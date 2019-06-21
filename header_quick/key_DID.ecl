import doxie,dx_header,data_services;
export key_DID := 
	header_quick.FN_key_DID(dataset([], dx_header.Layout_Header), 
	data_services.Data_location.Header_Quick + 'thor_data400::key::' + header_quick.str_SegmentName + 'DID_' + Doxie.Version_SuperKey);