IMPORT watercraft, watercraft_preprocess, ut, lib_StringLib, PromoteSupers;

ds_raw_base := dataset('~thor_data400::in::watercraft_coastguard_common',watercraft.Layout_Watercraft_Coastguard_Base,flat);

dJoined	:= Watercraft_preprocess.Map_CG_raw_to_CoastGuard
					+ Watercraft_preprocess.Map_WI_raw_to_CoastGuard;
					
//Rollup to capture most current record and latest registration
BOOLEAN basefileexists	:=	nothor(fileservices.GetSuperFileSubCount('~thor_data400::in::watercraft_coastguard_common')) > 0;

ds_combined := IF(basefileexists,dJoined + ds_raw_base,dJoined);
ds_distrib := sort(distribute(ds_combined, HASH(state_origin,watercraft_key, sequence_key)),
										state_origin,
										watercraft_key,
										sequence_key,
										hull_number,
										local);
										
RollupAll	:=	ROLLUP(ds_distrib, transform(watercraft.Layout_Watercraft_Coastguard_Base,self := left;),
											state_origin,
											watercraft_key,
											sequence_key,
											hull_number,
											doc_certificate_status,
											local);

PromoteSupers.MAC_SF_BuildProcess(RollupAll,'~thor_data400::in::watercraft_coastguard_common',build_wc_raw_out,2, /*csvout*/false, /*compress*/true);

EXPORT proc_coastguard_join_rollup := build_wc_raw_out;