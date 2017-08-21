import Address;

EXPORT layouts_ska := module

export raw := record //layout size (327)
  string5 PRENAME;
  string15 FIRST_NAME;
  string1 MIDDLE;
  string15 LAST_NAME;
  string31 TITLE;
  string1 DO;
  string3 KEY_CODE;
  string31 KEY_TITLE;
  string31 COMPANY;
  string31 ADDRESS;
  string17 CITY;
  string2 STATE;
  string10 ZIP;
  string31 ADDRESS2;
  string17 CITY2;
  string2 STATE2;
  string10 ZIP2;
  string5 FIPS;
  string12 PHONE;
  string3 SPEC;
  string30 SPEC_EXPL;
  string3 SPEC2;
  string3 SPEC3;
  string7 ID;
  string7 PERSID;
  string3 OWNER;
	string1 lf;
end;

export parserec :=  record
   string5 PRENAME;
   string15 FIRST_NAME;
   string1 MIDDLE;
   string15 LAST_NAME;
   string31 TITLE;
   string1 DO;
   string3 KEY_CODE;
   string31 KEY_TITLE;
   string40 KEY_FILE;
   string31 COMPANY;
   string31 ADDRESS;
   string17 CITY;
   string2 STATE;
   string10 ZIP;
   string31 ADDRESS2;
   string17 CITY2;
   string2 STATE2;
   string10 ZIP2;
   string5 FIPS;
   string12 PHONE;
   string3 SPEC;
   string31 SPEC_EXPL;
   string3 SPEC2;
   string40 SPEC2_EXPL;
   string3 SPEC3;
   string40 SPEC3_EXPL;
   string7 ID;
   string7 PERSID;
   string3 OWNER;
  string5        clntitle;
  string20       fname;
  string20       mname;
  string20       lname;
  string5        name_suffix;
  string3        name_score;
	 string182 clean_address;
   string182 clean2_address;

end;

export raw_b := record //layout size (261)
  string5 PRENAME;
  string15 FIRST_NAME;
  string1 MIDDLE;
  string15 LAST_NAME;
  string31 TITLE;
  string3 DEPT_CODE;
  string31 DEPT_EXPL;
  string3 SPEC;
  string30 SPEC_EXPL;
  string31 COMPANY;
  string31 ADDRESS;
  string17 CITY;
  string2 STATE;
  string10 ZIP;
  string3 AREA_CODE;
  string8 PHONE;
  string7 ID;
  string7 PERSID;
  string10 NIXIE_DATE;
	string1 lf;
end;

export parse_ska_b := record

  string5 PRENAME;
  string15 FIRST_NAME;
  string1 MIDDLE;
  string15 LAST_NAME;
  string31 TITLE;
  string3 DEPT_CODE;
  string31 DEPT_EXPL;
  string3 SPEC;
  string30 SPEC_EXPL;
  string40 DEPT_FILE;
	string31 COMPANY;
  string31 ADDRESS;
  string17 CITY;
  string2 STATE;
  string10 ZIP;
  string3 AREA_CODE;
	
  string8 PHONE;
  string7 ID;
  string7 PERSID;
  string10 NIXIE_DATE;
string5        clntitle;
  string20       fname;
  string20       mname;
  string20       lname;
  string5        name_suffix;
  string3        name_score;	 
	string182 clean_address;
end;




end;