IMPORT tools, HMS_STLIC;

EXPORT Files(STRING pversion = '', boolean pUseProd = false) := MODULE
 

   /* Input File Versions */
	 EXPORT address_input := dataset(Filenames(pversion,pUseProd).address_lInputTemplate, layouts.address_layout, csv( separator('\t'),heading(single), terminator(['\n', '\r\n']), quote(['\'','"'])));
	 EXPORT address_history := dataset(Filenames(pversion,pUseProd).address_lInputHistTemplate, layouts.address_layout, csv( separator('\t'),heading(single), terminator(['\n', '\r\n']), quote(['\'','"'])));
	 EXPORT address_input_new := dataset(Filenames(pversion,pUseProd).address_new_lInputTemplate, layouts.address_layout_new, csv( separator('\t'),heading(single), terminator(['\n', '\r\n']), quote(['\'','"'])));	 
	 	 
	 EXPORT csr_input := dataset(Filenames(pversion,pUseProd).csr_lInputTemplate, layouts.csr_layout, csv( separator('\t'),heading(single), terminator(['\n', '\r\n']), quote(['\'','"'])));
	 EXPORT csr_history := dataset(Filenames(pversion,pUseProd).csr_lInputHistTemplate, layouts.csr_layout, csv( separator('\t'),heading(single), terminator(['\n', '\r\n']), quote(['\'','"'])));
	 EXPORT csr_input_new := dataset(Filenames(pversion,pUseProd).csr_new_lInputTemplate, layouts.csr_layout_new, csv( separator('\t'),heading(single), terminator(['\n', '\r\n']), quote(['\'','"'])));
	
	 EXPORT dea_input := dataset(Filenames(pversion,pUseProd).dea_lInputTemplate, layouts.dea_layout, csv( separator('\t'),heading(single), terminator(['\n', '\r\n']), quote(['\'','"'])));
	 EXPORT dea_history := dataset(Filenames(pversion,pUseProd).dea_lInputHistTemplate, layouts.dea_layout, csv( separator('\t'),heading(single), terminator(['\n', '\r\n']), quote(['\'','"'])));
	 EXPORT dea_input_new := dataset(Filenames(pversion,pUseProd).dea_new_lInputTemplate, layouts.dea_layout_new, csv( separator('\t'),heading(single), terminator(['\n', '\r\n']), quote(['\'','"'])));
	 
	 EXPORT disciplinaryact_input := dataset(Filenames(pversion,pUseProd).disciplinaryact_lInputTemplate, layouts.disciplinaryact_layout, csv( separator('\t'),heading(single), terminator(['\n', '\r\n']), quote(['\'','"'])));
	 EXPORT disciplinaryact_history := dataset(Filenames(pversion,pUseProd).disciplinaryact_lInputHistTemplate, layouts.disciplinaryact_layout, csv( separator('\t'),heading(single), terminator(['\n', '\r\n']), quote(['\'','"'])));
	 EXPORT disciplinaryact_input_new := dataset(Filenames(pversion,pUseProd).disciplinaryact_new_lInputTemplate, layouts.disciplinaryact_layout_new, csv( separator('\t'),heading(single), terminator(['\n', '\r\n']), quote(['\'','"'])));
	 
	 EXPORT education_input := dataset(Filenames(pversion,pUseProd).education_lInputTemplate, layouts.education_layout, csv( separator('\t'),heading(single), terminator(['\n', '\r\n']), quote(['\'','"'])));
	 EXPORT education_history := dataset(Filenames(pversion,pUseProd).education_lInputHistTemplate, layouts.education_layout, csv( separator('\t'),heading(single), terminator(['\n', '\r\n']), quote(['\'','"'])));
	 EXPORT education_input_new := dataset(Filenames(pversion,pUseProd).education_new_lInputTemplate, layouts.education_layout_new, csv( separator('\t'),heading(single), terminator(['\n', '\r\n']), quote(['\'','"'])));
	 
	 EXPORT entity_input := dataset(Filenames(pversion,pUseProd).entity_lInputTemplate, layouts.entity_layout, csv( separator('\t'),heading(single), terminator(['\n', '\r\n']), quote(['\'','"'])));
	 EXPORT entity_history := dataset(Filenames(pversion,pUseProd).entity_lInputHistTemplate, layouts.entity_layout, csv( separator('\t'),heading(single), terminator(['\n', '\r\n']), quote(['\'','"'])));
	 EXPORT entity_input_new := dataset(Filenames(pversion,pUseProd).entity_new_lInputTemplate, layouts.entity_layout_new, csv( separator('\t'),heading(single), terminator(['\n', '\r\n']), quote(['\'','"'])));
	 
	 EXPORT language_input := dataset(Filenames(pversion,pUseProd).language_lInputTemplate, layouts.language_layout, csv( separator('\t'),heading(single), terminator(['\n', '\r\n']), quote(['\'','"'])));
	 EXPORT language_history := dataset(Filenames(pversion,pUseProd).language_lInputHistTemplate, layouts.language_layout, csv( separator('\t'),heading(single), terminator(['\n', '\r\n']), quote(['\'','"'])));
	 EXPORT language_input_new := dataset(Filenames(pversion,pUseProd).language_new_lInputTemplate, layouts.language_layout_new, csv( separator('\t'),heading(single), terminator(['\n', '\r\n']), quote(['\'','"'])));
	 
	 EXPORT license_input := dataset(Filenames(pversion,pUseProd).license_lInputTemplate, layouts.license_layout, csv( separator('\t'),heading(single), terminator(['\n', '\r\n']), quote(['\'','"'])));
	 EXPORT license_history := dataset(Filenames(pversion,pUseProd).license_lInputHistTemplate, layouts.license_layout, csv( separator('\t'),heading(single), terminator(['\n', '\r\n']), quote(['\'','"'])));
	 EXPORT license_input_new := dataset(Filenames(pversion,pUseProd).license_new_lInputTemplate, layouts.license_layout_new, csv( separator('\t'),heading(single), terminator(['\n', '\r\n']), quote(['\'','"'])));
	 
	 EXPORT npi_input := dataset(Filenames(pversion,pUseProd).npi_lInputTemplate, layouts.npi_layout, csv( separator('\t'),heading(single), terminator(['\n', '\r\n']), quote(['\'','"'])));
	 EXPORT npi_history := dataset(Filenames(pversion,pUseProd).npi_lInputHistTemplate, layouts.npi_layout, csv( separator('\t'),heading(single), terminator(['\n', '\r\n']), quote(['\'','"'])));
	 EXPORT npi_input_new := dataset(Filenames(pversion,pUseProd).npi_new_lInputTemplate, layouts.npi_layout_new, csv( separator('\t'),heading(single), terminator(['\n', '\r\n']), quote(['\'','"'])));
	 
	 EXPORT phone_input := dataset(Filenames(pversion,pUseProd).phone_lInputTemplate, layouts.phone_layout, csv( separator('\t'),heading(single), terminator(['\n', '\r\n']), quote(['\'','"'])));
	 EXPORT phone_history := dataset(Filenames(pversion,pUseProd).phone_lInputHistTemplate, layouts.phone_layout, csv( separator('\t'),heading(single), terminator(['\n', '\r\n']), quote(['\'','"'])));
	 EXPORT phone_input_new := dataset(Filenames(pversion,pUseProd).phone_new_lInputTemplate, layouts.phone_layout_new, csv( separator('\t'),heading(single), terminator(['\n', '\r\n']), quote(['\'','"'])));
	 
	 export specialty_input := dataset(Filenames(pversion,pUseProd).specialty_lInputTemplate, layouts.specialty_layout, csv( separator('\t'),heading(single), terminator(['\n', '\r\n']), quote(['\'','"'])));
	 export specialty_history := dataset(Filenames(pversion,pUseProd).specialty_lInputHistTemplate, layouts.specialty_layout, csv( separator('\t'),heading(single), terminator(['\n', '\r\n']), quote(['\'','"'])));
	 export specialty_input_new := dataset(Filenames(pversion,pUseProd).specialty_new_lInputTemplate, layouts.specialty_layout_new, csv( separator('\t'),heading(single), terminator(['\n', '\r\n']), quote(['\'','"'])));
	 
	 EXPORT statelicense_input := dataset(Filenames(pversion,pUseProd).statelicense_lInputTemplate, layouts.statelicense_layout, csv( separator('\t'),heading(single), terminator(['\n', '\r\n']), quote(['\'','"'])));
	 EXPORT statelicense_history := dataset(Filenames(pversion,pUseProd).statelicense_lInputHistTemplate, layouts.statelicense_layout, csv( separator('\t'),heading(single), terminator(['\n', '\r\n']), quote(['\'','"'])));
	 EXPORT statelicense_input_new := dataset(Filenames(pversion,pUseProd).statelicense_new_lInputTemplate, layouts.statelicense_layout_new, csv( separator('\t'),heading(single), terminator(['\n', '\r\n']), quote(['\'','"'])));
	 
	 EXPORT stliclookup_input := dataset(Filenames(pversion,pUseProd).stliclookup_lInputTemplate, layouts.stliclookup_layout, csv( separator('\t'),heading(single), terminator(['\n', '\r\n']), quote(['\'','"'])));
	 EXPORT stliclookup_input_new := dataset(Filenames(pversion,pUseProd).stliclookup_new_lInputTemplate, layouts.stliclookup_layout_new, csv( separator('\t'),heading(single), terminator(['\n', '\r\n']), quote(['\'','"'])));
	 
	 /* Base File Versions */
   tools.mac_FilesBase(Filenames(pversion,pUseProd).address_Base, HMS_STLIC.layouts.address_base, address_Base);
	 tools.mac_FilesBase(Filenames(pversion,pUseProd).csr_Base, HMS_STLIC.layouts.csr_base, csr_Base);
 	 tools.mac_FilesBase(Filenames(pversion,pUseProd).dea_Base, HMS_STLIC.layouts.dea_base, dea_base);
	 tools.mac_FilesBase(Filenames(pversion,pUseProd).disciplinaryact_Base, HMS_STLIC.layouts.disciplinaryact_base, disciplinaryact_Base);
	 tools.mac_FilesBase(Filenames(pversion,pUseProd).education_Base, HMS_STLIC.layouts.education_base, education_Base);
	 tools.mac_FilesBase(Filenames(pversion,pUseProd).entity_Base, HMS_STLIC.layouts.entity_base, entity_Base);
	 tools.mac_FilesBase(Filenames(pversion,pUseProd).language_Base, HMS_STLIC.layouts.language_base, language_Base);
 	 tools.mac_FilesBase(Filenames(pversion,pUseProd).license_Base, HMS_STLIC.layouts.license_base, license_Base);
	 tools.mac_FilesBase(Filenames(pversion,pUseProd).npi_Base, HMS_STLIC.layouts.npi_base, npi_Base);
	 tools.mac_FilesBase(Filenames(pversion,pUseProd).phone_Base, HMS_STLIC.layouts.phone_base, phone_Base);
	 tools.mac_FilesBase(Filenames(pversion,pUseProd).specialty_Base, HMS_STLIC.layouts.specialty_base, specialty_Base);
	 tools.mac_FilesBase(Filenames(pversion,pUseProd).statelicense_Base, HMS_STLIC.layouts.statelicense_base, statelicense_Base);	 
	 /*HMS replacement for AMS*/
	 tools.mac_FilesBase(Filenames(pversion,pUseProd).stlicrollup_Base, HMS_STLIC.layouts.statelicense_base, stlicrollup_Base);	
	 /*HMS replacement for AMS*/
	 
	/* Keybuild File */
   //versioncontrol.macBuildFileVersions(Filenames(pversion).keybuild, layouts.keybuild, keybuild); 
	 
END;