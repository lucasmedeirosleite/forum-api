# frozen_string_literal: true

FactoryBot.define do
  factory :topic do
    sequence(:title) { |i| "Title #{i}" }
    sequence(:description) { |i| "Description #{i}" }
    date Time.now.utc
    association :user, factory: :user
  end
end