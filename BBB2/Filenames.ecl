import ut, versioncontrol;

export Filenames(

	 string		pversion = ''
	,boolean	pUseProd = false

) :=
module

	export lInputTemplate	:= _Dataset(pUseProd).thor_cluster_files + 'in_rolling::' 	+ _Dataset().name + '::@version@::';
	export lBaseTemplate	:= _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '::@version@::';

	export Input :=
	module

		export Member			:= versioncontrol.mInputFilenameVersions(lInputTemplate + 'Member'		);
		export NonMember	:= versioncontrol.mInputFilenameVersions(lInputTemplate + 'NonMember'	);

		export dAll_filenames :=
					Member.dAll_filenames
				+ NonMember.dAll_filenames
				;
				
	end;

	export Base :=
	module

		export Member			:= versioncontrol.mBuildFilenameVersions(lBaseTemplate + 'Member'			,pversion);
		export NonMember	:= versioncontrol.mBuildFilenameVersions(lBaseTemplate + 'NonMember'	,pversion);
                                                                    
		export dAll_filenames :=
					Member.dAll_filenames
				+ NonMember.dAll_filenames
				;

	end;
                                                                        
	export dAll_filenames :=
		    Base.dAll_filenames
		  ;

end;