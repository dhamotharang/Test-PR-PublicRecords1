import faa;
export faa_airmen_ak_constants(string filedate='') := module

	shared root := '~thor_data400::key::faa::airmen::';
	
	export str_autokeyname								:= root + 'autokey::';
	export ak_keyname											:= root + 'autokey::@version@::'; //used to build autokeys
	export ak_logical(string filedate='')	:= root + filedate + '::autokey::';
  export ak_dataset                      := faa.file_faa_airmen_autokey;
	//export ak_dataset                     := file_faa_autokey;
	export ak_skipSet											:= ['P','Q','F','B'];  // B is for no business autokeys to be built
	export ak_typeStr											:= 'BC';
	
end;
