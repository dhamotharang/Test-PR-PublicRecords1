bh := Business_Header.File_Business_Header_Base;

layout_bdid_slim := record
bh.bdid;
unsigned6 group_id := 0;
end;

bh_slim := table(bh(zip <> 0, prim_name <> '',
                    prim_name[1..7] <> 'PO BOX', prim_name[1..3] not in ['RR ', 'HC ']), layout_bdid_slim);

bh_slim_dedup := dedup(bh_slim, bdid, all);

count(bh_slim_dedup);

// Append group ids
bhg := Business_Header.File_Super_Group;

bh_slim_gid := join(bh_slim_dedup,
                     bhg,
				 left.bdid = right.bdid,
				 transform(layout_bdid_slim, self.group_id := right.group_id, self := left),
				 hash);
				 
bh_slim_gid_dedup := dedup(bh_slim_gid, group_id, all);

count(bh_slim_gid_dedup);

