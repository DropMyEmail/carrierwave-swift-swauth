require 'spec_helper'

describe CarrierWave::Storage::SwiftSwauth do
  let(:swift_swauth) { CarrierWave::Storage::SwiftSwauth.new(uploader) }
  let(:uploader) { double('uploader') }

  context '#store!' do
    subject { swift_swauth.store!(file) }
    let(:content_type) { 'foo type' }
    let(:file) { double('file') }
    let(:filename) { 'moo' }
    let(:write_opts) { { content_type: content_type } }

    before do
      uploader.should_receive(:filename) { filename }
      file.should_receive(:content_type) { content_type }
      CarrierWave::Swift::SwauthClient.any_instance.should_receive(:create_object).with(filename, write_opts, file)
    end

    it { expect { subject }.to_not raise_error }
  end

  context '#retrieve!' do
    subject { swift_swauth.retrieve!(identifier) }
    let(:identifier) { 'loo' }
    let(:object) { double('obj') }

    before do
      CarrierWave::Swift::SwauthClient.any_instance.should_receive(:object).with(identifier) { object }
    end

    it { should == object }
  end
end
