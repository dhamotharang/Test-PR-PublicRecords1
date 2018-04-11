IMPORT LiensV2;

export Layout_Override_Liensv2_main := RECORD
  LiensV2.layout_liens_main_module.layout_liens_main and not [Filing_Type_ID	, Collection_Date, CaseLinkID, TMSID_old, RMSID_old, CaseLinkID_Prop_Flag];
  string20 flag_file_id;
END;