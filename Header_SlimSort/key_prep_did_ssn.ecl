import data_services;

slim_rec_plus := record
	unsigned6 did;
	qstring9 ssn;
	QSTRING4 ssn4;
	unsigned2 cnt;
	unsigned2 freq;
	unsigned8 __fpos { virtual (fileposition)};
end;

k1 := dataset('~thor_data400::base::did_ssn_glb_BUILDING',slim_rec_plus,flat);

export key_prep_did_ssn := index(k1,{did,ssn,ssn4,freq,__fpos},data_services.data_location.prefix() + 'thor_Data400::key::did_ssn_glb' + thorlib.wuid());