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
end;