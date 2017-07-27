import digssoff;
EXPORT create_superfile := 


 Parallel(digssoff.SuperFile_Functions.Fun_createSuperfile('~thor_Data400::base::Facility_list'),
	        digssoff.SuperFile_Functions.Fun_createSuperfile('~thor_Data400::base::Facility_list_father'),
					digssoff.SuperFile_Functions.Fun_createSuperfile('~thor_Data400::base::Facility_list_delete'),
					digssoff.SuperFile_Functions.Fun_createSuperfile('~thor_200::key::ERO::QA::Facility_address'),
					digssoff.SuperFile_Functions.Fun_createSuperfile('~thor_200::key::ERO::FATHER::Facility_address'),
					digssoff.SuperFile_Functions.Fun_createSuperfile('~thor_200::key::ERO::GRANDFATHER::Facility_address')
	        												   );