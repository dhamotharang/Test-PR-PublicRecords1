import doxie;

k3 := file_did_ssn_nonUtil;

export key_did_ssn_nonUtil := index(k3,{did,ssn,ssn4,freq,__fpos},'~thor_Data400::key::did_ssn_nonUtil_' + doxie.Version_SuperKey);