export CCW_Constants(string filedate='') := module

	shared root := '~thor_data400::key::CCW::';
	
	export str_autokeyname								:= root + 'autokey::';
	export ak_keyname											:= root + '@version@::autokey::'; //used to build autokeys
	export ak_logicalname               	:= root + filedate + '::autokey::';
	export ak_QAname                      := root + 'qa::autokey::';
	export ak_skipSet											:= ['P','Q','F','B'];  // B is for no business autokeys to be built
	export ak_typeStr											:= 'BC';
	
	export ak_keyname_fcra								:= root + 'fcra::@version@::autokey::'; //used to build autokeys
	export ak_logicalname_fcra           	:= root + 'fcra::' +filedate + '::autokey::';
	export ak_QAname_fcra                 := root + 'fcra::qa::autokey::';
end;

// need to add a ccw_rid to the layout as a particular did search will
// pull up multiple recs e.g. did=62031


