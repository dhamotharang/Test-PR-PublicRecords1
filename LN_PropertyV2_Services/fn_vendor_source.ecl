// as defined in LN_PropertyV2.layout_property_common_model_base
export string5 fn_vendor_source(string1 flag) := case(
	flag,
	'F' => 'FAR_F',
	'S' => 'FAR_S',
	'O' => 'OKCTY',
	'D' => 'DAYTN',
	''
);