import business_header, tools;
export Filenames(
	 string		pversion							= ''
	,boolean	pUseOtherEnvironment	= false
) :=
module
	shared lversiondate	:= pversion														;
	shared lInputRoot		:= _Constants(pUseOtherEnvironment).InputTemplate	+ 'data'	;
	shared lBaseRoot		:= _Constants(pUseOtherEnvironment).FileTemplate	+ 'data'	;
	export Input	:= tools.mod_FilenamesInput(lInputRoot	,lversiondate);
	export Base		:= tools.mod_FilenamesBuild(lBaseRoot		,lversiondate);
	export dAll_filenames := 
			Base.dAll_filenames
		; 
end;
