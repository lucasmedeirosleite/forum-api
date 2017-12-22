# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Topic, type: :model do
  describe 'fields' do
    it { is_expected.to respond_to(:title) }
    it { is_expected.to respond_to(:date) }
    it { is_expected.to respond_to(:description) }
  end

  describe 'relations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to have_many(:posts) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:date) }
    it { is_expected.to validate_presence_of(:description) }
    it { is_expected.to validate_presence_of(:user) }
  end
end
