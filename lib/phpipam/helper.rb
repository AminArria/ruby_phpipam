module Phpipam
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
  end
end