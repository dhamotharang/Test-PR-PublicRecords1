IMPORT BIPV2;

EXPORT Key_LinkIds := MODULE

  // DEFINE THE INDEX
	shared superfile_name		:= $.keynames().LinkIds.QA;
	
	shared Base				:= $.Files.Base;
	
	BIPV2.IDmacros.mac_IndexWithXLinkIDs(Base, k, superfile_name)
	export Key := k;


	//DEFINE THE INDEX ACCESS
	export kFetch(
		dataset(BIPV2.IDlayouts.l_xlink_ids) inputs, 
		string1 Level = BIPV2.IDconstants.Fetch_Level_DotID,	//The lowest level you'd like to pay attention to.  If U, then all the records for the UltID will be returned.
																								//Values:  D is for Dot.  E is for Emp.  W is for POW.  P is for Prox.  O is for Org.  U is for Ult.
																								//Should be enumerated or something?  at least need constants defined somewhere if you keep string1
		unsigned2 ScoreThreshold = 0								//Applied at lowest leve of ID
		) :=
	FUNCTION

		BIPV2.IDmacros.mac_IndexFetch(inputs, Key, out, Level)
		return out;																					

	END;
	
       //DEFINE THE INDEX ACCESS
       export kFetch2(
              dataset(BIPV2.IDlayouts.l_xlink_ids2) inputs, 
              string1 Level = BIPV2.IDconstants.Fetch_Level_DotID,
              unsigned2 ScoreThreshold = 0,
              joinLimit = 25000,
              unsigned1 JoinType = BIPV2.IDconstants.JoinTypes.KeepJoin
              ) :=
       FUNCTION

              BIPV2.IDmacros.mac_IndexFetch2(inputs, Key, out, Level, joinLimit, JoinType);
              return out;
			END;
END;