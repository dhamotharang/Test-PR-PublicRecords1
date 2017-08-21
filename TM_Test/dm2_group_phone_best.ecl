import Business_Header;

// For records with a BDID but no best phone, get best_phone from group
dm2_group_init := dm2_prep(bdid <> 0 and bus_best_phone = '');
dm2_other := dm2_prep(not(bdid <> 0 and bus_best_phone = ''));

// Get corresponding group records
bhsg := Business_Header.File_Super_Group;

layout_group_id := record
unsigned6 group_id;
end;

dm2_group_list := project(dm2_group_init,
                         transform(layout_group_id, self := left));
					
dm2_group_list_dedup := dedup(dm2_group_list, all);

dm2_group_gid_list := join(bhsg,
                           dm2_group_list_dedup,
					  left.group_id = right.group_id,
					  transform(Business_Header.Layout_BH_Super_Group, self := left),
					  hash);
					  
bh_all := Business_Header.File_Business_Header;

layout_bh_group := record
unsigned6 group_id;
Business_Header.Layout_Business_Header_Base;
end;

				  
bh_phone_init := join(bh_all,
                      dm2_group_gid_list,
			       left.bdid = right.bdid,
			       transform(layout_bh_group, self.group_id := right.group_id, self := left),
			       hash);
							


bh_phone := bh_phone_init(phone <> 0);
bh_d_gid := DISTRIBUTE(bh_phone, HASH(group_id));

layout_ph_sort := RECORD
	bh_d_gid.group_id;
	bh_d_gid.phone;
	bh_d_gid.phone_score;
	bh_d_gid.source;
	bh_d_gid.dt_last_seen;
	INTEGER1 has_area_code;
END;

layout_ph_sort CheckAreaCode(bh_d_gid l) := TRANSFORM
	SELF.has_area_code := IF(l.phone > 9999999, 1, 0);
	SELF := l;
END;

bh_slim := PROJECT(bh_d_gid, CheckAreaCode(LEFT));

STRING10 sf(INTEGER ph) := INTFORMAT(ph, 10, 1);
INTEGER ph_score(INTEGER ph) := 2 * (
						IF(sf(ph)[9..10] = '00', 500, 0) +
						IF(sf(ph)[8..10] = '000', 500, 0) +
						IF(sf(ph)[1..3] IN ['800','811','822','833','844','855','866','877','888'], 250, 0));

// Add a phone score to non-gong records.  If there are gong records,
// they will be preferred since they also include a sequence number
// in their score.
bh_needscore := bh_slim(source not in ['GB','GG']);

layout_ph_sort AddPhoneScore(bh_needscore l) := TRANSFORM
	SELF.phone_score := ph_score(l.phone);
	SELF := l;
END;

bh_scored := PROJECT(bh_needscore, AddPhoneScore(LEFT))
				+ bh_slim(~(source not in ['GB','GG']));

// Redistribute the concatenated set, just in case...
bh_d_scored := DISTRIBUTE(bh_scored, HASH(group_id));

bh_g_gid := GROUP(SORT(bh_d_scored,group_id, LOCAL), group_id);

// Always prefer phones with areacodes, even if not the most recent.
bh_d_phscore_date := DEDUP(
				SORT(bh_g_gid, -has_area_code, -dt_last_seen, -phone_score, -phone),
				group_id);

layout_bh_bestphone := RECORD
	bh_d_phscore_date.group_id;
	bh_d_phscore_date.phone;
END;

bh_bp := TABLE(GROUP(bh_d_phscore_date), layout_bh_bestphone);

// Append phone numbers to original file
Layout_dm2_Base AppendPhones(Layout_dm2_Base l, layout_bh_bestphone r) := transform
self.bus_best_phone := if(r.phone <> 0, intformat(r.phone, 10, 1), '');
self := l;
end;

dm2_phone_append := join(dm2_group_init,
                        bh_bp,
				    left.group_id = right.group_id,
				    AppendPhones(left, right),
				    left outer,
				    hash);



export dm2_group_phone_best := dm2_phone_append + dm2_other : persist('TMTEST::dm2_group_phone_best');
