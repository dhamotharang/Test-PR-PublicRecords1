import crimsrch;

export File_Moxie_Offender_Dev := dataset(Name_Moxie_Offender_Dev, crimsrch.Layout_Moxie_Offender, flat, unsorted)(length(trim(offender_key, left, right))>2);