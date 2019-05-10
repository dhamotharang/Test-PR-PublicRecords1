import liensv2, Doxie, ut, BIPV2,Data_Services;

get_recs := LiensV2.file_liens_party_keybuild;

Layout_liens_party_linkids := record
  liensv2.layout_liens_party;
	BIPV2.IDlayouts.l_xlink_ids;
	unsigned4 global_sid;//DF-24061 VC
  unsigned8 record_sid;
	string10  orig_rmsid;

end;

Layout_liens_party_linkids tformat(get_recs L) := transform

self.ssn := if((unsigned6)L.ssn <> 0, if(L.ssn[1..5] = '00000', L.ssn[6..9], L.ssn), L.app_ssn);
self.tax_id := if(L.tax_id <> '', if(L.tax_id[1..5] = '00000', L.tax_id[6..9], L.tax_id), L.app_tax_id);
self := L;

end;

get_recs_ssn := project(get_recs, tformat(left));

dist_id := distribute(get_recs_ssn, hash(TMSID,RMSID));
sort_id := sort(dist_id, TMSID, RMSID,local);

export 	Key_liens_party_ID := index(sort_id,{tmsid,RMSID},{sort_id},
Data_Services.Data_location.Prefix('Liensv2')+'thor_data400::key::liensv2::party::TMSID.RMSID_' + doxie.Version_SuperKey);