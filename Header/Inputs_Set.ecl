import drivers, vehlic,watercraft;

dL_file := if(fileservices.getsuperfilesubcount('~thor_data400::BASE::DLHeader_Building')>0,
output('Nothing added to BASE::DLHeader_Building.'),
fileservices.addsuperfile('~thor_data400::BASE::DLHeader_Building',drivers.Cluster + 'Base::FLDL_DID' + drivers.version));

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
fileservices.addsuperfile('~thor_data400::BASE::atfHeader_Building','~thor_data400::in::atf_firearms_explosives_IN',,true));

proflic_file := if(fileservices.getsuperfilesubcount('~thor_data400::Base::ProfLicHeader_Building')>0,
output('Nothing added to Base::ProfLicHeader_Building'),
fileservices.addsuperfile('~thor_data400::Base::ProfLicHeader_Building','~thor_data400::Base::Prof_Licenses',,true));

ms_work := if(fileservices.getsuperfilesubcount('~thor_data400::Base::MSHeader_Building')>0,
output('Nothing added to Base::MSHeader_Building'),
fileservices.addsuperfile('~thor_data400::Base::MSHeader_Building','~thor_data400::Base::MS_Workers',,true));

liens_file := if(fileservices.getsuperfilesubcount('~thor_data400::base::LiensHeader_Building')>0,
output('Nothing added to base::LiensHeader_Building'),
fileservices.addsuperfile('~thor_data400::base::LiensHeader_Building','~thor_data400::base::liens',,true));

utils := if(fileservices.getsuperfilesubcount('~thor_data400::Base::UtilityHeader_Building')>0,
output('Nothing added to Base::UtilityHeader_Building'),
fileservices.addsuperfile('~thor_data400::Base::UtilityHeader_Building','~thor_data400::Base::Utility_File',,true));

bksrch := if(fileservices.getsuperfilesubcount('~thor_data400::Base::BKSrcHeader_Building')>0,
output('Nothing added to Base::BKSrcHeader_Building'),
fileservices.addsuperfile('~thor_data400::Base::BKSrcHeader_Building','~thor_data400::Base::Bankrupt_Search',,true));

bkmain := if(fileservices.getsuperfilesubcount('~thor_data400::Base::BkMnHeader_Building')>0,
output('Nothing added to Base::BkMnHeader_Building'),
fileservices.addsuperfile('~thor_data400::Base::BkMnHeader_Building','~thor_data400::Base::Bankrupt_Main',,true));

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
fileservices.addsuperfile('~thor_data400::Base::DeathHeader_Building','~thor_data400::Base::Death_Master',,true));

gong_file := if(fileservices.getsuperfilesubcount('~thor_data400::Base::GongHeader_Building')>0,
output('Nothing added to Base::GongHeader_Building'),
fileservices.addsuperfile('~thor_data400::Base::GongHeader_Building','~thor_data400::base::gong'));

for_file := if(fileservices.getsuperfilesubcount('~thor_data400::Base::ForeclosureHeader_Building')>0,
output('Nothing added to Base::ForeclosureHeader_Building'),
fileservices.addsuperfile('~thor_data400::Base::ForeclosureHeader_Building','~thor_data400::BASE::foreclosure'));

airm_file := if(fileservices.getsuperfilesubcount('~thor_data400::Base::AirmenHeader_Building')>0,
output('Nothing added to Base::AirmenHeader_Building'),
fileservices.addsuperfile('~thor_data400::Base::AirmenHeader_Building','~thor_data400::base::faa_airmen_BUILT'));

airc_file := if(fileservices.getsuperfilesubcount('~thor_data400::Base::AircraftHeader_Building')>0,
output('Nothing added to Base::AircraftHeader_Building'),
fileservices.addsuperfile('~thor_data400::Base::AircraftHeader_Building','~thor_data400::base::faa_aircraft_reg_built'));

boat_file := if(fileservices.getsuperfilesubcount('~thor_data400::Base::BoatHeader_Building')>0,
output('Nothing added to Base::BoatHeader_Building'),
fileservices.addsuperfile('~thor_data400::Base::BoatHeader_Building','~thor_data400::in::emerges_boats_20050225'));

waterSrch_file := if(fileservices.getsuperfilesubcount('~thor_data400::Base::WatercraftSrchHeader_Building')>0,
output('Nothing added to Base::WatercraftSrchHeader_Building'),
fileservices.addsuperfile('~thor_data400::Base::WatercraftSrchHeader_Building',Watercraft.Cluster + 'base::watercraft_search_' + Watercraft.Version_Production));

waterMain_file := if(fileservices.getsuperfilesubcount('~thor_data400::Base::WatercraftMainHeader_Building')>0,
output('Nothing added to Base::WatercraftMainHeader_Building'),
fileservices.addsuperfile('~thor_data400::Base::WatercraftMainHeader_Building',Watercraft.Cluster + 'base::watercraft_main_' + Watercraft.Version_Production));

dea_file := if(fileservices.getsuperfilesubcount('~thor_data400::Base::DeaHeader_Building')>0,
output('Nothing added to Base::DeaHeader_Building'),
fileservices.addsuperfile('~thor_data400::Base::DeaHeader_Building','~thor_data400::in::dea'));

LN_prop_deeds := if(fileservices.getsuperfilesubcount('~thor_data400::BASE::LN_PropDeedHeader_Building')>0,
output('Nothing added to BASE::LN_PropDeedHeader_Building'),
fileservices.addsuperfile('~thor_data400::BASE::LN_PropDeedHeader_Building','~thor_data400::base::property_deed',,true));

LN_prop_asses := if(fileservices.getsuperfilesubcount('~thor_data400::BASE::LN_PropAssessHeader_Building')>0,
output('Nothing added to BASE::LN_PropAssesHeader_Building'),
fileservices.addsuperfile('~thor_data400::BASE::LN_PropAssessHeader_Building','~thor_data400::base::property_assessor',,true));

LN_prop_srch := if(fileservices.getsuperfilesubcount('~thor_data400::BASE::LN_PropSrchHeader_Building')>0,
output('Nothing added to BASE::LN_PropSrchHeader_Building'),
fileservices.addsuperfile('~thor_data400::BASE::LN_PropSrchHeader_Building','~thor_data400::base::property_search',,true));

add_super := parallel(dl_file,vehs,emrg,akPerm,akPermE,atf_file,proflic_file,death_file,gong_file,
					ms_work,liens_file,utils,bksrch,bkmain,prop_deeds,prop_asses,prop_srch,
					for_file,airm_file,airc_file,boat_file,waterSrch_file,waterMain_file,dea_file,ln_prop_deeds,
					ln_prop_asses,ln_prop_srch);


export Inputs_Set := add_super;