IMPORT LiensV2;

export Layout_override_Liensv2_party := RECORD
  LiensV2.layout_liens_party;
	//DF-24061 VC
	unsigned4 global_sid;
  unsigned8 record_sid;
  string10  orig_rmsid;
  string20 flag_file_id;
END;