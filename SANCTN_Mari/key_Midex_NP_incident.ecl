import doxie_files, doxie, ut, SANCTN_Mari,Data_Services;

f_sanctn_incident := SANCTN_Mari.files_SANCTN_DID.incident_did;
layout_incident_base	:=sanctn_mari.layouts_SANCTN_common.SANCTN_incident_base;

KeyName 			:= 'thor_data400::key::sanctn::np::';
			
dsIncident := project(f_sanctn_incident,transform(layout_incident_base,self:=left));
dsIncident_dedup := DEDUP(dsIncident,RECORD);	

export key_Midex_NP_incident := index(dsIncident_dedup
																		,{INCIDENT_NUM}
																		,{dsIncident_dedup}
																		,Data_Services.Data_Location.Prefix('sanctn')+ KeyName +doxie.Version_SuperKey+ '::incident');
		
