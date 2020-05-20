IMPORT tools, SICCodes;

EXPORT Filenames(
	 
	 STRING		pversion							= ''
	,BOOLEAN	pUseOtherEnvironment	= FALSE

) := MODULE

	SHARED lversiondate	:= pversion;
	SHARED lInputRoot		:= SICCodes._Constants(pUseOtherEnvironment).InputTemplate	+ 'lookup'	;
	SHARED lfileRoot		:= SICCodes._Constants(pUseOtherEnvironment).FileTemplate	+ 'lookup'	;

	EXPORT Input	      := tools.mod_FilenamesInput(lInputRoot ,lversiondate);
	EXPORT SICLookup		:= tools.mod_FilenamesBuild(lfileRoot  ,lversiondate);
		     
	EXPORT dAll_filenames := SICLookup.dAll_filenames; 

END;