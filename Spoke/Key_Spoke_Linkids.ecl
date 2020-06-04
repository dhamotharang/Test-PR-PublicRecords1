import BIPV2, Data_Services, doxie,ut, versioncontrol;

EXPORT key_spoke_linkids := MODULE

	// DEFINE THE INDEX
	shared superfile_name		:= Spoke.Keynames().LinkIDs.qa;
	shared Base							:= project(Spoke.Files().Base.Built,transform(layouts.keybuild_bip, self := left));

	BIPV2.IDmacros.mac_IndexWithXLinkIDs(Base, k, superfile_name)
	export Key := k;
	
	//DEFINE THE INDEX ACCESS
	// Jira# CCPA-817,  Added mod_access and Mac_check_access to kfetch functions for CCPA suppressions.
	export kFetch(
		dataset(BIPV2.IDlayouts.l_xlink_ids) inputs,
		Doxie.IDataAccess mod_access = MODULE(Doxie.IDataAccess) END,
		string1 Level = BIPV2.IDconstants.Fetch_Level_DotID,	//The lowest level you'd like to pay attention to.  If U, then all the records for the UltID will be returned.
																								//Values:  D is for Dot.  E is for Emp.  W is for POW.  P is for Prox.  O is for Org.  U is for Ult.
																								//Should be enumerated or something?  at least need constants defined somewhere if you keep string1
		unsigned2 ScoreThreshold = 0,								//Applied at lowest leve of ID
		JoinLimit = 25000
		) :=
	FUNCTION

		BIPV2.IDmacros.mac_IndexFetch(inputs, Key, fetched, Level, JoinLimit)
		Spoke.MAC_Check_Access(fetched, out, mod_access);					// Jira# CCPA-817, Function created for CCPA suppressions at key fetches.
		return out;																					

	END;

END;