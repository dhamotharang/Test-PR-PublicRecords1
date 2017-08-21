IMPORT corp2, corp2_raw_ny;
	
EXPORT Functions := MODULE

		//****************************************************************************
		//invalid_doccode: 	returns true or false based upon the incoming code.
		//****************************************************************************
		EXPORT invalid_doccode(STRING s, STRING corp_ln_name_type_cd) := FUNCTION
      
			 isValidCD := if(corp_ln_name_type_cd in ['01','P']
											 ,map(s[1..2] in ['01','02','03','04','05','06','07','08','09','10',
																						  '11','12','13','14','15','16','17','18','19','20',
																						  '21','22','23','24','25','26','27','28','29','30',
																						  '31','32','33','34','35','36','37','38','39','40',
																						  '41','42','43','44','45','46','47','48','49'] and
											      s[3] in ['D','F','O','U'] and
													  s[4] in ['A','B','C','D','E','G','L','N','O','P','R','S'] and
													  s[6] in ['A','F'] => true, false)
											,true); //For records without an ln_name_type_cd of 01 or P, 
															//doccode doesn't have to exist
									
			 RETURN if(isValidCD,1,0);

		END;
		
END;