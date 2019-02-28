IMPORT tools, _VendorSrc, ut;

EXPORT Files(STRING pversion = '', BOOLEAN pUseProd = FALSE) := MODULE

   /* Input File Versions */
 
	 EXPORT base_data_input         := DATASET (Filenames(pversion,pUseProd).base_data_lInputTemplate, layouts.base_data_Input, FLAT, __COMPRESSED__);
   EXPORT old_data_history        := DATASET (Filenames(pversion,pUseProd).base_data_lInputHistTemplate, layouts.base_data_Input, csv(separator('|'),quote('')));
	 //EXPORT old_vendor_src_input    := DATASET (Filenames(pversion,pUseProd).old_vendor_src_lInputTemplate, layouts.old_vendor_src_Input, CSV(SEPARATOR([',']), HEADING(1), TERMINATOR(['\n','\r\n']), QUOTE(['\"'])),opt);
   //EXPORT old_vendor_src_history  := DATASET (Filenames(pversion,pUseProd).old_vendor_src_lInputHistTemplate, layouts.old_vendor_src_Input, csv(separator('|'),quote('')));
	 EXPORT bank_court_input        := DATASET (Filenames(pversion,pUseProd).bank_court_lInputTemplate, layouts.bank_court_Input, CSV(SEPARATOR([',']), HEADING(1), TERMINATOR(['\n','\r\n']), QUOTE(['\"'])));
	 EXPORT bak_court_history       := DATASET (Filenames(pversion,pUseProd).bank_court_lInputHistTemplate, layouts.bank_court_Input, csv(separator('|'),quote('')));
   EXPORT lien_court_input        := DATASET (Filenames(pversion,pUseProd).lien_court_lInputTemplate, layouts.lien_court_Input, CSV(SEPARATOR([',']), HEADING(1), TERMINATOR(['\n','\r\n']), QUOTE(['\"'])));	 
	 EXPORT lien_court_history      := DATASET (Filenames(pversion,pUseProd).lien_court_lInputHistTemplate, layouts.lien_court_Input, csv(separator('|'),quote('')));
   EXPORT riskview_ffd_input      := DATASET (Filenames(pversion,pUseProd).riskview_ffd_lInputTemplate, layouts.riskview_ffd_Input, THOR, __COMPRESSED__);
	 EXPORT riskview_ffd_history    := DATASET (Filenames(pversion,pUseProd).riskview_ffd_lInputHistTemplate, layouts.riskview_ffd_Input, csv(separator('|'),quote('')));
	 EXPORT court_locations_input   := DATASET (Filenames(pversion,pUseProd).court_locations_lInputTemplate, layouts.court_locations_Input, CSV(SEPARATOR([',']), HEADING(1), TERMINATOR(['\n','\r\n']), QUOTE(['\"'])));
	 EXPORT court_locations_history := DATASET (Filenames(pversion,pUseProd).court_locations_lInputHistTemplate, layouts.court_locations_Input, csv(separator('|'),quote('')));
	 EXPORT master_list_input       := DATASET (Filenames(pversion,pUseProd).master_list_lInputTemplate, layouts.master_list_Input, CSV(SEPARATOR([',']), HEADING(1), TERMINATOR(['\n','\r\n']), QUOTE(['\"'])),opt);
	 EXPORT master_list_history     := DATASET (Filenames(pversion,pUseProd).master_list_lInputHistTemplate, layouts.master_list_Input, csv(separator('|'),quote('')));
	 EXPORT college_locator_input   := DATASET (Filenames(pversion,pUseProd).college_locator_lInputTemplate, layouts.master_list_Input, CSV(SEPARATOR([',']), HEADING(1), TERMINATOR(['\n','\r\n']), QUOTE(['\"'])),opt);
	 EXPORT college_locator_history := DATASET (Filenames(pversion,pUseProd).college_locator_lInputHistTemplate, layouts.master_list_Input, csv(separator('|'),quote('')));
	
	/* Base File Versions */
	
	 //tools.mac_FilesBase(Filenames(pversion,pUseProd).base_data_input, layouts.base_data_input, base_data_input);
  // tools.mac_FilesBase(Filenames(pversion,pUseProd).OldVendorSrc_Base, layouts.OldVendorSrc_Base, OldVendorSrc_base);
	 
	
	 	 
	/* Keybuild File */
   //versioncontrol.macBuildFileVersions(Filenames(pversion).keybuild, layouts.keybuild, keybuild); 
	 
END;