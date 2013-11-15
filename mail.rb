require_relative ('./config/EmailConfig.rb')
require 'Mail'


def prepareMessage(c)
  Mail.new do
    to c.to
    from c.from
    cc c.cc unless c.cc.nil?
    subject c.subject
    body c.body
    c.files.each { |f| add_file f } 
  end
end

authfile = ARGV[0]
ARGV.shift

if authfile == 'nil'
  authfile = nil
end

config = EmailConfig.new authfile



message = prepareMessage(config)


puts 'Mail will be sent'
ses = AWS::SimpleEmailService.new(config.config)
ses.send_raw_email(message.to_s)





