Import Data_Services, doxie_files, doxie,ut,lib_stringlib,Lib_FileServices;

f_sanctn_rebuttal := SANCTN.file_base_rebuttal;

KeyName 			:= 'thor_data400::key::sanctn::';

layout_SANCTN_rebuttal_key := RECORD
  SANCTN.layout_SANCTN_rebuttal_Base AND NOT [RECORD_TYPE];
END;

f_sanctn_rebuttal_new := project(f_sanctn_rebuttal, TRANSFORM(layout_SANCTN_rebuttal_key, SELF := LEFT));


export key_rebuttal_text := index(f_sanctn_rebuttal_new
                                ,{BATCH_NUMBER,INCIDENT_NUMBER,PARTY_NUMBER}
																,{f_sanctn_rebuttal_new}
																,Data_Services.Data_location.Prefix('sanctn')+KeyName +'rebuttal_'+doxie.Version_SuperKey);
																

