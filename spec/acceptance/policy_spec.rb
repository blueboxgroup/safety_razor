# -*- encoding: utf-8 -*-

require 'minitest/autorun'
require 'mocha/setup'

require 'safety_razor'

describe "Policy Slice" do

  let(:client) { SafetyRazor::Client.new(:uri => 'http://127.0.0.1:8026') }

  let(:images) do
    %x{vagrant ssh --command 'sudo razor image get all'}.
      split("\n\n").
      collect{ |x| Hash[*(x.split(/\n|=>/) - ['Images']).
      collect{|y| y.strip!}] }
  end

  let(:model) do
    client.model.create({
      :label => "test-model",
      :image_uuid => image_uuid,
      :template => "ubuntu_oneiric",
      :req_metadata_hash => {
        :hostname_prefix => "test",
        :domainname => "testdomain.com",
        :root_password => "test4321"
      }
    })
  end

  before do
    commands = [
      "sudo razor policy remove all",
      "sudo razor model remove all",
    ].join(' && ')
    %x{vagrant ssh --command '#{commands}'}
  end

  it "manages a policy" do
    client.policy.templates.
      find { |t| t.template == "linux_deploy" }.is_template.must_equal true

    client.policy.all.must_equal []

    policy = client.policy.create({
      label: "Test Policy",
      model_uuid: model.uuid,
      template: "linux_deploy",
      tags: "two_disks,memsize_1GiB,nics_2"
    })
    policy.label.must_equal "Test Policy"
    policy.model.uuid.must_equal model.uuid

    all = client.policy.all
    all.size.must_equal 1
    all.first.uuid.must_equal policy.uuid

    fetched_policy = client.policy.get(policy.uuid)
    fetched_policy.uuid.must_equal policy.uuid
    fetched_policy.label.must_equal "Test Policy"

    updated_policy = client.policy.update({
      :uuid => policy.uuid,
      :tags => "one,two,three"
    })
    updated_policy.tags.must_equal %w{one two three}

    client.policy.destroy(policy.uuid)
    client.policy.all.must_equal []
  end

  private

  def image_uuid(name = "ubuntu-minimal-10.04", version = "10.04")
    result = images.find do |image|
      image["OS Name"] == name && image["OS Version"] == version
    end

    result && result["UUID"]
  end
end
