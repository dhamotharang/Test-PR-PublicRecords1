﻿IMPORT BIPV2, doxie;

EXPORT Key_LinkIds := MODULE

  // DEFINE THE INDEX
	shared superfile_name	:= Experian_CRDB.keynames().LinkIds.QA;
	
	shared Base			   	  := Experian_CRDB.Files().Base.Built;
		
	BIPV2.IDmacros.mac_IndexWithXLinkIDs(Base, k, superfile_name)
	export Key := k;

	//DEFINE THE INDEX ACCESS
	export kFetch2(
		dataset(BIPV2.IDlayouts.l_xlink_ids2) inputs, 
		doxie.IDataAccess mod_access = MODULE (doxie.IDataAccess) END,
		string1 Level = BIPV2.IDconstants.Fetch_Level_DotID,	//The lowest level you'd like to pay attention to.  If U, then all the records for the UltID will be returned.
																								//Values:  D is for Dot.  E is for Emp.  W is for POW.  P is for Prox.  O is for Org.  U is for Ult.
																								//Should be enumerated or something?  at least need constants defined somewhere if you keep string1
		unsigned2 ScoreThreshold = 0,							//Applied at lowest leve of ID
		JoinLimit = 25000,
    unsigned1 JoinType = BIPV2.IDconstants.JoinTypes.KeepJoin
		) := FUNCTION

		BIPV2.IDmacros.mac_IndexFetch2(inputs, Key, fetched, Level, JoinLimit, JoinType);
		Experian_CRDB.mac_check_access(fetched, out, mod_access);
		return out;																					

	END;

	export kFetch(
		dataset(BIPV2.IDlayouts.l_xlink_ids) inputs, 
		doxie.IDataAccess mod_access = MODULE (doxie.IDataAccess) END,
		string1 Level = BIPV2.IDconstants.Fetch_Level_DotID,	//The lowest level you'd like to pay attention to.  If U, then all the records for the UltID will be returned.
																								//Values:  D is for Dot.  E is for Emp.  W is for POW.  P is for Prox.  O is for Org.  U is for Ult.
																								//Should be enumerated or something?  at least need constants defined somewhere if you keep string1
		unsigned2 ScoreThreshold = 0								//Applied at lowest leve of ID
		) := FUNCTION

		inputs_for2 := project(inputs, BIPV2.IDlayouts.l_xlink_ids2);
		f2 := kFetch2(inputs_for2, mod_access, Level, ScoreThreshold);
		return project(f2, recordof(Key));													

	END;
END;