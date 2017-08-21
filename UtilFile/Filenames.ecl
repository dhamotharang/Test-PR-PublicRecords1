import versioncontrol;

export Filenames(
	 string		pversion = ''
	,boolean	pUseProd = false
) :=
module

	export lBaseTemplate			:= _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '::@version@::bus_data';
	export lFullBaseTemplate	:= _Dataset(pUseProd).thor_cluster_files + 'base::utility_file';

	export Base		  					:= versioncontrol.mBuildFilenameVersions(lBaseTemplate			,pversion	);
	export FullBase		  			:= versioncontrol.mBuildFilenameVersions(lFullBaseTemplate	,pversion	);
 	
	export dAll_filenames :=
		   Base.dAll_filenames		 
		+  FullBase.dAll_filenames		 
	;

end;