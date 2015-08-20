require_dependency "diabetic_toolbox/application_controller"

module DiabeticToolbox
  class MembersController < DiabeticToolbox::ApplicationController
    #region Class methods
    load_and_authorize_resource
    respond_to :html, :json
    #endregion

    #region Before Action
    before_action :deploy_member_tabs,    only: :dash
    before_action :set_member,            only: [:show, :edit, :update, :destroy]
    before_action :there_can_be_only_one, only: :new
    #endregion

    #region Creation
    def new
      @member = DiabeticToolbox::Member.new
    end

    def create
      create_member = DiabeticToolbox::Members::CreateMember.new( member_params ).call
      @member       = create_member.actual

      respond_to do |format|
        if create_member.successful?
          login_new_user
          format.html {
            flash[:success] = create_member.flash
            redirect_to setup_path
          }
          format.json { render :json => create_member.response }
        else
          format.html {
            flash[:warning] = create_member.flash
            render :new
          }
          format.json { render :json => create_member.response }
        end
      end
    end
    #endregion

    #region Read
    def show
    end

    def edit
    end
    #endregion

    #region Mutation
    def update
    end

    def destroy
    end
    #endregion

    #region Member
    def dash
      redirect_to setup_path unless current_member.configured?
      @chart_data = DiabeticToolbox::Members::Dashboard.history current_member unless current_member.has_no_readings?
      @library    = DiabeticToolbox::Members::Dashboard.chartkick_library unless current_member.has_no_readings?
    end
    #endregion

    #region Private
    private
      def member_params
        params.require(:member).permit(:first_name, :last_name, :username, :email, :password, :password_confirmation, :dob, :gender, :accepted_tos)
      end

      def set_member
        @member = current_member
      end

      def there_can_be_only_one
        @ensure_cohesion = true
      end

      def login_new_member
        session = DiabeticToolbox::Members::Session.new( request.env['REMOTE_ADDR'], {'email' => member_params[:email], 'password' => member_params[:password]} )
        member  = session.create

        instant_in(member) if session.in_progress?
      end
    #endregion
  end
end
