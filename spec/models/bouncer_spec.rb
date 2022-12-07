# frozen_string_literal: true
require 'rails_helper'
#require 'bouncer'

describe 'Bouncer' do
  it 'returns the square root value' do
    b=Bouncer.new
    bounced=b.bounce(64)
    expect(bounced).to eq(8)
  end
end

