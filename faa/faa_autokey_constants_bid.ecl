export faa_autokey_constants_bid(string filedate='') := module

export str_autokeyname := '~thor_data400::key::faa::autokey::bid::';
export ak_keyname	:= '~thor_data400::key::faa::autokey::bid::@version@::';
export ak_logical	:= '~thor_data400::key::faa::'+filedate+'::autokey::bid::';
export ak_dataset	:=  file_faa_autokey_bid;
export ak_skipSet	:= ['P','Q','F'];
export ak_typeStr	:= 'BC';
//export temp_ak_keyname := '~thor_data400::key::faa::autokey::bid::qa::';

end;
