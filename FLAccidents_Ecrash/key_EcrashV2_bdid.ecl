Import Data_Services, doxie;

export key_EcrashV2_bdid := index(mod_PrepEcrashPRKeys().ded_bdid_base
                                  ,{unsigned6 l_bdid := (integer)b_did}
								                  ,{accident_nbr,orig_accnbr}
							                    ,Data_Services.Data_location.Prefix('ecrash')+'thor_data400::key::ecrashv2_bdid_' + doxie.Version_SuperKey);


