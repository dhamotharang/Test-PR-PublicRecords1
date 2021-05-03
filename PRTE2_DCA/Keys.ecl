IMPORT  doxie,mdr, PRTE2_DCA, BIPV2;

EXPORT keys := MODULE

	EXPORT key_linkids := MODULE
		
		BIPV2.IDmacros.mac_IndexWithXLinkIDs(Files.file_linkids, k, Constants.dca_keyname   + doxie.Version_SuperKey +  '::linkids')
		export Key := k;
	
			
		//DEFINE THE INDEX ACCESS
		export kFetch(
			dataset(BIPV2.IDlayouts.l_xlink_ids2) inputs, 
			string1 Level = BIPV2.IDconstants.Fetch_Level_DotID,	//The lowest level you'd like to pay attention to.  If U, then all the records for the UltID will be returned.
																									//Values:  D is for Dot.  E is for Emp.  W is for POW.  P is for Prox.  O is for Org.  U is for Ult.
																									//Should be enumerated or something?  at least need constants defined somewhere if you keep string1
			unsigned2 ScoreThreshold = 0,								//Applied at lowest leve of ID
			joinLimit = 25000,
			unsigned1 JoinType = BIPV2.IDconstants.JoinTypes.KeepJoin
			) :=
		FUNCTION

			BIPV2.IDmacros.mac_IndexFetch2(inputs, Key, out, Level, joinLimit, JoinType);
			return out;																					

		END;
	
	END;
		
	
	
	EXPORT key_bdid := 
		INDEX(Files.file_bdid, 
					{bdid}, 
					{Files.file_bdid}, 
					Constants.dca_keyname   + doxie.Version_SuperKey +  '::bdid');

	EXPORT key_entnum := 
		INDEX(Files.file_entnum, 
					{enterprise_num}, 
					{Files.file_entnum}, 
					Constants.dca_keyname  + doxie.Version_SuperKey + '::entnum');

	EXPORT key_entnum_nonfilt := 
		INDEX(Files.file_entnum, 
					{enterprise_num}, 
					{Files.file_entnum}, 
					Constants.dca_keyname  + doxie.Version_SuperKey + '::entnum_nonfilt');

	EXPORT key_hierarchy_parent_to_child_entnum := 
		INDEX(Files.file_hierarchy_parent_to_child_entnum, 
					{parent_enterprise_number,enterprise_num,child_level}, 
					{Files.file_hierarchy_parent_to_child_entnum}, 
					Constants.dca_keyname  + doxie.Version_SuperKey + '::hierarchy_parent_to_child_entnum');

	EXPORT key_hierarchy_bdid := 
		INDEX(Files.file_hierarchy_bdid, 
					{bdid}, 
					{Files.file_hierarchy_bdid}, 
					Constants.dca_keyname   + doxie.Version_SuperKey +  '::hierarchy_bdid' );

	EXPORT key_hierarchy_parent_to_child_root_sub := 
		INDEX(Files.file_hierarchy_parent_to_child_root_sub, 
					{parent_root,parent_sub,child_root,child_sub,child_level}, 
					{Files.file_hierarchy_parent_to_child_root_sub}, 
					Constants.dca_keyname   + doxie.Version_SuperKey +  '::hierarchy_parent_to_child_root_sub');
					
	EXPORT key_hierarchy_root_sub := 
		INDEX(Files.file_hierarchy_root_sub, 
					{root,sub}, 
					{Files.file_hierarchy_root_sub}, 
					Constants.dca_keyname   + doxie.Version_SuperKey +  '::hierarchy_root_sub');
					
	EXPORT key_root_sub := 
		INDEX(Files.file_root_sub, 
					{root,sub}, 
					{Files.file_root_sub}, 
					Constants.dca_keyname   + doxie.Version_SuperKey +  '::root_sub');

//CCPA Phase 2
	EXPORT key_contacts_bdid := INDEX(Files.contacts_bdid, {bdid}, {Files.contacts_bdid}, Constants.dca_keyname   + doxie.Version_SuperKey +  '::contacts_bdid');
END;
