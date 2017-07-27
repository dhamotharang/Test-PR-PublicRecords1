import header_slimsort;
d := header_slimsort.RawFile_Name_SSN(did > 0, ssn_dids < 50);

dis := distribute(d,hash((string)ssn));

export File_Name_SSN := d; //sort(dis,ssn,local) : persist('~HSS_name_ssn' + header_slimsort.version);