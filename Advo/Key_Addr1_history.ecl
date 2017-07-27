import doxie, ut, data_services;


Layout_revised := record
Layouts.Layout_Common_Out_k and not src;
end;

advo_b := project(Rollup_History, transform(Layout_revised, self := left));
export key_addr1_history := INDEX(advo_b, 
							 {zip, prim_range, prim_name, addr_suffix, predir, postdir, sec_range},
							 {advo_b},
							 Data_Services.Data_location.Prefix('advo')+ 'thor_data400::key::advo::' + doxie.Version_SuperKey + '::addr_search1_history');
							 
							 
							 
							 
							 
							 