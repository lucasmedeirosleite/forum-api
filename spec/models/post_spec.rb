require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'fields' do
    it { is_expected.to respond_to(:description) }
    it { is_expected.to respond_to(:date) }
  end
  
  describe 'relations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:topic) }
  end
  
  describe 'validations' do
    it { is_expected.to validate_presence_of(:description) }
    it { is_expected.to validate_presence_of(:date) }
    it { is_expected.to validate_presence_of(:user) }
    it { is_expected.to validate_presence_of(:topic) }
  end
end