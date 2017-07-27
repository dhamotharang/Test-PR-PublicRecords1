// EXPORT Files_w_medschool := 'todo';
IMPORT tools,Healthcare_Cleaners;

EXPORT Files_w_medschool(STRING pversion = '', boolean pUseProd = false) := MODULE

   /* Input File Versions */
	 export idv_basc_file 		            := dataset(Filenames(pversion,pUseProd).individual_lInputTemplate, layouts.individual_In, csv( separator('|'),heading(0), terminator(['\n', '\r\n']),QUOTE('')))(taxonomy<>'taxonomy');
 	 export fac_basc_file 		            := dataset(Filenames(pversion,pUseProd).facility_lInputTemplate, layouts.facility_In, csv( separator('|'),heading(0), terminator(['\n', '\r\n']),QUOTE('')))(surrogate_key<>'surrogate_key');
   export basc_cp_file 		              := dataset(Filenames(pversion,pUseProd).basc_cp_lInputTemplate, layouts.choice_point_in, csv( separator('|'),heading(0), terminator(['\n', '\r\n']),QUOTE('')));	 
	 export basc_claims_file		          := dataset(Filenames(pversion,pUseProd).basc_claims_lInputTemplate, layouts.basc_claims_In, csv( separator('|'),heading(0), terminator(['\n', '\r\n']),QUOTE('')));
	 export npi_extension_file 		        := dataset(Filenames(pversion,pUseProd).npi_extension_lInputTemplate, layouts.npi_extension_In, csv( separator('|'),heading(0), terminator(['\n', '\r\n']),QUOTE('')));
	 export npi_extension_facility_file 	:= dataset(Filenames(pversion,pUseProd).npi_extension_facility_lInputTemplate, layouts.npi_extension_facility_In, csv( separator('|'),heading(0), terminator(['\n', '\r\n']),QUOTE('')));
	 export claims_addr_master_file 		  := dataset(Filenames(pversion,pUseProd).claims_addr_master_lInputTemplate, layouts.claims_address_master_In, csv( separator('|'),heading(0), terminator(['\n', '\r\n']),QUOTE('')));
	 export dea_xref_file      		        := dataset(Filenames(pversion,pUseProd).dea_xref_lInputTemplate, layouts.dea_xref_in, csv( separator('|'),heading(0), terminator(['\n', '\r\n'])));
   export npi_tin_xref_file 		        := dataset(Filenames(pversion,pUseProd).npi_tin_xref_lInputTemplate,layouts.npi_tin_xref_in, csv( separator('|'),heading(0), terminator(['\n', '\r\n'])));
   //export license_xref_file  		        := dataset(Filenames(pversion,pUseProd).license_xref_lInputTemplate,layouts.license_xref_In, csv( separator('|'),heading(0), terminator(['\n', '\r\n'])));	 
   //export address_name_xref_file        := dataset(Filenames(pversion,pUseProd).address_name_xref_lInputTemplate,layouts.address_name_xref_In, csv( separator('|'),heading(0), terminator(['\n', '\r\n'])));	 
 	 export facility_name_xref_file       := dataset(Filenames(pversion,pUseProd).facility_name_xref_lInputTemplate,layouts.facility_name_xref_In, csv( separator('|'),heading(0), terminator(['\n', '\r\n'])));
   export taxonomy_equiv_file           := dataset(Filenames(pversion,pUseProd).taxonomy_equiv_lInputTemplate, layouts.taxonomy_equiv_in, csv( separator('|'),heading(0), terminator(['\n', '\r\n']), quote(['\'','"'])));
   export claims_by_month_file          := dataset(Filenames(pversion,pUseProd).claims_by_month_lInputTemplate, layouts.claims_by_month_in, csv( separator('|'),heading(0), terminator(['\n', '\r\n']), quote(['\'','"'])));
   export basc_deceased_file            := dataset(Filenames(pversion,pUseProd).basc_deceased_lInputTemplate, layouts.basc_deceased_in, csv( separator('|'),heading(0), terminator(['\n', '\r\n']), quote(['\'','"'])));	 
	 export basc_addr_file                := dataset(Filenames(pversion,pUseProd).basc_addr_lInputTemplate, layouts.basc_addr_in, csv( separator('|'),heading(0), terminator(['\n', '\r\n']), quote(['\'','"'])));	 
	 export client_data_file              := dataset(Filenames(pversion,pUseProd).client_data_lInputTemplate, layouts.client_data_in, csv( separator('|'),heading(0), terminator(['\n', '\r\n']), quote(['\'','"'])));	 
	 export office_attributes_file        := dataset(Filenames(pversion,pUseProd).office_attributes_lInputTemplate, layouts.office_attributes_in, csv( separator('|'),heading(0), terminator(['\n', '\r\n']), quote(['\'','"'])));	 
	 export office_attributes_facility_file   := dataset(Filenames(pversion,pUseProd).office_attributes_facility_lInputTemplate, layouts.office_attributes_facility_in, csv( separator('|'),heading(0), terminator(['\n', '\r\n']), quote(['\'','"'])));	 
   export std_terms_lu_file             := dataset(Filenames(pversion,pUseProd).std_terms_lu_lInputTemplate, layouts.std_terms_lu_in, csv( separator('|'),heading(0), terminator(['\n', '\r\n']), quote(['\'','"'])));
	 export taxonomy_full_lu_file         := dataset(Filenames(pversion,pUseProd).taxonomy_full_lu_lInputTemplate, layouts.taxonomy_full_lu_in, csv( separator('|'),heading(0), terminator(['\n', '\r\n']), quote(['\'','"'])));
   export dir_confidence_2010_lu_file   := dataset(Filenames(pversion,pUseProd).dir_confidence_2010_lu_lInputTemplate, layouts.dirconfidence2010lu_in, csv( separator('|'),heading(0), terminator(['\n', '\r\n']), quote(['\'','"'])));
   export specialty_lu_file             := dataset(Filenames(pversion,pUseProd).specialty_lu_lInputTemplate, layouts.specialty_lu_in, csv( separator('|'),heading(0), terminator(['\n', '\r\n']), quote(['\'','"'])));
   export group_lu_file                 := dataset(Filenames(pversion,pUseProd).group_lu_lInputTemplate, layouts.group_lu_in, csv( separator('|'),heading(0), terminator(['\n', '\r\n']), quote(['\'','"'])));
   export hospital_lu_file              := dataset(Filenames(pversion,pUseProd).hospital_lu_lInputTemplate, layouts.hospital_lu_in, csv( separator('|'),heading(0), terminator(['\n', '\r\n']), quote(['\'','"'])));
   export lic_xref_file                 := dataset(Filenames(pversion,pUseProd).lic_xref_lInputTemplate, layouts.lic_xref_in, csv( separator('|'),heading(0), terminator(['\n', '\r\n']), quote(['\'','"'])));
	 //export facility_name_xref_file       := dataset(Filenames(pversion,pUseProd).facility_name_xref_lInputTemplate, layouts.facility_name_xref_in, csv( separator('|'),heading(0), terminator(['\n', '\r\n']), quote(['\'','"'])));
	 export addr_name_xref_file           := dataset(Filenames(pversion,pUseProd).addr_name_xref_lInputTemplate, layouts.address_name_xref_in, csv( separator('|'),heading(0), terminator(['\n', '\r\n']), quote(['\'','"'])));
	 export basc_facility_mme_file        := dataset(Filenames(pversion,pUseProd).basc_facility_mme_lInputTemplate, layouts.basc_facility_mme_in, csv( separator('|'),heading(0), terminator(['\n', '\r\n']), quote(['\'','"'])));
	 export lic_filedate_file             := dataset(Filenames(pversion,pUseProd).lic_filedate_lInputTemplate, layouts.lic_filedate_in, csv( separator('|'),heading(0), terminator(['\n', '\r\n']), quote(['\'','"'])));
	 export nanpa_file                    := dataset(Filenames(pversion,pUseProd).nanpa_lInputTemplate, layouts.nanpa_in, csv( separator('|'),heading(0), terminator(['\n', '\r\n']), quote(['\'','"'])));
	 export best_hospital_file            := dataset(Filenames(pversion,pUseProd).best_hospital_lInputTemplate, layouts.best_hospital_in, csv( separator('|'),heading(0), terminator(['\n', '\r\n']), quote(['\'','"'])));
	 export last_name_stats_file          := dataset(Filenames(pversion,pUseProd).last_name_stats_lInputTemplate, layouts.last_name_stats_in, csv( separator('|'),heading(0), terminator(['\n', '\r\n']), quote(['\'','"'])));
	 export source_confidence_lu_file     := dataset(Filenames(pversion,pUseProd).source_confidence_lu_lInputTemplate, layouts.source_confidence_lu_in, csv( separator('|'),heading(0), terminator(['\n', '\r\n']), quote(['\'','"'])));
	 export ignore_terms_lu_file          := dataset(Filenames(pversion,pUseProd).ignore_terms_lu_lInputTemplate, layouts.ignore_terms_lu_in, csv( separator('|'),heading(0), terminator(['\n', '\r\n']), quote(['\'','"'])));
	 export taxon_lu_file                 := dataset(Filenames(pversion,pUseProd).taxon_lu_lInputTemplate, layouts.taxon_lu_in, csv( separator('|'),heading(0), terminator(['\n', '\r\n']), quote(['\'','"'])));
	 export abbr_lu_file                  := dataset(Filenames(pversion,pUseProd).abbr_lu_lInputTemplate, layouts.abbr_lu_in, csv( separator('|'),heading(0), terminator(['\n', '\r\n']), quote(['\'','"'])));
	 export call_queue_bad_file           := dataset(Filenames(pversion,pUseProd).call_queue_bad_lInputTemplate, layouts.call_queue_bad_in, csv( separator('|'),heading(0), terminator(['\n', '\r\n']), quote(['\'','"'])));
	 export medschool_file                := dataset(Filenames_w_medschool(pversion,false).medschool_lBaseTemplate,Healthcare_Cleaners.layouts_medschool.layoutMedicalSchoolInfo1, flat);
	 export medschool_wordlist_file       := dataset(Filenames_w_medschool(pversion,false).medschool_wordlist_lBaseTemplate,Healthcare_Cleaners.layouts_medschool.layoutMedicalSchoolWord1, flat);
	 export non_medschool_file             := dataset(Filenames_w_medschool(pversion,false).non_medschool_lBaseTemplate,Healthcare_Cleaners.layouts_medschool.layoutMedicalSchoolInfo1, flat);
	 export non_medschool_wordlist_file    := dataset(Filenames_w_medschool(pversion,false).non_medschool_wordlist_lBaseTemplate,Healthcare_Cleaners.layouts_medschool.layoutMedicalSchoolWord1, flat);
     
		 
		 
		 
		 
		 // Added files end ### 

	 	 
	 
	 export choice_point_in :=dataset('~thor_data400::in::ln_basc_cp_nonull1',mprd.layouts.choice_point_in,flat);
	 export choice_point_base :=dataset('~thor_data400::mprd::choice_point::built2',mprd.layouts.choice_point_base,flat);
	 


	 /* Base File Versions */
   //tools.mac_FilesBase(Filenames(pversion,pUseProd).individual_Base, layouts.individual_base, individual_Base);
	 //tools.mac_FilesBase(Filenames(pversion,pUseProd).facility_Base, layouts.facility_base, facility_base);
	 
	 tools.mac_FilesBase(Filenames(pversion,pUseProd).facility_Base, layouts.facility_Base, facility_base);
	 tools.mac_FilesBase(Filenames(pversion,pUseProd).individual_Base, layouts.individual_base, individual_base);
	 tools.mac_FilesBase(Filenames(pversion,pUseProd).basc_cp_base, layouts.choice_point_base, basc_cp_base);
	 tools.mac_FilesBase(Filenames(pversion,pUseProd).basc_claims_base, layouts.basc_claims_base, basc_claims_base);
	 tools.mac_FilesBase(Filenames(pversion,pUseProd).claims_addr_master_Base, layouts.claims_address_master_Base, claims_addr_master_Base);
	 tools.mac_FilesBase(Filenames(pversion,pUseProd).npi_extension_Base, layouts.npi_extension_Base, npi_extension_Base);
	 tools.mac_FilesBase(Filenames(pversion,pUseProd).npi_extension_facility_Base, layouts.npi_extension_facility_base, npi_extension_facility_Base);
   tools.mac_FilesBase(Filenames(pversion,pUseProd).basc_deceased_Base, layouts.basc_deceased_base, basc_deceased_Base);	 
	 tools.mac_FilesBase(Filenames(pversion,pUseProd).basc_addr_Base, layouts.basc_addr_base, basc_addr_Base);	 
	 tools.mac_FilesBase(Filenames(pversion,pUseProd).client_data_Base, layouts.client_data_base, client_data_Base);	 
	 tools.mac_FilesBase(Filenames(pversion,pUseProd).office_attributes_Base, layouts.office_attributes_base, office_attributes_Base);	 
	 tools.mac_FilesBase(Filenames(pversion,pUseProd).office_attributes_facility_Base, layouts.office_attributes_facility_base, office_attributes_facility_Base);	 
	 
	 tools.mac_FilesBase(Filenames(pversion,pUseProd).std_terms_lu_Base, layouts.std_terms_lu_base, std_terms_lu_Base);	 
	 tools.mac_FilesBase(Filenames(pversion,pUseProd).taxonomy_full_lu_Base, layouts.taxonomy_full_lu_base, taxonomy_full_lu_Base);	 
	 tools.mac_FilesBase(Filenames(pversion,pUseProd).dir_confidence_2010_lu_Base, layouts.dirconfidence2010lu_base, dir_confidence_2010_lu_Base);	 
	 tools.mac_FilesBase(Filenames(pversion,pUseProd).specialty_lu_Base, layouts.specialty_lu_base,specialty_lu_Base);	 
	 tools.mac_FilesBase(Filenames(pversion,pUseProd).group_lu_Base, layouts.group_lu_base,group_lu_Base);	 
   tools.mac_FilesBase(Filenames(pversion,pUseProd).hospital_lu_Base, layouts.hospital_lu_base,hospital_lu_Base);	 	 
	 tools.mac_FilesBase(Filenames(pversion,pUseProd).dea_xref_Base, layouts.dea_xref_base,dea_xref_Base);	 	 
	 tools.mac_FilesBase(Filenames(pversion,pUseProd).lic_xref_Base, layouts.lic_xref_base,lic_xref_Base);	 	 
	 tools.mac_FilesBase(Filenames(pversion,pUseProd).facility_name_xref_Base, layouts.facility_name_xref_base,facility_name_xref_Base);	 	 
	 tools.mac_FilesBase(Filenames(pversion,pUseProd).addr_name_xref_Base, layouts.address_name_xref_base,addr_name_xref_Base);	 	 
	 tools.mac_FilesBase(Filenames(pversion,pUseProd).basc_facility_mme_Base, layouts.basc_facility_mme_base,basc_facility_mme_Base);	
	 tools.mac_FilesBase(Filenames(pversion,pUseProd).lic_filedate_Base, layouts.lic_filedate_base,lic_filedate_Base);	
	 tools.mac_FilesBase(Filenames(pversion,pUseProd).nanpa_Base, layouts.nanpa_base,nanpa_Base);	
	 tools.mac_FilesBase(Filenames(pversion,pUseProd).best_hospital_Base, layouts.best_hospital_base,best_hospital_Base);	
	 tools.mac_FilesBase(Filenames(pversion,pUseProd).last_name_stats_Base, layouts.last_name_stats_base,last_name_stats_Base);	
	 tools.mac_FilesBase(Filenames(pversion,pUseProd).source_confidence_lu_Base, layouts.source_confidence_lu_base,source_confidence_lu_Base);	
	 tools.mac_FilesBase(Filenames(pversion,pUseProd).ignore_terms_lu_Base,layouts.ignore_terms_lu_base,ignore_terms_lu_Base);	
 	 
	 
	 
	 tools.mac_FilesBase(Filenames(pversion,pUseProd).claims_by_month_Base, layouts.claims_by_month_base, claims_by_month_Base);
	 tools.mac_FilesBase(Filenames(pversion,pUseProd).taxonomy_equiv_Base, layouts.taxonomy_equiv_base, taxonomy_equiv_Base);
	 tools.mac_FilesBase(Filenames(pversion,pUseProd).npi_tin_xref_base, layouts.npi_tin_xref_base, npi_tin_xref_base);
	 
	 tools.mac_FilesBase(Filenames(pversion,pUseProd).taxon_lu_base, layouts.taxon_lu_base, taxon_lu_base);
	 tools.mac_FilesBase(Filenames(pversion,pUseProd).abbr_lu_base, layouts.abbr_lu_base, abbr_lu_base);
	 tools.mac_FilesBase(Filenames(pversion,pUseProd).call_queue_bad_base, layouts.call_queue_bad_base, call_queue_bad_base);
	 
	 
	 //tools.mac_FilesBase(Filenames(pversion,pUseProd).individual_Base, layouts.individual_base, individual_base);
	 
	 	 
	/* Keybuild File */
   //versioncontrol.macBuildFileVersions(Filenames(pversion).keybuild, layouts.keybuild, keybuild); 
	 
END;