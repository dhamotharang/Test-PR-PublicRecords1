import mdr;
bh := Business_Header.File_Business_Header_Base;

earliest_date := 20050101;

layout_bdid_date := record
bh.bdid;
unsigned6 group_id := 0;
bh.dt_last_seen;
end;

bh_dates := table(bh((not MDR.sourceTools.SourceIsDunn_Bradstreet(source)), dt_last_seen >= earliest_date, zip <> 0, prim_name <> '',
                    prim_name[1..7] <> 'PO BOX', prim_name[1..3] not in ['RR ', 'HC ']), layout_bdid_date);

bh_dates_dist := distribute(bh_dates, hash(bdid));
bh_dates_sort := sort(bh_dates_dist, bdid, -dt_last_seen, local);
bh_dates_dedup := dedup(bh_dates_sort, bdid, local);

count(bh_dates_dedup);

// Append group ids
bhg := Business_Header.File_Super_Group;

bh_dates_gid := join(bh_dates_dedup,
                     bhg,
				 left.bdid = right.bdid,
				 transform(layout_bdid_date, self.group_id := right.group_id, self := left),
				 hash);
				 
bh_dates_gid_dist := distribute(bh_dates_gid, hash(group_id));
bh_dates_gid_sort := sort(bh_dates_gid_dist, group_id, -dt_last_seen, local);
bh_dates_gid_dedup := dedup(bh_dates_gid_sort, group_id, local);

count(bh_dates_gid_dedup);

