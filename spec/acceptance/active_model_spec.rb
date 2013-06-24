# -*- encoding: utf-8 -*-

require 'minitest/autorun'
require 'mocha/setup'

require 'safety_razor'

describe "ActiveModel Slice" do

  let(:client) { SafetyRazor::Client.new(:uri => 'http://127.0.0.1:8026') }

  let(:images) do
    %x{vagrant ssh --command 'sudo razor image get all'}.
      split("\n\n").
      collect{ |x| Hash[*(x.split(/\n|=>/) - ['Images']).
      collect{|y| y.strip!}] }
  end

  let(:node) do
    client.node.register({
      :hw_id => "000C29291C95",
      :last_state => "idle",
      :attributes_hash => {
        :productname => "safety"
      }
    })
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

  let(:tag) do
    result = client.tag.create({
      :name => "Safety",
      :tag => "safety"
    })
    client.tag_matcher.create(result.uuid, {
      :key => "productname",
      :compare => "equal",
      :value => "safety"
    })
    result
  end

  let(:policy) do
    client.policy.create({
      :label => "Test Policy",
      :model_uuid => model.uuid,
      :template => "linux_deploy",
      :tags => "safety",
      :enabled => "true"
    })
  end

  before do
    script = [
      %{d = ProjectRazor::Data.instance},
      %{d.check_init},
      %{d.delete_all_objects(:node)},
      %{d.delete_all_objects(:active)},
      %{e = ProjectRazor::Engine.instance}
    ].join(' ; ')
    commands = [
      %{sudo razor policy remove all},
      %{sudo razor model remove all},
      %{sudo razor tag remove all},
      %{sudo ruby -I/opt/razor/lib -rproject_razor -e "#{script}"}
    ].join(' && ')

    %x{vagrant ssh --command '#{commands}'}

    tag # create tag and matcher
    policy # create policy
    node # create node
  end

  it "manages an active model" do
    client.active_model.all.must_equal []

    # check node in to match against a policy and create an active_model
    client.node.checkin({
      :hw_id => "000C29291C95",
      :last_state => "idle"
    })

    all = client.active_model.all
    all.size.must_equal 1

    fetched_active_model = client.active_model.get(all.first.uuid)
    fetched_active_model.node_uuid.must_equal node.uuid

    client.active_model.destroy(fetched_active_model.uuid)
    client.active_model.all.must_equal []
  end

  private

  def image_uuid(name = "ubuntu-minimal-10.04", version = "10.04")
    result = images.find do |image|
      image["OS Name"] == name && image["OS Version"] == version
    end

    result && result["UUID"]
  end
end
