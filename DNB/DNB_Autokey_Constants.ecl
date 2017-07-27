IMPORT ut,DNB;
export DNB_Autokey_Constants(string filedate='') := module
export str_autokeyname := '~thor_data400::key::dnb::autokey::qa::';
export ak_keyname	:= '~thor_data400::key::dnb::autokey::@version@::';
export ak_logical	:= '~thor_data400::key::dnb::'+filedate+'::autokey::';
export ak_dataset	:=  DNB.File_DNB_autoKey; //dnb.File_DNB_Base; 
export ak_skipSet	:= ['P', 'S','C', 'F'];
export ak_typeStr	:= 'BC';
end;

