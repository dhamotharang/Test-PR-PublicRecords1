EXPORT Ext_Layouts := MODULE
  IMPORT SALT25;// Create a unique identifier for each child file
// Compute the External File Record counts - gathered from all the child files
EXPORT EFR_Child := RECORD
  UNSIGNED2 Child_Id;
  UNSIGNED4 Cnt;
END;
EXPORT EFRR_Layout := RECORD // Just used for external files to return results
    SALT25.UIDType LNPID;
  EFR_Child;
  END;
EXPORT EFR_Layout := RECORD
    SALT25.UIDType LNPID;
  DATASET(EFR_Child) Hits;
END;
END;
