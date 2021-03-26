IMPORT RoxieKeyBuild, FLAccidents_Ecrash, _control, STD, Data_Services;

EXPORT fn_Create_Update_BaseFiles(STRING FileDate, STRING qInitials, STRING fInitials):= FUNCTION

  Location := IF(_control.ThisEnvironment.Name = 'Prod_Thor', '~', Data_Services.Foreign_Prod);
  CreateSF := FLAccidents_Ecrash.CreateSuperFiles;
  Layouts := FLAccidents_Ecrash.Layouts;
  Layout_InseCrashSlim := FLAccidents_Ecrash.Layout_InseCrashSlim;
  Layout_VehIncidents := FLAccidents_Ecrash.Layout_VehIncidents;
  Layout_eCrash := FLAccidents_Ecrash.Layout_eCrash;
  Infiles := FLAccidents_Ecrash.Infiles;
  Files_eCrash := FLAccidents_Ecrash.Files_eCrash;
  Layout_Basefile := FLAccidents_Ecrash.Layout_Basefile;
  qFileDate := FileDate + qInitials;
  fFileDate := FileDate + fInitials;
	
 	fn_buildNewEcrashBase(DATASET(Layout_Basefile) EcrashBaseIn, STRING BuildDate)	:= FUNCTION																										 
	  rmeCrashCaseID := EcrashBaseIn(~(TRIM(case_identifier, LEFT, RIGHT) IN FLAccidents_Ecrash.Suppress_Id AND 
	                                   report_code IN ['EA', 'TF']));																		 
	  rmeCrashRptID	:= rmeCrashCaseID(TRIM(report_id, LEFT, RIGHT) NOT IN FLAccidents_Ecrash.Suppress_report_d);
	
	  rmeCrashIncID := rmeCrashRptID(incident_id NOT IN FLAccidents_Ecrash.supress_incident_id and incident_id NOT IN SET(Files_eCrash.DS_BASE_SUPPRESS_INCIDENTS, Incident_ID));
	
	  jnIncID_Deletes	:= JOIN(rmeCrashIncID, Files_eCrash.DS_BASE_ECRASH_DELETES, 
                         TRIM(LEFT.case_identifier, LEFT, RIGHT) = TRIM(RIGHT.case_identifier, LEFT, RIGHT) AND 
												 TRIM(LEFT.State_Report_Number, LEFT, RIGHT) = TRIM(RIGHT.State_Report_Number, LEFT, RIGHT) AND 
												 TRIM(LEFT.Source_ID , LEFT, RIGHT)= TRIM(RIGHT.Source_ID , LEFT, RIGHT)AND 
												 TRIM(LEFT.Loss_State_Abbr, LEFT, RIGHT) = TRIM(RIGHT.Loss_State_Abbr, LEFT, RIGHT) AND 
												 TRIM(LEFT.Crash_Date, LEFT, RIGHT) = STD.Str.FilterOut(TRIM(RIGHT.Crash_Date, LEFT, RIGHT),'-') AND 
												 TRIM(LEFT.Agency_ID, LEFT, RIGHT) = TRIM(RIGHT.Agency_ID, LEFT, RIGHT) AND 
												 TRIM(LEFT.Work_Type_ID , LEFT, RIGHT)= TRIM(RIGHT.Work_Type_ID, LEFT, RIGHT)  , MANY LOOKUP , LEFT ONLY );
		deCrashAccidents	:= DISTRIBUTE(jnIncID_Deletes, HASH32(incident_id));
	  RoxieKeyBuild.Mac_SF_BuildProcess_V2(deCrashAccidents, Files_eCrash.BASE_ECRASH_PREFIX, Files_eCrash.SUFFIX_BASE_ECRASH, BuildDate, BuildeCrash, 3, FALSE, TRUE); 
	   
		 RETURN BuildeCrash;
	 END;
	 
//New eCrash Base	 
  eCrashBaseOld_Father := DATASET(Location + 'thor_data400::base::ecrash_Father', Layout_Basefile, THOR); 
	BuildeCrashFather := fn_buildNewEcrashBase(eCrashBaseOld_Father, fFileDate);	 
		 
  eCrashBaseOld := DATASET(Location + 'thor_data400::base::ecrash', Layout_Basefile, THOR); 
	BuildeCrash := fn_buildNewEcrashBase(eCrashBaseOld, qFileDate);

//New Supplemental Base
  SupplementalOld_Father := DATASET(Location + 'thor_data400::base::ecrash_supplemental_father', Layouts.ReportVersion, THOR);
  RoxieKeyBuild.Mac_SF_BuildProcess_V2(SupplementalOld_Father, Files_eCrash.BASE_ECRASH_PREFIX, Files_eCrash.SUFFIX_BASE_SUPPLEMENTAL, fFileDate, BuildSupplementalFather, 3, FALSE, TRUE); 
	
  SupplementalOld := DATASET(Location + 'thor_data400::base::ecrash_supplemental', Layouts.ReportVersion, THOR);
  RoxieKeyBuild.Mac_SF_BuildProcess_V2(SupplementalOld, Files_eCrash.BASE_ECRASH_PREFIX, Files_eCrash.SUFFIX_BASE_SUPPLEMENTAL, qFileDate, BuildSupplemental, 3, FALSE, TRUE);

//New Document Base 
  PhotoBaseOld := DATASET(Location + 'thor_data400::base::ecrash_documents', Layouts.PhotoLayout, THOR);
  RoxieKeyBuild.Mac_SF_BuildProcess_V2(PhotoBaseOld, Files_eCrash.BASE_ECRASH_PREFIX, Files_eCrash.SUFFIX_BASE_DOCUMENT, qFileDate, BuildDocument, 3, FALSE, TRUE); 

//ClaimsClarity Base 
  ClaimsClarityOld := DATASET(Location + 'thor_data400::base::InseCrashSlim', Layout_InseCrashSlim, THOR);
  RoxieKeyBuild.Mac_SF_BuildProcess_V2(ClaimsClarityOld, Files_eCrash.BASE_ECRASH_PREFIX, Files_eCrash.SUFFIX_BASE_ClaimsClarity, qFileDate, BuildClaimsClarity, 3, FALSE, TRUE); 

//New CRUVehicleIncidents Base 
  CRUVehicleIncidentsOld := DATASET(Location + 'thor_data400::base::ecrash_Incidents', Layout_VehIncidents.SlimIncidents, THOR);
  RoxieKeyBuild.Mac_SF_BuildProcess_V2(CRUVehicleIncidentsOld, Files_eCrash.BASE_ECRASH_PREFIX, Files_eCrash.SUFFIX_BASE_CRUVehicleIncidents, qFileDate, BuildCRUVehicleIncidents, 3, FALSE, TRUE); 

//New AgencyConsolidation Base 
  AgencyCmbdOld := DATASET(Location + 'thor_data400::base::agency_cmbnd', Layouts.agency_cmbnd, THOR);
  RoxieKeyBuild.Mac_SF_BuildProcess_V2(AgencyCmbdOld, Files_eCrash.BASE_ECRASH_PREFIX, Files_eCrash.SUFFIX_CONSOLIDATION_MBSAgency, qFileDate, BuildConsolidationMBSAgency, 3, FALSE, TRUE);

//New CRU Base 
  ConsolidationCRUOld_Father := DATASET(Location + 'thor_data400::base::accidents_alpha_father', Layout_eCrash.Accidents_Alpha, THOR);
  RoxieKeyBuild.Mac_SF_BuildProcess_V2(ConsolidationCRUOld_Father, Files_eCrash.BASE_ECRASH_PREFIX, Files_eCrash.SUFFIX_CONSOLIDATION_CRU, fFileDate, BuildConsolidationeCRUFather, 3, FALSE, TRUE);
	 
  ConsolidationCRUOld := DATASET(Location + 'thor_data400::base::accidents_alpha', Layout_eCrash.Accidents_Alpha, THOR);
  RoxieKeyBuild.Mac_SF_BuildProcess_V2(ConsolidationCRUOld, Files_eCrash.BASE_ECRASH_PREFIX, Files_eCrash.SUFFIX_CONSOLIDATION_CRU, qFileDate, BuildConsolidationeCRU, 3, FALSE, TRUE);
	
	BuildNewBase := SEQUENTIAL(
	                            CreateSF,
	                            BuildeCrashFather, 
	                            BuildeCrash, 
	                            BuildSupplementalFather, 
	                            BuildSupplemental, 
													    BuildDocument, 
													    BuildClaimsClarity,
													    BuildCRUVehicleIncidents,
													    BuildConsolidationMBSAgency,
													    BuildConsolidationeCRUFather,
													    BuildConsolidationeCRU
													    );
	RETURN BuildNewBase;
END;
