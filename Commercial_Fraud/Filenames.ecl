import versioncontrol;

export Filenames(

	 string		pversion = ''
	,boolean	pUseOtherEnvironment = false

) :=
module

	export lInputFileTemplate	:= _Dataset(pUseOtherEnvironment).thor_cluster_files		+ 'in::'		+ _Dataset().name + '::@version@::'	;
	export lFileTemplate	    := _Dataset(pUseOtherEnvironment).thor_cluster_files		+ 'base::'	+ _Dataset().name + '::@version@::'	;

	export Input :=
	module
		
		export Dell := versioncontrol.mInputFilenameVersions(lInputFileTemplate	+ 'Dell'					);
		
	end;

	export Dell_return					:= versioncontrol.mInputFilenameVersions(lInputFileTemplate + 'Dell_return'		);

	export Address_Summary  		:= versioncontrol.mBuildFilenameVersions(lFileTemplate + 'Address_Summary'	,pversion	);
	export Business_Summary			:= versioncontrol.mBuildFilenameVersions(lFileTemplate + 'Business_Summary'	,pversion	);
	export Contact_Summary  		:= versioncontrol.mBuildFilenameVersions(lFileTemplate + 'Contact_Summary'	,pversion	);
	export Dell_out  						:= versioncontrol.mBuildFilenameVersions(lFileTemplate + 'Dell_out'					,pversion	);
	export Dell_out_append			:= versioncontrol.mBuildFilenameVersions(lFileTemplate + 'Dell_out_Append'	,pversion	);
	export Dell_out_append_csv	:= versioncontrol.mBuildFilenameVersions(lFileTemplate + 'Dell_out_Append_csv'	,pversion	);
                                                                        
	export dAll_filenames :=
		   Address_Summary.dAll_filenames
		 + Business_Summary.dALL_filenames
		 + Contact_Summary.dALL_filenames
		 + Dell_out.dALL_filenames
		 + Dell_out_append.dALL_filenames
		 + Dell_out_append_csv.dALL_filenames
	; 

end;