Import doxie, BIPV2;
EXPORT Key_LinkIds := MODULE
   shared  base_recs 						:= Diversity_Certification.Files().KeyBuildSF;
	 export  out_superfileKeyName := Diversity_Certification.Keynames().LinkIDs.qa; // linkids Key Super FileName
	 
	//filter has been in place for base file records in order to avoid system error (index limit exceeds) during key build time 	   															 
   valid_base :=base_recs (sizeof(base_recs)<=4096);
	
   BIPV2.IDmacros.mac_IndexWithXLinkIDs(valid_base, out_key, out_superfileKeyName);
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