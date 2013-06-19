# -*- encoding: utf-8 -*-

require 'minitest/autorun'
require 'mocha/setup'

require 'safety_razor'

describe "Tag Matcher Slice" do

  let(:client)  { SafetyRazor::Client.new(:uri => 'http://127.0.0.1:8026') }
  let(:tag)     { client.tag.create(:name => "Test Tag", :tag => "test_tag") }

  before do
    %x{vagrant ssh --command 'sudo razor tag remove all'}
  end

  it "manages a tag matcher" do
    matcher = client.tag_matcher.create(tag.uuid, {
      :key => "mk_hw_nic_count",
      :compare => "equal",
      :value => "2"
    })
    matcher.key.must_equal "mk_hw_nic_count"
    matcher.compare.must_equal "equal"

    fetched_matcher = client.tag_matcher.get(tag.uuid, matcher.uuid)
    fetched_matcher.uuid.must_equal matcher.uuid
    fetched_matcher.key.must_equal "mk_hw_nic_count"

    updated_matcher = client.tag_matcher.update(tag.uuid, {
      :uuid => matcher.uuid,
      :key => "mk_special_sauce"
    })
    updated_matcher.key.must_equal "mk_special_sauce"

    client.tag_matcher.destroy(tag.uuid, matcher.uuid)
  end
end
