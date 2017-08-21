IMPORT corp2;
	
EXPORT Functions := MODULE

		//****************************************************************************
		//valid_corp_key: returns true or false based upon the incoming corp_key.
		//									 
		//NOTE: The purpose of this routine is to validate the corp_key for MN.  The
		//			corp_key cannot contain only special characters and blanks.  There 
		//			must be letters and/or digits. The length has to be 4 or greater in 
		//		  length.
		//****************************************************************************
		EXPORT valid_corp_key(STRING code) := FUNCTION
					 uc_code	 := corp2.t2u(code);
					 isValidCD := map(length(uc_code) < 4																																 		 => false,																														
														stringlib.stringfilterout(uc_code,' -/=.+_0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ') <> '' => false,
														stringlib.stringfilterout(uc_code,' -/=.+_') 																		 <> '' => true,
														false
													 );
					 RETURN if(isValidCD,1,0);
		END;

END;		