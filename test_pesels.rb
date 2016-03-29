require 'test/unit'
require './pesel_validation.rb'

class TestPesels < Test::Unit::TestCase

  def test_pesels
    [
        ['90101701379', "pesel poprawny", "17-10-1990", true],
        ['89032315203', "pesel poprawny", "23-3-1989", true],
        ['00000000000', "pesel nieprawidłowy", "0-0-1900", false],
        ['44444444444', "pesel nieprawidłowy", "44-4-2144", false],
        ['87831279919', "pesel poprawny", "12-3-1887", true],
        ['11483129012', "pesel poprawny", "31-8-2111", true],
        ['38124623500', "pesel nieprawidłowy", "46-12-1938", false],
        ['38122623503', "pesel nieprawidłowy", "26-12-1938", true],
        ['38 24623500', "Pesel nieprawidłowy, zawiera niedozowlony znak", "46-2-1938", false],
        ['38122623502', "pesel poprawny", "26-12-1938", true],
        ['75120804350', "pesel nieprawidłowy", "8-12-1975", true],
        ['74082610618', "pesel nieprawidłowy", "26-8-1974", true]

    ].each do |pesel, expectedSummary, expectedDate, expectedDateValidation|
      assert_equal expectedSummary, Module1::PeselValidate.new(pesel).validate, "final validation failed with in #{pesel}"
      assert_equal expectedDate, Module1::PeselValidate.new(pesel).getDate, "dates not match with in #{pesel}"
      assert_equal expectedDateValidation, Module1::PeselValidate.new(pesel).dateValidation, "date validation failed with in #{pesel}"
    end
  end


end