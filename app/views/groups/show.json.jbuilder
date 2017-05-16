json.extract! @group, :id, :name, :purpose, :choose_takers
json.records_url group_records_path(@group, format: :json)
json.group_url group_path(@group, format: :json)
