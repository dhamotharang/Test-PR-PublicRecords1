// Query to calculate the number of supergroup business entities
// Excludes any group which does not have at least one BDID with a non-blank address

#workunit ('name', 'Count Business Group Entities');

bhb := Business_Header.File_Business_Header_Best(zip <> 0, prim_name <> '');

layout_bhb_slim := record
bhb.bdid;
bhb.prim_name;
bhb.zip;
end;

bhb_slim := table(bhb, layout_bhb_slim);

// Add group id
//bgkb := Business_Header.Key_BH_SuperGroup_BDID;
bhg := Business_Header.File_Super_Group;

output(count(dedup(bhg, group_id, all)), named('Number_Unique_GroupIDs'));

layout_group_addr := record
bhg.group_id;
bhb.bdid;
bhb.prim_name;
bhb.zip;
end;

layout_group_addr AppendGroupID(bhb_slim l, bhg r) := transform
self.group_id := r.group_id;
self := l;
end;

bhb_group := join(bhb_slim,
                  bhg,
			   left.bdid = right.bdid,
			   AppendGroupID(left, right),
			   hash);

// count group ids and get distribution			   
layout_group_stat := record
bhb_group.group_id;
cnt := count(group);
end;

bhb_group_stat := table(bhb_group, layout_group_stat, group_id);
output(count(bhb_group_stat), named('Number_Unique_GroupIDs_NonBlank_Addr'));

// Average number of BDIDs per group
output(ave(bhb_group_stat, cnt), named('Avg_Number_BDIDs'));

// count group ids with more than one BDID
output(count(bhb_group_stat(cnt > 1)), named('Number_GroupIDs_With_GT_One_BDID'));

// Average number of BDIDs per group with GT one BDID
output(ave(bhb_group_stat(cnt > 1), cnt), named('Avg_Number_BDIDs_GT_One'));
			   
layout_group_distribution := record
group_id_cnt := bhb_group_stat.cnt;
number_of_groups := count(group);
end;

bhb_distribution_stat := table(bhb_group_stat, layout_group_distribution, cnt, few);
output(sort(bhb_distribution_stat, -number_of_groups), all, named('GroupID_Dist_NonBlank_Addr'));
