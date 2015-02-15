# An example usage of the clingendb API
# @Author Xin Feng 
# @Email xinf@bcm.edu
# @Date 03/19/2014
#

require 'rest'
require 'urlb'

# Credentials
gbLogin   = 'xin'
usrPass   = '123456'

# Database configuration
kbName    = 'acmg-Test'
grpName   = 'acmg-apiTest'
collName  = 'acmg-lit'

# Query value 
qryVal = 'rs80357021' 

# Query configuration
props     = 'documentID.dbsnpId'

# Url building process
http        = 'http://'
genbHost    = 'genboree.org'
detailed    = '&detailed=true' # Enable full JSON report
useHost     = '&useHost=' + genbHost

rsrcPath    = "/REST/v1/grp/#{grpName}/kb/#{kbName}/coll/#{collName}/docs?"
propPath    = "matchProps=#{props}&matchValue=#{qryVal}"


url = buildURL(genbHost, gbLogin, usrPass, rsrcPath, propPath, detailed)

puts "Query url:" + url
page = get(url)
puts page.body
