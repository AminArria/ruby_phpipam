module RubyPhpipam
  class Helper
    def self.to_type(value, type)
      return nil if value.nil?

      case type
      when :int
        value.to_i
      when :binary
        value != "0"
      when :json
        JSON.parse(value)
      when :date
        if value == "0000-00-00 00:00:00"
          nil
        else
          Time.strptime(value, '%Y-%m-%d %H:%M:%S')
        end
      else
        raise UndefinedType, 'given type is not defined'
      end
    end

    def self.validate_cidr(cidr)
      cidr_regex = /^(([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\.){3}([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])(\/([0-9]|[1-2][0-9]|3[0-2]))$/

      not cidr_regex.match(cidr).nil?
    end
  end
end