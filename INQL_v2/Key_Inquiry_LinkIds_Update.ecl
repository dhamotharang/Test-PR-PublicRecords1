IMPORT BIPV2, INQL_v2, Data_services, doxie, BIPV2,Inquiry_AccLogs_Append;

EXPORT Key_Inquiry_LinkIds_Update := MODULE

  // DEFINE THE INDEX
	shared superfile_name	:= Data_Services.Data_location.Prefix('Inquiry') + 'thor_data400::key::inquiry_table::' + doxie.version_superkey  + '::linkids_update';

  shared Layout_inquiry_LinkIds_temp := record
	   INQL_v2.Layouts.Common_ThorAdditions_non_fcra;
		 bipv2.IDlayouts.l_xlink_ids;	 //Added for BIP project
		 end;
	Base_ := Inquiry_AccLogs_Append.FN_Append_Bip(INQL_v2.File_Inquiry_BaseSourced.updates);											
	shared Base := INQL_v2.FN_Append_SBA(Base_);											
	
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
		joinLimit = 25000
		) :=
	FUNCTION

		inputs_for2 := project(inputs, BIPV2.IDlayouts.l_xlink_ids2);
		f2 := kFetch2(inputs_for2, Level, ScoreThreshold, joinLimit);
		return project(f2, recordof(Key));																				

	END;

END;