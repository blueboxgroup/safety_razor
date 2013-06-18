# -*- encoding: utf-8 -*-

require 'minitest/autorun'
require 'mocha/setup'

require 'safety_razor'

describe "Model Slice" do

  let(:client) { SafetyRazor::Client.new(:uri => 'http://127.0.0.1:8026') }

  let(:images) do
    %x{vagrant ssh --command 'sudo razor image get all'}.
      split("\n\n").
      collect{ |x| Hash[*(x.split(/\n|=>/) - ['Images']).
      collect{|y| y.strip!}] }
  end

  before do
    %x{vagrant ssh --command 'sudo razor model remove all'}
  end

  it "manages a model" do
    client.model.all.must_equal []

    model = client.model.create({
      :label => "test-model",
      :image_uuid => image_uuid,
      :template => "ubuntu_oneiric",
      :req_metadata_hash => {
        :hostname_prefix => "test",
        :domainname => "testdomain.com",
        :root_password => "test4321"
      }
    })
    model.label.must_equal "test-model"
    model.image_uuid.must_equal image_uuid

    all = client.model.all
    all.size.must_equal 1
    all.first.uuid.must_equal model.uuid

    fetched_model = client.model.get(model.uuid)
    fetched_model.uuid.must_equal model.uuid
    fetched_model.label.must_equal "test-model"

    updated_model = client.model.update({
      :uuid => model.uuid,
      :label => "updated-test-model"
    })
    updated_model.label.must_equal "updated-test-model"

    client.model.destroy(model.uuid)
    client.model.all.must_equal []
  end

  private

  def image_uuid(name = "ubuntu-minimal-10.04", version = "10.04")
    result = images.find do |image|
      image["OS Name"] == name && image["OS Version"] == version
    end

    result && result["UUID"]
  end
end
