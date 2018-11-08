AppendAddressLatitudeLongitude README


This is an APPEND plugin.

This plugin appends latitude and longitude from an already cleaned address.
Batch plugins often return clean addresses without latitude and longitude therefore we need a way to add latitude and longitude 
without adding all of the clean address components all over again. 


The Prefix input will be appended to the front of the newly created field's name, e.g. AddressLatitude, AddressLongitude.

The dsInput is the input dataset.
All these columns need to be specified by the user from the input dataset:
	PrimaryRange
	PreDirectional
	PrimaryName
	AddressSuffix
	PostDirectional
	UnitDesignation
	SecondaryRange
	PostalCity
	VanityCity
	State
	Zip

GeoMatchCodeThreshold is used to to support NOT appending Latitude and Longitude if GeoMatchCode is above a certain threshold. 
The default is 0.


