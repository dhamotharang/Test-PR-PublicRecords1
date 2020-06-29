IMPORT corp2;
	
EXPORT Functions := MODULE

		//****************************************************************************
		//ValidCorpOrigBusTypeCD: returns true or false based upon the incoming code.
		//****************************************************************************
		EXPORT ValidCorpOrigBusTypeCD(STRING code) := FUNCTION

					 uc_code			:= corp2.t2u(code);
					 
					 isValidCode	:= map(uc_code IN ['0','00']																				  => TRUE,
															 uc_code IN ['11','12','13','14','15','16','18']								=> TRUE,
															 uc_code IN ['20','22','23','25','26']													=> TRUE,
															 uc_code IN ['30','31','35','36']																=> TRUE,
															 uc_code IN ['40','41','42','43']																=> TRUE,
															 uc_code IN ['50','51']																					=> TRUE,
															 uc_code IN ['60','61','62','63','64','65','66','67','68','69']	=> TRUE,
															 uc_code IN ['70','71','72','73','74','75','76','77']						=> TRUE,												
															 uc_code IN ['80','81','84','85','86','87','89']								=> TRUE,
															 uc_code IN ['95']																							=> TRUE,
															 uc_code IN ['']																								=> TRUE,
															 FALSE
														 );
														 
					RETURN if(isValidCode,1,0);

		END;

	 	//****************************************************************************
		//ValidCorpStatusDesc: 	returns true or false based upon the incoming code.
		//****************************************************************************
		EXPORT ValidCorpStatusDesc(STRING desc) := FUNCTION
		
					 uc_desc 					:= corp2.t2u(desc);

					 isValidStatusCD	:= map(uc_desc IN ['INACTIVE','ACTIVE','PENDING ACTIVE','']	=> TRUE,
																	 FALSE
																  );

					RETURN if(isValidStatusCD,1,0);

		END;
		
		//****************************************************************************
		//ValidCorpLNNameTypeCD: 	returns true or false based upon the incoming code.
		//****************************************************************************
		EXPORT ValidCorpLNNameTypeCD(STRING code, STRING recordorigin) := FUNCTION
					 
					 uc_code 		:= corp2.t2u(code);
					 
					 isValidCD	:= if(recordorigin = 'C',
													  map(uc_code IN ['01','07','09','F','P'] => TRUE,
															  FALSE
															 ),
													  TRUE
													 );
																		
					RETURN if(isValidCD,1,0);
		END;
		//****************************************************************************
		//ValidCorpLNNameTypeDesc: 	returns true or false based upon the incoming code.
		//****************************************************************************
		EXPORT ValidCorpLNNameTypeDesc(STRING s, STRING recordorigin) := FUNCTION
					 
					 uc_s 				:= corp2.t2u(s);
					 
					 isValidDesc	:= if(recordorigin = 'C',
															map(uc_s IN ['FBN','LEGAL','PRIOR','RESERVED','REGISTRATION'] => TRUE,
																	FALSE
																 ),
															TRUE
														 );
																		
					RETURN if(isValidDesc,1,0);
					
		END;

    //****************************************************************************
		//ValidCorpAgentStatusDesc: 	returns true or false based upon the incoming code.
		//****************************************************************************
		EXPORT ValidCorpAgentStatusDesc(STRING s, STRING recordorigin) := FUNCTION
					 
					 uc_s 				:= corp2.t2u(s);
					 
					 isValidDesc	:= if(recordorigin = 'C',
															map(uc_s IN ['ACTIVE','INACTIVE','RESIGNED','PENDING RESIGNATION',''] => TRUE,
																	FALSE
																 ),
															TRUE
														 );
																		
					RETURN if(isValidDesc,1,0);
					
		END;
END;