json.extract! repository, :id, :full_name, :html_url, :created_at, :updated_at
json.url repositories_url(repository, format: :json)
