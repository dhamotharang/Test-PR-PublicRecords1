import tools;

export Filenames(

	 string		pversion							= ''
	,boolean	pUseOtherEnvironment	= false

) :=
module

	shared lversiondate		:= pversion														;
	shared lInputCCRoot		:= _Constants(pUseOtherEnvironment).InputTemplate	 + 'cc_data' ;
	shared lInputRSIHRoot	:= _Constants(pUseOtherEnvironment).InputTemplate	 + 'rsih_data' ;
	shared lfileRoot			:= _Constants(pUseOtherEnvironment).FileTemplate + 'data' ;

	export InputCC		:= tools.mod_FilenamesInput(lInputCCRoot,lversiondate);
	export InputRSIH	:= tools.mod_FilenamesInput(lInputRSIHRoot,lversiondate);
	export Base				:= tools.mod_FilenamesBuild(lfileRoot ,lversiondate);
		     
	export dAll_filenames := 
			Base.dAll_filenames
		; 
  
end;