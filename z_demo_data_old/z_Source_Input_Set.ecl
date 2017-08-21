import drivers, driversv2, vehlic,watercraft, ln_property, utilfile, american_student_list, liensv2, ln_propertyv2,dea;

dLv2_file := if(fileservices.getsuperfilesubcount('~thor_data400::BASE::dl2::DLHeader_Building')>0,
output('Nothing added to BASE::dl2::DLHeader_Building.'),
fileservices.addsuperfile('~thor_data400::BASE::dl2::DLHeader_Building','~thor_200::base::dl2::drvlic'));

vehs := if(fileservices.getsuperfilesubcount('~thor_data400::BASE::VehiclesHeader_Building')>0,
output('Nothing added to BASE::VehiclesHeader_Building.'),
fileservices.addsuperfile('~thor_data400::BASE::VehiclesHeader_Building','~thor_data400::BASE::Vehicles_' + vehlic.version));

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
fileservices.addsuperfile('~thor_data400::Base::ProfLicHeader_Building','~thor_data400::Base::Prof_Licenses',,true));

ms_work := if(fileservices.getsuperfilesubcount('~thor_data400::Base::MSHeader_Building')>0,
output('Nothing added to Base::MSHeader_Building'),
fileservices.addsuperfile('~thor_data400::Base::MSHeader_Building','~thor_data400::Base::MS_Workers',,true));

liens_file := if(fileservices.getsuperfilesubcount('~thor_data400::base::LiensHeader_Building')>0,
output('Nothing added to base::LiensHeader_Building'),
fileservices.addsuperfile('~thor_data400::base::LiensHeader_Building','~thor_data400::base::liens',,true));


liensv2_file := if(fileservices.getsuperfilesubcount('~thor_data400::base::LiensV2_mainHeader_Building')>0,
output('Nothing added to base::LiensV2Header_Building'),
sequential(
//output(liensv2.file_liens_main,,'~thor_data400::base::liens::main', overwrite), //combines all liensv2 base files main
//output(liensv2.file_liens_party,,'~thor_data400::base::liens::party', overwrite), //combines all liensv2 base files party
fileservices.addsuperfile('~thor_data400::base::LiensV2_mainHeader_Building','~thor_data400::base::liens::main',,true),
fileservices.addsuperfile('~thor_data400::base::LiensV2_partyHeader_Building','~thor_data400::base::liens::party',,true)
//FileServices.DeleteLogicalFile('~thor_data400::base::liens::main'), //deletes combined all liensv2 base files main
//FileServices.DeleteLogicalFile('~thor_data400::base::liens::party') //deletes combined all liensv2 base files main
));
		 
utils := if(fileservices.getsuperfilesubcount('~thor_data400::Base::UtilityHeader_Building')>0,
            output('Nothing added to Base::UtilityHeader_Building'),
            sequential(fileservices.addsuperfile('~thor_data400::Base::UtilityHeader_Building',
		                                           '~thor_data400::Base::Utility_File',,true),
		                 utilfile.mod_daily_did_sf_swap().swap_sfs
						)
		   );

bksrch := if(fileservices.getsuperfilesubcount('~thor_data400::Base::BKSrcHeader_Building')>0,
output('Nothing added to Base::BKSrcHeader_Building'),
fileservices.addsuperfile('~thor_data400::Base::BKSrcHeader_Building','~thor_data400::base::bankruptcy::search',,true));

bkmain := if(fileservices.getsuperfilesubcount('~thor_data400::Base::BkMnHeader_Building')>0,
output('Nothing added to Base::BkMnHeader_Building'),
fileservices.addsuperfile('~thor_data400::Base::BkMnHeader_Building','~thor_data400::base::bankruptcy::main',,true));

prop_deeds := if(fileservices.getsuperfilesubcount('~thor_data400::BASE::PropDeedHeader_Building')>0,
output('Nothing added to BASE::PropDeedHeader_Building'),
fileservices.addsuperfile('~thor_data400::BASE::PropDeedHeader_Building','~thor_data400::base::fares_1080',,true));

prop_asses := if(fileservices.getsuperfilesubcount('~thor_data400::BASE::PropAssesHeader_Building')>0,
output('Nothing added to BASE::PropAssesHeader_Building'),
fileservices.addsuperfile('~thor_data400::BASE::PropAssesHeader_Building','~thor_data400::base::fares_2580',,true));

prop_srch := if(fileservices.getsuperfilesubcount('~thor_data400::BASE::PropSrchHeader_Building')>0,
output('Nothing added to BASE::PropSrchHeader_Building'),
fileservices.addsuperfile('~thor_data400::BASE::PropSrchHeader_Building','~thor_data400::in::fares_search',,true));

death_file := if(fileservices.getsuperfilesubcount('~thor_data400::Base::DeathHeader_Building')>0,
output('Nothing added to Base::DeathHeader_Building'),
fileservices.addsuperfile('~thor_data400::Base::DeathHeader_Building','~thor_data400::base::did_death_masterV2',,true));

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
fileservices.addsuperfile('~thor_data400::Base::BoatHeader_Building','~thor_data400::in::emerges_boats_20050225'));

waterSrch_file := if(fileservices.getsuperfilesubcount('~thor_data400::Base::WatercraftSrchHeader_Building')>0,
output('Nothing added to Base::WatercraftSrchHeader_Building'),
fileservices.addsuperfile('~thor_data400::Base::WatercraftSrchHeader_Building','~thor_data400::base::watercraft_search'));

waterMain_file := if(fileservices.getsuperfilesubcount('~thor_data400::Base::WatercraftMainHeader_Building')>0,
output('Nothing added to Base::WatercraftMainHeader_Building'),
fileservices.addsuperfile('~thor_data400::Base::WatercraftMainHeader_Building','~thor_data400::base::watercraft_main'));

waterCG_file := if(fileservices.getsuperfilesubcount('~thor_data400::Base::WatercraftCGHeader_Building')>0,
output('Nothing added to Base::WatercraftCGHeader_Building'),
fileservices.addsuperfile('~thor_data400::Base::WatercraftCGHeader_Building','~thor_data400::base::watercraft_coastguard'));

// Dea for some reason the base file had the wrong layout so had to project it to key build

dea_file := if(fileservices.getsuperfilesubcount('~thor_data400::Base::DeaHeader_Building')>0,
output('Nothing added to Base::DeaHeader_Building'),
fileservices.addsuperfile('~thor_data400::Base::DeaHeader_Building','~thor_data400::base::dea'));

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
fileservices.addsuperfile('~thor_data400::Base::ASLHeader_Building',American_student_list.Cluster+'base::american_student_list',,true));

voters_v2 := if(fileservices.getsuperfilesubcount('~thor_data400::Base::Voters_Header_Building')>0,
output('Nothing added to Base::Voters_Header_Building'),
fileservices.addsuperfile('~thor_data400::Base::Voters_Header_Building','~thor_data400::Base::Voters_Reg',,true));

vehicle_v2_main  := if(fileservices.getsuperfilesubcount('~thor_data400::base::vehicles_v2_main_header_building')>0,
output('Nothing added to base::vehicles_v2_main_header_building'),
fileservices.addsuperfile('~thor_data400::base::vehicles_v2_main_header_building','~thor_data400::base::vehiclev2::main',,true));

vehicle_v2_party := if(fileservices.getsuperfilesubcount('~thor_data400::base::vehicles_v2_party_header_building')>0,
output('Nothing added to base::vehicles_v2_party_header_building'),
fileservices.addsuperfile('~thor_data400::base::vehicles_v2_party_header_building','~thor_data400::base::vehiclev2::party',,true));

add_super := parallel(dLv2_file,vehs,emrg,akPerm,akPermE,atf_file,proflic_file,death_file,gong_file,
					ms_work,liens_file,liensv2_file,utils,bksrch,bkmain,prop_deeds,prop_asses,prop_srch,
					for_file,airm_file,airc_file,boat_file,waterSrch_file,waterMain_file,waterCG_file,dea_file,ln_prop_deeds,
					ln_prop_asses,ln_prop_srch,ln_prop_addl_deeds,ln_prop_addl_asses,asl_file,voters_v2,vehicle_v2_main,vehicle_v2_party);


export Source_Input_Set := add_super;