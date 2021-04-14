IMPORT tools;

EXPORT Filenames(

	 string		pversion							= ''
	,boolean	pUseOtherEnvironment	= false

) :=
MODULE

	shared lversiondate	:= pversion;
	shared lInputRoot		:= _Constants(pUseOtherEnvironment).InputTemplate;	
	shared lfileRoot		:= _Constants(pUseOtherEnvironment).FileTemplate;
	
	EXPORT Input := 
	MODULE
		EXPORT Adds		:= tools.mod_FilenamesInput(lInputRoot + 'Adds', lversiondate);
		EXPORT Dels		:= tools.mod_FilenamesInput(lInputRoot + 'Dels', lversiondate);
		
		EXPORT dAll_filenames :=	Adds.dAll_filenames
														+	Dels.dAll_filenames; 
	END;
	
	EXPORT Base		:= 
	MODULE
		EXPORT Tradeline 	:= tools.mod_FilenamesBuild(lfileRoot + 'Tradeline', lversiondate);
					     
		EXPORT dAll_filenames :=	Tradeline.dAll_filenames;
	END;

END;