IMPORT BIPV2, doxie;

EXPORT Key_LinkIds := MODULE
  export  KeyName       			:= cluster.cluster_out+'Key::FBNV2::';
  shared  base_recs 					:= FBNV2.File_FBN_Business_Base_AID;
	export  out_logicalKeyName  := KeyName+doxie.Version_SuperKey+'::linkids'; //linkid Key Super FileName
	
  BIPV2.IDmacros.mac_IndexWithXLinkIDs(base_recs, out_key, out_logicalKeyName);
  export Key := out_key;

  
	
	//DEFINE THE INDEX ACCESS
	export kFetch2(
	  dataset(BIPV2.IDlayouts.l_xlink_ids2) inputs,
		Doxie.IDataAccess mod_access = MODULE(Doxie.IDataAccess) END,
		string1 Level = BIPV2.IDconstants.Fetch_Level_DotID,	//The lowest level you'd like to pay attention to.  If U, then all the records for the UltID will be returned.
																												 //Values:  D is for Dot.  E is for Emp.  W is for POW.  P is for Prox.  O is for Org.  U is for Ult.
																												//Should be enumerated or something?  at least need constants defined somewhere if you keep string1
		unsigned2 ScoreThreshold = 0,											 //Applied at lowest leve of ID
		joinLimit = 25000,
		unsigned1 JoinType = BIPV2.IDconstants.JoinTypes.KeepJoin
								) :=FUNCTION

		BIPV2.IDmacros.mac_IndexFetch2(inputs, Key, fetched, Level, joinLimit, JoinType);
		FBNV2.MAC_Check_Access(fetched, out_fetch, mod_access);		// Jira# CCPA-100, Function created for CCPA suppressions at key fetches.
	  return out_fetch;	
  END;
	
	// Depricated version of the above kFetch2
  export KeyFetch(
	  dataset(BIPV2.IDlayouts.l_xlink_ids) in_ds_withids,
		Doxie.IDataAccess mod_access = MODULE(Doxie.IDataAccess) END,
		string1 Level = BIPV2.IDconstants.Fetch_Level_DotID,	//The lowest level you'd like to pay attention to.  If U, then all the records for the UltID will be returned.
																												 //Values:  D is for Dot.  E is for Emp.  W is for POW.  P is for Prox.  O is for Org.  U is for Ult.
																												//Should be enumerated or something?  at least need constants defined somewhere if you keep string1
		unsigned2 ScoreThreshold = 0,											 //Applied at lowest leve of ID
		joinLimit = 25000
								) :=FUNCTION

		inputs_for2 := project(in_ds_withids, BIPV2.IDlayouts.l_xlink_ids2);
		f2 := kFetch2(inputs_for2, mod_access, Level, ScoreThreshold, JoinLimit);
		return project(f2, recordof(Key));		
  END;

END;