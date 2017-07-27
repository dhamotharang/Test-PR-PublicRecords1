IMPORT FFD;
export layout_ssn_records := record
  string1 Input;
  string9  ssn;
  unsigned8 cnt;
  string20 fname;
  string30 mname;
  string20 lname;
  string5  name_suffix;
  unsigned4 first_seen;
  unsigned4 last_seen;
  string4 dead;
  integer4 youngest_age;
  integer4 oldest_age;
  unsigned6 did;
  string30 comment;
	boolean likely_fragment;
	unsigned4 dob;
	unsigned1 age;
  unsigned4 SSN_Issue_Early;
  unsigned4 SSN_Issue_Last;

  // if increased, iesp.share.t_SSNInfo should be modified as well.
  string32  SSN_Issue_Place; //the longest so far is "Guam or Samoa or The Philippines";
  boolean	valid;
  string9	ssn_unmasked := '';
	string5 current_name := '';
	string5 subject_ssn_indicator := '';
	string5 correct_dob := '';
	STRING8  util_connect_date := '';
	STRING30 util_type := '';
	
	unsigned2 fdn_did_ind   := 0; // Added for the FDN project.
	unsigned2 fdn_ssn_ind   := 0; // Added for the FDN project.
	FFD.Layouts.CommonRawRecordElements;
end;