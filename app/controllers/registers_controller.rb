class RegistersController < ApplicationController
  before_action :authenticate_user!
  def show
    @register = Register.find params[:id]
    @instagrammers = eval(@register.fetch_data)[:instagrammers]
    @recent_comments = Kaminari.paginate_array(eval(@register.fetch_data)[:recent_comments])
      .page(params[:page]).per 10
  end

  def index
    @register = Register.new
    @registers = Register.all
  end

  def create
    @register = Register.new register_params
    @register.value.insert(0, "#") if @register.value[0] != "#"
    @register.save
    redirect_to :back
  end

  private
  def register_params
    params.require(:register).permit :value
  end
end
