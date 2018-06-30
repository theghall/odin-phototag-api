require 'test_helper'

class PhotoTest < ActiveSupport::TestCase
  def setup
    @photo = photos(:aaaaa)
  end

  test "it should be valid" do
    assert @photo.valid?
  end

  test "it should not permit a blank name" do
    @photo.name = ''
    assert_not @photo.valid?
  end

  test "it should not permit a blank desc" do
    @photo.desc = ''
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
    @photo.image_filename = ''
    assert_not @photo.valid?
  end

  test "it should not permit a duplicate name" do
    assert_raises ActiveRecord::RecordNotUnique do
      Photo.create(name: @photo.name, desc: 'a', difficulty: 'a', category: 'a', image_filename: 'a');
    end
  end

  test "it should return all records with no search params" do
    assert_equal Photo.count, Photo.query({}).count
  end

  test "it should return correct number of records when using number search" do
    assert_equal 1, Photo.query({"number" => "1"}).count
    assert_equal "aaaaa", Photo.query({"number" => "1"}).first.name
    assert_equal 3, Photo.query({"number" => "3"}).count
    assert_equal "ccccc", Photo.query({"number" => "3"}).last.name
  end

  test "it should return correct records when using a category search" do
    assert_equal 3, Photo.query({"category" => "cat1"}).count
    assert_equal "aaaaa", Photo.query({"category" => "cat1"}).first.name
    assert_equal "bbbbb", Photo.query({"category" => "cat1"}).second.name
    assert_equal "ccccc", Photo.query({"category" => "cat1"}).third.name
  end

  test "it should return correct records when using category and number" do
    assert_equal 2, Photo.query({"category" => "cat1", "number" => "2"}).count
    assert_equal "aaaaa", Photo.query({"category" => "cat1", "number" => "2"}).first.name
    assert_equal "bbbbb", Photo.query({"category" => "cat1", "number" => "2"}).second.name
  end

  test "should return correct records when using difficulty" do
    assert_equal 3, Photo.query({"difficulty" => "easy"}).count
    assert_equal "aaaaa", Photo.query({"difficulty" => "easy"}).first.name
    assert_equal "ddddd", Photo.query({"difficulty" => "easy"}).second.name
    assert_equal "eeeee", Photo.query({"difficulty" => "easy"}).third.name
  end

  test "should return correct records when using difficulty and number" do
    assert_equal 1, Photo.query({"difficulty" => "hard", "number" => "1"}).count
    assert_equal "bbbbb", Photo.query({"difficulty" => "hard", "number" => "1"}).first.name
  end

  test "should return correct records when using difficulty and category" do
    assert_equal 2, Photo.query({"difficulty" => "easy", "category" => "cat2"}).count
    assert_equal "ddddd", Photo.query({"difficulty" => "easy", "category" => "cat2"}).first.name
    assert_equal "eeeee", Photo.query({"difficulty" => "easy", "category" => "cat2"}).second.name
  end

  test "should return correct records when using difficulty and category and number" do
    assert_equal 1, Photo.query({"difficulty" => "easy", "category" => "cat2", "number" => "1"}).count
    assert_equal "ddddd", Photo.query({"difficulty" => "easy", "category" => "cat2"}).first.name
  end

end
