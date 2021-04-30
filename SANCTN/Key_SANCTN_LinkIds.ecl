IMPORT BIPV2, SANCTN,Data_Services, Doxie;

EXPORT Key_SANCTN_LinkIds := MODULE

  // DEFINE THE INDEX
	shared superfile_name	:= Data_Services.Data_Location.Prefix('Telcordia')+'thor_data400::key::sanctn::linkids_qa';
		
	shared Base := SANCTN.file_base_party;
	
	base_clean := project(Base,{Base}-enh_did_src);				//do not inlucde enh_did_src in the key file
	
	BIPV2.IDmacros.mac_IndexWithXLinkIDs(base_clean, k, superfile_name)
	export Key := k;

	//DEFINE THE INDEX ACCESS
	// Jira# CCPA-818,  Added mod_access and Mac_check_access to kfetch functions for CCPA suppressions.
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
		Sanctn.MAC_Check_Access(fetched, out, mod_access);					// Jira# CCPA-818, Function created for CCPA suppressions at key fetches.
		return out;																					

	END;

END;