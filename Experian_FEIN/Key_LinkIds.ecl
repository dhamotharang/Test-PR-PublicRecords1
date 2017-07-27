IMPORT AutoStandardI, BIPV2;

EXPORT Key_LinkIds := MODULE

  // DEFINE THE INDEX
	shared superfile_name	:= Experian_FEIN.keynames().LinkIds.QA;
	
	shared Base			   	  := Experian_FEIN.Files().Base.Built;
		
	BIPV2.IDmacros.mac_IndexWithXLinkIDs(Base, k, superfile_name)
	export Key := k;

	//DEFINE THE INDEX ACCESS
	export kFetch(
		dataset(BIPV2.IDlayouts.l_xlink_ids) inputs, 
		string1 Level = BIPV2.IDconstants.Fetch_Level_DotID,	//The lowest level you'd like to pay attention to.  If U, then all the records for the UltID will be returned.
																								//Values:  D is for Dot.  E is for Emp.  W is for POW.  P is for Prox.  O is for Org.  U is for Ult.
																								//Should be enumerated or something?  at least need constants defined somewhere if you keep string1
		unsigned2 ScoreThreshold = 0,								//Applied at lowest leve of ID
    BIPV2.mod_sources.iParams in_mod=PROJECT(AutoStandardI.GlobalModule(),BIPV2.mod_sources.iParams,opt)
		) := FUNCTION

		BIPV2.IDmacros.mac_IndexFetch(inputs, Key, ds_fetched, Level);
    
    // Apply restrictions
    ds_restricted := ds_fetched(BIPV2.mod_sources.isPermitted(in_mod).bySource(source));
    
		return ds_restricted;																					

	END;

END;
