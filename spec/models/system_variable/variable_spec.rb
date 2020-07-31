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
      variable_1 = create(:system_variable_variable, key: 'var1')
      variable_2 = create(:system_variable_variable, key: 'var2')
      variable_3 = create(:system_variable_variable, key: 'var3')
      variable_4 = create(:system_variable_variable, key: 'var4')

      result = described_class.hashify

      expect(result.with_indifferent_access).to eq({
        VAR1: variable_1.value,
        VAR2: variable_2.value,
        VAR3: variable_3.value,
        VAR4: variable_4.value
      }.with_indifferent_access)
    end
  end

  describe '#get' do
    it 'retrieves values' do
      create(:system_variable_variable, key: 'var1', value: 'var1 value')

      expect(described_class.get('var1')).to eq('var1 value')
    end

    it 'returns nil if key does not exist and no default is specified' do
      expect(described_class.get('fake_key')).to be_nil
    end
  end

  describe '#exists?' do
    it 'returns true if key exists' do
      create(:system_variable_variable, key: 'var1', value: 'var1 value')

      expect(described_class.exists?('var1')).to eq(true)
    end

    it 'returns false if key does not exists' do
      expect(described_class.exists?('fake_key')).to eq(false)
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
