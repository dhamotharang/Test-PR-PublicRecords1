import doxie;

//r := dataset('~thor_data400::TMTEMP::gid_group_stat', {unsigned6 group_id, unsigned4 group_cnt}, flat);

r := Business_Risk.GID_Group_Stat;

export key_groupid_cnt := index(r,{group_id},{r},'~thor_data400::key::groupid_cnt_'+doxie.Version_SuperKey);
