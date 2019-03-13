Compute Business Intra Georadius Associations Read Me

===========================================================
                      Plugin Type
===========================================================
This is a COMPUTE plugin.

===========================================================
                      Plugin Description
===========================================================
This plugin calculates business location associations
 and assigns a set of of attributes
when it finds associations between business locations.

===========================================================
                      What to Input
===========================================================

The Prefix input will be appended to the front of the newly created field's name.

The dsInput is the input dataset.

Geohash - the location geohash. 
Typically calculated using the AppendGeohash plugin

Record ID - a unique record ID.
Typically calculated using the AppendSequenceId plugin unless the dataset already contains 
a unique record identifier

Ult ID - the business ultimate owner BIP Id

Prox ID - the business physical location BIP Id

Prox Entity Context UID - the ProxID entity context UID
Typically calculated using the AppendEntityContextUID plugin

Business Name - the name of the business

Business Building Address - the building address of the business
Typically this will be a concatenated field of the cleaned address values
without the secondary range included (using the ComputeConcatenatedColumn plugin).

Business Physical Address - the physical address of the business

Business Phone - the phone number of the business

Legal Name - the legal name of the business
This field is optional. 

Doing Business As Name - the DBA name of the business
This field is optional. 

Business Mailing Address - the mailing address of the business
This field is optional. 

Append Fields - the list of fields from the business location match up to add to the output  

Distance Threshold - the distance threshold for two different business locations to be considered an associations
The default is 0.5 miles

Max Business at Location - the maximum number of businesses at a single location when calculating associations
The default is 50.
This option is to prevent the dataset from blowing out of proportions due to businesses like paycorp

Name Distance Threshold - the business name distance treshold to be considerent an almost match.
The default is 2

===========================================================
                      Outputs
===========================================================

In the output the following fields are appended:

AppendFields selected (the Prefix will be appended in front of them to make them unique)

ProxEntityLocation - a concatenated field of the Prox Entity Context UID and the Geohash location

GeoDistance - the distance between the two business locations geohash (in miles)

EditDistanceMatch - whether the two business locations have an edit distance match between any of the business names provided

ExactCompanyNameMatch - whether the two business locations have an exact company name match

PhoneNumberMatch - whether the two business locations have a phone number match

Matching Ult - whether the two business locations have a matching Ult ID (i.e. they fall under the same business hierarchy)

DifferentLocationMailingAddressMatch - whether the two business locations have a different physical location but a matching mailing address
This output field is optional and only returned and populated if the Business Mailing Address input field is assigned.

PinColor - will return the following values:
   - orange if the two business locations are the same business (i.e. matching Prox Entity Context UID)
   - red if the PhoneNumberMatch OR the ExactCompanyNameMatch OR the EditDistanceMatch Or the DifferentLocationMailingAddressMatch (when returned)
   - grey if the Prox ID is 0
   - green otherwise

