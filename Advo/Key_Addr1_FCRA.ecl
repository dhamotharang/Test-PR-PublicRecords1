Import Data_Services, doxie, ut;

advo_b := project(Files().Base.built(active_flag = 'Y'), transform(Layouts.Layout_Common_Out_k, self := left));

// DF-21511 deprecate specified fields in thor_data400::key::advo::fcra::qa::addr_search1
ut.MAC_CLEAR_FIELDS(advo_b, advo_b_cleared, ADVO.Constants.fields_to_clear);

export Key_Addr1_FCRA := INDEX(advo_b_cleared, 
							 {zip, prim_range, prim_name, addr_suffix, predir, postdir, sec_range},
							 {advo_b_cleared},
							 Data_Services.Data_location.Prefix('advo')+'thor_data400::key::advo::fcra::' + doxie.Version_SuperKey + '::addr_search1');