IMPORT BIPV2, Data_Services, doxie;

EXPORT Key_LinkIds := MODULE

  // DEFINE THE INDEX
	EXPORT out_SuperKeyName		:= Data_Services.Data_location.Prefix('ATF')+'thor_data400::key::atf::firearms::linkids_'+ doxie.Version_SuperKey; //SuperKeyName

	SHARED Base						  	:= ATF.file_firearms_explosives_base_BIP;

	BIPV2.IDmacros.mac_IndexWithXLinkIDs(Base, k, out_SuperKeyName)
	EXPORT Key := k;

	//DEFINE THE INDEX ACCESS
	EXPORT kFetch(
		DATASET(BIPV2.IDlayouts.l_xlink_ids) inputs, 
		STRING1 Level = BIPV2.IDconstants.Fetch_Level_DotID,	//The lowest level you'd like to pay attention to.  If U, then all the records for the UltID will be returned.
																								//Values:  D is for Dot.  E is for Emp.  W is for POW.  P is for Prox.  O is for Org.  U is for Ult.
																								//Should be enumerated or something?  at least need constants defined somewhere if you keep string1
		UNSIGNED2 ScoreThreshold = 0,								//Applied at lowest leve of ID
		JoinLimit = 25000
		) :=
	FUNCTION

		BIPV2.IDmacros.mac_IndexFetch(inputs, Key, out, Level, JoinLimit)
		RETURN out;																					

	END;

END;