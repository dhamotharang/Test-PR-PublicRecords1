IMPORT doxie;

EXPORT Layouts := MODULE

  EXPORT interface_data_acess := doxie.IDataAccess;

  EXPORT layout_kfetch_seleid := RECORD
    UNSIGNED6 ultid;
    UNSIGNED6 orgid;
    UNSIGNED6 seleid;
  END;

  EXPORT layout_kfetch_locid := RECORD
    UNSIGNED6 locid;
  END;

END;