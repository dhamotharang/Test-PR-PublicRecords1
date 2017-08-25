import lib_fileservices;

proflic_file := if(fileservices.getsuperfilesubcount('~thor_data400::Base::ProfLicFCRAHeader_Building')>0,
output('Nothing added to Base::ProfLicFCRAHeader_Building'),
fileservices.addsuperfile('~thor_data400::Base::ProfLicFCRAHeader_Building','~thor_data400::base::prof_licenses_AID',,true));

add_super := proflic_file;

export Inputs_Set := add_super;
