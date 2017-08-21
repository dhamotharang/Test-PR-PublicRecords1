//Nationwide Mortgage Licensing System Professional Licenses Files for MARI


export files_NMLS0900 := MODULE
	export branch := dataset('~thor_data400::in::proflic_mari::NMLS::Branch',Prof_License_Mari.layouts_NMLS0900.Branch,csv(SEPARATOR(','),QUOTE('"'),heading(1)));
	export branch_lic := dataset('~thor_data400::in::proflic_mari::NMLS::Branch_License',Prof_License_Mari.layouts_NMLS0900.Branch_Lic,csv(SEPARATOR(','),QUOTE('"'),heading(1)));
	export branch_dba := dataset('~thor_data400::in::proflic_mari::NMLS::Branch_DBA',Prof_License_Mari.layouts_NMLS0900.Branch_DBA,csv(SEPARATOR(','),QUOTE('"'),heading(1)));
	export business := dataset('~thor_data400::in::proflic_mari::NMLS::Company',Prof_License_Mari.layouts_NMLS0900.Business,csv(SEPARATOR(','),QUOTE('"'),heading(1)));
	export business_lic := dataset('~thor_data400::in::proflic_mari::NMLS::Company_License',Prof_License_Mari.layouts_NMLS0900.Business_Lic,csv(SEPARATOR(','),QUOTE('"'),heading(1)));
	export business_dba := dataset('~thor_data400::in::proflic_mari::NMLS::Company_DBA',Prof_License_Mari.layouts_NMLS0900.Business_DBA,csv(SEPARATOR(','),QUOTE('"'),heading(1)));
	export individual := dataset('~thor_data400::in::proflic_mari::NMLS::Individual',Prof_License_Mari.layouts_NMLS0900.Individual,csv(SEPARATOR(','),QUOTE('"'),heading(1)));
	export individual_lic := dataset('~thor_data400::in::proflic_mari::NMLS::Individual_License',Prof_License_Mari.layouts_NMLS0900.Individual_Lic,csv(SEPARATOR(','),QUOTE('"'),heading(1)));
	export location := dataset('~thor_data400::in::proflic_mari::NMLS::Individual_Location',Prof_License_Mari.layouts_NMLS0900.Individual_Location,csv(SEPARATOR(','),QUOTE('"'),heading(1)));
	export individual_aka	:= dataset('~thor_data400::in::proflic_mari::NMLS::Individual_AKA',Prof_License_Mari.layouts_NMLS0900.Individual_AKA,csv(SEPARATOR(','),QUOTE('"'),heading(1)));
	export individual_reg	:= dataset('~thor_data400::in::proflic_mari::NMLS::Individual_Registration',Prof_License_Mari.layouts_NMLS0900.Indv_Registration,csv(SEPARATOR(','),QUOTE('"'),heading(1)));
	export individual_regdetail	:= dataset('~thor_data400::in::proflic_mari::NMLS::Individual_Reg_Detail',Prof_License_Mari.layouts_NMLS0900.Indv_RegDetail,csv(SEPARATOR(','),QUOTE('"'),heading(1)));
	export sponsorship := dataset('~thor_data400::in::proflic_mari::NMLS::Individual_Sponsorship',Prof_License_Mari.layouts_NMLS0900.Sponsorship,csv(SEPARATOR(','),QUOTE('"'),heading(1)));
	export regulatory := dataset('~thor_data400::in::proflic_mari::NMLS::regulatory_actions',Prof_License_Mari.layouts_NMLS0900.Regulatory,csv(SEPARATOR(','),QUOTE('"'),heading(1)));
	export disciplinary := dataset('~thor_data400::in::proflic_mari::nmls::individual_disciplinary_actions',Prof_License_Mari.layouts_NMLS0900.Individual_Disciplinary_Action,csv(SEPARATOR(','),QUOTE('"'),heading(1)));
	
END;		

