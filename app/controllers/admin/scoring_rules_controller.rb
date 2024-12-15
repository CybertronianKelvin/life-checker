class Admin::ScoringRulesController < ApplicationController
  before_action :authenticate_user!, :set_scoring_rule, only: %i[edit update]

  def index
    @scoring_rules = ScoringRule.all
  end

  def edit; end

  def update
    if @scoring_rule.update(scoring_rule_params)
      redirect_to admin_scoring_rules_path, notice: 'Scoring rule updated successfully.'
    else
      render :edit
    end
  end

  private

  def set_scoring_rule
    @scoring_rule = ScoringRule.find(params[:id])
  end

  def scoring_rule_params
    params.require(:scoring_rule).permit(:age_min, :age_max, :q1, :q2, :q3, :threshold)
  end
end
index.html.erb
