EXPORT Ext_Layouts := MODULE
  IMPORT SALT44;// Create a unique identifier for each child file
EXPORT ID_Ext_Data := 1;
 
// Compute the External File Record counts - gathered from all the child files
EXPORT EFR_Child := RECORD
  UNSIGNED2 Child_Id;
  UNSIGNED4 Cnt;
END;
EXPORT EFRR_Layout := RECORD // Just used for external files to return results
  SALT44.UIDType proxid;
  SALT44.UIDType seleid;
  SALT44.UIDType orgid;
  SALT44.UIDType ultid;
 
  UNSIGNED4 ChildId_BMap;
  EFR_Child;
END;
EXPORT EFR_Layout := RECORD,MAXLENGTH(32000)
  SALT44.UIDType proxid;
  SALT44.UIDType seleid;
  SALT44.UIDType orgid;
  SALT44.UIDType ultid;
 
  UNSIGNED4 ChildId_BMap;
  DATASET(EFR_Child) Hits;
END;
END;
