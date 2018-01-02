import doxie,data_services;
base := file_areacode_change;
export Key_AreaCode_Change := index(base,{old_NPA,old_NXX},{base},data_services.data_location.prefix() + 'thor_data400::key::areacode_change_' + doxie.Version_SuperKey);