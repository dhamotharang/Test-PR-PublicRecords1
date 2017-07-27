import tools;

export Filenames(

	 string		pversion							= ''
	,boolean	pUseOtherEnvironment	= false

) :=
module

	shared lversiondate	:= pversion														;
	shared iRequestfileRoot		:= _Constants(pUseOtherEnvironment).InRequestFileTemplate	+ 'data'	;
	shared iResponsefileRoot		:= _Constants(pUseOtherEnvironment).InResponseFileTemplate	+ 'data'	;
	shared iRequestFixedfileRoot		:= _Constants(pUseOtherEnvironment).InRequestFixedFileTemplate	+ 'data'	;
	shared iResonseFixedfileRoot		:= _Constants(pUseOtherEnvironment).InResponseFixedFileTemplate	+ 'data'	;
	
	shared bfileRoot		:= _Constants(pUseOtherEnvironment).FileTemplate	+ 'data'	;
	shared lstatRoot		:= _Constants(pUseOtherEnvironment).statsTemplate + 'data'	;

  export in_request		:= tools.mod_FilenamesBuild(iRequestfileRoot ,lversiondate);	
	export in_response		:= tools.mod_FilenamesBuild(iResponsefileRoot ,lversiondate);
	export in_request_fixed		:= tools.mod_FilenamesBuild(iRequestFixedfileRoot ,lversiondate);
  export in_response_fixed		:= tools.mod_FilenamesBuild(iResonseFixedfileRoot ,lversiondate);
	export Base		:= tools.mod_FilenamesBuild(bfileRoot ,lversiondate);
	export Stat		:= tools.mod_FilenamesBuild(lstatRoot ,lversiondate);
	
	export dSome_filenames := 
			in_request.dAll_filenames
		+ in_response.dAll_filenames
		+	Base.dAll_filenames
		+	Stat.dAll_filenames
		; 	
	
	export dAll_filenames := 
			in_request.dAll_filenames
		+ in_response.dAll_filenames
		+ in_request_fixed.dAll_filenames
		+ in_response_fixed.dAll_filenames
		+	Base.dAll_filenames
		+	Stat.dAll_filenames
		; 
end;