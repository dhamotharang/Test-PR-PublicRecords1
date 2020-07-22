IMPORT  tools;

EXPORT Filenames(
	 
	 STRING		pversion							= ''
	,BOOLEAN	pUseOtherEnvironment	= FALSE

) := MODULE
 
	SHARED lversiondate	      := pversion;
	SHARED lInputRoot		      := _Constants(pUseOtherEnvironment).InputTemplate	+ 'data'	;
	SHARED lInputRootContacts	:= _Constants(pUseOtherEnvironment).InputTemplate	+ 'data::contacts'	;
	SHARED lfileRoot		      := _Constants(pUseOtherEnvironment).FileTemplate	+ 'data'	;
	SHARED lfileRootContacts	:= _Constants(pUseOtherEnvironment).FileTemplate	+ 'data::contacts'	;

  export Input :=
	module
	export Companies := tools.mod_FilenamesInput(lInputRoot,lversiondate);
	export Contacts  := tools.mod_FilenamesInput(lInputRootContacts,lversiondate);

  export dAll_filenames := 
				Companies.dAll_filenames
			+ Contacts.dAll_filenames
			; 	
	
	end;	
	
	export Base		      := 
	module 
	  export Companies := tools.mod_FilenamesBuild(lfileRoot,lversiondate);
		export Contacts  := tools.mod_FilenamesBuild(lfileRootContacts,lversiondate);
	end;
	
	EXPORT dAll_filenames := Base.Companies.dAll_filenames
	                         + Base.Contacts.dAll_filenames; 

END;