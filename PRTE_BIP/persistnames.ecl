export PersistNames(
	
	 string		pname								 = ''
	,boolean	pUseOtherEnvironment = false	//if true on dataland, use prod, if true on prod, use dataland

):=
module
		export root 	:= 	_dataset(puseotherenvironment).thor_cluster_persists + 'persist::' + _dataset().name + '::';
		export suffix :=  '::prepped::data';			
//For Future Products
//	export prepped_bankruptcyv2_main  		 		:=  dataset(root + 'bankruptcyv2_main'							+ suffix,prte_bip.layouts_bankruptcy.layout_main,thor);
//	export prepped_bankruptcyv2_search		 		:=  dataset(root + 'bankruptcyv2_search'						+ suffix,prte_bip.layouts_bankruptcy.layout_search,thor);
//	export prepped_busreg_companies			 			:=  dataset(root + 'busreg_companies'								+ suffix,prte_bip.layouts_busreg.companies,thor);
//	export prepped_busreg_contacts				 		:=  dataset(root + 'busreg_contacts'								+ suffix,prte_bip.layouts_busreg.contacts,thor);
//	export prepped_corp2_corporations		 			:=  dataset(root + 'corp2_corporations'							+ suffix,prte_bip.layouts_corp2.corporations,thor);
// 	export prepped_corp2_contacts  			 			:=  dataset(root + 'corp2_contacts'									+ suffix,prte_bip.layouts_corp2.contacts,thor);		
//	export prepped_corp2_events					 			:=  dataset(root + 'corp2_events'										+ suffix,prte_bip.layouts_corp2.events,thor);
//	export prepped_dcav2_companies  			 		:=  dataset(root + 'dcav2_companies'								+ suffix,prte_bip.layouts_dcav2.companies,thor);
//	export prepped_dcav2_contacts				 			:=  dataset(root + 'dcav2_contacts'									+ suffix,prte_bip.layouts_dcav2.contacts,thor);		
//	export prepped_dea  									 		:=  dataset(root + 'dea'														+ suffix,prte_bip.layouts_dea.base,thor);
//	export prepped_dnb_dmi_companies 					:=  dataset(root + 'dnb_dmi_companies'							+ suffix,prte_bip.layouts_dnb_dmi.companies,thor);
//	export prepped_dnb_dmi_contacts						:=  dataset(root + 'dnb_dmi_contacts'								+ suffix,prte_bip.layouts_dnb_dmi.contacts,thor);
//	export prepped_ebr_0010_header 						:=  dataset(root + 'ebr_0010'												+ suffix,prte_bip.layouts_ebr.layout_0010_header,thor);
//	export prepped_ebr_5600_demographic				:=  dataset(root + 'ebr_5600'												+ suffix,prte_bip.layouts_ebr.layout_5600_demographic,thor);
//	export prepped_ebr_5610_demographic				:=  dataset(root + 'ebr_5610'												+ suffix,prte_bip.layouts_ebr.layout_5610_demographic,thor);
		export prepped_faa  											:=  dataset(root + 'faa_aircraft_reg'				 				+ suffix,{prte_bip.layouts_faa.layout_faa_aircraft_reg_as_business_linking, unsigned8 __fpos { virtual (fileposition)}},thor);	
//	export prepped_gong_v2  									:=  dataset(root + 'gong_v2'												+ suffix,prte_bip.layouts_gongv2.layout_gong_history,thor);
//	export prepped_irs5500  							 		:=  dataset(root + 'irs5500'												+ suffix,prte_bip.layouts_irs5500.layout_irs5500_aid,thor);
//	export prepped_liensv2  							 		:=  dataset(root + 'liensv2'												+ suffix,prte_bip.layouts_liensv2.layout_liens_party,thor);
//	export prepped_ln_propertyv2_search  			:=  dataset(root + 'ln_propertyv2_search_did'				+ suffix,prte_bip.layouts_ln_propertyv2.layout_property_search,thor);
//	export prepped_ln_propertyv2_deed  				:=  dataset(root + 'ln_propertyv2_deed'							+ suffix,prte_bip.layouts_ln_propertyv2.layout_property_deed,thor);
//	export prepped_ln_propertyv2_assessment		:=  dataset(root + 'ln_propertyv2_assessor'					+ suffix,prte_bip.layouts_ln_propertyv2.layout_property_assessment,thor);
//	export prepped_ln_propertyv2_addl_deed 		:=  dataset(root + 'ln_propertyv2_addlfaresdeed'		+ suffix,prte_bip.layouts_ln_propertyv2.layout_property_addl_deed,thor);
//	export prepped_ln_propertyv2_addl_tax 		:=  dataset(root + 'ln_propertyv2_addlfarestax'			+ suffix,prte_bip.layouts_ln_propertyv2.layout_property_addl_tax,thor);		
//	export prepped_prof_license  				 			:=  dataset(root + 'prof_licensev2'									+ suffix,prte_bip.layouts_prof_licensev2.layout_base_with_tiers,thor);
//	export prepped_uccv2  								 		:=  dataset(root + 'uccv2'													+ suffix,prte_bip.layouts_uccv2.layout_party,thor);
//	export prepped_vehiclev2  						 		:=  dataset(root + 'vehiclev2'											+ suffix,prte_bip.layouts_vehiclev2.party_base_bip,thor);
//	export prepped_watercraft  					 			:=  dataset(root + 'watercraft'											+ suffix,prte_bip.layouts_watercraft.layout_watercraft_search_base,thor);

		export abl																:= root + pname + '::as_business_linking';
		export prepped														:= root + pname + suffix;
		export combined														:= root + pname;
		export dcombined													:= dataset(root + 'combined'			,layouts.base,thor);		
		export standardized												:= root + pname;	
		export dstandardized											:= dataset(root + 'standardized'	,layouts.base,thor);

		
end;