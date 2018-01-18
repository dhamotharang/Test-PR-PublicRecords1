import doxie, data_services;

k4 := file_did_ssn_nonglb_nonutil;

export key_did_ssn_Nonglb_NonUtil := index(k4,{did,ssn,ssn4,freq,__fpos},data_services.data_location.prefix() + 'thor_Data400::key::did_ssn_nonglb_nonUtil_' + doxie.Version_SuperKey);