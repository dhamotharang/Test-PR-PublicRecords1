IMPORT Civ_Court, ut, Data_Services;

EXPORT Files_In_CA_Kern := MODULE

	EXPORT civil	:= dataset(Data_Services.foreign_prod +'thor_data400::in::civil::ca_kern', Civ_Court.Layouts_In_CA_Kern.Civil_In,csv(heading(1), separator(['\t'])));
  EXPORT civil_new	:= dataset(Data_Services.foreign_prod +'thor_data400::in::civil::ca_kern_new', Civ_Court.Layouts_In_CA_Kern.Civil_In_New,csv(heading(1), separator([',']),quote('"')));	
	EXPORT case_category	:= dataset(Data_Services.foreign_prod +'thor_data400::in::civil::kern_cty_case_category.lkp', Civ_Court.Layouts_In_CA_Kern.code_lkp,csv(heading(0), separator(['\t'])));
	EXPORT case_type	:= dataset(Data_Services.foreign_prod +'thor_data400::in::civil::kern_cty_case_type.lkp',Civ_Court.Layouts_In_CA_Kern.code_lkp,csv(heading(0), separator(['\t'])));
	EXPORT party_type	:= dataset(Data_Services.foreign_prod +'thor_data400::in::civil::kern_cty_party_types.lkp',Civ_Court.Layouts_In_CA_Kern.party_type_lkp,csv(heading(0), separator(['\t'])));

END;