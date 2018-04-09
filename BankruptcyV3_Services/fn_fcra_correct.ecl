/* 
 ***** FCRA Corrections *****
 implement fcra corrections/overrides for on main and search bk files
 based on doxie.bk_records (as of 2013.03.16)
*/

import bankruptcyv3, business_header, FCRA, FFD, Gateway, STD, ut;

export layouts.layout_rollup fn_fcra_correct(dataset(layouts.layout_rollup) ds) := function

	business_header.doxie_mac_field_declare(, true); // second param is isFCRA
	string7 cnum := CaseNumber_value;
	string5  ccode := '' : stored('CourtCode');
	string1 in_party_type := '';

  gateways := Gateway.Configuration.Get();    
    
  dids4flag := normalize(ds, left.debtors,
	                  transform(doxie.layout_best, 
                     self.did := (unsigned6) right.did, 
										 self.fname := right.names[1].fname,
										 self.mname := right.names[1].mname,
										 self.lname := right.names[1].lname,
										 self.ssn := right.ssn,
										 self := right));
 										
  dids4pc := project(dids4flag, transform(FFD.Layouts.DidBatch, 
                      self.did := left.did, 
                      self.acctno := FFD.Constants.SingleSearchAcctno));
                    
  // call person context  to get LT suppression records  
	// we are deliberately making additional call to person context here to keep changes as simple as possible
  pc_recs := FFD.FetchPersonContext(dids4pc, gateways, FFD.Constants.DataGroupSet.Bankruptcy);  
	ds_flags := FFD.GetFlagFile(dids4flag, pc_recs);

	// Get overrides records:
	// a) identifiers (unique for this datatype) showing which records are to be corrected;
	// b) pointers to corrected records ("right" by definition);
	bk_cccn := SET (ds_flags (file_id = FCRA.FILE_ID.BANKRUPTCY), record_id);
  bk_ffid := SET (ds_flags (file_id = FCRA.FILE_ID.BANKRUPTCY), flag_file_id);

	// Get only "good" records (filtered out by both main- and search- override ids:
  bk_main_record_id   := TRIM(ds.court_code) + TRIM(ds.case_number);
  bk_search_record_id := TRIM(ds.tmsid) + BankruptcyV3_Services.consts.NAME_TYPES.DEBTOR + TRIM(ds.debtors[1].did);// 'D' is hardcoded because only DEBTOR bk records are correctable while Attorney and Judge records are not.
  ds_clean := ds((bk_main_record_id NOT IN bk_cccn) AND (bk_search_record_id NOT IN bk_cccn));
	
	//get corrections (both for main- and search- files)
	ds_main_override := CHOOSEN (fcra.key_Override_bkv3_main_ffid (keyed (flag_file_id IN bk_ffid)), ut.limits.OVERRIDE_LIMIT);
	ds_main_corrections := project(ds_main_override, 
	                               transform(recordof(bankruptcyv3.key_bankruptcyv3_main_full()),
							                   self := left, self := []));

	ds_search_override := CHOOSEN (fcra.key_Override_bkv3_search_ffid (keyed (flag_file_id IN bk_ffid)), ut.limits.OVERRIDE_LIMIT);
  ds_search_corrections :=  project (ds_search_override, 
	                                   transform(BankruptcyV3_Services.Layout_key_bankruptcyV3_search_full_bip_plus_case_numbers,
	            							         self := left, 
                                     self := []));

	// format overrides to BK V3 layout_rollup
	ds_correct := fn_rollup_corrections (ds_search_corrections,ds_main_corrections,,,true);

	// add user's (override) records; filter by fcra-date criteria
	res_fcra := (ds_clean + ds_correct) (FCRA.bankrupt_is_ok ((STRING)STD.Date.Today(), date_filed));
	
	// OUTPUT(bk_cccn,NAMED('bk_cccn'));
	// OUTPUT(bk_ffid,NAMED('bk_ffid'));
	// OUTPUT(ds,NAMED('ds'));
	// OUTPUT(ds_pro,NAMED('ds_pro'));
	// OUTPUT(ds_flags,NAMED('ds_flags'));
	// OUTPUT(ds_clean,NAMED('ds_clean'));

	return res_fcra;

end;