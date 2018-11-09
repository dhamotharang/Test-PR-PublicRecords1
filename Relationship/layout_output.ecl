export layout_output := MODULE

export iter := RECORD
  unsigned6 did1;
  unsigned6 did2;
  integer2 cohabit_score;
  integer2 cohabit_cnt;
  integer2 coapt_score;
  integer2 coapt_cnt;
  integer2 copobox_score;
  integer2 copobox_cnt;
  integer2 cossn_score;
  integer2 cossn_cnt;
  integer2 copolicy_score;
  integer2 copolicy_cnt;
  integer2 coclaim_score;
  integer2 coclaim_cnt;
  integer2 coproperty_score;
  integer2 coproperty_cnt;
  integer2 bcoproperty_score;
  integer2 bcoproperty_cnt;
  integer2 coforeclosure_score;
  integer2 coforeclosure_cnt;
  integer2 bcoforeclosure_score;
  integer2 bcoforeclosure_cnt;
  integer2 colien_score;
  integer2 colien_cnt;
  integer2 bcolien_score;
  integer2 bcolien_cnt;
  integer2 cobankruptcy_score;
  integer2 cobankruptcy_cnt;
  integer2 bcobankruptcy_score;
  integer2 bcobankruptcy_cnt;
  integer2 covehicle_score;
  integer2 covehicle_cnt;
  integer2 coexperian_score;
  integer2 coexperian_cnt;
  integer2 cotransunion_score;
  integer2 cotransunion_cnt;
  integer2 coenclarity_score;
  integer2 coenclarity_cnt;
  integer2 coecrash_score;
  integer2 coecrash_cnt;
  integer2 bcoecrash_score;
  integer2 bcoecrash_cnt;
  integer2 cowatercraft_score;
  integer2 cowatercraft_cnt;
  integer2 coaircraft_score;
  integer2 coaircraft_cnt;
  integer2 comarriagedivorce_score;
  integer2 comarriagedivorce_cnt;
  integer2 coucc_score;
  integer2 coucc_cnt;
  integer2 coclue_score;
  integer2 coclue_cnt;
  integer2 cocc_score;
  integer2 cocc_cnt;
  integer2 lname_score;
  integer2 phone_score;
  integer2 dl_nbr_score;
  unsigned2 total_cnt;
  integer2 total_score;
 END;
 
export final := record
	 string15 type;
	 string10 confidence;
   iter;
	 string10 cluster;
	 string2  generation;
	 string1  gender;
	 unsigned4 lname_cnt;
	 // unsigned4 last_cohabit_date;
	 unsigned4 rel_dt_first_seen;
	 unsigned4 rel_dt_last_seen;
	 unsigned2 overlap_months;
	 unsigned4 hdr_dt_first_seen;
	 unsigned4 hdr_dt_last_seen;
	 unsigned2 age_first_seen;
	 boolean   isAnyLnameMatch;
	 boolean   isAnyPhoneMatch;
	 boolean   isEarlyLnameMatch;
	 boolean   isCurrLnameMatch;
	 boolean   isMixedLnameMatch;
	 string9   ssn1;
	 string9   ssn2;
	 unsigned4 dob1;
	 unsigned4 dob2;
	 string28 current_lname1,
	 string28 current_lname2,
	 string28 early_lname1,
	 string28 early_lname2,
	 string2 addr_ind1;
	 string2 addr_ind2;
	 unsigned6 r2rdid;
	 //string28 d1_current_lname;
	 //string28 d1_first_lname;
	 unsigned6 r2cnt;
	 boolean Personal;
	 boolean Business;
	 boolean Other;
 end;  
 
export titled := record
   final;
	 unsigned1 title,
 end;
 
export relTypeRec := record
		string rel_type;
		integer2 score;
		integer2 cnt
 end;

export normedRelTypeRec := record
		iter.did1;
		iter.did2;
		relTypeRec;
end;
 
export key := record
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
	unsigned1 title
 end;
 
 END;