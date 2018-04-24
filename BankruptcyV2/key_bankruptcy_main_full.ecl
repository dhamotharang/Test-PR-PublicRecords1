﻿import fcra, Doxie, ut,dops;

export key_bankruptcy_main_full(boolean isFCRA = false) := function

  todaysdate := ut.GetDate;
	get_recs := BankruptcyV2.file_bankruptcy_main(~isFCRA OR fcra.bankrupt_is_ok (todaysdate,date_filed));
	FCRATest:=if(isFCRA,get_recs(court_code+case_number not in dops.SuppressID('bankruptcy').GetIDsAsSet(isFCRA)),get_recs);
	get_recs reformat(FCRATest l) := transform 
		self.filing_status := if(l.filing_status = 'Unknown' ,'',l.filing_status);
		self := l ; 
	end; 

	get_rec_clean := project(FCRATest , reformat(left)); 
	dist_id := distribute(get_rec_clean, hash(TMSID));
	sort_id := dedup(sort(dist_id, TMSID, -process_Date, local), TMSID,local);

	key_name := bankruptcyv2.BuildKeyName(isFCRA, 'main::tmsid');

	return index(sort_id,{tmsid},{sort_id},key_name);
end;


