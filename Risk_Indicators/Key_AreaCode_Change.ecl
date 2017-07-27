import doxie;
base := file_areacode_change;
export Key_AreaCode_Change := index(base,{old_NPA,old_NXX},{base},'~thor_data400::key::areacode_change_' + doxie.Version_SuperKey);