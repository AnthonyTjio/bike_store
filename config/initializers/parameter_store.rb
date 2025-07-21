# Parameter Store configuration
# This initializer sets up AWS SDK configuration for Parameter Store access

if Rails.env.production?
  # In production, use IAM roles or environment variables for AWS credentials
  Aws.config.update({
    region: ENV['AWS_REGION'] || 'us-east-1'
  })
else
  # In development/test, you can use AWS credentials from environment or AWS CLI
  Aws.config.update({
    region: ENV['AWS_REGION'] || 'us-east-1',
    # Uncomment and set these if not using AWS CLI or environment variables
    # access_key_id: ENV['AWS_ACCESS_KEY_ID'],
    # secret_access_key: ENV['AWS_SECRET_ACCESS_KEY']
  })
end

# Log Parameter Store configuration status
Rails.logger.info "Parameter Store configured for region: #{Aws.config[:region]}"