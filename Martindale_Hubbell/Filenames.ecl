import versioncontrol;

export Filenames(

	 string		pversion = ''
	,boolean	pUseOtherEnvironment = false

) :=
module

	export ftemplate(string pFiletype)	:= _Dataset(pUseOtherEnvironment).thor_cluster_files + pFiletype + '::' + _Dataset().name + '::@version@';

	export input 					:= versioncontrol.mInputFilenameVersions(ftemplate('in') + '::Data',pFileDate := pversion);

	export base :=
	module
		
		shared template				:= ftemplate('base');

		export lOrganizations								:= template + '::Organizations'							;
		export lAffiliated_Individuals			:= template + '::Affiliated_Individuals'		;
		export lUnaffiliated_Individuals		:= template + '::Unaffiliated_Individuals'	;

		export Organizations						:= versioncontrol.mBuildFilenameVersions(lOrganizations							,pversion);
		export Affiliated_Individuals		:= versioncontrol.mBuildFilenameVersions(lAffiliated_Individuals		,pversion);
		export Unaffiliated_Individuals	:= versioncontrol.mBuildFilenameVersions(lUnaffiliated_Individuals	,pversion);
                                                                        
		export dAll_filenames := 
				Organizations.dAll_filenames
			+ Affiliated_Individuals.dAll_filenames
			+ Unaffiliated_Individuals.dAll_filenames
			; 
	
	end;

	export stat :=
	module
		
		shared template				:= ftemplate('stats');

		export lOrganizations								:= template + '::Organizations'							;
		export lAffiliated_Individuals			:= template + '::Affiliated_Individuals'		;
		export lUnaffiliated_Individuals		:= template + '::Unaffiliated_Individuals'	;

		export Organizations						:= versioncontrol.mBuildFilenameVersions(lOrganizations							,pversion);
		export Affiliated_Individuals		:= versioncontrol.mBuildFilenameVersions(lAffiliated_Individuals		,pversion);
		export Unaffiliated_Individuals	:= versioncontrol.mBuildFilenameVersions(lUnaffiliated_Individuals	,pversion);
                                                                        
		export dAll_filenames := 
				Organizations.dAll_filenames
			+ Affiliated_Individuals.dAll_filenames
			+ Unaffiliated_Individuals.dAll_filenames
			; 
	
	end;

	export extracts :=
	module
		
		shared template				:= ftemplate('extract');
		shared template2			:= ftemplate('base2');

		export lOrganizations								:= template + '::Organizations'							;
		export lAffiliated_Individuals			:= template + '::Affiliated_Individuals'		;
		export lUnaffiliated_Individuals		:= template + '::Unaffiliated_Individuals'	;

		export lOrgs						:= template2 + '::Organizations'							;
		export lAff_Indivs			:= template2 + '::Affiliated_Individuals'		;
		export lUnaff_Indivs		:= template2 + '::Unaffiliated_Individuals'	;

		export Orgs					:= versioncontrol.mBuildFilenameVersions(lOrgs					,pversion);
		export Aff_Indivs		:= versioncontrol.mBuildFilenameVersions(lAff_Indivs		,pversion);
		export Unaff_Indivs	:= versioncontrol.mBuildFilenameVersions(lUnaff_Indivs	,pversion);

		export Organizations						:= versioncontrol.mBuildFilenameVersions(lOrganizations							,pversion);
		export Affiliated_Individuals		:= versioncontrol.mBuildFilenameVersions(lAffiliated_Individuals		,pversion);
		export Unaffiliated_Individuals	:= versioncontrol.mBuildFilenameVersions(lUnaffiliated_Individuals	,pversion);
                                                                        
		export dAll_filenames := 
				Organizations.dAll_filenames
			+ Affiliated_Individuals.dAll_filenames
			+ Unaffiliated_Individuals.dAll_filenames
			; 
	
	end;

	export dAll_filenames :=
			Base.dAll_filenames
		+ stat.dAll_filenames
	;

end;