IMPORT BIPV2, Doxie;

EXPORT Key_1000_Executive_Summary_linkids := MODULE

  // DEFINE THE INDEX
	BIPV2.IDmacros.mac_IndexWithXLinkIDs(File_1000_Executive_Summary_Base, k, KeyName_1000_Executive_Summary_Linkids + '_' + doxie.Version_SuperKey);
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