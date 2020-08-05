import Business_Header;

f := dataset('~thor_data400::TEMP::BH_Super_Group', Business_Header.Layout_BH_Super_Group, flat);

layout_stat := record
f.group_id;
unsigned4 group_cnt := count(group);
end;

group_stat := table(f, layout_stat, group_id);

export GID_Group_Stat := group_stat : persist('TMTEMP::gid_group_stat');
