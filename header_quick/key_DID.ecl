import header,doxie;
export key_DID := 
	header_quick.FN_key_DID(dataset([], header.Layout_Header), 
	'~thor_data400::key::' + header_quick.str_SegmentName + 'DID_' + Doxie.Version_SuperKey);