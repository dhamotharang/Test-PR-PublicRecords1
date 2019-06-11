IMPORT Address, BIPV2, AID, HMS_STLIC;
EXPORT Preprocessor := MODULE

// added to build to remove new fields in input file that are not wanted in the base file or keys
// "preprocessing" to remove these fields and write the modified input file back to thor as "in"
// files in the format the build is expecting.

	EXPORT Infile_Preprocessor(string pversion, boolean pUseProd)	:= MODULE

		EXPORT Prepped_Address_file	:= FUNCTION
			std_input := project(Files(pversion,pUseProd).address_input_new, 
				transform(layouts.address_layout, self := Left, self := []));
			return std_input;
		END;
		
		EXPORT Prepped_CSR_file	:= FUNCTION
			std_input := project(Files(pversion,pUseProd).csr_input_new, 
				transform(layouts.csr_layout, self := Left, self := []));
			return std_input;
		END;
		
		EXPORT Prepped_DEA_file	:= FUNCTION
			std_input := project(Files(pversion,pUseProd).dea_input_new, 
				transform(layouts.dea_layout, self := Left, self := []));
			return std_input;
		END;
		
		EXPORT Prepped_Disciplinaryact_file	:= FUNCTION
			std_input := project(Files(pversion,pUseProd).disciplinaryact_input_new, 
				transform(layouts.disciplinaryact_layout, self := Left, self := []));
			return std_input;
		END;
		
		EXPORT Prepped_Education_file	:= FUNCTION
			std_input := project(Files(pversion,pUseProd).education_input_new, 
				transform(layouts.education_layout, self := Left, self := []));
			return std_input;
		END;
		
		EXPORT Prepped_Entity_file	:= FUNCTION
			std_input := project(Files(pversion,pUseProd).entity_input_new, 
				transform(layouts.entity_layout, self := Left, self := []));
			return std_input;
		END;
		
		EXPORT Prepped_Language_file	:= FUNCTION
			std_input := project(Files(pversion,pUseProd).language_input_new, 
				transform(layouts.language_layout, self := Left, self := []));
			return std_input;
		END;
		
		EXPORT Prepped_License_file	:= FUNCTION
			std_input := project(Files(pversion,pUseProd).license_input_new, 
				transform(layouts.license_layout, self := Left, self := []));
			return std_input;
		END;

		EXPORT Prepped_NPI_file	:= FUNCTION
			std_input := project(Files(pversion,pUseProd).npi_input_new, 
				transform(layouts.npi_layout, self := Left, self := []));
			return std_input;
		END;

		EXPORT Prepped_Phone_file	:= FUNCTION
			std_input := project(Files(pversion,pUseProd).phone_input_new, 
				transform(layouts.phone_layout, self := Left, self := []));
			return std_input;
		END;
		
		EXPORT Prepped_Specialty_file	:= FUNCTION
			std_input := project(Files(pversion,pUseProd).specialty_input_new, 
				transform(layouts.specialty_layout, self := Left, self := []));
			return std_input;
		END;

		EXPORT Prepped_Statelicense_file	:= FUNCTION
			std_input := project(Files(pversion,pUseProd).statelicense_input_new, 
				transform(layouts.statelicense_layout, self := Left, self := []));
			return std_input;
		END;
		
		EXPORT Prepped_Stliclookup_file	:= FUNCTION
			std_input := project(Files(pversion,pUseProd).stliclookup_input_new, 
				transform(layouts.stliclookup_layout, self := Left, self := []));
			return std_input;
		END;
		
	END; // end prepping files
	
	EXPORT Run_the_prep (string pversion, boolean pUseProd)	:= MODULE
		shared	addr_file 	:= Infile_Preprocessor(pversion,puseprod).Prepped_address_file;
		shared	csr_file		:= Infile_Preprocessor(pversion,puseprod).Prepped_csr_file;
		shared	dea_file		:= Infile_Preprocessor(pversion,puseprod).Prepped_dea_file;
		shared	disc_file		:= Infile_Preprocessor(pversion,puseprod).Prepped_disciplinaryact_file;
		shared	edu_file		:= Infile_Preprocessor(pversion,puseprod).Prepped_education_file;
		shared	entity_file	:= Infile_Preprocessor(pversion,puseprod).Prepped_entity_file;
		shared	lang_file		:= Infile_Preprocessor(pversion,puseprod).Prepped_language_file;
		shared	lic_file		:= Infile_Preprocessor(pversion,puseprod).Prepped_license_file;
		shared	npi_file		:= Infile_Preprocessor(pversion,puseprod).Prepped_npi_file;
		shared	phone_file	:= Infile_Preprocessor(pversion,puseprod).Prepped_phone_file;
		shared	spec_file		:= Infile_Preprocessor(pversion,puseprod).Prepped_specialty_file;
		shared	stliclu_file:= Infile_Preprocessor(pversion,puseprod).Prepped_stliclookup_file;
		
		EXPORT write_them := FUNCTION
			do_it	:= sequential(
			output(addr_file,,HMS_STLIC.Filenames(pversion,puseprod).address_lInputTemplate,overwrite,compressed,csv( separator('\t'),heading(single), terminator(['\n', '\r\n']), quote(['\'','"']))),			
			output(csr_file,,HMS_STLIC.Filenames(pversion,puseprod).csr_lInputTemplate,overwrite,compressed,csv( separator('\t'),heading(single), terminator(['\n', '\r\n']), quote(['\'','"']))),
			output(dea_file,,HMS_STLIC.Filenames(pversion,puseprod).dea_lInputTemplate,overwrite,compressed,csv( separator('\t'),heading(single), terminator(['\n', '\r\n']), quote(['\'','"']))),
			output(disc_file,,HMS_STLIC.Filenames(pversion,puseprod).disciplinaryact_lInputTemplate,overwrite,compressed,csv( separator('\t'),heading(single), terminator(['\n', '\r\n']), quote(['\'','"']))),
			output(edu_file,,HMS_STLIC.Filenames(pversion,puseprod).education_lInputTemplate,overwrite,compressed,csv( separator('\t'),heading(single), terminator(['\n', '\r\n']), quote(['\'','"']))),
			output(entity_file,,HMS_STLIC.Filenames(pversion,puseprod).entity_lInputTemplate,overwrite,compressed,csv( separator('\t'),heading(single), terminator(['\n', '\r\n']), quote(['\'','"']))),
			output(lang_file,,HMS_STLIC.Filenames(pversion,puseprod).language_lInputTemplate,overwrite,compressed,csv( separator('\t'),heading(single), terminator(['\n', '\r\n']), quote(['\'','"']))),
			output(lic_file,,HMS_STLIC.Filenames(pversion,puseprod).license_lInputTemplate,overwrite,compressed,csv( separator('\t'),heading(single), terminator(['\n', '\r\n']), quote(['\'','"']))),
			output(npi_file,,HMS_STLIC.Filenames(pversion,puseprod).npi_lInputTemplate,overwrite,compressed,csv( separator('\t'),heading(single), terminator(['\n', '\r\n']), quote(['\'','"']))),
			output(phone_file,,HMS_STLIC.Filenames(pversion,puseprod).phone_lInputTemplate,overwrite,compressed,csv( separator('\t'),heading(single), terminator(['\n', '\r\n']), quote(['\'','"']))),
			output(spec_file,,HMS_STLIC.Filenames(pversion,puseprod).specialty_lInputTemplate,overwrite,compressed,csv( separator('\t'),heading(single), terminator(['\n', '\r\n']), quote(['\'','"']))),
			output(stliclu_file,,HMS_STLIC.Filenames(pversion,puseprod).stliclookup_lInputTemplate,overwrite,compressed,csv( separator('\t'),heading(single), terminator(['\n', '\r\n']), quote(['\'','"']))));
			
			return do_it;				
		END;
	END;
END;//final end
