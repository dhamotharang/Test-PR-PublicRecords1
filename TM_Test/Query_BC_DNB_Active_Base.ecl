// Determine active contacts
bc := Business_Header.File_Business_Contacts_Base(from_hdr = 'N');

earliest_date := 20030701;

layout_bdid_date := record
unsigned6 bdid;
unsigned6 group_id;
string2 source;
unsigned4 dt_last_seen;
string2 state;
string1 phone_active;
string1 active_dnb;
end;

bh_active_base := dataset('~thor_data400::TMTEST::bh_active_base_dnb', layout_bdid_date, flat)();

layout_bdid_list := record
bh_active_base.bdid;
bh_active_base.group_id;
bh_active_base.state;
end;

bdid_list := table(bh_active_base, layout_bdid_list);
bdid_list_dedup := dedup(bdid_list, bdid, group_id, all);

layout_bc_seq := record
unsigned6 seq := 0;
unsigned6 group_id;
string2 business_state;
Business_Header.Layout_Business_Contact_Full;
end;

bc_filtered := bc(bdid <> 0, dt_last_seen >= earliest_date, /* source <> 'D', */ company_state <> '');

bc_init := join(bc_filtered,
                bdid_list_dedup,
			 left.bdid = right.bdid,
			 transform(layout_bc_seq,
			           self.group_id := right.group_id,
					 self.business_state := right.state;
			           self := left),
			 hash);

layout_bc_seq SequenceBC(bc_init l, unsigned6 cnt) := transform
self.seq := cnt;
self := l;
end;

bc_seq := project(sort(bc_init, bdid), SequenceBC(left, counter));
                  
layout_bc_slim := record
bc_seq.seq;
bc_seq.bdid;
bc_seq.group_id;
bc_seq.did;
bc_seq.dt_last_seen;
bc_seq.source;
string2 state := bc_seq.business_state;
string20 fname := bc_seq.fname;
string20 mname := bc_seq.mname;
string20 lname := bc_seq.lname;
string5  name_suffix := bc_seq.name_suffix;
bc_seq.company_title;
string1 active_dnb := 'N';
end;

bc_slim := table(bc_seq, layout_bc_slim);

bc_slim_did := bc_slim(did <> 0);
bc_slim_no_did := bc_slim(did = 0);

bc_slim_did_dist := distribute(bc_slim_did, hash(bdid));
bc_slim_did_sort := sort(bc_slim_did_dist, bdid, did, -dt_last_seen, ut.TitleRank(company_title), local);
bc_slim_did_dedup := dedup(bc_slim_did_sort, bdid, did, local);

// combine deduped by did with no did
bc_slim_combined := bc_slim_no_did + bc_slim_did_dedup;
bc_slim_combined_dist := distribute(bc_slim_combined, hash(bdid));


// match names within BDID
Layout_PairMatch := record
  unsigned6 new_rid;
  unsigned6 old_rid;
  unsigned1  pflag;
end;

Layout_PairMatch MatchNames(layout_bc_slim l, layout_bc_slim r, unsigned1 match) := transform
self.old_rid := l.seq;
self.new_rid := r.seq;
self.pflag := match;
end;

bc_matches := join(bc_slim_combined_dist,
                      bc_slim_combined_dist,
				  left.bdid = right.bdid and
				  left.seq < right.seq and
				    ut.NameMatch(left.fname, left.mname, left.lname,
				                 right.fname, right.mname, right.lname) < 3,
				  MatchNames(left, right, 1),
				  local);

bc_matches_dedup := dedup(bc_matches, new_rid, old_rid, all);

// Transitive closure of match pairs
ut.MAC_Reduce_Pairs(bc_matches_dedup, new_rid, old_rid, pflag, Layout_PairMatch, bc_matches_reduced)

// Patch new BDIDs
ut.MAC_Patch_Id(bc_slim_combined, seq, bc_matches_reduced, old_rid, new_rid, bc_slim_patched)


bc_slim_patched_dist := distribute(bc_slim_patched, hash(seq));
bc_slim_patched_sort := sort(bc_slim_patched_dist, seq, if(did <> 0, 0, 1), -dt_last_seen, ut.TitleRank(company_title), local);
bc_slim_patched_dedup := dedup(bc_slim_patched_sort, seq, local);

bc_active_base := sort(bc_slim_patched_dedup, seq) : persist('TMTEST::bc_active_base');

output(count(bc_active_base), named('Total_Active_Contact_Base'));
output(choosen(bc_active_base, 1000),all);


