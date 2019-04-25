// basefile: thor_data400::base::liens::main::Hogan

eyeball := 25;
eyeball_2 := 25;
orig_data_size := 100000;

full_lv2_key := pull(LiensV2.key_liens_main_ID_FCRA);
// output(choosen(full_lv2_key, eyeball), named('tmsid_rmsid_main_key'));
// output(count(full_lv2_key), named('tmsid_rmsid_main_key_count'));

lv2_did_key := pull(LiensV2.key_liens_DID_FCRA);
// output(choosen(lv2_did_key, eyeball), named('lv2_did_key'));
// output(count(lv2_did_key), named('lv2_did_key'));




ds := LiensV2.key_liens_DID_FCRA(did = 1436817190);

s1_daily := set(ds, (string)tmsid);

slim_ds := LiensV2.key_liens_main_ID_FCRA(tmsid in s1_daily);

output(choosen(slim_ds, all));


// full_lv2 := join(full_lv2_key, did_lay, left.tmsid = right.tmsid and left.rmsid = right.rmsid, append_all(left, right) ) : persist('~nkoubsky::persist::lv2_full');
// output(choosen(full_lv2, eyeball), named('tmsid_full_party_key'));
// output(count(full_lv2), named('tmsid_rmsid_full_key_count'));
