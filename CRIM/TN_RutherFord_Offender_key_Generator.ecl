export TN_RutherFord_Offender_key_Generator (string p_source,
                                             String p_Cause_number,
                                             String p_file_dt
																						 ):= FUNCTION

  String Offender_key := p_source+ trim(p_Cause_number) + Function_ParseDate(TRIM(p_file_dt,right),'MMDDYYDOB');
	
	Return trim(Offender_key[1..60]);
		
end;																	