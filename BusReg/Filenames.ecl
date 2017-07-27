import versioncontrol;

export Filenames(

	 string		pversion = ''
	,boolean	pUseProd = false

) :=
module

	export lInputTemplate	:= _Dataset(pUseProd).thor_cluster_files + 'in::' 	+ _Dataset().name + '::@version@::data';
	export lBaseTemplate	:= _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '::@version@::';
	export lOutTemplate		:= _Dataset(pUseProd).thor_cluster_files + 'out::' 	+ _Dataset().name + '::@version@::';

	export Input	:= versioncontrol.mInputFilenameVersions(lInputTemplate						);
	
	export Base :=
	module

		export full				:= versioncontrol.mBuildFilenameVersions(lBaseTemplate	+ 'full'			,pversion	);
		export AID				:= versioncontrol.mBuildFilenameVersions(lBaseTemplate	+ 'AID'				,pversion	);
		export companies	:= versioncontrol.mBuildFilenameVersions(lBaseTemplate	+ 'companies'	,pversion	);
		export contacts		:= versioncontrol.mBuildFilenameVersions(lBaseTemplate	+ 'contacts'	,pversion	);
	
		export dAll_filenames :=
				full.dAll_filenames
			+	AID.dAll_filenames
			+ companies.dAll_filenames
			+ contacts.dAll_filenames
		;

	end;
                                                                        
	export out :=
	module

		export companies	:= versioncontrol.mBuildFilenameVersions(lOutTemplate	+ 'companies'	,pversion	);
		export contacts		:= versioncontrol.mBuildFilenameVersions(lOutTemplate	+ 'contacts'	,pversion	);
	
		export dAll_filenames :=
				companies.dAll_filenames
			+ contacts.dAll_filenames
		;
	end;

	export dAll_filenames :=
		  Base.dAll_filenames
		+	out.dAll_filenames
	;

end;