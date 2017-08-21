import tools;

export Filenames(

	 string		pversion = ''
	,boolean	pUseProd = false

) :=
module

	shared lInputTemplate		:= _Constants(pUseProd).InputTemplate	+ 'search::output'	;
	shared lBaseTemplate		:= _Constants(pUseProd).FileTemplate	+ 'search::output'	;

		
	export Input		:= tools.mod_FilenamesInput(lInputTemplate,	pversion);

	export Base		  := tools.mod_FilenamesBuild(lBaseTemplate, pversion);
  
	
	export dAll_filenames :=
		   Base.dAll_filenames		 
	;

end;
