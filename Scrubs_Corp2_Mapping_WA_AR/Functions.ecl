IMPORT corp2, corp2_raw_wa; 
	 
EXPORT Functions := MODULE

		//********************************************************************************
		//invalid_ar_comment: 	returns true or false based upon the incoming description.
		//********************************************************************************
		EXPORT fn_valid_ar_comment(STRING s) := FUNCTION
      
			 isValidDesc := map(corp2.t2u(s) in ['AMENDED ANNUAL REPORT','AMENDED REPORT','ANNUAL REPORT',	
										                       'ANNUAL REPORT-WAIVER GRANTED','DELINQUENT ANNUAL REPORT NOTICE','']	=> true,false);
			 RETURN if(isValidDesc,1,0);

		END;
END;