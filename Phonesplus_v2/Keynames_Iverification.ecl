import tools;

export Keynames_Iverification(

	 string		pversion							= '',
   boolean pUseProd = false

) :=
module

	export lFileTemplate	    := '~thor_data400::key::iverification::@version@::'	;
	
	//shared lDid		:= lFileTemplate + 'did'	;
	//shared lHhid			:= lFileTemplate + 'hhid'		;
	shared lphone			:= lFileTemplate + 'phone'		;
	shared lDidPhone			:= lFileTemplate + 'did_phone'		;
	//export Did		:= tools.mod_FilenamesBuild(lDid	,pversion);
	//export Hhid		:= tools.mod_FilenamesBuild(lhhid	,pversion);
	export phone	:= tools.mod_FilenamesBuild(lphone	,pversion);
	export Did_phone	:= tools.mod_FilenamesBuild(lDidPhone	,pversion);
	export dAll_filenames := 
				 phone.dAll_filenames
				+ Did_phone.dAll_filenames
		;

end;