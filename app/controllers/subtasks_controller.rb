class SubtasksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_subtask

  def update
    if @subtask.update(subtask_params)
      respond_to do |format|
        format.html { redirect_to goal_path(@subtask.milestone.goal), notice: "Subtask updated" }
        format.turbo_stream
      end
    else
      respond_to do |format|
        format.html { redirect_to goal_path(@subtask.milestone.goal), alert: "Failed to update subtask" }
        format.turbo_stream { render turbo_stream: turbo_stream.replace(@subtask, partial: "goals/subtask", locals: { subtask: @subtask }) }
      end
    end
  end

  private

  def set_subtask
    @subtask = Subtask.find(params[:id])
    # Ensure the user owns the goal this subtask belongs to
    unless @subtask.milestone.goal.user == current_user
      redirect_to root_path, alert: "Not authorized"
    end
  end

  def subtask_params
    params.require(:subtask).permit(:completed)
  end
end
