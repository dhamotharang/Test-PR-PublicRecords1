IMPORT PRTE2_Neighborhood, Address_Attributes;

/************************************************************************************************************************
NOTE - All files are currently empty as only one key is actually used by a query, prte::key::neighborhood::crime::geolink
which is used by the Person Comp report. This will be a copy of the Production key
*************************************************************************************************************************/
EXPORT Files := MODULE

	EXPORT ACA_Institute	:= DATASET([], Layouts.l_ACA);
	EXPORT Neighborhood_Stats	:= DATASET([], Layouts.l_neighborhoodstats);
	EXPORT Businesses			:= DATASET([], Layouts.l_business);
	EXPORT SexOffender		:= DATASET([], recordof(Address_Attributes.file_sex_offender)); 
	EXPORT Schools				:= DATASET([], recordof(address_attributes.file_schools));
	EXPORT Colleges				:= DATASET([], recordof(address_attributes.file_colleges));
	EXPORT FBI_CIUS				:= DATASET([], Layouts.l_Fbi_cius);
	EXPORT FireDept				:= DATASET([], recordof(address_attributes.File_Fire_Departments));
	EXPORT LawEnforcement	:= DATASET([], recordof(address_attributes.File_Law_Enforcement));
	EXPORT GEOLinkDistance	:= DATASET([], Layouts.l_GeoLinkDistance);
	EXPORT GEOBlk_LatLon	:= DATASET([], Layouts.l_geoblk_latlon);
	EXPORT GEOBlkInfo			:= DATASET([], Layouts.l_GeoblkInfo);
	//EXPORT CrimeGeoLink		:= Address_Attributes.file_crime_geolink; Not needed as code was added to create a copy of Prod key
END;
	
	