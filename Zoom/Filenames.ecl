import versioncontrol;

export Filenames(

	 string		pversion = ''
	,boolean	pUseProd = false

) :=
module

	export lInputTemplate	    := _Dataset(pUseProd).thor_cluster_files + 'in::' 	+ _Dataset().name + '::@version@::data';
	export lInputXMLTemplate	:= _Dataset(pUseProd).thor_cluster_files + 'in::' 	+ _Dataset().name + '::@version@::dataXML';
	export lBaseTemplate	    := _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '::@version@::data';
	export lBaseXMLTemplate	  := _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '::@version@::dataXML';

	export Input	  := versioncontrol.mInputFilenameVersions(lInputTemplate						);
	export InputXML	:= versioncontrol.mInputFilenameVersions(lInputXMLTemplate				);
	export Base		  := versioncontrol.mBuildFilenameVersions(lBaseTemplate	,pversion	);
	export BaseXML  := versioncontrol.mBuildFilenameVersions(lBaseXMLTemplate	,pversion	);
                                                                        
	export dAll_filenames :=
		   Base.dAll_filenames
		 + BaseXML.dALL_filenames
	;
 
end;