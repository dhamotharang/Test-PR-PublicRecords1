import versioncontrol;

export Filenames(string pversion) :=
module
	export templates :=
	module
		export input :=
		module
			
			export root	:= thor_cluster + 'in::' + dataset_name + '::@version@::All';
			
			export AL		:= thor_cluster + 'in::' + dataset_name + '::@version@::AL';
			export AK		:= thor_cluster + 'in::' + dataset_name + '::@version@::AK';
			export AR		:= thor_cluster + 'in::' + dataset_name + '::@version@::AR';
			export AZ		:= thor_cluster + 'in::' + dataset_name + '::@version@::AZ';
			
		end;

		export base :=
		module

			export root	:= thor_cluster + 'base::' + dataset_name + '::@version@::All';
		
			export AL		:= thor_cluster + 'base::' + dataset_name + '::@version@::AL';
			export AK		:= thor_cluster + 'base::' + dataset_name + '::@version@::AK';
			export AR		:= thor_cluster + 'base::' + dataset_name + '::@version@::AR';
			export AZ		:= thor_cluster + 'base::' + dataset_name + '::@version@::AZ';
		
		end;
	end;

	export input :=
	module

		export Root	:= versioncontrol.mInputFilenameVersions(Templates.Input.Root);

		export AL		:= versioncontrol.mInputFilenameVersions(Templates.Input.AL);
		export AK		:= versioncontrol.mInputFilenameVersions(Templates.Input.AK);
		export AR		:= versioncontrol.mInputFilenameVersions(Templates.Input.AR);
		export AZ		:= versioncontrol.mInputFilenameVersions(Templates.Input.AZ);
		                                                             
		export dAll_superfilenames := 
				Root.dAll_superfilenames
			+ AL.dAll_superfilenames
			+ AK.dAll_superfilenames
			+ AR.dAll_superfilenames
			+ AZ.dAll_superfilenames
			; 

	end;

	export base :=
	module

		export Root	:= versioncontrol.mBuildFilenameVersions(Templates.Base.Root	,pversion);

		export AL		:= versioncontrol.mBuildFilenameVersions(Templates.Base.AL	,pversion);
		export AK		:= versioncontrol.mBuildFilenameVersions(Templates.Base.AK	,pversion);
		export AR		:= versioncontrol.mBuildFilenameVersions(Templates.Base.AR	,pversion);
		export AZ		:= versioncontrol.mBuildFilenameVersions(Templates.Base.AZ	,pversion);
		                                                             
		export dAll_superfilenames := 
				Root.dAll_superfilenames
			+ AL.dAll_superfilenames
			+ AK.dAll_superfilenames
			+ AR.dAll_superfilenames
			+ AZ.dAll_superfilenames
			; 

		export dNew := 
				Root.dNew
			+ AL.dNew
			+ AK.dNew
			+ AR.dNew
			+ AZ.dNew
			; 
	
	end;

		export dAll_superfilenames := 
		  Input.dAll_superfilenames
		+ Base.dAll_superfilenames
		;

	export dAll_logicalfilenames :=
//		  Input.dNew(versiondate)
		  Base.dNew
		;

end;