class StubbedHtml
  def self.get(file)
    ## Remove specific file from caller location
    caller_paths = caller_locations(1,1)[0].path.split(/\//)
    league_path = caller_paths.pop
    caller_paths << league_path.match(/\w+_/).to_s.gsub(/_/, '')
    caller_path = caller_paths.join('/')

    files = caller_path.match(/spec\/.+$/).to_s.gsub(/spec\//, '').split('/')
    attempt = File.join(SportsApi.root, 'spec', 'fixtures', files, file)

    Nokogiri::HTML(File.read(attempt))
  end
end
