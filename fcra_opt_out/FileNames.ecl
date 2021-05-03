IMPORT	versioncontrol;
EXPORT	FileNames(STRING pVersion='',BOOLEAN pUseProd=FALSE)	:=	MODULE

	EXPORT	lBase        		:=	'~thor_data400::base::fcra::@version@::optout';
	EXPORT	lBaseDelta  		:=	'~thor_data400::base::fcra::@version@::optout_daily';
	EXPORT	lBaseFullReplace    :=	'~thor_data400::base::fcra::@version@::optout_monthly';

	EXPORT	Base		        :=	MODULE
		EXPORT	OptOut  	   		:=	versioncontrol.mBuildFilenameVersions(lBase,pVersion);
		EXPORT	Delta	        	:=	versioncontrol.mBuildFilenameVersions(lBaseDelta,pVersion);
		EXPORT	FullReplace     	:= 	versioncontrol.mBuildFilenameVersions(lBaseFullReplace,pVersion);
		EXPORT  OptOutPrevious		:=  '~thor_data400::base::fcra::previous::optout';
	END;

END;