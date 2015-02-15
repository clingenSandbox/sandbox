# An example usage of the clingendb API
# @Author Xin Feng 
# @Email xinf@bcm.edu
# @Date 03/19/2014
#

require 'rest'
require 'urlb'

if ARGV.length < 1
  puts "Usage: ruby #{$0} gene.name"
  exit
end
# Credentials
gbLogin   = 'xin'
usrPass   = '123456'

# Database configuration
kbName    = 'acmg-Test'
grpName   = 'acmg-apiTest'
collName  = 'acmg-lit'

# Query value 
qryVal = ARGV[0]

# Query configuration
props     = 'documentID.variantEffectOnGene.affectedGene'

# Url building process
http        = 'http://'
genbHost    = 'genboree.org'
detailed    = '&detailed=true' # Enable full JSON report

rsrcPath    = "/REST/v1/grp/#{grpName}/kb/#{kbName}/coll/#{collName}/docs?"
propPath    = "matchProps=#{props}&matchValue=#{qryVal}"

url = buildURL(genbHost, gbLogin, usrPass, rsrcPath, propPath, detailed)
$stderr.puts "Query url:" + url
page = get(url)
$stderr.puts page.body

chr='documentID.'
ga= JSON.parse(page.body)
statusCode=ga["status"]["statusCode"]

if statusCode == "OK"
  $stderr.puts "Queried Gene: #{ARGV[0]}"
  $stderr.puts "Got #{ga["data"].length} variants"
ga["data"].each do |val|
  vals = val["documentID"]["properties"]["location"]["properties"]
  print "#{vals["chromosome"]["value"]}\t"
  print "#{vals["startOfGenomicLocus"]["value"]}\t"
  print "#{vals["endOfGenomicLocus"]["value"]}\t"
  print val["documentID"]["properties"]["variantNucleotideSequence"]["value"]+ "\t"
  puts val["documentID"]["properties"]["referenceNucleotideSequence"]["value"]
end

end
