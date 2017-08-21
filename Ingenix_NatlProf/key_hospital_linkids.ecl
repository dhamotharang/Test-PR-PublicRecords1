IMPORT BIPV2, doxie;

EXPORT key_hospital_linkids := MODULE
		shared  base_recs 					:= Ingenix_NatlProf.Basefile_Hospital_BDID_BIP;
		export  out_superfilekeyname  := '~thor_data400::key::ingenix_hospital_linkids_' + Doxie.Version_SuperKey; //linkid Key Super FileName
		
		BIPV2.IDmacros.mac_IndexWithXLinkIDs(base_recs, out_key, out_superfilekeyname);
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