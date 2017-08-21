import versioncontrol;

export Filenames(

	 string		pversion = ''
	,boolean	pUseProd = false

) :=
module

	export lInputSVCAddrTemplate	:= _Dataset(pUseProd).thor_cluster_files + 'in::' 	+ _Dataset().name + '::@version@::svcaddr';
	export lInputEntityTemplate		:= _Dataset(pUseProd).thor_cluster_files + 'in::' 	+ _Dataset().name + '::@version@::entity';
	
	export lBaseTemplate	    := _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '::@version@::cp_data';
	
	export InputSVCAddr	:= versioncontrol.mInputFilenameVersions(lInputSVCAddrTemplate			);
	export InputEntity	:= versioncontrol.mInputFilenameVersions(lInputEntityTemplate				);

	export Base		  := versioncontrol.mBuildFilenameVersions(lBaseTemplate	,pversion	);
  
	
	export dAll_filenames :=
		   Base.dAll_filenames		 
	;

end;