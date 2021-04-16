Import Data_Services, doxie_files, doxie,ut,lib_stringlib,Lib_FileServices;

f_sanctn_aka_dba := SANCTN.file_base_party_aka_dba;

KeyName 			:= 'thor_data400::key::sanctn::';

layout_SANCTN_aka_dba_key := RECORD
  SANCTN.layout_SANCTN_aka_dba_base AND NOT [RECORD_TYPE,LAST_NAME,FIRST_NAME,MIDDLE_NAME];
END;

f_sanctn_aka_dba_new := project(f_sanctn_aka_dba , TRANSFORM(layout_SANCTN_aka_dba_key, SELF := LEFT));


export key_party_aka_dba := index(f_sanctn_aka_dba_new
                                ,{BATCH_NUMBER,INCIDENT_NUMBER,PARTY_NUMBER}
																,{f_sanctn_aka_dba_new}
																,Data_Services.Data_location.Prefix('sanctn')+KeyName +'party_aka_dba_'+doxie.Version_SuperKey);
																
																
