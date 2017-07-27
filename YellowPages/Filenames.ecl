import tools;

export Filenames(

	 string		pversion = ''
	,boolean	pUseProd = false

) :=
module

	export lInputTemplate	    := Constants(pUseProd).InputRollingTemplate + 'Full';
	export lBaseTemplate	    := Constants(pUseProd).FileTemplate					+ 'data';

	export Input	  := tools.mod_FilenamesInput(lInputTemplate		,pFileDate := pversion);
	export Base		  := tools.mod_FilenamesBuild(lBaseTemplate			,pversion	);
                                                                        
	export dAll_filenames :=
		   Base.dAll_filenames
	;
 
end;
