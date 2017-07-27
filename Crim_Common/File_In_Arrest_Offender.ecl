export File_In_Arrest_Offender
 := dataset('~thor_data400::in::arrest_log_offender_clean_' + Version_In_Arrest_Offender,
			Layout_In_Arrest_Offender,
			flat
		   );