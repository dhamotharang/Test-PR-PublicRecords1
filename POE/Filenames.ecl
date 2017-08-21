import tools;

export Filenames(

	 string		pversion							= ''
	,boolean	pUseOtherEnvironment	= false

) :=
module

	shared lversiondate	:= pversion														;
	shared lfileRoot		:= _Constants(pUseOtherEnvironment).FileTemplate	+ 'data'	;
	shared lstatRoot		:= _Constants(pUseOtherEnvironment).statsTemplate + 'data'	;

	export Base		:= tools.mod_FilenamesBuild(lfileRoot ,lversiondate);
	export Stat		:= tools.mod_FilenamesBuild(lstatRoot ,lversiondate);
		     
	export dAll_filenames := 
			Base.dAll_filenames
		+	Stat.dAll_filenames
		; 


end;