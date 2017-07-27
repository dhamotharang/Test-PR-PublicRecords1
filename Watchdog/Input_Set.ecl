prop_deeds := if(fileservices.getsuperfilesubcount('~thor_data400::BASE::PropDeedHeader_Building')>0,
output('Nothing added to BASE::PropDeedHeader_Building'),
fileservices.addsuperfile('~thor_data400::BASE::PropDeedHeader_Building','~thor_data400::base::fares_1080',,true));

prop_asses := if(fileservices.getsuperfilesubcount('~thor_data400::BASE::PropAssesHeader_Building')>0,
output('Nothing added to BASE::PropAssesHeader_Building'),
fileservices.addsuperfile('~thor_data400::BASE::PropAssesHeader_Building','~thor_data400::base::fares_2580',,true));

prop_srch := if(fileservices.getsuperfilesubcount('~thor_data400::BASE::PropSrchHeader_Building')>0,
output('Nothing added to BASE::PropSrchHeader_Building'),
fileservices.addsuperfile('~thor_data400::BASE::PropSrchHeader_Building','~thor_data400::in::fares_search',,true));

utils := if(fileservices.getsuperfilesubcount('~thor_data400::Base::UtilityHeader_Building')>0,
output('Nothing added to Base::UtilityHeader_Building'),
fileservices.addsuperfile('~thor_data400::Base::UtilityHeader_Building','~thor_data400::Base::Utility_File',,true));


export Input_Set := parallel(prop_deeds,prop_asses,prop_srch,utils);