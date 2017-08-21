export Constants(string filedate) := module
	// autokey
	export ak_keyname := dnb_feinv2.cluster + 'key::Dnbfein::autokey::';
	export ak_logical := dnb_feinv2.cluster + 'key::Dnbfein::' + filedate + '::autokey::';
	//export ak_typeStr := 'BC';
end;
