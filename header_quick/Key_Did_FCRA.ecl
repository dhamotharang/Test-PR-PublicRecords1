import header,doxie, ut;
export key_DID_FCRA := 
	header_quick.FN_key_DID(dataset([], header.Layout_Header), 
	ut.foreign_prod + 'thor_data400::key::' + header_quick.str_SegmentName + '::FCRA::did_' + Doxie.Version_SuperKey);

