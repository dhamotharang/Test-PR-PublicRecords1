import data_services, doxie, dx_Header;

export data_key_addr_hist(unsigned1 data_class = data_services.data_env.iNonFCRA) := function

boolean isFCRA := data_class = data_services.data_env.iFCRA;

ds:=header.proc_address_hist(isFCRA);

RETURN PROJECT (ds, dx_Header.layouts.i_addr_hist);
//address_ind :=index(ds,{ds.s_did},{ds}, data_services.Data_location.person_header +
//                                        if(isFCRA,
//                                           'thor_data400::key::fcra::header::address_rank_',
//                                           'thor_data400::key::header::address_rank_') + Doxie.Version_SuperKey);
//return address_ind;


end;
