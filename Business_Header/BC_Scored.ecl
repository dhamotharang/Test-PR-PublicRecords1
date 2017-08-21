IMPORT ut, NID;
EXPORT BC_Scored(

	 dataset(Layout_Business_Contacts_Temp)	pBC_Extra									= BC_Extra()
	,dataset(Layout_BH_Super_Group				)	pSuper_Group							= Files		().Base.Super_Group.built
	,string																	pPersistname							= persistnames().BCScored
	,boolean																pShouldRecalculatePersist	= true													

) := 
function

bce := filters.bcextra(pBC_Extra);
bce_dist := distribute(bce(bdid != 0), hash(bdid));

// Propagate DIDs within a non-zero BDID, with the assumption that
// a name will be unique within a BDID.
Emps_Sort := SORT(bce_dist, bdid, lname, mname[1], NID.PreferredFirstVersionedStr(fname, NID.version), name_suffix, LOCAL);
Emps_Grpd := GROUP(Emps_Sort, bdid, lname, mname[1], NID.PreferredFirstVersionedStr(fname, NID.version), name_suffix, LOCAL);
Emps_Grpd_Sort := SORT(Emps_Grpd, -did);

Layout_Business_Contacts_Temp PropagateDID(Emps_Grpd_Sort l, Emps_Grpd_Sort r) := TRANSFORM
	SELF.did := IF(l.did != 0 AND r.did = 0, l.did, r.did);
	SELF := r;
END;

Emps_Prop := GROUP(ITERATE(Emps_Grpd_Sort, PropagateDID(LEFT, RIGHT)));

// Propagate DIDs within a Group ID, with the assumption that
// a name will be unique within a close business group. 
// Limit to groups with less than 1000 total contact records, and 250 from business contacts or Equifax

Layout_Group_Contact := record
unsigned6 group_id := 0;
Layout_Business_Contacts_Temp;
end;

bhsg := pSuper_Group;
bhsg_dist := distribute(bhsg, hash(bdid));

// Append the Group ID
Layout_Group_Contact AppendGroupID(Layout_Business_Contacts_Temp l, bhsg r) := transform
self.group_id := r.group_id;
self := l;
end;

Emps_Prop_GID := join(Emps_Prop,
                      bhsg_dist,
					  left.bdid = right.bdid,
					  AppendGroupID(left, right),
					  left outer,
					  local);
					  
layout_group_stat := record
Emps_Prop_GID.group_id;
unsigned3 buscnt := count(group, Emps_Prop_GID.from_hdr='N');
unsigned3 eqcnt := count(group, Emps_Prop_GID.from_hdr='E');
unsigned3 hdrcnt := count(group, Emps_Prop_GID.from_hdr='Y');
unsigned3 totcnt := count(group);
end;

Emps_Prop_GID_Stat := table(Emps_Prop_GID, layout_group_stat, group_id);

// Join stat to select groups for propagation
Emps_Prop_GID_Dist := distribute(Emps_Prop_GID, hash(group_id));
Emps_Prop_GID_Stat_Dist := distribute(Emps_Prop_GID_Stat((buscnt+eqcnt) <= 250, totcnt <= 1000), hash(group_id));

Layout_Group_Contact SelectContactGroups(Layout_Group_Contact l, layout_group_stat r) := transform
self.group_id := r.group_id;  // zero group_id if there is no match
self := l;
end;

Emp_Prop_GID_Reduced := join(Emps_Prop_GID_Dist,
                             Emps_Prop_GID_Stat_Dist,
							 left.group_id = right.group_id,
							 SelectContactGroups(left, right),
							 left outer,
							 local);

Emps_GID_Sort := SORT(Emp_Prop_GID_Reduced(group_id <> 0), group_id, lname, mname[1], NID.PreferredFirstVersionedStr(fname, NID.version), name_suffix, LOCAL);
Emps_GID_Grpd := GROUP(Emps_GID_Sort, group_id, lname, mname[1], NID.PreferredFirstVersionedStr(fname, NID.version), name_suffix, LOCAL);
Emps_GID_Grpd_Sort := SORT(Emps_GID_Grpd, -did);

Layout_Group_Contact PropagateDID_GID(Emps_GID_Grpd_Sort l, Emps_GID_Grpd_Sort r) := TRANSFORM
	SELF.did := IF(l.did != 0 AND r.did = 0, l.did, r.did);
	SELF := r;
END;

Emps_GID_Prop := GROUP(ITERATE(Emps_GID_Grpd_Sort, PropagateDID_GID(LEFT, RIGHT)));

// Accumulate the scores of contacts seen multiple times for a bdid.
// Do this in a more sophisticated way than the DID propagation so
// that similar names get the same score.
emps_d_seq := DISTRIBUTE(Emps_GID_Prop + Emp_Prop_GID_Reduced(group_id = 0), HASH(bdid));

layout_emp_pair := RECORD
	UNSIGNED6 lseq; // new
	UNSIGNED6 rseq; // old
	UNSIGNED1 rscore := 0;
	UNSIGNED1 flag := 0;
END;

layout_emp_pair Match(emps_d_seq l, emps_d_seq r) := TRANSFORM
	SELF.lseq := l.uid;
	SELF.rseq := r.uid;
	SELF.rscore := r.contact_score;
END;

j := JOIN(emps_d_seq, emps_d_seq,
	LEFT.bdid = RIGHT.bdid AND
	LEFT.uid < RIGHT.uid AND
	(
		(LEFT.did = RIGHT.did AND LEFT.did != 0) OR
		(LEFT.lname = RIGHT.lname AND
		 NID.PreferredFirstVersionedStr(LEFT.fname, NID.version) = NID.PreferredFirstVersionedStr(RIGHT.fname, NID.version) AND
		 LEFT.mname = RIGHT.mname AND
		 ut.NNEQ(LEFT.name_suffix, RIGHT.name_suffix)
		) OR
		(
			ut.NNEQ(LEFT.name_suffix, RIGHT.name_suffix) AND
			ut.NameMatch(	LEFT.fname, LEFT.mname, LEFT.lname,
							RIGHT.fname, RIGHT.mname, RIGHT.lname) < 2
		)
	), 
	Match(LEFT, RIGHT), ATMOST(
													LEFT.bdid = RIGHT.bdid 
												, 10000), LOCAL);

ut.MAC_Reduce_Pairs(j, lseq, rseq, flag, layout_emp_pair, j_red)
j_red_dist_r := DISTRIBUTE(j_red, HASH(rseq));

// We also want the original records that others were reduced to.
layout_emp_pair TakeOriginal(j_red l) := TRANSFORM
	SELF.lseq := l.lseq;
	SELF.rseq := l.lseq;
END;

j_red_l := PROJECT(
	DEDUP(SORT(DISTRIBUTE(j_red, HASH(lseq)), lseq, LOCAL), lseq, LOCAL),
	TakeOriginal(LEFT));

// Put back the scores that got chopped in pair reduction
emps_d_uid := DISTRIBUTE(emps_d_seq, HASH(uid));
need_score := j_red_dist_r + j_red_l;

layout_emp_pair PutBackScore1(need_score l, emps_d_uid r) := TRANSFORM
	SELF.rscore := r.contact_score;
	SELF := l;
END;

j_red_score := JOIN(
	need_score,
	emps_d_uid,
	LEFT.rseq = RIGHT.uid,
	PutBackScore1(LEFT, RIGHT), LOCAL);

j_red_dist_l := DISTRIBUTE(j_red_score, HASH(lseq));

layout_total := RECORD
	j_red_dist_l.lseq;
	UNSIGNED1 score := IF(SUM(GROUP, j_red_dist_l.rscore) > 100, 100, SUM(GROUP, j_red_dist_l.rscore));
END;

s_group_sum := TABLE(j_red_dist_l, layout_total, lseq, LOCAL);

layout_emp_pair AddTotal(j_red_dist_l l, s_group_sum r) := TRANSFORM
	SELF.rscore := r.score;
	SELF := l;
END;

updated_scores := JOIN(j_red_dist_l, s_group_sum,
	LEFT.lseq = RIGHT.lseq,
	AddTotal(LEFT, RIGHT), LOCAL);

// Join the scores back on the old right id's.
Layout_Business_Contacts_Temp PutBackScore(emps_d_seq l, updated_scores r) := TRANSFORM
	SELF.contact_score := IF(r.rseq != 0, r.rscore, l.contact_score);
	SELF := l;
END;

Emps_Scored := JOIN(
	DISTRIBUTE(emps_d_seq, HASH(uid)),
	DISTRIBUTE(updated_scores, HASH(rseq)),
	LEFT.uid = RIGHT.rseq,
	PutBackScore(LEFT, RIGHT), LEFT OUTER, LOCAL);

Emps_All := Emps_Scored + bce(bdid = 0) : PERSIST(pPersistname);

returndataset := if(pShouldRecalculatePersist = true, Emps_All
																										, persists().BCScored
									);
return returndataset;

end;