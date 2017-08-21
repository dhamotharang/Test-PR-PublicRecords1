IF(FileServices.SuperFileExists('~thor_data400::base::AlloyMedia_student_list'), OUTPUT('File exists'),FileServices.CreateSuperFile('~thor_data400::base::AlloyMedia_student_list'));
IF(FileServices.SuperFileExists('~thor_data400::base::AlloyMedia_student_list_father'), OUTPUT('File exists'),FileServices.CreateSuperFile('~thor_data400::base::AlloyMedia_student_list_father'));
IF(FileServices.SuperFileExists('~thor_data400::base::AlloyMedia_student_list_grandfather'), OUTPUT('File exists'),FileServices.CreateSuperFile('~thor_data400::base::AlloyMedia_student_list_grandfather'));
IF(FileServices.SuperFileExists('~thor_data400::base::AlloyMedia_student_list_delete'), OUTPUT('File exists'),FileServices.CreateSuperFile('~thor_data400::base::AlloyMedia_student_list_delete'));

IF(FileServices.SuperFileExists('~thor_data400::key::AlloyMedia_student_list::built::DID'), OUTPUT('File exists'),FileServices.CreateSuperFile('~thor_data400::key::AlloyMedia_student_list::built::DID'));
IF(FileServices.SuperFileExists('~thor_data400::key::AlloyMedia_student_list::delete::DID'), OUTPUT('File exists'),FileServices.CreateSuperFile('~thor_data400::key::AlloyMedia_student_list::delete::DID'));
IF(FileServices.SuperFileExists('~thor_data400::key::AlloyMedia_student_list::father::DID'), OUTPUT('File exists'),FileServices.CreateSuperFile('~thor_data400::key::AlloyMedia_student_list::father::DID'));
IF(FileServices.SuperFileExists('~thor_data400::key::AlloyMedia_student_list::grandfather::DID'), OUTPUT('File exists'),FileServices.CreateSuperFile('~thor_data400::key::AlloyMedia_student_list::grandfather::DID'));
IF(FileServices.SuperFileExists('~thor_data400::key::AlloyMedia_student_list::qa::DID'), OUTPUT('File exists'),FileServices.CreateSuperFile('~thor_data400::key::AlloyMedia_student_list::qa::DID'));

IF(FileServices.SuperFileExists('~thor_data400::key::fcra::AlloyMedia_student_list::built::DID'), OUTPUT('File exists'),FileServices.CreateSuperFile('~thor_data400::key::fcra::AlloyMedia_student_list::built::DID'));
IF(FileServices.SuperFileExists('~thor_data400::key::fcra::AlloyMedia_student_list::delete::DID'), OUTPUT('File exists'),FileServices.CreateSuperFile('~thor_data400::key::fcra::AlloyMedia_student_list::delete::DID'));
IF(FileServices.SuperFileExists('~thor_data400::key::fcra::AlloyMedia_student_list::father::DID'), OUTPUT('File exists'),FileServices.CreateSuperFile('~thor_data400::key::fcra::AlloyMedia_student_list::father::DID'));
IF(FileServices.SuperFileExists('~thor_data400::key::fcra::AlloyMedia_student_list::grandfather::DID'), OUTPUT('File exists'),FileServices.CreateSuperFile('~thor_data400::key::fcra::AlloyMedia_student_list::grandfather::DID'));
IF(FileServices.SuperFileExists('~thor_data400::key::fcra::AlloyMedia_student_list::qa::DID'), OUTPUT('File exists'),FileServices.CreateSuperFile('~thor_data400::key::fcra::AlloyMedia_student_list::qa::DID'));

/***** Uncomment for Autokeys *****/
/*
IF(FileServices.SuperFileExists('~thor_data400::key::alloymedia_student_list::autokey::Payload_QA'), OUTPUT('File exists'),FileServices.CreateSuperFile('~thor_data400::key::alloymedia_student_list::autokey::Payload_QA'));
IF(FileServices.SuperFileExists('~thor_data400::key::alloymedia_student_list::autokey::Payload_Built'), OUTPUT('File exists'),FileServices.CreateSuperFile('~thor_data400::key::alloymedia_student_list::autokey::Payload_Built'));
IF(FileServices.SuperFileExists('~thor_data400::key::alloymedia_student_list::autokey::Payload_Delete'), OUTPUT('File exists'),FileServices.CreateSuperFile('~thor_data400::key::alloymedia_student_list::autokey::Payload_Delete'));
IF(FileServices.SuperFileExists('~thor_data400::key::alloymedia_student_list::autokey::Payload_Father'), OUTPUT('File exists'),FileServices.CreateSuperFile('~thor_data400::key::alloymedia_student_list::autokey::Payload_Father'));
IF(FileServices.SuperFileExists('~thor_data400::key::alloymedia_student_list::autokey::Payload_Grandfather'), OUTPUT('File exists'),FileServices.CreateSuperFile('~thor_data400::key::alloymedia_student_list::autokey::Payload_Grandfather'));

IF(FileServices.SuperFileExists('~thor_data400::key::alloymedia_student_list::autokey::Address_QA'), OUTPUT('File exists'),FileServices.CreateSuperFile('~thor_data400::key::alloymedia_student_list::autokey::Address_QA'));
IF(FileServices.SuperFileExists('~thor_data400::key::alloymedia_student_list::autokey::Address_Built'), OUTPUT('File exists'),FileServices.CreateSuperFile('~thor_data400::key::alloymedia_student_list::autokey::Address_Built'));
IF(FileServices.SuperFileExists('~thor_data400::key::alloymedia_student_list::autokey::Address_Delete'), OUTPUT('File exists'),FileServices.CreateSuperFile('~thor_data400::key::alloymedia_student_list::autokey::Address_Delete'));
IF(FileServices.SuperFileExists('~thor_data400::key::alloymedia_student_list::autokey::Address_Father'), OUTPUT('File exists'),FileServices.CreateSuperFile('~thor_data400::key::alloymedia_student_list::autokey::Address_Father'));
IF(FileServices.SuperFileExists('~thor_data400::key::alloymedia_student_list::autokey::Address_Grandfather'), OUTPUT('File exists'),FileServices.CreateSuperFile('~thor_data400::key::alloymedia_student_list::autokey::Address_Grandfather'));

IF(FileServices.SuperFileExists('~thor_data400::key::alloymedia_student_list::autokey::CityStName_QA'), OUTPUT('File exists'),FileServices.CreateSuperFile('~thor_data400::key::alloymedia_student_list::autokey::CityStName_QA'));
IF(FileServices.SuperFileExists('~thor_data400::key::alloymedia_student_list::autokey::CityStName_Built'), OUTPUT('File exists'),FileServices.CreateSuperFile('~thor_data400::key::alloymedia_student_list::autokey::CityStName_Built'));
IF(FileServices.SuperFileExists('~thor_data400::key::alloymedia_student_list::autokey::CityStName_Delete'), OUTPUT('File exists'),FileServices.CreateSuperFile('~thor_data400::key::alloymedia_student_list::autokey::CityStName_Delete'));
IF(FileServices.SuperFileExists('~thor_data400::key::alloymedia_student_list::autokey::CityStName_Father'), OUTPUT('File exists'),FileServices.CreateSuperFile('~thor_data400::key::alloymedia_student_list::autokey::CityStName_Father'));
IF(FileServices.SuperFileExists('~thor_data400::key::alloymedia_student_list::autokey::CityStName_Grandfather'), OUTPUT('File exists'),FileServices.CreateSuperFile('~thor_data400::key::alloymedia_student_list::autokey::CityStName_Grandfather'));

IF(FileServices.SuperFileExists('~thor_data400::key::alloymedia_student_list::autokey::Name_QA'), OUTPUT('File exists'),FileServices.CreateSuperFile('~thor_data400::key::alloymedia_student_list::autokey::Name_QA'));
IF(FileServices.SuperFileExists('~thor_data400::key::alloymedia_student_list::autokey::Name_Built'), OUTPUT('File exists'),FileServices.CreateSuperFile('~thor_data400::key::alloymedia_student_list::autokey::Name_Built'));
IF(FileServices.SuperFileExists('~thor_data400::key::alloymedia_student_list::autokey::Name_Delete'), OUTPUT('File exists'),FileServices.CreateSuperFile('~thor_data400::key::alloymedia_student_list::autokey::Name_Delete'));
IF(FileServices.SuperFileExists('~thor_data400::key::alloymedia_student_list::autokey::Name_Father'), OUTPUT('File exists'),FileServices.CreateSuperFile('~thor_data400::key::alloymedia_student_list::autokey::Name_Father'));
IF(FileServices.SuperFileExists('~thor_data400::key::alloymedia_student_list::autokey::Name_Grandfather'), OUTPUT('File exists'),FileServices.CreateSuperFile('~thor_data400::key::alloymedia_student_list::autokey::Name_Grandfather'));

IF(FileServices.SuperFileExists('~thor_data400::key::alloymedia_student_list::autokey::Phone2_QA'), OUTPUT('File exists'),FileServices.CreateSuperFile('~thor_data400::key::alloymedia_student_list::autokey::Phone2_QA'));
IF(FileServices.SuperFileExists('~thor_data400::key::alloymedia_student_list::autokey::Phone2_Built'), OUTPUT('File exists'),FileServices.CreateSuperFile('~thor_data400::key::alloymedia_student_list::autokey::Phone2_Built'));
IF(FileServices.SuperFileExists('~thor_data400::key::alloymedia_student_list::autokey::Phone2_Delete'), OUTPUT('File exists'),FileServices.CreateSuperFile('~thor_data400::key::alloymedia_student_list::autokey::Phone2_Delete'));
IF(FileServices.SuperFileExists('~thor_data400::key::alloymedia_student_list::autokey::Phone2_Father'), OUTPUT('File exists'),FileServices.CreateSuperFile('~thor_data400::key::alloymedia_student_list::autokey::Phone2_Father'));
IF(FileServices.SuperFileExists('~thor_data400::key::alloymedia_student_list::autokey::Phone2_Grandfather'), OUTPUT('File exists'),FileServices.CreateSuperFile('~thor_data400::key::alloymedia_student_list::autokey::Phone2_Grandfather'));

IF(FileServices.SuperFileExists('~thor_data400::key::alloymedia_student_list::autokey::Stname_QA'), OUTPUT('File exists'),FileServices.CreateSuperFile('~thor_data400::key::alloymedia_student_list::autokey::Stname_QA'));
IF(FileServices.SuperFileExists('~thor_data400::key::alloymedia_student_list::autokey::Stname_Built'), OUTPUT('File exists'),FileServices.CreateSuperFile('~thor_data400::key::alloymedia_student_list::autokey::Stname_Built'));
IF(FileServices.SuperFileExists('~thor_data400::key::alloymedia_student_list::autokey::Stname_Delete'), OUTPUT('File exists'),FileServices.CreateSuperFile('~thor_data400::key::alloymedia_student_list::autokey::Stname_Delete'));
IF(FileServices.SuperFileExists('~thor_data400::key::alloymedia_student_list::autokey::Stname_Father'), OUTPUT('File exists'),FileServices.CreateSuperFile('~thor_data400::key::alloymedia_student_list::autokey::Stname_Father'));
IF(FileServices.SuperFileExists('~thor_data400::key::alloymedia_student_list::autokey::Stname_Grandfather'), OUTPUT('File exists'),FileServices.CreateSuperFile('~thor_data400::key::alloymedia_student_list::autokey::Stname_Grandfather'));

IF(FileServices.SuperFileExists('~thor_data400::key::alloymedia_student_list::autokey::Zip_QA'), OUTPUT('File exists'),FileServices.CreateSuperFile('~thor_data400::key::alloymedia_student_list::autokey::Zip_QA'));
IF(FileServices.SuperFileExists('~thor_data400::key::alloymedia_student_list::autokey::Zip_Built'), OUTPUT('File exists'),FileServices.CreateSuperFile('~thor_data400::key::alloymedia_student_list::autokey::Zip_Built'));
IF(FileServices.SuperFileExists('~thor_data400::key::alloymedia_student_list::autokey::Zip_Delete'), OUTPUT('File exists'),FileServices.CreateSuperFile('~thor_data400::key::alloymedia_student_list::autokey::Zip_Delete'));
IF(FileServices.SuperFileExists('~thor_data400::key::alloymedia_student_list::autokey::Zip_Father'), OUTPUT('File exists'),FileServices.CreateSuperFile('~thor_data400::key::alloymedia_student_list::autokey::Zip_Father'));
IF(FileServices.SuperFileExists('~thor_data400::key::alloymedia_student_list::autokey::Zip_Grandfather'), OUTPUT('File exists'),FileServices.CreateSuperFile('~thor_data400::key::alloymedia_student_list::autokey::Zip_Grandfather'));
*/