import crimsrch, corrections, lib_date;

file_date_filter								:= StringLib.StringFilter(hygenics_search.Version.development, '0123456789');

export File_Moxie_Offender_Dev 	:= dataset('~thor_data400::base::fcra_corrections_offenders_public', corrections.layout_offender, flat, unsorted)(length(trim(offender_key, left, right))>2 and 
																			vendor not in hygenics_search.sCourt_Vendors_To_Omit
																			/*or (trim(src_upload_date, left, right)<>'' 
																			and length(src_upload_date) = length(file_date_filter) 
																			and LIB_Date.DaysApart(src_upload_date, file_date_filter)<=180)*/);