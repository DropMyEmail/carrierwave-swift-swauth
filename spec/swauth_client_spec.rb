require 'spec_helper'

describe 'SwauthClient' do
  let(:client) { CarrierWave::Swift::SwauthClient.new }
  let(:connection) { double('connection') }
  let(:container) { double('container') }
  let(:path) { 'path/to/nerdvana' }

  describe '#object_exists?' do
    subject { client.object_exists?(path) }

    context 'object exists' do
      before do
        OpenStack::Connection.stub(:create) { connection }
        connection.stub(:container) { container }
        container.should_receive(:object_exists?).with(path) { true }
      end
      it { should be_true }
    end

    context 'object does not exist' do
      before do
        OpenStack::Connection.stub(:create) { connection }
        connection.stub(:container) { container }
        container.should_receive(:object_exists?).with(path) { false }
      end
      it { should be_false }
    end
  end

  describe '#create_object' do
    subject { client.create_object(path, opts, data) }
    let(:opts) { {} }
    let(:data) { 'some data' }

    before do
      OpenStack::Connection.stub(:create) { connection }
      connection.stub(:container) { container }
      container.should_receive(:create_object).with(path, opts, data)
    end

    it { expect { subject }.to_not raise_error }
  end

  describe '#delete_object' do
    subject { client.delete_object(path) }

    before do
      OpenStack::Connection.stub(:create) { connection }
      connection.stub(:container) { container }
      container.should_receive(:delete_object).with(path)
    end

    it { expect { subject }.to_not raise_error }
  end

  describe '#object' do
    subject { client.object(path) }

    before do
      OpenStack::Connection.stub(:create) { connection }
      connection.stub(:container) { container }
      container.should_receive(:object).with(path)
    end

    it { expect { subject }.to_not raise_error }
  end
end
