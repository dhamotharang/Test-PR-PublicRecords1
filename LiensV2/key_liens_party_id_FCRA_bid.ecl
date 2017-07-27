import liensv2, Doxie, ut;

get_recs :=project(LiensV2.file_liens_party_keybuild_bid,transform(liensv2.layout_liens_party_ssn,self.bdid:=(string12)left.bid,self:=left));

liensv2.layout_liens_party tformat(liensv2.layout_liens_party_ssn L) := transform

self.ssn := if((unsigned6)L.ssn <> 0, if(L.ssn[1..5] = '00000', L.ssn[6..9], L.ssn), L.app_ssn);
self.tax_id := if((unsigned6)L.tax_id <> 0, if(L.tax_id[1..5] = '00000', L.tax_id[6..9], L.tax_id), L.app_tax_id);
self := L;

end;

get_recs_ssn := project(get_recs, tformat(left));

dist_id := distribute(get_recs_ssn, hash(TMSID,RMSID));
sort_id := sort(dist_id, TMSID, RMSID,local);

export 	key_liens_party_id_FCRA_bid := index(sort_id,{tmsid,RMSID},{sort_id},
'~thor_data400::key::liensv2::fcra::party::bid::TMSID.RMSID_' + doxie.Version_SuperKey);