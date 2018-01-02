IMPORT BIPV2, doxie, data_services;

EXPORT  Key_AMIDIR_LinkIDs := MODULE
  shared  base_recs 					:= AMIDIR.File_AMIDIR_DID_SSN_BDID_BIP(Business_Name<>'');
	export  out_superfile_Name  := data_services.data_location.prefix() + 'thor_data400::key::amidir_LinkIDs_' + Doxie.Version_SuperKey; //linkid Key Super FileName
	
  BIPV2.IDmacros.mac_IndexWithXLinkIDs(base_recs, out_key, out_superfile_Name);
  export Key := out_key;
	
	//DEFINE THE INDEX ACCESS
	export KeyFetch(
		dataset(BIPV2.IDlayouts.l_xlink_ids) in_ds_withids, 
		string1 Level = BIPV2.IDconstants.Fetch_Level_DotID,	//The lowest level you'd like to pay attention to.  If U, then all the records for the UltID will be returned.
																												 //Values:  D is for Dot.  E is for Emp.  W is for POW.  P is for Prox.  O is for Org.  U is for Ult.
																												//Should be enumerated or something?  at least need constants defined somewhere if you keep string1
		unsigned2 ScoreThreshold = 0											 //Applied at lowest leve of ID
								) :=FUNCTION

		BIPV2.IDmacros.mac_IndexFetch(in_ds_withids, Key, out_fetch, Level)
		return out_fetch;	
	END;

END;