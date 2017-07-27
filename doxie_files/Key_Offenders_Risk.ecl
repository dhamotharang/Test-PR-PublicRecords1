Import Data_Services, doxie_build,doxie, ut, hygenics_search;

df 								:= File_Offenders_Risk;
string file_name 	:= Data_Services.Data_location.Prefix('Criminal')+'thor_data400::key::corrections_offenders_risk::did_'+doxie_build.buildstate + '_' + doxie.Version_SuperKey;

export Key_Offenders_Risk := index(df,{unsigned6 sdid := (integer)df.did},{df}, file_name);
