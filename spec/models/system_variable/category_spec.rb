require 'rails_helper'

describe SystemVariable::Category do
  describe 'associations' do
    it { is_expected.to have_many(:variables) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
  end
end
