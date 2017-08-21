IMPORT corp2;
	
EXPORT Functions := MODULE

		//****************************************************************************
		//invalid_corp_key: returns true or false based upon the incoming code.
		//									 
		//NOTE: The purpose of this routine is to validate the corp_key for HI.  The
		//			file number must be all numeric or this function will return false. 
		//****************************************************************************
		EXPORT invalid_corp_key(STRING code) := FUNCTION
		
					 uc_code			:= corp2.t2u(code);
					 codeparts 		:= stringlib.splitwords(uc_code,'-',false);
					 state_fips 	:= trim(codeparts[1],left,right);
					 file_suffix 	:= trim(codeparts[2],left,right);
					 file_number 	:= trim(codeparts[3],left,right);

					 isValidCorpKey := map(regexfind('\\T',uc_code,0) <> '' => false,  //Any charter number with a "T" in it is a "Temporary Record"
																 file_number = '' 								=> false,
																 file_suffix = '' 								=> false,
																 state_fips  = '' 								=> false,
																 state_fips = '15' and stringlib.stringfilterout(file_number,'0123456789')='' => true,
																 false
																);
																
					 RETURN if(isValidCorpKey,1,0);
					
		END;
			
		//****************************************************************************
		//invalid_corp_term_exist_exp: returns true or false based upon the incoming
		//									 					 string value "s".
		//NOTE: The purpose of this routine is to validate the corp_term_exist_exp
		//			field for HI.  Typically it is a date.  However, for HI it can be a
		//			date or a numeric value representing the number of years.
		//****************************************************************************
		EXPORT invalid_corp_sos_charter_nbr(STRING s) := FUNCTION
		
			 uc_s					:= corp2.t2u(s);
			 codeparts 		:= stringlib.splitwords(uc_s,' ',false);
			 file_number 	:= trim(codeparts[1],left,right);			 
			 file_suffix 	:= trim(codeparts[2],left,right);
			 
			 isValidCorpSosCharterNbr := map(regexfind('\\T',uc_s,0) <> '' 		=> false,  //Any charter number with a "T" in it is a "Temporary Record"
																			 file_number = '' 								=> false,
																			 file_suffix = '' 								=> false,
																			 stringlib.stringfilterout(file_number,'0123456789')='' => true,
																			 false
																			);
																			
			 RETURN if(isValidCorpSosCharterNbr,1,0);
					 
		END;
		
END;