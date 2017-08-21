IMPORT tools, HMS_CSR;

EXPORT Files(STRING pversion = '', boolean pUseProd = false) := MODULE
 

   /* Input File Versions */
	 EXPORT address_input := dataset(Filenames(pversion,pUseProd).address_lInputTemplate, layouts.address_layout, csv( separator('\t'),heading(single), terminator(['\n', '\r\n']), quote(['\'','"'])));
	 EXPORT address_history := dataset(Filenames(pversion,pUseProd).address_lInputHistTemplate, layouts.address_layout, csv( separator('\t'),heading(single), terminator(['\n', '\r\n']), quote(['\'','"'])));
	 	 
	 EXPORT csr_input := dataset(Filenames(pversion,pUseProd).csr_lInputTemplate, layouts.csr_layout, csv( separator('\t'),heading(single), terminator(['\n', '\r\n']), quote(['\'','"'])));
	 EXPORT csr_history := dataset(Filenames(pversion,pUseProd).csr_lInputHistTemplate, layouts.csr_layout, csv( separator('\t'),heading(single), terminator(['\n', '\r\n']), quote(['\'','"'])));
	
	 EXPORT dea_input := dataset(Filenames(pversion,pUseProd).dea_lInputTemplate, layouts.dea_layout, csv( separator('\t'),heading(single), terminator(['\n', '\r\n']), quote(['\'','"'])));
	 EXPORT dea_history := dataset(Filenames(pversion,pUseProd).dea_lInputHistTemplate, layouts.dea_layout, csv( separator('\t'),heading(single), terminator(['\n', '\r\n']), quote(['\'','"'])));
	 
	 EXPORT disciplinaryact_input := dataset(Filenames(pversion,pUseProd).disciplinaryact_lInputTemplate, layouts.disciplinaryact_layout, csv( separator('\t'),heading(single), terminator(['\n', '\r\n']), quote(['\'','"'])));
	 EXPORT disciplinaryact_history := dataset(Filenames(pversion,pUseProd).disciplinaryact_lInputHistTemplate, layouts.disciplinaryact_layout, csv( separator('\t'),heading(single), terminator(['\n', '\r\n']), quote(['\'','"'])));
	 
	 EXPORT education_input := dataset(Filenames(pversion,pUseProd).education_lInputTemplate, layouts.education_layout, csv( separator('\t'),heading(single), terminator(['\n', '\r\n']), quote(['\'','"'])));
	 EXPORT education_history := dataset(Filenames(pversion,pUseProd).education_lInputHistTemplate, layouts.education_layout, csv( separator('\t'),heading(single), terminator(['\n', '\r\n']), quote(['\'','"'])));
	 
	 EXPORT entity_input := dataset(Filenames(pversion,pUseProd).entity_lInputTemplate, layouts.entity_layout, csv( separator('\t'),heading(single), terminator(['\n', '\r\n']), quote(['\'','"'])));
	 EXPORT entity_history := dataset(Filenames(pversion,pUseProd).entity_lInputHistTemplate, layouts.entity_layout, csv( separator('\t'),heading(single), terminator(['\n', '\r\n']), quote(['\'','"'])));
	 
	 EXPORT language_input := dataset(Filenames(pversion,pUseProd).language_lInputTemplate, layouts.language_layout, csv( separator('\t'),heading(single), terminator(['\n', '\r\n']), quote(['\'','"'])));
	 EXPORT language_history := dataset(Filenames(pversion,pUseProd).language_lInputHistTemplate, layouts.language_layout, csv( separator('\t'),heading(single), terminator(['\n', '\r\n']), quote(['\'','"'])));
	 
	 EXPORT license_input := dataset(Filenames(pversion,pUseProd).license_lInputTemplate, layouts.license_layout, csv( separator('\t'),heading(single), terminator(['\n', '\r\n']), quote(['\'','"'])));
	 EXPORT license_history := dataset(Filenames(pversion,pUseProd).license_lInputHistTemplate, layouts.license_layout, csv( separator('\t'),heading(single), terminator(['\n', '\r\n']), quote(['\'','"'])));
	 
	 EXPORT npi_input := dataset(Filenames(pversion,pUseProd).npi_lInputTemplate, layouts.npi_layout, csv( separator('\t'),heading(single), terminator(['\n', '\r\n']), quote(['\'','"'])));
	 EXPORT npi_history := dataset(Filenames(pversion,pUseProd).npi_lInputHistTemplate, layouts.npi_layout, csv( separator('\t'),heading(single), terminator(['\n', '\r\n']), quote(['\'','"'])));
	 
	 EXPORT phone_input := dataset(Filenames(pversion,pUseProd).phone_lInputTemplate, layouts.phone_layout, csv( separator('\t'),heading(single), terminator(['\n', '\r\n']), quote(['\'','"'])));
	 EXPORT phone_history := dataset(Filenames(pversion,pUseProd).phone_lInputHistTemplate, layouts.phone_layout, csv( separator('\t'),heading(single), terminator(['\n', '\r\n']), quote(['\'','"'])));
	 
	 EXPORT specialty_input := dataset(Filenames(pversion,pUseProd).specialty_lInputTemplate, layouts.specialty_layout, csv( separator('\t'),heading(single), terminator(['\n', '\r\n']), quote(['\'','"'])));
	 EXPORT specialty_history := dataset(Filenames(pversion,pUseProd).specialty_lInputHistTemplate, layouts.specialty_layout, csv( separator('\t'),heading(single), terminator(['\n', '\r\n']), quote(['\'','"'])));
	 
	 EXPORT medicaid_input := dataset(Filenames(pversion,pUseProd).medicaid_lInputTemplate, layouts.medicaid_layout, csv( separator('\t'),heading(single), terminator(['\n', '\r\n']), quote(['\'','"'])));
	 EXPORT medicaid_history := dataset(Filenames(pversion,pUseProd).medicaid_lInputHistTemplate, layouts.medicaid_layout, csv( separator('\t'),heading(single), terminator(['\n', '\r\n']), quote(['\'','"'])));
		
	 EXPORT taxonomy_input := dataset(Filenames(pversion,pUseProd).taxonomy_lInputTemplate, layouts.taxonomy_layout, csv( separator('\t'),heading(single), terminator(['\n', '\r\n']), quote(['\'','"'])));
	 EXPORT taxonomy_history := dataset(Filenames(pversion,pUseProd).taxonomy_lInputHistTemplate, layouts.taxonomy_layout, csv( separator('\t'),heading(single), terminator(['\n', '\r\n']), quote(['\'','"'])));	
	 
	 EXPORT stliclookup_input := dataset(Filenames(pversion,pUseProd).stliclookup_lInputTemplate, layouts.stliclookup_layout, csv( separator('\t'),heading(single), terminator(['\n', '\r\n']), quote(['\'','"'])));
	 
	 /* Base File Versions */
   tools.mac_FilesBase(Filenames(pversion,pUseProd).address_Base, HMS_CSR.layouts.address_base, address_Base);
	 tools.mac_FilesBase(Filenames(pversion,pUseProd).csr_Base, HMS_CSR.layouts.csr_base, csr_Base);
 	 tools.mac_FilesBase(Filenames(pversion,pUseProd).dea_Base, HMS_CSR.layouts.dea_base, dea_base);
	 tools.mac_FilesBase(Filenames(pversion,pUseProd).disciplinaryact_Base, HMS_CSR.layouts.disciplinaryact_base, disciplinaryact_Base);
	 tools.mac_FilesBase(Filenames(pversion,pUseProd).education_Base, HMS_CSR.layouts.education_base, education_Base);
	 tools.mac_FilesBase(Filenames(pversion,pUseProd).entity_Base, HMS_CSR.layouts.entity_base, entity_Base);
	 tools.mac_FilesBase(Filenames(pversion,pUseProd).language_Base, HMS_CSR.layouts.language_base, language_Base);
 	 tools.mac_FilesBase(Filenames(pversion,pUseProd).license_Base, HMS_CSR.layouts.license_base, license_Base);
	 tools.mac_FilesBase(Filenames(pversion,pUseProd).npi_Base, HMS_CSR.layouts.npi_base, npi_Base);
	 tools.mac_FilesBase(Filenames(pversion,pUseProd).phone_Base, HMS_CSR.layouts.phone_base, phone_Base);
	 tools.mac_FilesBase(Filenames(pversion,pUseProd).specialty_Base, HMS_CSR.layouts.specialty_base, specialty_Base);
	 // tools.mac_FilesBase(Filenames(pversion,pUseProd).medicaid_Base, HMS_CSR.layouts.medicaid_base, medicaid_Base);
	 // tools.mac_FilesBase(Filenames(pversion,pUseProd).taxonomy_Base, HMS_CSR.layouts.taxonomy_base, taxonomy_Base);
	 tools.mac_FilesBase(Filenames(pversion,pUseProd).csrcredential_Base, HMS_CSR.layouts.csrcredential_base, csrcredential_Base);	 
	/* Keybuild File */
   //versioncontrol.macBuildFileVersions(Filenames(pversion).keybuild, layouts.keybuild, keybuild); 
	 
END;