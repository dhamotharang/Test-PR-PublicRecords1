IMPORT $, _control, doxie, data_services;

#IF(_control.environment.onThor and ~_control.Environment.onVault)
	InFile := $.Layouts.Layout_ExecLinkID;
#ELSE
	InFile := dataset([], $.Layout_ExecLinkID);
#END
				
EXPORT Key_Executive_Link_Id := INDEX({InFile.Link_ID, InFile.persistent_record_id}, {InFile},
																			data_services.Data_Location.Prefix('')+'thor_data400::key::cortera::' + doxie.version_superkey + '::executive_linkid');