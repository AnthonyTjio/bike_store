namespace :parameter_store do
  desc "Setup database configuration parameters in AWS Parameter Store"
  task :setup_database => :environment do
    require 'aws-sdk-ssm'
    
    ssm_client = Aws::SSM::Client.new(region: ENV['AWS_REGION'] || 'us-east-1')
    app_name = Rails.application.class.parent_name.downcase
    
    # Default configurations for each environment
    configs = {
      'development' => {
        'adapter' => 'sqlite3',
        'database' => 'db/development.sqlite3',
        'pool' => '5',
        'timeout' => '5000'
      },
      'test' => {
        'adapter' => 'sqlite3',
        'database' => 'db/test.sqlite3',
        'pool' => '5',
        'timeout' => '5000'
      },
      'production' => {
        'adapter' => 'sqlite3',
        'database' => 'db/production.sqlite3',
        'pool' => '5',
        'timeout' => '5000'
      }
    }
    
    configs.each do |env, config|
      puts "Setting up parameters for #{env} environment..."
      
      config.each do |key, value|
        parameter_name = "/#{app_name}/#{env}/database/#{key}"
        
        begin
          ssm_client.put_parameter({
            name: parameter_name,
            value: value,
            type: key == 'password' ? 'SecureString' : 'String',
            overwrite: true,
            description: "Database #{key} for #{env} environment"
          })
          
          puts "  ✓ Set #{parameter_name} = #{key == 'password' ? '[HIDDEN]' : value}"
        rescue Aws::SSM::Errors::ServiceError => e
          puts "  ✗ Failed to set #{parameter_name}: #{e.message}"
        end
      end
    end
    
    puts "\nParameter Store setup complete!"
    puts "\nTo customize your database configuration, update the parameters in AWS Systems Manager Parameter Store:"
    puts "AWS Console > Systems Manager > Parameter Store"
    puts "\nOr use the AWS CLI:"
    puts "aws ssm put-parameter --name '/#{app_name}/production/database/adapter' --value 'postgresql' --type 'String' --overwrite"
  end
  
  desc "List all database parameters in Parameter Store"
  task :list_database => :environment do
    require 'aws-sdk-ssm'
    
    ssm_client = Aws::SSM::Client.new(region: ENV['AWS_REGION'] || 'us-east-1')
    app_name = Rails.application.class.parent_name.downcase
    
    ['development', 'test', 'production'].each do |env|
      puts "\n#{env.upcase} Environment:"
      puts "=" * 50
      
      begin
        response = ssm_client.get_parameters_by_path({
          path: "/#{app_name}/#{env}/database",
          recursive: true,
          with_decryption: false
        })
        
        if response.parameters.empty?
          puts "  No parameters found"
        else
          response.parameters.each do |param|
            key = param.name.split('/').last
            value = key == 'password' ? '[HIDDEN]' : param.value
            puts "  #{key}: #{value}"
          end
        end
      rescue Aws::SSM::Errors::ServiceError => e
        puts "  Error: #{e.message}"
      end
    end
  end
  
  desc "Test database connection using Parameter Store configuration"
  task :test_connection => :environment do
    begin
      ActiveRecord::Base.connection.execute("SELECT 1")
      puts "✓ Database connection successful using Parameter Store configuration"
    rescue => e
      puts "✗ Database connection failed: #{e.message}"
    end
  end
end