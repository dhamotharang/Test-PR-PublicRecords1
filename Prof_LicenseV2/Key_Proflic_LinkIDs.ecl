IMPORT doxie, BIPV2, Data_Services;

EXPORT Key_Proflic_LinkIDs := MODULE

  shared  base_recs 					:= Prof_LicenseV2.File_Proflic_Base_Keybuild(company_name<>'');
	export  out_SuperFileName   := Data_Services.Data_location.Prefix('NONAMEGIVEN')
	                               +'thor_data400::key::prolicv2::'+ doxie.Version_SuperKey +'::linkids'; //SuperFileName
	
  BIPV2.IDmacros.mac_IndexWithXLinkIDs(base_recs, out_key, out_SuperFileName)
	
  export Key := out_key;

  //DEFINE THE INDEX ACCESS
  export KeyFetch(
	  dataset(BIPV2.IDlayouts.l_xlink_ids) in_ds_withids, 
		string1 Level = BIPV2.IDconstants.Fetch_Level_DotID,	//The lowest level you'd like to pay attention to.  If U, then all the records for the UltID will be returned.
																												 //Values:  D is for Dot.  E is for Emp.  W is for POW.  P is for Prox.  O is for Org.  U is for Ult.
																												//Should be enumerated or something?  at least need constants defined somewhere if you keep string1
		unsigned2 ScoreThreshold = 0,											 //Applied at lowest leve of ID
		JoinLimit = 25000
								) :=FUNCTION

		BIPV2.IDmacros.mac_IndexFetch(in_ds_withids, Key, out_fetch, Level, JoinLimit)
	  return out_fetch;																					

  END;

END;