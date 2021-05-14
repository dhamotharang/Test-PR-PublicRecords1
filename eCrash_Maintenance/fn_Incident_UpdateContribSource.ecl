IMPORT STD, FLAccidents_Ecrash, Data_Services;
EXPORT fn_Incident_UpdateContribSource() := FUNCTION												
																
ds_incident := flaccidents_ecrash.infiles.incident;
ds_incident_TM := ds_incident(STD.Str.ToUpperCase(source_id) = 'TM');
ds_incident_NOT_TM := ds_incident(STD.Str.ToUpperCase(source_id) <> 'TM');

layout_incident := flaccidents_ecrash.layout_infiles.incident_new;
lay_agency := RECORD
		STRING11  Agency_ID;
	  STRING100 Agency_Name;
		STRING10  Agency_State_Abbr;
	  STRING11  Agency_ori;
	  STRING1   Allow_Open_Search;
	  STRING2   Append_Overwrite_Flag;
	  STRING1   Drivers_Exchange_Flag;   
	  STRING3   Source_ID;
	  STRING10  Orig_Source_Start_Date; 
	  UNSIGNED4  Source_Start_Date; 
	  STRING10  Orig_Source_End_Date; 
	  UNSIGNED4  Source_End_Date; 
	  STRING20  Orig_Source_Termination_Date; 	    
	  UNSIGNED4  Source_Termination_Date; 	    
	  STRING1   Source_Resale_Allowed; 
	  STRING1   Source_Auto_Renew; 
	  STRING1   Source_Allow_Sale_Of_Component_Data; 
	  STRING1   Source_Allow_Extract_Of_Vehicle_Data; 
	END; 

ds_agency := flaccidents_ecrash.Files_MBSAgency.DS_BASE_AGENCY;
uagency := DEDUP(SORT(ds_agency(Agency_ID <> ''), Agency_ID, (MAP(Source_ID = 'E' => 1, 2))), Agency_ID);

Temp_Agency := RECORD
                STRING Agency_id;
							 END;
ds_agency_missing := DATASET('~thor::ecrash::update_agency_0309', Temp_Agency, THOR);

// 1. All records with source_id ‘TF’ need no updates and these records will be filtered out in the downstream process on eCrash build : Record count 68k
// 2. For Vendor_Code as ‘IYETEK’ and Report_Type_Id as ‘DE’ and Source_Id as ‘TM’  update Contrib_Source to 'I' : Record count 133k
// 3. For Vendor_Code as ‘MSP’ and Source_Id as ‘TM’  and Contrib_Source as 'E' or 'A' update Contrib_Source to 'I' : Record count 272k
// 4. Agency_id ‘6931243’ Kerri please confirm what is the correct source (We have active Contrib_Source as ‘GN’ for the same Agency_Id but data from 20210204-20210208 were sent with  Contrib_Source ‘A’) : Record count 521 
// 5. For Source_id as ‘EA’ and  Work_Type_Id as ‘0’ or ‘1’  and Contrib_Source as blank update Contrib_Source to 'E' : Record count 17k
// 6. For source_id = 'EA' and current contrib_source = 'A' to contrib_source = 'P' and agency_id in email list 

Layout_Incident tIncSourceUpd(ds_incident_TM L, ds_agency_missing R) := TRANSFORM
 agency_matching := L.agency_id = R.agency_id;
 isTMAgency := agency_matching AND STD.Str.ToUpperCase(L.source_id) = 'TM';
 
 isIyetekAgency := STD.Str.ToUpperCase(L.vendor_code) = 'IYETEK';
 isMSPAgency := STD.Str.ToUpperCase(L.vendor_code) = 'MSP';
 
 isReportTypeDE := STD.Str.ToUpperCase(L.report_type_id) = 'DE';
// SELF.contrib_source := MAP((agency_matching AND STD.Str.ToUpperCase(L.vendor_code) = 'IYETEK' AND STD.Str.ToUpperCase(L.report_type_id) = 'DE' AND 
                             // STD.Str.ToUpperCase(L.source_id) = 'TM' AND STD.Str.ToUpperCase(L.contrib_source) = 'E') => 'I',
														// (agency_matching AND STD.Str.ToUpperCase(L.vendor_code)IN ['MSP', 'IYETEK'] AND STD.Str.ToUpperCase(L.source_id) = 'TM' AND 
														 // STD.Str.ToUpperCase(L.contrib_source) IN ['E', 'A']) => 'I',
														//L.contrib_source
													 // );
 //Case1: I, DE, A => 'I'
 //Case2: I, DE, E => 'I'
 //Case3: I, -DE, A => 'I'
 //Case4: I, -DE, E => 'I'
 
 //Case1: I, DE, B => L.contrib_source (B)
 //Case2: I, DE, B => L.contrib_source (B)
 //Case3: I, -DE, B => L.contrib_source (B)
 //Case4: I, -DE, B => L.contrib_source (B)
 
 contrib_source := MAP((isIyetekAgency AND isReportTypeDE AND STD.Str.ToUpperCase(L.contrib_source) = 'E') => 'I',
											 (isMSPAgency AND STD.Str.ToUpperCase(L.contrib_source) IN ['E', 'A']) => 'I',
											 L.contrib_source
											 );
													 
 SELF.contrib_source := IF(isTMAgency, contrib_source, L.contrib_source);
 SELF := L;
END;
jIncSourceUpd := JOIN(ds_incident_TM, ds_agency_missing, 
                      LEFT.agency_id = RIGHT.agency_id, 
                       tIncSourceUpd(LEFT, RIGHT), LEFT OUTER, LOOKUP); 
Updated_TM_Incidents := jIncSourceUpd + ds_incident_NOT_TM:INDEPENDENT;

Incidents_EA := Updated_TM_Incidents(STD.Str.ToUpperCase(source_id)  = 'EA');
Incidents_NOT_EA := Updated_TM_Incidents(STD.Str.ToUpperCase(source_id)  <> 'EA');
										 
Layout_Incident tIncMissingSourceUpd(Incidents_EA L, uagency R) := TRANSFORM
 agency_matching := L.agency_id = R.agency_id;
 SELF.contrib_source := IF((agency_matching AND 
                            L.agency_id IN eCrash_Maintenance.agency_list.agency_ea_list AND 
														TRIM(L.work_type_id, LEFT, RIGHT) IN ['0', '1'] AND 
														TRIM(L.contrib_source, LEFT, RIGHT) = ''), 
														R.source_id, L.contrib_source);
 SELF := L;
END;
pIncSourceUpdmissingcs := JOIN(Incidents_EA, uagency, 
                               LEFT.agency_id = RIGHT.agency_id, 
                               tIncMissingSourceUpd(LEFT, RIGHT), LEFT OUTER, LOOKUP); 
Updated_TM_EA_Incidents := pIncSourceUpdmissingcs + Incidents_NOT_EA:INDEPENDENT;
											 
pIncSourceUpdmissingFinal  := PROJECT(Updated_TM_EA_Incidents, TRANSFORM(Layout_Incident, 
																			SELF.contrib_source := MAP((LEFT.agency_id IN eCrash_Maintenance.agency_list.agency_email_list AND 
																			                           STD.Str.ToUpperCase(LEFT.source_id) = 'EA' AND 
																			                           STD.Str.ToUpperCase(LEFT.contrib_source) = 'A') => 'P', 
																																 (LEFT.agency_id = '6931243' AND STD.Str.ToUpperCase(LEFT.vendor_code) = 'CRASHLOGIC' AND
																																 STD.Str.ToUpperCase(LEFT.source_id) = 'TM') => 'GN',
																																 (LEFT.agency_id = '1541360' AND STD.Str.ToUpperCase(LEFT.vendor_code) = 'IYETEK' AND
																																 STD.Str.ToUpperCase(LEFT.source_id) = 'TM' AND 
																																 STD.Str.ToUpperCase(LEFT.contrib_source) = 'E') => 'C',
																																 (LEFT.agency_id IN eCrash_Maintenance.agency_list.agency_tm_list AND 
																																  STD.Str.ToUpperCase(LEFT.source_id) = 'TM' AND 
																																  STD.Str.ToUpperCase(LEFT.vendor_code) = 'IYETEK' AND 
																																	STD.Str.ToUpperCase(LEFT.contrib_source) IN ['E', 'A']) => 'I',
																																	(LEFT.agency_id = '1513172' AND 
																																  STD.Str.ToUpperCase(LEFT.source_id) = 'TM' AND 
																																  STD.Str.ToUpperCase(LEFT.vendor_code) = 'IYETEK' AND 
																																	STD.Str.ToUpperCase(LEFT.contrib_source) = 'C') => 'I',
																																	(LEFT.agency_id = '1639547' AND 
																																  STD.Str.ToUpperCase(LEFT.source_id) = 'TM' AND 
																																  STD.Str.ToUpperCase(LEFT.vendor_code) = 'IYETEK' AND 
																																	STD.Str.ToUpperCase(LEFT.contrib_source) = 'I') => 'A',
																																	(LEFT.agency_id = '1537076' AND 
																																  STD.Str.ToUpperCase(LEFT.source_id) = 'TM' AND 
																																  STD.Str.ToUpperCase(LEFT.vendor_code) = 'IYETEK' AND 
																																	STD.Str.ToUpperCase(LEFT.contrib_source) = 'C') => 'I',
																																	(LEFT.agency_id = '1523972' AND 
																																  STD.Str.ToUpperCase(LEFT.source_id) = 'TM' AND 
																																  STD.Str.ToUpperCase(LEFT.vendor_code) = 'IYETEK' AND 
																																	STD.Str.ToUpperCase(LEFT.contrib_source) = 'I') => 'C',
																																	(LEFT.agency_id = '6667593' AND 
																																  STD.Str.ToUpperCase(LEFT.source_id) = 'EA' AND
																																	STD.Str.ToUpperCase(LEFT.contrib_source) = 'E') => 'A',
																																	(LEFT.agency_id = '6696543' AND 
																																  STD.Str.ToUpperCase(LEFT.source_id) = 'EA' AND
																																	STD.Str.ToUpperCase(LEFT.contrib_source) = 'E') => 'I',
																			                            LEFT.contrib_source);
																		  SELF := LEFT;));
 					
ds_Incident_Upd_Out := OUTPUT(pIncSourceUpdmissingFinal ,, Files.Incident_Raw_LF('Update_Contrib_Source'), OVERWRITE, __COMPRESSED__,
					                     CSV(TERMINATOR('\n'), SEPARATOR(','), QUOTE('"')));
 
New_Incident_Raw := SEQUENTIAL(
                               ds_Incident_Upd_Out,
												       STD.File.StartSuperFileTransaction(),
												       STD.File.ClearSuperFile(Files.Incident_Raw_SF, FALSE),
												       STD.File.AddSuperFile(Files.Incident_Raw_SF, 
																                     Files.Incident_Raw_LF('Update_Contrib_Source')),
												       STD.File.FinishSuperFileTransaction()
												       );
 RETURN New_Incident_Raw;
END;