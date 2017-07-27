import doxie;

export Key_BH_SuperGroup_BDID := index(Business_Header.File_Super_Group,{bdid},{group_id},'~thor_Data400::key::bh_supergroup_bdid_' + doxie.Version_SuperKey);
