import doxie,doxie_raw,doxie_crs,ut,Header;

export Source_counts (dataset (doxie.layout_references) dids) := function

doxie.MAC_Header_Field_Declare();
doxie.MAC_Selection_Declare();

mod_access := Doxie.compliance.GetGlobalDataAccessModule();

boolean is_knowx1 := mod_access.isConsumer();

Out_layout := record
 unsigned2 atf_cnt; 
 unsigned2 bk_cnt;
 unsigned2 bkv2_cnt;
 unsigned2 lien_cnt;
 unsigned2 lienv2_cnt;
 unsigned2 dl_cnt;
 unsigned2 dl2_cnt;
 unsigned2 death_cnt;
 unsigned2 statedeath_cnt; 
 unsigned2 proflic_cnt;
 unsigned2 sanc_cnt;
 unsigned2 prov_cnt;
 //check on email
 unsigned2 email_cnt;
 unsigned2 veh_cnt;
 unsigned2 vehv2_cnt;
 unsigned2 eq_cnt;
 unsigned2 en_cnt;
 unsigned2 dea_cnt;
 unsigned2 deav2_cnt;
 unsigned2 airc_cnt;
 unsigned2 pilot_cnt;
 unsigned2 pilotCert_cnt;
 unsigned2 watercraft_cnt;
 unsigned2 ucc_cnt; 
 unsigned2 uccv2_cnt; 
 unsigned2 corpAffil_cnt;
 unsigned2 voter_cnt;
 unsigned2 voterv2_cnt;
 unsigned2 ccw_cnt;
 unsigned2 hunt_cnt;
 unsigned2 whoIs_cnt;
 unsigned2 phone_cnt;
//unsigned2 property_cnt;
 unsigned2 flcrash_cnt;
 unsigned2 DOC_Cnt; //either v1 or v2
 unsigned2 SO_Cnt;
 unsigned2 ak_cnt;
 unsigned2 mswork_cnt;
 unsigned2 for_cnt;
 unsigned2 nod_cnt;
 unsigned2 boater_cnt;
 unsigned2 finder_cnt;
 unsigned2 tu_cnt; 
 unsigned2 tn_cnt;
 unsigned2 deed_cnt;
 unsigned2 assessment_cnt;
 unsigned2 deed2_cnt;
 unsigned2 assessment2_cnt;
 unsigned2 util_cnt;
 unsigned2 quickheader_cnt;
 unsigned2 targ_cnt;
 unsigned2 phonesPlus_cnt;
 unsigned2 FBNv2_cnt;
 unsigned2 student_cnt;
end;

doxie_raw.Layout_input intoInput(doxie.layout_references L) := transform
 self.idtype := 'DID';
 self.id := (string)l.did;
 self.section := '';
 self := [];
end;

inputi := project(dids,intoInput(left));

outDid := Doxie_Raw.ViewSourceDid(inputi, mod_access, IsCRS,
		BankruptcyVersion,JudgmentLienVersion,UccVersion,DlVersion,VehicleVersion,VoterVersion,DeaVersion,CriminalRecordVersion,
		doxie_crs.str_typeDebtor); //limit counts for CRS

//=========================================================

outRec := Doxie_Raw.Layout_crs_raw;
outRec combineChildResults(outRec L, outRec R) := transform
	self.did := L.did;
	self.atf_child := IF(not is_knowx1,(L.atf_child + R.atf_child));
	self.bk_child := (L.bk_child + R.bk_child);
	self.bk_V2_child := (L.bk_V2_child + R.bk_V2_child);
	self.lien_child := (L.lien_child + R.lien_child);
	self.lien_V2_child := (L.lien_V2_child + R.lien_V2_child);
	self.dl_child := IF(not is_knowx1,(L.dl_child + R.dl_child));
	self.dl2_child := IF(not is_knowx1,(L.dl2_child + R.dl2_child));
	self.emerge_child := (L.emerge_child + R.emerge_child);
	self.voters_v2_child := IF(not is_knowx1,(L.voters_v2_child + R.voters_v2_child));
	self.death_child := (L.death_child + R.death_child);
	self.state_death_child := (L.state_death_child + R.state_death_child);
	self.proflic_child := (L.proflic_child + R.proflic_child);
	self.sanc_child := (L.sanc_child + R.sanc_child);
	self.prov_child := (L.prov_child + R.prov_child);
	self.email_child := (L.email_child + R.email_child);
	self.veh_child := IF(not is_knowx1,(L.veh_child + R.veh_child));
	self.veh_v2_child := IF(not is_knowx1,(L.veh_v2_child + R.veh_v2_child));
	self.dea_child := (L.dea_child + R.dea_child);
	self.dea_v2_child := (L.dea_v2_child + R.dea_v2_child);
	self.airc_child := (L.airc_child + R.airc_child);
	self.pilot_child := (L.pilot_child + R.pilot_child);
	self.pilotCert_child := (L.pilotCert_child + R.pilotCert_child);
	self.watercraft_child := (L.watercraft_child + R.watercraft_child);
	self.ucc_child := IF(not is_knowx1,(L.ucc_child + R.ucc_child));
	self.ucc_v2_child := IF(not is_knowx1,(L.ucc_v2_child + R.ucc_v2_child));
	self.corpAffil_child := (L.corpAffil_child + R.corpAffil_child);
	self.whoIs_child := IF(not is_knowx1,(L.whoIs_child + R.whoIs_child));
	self.deed_child := (L.deed_child + R.deed_child);
	self.assessor_child := (L.assessor_child + R.assessor_child);
	self.deed2_child := (L.deed2_child + R.deed2_child);
	self.assessor2_child := (L.assessor2_child + R.assessor2_child);
	self.ak_child := (L.ak_child + R.ak_child);
	self.mswork_child := (L.mswork_child + R.mswork_child);
	self.util_child := (L.util_child + R.util_child);
	self.eq_child := IF(not is_knowx1,(L.eq_child + R.eq_child));
	self.en_child := IF(not is_knowx1,(L.en_child + R.en_child));
	self.for_child := IF(not is_knowx1,(L.for_child + R.for_child));
	self.nod_child := IF(not is_knowx1,(L.nod_child + R.nod_child));
	self.boater_child := (L.boater_child + R.boater_child);
	self.tu_child := (L.tu_child + R.tu_child);
	self.tn_child := (L.tn_child + R.tn_child);
	self.finder_child := (L.finder_child + R.finder_child);
	self.phone_child := (L.phone_child + R.phone_child);
	self.targ_child := IF(not is_knowx1,(L.targ_child + R.targ_child));
	self.phonesPlus_child := IF(not is_knowx1,(L.phonesPlus_child  + R.phonesPlus_child ));
	self.FBNv2_child := (L.FBNv2_child + R.FBNv2_child);
	self.DOC_people_child := L.DOC_people_child + R.DOC_people_child;
	self.DOCv2_child := L.DOCv2_child + R.DOCv2_child;
	self.SexOffender_people_child := L.SexOffender_people_child + R.SexOffender_people_child;
	self.student_child := L.student_child + R.student_child;
	// self.busHdr_child := (L.busHdr_child + R.busHdr_child);
	// self.rid := 0;
	// self.uid := 0;
	// self.src := '';
	// self.QuickHeader_child := [];
	// self.FLCrash_child := [];
	// self.DOC_events_child := [];
	// self.SexOffender_events_child := [];
	self := [];
end;

outSectAll := rollup(outDid, true, combineChildResults(LEFT, RIGHT));

out_layout ddp_SectionCounts(outRec L) :=
TRANSFORM
	self.atf_cnt := if (Include_FirearmsAndExplosives_val,count(dedup(SORT(L.atf_child, RECORD), record)), 0);
	self.bk_cnt := if (Include_Bankruptcies_val,count(dedup(SORT(L.bk_child, RECORD), record)),0);
	self.bkv2_cnt := if (Include_Bankruptcies_val,count(dedup(SORT(L.bk_V2_child, RECORD), record)),0);
	self.lien_cnt := if (Include_LiensJudgments_val,count(dedup(SORT(L.lien_child, RECORD), record)),0);
	// FIX(KLL)  May Need to use a new V2 flag
	self.lienv2_cnt := if (Include_LiensJudgments_val,count(dedup(SORT(L.lien_V2_child, RECORD), record)),0);
	self.dl_cnt := if (Include_DriversLicenses_val,count(dedup(SORT(L.dl_child , RECORD), record)),0);
	self.dl2_cnt := if (Include_DriversLicenses_val,count(dedup(SORT(L.dl2_child , RECORD), record)),0);
  // the following three are from "eMerges":
	self.hunt_cnt  := if (Include_HuntingFishingLicenses_val,count(dedup(SORT(L.emerge_child(file_id = 'HUNT'), RECORD), record)),0);
  self.ccw_cnt   := if (Include_WeaponPermits_val,count(dedup(SORT(L.emerge_child(file_id = 'CCW'), RECORD), record)),0);
	self.voter_cnt := if (Include_VoterRegistrations_val,count(dedup(SORT(L.emerge_child(file_id = 'VOTE'), RECORD), record)),0);

	self.voterv2_cnt := if (Include_VoterRegistrations_val,count(dedup(SORT(L.voters_v2_child, RECORD), record)),0);
	self.death_cnt := count(dedup(SORT(L.death_child, RECORD), record));
	self.statedeath_cnt := count(dedup(SORT(L.state_death_child,RECORD),record));	
	self.proflic_cnt := if (Include_ProfessionalLicenses_val,count(dedup(SORT(L.proflic_child, RECORD), record)),0);
	self.sanc_cnt := if (Include_Sanctions_val,count(dedup(SORT(L.sanc_child, RECORD), record)),0);
	self.prov_cnt := if (Include_Providers_val,count(dedup(SORT(L.prov_child, RECORD), record)),0);
	self.email_cnt := if(Include_Email_addresses_val,count(dedup(sort(L.email_child,RECORD),record)),0);
	self.veh_cnt := if (Include_MotorVehicles_val,count(dedup(SORT(L.veh_child, RECORD), record)),0);
	self.vehv2_cnt := if (Include_MotorVehicles_val,count(dedup(SORT(L.veh_v2_child, RECORD), record)),0);
	self.dea_cnt := if (Include_DEA_Val,count(dedup(SORT(L.dea_child, RECORD), record)),0);
	self.deav2_cnt := if (Include_DEA_Val,count(dedup(SORT(L.dea_v2_child, RECORD), record)),0);
	self.airc_cnt := if (Include_FAAAircrafts_val,count(dedup(SORT(L.airc_child, RECORD), record)),0);
	self.pilot_cnt := if (Include_FAACertificates_val,count(dedup(SORT(L.pilot_child, RECORD), record)),0);
	self.pilotCert_cnt := if (Include_FAACertificates_val,count(dedup(SORT(L.pilotCert_child, RECORD), record)),0);
	self.watercraft_cnt := if (Include_Watercrafts_val,count(dedup(SORT(L.watercraft_child, RECORD), record)),0);
	self.ucc_cnt := if (Include_UCCFilings_val,count(dedup(SORT(L.ucc_child, RECORD), record)),0);
	self.uccv2_cnt := if (Include_UCCFilings_val,count(dedup(SORT(L.ucc_v2_child, RECORD), record)),0);
	self.corpAffil_cnt := if (Include_CorporateAffiliations_val,count(dedup(SORT(L.corpAffil_child, RECORD), record)),0);
	self.whoIs_cnt := if (Include_InternetDomains_val,count(dedup(SORT(L.whoIs_child, RECORD), record)),0);
	self.deed_cnt := if(Include_Properties_val,count(dedup(SORT(if(doxie.DataRestriction.Fares,L.deed_child(ln_fares_id[1]<>'R'), L.deed_child), RECORD), record)),0);
	self.assessment_cnt := if(Include_Properties_val,count(dedup(SORT(if(doxie.DataRestriction.Fares,L.assessor_child(ln_fares_id[1]<>'R'), L.assessor_child), RECORD), record)),0);
	self.deed2_cnt := if(Include_Properties_val,count(dedup(SORT(L.deed2_child, RECORD), record)),0);
	self.assessment2_cnt := if(Include_Properties_val,count(dedup(SORT(L.assessor2_child, RECORD), record)),0);
		cnt_doc_v1 := count(dedup(SORT(L.DOC_people_child, RECORD), record));
		cnt_doc_v2 := count(dedup(SORT(L.DOCv2_child, RECORD), record));
	self.DOC_cnt := if(Include_CriminalRecords_val, max (cnt_doc_v1, cnt_doc_v2), 0);
	self.SO_Cnt := if (Include_SexualOffenses_val, count(dedup(SORT(L.SexOffender_people_child, RECORD), record)),0);
	self.ak_cnt := count(dedup(SORT(L.ak_child, RECORD), record));
	self.mswork_cnt := count(dedup(SORT(L.mswork_child, RECORD), record));
	self.util_cnt := count(dedup(SORT(L.util_child, -record_date,lname,fname,mname,name_suffix,title,dob,
																							st,county,zip4,zip,p_city_name,prim_name,
																							addr_suffix,predir,prim_range,postdir,unit_desig,sec_range,
																							util_type,date_first_seen,connect_date,
																							date_added_to_exchange
															 ),
																record_date,lname,fname,mname,name_suffix,title,dob,
																st,county,zip4,zip,p_city_name,prim_name,
																addr_suffix,predir,prim_range,postdir,unit_desig,sec_range,
																util_type,date_first_seen,connect_date,
																date_added_to_exchange));
																
	self.quickheader_cnt := count(dedup(SORT(L.quickheader_child, RECORD), record));
	Header.Layout_EQ_src_dates t(Header.Layout_EQ_src_dates a , 
   		                             Header.Layout_EQ_src_dates b):= transform
   			IsABig := a.date_last_seen > b.date_last_seen ;
   			self 	 := if(IsABig ,a ,b);
   		 end;
   		 
   	self.eq_cnt := count(rollup(sort(L.eq_child, -current_address_date_reported[3..6],
   															 -current_address_date_reported[1..2],RECORD), 
   													t(left,right),
   							            RECORD,EXCEPT date_last_seen,date_first_seen,cid));		
														
	self.en_cnt := count(dedup(SORT(L.en_child, RECORD), record));
	self.for_cnt := if(Include_Foreclosures_val and (not doxie.DataRestriction.Fares),count(dedup(SORT(L.for_child, RECORD), record)),0);
	self.nod_cnt := if(Include_NoticeOfDefaults_val and (not doxie.DataRestriction.Fares),count(dedup(SORT(L.nod_child, RECORD), record)),0);
	self.boater_cnt := count(dedup(SORT(L.boater_child, RECORD), record));
	self.tu_cnt := count(dedup(SORT(L.tu_child, RECORD), record));
	self.tn_cnt := count(dedup(SORT(L.tn_child, RECORD), record));
	self.finder_cnt := count(dedup(SORT(L.finder_child, RECORD), record));
	self.phone_cnt := count(dedup(SORT(L.phone_child, RECORD), record));
	self.targ_cnt := count(dedup(SORT(L.targ_child, RECORD), record));
	self.phonesPlus_cnt := count(dedup(SORT(L.phonesPlus_child, RECORD), record));
	self.FBNv2_cnt := if(IncludeFBN_val,count(dedup(SORT(L.FBNv2_child, RECORD), record)),0);
  self.flcrash_cnt := 0;
	self.student_cnt := count(dedup(SORT(L.student_child, RECORD), record));
END;

return PROJECT(outSectAll, ddp_SectionCounts(LEFT));
end;
