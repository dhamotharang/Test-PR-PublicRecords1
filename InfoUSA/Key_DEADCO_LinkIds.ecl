IMPORT Data_Services, Doxie, BIPV2;

EXPORT Key_DEADCO_LinkIds := MODULE

  // DEFINE THE INDEX
	shared superfile_name	:= Data_Services.Data_location.Prefix('DEADCO') + 'thor_data400::key::infousa::deadco::qa::linkids';
	
	shared Base := File_DEADCO_Base_AID;
	
	BIPV2.IDmacros.mac_IndexWithXLinkIDs(Base, k, superfile_name)
	export Key := k;

	//DEFINE THE INDEX ACCESS
	
	export kFetch2(
		dataset(BIPV2.IDlayouts.l_xlink_ids2) inputs,
		Doxie.IDataAccess mod_access = MODULE(Doxie.IDataAccess) END,
		string1 Level = BIPV2.IDconstants.Fetch_Level_DotID,	//The lowest level you'd like to pay attention to.  If U, then all the records for the UltID will be returned.
																								//Values:  D is for Dot.  E is for Emp.  W is for POW.  P is for Prox.  O is for Org.  U is for Ult.
																								//Should be enumerated or something?  at least need constants defined somewhere if you keep string1
		unsigned2 ScoreThreshold = 0,								//Applied at lowest leve of ID
		joinLimit = 25000,
		unsigned1 JoinType = BIPV2.IDconstants.JoinTypes.KeepJoin
		) :=
	FUNCTION

		BIPV2.IDmacros.mac_IndexFetch2(inputs, Key, fetched, Level, joinLimit, JoinType);
		InfoUSA.MAC_Check_Access(fetched, out, mod_access);					// Jira# CCPA-820, Function created for CCPA suppressions at key fetches.
		return out;																					

	END;
	
	// Depricated version of the above kFetch2
	export kFetch(
		dataset(BIPV2.IDlayouts.l_xlink_ids) inputs,
		Doxie.IDataAccess mod_access = MODULE(Doxie.IDataAccess) END,
		string1 Level = BIPV2.IDconstants.Fetch_Level_DotID,	//The lowest level you'd like to pay attention to.  If U, then all the records for the UltID will be returned.
																								//Values:  D is for Dot.  E is for Emp.  W is for POW.  P is for Prox.  O is for Org.  U is for Ult.
																								//Should be enumerated or something?  at least need constants defined somewhere if you keep string1
		unsigned2 ScoreThreshold = 0,								//Applied at lowest leve of ID
		joinLimit = 25000
		) :=
	FUNCTION

		inputs_for2 := project(inputs, BIPV2.IDlayouts.l_xlink_ids2);
		f2 := kFetch2(inputs_for2, mod_access, Level, ScoreThreshold, joinLimit);
		return project(f2, recordof(Key));																			

	END;

END;