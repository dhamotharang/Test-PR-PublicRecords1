import doxie, data_services;

export Key_BH_SuperGroup_GroupID := index(Business_Header.File_Super_Group,{group_id},{bdid},data_services.data_location.prefix() + 'thor_Data400::key::bh_supergroup_groupid_' + doxie.Version_SuperKey);
