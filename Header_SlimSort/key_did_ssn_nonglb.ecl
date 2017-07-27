import doxie;

k2 := file_did_ssn_nonglb;

export key_did_ssn_nonglb := index(k2,{did,ssn,ssn4,freq,__fpos},'~thor_Data400::key::did_ssn_nonglb_' + doxie.Version_SuperKey);