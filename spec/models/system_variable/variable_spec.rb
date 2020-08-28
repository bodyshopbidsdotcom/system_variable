require 'rails_helper'

describe SystemVariable::Variable do
  describe 'associations' do
    it { is_expected.to belong_to(:category).optional }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:key) }
  end

  describe '#hashify' do
    let(:owner) { SystemVariable::DefaultOwner.create }

    it 'formats variables into a hash' do
      variable1 = create(:system_variable_variable, key: 'var1')
      variable2 = create(:system_variable_variable, key: 'var2')
      variable3 = create(:system_variable_variable, key: 'var3')
      variable4 = create(:system_variable_variable, key: 'var4')

      result = described_class.hashify

      expect(result.with_indifferent_access).to eq({
        VAR1: variable1.value,
        VAR2: variable2.value,
        VAR3: variable3.value,
        VAR4: variable4.value
      }.with_indifferent_access)
    end
  end

  describe '#fetch' do
    it 'retrieves values' do
      create(:system_variable_variable, key: 'var1', value: 'var1 value')

      expect(described_class.fetch('var1')).to eq('var1 value')
    end

    it 'returns nil if key does not exist and no default is specified' do
      expect(described_class.fetch('fake_key')).to be_nil
    end

    it 'returns nil if key does not exist and default is specified' do
      expect(described_class.fetch('fake_key', 'foo')).to eq('foo')
    end
  end

  describe '#key?' do
    it 'returns true if key exists' do
      create(:system_variable_variable, key: 'var1', value: 'var1 value')

      expect(described_class.key?('var1')).to eq(true)
    end

    it 'returns false if key does not exists' do
      expect(described_class.key?('fake_key')).to eq(false)
    end
  end

  describe '#sanitize_key' do
    it 'sanitizes' do
      expect(described_class.sanitize_key(' foo ')).to eq('FOO')
    end
  end

  describe '#sanitize_value' do
    it 'sanitizes' do
      expect(described_class.sanitize_value(' foo ')).to eq('foo')
    end
  end
end
