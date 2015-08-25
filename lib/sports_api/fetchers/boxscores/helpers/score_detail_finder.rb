class SportsApi::Fetcher::Helpers::ScoreDetailFinder
  attr_accessor :markup

  def initialize(markup)
    self.markup = markup
  end

  def details
    @details ||= find_details
  end

  private

  def find_details
    css = '.mod-container.mod-open.mod-open-gamepack'

    score_detail_finder(css, 'th', 'td') do |content, index|
      case index
      when 0
        content.at_css('img').attributes['alt'].content
      when 1
        nil
      when 3
        content.children.first.content
      else
        content.content
      end
    end
  end

  def score_detail_finder(table_css, header_css, content_css,  &block)
    summary = markup.at_css(table_css)
    score_detail = []

    current_section = 0
    summary.css('tr').each_with_index do |row, index|
      if row.at_css(header_css)
        score_detail << {
          header_info: row.at_css(header_css).content,
          content_info: []
        }

        current_section = score_detail.count
      else
        content = []
        row.css(content_css).each_with_index do |box, i|
          content << yield(box, i)
        end

        score_detail[current_section - 1][:content_info] << content.compact.map(&:strip).take(3)
      end
    end

    return score_detail
  end
end

