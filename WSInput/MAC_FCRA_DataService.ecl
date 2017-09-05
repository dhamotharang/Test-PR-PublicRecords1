// This service created to add Web Service fields for ConsumerDisclosure.FCRADataService

EXPORT MAC_FCRA_DataService() := MACRO

  #WEBSERVICE(FIELDS(	
										/*---- Compliance Fields ----*/										
										/*---- Search Fields ----*/
										'FcraDataServiceRequest',
										'gateways'
									));
									
ENDMACRO;	

