Compute BIS Unknown Business Attributes ReadMe

===========================================================
                      Plugin Type
===========================================================
This is a COMPUTE plugin.

===========================================================
                      Plugin Description
===========================================================
This plugin computes BIS unknown business attributes to filter potential false positives in added business entities
from AppendAdditionalBusinessEntities plugin to use in dashboarding

===========================================================
                      What to Input
===========================================================
The Prefix input will be appended to the front of the newly created field's name.

The dsInput is the input dataset.

Prox ID - the business physical location BIP Id

Prox Entity Context UID - the entity context UID of the business ProxID
Typically calculated using the AppendEntityContextUID plugin

Prox Entity Location - a concatenated field of the Prox Entity Context UID and the Geohash location

GeoDistance - the distance between the two business locations geohash (in miles)
Typically calculated using the ComputeBusinessIntraGeoradiusAssociations plugin

Alternate Prox Entity Context UID - the entity context UID of the potentially matching business ProxID"
Typically calculated using the AppendEntityContextUID plugin

Alternate Business Is Prox Input - whether the potentially matching business physical location is from the input

Matching Ult - whether the two business locations have a matching Ult ID (i.e. they fall under the same business hierarchy)
Typically calculated using the ComputeBusinessIntraGeoradiusAssociations plugin

Exact Company Name Match - whether the two business locations have the same business name
Typically calculated using the ComputeBusinessIntraGeoradiusAssociations plugin

Edit Distance Match - whether the two business locations have an edit distance match between any of the business names provided
Typically calculated using the ComputeBusinessIntraGeoradiusAssociations plugin

Phone Number Match - whether the two business locations have a phone number match
Typically calculated using the ComputeBusinessIntraGeoradiusAssociations plugin

Different Location Mailing Address Match - whether the two business locations have a different physical location but a matching mailing address
This field is optional. 
Typically calculated using the ComputeBusinessIntraGeoradiusAssociations plugin

Append Fields - the list of fields from the business location match up to add to the output  


===========================================================
                      Outputs
===========================================================
The Output will be composed of only the following fields:

Business Count - the number of businesses that match by Prox Entity Location but not by Prox Entity Context UID

InputBusinessCount - the number of businesses that match by Prox Entity Location but not by Prox Entity Context UID and are in the customer input (i.e. Alternate Business Is Prox Input = 1)

UnlinkedBusinessCount - the number of businesses that match by Prox Entity Location but not by Prox Entity Context UID and have a ProxID of 0

BusinessAtLocationCount - the number of businesses that match by Prox Entity Location but not by Prox Entity Context UID and have a Geodistance of 0

InputBusinessAtLocationCount - the number of businesses that match by Prox Entity Location but not by Prox Entity Context UID, have a geodistance of 0 and are in the customer input (i.e. Alternate Business Is Prox Input = 1)

UnlinkedBusinessAtLocationCount - the number of businesses that match by Prox Entity Location but not by Prox Entity Context UID, have a ProxID of 0 and a geodistance of 0

UltBusinessCount - the number of businesses that match by Prox Entity Location but not by Prox Entity Context UID and have a matching Ult (i.e. Matching Ult = 1)

UltBusinessAtLocationCount - the number of businesses that match by Prox Entity Location but not by Prox Entity Context UID, have a matching Ult (i.e. Matching Ult = 1) and a geodistance of 0

ExactBusinessNameAtLocationCount - the number of businesses that match by Prox Entity Location but not by Prox Entity Context UID, have the same business name (i.e. Exact Company Name Match = 1) and a geodistance of 0

ExactBusinessNameNotAtLocationCount - the number of businesses that match by Prox Entity Location but not by Prox Entity Context UID, have the same business name (i.e. Exact Company Name Match = 1) and a geodistance greater than 0

SimilarBusinessNameAtLocationCount - the number of businesses that match by Prox Entity Location but not by Prox Entity Context UID, have a similar name (i.e. Edit Distance Match = 1) and a geodistance of 0

SimilarBusinessNameNotAtLocationCount - the number of businesses that match by Prox Entity Location but not by Prox Entity Context UID, have a similar name (i.e. Edit Distance Match = 1) and a geodistance greater than 0

PhoneNumberMatchCount - the number of businesses that match by Prox Entity Location but not by Prox Entity Context UID and have the same phone number (i.e. Phone Number Match = 1)

PhoneNumberMatchAtLocationCount - the number of businesses that match by Prox Entity Location but not by Prox Entity Context UID, have the same phone number (i.e. Phone Number Match = 1) and a geodistance of 0

PhoneNumberMatchNotAtLocationCount - the number of businesses that match by Prox Entity Location but not by Prox Entity Context UID, have the same phone number (i.e. Phone Number Match = 1) and a geodistance greater than 0

MailingAddressMatchNotAtLocationCount - the number of businesses that match by Prox Entity Location but not by Prox Entity Context UID and have the same mailing address but a different physical address (i.e. Different Location Mailing Address Match = 1)
This output field is optional and only returned and populated if the Different Location Mailing Address Match input field is assigned.

Any fields selected in the AppendFields will be outputted 
