# frozen_string_literal: true

module SignerColors
  PATH = Rails.root.join('app/javascript/signer_colors.js')
  ENTRY = /
    \{\s*dot:\s*'([^']+)',\s*bg:\s*'([^']+)',\s*border:\s*'([^']+)',
    \s*outline:\s*'([^']+)',\s*edge:\s*'([^']+)',\s*event:\s*'([^']+)'\s*\}
  /x

  module_function

  def entries
    list = PATH.read.scan(ENTRY).map do |dot, bg, border, outline, edge, event|
      { dot:, bg:, border:, outline:, edge:, event: }
    end

    raise "No signer colors found in #{PATH}" if list.empty?

    list
  end

  def at(index)
    palette = entries
    position = index.to_i
    position = 0 if position.negative?

    palette[position % palette.length]
  end

  def dots
    entries.pluck(:dot)
  end

  def backgrounds
    entries.pluck(:bg)
  end

  def borders
    entries.pluck(:border)
  end

  def events
    entries.pluck(:event)
  end
end
