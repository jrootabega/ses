require_relative ('./config/EmailConfig.rb')
require 'Mail'


def prepareMessage(c)
  Mail.new do
    to c.to
    from c.from
    subject c.subject
    body c.body
    c.files.each { |f| add_file f } 
  end
end

config = EmailConfig.new



message = prepareMessage(config)


puts 'Mail will be sent'
ses = AWS::SimpleEmailService.new(config.config)
ses.send_raw_email(message.to_s)




