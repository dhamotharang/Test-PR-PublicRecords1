import doxie_files, doxie,ut,sanctn_mari,Data_Services;	

f_sanctn_party_aka_dba :=	SANCTN_Mari.files_SANCTN_common.party_aka_dba;

KeyName 			:= 'thor_data400::key::sanctn::np::';



layout_party_aka_dba_key := record
  SANCTN_Mari.layouts_SANCTN_common.party_aka_dba AND NOT [FIRST_NAME,MIDDLE_NAME,LAST_NAME,PARTY_KEY];
END;
	

f_sanctn_party_aka_dba_new := project(f_sanctn_party_aka_dba, TRANSFORM(layout_party_aka_dba_key, SELF := LEFT));
 
	
		
export key_party_aka_dba  := index(f_sanctn_party_aka_dba_new
																	, {BATCH,INCIDENT_NUM,PARTY_NUM}
																	,{f_sanctn_party_aka_dba_new}
																	,Data_Services.Data_Location.Prefix('sanctn')+ Keyname + doxie.Version_SuperKey +'::party_aka_dba');
																	
																	
											
																	
