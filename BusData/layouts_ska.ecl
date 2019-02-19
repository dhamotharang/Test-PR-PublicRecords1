import Address;

EXPORT layouts_ska := module

export raw := record //layout size (556)
  // string5 PRENAME;
  string5 TTL;               //Formerly PRENAME
  // string15 FIRST_NAME;
  string30 FIRST_NAME;        //Changed from length of 15
  string1 MIDDLE;
  // string15 LAST_NAME;
  string30 LAST_NAME;         //Changed from length of 15
  // string31 TITLE;
  string31 T1;                //Formerly TITLE
  // string1 DO;
  string3 DO;                //Changed from length of 1
  // string3 KEY_CODE;
  string3 DEPTCODE;          //Formerly KEY_CODE
  // string31 KEY_TITLE;
  string31 DEPT_EXPL;         //Formerly KEY_TITLE
  // string31 COMPANY;
  string100 COMPANY1;          //Formerly COMPANY and length of 31
  // string31 ADDRESS;
  string80 ADDRESS1;          //Formerly ADDRESS and length of 31
  // string17 CITY;
  string30 CITY;              //Changed from length of 17
  string2 STATE;
  string10 ZIP;  
  // string31 ADDRESS2;
  string80 ADDRESS2;          //Changed from length of 31
  // string17 CITY2;
  string30 CITY2;             //Changed from length of 17
  string2 STATE2;
  string10 ZIP2;
  string5 FIPS;
  string12 PHONE;
  string3 SPEC;
  string30 SPEC_EXPL;
  string3 SPEC2;
  string3 SPEC3;
  string7 ID;
  // string7 PERSID;
  string10 PERSID;            //Changed from length of 7
  string3 OWNER;
  string1 EMAILAVAIL;        //Added as part of new layout
	// string1 lf;             //Removed
end;

export parserec :=  record
   // string5 PRENAME;
   string5 TTL;               //Formerly PRENAME
   // string15 FIRST_NAME;
   string30 FIRST_NAME;        //Changed from length of 15
   string1 MIDDLE;
   // string15 LAST_NAME;
   string30 LAST_NAME;         //Changed from length of 15
   // string31 TITLE;
   string31 T1;                //Formerly TITLE
   // string1 DO;
   string3 DO;                 //Changed from length of 1
   // string3 KEY_CODE;
   string3 DEPTCODE;           //Formerly KEY_CODE
   // string31 KEY_TITLE;
   string31 DEPT_EXPL;         //Formerly KEY_TITLE
   string40 KEY_FILE;
   // string31 COMPANY;
   string100 COMPANY1;         //Formerly COMPANY and length of 31
   // string31 ADDRESS;
   string80 ADDRESS1;          //Formerly ADDRESS and length of 31
   // string17 CITY;
   string30 CITY;              //Changed from length of 17
   string2 STATE;
   string10 ZIP;
   // string31 ADDRESS2;
   string80 ADDRESS2;          //Changed from length of 31
   // string17 CITY2;
   string30 CITY2;             //Changed from length of 17
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
   // string7 PERSID;
   string10 PERSID;            //Changed from length of 7
   string3 OWNER;
   string1 EMAILAVAIL;         //Added as part of new layout
   
   Address.Layout_Clean_Name;
   // string5 clntitle;
   // string20 fname;
   // string20 mname;
   // string20 lname;
   // string5 name_suffix;
   // string3 name_score;
   string182 clean_address;
   string182 clean2_address;

end;

export raw_b := record //layout size (264)
  // string5 PRENAME;
  string5 TTL;               //Formerly PRENAME
  string15 FIRST_NAME;
  string1 MIDDLE;
  string15 LAST_NAME;
  // string31 TITLE;
  string31 T1;                //Formerly TITLE
  string3 DEPT_CODE;
  string31 DEPT_EXPL;
  string3 SPEC;
  string30 SPEC_EXPL;
  // string31 COMPANY;
  string31 COMPANY1;          //Formerly COMPANY
  // string31 ADDRESS;
  string31 ADDRESS1;          //Formerly ADDRESS
  string17 CITY;
  string2 STATE;
  string10 ZIP;
  string3 AREA_CODE;
  // string8 PHONE;
  string8 NUMBER;             //Formerly PHONE
  string7 ID;
  // string7 PERSID;
  string10 PERSID;            //Changed from length of 7
  string10 NIXIE_DATE;
	// string1 lf;              //Removed
end;

export parse_ska_b := record
  // string5 PRENAME;
  string5 TTL;               //Formerly PRENAME
  string15 FIRST_NAME;
  string1 MIDDLE;
  string15 LAST_NAME;
  // string31 TITLE;
  string31 T1;                //Formerly TITLE
  string3 DEPT_CODE;
  string31 DEPT_EXPL;
  string3 SPEC;
  string30 SPEC_EXPL;
  string40 DEPT_FILE;
  // string31 COMPANY;
  string31 COMPANY1;          //Formerly COMPANY
  // string31 ADDRESS;
  string31 ADDRESS1;          //Formerly ADDRESS
  string17 CITY;
  string2 STATE;
  string10 ZIP;
  string3 AREA_CODE;
  // string8 PHONE;
  string8 NUMBER;             //Formerly PHONE
  string7 ID;
  // string7 PERSID;
  string10 PERSID;            //Changed from length of 7
  string10 NIXIE_DATE;
  
  Address.Layout_Clean_Name;
  // string5        clntitle;
  // string20       fname;
  // string20       mname;
  // string20       lname;
  // string5        name_suffix;
  // string3        name_score;	 
	string182 clean_address;
end;




end;