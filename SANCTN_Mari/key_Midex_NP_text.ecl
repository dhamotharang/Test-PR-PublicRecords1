import doxie_files, doxie,ut,sanctn_mari,Data_Services;

// #option('maxLength', 6000);

f_sanctn_incidenttext :=	SANCTN_Mari.files_SANCTN_common.incident_text;

layout_incident_text	:= RECORD, MAXLENGTH(9000)
sanctn_mari.layouts_SANCTN_common.SANCTN_incident_text;

END;

dsIncidentText := project(f_sanctn_incidenttext,transform(layout_incident_text,self:=left));

KeyName 			:= 'thor_data400::key::sanctn::np::';



export key_Midex_NP_text := index(dsIncidentText
																	,{INCIDENT_NUM}
																	,{dsIncidentText}
																	,Data_Services.Data_Location.Prefix('sanctn')+ KeyName +doxie.Version_SuperKey+ '::incidenttext');
																	
