class TestClass
  attr_accessor :id, :name
  include S3lite::Base
  def initialize(name: SecureRandom.hex(2))
    @id = (1..100).to_a.sample
    @name = name
  end
end

require 'spec_helper'

RSpec.describe S3lite::Base do
  context 'latest' do
  end

  context 'backup' do
  end
end
