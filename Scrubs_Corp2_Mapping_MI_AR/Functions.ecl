IMPORT corp2;
	
EXPORT Functions := MODULE

		//****************************************************************************
		//invalid_ar_extension: 	returns true or false based upon the incoming code.
		//****************************************************************************
		EXPORT invalid_ar_extension(STRING s) := FUNCTION

			 uc_s 		:= corp2.t2u(s);
			 isValidCD := if(stringlib.stringfilterout(uc_s,' 0123456789ACEILNR') = '',true,false);
			 RETURN if(isValidCD,1,0);

		END;
		
		//****************************************************************************
		//invalid_ar_frame: 	returns true or false based upon the incoming code.
		//****************************************************************************
		EXPORT invalid_ar_frame(STRING s) := FUNCTION

			 uc_s 		:= corp2.t2u(s);
			 isValidCD := if(stringlib.stringfilterout(uc_s,' 0123456789N') = '',true,false);
			 RETURN if(isValidCD,1,0);

		END;		
		
		//****************************************************************************
		//invalid_ar_roll: 	returns true or false based upon the incoming code.
		//****************************************************************************
		EXPORT invalid_ar_roll(STRING s) := FUNCTION

			 uc_s 		:= corp2.t2u(s);
			 isValidCD := if(stringlib.stringfilterout(uc_s,' 0123456789O-') = '',true,false);
			 RETURN if(isValidCD,1,0);

		END;
		
END;