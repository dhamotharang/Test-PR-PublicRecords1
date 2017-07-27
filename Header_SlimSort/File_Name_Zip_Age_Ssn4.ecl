import ut;


ds := header_slimsort.RawFile_Name_Zip_Age_Ssn4;

tf(STRING fname) := datalib.preferredfirstNew(fname, Header_Slimsort.Constants.UsePFNew);
dist := DISTRIBUTE(ds, HASH((QSTRING)(lname), (QSTRING)(tf(fname)[1])));

export File_Name_Zip_Age_Ssn4 := ds; //dist : PERSIST('~HSS_name_zip_age_ssn4'+header_slimsort.version);