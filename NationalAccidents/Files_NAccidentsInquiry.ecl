EXPORT Files_NAccidentsInquiry := MODULE

	// #################################################################################
	//                                 NAccidentsInquiry Prefix
	// #################################################################################
	EXPORT SPRAY_PREFIX                       := Files.SPRAY_NAI_PREFIX;
	EXPORT BASE_PREFIX                        := Files.BASE_NAI_PREFIX;

	// #################################################################################
	//                         NAccidentsInquiry Suffixes for Spray Datasets 
	// #################################################################################
	EXPORT SUFFIX_SPRAY_CLIENT                     := FileNames.CLIENT_FILE_NAME;
	EXPORT SUFFIX_SPRAY_INT_ORDER                  := FileNames.INT_ORDER_FILE_NAME;
	EXPORT SUFFIX_SPRAY_ORDER_VERSION              := FileNames.ORDER_VERSION_FILE_NAME;	
	EXPORT SUFFIX_SPRAY_VEHICLE_PARTY              := FileNames.VEHICLE_PARTY_FILE_NAME;	
	EXPORT SUFFIX_SPRAY_VEHICLE_INCIDENT           := FileNames.VEHICLE_INCIDENT_FILE_NAME;
	EXPORT SUFFIX_SPRAY_VEHICLE                    := FileNames.VEHICLE_FILE_NAME;
	EXPORT SUFFIX_SPRAY_RESULT                     := FileNames.RESULT_FILE_NAME;
	EXPORT SUFFIX_SPRAY_VEHICLE_INSCR              := FileNames.VEHICLE_INSCR_FILE_NAME;	

	// #################################################################################
	//                       NAccidentsInquiry Suffixes for Base Datasets  
	// #################################################################################
	EXPORT SUFFIX_NAME_CLIENT                      := FileNames.CLIENT_FILE_NAME;
	EXPORT SUFFIX_NAME_INT_ORDER                                   := FileNames.INT_ORDER_FILE_NAME;
	EXPORT SUFFIX_NAME_ORDER_VERSION                               := FileNames.ORDER_VERSION_FILE_NAME;	
	EXPORT SUFFIX_NAME_VEHICLE_PARTY                               := FileNames.VEHICLE_PARTY_FILE_NAME;	
	EXPORT SUFFIX_NAME_VEHICLE_INCIDENT                            := FileNames.VEHICLE_INCIDENT_FILE_NAME;
	EXPORT SUFFIX_NAME_VEHICLE                                     := FileNames.VEHICLE_FILE_NAME;
	EXPORT SUFFIX_NAME_RESULT                                      := FileNames.RESULT_FILE_NAME;
	EXPORT SUFFIX_NAME_VEHICLE_INSCR                               := FileNames.VEHICLE_INSCR_FILE_NAME;

	EXPORT SUFFIX_NAME_ALL_CRU_ORDERS	                             := 'ALL_CRU_ORDERS';
	EXPORT SUFFIX_NAME_ACCIDENTS_BASE		                            := 'NATIONAL_ACCIDENTS';
	EXPORT SUFFIX_NAME_INQUIRY_BASE                                := 'NATIONAL_ACCIDENTS_INQUIRY';

	// ###########################################################################
	//                 NAccidentsInquiry Spray Dataset Super File Definitions
	// ###########################################################################
	EXPORT SPRAY_CLIENT_BASE_FILE                  := SPRAY_PREFIX + '::QA::' + SUFFIX_SPRAY_CLIENT;
	EXPORT SPRAY_INT_ORDER_BASE_FILE               := SPRAY_PREFIX + '::QA::' + SUFFIX_SPRAY_INT_ORDER;
	EXPORT SPRAY_ORDER_VERSION_BASE_FILE           := SPRAY_PREFIX + '::QA::' + SUFFIX_SPRAY_ORDER_VERSION;
	EXPORT SPRAY_VEHICLE_PARTY_BASE_FILE           := SPRAY_PREFIX + '::QA::' + SUFFIX_SPRAY_VEHICLE_PARTY;
	EXPORT SPRAY_VEHICLE_INCIDENT_BASE_FILE        := SPRAY_PREFIX + '::QA::' + SUFFIX_SPRAY_VEHICLE_INCIDENT;
	EXPORT SPRAY_VEHICLE_BASE_FILE                 := SPRAY_PREFIX + '::QA::' + SUFFIX_SPRAY_VEHICLE;
	EXPORT SPRAY_RESULT_BASE_FILE                  := SPRAY_PREFIX + '::QA::' + SUFFIX_SPRAY_RESULT;
	EXPORT SPRAY_VEHICLE_INSCR_BASE_FILE           := SPRAY_PREFIX + '::QA::' + SUFFIX_SPRAY_VEHICLE_INSCR;

	// ###########################################################################
	//                  NAccidentsInquiry Spray Dataset Definitions
	// ###########################################################################	
	EXPORT DS_SPRAY_CLIENT                         := DATASET(SPRAY_CLIENT_BASE_FILE, 
																																																											Layouts_NAccidentsInquiry.CLIENT_INPUT, 
																																																											CSV(SEPARATOR(Constants.FieldSeparator), TERMINATOR(Constants.RecordTerminator), Quote(Constants.DefaultQuote), NOTRIM), 
																																																											OPT);
	EXPORT DS_SPRAY_INT_ORDER                      := DATASET(SPRAY_INT_ORDER_BASE_FILE, 
																																																											Layouts_NAccidentsInquiry.INT_ORDER_INPUT, 
																																																											CSV(SEPARATOR(Constants.FieldSeparator), TERMINATOR(Constants.RecordTerminator), Quote(Constants.DefaultQuote), NOTRIM),  
																																																											OPT);
	EXPORT DS_SPRAY_ORDER_VERSION                  := DATASET(SPRAY_ORDER_VERSION_BASE_FILE, 
																																																											Layouts_NAccidentsInquiry.ORDER_VERSION_INPUT, 
																																																											CSV(SEPARATOR(Constants.FieldSeparator), TERMINATOR(Constants.RecordTerminator), Quote(Constants.DefaultQuote), NOTRIM),  
																																																											OPT);
	EXPORT DS_SPRAY_VEHICLE_PARTY                  := DATASET(SPRAY_VEHICLE_PARTY_BASE_FILE, 
																																																											Layouts_NAccidentsInquiry.VEHICLE_PARTY_INPUT, 
																																																											CSV(SEPARATOR(Constants.FieldSeparator), TERMINATOR(Constants.RecordTerminator), Quote(Constants.DefaultQuote), NOTRIM),  
																																																											OPT); 
	EXPORT DS_SPRAY_VEHICLE_INCIDENT               := DATASET(SPRAY_VEHICLE_INCIDENT_BASE_FILE, 
																																																											Layouts_NAccidentsInquiry.VEHICLE_INCIDENT_INPUT, 
																																																											CSV(SEPARATOR(Constants.FieldSeparator), TERMINATOR(Constants.RecordTerminator), Quote(Constants.DefaultQuote), NOTRIM),  
																																																											OPT);																														
	EXPORT DS_SPRAY_VEHICLE                        := DATASET(SPRAY_VEHICLE_BASE_FILE, 
																																																											Layouts_NAccidentsInquiry.PAYLOAD, 
																																																											CSV(SEPARATOR(Constants.FieldSeparator), TERMINATOR(Constants.RecordTerminator), Quote(Constants.DefaultQuote), NOTRIM), 
																																																											OPT);
	EXPORT DS_SPRAY_RESULT                         := DATASET(SPRAY_RESULT_BASE_FILE, 
																																																											Layouts_NAccidentsInquiry.RESULT_INPUT, 
																																																											CSV(SEPARATOR(Constants.FieldSeparator), TERMINATOR(Constants.RecordTerminator), Quote(Constants.DefaultQuote), NOTRIM),  
																																																											OPT);																														
	EXPORT DS_SPRAY_VEHICLE_INSCR                  := DATASET(SPRAY_VEHICLE_INSCR_BASE_FILE, 
																																																											Layouts_NAccidentsInquiry.VEHICLE_INSURANCE_INPUT, 
																																																											CSV(SEPARATOR(Constants.FieldSeparator), TERMINATOR(Constants.RecordTerminator), Quote(Constants.DefaultQuote), NOTRIM),  
																																																											OPT); 

	//###############################################################################
	//						NAccidentsInquiry ALL SUPER FILE NAME SETTINGS 
	//###############################################################################

	EXPORT FILE_ALL_CLIENT_SF     		              := BASE_PREFIX + '::ALL::' + SUFFIX_NAME_CLIENT;	
	EXPORT FILE_ALL_VEHICLE_PARTY_SF       		     := BASE_PREFIX + '::ALL::' + SUFFIX_NAME_VEHICLE_PARTY;
	EXPORT FILE_ALL_VEHICLE_INCIDENT_SF      	    := BASE_PREFIX + '::ALL::' + SUFFIX_NAME_VEHICLE_INCIDENT;
	EXPORT FILE_ALL_VEHICLE_SF    	               := BASE_PREFIX + '::ALL::' + SUFFIX_NAME_VEHICLE;
	EXPORT FILE_ALL_RESULT_SF	                    := BASE_PREFIX + '::ALL::' + SUFFIX_NAME_RESULT;
	EXPORT FILE_ALL_VEHICLE_INSCR_SF    		        := BASE_PREFIX + '::ALL::' + SUFFIX_NAME_VEHICLE_INSCR;
	EXPORT FILE_ALL_CRU_ORDERS_SF       	         := BASE_PREFIX + '::ALL::' + SUFFIX_NAME_ALL_CRU_ORDERS;

	// ###########################################################################
	//                NAccidentsInquiry Logical File Name Settings
	//                      @ QA, FATHER, GRANDFATHER
	// ###########################################################################	
	EXPORT FILE_BASE_CLIENT_SF                                 := BASE_PREFIX + '::QA::' + SUFFIX_NAME_CLIENT;	
	EXPORT FILE_BASE_VEHICLE_PARTY_SF                          := BASE_PREFIX + '::QA::' + SUFFIX_NAME_VEHICLE_PARTY;
	EXPORT FILE_BASE_VEHICLE_INCIDENT_SF                       := BASE_PREFIX + '::QA::' + SUFFIX_NAME_VEHICLE_INCIDENT;	
	EXPORT FILE_BASE_VEHICLE_SF                                := BASE_PREFIX + '::QA::' + SUFFIX_NAME_VEHICLE;
	EXPORT FILE_BASE_RESULT_SF                                 := BASE_PREFIX + '::QA::' + SUFFIX_NAME_RESULT;  
	EXPORT FILE_BASE_VEHICLE_INSCR_SF                          := BASE_PREFIX + '::QA::' + SUFFIX_NAME_VEHICLE_INSCR;  

	EXPORT FILE_BASE_ALL_CRU_ORDERS_SF                         := BASE_PREFIX + '::QA::' + SUFFIX_NAME_ALL_CRU_ORDERS;
	EXPORT FILE_BASE_NAccidents_SF                             := BASE_PREFIX + '::QA::' + SUFFIX_NAME_ACCIDENTS_BASE;
	EXPORT FILE_BASE_NAccidentsInquiry_SF                      := BASE_PREFIX + '::QA::' + SUFFIX_NAME_INQUIRY_BASE;	


	// ###########################################################################
	//               NAccidentsInquiry Base File Datasets Definitions  
	// ###########################################################################	
	EXPORT DS_BASE_CLIENT                          := DATASET(FILE_BASE_CLIENT_SF,            Layouts_NAccidentsInquiry.CLIENT, THOR, OPT);
	EXPORT DS_BASE_VEHICLE_PARTY                   := DATASET(FILE_BASE_VEHICLE_PARTY_SF,     Layouts_NAccidentsInquiry.VEHICLE_PARTY, THOR, OPT);	
	EXPORT DS_BASE_VEHICLE_INCIDENT                := DATASET(FILE_BASE_VEHICLE_INCIDENT_SF,  Layouts_NAccidentsInquiry.VEHICLE_INCIDENT, THOR, OPT);
	EXPORT DS_BASE_VEHICLE                         := DATASET(FILE_BASE_VEHICLE_SF,           Layouts_NAccidentsInquiry.VEHICLE, THOR, OPT);
	EXPORT DS_BASE_RESULT                          := DATASET(FILE_BASE_RESULT_SF,            Layouts_NAccidentsInquiry.RESULT, THOR, OPT);
	EXPORT DS_BASE_VEHICLE_INSCR                   := DATASET(FILE_BASE_VEHICLE_INSCR_SF,     Layouts_NAccidentsInquiry.VEHICLE_INSURANCE, THOR, OPT);

	EXPORT DS_BASE_ALL_CRU_ORDERS                  := DATASET(FILE_BASE_ALL_CRU_ORDERS_SF,    Layouts_NAccidentsInquiry.ALL_CRU_ORDERS, THOR, OPT);
	EXPORT DS_BASE_NACCIDENTS                      := DATASET(FILE_BASE_NACCIDENTS_SF,        Layouts_NAccidentsInquiry.NATIONAL_ACCIDENTS, THOR, OPT);
	EXPORT DS_BASE_NACCIDENTSINQUIRY               := DATASET(FILE_BASE_NACCIDENTSINQUIRY_SF, Layouts_NAccidentsInquiry.NATIONAL_ACCIDENTS_INQUIRY, THOR, OPT);	

END;