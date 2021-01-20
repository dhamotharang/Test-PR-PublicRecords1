import business_header, versioncontrol;

export Keynames(

	 string		pversion							= ''
	,boolean	pUseOtherEnvironment	= false

) :=
module

	shared lversiondate	:= pversion														;
	shared lkeyRoot			:= business_header._Dataset(pUseOtherEnvironment).thor_cluster_Files + 'key::paw::@version@::';
	shared lautokeyRoot	:= lkeyRoot + 'autokey::';

	export root					:= versioncontrol.mBuildFilenameVersions(lautokeyRoot									,lversiondate);

	//*** Jira# DF-28405, PAW - Remove Deprecated Key
	//export companyname_domain := versioncontrol.mBuildFilenameVersions(lkeyRoot     + 'companyname_domain',lversiondate);
	export contactid					:= versioncontrol.mBuildFilenameVersions(lkeyRoot 		+ 'contactid'					,lversiondate);
	export bdid								:= versioncontrol.mBuildFilenameVersions(lkeyRoot 		+ 'bdid'							,lversiondate);
	export did								:= versioncontrol.mBuildFilenameVersions(lkeyRoot			+ 'did'								,lversiondate);
	export LinkIDs						:= versioncontrol.mBuildFilenameVersions(lkeyRoot			+ 'linkIDs'						,lversiondate);

	export namewords2					:= versioncontrol.mBuildFilenameVersions(lautokeyRoot + 'namewords2'				,lversiondate);
	export payload						:= versioncontrol.mBuildFilenameVersions(lautokeyRoot + 'payload'						,lversiondate);
	export phone2							:= versioncontrol.mBuildFilenameVersions(lautokeyRoot + 'phone2'						,lversiondate);
	export phoneb2						:= versioncontrol.mBuildFilenameVersions(lautokeyRoot + 'phoneb2'						,lversiondate);
	export ssn2								:= versioncontrol.mBuildFilenameVersions(lautokeyRoot + 'ssn2'							,lversiondate);
	export stname							:= versioncontrol.mBuildFilenameVersions(lautokeyRoot + 'stname'						,lversiondate);
	export zip								:= versioncontrol.mBuildFilenameVersions(lautokeyRoot + 'zip'								,lversiondate);
	export zipb2							:= versioncontrol.mBuildFilenameVersions(lautokeyRoot + 'zipb2'							,lversiondate);
	export stnameb2						:= versioncontrol.mBuildFilenameVersions(lautokeyRoot + 'stnameb2'					,lversiondate);
	export address						:= versioncontrol.mBuildFilenameVersions(lautokeyRoot + 'address'						,lversiondate);
	export addressb2					:= versioncontrol.mBuildFilenameVersions(lautokeyRoot + 'addressb2'					,lversiondate);
	export citystname					:= versioncontrol.mBuildFilenameVersions(lautokeyRoot + 'citystname'				,lversiondate);
	export fein2							:= versioncontrol.mBuildFilenameVersions(lautokeyRoot + 'fein2'							,lversiondate);
	export name								:= versioncontrol.mBuildFilenameVersions(lautokeyRoot + 'name'							,lversiondate);
	export nameb2							:= versioncontrol.mBuildFilenameVersions(lautokeyRoot + 'nameb2'						,lversiondate);
	export citystnameb2				:= versioncontrol.mBuildFilenameVersions(lautokeyRoot + 'citystnameb2'			,lversiondate);

	export fcra := 
	module

		export did_fcra					:= versioncontrol.mBuildFilenameVersions(lkeyRoot			+ 'did_FCRA'					,lversiondate);
		
		export dAll_filenames := 
				did_fcra.dAll_filenames
			;

	end;
	
	export dAll_filenames := 
	//		companyname_domain.dAll_filenames   //*** Jira# DF-28405, PAW - Remove Deprecated Key 
			contactid.dAll_filenames
		+ bdid.dAll_filenames
		+ did.dAll_filenames
		+ namewords2.dAll_filenames
		+ payload.dAll_filenames
		+ phone2.dAll_filenames
		+ phoneb2.dAll_filenames
		+ ssn2.dAll_filenames
		+ stname.dAll_filenames
		+ zip.dAll_filenames
		+ zipb2.dAll_filenames
		+ stnameb2.dAll_filenames
		+ address.dAll_filenames
		+ addressb2.dAll_filenames
		+ citystname.dAll_filenames
		+ fein2.dAll_filenames
		+ name.dAll_filenames
		+ nameb2.dAll_filenames
		+ citystnameb2.dAll_filenames
		+	LinkIDS.dAll_filenames
		; 


end;