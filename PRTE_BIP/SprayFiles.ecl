import PRTE;

export SprayFiles(string pversion = '') := module

	export fSpraySlimFiles(string pname)	:=	function
	//-------------------------------------------------------------------------
  // Spray prte slim file
	//-------------------------------------------------------------------------				
		spray_all_slim_files := sequential(
																			 PRTE.SprayFiles(pversion,PRTE_BIP._Dataset().name).Create_Input_Superfiles(pname)
																			,PRTE.SprayFiles(pversion,PRTE_BIP._Dataset().name).Clear_Input_Superfiles(pname) 
																			,PRTE.SprayFiles(pversion,PRTE_BIP._Dataset().name).Spray_Raw_Data(pname,pname)															 
																			,PRTE.SprayFiles(pversion,PRTE_BIP._Dataset().name).Add_To_Superfiles(pname)	
																			);
																 
		return spray_all_slim_files;	
	end; //end fSpraySlimFiles

	export fSprayBaseFiles	:=	function
//-------------------------------------------------------------------------
// Spray all prte base files sequentially 
//-------------------------------------------------------------------------
		spray_all_base_files := sequential(/*
															 Create_Input_Superfiles('bankruptcyv2_main')
														  ,Create_Input_Superfiles('bankruptcyv2_search')
															,Create_Input_Superfiles('busreg_companies')
															,Create_Input_Superfiles('busreg_contacts')
															,Create_Input_Superfiles('corp2_contacts')
															,Create_Input_Superfiles('corp2_corporations')
															,Create_Input_Superfiles('corp2_events')
															,Create_Input_Superfiles('dcav2_companies')
															,Create_Input_Superfiles('dcav2_contacts')
															,Create_Input_Superfiles('dea')
															,Create_Input_Superfiles('dnb_dmi_companies')
															,Create_Input_Superfiles('dnb_dmi_contacts')															
															,Create_Input_Superfiles('ebr_0010_header')
															,Create_Input_Superfiles('ebr_5600_demographic_data')
															,Create_Input_Superfiles('ebr_5610_demographic_data')
															*/
															 PRTE.SprayFiles(pversion).Create_Input_Superfiles('faa_aircraft_reg');
															 PRTE.SprayFiles(pversion).Create_Input_Superfiles('busreg_aid');
															/*
															,Create_Input_Superfiles('gongv2_history')
															,Create_Input_Superfiles('header_santander')															
															,Create_Input_Superfiles('irs5500')
															,Create_Input_Superfiles('liensv2_party')
															,Create_Input_Superfiles('ln_propertyv2_search')
															,Create_Input_Superfiles('ln_propertyv2_deed')
															,Create_Input_Superfiles('ln_propertyv2_assessment')
															,Create_Input_Superfiles('ln_propertyv2_addl_fares_tax')
															,Create_Input_Superfiles('ln_propertyv2_addl_fares_deed')
															,Create_Input_Superfiles('prof_licensev2')
															,Create_Input_Superfiles('uccv2_party')
															,Create_Input_Superfiles('vehiclev2_party')
															,Create_Input_Superfiles('watercraft_search')											
														  ,Spray_Raw_Data('bankruptcyv2_main','bankruptcyv2_main.xml')
														  ,Spray_Raw_Data('bankruptcyv2_search','bankruptcyv2_search.csv')
															,Spray_Raw_Data('busreg_companies','busreg_companies.csv')
															,Spray_Raw_Data('busreg_contacts','busreg_contacts.csv')
															,Spray_Raw_Data('corp2_contacts','corp2_contacts.csv')
															,Spray_Raw_Data('corp2_corporations','corp2_corporations.csv')
															,Spray_Raw_Data('corp2_events','corp2_events.csv')
															,Spray_Raw_Data('dcav2_companies','dcav2_companies.csv')
															,Spray_Raw_Data('dcav2_contacts','dcav2_contacts.csv')
															,Spray_Raw_Data('dea','dea.csv')
															,Spray_Raw_Data('dnb_dmi_companies','dnb_dmi_companies.csv')
															,Spray_Raw_Data('dnb_dmi_contacts','dnb_dmi_contacts.csv')															
															,Spray_Raw_Data('ebr_0010_header','ebr_0010_header.csv')
															,Spray_Raw_Data('ebr_5600_demographic_data','ebr_5600_demographic_data.csv')
															,Spray_Raw_Data('ebr_5610_demographic_data','ebr_5610_demographic_data.csv')
															*/
															PRTE.SprayFiles(pversion).Spray_Raw_Data('faa__aircraft_reg_built','faa_aircraft_reg');
															PRTE.SprayFiles(pversion).Spray_Raw_Data('busreg_aid_built','busreg_aid');									
															//,Spray_Raw_Data('faa_aircraft_registration','faa_aircraft_registration.csv')
/*
															,Spray_Raw_Data('gongv2_history','gongv2_history.csv')
															,Spray_Raw_Data('header_santander','header_santander.csv')															
															,Spray_Raw_Data('irs5500','irs5500.csv')
															,Spray_Raw_Data('liensv2_party','liensv2_party.csv')
															,Spray_Raw_Data('ln_propertyv2_search','ln_propertyv2_search.csv')
															,Spray_Raw_Data('ln_propertyv2_deed','ln_propertyv2_deed.csv')
															,Spray_Raw_Data('ln_propertyv2_assessment','ln_propertyv2_assessment.csv')
															,Spray_Raw_Data('ln_propertyv2_addl_fares_tax','ln_propertyv2_addl_fares_tax.csv')
															,Spray_Raw_Data('ln_propertyv2_addl_fares_deed','ln_propertyv2_addl_fares_deed.csv')
															,Spray_Raw_Data('prof_licensev2','prof_licensev2.csv')
															,Spray_Raw_Data('uccv2_party','uccv2_party.csv')
															,Spray_Raw_Data('vehiclev2_party','vehiclev2_party.csv')
															,Spray_Raw_Data('watercraft_search','watercraft_search.csv')
															,Add_To_Superfiles('bankruptcyv2_main','bankruptcyv2_main.xml')
															,Add_To_Superfiles('bankruptcyv2_search','bankruptcyv2_search.csv')
															,Add_To_Superfiles('busreg_companies','busreg_companies.csv')
															,Add_To_Superfiles('busreg_contacts','busreg_contacts.csv')															
															,Add_To_Superfiles('corp2_contacts','corp2_contacts.csv')
															,Add_To_Superfiles('corp2_corporations','corp2_corporations.csv')
															,Add_To_Superfiles('corp2_events','corp2_events.csv')
															,Add_To_Superfiles('dcav2_companies','dcav2_companies.csv')
															,Add_To_Superfiles('dcav2_contacts','dcav2_contacts.csv')
															,Add_To_Superfiles('dea','dea.csv')
															,Add_To_Superfiles('dnb_dmi_companies','dnb_dmi_companies.csv')
															,Add_To_Superfiles('dnb_dmi_contacts','dnb_dmi_contacts.csv')															
															,Add_To_Superfiles('ebr_0010_header','ebr_0010_header.csv')
															,Add_To_Superfiles('ebr_5600_demographic_data','ebr_5600_demographic_data.csv')
															,Add_To_Superfiles('ebr_5610_demographic_data','ebr_5610_demographic_data.csv')
															 */
															 PRTE.SprayFiles(pversion).Add_To_Superfiles('faa_aircraft_reg');
															 PRTE.SprayFiles(pversion).Add_To_Superfiles('busreg_aid');
															//,Add_To_Superfiles('faa_aircraft_registration','faa_aircraft_registration.csv')
															 /*
															,Add_To_Superfiles('gongv2_history','gongv2_history.csv')
															,Add_To_Superfiles('header_santander','header_santander.csv')															
															,Add_To_Superfiles('irs5500','irs5500.csv')
															,Add_To_Superfiles('liensv2_party','liensv2_party.csv')
															,Add_To_Superfiles('ln_propertyv2_search','ln_propertyv2_search.csv')
															,Add_To_Superfiles('ln_propertyv2_deed','ln_propertyv2_deed.csv')
															,Add_To_Superfiles('ln_propertyv2_assessment','ln_propertyv2_assessment.csv')
															,Add_To_Superfiles('ln_propertyv2_addl_fares_tax','ln_propertyv2_addl_fares_tax.csv')
															,Add_To_Superfiles('ln_propertyv2_addl_fares_deed','ln_propertyv2_addl_fares_deed.csv')
															,Add_To_Superfiles('prof_licensev2','prof_licensev2.csv')
															,Add_To_Superfiles('uccv2_party','uccv2_party.csv')
															,Add_To_Superfiles('vehiclev2_party','vehiclev2_party.csv')
															,Add_To_Superfiles('watercraft_search','watercraft_search.csv')
															*/
															);
																
		return spray_all_base_files;
	end; //end fSprayBaseFiles

end;  //end SprayFiles