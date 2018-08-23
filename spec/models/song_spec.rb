require 'rails_helper'

RSpec.describe Song, type: :model do
  it 'has a name' do
    expect(Song.new).to respond_to(:name)
  end

  it 'belongs to an album' do
    expect(Song.new).to respond_to(:album)
  end

  it 'has many lines' do
    expect(Song.new).to respond_to(:lines)
  end

  it 'belongs to an artist' do
    expect(Song.new).to respond_to(:artist)
  end
end
