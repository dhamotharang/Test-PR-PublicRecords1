import BIPV2;

EXPORT Layout_liens_party_SSN_BIPV2 := record
	Layout_liens_party_SSN and not [global_sid,record_sid,orig_rmsid];
	BIPV2.IDlayouts.l_xlink_ids;
	unsigned4 global_sid;
  unsigned8 record_sid;
  string10  orig_rmsid;
end;