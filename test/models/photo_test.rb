require 'test_helper'

class PhotoTest < ActiveSupport::TestCase
  def setup
    @photo = photos(:star_trek)
  end

  test "it should be valid" do
    assert @photo.valid?
  end

  test "it should not permit a blank name" do
    @photo.name = '';
    assert_not @photo.valid?
  end

  test "it should not permit a blank desc" do
    @photo.desc = '';
    assert_not @photo.valid?
  end

  test "it should not permit a blank difficulty" do
    @photo.difficulty = ''
    assert_not @photo.valid?
  end

  test "it should not permit a blank category" do
    @photo.category = ''
    assert_not @photo.valid?
  end

  test "it should not permit a blank image name" do
    @photo.image_filename = '';
    assert_not @photo.valid?
  end

  test "it should not permit a duplicate name" do
    assert_raises ActiveRecord::RecordNotUnique do
      Photo.create(name: @photo.name, desc: 'a', difficulty: 'a', category: 'a', image_filename: 'a');
    end
  end
end
