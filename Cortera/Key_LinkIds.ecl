IMPORT $, BIPV2, doxie;

EXPORT Key_LinkIds := MODULE

  // DEFINE THE INDEX
	shared superfile_name		:= cortera.keynames().LinkIds.qa;
	
	shared Base				:= Cortera.Files().Base.Header.built(COUNTRY='US');
	
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
              unsigned1 JoinType = BIPV2.IDconstants.JoinTypes.KeepJoin,
              doxie.IDataAccess mod_access = MODULE (doxie.IDataAccess) END,
              boolean append_contact = FALSE
              ) :=
       FUNCTION

              BIPV2.IDmacros.mac_IndexFetch2(inputs, Key, fetched, Level, joinLimit, JoinType);
							$.mac_append_contact(fetched, out, mod_access, append_contact);
              return out;
			END;
END;