/*     ----- CREATING BASE SUPERFILES -----   */
import outwardmedia, ut;
IF(FileServices.SuperFileExists(OutwardMedia.cluster+'in::outwardmedia'), OUTPUT('File exists'),
			FileServices.CreateSuperFile(OutwardMedia.cluster+'in::outwardmedia'));

// IF(FileServices.SuperFileExists(OutwardMedia.cluster+'base::outwardmedia'), OUTPUT('File exists'),
			// FileServices.CreateSuperFile(OutwardMedia.cluster+'base::outwardmedia'));
IF(FileServices.SuperFileExists(OutwardMedia.cluster+'base::outwardmedia_delete'), OUTPUT('File exists'),
			FileServices.CreateSuperFile(OutwardMedia.cluster+'base::outwardmedia_delete'));
IF(FileServices.SuperFileExists(OutwardMedia.cluster+'base::outwardmedia_father'), OUTPUT('File exists'),
			FileServices.CreateSuperFile(OutwardMedia.cluster+'base::outwardmedia_father'));
IF(FileServices.SuperFileExists(OutwardMedia.cluster+'base::outwardmedia_grandfather'), OUTPUT('File exists'),
			FileServices.CreateSuperFile(OutwardMedia.cluster+'base::outwardmedia_grandfather'));

IF(FileServices.SuperFileExists(OutwardMedia.cluster+'key::outwardmedia::autokey::Payload_Built'),  OUTPUT('File exists'),
				FileServices.CreateSuperFile(OutwardMedia.cluster+'key::outwardmedia::autokey::Payload_Built'));
IF(FileServices.SuperFileExists( OutwardMedia.cluster+'key::outwardmedia::autokey::Payload_QA'),  OUTPUT('File exists'),
				FileServices.CreateSuperFile(OutwardMedia.cluster+'key::outwardmedia::autokey::Payload_QA'));
IF(FileServices.SuperFileExists(OutwardMedia.cluster+'key::outwardmedia::autokey::Payload_GRANDFATHER'), OUTPUT('File exists'),
				FileServices.CreateSuperFile(OutwardMedia.cluster+'key::outwardmedia::autokey::Payload_GRANDFATHER'));
IF(FileServices.SuperFileExists(OutwardMedia.cluster+'key::outwardmedia::autokey::Payload_FATHER'),  OUTPUT('File exists'),
				FileServices.CreateSuperFile(OutwardMedia.cluster+'key::outwardmedia::autokey::Payload_FATHER'));
				

IF(FileServices.SuperFileExists(OutwardMedia.cluster+'key::outwardmedia::autokey::Address_built'), OUTPUT('File exists'),
				FileServices.CreateSuperFile(OutwardMedia.cluster+'key::outwardmedia::autokey::Address_built'));
IF(FileServices.SuperFileExists(OutwardMedia.cluster+'key::outwardmedia::autokey::Address_QA'), 		OUTPUT('File exists'),
				FileServices.CreateSuperFile(OutwardMedia.cluster+'key::outwardmedia::autokey::Address_QA'));
IF(FileServices.SuperFileExists(OutwardMedia.cluster+'key::outwardmedia::autokey::Address_GrandFather'), OUTPUT('File exists'),
				FileServices.CreateSuperFile(OutwardMedia.cluster+'key::outwardmedia::autokey::Address_GrandFather')); 
IF(FileServices.SuperFileExists(OutwardMedia.cluster+'key::outwardmedia::autokey::Address_Father'), OUTPUT('File exists'),
				FileServices.CreateSuperFile(OutwardMedia.cluster+'key::outwardmedia::autokey::Address_Father')); 

IF(FileServices.SuperFileExists(OutwardMedia.cluster+'key::outwardmedia::autokey::CityStName_built'), OUTPUT('File exists'),
				FileServices.CreateSuperFile(OutwardMedia.cluster+'key::outwardmedia::autokey::CityStName_built'));
IF(FileServices.SuperFileExists(OutwardMedia.cluster+'key::outwardmedia::autokey::CityStName_QA'), 		OUTPUT('File exists'),
				FileServices.CreateSuperFile(OutwardMedia.cluster+'key::outwardmedia::autokey::CityStName_QA'));
IF(FileServices.SuperFileExists(OutwardMedia.cluster+'key::outwardmedia::autokey::CityStName_GrandFather'), 		OUTPUT('File exists'),
				FileServices.CreateSuperFile(OutwardMedia.cluster+'key::outwardmedia::autokey::CityStName_GrandFather'));
IF(FileServices.SuperFileExists(OutwardMedia.cluster+'key::outwardmedia::autokey::CityStName_Father'), 		OUTPUT('File exists'),
				FileServices.CreateSuperFile(OutwardMedia.cluster+'key::outwardmedia::autokey::CityStName_Father'));

IF(FileServices.SuperFileExists(OutwardMedia.cluster+'key::outwardmedia::autokey::Name_built'), OUTPUT('File exists'),
				FileServices.CreateSuperFile(OutwardMedia.cluster+'key::outwardmedia::autokey::Name_built'));
IF(FileServices.SuperFileExists(OutwardMedia.cluster+'key::outwardmedia::autokey::Name_QA'), 		OUTPUT('File exists'),
				FileServices.CreateSuperFile(OutwardMedia.cluster+'key::outwardmedia::autokey::Name_QA'));
IF(FileServices.SuperFileExists(OutwardMedia.cluster+'key::outwardmedia::autokey::Name_GrandFather'), 		OUTPUT('File exists'),
				FileServices.CreateSuperFile(OutwardMedia.cluster+'key::outwardmedia::autokey::Name_GrandFather'));
IF(FileServices.SuperFileExists(OutwardMedia.cluster+'key::outwardmedia::autokey::Name_Father'), 		OUTPUT('File exists'),
				FileServices.CreateSuperFile(OutwardMedia.cluster+'key::outwardmedia::autokey::Name_Father'));

IF(FileServices.SuperFileExists(OutwardMedia.cluster+'key::outwardmedia::autokey::Phone2_built'), OUTPUT('File exists'),
				FileServices.CreateSuperFile(OutwardMedia.cluster+'key::outwardmedia::autokey::Phone2_built'));
IF(FileServices.SuperFileExists(OutwardMedia.cluster+'key::outwardmedia::autokey::Phone2_QA'), 		OUTPUT('File exists'),
				FileServices.CreateSuperFile(OutwardMedia.cluster+'key::outwardmedia::autokey::Phone2_QA'));
IF(FileServices.SuperFileExists(OutwardMedia.cluster+'key::outwardmedia::autokey::Phone2_Father'), 		OUTPUT('File exists'),
				FileServices.CreateSuperFile(OutwardMedia.cluster+'key::outwardmedia::autokey::Phone2_Father'));
IF(FileServices.SuperFileExists(OutwardMedia.cluster+'key::outwardmedia::autokey::Phone2_GrandFather'), 		OUTPUT('File exists'),
				FileServices.CreateSuperFile(OutwardMedia.cluster+'key::outwardmedia::autokey::Phone2_GrandFather'));
				
IF(FileServices.SuperFileExists(OutwardMedia.cluster+'key::outwardmedia::autokey::StName_built'), OUTPUT('File exists'),
				FileServices.CreateSuperFile(OutwardMedia.cluster+'key::outwardmedia::autokey::StName_built'));
IF(FileServices.SuperFileExists(OutwardMedia.cluster+'key::outwardmedia::autokey::StName_QA'), 		OUTPUT('File exists'),
				FileServices.CreateSuperFile(OutwardMedia.cluster+'key::outwardmedia::autokey::StName_QA'));
IF(FileServices.SuperFileExists(OutwardMedia.cluster+'key::outwardmedia::autokey::StName_Father'), 		OUTPUT('File exists'),
				FileServices.CreateSuperFile(OutwardMedia.cluster+'key::outwardmedia::autokey::StName_Father'));
IF(FileServices.SuperFileExists(OutwardMedia.cluster+'key::outwardmedia::autokey::StName_GrandFather'), 		OUTPUT('File exists'),
				FileServices.CreateSuperFile(OutwardMedia.cluster+'key::outwardmedia::autokey::StName_GrandFather'));
				
IF(FileServices.SuperFileExists(OutwardMedia.cluster+'key::outwardmedia::autokey::Zip_built'), OUTPUT('File exists'),
				FileServices.CreateSuperFile(OutwardMedia.cluster+'key::outwardmedia::autokey::Zip_built'));				
IF(FileServices.SuperFileExists(OutwardMedia.cluster+'key::outwardmedia::autokey::Zip_QA'), 		OUTPUT('File exists'),
				FileServices.CreateSuperFile(OutwardMedia.cluster+'key::outwardmedia::autokey::Zip_QA'));
IF(FileServices.SuperFileExists(OutwardMedia.cluster+'key::outwardmedia::autokey::Zip_Father'), 		OUTPUT('File exists'),
				FileServices.CreateSuperFile(OutwardMedia.cluster+'key::outwardmedia::autokey::Zip_Father'));
IF(FileServices.SuperFileExists(OutwardMedia.cluster+'key::outwardmedia::autokey::Zip_GrandFather'), 		OUTPUT('File exists'),
				FileServices.CreateSuperFile(OutwardMedia.cluster+'key::outwardmedia::autokey::Zip_GrandFather'));
				
IF(FileServices.SuperFileExists(OutwardMedia.cluster+'key::outwardmedia::autokey::SSN2_BUILT'), 		OUTPUT('File exists'),
				FileServices.CreateSuperFile(OutwardMedia.cluster+'key::outwardmedia::autokey::SSN2_BUILT'));
IF(FileServices.SuperFileExists(OutwardMedia.cluster+'key::outwardmedia::autokey::SSN2_QA'), 		OUTPUT('File exists'),
				FileServices.CreateSuperFile(OutwardMedia.cluster+'key::outwardmedia::autokey::SSN2_QA'));
				
IF(FileServices.SuperFileExists(OutwardMedia.cluster+'key::outwardmedia::autokey::AddressB2_BUILT'), 		OUTPUT('File exists'),
				FileServices.CreateSuperFile(OutwardMedia.cluster+'key::outwardmedia::autokey::AddressB2_BUILT'));
IF(FileServices.SuperFileExists(OutwardMedia.cluster+'key::outwardmedia::autokey::AddressB2_QA'), 		OUTPUT('File exists'),
				FileServices.CreateSuperFile(OutwardMedia.cluster+'key::outwardmedia::autokey::AddressB2_QA'));

IF(FileServices.SuperFileExists(OutwardMedia.cluster+'key::outwardmedia::autokey::CityStNameB2_BUILT'), 		OUTPUT('File exists'),
				FileServices.CreateSuperFile(OutwardMedia.cluster+'key::outwardmedia::autokey::CityStNameB2_BUILT'));
IF(FileServices.SuperFileExists(OutwardMedia.cluster+'key::outwardmedia::autokey::CityStNameB2_QA'), 		OUTPUT('File exists'),
				FileServices.CreateSuperFile(OutwardMedia.cluster+'key::outwardmedia::autokey::CityStNameB2_QA'));

IF(FileServices.SuperFileExists(OutwardMedia.cluster+'key::outwardmedia::autokey::PhoneB2_BUILT'), 		OUTPUT('File exists'),
				FileServices.CreateSuperFile(OutwardMedia.cluster+'key::outwardmedia::autokey::PhoneB2_BUILT'));
IF(FileServices.SuperFileExists(OutwardMedia.cluster+'key::outwardmedia::autokey::PhoneB2_QA'), 		OUTPUT('File exists'),
				FileServices.CreateSuperFile(OutwardMedia.cluster+'key::outwardmedia::autokey::PhoneB2_QA'));
				
IF(FileServices.SuperFileExists(OutwardMedia.cluster+'key::outwardmedia::autokey::StNameB2_BUILT'), 		OUTPUT('File exists'),
				FileServices.CreateSuperFile(OutwardMedia.cluster+'key::outwardmedia::autokey::StNameB2_BUILT'));
IF(FileServices.SuperFileExists(OutwardMedia.cluster+'key::outwardmedia::autokey::StNameB2_QA'), 		OUTPUT('File exists'),
				FileServices.CreateSuperFile(OutwardMedia.cluster+'key::outwardmedia::autokey::StNameB2_QA'));
				
IF(FileServices.SuperFileExists(OutwardMedia.cluster+'key::outwardmedia::autokey::ZipB2_BUILT'), 		OUTPUT('File exists'),
				FileServices.CreateSuperFile(OutwardMedia.cluster+'key::outwardmedia::autokey::ZipB2_BUILT'));
IF(FileServices.SuperFileExists(OutwardMedia.cluster+'key::outwardmedia::autokey::ZipB2_QA'), 		OUTPUT('File exists'),
				FileServices.CreateSuperFile(OutwardMedia.cluster+'key::outwardmedia::autokey::ZipB2_QA'));

IF(FileServices.SuperFileExists(OutwardMedia.cluster+'key::outwardmedia::autokey::FEIN2_BUILT'), 		OUTPUT('File exists'),
				FileServices.CreateSuperFile(OutwardMedia.cluster+'key::outwardmedia::autokey::FEIN2_built'));
IF(FileServices.SuperFileExists(OutwardMedia.cluster+'key::outwardmedia::autokey::FEIN2_QA'), 		OUTPUT('File exists'),
				FileServices.CreateSuperFile(OutwardMedia.cluster+'key::outwardmedia::autokey::FEIN2_QA'));

IF(FileServices.SuperFileExists(OutwardMedia.cluster+'key::outwardmedia::autokey::NameWords2_BUILT'), 		OUTPUT('File exists'),
				FileServices.CreateSuperFile(OutwardMedia.cluster+'key::outwardmedia::autokey::NameWords2_BUILT'));
IF(FileServices.SuperFileExists(OutwardMedia.cluster+'key::outwardmedia::autokey::NameWords2_QA'), 		OUTPUT('File exists'),
				FileServices.CreateSuperFile(OutwardMedia.cluster+'key::outwardmedia::autokey::NameWords2_QA'));
				
IF(FileServices.SuperFileExists(OutwardMedia.cluster+'key::outwardmedia::autokey::NameB2_BUILT'), 		OUTPUT('File exists'),
				FileServices.CreateSuperFile(OutwardMedia.cluster+'key::outwardmedia::autokey::NameB2_BUILT'));
IF(FileServices.SuperFileExists(OutwardMedia.cluster+'key::outwardmedia::autokey::NameB2_QA'), 		OUTPUT('File exists'),
				FileServices.CreateSuperFile(OutwardMedia.cluster+'key::outwardmedia::autokey::NameB2_QA'));