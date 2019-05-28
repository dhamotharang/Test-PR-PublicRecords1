import BankruptcyV2, fcra, Doxie, ut, dops, Std;

export key_bankruptcyV3_main_full(boolean isFCRA = false) := function

  todaysdate := (STRING8)Std.Date.Today();

	get_recs := project(BankruptcyV2.file_bankruptcy_main_v3(~isFCRA OR fcra.bankrupt_is_ok (todaysdate,date_filed)), bankruptcyV2.Layout_bankruptcy_main_v3.layout_bankruptcy_main_filing_supp_excludescrubs);

	FCRATest:=if(isFCRA,get_recs(court_code+case_number not in dops.SuppressID('bankruptcy').GetIDsAsSet(isFCRA)),get_recs);
	get_recs reformat(FCRATest l) := transform 
		self.filing_status := if(l.filing_status = 'Unknown' ,'',l.filing_status);
		self := l ; 
	end; 

	get_rec_clean := project(FCRATest , reformat(left)); 
	dist_id := distribute(get_rec_clean, hash(TMSID));
	sort_id := dedup(sort(dist_id, TMSID, -process_Date, local), TMSID,local);

	// DF-22108 FCRA Consumer Data Deprecation for FCRA_BankruptcyKeys - thor_data400::key::bankruptcyv3::fcra::main::tmsid_qa
	ut.MAC_CLEAR_FIELDS(sort_id, sort_id_cleared, BankruptcyV3.Constants().fields_to_clear.main_tmsid);
	sort_id_cleared_proj := project(sort_id_cleared,recordof(sort_id));
	sort_id_final := IF(isFCRA,sort_id_cleared_proj,sort_id);
	
	key_name := bankruptcyv3.BuildKeyName(isFCRA, 'main::tmsid');

	return index(sort_id_final,{tmsid},{sort_id_final},key_name);
end;