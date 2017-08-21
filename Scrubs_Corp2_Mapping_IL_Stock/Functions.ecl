IMPORT corp2;
	
EXPORT Functions := MODULE

		//****************************************************************************
		//invalid_class: 	returns true or false based upon the incoming code
		//****************************************************************************
		EXPORT invalid_class(STRING s) := FUNCTION

			uc_s 				:= corp2.t2u(s);
			 
			isValidDesc := map(stringlib.stringfilterout(uc_s,' $/-()%,.*=0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ')='' => true,
											 false
										  );

			RETURN if(isValidDesc,1,0);

		END;

		//****************************************************************************
		//invalid_shares: 	returns true or false based upon the incoming code.
		//****************************************************************************
		EXPORT invalid_shares(STRING s) := FUNCTION

			uc_s 				:= corp2.t2u(s);

			isValidDesc := map(stringlib.stringfilterout(uc_s,' .0123456789')='' => true,
												 false
											  );

			RETURN if(isValidDesc,1,0);

		END;
		
		//****************************************************************************
		//invalid_money: 	returns true or false based upon the incoming code.	
		//****************************************************************************
		EXPORT invalid_money(STRING s) := FUNCTION

			 uc_s 		:= corp2.t2u(s);

			 isValidDesc := map(stringlib.stringfilterout(uc_s,' $.0123456789')='' => true,
													false
												 );

			 RETURN if(isValidDesc,1,0);

		END;	

END;