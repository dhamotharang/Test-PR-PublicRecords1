IMPORT corp2;
	
EXPORT Functions := MODULE

		//****************************************************************************
		//valid_stock_class_type_cd: returns true or false based upon the incoming code.
		//****************************************************************************
		EXPORT valid_stock_class_type_cd(STRING code) := FUNCTION
					 uc_code								:= corp2.t2u(code);
					 isValidCD			 		  	:= map(uc_code in ['1','2','3','4','5','6','7','8','9',
																										'10','11','12','13','14','15','16',
																										'17','18','19',''] => true,false
																				);
					 RETURN if(isValidCD,1,0);
		END;

		//****************************************************************************
		//valid_stock_class_type_desc: returns true or false based upon the incoming code.
		//****************************************************************************
		EXPORT valid_stock_class_type_desc(STRING s) := FUNCTION
					 uc_s 									:= corp2.t2u(s);
					 isValidDesc			 		  := map(uc_s in ['99 SEE CERT','COMMON','CMM CLS A NONVOTING','CMM CLS A VOTING',
																									'CMM CLS B NONVOTING','CMM CLS B VOTING','CMM CLS C',
																									'CMM CLS C VOTING','CMM CLS NONVOTING','CMM VOTING','PREFERRED',
																									'PREF CLS A NONVOTING','PREF CLS A VOTING','PREF CLS B NONVOTING',
																									'PREF CLS B VOTING','PREF CLS C','PREF CLS C VOTING','PREF NONVOTING',
																									'UNDECLARED',''] => true,false
																				);
					 RETURN if(isValidDesc,1,0);
		END;

END;