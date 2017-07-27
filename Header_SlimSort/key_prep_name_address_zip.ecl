df := dataset('~thor_Data400::base::hss_name_address_BUILDING',header_slimsort.Layout_Name_Address,flat);

df2 := df(safe_name_zip > 0, (integer)zip != 0);

export key_prep_name_address_zip := index(df2,{fname,lname,
     safe_name_zip,zip,dt_last_seen,did},'~thor_data400::key::file_name_zip_' + thorlib.wuid());