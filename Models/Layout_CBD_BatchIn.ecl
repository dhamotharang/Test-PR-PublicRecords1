export Layout_CBD_BatchIn := RECORD
	unsigned4	seq;
	string30 acctno := '';
	string15 name_first := '';
	STRING30 name_middle;
	string20 name_last := '';
	STRING5  name_suffix;
	string65 street_addr := '';
	string10 prim_range := '';
	string2  predir := '';	
	string28 prim_name := '';	
	string4  suffix := '';	
	string2  postdir := '';	
	string10 unit_desig := '';	
	string8  sec_range := '';
	string30 p_city_name := '';
	string2  st := '';
	string5  z5 := '';
	string10 home_phone := '';
	string9  ssn := '';
	string50 email := '';
	STRING20 dl_number;
	STRING2  dl_state;
	string15 name_first_2 := '';
	string30 name_middle_2 := '';
	string20 name_last_2 := '';
	STRING5  name_suffix_2;
	string65 street_addr2 := '';
	string10 prim_range_2 := '';
	string2  predir_2 := '';	
	string28 prim_name_2 := '';	
	string4  suffix_2 := '';	
	string2  postdir_2 := '';	
	string10 unit_desig_2 := '';	
	string8  sec_range_2 := '';
	string30 city_2 := '';
	string2  state_2 := '';
	string5  z5_2 := '';
	string10 home_phone_2 := '';
	STRING45 ip_addr := '';
	string2  pymtmethod := '';
	string2  prodcode := '';
	string1  avscode := '';
	string6  orderamt := '';
	string3  numitems := '';
	string4  cidcode := '';
	string4  score1;
	string4  score2;
	string6  userdefined1;
	string6  userdefined2;
	string6  userdefined3;
	string6  userdefined4;
	string6  userdefined5;
	unsigned3 HistoryDateYYYYMM;
end;