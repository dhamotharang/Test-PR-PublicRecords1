//============================================================================
// Attribute: bk_raw.  Used by view source service and comp-report.
// Function to get bankruptcy records by did, bdid, or case number and court code.
// Return value: Dataset with layout Doxie/layout_bk_output.
//============================================================================

import Doxie, bankrupt, bankruptcyv3, ut, Suppress, bipv2, bankruptcyv2;

export bk_raw(
  dataset(Doxie.layout_references) dids,
  dataset(Doxie.Layout_ref_bdid) bdids,
  string7 cnum = '',
  string5  ccode = '',
  unsigned3 dateVal = 0,
  unsigned1 dppa_purpose = 0, // isn't used
  unsigned1 glb_purpose = 0,  // isn't used
  STRING6 ssn_mask_value = 'NONE', //isn't used??
	string1 in_party_type = '',
	BOOLEAN isReport = false
) := FUNCTION

slim_rec := record
  unsigned6 s_did;
  string5   court_code;
  string7   case_number;
end;
// get main records by did
bydid := join (dids, bankruptcyv3.key_bankruptcyv3_did(),
								LEFT.did<>0 AND keyed(left.did=right.did) and
								(In_Party_Type = '' or exists(bankruptcyv3.key_bankruptcyv3_search_full_bip()((unsigned)did = left.did and tmsid = right.tmsid and name_type[1] = stringlib.stringtouppercase(In_Party_Type)[1]))),
								transform (slim_rec, SELF.s_did := Right.did, SELF := Right),
								LIMIT (ut.limits. BANKRUPT_MAX, SKIP));

// get main records by bdid
slim_rec get_by_bdid(
	recordof(bankruptcyv3.key_bankruptcyv3_bdid())	L) := transform
	self.s_did := 0;
	self.court_code := L.court_code;
	self.case_number := L.case_number;
end;

bybdid := join (bdids, bankruptcyv3.key_bankruptcyv3_bdid(), keyed (left.bdid = right.p_bdid) and
								(In_Party_Type = '' or exists(bankruptcyv3.key_bankruptcyv3_search_full_bip()((unsigned)bdid = left.bdid and tmsid = right.tmsid and name_type[1] = stringlib.stringtouppercase(In_Party_Type)[1]))),
                get_by_bdid(RIGHT),
                ATMOST (ut.limits. BANKRUPT_PER_BDID));

// combine records obtained by did, bdid
ds_temp := bydid + bybdid;
ds_did_bdid := dedup(sort(ds_temp, court_code,case_number), court_code, case_number);

//Gathering the trustee information from the Bkv3 main key.
//In Bkv2 this information was in the search key. 
rec_main_int := record
	string50 tmsid;
	bankrupt.Layout_BK_Main_v8;
end;

rec_main_int get_trustee_info(recordof(bankruptcyv3.key_bankruptcyv3_main_full()) R) := transform
	SELF.trustee_name 		:= R.trusteeName;
	SELF.trustee_phone 		:= R.trusteePhone;
	SELF.trustee_company 	:= ''; //no company info in BKv3 main key, trustee are never companies even in Bkv2 search key: W20150410-145529
	SELF.trustee_address1 := R.trusteeAddress;
	SELF.trustee_address2	:= '';
	SELF.trustee_city			:= R.trusteeCity;
	SELF.trustee_st				:= R.trusteeState;
	SELF.trustee_zip			:= R.trusteeZip;
	SELF.trustee_zip4			:= R.trusteeZip4;
	SELF := R;
	SELF := [];
end;

rec_main_int_full_bip := RECORD
	  rec_main_int;
			bankruptcyv2.layout_bankruptcy_search_v3_supp;
			bipv2.IDlayouts.l_xlink_ids;	 
			unsigned8 source_rec_id := 0; 
END;
	
f_main_byd0 := join(ds_did_bdid,bankruptcyv3.key_bankruptcyv3_casenumber(),
                       keyed(left.case_number = right.case_number),
											 transform({recordof(bankruptcyv3.key_bankruptcyv3_casenumber()),ds_did_bdid.court_code}, 
											 SELF := right, 
											 SELF := left),
											 atmost(ut.limits.BANKRUPT_MAX));
f_main_byd := join(f_main_byd0,bankruptcyv3.key_bankruptcyv3_main_full(),
                       keyed(left.tmsid = right.tmsid) and
											 left.court_code = right.court_code,
											 get_trustee_info(right),
											 limit(0), keep(1)); //main key is a 1:1 key
ds_bk_full := choosen(bankruptcyv3.key_bankruptcyv3_casenumber()(keyed(case_number = cnum)),ut.limits.BANKRUPT_MAX);
f_main_byn := join(ds_bk_full,bankruptcyv3.key_bankruptcyv3_main_full(),
                       keyed(left.tmsid = right.tmsid) and
											 right.court_code = ccode,
											 get_trustee_info(right),
											 limit(0), keep(1)); //main key is a 1:1 key
f_main0 := if(cnum != '', f_main_byn, f_main_byd);
//Here we need to make sure to fill out the fields that used 
//to be in Bkv2 main but are now only available in Bkv3 search
f_main1 := join(f_main0, bankruptcyv3.key_bankruptcyv3_search_full_bip(),
                    keyed(left.tmsid = right.tmsid),
										transform(rec_main_int_full_bip,
											self.chapter 					:= right.chapter,
											self.orig_filing_type := right.filing_type,
											self.corp_flag 				:= right.corp_flag,
											self.disposed_date 		:= right.discharged,
											self.disposition 			:= right.disposition,
											self.converted_date 	:= right.converted_date, 
											self.record_type 			:= right.record_type, 
											self.filing_type 			:= right.filing_type, 
											self.pro_se_ind 			:= right.pro_se_ind,
											self 									:= left,
											self 									:= right),
										atmost(ut.limits.BANKRUPT_MAX));
																														
f_main2 := rollup(project(f_main1(name_type[1] = 'A'), recordof(bankruptcyv3.key_bankruptcyv3_search_full_bip())),
										left.tmsid = right.tmsid and
										left.name_type = right.name_type,
										transform(recordof(bankruptcyv3.key_bankruptcyv3_search_full_bip()),
											self.orig_company := if(left.orig_company = '',right.orig_company,left.orig_company),
											self.orig_name := if(left.orig_name = '',right.orig_name,left.orig_name),
											self.orig_fname := if(left.orig_fname = '',right.orig_fname,left.orig_fname),
											self.orig_mname := if(left.orig_mname = '',right.orig_mname,left.orig_mname),
											self.orig_lname := if(left.orig_lname = '',right.orig_lname,left.orig_lname),
											self := left));
//only need to keep 1 of the tmsid records from the join to Bkv3 search key
//all tmsid records will carry the extra info we are getting from Bkv3 search key + the Bkv3 main key info gathered previously
dup_f_main1 := dedup(sort(f_main1, tmsid), tmsid); 
f_main := join(dup_f_main1,f_main2,
                    left.tmsid = right.tmsid,
										transform(Bankrupt.layout_bk_crs_main,
											self.attorney_name 		:= if(right.orig_name = '',
												trim(right.orig_fname) + ' ' + trim(right.orig_lname),
												right.orig_name),
											self.attorney_phone 	:= right.phone,
											self.attorney_company := right.orig_company,
											self.attorney_address1:= right.orig_addr1,
											self.attorney_address2:= right.orig_addr2,
											self.attorney_city 		:= right.orig_city,
											self.attorney_st 			:= right.orig_st,
											self.attorney_zip 		:= right.orig_zip5,
											self.attorney_zip4 		:= right.orig_zip4,
											self := left),
										left outer,
										atmost(ut.limits.BANKRUPT_MAX));
										
raw_search0 := join (f_main,bankruptcyv3.key_bankruptcyv3_casenumber(),
                         keyed(left.case_number = right.case_number),
												 transform({recordof(bankruptcyv3.key_bankruptcyv3_casenumber()),f_main.court_code},self := right,self := left),
												 limit(ut.limits.BANKRUPT_MAX,skip));
raw_search := join(raw_search0,bankruptcyv3.key_bankruptcyv3_search_full_bip(),
                       keyed(left.tmsid = right.tmsid) and
											 left.court_code = right.court_code and
											 right.name_type[1] = 'D',
												 transform(Bankrupt.layout_bk_crs_search,
													self.debtor_ssn := right.ssn,
													self.debtor_title := right.title,
													self.debtor_fname := right.fname,
													self.debtor_mname := right.mname,
													self.debtor_lname := right.lname,
													self.debtor_name_suffix := right.name_suffix,
													self.debtor_company := right.cname,
													self.suffix := right.addr_suffix,
													self.z5 := right.zip,
													self.debtor_did := right.did,
													self.score := right.name_score,
													self.debtor_did_score := '',
													self := right),
												 limit(ut.limits.BANKRUPT_MAX,skip));

Suppress.MAC_Mask(raw_search, raw_search_masked, debtor_ssn, null, true, false, maskVal:=ssn_mask_value);

srtout := Bankrupt.GetCRSOutput (f_main, raw_search_masked);
return project(srtout(penalt < 10 OR isReport), doxie.Layout_BK_Output);
END;