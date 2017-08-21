IMPORT tools;

EXPORT Filenames(
	 STRING		pState								= 'state',
	 STRING		pVersionDate					= '',
	 BOOLEAN	pUseOtherEnvironment	= FALSE
) :=
MODULE
	SHARED lversiondate	:= pVersionDate;
	SHARED lInputRoot		:= _Constants(pState, pUseOtherEnvironment).InputTemplate	+ 'data';
	SHARED lBaseRoot		:= _Constants(pState, pUseOtherEnvironment).FileTemplate		+ 'data';

	EXPORT Input	:= tools.mod_FilenamesInput(lInputRoot	,lversiondate);
	EXPORT Base		:= tools.mod_FilenamesBuild(lBaseRoot		,lversiondate);

	EXPORT dAll_filenames := Base.dAll_filenames; 
END;
