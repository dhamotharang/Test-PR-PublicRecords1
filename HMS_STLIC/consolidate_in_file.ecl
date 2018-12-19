IMPORT HMS_STLIC, ut;

EXPORT Consolidate_In_File (string pVersion, boolean pUseProd):= FUNCTION

		//ADDRESS
		address_consol_layout := RECORD
			HMS_STLIC.layouts.address_layout;
			string75 filename := '';
		END;
		
		prv_addr_file := '~' + FileServices.GetSuperFileSubName(HMS_STLIC.Filenames(pVersion,pUseProd).address_lInputHistTemplate,1);
		
		con_addr_file := DATASET(prv_addr_file,address_consol_layout,THOR);
		
		raw_addr_file			:= DATASET(HMS_STLIC.Filenames(pVersion,pUseProd).address_lInputTemplate, 
																{HMS_STLIC.layouts.address_layout,string75 filename {virtual(logicalfilename)}},
																csv(terminator(['\r\n','\n']), separator(['\t']), quote(['']),heading(1))
																);
	
		tr_raw_addr_file := PROJECT(raw_addr_file, TRANSFORM(address_consol_layout, self := left));
		
		new_con_addr_file := IF(NOTHOR(FileServices.GetSuperFileSubCount(HMS_STLIC.Filenames(pversion,pUseProd).address_lInputHistTemplate)) = 0
												 ,tr_raw_addr_file
												 ,tr_raw_addr_file + con_addr_file);
		
 			
		ouput_addr_file :=  OUTPUT(new_con_addr_file,,'~thor400_data::in::hms_stl::hms_address::' + pVersion, 
   							 THOR,OVERWRITE,compressed);
		//LICENSE
		license_consol_layout := RECORD
			HMS_STLIC.layouts.license_layout;
			string75 filename := '';
		END;
		
		prv_lic_file := '~' + FileServices.GetSuperFileSubName(HMS_STLIC.Filenames(pVersion,pUseProd).license_lInputHistTemplate,1);
		
		con_lic_file := DATASET(prv_lic_file,license_consol_layout,THOR);
		
		raw_lic_file			:= DATASET(HMS_STLIC.Filenames(pVersion,pUseProd).license_lInputTemplate, 
																{HMS_STLIC.layouts.license_layout,string75 filename {virtual(logicalfilename)}},
																csv(terminator(['\r\n','\n']), separator(['\t']), quote(['']),heading(1))
																);
	
		tr_raw_lic_file := PROJECT(raw_lic_file, TRANSFORM(license_consol_layout, self := left));
		
		new_con_lic_file := IF(NOTHOR(FileServices.GetSuperFileSubCount(HMS_STLIC.Filenames(pversion,pUseProd).license_lInputHistTemplate)) = 0
												 ,tr_raw_lic_file
												 ,tr_raw_lic_file + con_lic_file);
		
 			
		ouput_lic_file :=  OUTPUT(new_con_lic_file,,'~thor400_data::in::hms_stl::hms_license::' + pVersion, 
   							 THOR,OVERWRITE,compressed);
								 
		//ENTITY
		entity_consol_layout := RECORD
			HMS_STLIC.layouts.entity_layout;
			string75 filename := '';
		END;
		
		prv_ent_file := '~' + FileServices.GetSuperFileSubName(HMS_STLIC.Filenames(pVersion,pUseProd).entity_lInputHistTemplate,1);
		
		con_ent_file := DATASET(prv_ent_file,entity_consol_layout,THOR);
		
		raw_ent_file			:= DATASET(HMS_STLIC.Filenames(pVersion,pUseProd).entity_lInputTemplate, 
																{HMS_STLIC.layouts.entity_layout,string75 filename {virtual(logicalfilename)}},
																csv(terminator(['\r\n','\n']), separator(['\t']), quote(['']),heading(1))
																);
	
		tr_raw_ent_file := PROJECT(raw_ent_file, TRANSFORM(entity_consol_layout, self := left));
		
		new_con_ent_file := IF(NOTHOR(FileServices.GetSuperFileSubCount(HMS_STLIC.Filenames(pversion,pUseProd).entity_lInputHistTemplate)) = 0
												 ,tr_raw_ent_file
												 ,tr_raw_ent_file + con_ent_file);
		
 			
		ouput_ent_file :=  OUTPUT(new_con_ent_file,,'~thor400_data::in::hms_stl::hms_entity::' + pVersion, 
   							 THOR,OVERWRITE,compressed);
								 
		//CSR
		csr_consol_layout := RECORD
			HMS_STLIC.layouts.csr_layout;
			string75 filename := '';
		END;
		
		prv_csr_file := '~' + FileServices.GetSuperFileSubName(HMS_STLIC.Filenames(pVersion,pUseProd).csr_lInputHistTemplate,1);
		
		con_csr_file := DATASET(prv_csr_file,csr_consol_layout,THOR);
		
		raw_csr_file			:= DATASET(HMS_STLIC.Filenames(pVersion,pUseProd).csr_lInputTemplate, 
																{HMS_STLIC.layouts.csr_layout,string75 filename {virtual(logicalfilename)}},
																csv(terminator(['\r\n','\n']), separator(['\t']), quote(['']),heading(1))
																);
	
		tr_raw_csr_file := PROJECT(raw_csr_file, TRANSFORM(csr_consol_layout, self := left));
		
		new_con_csr_file := IF(NOTHOR(FileServices.GetSuperFileSubCount(HMS_STLIC.Filenames(pversion,pUseProd).csr_lInputHistTemplate)) = 0
												 ,tr_raw_csr_file
												 ,tr_raw_csr_file + con_csr_file);
		
				
		ouput_csr_file :=  OUTPUT(new_con_csr_file,,'~thor400_data::in::hms_stl::hms_csr::' + pVersion, 
									 THOR,OVERWRITE,compressed);
   								 
		//DEA
		dea_consol_layout := RECORD
			HMS_STLIC.layouts.dea_layout;
			string75 filename := '';
		END;
		
		prv_dea_file := '~' + FileServices.GetSuperFileSubName(HMS_STLIC.Filenames(pVersion,pUseProd).dea_lInputHistTemplate,1);
		
		con_dea_file := DATASET(prv_dea_file,dea_consol_layout,THOR);
		
		raw_dea_file			:= DATASET(HMS_STLIC.Filenames(pVersion,pUseProd).dea_lInputTemplate, 
																{HMS_STLIC.layouts.dea_layout,string75 filename {virtual(logicalfilename)}},
																csv(terminator(['\r\n','\n']), separator(['\t']), quote(['']),heading(1))
																);
	
		tr_raw_dea_file := PROJECT(raw_dea_file, TRANSFORM(dea_consol_layout, self := left));
		
		new_con_dea_file := IF(NOTHOR(FileServices.GetSuperFileSubCount(HMS_STLIC.Filenames(pversion,pUseProd).dea_lInputHistTemplate)) = 0
												 ,tr_raw_dea_file
												 ,tr_raw_dea_file + con_dea_file);
		
				
		ouput_dea_file :=  OUTPUT(new_con_dea_file,,'~thor400_data::in::hms_stl::hms_dea::' + pVersion, 
									 THOR,OVERWRITE,compressed);

		
		//NPI
		npi_consol_layout := RECORD
			HMS_STLIC.layouts.npi_layout;
			string75 filename := '';
		END;
		
		prv_npi_file := '~' + FileServices.GetSuperFileSubName(HMS_STLIC.Filenames(pVersion,pUseProd).npi_lInputHistTemplate,1);
		
		con_npi_file := DATASET(prv_npi_file,npi_consol_layout,THOR);
		
		raw_npi_file			:= DATASET(HMS_STLIC.Filenames(pVersion,pUseProd).npi_lInputTemplate, 
																{HMS_STLIC.layouts.npi_layout,string75 filename {virtual(logicalfilename)}},
																csv(terminator(['\r\n','\n']), separator(['\t']), quote(['']),heading(1))
																);
	
		tr_raw_npi_file := PROJECT(raw_npi_file, TRANSFORM(npi_consol_layout, self := left));
		
		new_con_npi_file := IF(NOTHOR(FileServices.GetSuperFileSubCount(HMS_STLIC.Filenames(pversion,pUseProd).npi_lInputHistTemplate)) = 0
												 ,tr_raw_npi_file
												 ,tr_raw_npi_file + con_npi_file);
		
				
		ouput_npi_file :=  OUTPUT(new_con_npi_file,,'~thor400_data::in::hms_stl::hms_npi::' + pVersion, 
									 THOR,OVERWRITE,compressed);
										 
										 
		//PHONE
		phone_consol_layout := RECORD
			HMS_STLIC.layouts.phone_layout;
			string75 filename := '';
		END;
		
		prv_phone_file := '~' + FileServices.GetSuperFileSubName(HMS_STLIC.Filenames(pVersion,pUseProd).phone_lInputHistTemplate,1);
		
		con_phone_file := DATASET(prv_phone_file,phone_consol_layout,THOR);
		
		raw_phone_file			:= DATASET(HMS_STLIC.Filenames(pVersion,pUseProd).phone_lInputTemplate, 
																{HMS_STLIC.layouts.phone_layout,string75 filename {virtual(logicalfilename)}},
																csv(terminator(['\r\n','\n']), separator(['\t']), quote(['']),heading(1))
																);
	
		tr_raw_phone_file := PROJECT(raw_phone_file, TRANSFORM(phone_consol_layout, self := left));
		
		new_con_phone_file := IF(NOTHOR(FileServices.GetSuperFileSubCount(HMS_STLIC.Filenames(pversion,pUseProd).phone_lInputHistTemplate)) = 0
												 ,tr_raw_phone_file
												 ,tr_raw_phone_file + con_phone_file);
		
				
		ouput_phone_file :=  OUTPUT(new_con_phone_file,,'~thor400_data::in::hms_stl::hms_phone::' + pVersion, 
									 THOR,OVERWRITE,compressed);
										 
		//LANGUAGE
		language_consol_layout := RECORD
			HMS_STLIC.layouts.language_layout;
			string75 filename := '';
		END;
		
		prv_language_file := '~' + FileServices.GetSuperFileSubName(HMS_STLIC.Filenames(pVersion,pUseProd).language_lInputHistTemplate,1);
		
		con_language_file := DATASET(prv_language_file,language_consol_layout,THOR);
		
		raw_language_file			:= DATASET(HMS_STLIC.Filenames(pVersion,pUseProd).language_lInputTemplate, 
																{HMS_STLIC.layouts.language_layout,string75 filename {virtual(logicalfilename)}},
																csv(terminator(['\r\n','\n']), separator(['\t']), quote(['']),heading(1))
																);
	
		tr_raw_language_file := PROJECT(raw_language_file, TRANSFORM(language_consol_layout, self := left));
		
		new_con_language_file := IF(NOTHOR(FileServices.GetSuperFileSubCount(HMS_STLIC.Filenames(pversion,pUseProd).language_lInputHistTemplate)) = 0
												 ,tr_raw_language_file
												 ,tr_raw_language_file + con_language_file);
		
				
		ouput_language_file :=  OUTPUT(new_con_language_file,,'~thor400_data::in::hms_stl::hms_language::' + pVersion, 
									 THOR,OVERWRITE,compressed);
										 
			
		//EDUCATION
		education_consol_layout := RECORD
			HMS_STLIC.layouts.education_layout;
			string75 filename := '';
		END;
		
		prv_education_file := '~' + FileServices.GetSuperFileSubName(HMS_STLIC.Filenames(pVersion,pUseProd).education_lInputHistTemplate,1);
		
		con_education_file := DATASET(prv_education_file,education_consol_layout,THOR);
		
		raw_education_file			:= DATASET(HMS_STLIC.Filenames(pVersion,pUseProd).education_lInputTemplate, 
																{HMS_STLIC.layouts.education_layout,string75 filename {virtual(logicalfilename)}},
																csv(terminator(['\r\n','\n']), separator(['\t']), quote(['']),heading(1))
																);
	
		tr_raw_education_file := PROJECT(raw_education_file, TRANSFORM(education_consol_layout, self := left));
		
		new_con_education_file := IF(NOTHOR(FileServices.GetSuperFileSubCount(HMS_STLIC.Filenames(pversion,pUseProd).education_lInputHistTemplate)) = 0
												 ,tr_raw_education_file
												 ,tr_raw_education_file + con_education_file);
		
				
		ouput_education_file :=  OUTPUT(new_con_education_file,,'~thor400_data::in::hms_stl::hms_education::' + pVersion, 
									 THOR,OVERWRITE,compressed);
										 
										 
		//SPECIALTY
		specialty_consol_layout := RECORD
			HMS_STLIC.layouts.specialty_layout;
			string75 filename := '';
		END;
		
		prv_specialty_file := '~' + FileServices.GetSuperFileSubName(HMS_STLIC.Filenames(pVersion,pUseProd).specialty_lInputHistTemplate,1);
		
		con_specialty_file := DATASET(prv_specialty_file,specialty_consol_layout,THOR);
		
		raw_specialty_file			:= DATASET(HMS_STLIC.Filenames(pVersion,pUseProd).specialty_lInputTemplate, 
																{HMS_STLIC.layouts.specialty_layout,string75 filename {virtual(logicalfilename)}},
																csv(terminator(['\r\n','\n']), separator(['\t']), quote(['']),heading(1))
																);
	
		tr_raw_specialty_file := PROJECT(raw_specialty_file, TRANSFORM(specialty_consol_layout, self := left));
		
		new_con_specialty_file := IF(NOTHOR(FileServices.GetSuperFileSubCount(HMS_STLIC.Filenames(pversion,pUseProd).specialty_lInputHistTemplate)) = 0
												 ,tr_raw_specialty_file
												 ,tr_raw_specialty_file + con_specialty_file);
		
				
		ouput_specialty_file :=  OUTPUT(new_con_specialty_file,,'~thor400_data::in::hms_stl::hms_specialty::' + pVersion, 
									 THOR,OVERWRITE,compressed);
										 
										 
		//DISCIPLINARYACT
		disciplinaryact_consol_layout := RECORD
			HMS_STLIC.layouts.disciplinaryact_layout;
			string75 filename := '';
		END;
		
		prv_disciplinaryact_file := '~' + FileServices.GetSuperFileSubName(HMS_STLIC.Filenames(pVersion,pUseProd).disciplinaryact_lInputHistTemplate,1);
		
		con_disciplinaryact_file := DATASET(prv_disciplinaryact_file,disciplinaryact_consol_layout,THOR);
		
		raw_disciplinaryact_file			:= DATASET(HMS_STLIC.Filenames(pVersion,pUseProd).disciplinaryact_lInputTemplate, 
																{HMS_STLIC.layouts.disciplinaryact_layout,string75 filename {virtual(logicalfilename)}},
																csv(terminator(['\r\n','\n']), separator(['\t']), quote(['']),heading(1))
																);
	
		tr_raw_disciplinaryact_file := PROJECT(raw_disciplinaryact_file, TRANSFORM(disciplinaryact_consol_layout, self := left));
		
		new_con_disciplinaryact_file := IF(NOTHOR(FileServices.GetSuperFileSubCount(HMS_STLIC.Filenames(pversion,pUseProd).disciplinaryact_lInputHistTemplate)) = 0
												 ,tr_raw_disciplinaryact_file
												 ,tr_raw_disciplinaryact_file + con_disciplinaryact_file);
		
				
		ouput_disciplinaryact_file :=  OUTPUT(new_con_disciplinaryact_file,,'~thor400_data::in::hms_stl::hms_disciplinaryact::' + pVersion, 
									 THOR,OVERWRITE,compressed);
		
			//STLICLOOKUP
		stliclookup_consol_layout := RECORD
			HMS_STLIC.layouts.stliclookup_layout;
			string75 filename := '';
		END;
		
		prv_stliclookup_file := '~' + FileServices.GetSuperFileSubName(HMS_STLIC.Filenames(pVersion,pUseProd).stliclookup_lInputHistTemplate,1);
		
		con_stliclookup_file := DATASET(prv_stliclookup_file,stliclookup_consol_layout,THOR);
		
		raw_stliclookup_file			:= DATASET(HMS_STLIC.Filenames(pVersion,pUseProd).stliclookup_lInputTemplate, 
																{HMS_STLIC.layouts.stliclookup_layout,string75 filename {virtual(logicalfilename)}},
																csv(terminator(['\r\n','\n']), separator(['\t']), quote(['']),heading(1))
																);
	
		tr_raw_stliclookup_file := PROJECT(raw_stliclookup_file, TRANSFORM(stliclookup_consol_layout, self := left));
		
		new_con_stliclookup_file := IF(NOTHOR(FileServices.GetSuperFileSubCount(HMS_STLIC.Filenames(pversion,pUseProd).stliclookup_lInputHistTemplate)) = 0
												 ,tr_raw_stliclookup_file
												 ,tr_raw_stliclookup_file + con_stliclookup_file);
		
				
		ouput_stliclookup_file :=  OUTPUT(new_con_stliclookup_file,,'~thor400_data::in::hms_stl::hms_stliclookup::' + pVersion, 
									 THOR,OVERWRITE,compressed);
		
		write	:= sequential(
									ouput_addr_file,
									ouput_lic_file,
									ouput_ent_file,
									ouput_csr_file,
									ouput_dea_file,
									ouput_education_file,
									ouput_npi_file,
									ouput_phone_file,
									ouput_language_file,
									ouput_specialty_file,
									ouput_disciplinaryact_file,
									ouput_stliclookup_file					
				);
					
		return write;
				
		/* 		ut.MAC_SF_BuildProcess(new_con_addr_file,'~thor400_data::in::hms_stl::hms_address::history', build_it,2,,true);
   		return build_it;
		*/
END;

