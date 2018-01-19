IMPORT BIPV2, Prof_License_Mari, Data_Services;

EXPORT key_Linkids := MODULE

  // DEFINE THE INDEX
	shared superfile_name	:= Data_Services.Data_location.Prefix('mari')+'thor_data400::key::proflic_mari::qa::linkids';
		
	shared Base := Prof_License_Mari.file_mari_search;
	
	base_clean := project(Base,{Base}-enh_did_src);				//do not inlucde enh_did_src in the key file
	
	BIPV2.IDmacros.mac_IndexWithXLinkIDs(base_clean, k, superfile_name)
	export Key := k;

	//DEFINE THE INDEX ACCESS
	export kFetch(
		dataset(BIPV2.IDlayouts.l_xlink_ids) inputs, 
		string1 Level = BIPV2.IDconstants.Fetch_Level_DotID,	//The lowest level you'd like to pay attention to.  If U, then all the records for the UltID will be returned.
																								//Values:  D is for Dot.  E is for Emp.  W is for POW.  P is for Prox.  O is for Org.  U is for Ult.
																								//Should be enumerated or something?  at least need constants defined somewhere if you keep string1
		unsigned2 ScoreThreshold = 0								//Applied at lowest leve of ID
		) :=
	FUNCTION

		BIPV2.IDmacros.mac_IndexFetch(inputs, Key, out, Level)
		return out;																					

	END;

END;