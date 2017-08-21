 Import doxie, BIPV2;

EXPORT keys := MODULE

EXPORT Key_Experian_LinkIDs := MODULE
BIPV2.IDmacros.mac_IndexWithXLinkIDs(files.CRDB, out_key, 
	    constants.KeyName_experian_crdb + doxie.Version_SuperKey + '::linkids');
	
 Export Key:=out_key;
    
   export KeyFetch(
	  dataset(BIPV2.IDlayouts.l_xlink_ids) in_ds_withids, 
		string1 Level = BIPV2.IDconstants.Fetch_Level_DotID,	
		unsigned2 ScoreThreshold = 0											
		) :=FUNCTION
		BIPV2.IDmacros.mac_IndexFetch(in_ds_withids, Key, out_fetch, Level)
	  return out_fetch;																					
  END;
 END;
END;
