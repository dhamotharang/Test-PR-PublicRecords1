EXPORT Ext_Layouts := MODULE
  IMPORT SALT29;// Create a unique identifier for each child file
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
  SALT29.UIDType proxid;
  SALT29.UIDType seleid;
  SALT29.UIDType orgid;
  SALT29.UIDType ultid;
  EFR_Child;
  END;
EXPORT EFR_Layout := RECORD,MAXLENGTH(32000)
  SALT29.UIDType proxid;
  SALT29.UIDType seleid;
  SALT29.UIDType orgid;
  SALT29.UIDType ultid;
  DATASET(EFR_Child) Hits;
END;
END;
