CarrierWave.configure do |config|
    config.fog_provider = 'fog/aws'                        # required
    config.fog_credentials = {
        provider:              'AWS',                                           # required
        aws_access_key_id:     'AKIAJEBKG2JF4IEGIZRQ',                          # required
        aws_secret_access_key: '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',      # required
        region:                'ap-northeast-2',             # optional, defaults to 'us-east-1'
    }
    config.fog_directory  = 'snt123'            # required
end

# Users with AWS Management Console access can sign-in at:
# https://480798049484.signin.aws.amazon.com/console
