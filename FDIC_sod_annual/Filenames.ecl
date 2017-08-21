import business_header, tools;

export Filenames(

	 string		pversion							= ''
	,boolean	pUseOtherEnvironment	= false

) :=
module
  export ftemplate(string pFiletype)	:= '~thor_data400::' + pFiletype + '::' + _Dataset().name + '::@version@';

	shared lversiondate	:= pversion														;
	shared lInputRoot		:= _Constants(pUseOtherEnvironment).InputTemplate	+ 'data'	;
	shared lfileRoot		:= _Constants(pUseOtherEnvironment).FileTemplate	+ 'data'	;

	export Input	:= tools.mod_FilenamesInput(lInputRoot,lversiondate);
	export Base		:= tools.mod_FilenamesBuild(lfileRoot ,lversiondate);
	export FileTemplate			:= ftemplate('base'	);
	export keyTemplate			:= ftemplate('key'	);
	export autokeytemplate	:= keyTemplate + 'autokey::';
	export statsTemplate		:= ftemplate('stats');
	export dAll_filenames := 
			Base.dAll_filenames
		; 

end;