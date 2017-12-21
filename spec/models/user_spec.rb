# frozen_string_literal

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'fields' do
    it { is_expected.to respond_to(:name) }
    it { is_expected.to respond_to(:email) }
    it { is_expected.to respond_to(:password) }
  end
  
  describe 'relations' do
    it { is_expected.to have_many(:topics) }
  end
  
  describe 'validations' do
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:password) }
    
    it { is_expected.to validate_uniqueness_of(:email).case_insensitive }
  end
end