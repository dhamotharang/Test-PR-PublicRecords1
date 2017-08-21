import tools;

export Filenames(

	 string		pversion = ''
	,boolean	pUseProd = false

) :=
module

	export lInputTemplate	    := _Dataset(pUseProd).thor_cluster_files + 'in::' 	+ _Dataset().name + '::@version@::data';
	export lInputXMLTemplate	:= _Dataset(pUseProd).thor_cluster_files + 'in::' 	+ _Dataset().name + '::@version@::dataXML';
	export lBaseTemplate	    := _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '::@version@::data';
	export lBaseXMLTemplate	  := _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '::@version@::dataXML';

	export Input	  := tools.mod_FilenamesInput(lInputTemplate		,pFileDate := pversion);
	export InputXML	:= tools.mod_FilenamesInput(lInputXMLTemplate	,pFileDate := pversion);
	export Base		  := tools.mod_FilenamesBuild(lBaseTemplate			,pversion	);
	export BaseXML  := tools.mod_FilenamesBuild(lBaseXMLTemplate	,pversion	);
                                                                        
	export dAll_filenames :=
		   Base.dAll_filenames
		 + BaseXML.dALL_filenames
	;
 
end;