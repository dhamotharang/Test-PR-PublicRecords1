IMPORT $, BIPV2, doxie;
 
EXPORT Key_LinkIds := MODULE

  //DEFINE THE INDEX
	//Used this index method to carry the maxlength.
  dsLINKIDS := DATASET([], $.Layouts.LINKIDS);

  EXPORT Key := INDEX(dsLINKIDS,
                      $.Layouts.LINKIDS_KEYED, //{UltID,OrgID,SELEID,ProxID,POWID,EmpID,DotID},    
                      $.Layouts.LINKIDS_PAYLOAD,    
                      $.Names.i_LINKIDS_SF
                      );  
  
	//DEFINE THE INDEX ACCESS
  EXPORT kFetch(
    DATASET(BIPV2.IDlayouts.l_xlink_ids) inputs, 
		doxie.IDataAccess mod_access = MODULE (doxie.IDataAccess) END,
    STRING1 Level = BIPV2.IDconstants.Fetch_Level_DotID,  //The lowest level you'd like to pay attention to.  If U, then all the records for the UltID will be returned.
                                                //Values:  D is for Dot.  E is for Emp.  W is for POW.  P is for Prox.  O is for Org.  U is for Ult.
                                                //Should be enumerated or something?  at least need constants defined somewhere if you keep string1
    UNSIGNED2 ScoreThreshold = 0                //Applied at lowest level of ID
    ) :=
  FUNCTION

     BIPV2.IDmacros.mac_IndexFetch(inputs, Key, fetched, Level);
		 $.mac_check_access(fetched, out, mod_access);
		
    RETURN out;                                          

  END;

END;