Import _Control, VersionControl, Data_Services;

Export _Dataset( Boolean pUseProd = False ) := Module

	Export name	:= 'Header_Anomalies_Report';
	
	Export thor_cluster_Files := 	if(pUseProd, 
									Data_Services.foreign_prod + '~thor_data400::', '~thor_data400::'
									);

	Export thor_cluster_Persists := thor_cluster_Files;

	Export max_record_size := 40000;

	Export Groupname	:= versioncontrol.Groupname();

End;