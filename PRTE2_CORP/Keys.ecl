IMPORT  doxie,mdr, Corp2,BIPV2, corp2_mapping;

EXPORT keys := MODULE

EXPORT key_corp_ar := INDEX(FILES.DS_AR_key, {corp_key,record_type}, 
	 {files.DS_AR_key}, 
	Constants.KeyName_corp2 + doxie.Version_SuperKey + '::ar::corp_key.record_type');
	
	EXPORT key_corp_event := INDEX(FILES.DS_event_key, {corp_key,record_type}, 
	 {files.DS_event_key}, 
	Constants.KeyName_corp2 + doxie.Version_SuperKey + '::event:corp_key.record_type');
	
	EXPORT key_corp_stock := INDEX(FILES.DS_stock_key, {corp_key,record_type}, 
	 {files.DS_stock_key}, 
	Constants.KeyName_corp2 + doxie.Version_SuperKey + '::event:corp_key.record_type');
		
	EXPORT key_corp_cont_did := INDEX(FILES.DS_cont_did_key (did!=0), {did}, 
	 {files.DS_cont_did_key}, 
	 Constants.KeyName_corp2 + doxie.Version_SuperKey + '::cont::did');
	 
	 EXPORT key_corp_corp_bdid := INDEX(FILES.DS_corp_bdid_key (bdid!=0), {bdid}, 
	 {files.DS_corp_bdid_key}, 
	 Constants.KeyName_corp2 + doxie.Version_SuperKey + '::cont::bdid');
		
	 EXPORT key_corp_corp_record_key := INDEX(FILES.DS_corp_record_key, {corp_key,record_type}, 
   {files.DS_corp_record_key},
	 Constants.KeyName_corp2 + doxie.Version_SuperKey + '::corp::corp_key.record_type');
	 
	 EXPORT key_corp2_corpst := INDEX(FILES.DS_corp_charter_key, 
	 {corp_state_origin,corp_sos_charter_nbr}, 
	 {FILES.DS_corp_charter_key}, 
	Constants.KeyName_corp2 + doxie.Version_SuperKey + '::corp::st.charter_number');
		
	EXPORT key_corp2_corpbdidpl := INDEX(Files.DS_corp_pl_key (bdid!=0), 
	 {bdid}, {Files.DS_corp_pl_key},
	 Constants.KeyName_corp2 + doxie.Version_SuperKey + '::corp::bdid.pl');
	 
	 EXPORT key_corp2_contbdid := INDEX(FILES.DS_corp2_contbdid_key (bdid!=0), 
	 {bdid}, {files.DS_corp2_contbdid_key}, 
	 Constants.KeyName_corp2 + doxie.Version_SuperKey + '::cont::bdid');
	 
	 EXPORT key_corp2_contcorp := INDEX(FILES.DS_cont_corp_key_record_type (Corp_key != ''), 
	 {corp_key,record_type}, {FILES.DS_cont_corp_key_record_type},
	 Constants.KeyName_corp2 + doxie.Version_SuperKey + '::cont::corp_key.record_type');
	 
	 EXPORT Key_Corp2_LinkIDs := MODULE

  shared CorpBase := project(files.Corp2_corp_Base,corp2.Layout_Corporate_Direct_Corp_AID);

//Cleanup Corp base file	
  CorpBase TFixCorpBase(CorpBase L) := TRANSFORM
		SELF.corp_legal_name 			:= Corp2_Mapping.fn_RemoveSpecialChars(L.corp_legal_name);
		SELF.corp_sos_charter_nbr := StringLib.StringToUpperCase(L.corp_sos_charter_nbr);
    SELF := L;
  END;
	
	shared Base := dedup(sort(distribute(PROJECT(CorpBase,TFixCorpBase(LEFT)),hash(corp_key)),record, local),record,local);
	
	BIPV2.IDmacros.mac_IndexWithXLinkIDs(Base, out_key, constants.keyname_corp2 + doxie.version_superKey+ '::corp::linkids');
	export Key := out_key;


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
																								// Values:  D is for Dot.  E is for Emp.  W is for POW.  P is for Prox.  O is for Org.  U is for Ult.
																								// Should be enumerated or something?  at least need constants defined somewhere if you keep string1
		unsigned2 ScoreThreshold = 0,								//Applied at lowest leve of ID
		JOINLIMIT = 25000
		) :=
	FUNCTION

		inputs_for2 := project(inputs, BIPV2.IDlayouts.l_xlink_ids2);
		f2 := kFetch2(inputs_for2, Level, ScoreThreshold,JoinLimit);		
		return project(f2, recordof(Key));																					

	END;

	END;
	 
	
END;
