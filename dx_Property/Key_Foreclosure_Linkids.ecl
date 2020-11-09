IMPORT $, Data_Services, Doxie, BIPV2;

EXPORT Key_Foreclosure_Linkids := MODULE

// DEFINE THE INDEX
  EXPORT Key := INDEX(	   
     BIPV2.IDlayouts.l_key_ids_bare, //{UltID,OrgID,SELEID,ProxID,POWID,EmpID,DotID},    
     $.Layouts.i_LinkIDs,    
     Data_Services.Data_location.Prefix('foreclosure')+'thor_data400::key::foreclosure::'+doxie.Version_SuperKey+'::linkids');
	
  //DEFINE THE INDEX ACCESS
  EXPORT kFetch2(
    DATASET(BIPV2.IDlayouts.l_xlink_ids) inputs,
    STRING1 Level = BIPV2.IDconstants.Fetch_Level_DotID, // The lowest level you'd like to pay attention to.
    UNSIGNED2 ScoreThreshold = 0, // Applied at lowest level of ID
    joinLimit = 25000
    ) :=
  FUNCTION

    BIPV2.IDmacros.mac_IndexFetch(inputs, Key, out, Level, joinLimit);
    RETURN out;
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

	END;
	
END;
