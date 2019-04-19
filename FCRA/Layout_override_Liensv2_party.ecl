IMPORT LiensV2;

export Layout_override_Liensv2_party := RECORD
  LiensV2.layout_liens_party;
	//DF-24061
	string10  orig_rmsid;
	unsigned4 global_sid;
  unsigned8 record_sid;
  string20 flag_file_id;
END;