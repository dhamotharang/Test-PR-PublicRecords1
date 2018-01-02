import header,doxie, data_services;
export key_DID_FCRA := 
	header_quick.FN_key_DID(dataset([], header.Layout_Header), 
	data_services.foreign_prod + 'thor_data400::key::' + header_quick.str_SegmentName + '::FCRA::did_' + Doxie.Version_SuperKey);

