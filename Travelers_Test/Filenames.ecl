import versioncontrol;

export Filenames(

	 string		pversion							= ''
	,boolean	pUseOtherEnvironment	= false

) :=
module

	export lInputTemplate	  := _Dataset(pUseOtherEnvironment).thor_cluster_files + 'in::' 	+ _Dataset().name + '::@version@::data';
	export lOutTemplate	    := _Dataset(pUseOtherEnvironment).thor_cluster_files + 'out::'	+ _Dataset().name + '::@version@::data';
	export lStatsTemplate	  := _Dataset(pUseOtherEnvironment).thor_cluster_files + 'Stats::'	+ _Dataset().name + '::@version@::data';

	export Input	  := versioncontrol.mInputFilenameVersions(lInputTemplate						);
	export Out		  := versioncontrol.mBuildFilenameVersions(lOutTemplate		,pversion	);
	export Stats	  := versioncontrol.mBuildFilenameVersions(lStatsTemplate	,pversion	);
                                                                        
	export dAll_filenames :=
		   Out.dAll_filenames
	;
 
end;