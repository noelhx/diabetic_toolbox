module DiabeticToolbox
  # = RecoverMemberPassword
  #
  # This class provides a "forgot password" capability for
  # members, used as follows:
  #
  #   result = RecoverMemberPassword.new({email: member_email}).call
  #
  class RecoverMemberPassword < Exchange
    #:enddoc:
    #region Init
    def initialize(recovery_params)
      super recovery_params
    end
    #endregion

    #region Hooks
    hook :default do
      @member     = Member.find_by_email call_params[:email]
      in_recovery = false
      in_recovery = triage if @member.present?
      ambiguous   = I18n.t('flash.authenticatable.send_recovery_kit.ambiguous_response')

      if in_recovery
        success do |option|
          option.subject = @member
          option.message = ambiguous.dup
        end
      else
        failure do |option|
          option.subject = @member
          option.message = ambiguous.dup
        end
      end
    end

    hook :after do
      if call_result.success?
        DiabeticToolbox::RecoveryKitMailer.send_forgot_password_kit(@member).deliver_now
      end
    end
    #endregion

    #region Private
    private
    def triage
      @member.update_columns reset_password_token: RecoverMemberPassword.create_token, reset_password_sent_at: Time.now
    end
    #endregion

    #region Static
    public
    def self.create_token
      Digest::SHA2.hexdigest Time.now.to_s
    end
    #endregion
  end
end