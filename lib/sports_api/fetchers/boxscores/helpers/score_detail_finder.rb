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
    css = '#gamepackage-scoring-wrap table'

    score_detail_finder(css, 'highlight', 'td') do |content, index|
      case index
      when 0
        content.at_css('img').attributes['src'].content.match(/\/500\/\w*/).to_s.gsub('/500/', '')
      when 1
        [content.at_css('.time-stamp').content, content.at_css('.headline').content]
      else
        nil
      end
    end
  end

  def score_detail_finder(table_css, header_css, content_css,  &block)
    summary = markup.css(table_css).last
    score_detail = []

    current_section = 0
    summary.css('tr').each_with_index do |row, index|
      if (row.attributes['class'] && row.attributes['class'].content == header_css rescue byebug)
        score_detail << {
          header_info: row.at_css('th').content,
          content_info: []
        }

        current_section = score_detail.count
      else
        content = []
        row.css(content_css).each_with_index do |box, i|
          content << yield(box, i)
        end

        score_detail[current_section - 1][:content_info] << content.compact.flatten.map(&:strip).take(3)
      end
    end

    return score_detail
  end
end

