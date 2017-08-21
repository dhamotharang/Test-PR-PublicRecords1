import tools;
export Filenames(
	 string		pversion							= ''
	,boolean	pUseOtherEnvironment	= false
) :=
module

	shared lversiondate	:= pversion														            ;
	shared lInputRoot		:= _Constants(pUseOtherEnvironment).InputTemplate	;
	shared lfileRoot		:= _Constants(pUseOtherEnvironment).FileTemplate	;

	export Input := 
	module
    export Companies	:= tools.mod_FilenamesInput(lInputRoot + 'Companies'	,lversiondate);
		export Contacts		:= tools.mod_FilenamesInput(lInputRoot + 'Contacts'	  ,lversiondate);
		
		export dAll_filenames := 
					Companies.dAll_filenames
				+	Contacts.dAll_filenames
			; 
	end;

	export Base :=
	module
		export Companies	:= tools.mod_FilenamesBuild(lfileRoot + 'Companies'	,lversiondate);
		export Contacts		:= tools.mod_FilenamesBuild(lfileRoot + 'Contacts'	,lversiondate);
		export dAll_filenames := 
					Companies.dAll_filenames
				+	Contacts.dAll_filenames
			; 
	end;
	
	export dAll_filenames := 
		 Base.dAll_filenames
		; 
    
end;