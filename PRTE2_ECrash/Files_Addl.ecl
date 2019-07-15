import FLAccidents_Ecrash, ut, std, prte2_Ecrash;

EXPORT Files_Addl := module;

//Related to BuyCrash Appriss Ingretation Releases Changes
shared dsKeybuildSearchSlim := project(File_KeybuildV2.eCrashSearchRecs, Layouts.key_slim_rec); 

/*************************************************************************************************/
EXPORT ds_keybuild_analytics := project(file_KeybuildV2.out, transform(Layouts.keybuild_SSv3,
																					self.did 											:= (string12)left.did;
																					self.orig_case_identifier 		:= if(left.report_code = 'EA', left.orig_accnbr , left.addl_report_number);
																					self.orig_state_report_number := if(left.report_code = 'EA', left.addl_report_number, left.orig_accnbr); 
																					self:= left;
																					self := [];
																					));
//need to revisit distribute/sort/dedup
Dedup1 := DEDUP(ds_keybuild_analytics (DID > '0'), DID, Vehicle_Incident_id);
Dedup2 := DEDUP(ds_keybuild_analytics (DID = '0'), Vehicle_Incident_Id,fname, lname, name_suffix, dob, driver_license_nbr,cname);

EXPORT DedupedKey := SORT(Dedup1 + Dedup2, jurisdiction_nbr + Vehicle_Incident_id + Vehicle_unit_number);

// CRU Inq/Natational Accident Reports
EcrashAndCru 	 := File_KeybuildV2.out(report_code in ['EA','TM','TF'] and  (work_type_id not in ['0','1']  OR trim(report_type_id,all) in ['A','DE']) );   
Filter_CRU 		:= File_KeybuildV2.out(report_code not in ['EA','TM','TF']);
				
// eCrash Reports:  normalize addl_report_number for ecrash TM,TF and EA work type 1,0
NormAddlRpt := project(EcrashAndCru(work_type_id not in ['2','3']), 
																transform( {EcrashAndCru}, 
																				self.accident_nbr := left.addl_report_number;
																				self := left, self := [])); 

crash_accnbr_base_norm := (EcrashAndCru + NormAddlRpt + Filter_CRU (vin+driver_license_nbr+tag_nbr+lname+cname <>'')) (trim(accident_nbr,left,right)<>'');

EXPORT ds_accnbrv1 	:= project(crash_accnbr_base_norm, transform(layouts.ecrashv2_accnbrv1, self.l_accnbr := left.accident_nbr, self.date_report_submitted:='', self := left, self:= []));

//Key Accnbr
Ecrash 			:= File_KeybuildV2.out(report_code in ['EA','TM','TF']);
Filter_CRU 	:= File_KeybuildV2.out(report_code not in ['EA','TM','TF']);

crash_accnbr_base := Ecrash + Filter_CRU (vin+driver_license_nbr+tag_nbr+lname+cname <>''); 
						
// normalize addl_report_number 
NormAddlRpt := project(crash_accnbr_base(report_code in ['TF','TM']), transform( {crash_accnbr_base}, 
																																								self.accident_nbr := left.addl_report_number;
																																								self := left, self := [])); 

crash_accnbr_base_norm := (crash_accnbr_base + NormAddlRpt) (trim(accident_nbr,left,right)<>'');
EXPORT ds_accnbr := project(crash_accnbr_base_norm, transform(layouts.ecrashv2_accnbr, self.l_accnbr := left.accident_nbr, self := left, self:= []));


//Related to BuyCrash Appriss Changes
// PROJECT(file_keybuildV2.out(report_code in ['EA','TM','TF'] and work_type_id not in ['2','3'] and trim(report_type_id,all) in ['A','DE']), transform(Layouts.slim_rec_reportlinkid, self := left, self := []));
tab := table (dsKeybuildSearchSlim, {jurisdiction_nbr , string8 MaxSent_to_hpcc_date := max(group,date_vendor_last_reported)}, jurisdiction_nbr);
EXPORT ds_agencyid_sentdate := tab; 


EXPORT ds_dol := PROJECT(file_keybuildV2.out(vin+driver_license_nbr+tag_nbr+lname <>'' and trim(report_type_id,all) in ['A','DE']), transform(Layouts.ecrashv2_dol, self := left, self := []));


// LastName State Key
//Related to BuyCrash Appriss Changes
// dsKeyBuild :=  file_keybuildV2.out(report_code in ['EA','TM','TF'] and work_type_id not in ['2','3'] and lname <> '' and trim(report_type_id,all) in ['A','DE']);
dsKeybuild := File_KeybuildV2.eCrashSearchRecs(lname <> '');
mSSv2:= PROJECT(dsKeyBuild(trim(lname, left, right) <> trim(orig_lname, left, right) and  
															 (STD.STr.CountWords(lname,' ') > 1 or STD.STr.CountWords(orig_lname,' ') > 1 ) and orig_lname <> '' ), 
																	transform(Layouts.key_search_rec, 
																						SELF.fname := left.orig_fname;
																						SELF.lname := left.orig_lname;
																						SELF.mname := left.orig_mname;
																						self.did 	 := (string12) left.did;
																						SELF := left;
																						self := [];
																						));
																						
EXPORT ds_lastname_state := project(mSSv2 + dsKeyBuild, Layouts.key_slim_rec);


EXPORT ds_prefname_state := project(dsKeybuildSearchSlim(fname <> ''), transform(Layouts.key_slim_rec,
																																		self.fname :=	LEFT.fname;
																																		self := LEFT;
																																		self := [];
																																		)); 
																																		
//Related to BuyCrash Appriss Changes																												
EXPORT ds_reportLinkID := project(dsKeybuildSearchSlim, transform(Layouts.slim_rec_reportlinkid, self := left, self := []))(ReportLinkID <> '');  

//Related to BuyCrash Appriss Changes
EXPORT ds_DLNbrState := dsKeybuildSearchSlim(driver_license_nbr <> '');

EXPORT ds_LicensePlateNbr := dsKeybuildSearchSlim(tag_nbr <> '');

EXPORT ds_OfficerBadgeNbr := dsKeybuildSearchSlim(officer_id <> '');

EXPORT ds_VinNbr := dsKeybuildSearchSlim(vin <> '');

END;