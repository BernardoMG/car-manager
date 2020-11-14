Apipie.configure do |config|
  config.app_name                = 'Car Manager API'
  config.app_info['1.0']         = 'A language agnostic RESTful API for Car Manager applications. It\'s currently on v.1.0.'
  config.api_base_url            = ''
  config.doc_base_url            = '/apipie'
  config.reload_controllers      = Rails.env.development?
  config.default_version         = '1.0'
  config.copyright = '&copy; 2020 Bernardo Graça'
  config.translate = false

  # where is your API defined?
  config.api_controllers_matcher = "#{Rails.root}/app/controllers/**/*.rb"
end
