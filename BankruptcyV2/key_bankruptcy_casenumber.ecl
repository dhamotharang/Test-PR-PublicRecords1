import fcra, Doxie, ut,dops;

export key_bankruptcy_casenumber(boolean isFCRA = false) := function
  todaysdate := ut.GetDate;
	get_recs := BankruptcyV2.file_bankruptcy_main(~IsFCRA OR fcra.bankrupt_is_ok (todaysdate,date_filed));

	slim_rec := record
		get_recs.tmsid;
		get_recs.court_code;
		get_recs.orig_case_number;
		get_recs.case_number;
		string2 filing_state ;
	end;

	strip_leadingzeroes(string25 number) := regexreplace('^[ |0]*',number,'');
	FCRATest:=if(isFCRA,get_recs(court_code+case_number not in dops.SuppressID('bankruptcy').GetIDsAsSet(isFCRA)),get_recs);
	slim_rec tslim(FCRATest L, integer cnt) := transform
		string25 s_case_number        := if(strip_leadingzeroes(L.case_number)   <> '', L.case_number, ''); 
		string25 s_orig_case_number   := if(strip_leadingzeroes(L.orig_case_number)   <> '', L.orig_case_number, ''); 
		self.case_number := choose(cnt, s_case_number, s_orig_case_number);						  	
		self.filing_state  := l.filing_jurisdiction ;					                        
		self := L;
	end;
			   
	slim_file := normalize(FCRATest(case_number <> '' or orig_case_number <> '' ), 2, tslim(left, counter));

	slim_rec tformat(slim_rec L, integer cnt) := transform
		self.case_number := choose(cnt, L.case_number, strip_leadingzeroes(L.case_number));
		self := L;
	end;

	slim_norm := normalize(slim_file(case_number<> ''), 2, tformat(left, counter));
	slim_dist  := distribute(slim_norm, hash(tmsid, case_number, filing_state));
	slim_sort  := sort(slim_dist, tmsid, case_number,filing_state, local);
	slim_dedup := dedup(slim_sort, tmsid, case_number, filing_state, local);

	key_name := BuildKeyName(isFCRA,'case_number');

	return index(slim_dedup,{case_number, filing_state},{TMSID}, key_name);
end;