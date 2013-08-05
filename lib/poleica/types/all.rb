# -*- encoding: utf-8 -*-
module Poleica
  # rubocop:disable all
  module Types
    All = Poleica::Types.constants.map { |c| Poleica::Types.const_get(c) }
  end # module Types
  # rubocop:enable all
end # module Poleica
