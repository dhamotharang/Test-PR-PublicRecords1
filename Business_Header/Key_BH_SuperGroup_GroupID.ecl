import doxie;

export Key_BH_SuperGroup_GroupID := index(Business_Header.File_Super_Group,{group_id},{bdid},'~thor_Data400::key::bh_supergroup_groupid_' + doxie.Version_SuperKey);
