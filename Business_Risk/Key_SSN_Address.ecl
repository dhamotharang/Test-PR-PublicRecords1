import header, doxie,ut;

df := header.file_headers(length(trim(ssn)) = 9);

df2 := dedup(sort(distribute(df,hash(ssn)), ssn, lname, fname, prim_range, prim_name, -mname, local), ssn, lname, fname, prim_range, prim_name, local);

export Key_SSN_Address := index(df2,{ssn, prim_name},{lname, fname, mname, prim_range, sec_range,zip},ut.Data_Location.Person_header+'thor_data400::key::header_ssn_Address_' + doxie.Version_SuperKey);
