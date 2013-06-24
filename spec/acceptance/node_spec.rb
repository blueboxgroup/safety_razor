# -*- encoding: utf-8 -*-

require 'minitest/autorun'
require 'mocha/setup'

require 'safety_razor'

describe "Node Slice" do

  let(:client) { SafetyRazor::Client.new(:uri => 'http://127.0.0.1:8026') }

  before do
    # sadly there isn't a way to delete nodes via any API so we can get evil
    # and creative instead
    script = [
      %{i = ProjectRazor::Data.instance},
      %{i.check_init},
      %{i.delete_all_objects(:node)}
    ].join(' ; ')
    command = %{sudo ruby -I/opt/razor/lib -rproject_razor -e "#{script}"}

    %x{vagrant ssh --command '#{command}'}
  end

  it "manages a node" do
    client.node.all.must_equal []

    node = client.node.register({
      :hw_id => "000C29291C95",
      :last_state => "idle",
      :attributes_hash => {
        :attr1 => "val1",
        :attr2 => "val2"
      }
    })
    node.hw_id.first.must_equal "000C29291C95"
    node.last_state.must_equal "idle"

    all = client.node.all
    all.size.must_equal 1
    all.first.hw_id.must_equal node.hw_id

    fetched_node = client.node.get(node.uuid)
    fetched_node.uuid.must_equal node.uuid
    fetched_node.last_state.must_equal "idle"

    client.node.checkin({
      :hw_id => "000C29291C95",
      :last_state => "baked"
    })
    client.node.get(node.uuid).last_state.must_equal "baked"

    attrs = client.node.get_attributes(node.uuid)
    attrs['attr1'].must_equal "val1"
    attrs['attr2'].must_equal "val2"

    client.node.get_hardware_ids(node.uuid).must_equal node.hw_id
  end
end
