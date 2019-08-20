import ut, Enclarity, tools;

EXPORT Files(STRING pversion = '', boolean pUseProd = false) := MODULE

   /* Input File Versions */
  export collapse_input  		:= dataset(Filenames(pversion,pUseProd).collapse_lInputTemplate, layouts.collapse_Input, csv(separator('|'),quote('')),opt);
  export split_input  			:= dataset(Filenames(pversion,pUseProd).split_lInputTemplate, layouts.split_Input, csv(separator('|'),quote('')),opt);
  export drop_input  				:= dataset(Filenames(pversion,pUseProd).drop_lInputTemplate, layouts.drop_Input, csv(separator('|'),quote('')),opt);
  export facility_input  		:= dataset(Filenames(pversion,pUseProd).facility_lInputTemplate, layouts.facility_Input, csv(separator('|'),quote('')));
	export facility_history   := dataset(Filenames(pversion,pUseProd).facility_lInputHistTemplate, layouts.facility_Input, csv(separator('|'),quote('')));
	export individual_input 	:= dataset(Filenames(pversion,pUseProd).individual_lInputTemplate, layouts.individual_Input, csv(separator('|'),quote('')));
	export individual_history := dataset(Filenames(pversion,pUseProd).individual_lInputHistTemplate, layouts.individual_Input, csv(separator('|'),quote('')));
	export associate_input  	:= dataset(Filenames(pversion,pUseProd).associate_lInputTemplate, layouts.associate_Input, csv(separator('|'),quote('')));
	export associate_history  := dataset(Filenames(pversion,pUseProd).associate_lInputHistTemplate, layouts.associate_Input, csv(separator('|'),quote('')));
  export address_input    	:= dataset(Filenames(pversion,pUseProd).address_lInputTemplate, layouts.address_Input, csv(separator('|'),quote('')));
  export address_history    := dataset(Filenames(pversion,pUseProd).address_lInputHistTemplate, layouts.address_Input, csv(separator('|'),quote('')));	
  export dea_input 					:= dataset(Filenames(pversion,pUseProd).dea_lInputTemplate, layouts.dea_Input, csv(separator('|'),quote('')));
  export dea_history 				:= dataset(Filenames(pversion,pUseProd).dea_lInputHistTemplate, layouts.dea_Input, csv(separator('|'),quote('')));
  export license_input 			:= dataset(Filenames(pversion,pUseProd).license_lInputTemplate, layouts.license_Input, csv(separator('|'),quote('')));
  export license_history 		:= dataset(Filenames(pversion,pUseProd).license_lInputHistTemplate, layouts.license_Input, csv(separator('|'),quote('')));
  export taxonomy_input 		:= dataset(Filenames(pversion,pUseProd).taxonomy_lInputTemplate, layouts.taxonomy_Input, csv(separator('|'),quote('')));
  export taxonomy_history 	:= dataset(Filenames(pversion,pUseProd).taxonomy_lInputHistTemplate, layouts.taxonomy_Input, csv(separator('|'),quote('')));
  export npi_input 					:= dataset(Filenames(pversion,pUseProd).npi_lInputTemplate, layouts.npi_Input, csv(separator('|'),quote('')));
  export npi_history 				:= dataset(Filenames(pversion,pUseProd).npi_lInputHistTemplate, layouts.npi_Input, csv(separator('|'),quote('')));
  export medschool_input  	:= dataset(Filenames(pversion,pUseProd).medschool_lInputTemplate, layouts.medschool_Input, csv(separator('|'),quote('')));
	export medschool_history  := dataset(Filenames(pversion,pUseProd).medschool_lInputHistTemplate, layouts.medschool_Input, csv(separator('|'),quote('')));
	export tax_codes_input   	:= dataset(Filenames(pversion,pUseProd).tax_codes_lInputTemplate, layouts.tax_codes_Input, csv(separator('|'),quote('')));
	export tax_codes_history  := dataset(Filenames(pversion,pUseProd).tax_codes_lInputHistTemplate, layouts.tax_codes_Input, csv(separator('|'),quote('')));	
  export prov_ssn_input			:= dataset(Filenames(pversion,pUseProd).prov_ssn_lInputTemplate, layouts.prov_ssn_Input, csv(separator('|'),quote('')),opt);
  export prov_ssn_history		:= dataset(Filenames(pversion,pUseProd).prov_ssn_lInputHistTemplate, layouts.prov_ssn_Input, csv(separator('|'),quote('')));
  export specialty_input  	:= dataset(Filenames(pversion,pUseProd).specialty_lInputTemplate, layouts.specialty_Input, csv(separator('|'),quote('')));
  export specialty_history  := dataset(Filenames(pversion,pUseProd).specialty_lInputHistTemplate, layouts.specialty_Input, csv(separator('|'),quote('')));
  export sanc_prov_type_input  := dataset(Filenames(pversion,pUseProd).sanc_prov_type_lInputTemplate, layouts.sanc_prov_type_Input, csv(separator('|'),quote('')));
  export sanc_prov_type_history  := dataset(Filenames(pversion,pUseProd).sanc_prov_type_lInputHistTemplate, layouts.sanc_prov_type_Input, csv(separator('|'),quote('')));
  export sanc_codes_input  	:= dataset(Filenames(pversion,pUseProd).sanc_codes_lInputTemplate, layouts.sanc_codes_Input, csv(separator('|'),quote('')));
  export sanc_codes_history := dataset(Filenames(pversion,pUseProd).sanc_codes_lInputHistTemplate, layouts.sanc_codes_Input, csv(separator('|'),quote('')));
  // export dea_BAcodes_input  := dataset(Filenames(pversion,pUseProd).dea_BAcodes_lInputTemplate, layouts.dea_BAcodes_Input, csv(separator('|')),opt);
  // export dea_BAcodes_history  := dataset(Filenames(pversion,pUseProd).dea_BAcodes_lInputHistTemplate, layouts.dea_BAcodes_Input, csv(separator('|')));
	export prov_birthdate_input := dataset(Filenames(pversion,puseProd).prov_birthdate_lInputTemplate, layouts.prov_birthdate_input, csv(separator('|'),quote('')));
	export prov_birthdate_history := dataset(Filenames(pversion,puseProd).prov_birthdate_lInputHistTemplate, layouts.prov_birthdate_input, csv(separator('|'),quote('')));
  export sanction_input  		:= dataset(Filenames(pversion,pUseProd).sanction_lInputTemplate, layouts.sanction_Input, csv(separator('|'),quote('')));
  export sanction_history  	:= dataset(Filenames(pversion,pUseProd).sanction_lInputHistTemplate, layouts.sanction_Input, csv(separator('|'),quote('')));

	 /* Base File Versions */
   tools.mac_FilesBase(Filenames(pversion,pUseProd).collapse_Base, layouts.collapse_Base, collapse_base);
   tools.mac_FilesBase(Filenames(pversion,pUseProd).split_Base, layouts.split_Base, split_base);
   tools.mac_FilesBase(Filenames(pversion,pUseProd).drop_Base, layouts.drop_Base, drop_base);
   tools.mac_FilesBase(Filenames(pversion,pUseProd).facility_Base, layouts.facility_Base, facility_base);
	 tools.mac_FilesBase(Filenames(pversion,pUseProd).individual_Base, layouts.individual_base, individual_base);
	 tools.mac_FilesBase(Filenames(pversion,pUseProd).associate_Base, layouts.associate_base, associate_base);
	 tools.mac_FilesBase(Filenames(pversion,pUseProd).address_Base, layouts.address_base, address_base);
 	 tools.mac_FilesBase(Filenames(pversion,pUseProd).dea_Base, layouts.dea_base, dea_base);
 	 tools.mac_FilesBase(Filenames(pversion,pUseProd).license_Base, layouts.license_base, license_base);
 	 tools.mac_FilesBase(Filenames(pversion,pUseProd).taxonomy_Base, layouts.taxonomy_base, taxonomy_base);
 	 tools.mac_FilesBase(Filenames(pversion,pUseProd).npi_Base, layouts.npi_base, npi_base);
 	 tools.mac_FilesBase(Filenames(pversion,pUseProd).medschool_Base, layouts.medschool_base, medschool_base);
 	 tools.mac_FilesBase(Filenames(pversion,pUseProd).tax_codes_Base, layouts.tax_codes_base, tax_codes_base);
 	 tools.mac_FilesBase(Filenames(pversion,pUseProd).prov_ssn_Base, layouts.prov_ssn_base, prov_ssn_base);
 	 tools.mac_FilesBase(Filenames(pversion,pUseProd).specialty_Base, layouts.specialty_base, specialty_base);
 	 tools.mac_FilesBase(Filenames(pversion,pUseProd).sanc_prov_type_Base, layouts.sanc_prov_type_base, sanc_prov_type_base);
 	 tools.mac_FilesBase(Filenames(pversion,pUseProd).sanc_codes_Base, layouts.sanc_codes_base, sanc_codes_base);
 	 // tools.mac_FilesBase(Filenames(pversion,pUseProd).dea_BAcodes_Base, layouts.dea_BAcodes_base, );
 	 tools.mac_FilesBase(Filenames(pversion,pUseProd).prov_birthdate_Base, layouts.prov_birthdate_base, prov_birthdate_base);
 	 tools.mac_FilesBase(Filenames(pversion,pUseProd).sanction_Base, layouts.sanction_base, sanction_base);
	 tools.mac_FilesBase(Filenames(pversion,pUseProd).gk_to_provID_Base, layouts.gk_to_provID_base, gk_to_provID_base);
	 tools.mac_FilesBase(Filenames(pversion,pUseProd).individual_exceptions, layouts.individual_exception_base, exceptions);
	 
   Export dea_BAcodes_base :=
				dataset([
								{'A','5','ONLINE RETAIL PHARMACY'},
								{'U','0','COMPUNDER/MAINT & DETOX'},
								{'G','0','RESEARCHER(II-V)'},
								{'P','0','DETOXIFICATION'},
								{'M','7','MLP-MEDICAL PSYCHOLOGIST'},
								{'B','0','HOSPITAL/CLINIC'},
								{'A','0','RETAIL PHARMACY'},
								{'G','1','CANINE HANDLER'},
								{'A','4','AUTOMATED DISPENSING SYSTEM'},
								{'M','3','MLP-DR OF ORIENTAL MEDICINE'},
								{'M','C','MLP-PHYSICIAN ASSISTANT'},
								{'T','0','COMPOUNDER/DETOXIFICATION'},
								{'E','0','MANUFACTURER'},
								{'C','3','MLP-MILITARY'},
								{'M','A','MLP-NURSE PRACTITIONER'},
								{'L','0','REVERSE DISTRIBUTOR'},
								{'M','6','MLP-HOMEOPATHIC PHYSICIAN'},
								{'C','2','PRACTITIONER-MILITARY'},
								{'H','0','ANALYTICAL LAB'},
								{'E','1','"MANUFACTURER (C I,II BULK)"'},
								{'R','0','MAINTENANCE & DETOX'},
								{'G','2','RESEARCHER (I)'},
								{'C','1','PRACTITIONER-DW/30'},
								{'C','0','PRACTITIONER'},
								{'M','2','MLP-ANIMAL SHELTER'},
								{'M','8','MLP-NATUROPATHIC PHYSICIAN'},
								{'K','0','EXPORTER'},
								{'C','5','MILITARY PRACTITIONER - DW30'},
								{'C','4','PRACTITIONER-DW/100'},
								{'M','4','MLP-DEPT OF STATE'},
								{'M','D','MLP-REGISTERED PHARMACIST'},
								{'A','3','CHAIN PHARMACY'},
								{'M','B','MLP-OPTOMETRIST'},
								{'J','0','IMPORTER'},
								{'S','0','COMPOUNDER/MAINTENANCE'},
								{'M','9','MLP-NURSING HOME'},
								{'F','0','DISTRIBUTOR'},
								{'A','7','ONLINE CHAIN PHARMACY'},
								{'M','5','MLP-EUTHANASIA TECHNICIAN'},
								{'N','0','MAINTENANCE'},
								{'A','6','ONLINE CENTRAL FILL PHARMACY'},
								{'D','0','TEACHING INSTITUTION'},
								{'A','1','CENTRAL FILL PHARMACY'},
								{'J','1','"IMPORTER (C I, II)"'}
								],Layouts.DEA_BACodes_input);

END;
