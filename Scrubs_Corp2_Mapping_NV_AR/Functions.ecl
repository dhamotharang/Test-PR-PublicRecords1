﻿IMPORT corp2;
	
EXPORT Functions := MODULE

		//****************************************************************************
		//ValidActionTypes: returns true or false based upon the incoming code.
		//****************************************************************************
		EXPORT ValidActionTypes(STRING s) := FUNCTION
				isValidActionType := case(corp2.t2u(s),
							'DOMESTICATION'																			=> TRUE,
							'MERGE OUT'  																				=> TRUE,
							'REGISTERED AGENT NAME CHANGE'                    	=> TRUE,
							'COMMERCIAL REGISTERED AGENT LISTING STATEMENT'     => TRUE,
							'CERTIFICATE - CITY POP. < 1,000'       						=> TRUE,
							'CORRECTION'                                        => TRUE,
							'COMMERCIAL REGISTERED AGENT STATEMENT OF CHANG'    => TRUE,
							'STATEMENT OF PARTNERSHIP AUTHORITY'                => TRUE, 
							'DISSOLUTION'                                       => TRUE,
							'REINSTATEMENT'                                     => TRUE,
							'WITHDRAWAL OF DESIGNATION'                         => TRUE,
							'AMENDMENT TO STATEMENT OF PARTNERSHIP AUTHORITY'   => TRUE,
							'CERTIFICATE OF LIMITED PARTNERSHIP'                => TRUE,
							'ARTICLES OF INCORPORATION'                         => TRUE,
							'CERTIFICATE - CITY POP. >= 1,000; < 50,000'        => TRUE,
							'CERTIFICATE - COUNTY POP. < 50,000'                => TRUE,
							'MODIFIED NAME RESOLUTION'                          => TRUE,
							'ACCEPTANCE OF REGISTERED AGENT'                    => TRUE,
							'TERMINATION OF COMMERCIAL REGISTERED AGENT'        => TRUE,
							'MERGER'                                            => TRUE,
							'MISCELLANEOUS'                                     => TRUE,
							'APPLICATION FOR FOREIGN REGISTRATION'              => TRUE,
							'CERTIFICATE OF FOREIGN LIMITED PARTNERSHIP'        => TRUE,
							'CHARITABLE-SOLICITATION REGISTRATION STATEMENT'    => TRUE,
							'COMMERCIAL REGISTERED AGENT RESIGNATION'           => TRUE,
							'EXCHANGE'                                          => TRUE,
							'APP CERT OF AUTH - COUNTY >= 100,000'              => TRUE,
							'DESIGNATION'                                      	=> TRUE,
							'REGISTRATION OF FLLP'                              => TRUE,
							'AMENDMENT'                                         => TRUE,
							'RESIGNATION OF OFFICERS'                           => TRUE,
							'MARK RENEWAL (5 YR DURATION)'                      => TRUE,
							'REORGANIZATION'                                    => TRUE,
							'REGISTERED AGENT RESIGNATION'                      => TRUE,
							'RESTATED ARTICLES'                                 => TRUE,
							'APP CERT OF AUTH'                                  => TRUE,
							'CONVERT IN'                                        => TRUE,
							'ANNUAL LIST'                                       => TRUE,
							'CERTIFICATE OF BUSINESS TRUST'                     => TRUE,
							'AMENDED & RESTATED ARTICLES'                       => TRUE,
							'AMENDMENT OF ACOA'                                 => TRUE,
							'APP CERT OF AUTH - COUNTY < 50,000'                => TRUE,
							'REGISTERED AGENT CHANGE'                           => TRUE,
							'SURRENDER OF MODIFIED NAME'                        => TRUE,
							'NAME RESERVATION'                                  => TRUE,
							'TERMINATION OF AMENDMENTS'                         => TRUE,
							'TERMINATION OF MERGERS'                           	=> TRUE,
							'APPOINTMENT OF REGISTERED AGENT'                   => TRUE,
							'TRANSFER OF ACOA'                                  => TRUE,
							'REGISTRATION OF LLP'                               => TRUE,
							'FOREIGN QUALIFICATION'                             => TRUE,
							'WITHDRAWAL'                                        => TRUE, 
							'MARK REGISTRATION (5 YR DURATION)'                	=> TRUE,  
							'AMENDED DESIGNATION'                               => TRUE, 
							'CERTIFICATE OF REGISTRATION'                       => TRUE, 
							'CONVERT OUT'                                       => TRUE, 
							'ASSIGNMENT OF MARK'                                => TRUE, 
							'STOCK SPLIT'                                       => TRUE,
							'ARTICLES OF ORGANIZATION'                          => TRUE,
							'CERTIFICATE OF AMENDMENT/CORRECTION'               => TRUE, 
							'REVIVAL'                                           => TRUE,
							'GENERAL IMPROVEMENT DISTRICT'                      => TRUE,
							'ADMIN STATUS CHANGE'                               => TRUE,
							'INITIAL LIST'                                      => TRUE,
							'APPL FOR REGISTRATION OF FOREIGN BUSINESS TRUST'   => TRUE,
							'CANCELLATION OF COMMERCIAL REGISTERED AGENT'       => TRUE,
							'STATEMENT OF DISSOCIATION'                         => TRUE,
							'CHARITABLE-SOLICITATION REGISTRATION EXEMPTION'    => TRUE,
							'CANCELLATION OF MARK'                              => TRUE,
							'AMENDED LIST'                                      => TRUE, 
							'CERTIFICATE - STATEWIDE'                           => TRUE, 
							'AMENDED MODIFIED NAME RESOLUTION'                  => TRUE, 
							'MERGE IN'                                          => TRUE, 
							'CANCELLATION'                                     	=> TRUE,  
							'REGISTERED AGENT ADDRESS CHANGE' 									=> TRUE,
							''                                                  => TRUE,
							 FALSE); 
				RETURN if(isValidActionType,1,0);			 
		END;
		
END;