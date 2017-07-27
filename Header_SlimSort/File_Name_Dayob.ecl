import header_slimsort;
d := header_slimsort.RawFile_Name_Dayob(did > 0);
export file_name_dayob := d; //distribute(d, hash(mob,trim((string)lname))) : persist('~HSS_Name_Dayob' + header_slimsort.version);