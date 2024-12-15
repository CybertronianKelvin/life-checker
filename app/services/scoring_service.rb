class ScoringService
  SCORING_RULES = {
    age_groups: {
      (16..21) => { drink: 1, smoke: 2, exercise: 1 },
      (22..40) => { drink: 2, smoke: 2, exercise: 3 },
      (41..65) => { drink: 3, smoke: 2, exercise: 2 },
      (66..) => { drink: 3, smoke: 3, exercise: 1 }
    }
  }

  def initialize(age:, answers:)
    @age = age
    @answers = answers
  end

  def calculate_score
    group_rules = find_rules_for_age

    return 0 unless group_rules
    
    group_rules[:drink] * @answers[:drink].to_i +
      group_rules[:smoke] * @answers[:smoke].to_i +
      group_rules[:exercise] * (1 - @answers[:exercise].to_i)
  end

  private

  def find_rules_for_age
    rule = SCORING_RULES[:age_groups].find { |range, _| range.include?(@age) }
    rule ? rule.last : nil
  end
end
