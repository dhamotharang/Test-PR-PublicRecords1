EXPORT fn_CreateSuperFiles_NtlAccidents() := FUNCTION

  retval := SEQUENTIAL (
  
  // ##############################################################################################
  //                                Ntl Accidents
  // ##############################################################################################	
                        mod_Utilities.fn_CreateSuperFile('~thor_data400::base::ntlcrash_Consolidation'),
                        mod_Utilities.fn_CreateSuperFile('~thor_data400::base::ntlcrash_Consolidation_father'),
                        mod_Utilities.fn_CreateSuperFile('~thor_data400::base::ntlcrash_Consolidation_grandfather'),
                        mod_Utilities.fn_CreateSuperFile('~thor_data400::base::ntlcrash_Consolidation_delete'),
  
  // ##############################################################################################
  //                                Ntl Accidents Inquiry
  // ##############################################################################################	
                        mod_Utilities.fn_CreateSuperFile('~thor_data400::base::ntlcrash_inquiry_Consolidation'),
                        mod_Utilities.fn_CreateSuperFile('~thor_data400::base::ntlcrash_inquiry_Consolidation_father'),
                        mod_Utilities.fn_CreateSuperFile('~thor_data400::base::ntlcrash_inquiry_Consolidation_grandfather'),
                        mod_Utilities.fn_CreateSuperFile('~thor_data400::base::ntlcrash_inquiry_Consolidation_delete')												
											 );
  RETURN retval;
END;