IMPORT corp2, corp2_mapping;

EXPORT Functions := Module

	//********************************************************************
	//CorpForeignDomesticInd: Returns "corp_foreign_domestic_ind".
	//********************************************************************	
	EXPORT CorpForeignDomesticInd(STRING s) := FUNCTION
		 uc_s  := corp2.t2u(s);
		 RETURN map(uc_s='DOMESTIC LIMITED LIABILITY COMPANY'																	=> 'D',
								uc_s='DOMESTIC NONPROFIT CORPORATION' 																		=> 'D',
								uc_s='DOMESTIC PROFIT CORPORATION' 																				=> 'D',
								uc_s='DOMESTIC PROFIT PROFESSIONAL CORPORATION' 													=> 'D',
								uc_s='FOREIGN LIMITED LIABILITY COMPANY'																	=> 'F',
								uc_s='FOREIGN NONPROFIT CORPORATION' 																			=> 'F',
								uc_s='FOREIGN PROFIT CORPORATION' 																				=> 'F',
								uc_s='FOREIGN PROFIT PROFESSIONAL CORPORATION' 														=> 'F',
								uc_s='FOREIGN PROFIT PROFESSIONAL ASSOCIATION' 														=> 'F',
								uc_s='DOMESTIC AGENCY CONNECTED' 																					=> 'D',
								uc_s='DOMESTIC COOPERATIVE EXEMPT' 																				=> 'D',
								uc_s='DOMESTIC COOPERATIVE REPORTER' 																			=> 'D',
								uc_s='DOMESTIC CREDIT UNION'																							=> 'D',
								uc_s='DOMESTIC FINANCIAL EXEMPT'		 																			=> 'D',
								uc_s='DOMESTIC INSURANCE COMPANY - MUTUAL'																=> 'D',
								uc_s='DOMESTIC NONPROFIT' 																								=> 'D',
								uc_s='DOMESTIC NONPROFIT EXEMPT' 	  																			=> 'D',
								uc_s='DOMESTIC NONPROFIT MARKETING COOPERATIVE ASSOCIATION WITHOUT SHARES'=> 'D',
								uc_s='DOMESTIC NONPROFIT WATER USERS ASSOCIATION WITHOUT SHARES'					=> 'D',
								uc_s='DOMESTIC PARTNERSHIP TO GENERAL LIABILITY COMPANY'				  				=> 'D',
								uc_s='DOMESTIC PROFESSIONAL CORPORATION'																	=> 'D',
								uc_s='DOMESTIC PROFIT'		  		 																					=> 'D',
								uc_s='DOMESTIC PROFIT COOPERATIVE ASSOCIATION WITH SHARES'								=> 'D',
								uc_s='DOMESTIC PROFIT COOPERATIVE ASSOCIATION WITHOUT SHARES'							=> 'D',
								uc_s='DOMESTIC PROFIT EXEMPT'																							=> 'D',
								uc_s='DOMESTIC PROFIT PROFESSIONAL CORPORATION'														=> 'D',
								uc_s='DOMESTIC REDOMESTICATED'																						=> 'D',
								uc_s='DOMESTIC RURAL ELECTRIC COOPERATIVE'																=> 'D',
								uc_s='DOMESTIC SANITARY PROJECT ASSOCIATIONS'															=> 'D',
								uc_s='DOMESTIC SAVINGS AND LOAN'		  																		=> 'D',
								uc_s='DOMESTIC STATE BANK'																								=> 'D',
								uc_s='FOREIGN BUSINESS TRUST'																							=> 'F',
								uc_s='FOREIGN COOPERATIVE EXEMPT'																					=> 'F',
								uc_s='FOREIGN COOPERATIVE REPORTER'																				=> 'F',
								uc_s='FOREIGN COOPERATIVE'																								=> 'F',
								uc_s='FOREIGN FEDERAL SAVINGS BANK'																				=> 'F',
								uc_s='FOREIGN FINANCIAL EXEMPT'																						=> 'F',
								uc_s='FOREIGN NONPROFIT'																									=> 'F',
								uc_s='FOREIGN NONPROFIT EXEMPT'																						=> 'F',
								uc_s='FOREIGN PROFESSIONAL CORPORATION'																		=> 'F',
								uc_s='FOREIGN PROFIT COOPERATIVE ASSOCIATION WITHOUT SHARES'							=> 'F',
								uc_s='FOREIGN PROFIT CORPORATION'																					=> 'F',
								uc_s='FOREIGN PROFIT EXEMPT'																							=> 'F',
								uc_s='FOREIGN PROFIT TELEPHONE COOPERATIVE ASSOCIATION WITHOUT SHARES'		=> 'F',
								uc_s='FOREIGN RURAL ELECTRIC COOPERATIVE'																	=> 'F',
								uc_s='OTHER/DOMESTIC AGENCY CONNECTED'		 																=> 'D',
								uc_s='OTHER/DOMESTIC COOPERATIVE EXEMPT'	  															=> 'D',
								uc_s='OTHER/DOMESTIC COOPERATIVE REPORTER'																=> 'D',
								uc_s='OTHER/DOMESTIC NONPROFIT EXEMPT'																		=> 'D',
								uc_s='OTHER/DOMESTIC PROFIT EXEMPT'																				=> 'D',
								uc_s='OTHER/FOREIGN COOPERATIVE EXEMPT'																		=> 'F',
								uc_s='OTHER/FOREIGN PROFIT EXEMPT'																				=> 'F',
								uc_s='OTHER/NO CORP TYPE FROM MNFRM'																			=> 'D',
								''
							);
	END;

	//********************************************************************
	//CorpForProfitInd: Returns "corp_for_profit_ind".
	//********************************************************************	
	EXPORT CorpForProfitInd(STRING s) := FUNCTION
		 uc_s  := corp2.t2u(s);
		 RETURN map(uc_s='DOMESTIC NONPROFIT CORPORATION'																			=>'N',
								uc_s='DOMESTIC PROFIT CORPORATION'																				=>'Y',
								uc_s='FOREIGN NONPROFIT CORPORATION'																			=>'N',
								uc_s='FOREIGN PROFIT CORPORATION'																					=>'Y',
								uc_s='FOREIGN PROFIT PROFESSIONAL CORPORATION'														=>'Y',
								uc_s='FOREIGN PROFIT PROFESSIONAL ASSOCIATION'														=>'Y',
								uc_s='DOMESTIC NONPROFIT'																									=>'N',
								uc_s='DOMESTIC NONPROFIT EXEMPT'																					=>'N',
								uc_s='DOMESTIC NONPROFIT MARKETING COOPERATIVE ASSOCIATION WITHOUT SHARES'=>'N',
								uc_s='DOMESTIC NONPROFIT WATER USERS ASSOCIATION WITHOUT SHARES'					=>'N',
								uc_s='DOMESTIC PROFIT'			  																						=>'Y',
								uc_s='DOMESTIC PROFIT COOPERATIVE ASSOCIATION WITH SHARES'								=>'Y',
								uc_s='DOMESTIC PROFIT COOPERATIVE ASSOCIATION WITHOUT SHARES'							=>'Y',
								uc_s='DOMESTIC PROFIT EXEMPT'																							=>'Y',
								uc_s='DOMESTIC PROFIT PROFESSIONAL CORPORATION'														=>'Y',
								uc_s='FOREIGN NONPROFIT'																									=>'N',
								uc_s='FOREIGN NONPROFIT EXEMPT'																						=>'N',
								uc_s='FOREIGN PROFIT COOPERATIVE ASSOCIATION WITHOUT SHARES'							=>'Y',
								uc_s='FOREIGN PROFIT EXEMPT'																							=>'Y',
								uc_s='FOREIGN PROFIT TELEPHONE COOPERATIVE ASSOCIATION WITHOUT SHARES'		=>'Y',
								uc_s='FOREIGN RURAL ELECTRIC COOPERATIVE'																	=>'Y',
								uc_s='OTHER/DOMESTIC NONPROFIT EXEMPT'																		=>'N',
								uc_s='OTHER/DOMESTIC PROFIT EXEMPT'																				=>'Y',
								uc_s='OTHER/FOREIGN PROFIT EXEMPT'																				=>'Y',
								''
						);
	END;

	//********************************************************************
	//CorpOrigOrgStructureDesc: Returns "corp_orig_org_structure_desc".
	//********************************************************************	
	EXPORT CorpOrigOrgStructureDesc(STRING s) := FUNCTION
		 uc_s  := corp2.t2u(s);
		 RETURN map(uc_s='DOMESTIC LIMITED LIABILITY COMPANY'																	=> uc_s,
								uc_s='DOMESTIC NONPROFIT CORPORATION' 																	  => uc_s,
								uc_s='DOMESTIC PROFIT CORPORATION' 																			  => uc_s,
								uc_s='DOMESTIC PROFIT PROFESSIONAL CORPORATION' 													=> uc_s,
								uc_s='FOREIGN LIMITED LIABILITY COMPANY'																	=> uc_s,
								uc_s='FOREIGN NONPROFIT CORPORATION' 																			=> uc_s,
								uc_s='FOREIGN PROFIT CORPORATION' 														            => uc_s,
								uc_s='FOREIGN PROFIT PROFESSIONAL CORPORATION' 														=> uc_s,
								uc_s='FOREIGN PROFIT PROFESSIONAL ASSOCIATION' 														=> uc_s,
								uc_s='DOMESTIC AGENCY CONNECTED' 																					=> uc_s,
								uc_s='DOMESTIC COOPERATIVE EXEMPT' 																				=> uc_s,
								uc_s='DOMESTIC COOPERATIVE REPORTER' 																			=> uc_s,
								uc_s='DOMESTIC CREDIT UNION' 																							=> uc_s,
								uc_s='DOMESTIC FINANCIAL EXEMPT' 																					=> uc_s,
								uc_s='DOMESTIC INSURANCE COMPANY - MUTUAL'																=> uc_s,
								uc_s='DOMESTIC NONPROFIT'																									=> uc_s,
								uc_s='DOMESTIC NONPROFIT EXEMPT' 																					=> uc_s,
								uc_s='DOMESTIC NONPROFIT MARKETING COOPERATIVE ASSOCIATION WITHOUT SHARES'=>'DOMESTIC NONPROFIT MARKETING COOPERATIVE ASSO WO SHARES',
								uc_s='DOMESTIC NONPROFIT WATER USERS ASSOCIATION WITHOUT SHARES'					=> uc_s,
								uc_s='DOMESTIC PARTNERSHIP TO GENERAL LIABILITY COMPANY'				  				=> uc_s,
								uc_s='DOMESTIC PROFESSIONAL CORPORATION'																	=> uc_s,
								uc_s='DOMESTIC PROFIT'		  																							=> uc_s,
								uc_s='DOMESTIC PROFIT COOPERATIVE ASSOCIATION WITH SHARES'		 						=> uc_s,
								uc_s='DOMESTIC PROFIT COOPERATIVE ASSOCIATION WITHOUT SHARES'							=> uc_s,
								uc_s='DOMESTIC PROFIT EXEMPT'																							=> uc_s,
								uc_s='DOMESTIC PROFIT PROFESSIONAL CORPORATION'														=> uc_s,
								uc_s='DOMESTIC REDOMESTICATED'																						=> uc_s,
								uc_s='DOMESTIC RURAL ELECTRIC COOPERATIVE'																=> uc_s,
								uc_s='DOMESTIC SANITARY PROJECT ASSOCIATIONS'															=> uc_s,
								uc_s='DOMESTIC SAVINGS AND LOAN'																					=> uc_s,
								uc_s='DOMESTIC STATE BANK'  																							=> uc_s,
								uc_s='FOREIGN BUSINESS TRUST'																							=> uc_s,
								uc_s='FOREIGN COOPERATIVE EXEMPT'																					=> uc_s,
								uc_s='FOREIGN COOPERATIVE REPORTER'																				=> uc_s,
								uc_s='FOREIGN COOPERATIVE'  																							=> uc_s,
								uc_s='FOREIGN FEDERAL SAVINGS BANK'																				=> uc_s,
								uc_s='FOREIGN FINANCIAL EXEMPT'																						=> uc_s,
								uc_s='FOREIGN NONPROFIT'	  																							=> uc_s,
								uc_s='FOREIGN NONPROFIT EXEMPT'																						=> uc_s,
								uc_s='FOREIGN PROFESSIONAL CORPORATION'																		=> uc_s,
								uc_s='FOREIGN PROFIT COOPERATIVE ASSOCIATION WITHOUT SHARES'							=> uc_s,
								uc_s='FOREIGN PROFIT CORPORATION'																					=> uc_s,
								uc_s='FOREIGN PROFIT EXEMPT'							  															=> uc_s,
								uc_s='FOREIGN PROFIT TELEPHONE COOPERATIVE ASSOCIATION WITHOUT SHARES'		=>'FOREIGN PROFIT TELEPHONE COOPERATIVE ASSO WO SHARES',
								uc_s='FOREIGN RURAL ELECTRIC COOPERATIVE'																	=> uc_s,
								uc_s='OTHER/DOMESTIC AGENCY CONNECTED'		 																=> uc_s,
								uc_s='OTHER/DOMESTIC COOPERATIVE EXEMPT'	  															=> uc_s,
								uc_s='OTHER/DOMESTIC COOPERATIVE REPORTER'																=> uc_s,
								uc_s='OTHER/DOMESTIC NONPROFIT EXEMPT'		  															=> uc_s, 
								uc_s='OTHER/DOMESTIC PROFIT EXEMPT'																				=> uc_s,
								uc_s='OTHER/FOREIGN COOPERATIVE EXEMPT'																		=> uc_s,
								uc_s='OTHER/FOREIGN PROFIT EXEMPT'																				=> uc_s,
								uc_s='OTHER/NO CORP TYPE FROM MNFRM'																			=> uc_s,
								'**|'+uc_s
	);
	END;

	//********************************************************************
	//CorpStatusDesc: Returns "corp_status_desc".
	//********************************************************************	
	EXPORT CorpStatusDesc(STRING s) := FUNCTION
		 uc_s  := corp2.t2u(s);
		 RETURN map(uc_s='ACTIVE'													 =>'ACTIVE',
								uc_s='PROCESS OF APPEAL'							 =>'PROCESS OF APPEAL',
								uc_s='BANKRUPTCY-RECEIVERSHIP'				 =>'BANKRUPTCY-RECEIVERSHIP',
								uc_s='BUSINESS TRANSACTED'						 =>'BUSINESS TRANSACTED',
								uc_s='CANCELLATION'										 =>'CANCELLATION',
								uc_s='CONSOLIDATED'										 =>'CONSOLIDATED',
								uc_s='CANCELLATION OF REGISTRATION'		 =>'CANCELLATION OF REGISTRATION',
								uc_s='CONVERSION'											 =>'CONVERSION',
								uc_s='DISSOLUTION HEARING'						 =>'DISSOLUTION HEARING',
								uc_s='DISSOLVED'											 =>'DISSOLVED',
								uc_s='VOLUNTARY DISSOLUTION'					 =>'VOLUNTARY DISSOLUTION',
								uc_s='EXISTENCE EXPIRED AUTOMATICALLY' =>'EXISTENCE EXPIRED AUTOMATICALLY',
								uc_s='EXEMPT'													 =>'EXEMPT',
								uc_s='FUTURE EFFECTIVE'								 =>'FUTURE EFFECTIVE',
								uc_s='FORFEITED'											 =>'FORFEITED',
								uc_s='FINAL REPORT'									   =>'FINAL REPORT',
								uc_s='INVOLUNTARILY STRICKEN'					 =>'INVOLUNTARILY STRICKEN',
								uc_s='LATE-FILER'											 =>'LATE-FILER',
								uc_s='MERGED-OUT'											 =>'MERGED-OUT',
								uc_s='MERGED-OUT OF EXISTENCE'				 =>'MERGED-OUT OF EXISTENCE',
								uc_s='NEW CORPORATION'								 =>'NEW CORPORATION',
								uc_s='NON-FILER'											 =>'NON-FILER',
								uc_s='NOT IN GOOD STANDING'						 =>'NOT IN GOOD STANDING',																								
								uc_s='REVOKED AND BEYOND APPEAL PERIOD'=>'REVOKED AND BEYOND APPEAL PERIOD',
								uc_s='RE-INSTATEMENT'									 =>'RE-INSTATEMENT',
								uc_s='RETURNED REPORT'								 =>'RETURNED REPORT',
								uc_s='REVOKED'												 =>'REVOKED',
								uc_s='STATEMENT OF INTENT TO DISSOLVE' =>'STATEMENT OF INTENT TO DISSOLVE',
								uc_s='SUSPENSION'											 =>'SUSPENSION',
								uc_s='CORPORATION TAX CLEARANCE'			 =>'CORPORATION TAX CLEARANCE',
								uc_s='WITHDRAWN'										   =>'WITHDRAWN',
								uc_s='NOSTAT'													 =>'NOSTAT',
								'**|'+uc_s
							 );
	END;

	//********************************************************************
	//CorpRAFullName: Returns "corp_ra_full_name".
	//********************************************************************	
	EXPORT CorpRAFullName(STRING stateorigin,STRING statedesc,STRING s) := FUNCTION
		 uc_s  			:= corp2.t2u(s);
		 cleaned_s	:= corp2.t2u(stringlib.stringfilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ'));
		 bad_names 	:= ['MERGEDOUTOFEXISTENCE','NONE','NONEGIVEN','NONESTATED','NONEREQUIRED','NOREGISTEREDAGENTNEEDED','NOTGIVEN','NOTLISTED',
										'NOTREGISTEREDLC','NOTREQUIRED','NOTREQUIREDBYSTATUTE','NOTREQUIRES','NOTREQUIREDTOHAVEANAGENT','NULL','NA',
										'OFFICERSANDDIRECTORSONFILEWITHTHESECRETARYOFSTATE','SAMEASABOVE','SEEFILEFORADDLOFFICERSDIRECTORS'
									 ];
		 titles			:= '^MISS |^MR. |^MR |^MRS. |^MRS ';
		 RETURN map(cleaned_s in bad_names					=> '',
								regexfind(titles,uc_s,0) <> ''	=> regexreplace(titles,uc_s,''),
								Corp2_mapping.fCleanBusinessName(corp2.t2u(stateorigin),corp2.t2u(statedesc),uc_s).BusinessName
							 );
	END;

END;		