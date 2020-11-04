IMPORT BIPV2, Doxie;

// ---------------------------------------------------------------
// For delta rollup logic (dx_common.mac_incremental_rollup) use:
//  $.mod_delta_rid.key_4510_delta_rid
// ---------------------------------------------------------------

EXPORT Key_4510_UCC_Filings_linkids := MODULE

  // DEFINE THE INDEX
	BIPV2.IDmacros.mac_IndexWithXLinkIDs(File_4510_UCC_Filings_Base, k, KeyName_4510_UCC_Filings_Linkids + '_' + doxie.Version_SuperKey);
	export Key := k;


	//DEFINE THE INDEX ACCESS
	export kFetch(
		dataset(BIPV2.IDlayouts.l_xlink_ids) inputs,
		Doxie.IDataAccess mod_access = MODULE(Doxie.IDataAccess) END,
		string1 Level = BIPV2.IDconstants.Fetch_Level_DotID,	//The lowest level you'd like to pay attention to.  If U, then all the records for the UltID will be returned.
																								//Values:  D is for Dot.  E is for Emp.  W is for POW.  P is for Prox.  O is for Org.  U is for Ult.
																								//Should be enumerated or something?  at least need constants defined somewhere if you keep string1
		unsigned2 ScoreThreshold = 0								//Applied at lowest leve of ID
		) :=
	FUNCTION

		BIPV2.IDmacros.mac_IndexFetch(inputs, Key, fetched, Level)
		EBR.mac_check_access(fetched, out, mod_access);   // Jira# CCPA-98, Function created for CCPA suppressions at key fetches.
		return out;																					

	END;

END;