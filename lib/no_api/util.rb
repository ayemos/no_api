module NoApi
  module Util
    def parse_num_with_unit(str)
      return if str =~ /[^0-9,.kKmMgG]/

      eval(str.gsub(/,/,'')
           .gsub(/[gG]/, '*1000_000_000')
           .gsub(/[mM]/, '*1000_000')
           .gsub(/[kK]/, '*1000'))
    end
  end
end
