import tools;

export Filenames(

	 string		pversion = ''
	,boolean	pUseProd = false

) :=
module

	export lInputTemplate	:= _Dataset(pUseProd).thor_cluster_Files + 'in::' 	+ _Dataset().name + '::@version@::data';
	export lBaseTemplate	:= _Dataset(pUseProd).thor_cluster_Files + 'base::' + _Dataset().name + '::@version@::data';

	export Input	:= tools.mod_FilenamesInput(lInputTemplate	,pFileDate := pversion  );
	export Base		:= tools.mod_FilenamesBuild(lBaseTemplate	  ,pversion	              );
                                                                        
	export dAll_filenames :=
		  Base.dAll_filenames
	;

end;