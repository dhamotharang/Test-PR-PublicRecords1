EXPORT Files_NtlAccidents := MODULE	

  EXPORT DS_BASE_NtlAccidents := DATASET(mod_Utilities.Location + 'thor_data400::base::ntlcrash_Consolidation', Layout_NtlAccidents_Alpharetta.ConsolidationBase, THOR);

END;