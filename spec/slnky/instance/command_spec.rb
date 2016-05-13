require 'spec_helper'

describe Slnky::Instance::Command do
  subject do
    s = described_class.new
    s.client = Slnky::Instance::Mock.new
    s
  end
  let(:terminate) { slnky_command('terminate') }
  let(:termreal) { slnky_command('termreal') }
  let(:help) { slnky_command('help') }
  let(:terminate_response) { slnky_response('test-route', 'spec') }
  let(:help_response) { slnky_response('test-route', 'spec') }

  it 'handles terminate' do
    # make sure the command handler does not raise an error
    expect { subject.handle(terminate.name, terminate.payload, terminate_response) }.to_not raise_error
    # validate that the correct output is available in the response object
    expect(terminate_response.trace).to include("no instances found matching 'blarg'")
  end

  it 'handles terminate of found instance' do
    # make sure the command handler does not raise an error
    expect { subject.handle(termreal.name, termreal.payload, terminate_response) }.to_not raise_error
    # validate that the correct output is available in the response object
    expect(terminate_response.trace).to include("terminated i-87654321")
  end

  it 'handles help' do
    expect { subject.handle(help.name, help.payload, help_response) }.to_not raise_error
    expect(help_response.trace).to include("instance help: print help")
  end
end
