IMPORT BIPV2, Data_Services, doxie;

EXPORT Key_BBB_LinkIds := MODULE

  // DEFINE THE INDEX
	EXPORT out_SuperKeyName		:= Data_Services.Data_location.Prefix('NONAMEGIVEN')+'thor_data400::key::bbb_linkids_'+ doxie.Version_SuperKey; //SuperKeyName

	SHARED Base						  	:= project(BBB2.Files().Base.Member.Built, transform(BBB2.Layouts_Files.Base.Member_BIP - BBB2.Layouts_Files.Base.Layout_Addr_AID, self := left));

	BIPV2.IDmacros.mac_IndexWithXLinkIDs(Base, k, out_SuperKeyName)
	EXPORT Key := k;

	//DEFINE THE INDEX ACCESS
	EXPORT kFetch2(
		DATASET(BIPV2.IDlayouts.l_xlink_ids2) inputs, 
		STRING1 Level = BIPV2.IDconstants.Fetch_Level_DotID,	//The lowest level you'd like to pay attention to.  If U, then all the records for the UltID will be returned.
																								//Values:  D is for Dot.  E is for Emp.  W is for POW.  P is for Prox.  O is for Org.  U is for Ult.
																								//Should be enumerated or something?  at least need constants defined somewhere if you keep string1
		UNSIGNED2 ScoreThreshold = 0,								//Applied at lowest leve of ID
		joinLimit = 25000,
		UNSIGNED1 JoinType = BIPV2.IDconstants.JoinTypes.KeepJoin
		) :=
	FUNCTION

		BIPV2.IDmacros.mac_IndexFetch2(inputs, Key, out, Level, joinLimit, JoinType);
		RETURN out;																					

	END;
	
	// Depricated version of the above kFetch2
	EXPORT kFetch(
		DATASET(BIPV2.IDlayouts.l_xlink_ids) inputs, 
		STRING1 Level = BIPV2.IDconstants.Fetch_Level_DotID,	//The lowest level you'd like to pay attention to.  If U, then all the records for the UltID will be returned.
																								//Values:  D is for Dot.  E is for Emp.  W is for POW.  P is for Prox.  O is for Org.  U is for Ult.
																								//Should be enumerated or something?  at least need constants defined somewhere if you keep string1
		UNSIGNED2 ScoreThreshold = 0,								//Applied at lowest leve of ID
		JoinLimit = 25000
		) :=
	FUNCTION

		inputs_for2 := PROJECT(inputs, BIPV2.IDlayouts.l_xlink_ids2);
		f2 := kFetch2(inputs_for2, Level, ScoreThreshold, JoinLimit);		
		RETURN PROJECT(f2, RECORDOF(Key));											

	END;

END;