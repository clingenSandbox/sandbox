# An example usage of the clingendb API
# to do bulk upload
# @Author Xin Feng 
# @Email xinf@bcm.edu
# @Date 08/18/2014
#

require 'rest'
require 'urlb'
require 'up'

if ARGV.length <  2
  $stderr.puts "Usage: ruby #{$0} collection.name json.doc.folder"
  exit
end

docs = [];
dataFiles = Dir[ARGV[1]+"/*.json"]

dataFiles.each do |f|
  docs << f
end

# Credentials
gbLogin, usrPass = getUP 

# Database configuration
kbName    = 'acmg-Test'
grpName   = 'acmg-apiTest'
collName  = ARGV[0]

# Url building process
http     = 'http://'
genbHost = 'genboree.org'

rsrcPath = "/REST/v1/grp/#{grpName}/kb/#{kbName}/coll/#{collName}/docs"
propPath = '' 
detailed = '' 

url = buildURL(genbHost, gbLogin, usrPass, rsrcPath, propPath, detailed)

api_put_with_diag(url,docs.to_json)
