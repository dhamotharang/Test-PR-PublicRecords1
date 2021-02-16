IMPORT FLAccidents, STD;

EXPORT File_KeybuildV2 := MODULE

// ###########################################################################
// Combine FL Crash, Ntl Accidents, Ntl Inquiries & eCrash Data
// ###########################################################################
	CombineAccidents := Map_FLAccidents_To_eCrashConsolidation + 
	                    Map_NtlAccidents_To_eCrashConsolidation + 
											Map_NtlAccidentsInquiry_To_eCrashConsolidation + 
											Map_eCrashAccidents_To_eCrashConsolidation;

  //Perform Convertion to UpperCase
	UpCaseCombineAccidents := Fn_Upcase(CombineAccidents); 
	CombineAccidentsDID := UpCaseCombineAccidents(~(fname <> '' AND lname <> '' AND vin <> '' AND (UNSIGNED) did = 0)); 
	CombineAccidentsNoDID := UpCaseCombineAccidents(fname <> '' AND lname <> '' AND vin <> '' AND (UNSIGNED) did = 0);
	
  //Get DID from Vehicle file by name AND vin
	getMVRDID := Fn_Mvr_DID(CombineAccidentsNoDID);
	
	CleanAllAccidents := CombineAccidentsDID + getMVRDID;
	dAllAccidents := DISTRIBUTE(CleanAllAccidents, HASH32(accident_nbr));
	sAllAccidents := SORT(dAllAccidents, accident_date, accident_nbr, jurisdiction_state, vin, tag_nbr, lname, fname, mname, did, record_type, 
	                                     prim_name, dob, report_code, report_type_id, MAP(work_type_id IN ['1', '0'] => 2, 1), 
																			 date_vendor_last_reported, creation_date, LENGTH(TRIM(carrier_name, LEFT, RIGHT)) <> 0, 
																			 LENGTH(TRIM(driver_license_nbr, LEFT, RIGHT)) <> 0, vehicle_incident_id, LOCAL); // give preference to ecrash work type 1's over 2, 3
	uAllAccidents := DEDUP(sAllAccidents, accident_date, accident_nbr, jurisdiction_state, vin, tag_nbr, lname, fname, mname, did, record_type, 
	                                      prim_name, dob, report_code, report_type_id, RIGHT, LOCAL);
																				
	//scrub the accident number AND UNK issue
	Layout_eCrash.Consolidation_AgencyOri tAllAccidents(uAllAccidents L) := TRANSFORM
		t_scrub := STD.Str.Filter(L.accident_nbr, 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789');
		SELF.accident_nbr := IF(t_scrub IN ['UNK', 'UNKNOWN'], 'UNK' + L.vehicle_incident_id, t_scrub); 
		SELF.orig_accnbr := L.accident_nbr; 
		SELF.addl_report_number := IF(STD.Str.FilterOut(TRIM(L.addl_report_number, LEFT, RIGHT), '0') <>'', L.addl_report_number, '');
		SELF.scrub_addl_report_number := STD.Str.Filter(SELF.addl_report_number, 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789');
		SELF.policy_effective_date := MAP(TRIM(L.policy_effective_date)[1] = '0' => '',
																			TRIM(L.policy_effective_date)[8] = '-' => TRIM(L.policy_effective_date)[1..7],
                                      TRIM(L.policy_effective_date));
		SELF := L;
	END;
	SHARED AllAccidents := PROJECT(uAllAccidents, tAllAccidents(LEFT)): PERSIST('~thor_data400::persist::ecrash_ssV2');

// ###########################################################################
// Accident data for Insurance eCrash CRU Keys / Queries
// ###########################################################################
	SHARED InteractiveReports := ['I0', 'I1', 'I2', 'I3', 'I4', 'I5', 'I6', 'I7', 'I8', 'I9'];
	SHARED AlphaIA := AllAccidents (report_code[1] = 'I' AND report_code NOT IN InteractiveReports); 
	SHARED AlphaOther := AllAccidents (report_code[1] <> 'I');
	SHARED AlphaCmbnd := AlphaOther + AlphaIA (reason_id IN ['HOLD', 'AFYI', 'ASSI', 'AUTO', 'CALL', 'PRAC', 'SEAR', 'SECR', 'WAIT', 'PRAI']);
	SHARED AlphaOtherVendors := AlphaCmbnd(TRIM(vendor_code, LEFT, RIGHT) <> 'COPLOGIC');
	SHARED AlphaCoplogic := AlphaCmbnd(TRIM(vendor_code, LEFT, RIGHT) = 'COPLOGIC' AND 
	                                   ((TRIM(supplemental_report, LEFT, RIGHT) = '1' AND TRIM(super_report_id, LEFT, RIGHT) <> TRIM(report_id, LEFT, RIGHT)) OR 
																		  (TRIM(supplemental_report, LEFT, RIGHT) = '0' AND TRIM(super_report_id, LEFT, RIGHT) = TRIM(report_id, LEFT, RIGHT)) OR 
																		  (TRIM(supplemental_report, LEFT, RIGHT) = '' AND TRIM(super_report_id, LEFT, RIGHT) = TRIM(report_id, LEFT, RIGHT) )
																		 )
																		);
	SHARED ALLAlphaAccidents := AlphaOtherVendors + AlphaCoplogic;																
	SHARED fAlphaAccidents := ALLAlphaAccidents(STD.Str.ToUpperCase(TRIM(orig_agency_ori, ALL)) NOT IN Agency_exclusion.CRU_Agency_ori_list AND
																							STD.Str.ToUpperCase(TRIM(agency_ori, ALL)) NOT IN Agency_exclusion.CRU_Agency_ori_list);
	SHARED ActiveAlphaAccidents := PROJECT(fAlphaAccidents, TRANSFORM(Layout_eCrash.Accidents_Alpha, SELF := LEFT;));
	EXPORT Alpha := ActiveAlphaAccidents;	

// ###########################################################################
//  ALL Accidents report data
// ###########################################################################
	SHARED eCrashAccidents := AllAccidents(CRU_inq_name_type NOT IN ['2', '3'] AND 
	                                report_code NOT IN InteractiveReports AND 
																	TRIM(vendor_code, LEFT, RIGHT) <> 'COPLOGIC'):INDEPENDENT;

// ###########################################################################
//  ALL Accidents report data for eCrash Keys / Queries
// ###########################################################################																	
	EXPORT out := PROJECT(eCrashAccidents, TRANSFORM(Layout_eCrash.Consolidation, SELF := LEFT;));

// ###########################################################################
//  ALL Accidents report data for PR Keys / Queries
// ###########################################################################													 
	SHARED EcrashAgencyExclusionAgencyOri := eCrashAccidents(STD.Str.ToUpperCase(TRIM(orig_agency_ori, ALL)) NOT IN Agency_exclusion.Agency_ori_list AND
																										 STD.Str.ToUpperCase(TRIM(orig_agency_ori, ALL))[1..2] NOT IN Agency_exclusion.Agency_ori_jurisdiction_list
																										 );																																						
	SHARED EcrashAgencyExclusion := EcrashAgencyExclusionAgencyOri(STD.Str.ToUpperCase(TRIM(agency_ori, ALL)) NOT IN Agency_exclusion.Agency_ori_list AND
																																 STD.Str.ToUpperCase(TRIM(agency_ori, ALL))[1..2] NOT IN Agency_exclusion.Agency_ori_jurisdiction_list
																																 );
	EXPORT prout := PROJECT(EcrashAgencyExclusion, TRANSFORM(Layout_eCrash.Consolidation, SELF := LEFT;));

END; 