# frozen_string_literal: true

FactoryBot.define do
  factory :post do
    sequence(:description) { |i| "Post description #{i}" }
    date Time.now.utc
    association :user, factory: :user
    association :topic, factory: :topic
  end
end
