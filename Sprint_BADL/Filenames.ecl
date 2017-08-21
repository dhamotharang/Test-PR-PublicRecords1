import versioncontrol;

export Filenames(

	 string		pversion = ''
	,boolean	pUseProd = false

) :=
module

	export lInputTemplate	:= _Dataset(pUseProd).thor_cluster_files + 'in::' 	+ _Dataset().name + '::@version@::';
	export lBaseTemplate	:= _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '::@version@::';

	export Input	:= 
	module
		
		export Exist	:= versioncontrol.mInputFilenameVersions(lInputTemplate	+ 'Exist'	);
		export Fraud	:= versioncontrol.mInputFilenameVersions(lInputTemplate	+ 'Fraud'	);
		export WO			:= versioncontrol.mInputFilenameVersions(lInputTemplate	+ 'WO'		);

		export dall_filenames :=
				Exist.dall_filenames
			+ Fraud.dall_filenames
			+ WO.dall_filenames
			; 
	
	end;
	
	export Base		:= 
	module
		
		export Exist	:= versioncontrol.mBuildFilenameVersions(lBaseTemplate	+ 'Exist'	,pversion	);
		export Fraud	:= versioncontrol.mBuildFilenameVersions(lBaseTemplate	+ 'Fraud'	,pversion	);
		export WO			:= versioncontrol.mBuildFilenameVersions(lBaseTemplate	+ 'WO'		,pversion	);
		export all			:= versioncontrol.mBuildFilenameVersions(lBaseTemplate	+ 'all'			,pversion	);

		export dall_filenames :=
				Exist.dall_filenames
			+ Fraud.dall_filenames
			+ WO.dall_filenames
			; 
			
	end;
                                                                        
	export dAll_filenames :=
		  Base.dAll_filenames
	;

end;