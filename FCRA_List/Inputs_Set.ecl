import lib_fileservices;

proflic_mari_file := if(fileservices.getsuperfilesubcount('~thor_data400::Base::proflicMarisrchFCRAHeader_Building')>0,
output('Nothing added to Base::proflicMarisrchFCRAHeader_Building'),
fileservices.addsuperfile('~thor_data400::Base::proflicMarisrchFCRAHeader_Building','~thor_data400::base::proflic_mari::search',,true));

proflic_file := if(fileservices.getsuperfilesubcount('~thor_data400::Base::ProfLicFCRAHeader_Building')>0,
output('Nothing added to Base::ProfLicFCRAHeader_Building'),
fileservices.addsuperfile('~thor_data400::Base::ProfLicFCRAHeader_Building','~thor_data400::base::prof_licenses_AID',,true));

gong_file := if(fileservices.getsuperfilesubcount('~thor_data400::Base::GongFCRAHeader_Building')>0,
output('Nothing added to Base::GongFCRAHeader_Building'),
fileservices.addsuperfile('~thor_data400::Base::GongFCRAHeader_Building','~thor_data400::base::gong_history',,true));

waterSrch_file := if(fileservices.getsuperfilesubcount('~thor_data400::Base::WatercraftSrchfcraHeader_Building')>0,
output('Nothing added to Base::WatercraftSrchfcraHeader_Building'),
fileservices.addsuperfile('~thor_data400::Base::WatercraftSrchfcraHeader_Building','~thor_data400::base::watercraft_search',,true));

waterMain_file := if(fileservices.getsuperfilesubcount('~thor_data400::Base::WatercraftMainfcraHeader_Building')>0,
output('Nothing added to Base::WatercraftMainfcraHeader_Building'),
fileservices.addsuperfile('~thor_data400::Base::WatercraftMainfcraHeader_Building','~thor_data400::base::watercraft_main',,true));

waterCG_file := if(fileservices.getsuperfilesubcount('~thor_data400::Base::WatercraftCGfcraHeader_Building')>0,
output('Nothing added to Base::WatercraftCGfcraHeader_Building'),
fileservices.addsuperfile('~thor_data400::Base::WatercraftCGfcraHeader_Building','~thor_data400::base::watercraft_coastguard',,true));

InfutorCID_file := if(fileservices.getsuperfilesubcount('~thor_data400::Base::InfutorCIDFCRAHeader_Building')>0,
output('Nothing added to Base::InfutorCIDFCRAHeader_Building'),
fileservices.addsuperfile('~thor_data400::Base::InfutorCIDFCRAHeader_Building','~thor_data400::base::infutorcid',,true));

ImpulseEmail_file := if(fileservices.getsuperfilesubcount('~thor_data400::Base::ImpulseEmailFCRAHeader_Building')>0,
output('Nothing added to Base::ImpulseEmailFCRAHeader_Building'),
fileservices.addsuperfile('~thor_data400::Base::ImpulseEmailFCRAHeader_Building','~thor_data400::base::impulse_email',,true));

CNLDPractitioner_file := if(fileservices.getsuperfilesubcount('~thor_data400::Base::CNLDPractitionerFCRAHeader_Building')>0,
output('Nothing added to Base::CNLDPractitionerFCRAHeader_Building'),
fileservices.addsuperfile('~thor_data400::Base::CNLDPractitionerFCRAHeader_Building','~thor_data400::temp::cnld_practitioner::built::data',,true));

NCPDP_file := if(fileservices.getsuperfilesubcount('~thor_data400::Base::NCPDPFCRAHeader_Building')>0,
output('Nothing added to Base::NCPDPFCRAHeader_Building'),
fileservices.addsuperfile('~thor_data400::Base::NCPDPFCRAHeader_Building','~thor_data400::base::ncpdp::keybuild_file::built::data',,true));


add_super := parallel(
																proflic_mari_file
                                ,proflic_file
																,gong_file
                                ,waterSrch_file
																,waterMain_file
																,waterCG_file
																,InfutorCID_file
                               // ,ImpulseEmail_file
                                ,CNLDPractitioner_file
                                ,NCPDP_file);
									
export Inputs_Set := add_super;
