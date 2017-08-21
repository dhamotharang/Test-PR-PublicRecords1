import tools;

export Filenames(

	 string		pversion = ''
	,boolean	pUseProd = false

) :=
module

	export lInputTemplate	:= _Dataset(pUseProd).thor_cluster_files + 'in::' 	+ _Dataset().name + '::@version@::vendor_raw';

	export lBaseTemplate	:= _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '::@version@::data';
	
	export Input		:= tools.mod_FilenamesInput(lInputTemplate			);

	export Base		  := tools.mod_FilenamesBuild(lBaseTemplate, pversion);
  
	
	export dAll_filenames :=
		   Base.dAll_filenames		 
	;

end;