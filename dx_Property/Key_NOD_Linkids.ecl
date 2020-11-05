import BIPV2, Data_Services, doxie,ut, versioncontrol;

EXPORT Key_NOD_Linkids := MODULE
 
// DEFINE THE INDEX
  EXPORT Key := INDEX(	   
     BIPV2.IDlayouts.l_key_ids_bare, //{UltID,OrgID,SELEID,ProxID,POWID,EmpID,DotID},    
     $.Layouts.i_LinkIDs,    
     Data_Services.Data_location.Prefix('foreclosure')+'thor_data400::key::nod::'+doxie.Version_SuperKey+'::linkids');
	
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
	
END;