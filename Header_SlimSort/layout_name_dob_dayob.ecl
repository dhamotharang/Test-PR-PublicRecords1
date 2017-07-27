export Layout_Name_DOB_dayob := record
 unsigned6   did;
 string20    fname;
 string20    mname;
 string20    lname;
 unsigned3   mob;
 unsigned1   dayob;
 string2	 alphinit := '';
 string2     st;
 string5     zip;
 unsigned2 dob_fnname_dids := 0;
 unsigned2 dob_fnmname_dids := 0;
 unsigned2 dob_fnname_zip_dids := 0;
 unsigned2 dob_fnname_dob_dids := 0;
 unsigned2 dob_fnname_st_dids := 0;
 boolean     near_name := false;
 
end;