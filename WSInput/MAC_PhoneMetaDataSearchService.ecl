// This service created to add Web Service fields for Phones.PhoneMetaDataService

EXPORT MAC_PhoneMetaDataSearchService() := MACRO

  #WEBSERVICE(FIELDS(	
											/*---- Search Fields ----*/
          'PhoneMetaDataSearchServiceRequest',
          'Gateways'
									));
ENDMACRO;	