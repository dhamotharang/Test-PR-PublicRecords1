IMPORT dx_Ecrash AS dx;

EXPORT Files_eCrash := MODULE
                                                    
  // #################################################################################
  //                                 Ecrash Prefix
  // #################################################################################
  EXPORT SPRAY_ECRASH_PREFIX := Files.SPRAY_ECRASH_PREFIX;
  EXPORT BASE_ECRASH_PREFIX := Files.BASE_ECRASH_PREFIX;
  EXPORT ORBIT_ECRASH_PREFIX := Files.ORBIT_ECRASH_PREFIX;	
	
  // #################################################################################
  //                         Ecrash Suffixes for Spray Datasets 
  // #################################################################################
  EXPORT SUFFIX_SPRAY_INCIDENT := FileNames.INCIDENT_FILE_NAME;    
  EXPORT SUFFIX_SPRAY_PERSON := FileNames.PERSON_FILE_NAME;        
  EXPORT SUFFIX_SPRAY_VEHICLE := FileNames.VEHICLE_FILE_NAME;        
  EXPORT SUFFIX_SPRAY_CITATION := FileNames.CITATION_FILE_NAME;        
  EXPORT SUFFIX_SPRAY_COMMERCIAL := FileNames.COMMERCIAL_FILE_NAME;        
  EXPORT SUFFIX_SPRAY_PROPERTY_DAMAGE := FileNames.PROPERTY_DAMAGE_FILE_NAME;        
  EXPORT SUFFIX_SPRAY_DOCUMENT := FileNames.DOCUMENT_FILE_NAME;        
  EXPORT SUFFIX_SPRAY_AGENCY := FileNames.AGENCY_FILE_NAME;        
  EXPORT SUFFIX_SPRAY_BILLING_AGENCY := FileNames.BILLING_AGENCY_FILE_NAME;
	
  // #################################################################################
  //                       Ecrash Suffixes for Base Datasets  
  // #################################################################################	
  EXPORT SUFFIX_NAME_INCIDENT := FileNames.INCIDENT_FILE_NAME;    
  EXPORT SUFFIX_NAME_PERSON := FileNames.PERSON_FILE_NAME;        
  EXPORT SUFFIX_NAME_VEHICLE := FileNames.VEHICLE_FILE_NAME;        
  EXPORT SUFFIX_NAME_CITATION := FileNames.CITATION_FILE_NAME;        
  EXPORT SUFFIX_NAME_COMMERCIAL := FileNames.COMMERCIAL_FILE_NAME;        
  EXPORT SUFFIX_NAME_PROPERTY_DAMAGE := FileNames.PROPERTY_DAMAGE_FILE_NAME;        
  EXPORT SUFFIX_NAME_DOCUMENT := FileNames.DOCUMENT_FILE_NAME;        
  EXPORT SUFFIX_NAME_AGENCY := FileNames.AGENCY_FILE_NAME;        
  EXPORT SUFFIX_NAME_BILLING_AGENCY := FileNames.BILLING_AGENCY_FILE_NAME;
	
  // #################################################################################
  //             Ecrash Suffixes for Combined Base Datasets 
  // #################################################################################
  EXPORT SUFFIX_NAME_AGENCY_COMBINED := 'AGENCY_COMBINED';
  EXPORT SUFFIX_NAME_ECRASH := 'ECRASH_BASE';    
  EXPORT SUFFIX_NAME_SUPPLEMENTAL := 'SUPPLEMENTAL_BASE';	
	EXPORT SUFFIX_NAME_INCIDENTS_EXTRACT := 'INCIDENTS_EXTRACT';
	
  // #################################################################################
  //             Ecrash Suffixes for SUPPRESS & DELETES Datasets
  // #################################################################################	
  EXPORT SUFFIX_NAME_SUPPRESS_INCIDENTS := 'SUPPRESS_INCIDENTS';
  EXPORT SUFFIX_NAME_SUPPRESS_REPORT_ID := 'SUPPRESS_REPORT_ID';
  EXPORT SUFFIX_NAME_SUPPRESS_CASE_IDENTIFIER := 'SUPPRESS_CASE_IDENTIFIER';
  EXPORT SUFFIX_NAME_ECRASH_DELETES := 'ECRASH_DELETES';
	
  // #################################################################################
  //             Ecrash Suffixes for Accidents Consolidation Base Files
  // #################################################################################
  EXPORT SUFFIX_NAME_CONSOLIDATION_ECRASH := 'ACCIDENTS_CONSOLIDATION_ECRASH';
  EXPORT SUFFIX_NAME_CONSOLIDATION_PR := 'ACCIDENTS_CONSOLIDATION_PR';
	
   // ###########################################################################
  //                 Ecrash Spray Super File Definitions
  // ###########################################################################    
  // EXPORT SPRAY_INCIDENT_BASE_FILE := SPRAY_ECRASH_PREFIX + '::QA::' + SUFFIX_SPRAY_INCIDENT;
  // EXPORT SPRAY_PERSON_BASE_FILE := SPRAY_ECRASH_PREFIX + '::QA::' + SUFFIX_SPRAY_PERSON;
  // EXPORT SPRAY_VEHICLE_BASE_FILE := SPRAY_ECRASH_PREFIX + '::QA::' + SUFFIX_SPRAY_VEHICLE;
  // EXPORT SPRAY_CITATION_BASE_FILE := SPRAY_ECRASH_PREFIX + '::QA::' + SUFFIX_SPRAY_CITATION;
  // EXPORT SPRAY_COMMERCIAL_BASE_FILE := SPRAY_ECRASH_PREFIX + '::QA::' + SUFFIX_SPRAY_COMMERCIAL;
  // EXPORT SPRAY_PROPERTY_DAMAGE_BASE_FILE := SPRAY_ECRASH_PREFIX + '::QA::' + SUFFIX_SPRAY_PROPERTY_DAMAGE;
  // EXPORT SPRAY_DOCUMENT_BASE_FILE := SPRAY_ECRASH_PREFIX + '::QA::' + SUFFIX_SPRAY_DOCUMENT;
  // EXPORT SPRAY_AGENCY_BASE_FILE := SPRAY_ECRASH_PREFIX + '::QA::' + SUFFIX_SPRAY_AGENCY;
  // EXPORT SPRAY_BILLING_AGENCY_BASE_FILE := SPRAY_ECRASH_PREFIX + '::QA::' + SUFFIX_SPRAY_BILLING_AGENCY;
	  
  // ###########################################################################
  //						Ecrash ALL Super File Definitions
  //###############################################################################    
  // EXPORT FILE_ALL_INCIDENT_SF := BASE_ECRASH_PREFIX + '::ALL::' + SUFFIX_NAME_INCIDENT;
  // EXPORT FILE_ALL_PERSON_SF := BASE_ECRASH_PREFIX + '::ALL::' + SUFFIX_NAME_PERSON;
  // EXPORT FILE_ALL_VEHICLE_SF := BASE_ECRASH_PREFIX + '::ALL::' + SUFFIX_NAME_VEHICLE;
  // EXPORT FILE_ALL_CITATION_SF := BASE_ECRASH_PREFIX + '::ALL::' + SUFFIX_NAME_CITATION;
  // EXPORT FILE_ALL_COMMERCIAL_SF := BASE_ECRASH_PREFIX + '::ALL::' + SUFFIX_NAME_COMMERCIAL;
  // EXPORT FILE_ALL_PROPERTY_DAMAGE_SF := BASE_ECRASH_PREFIX + '::ALL::' + SUFFIX_NAME_PROPERTY_DAMAGE;
  // EXPORT FILE_ALL_DOCUMENT_SF := BASE_ECRASH_PREFIX + '::ALL::' + SUFFIX_NAME_DOCUMENT;
  // EXPORT FILE_ALL_AGENCY_SF := BASE_ECRASH_PREFIX + '::ALL::' + SUFFIX_NAME_AGENCY;
  // EXPORT FILE_ALL_BILLING_AGENCY_SF := BASE_ECRASH_PREFIX + '::ALL::' + SUFFIX_NAME_BILLING_AGENCY;
	
  // ###########################################################################
  //						Ecrash FULL Super File Definitions
  //###############################################################################    
  // EXPORT FILE_FULL_INCIDENT_SF := BASE_ECRASH_PREFIX + '::FULL::' + SUFFIX_NAME_INCIDENT;
  // EXPORT FILE_FULL_PERSON_SF := BASE_ECRASH_PREFIX + '::FULL::' + SUFFIX_NAME_PERSON;
  // EXPORT FILE_FULL_VEHICLE_SF := BASE_ECRASH_PREFIX + '::FULL::' + SUFFIX_NAME_VEHICLE;
  // EXPORT FILE_FULL_CITATION_SF := BASE_ECRASH_PREFIX + '::FULL::' + SUFFIX_NAME_CITATION;
  // EXPORT FILE_FULL_COMMERCIAL_SF := BASE_ECRASH_PREFIX + '::FULL::' + SUFFIX_NAME_COMMERCIAL;
  // EXPORT FILE_FULL_PROPERTY_DAMAGE_SF := BASE_ECRASH_PREFIX + '::FULL::' + SUFFIX_NAME_PROPERTY_DAMAGE;
  // EXPORT FILE_FULL_DOCUMENT_SF := BASE_ECRASH_PREFIX + '::FULL::' + SUFFIX_NAME_DOCUMENT;
  // EXPORT FILE_FULL_AGENCY_SF := BASE_ECRASH_PREFIX + '::FULL::' + SUFFIX_NAME_AGENCY;
  // EXPORT FILE_FULL_BILLING_AGENCY_SF := BASE_ECRASH_PREFIX + '::FULL::' + SUFFIX_NAME_BILLING_AGENCY;
	
  //###############################################################################
  //						Ecrash INC Super File Definitions 
  //###############################################################################    
  // EXPORT FILE_INC_INCIDENT_SF := BASE_ECRASH_PREFIX + '::INC::' + SUFFIX_NAME_INCIDENT;
  // EXPORT FILE_INC_PERSON_SF := BASE_ECRASH_PREFIX + '::INC::' + SUFFIX_NAME_PERSON;
  // EXPORT FILE_INC_VEHICLE_SF := BASE_ECRASH_PREFIX + '::INC::' + SUFFIX_NAME_VEHICLE;
  // EXPORT FILE_INC_CITATION_SF := BASE_ECRASH_PREFIX + '::INC::' + SUFFIX_NAME_CITATION;
  // EXPORT FILE_INC_COMMERCIAL_SF := BASE_ECRASH_PREFIX + '::INC::' + SUFFIX_NAME_COMMERCIAL;
  // EXPORT FILE_INC_PROPERTY_DAMAGE_SF := BASE_ECRASH_PREFIX + '::INC::' + SUFFIX_NAME_PROPERTY_DAMAGE;
  // EXPORT FILE_INC_DOCUMENT_SF := BASE_ECRASH_PREFIX + '::INC::' + SUFFIX_NAME_DOCUMENT;
  // EXPORT FILE_INC_AGENCY_SF := BASE_ECRASH_PREFIX + '::INC::' + SUFFIX_NAME_AGENCY;
  // EXPORT FILE_INC_BILLING_AGENCY_SF := BASE_ECRASH_PREFIX + '::INC::' + SUFFIX_NAME_BILLING_AGENCY;
  																											
  // ###########################################################################
  //                Ecrash BaseFiles Super File Definitions 
  // ###########################################################################	
  EXPORT FILE_BASE_INCIDENT_SF := BASE_ECRASH_PREFIX + '::QA::' + SUFFIX_NAME_INCIDENT;	
  EXPORT FILE_BASE_PERSON_SF := BASE_ECRASH_PREFIX + '::QA::' + SUFFIX_NAME_PERSON;	
  EXPORT FILE_BASE_VEHICLE_SF := BASE_ECRASH_PREFIX + '::QA::' + SUFFIX_NAME_VEHICLE;			
  EXPORT FILE_BASE_CITATION_SF := BASE_ECRASH_PREFIX + '::QA::' + SUFFIX_NAME_CITATION;
  EXPORT FILE_BASE_COMMERCIAL_SF := BASE_ECRASH_PREFIX + '::QA::' + SUFFIX_NAME_COMMERCIAL;	
  EXPORT FILE_BASE_PROPERTY_DAMAGE_SF := BASE_ECRASH_PREFIX + '::QA::' + SUFFIX_NAME_PROPERTY_DAMAGE;
  EXPORT FILE_BASE_DOCUMENT_SF := BASE_ECRASH_PREFIX + '::QA::' + SUFFIX_NAME_DOCUMENT;
  EXPORT FILE_BASE_AGENCY_SF := BASE_ECRASH_PREFIX + '::QA::' + SUFFIX_NAME_AGENCY;	
  EXPORT FILE_BASE_BILLING_AGENCY_SF := BASE_ECRASH_PREFIX + '::QA::' + SUFFIX_NAME_BILLING_AGENCY;	
  																											
  // ###########################################################################
  //             Ecrash Combined BaseFiles Super File Definitions 
  // ###########################################################################	 	
  EXPORT FILE_BASE_AGENCY_COMBINED_SF := BASE_ECRASH_PREFIX + '::QA::' + SUFFIX_NAME_AGENCY_COMBINED;		
  EXPORT FILE_BASE_ECRASH_SF := BASE_ECRASH_PREFIX + '::QA::' + SUFFIX_NAME_ECRASH;	
  EXPORT FILE_BASE_INCIDENTS_EXTRACT_SF := BASE_ECRASH_PREFIX + '::QA::' + SUFFIX_NAME_INCIDENTS_EXTRACT;	
  EXPORT FILE_BASE_SUPPLEMENTAL_SF := BASE_ECRASH_PREFIX + '::QA::' + SUFFIX_NAME_SUPPLEMENTAL;		
  
  // ###########################################################################
  //             Ecrash SUPPRESS & DELETES  Super File Definitions 
  // ###########################################################################  	
  EXPORT FILE_BASE_SUPPRESS_INCIDENTS_SF := BASE_ECRASH_PREFIX + '::QA::' + SUFFIX_NAME_SUPPRESS_INCIDENTS;	
  EXPORT FILE_BASE_SUPPRESS_REPORT_ID_SF := BASE_ECRASH_PREFIX + '::QA::' + SUFFIX_NAME_SUPPRESS_REPORT_ID;	
  EXPORT FILE_BASE_SUPPRESS_CASE_IDENTIFIER_SF := BASE_ECRASH_PREFIX + '::QA::' + SUFFIX_NAME_SUPPRESS_CASE_IDENTIFIER;	
  EXPORT FILE_BASE_ECRASH_DELETES_SF := BASE_ECRASH_PREFIX + '::QA::' + SUFFIX_NAME_ECRASH_DELETES;
  
  // ###########################################################################
  //             Ecrash Accidents Consolidation Super File Definitions 
  // ###########################################################################   	
  EXPORT FILE_BASE_CONSOLIDATION_ECRASH_SF := BASE_ECRASH_PREFIX + '::QA::' + SUFFIX_NAME_CONSOLIDATION_ECRASH;	
  EXPORT FILE_BASE_CONSOLIDATION_PR_SF := BASE_ECRASH_PREFIX + '::QA::' + SUFFIX_NAME_CONSOLIDATION_PR;	
	
  // ###########################################################################
  //                  Ecrash Spray Dataset Definitions
  // ###########################################################################	
  // EXPORT DS_SPRAY_INCIDENT := DATASET(SPRAY_INCIDENT_BASE_FILE, Layouts_Ecrash.INCIDENT_INPUT, 
                                      // CSV(SEPARATOR(Constants.FieldSeparator), TERMINATOR(Constants.RecordTerminator),
                                      // QUOTE(Constants.DefaultQuote), NOTRIM));
  // EXPORT DS_SPRAY_PERSON := DATASET(SPRAY_PERSON_BASE_FILE, Layouts_Ecrash.PERSON_INPUT, 
                                    // CSV(SEPARATOR(Constants.FieldSeparator), TERMINATOR(Constants.RecordTerminator),
                                    // QUOTE(Constants.DefaultQuote), NOTRIM));
  // EXPORT DS_SPRAY_VEHICLE := DATASET(SPRAY_VEHICLE_BASE_FILE, Layouts_Ecrash.VEHICLE_INPUT, 
                                     // CSV(SEPARATOR(Constants.FieldSeparator), TERMINATOR(Constants.RecordTerminator),
                                     // QUOTE(Constants.DefaultQuote), NOTRIM));
  // EXPORT DS_SPRAY_CITATION := DATASET(SPRAY_CITATION_BASE_FILE, Layouts_Ecrash.CITATION_INPUT, 
                                      // CSV(SEPARATOR(Constants.FieldSeparator), TERMINATOR(Constants.RecordTerminator),
                                      // QUOTE(Constants.DefaultQuote), NOTRIM), OPT); 
  // EXPORT DS_SPRAY_COMMERCIAL := DATASET(SPRAY_COMMERCIAL_BASE_FILE, Layouts_Ecrash.COMMERCIAL_INPUT, 
                                        // CSV(SEPARATOR(Constants.FieldSeparator), TERMINATOR(Constants.RecordTerminator),
                                        // QUOTE(Constants.DefaultQuote), NOTRIM), OPT);																														
  // EXPORT DS_SPRAY_PROPERTY_DAMAGE := DATASET(SPRAY_PROPERTY_DAMAGE_BASE_FILE, Layouts_Ecrash.PROPERTY_DAMAGE_INPUT, 
                                             // CSV(SEPARATOR(Constants.FieldSeparator), TERMINATOR(Constants.RecordTerminator),
                                             // QUOTE(Constants.DefaultQuote), NOTRIM), OPT);
  // EXPORT DS_SPRAY_DOCUMENT := DATASET(SPRAY_DOCUMENT_BASE_FILE, Layouts_Ecrash.DOCUMENT_INPUT, 
                                      // CSV(SEPARATOR(Constants.FieldSeparator), TERMINATOR(Constants.RecordTerminator),
                                      // QUOTE(Constants.DefaultQuote), NOTRIM), OPT);
  // EXPORT DS_SPRAY_AGENCY := DATASET(SPRAY_AGENCY_BASE_FILE, Layouts_Ecrash.AGENCY_INPUT, 
                                    // CSV(SEPARATOR(Constants.AgencyFieldSeparator), TERMINATOR(Constants.RecordTerminator),
                                    // QUOTE(Constants.DefaultQuote), NOTRIM), OPT);
  // EXPORT DS_SPRAY_BILLING_AGENCY := DATASET(SPRAY_BILLING_AGENCY_BASE_FILE, Layouts_Ecrash.BILLING_AGENCY_INPUT, 
                                            // CSV(SEPARATOR(Constants.FieldSeparator), TERMINATOR(Constants.RecordTerminator),
                                            // QUOTE(Constants.DefaultQuote), NOTRIM), OPT);

  //###############################################################################
  //						Ecrash ALL File Dataset Definitions 
  //###############################################################################		
  // EXPORT DS_ALL_INCIDENT := DATASET(FILE_ALL_INCIDENT_SF, Layouts_Ecrash.INCIDENT, THOR, OPT);
  // EXPORT DS_ALL_PERSON := DATASET(FILE_ALL_PERSON_SF, Layouts_Ecrash.PERSON, THOR, OPT);
  // EXPORT DS_ALL_VEHICLE := DATASET(FILE_ALL_VEHICLE_SF, Layouts_Ecrash.VEHICLE, THOR, OPT);
  // EXPORT DS_ALL_CITATION := DATASET(FILE_ALL_CITATION_SF, Layouts_Ecrash.CITATION, THOR, OPT);
  // EXPORT DS_ALL_COMMERCIAL := DATASET(FILE_ALL_COMMERCIAL_SF, Layouts_Ecrash.COMMERCIAL, THOR, OPT);
  // EXPORT DS_ALL_PROPERTY_DAMAGE := DATASET(FILE_ALL_PROPERTY_DAMAGE_SF, Layouts_Ecrash.PROPERTY_DAMAGE, THOR, OPT);
  // EXPORT DS_ALL_DOCUMENT := DATASET(FILE_ALL_DOCUMENT_SF, Layouts_Ecrash.DOCUMENT, THOR, OPT);
  // EXPORT DS_ALL_AGENCY := DATASET(FILE_ALL_AGENCY_SF, Layouts_Ecrash.AGENCY, THOR, OPT);
  // EXPORT DS_ALL_BILLING_AGENCY := DATASET(FILE_ALL_BILLING_AGENCY_SF, Layouts_Ecrash.BILLING_AGENCY, THOR, OPT);

  //###############################################################################
  //						Ecrash FULL File Dataset Definitions 
  //###############################################################################		
  // EXPORT DS_FULL_INCIDENT := DATASET(FILE_FULL_INCIDENT_SF, Layouts_Ecrash.INCIDENT, THOR, OPT);
  // EXPORT DS_FULL_PERSON := DATASET(FILE_FULL_PERSON_SF, Layouts_Ecrash.PERSON, THOR, OPT);
  // EXPORT DS_FULL_VEHICLE := DATASET(FILE_FULL_VEHICLE_SF, Layouts_Ecrash.VEHICLE, THOR, OPT);
  // EXPORT DS_FULL_CITATION := DATASET(FILE_FULL_CITATION_SF, Layouts_Ecrash.CITATION, THOR, OPT);
  // EXPORT DS_FULL_COMMERCIAL := DATASET(FILE_FULL_COMMERCIAL_SF, Layouts_Ecrash.COMMERCIAL, THOR, OPT);
  // EXPORT DS_FULL_PROPERTY_DAMAGE := DATASET(FILE_FULL_PROPERTY_DAMAGE_SF, Layouts_Ecrash.PROPERTY_DAMAGE, THOR, OPT);
  // EXPORT DS_FULL_DOCUMENT := DATASET(FILE_FULL_DOCUMENT_SF, Layouts_Ecrash.DOCUMENT, THOR, OPT);
  // EXPORT DS_FULL_AGENCY := DATASET(FILE_FULL_AGENCY_SF, Layouts_Ecrash.AGENCY, THOR, OPT);
  // EXPORT DS_FULL_BILLING_AGENCY := DATASET(FILE_FULL_BILLING_AGENCY_SF, Layouts_Ecrash.BILLING_AGENCY, THOR, OPT);

  //###############################################################################
  //						Ecrash INC File Dataset Definitions 
  //###############################################################################		
  // EXPORT DS_INC_INCIDENT := DATASET(FILE_INC_INCIDENT_SF, Layouts_Ecrash.INCIDENT, THOR, OPT);
  // EXPORT DS_INC_PERSON := DATASET(FILE_INC_PERSON_SF, Layouts_Ecrash.PERSON, THOR, OPT);
  // EXPORT DS_INC_VEHICLE := DATASET(FILE_INC_VEHICLE_SF, Layouts_Ecrash.VEHICLE, THOR, OPT);
  // EXPORT DS_INC_CITATION := DATASET(FILE_INC_CITATION_SF, Layouts_Ecrash.CITATION, THOR, OPT);
  // EXPORT DS_INC_COMMERCIAL := DATASET(FILE_INC_COMMERCIAL_SF, Layouts_Ecrash.COMMERCIAL, THOR, OPT);
  // EXPORT DS_INC_PROPERTY_DAMAGE := DATASET(FILE_INC_PROPERTY_DAMAGE_SF, Layouts_Ecrash.PROPERTY_DAMAGE, THOR, OPT);
  // EXPORT DS_INC_DOCUMENT := DATASET(FILE_INC_DOCUMENT_SF, Layouts_Ecrash.DOCUMENT, THOR, OPT);
  // EXPORT DS_INC_AGENCY := DATASET(FILE_INC_AGENCY_SF, Layouts_Ecrash.AGENCY, THOR, OPT);
  // EXPORT DS_INC_BILLING_AGENCY := DATASET(FILE_INC_BILLING_AGENCY_SF, Layouts_Ecrash.BILLING_AGENCY, THOR, OPT);			
  
  // ###########################################################################
  //               Ecrash Base Files Dataset Definitions  
  // ###########################################################################	
  // EXPORT DS_BASE_INCIDENT := DATASET(FILE_BASE_INCIDENT_SF, Layouts_Ecrash.INCIDENT, THOR, OPT);
  // EXPORT DS_BASE_PERSON := DATASET(FILE_BASE_PERSON_SF, Layouts_Ecrash.PERSON, THOR, OPT);	
  // EXPORT DS_BASE_VEHICLE := DATASET(FILE_BASE_VEHICLE_SF, Layouts_Ecrash.VEHICLE, THOR, OPT);
  // EXPORT DS_BASE_CITATION := DATASET(FILE_BASE_CITATION_SF, Layouts_Ecrash.CITATION, THOR, OPT);
  // EXPORT DS_BASE_COMMERCIAL := DATASET(FILE_BASE_COMMERCIAL_SF, Layouts_Ecrash.COMMERCIAL, THOR, OPT);
  // EXPORT DS_BASE_PROPERTY_DAMAGE := DATASET(FILE_BASE_PROPERTY_DAMAGE_SF, Layouts_Ecrash.PROPERTY_DAMAGE, THOR, OPT);
  // EXPORT DS_BASE_DOCUMENT := DATASET(FILE_BASE_DOCUMENT_SF, Layouts_Ecrash.DOCUMENT, THOR, OPT);
  // EXPORT DS_BASE_AGENCY := DATASET(FILE_BASE_AGENCY_SF, Layouts_Ecrash.AGENCY, THOR, OPT);	
  // EXPORT DS_BASE_BILLING_AGENCY := DATASET(FILE_BASE_BILLING_AGENCY_SF, Layouts_Ecrash.BILLING_AGENCY, THOR, OPT);
  
  // ###########################################################################
  //               Ecrash Combined BaseFiles Dataset Definitions
  // ########################################################################### 	
  // EXPORT DS_BASE_ECRASH := DATASET(FILE_BASE_ECRASH_SF, Layouts_Ecrash.ECRASH_BASE, THOR, OPT);	
  // EXPORT DS_BASE_SUPPLEMENTAL := DATASET(FILE_BASE_SUPPLEMENTAL_SF, Layouts_Ecrash.SUPPLEMENTAL_BASE, THOR, OPT);
  
  // ###########################################################################
  //      Ecrash Combined BaseFiles Dataset Definitions for Insurance Builds
  // ########################################################################### 	
  // EXPORT DS_BASE_AGENCY_COMBINED := DATASET(FILE_BASE_AGENCY_COMBINED_SF, Layouts_Ecrash.AGENCY_COMBINED, THOR, OPT);	
  // EXPORT DS_BASE_INCIDENTS_EXTRACT := DATASET(FILE_BASE_INCIDENTS_EXTRACT_SF, Layouts_Ecrash.INCIDENTS_EXTRACT, THOR, OPT);
  // EXPORT DS_BASE_INSECRASHSLIM := DATASET(FILE_BASE_INSECRASHSLIM_SF, Layout_InseCrashSlim, THOR, OPT);
  // EXPORT DS_BASE_CRU_ACCIDENTS := DATASET(FILE_BASE_CRU_ACCIDENTS_SF, Layout_eCrash.Accidents_Alpha, THOR, OPT);
  
  // ###########################################################################
  //               Ecrash SUPPRESS & DELETES Dataset Definitions
  // ###########################################################################  	
  // EXPORT DS_BASE_SUPPRESS_INCIDENTS := DATASET(FILE_BASE_SUPPRESS_INCIDENTS_SF, Layouts_Ecrash.SUPPRESS_INCIDENTS, THOR, OPT);	
  // EXPORT DS_BASE_SUPPRESS_REPORT_ID := DATASET(FILE_BASE_SUPPRESS_REPORT_ID_SF, Layouts_Ecrash.SUPPRESS_REPORT_ID, THOR, OPT);	
  // EXPORT DS_BASE_SUPPRESS_CASE_IDENTIFIER := DATASET(FILE_BASE_SUPPRESS_CASE_IDENTIFIER_SF, Layouts_Ecrash.SUPPRESS_CASE_IDENTIFIER, THOR, OPT);
  // EXPORT DS_BASE_ECRASH_DELETES := DATASET(FILE_BASE_ECRASH_DELETES_SF, Layouts_Ecrash.ECRASH_DELETES, THOR, OPT);
  
  // ###########################################################################
  // Accidents Consolidation BaseFiles Dataset Definitions for eCrash Keys & eCrash PR Keys
  // ###########################################################################   	
  EXPORT DS_BASE_CONSOLIDATION_ECRASH := DATASET(FILE_BASE_CONSOLIDATION_ECRASH_SF, Layout_eCrash.Consolidation, THOR, OPT);	
  EXPORT DS_BASE_CONSOLIDATION_PR := DATASET(FILE_BASE_CONSOLIDATION_PR_SF, Layout_eCrash.Consolidation, THOR, OPT);
 
 	//Existing
//***********************************************************************
//                 	EcrashKeys
//***********************************************************************
  EXPORT FILE_KEY_AGENCY_SF := dx.Files.FILE_KEY_AGENCY_SF;
  EXPORT FILE_KEY_ACCNBRV1_FATHER_SF := dx.Files.KEY_PREFIX + '_' + 'accnbrv1_father';
  EXPORT FILE_KEY_UNRESTRICTED_ACCNBRV1_SF := dx.Files.FILE_KEY_UNRESTRICTED_ACCNBRV1_SF;
  EXPORT FILE_KEY_PHOTO_ID_SF := dx.Files.FILE_KEY_PHOTO_ID_SF;
  EXPORT FILE_KEY_DOL_SF := dx.Files.FILE_KEY_DOL_SF;
  EXPORT FILE_KEY_LINKIDS_SF := dx.Files.FILE_KEY_LINKIDS_SF;
  EXPORT FILE_KEY_DELTA_DATE_SF := dx.Files.FILE_KEY_DELTA_DATE_SF;
  EXPORT FILE_KEY_REPORT_ID_SF := dx.Files.FILE_KEY_REPORT_ID_SF;
  EXPORT FILE_KEY_SUPPLEMENTAL_SF := dx.Files.FILE_KEY_SUPPLEMENTAL_SF;
	
//***********************************************************************
//                 	EcrashAnalyticKeys
//***********************************************************************
  EXPORT FILE_KEY_ANALYTICS_BY_AGENCY_ID_SF := dx.Files.FILE_KEY_ANALYTICS_BY_AGENCY_ID_SF;
  EXPORT FILE_KEY_ANALYTICS_BY_COLLISION_TYPE_SF := dx.Files.FILE_KEY_ANALYTICS_BY_COLLISION_TYPE_SF;
  EXPORT FILE_KEY_ANALYTICS_BY_DOW_SF := dx.Files.FILE_KEY_ANALYTICS_BY_DOW_SF;
  EXPORT FILE_KEY_ANALYTICS_BY_HOD_SF := dx.Files.FILE_KEY_ANALYTICS_BY_HOD_SF;
  EXPORT FILE_KEY_ANALYTICS_BY_INTER_SF := dx.Files.FILE_KEY_ANALYTICS_BY_INTER_SF;
  EXPORT FILE_KEY_ANALYTICS_BY_MOY_SF := dx.Files.FILE_KEY_ANALYTICS_BY_MOY_SF;
	
//***********************************************************************
//                 	EcrashSearchKeys
//***********************************************************************
  EXPORT FILE_KEY_DLN_NBR_DL_STATE_SF := dx.Files.FILE_KEY_DLN_NBR_DL_STATE_SF;
  EXPORT FILE_KEY_LAST_NAME_STATE_SF := dx.Files.FILE_KEY_LAST_NAME_STATE_SF;
  EXPORT FILE_KEY_LICENSE_PLATE_NBR_SF := dx.Files.FILE_KEY_LICENSE_PLATE_NBR_SF;
  EXPORT FILE_KEY_OFFICER_BADGE_NBR_STATE_SF := dx.Files.FILE_KEY_OFFICER_BADGE_NBR_STATE_SF;
  EXPORT FILE_KEY_PREFNAME_STATE_SF := dx.Files.FILE_KEY_PREFNAME_STATE_SF;
  EXPORT FILE_KEY_REPORT_LINKID_SF := dx.Files.FILE_KEY_REPORT_LINKID_SF;
  EXPORT FILE_KEY_ST_AND_LOCATION_SF := dx.Files.FILE_KEY_ST_AND_LOCATION_SF;
  EXPORT FILE_KEY_VINNBR_SF := dx.Files.FILE_KEY_VINNBR_SF;
  EXPORT FILE_KEY_AGENCY_ID_SENT_DATE_STATE_SF := dx.Files.FILE_KEY_AGENCY_ID_SENT_DATE_STATE_SF;
	
END;