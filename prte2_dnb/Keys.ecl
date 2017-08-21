IMPORT  doxie,mdr, prte2_dnb,BIPV2;

EXPORT keys := MODULE

	EXPORT key_dnb_bdid := INDEX(FILES.DNB_BDID((INTEGER)bd > 0),  {bd},  {bd ,duns_number}, 'prte::key::dnb::'+doxie.Version_SuperKey + '::bdid');
	EXPORT key_dnb_dunsnum := INDEX(FILES.DS_dunsNum(duns_number<>''),  
									{string9 duns := duns_number},  
									{FILES.DS_dunsNum(duns_number<>''),string9 duns := duns_number}, 
									'prte::key::dnb::'+doxie.Version_SuperKey + '::dunsnum');						
  EXPORT Key_LinkIds := MODULE


  // DEFINE THE INDEX

	shared Base				:= FILES.dnb_linkids;
	
	BIPV2.IDmacros.mac_IndexWithXLinkIDs(Base, k, constants.KeyName_DNB+'qa::linkids')
	export Key := k;


	//DEFINE THE INDEX ACCESS
	export kFetch2(
		dataset(BIPV2.IDlayouts.l_xlink_ids2) inputs, 
		string1 Level = BIPV2.IDconstants.Fetch_Level_DotID,	//The lowest level you'd like to pay attention to.  If U, then all the records for the UltID will be returned.
																								//Values:  D is for Dot.  E is for Emp.  W is for POW.  P is for Prox.  O is for Org.  U is for Ult.
																								//Should be enumerated or something?  at least need constants defined somewhere if you keep string1
		unsigned2 ScoreThreshold = 0,								//Applied at lowest leve of ID
		joinLimit = 25000,
		unsigned1 JoinType = BIPV2.IDconstants.JoinTypes.KeepJoin
		) :=
	FUNCTION

		BIPV2.IDmacros.mac_IndexFetch2(inputs, Key, out, Level, joinLimit, JoinType);
		return out;																					

	END;
	
	// Depricated version of the above kFetch2
	export kFetch(
		dataset(BIPV2.IDlayouts.l_xlink_ids) inputs, 
		string1 Level = BIPV2.IDconstants.Fetch_Level_DotID,	//The lowest level you'd like to pay attention to.  If U, then all the records for the UltID will be returned.
																								//Values:  D is for Dot.  E is for Emp.  W is for POW.  P is for Prox.  O is for Org.  U is for Ult.
																								//Should be enumerated or something?  at least need constants defined somewhere if you keep string1
		unsigned2 ScoreThreshold = 0								//Applied at lowest leve of ID
		) :=
	FUNCTION

		inputs_for2 := project(inputs, BIPV2.IDlayouts.l_xlink_ids2);
		f2 := kFetch2(inputs_for2, Level, ScoreThreshold);
		return project(f2, recordof(Key));																				

	END;

END;
END;
