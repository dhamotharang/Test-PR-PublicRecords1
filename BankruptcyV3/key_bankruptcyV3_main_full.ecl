import BankruptcyV2, fcra, Doxie, ut, std;

export key_bankruptcyV3_main_full(boolean isFCRA = false) := function

  todaysdate := (STRING8)Std.Date.Today();

	get_recs := project(BankruptcyV2.file_bankruptcy_main_v3(~isFCRA OR fcra.bankrupt_is_ok (todaysdate,date_filed)), bankruptcyV2.Layout_bankruptcy_main_v3.layout_bankruptcy_main_filing_supp_excludescrubs);

	get_recs reformat(get_recs l) := transform 
		self.filing_status := if(l.filing_status = 'Unknown' ,'',l.filing_status);
		self := l ; 
	end; 

	get_rec_clean := project(get_recs , reformat(left)); 
	dist_id := distribute(get_rec_clean, hash(TMSID));
	sort_id := dedup(sort(dist_id, TMSID, -process_Date, local), TMSID,local);

	key_name := bankruptcyv3.BuildKeyName(isFCRA, 'main::tmsid');

	return index(sort_id,{tmsid},{sort_id},key_name);
end;