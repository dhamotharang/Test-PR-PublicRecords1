IMPORT tools,versioncontrol;

EXPORT _Dataset(BOOLEAN	pUseProd = FALSE) := module
					export pDatasetName			:=	'FirstData';
					export pGroupname				:=	'thor400_dev';
					export pMaxRecordSize		:=	8192;
					export thor_cluster_Files			:= 	if(pUseProd,VersionControl.foreign_prod + 'thor_data400::','~thor_data400::');
					export pIsTesting				:=	Tools._Constants.IsDataland;
END;