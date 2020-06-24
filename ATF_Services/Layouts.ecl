IMPORT iesp, atf, FFD;

export Layouts := MODULE;
  export firearms_out :=record
     // for ATF "persistent_record_id" is stored in "atf_id"
     atf.layout_firearms_explosives_out and not [lf, persistent_record_id];
     unsigned8 ATF_id;
  end;
  
  export search_did := record
    unsigned6 did;
    boolean isDeepDive := false;
  end;
  
  export search_bdid := record
    unsigned6 bdid;
    boolean isDeepDive := false;
  end;
  
  export atfNumberPlus := record
    string15 license_number;
    unsigned6 did;
    unsigned6 bdid;
    unsigned8 atf_id;
    boolean isDeepDive := false;
  end;
  
  export rawrec := record
    firearms_out;
    boolean isDeepDive := false;
    string8 lic_Exp_Date := '';
    unsigned2 penalt := 0;
    dataset(FFD.Layouts.StatementIdRec) StatementIds := dataset([],FFD.Layouts.StatementIdRec);
    boolean isDisputed := false;
  end;
  
  export rawrecCrimInd := record
    rawrec;
    boolean hasCriminalConviction := false;
    boolean isSexualOffender := false;
  end;

  export t_atfRecordWithPenalty := record
     iesp.firearm.t_FirearmRecord;
     unsigned8 atf_id := 0;
  end;
END;
