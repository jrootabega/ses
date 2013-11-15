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


attr_reader :from, :to, :subject, :body, :files



def initialize
config_file = File.join("./auth.yml")

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


if (1..3).cover? ARGV.size

  puts <<END
Specify either number of command line arguments:
0: (use all defaults)
>=5: (specify all manually)
END
  exit 1
end



if ARGV.size > 0
@from = ARGV[0]
ARGV.shift

@to = ARGV[0]
ARGV.shift

@subject = ARGV[0]
ARGV.shift

@body = ARGV[0]
ARGV.shift

@files = ARGV[0,ARGV.size]


else
@from = 'NRRCProjectNotifications@gmail.com'
@to = from
@subject = 'NRRC Automated Notification'
@body = 'This is an automated notification about the NRRC.'
@files = Array.new


end


end #end the init method



def config
 @config
end


#AWS.config(config) - will configure individually
end
