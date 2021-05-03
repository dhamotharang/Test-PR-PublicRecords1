EXPORT layouts := MODULE


	reltyperec := RECORD
	 string rel_type;
	 integer2 score;
	 integer2 cnt;
	END;
	
	
	EXPORT recNthDegree := RECORD
		unsigned6 did1;
		unsigned6 did2;
		string15 type;
		string10 confidence;
		dataset(relTypeRec) rels;
		integer2 lname_score;
		integer2 phone_score;
		integer2 dl_nbr_score;
		unsigned2 total_cnt;
		integer2 total_score;
		string10 cluster;
		string2 generation;
		string1 gender;
		unsigned4 lname_cnt;
		unsigned4 rel_dt_first_seen;
		unsigned4 rel_dt_last_seen;
		unsigned2 overlap_months;
		unsigned4 hdr_dt_first_seen;
		unsigned4 hdr_dt_last_seen;
		unsigned2 age_first_seen;
		boolean isAnyLnameMatch;
		boolean isAnyPhoneMatch;
		boolean isEarlyLnameMatch;
		boolean isCurrLnameMatch;
		boolean isMixedLnameMatch;
		string9 ssn1;
		string9 ssn2;
		unsigned4 dob1;
		unsigned4 dob2;
		string28 current_lname1;
		string28 current_lname2;
		string28 early_lname1;
		string28 early_lname2;
		string2 addr_ind1;
		string2 addr_ind2;
		unsigned6 r2rdid;
		unsigned6 r2cnt;
		boolean Personal;
		boolean Business;
		boolean Other;
		unsigned1 title;
		/*----CCPA Fields------*/
		unsigned4 GLOBAL_SID;
		unsigned8 RECORD_SID;
	 end;
	 

END;