import tools;

export Filenames(

	 string		pversion							= ''
	,boolean	pUseOtherEnvironment	= false

) :=
module

	shared lversiondate	:= pversion														;
	
	shared bfileRoot		:= _Constants(pUseOtherEnvironment).FileTemplate	+ 'data'	;
	shared lstatRoot		:= _Constants(pUseOtherEnvironment).statsTemplate + 'data'	;

  export in_request		:= _Constants(pUseOtherEnvironment).InRequestFileTemplate;
	export in_response		:= _Constants(pUseOtherEnvironment).InResponseFileTemplate;
	export in_request_fixed		:= _Constants(pUseOtherEnvironment).InRequestFixedFileTemplate;
  export in_response_fixed		:=  _Constants(pUseOtherEnvironment).InResponseFixedFileTemplate;
	export Base		:= tools.mod_FilenamesBuild(bfileRoot ,lversiondate);
	export Stat		:= tools.mod_FilenamesBuild(lstatRoot ,lversiondate);
	
	export dSome_filenames := 
			Base.dAll_filenames
		+	Stat.dAll_filenames
		; 	
	
	export dAll_filenames := 
			Base.dAll_filenames
		+	Stat.dAll_filenames
		; 
end;