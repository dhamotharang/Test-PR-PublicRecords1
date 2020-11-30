IMPORT Address;

EXPORT layouts_ska := MODULE

EXPORT raw := RECORD //layout size (952)
  STRING5 TTL;                //Formerly PRENAME
  STRING40 FIRST_NAME;        //Changed from length of 15, 30
  STRING1 MIDDLE;
  STRING50 LAST_NAME;         //Changed from length of 15, 30
  STRING50 T1;                //Formerly TITLE and length 31
  STRING1 DO;                 //Changed from length of 1, 3
  STRING3 DEPTCODE;           //Formerly KEY_CODE
  STRING100 DEPT_EXPL;        //Formerly KEY_TITLE and length 31
  STRING150 COMPANY1;         //Formerly COMPANY and length of 31, 100
  STRING161 ADDRESS1;         //Formerly ADDRESS and length of 31, 80
  STRING30 CITY;              //Changed from length of 17
  STRING2 STATE;
  STRING10 ZIP;  
  STRING161 ADDRESS2;         //Changed from length of 31, 80
  STRING30 CITY2;             //Changed from length of 17
  STRING2 STATE2;
  STRING10 ZIP2;
  STRING5 FIPS;
  STRING12 PHONE;
  STRING3 SPEC;
  STRING100 SPEC_EXPL;        //Changed from length of 30
  STRING3 SPEC2;
  STRING3 SPEC3;
  STRING8 ID;                 //Changed from length of 7
  STRING8 PERSID;             //Changed from length of 7, 10
  STRING3 OWNER;
  STRING1 a_c_d;
  STRING1 EMAILAVAIL;        //Added as part of new layout
END;

EXPORT parserec :=  RECORD
   raw;
   STRING40 KEY_FILE;   
   STRING100 SPEC2_EXPL;
   STRING100 SPEC3_EXPL;
   Address.Layout_Clean_Name;
   STRING182 clean_address;
   STRING182 clean2_address;
END;

EXPORT raw_b := RECORD //layout size (606)
  STRING5 TTL;                //Formerly PRENAME
  STRING40 FIRST_NAME;        //Changed from length 15
  STRING1 MIDDLE;
  STRING50 LAST_NAME;         //Changed from length 15
  STRING50 T1;                //Formerly TITLE and length 31
  STRING3 DEPT_CODE;
  STRING31 DEPT_EXPL;
  STRING3 SPEC;
  STRING31 SPEC_EXPL;         //Changed from length 30
  STRING150 COMPANY1;         //Formerly COMPANY and length 31
  STRING161 ADDRESS1;         //Formerly ADDRESS and length 31
  STRING30 CITY;              //Changed from length 17
  STRING2 STATE;
  STRING10 ZIP;
  STRING3 AREA_CODE;
  STRING8 NUMBER;             //Formerly PHONE
  STRING8 ID;                 //Changed from length of 7
  STRING10 PERSID;            //Changed from length of 7
  STRING10 NIXIE_DATE;
  STRING1 a_c_d;
END;

EXPORT parse_ska_b := RECORD
  raw_b;
  STRING40 DEPT_FILE;  
  Address.Layout_Clean_Name;
	STRING182 clean_address;
END;

END;