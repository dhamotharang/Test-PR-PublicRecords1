IMPORT BIPV2, Doxie;

EXPORT Key_LinkIds := MODULE

  // DEFINE THE INDEX
	shared superfile_name		:= PAW.Keynames().LinkIds.qa;
	
	shared Base := PAW.File_base_CleanAddr_Keybuild_BIPv2;
	File_To_Process_To_Key	:= File_keybuild_BIPv2(Base);
	
	shared DedupBase := dedup(sort(distribute(File_To_Process_To_Key,hash(did,bdid)),record, local),record,local);

	BIPV2.IDmacros.mac_IndexWithXLinkIDs(DedupBase, k, superfile_name)
	export Key := k;


	//DEFINE THE INDEX ACCESS
	export kFetch(
		dataset(BIPV2.IDlayouts.l_xlink_ids) inputs,
		Doxie.IDataAccess mod_access = MODULE(Doxie.IDataAccess) END,
		string1 Level = BIPV2.IDconstants.Fetch_Level_DotID,	//The lowest level you'd like to pay attention to.  If U, then all the records for the UltID will be returned.
																													//Values:  D is for Dot.  E is for Emp.  W is for POW.  P is for Prox.  O is for Org.  U is for Ult.
																													//Should be enumerated or something?  at least need constants defined somewhere if you keep string1
		unsigned2 ScoreThreshold = 0													//Applied at lowest leve of ID
		) :=
	FUNCTION

		BIPV2.IDmacros.mac_IndexFetch(inputs, Key, fetched, Level)
		PAW.Mac_Check_Access(fetched, out, mod_access);						// Jira# RR-15825, Function created for CCPA suppressions at key fetches.
		return out;																					

	END;
	
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
		PAW.Mac_Check_Access(fetched, out, mod_access);						// Jira# RR-15825, Function created for CCPA suppressions at key fetches.
		return out;																					

	END;
end;