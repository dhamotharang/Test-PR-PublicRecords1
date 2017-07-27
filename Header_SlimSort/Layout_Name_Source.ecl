export Layout_Name_Source := record
     string2   src;
     unsigned6 did;
     string20  fname;
     string20  lname;
     string10  prim_range;
     string28  prim_name;
     string5   zip;
     string1   mname;
     string8   sec_range;
     string5   name_suffix;
     string9   ssn;
     unsigned2 dob;
     unsigned2 dids_with_this_nm_addr          := 0;
     unsigned2 suffix_cnt_with_this_nm_addr    := 0;
     unsigned2 sec_range_cnt_with_this_nm_addr := 0;
     unsigned2 ssn_cnt_with_this_nm_addr       := 0;
     unsigned2 dob_cnt_with_this_nm_addr       := 0;
     unsigned2 mname_cnt_with_this_nm_addr     := 0;
     unsigned2 dids_with_this_nm_ssn           := 0;
     unsigned2 dob_cnt_with_this_nm_ssn        := 0;
	 
 END;

