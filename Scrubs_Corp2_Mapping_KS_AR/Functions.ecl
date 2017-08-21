import corp2;

EXPORT Functions := MODULE

		//****************************************************************************
		//invalid_ar_status: 	returns true or false based upon the incoming code.
		//****************************************************************************
		export invalid_ar_status(string code) := function
					 uc_code 			:= corp2.t2u(code);
					 isValidCode	:= map (corp2.t2u(uc_code) in ['A/R RECEIVED BY OUR OFFICE, BUT NOT AUDITED',
																											 'A/R NOT DUE, CORPORATION IS IN GOOD STANDING',
																											 'A/R NOTICE HAS BEEN MAILED TO THE CORPORATION',
																											 'A/R IN ERROR - CAN BECOME DELINQUENT AND FORFEIT',
																											 ''] => true,false);	 
					return if(isValidCode,1,0);
		end;

end;