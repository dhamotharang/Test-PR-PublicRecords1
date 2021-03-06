Append Clean Address HIPIE Plugin

This plugin uses the current Address cleaner library to take address columns, 
clean the address into standard components and append them to the 
dataset.

This plugin is typically used where you have Address columns with 
two address lines, city and/or state and zip.

Address1                  Address2                City         State       Zip
123 Main Street           APT 202B                Dullsville   MN          93922
2000 5th Street           SUITE 202B              Davis        CA          92929

This address would map to the following inputs for the plugin.
AddressLine1
AddressLine2
City
State
Zip

You can also clean addresses where it has two columns. One with the addresses line 
and the second with the City,St,Zip etc..

Address1                       Address2
123 Main Street, APT 202B      Dullsville, MN, 93922
2000 5th Street, SUITE 202B    Davis, CA, 92929

This would map to the following inputs for the plugin

AddressLine1
AddressLine2WithCity

The plugin will separate the Address into component parts and append them to the input dataset.

primaryrange
predirectional
primaryname
addresssuffix
postdirectional
unitdesignation
secondaryrange
postalcity
vanitycity
state
zip
zip4
dbpc
checkdigit
recordtype
county           : This is the 5-digit county FIPS code. Super important if you are planning to aggregate for 
                   a Choropleth widget.
latitude
longitude
msa
geoblock
geomatchcode     : Match code indicating the precision of the latitude and longitude assignment.
                   0: Matched in AddressLevel
                   1: Nine-digit match. Unsually indicates precision to a particular block face.
                   4: Seven-digit match. Usually indicates precision to within a few blocks.
                   5: Five-digit match. Usually indicates precision to within a mile or two.
                   7: No match in Centroid-Level.
                   8: No match in Address-Level.
                   9: No match in Centroid-Level or Address-Level.

errorstatus: is the ACE U.S. address status codes

1st
A ACE had to truncate the address line to make it fit into your field.
B ACE truncated both the address line and the city name.
C ACE had to truncate the city name to make it fit into your field.
S ACE didn???t truncate anything.

2nd
0 Regarding the city, state, ZIP, and ZIP+4, there is no significant difference between the input data and the data that ACE assigned.
1 ACE assigned a different ZIP.
2 ACE assigned a different city.
3 ACE assigned a different city and ZIP.
4 ACE assigned a different state.
5 ACE assigned a different state and ZIP.
6 ACE assigned a different city and state.
7 ACE assigned a different city, state, and ZIP.
8 ACE assigned a different ZIP+4.
9 ACE assigned a different ZIP and ZIP+4.
A ACE assigned a different city and ZIP+4.
B ACE assigned a different city, ZIP, and ZIP+4.
C ACE assigned a different state and ZIP+4.
D ACE assigned a different state, ZIP, and ZIP+4.
E ACE assigned a different city, state, and ZIP+4.
F ACE assigned a different city, state, ZIP and ZIP+4.

3rd
0 Regarding the primary name, directionals, and suffix, there is no significant difference between the input and what ACE assigned.
1 ACE assigned a different suffix.
2 ACE assigned a different predirectional.
3 ACE assigned a different predirectional and suffix.
4 ACE assigned a different postdirectional.
5 ACE assigned a different suffix and postdirectional.
6 ACE assigned a different predirectional and postdirectional.
7 ACE assigned a different predirectional, suffix, and postdirectional.
8 ACE assigned a different primary name.
9 ACE assigned a different primary name and suffix.
A ACE assigned a different predirectional and primary name.
B ACE assigned a different predirectional, primary name, and suffix.
C ACE assigned a different primary name and postdirectional.
D ACE assigned a different primary name, suffix, and postdirectional.
E ACE assigned a different predirectional, primary name, and postdirectional.
F ACE assigned a different predirectional, primary name, postdirectional, and suffix.

4th
0 Regarding the county number, CART (carrier-route number), DPBC, and unit designator, there is no significant difference between the input data and the data that ACE assigned.
1 ACE assigned a different unit designator.
2 ACE assigned a different DPBC.
3 ACE assigned a different DPBC and unit designator.
4 ACE assigned a different CART.
5 ACE assigned a different CART and unit designator.
6 ACE assigned a different CART and DPBC.
7 ACE assigned a different CART, DPBC, and unit designator.
8 ACE assigned a different county number.
9 ACE assigned a different county number and unit designator.
A ACE assigned a different county number and DPBC.
B ACE assigned a different county number, DPBC, and unit designator.
C ACE assigned a different county number and CART.
D ACE assigned a different county number, CART, and unit designator.
E ACE assigned a different county number, CART, and DPBC.
F ACE assigned a different county number, CART, DPBC, and unit designator.

ACE address error codes

E101 Last line is bad or missing
E212 No city and bad ZIP/postal code
E213 Bad city, valid state/province, and no ZIP/postal code
E214 Bad city and bad ZIP/postal code
E216 Bad ZIP, can???t determine which city match to select
E302 No primary address line parsed
E412 Street name not found in directory
E413 Possible street-name matches too close to choose one
E420 Primary range is missing
E421 Primary range is invalid for the street/route/building
E422 Predirectional needed, input is wrong or missing
E423 Suffix needed, input is wrong or missing
E425 Suffix and directional needed, input is wrong or missing
E427 [Post] Directional needed, input is wrong or missing
E428 Bad ZIP, can???t select an address match
E429 Bad city, can???t select an address match
E430 Possible address-line matches too close to choose one
E431 Urbanization needed, input is wrong or missing
E439 Exact match made in EWS directory
E500 Other error
E501 Foreign address
E502 Input record entirely blank
E503 ZIP not in area covered by partial ZIP+4 directory
E504 Overlapping ranges in ZIP+4 directory
E505 Address does not exist in the USPS directories, undeliverable address.
E600 Marked by USPS as unsuitable for delivery of mail

cachehit: True means that the address, in the format it was given existed in our 
          address cache. This means that we have seen it in that format before
          and that the clean address came from the cache and not the Address cleaner.
          
cleanerhit: True means that the clean address came from the Address cleaner.

Generally speaking, most addresses should be in the cache. If there is a high percentage
of addresses not hitting the cache then either it is because they are in a new format 
for those addresses (one we haven't seen or cleaned before) or they really are new addresses.
A new highrise or community of houses would cause this but it is unlikely they would all
be reported in the same input file at the same time for the first time.

Resource Requirements:

Requires the Address cleaner plugin to be available.

