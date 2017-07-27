import doxie_files, doxie,ut,sanctn_mari,Data_Services;	

KeyName 			:= 'thor_data400::key::sanctn::np::';

f_sanctn_incidentcode :=	SANCTN_Mari.files_SANCTN_common.incident_codes;
layout_Midex_cd	:=sanctn_mari.layouts_SANCTN_common.Midex_cd;
		
dsIncidentCd := project(f_sanctn_incidentcode,transform(layout_Midex_cd,self:=left));	
		
export key_Midex_NP_codes := index(dsIncidentCd
																	, {INCIDENT_NUM}
																	,{dsIncidentCd}
																	,Data_Services.Data_Location.Prefix('sanctn')+ KeyName + doxie.Version_SuperKey+ '::incidentcode');


