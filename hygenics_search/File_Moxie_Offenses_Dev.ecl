import crimsrch;

export File_Moxie_Offenses_Dev := dataset(Name_Moxie_Offenses_Dev, crimsrch.Layout_Moxie_Offenses, flat)(length(trim(offender_key, left, right))>2);