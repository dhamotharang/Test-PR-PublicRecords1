import doxie, data_services;

filtered_flcrash_ss := flaccidents.basefile_flcrash_ss((lname<>'' or cname <> '') or 
                                                       prim_name<>'');

flcrash_accnbr_base := filtered_flcrash_ss(accident_nbr<>'',
                                            accident_nbr<>'000000000');
											 
dst_accnbr_base := distribute(flcrash_accnbr_base, hash(accident_nbr));
srt_accnbr_base := sort(dst_accnbr_base, except did, except b_did, local);
dep_accnbr_base := dedup(srt_accnbr_base, except did, except b_did, local);

export key_flcrash_accnbr := index(dep_accnbr_base,
                                   {unsigned6 l_accnbr := (integer)accident_nbr},
                                   {accident_date,did,title,fname,mname,lname,name_suffix,b_did,cname,
                                      prim_range,predir,prim_name,addr_suffix,postdir,
                                      unit_desig,sec_range,v_city_name,st,zip,zip4,
                                      record_type,vin,driver_license_nbr,dlnbr_st,tag_nbr,tagnbr_st
                                   },
                                   data_services.data_location.prefix() + 'thor_data400::key::flcrash_accnbr_' + doxie.Version_SuperKey);