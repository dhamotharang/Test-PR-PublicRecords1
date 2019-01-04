Import Data_Services, liensv2, Doxie, ut, BIPV2;

get_recs := LiensV2.file_liens_party_keybuild_fcra;

Layout_liens_party_linkids := record
  liensv2.layout_liens_party;
	BIPV2.IDlayouts.l_xlink_ids;
end;

Layout_liens_party_linkids tformat(get_recs L) := transform

self.ssn		:=	IF((UNSIGNED6)L.ssn <> 0, IF(L.ssn[1..5] = '00000', L.ssn[6..9], L.ssn), '');
self.tax_id :=	IF((UNSIGNED6)L.tax_id <> 0, IF(L.tax_id[1..5] = '00000', L.tax_id[6..9], L.tax_id), '');
self := L;

end;

get_recs_ssn := project(get_recs, tformat(left));

dist_id := distribute(get_recs_ssn, hash(TMSID,RMSID));
sort_id := sort(dist_id, TMSID, RMSID,local);

//DF-22188 - Deprecate speicified in thor_data400::key::liensv2::fcra::party::tmsid.rmsid_qa
ut.MAC_CLEAR_FIELDS(sort_id, sort_id_cleared, LiensV2.Constants.fields_to_clear_party_id_fcra);

export 	key_liens_party_id_FCRA := index(sort_id_cleared,{tmsid,RMSID},{sort_id_cleared},
Data_Services.Data_location.Prefix('Liensv2')+'thor_data400::key::liensv2::fcra::party::TMSID.RMSID_' + doxie.Version_SuperKey);