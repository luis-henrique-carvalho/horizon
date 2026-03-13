class GoalsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_goal, only: %i[show edit update destroy]

  def index
    @goals = current_user.goals
    @goals = apply_filters(@goals)
    @goals = apply_sorting(@goals)
  end

  def show
  end

  def new
    @goal = current_user.goals.build
  end

  def create
    @goal = current_user.goals.build(goal_params)

    if @goal.save
      redirect_to goals_path, notice: "Goal was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @goal.update(goal_params)
      redirect_to goals_path, notice: "Goal was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @goal.destroy
    redirect_to goals_path, notice: "Goal was successfully destroyed."
  end

  private

  def set_goal
    @goal = current_user.goals.includes(milestones: :subtasks).find(params[:id])
  end

  def apply_filters(relation)
    case params[:tab]
    when "archived"
      relation = relation.archived
    else
      relation = relation.active
    end

    relation = relation.by_category(params[:category]) if params[:category].present?
    relation = relation.search(params[:query]) if params[:query].present?
    relation
  end

  def apply_sorting(relation)
    case params[:sort]
    when "progress_high"
      relation.order_by_progress(:desc)
    when "progress_low"
      relation.order_by_progress(:asc)
    when "deadline_soon"
      relation.order_by_deadline(:asc)
    when "deadline_far"
      relation.order_by_deadline(:desc)
    else
      relation.order_by_deadline(:asc)
    end
  end

  def goal_params
    params.require(:goal).permit(
      :title, :description, :category, :status, :progress, :deadline,
      milestones_attributes: [
        :id, :title, :order, :_destroy,
        subtasks_attributes: [ :id, :title, :completed, :_destroy ]
      ]
    )
  end
end
