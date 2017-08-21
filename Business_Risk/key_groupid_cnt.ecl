import doxie, Prte2_Business_Header;

//r := dataset('~thor_data400::TMTEMP::gid_group_stat', {unsigned6 group_id, unsigned4 group_cnt}, flat);

#IF (PRTE2_Business_Header.constants.PRTE_BUILD) #WARNING(PRTE2_Business_Header.constants.PRTE_BUILD_WARN_MSG);
r := Prte2_Business_Header.GID_Group_Stat;
#ELSE
r := Business_Risk.GID_Group_Stat;
#END;

export key_groupid_cnt := index(r,{group_id},{r},'~thor_data400::key::groupid_cnt_'+doxie.Version_SuperKey);
