import tools;
export Keynames(
	 string		pversion							= ''
	,boolean	pUseOtherEnvironment	= false
	,string		pDatasetname					= 'dca'
) :=
module

	export lLogicalTmplt				:= _Constants(pUseOtherEnvironment,pDatasetname).keyTemplate									;
	export lsuperTmplt					:= _Constants(pUseOtherEnvironment,pDatasetname).oldkeyTemplate								;
	export llogicalautoTmplt		:= _Constants(pUseOtherEnvironment,pDatasetname).autokeytemplate							;
	export lsuperautoTmplt			:= _Constants(pUseOtherEnvironment,pDatasetname).altautokeytemplate						;

	export Bdid							:= tools.mod_FilenamesBuild(lsuperTmplt					+ '_bdid'																,pversion	,lLogicalTmplt						+ 'bdid'															);
	export BdidHier					:= tools.mod_FilenamesBuild(lsuperTmplt					+ '_hierarchy_bdid'											,pversion	,lLogicalTmplt						+ 'hierarchy_bdid'										);
	export HierP2C					:= tools.mod_FilenamesBuild(lsuperTmplt					+ '_hierarchy_parent_to_child_root_sub'	,pversion	,lLogicalTmplt						+ 'hierarchy_parent_to_child_root_sub');
	export HierRootSub			:= tools.mod_FilenamesBuild(lsuperTmplt					+ '_hierarchy_root_sub'									,pversion	,lLogicalTmplt						+ 'hierarchy_root_sub'								);
	export RootSub					:= tools.mod_FilenamesBuild(lsuperTmplt					+ '_root_sub'														,pversion	,lLogicalTmplt						+ 'root_sub'													);
  
	//new keys
	export HierP2CNew				:= tools.mod_FilenamesBuild(lLogicalTmplt					+ 'hierarchy_parent_to_child_entnum'	,pversion	);
	export HierEntNum 			:= tools.mod_FilenamesBuild(lLogicalTmplt					+ 'hierarchy_entnum'									,pversion	);
	export EntNum						:= tools.mod_FilenamesBuild(lLogicalTmplt					+ 'entnum'														,pversion	);
	export EntNumNonFilt		:= tools.mod_FilenamesBuild(lLogicalTmplt					+ 'entnum_NonFilt'										,pversion	);
	
	export LinkIds				  := tools.mod_FilenamesBuild(lLogicalTmplt		      + 'linkIds'			                      ,pversion );
	
	// Creating a BDID key on Contacts base file. Added for CCPA phase 2 requirement as per Jira# CCPA-1029
	export ContactBDID			:= tools.mod_FilenamesBuild(lLogicalTmplt					+ 'contacts_bdid'											,pversion );

	export autokeyroot	 		:= tools.mod_FilenamesBuild(lsuperautoTmplt																							,pversion	,llogicalautoTmplt																							);

	export addressb2 				:= tools.mod_FilenamesBuild(lsuperautoTmplt			+ 'addressb2'														,pversion	,llogicalautoTmplt				+ 'addressb2'													);
	export citystnameb2 		:= tools.mod_FilenamesBuild(lsuperautoTmplt			+ 'citystnameb2'												,pversion	,llogicalautoTmplt				+ 'citystnameb2'											);
	export nameb2 					:= tools.mod_FilenamesBuild(lsuperautoTmplt			+ 'nameb2'															,pversion	,llogicalautoTmplt				+ 'nameb2'														);
	export namewords2 			:= tools.mod_FilenamesBuild(lsuperautoTmplt			+ 'namewords2'													,pversion	,llogicalautoTmplt				+ 'namewords2'												);
	export payload 					:= tools.mod_FilenamesBuild(lsuperautoTmplt			+ 'payload'															,pversion	,llogicalautoTmplt				+ 'payload'														);
	export stnameb2 				:= tools.mod_FilenamesBuild(lsuperautoTmplt			+ 'stnameb2'														,pversion	,llogicalautoTmplt				+ 'stnameb2'													);
	export zipb2 						:= tools.mod_FilenamesBuild(lsuperautoTmplt			+ 'zipb2'																,pversion	,llogicalautoTmplt				+ 'zipb2'															);
  
	export dNotAutokey_filenames := 
		  Bdid.dAll_filenames
		+ BdidHier.dAll_filenames
		+ HierP2C.dAll_filenames
		+ HierRootSub.dAll_filenames
		+ RootSub.dAll_filenames
		+ HierP2CNew.dAll_filenames
		+ HierEntNum.dAll_filenames
		+ EntNum.dAll_filenames
		+ EntNumNonFilt.dAll_filenames
		+ LinkIds.dAll_filenames
		+ ContactBDID.dAll_filenames
		;

	export dAll_filenames := 
		  Bdid.dAll_filenames
		+ BdidHier.dAll_filenames
		+ HierP2C.dAll_filenames
		+ HierRootSub.dAll_filenames
		+ RootSub.dAll_filenames
		+ HierP2CNew.dAll_filenames
		+ HierEntNum.dAll_filenames
		+ EntNum.dAll_filenames
		+ EntNumNonFilt.dAll_filenames
		+ addressb2.dAll_filenames
		+ citystnameb2.dAll_filenames
		+ nameb2.dAll_filenames
		+ namewords2.dAll_filenames
		+ payload.dAll_filenames
		+ stnameb2.dAll_filenames
		+ zipb2.dAll_filenames
		+ LinkIds.dAll_filenames
		+ ContactBDID.dAll_filenames
		;

end;
