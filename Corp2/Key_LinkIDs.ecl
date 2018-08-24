IMPORT BIPV2, corp2_mapping;

EXPORT Key_LinkIds := MODULE

export Corp :=
	module

  // DEFINE THE INDEX
	shared superfile_name		:= corp2.keynames('').corp.LinkIds.QA;
	
	shared CorpBase := corp2.Files().AID.Corp.Built;

//Cleanup Corp base file	
  CorpBase TFixCorpBase(CorpBase L) := TRANSFORM
		SELF.corp_legal_name 			:= Corp2_Mapping.fn_RemoveSpecialChars(L.corp_legal_name);
		SELF.corp_sos_charter_nbr := StringLib.StringToUpperCase(L.corp_sos_charter_nbr);
    SELF := L;
  END;
	
	shared Base := dedup(sort(distribute(PROJECT(CorpBase,TFixCorpBase(LEFT)),hash(corp_key)),record, local),record,local);
	
	BIPV2.IDmacros.mac_IndexWithXLinkIDs(Base, k, superfile_name)
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
		unsigned2 ScoreThreshold = 0,								//Applied at lowest leve of ID
		JOINLIMIT = 25000
		) :=
	FUNCTION

		inputs_for2 := project(inputs, BIPV2.IDlayouts.l_xlink_ids2);
		f2 := kFetch2(inputs_for2, Level, ScoreThreshold,JoinLimit);		
		return project(f2, recordof(Key));																					

	END;

	END;
	
export Cont :=
	module

  // DEFINE THE INDEX
	shared superfile_name		:= corp2.keynames('').cont.LinkIds.QA;
	
	shared ContBase := corp2.Files().AID.Cont.Built;


  ContBase TFixContBase(ContBase L) := TRANSFORM,
												skip(length(Corp2_Mapping.fn_RemoveSpecialChars(L.cont_name)) <= 1)
												
		SELF.corp_legal_name 	:= Corp2_Mapping.fn_RemoveSpecialChars(L.corp_legal_name);
		SELF.cont_cname 			:= Corp2_Mapping.fn_RemoveSpecialChars(L.cont_cname);
		SELF.cont_name  			:= Corp2_Mapping.fn_RemoveSpecialChars(L.cont_name);
    SELF.cont_fname 			:= Corp2_Mapping.fn_RemoveSpecialChars(L.cont_fname);
    SELF.cont_mname 			:= Corp2_Mapping.fn_RemoveSpecialChars(L.cont_mname);
    SELF.cont_lname 			:= Corp2_Mapping.fn_RemoveSpecialChars(L.cont_lname);
		SELF.corp_sos_charter_nbr := StringLib.StringToUpperCase(L.corp_sos_charter_nbr);
    SELF := L;
  END;
	
	shared Base := dedup(sort(distribute(PROJECT(ContBase,TFixContBase(LEFT)),hash(corp_key)),record, local),record,local);
	
	BIPV2.IDmacros.mac_IndexWithXLinkIDs(Base, k, superfile_name)
	export Key := k;


	//DEFINE THE INDEX ACCESS
	export kFetch(
		dataset(BIPV2.IDlayouts.l_xlink_ids) inputs, 
		string1 Level = BIPV2.IDconstants.Fetch_Level_DotID,	//The lowest level you'd like to pay attention to.  If U, then all the records for the UltID will be returned.
																								//Values:  D is for Dot.  E is for Emp.  W is for POW.  P is for Prox.  O is for Org.  U is for Ult.
																								//Should be enumerated or something?  at least need constants defined somewhere if you keep string1
		unsigned2 ScoreThreshold = 0,								//Applied at lowest leve of ID
		JOINLIMIT = 25000
		) :=
	FUNCTION

		BIPV2.IDmacros.mac_IndexFetch(inputs, Key, out, Level,JOINLimit)
		return out;																					

	END;

	END;
end;
