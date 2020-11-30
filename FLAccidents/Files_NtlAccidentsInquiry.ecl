EXPORT Files_NtlAccidentsInquiry := MODULE	

  EXPORT DS_BASE_NtlAccidentsInquiry := DATASET(mod_Utilities.Location + 'thor_data400::base::ntlcrash_inquiry_Consolidation', Layout_NtlAccidentsInquiry.ConsolidationBase, THOR);

END;