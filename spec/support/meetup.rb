def meetup_api_key
  "meetup_key"
end

def meetup_url(url)
  "http://api.meetup.com#{url}"
end

def fixture_file(filename)
  return '' if filename == ''
  file_path =  File.expand_path('../../fixtures/' + filename, __FILE__)
  File.read(file_path)
end