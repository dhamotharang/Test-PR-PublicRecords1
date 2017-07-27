slim_rec_plus := record
	unsigned6 did;
	qstring9 ssn;
	QSTRING4 ssn4;
	unsigned2 cnt;
	unsigned2 freq;
	unsigned8 __fpos { virtual (fileposition)};
end;

k3 := dataset('~thor_data400::base::did_ssn_nonUtil_BUILDING',slim_rec_plus,flat);

export key_prep_did_ssn_nonUtil := index(k3,{did,ssn,ssn4,freq,__fpos},'~thor_Data400::key::did_ssn_nonUtil' + thorlib.wuid());