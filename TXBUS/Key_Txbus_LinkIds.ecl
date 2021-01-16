IMPORT BIPV2, doxie, Data_Services;
EXPORT Key_Txbus_LinkIds := MODULE
  shared  base_recs 					:= TXBUS.File_Txbus_Base;
	export  out_SuperFile_Name  := Data_Services.Data_location.Prefix('NONAMEGIVEN')+
	                               'thor_data400::key::txbus::'+doxie.Version_SuperKey+'::LinkIds'; //linkid Key Super FileName
	
  BIPV2.IDmacros.mac_IndexWithXLinkIDs(base_recs, out_key, out_SuperFile_Name);
  export Key := out_key;
	
	//DEFINE THE INDEX ACCESS
  export KeyFetch(
	  dataset(BIPV2.IDlayouts.l_xlink_ids) in_ds_withids, 
		string1 Level = BIPV2.IDconstants.Fetch_Level_DotID,	//The lowest level you'd like to pay attention to.  If U, then all the records for the UltID will be returned.
																												 //Values:  D is for Dot.  E is for Emp.  W is for POW.  P is for Prox.  O is for Org.  U is for Ult.
																												//Should be enumerated or something?  at least need constants defined somewhere if you keep string1
		unsigned2 ScoreThreshold = 0,											 //Applied at lowest leve of ID
		joinLimit=25000
								) :=FUNCTION

		BIPV2.IDmacros.mac_IndexFetch(in_ds_withids, Key, out_fetch, Level, joinLimit)
	  return out_fetch;	
  END;


  export KFetch2(
	  dataset(BIPV2.IDlayouts.l_xlink_ids) in_ds_withids, 
		string1 Level = BIPV2.IDconstants.Fetch_Level_DotID,	//The lowest level you'd like to pay attention to.  If U, then all the records for the UltID will be returned.
																												 //Values:  D is for Dot.  E is for Emp.  W is for POW.  P is for Prox.  O is for Org.  U is for Ult.
																												//Should be enumerated or something?  at least need constants defined somewhere if you keep string1
		unsigned2 ScoreThreshold = 0,											 //Applied at lowest leve of ID
		joinLimit=25000,
		UNSIGNED1 JoinType = BIPV2.IDconstants.JoinTypes.KeepJoin
								) :=FUNCTION

		BIPV2.IDmacros.mac_IndexFetch2(in_ds_withids, Key, out_fetch, Level, joinLimit, JoinType);
	  return out_fetch;	
  END;
	
END;