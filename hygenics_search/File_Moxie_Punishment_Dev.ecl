import hygenics_crim;

export File_Moxie_Punishment_Dev := dataset('~thor_data400::base::corrections_punishment_public', hygenics_crim.Layout_CrimPunishment, flat)(length(trim(offender_key, left, right))>2 and vendor not in hygenics_search.sCourt_Vendors_To_Omit);