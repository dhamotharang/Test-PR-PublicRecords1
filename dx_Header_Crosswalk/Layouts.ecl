EXPORT Layouts := MODULE

  // EntityID types
  SHARED type_lexid := UNSIGNED6;
  SHARED type_seleid := UNSIGNED6;
  SHARED type_lnpid := UNSIGNED6;

  EXPORT lnpid_2_lexid := RECORD
    type_lnpid lnpid;
    type_lexid lexid;
  END;
  
  EXPORT lexid_2_lnpid := RECORD
    type_lexid lexid;
    type_lnpid lnpid;
  END;

  EXPORT lexid_2_seleid := RECORD
    type_lexid lexid;
    type_seleid seleid;
  END;

  EXPORT seleid_2_lexid := RECORD
    type_seleid seleid;
    type_lexid lexid;
  END;

  EXPORT seleid_2_lnpid := RECORD
    type_seleid seleid;
    type_lnpid lnpid;
  END;

  EXPORT lnpid_2_seleid := RECORD
    type_lnpid lnpid;
    type_seleid seleid;
  END;
END;