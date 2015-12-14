class Circle::CommentsController < ApplicationController
  layout "internal"
  before_action :ensure_logged_in

  include HasCircle

  def create
    authorize! :create, Comment, current_task

    @comment = Comment.new
    @form = Comment::Create.new(params[:comment], commenter: current_user, task: current_task, comment: @comment)

    outcome = @form.submit

    if outcome.success?
      redirect_to circle_task_or_supply_path(current_circle, current_task),
      notice: t('flash.created', name: Comment.model_name.human)
    else
      redirect_to circle_task_or_supply_path(current_circle, current_task),
      alert: t('flash.failed.create', name: Comment.model_name.human)
    end
  end

  helper_method def current_task
    @task ||= params[:supply_id] ? Supply.find(params[:supply_id]) : Task.find(params[:task_id])
  end

  helper_method def page
    @page ||= OpenStruct.new.tap do |page|
    end
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def task_params
      params[:comment].permit(:body)
    end

    def circle_task_or_supply_path(circle, task_supply)
      if current_task.is_a? Supply
        circle_supply_path(current_circle, current_task)
      else
        circle_task_path(current_circle, current_task)
      end
    end
end
