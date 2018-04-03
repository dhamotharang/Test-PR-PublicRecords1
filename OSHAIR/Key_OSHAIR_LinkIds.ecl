IMPORT BIPV2, Data_Services, doxie;

EXPORT Key_OSHAIR_LinkIds := MODULE

  // DEFINE THE INDEX
	EXPORT out_SuperKeyName		:= Data_Services.Data_location.Prefix('NONAMEGIVEN')+'thor_data400::key::oshair::linkids_'+ doxie.Version_SuperKey; //SuperKeyName

	SHARED Base						  	:= OSHAIR.file_out_inspection_cleaned_both;
 
  slimLayout	:=	record
		OSHAIR.layout_OSHAIR_inspection_clean_BIP	 
		  - dt_first_seen	- dt_last_seen						 
			- dt_vendor_first_reported - dt_vendor_last_reported
			- raw_aid -ace_aid;	  
  end;

  NewKeyBuild	:=	project(Base, TRANSFORM(slimLayout,SELF := LEFT;));

	BIPV2.IDmacros.mac_IndexWithXLinkIDs(NewKeyBuild, k, out_SuperKeyName);
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
		UNSIGNED2 ScoreThreshold = 0,													//Applied at lowest leve of ID
		joinLimit = 25000
		) :=
	FUNCTION

		inputs_for2 := project(inputs, BIPV2.IDlayouts.l_xlink_ids2);
		f2 := kFetch2(inputs_for2, Level, ScoreThreshold, joinLimit);
		return project(f2, recordof(Key));

	END;

END;