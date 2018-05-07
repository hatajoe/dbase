json.extract! product, :id, :organization_id, :repository_name, :name, :created_at, :updated_at
json.url product_url(product, format: :json)
