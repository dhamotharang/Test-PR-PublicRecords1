import bipv2;
export layout_prolic_out_with_AID := record
	Prof_License.Layout_prolic_in_with_AID;
	string18	county_name;
	string12	did;
	string3		score;
	string9		best_ssn;
	string12	bdid;
	unsigned8	source_rec_id  :=  0;
	BIPV2.IDlayouts.l_xlink_ids;
	unsigned8	LNPID	  := 0;
  INTEGER2  xadl2_weight := 0;
  UNSIGNED2 xadl2_score := 0;   // salt score
  INTEGER1  xadl2_distance := 0;
  UNSIGNED4 xadl2_keys_used := 0;
  STRING    xadl2_keys_desc := '';
  STRING60  xadl2_matches := '';
  STRING    xadl2_matches_desc := '';
	//DF-24056 CCPA new fields
	unsigned4 global_sid := 0;
	unsigned8 record_sid := 0;

end;