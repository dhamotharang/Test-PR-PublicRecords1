export Layout_keys := module

export rAddress3 := 
record
  qstring10 prim_range;
  qstring28 prim_name;
  qstring5 zip;
  string20 fname_preferredname;
  qstring20 fname;
  qstring20 mname;
  qstring20 lname;
  unsigned6 did;
  unsigned2 dob_year;
  unsigned1 dob_month;
  unsigned1 dob_day;
  qstring8 sec_range;
  unsigned2 prim_range_weight100;
  unsigned2 prim_range_e1_weight100;
  unsigned2 prim_name_weight100;
  unsigned2 prim_name_e1_weight100;
  unsigned2 zip_weight100;
  unsigned2 fname_weight100;
  unsigned2 fname_p_weight100;
  unsigned2 fname_e2_weight100;
  unsigned2 fname_e2p_weight100;
  unsigned2 fname_preferredname_weight100;
  unsigned2 mname_weight100;
  unsigned2 mname_e2_weight100;
  unsigned2 lname_weight100;
  unsigned2 lname_p_weight100;
  unsigned2 lname_e2_weight100;
  unsigned2 lname_e2p_weight100;
  unsigned2 dob_year_weight100;
  unsigned2 dob_month_weight100;
  unsigned2 dob_day_weight100;
  unsigned2 sec_range_weight100;
  unsigned2 fname_initial_weight100;
  unsigned2 mname_initial_weight100;
	end;	

export rDOB :=
record
  unsigned2 dob_year;
  unsigned1 dob_month;
  unsigned1 dob_day;
  qstring20 lname;
  string20 fname_preferredname;
  qstring20 fname;
  unsigned6 did;
  string2 state;
  qstring25 city;
  qstring5 ssn5;
  qstring4 ssn4;
  qstring20 mname;
  unsigned2 dob_year_weight100;
  unsigned2 dob_month_weight100;
  unsigned2 dob_day_weight100;
  unsigned2 lname_weight100;
  unsigned2 lname_p_weight100;
  unsigned2 lname_e2_weight100;
  unsigned2 lname_e2p_weight100;
  unsigned2 fname_weight100;
  unsigned2 fname_p_weight100;
  unsigned2 fname_e2_weight100;
  unsigned2 fname_e2p_weight100;
  unsigned2 fname_preferredname_weight100;
  unsigned2 state_weight100;
  unsigned2 city_weight100;
  unsigned2 ssn5_weight100;
  unsigned2 ssn5_e1_weight100;
  unsigned2 ssn4_weight100;
  unsigned2 ssn4_e1_weight100;
  unsigned2 mname_weight100;
  unsigned2 mname_e2_weight100;
  unsigned2 fname_initial_weight100;
  unsigned2 mname_initial_weight100;
	end;
	
export rSSN := record

  qstring5 ssn5;
  qstring4 ssn4;
  string20 fname_preferredname;
  qstring20 fname;
  qstring20 mname;
  qstring20 lname;
  unsigned6 did;
  unsigned2 dob_year;
  unsigned1 dob_month;
  unsigned1 dob_day;
  qstring25 city;
  string2 state;
  unsigned2 ssn5_weight100;
  unsigned2 ssn5_e1_weight100;
  unsigned2 ssn4_weight100;
  unsigned2 ssn4_e1_weight100;
  unsigned2 fname_weight100;
  unsigned2 fname_p_weight100;
  unsigned2 fname_e2_weight100;
  unsigned2 fname_e2p_weight100;
  unsigned2 fname_preferredname_weight100;
  unsigned2 mname_weight100;
  unsigned2 mname_e2_weight100;
  unsigned2 lname_weight100;
  unsigned2 lname_p_weight100;
  unsigned2 lname_e2_weight100;
  unsigned2 lname_e2p_weight100;
  unsigned2 dob_year_weight100;
  unsigned2 dob_month_weight100;
  unsigned2 dob_day_weight100;
  unsigned2 city_weight100;
  unsigned2 state_weight100;
  unsigned2 fname_initial_weight100;
  unsigned2 mname_initial_weight100;
	end;
	
export rSSN4 := record
  qstring4 ssn4;
  string20 fname_preferredname;
  qstring20 fname;
  qstring20 lname;
  unsigned6 did;
  unsigned2 dob_year;
  unsigned1 dob_month;
  unsigned1 dob_day;
  qstring5 ssn5;
  unsigned2 ssn4_weight100;
  unsigned2 ssn4_e1_weight100;
  unsigned2 fname_weight100;
  unsigned2 fname_p_weight100;
  unsigned2 fname_e2_weight100;
  unsigned2 fname_e2p_weight100;
  unsigned2 fname_preferredname_weight100;
  unsigned2 lname_weight100;
  unsigned2 lname_p_weight100;
  unsigned2 lname_e2_weight100;
  unsigned2 lname_e2p_weight100;
  unsigned2 dob_year_weight100;
  unsigned2 dob_month_weight100;
  unsigned2 dob_day_weight100;
  unsigned2 ssn5_weight100;
  unsigned2 ssn5_e1_weight100;
	end;

export rPHONE := record

  qstring10 phone;
  string20 fname_preferredname;
  qstring20 fname;
  qstring20 mname;
  qstring20 lname;
  unsigned2 dob_year;
  unsigned1 dob_month;
  unsigned1 dob_day;
  unsigned6 did;
  qstring25 city;
  string2 state;
  qstring5 ssn5;
  qstring4 ssn4;
  unsigned2 phone_weight100;
  unsigned2 fname_weight100;
  unsigned2 fname_p_weight100;
  unsigned2 fname_e2_weight100;
  unsigned2 fname_e2p_weight100;
  unsigned2 fname_preferredname_weight100;
  unsigned2 mname_weight100;
  unsigned2 mname_e2_weight100;
  unsigned2 lname_weight100;
  unsigned2 lname_p_weight100;
  unsigned2 lname_e2_weight100;
  unsigned2 lname_e2p_weight100;
  unsigned2 dob_year_weight100;
  unsigned2 dob_month_weight100;
  unsigned2 dob_day_weight100;
  unsigned2 city_weight100;
  unsigned2 state_weight100;
  unsigned2 ssn5_weight100;
  unsigned2 ssn5_e1_weight100;
  unsigned2 ssn4_weight100;
  unsigned2 ssn4_e1_weight100;
  unsigned2 fname_initial_weight100;
  unsigned2 mname_initial_weight100;
	end;
	
export rZPRF := record
  qstring5 zip;
  qstring10 prim_range;
  string20 fname_preferredname;
  qstring20 fname;
  unsigned6 did;
  qstring20 lname;
  qstring28 prim_name;
  qstring8 sec_range;
  unsigned2 dob_year;
  unsigned1 dob_month;
  unsigned1 dob_day;
  unsigned2 zip_weight100;
  unsigned2 prim_range_weight100;
  unsigned2 prim_range_e1_weight100;
  unsigned2 fname_weight100;
  unsigned2 fname_p_weight100;
  unsigned2 fname_e2_weight100;
  unsigned2 fname_e2p_weight100;
  unsigned2 fname_preferredname_weight100;
  unsigned2 lname_weight100;
  unsigned2 lname_p_weight100;
  unsigned2 lname_e2_weight100;
  unsigned2 lname_e2p_weight100;
  unsigned2 prim_name_weight100;
  unsigned2 prim_name_e1_weight100;
  unsigned2 sec_range_weight100;
  unsigned2 dob_year_weight100;
  unsigned2 dob_month_weight100;
  unsigned2 dob_day_weight100;
  unsigned2 fname_initial_weight100;
	end;

export rLFZ := record
  qstring20 lname;
  string20 fname_preferredname;
  qstring20 fname;
  qstring5 zip;
  unsigned6 did;
  qstring25 city;
  qstring10 prim_range;
  qstring28 prim_name;
  qstring5 ssn5;
  qstring4 ssn4;
  qstring20 mname;
  qstring8 sec_range;
  qstring5 name_suffix;
  unsigned2 dob_year;
  unsigned1 dob_month;
  unsigned1 dob_day;
  unsigned2 lname_weight100;
  unsigned2 lname_p_weight100;
  unsigned2 lname_e2_weight100;
  unsigned2 lname_e2p_weight100;
  unsigned2 fname_weight100;
  unsigned2 fname_p_weight100;
  unsigned2 fname_e2_weight100;
  unsigned2 fname_e2p_weight100;
  unsigned2 fname_preferredname_weight100;
  unsigned2 zip_weight100;
  unsigned2 city_weight100;
  unsigned2 prim_range_weight100;
  unsigned2 prim_range_e1_weight100;
  unsigned2 prim_name_weight100;
  unsigned2 prim_name_e1_weight100;
  unsigned2 ssn5_weight100;
  unsigned2 ssn5_e1_weight100;
  unsigned2 ssn4_weight100;
  unsigned2 ssn4_e1_weight100;
  unsigned2 mname_weight100;
  unsigned2 mname_e2_weight100;
  unsigned2 sec_range_weight100;
  unsigned2 name_suffix_weight100;
  unsigned2 name_suffix_e2_weight100;
  unsigned2 dob_year_weight100;
  unsigned2 dob_month_weight100;
  unsigned2 dob_day_weight100;
  unsigned2 mname_initial_weight100;
 END;

end;