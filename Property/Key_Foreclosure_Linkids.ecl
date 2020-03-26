import BIPV2, Data_Services, doxie,ut, versioncontrol;

EXPORT Key_Foreclosure_Linkids := MODULE

// Suppressing 4 Foreclosure IDs as part of dispute database Bug#: 60282 and bugzilla bug#: 170863 
 Shared FC_ids := ['058118BANKOFAMERICA', '058118ESCOBARCARLOSG', '1079290090820TRUCAPREOCORP', '1079290090820TRUCAPGRANTORTRUST2010-1'];
	// DEFINE THE INDEX
	shared superfile_name		:= _Dataset().thor_cluster_files + 'key::' + _dataset().Name + '::qa::linkids';
	shared Base							:= Property.File_Foreclosure_Bip(Trim(foreclosure_id, left, right) not in FC_ids);

	BIPV2.IDmacros.mac_IndexWithXLinkIDs(Base, k, superfile_name)
	export Key := k;
	
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
	//DEFINE THE INDEX ACCESS
	export kFetch(
		dataset(BIPV2.IDlayouts.l_xlink_ids) inputs, 
		string1 Level = BIPV2.IDconstants.Fetch_Level_DotID,	//The lowest level you'd like to pay attention to.  If U, then all the records for the UltID will be returned.
																								//Values:  D is for Dot.  E is for Emp.  W is for POW.  P is for Prox.  O is for Org.  U is for Ult.
																								//Should be enumerated or something?  at least need constants defined somewhere if you keep string1
		unsigned2 ScoreThreshold = 0,								//Applied at lowest leve of ID
		Joinlimit = 25000
		) :=
	FUNCTION
	
	  inputs_for2 := project(inputs, BIPV2.IDlayouts.l_xlink_ids2);
		f2 := kFetch2(inputs_for2, Level, ScoreThreshold, JoinLimit);		
		return project(f2, recordof(Key));

		// BIPV2.IDmacros.mac_IndexFetch(inputs, Key, out, Level, joinLimit)
		// return out;																					

	END;

END;