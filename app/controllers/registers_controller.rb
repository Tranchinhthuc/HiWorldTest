class RegistersController < ApplicationController
  def show
    @register = Register.find params[:id]
    @instagrammers = @register.instagrammers
    @recent_comments = Kaminari.paginate_array(@register.recent_comments).page(params[:page]).per 10
  end

  def index
    # artists = Artist.ransack(name_cont: 'foo', style_cont: 'bar', m: 'or')
    @register = Register.new
    @registers = Register.all
    @search = Hashtag.ransack params[:q]
    @hashtags = if params[:q]
      params[:q][:value_cont].present? ? (Kaminari.paginate_array(@search.result).page params[:page]) : []
    else
      @hashtags = []
    end
    @comments = @hashtags.map(&:comment)
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
