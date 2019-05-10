import BIPV2;

EXPORT Layout_liens_party_SSN_BIPV2 := record
	Layout_liens_party_SSN and not [global_sid,record_sid,orig_rmsid];
	BIPV2.IDlayouts.l_xlink_ids;
	string50  TMSID_old;
  string50  RMSID_old;
	unsigned4 global_sid;//DF-24061 VC
  unsigned8 record_sid;	
	string10  orig_rmsid;

end;