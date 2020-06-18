IMPORT Scrubs_Debt_Settlement, std;
	
EXPORT Functions := MODULE

		//****************************************************************************
		//fn_valid_status: returns true or false based upon the incoming value
		//****************************************************************************
		EXPORT fn_valid_status(STRING s) := FUNCTION

				 RETURN if(std.str.touppercase(std.str.cleanspaces(s)) in ['ACTIVE',
																																	 'CURRENT',
																																	 'INACTIVE',
																																	 'PENDING',
																																	 'TRANSITION',
																																	 ''],1,0);
		END;

		//****************************************************************************
		//fn_valid_orgtype: returns true or false based upon the incoming value
		//****************************************************************************
		EXPORT fn_valid_orgtype(STRING s) := FUNCTION

				 RETURN if(std.str.touppercase(std.str.cleanspaces(s)) in ['CREDIT COUNSELING',
																																	 'CREDIT COUNSELING, NON-PROFIT',
																																	 'CREDIT COUNSELOR',
																																	 'DEBT MANAGEMENT SERVICES',
																																	 'DEBT SETTLEMENT',
																																	 ''],1,0);					 
		END;

END;












