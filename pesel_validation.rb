module Module1

  require 'date'

  class PeselValidate

    PESEL_WEIGHTS = [1, 3, 7, 9, 1, 3, 7, 9, 1, 3]
    attr_reader :peselAsArr
    attr_accessor :pesel

    def initialize (str1)
      @pesel = str1.to_s
      @peselAsArr = @pesel.split(//).map { |i| i.to_i }
    end

    def validate
      if /\D/.match @pesel
        "Pesel nieprawidłowy, zawiera niedozowlony znak"
      elsif @pesel.length != 11
        "Nieprawidłowa długość numeru"
      elsif !(checkSumValidation && dateValidation)
        "pesel nieprawidłowy"
      else
        "pesel poprawny"
      end
    end

    def checkSumValidation
      sum = 0
      @peselAsArr.each_with_index do |i, index|
        unless index == @peselAsArr.length - 1
          sum += i * PESEL_WEIGHTS[index]
        end
      end
      checksum = (10 - (sum % 10)) % 10

      (checksum == @peselAsArr[@peselAsArr.length-1]) ? true : false
    end

    def getDate
      yearVal = @peselAsArr[0..1].join("").to_i
      monthVal = @peselAsArr[2..3].join("").to_i
      case monthVal
        when 21 .. 32
          year = 2000 + yearVal
          month = monthVal - 20
        when 81 .. 92
          year = 1800 + yearVal
          month = monthVal - 80
        when 41 .. 52
          year = 2100 + yearVal
          month = monthVal - 40
        when 61 .. 72
          year = 2200 + yearVal
          month = monthVal - 60
        else
          year = 1900 + yearVal
          month = monthVal
      end

      day = @peselAsArr[4..5].join("").to_i

      "#{day}-#{month}-#{year}"
    end

    def dateValidation
      begin
        Date.parse(getDate())
      rescue ArgumentError
        return false
      end

      true
    end

  end
end


