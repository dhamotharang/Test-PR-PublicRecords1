// This service created to add Web Service fields for ConsumerDisclosure.FCRAInquiryHistoryService

EXPORT MAC_FCRA_InquiryHistory_Service() := MACRO

  #WEBSERVICE(FIELDS(	
										/*---- Compliance Fields ----*/										
										/*---- Search Fields ----*/
										'FCRAInquiryHistoryRequest',
										'gateways'
									));
									
ENDMACRO;	

