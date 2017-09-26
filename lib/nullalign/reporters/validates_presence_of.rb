require 'nullalign/reporters/base'

module Nullalign
  module Reporters
    class ValidatesPresenceOf < Base
      attr_reader :macro

      def initialize
        @macro = :validates_presence_of
      end
    end
  end
end
