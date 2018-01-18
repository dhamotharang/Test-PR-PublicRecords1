import doxie, data_services;


r := Business_Risk.GID_Group_Stat;

export key_groupid_cnt := index(r,{group_id},{r},data_services.data_location.prefix() + 'thor_data400::key::groupid_cnt_'+doxie.Version_SuperKey);
