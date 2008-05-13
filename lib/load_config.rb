class ActiveResource::Base
  cattr_accessor :resource_con
  CONFIG_FILE = RAILS_ROOT + "/config/active_resource.yml"
  def self.config
    raise "#{CONFIG_FILE} non-existent!" unless File.exist?(CONFIG_FILE)
    @config ||= YAML.load_file(CONFIG_FILE)
  end
  
  def self.load_config(name)
    return nil if RAILS_ENV=='test'
    my_config = config[name.to_s]
    raise "no configuration for #{name} in #{CONFIG_FILE}" if my_config.nil?
    my_env_config = my_config[RAILS_ENV]
    raise "No configuration for #{name} in #{CONFIG_FILE} for environment #{RAILS_ENV}" if my_env_config.nil?
    
    self.site = my_env_config['site']
    site.user = my_env_config['user']
    site.password = my_env_config['password']
    self.prefix = my_env_config["prefix"] || ""
  end
end
