import hygenics_crim;

export File_Moxie_CourtOffenses_Dev := dataset('~thor_data400::base::corrections_court_offenses_public', hygenics_crim.Layout_Base_CourtOffenses_with_OffenseCategory, flat)(length(trim(offender_key, left, right))>2 and vendor not in hygenics_search.sCourt_Vendors_To_Omit);