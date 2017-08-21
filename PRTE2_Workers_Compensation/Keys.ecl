IMPORT  doxie, BIPV2, PRTE2_Workers_Compensation;

EXPORT keys := MODULE

	EXPORT key_workers_compensation_bdid := 
	INDEX(Files.file_bdid, 
				{bdid}, 
				{Files.file_bdid}, 
				Constants.KeyName_Workers_Compensation + doxie.Version_SuperKey + '::bdid'
				);
	
	EXPORT key_workers_compensation_linkids := MODULE
		// DEFINE THE INDEX
		BIPV2.IDmacros.mac_IndexWithXLinkIDs(Files.file_keybuild, k, Constants.KeyName_Workers_Compensation  + doxie.Version_SuperKey + '::linkids')
		export Key := k;

		//DEFINE THE INDEX ACCESS
		export kFetch(
			dataset(BIPV2.IDlayouts.l_xlink_ids) inputs, 
			string1 Level = BIPV2.IDconstants.Fetch_Level_DotID,	//The lowest level you'd like to pay attention to.  If U, then all the records for the UltID will be returned.
																									//Values:  D is for Dot.  E is for Emp.  W is for POW.  P is for Prox.  O is for Org.  U is for Ult.
																									//Should be enumerated or something?  at least need constants defined somewhere if you keep string1
			unsigned2 ScoreThreshold = 0								//Applied at lowest leve of ID
			) := FUNCTION

			BIPV2.IDmacros.mac_IndexFetch(inputs, Key, out, Level)
			return out;																					

		END;
	END;

END;
