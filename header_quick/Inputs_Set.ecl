import liensv2,header;

export Inputs_Set(string pVersion=Header.Sourcedata_month.v_eq_as_of_date) := function

dLv2_file := if(fileservices.getsuperfilesubcount('~thor_data400::BASE::dl2::DLQuickHeader_Building')>0,
output('Nothing added to BASE::dl2::DLQuickHeader_Building.'),
fileservices.addsuperfile('~thor_data400::BASE::dl2::DLQuickHeader_Building','~thor_200::base::dl2::drvlic_aid',,true));

liens_file := if(fileservices.getsuperfilesubcount('~thor_data400::base::LiensQuickHeader_Building')>0,
output('Nothing added to base::LiensQuickHeader_Building'),
fileservices.addsuperfile('~thor_data400::base::LiensQuickHeader_Building','~thor_data400::base::liens',,true));


liensv2_file := if(fileservices.getsuperfilesubcount('~thor_data400::base::LiensV2_mainQuickHeader_Building')>0,
output('Nothing added to base::LiensV2QuickHeader_Building'),
sequential(
				output(liensv2.file_liens_main,,'~thor_data400::base::liens::main_'+workunit,compressed) //combines all liensv2 base files main
				,output(liensv2.File_liens_party_headerIngest,,'~thor_data400::base::liens::party_'+workunit,compressed) //combines all liensv2 base files party
				,fileservices.addsuperfile('~thor_data400::base::LiensV2_mainQuickHeader_Building','~thor_data400::base::liens::main_'+workunit)
				,fileservices.addsuperfile('~thor_data400::base::LiensV2_partyQuickHeader_Building','~thor_data400::base::liens::party_'+workunit)
				));
		 
bksrch := if(fileservices.getsuperfilesubcount('~thor_data400::Base::BKSrcQuickHeader_Building')>0,
output('Nothing added to Base::BKSrcQuickHeader_Building'),
fileservices.addsuperfile('~thor_data400::Base::BKSrcQuickHeader_Building','~thor_data400::base::bankruptcy::search_v3',,true));

bkmain := if(fileservices.getsuperfilesubcount('~thor_data400::Base::BkMnQuickHeader_Building')>0,
output('Nothing added to Base::BkMnQuickHeader_Building'),
fileservices.addsuperfile('~thor_data400::Base::BkMnQuickHeader_Building','~thor_data400::base::bankruptcy::main_v3',,true));

LN_prop_deeds := if(fileservices.getsuperfilesubcount('~thor_data400::BASE::LN_PropV2DeedQuickHeader_Building')>0,
output('Nothing added to BASE::LN_PropV2DeedQuickHeader_Building'),
fileservices.addsuperfile('~thor_data400::BASE::LN_PropV2DeedQuickHeader_Building','~thor_data400::base::ln_propertyv2::deed',,true));

LN_prop_asses := if(fileservices.getsuperfilesubcount('~thor_data400::BASE::LN_PropV2AssessQuickHeader_Building')>0,
output('Nothing added to BASE::LN_PropV2AssessQuickHeader_Building'),
fileservices.addsuperfile('~thor_data400::BASE::LN_PropV2AssessQuickHeader_Building','~thor_data400::base::ln_propertyv2::assesor',,true));

LN_prop_srch := if(fileservices.getsuperfilesubcount('~thor_data400::BASE::LN_PropV2SrchQuickHeader_Building')>0,
output('Nothing added to BASE::LN_PropV2SrchQuickHeader_Building'),
fileservices.addsuperfile('~thor_data400::BASE::LN_PropV2SrchQuickHeader_Building','~thor_data400::base::ln_propertyv2::search',,true));

LN_prop_addl_deeds := if(fileservices.getsuperfilesubcount('~thor_data400::BASE::LN_PropV2AddlDeedQuickHeader_Building')>0,
output('Nothing added to BASE::LN_PropV2AddlDeedQuickHeader_Building'),
fileservices.addsuperfile('~thor_data400::BASE::LN_PropV2AddlDeedQuickHeader_Building','~thor_data400::base::ln_propertyv2::addl::fares_deed',,true));

LN_prop_addl_asses := if(fileservices.getsuperfilesubcount('~thor_data400::BASE::LN_PropV2AddlAssessQuickHeader_Building')>0,
output('Nothing added to BASE::LN_PropV2AddlAssessQuickHeader_Building'),
fileservices.addsuperfile('~thor_data400::BASE::LN_PropV2AddlAssessQuickHeader_Building','~thor_data400::base::ln_propertyv2::addl::fares_tax',,true));

vehicle_v2_main  := if(fileservices.getsuperfilesubcount('~thor_data400::base::vehicles_v2_main_QuickHeader_building')>0,
output('Nothing added to base::vehicles_v2_main_QuickHeader_building'),
fileservices.addsuperfile('~thor_data400::base::vehicles_v2_main_QuickHeader_building','~thor_data400::base::vehiclev2::main',,true));

vehicle_v2_party := if(fileservices.getsuperfilesubcount('~thor_data400::base::vehicles_v2_party_QuickHeader_building')>0,
output('Nothing added to base::vehicles_v2_party_QuickHeader_building'),
fileservices.addsuperfile('~thor_data400::base::vehicles_v2_party_QuickHeader_building','~thor_data400::base::vehiclev2::party',,true));

experian_file := if(fileservices.getsuperfilesubcount('~thor_data400::Base::experianQuickHeader_Building')>0,
output('Nothing added to Base::experianQuickHeader_Building'),
fileservices.addsuperfile('~thor_data400::Base::experianQuickHeader_Building','~thor_data400::base::Experiancred',,true));

transunioncred_file := if(fileservices.getsuperfilesubcount('~thor_data400::base::transunioncredQuickHeader_building')>0,
output('Nothing added to Base::transunioncredQuickHeader_building'),
fileservices.addsuperfile('~thor_data400::base::transunioncredQuickHeader_building','~thor_data400::base::TransunionCred',,true));

EQ_hist_file := if(fileservices.getsuperfilesubcount('~thor_data400::base::eq_histQuickHeader_building')>0,
output('Nothing added to Base::eq_histQuickHeader_building'),
fileservices.addsuperfile('~thor_data400::base::eq_histQuickHeader_building','~thor_data400::BASE::equifax_history',,true));

mod:=header.Mod_SetSources(true,pVersion);

sequence_sources:=parallel(
													Mod.sequence_EQ
													,Mod.sequence_L2
													,Mod.sequence_EN
													,Mod.sequence_TN
													,Mod.sequence_DL
													,Mod.sequence_VH
													,Mod.sequence_BA
													,Mod.sequence_FAT
													,Mod.sequence_FAD
													);

add_super := sequential(
												parallel(
																	dLv2_file
																	,liens_file
																	,liensv2_file
																	,bksrch
																	,bkmain
																	,ln_prop_deeds
																	,ln_prop_asses
																	,ln_prop_srch
																	,ln_prop_addl_deeds
																	,ln_prop_addl_asses
																	,vehicle_v2_main
																	,vehicle_v2_party
																	,experian_file
																	,transunioncred_file
																	,EQ_hist_file
																	)
													,sequence_sources
													);

return add_super;

end;