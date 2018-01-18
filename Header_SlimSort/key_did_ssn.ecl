import header,doxie, data_services;

df := header_slimsort.file_did_Ssn;

export key_did_ssn := index(df,{did,ssn,ssn4,freq,__fpos},data_services.data_location.prefix() + 'thor_Data400::key::did_ssn_glb_' + doxie.Version_SuperKey);