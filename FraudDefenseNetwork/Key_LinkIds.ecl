IMPORT BIPV2, dx_FraudDefenseNetwork;

EXPORT Key_LinkIds := MODULE

  // DEFINE THE INDEX
	SHARED superfile_name	:= dx_FraudDefenseNetwork.Names.i_LINKIDS_SF;
  
 	SHARED Base       := FraudDefenseNetwork.File_KeyBuild(); 

	BIPV2.IDmacros.mac_IndexWithXLinkIDs(Base, k, superfile_name)
	
	EXPORT Key := k;

	//DEFINE THE INDEX ACCESS
	EXPORT kFetch(
		DATASET(BIPV2.IDlayouts.l_xlink_ids) inputs, 
		STRING1 Level = BIPV2.IDconstants.Fetch_Level_DotID,	//The lowest level you'd like to pay attention to.  If U, then all the records for the UltID will be returned.
																								//Values:  D is for Dot.  E is for Emp.  W is for POW.  P is for Prox.  O is for Org.  U is for Ult.
																								//Should be enumerated or something?  at least need constants defined somewhere if you keep string1
		UNSIGNED2 ScoreThreshold = 0								//Applied at lowest leve of ID
		) :=
	FUNCTION

		BIPV2.IDmacros.mac_IndexFetch(inputs, Key, out, Level)
		RETURN out;																					

	END;

END;