import doxie, business_header;

df := filters.keys.peopleatwork(File_Employment_Keybuild((integer)bdid <> 0));

       

export key_employment_bdid := index(df,{unsigned6 newbdid := (integer) df.bdid}, {df}, 
                '~thor_data400::key::employment_bdid_' + doxie.Version_SuperKey);
								