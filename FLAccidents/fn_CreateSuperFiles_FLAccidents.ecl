EXPORT fn_CreateSuperFiles_FLAccidents() := FUNCTION

  retval := SEQUENTIAL (
                        mod_Utilities.fn_CreateSuperFile('~thor_data400::base::flcrash_consolidation'),
                        mod_Utilities.fn_CreateSuperFile('~thor_data400::base::flcrash_consolidation_father'),
                        mod_Utilities.fn_CreateSuperFile('~thor_data400::base::flcrash_consolidation_delete')
											 );
  RETURN retval;
END;