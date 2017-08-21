IMPORT tools, MPRD, ut, data_services;

EXPORT Files(STRING pversion = '', boolean pUseProd = true) := MODULE

   /* Input File Versions */
	 export idv_basc_file 		            := dataset(MPRD.Filenames(pversion,pUseProd).individual_lInputTemplate, MPRD.layouts.individual_In, csv( separator('|'),heading(0), terminator(['\n', '\r\n']),QUOTE('')))(taxonomy<>'taxonomy');
 	 export fac_basc_file 		            := dataset(MPRD.Filenames(pversion,pUseProd).facility_lInputTemplate, MPRD.layouts.facility_In, csv( separator('|'),heading(0), terminator(['\n', '\r\n']),QUOTE('')))(surrogate_key<>'surrogate_key');
   export basc_cp_file 		              := dataset(MPRD.Filenames(pversion,pUseProd).basc_cp_lInputTemplate, MPRD.layouts.choice_point_in, csv( separator('|'),heading(0), terminator(['\n', '\r\n']),QUOTE('')));	 
	 export basc_claims_file		          := dataset(MPRD.Filenames(pversion,pUseProd).basc_claims_lInputTemplate, MPRD.layouts.basc_claims_In, csv( separator('|'),heading(0), terminator(['\n', '\r\n']),QUOTE('')));
	 export npi_extension_file 		        := dataset(MPRD.Filenames(pversion,pUseProd).npi_extension_lInputTemplate, MPRD.layouts.npi_extension_In, csv( separator('|'),heading(0), terminator(['\n', '\r\n']),QUOTE('')));
	 export npi_extension_facility_file 	:= dataset(MPRD.Filenames(pversion,pUseProd).npi_extension_facility_lInputTemplate, MPRD.layouts.npi_extension_facility_In, csv( separator('|'),heading(0), terminator(['\n', '\r\n']),QUOTE('')));
	 export claims_addr_master_file 		  := dataset(MPRD.Filenames(pversion,pUseProd).claims_addr_master_lInputTemplate, MPRD.layouts.claims_address_master_In, csv( separator('|'),heading(0), terminator(['\n', '\r\n']),QUOTE('')));
	 export dea_xref_file      		        := dataset(MPRD.Filenames(pversion,pUseProd).dea_xref_lInputTemplate, MPRD.layouts.dea_xref_in, csv( separator('|'),heading(0), terminator(['\n', '\r\n'])));
   export npi_tin_xref_file 		        := dataset(MPRD.Filenames(pversion,pUseProd).npi_tin_xref_lInputTemplate,MPRD.layouts.npi_tin_xref_in, csv( separator('|'),heading(0), terminator(['\n', '\r\n'])));
 	 export facility_name_xref_file       := dataset(MPRD.Filenames(pversion,pUseProd).facility_name_xref_lInputTemplate,MPRD.layouts.facility_name_xref_In, csv( separator('|'),heading(0), terminator(['\n', '\r\n'])));
   export taxonomy_equiv_file           := dataset(MPRD.Filenames(pversion,pUseProd).taxonomy_equiv_lInputTemplate, MPRD.layouts.taxonomy_equiv_in, csv( separator('|'),heading(0), terminator(['\n', '\r\n']), quote(['\'','"'])));
   export claims_by_month_file          := dataset(MPRD.Filenames(pversion,pUseProd).claims_by_month_lInputTemplate, MPRD.layouts.claims_by_month_in, csv( separator('|'),heading(0), terminator(['\n', '\r\n']), quote(['\'','"'])));
   export basc_deceased_file            := dataset(MPRD.Filenames(pversion,pUseProd).basc_deceased_lInputTemplate, MPRD.layouts.basc_deceased_in, csv( separator('|'),heading(0), terminator(['\n', '\r\n']), quote(['\'','"'])));	 
	 export basc_addr_file                := dataset(MPRD.Filenames(pversion,pUseProd).basc_addr_lInputTemplate, MPRD.layouts.basc_addr_in, csv( separator('|'),heading(0), terminator(['\n', '\r\n']), quote(['\'','"'])));	 
	 export client_data_file              := dataset(MPRD.Filenames(pversion,pUseProd).client_data_lInputTemplate, MPRD.layouts.client_data_in, csv( separator('|'),heading(0), terminator(['\n', '\r\n']), quote(['\'','"'])));	 
	 export office_attributes_file        := dataset(MPRD.Filenames(pversion,pUseProd).office_attributes_lInputTemplate, MPRD.layouts.office_attributes_in, csv( separator('|'),heading(0), terminator(['\n', '\r\n']), quote(['\'','"'])));	 
	 export office_attributes_facility_file   := dataset(MPRD.Filenames(pversion,pUseProd).office_attributes_facility_lInputTemplate, MPRD.layouts.office_attributes_facility_in, csv( separator('|'),heading(0), terminator(['\n', '\r\n']), quote(['\'','"'])));	 
   export std_terms_lu_file             := dataset(MPRD.Filenames(pversion,pUseProd).std_terms_lu_lInputTemplate, MPRD.layouts.std_terms_lu_in, csv( separator('|'),heading(0), terminator(['\n', '\r\n']), quote(['\'','"'])));
	 export taxonomy_full_lu_file         := dataset(MPRD.Filenames(pversion,pUseProd).taxonomy_full_lu_lInputTemplate, MPRD.layouts.taxonomy_full_lu_in, csv( separator('|'),heading(0), terminator(['\n', '\r\n']), quote(['\'','"'])));
   export dir_confidence_2010_lu_file   := dataset(MPRD.Filenames(pversion,pUseProd).dir_confidence_2010_lu_lInputTemplate, MPRD.layouts.dirconfidence2010lu_in, csv( separator('|'),heading(0), terminator(['\n', '\r\n']), quote(['\'','"'])));
   export specialty_lu_file             := dataset(MPRD.Filenames(pversion,pUseProd).specialty_lu_lInputTemplate, MPRD.layouts.specialty_lu_in, csv( separator('|'),heading(0), terminator(['\n', '\r\n']), quote(['\'','"'])));
   export group_lu_file                 := dataset(MPRD.Filenames(pversion,pUseProd).group_lu_lInputTemplate, MPRD.layouts.group_lu_in, csv( separator('|'),heading(0), terminator(['\n', '\r\n']), quote(['\'','"'])));
   export hospital_lu_file              := dataset(MPRD.Filenames(pversion,pUseProd).hospital_lu_lInputTemplate, MPRD.layouts.hospital_lu_in, csv( separator('|'),heading(0), terminator(['\n', '\r\n']), quote(['\'','"'])));
   export lic_xref_file                 := dataset(MPRD.Filenames(pversion,pUseProd).lic_xref_lInputTemplate, MPRD.layouts.lic_xref_in, csv( separator('|'),heading(0), terminator(['\n', '\r\n']), quote(['\'','"'])));
	 export addr_name_xref_file           := dataset(MPRD.Filenames(pversion,pUseProd).addr_name_xref_lInputTemplate, MPRD.layouts.address_name_xref_in, csv( separator('|'),heading(0), terminator(['\n', '\r\n']), quote(['\'','"'])));
	 export basc_facility_mme_file        := dataset(MPRD.Filenames(pversion,pUseProd).basc_facility_mme_lInputTemplate, MPRD.layouts.basc_facility_mme_in, csv( separator('|'),heading(0), terminator(['\n', '\r\n']), quote(['\'','"'])));
	 export lic_filedate_file             := dataset(MPRD.Filenames(pversion,pUseProd).lic_filedate_lInputTemplate, MPRD.layouts.lic_filedate_in, csv( separator('|'),heading(0), terminator(['\n', '\r\n']), quote(['\'','"'])));
	 export nanpa_file                    := dataset(MPRD.Filenames(pversion,pUseProd).nanpa_lInputTemplate, MPRD.layouts.nanpa_in, csv( separator('|'),heading(0), terminator(['\n', '\r\n']), quote(['\'','"'])));
	 export best_hospital_file            := dataset(MPRD.Filenames(pversion,pUseProd).best_hospital_lInputTemplate, MPRD.layouts.best_hospital_in, csv( separator('|'),heading(0), terminator(['\n', '\r\n']), quote(['\'','"'])));
	 export last_name_stats_file          := dataset(MPRD.Filenames(pversion,pUseProd).last_name_stats_lInputTemplate, MPRD.layouts.last_name_stats_in, csv( separator('|'),heading(0), terminator(['\n', '\r\n']), quote(['\'','"'])));
	 export source_confidence_lu_file     := dataset(MPRD.Filenames(pversion,pUseProd).source_confidence_lu_lInputTemplate, MPRD.layouts.source_confidence_lu_in, csv( separator('|'),heading(0), terminator(['\n', '\r\n']), quote(['\'','"'])));
	 export ignore_terms_lu_file          := dataset(MPRD.Filenames(pversion,pUseProd).ignore_terms_lu_lInputTemplate, MPRD.layouts.ignore_terms_lu_in, csv( separator('|'),heading(0), terminator(['\n', '\r\n']), quote(['\'','"'])));
	 export taxon_lu_file                 := dataset(MPRD.Filenames(pversion,pUseProd).taxon_lu_lInputTemplate, MPRD.layouts.taxon_lu_in, csv( separator('|'),heading(0), terminator(['\n', '\r\n']), quote(['\'','"'])));
	 export abbr_lu_file                  := dataset(MPRD.Filenames(pversion,pUseProd).abbr_lu_lInputTemplate, MPRD.layouts.abbr_lu_in, csv( separator('|'),heading(0), terminator(['\n', '\r\n']), quote(['\'','"'])));
	 export call_queue_bad_file           := dataset(MPRD.Filenames(pversion,pUseProd).call_queue_bad_lInputTemplate, MPRD.layouts.call_queue_bad_in, csv( separator('|'),heading(0), terminator(['\n', '\r\n']), quote(['\'','"'])));
	 export group_practice_file						:= dataset(MPRD.Filenames(pversion,pUseProd).group_practice_lInputTemplate, MPRD.layouts.group_practice_in, csv(separator('|'),heading(0),terminator(['\n','\r\n']),quote(['\'','"'])));
	 export aci_schedule_file							:= dataset(MPRD.Filenames(pversion,pUseProd).aci_schedule_lInputTemplate, MPRD.layouts.aci_schedule_in,csv(separator('|'),heading(0),terminator(['\n','\r\n']),quote(['\'','"'])),opt);
	 export business_activities_lu_file		:= dataset(MPRD.Filenames(pversion,pUseProd).business_activities_lu_lInputTemplate, MPRD.layouts.business_activities_lu_in,csv(separator('|'),heading(0),terminator(['\n','\r\n']),quote(['\'','"'])));
	 export cms_ecp_file									:= dataset(MPRD.Filenames(pversion,pUseProd).cms_ecp_lInputTemplate, MPRD.layouts.cms_ecp_in,csv(separator('|'),heading(0),terminator(['\n','\r\n']),quote(['\'','"'])));
	 export opi_file											:= dataset(MPRD.Filenames(pversion,pUseProd).opi_lInputTemplate, MPRD.layouts.opi_in, csv(separator('|'),heading(0),terminator(['\n','\r\n']),quote(['\'','"'])));
	 export opi_facility_file							:= dataset(MPRD.Filenames(pversion,pUseProd).opi_facility_lInputTemplate, MPRD.layouts.opi_facility_in,csv(separator('|'),heading(0),terminator(['\n','\r\n']),quote(['\'','"'])));
	 export abms_cert_lu_file							:= dataset(MPRD.Filenames(pversion,pUseProd).abms_cert_lu_lInputTemplate, MPRD.layouts.abms_cert_lu_in,csv(separator('|'),heading(0),terminator(['\n','\r\n']),quote(['\'','"'])),opt);
	 export abms_cooked_file							:= dataset(MPRD.Filenames(pversion,pUseProd).abms_cooked_lInputTemplate, MPRD.layouts.abms_cooked_in,csv(separator('|'),heading(0),terminator(['\n','\r\n']),quote(['\'','"'])),opt);
	 
	 /* No test cases on prod - per Miller 20160614
	 //qa_test files
	 export idv_basc_qa_test_file 		            	:=// if(pUseProd = true,
			// dataset(data_services.foreign_dataland + 'thor_data400::in::mprd::individual::qa_test', MPRD.layouts.individual_In, csv( separator('|'),heading(0), terminator(['\n', '\r\n']),QUOTE('')),opt),
			dataset('~thor_data400::in::mprd::individual::qa_test', MPRD.layouts.individual_In, csv( separator('|'),heading(0), terminator(['\n', '\r\n']),QUOTE('')),opt);//);
 	 export fac_basc_qa_test_file 		            	:=// if(pUseProd = true,
			// dataset(data_services.foreign_dataland + 'thor_data400::in::mprd::facility::qa_test', MPRD.layouts.facility_In, csv( separator('|'),heading(0), terminator(['\n', '\r\n']),QUOTE('')),opt),
			dataset('~thor_data400::in::mprd::facility::qa_test', MPRD.layouts.facility_In, csv( separator('|'),heading(0), terminator(['\n', '\r\n']),QUOTE('')),opt);//);
   export basc_cp_qa_test_file 		            	  := //if(pUseProd = true,
			// dataset(data_services.foreign_dataland + 'thor_data400::in::mprd::basc_cp::qa_test', MPRD.layouts.choice_point_in, csv( separator('|'),heading(0), terminator(['\n', '\r\n']),QUOTE('')),opt),
			dataset('~thor_data400::in::mprd::basc_cp::qa_test', MPRD.layouts.choice_point_in, csv( separator('|'),heading(0), terminator(['\n', '\r\n']),QUOTE('')),opt);//);;	 
	 export basc_claims_qa_test_file		      	    :=// if(pUseProd = true,
			// dataset(data_services.foreign_dataland + 'thor_data400::in::mprd::basc_claims::qa_test', MPRD.layouts.basc_claims_In, csv( separator('|'),heading(0), terminator(['\n', '\r\n']),QUOTE('')),opt),
			dataset('~thor_data400::in::mprd::basc_claims::qa_test', MPRD.layouts.basc_claims_In, csv( separator('|'),heading(0), terminator(['\n', '\r\n']),QUOTE('')),opt);//);
	 export npi_extension_qa_test_file 		     		  :=// if(pUseProd = true,
			// dataset(data_services.foreign_dataland + 'thor_data400::in::mprd::npi_extension::qa_test', MPRD.layouts.npi_extension_In, csv( separator('|'),heading(0), terminator(['\n', '\r\n']),QUOTE('')),opt),
			dataset('~thor_data400::in::mprd::npi_extension::qa_test', MPRD.layouts.npi_extension_In, csv( separator('|'),heading(0), terminator(['\n', '\r\n']),QUOTE('')),opt);//);
	 export npi_extension_facility_qa_test_file 		:= //if(pUseProd = true,
			// dataset(data_services.foreign_dataland + 'thor_data400::in::mprd::npi_extension_facility::qa_test', MPRD.layouts.npi_extension_facility_In, csv( separator('|'),heading(0), terminator(['\n', '\r\n']),QUOTE('')),opt),
			dataset('~thor_data400::in::mprd::npi_extension_facility::qa_test', MPRD.layouts.npi_extension_facility_In, csv( separator('|'),heading(0), terminator(['\n', '\r\n']),QUOTE('')),opt);//);
	 export claims_addr_master_qa_test_file 			  :=// if(pUseProd = true,
			// dataset(data_services.foreign_dataland + 'thor_data400::in::mprd::claims_addr_master::qa_test', MPRD.layouts.claims_address_master_In, csv( separator('|'),heading(0), terminator(['\n', '\r\n']),QUOTE('')),opt),
			dataset('~thor_data400::in::mprd::claims_addr_master::qa_test', MPRD.layouts.claims_address_master_In, csv( separator('|'),heading(0), terminator(['\n', '\r\n']),QUOTE('')),opt);//);
   export npi_tin_xref_qa_test_file 		    	    := //if(pUseProd = true,
			// dataset(data_services.foreign_dataland + 'thor_data400::in::mprd::npi_tin_xref::qa_test',MPRD.layouts.npi_tin_xref_in, csv( separator('|'),heading(0), terminator(['\n', '\r\n']),QUOTE('')),opt),
			dataset('~thor_data400::in::mprd::npi_tin_xref::qa_test',MPRD.layouts.npi_tin_xref_in, csv( separator('|'),heading(0), terminator(['\n', '\r\n']),QUOTE('')),opt);//);
   export claims_by_month_qa_test_file    	      := //if(pUseProd = true,
			// dataset(data_services.foreign_dataland + 'thor_data400::in::mprd::claims_by_moth::qa_test', MPRD.layouts.claims_by_month_in, csv( separator('|'),heading(0), terminator(['\n', '\r\n']), quote(['\'','"'])),opt),
			dataset('~thor_data400::in::mprd::claims_by_moth::qa_test', MPRD.layouts.claims_by_month_in, csv( separator('|'),heading(0), terminator(['\n', '\r\n']), quote(['\'','"'])),opt);//);
   export basc_deceased_qa_test_file           		:= //if(pUseProd = true,
			// dataset(data_services.foreign_dataland + 'thor_data400::in::mprd::basc_deceased::qa_test', MPRD.layouts.basc_deceased_in, csv( separator('|'),heading(0), terminator(['\n', '\r\n']), quote(['\'','"'])),opt),
			dataset('~thor_data400::in::mprd::basc_deceased::qa_test', MPRD.layouts.basc_deceased_in, csv( separator('|'),heading(0), terminator(['\n', '\r\n']), quote(['\'','"'])),opt);//);
	 export office_attributes_qa_test_file        	:= //if(pUseProd = true,
			// dataset(data_services.foreign_dataland + 'thor_data400::in::mprd::office_attributes::qa_test', MPRD.layouts.office_attributes_in, csv( separator('|'),heading(0), terminator(['\n', '\r\n']), quote(['\'','"'])),opt),
			dataset('~thor_data400::in::mprd::office_attributes::qa_test', MPRD.layouts.office_attributes_in, csv( separator('|'),heading(0), terminator(['\n', '\r\n']), quote(['\'','"'])),opt);//);
	 export office_attributes_facility_qa_test_file := //if(pUseProd = true,
			// dataset(data_services.foreign_dataland + 'thor_data400::in::mprd::office_attributes_facility::qa_test', MPRD.layouts.office_attributes_facility_in, csv( separator('|'),heading(0), terminator(['\n', '\r\n']), quote(['\'','"'])),opt),
			dataset('~thor_data400::in::mprd::office_attributes_facility::qa_test', MPRD.layouts.office_attributes_facility_in, csv( separator('|'),heading(0), terminator(['\n', '\r\n']), quote(['\'','"'])),opt);//);	 
   export group_lu_qa_test_file              		  := //if(pUseProd = true,
			// dataset(data_services.foreign_dataland + 'thor_data400::in::mprd::group_lu::qa_test', MPRD.layouts.group_lu_in, csv( separator('|'),heading(0), terminator(['\n', '\r\n']), quote(['\'','"'])),opt),
			dataset('~thor_data400::in::mprd::group_lu::qa_test', MPRD.layouts.group_lu_in, csv( separator('|'),heading(0), terminator(['\n', '\r\n']), quote(['\'','"'])),opt);//);
   export hospital_lu_qa_test_file        	      := //if(pUseProd = true,
			// dataset(data_services.foreign_dataland + 'thor_data400::in::mprd::hospital_lu::qa_test', MPRD.layouts.hospital_lu_in, csv( separator('|'),heading(0), terminator(['\n', '\r\n']), quote(['\'','"'])),opt),
			dataset('~thor_data400::in::mprd::hospital_lu::qa_test', MPRD.layouts.hospital_lu_in, csv( separator('|'),heading(0), terminator(['\n', '\r\n']), quote(['\'','"'])),opt);//);
	 export basc_facility_mme_qa_test_file    	    := //if(pUseProd = true,
			// dataset(data_services.foreign_dataland + 'thor_data400::in::mprd::basc_facility_mme::qa_test', MPRD.layouts.basc_facility_mme_in, csv( separator('|'),heading(0), terminator(['\n', '\r\n']), quote(['\'','"'])),opt),
			dataset('~thor_data400::in::mprd::basc_facility_mme::qa_test', MPRD.layouts.basc_facility_mme_in, csv( separator('|'),heading(0), terminator(['\n', '\r\n']), quote(['\'','"'])),opt);//);
	 export lic_filedate_qa_test_file           	  := //if(pUseProd = true,
			// dataset(data_services.foreign_dataland + 'thor_data400::in::mprd::lic_filedate::qa_test', MPRD.layouts.lic_filedate_in, csv( separator('|'),heading(0), terminator(['\n', '\r\n']), quote(['\'','"'])),opt),
			dataset('~thor_data400::in::mprd::lic_filedate::qa_test', MPRD.layouts.lic_filedate_in, csv( separator('|'),heading(0), terminator(['\n', '\r\n']), quote(['\'','"'])),opt);//);
	 export nanpa_qa_test_file             		      := //if(pUseProd = true,
			// dataset(data_services.foreign_dataland + 'thor_data400::in::mprd::nanpa::qa_test', MPRD.layouts.nanpa_in, csv( separator('|'),heading(0), terminator(['\n', '\r\n']), quote(['\'','"'])),opt),
			dataset('~thor_data400::in::mprd::nanpa::qa_test', MPRD.layouts.nanpa_in, csv( separator('|'),heading(0), terminator(['\n', '\r\n']), quote(['\'','"'])),opt);//);
	 export best_hospital_qa_test_file     		      := //if(pUseProd = true,
			// dataset(data_services.foreign_dataland + 'thor_data400::in::mprd::best_hospital::qa_test', MPRD.layouts.best_hospital_in, csv( separator('|'),heading(0), terminator(['\n', '\r\n']), quote(['\'','"'])),opt),
			dataset('~thor_data400::in::mprd::best_hospital::qa_test', MPRD.layouts.best_hospital_in, csv( separator('|'),heading(0), terminator(['\n', '\r\n']), quote(['\'','"'])),opt);//);
	 export source_confidence_lu_qa_test_file 	    := //if(pUseProd = true,
			// dataset(data_services.foreign_dataland + 'thor_data400::in::mprd::source_confidence_lu::qa_test', MPRD.layouts.source_confidence_lu_in, csv( separator('|'),heading(0), terminator(['\n', '\r\n']), quote(['\'','"'])),opt),
			dataset('~thor_data400::in::mprd::source_confidence_lu::qa_test', MPRD.layouts.source_confidence_lu_in, csv( separator('|'),heading(0), terminator(['\n', '\r\n']), quote(['\'','"'])),opt);//);
	 export cms_ecp_qa_test_file										:= //if(pUseProd = true,
			// dataset(data_services.foreign_dataland + 'thor_data400::in::mprd::cms_ecp::qa_test', MPRD.layouts.cms_ecp_in,csv(separator('|'),heading(0),terminator(['\n','\r\n']),quote(['\'','"'])),opt),
			dataset('~thor_data400::in::mprd::cms_ecp::qa_test', MPRD.layouts.cms_ecp_in,csv(separator('|'),heading(0),terminator(['\n','\r\n']),quote(['\'','"'])),opt);//);
	 export opi_qa_test_file												:=// if(pUseProd = true,
			// dataset(data_services.foreign_dataland + 'thor_data400::in::mprd::opi::qa_test', MPRD.layouts.opi_in, csv(separator('|'),heading(0),terminator(['\n','\r\n']),quote(['\'','"'])),opt),
			dataset('~thor_data400::in::mprd::opi::qa_test', MPRD.layouts.opi_in, csv(separator('|'),heading(0),terminator(['\n','\r\n']),quote(['\'','"'])),opt);//);
	 export opi_facility_qa_test_file								:= //if(pUseProd = true,
			// dataset(data_services.foreign_dataland + 'thor_data400::in::mprd::opi_facility::qa_test', MPRD.layouts.opi_facility_in,csv(separator('|'),heading(0),terminator(['\n','\r\n']),quote(['\'','"'])),opt),
			dataset('~thor_data400::in::mprd::opi_facility::qa_test', MPRD.layouts.opi_facility_in,csv(separator('|'),heading(0),terminator(['\n','\r\n']),quote(['\'','"'])),opt);//);
	 export abms_cooked_qa_test_file								:= //if(pUseProd = true,
			// dataset(data_services.foreign_dataland + 'thor_data400::in::mprd::abms_cooked::qa_test', MPRD.layouts.abms_cooked_in,csv(separator('|'),heading(0),terminator(['\n','\r\n']),quote(['\'','"'])),opt),
			dataset('~thor_data400::in::mprd::abms_cooked::qa_test', MPRD.layouts.abms_cooked_in,csv(separator('|'),heading(0),terminator(['\n','\r\n']),quote(['\'','"'])),opt);//);
	 */
	 
	 /* Base File Versions */
	 tools.mac_FilesBase(MPRD.Filenames(pversion,pUseProd).facility_Base, MPRD.layouts.facility_Base, facility_base);
	 tools.mac_FilesBase(MPRD.Filenames(pversion,pUseProd).individual_Base, MPRD.layouts.individual_base, individual_base);
	 tools.mac_FilesBase(MPRD.Filenames(pversion,pUseProd).basc_cp_base, MPRD.layouts.choice_point_base, basc_cp_base);
	 tools.mac_FilesBase(MPRD.Filenames(pversion,pUseProd).basc_claims_base, MPRD.layouts.basc_claims_base, basc_claims_base);
	 tools.mac_FilesBase(MPRD.Filenames(pversion,pUseProd).claims_addr_master_Base, MPRD.layouts.claims_address_master_Base, claims_addr_master_Base);
	 tools.mac_FilesBase(MPRD.Filenames(pversion,pUseProd).npi_extension_Base, MPRD.layouts.npi_extension_Base, npi_extension_Base);
	 tools.mac_FilesBase(MPRD.Filenames(pversion,pUseProd).npi_extension_facility_Base, MPRD.layouts.npi_extension_facility_base, npi_extension_facility_Base);
   tools.mac_FilesBase(MPRD.Filenames(pversion,pUseProd).basc_deceased_Base, MPRD.layouts.basc_deceased_base, basc_deceased_Base);	 
	 tools.mac_FilesBase(MPRD.Filenames(pversion,pUseProd).basc_addr_Base, MPRD.layouts.basc_addr_base, basc_addr_Base);	 
	 tools.mac_FilesBase(MPRD.Filenames(pversion,pUseProd).client_data_Base, MPRD.layouts.client_data_base, client_data_Base);	 
	 tools.mac_FilesBase(MPRD.Filenames(pversion,pUseProd).office_attributes_Base, MPRD.layouts.office_attributes_base, office_attributes_Base);	 
	 tools.mac_FilesBase(MPRD.Filenames(pversion,pUseProd).office_attributes_facility_Base, MPRD.layouts.office_attributes_facility_base, office_attributes_facility_Base);	 
	 tools.mac_FilesBase(MPRD.Filenames(pversion,pUseProd).std_terms_lu_Base, MPRD.layouts.std_terms_lu_base, std_terms_lu_Base);	 
	 tools.mac_FilesBase(MPRD.Filenames(pversion,pUseProd).taxonomy_full_lu_Base, MPRD.layouts.taxonomy_full_lu_base, taxonomy_full_lu_Base);	 
	 tools.mac_FilesBase(MPRD.Filenames(pversion,pUseProd).dir_confidence_2010_lu_Base, MPRD.layouts.dirconfidence2010lu_base, dir_confidence_2010_lu_Base);	 
	 tools.mac_FilesBase(MPRD.Filenames(pversion,pUseProd).specialty_lu_Base, MPRD.layouts.specialty_lu_base,specialty_lu_Base);	 
	 tools.mac_FilesBase(MPRD.Filenames(pversion,pUseProd).group_lu_Base, MPRD.layouts.group_lu_base,group_lu_Base);	 
   tools.mac_FilesBase(MPRD.Filenames(pversion,pUseProd).hospital_lu_Base, MPRD.layouts.hospital_lu_base,hospital_lu_Base);	 	 
	 tools.mac_FilesBase(MPRD.Filenames(pversion,pUseProd).dea_xref_Base, MPRD.layouts.dea_xref_base,dea_xref_Base);	 	 
	 tools.mac_FilesBase(MPRD.Filenames(pversion,pUseProd).lic_xref_Base, MPRD.layouts.lic_xref_base,lic_xref_Base);	 	 
	 tools.mac_FilesBase(MPRD.Filenames(pversion,pUseProd).facility_name_xref_Base, MPRD.layouts.facility_name_xref_base,facility_name_xref_Base);	 	 
	 tools.mac_FilesBase(MPRD.Filenames(pversion,pUseProd).addr_name_xref_Base, MPRD.layouts.address_name_xref_base,addr_name_xref_Base);	 	 
	 tools.mac_FilesBase(MPRD.Filenames(pversion,pUseProd).basc_facility_mme_Base, MPRD.layouts.basc_facility_mme_base,basc_facility_mme_Base);	
	 tools.mac_FilesBase(MPRD.Filenames(pversion,pUseProd).lic_filedate_Base, MPRD.layouts.lic_filedate_base,lic_filedate_Base);	
	 tools.mac_FilesBase(MPRD.Filenames(pversion,pUseProd).nanpa_Base, MPRD.layouts.nanpa_base,nanpa_Base);	
	 tools.mac_FilesBase(MPRD.Filenames(pversion,pUseProd).best_hospital_Base, MPRD.layouts.best_hospital_base,best_hospital_Base);	
	 tools.mac_FilesBase(MPRD.Filenames(pversion,pUseProd).last_name_stats_Base, MPRD.layouts.last_name_stats_base,last_name_stats_Base);	
	 tools.mac_FilesBase(MPRD.Filenames(pversion,pUseProd).source_confidence_lu_Base, MPRD.layouts.source_confidence_lu_base,source_confidence_lu_Base);	
	 tools.mac_FilesBase(MPRD.Filenames(pversion,pUseProd).ignore_terms_lu_Base,MPRD.layouts.ignore_terms_lu_base,ignore_terms_lu_Base);	
	 tools.mac_FilesBase(MPRD.Filenames(pversion,pUseProd).claims_by_month_Base, MPRD.layouts.claims_by_month_base, claims_by_month_Base);
	 tools.mac_FilesBase(MPRD.Filenames(pversion,pUseProd).taxonomy_equiv_Base, MPRD.layouts.taxonomy_equiv_base, taxonomy_equiv_Base);
	 tools.mac_FilesBase(MPRD.Filenames(pversion,pUseProd).npi_tin_xref_base, MPRD.layouts.npi_tin_xref_base, npi_tin_xref_base);
	 tools.mac_FilesBase(MPRD.Filenames(pversion,pUseProd).taxon_lu_base, MPRD.layouts.taxon_lu_base, taxon_lu_base);
	 tools.mac_FilesBase(MPRD.Filenames(pversion,pUseProd).abbr_lu_base, MPRD.layouts.abbr_lu_base, abbr_lu_base);
	 tools.mac_FilesBase(MPRD.Filenames(pversion,pUseProd).call_queue_bad_base, MPRD.layouts.call_queue_bad_base, call_queue_bad_base);
	 tools.mac_FilesBase(MPRD.Filenames(pversion,pUseProd).group_practice_base, MPRD.layouts.group_practice_base, group_practice_base);
	 tools.mac_FilesBase(MPRD.Filenames(pversion,pUseProd).aci_schedule_base, MPRD.layouts.aci_schedule_base, aci_schedule_base);
	 tools.mac_FilesBase(MPRD.Filenames(pversion,pUseProd).business_activities_lu_base, MPRD.layouts.business_activities_lu_base, business_activities_lu_base);
	 tools.mac_FilesBase(MPRD.Filenames(pversion,pUseProd).cms_ecp_base, MPRD.layouts.cms_ecp_base, cms_ecp_base);
	 tools.mac_FilesBase(MPRD.Filenames(pversion,pUseProd).opi_base, MPRD.layouts.opi_base, opi_base);
	 tools.mac_FilesBase(MPRD.Filenames(pversion,pUseProd).opi_facility_base, MPRD.layouts.opi_facility_base, opi_facility_base);
	 tools.mac_FilesBase(MPRD.Filenames(pversion,pUseProd).abms_cert_lu_base, MPRD.layouts.abms_cert_lu_base, abms_cert_lu_base);
	 tools.mac_FilesBase(MPRD.Filenames(pversion,pUseProd).abms_cooked_base, MPRD.layouts.abms_cooked_base, abms_cooked_base);
END;