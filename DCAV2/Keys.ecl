import doxie, tools,autokeyb2,dca;
export Keys(
	 string													pversion									= ''
	,boolean												pUseOtherEnvironment			= false
	,string													pDatasetname							= 'dca'
	,dataset(Layouts.base.keybuildEntNum)	pFileKeybuild 						= file_keybuild()
	,dataset(Layouts.base.keybuildEntNum)	pFileKeybuildNonFiltered	= File_Keybuild_NonFiltered()
	,dataset(Layouts.base.contacts)	pFileContacts 						= files().base.contacts.built
) :=
module

	shared knames := keynames(pversion,pUseOtherEnvironment,pDatasetname);

  export dFileKeybuild := project(pFileKeybuild ,transform(Layouts.base.keybuild , self := left));
	export Basebdid			 := project(dFileKeybuild	,transform(Layouts.base.keybuildslim	,self := left));

	export EntNumFilt  	 := project(pFileKeybuild	,transform(Layouts.base.keybuildEntNum, self := left));
	export EntNumNonFilter := pFileKeybuildNonFiltered;
		
	export FilterBdids	 := Basebdid	(bdid	!= 0);
	// Creating a BDID key on Contacts base file. Added for CCPA phase 2 requirement as per Jira# CCPA-1029
	// applying the same record_type filter applied on contact base file that is used to create the DCAV2.File_Keybuild file for the creation of companies BDID key.
	// So, only keeping the contact records that matched this record_type filter code for ContactBDID key.
	// filter applied is - record_type in [DCAV2.Utilities.RecordType.Updated,DCAV2.Utilities.RecordType.New]
	export FilterContBdids			:= pFileContacts(bdid	!= 0 and record_type in [DCAV2.Utilities.RecordType.Updated,DCAV2.Utilities.RecordType.New]);
	export FilterContBdids_ded  := dedup(sort(distribute(FilterContBdids, hash(BDID, rawfields.enterprise_num)), record, local), record, except rid, lncagid, lncaghid, local);
	
	shared layout_dca_hierarchy :=
	record
		FilterBdids.bdid;
		FilterBdids.level;
		FilterBdids.root;
		FilterBdids.sub;
		string9 parent_root := FilterBdids.parent_number[1..9];
		string4 parent_sub 	:= FilterBdids.parent_number[11..];
	end;

	shared dca_hierarchy := table(FilterBdids, layout_dca_hierarchy);
	
	shared layout_dca_hierarchy_parent_to_child := RECORD
		STRING9 parent_root := IF( dFileKeybuild.parent_number != '', dFileKeybuild.parent_number[1..9]	, dFileKeybuild.root );
		STRING4 parent_sub  := IF( dFileKeybuild.parent_number != '', dFileKeybuild.parent_number[11..]	, dFileKeybuild.sub );
		STRING9 child_root  := dFileKeybuild.root;
		STRING4 child_sub   := dFileKeybuild.sub;
		STRING2 child_level := dFileKeybuild.level;	
	END;

	shared dhierp2c := TABLE(dFileKeybuild, layout_dca_hierarchy_parent_to_child);

	shared layout_dca_hierarchyrootsub := record
	Basebdid.bdid;
	Basebdid.level;
	Basebdid.root;
	Basebdid.sub;
	string9 parent_root := Basebdid.parent_number[1..9];
	string4 parent_sub 	:= Basebdid.parent_number[11..];
	end;

	shared dHierRootSub := table(Basebdid, layout_dca_hierarchyrootsub);

	//////////////////////////////////////////////////
	//Hierarchy parent to child NEW!!!!
	shared fHierP2CNew(dataset(Layouts.base.keybuild)	pdataset	= dFileKeybuild) :=
	function

		lHierP2C :=
		RECORD
			STRING9 Parent_Enterprise_number 	:= IF( pdataset.Parent_Enterprise_number != '', pdataset.Parent_Enterprise_number, pdataset.Enterprise_num );
			STRING9 Enterprise_num 						:= pdataset.Enterprise_num;
			STRING2 child_level 							:= pdataset.level;	
		END;

		return TABLE(pdataset, lHierP2C);
	end;

	//Hierarchy Root to sub
	shared fHierRootSubNew(dataset(Layouts.base.keybuildslim)	pdataset) :=
	function
	
		lHierRootSub := 
		record
			pdataset.bdid;
			pdataset.level;
			pdataset.Enterprise_num;
			pdataset.Parent_Enterprise_number;
		end;

		return table(pdataset, lHierRootSub);

	end;

	shared dHierP2CNew			:= fHierP2CNew		(dFileKeybuild);
	shared dHierRootSubNew	:= fHierRootSubNew(Basebdid			);
	
	export Bdid 				:= tools.macf_FilesIndex('FilterBdids				,{bdid																												}	,{FilterBdids			}'	,knames.Bdid					);
	export BdidHier 		:= tools.macf_FilesIndex('dca_hierarchy			,{bdid																												}	,{dca_hierarchy		}'	,knames.BdidHier			);
	export HierRootSub 	:= tools.macf_FilesIndex('dHierRootSub			,{root, sub																										}	,{dHierRootSub		}'	,knames.HierRootSub		);
	export RootSub 			:= tools.macf_FilesIndex('Basebdid					,{root, sub																										}	,{Basebdid				}'	,knames.RootSub				);
	export HierP2C 			:= tools.macf_FilesIndex('dhierp2c					,{parent_root, parent_sub, child_root, child_sub, child_level	}	,{dhierp2c				}'	,knames.HierP2C				);
	export HierP2CNew 	:= tools.macf_FilesIndex('dHierP2CNew				,{Parent_Enterprise_number, Enterprise_num, child_level				}	,{dHierP2CNew			}'	,knames.HierP2CNew		);
	export HierEntNum 	:= tools.macf_FilesIndex('dHierRootSubNew		,{Enterprise_num																							}	,{dHierRootSubNew	}'	,knames.HierEntNum		);
	export EntNum				:= tools.macf_FilesIndex('EntNumFilt   		  ,{Enterprise_num																							}	,{EntNumFilt  		}'	,knames.EntNum				);
	export EntNumNonFilt:= tools.macf_FilesIndex('EntNumNonFilter		,{Enterprise_num																				    	}	,{EntNumNonFilter }'	,knames.EntNumNonFilt	);
	export ContactBdid 	:= tools.macf_FilesIndex('FilterContBdids		,{bdid																												}	,{FilterContBdids	}'	,knames.ContactBdid		);

end;




