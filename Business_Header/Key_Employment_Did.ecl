import doxie;

df := business_header.File_Employment_Keybuild((integer)did != 0);

export Key_Employment_Did := 
       index(df,{unsigned6 sdid := (integer)df.did}, {df}, 
                '~thor_data400::key::employment_did_' + doxie.Version_SuperKey);
