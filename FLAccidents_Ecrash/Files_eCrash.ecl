IMPORT dx_Ecrash;

EXPORT Files_eCrash := MODULE
                                                    
  // #################################################################################
  //                  Ecrash Prefix
  // #################################################################################
  EXPORT SPRAY_ECRASH_PREFIX := Files.SPRAY_ECRASH_PREFIX;
  EXPORT BASE_ECRASH_PREFIX := Files.BASE_ECRASH_PREFIX;
  EXPORT ORBIT_ECRASH_PREFIX := Files.ORBIT_ECRASH_PREFIX;
	
  // #################################################################################
  //             Ecrash Suffixes for Combined Base Datasets 
  // #################################################################################
  EXPORT SUFFIX_BASE_ECRASH := 'ECRASH';    
  EXPORT SUFFIX_BASE_ClaimsClarity := 'ClaimsClarity';	
  EXPORT SUFFIX_BASE_SUPPLEMENTAL := 'SUPPLEMENTAL';	
  EXPORT SUFFIX_BASE_DOCUMENT := 'DOCUMENT';	
	EXPORT SUFFIX_BASE_CRUVehicleIncidents := 'CRUVehicleIncidents';
	
  // #################################################################################
  //             Ecrash Suffixes for Accidents Consolidation Base Files
  // #################################################################################
  EXPORT SUFFIX_CONSOLIDATION_ECRASH := 'CONSOLIDATION_ECRASH';
  EXPORT SUFFIX_CONSOLIDATION_PR := 'CONSOLIDATION_PR';
  EXPORT SUFFIX_CONSOLIDATION_CRU := 'CONSOLIDATION_CRU';
  EXPORT SUFFIX_CONSOLIDATION_MBSAgency := 'CONSOLIDATION_MBSAgency';		
  																											
  // ###########################################################################
  //             Ecrash Combined BaseFiles Super File Definitions 
  // ###########################################################################	 	
  EXPORT FILE_BASE_ECRASH_SF := BASE_ECRASH_PREFIX + '::QA::' + SUFFIX_BASE_ECRASH;	
  EXPORT FILE_BASE_ClaimsClarity_SF := BASE_ECRASH_PREFIX + '::QA::' + SUFFIX_BASE_ClaimsClarity;	
	EXPORT FILE_BASE_SUPPLEMENTAL_SF := BASE_ECRASH_PREFIX + '::QA::' + SUFFIX_BASE_SUPPLEMENTAL;
  EXPORT FILE_BASE_DOCUMENT_SF := BASE_ECRASH_PREFIX + '::QA::' + SUFFIX_BASE_DOCUMENT;
  EXPORT FILE_BASE_CRUVehicleIncidents_SF := BASE_ECRASH_PREFIX + '::QA::' + SUFFIX_BASE_CRUVehicleIncidents;
  
  // ###########################################################################
  //             Ecrash Accidents Consolidation Super File Definitions 
  // ###########################################################################   	
  EXPORT FILE_BASE_CONSOLIDATION_ECRASH_SF := BASE_ECRASH_PREFIX + '::QA::' + SUFFIX_CONSOLIDATION_ECRASH;	
  EXPORT FILE_BASE_CONSOLIDATION_PR_SF := BASE_ECRASH_PREFIX + '::QA::' + SUFFIX_CONSOLIDATION_PR;	
  EXPORT FILE_BASE_CONSOLIDATION_CRU_SF := BASE_ECRASH_PREFIX + '::QA::' + SUFFIX_CONSOLIDATION_CRU;	
  EXPORT FILE_BASE_CONSOLIDATION_MBSAgency_SF := BASE_ECRASH_PREFIX + '::QA::' + SUFFIX_CONSOLIDATION_MBSAgency;
  
  // ###########################################################################
  //               Ecrash Combined BaseFiles Dataset Definitions
  // ########################################################################### 	
  EXPORT DS_BASE_ECRASH := DATASET(FILE_BASE_ECRASH_SF, Layout_Basefile, THOR);
  EXPORT DS_BASE_ClaimsClarity := DATASET(FILE_BASE_ClaimsClarity_SF, Layout_InseCrashSlim, THOR);	
  EXPORT DS_BASE_SUPPLEMENTAL := DATASET(FILE_BASE_SUPPLEMENTAL_SF, Layouts.ReportVersion, THOR);
  EXPORT DS_BASE_DOCUMENT := DATASET(FILE_BASE_DOCUMENT_SF, Layouts.PhotoLayout, THOR);
	EXPORT DS_BASE_CRUVehicleIncidents := DATASET(FILE_BASE_CRUVehicleIncidents_SF, Layout_VehIncidents.SlimIncidents, THOR);
  
  // ###########################################################################
  // Accidents Consolidation BaseFiles Dataset Definitions for 
	// eCrash Keys, eCrash PR Keys & CRU Keys
  // ###########################################################################   	
  EXPORT DS_BASE_CONSOLIDATION_ECRASH := DATASET(FILE_BASE_CONSOLIDATION_ECRASH_SF, Layout_eCrash.Consolidation, THOR);	
  EXPORT DS_BASE_CONSOLIDATION_PR := DATASET(FILE_BASE_CONSOLIDATION_PR_SF, Layout_eCrash.Consolidation, THOR);
  EXPORT DS_BASE_CONSOLIDATION_CRU := DATASET(FILE_BASE_CONSOLIDATION_CRU_SF, Layout_eCrash.Accidents_Alpha, THOR);
  EXPORT DS_BASE_CONSOLIDATION_MBSAgency := DATASET(FILE_BASE_CONSOLIDATION_MBSAgency_SF, Layouts.agency_cmbnd, THOR);		
  																											
  // ###########################################################################
  //             Ecrash Combined BaseFiles Super File Father Definitions 
  // ###########################################################################	 	
  EXPORT FILE_BASE_ECRASH_FATHER := BASE_ECRASH_PREFIX + '::FATHER::' + SUFFIX_BASE_ECRASH;	
  EXPORT FILE_BASE_ClaimsClarity_FATHER := BASE_ECRASH_PREFIX + '::FATHER::' + SUFFIX_BASE_ClaimsClarity;	
	EXPORT FILE_BASE_SUPPLEMENTAL_FATHER := BASE_ECRASH_PREFIX + '::FATHER::' + SUFFIX_BASE_SUPPLEMENTAL;
  EXPORT FILE_BASE_DOCUMENT_FATHER := BASE_ECRASH_PREFIX + '::FATHER::' + SUFFIX_BASE_DOCUMENT;
  EXPORT FILE_BASE_CRUVehicleIncidents_FATHER := BASE_ECRASH_PREFIX + '::FATHER::' + SUFFIX_BASE_CRUVehicleIncidents;
  
  // ###########################################################################
  //             Ecrash Accidents Consolidation Super File Definitions 
  // ###########################################################################   	
  EXPORT FILE_BASE_CONSOLIDATION_ECRASH_FATHER := BASE_ECRASH_PREFIX + '::FATHER::' + SUFFIX_CONSOLIDATION_ECRASH;	
  EXPORT FILE_BASE_CONSOLIDATION_PR_FATHER := BASE_ECRASH_PREFIX + '::FATHER::' + SUFFIX_CONSOLIDATION_PR;	
  EXPORT FILE_BASE_CONSOLIDATION_CRU_FATHER := BASE_ECRASH_PREFIX + '::FATHER::' + SUFFIX_CONSOLIDATION_CRU;	
  EXPORT FILE_BASE_CONSOLIDATION_MBSAgency_FATHER := BASE_ECRASH_PREFIX + '::FATHER::' + SUFFIX_CONSOLIDATION_MBSAgency;
  
  // ###########################################################################
  //               Ecrash Combined BaseFiles Dataset Definitions
  // ########################################################################### 	
  EXPORT DS_BASE_ECRASH_FATHER := DATASET(FILE_BASE_ECRASH_FATHER, Layout_Basefile, THOR);
  EXPORT DS_BASE_ClaimsClarity_FATHER := DATASET(FILE_BASE_ClaimsClarity_FATHER, Layout_InseCrashSlim, THOR);	
  EXPORT DS_BASE_SUPPLEMENTAL_FATHER := DATASET(FILE_BASE_SUPPLEMENTAL_FATHER, Layouts.ReportVersion, THOR);
  EXPORT DS_BASE_DOCUMENT_FATHER := DATASET(FILE_BASE_DOCUMENT_FATHER, Layouts.PhotoLayout, THOR);
	EXPORT DS_BASE_CRUVehicleIncidents_FATHER := DATASET(FILE_BASE_CRUVehicleIncidents_FATHER, Layout_VehIncidents.SlimIncidents, THOR);
  
  // ###########################################################################
  // Accidents Consolidation BaseFiles Dataset Definitions for 
	// eCrash Keys, eCrash PR Keys & CRU Keys
  // ###########################################################################   	
  EXPORT DS_BASE_CONSOLIDATION_ECRASH_FATHER := DATASET(FILE_BASE_CONSOLIDATION_ECRASH_FATHER, Layout_eCrash.Consolidation, THOR);	
  EXPORT DS_BASE_CONSOLIDATION_PR_FATHER := DATASET(FILE_BASE_CONSOLIDATION_PR_FATHER, Layout_eCrash.Consolidation, THOR);
  EXPORT DS_BASE_CONSOLIDATION_CRU_FATHER := DATASET(FILE_BASE_CONSOLIDATION_CRU_FATHER, Layout_eCrash.Accidents_Alpha, THOR);
  EXPORT DS_BASE_CONSOLIDATION_MBSAgency_FATHER := DATASET(FILE_BASE_CONSOLIDATION_MBSAgency_FATHER, Layouts.agency_cmbnd, THOR);
  
  // ###########################################################################
  //               Ecrash SUPPRESS & DELETES Dataset Definitions
  // ###########################################################################  	
  EXPORT DS_BASE_SUPPRESS_INCIDENTS := DATASET(mod_Utilities.Location + 'thor_data400::in::ecrash::suppress_tf.csv', Layouts.SuppressIncidents, CSV(HEADING(1), TERMINATOR(['\n','\r\n']), SEPARATOR(','), QUOTE('"')));
  EXPORT DS_BASE_ECRASH_DELETES := DATASET(mod_Utilities.Location +'thor_data::in::ecrash_deletes', Layouts.deletes, CSV(TERMINATOR(['\n','\r\n']), SEPARATOR(','), QUOTE('"'))); 
	
  // #################################################################################
  //                         Ecrash Suffixes for Spray Datasets 
  // #################################################################################
  // EXPORT SUFFIX_SPRAY_INCIDENT := FileNames.INCIDENT_FILE_NAME;    
  // EXPORT SUFFIX_SPRAY_PERSON := FileNames.PERSON_FILE_NAME;        
  // EXPORT SUFFIX_SPRAY_VEHICLE := FileNames.VEHICLE_FILE_NAME;        
  // EXPORT SUFFIX_SPRAY_CITATION := FileNames.CITATION_FILE_NAME;        
  // EXPORT SUFFIX_SPRAY_COMMERCIAL := FileNames.COMMERCIAL_FILE_NAME;        
  // EXPORT SUFFIX_SPRAY_PROPERTY_DAMAGE := FileNames.PROPERTY_DAMAGE_FILE_NAME;        
  // EXPORT SUFFIX_SPRAY_DOCUMENT := FileNames.DOCUMENT_FILE_NAME;        
  // EXPORT SUFFIX_SPRAY_AGENCY := FileNames.AGENCY_FILE_NAME;        
  // EXPORT SUFFIX_SPRAY_BILLING_AGENCY := FileNames.BILLING_AGENCY_FILE_NAME;
	
  // #################################################################################
  //                       Ecrash Suffixes for Base Datasets  
  // #################################################################################	
  // EXPORT SUFFIX_INCIDENT := FileNames.INCIDENT_FILE_NAME;    
  // EXPORT SUFFIX_PERSON := FileNames.PERSON_FILE_NAME;        
  // EXPORT SUFFIX_VEHICLE := FileNames.VEHICLE_FILE_NAME;        
  // EXPORT SUFFIX_CITATION := FileNames.CITATION_FILE_NAME;        
  // EXPORT SUFFIX_COMMERCIAL := FileNames.COMMERCIAL_FILE_NAME;        
  // EXPORT SUFFIX_PROPERTY_DAMAGE := FileNames.PROPERTY_DAMAGE_FILE_NAME;        
  // EXPORT SUFFIX_DOCUMENT := FileNames.DOCUMENT_FILE_NAME;        
  // EXPORT SUFFIX_AGENCY := FileNames.AGENCY_FILE_NAME;        
  // EXPORT SUFFIX_BILLING_AGENCY := FileNames.BILLING_AGENCY_FILE_NAME;
	
  // #################################################################################
  //             Ecrash Suffixes for SUPPRESS & DELETES Datasets
  // #################################################################################	
  // EXPORT SUFFIX_SUPPRESS_INCIDENTS := 'SUPPRESS_INCIDENTS';
  // EXPORT SUFFIX_SUPPRESS_REPORT_ID := 'SUPPRESS_REPORT_ID';
  // EXPORT SUFFIX_SUPPRESS_CASE_IDENTIFIER := 'SUPPRESS_CASE_IDENTIFIER';
  // EXPORT SUFFIX_ECRASH_DELETES := 'ECRASH_DELETES';
	
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
  // EXPORT FILE_ALL_INCIDENT_SF := BASE_ECRASH_PREFIX + '::ALL::' + SUFFIX_INCIDENT;
  // EXPORT FILE_ALL_PERSON_SF := BASE_ECRASH_PREFIX + '::ALL::' + SUFFIX_PERSON;
  // EXPORT FILE_ALL_VEHICLE_SF := BASE_ECRASH_PREFIX + '::ALL::' + SUFFIX_VEHICLE;
  // EXPORT FILE_ALL_CITATION_SF := BASE_ECRASH_PREFIX + '::ALL::' + SUFFIX_CITATION;
  // EXPORT FILE_ALL_COMMERCIAL_SF := BASE_ECRASH_PREFIX + '::ALL::' + SUFFIX_COMMERCIAL;
  // EXPORT FILE_ALL_PROPERTY_DAMAGE_SF := BASE_ECRASH_PREFIX + '::ALL::' + SUFFIX_PROPERTY_DAMAGE;
  // EXPORT FILE_ALL_DOCUMENT_SF := BASE_ECRASH_PREFIX + '::ALL::' + SUFFIX_DOCUMENT;
  // EXPORT FILE_ALL_AGENCY_SF := BASE_ECRASH_PREFIX + '::ALL::' + SUFFIX_AGENCY;
  // EXPORT FILE_ALL_BILLING_AGENCY_SF := BASE_ECRASH_PREFIX + '::ALL::' + SUFFIX_BILLING_AGENCY;
	
  // ###########################################################################
  //						Ecrash FULL Super File Definitions
  //###############################################################################    
  // EXPORT FILE_FULL_INCIDENT_SF := BASE_ECRASH_PREFIX + '::FULL::' + SUFFIX_INCIDENT;
  // EXPORT FILE_FULL_PERSON_SF := BASE_ECRASH_PREFIX + '::FULL::' + SUFFIX_PERSON;
  // EXPORT FILE_FULL_VEHICLE_SF := BASE_ECRASH_PREFIX + '::FULL::' + SUFFIX_VEHICLE;
  // EXPORT FILE_FULL_CITATION_SF := BASE_ECRASH_PREFIX + '::FULL::' + SUFFIX_CITATION;
  // EXPORT FILE_FULL_COMMERCIAL_SF := BASE_ECRASH_PREFIX + '::FULL::' + SUFFIX_COMMERCIAL;
  // EXPORT FILE_FULL_PROPERTY_DAMAGE_SF := BASE_ECRASH_PREFIX + '::FULL::' + SUFFIX_PROPERTY_DAMAGE;
  // EXPORT FILE_FULL_DOCUMENT_SF := BASE_ECRASH_PREFIX + '::FULL::' + SUFFIX_DOCUMENT;
  // EXPORT FILE_FULL_AGENCY_SF := BASE_ECRASH_PREFIX + '::FULL::' + SUFFIX_AGENCY;
  // EXPORT FILE_FULL_BILLING_AGENCY_SF := BASE_ECRASH_PREFIX + '::FULL::' + SUFFIX_BILLING_AGENCY;
	
  //###############################################################################
  //						Ecrash INC Super File Definitions 
  //###############################################################################    
  // EXPORT FILE_INC_INCIDENT_SF := BASE_ECRASH_PREFIX + '::INC::' + SUFFIX_INCIDENT;
  // EXPORT FILE_INC_PERSON_SF := BASE_ECRASH_PREFIX + '::INC::' + SUFFIX_PERSON;
  // EXPORT FILE_INC_VEHICLE_SF := BASE_ECRASH_PREFIX + '::INC::' + SUFFIX_VEHICLE;
  // EXPORT FILE_INC_CITATION_SF := BASE_ECRASH_PREFIX + '::INC::' + SUFFIX_CITATION;
  // EXPORT FILE_INC_COMMERCIAL_SF := BASE_ECRASH_PREFIX + '::INC::' + SUFFIX_COMMERCIAL;
  // EXPORT FILE_INC_PROPERTY_DAMAGE_SF := BASE_ECRASH_PREFIX + '::INC::' + SUFFIX_PROPERTY_DAMAGE;
  // EXPORT FILE_INC_DOCUMENT_SF := BASE_ECRASH_PREFIX + '::INC::' + SUFFIX_DOCUMENT;
  // EXPORT FILE_INC_AGENCY_SF := BASE_ECRASH_PREFIX + '::INC::' + SUFFIX_AGENCY;
  // EXPORT FILE_INC_BILLING_AGENCY_SF := BASE_ECRASH_PREFIX + '::INC::' + SUFFIX_BILLING_AGENCY;
  																											
  // ###########################################################################
  //                Ecrash BaseFiles Super File Definitions 
  // ###########################################################################	
  // EXPORT FILE_BASE_INCIDENT_SF := BASE_ECRASH_PREFIX + '::QA::' + SUFFIX_INCIDENT;	
  // EXPORT FILE_BASE_PERSON_SF := BASE_ECRASH_PREFIX + '::QA::' + SUFFIX_PERSON;	
  // EXPORT FILE_BASE_VEHICLE_SF := BASE_ECRASH_PREFIX + '::QA::' + SUFFIX_VEHICLE;			
  // EXPORT FILE_BASE_CITATION_SF := BASE_ECRASH_PREFIX + '::QA::' + SUFFIX_CITATION;
  // EXPORT FILE_BASE_COMMERCIAL_SF := BASE_ECRASH_PREFIX + '::QA::' + SUFFIX_COMMERCIAL;	
  // EXPORT FILE_BASE_PROPERTY_DAMAGE_SF := BASE_ECRASH_PREFIX + '::QA::' + SUFFIX_PROPERTY_DAMAGE;
  // EXPORT FILE_BASE_DOCUMENT_SF := BASE_ECRASH_PREFIX + '::QA::' + SUFFIX_DOCUMENT;
  // EXPORT FILE_BASE_AGENCY_SF := BASE_ECRASH_PREFIX + '::QA::' + SUFFIX_AGENCY;	
  // EXPORT FILE_BASE_BILLING_AGENCY_SF := BASE_ECRASH_PREFIX + '::QA::' + SUFFIX_BILLING_AGENCY;		
  
  // ###########################################################################
  //             Ecrash SUPPRESS & DELETES  Super File Definitions 
  // ###########################################################################  	
  // EXPORT FILE_BASE_SUPPRESS_INCIDENTS_SF := BASE_ECRASH_PREFIX + '::QA::' + SUFFIX_SUPPRESS_INCIDENTS;	
  // EXPORT FILE_BASE_SUPPRESS_REPORT_ID_SF := BASE_ECRASH_PREFIX + '::QA::' + SUFFIX_SUPPRESS_REPORT_ID;	
  // EXPORT FILE_BASE_SUPPRESS_CASE_IDENTIFIER_SF := BASE_ECRASH_PREFIX + '::QA::' + SUFFIX_SUPPRESS_CASE_IDENTIFIER;	
  // EXPORT FILE_BASE_ECRASH_DELETES_SF := BASE_ECRASH_PREFIX + '::QA::' + SUFFIX_ECRASH_DELETES;	
	
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
  // EXPORT DS_ALL_INCIDENT := DATASET(FILE_ALL_INCIDENT_SF, Layouts_Ecrash.INCIDENT, THOR);
  // EXPORT DS_ALL_PERSON := DATASET(FILE_ALL_PERSON_SF, Layouts_Ecrash.PERSON, THOR);
  // EXPORT DS_ALL_VEHICLE := DATASET(FILE_ALL_VEHICLE_SF, Layouts_Ecrash.VEHICLE, THOR);
  // EXPORT DS_ALL_CITATION := DATASET(FILE_ALL_CITATION_SF, Layouts_Ecrash.CITATION, THOR);
  // EXPORT DS_ALL_COMMERCIAL := DATASET(FILE_ALL_COMMERCIAL_SF, Layouts_Ecrash.COMMERCIAL, THOR);
  // EXPORT DS_ALL_PROPERTY_DAMAGE := DATASET(FILE_ALL_PROPERTY_DAMAGE_SF, Layouts_Ecrash.PROPERTY_DAMAGE, THOR);
  // EXPORT DS_ALL_DOCUMENT := DATASET(FILE_ALL_DOCUMENT_SF, Layouts_Ecrash.DOCUMENT, THOR);
  // EXPORT DS_ALL_AGENCY := DATASET(FILE_ALL_AGENCY_SF, Layouts_Ecrash.AGENCY, THOR);
  // EXPORT DS_ALL_BILLING_AGENCY := DATASET(FILE_ALL_BILLING_AGENCY_SF, Layouts_Ecrash.BILLING_AGENCY, THOR);

  //###############################################################################
  //						Ecrash FULL File Dataset Definitions 
  //###############################################################################		
  // EXPORT DS_FULL_INCIDENT := DATASET(FILE_FULL_INCIDENT_SF, Layouts_Ecrash.INCIDENT, THOR);
  // EXPORT DS_FULL_PERSON := DATASET(FILE_FULL_PERSON_SF, Layouts_Ecrash.PERSON, THOR);
  // EXPORT DS_FULL_VEHICLE := DATASET(FILE_FULL_VEHICLE_SF, Layouts_Ecrash.VEHICLE, THOR);
  // EXPORT DS_FULL_CITATION := DATASET(FILE_FULL_CITATION_SF, Layouts_Ecrash.CITATION, THOR);
  // EXPORT DS_FULL_COMMERCIAL := DATASET(FILE_FULL_COMMERCIAL_SF, Layouts_Ecrash.COMMERCIAL, THOR);
  // EXPORT DS_FULL_PROPERTY_DAMAGE := DATASET(FILE_FULL_PROPERTY_DAMAGE_SF, Layouts_Ecrash.PROPERTY_DAMAGE, THOR);
  // EXPORT DS_FULL_DOCUMENT := DATASET(FILE_FULL_DOCUMENT_SF, Layouts_Ecrash.DOCUMENT, THOR);
  // EXPORT DS_FULL_AGENCY := DATASET(FILE_FULL_AGENCY_SF, Layouts_Ecrash.AGENCY, THOR);
  // EXPORT DS_FULL_BILLING_AGENCY := DATASET(FILE_FULL_BILLING_AGENCY_SF, Layouts_Ecrash.BILLING_AGENCY, THOR);

  //###############################################################################
  //						Ecrash INC File Dataset Definitions 
  //###############################################################################		
  // EXPORT DS_INC_INCIDENT := DATASET(FILE_INC_INCIDENT_SF, Layouts_Ecrash.INCIDENT, THOR);
  // EXPORT DS_INC_PERSON := DATASET(FILE_INC_PERSON_SF, Layouts_Ecrash.PERSON, THOR);
  // EXPORT DS_INC_VEHICLE := DATASET(FILE_INC_VEHICLE_SF, Layouts_Ecrash.VEHICLE, THOR);
  // EXPORT DS_INC_CITATION := DATASET(FILE_INC_CITATION_SF, Layouts_Ecrash.CITATION, THOR);
  // EXPORT DS_INC_COMMERCIAL := DATASET(FILE_INC_COMMERCIAL_SF, Layouts_Ecrash.COMMERCIAL, THOR);
  // EXPORT DS_INC_PROPERTY_DAMAGE := DATASET(FILE_INC_PROPERTY_DAMAGE_SF, Layouts_Ecrash.PROPERTY_DAMAGE, THOR);
  // EXPORT DS_INC_DOCUMENT := DATASET(FILE_INC_DOCUMENT_SF, Layouts_Ecrash.DOCUMENT, THOR);
  // EXPORT DS_INC_AGENCY := DATASET(FILE_INC_AGENCY_SF, Layouts_Ecrash.AGENCY, THOR);
  // EXPORT DS_INC_BILLING_AGENCY := DATASET(FILE_INC_BILLING_AGENCY_SF, Layouts_Ecrash.BILLING_AGENCY, THOR);			
  
  // ###########################################################################
  //               Ecrash Base Files Dataset Definitions  
  // ###########################################################################	
  // EXPORT DS_BASE_INCIDENT := DATASET(FILE_BASE_INCIDENT_SF, Layouts_Ecrash.INCIDENT, THOR);
  // EXPORT DS_BASE_PERSON := DATASET(FILE_BASE_PERSON_SF, Layouts_Ecrash.PERSON, THOR);	
  // EXPORT DS_BASE_VEHICLE := DATASET(FILE_BASE_VEHICLE_SF, Layouts_Ecrash.VEHICLE, THOR);
  // EXPORT DS_BASE_CITATION := DATASET(FILE_BASE_CITATION_SF, Layouts_Ecrash.CITATION, THOR);
  // EXPORT DS_BASE_COMMERCIAL := DATASET(FILE_BASE_COMMERCIAL_SF, Layouts_Ecrash.COMMERCIAL, THOR);
  // EXPORT DS_BASE_PROPERTY_DAMAGE := DATASET(FILE_BASE_PROPERTY_DAMAGE_SF, Layouts_Ecrash.PROPERTY_DAMAGE, THOR);
  // EXPORT DS_BASE_DOCUMENT := DATASET(FILE_BASE_DOCUMENT_SF, Layouts_Ecrash.DOCUMENT, THOR);
  // EXPORT DS_BASE_AGENCY := DATASET(FILE_BASE_AGENCY_SF, Layouts_Ecrash.AGENCY, THOR);	
  // EXPORT DS_BASE_BILLING_AGENCY := DATASET(FILE_BASE_BILLING_AGENCY_SF, Layouts_Ecrash.BILLING_AGENCY, THOR);
  
  // ###########################################################################
  //               Ecrash SUPPRESS & DELETES Dataset Definitions
  // ###########################################################################  	
  // EXPORT DS_BASE_SUPPRESS_INCIDENTS := DATASET(FILE_BASE_SUPPRESS_INCIDENTS_SF, Layouts_Ecrash.SUPPRESS_INCIDENTS, THOR);	
  // EXPORT DS_BASE_SUPPRESS_REPORT_ID := DATASET(FILE_BASE_SUPPRESS_REPORT_ID_SF, Layouts_Ecrash.SUPPRESS_REPORT_ID, THOR);	
  // EXPORT DS_BASE_SUPPRESS_CASE_IDENTIFIER := DATASET(FILE_BASE_SUPPRESS_CASE_IDENTIFIER_SF, Layouts_Ecrash.SUPPRESS_CASE_IDENTIFIER, THOR);
  // EXPORT DS_BASE_ECRASH_DELETES := DATASET(FILE_BASE_ECRASH_DELETES_SF, Layouts_Ecrash.ECRASH_DELETES, THOR);

 	//Existing
//***********************************************************************
//                 	EcrashKeys
//***********************************************************************
  EXPORT FILE_KEY_AGENCY_SF := dx_Ecrash.Names.i_AGENCY_SF;
  EXPORT FILE_KEY_AGENCYSOURCE_SF := dx_Ecrash.Names.i_AGENCYSOURCE_SF;
  EXPORT FILE_KEY_ACCNBRV1_FATHER_SF := dx_Ecrash.Names.KEY_PREFIX + '_' + 'accnbrv1_father';
  EXPORT FILE_KEY_UNRESTRICTED_ACCNBRV1_SF := dx_Ecrash.Names.i_UNRESTRICTED_ACCNBRV1_SF;
  EXPORT FILE_KEY_PHOTO_ID_SF := dx_Ecrash.Names.i_PHOTO_ID_SF;
  EXPORT FILE_KEY_DOL_SF := dx_Ecrash.Names.i_DOL_SF;
  EXPORT FILE_KEY_DELTA_DATE_SF := dx_Ecrash.Names.i_DELTA_DATE_SF;
  EXPORT FILE_KEY_REPORT_ID_SF := dx_Ecrash.Names.i_REPORT_ID_SF;
  EXPORT FILE_KEY_SUPPLEMENTAL_SF := dx_Ecrash.Names.i_SUPPLEMENTAL_SF;
	
//***********************************************************************
//                 	EcrashAnalyticKeys
//***********************************************************************
  EXPORT FILE_KEY_ANALYTICS_BY_AGENCY_ID_SF := dx_Ecrash.Names.i_ANALYTICS_BY_AGENCY_ID_SF;
  EXPORT FILE_KEY_ANALYTICS_BY_COLLISION_TYPE_SF := dx_Ecrash.Names.i_ANALYTICS_BY_COLLISION_TYPE_SF;
  EXPORT FILE_KEY_ANALYTICS_BY_DOW_SF := dx_Ecrash.Names.i_ANALYTICS_BY_DOW_SF;
  EXPORT FILE_KEY_ANALYTICS_BY_HOD_SF := dx_Ecrash.Names.i_ANALYTICS_BY_HOD_SF;
  EXPORT FILE_KEY_ANALYTICS_BY_INTER_SF := dx_Ecrash.Names.i_ANALYTICS_BY_INTER_SF;
  EXPORT FILE_KEY_ANALYTICS_BY_MOY_SF := dx_Ecrash.Names.i_ANALYTICS_BY_MOY_SF;
	
//***********************************************************************
//                 	EcrashSearchKeys
//***********************************************************************
  EXPORT FILE_KEY_DLN_NBR_DL_STATE_SF := dx_Ecrash.Names.i_DLN_NBR_DL_STATE_SF;
  EXPORT FILE_KEY_LAST_NAME_STATE_SF := dx_Ecrash.Names.i_LAST_NAME_STATE_SF;
  EXPORT FILE_KEY_LICENSE_PLATE_NBR_SF := dx_Ecrash.Names.i_LICENSE_PLATE_NBR_SF;
  EXPORT FILE_KEY_OFFICER_BADGE_NBR_STATE_SF := dx_Ecrash.Names.i_OFFICER_BADGE_NBR_STATE_SF;
  EXPORT FILE_KEY_PREFNAME_STATE_SF := dx_Ecrash.Names.i_PREFNAME_STATE_SF;
  EXPORT FILE_KEY_ST_AND_LOCATION_SF := dx_Ecrash.Names.i_ST_AND_LOCATION_SF;
  EXPORT FILE_KEY_VINNBR_SF := dx_Ecrash.Names.i_VINNBR_SF;
  EXPORT FILE_KEY_AGENCY_ID_SENT_DATE_STATE_SF := dx_Ecrash.Names.i_AGENCY_ID_SENT_DATE_STATE_SF;
END;
