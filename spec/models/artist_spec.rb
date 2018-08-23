require 'rails_helper'

RSpec.describe Artist, type: :model do
  it 'has a name' do
    expect(Artist.new).to respond_to(:name)
  end

  it 'has many albums' do
    expect(Artist.new).to respond_to(:albums)
  end

  it 'has many songs' do
    expect(Artist.new).to respond_to(:songs)
  end

  it 'has many lines' do
    expect(Artist.new).to respond_to(:lines)
  end

  it 'has many notes' do
    expect(Artist.new).to respond_to(:notes)
  end
end
