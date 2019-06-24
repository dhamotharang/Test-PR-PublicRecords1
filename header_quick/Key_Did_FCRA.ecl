import header_quick,dx_header,doxie, ut, data_services;
export key_DID_FCRA := 
	header_quick.FN_key_DID(dataset([], dx_header.Layout_Header), 
	data_services.Data_location.Prefix('Header_Quick') + 'thor_data400::key::' + header_quick.str_SegmentName + '::FCRA::did_' + Doxie.Version_SuperKey);

