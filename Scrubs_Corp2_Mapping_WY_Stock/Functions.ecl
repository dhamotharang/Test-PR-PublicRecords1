IMPORT corp2;
	
EXPORT Functions := MODULE

		//****************************************************************************
		//invalid_stock_par_value: 	returns true or false based upon the incoming
		//													code.
		//****************************************************************************
		EXPORT invalid_stock_par_value(STRING s) := FUNCTION

			uc_s 			:= corp2.t2u(s);
			 
			isValidValue := map(uc_s in ['UNLIMITED']															 	=> true,
													stringlib.stringfilterout(uc_s,' .0123456789') = ''	=> true,
												  false
												 );

			 RETURN if(isValidValue,1,0);

		END;
		
END;		