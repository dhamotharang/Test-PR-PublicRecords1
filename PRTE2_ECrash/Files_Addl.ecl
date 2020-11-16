import FLAccidents_Ecrash, ut, std, prte2_Ecrash, doxie;

EXPORT Files_Addl := module

//Related to BuyCrash Appriss Ingretation Releases Changes
export dsKeybuildSearchSlim := project(File_KeybuildV2.eCrashSearchRecs, Layouts.key_slim_rec); 

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

EXPORT ds_accnbrv1 	:= project(DedupedKey, transform(layouts.ecrashv2_accnbrv1, 
																																 self.l_accnbr 							:= left.accident_nbr;
																																 self.super_report_id 			:= left.report_id;
																																 self.date_report_submitted	:=''; 
																																 self.jurisdiction					:= left.jurisdiction;
																																 self := left; 
																																 self	:= []));

//Key Accnbr
Ecrash 			:= File_KeybuildV2.out(report_code in ['EA','TM','TF']);
Filter_CRU 	:= File_KeybuildV2.out(report_code not in ['EA','TM','TF']);

crash_accnbr_base := Ecrash + Filter_CRU (vin+driver_license_nbr+tag_nbr+lname+cname <>''); 
						
EXPORT ds_accnbr := dedup(sort(distribute(project(crash_accnbr_base, 
																									transform(layouts.ecrashv2_accnbr, 
																									self.l_accnbr := left.accident_nbr, 
																									self := left, self:= [])),
																									hash(l_accnbr)), l_accnbr,local), ALL);


//Related to BuyCrash Appriss Changes

dsSlim := PROJECT(file_keybuildV2.out(report_code in ['EA','TM','TF'] and work_type_id not in ['2','3'] and trim(report_type_id,all) in ['A','DE']), transform(Layouts.slim_rec_reportlinkid, self := left, self := []));
tab := table (dsSlim, {jurisdiction_nbr, contrib_source, string8 MaxSent_to_hpcc_date := max(group,date_vendor_last_reported)}, jurisdiction_nbr,contrib_source);
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

EXPORT ds_lastname_state := project(mSSv2, Layouts.key_slim_rec);


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

//Dedupping Logic related to key_ecrashv2_did
dst_did_base := distribute(prte2_ecrash.file_keybuildV2.out(did<>'',did<>'000000000000'), hash(did, orig_accnbr));
srt_did_base := sort(dst_did_base, did, orig_accnbr,vin, local);
export ded_did_base := dedup(srt_did_base, did, orig_accnbr,vin, local); 

 
END;