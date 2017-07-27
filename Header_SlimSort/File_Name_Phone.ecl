d := header_slimsort.RawFile_Name_Phone(did > 0);
export file_name_phone := d; //distribute(d, hash((string)phone)) : persist('~HSS_Name_Phone' + header_slimsort.version);