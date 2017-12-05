EXPORT Ext_Layouts := MODULE
  IMPORT SALT38;// Create a unique identifier for each child file
EXPORT ID_Corps := 1;
EXPORT ID_UCC := 2;
EXPORT ID_Vehicle := 3;
EXPORT ID_PropertyV2 := 4;
EXPORT ID_BizContacts := 5;
 
// Compute the External File Record counts - gathered from all the child files
EXPORT EFR_Child := RECORD
  UNSIGNED2 Child_Id;
  UNSIGNED4 Cnt;
  UNSIGNED2 Permits := 0;
END;
EXPORT EFRR_Layout := RECORD // Just used for external files to return results
  SALT38.UIDType proxid;
  SALT38.UIDType seleid;
  SALT38.UIDType orgid;
  SALT38.UIDType ultid;
  //UNSIGNED4 ChildId_BMap;
  EFR_Child;
END;
EXPORT EFR_Layout := RECORD,MAXLENGTH(32000)
  SALT38.UIDType proxid;
  SALT38.UIDType seleid;
  SALT38.UIDType orgid;
  SALT38.UIDType ultid;
  //UNSIGNED4 ChildId_BMap;
  DATASET(EFR_Child) Hits;
END;
END;
