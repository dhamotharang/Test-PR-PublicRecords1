r1 := RECORD
  string2 src;
  unsigned integer6 did;
  string20 fname;
  string20 lname;
  string10 prim_range;
  string28 prim_name;
  string5 zip;
  string1 mname;
  string8 sec_range;
  string5 name_suffix;
  string4 ssn;
  integer8 dob;
  integer8 dids_with_this_nm_addr;
  integer8 suffix_cnt_with_this_nm_addr;
  integer8 sec_range_cnt_with_this_nm_addr;
  integer8 ssn_cnt_with_this_nm_addr;
  integer8 dob_cnt_with_this_nm_addr;
  integer8 mname_cnt_with_this_nm_addr;
 END;

export file_header_nmsrc := dataset('~thor_data400::base::header_nmsrc',r1,flat);