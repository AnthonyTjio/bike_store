require 'aws-sdk-ssm'

class DatabaseConfig
  def self.load_config
    return @config if @config
    
    @config = {}
    environments = ['development', 'test', 'production']
    
    environments.each do |env|
      @config[env] = fetch_config_for_environment(env)
    end
    
    @config
  end
  
  private
  
  def self.fetch_config_for_environment(env)
    ssm_client = Aws::SSM::Client.new(region: ENV['AWS_REGION'] || 'us-east-1')
    
    base_path = "/#{Rails.application.class.parent_name.downcase}/#{env}/database"
    
    begin
      # Fetch all parameters for this environment
      response = ssm_client.get_parameters_by_path({
        path: base_path,
        recursive: true,
        with_decryption: true
      })
      
      config = {}
      
      response.parameters.each do |param|
        key = param.name.split('/').last
        config[key] = param.value
      end
      
      # Set defaults if not provided
      config['adapter'] ||= 'sqlite3'
      config['pool'] ||= '5'
      config['timeout'] ||= '5000'
      
      # Handle database path for SQLite
      if config['adapter'] == 'sqlite3' && !config['database']
        config['database'] = "db/#{env}.sqlite3"
      end
      
      config
    rescue Aws::SSM::Errors::ServiceError => e
      Rails.logger.warn "Failed to fetch database config from Parameter Store: #{e.message}"
      Rails.logger.warn "Falling back to default configuration for #{env}"
      
      # Fallback configuration
      {
        'adapter' => 'sqlite3',
        'database' => "db/#{env}.sqlite3",
        'pool' => '5',
        'timeout' => '5000'
      }
    end
  end
end