/*
  p_source = code for the source. 
  p_flag   = 1)C := Concatenate the fields
             2)H := Get the Hash of first and second values.
*/
export Function_Offender_Key_Generator (string p_source,
                                        String p_first_value,
                                        String p_second_value,
																				string p_flag  ='C'
																			 ):= FUNCTION
  
  String Offender_key := CASE (p_flag , 
	                             'C' => p_source+ trim(p_first_value) + trim(p_second_value),
															 'H' => p_source+ HASH(p_first_value+p_second_value),
															 '');
	
	Return trim(Offender_key[1..60]);
		
end;																	