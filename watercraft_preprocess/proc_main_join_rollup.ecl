IMPORT watercraft, watercraft_preprocess, ut, lib_StringLib, PromoteSupers;
#option('multiplePersistInstances',FALSE);

ds_raw_base := dataset('~thor_data400::in::watercraft_main_common',watercraft.Layout_Watercraft_Main_Base,flat);

dJoined
 := Watercraft_preprocess.Map_AK_raw_to_Main
 +  Watercraft_preprocess.Map_AL_raw_to_Main
 +	Watercraft_preprocess.Map_AR_raw_to_Main
 +	Watercraft_preprocess.Map_AZ_raw_to_Main
 +	Watercraft_preprocess.Map_CT_raw_to_Main
 +	Watercraft_preprocess.Map_FL_raw_to_Main
 +	Watercraft_preprocess.Map_GA_raw_to_Main
 +	Watercraft_preprocess.Map_IA_raw_to_Main
 +	Watercraft_preprocess.Map_KS_raw_to_Main
 +	Watercraft_preprocess.Map_KY_raw_to_Main
 +	Watercraft_preprocess.Map_MA_raw_to_Main
 +	Watercraft_preprocess.Map_ME_raw_to_Main
 +	Watercraft_preprocess.Map_MI_raw_to_Main
 +	Watercraft_preprocess.Map_MO_raw_to_Main
 +	Watercraft_preprocess.Map_MS_raw_to_Main
 +	Watercraft_preprocess.Map_ND_raw_to_Main
 +	Watercraft_preprocess.Map_NE_raw_to_Main
 +	Watercraft_preprocess.Map_NM_raw_to_Main
 +	Watercraft_preprocess.Map_OH_raw_to_Main
 +	Watercraft_preprocess.Map_OR_raw_to_Main
 +	Watercraft_preprocess.Map_TX_raw_to_Main
 +	Watercraft_preprocess.Map_VA_raw_to_Main
 +	Watercraft_preprocess.Map_WA_raw_to_Main
 +	Watercraft_preprocess.Map_WI_raw_to_Main
 //+	Watercraft_preprocess.Map_WY_raw_to_Main - new layout for 2015_Q1
 +	Watercraft_preprocess.Map_Wy_raw_to_Main_new
 +	Watercraft_preprocess.Map_CG_raw_to_Main;
 
 //Rollup to capture most current record and latest registration
BOOLEAN basefileexists	:=	nothor(fileservices.GetSuperFileSubCount('~thor_data400::in::watercraft_main_common')) > 0;

ds_combined := IF(basefileexists,dJoined + ds_raw_base,dJoined);
ds_distrib := sort(distribute(ds_combined, HASH(state_origin,watercraft_key)),
										state_origin,
										watercraft_key,
										registration_number,
										hull_number,
										-registration_date,
										registration_status_code,
										-registration_expiration_date,
										-registration_status_date,
										-registration_renewal_date,
										-title_issue_date,
										lien_1_name,
										local);
										
RollupAll	:=	ROLLUP(ds_distrib, transform(watercraft.Layout_Watercraft_Main_Base,self := left;),
											state_origin,
											watercraft_key,
											registration_number,
											hull_number,
											registration_status_code,
											registration_expiration_date,
											registration_status_date,
											registration_renewal_date,
											title_issue_date,
											lien_1_name,
											local);

PromoteSupers.MAC_SF_BuildProcess(RollupAll,'~thor_data400::in::watercraft_main_common',build_wc_raw_out,2, /*csvout*/false, /*compress*/true);


EXPORT proc_main_join_rollup := build_wc_raw_out;