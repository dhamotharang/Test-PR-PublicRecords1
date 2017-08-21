import ut, doxie;
ds := dataset ([],{unsigned6 lnpid, unsigned6 sanc_id }); 

EXPORT key_sanction := pull(dedup(sort(INDEX(ds,
														{lnpid},
														{ds}, 
														ut.foreign_prod_boca+ 'thor_data400::key::ingenix_sanctions_lnpid_' + doxie.Version_SuperKey) (sanc_id < 10000000),lnpid),lnpid));
