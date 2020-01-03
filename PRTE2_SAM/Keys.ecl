IMPORT RoxieKeyBuild, AutoKeyB2, PRTE, _control, autokeyb, Business_Header_SS, business_header, ut, doxie, address, PRTE2_Common, Data_Services, doxie, BIPV2, SAM, UT, PromoteSupers, std, Prte2, PRTE2_SAM, Address, AID, AID_Support;

EXPORT Keys := MODULE
  
  EXPORT linkids := MODULE
  // DEFINE THE INDEX
   EXPORT SAM_LinkIds_Name := constants.KEY_PREFIX+doxie.Version_SuperKey+'::linkids';
   EXPORT Base := PROJECT(PRTE2_Sam.Files.Sam_key, PRTE2_sam.layouts.BIP_linkid-Cage);
      
   BIPV2.IDmacros.mac_IndexWithXLinkIDs(Base, k, SAM_LinkIds_Name)
   EXPORT Key := k;
   
	//DEFINE THE INDEX ACCESS
	EXPORT kFetch2(
		DATASET(BIPV2.IDlayouts.l_xlink_ids2) inputs, 
		STRING1 Level = BIPV2.IDconstants.Fetch_Level_DotID,	//The lowest level you'd like to pay attention to.  If U, then all the records for the UltID will be returned.
																								//Values:  D is for Dot.  E is for Emp.  W is for POW.  P is for Prox.  O is for Org.  U is for Ult.
																								//Should be enumerated or something?  at least need constants defined somewhere if you keep string1
		UNSIGNED2 ScoreThreshold = 0,								     //Applied at lowest leve of ID
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
		UNSIGNED2 ScoreThreshold = 0,								     //Applied at lowest leve of ID
		joinLimit = 25000
		) :=
	FUNCTION

		inputs_for2 := PROJECT(inputs, BIPV2.IDlayouts.l_xlink_ids2);
		f2 := kFetch2(inputs_for2, Level, ScoreThreshold, joinLimit);
		RETURN PROJECT(f2, RECORDOF(Key));

	END;
END;
END;