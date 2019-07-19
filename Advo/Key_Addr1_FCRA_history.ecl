Import Data_Services, doxie, ut, vault, _control;

Layout_revised := record
Layouts.Layout_Common_Out_k and not src;
end;

advo_b := project(Rollup_History, transform(Layout_revised, self := left));


#IF(_Control.Environment.onVault) // when running on vault cluster, we need to use the file pointer instead of the roxie key in boca
export Key_Addr1_FCRA_history := vault.Advo.Key_Addr1_FCRA_history;
#ELSE
export Key_Addr1_FCRA_history := INDEX(advo_b, 
							 {zip, prim_range, prim_name, addr_suffix, predir, postdir, sec_range},
							 {advo_b},
							 Data_Services.Data_location.Prefix('advo')+'thor_data400::key::advo::fcra::' + doxie.Version_SuperKey + '::addr_search1_history');

#END;


