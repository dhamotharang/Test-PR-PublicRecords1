import doxie, Tools, VersionControl;
export Build_Keys(
	 string													pversion
	,string													pKeyDatasetName	= 'DCA'
	,dataset(Layouts.base.keybuildEntnum)	pFileKeybuild 	= file_keybuild()
	,dataset(Layouts.base.keybuildEntnum)	pFileKeybuildNonFiltered	= File_Keybuild_NonFiltered()
) :=
module

	shared lkeys := Keys(pversion,,pKeyDatasetName,pFileKeybuild,pFileKeybuildNonFiltered);
		
	export BuildBdid 					:= tools.macf_WriteIndex('lkeys.Bdid.New'			  );
	export BuildBdidHier 			:= tools.macf_WriteIndex('lkeys.BdidHier.New'	  );
	export BuildHierRootSub		:= tools.macf_WriteIndex('lkeys.HierRootSub.New');
	export BuildRootSub 			:= tools.macf_WriteIndex('lkeys.RootSub.New'		);
	export BuildHierP2C 			:= tools.macf_WriteIndex('lkeys.HierP2C.New'		);
	export BuildHierP2CNew 		:= tools.macf_WriteIndex('lkeys.HierP2CNew.New' );
	export BuildHierEntNum 		:= tools.macf_WriteIndex('lkeys.HierEntNum.New' );
	export BuildEntNum				:= tools.macf_WriteIndex('lkeys.EntNum.New'		  );
	export BuildEntNumNonFilt	:= tools.macf_WriteIndex('lkeys.EntNumNonFilt.New');
	export BuildContactBdid		:= tools.macf_WriteIndex('lkeys.ContactBdid.New');	// Added for CCPA phase 2 requirement as per Jira# CCPA-1029 

  VersionControl.macBuildNewLogicalKeyWithName(DCAV2.Key_LinkIds.Key,	DCAV2.keynames(pversion,false,pKeyDatasetName).LinkIds.New, BuildLinkIdsKey);	
		
	export full_build :=
	sequential(
		if(not tools.fun_DoAllFilesExist.fNamesBuilds(keynames(pversion,,pKeyDatasetName).dNotAutokey_filenames)
		,parallel(
			  BuildBdid 											
			 ,BuildBdidHier 										
			 ,BuildHierRootSub								
			 ,BuildRootSub 								
			 ,BuildHierP2C 								
			 ,BuildHierP2CNew 							
			 ,BuildHierEntNum 									
			 ,BuildEntNum
			 ,BuildEntNumNonFilt
			 ,BuildContactBdid
			 ,BuildLinkIdsKey
		 ))
		 ,Promote(pversion).buildfiles.New2Built
	);
		
	export All :=
	if(tools.fun_IsValidVersion(pversion)
		,full_build
		,output('No Valid version parameter passed, skipping DCAV2.Build_Keys atribute')
	);
end;
