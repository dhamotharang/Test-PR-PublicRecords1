

IMPORT	versioncontrol;
EXPORT	Filenames(STRING	pVersion	=	'',
									BOOLEAN	pUseProd	=	FALSE)	:=	MODULE

	EXPORT	lInputTemplate	:=	_Dataset(pUseProd).thor_cluster_files	+	'in::'		+	_Dataset().name	+	'::@version@::';
	EXPORT	lBaseTemplate		:=	_Dataset(pUseProd).thor_cluster_files	+	'base::'	+	_Dataset().name	+	'::@version@::';
	EXPORT	lOutTemplate		:=	_Dataset(pUseProd).thor_cluster_files	+	'out::'		+	_Dataset().name	+	'::@version@::';

	EXPORT	Input						:=	MODULE
	
	  //list all raw inputs here
		EXPORT	Consumer	:=	versioncontrol.mInputFilenameVersions(lInputTemplate	+	'consumer',	pVersion);      
		
		EXPORT	dAll_filenames	:= Consumer.dAll_filenames;		
	END;

	EXPORT	Base	:=	MODULE
	
	  //list all base files here
		EXPORT	Consumer	:=	versioncontrol.mBuildFilenameVersions(lBaseTemplate	+	'consumer',pVersion);
   
		EXPORT	dAll_filenames	:=	Consumer.dAll_filenames;
	END;

	EXPORT	dAll_filenames	:=  Base.dAll_filenames;
END;
