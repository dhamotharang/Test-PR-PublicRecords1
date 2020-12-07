Import Data_Services, doxie;

export key_EcrashV2_tagnbr := index(mod_PrepEcrashPRKeys().dep_tagnbr_base
                                    ,{l_tagnbr := tag_nbr}
								                    ,{accident_nbr,orig_accnbr}
								                    ,Data_Services.Data_location.Prefix('ecrash')+'thor_data400::key::ecrashV2_tagnbr_' + doxie.Version_SuperKey);
