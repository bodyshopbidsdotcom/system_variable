require 'rails_helper'

describe SystemVariable do
  describe '#fetch' do
    it 'returns value defined in SystemVariable' do
      create(:system_variable_variable, key: 'foo', value: 'native value')

      expect(described_class.fetch('foo')).to eq('native value')
    end

    it 'returns value from ENV if not defined in SystemVariable' do
      expect(ENV).to receive(:fetch).with("BAR", nil).and_return("ENV value")

      expect(described_class.fetch('BAR')).to eq('ENV value')
    end

    it 'returns nil if not found in any sources' do
      expect(described_class.fetch('NON_EXISTANT')).to be_nil
    end

    it 'returns default value if not found in any sources' do
      expect(described_class.fetch('NON_EXISTANT', default: 'foo')).to eq('foo')
    end
  end

  describe '#exists?' do
    it 'returns true if found in SystemVariable' do
      create(:system_variable_variable, key: 'foo')

      expect(described_class.exists?('foo')).to eq(true)
    end

    it 'returns true if found in ENV' do
      expect(ENV).to receive(:key?).with("BAR").and_return(true)

      expect(described_class.exists?('BAR')).to eq(true)
    end

    it 'returns false if not found in any sources' do
      expect(described_class.exists?('NON_EXISTANT')).to eq(false)
    end
  end
end
