# -*- encoding: utf-8 -*-

require 'minitest/autorun'
require 'mocha/setup'

require 'safety_razor'

describe "Tag Slice" do

  let(:client) { SafetyRazor::Client.new(:uri => 'http://127.0.0.1:8026') }

  before do
    %x{vagrant ssh --command 'sudo razor tag remove all'}
  end

  it "manages a tag" do
    client.tag.all.must_equal []

    tag = client.tag.create({
      :name => "Test Tag",
      :tag => "test_tag"
    })
    tag.name.must_equal "Test Tag"
    tag.tag.must_equal "test_tag"

    all = client.tag.all
    all.size.must_equal 1
    all.first.uuid.must_equal tag.uuid

    fetched_tag = client.tag.get(tag.uuid)
    fetched_tag.uuid.must_equal tag.uuid
    fetched_tag.name.must_equal "Test Tag"

    updated_tag = client.tag.update({
      :uuid => tag.uuid,
      :tag => "updated_test_tag"
    })
    updated_tag.tag.must_equal "updated_test_tag"

    client.tag.destroy(tag.uuid)
    client.tag.all.must_equal []
  end
end
