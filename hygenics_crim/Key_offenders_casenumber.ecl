Import Data_Services, doxie_build,doxie,Data_Services;


key_layout := RECORD
hygenics_crim.file_offenders_keybuilding.case_num;
hygenics_crim.file_offenders_keybuilding.offender_key;
string1 file_indicator;
END;

df := dataset([],key_layout);

EXPORT Key_offenders_casenumber := index(df,{df.case_num},{df.offender_key,df.file_indicator},Data_Services.Data_location.Prefix('Provider')+'thor_data400::key::corrections_Offenders_casenumber_' + doxie_build.buildstate + '_' + doxie.Version_SuperKey);
