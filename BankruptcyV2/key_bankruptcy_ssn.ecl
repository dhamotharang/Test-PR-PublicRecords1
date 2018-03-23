import Doxie, ut, fcra,dops;

export key_bankruptcy_ssn(boolean isFCRA = false) := function
	todaysdate := ut.GetDate;
	get_recs := BankruptcyV2.file_bankruptcy_search(~IsFCRA OR fcra.bankrupt_is_ok (todaysdate,process_date));
FCRATest:=if(isFCRA,get_recs(court_code+case_number not in dops.SuppressID('bankruptcy').GetIDsAsSet(isFCRA)),get_recs);
	temp_rec := record
		FCRATest.ssn;
		FCRATest.tmsid;
	end;

	temp_rec treformatssn(BankruptcyV2.file_bankruptcy_search L) := transform
		self.ssn := if((unsigned6)L.ssn <> 0,L.ssn, L.app_ssn);
		self := L;
	end;

	slim_party := project(FCRATest,treformatssn(left));
	slim_dist   := distribute(slim_party(ssn <> ''), hash(tmsid, ssn));
	slim_sort   := sort(slim_dist, tmsid,  ssn, local);
	slim_dedup  := dedup(slim_sort, tmsid, ssn, local);

	key_name := BuildKeyName(isFCRA, 'SSN');
	
	return index(slim_dedup, {ssn}, {TMSID}, key_name);
end;
