IMPORT tools, NAICSCodes;

EXPORT Filenames(
	 
	 STRING		pversion							= ''
	,BOOLEAN	pUseOtherEnvironment	= FALSE

) := MODULE

	SHARED lversiondate	:= pversion;
	SHARED lInputRoot		:= NAICSCodes._Constants(pUseOtherEnvironment).InputTemplate	+ 'lookup'	;
	SHARED lfileRoot		:= NAICSCodes._Constants(pUseOtherEnvironment).FileTemplate	+ 'lookup'	;

	EXPORT Input	      := tools.mod_FilenamesInput(lInputRoot ,lversiondate);
	EXPORT NAICSLookup	:= tools.mod_FilenamesBuild(lfileRoot  ,lversiondate);
		     
	EXPORT dAll_filenames := NAICSLookup.dAll_filenames; 

END;