require 'colorize'

class Tile
    attr_reader :value, :given

    def initialize(value, given = false)
        @value = value
        @given = value == 0 ? false : true
    end

    def given?
        @given
    end

    def color(value)
        given? ? value.blue : value.red    
    end

    def to_s
        value == 0 ? " " : color(value.to_s)
    end

    def value=(new_val)
        if given?
            puts "You can not change value at this position"
        else
           @value = new_val  
        end
    end

end


