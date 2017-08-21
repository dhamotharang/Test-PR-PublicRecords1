#OPTION('multiplePersistInstances',FALSE);

export PRTE_BIP_BH_Sources_Prepped :=
				sequential(
										/*prte_bip.prep_bankruptcy('20140624').all
									 ,prte_bip.prep_corp2('20130404b').all
									 ,prte_bip.prep_dcav2.all
									 ,prte_bip.prep_dea('20140716').all
									 ,prte_bip.prep_dnb_dmi.all
									 ,prte_bip.prep_ebr.all*/
									  prte_bip.prep_faa.all
									 ,prte_bip.prep_busreg.all
									 /*
									 ,prte_bip.prep_gongv2('20121030').all
									 ,prte_bip.prep_irs5500.all
									 ,prte_bip.prep_liensv2('20140717').all
									 ,prte_bip.prep_ln_propertyv2.all
									 ,prte_bip.prep_prof_licensev2.all
									 ,prte_bip.prep_uccv2.all
									 ,prte_bip.prep_vehiclev2.all
									 ,prte_bip.prep_watercraft.all*/
									);
