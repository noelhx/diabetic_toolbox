module DiabeticToolbox
  # = ReconfirmMember
  #
  # This exchange allows for a member to reconfirm their email change
  # originally initiated with ChangeMemberEmail, as follows:
  #
  #   result = ReconfirmMember.new(token).call
  #
  class ReconfirmMember < Exchange
    #:enddoc:
    #region Init
    def initialize(token)
      if token.blank?
        @member = nil
      else
        @member = Member.find_by_confirmation_token token
      end
    end
    #endregion

    #region Hooks
    hook :default do
      if @member.present?
        exchanged = false
        exchanged = exchange unless email_in_use?

        if exchanged
          success do |option|
            option.subject = @member
            option.message = I18n.t('flash.member.reconfirm.success')
          end
        else
          failure do |option|
            option.subject = @member
            option.message = I18n.t('flash.member.reconfirm.failure')
          end
        end
      else
        failure do |option|
          option.message = I18n.t('flash.member.reconfirm.failure')
        end
      end
    end
    #endregion

    #region Private
    private
    def exchange
      @member.update_columns musical_chairs
    end

    def musical_chairs
      {email: @member.unconfirmed_email, unconfirmed_email: nil, confirmation_token: nil, confirmation_sent_at: nil, confirmed_at: Time.now}
    end

    def email_in_use?
      Member.exists? email: @member.unconfirmed_email
    end
    #endregion
  end
end