import doxie, business_header;

df := business_header.File_Employment_Keybuild(bdid != '');

export key_employment_bdid := index(df,{unsigned6 newbdid := (integer) df.bdid}, {df}, 
                '~thor_data400::key::employment_bdid_' + doxie.Version_SuperKey);