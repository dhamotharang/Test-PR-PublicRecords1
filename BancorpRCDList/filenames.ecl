import BancorpRCDList,VersionControl;
EXPORT Filenames (STRING	pversion	=	'',
									BOOLEAN	pUseProd	=	FALSE)	:=	MODULE
									
	EXPORT	lInputTemplate	:=	_Dataset(pUseProd).thor_cluster_files	+	'in::'			+	_Dataset().name	+	'::@version@';
	EXPORT	lBaseTemplate		:=	_Dataset(pUseProd).thor_cluster_files	+	'base::'		+	_Dataset().name	+	'::@version@';
	
	EXPORT	Input:= versioncontrol.mInputFilenameVersions(lInputTemplate);
	
	EXPORT	Base		:=	MODULE
		EXPORT	RCDList	:=	versioncontrol.mBuildFilenameVersions(lBaseTemplate	+	'BancorpRCDList'		,pVersion);

		EXPORT	dAll_filenames	:=
			RCDList.dAll_filenames
		;
	END;
	


	EXPORT	dAll_filenames	:=
			Base.dAll_filenames
		;

end;