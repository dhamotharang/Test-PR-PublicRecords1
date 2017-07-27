export faa_autokey_constants(string filedate='') := module

export str_autokeyname := '~thor_data400::key::faa::autokey::';
export ak_keyname	:= '~thor_data400::key::faa::autokey::@version@::';
export ak_logical	:= '~thor_data400::key::faa::'+filedate+'::autokey::';
export ak_dataset	:=  file_faa_autokey;
export ak_skipSet	:= ['P','Q','F'];
export ak_typeStr	:= 'BC';

end;
