import Business_Header;

f := Prte2_Business_Header.BH_Super_Group();

layout_stat := record
f.group_id;
unsigned4 group_cnt := count(group);
end;

group_stat := table(f, layout_stat, group_id);

export GID_Group_Stat := group_stat : persist('~prte::persist::business_risk::gid_group_stat');