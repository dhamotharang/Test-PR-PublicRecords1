import mdr;

bh := Business_Header.File_Business_Header_Base;

layout_bdid_slim := record
bh.bdid;
unsigned6 group_id := 0;
end;

// All businessess
bh_slim_all := table(bh((not MDR.sourceTools.SourceIsDunn_Bradstreet(source)), zip <> 0, prim_name <> '',
                    prim_name[1..7] <> 'PO BOX', prim_name[1..3] not in ['RR ', 'HC ']), layout_bdid_slim);

bh_slim_all_dedup := dedup(bh_slim_all, bdid, all);

// Businesses with a D&B record
bh_slim_DNB := table(bh(MDR.sourceTools.SourceIsDunn_Bradstreet(source), fein = 0, zip <> 0, prim_name <> '',
                    prim_name[1..7] <> 'PO BOX', prim_name[1..3] not in ['RR ', 'HC ']), layout_bdid_slim);
				
bh_slim_DNB_dedup := dedup(bh_slim_DNB, bdid, all);

bh_DNB_only := join(bh_slim_all_dedup,
                    bh_slim_DNB_dedup,
				left.bdid = right.bdid,
				transform(layout_bdid_slim, self := right),
				right only,
				hash);
				
count(bh_DNB_only);
				

// Append group ids
bhg := Business_Header.File_Super_Group;

bh_slim_all_gid := join(bh_slim_all_dedup,
                     bhg,
				 left.bdid = right.bdid,
				 transform(layout_bdid_slim, self.group_id := right.group_id, self := left),
				 hash);
				 
bh_slim_all_gid_dedup := dedup(bh_slim_all_gid, group_id, all);

bh_slim_DNB_gid := join(bh_slim_DNB_dedup,
                     bhg,
				 left.bdid = right.bdid,
				 transform(layout_bdid_slim, self.group_id := right.group_id, self := left),
				 hash);
				 
bh_slim_DNB_gid_dedup := dedup(bh_slim_DNB_gid, group_id, all);

bh_DNB_gid_only := join(bh_slim_all_gid_dedup,
                    bh_slim_DNB_gid_dedup,
				left.group_id = right.group_id,
				transform(layout_bdid_slim, self := right),
				right only,
				hash);
				
count(bh_DNB_gid_only);
