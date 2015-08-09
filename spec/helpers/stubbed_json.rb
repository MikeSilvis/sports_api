class StubbedJson
  def self.get(file)
    ## Remove specific file from caller location
    caller_paths = caller_locations(1,1)[0].path.split(/\//)
    caller_paths.pop
    caller_path = caller_paths.join('/')

    files = caller_path.match(/spec\/.+$/).to_s.gsub(/spec\//, '').split('/')
    attempt = File.join(SportsApi.root, 'spec', 'fixtures', files, 'nba', file)
    JSON.parse(File.read(attempt))
  end
end
