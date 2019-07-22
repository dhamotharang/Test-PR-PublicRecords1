Import Data_Services, doxie, ut;

advo_b := project(Files().Base.built(active_flag = 'Y'), transform(Layouts.Layout_Common_Out_k, self := left));

export Key_Addr1_FCRA := INDEX(advo_b, 
							 {zip, prim_range, prim_name, addr_suffix, predir, postdir, sec_range},
							 {advo_b},
							 Data_Services.Data_location.Prefix('advo')+'thor_data400::key::advo::fcra::' + doxie.Version_SuperKey + '::addr_search1');