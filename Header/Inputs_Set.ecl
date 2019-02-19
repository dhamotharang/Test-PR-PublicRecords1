import liensv2;
// #WORKUNIT('name','hdr_bld_input_set');
export Inputs_Set(boolean incremental=false) := function

dLv2_file := if(fileservices.getsuperfilesubcount('~thor_data400::BASE::dl2::DLHeader_Building')>0,
output('Nothing added to BASE::dl2::DLHeader_Building.'),
fileservices.addsuperfile('~thor_data400::BASE::dl2::DLHeader_Building','~thor_200::base::dl2::drvlic_aid',,true));

emrg := if(fileservices.getsuperfilesubcount('~thor_data400::base::emergesHeader_Building')>0,
output('Nothing added to base::emergesHeader_Building.'),
fileservices.addsuperfile('~thor_data400::base::emergesHeader_Building','~thor_data400::base::emerges_hunt_vote_ccw',,true));

akPerm := if(fileservices.getsuperfilesubcount('~thor_data400::Base::AKHeader_Building')>0,
output('Nothing added to Base::AKHeader_Building.'),
fileservices.addsuperfile('~thor_data400::Base::AKHeader_Building','~thor_data400::Base::AK_Perm_Fund',,true));

akPermE := if(fileservices.getsuperfilesubcount('~thor_data400::Base::AKPEHeader_Building')>0,
output('Nothing added to Base::AKPEHeader_Building'),
fileservices.addsuperfile('~thor_data400::Base::AKPEHeader_Building','~thor_data400::Base::AK_Perm_Fund_PE',,true));

atf_file := if(fileservices.getsuperfilesubcount('~thor_data400::BASE::atfHeader_Building')>0,

output('Nothing added to BASE::atfHeader_Building'),
fileservices.addsuperfile('~thor_data400::BASE::atfHeader_Building','~thor_data400::base::atf_firearms_explosives',,true));

proflic_file := if(fileservices.getsuperfilesubcount('~thor_data400::Base::ProfLicHeader_Building')>0,
output('Nothing added to Base::ProfLicHeader_Building'),
fileservices.addsuperfile('~thor_data400::Base::ProfLicHeader_Building','~thor_data400::base::prof_licenses_AID',,true));

ms_work := if(fileservices.getsuperfilesubcount('~thor_data400::Base::MSHeader_Building')>0,
output('Nothing added to Base::MSHeader_Building'),
fileservices.addsuperfile('~thor_data400::Base::MSHeader_Building','~thor_data400::Base::MS_Workers',,true));

liens_file := if(fileservices.getsuperfilesubcount('~thor_data400::base::LiensHeader_Building')>0,
output('Nothing added to base::LiensHeader_Building'),
fileservices.addsuperfile('~thor_data400::base::LiensHeader_Building','~thor_data400::base::liens',,true));


liensv2_file := if(fileservices.getsuperfilesubcount('~thor_data400::base::LiensV2_mainHeader_Building')>0,
output('Nothing added to base::LiensV2Header_Building'),
sequential(
output(liensv2.file_liens_main,,'~thor_data400::base::liens::main', CLUSTER( 'thor400_44' ), overwrite,compressed), //combines all liensv2 base files main
output(liensv2.file_liens_party,,'~thor_data400::base::liens::party', CLUSTER( 'thor400_44' ), overwrite,compressed), //combines all liensv2 base files party
fileservices.addsuperfile('~thor_data400::base::LiensV2_mainHeader_Building','~thor_data400::base::liens::main'),
fileservices.addsuperfile('~thor_data400::base::LiensV2_partyHeader_Building','~thor_data400::base::liens::party')
));
		 
utils := if(fileservices.getsuperfilesubcount('~thor_data400::Base::UtilityHeader_Building')>0,
            output('Nothing added to Base::UtilityHeader_Building'),
            fileservices.addsuperfile('~thor_data400::Base::UtilityHeader_Building','~thor_data400::Base::Utility_File',,true)
		   );

bksrch := if(fileservices.getsuperfilesubcount('~thor_data400::Base::BKSrcHeader_Building')>0,
output('Nothing added to Base::BKSrcHeader_Building'),
fileservices.addsuperfile('~thor_data400::Base::BKSrcHeader_Building','~thor_data400::base::bankruptcy::search_v3',,true));

bkmain := if(fileservices.getsuperfilesubcount('~thor_data400::Base::BkMnHeader_Building')>0,
output('Nothing added to Base::BkMnHeader_Building'),
fileservices.addsuperfile('~thor_data400::Base::BkMnHeader_Building','~thor_data400::base::bankruptcy::main_v3',,true));

death_file := if(fileservices.getsuperfilesubcount('~thor_data400::Base::DeathHeader_Building')>0,
output('Nothing added to Base::DeathHeader_Building'),
fileservices.addsuperfile('~thor_data400::Base::DeathHeader_Building','~thor_data400::base::did_death_masterV2_SSA',,true));

gong_file := if(fileservices.getsuperfilesubcount('~thor_data400::Base::GongHeader_Building')>0,
output('Nothing added to Base::GongHeader_Building'),
fileservices.addsuperfile('~thor_data400::Base::GongHeader_Building','~thor_data400::base::gong',,true));

for_file := if(fileservices.getsuperfilesubcount('~thor_data400::Base::ForeclosureHeader_Building')>0,
output('Nothing added to Base::ForeclosureHeader_Building'),
fileservices.addsuperfile('~thor_data400::Base::ForeclosureHeader_Building','~thor_data400::BASE::foreclosure',,true));

airm_file := if(fileservices.getsuperfilesubcount('~thor_data400::Base::AirmenHeader_Building')>0,
output('Nothing added to Base::AirmenHeader_Building'),
fileservices.addsuperfile('~thor_data400::Base::AirmenHeader_Building','~thor_data400::base::faa_airmen_BUILT',,true));

airc_file := if(fileservices.getsuperfilesubcount('~thor_data400::Base::AircraftHeader_Building')>0,
output('Nothing added to Base::AircraftHeader_Building'),
fileservices.addsuperfile('~thor_data400::Base::AircraftHeader_Building','~thor_data400::base::faa_aircraft_reg_built',,true));

boat_file := if(fileservices.getsuperfilesubcount('~thor_data400::Base::BoatHeader_Building')>0,
output('Nothing added to Base::BoatHeader_Building'),
fileservices.addsuperfile('~thor_data400::Base::BoatHeader_Building','~thor_data400::in::emerges_boats',,true));

waterSrch_file := if(fileservices.getsuperfilesubcount('~thor_data400::Base::WatercraftSrchHeader_Building')>0,
output('Nothing added to Base::WatercraftSrchHeader_Building'),
fileservices.addsuperfile('~thor_data400::Base::WatercraftSrchHeader_Building','~thor_data400::base::watercraft_search',,true));

waterMain_file := if(fileservices.getsuperfilesubcount('~thor_data400::Base::WatercraftMainHeader_Building')>0,
output('Nothing added to Base::WatercraftMainHeader_Building'),
fileservices.addsuperfile('~thor_data400::Base::WatercraftMainHeader_Building','~thor_data400::base::watercraft_main',,true));

waterCG_file := if(fileservices.getsuperfilesubcount('~thor_data400::Base::WatercraftCGHeader_Building')>0,
output('Nothing added to Base::WatercraftCGHeader_Building'),
fileservices.addsuperfile('~thor_data400::Base::WatercraftCGHeader_Building','~thor_data400::base::watercraft_coastguard',,true));

dea_file := if(fileservices.getsuperfilesubcount('~thor_data400::Base::DeaHeader_Building')>0,
output('Nothing added to Base::DeaHeader_Building'),
fileservices.addsuperfile('~thor_data400::Base::DeaHeader_Building','~thor_data400::base::dea',,true));

LN_prop_deeds := if(fileservices.getsuperfilesubcount('~thor_data400::BASE::LN_PropV2DeedHeader_Building')>0,
output('Nothing added to BASE::LN_PropV2DeedHeader_Building'),
fileservices.addsuperfile('~thor_data400::BASE::LN_PropV2DeedHeader_Building','~thor_data400::base::ln_propertyv2::deed',,true));

LN_prop_asses := if(fileservices.getsuperfilesubcount('~thor_data400::BASE::LN_PropV2AssessHeader_Building')>0,
output('Nothing added to BASE::LN_PropV2AssessHeader_Building'),
fileservices.addsuperfile('~thor_data400::BASE::LN_PropV2AssessHeader_Building','~thor_data400::base::ln_propertyv2::assesor',,true));

LN_prop_srch := if(fileservices.getsuperfilesubcount('~thor_data400::BASE::LN_PropV2SrchHeader_Building')>0,
output('Nothing added to BASE::LN_PropV2SrchHeader_Building'),
fileservices.addsuperfile('~thor_data400::BASE::LN_PropV2SrchHeader_Building','~thor_data400::base::ln_propertyv2::search',,true));

LN_prop_addl_deeds := if(fileservices.getsuperfilesubcount('~thor_data400::BASE::LN_PropV2AddlDeedHeader_Building')>0,
output('Nothing added to BASE::LN_PropV2AddlDeedHeader_Building'),
fileservices.addsuperfile('~thor_data400::BASE::LN_PropV2AddlDeedHeader_Building','~thor_data400::base::ln_propertyv2::addl::fares_deed',,true));

LN_prop_addl_asses := if(fileservices.getsuperfilesubcount('~thor_data400::BASE::LN_PropV2AddlAssessHeader_Building')>0,
output('Nothing added to BASE::LN_PropV2AddlAssessHeader_Building'),
fileservices.addsuperfile('~thor_data400::BASE::LN_PropV2AddlAssessHeader_Building','~thor_data400::base::ln_propertyv2::addl::fares_tax',,true));

asl_file := if(fileservices.getsuperfilesubcount('~thor_data400::Base::ASLHeader_Building')>0,
output('Nothing added to Base::ASLHeader_Building'),
fileservices.addsuperfile('~thor_data400::Base::ASLHeader_Building','~thor_data400::base::american_student_list',,true));

osl_file := if(fileservices.getsuperfilesubcount('~thor_data400::Base::OKC_SLHeader_Building')>0,
output('Nothing added to Base::OKC_SLHeader_Building'),
fileservices.addsuperfile('~thor_data400::Base::OKC_SLHeader_Building','~thor_data400::base::okc_student_list',,true));

voters_v2 := if(fileservices.getsuperfilesubcount('~thor_data400::Base::Voters_Header_Building')>0,
output('Nothing added to Base::Voters_Header_Building'),
fileservices.addsuperfile('~thor_data400::Base::Voters_Header_Building','~thor_data400::Base::Voters_Reg',,true));

certegy_file := if(fileservices.getsuperfilesubcount('~thor_data400::Base::certegyHeader_Building')>0,
output('Nothing added to Base::certegyHeader_Building'),
fileservices.addsuperfile('~thor_data400::Base::certegyHeader_Building','~thor_data400::base::certegy',,true));

tucs_file := if(fileservices.getsuperfilesubcount('~thor_data400::Base::tucsHeader_Building')>0,
output('Nothing added to Base::tucsHeader_Building'),
fileservices.addsuperfile('~thor_data400::Base::tucsHeader_Building','~thor400::base::transunion_PTrak',,true));

experian_file := if(fileservices.getsuperfilesubcount('~thor_data400::Base::experianHeader_Building')>0,
output('Nothing added to Base::experianHeader_Building'),
fileservices.addsuperfile('~thor_data400::Base::experianHeader_Building','~thor_data400::base::Experiancred',,true));

exprnph_file := if(fileservices.getsuperfilesubcount('~thor_data400::Base::exprnphHeader_Building')>0,
output('Nothing added to Base::exprnphHeader_Building'),
fileservices.addsuperfile('~thor_data400::Base::exprnphHeader_Building','~thor_data400::base::Experianirsg_build',,true));

sex_offender_file := if(fileservices.getsuperfilesubcount('~thor_data400::Base::sex_offender_mainpublic_building ')>0,
output('Nothing added to Base::sex_offender_mainpublic_building '),
fileservices.addsuperfile('~thor_data400::Base::sex_offender_mainpublic_building ','~thor_data400::base::sex_offender_mainpublic',,true));

transunioncred_file := if(fileservices.getsuperfilesubcount('~thor_data400::base::transunioncredheader_building')>0,
output('Nothing added to Base::transunioncredheader_building'),
fileservices.addsuperfile('~thor_data400::base::transunioncredheader_building','~thor_data400::base::TransunionCred',,true));

EQ_hist_file := if(fileservices.getsuperfilesubcount('~thor_data400::base::eq_histHeader_building')>0,
output('Nothing added to Base::eq_histHeader_building'),
fileservices.addsuperfile('~thor_data400::base::eq_histHeader_building','~thor_data400::BASE::equifax_history',,true));

AlloyMedia_SL_file := if(fileservices.getsuperfilesubcount('~thor_data400::base::alloymedia_student_list_Header_Building')>0,
output('Nothing added to Base::alloymedia_student_list_Header_Building'),
fileservices.addsuperfile('~thor_data400::base::alloymedia_student_list_Header_Building','~thor_data400::base::alloymedia_student_list',,true));

targus := if(fileservices.getsuperfilesubcount('~thor_data400::base::consumer_targusHeader_Building')>0,
output('Nothing added to Base::consumer_targusHeader_Building'),
fileservices.addsuperfile('~thor_data400::base::consumer_targusHeader_Building','~thor_data400::base::consumer_targus',,true));

cd_seed := if(fileservices.getsuperfilesubcount('~thor_data::base::cd_seed_building')>0,
output('Nothing added to Base::cd_seed_Building'),
fileservices.addsuperfile('~thor_data::base::cd_seed_building','~thor_data::base::CD_Seed::built',,true));

add_super := sequential(
                            parallel(
                                             dLv2_file
                                            ,emrg
                                            ,akPerm
                                            ,akPermE
                                            ,atf_file
                                            ,proflic_file
                                            ,death_file
                                            ,gong_file
                                            ,ms_work
                                            ,liens_file
                                            ,utils
                                            ,bksrch
                                            ,bkmain
                                            ,for_file
                                            ,airm_file
                                            ,airc_file
                                            ,boat_file
                                            ,waterSrch_file
                                            ,waterMain_file
                                            ,waterCG_file
                                            ,dea_file
                                            ,ln_prop_deeds
                                            ,ln_prop_asses
                                            ,ln_prop_srch
                                            ,ln_prop_addl_deeds
                                            ,ln_prop_addl_asses
                                            ,asl_file
                                            ,osl_file
                                            ,voters_v2
                                            ,certegy_file
                                            ,tucs_file
                                            ,experian_file
                                            ,exprnph_file
                                            ,sex_offender_file
                    ,if(~incremental        ,transunioncred_file   )
                                            ,EQ_hist_file
                                            ,AlloyMedia_SL_file
                                            ,targus
                                            )
                    ,liensv2_file
                    ,cd_seed
                    );

return add_super;
end;