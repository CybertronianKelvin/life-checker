# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
ScoringRule.create!([
                      { age_min: 16, age_max: 21, q1: 1, q2: 2, q3: 1, threshold: 4 },
                      { age_min: 22, age_max: 40, q1: 2, q2: 2, q3: 3, threshold: 4 },
                      { age_min: 41, age_max: 65, q1: 3, q2: 2, q3: 2, threshold: 4 },
                      { age_min: 66, age_max: 200, q1: 3, q2: 3, q3: 1, threshold: 4 }
                    ])

# Seed a default admin user if none exists
User.create!(
  email: 'admin@example.com',
  password: 'password',
  password_confirmation: 'password'
) unless User.exists?(email: 'admin@example.com')
