# Copyright 2011-2013 Amazon.com, Inc. or its affiliates. All Rights Reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License"). You
# may not use this file except in compliance with the License. A copy of
# the License is located at
#
#     http://aws.amazon.com/apache2.0/
#
# or in the "license" file accompanying this file. This file is
# distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF
# ANY KIND, either express or implied. See the License for the specific
# language governing permissions and limitations under the License.

require 'rubygems'
require 'yaml'
require 'aws-sdk'

class EmailConfig
  
  
  attr_reader :from, :to, :cc, :subject, :body, :files
  
  
  
  def initialize(authfile = nil)
    config_file = File.join(authfile.nil? ? "./auth.yml" : authfile)
    
    unless File.exist?(config_file)
      puts <<END
To run the samples, put your credentials in auth.yml as follows:

access_key_id: YOUR_ACCESS_KEY_ID
secret_access_key: YOUR_SECRET_ACCESS_KEY

END
      exit 1
    end
    
    @config = YAML.load(File.read(config_file))
    
    unless @config.kind_of?(Hash)
      puts <<END
auth.yml is formatted incorrectly.  Please use the following format:

access_key_id: YOUR_ACCESS_KEY_ID
secret_access_key: YOUR_SECRET_ACCESS_KEY

END
      exit 1
    end
    
    
    if ARGV.size == 0
      
      puts <<END
Specify either number of command line arguments:
MessageFilename [AttachmentFilename ...]
END
      exit 1
    end
    
    
    
    @from, @to, @cc, @subject, @body  = parseMessageFile ARGV[0] 
    ARGV.shift
    
    @files = ARGV[0,ARGV.size]
    
    
    
    
  end #end the init method
  
  
  def parseMessageFile(filename) 
    
    mFile = File.open(filename)

    def mFile.nextContentLine
      line = nil
      loop do
        line = self.readline.chomp
        break unless line[0] == '#'
      end

      line
    end
    
    #from = mFile.readline.chomp
    from = mFile.nextContentLine
    
    #to = mFile.readline.chomp
    to = mFile.nextContentLine
    
    #cc = mFile.readline.chomp
    cc = mFile.nextContentLine
    cc = cc == '' ? nil : cc
    
    #subject = mFile.readline.chomp
    subject = mFile.nextContentLine
    
    
    body = ''
    
    mFile.each_line do |l|
      body << l
      
      
      
      
    end
    
    
    [from, to, cc, subject, body]
    
    
    
    
  end
  
  
  
  def config
    @config
  end
  
  
  #AWS.config(config) - will configure individually
end
