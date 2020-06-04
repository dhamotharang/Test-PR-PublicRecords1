IMPORT  tools;

EXPORT Filenames(
	 
	 STRING		pversion							= ''
	,BOOLEAN	pUseOtherEnvironment	= FALSE

) := MODULE

	SHARED lversiondate	:= pversion;
	SHARED lInputRoot		:= _Constants(pUseOtherEnvironment).InputTemplate	+ 'data'	;
	SHARED lfileRoot		:= _Constants(pUseOtherEnvironment).FileTemplate	+ 'data'	;

	EXPORT Input	      := tools.mod_FilenamesInput(lInputRoot ,lversiondate);
	EXPORT Base		      := tools.mod_FilenamesBuild(lfileRoot  ,lversiondate);
		     
	EXPORT dAll_filenames := Base.dAll_filenames; 

END;