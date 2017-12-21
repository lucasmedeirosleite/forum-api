# frozen_string_literal

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:password) }
    
    it { is_expected.to validate_uniqueness_of(:email).case_insensitive }
  end
end