require 'spec_helper'

describe Slnky::Instance::Client, remote: true do
  subject { described_class.new }

  context '#find' do
    it 'handles missing' do
      expect(subject.find('blarg')).to be_empty
    end

    it 'finds by id' do
      expect(subject.find('i-12345678')).to be_nil
    end

    it 'finds by name' do
      expect(subject.find('tools-ops')).not_to be_empty
    end
  end
end
