import versioncontrol;

export Filenames(

	 string		pversion = ''
	,boolean	pUseProd = false

) :=
module

	export lBaseTemplate	:= _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '::@version@::data';
	
	export Base		  := versioncontrol.mBuildFilenameVersions(lBaseTemplate, pversion);
  
	
	export dAll_filenames :=
		   Base.dAll_filenames		 
	;

end;