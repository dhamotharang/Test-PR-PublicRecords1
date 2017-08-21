import doxie, doxie_build, hygenics_search;

df 								:= File_Offenders_Risk;

string file_name 	:= '~thor_data400::key::corrections_offenders_risk::did_'+doxie_build.buildstate + '_' + doxie.Version_SuperKey;

export Key_Offenders_Risk := index(df,{unsigned6 sdid := (integer)df.did},{df}, file_name);
