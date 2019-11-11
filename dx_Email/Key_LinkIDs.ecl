IMPORT $, Data_Services, Doxie, BIPV2;
	   
EXPORT Key_LinkIds := MODULE

  // DEFINE THE INDEX
  export Key := INDEX(	   
     BIPV2.IDlayouts.l_key_ids_bare, //{UltID,OrgID,SELEID,ProxID,POWID,EmpID,DotID},    
     $.Layouts.i_LinkIDs,    
     Data_Services.Data_location.Prefix('Email_Data')+'thor_200::key::email_dataV2::'+doxie.Version_SuperKey+'::LinkIDs');  
  
	// DEFINE THE INDEX ACCESS
  export kFetch(
    dataset(BIPV2.IDlayouts.l_xlink_ids) inputs, 
    string1 Level = BIPV2.IDconstants.Fetch_Level_DotID,  //The lowest level you'd like to pay attention to.  If U, then all the records for the UltID will be returned.
                                                //Values:  D is for Dot.  E is for Emp.  W is for POW.  P is for Prox.  O is for Org.  U is for Ult.
                                                //Should be enumerated or something?  at least need constants defined somewhere if you keep string1
    unsigned2 ScoreThreshold = 0                //Applied at lowest level of ID
    ) :=
  FUNCTION

    BIPV2.IDmacros.mac_IndexFetch(inputs, Key, out, Level);
    return out;                                          

  END;

END;