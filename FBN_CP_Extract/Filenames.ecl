import versioncontrol;

export Filenames(string pversion = '') := module

	export Experian	:=	module
	
		export Base := 	module
	
			export Templates_ExpFiling	:= _Dataset().thor_cluster_files + 'base::' + _Dataset().name + '::@version@::Exp_Filing';
			export Templates_ExpNames		:= _Dataset().thor_cluster_files + 'base::' + _Dataset().name + '::@version@::Exp_Names';	
	
			export ExpFilingBase				:= versioncontrol.mBuildFilenameVersions(Templates_ExpFiling,pversion);
			export ExpNamesBase					:= versioncontrol.mBuildFilenameVersions(Templates_ExpNames,pversion);
                                                                        
			export dall_filenames 			:=	ExpFilingBase.dall_filenames 	+ 
																			ExpNamesBase.dall_filenames;
		end;
	end;
	
	export Florida	:=	module

		export Base := 	module
	
			export Templates_FLFiling		:= _Dataset().thor_cluster_files + 'base::' + _Dataset().name + '::@version@::FL_Filing';
			export Templates_FLNames		:= _Dataset().thor_cluster_files + 'base::' + _Dataset().name + '::@version@::FL_Names';	

			export FLFilingBase					:= versioncontrol.mBuildFilenameVersions(Templates_FLFiling,pversion);
			export FLNamesBase					:= versioncontrol.mBuildFilenameVersions(Templates_FLNames,pversion);	
                                                                        
			export dall_filenames 			:=	FLFilingBase.dall_filenames		+
																			FLNamesBase.dall_filenames;
		end;	
	end;
	
	export Combined	:=	module

		export Out := 	module
	
			export Templates_Filing			:= _Dataset().thor_cluster_files + 'out::' + _Dataset().name + '::@version@::Filing';
			export Templates_Names			:= _Dataset().thor_cluster_files + 'out::' + _Dataset().name + '::@version@::Names';	

			export FilingOut						:= versioncontrol.mBuildFilenameVersions(Templates_Filing,pversion);
			export NamesOut							:= versioncontrol.mBuildFilenameVersions(Templates_Names,pversion);	
                                                                        
			export dall_filenames 			:=	FilingOut.dall_filenames		+
																			NamesOut.dall_filenames;
		end;	
	end;
	
end;