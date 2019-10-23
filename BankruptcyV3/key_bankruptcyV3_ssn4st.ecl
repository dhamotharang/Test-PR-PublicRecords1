import ut,fcra, BankruptcyV2,dops;

//last 4 digits of SSN, DEBTORS ONLY index
export key_bankruptcyV3_ssn4st(boolean isFCRA = false) := function
	todaysdate := ut.GetDate;
	
	base_recs := BankruptcyV2.file_bankruptcy_search_v3;
	get_recs := base_recs(name_type ='D' AND 
	                     ((integer)ssn > 0  or (integer)app_ssn > 0 or (integer)ssnmatch > 0) and 
						 (~IsFCRA OR fcra.bankrupt_is_ok (todaysdate,process_date)));
	FCRATest:=if(isFCRA,get_recs(court_code+case_number not in dops.SuppressID('bankruptcy').GetIDsAsSet(isFCRA)),get_recs);
	temp_rec := record
		string4   ssnLast4;
		string2   state;
		string150 lname;      //will contain company name if lname is blank.
		string50  fname;
		FCRATest.tmsid;
	end;

	temp_rec treformatssn(FCRATest L) := transform
	    //ssns can be '####     ' where #### is last 4 digits, so pad ssns with leading zeros.
	    ssn := INTFORMAT((integer)L.ssn,9,1)[6..9];
	    app_ssn := INTFORMAT((integer)L.app_ssn,9,1)[6..9];
	    ssnmatch := INTFORMAT((integer)L.ssnmatch,9,1)[6..9];
	
		self.ssnLast4 := map ((integer)ssn > 0 => ssn,
		                      (integer)app_ssn > 0 => app_ssn,
                        	  (integer)ssnmatch > 0 => ssnmatch,
							  ''
		                      );
		self.state := L.court_code[1..2];
		self.lname := if (length(trim(L.lname))>0,L.lname,L.cname);
		self := L;
	end;

	slim_party := project(FCRATest,treformatssn(left));
	slim_dist   := distribute(slim_party((integer)ssnLast4 > 0), 
	                          hash( tmsid,ssnLast4,state,lname,fname));
	slim_sort   :=  sort(slim_dist, tmsid,ssnLast4,state,lname,fname,local);
	slim_dedup  := dedup(slim_sort, tmsid,ssnLast4,state,lname,fname,local);

	key_name := BankruptcyV3.BuildKeyName(isFCRA, 'ssn4st');
	
	return index(slim_dedup, {ssnLast4,state,lname,fname}, {TMSID}, key_name);
end;
