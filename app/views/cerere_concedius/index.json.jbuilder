json.array!(@cerere_concedius) do |cerere_concediu|
  json.extract! cerere_concediu, :id, :data_inceput, :data_sfarsit, :user_id, :aprobata
  json.url cerere_concediu_url(cerere_concediu, format: :json)
end
