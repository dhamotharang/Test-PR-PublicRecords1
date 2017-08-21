EXPORT Lookups := Module

Export LegalBusiStructure(String cd) := Case(cd,	 '001' => 'INDIVIDUAL SOLE PROPRIETORSHIP', 
																						 '002' => 'PARTNERSHIP - LIMITED', 
																						 '003' => 'PARTNERSHIP - GENERAL', 
																						 '004' => 'LIMITED LIABILITY - CORPORATION', 
																						 '005' => 'LIMITED LIABILITY - PARTNERSHIP', 
																						 '006' => 'CORPORATION - SUBCHAPTER S', 
																						 '007' => 'CORPORATION - SUBCHAPTER C', 
																						 '008' => 'CORPORATION - NON-PROFIT', 
																						 '009' => 'CORPORATION - LOW PROFIT LLC/L3C', 
																						 '010' => 'CORPORATION - PUBLIC', 
																						 '011' => 'CORPORATION - PRIVATE', 
																						 '012' => 'CORPORATION - TYPE UNKNOWN', 
																						 '013' => 'FIDUCIARY - ESTATE', 
																						 '014' => 'FIDUCIARY - TRUST', 
																						 '015' => 'INDIVIDUAL D.B.A.', 
																						 '016' => 'JOINT VENTURE', 
																						 '050' => 'GOVERNMENT - FEDERAL', 
																						 '051' => 'GOVERNMENT - STATE', 
																						 '052' => 'GOVERNMENT - COUNTY', 
																						 '053' => 'GOVERNMENT - CITY', 
																						 '070' => 'SCHOOL - PRIVATE', 
																						 '071' => 'SCHOOL - PUBLIC', 
																						 '080' => 'CHURCH', '');
	
Export AccTypeRep(String cd) := 	Case(cd,	 '001' => 'TERM LOAN', 
																			 '002' => 'LINE OF CREDIT', 
																			 '003' => 'COMMERCIAL CARD', 
																			 '004' => 'BUSINESS LEASE', 
																			 '005' => 'LETTER OF CREDIT', 
																			 '006' => 'OPEN ENDED CREDIT LINE  ', 
																			 '099' => 'OTHER', '');
	
Export AccSts1_2(String cd) := 		Case(cd,	 '001' => 'ITEM IN DISPUTE', 
																			 '002' => 'ACCOUNT SOLD/ TRANSFERRED', 
																			 '003' => 'LOST OR STOLEN CARD', 
																			 '004' => 'VOLUNTARY REFINANCE OR RENEWAL', 
																			 '005' => 'SUSPENDED OR CLOSED ACCOUNT', 
																			 '006' => 'FORECLOSURE', 
																			 '007' => 'MODIFICATION PENDING', 
																			 '008' => 'DISCHARGED IN BANKRUPTCY', 
																			 '009' => 'PAID CHARGE OFF', 
																			 '010' => 'NON-ACCRUAL', 
																			 '011' => 'CHARGE OFF - WHOLE BALANCE', 
																			 '012' => 'BLANK (NOW DEPRECATED HISTORICAL EQUALS CASH ON DEMAND)', 
																			 '013' => 'BLANK', 
																			 '014' => 'INVOLUNTARY HARDSHIP RESTRUCTURE', 
																			 '015' => 'FIRST PAYMENT DEFAULT', 
																			 '016' => 'ACCOUNT PAID IN FULL - FOR PORTION OF BALANCE', 
																			 '017' => 'ACCOUNT IN COLLECTION', 
																			 '018' => 'VOLUNTARY SURRENDER', 
																			 '019' => 'PAYMENT DEFERRED', 
																			 '020' => 'BUSINESS AFFECTED BY NATURAL/ DECLARED DISASTER ', 
																			 '021' => 'REPORTING SUSPENDED DUE TO NATURAL/ DECLARED DISASTER', 
																			 '022' => 'SETTLED FOR LESS THAN AMOUNT DUE', '');
	
Export AccCloseureBasis(String cd) := 	Case(cd,	 'V' => 'VOLUNTARILY CLOSED BY ACCOUNT HOLDER', 
																					 'X' => 'INVOLUNTARILY CLOSED BY CREDITOR', 
																					 'F' => 'INVOLUNTARILY CLOSED BY CREDITOR DUE TO FRAUD', 
																					 'B' => 'INVOLUNTARILY CLOSED - BUSINESS FILED FOR BANKRUPTCY', 
																					 'P' => 'INVOLUNTARILY CLOSED DUE TO POOR PAYMENT HISTORY ', 
																					 'O' => 'OTHER INVOLUNTARY CLOSURE BY CREDITOR', '');
	
Export OrigCreditLmt(String cd) := 	Case(cd,	 '001' => '(LOAN), PROVIDE ORIGINAL LOAN AMOUNT', 
																				 '002' => '(LINE OF CREDIT), PROVIDE ASSIGNED CREDIT LIMIT', 
																				 '003' => '(COMMERCIAL CARD), PROVIDE ASSIGNED CREDIT LIMIT', 
																				 '004' => '(COMMERCIAL LEASE), PROVIDE ORIGINAL LEASE AMOUNT', 
																				 '005' => '(LETTER OF CREDIT), PROVIDE TOTAL AMOUNT OF CREDIT', 
																				 '006' => '(REVOLVING CHARGE/CREDIT CARD), PROVIDE ASSIGNED CREDIT LIMIT', 
																				 '099' => '(OTHER), PROVIDE ASSIGNED CREDIT LIMIT', '');
	
Export HghstCreditUsd(String cd) := 	Case(cd,	 '001' => '(LOAN), PROVIDE ORIGINAL LOAN AMOUNT, WITHOUT INTEREST', 
																					 '002' => '(LINE OF CREDIT), PROVIDE HIGHEST BALANCE EVER UTILIZED', 
																					 '003' => '(COMMERCIAL CARD), PROVIDE HIGHEST BALANCE EVER UTILIZED', 
																					 '004' => '(COMMERCIAL LEASE), PROVIDE ORIGINAL LEASE AMOUNT, WITHOUT INTEREST', 
																					 '005' => '(LETTER OF CREDIT), PROVIDE HIGHEST BALANCE EVER UTILIZED', 
																					 '006' => '(REVOLVING CHARGE/CREDIT CARD), PROVIDE HIGHEST BALANCE EVER UTILIZED', 
																					 '099' => '(OTHER), PROVIDE HIGHEST BALANCE EVER CAPTURED', '');
	
Export CurrCreditLmt(String cd) := 	Case(cd,	 '001' => '(LOAN), PROVIDE ORIGINAL LOAN AMOUNT', 
																				 '002' => '(LINE OF CREDIT), PROVIDE CREDIT LIMIT', 
																				 '003' => '(COMMERCIAL CARD), PROVIDE CREDIT LIMIT', 
																				 '004' => '(COMMERCIAL LEASE), PROVIDE ORIGINAL LEASE AMOUNT', 
																				 '005' => '(LETTER OF CREDIT), PROVIDE TOTAL AMOUNT OF CREDIT', 
																				 '006' => '(REVOLVING CHARGE/CREDIT CARD), PROVIDE CREDIT LIMIT', 
																				 '099' => '(OTHER), PROVIDE ASSIGNED CREDIT LIMIT', '');
	
Export RepIndicatorLen(String cd) := 	Case(cd,	 '001' => '12 MONTHS', 
																					 '002' => '24 MONTHS', 
																					 '003' => 'LIFETIME OF ACCOUNT', 
																					 '999' => 'CURRENT PERIOD/EXCEPTION REPORTING', '');

Export PymtInterval(String cd) := 	Case(cd,	 'A' => 'ANNUALLY', 
																				 'BM' => 'BI-MONTHLY', 
																				 'BW' => 'BI-WEEKLY', 
																				 'D' => 'DAILY', 
																				 'M' => 'MONTHLY', 
																				 'Q' => 'QUARTERLY', 
																				 'S' => 'SEASONAL', 
																				 'SA' => 'SEMIANNUALLY', 
																				 'SM' => 'SEMI-MONTHLY', 
																				 'SP' => 'SINGLE PAYMENT', 
																				 'W' => 'WEEKLY ', '');
	
Export PymtStsCat(String cd) := 	Case(cd,	 '000' => 'CURRENT ACCOUNT/NOT DELINQUENT', 
																			 '001' => 'OVER 0 DAYS PAST DUE', 
																			 '002' => 'OVER 30 DAYS PAST DUE', 
																			 '003' => 'OVER 60 DAYS PAST DUE', 
																			 '004' => 'OVER 90 DAYS PAST DUE', 
																			 '005' => 'OVER 120 DAYS PAST DUE', 
																			 '006' => 'OVER 150 DAYS PAST DUE', 
																			 '007' => 'OVER 180 DAYS PAST DUE', '');

Export PymtCat(String cd) := 	Case(cd,	 '001' => 'PRINCIPAL ONLY', 
																		 '002' => 'PRINCIPAL AND INTEREST', 
																		 '003' => 'INTEREST ONLY', 
																		 '004' => 'PERCENTAGE OF BALANCE', 
																		 '005' => 'PRINCIPAL PLUS INTEREST', 
																		 '006' => 'FIXED PAYMENT AMOUNT', 
																		 '007' => 'PROMOTIONAL - INTEREST ONLY FOR AN INTRODUCTORY PERIOD, THEN FIXED PAYMENTS', 
																		 '008' => 'PROMOTIONAL - INTEREST ONLY FOR AN INTRODUCTORY PERIOD, THEN BALANCE DUE', 
																		 '009' => 'MINIMUM PAYMENT', 
																		 '099' => 'OTHER', ''); 
	
Export PymtHistProf(String cd) := 	Case(cd,	 '0' => '0 PAYMENTS PAST DUE (CURRENT ACCOUNT)', 
																				 '1' => '30 - 59 DAYS PAST DUE DATE', 
																				 '2' => '60 - 89 DAYS PAST DUE DATE', 
																				 '3' => '90 - 119 DAYS PAST DUE DATE', 
																				 '4' => '120 - 149 DAYS PAST DUE DATE', 
																				 '5' => '150 - 179 DAYS PAST DUE DATE', 
																				 '6' => '180 DAYS OR MORE PAST DUE DATE', 
																				 'B' => 'NO PAYMENT HISTORY AVAILABLE PRIOR TO THIS TIME. A â€œBâ€ MAY NOT BE EMBEDDED WITHIN OTHER VALUES.', 
																				 'D' => 'NO PAYMENT HISTORY AVAILABLE THIS MONTH. A â€œDâ€ MAY BE EMBEDDED IN THE PAYMENT PATTERN.', 
																				 'E' => 'ZERO BALANCE AND CURRENT ACCOUNT (APPLIES TO CREDIT CARDS & LINES OF CREDIT)', 
																				 'G' => 'COLLECTION', 
																				 'H' => 'FORECLOSURE', 
																				 'J' => 'VOLUNTARY SURRENDER', 
																				 'K' => 'REPOSSESSION', 
																				 'L' => 'CHARGE-OFF', '');
	
Export PymtAmtSch(String cd) := 	Case(cd,	 '001' => '(LOAN), PROVIDE AMOUNT OF SCHEDULED PAYMENT', 
																			 '002' => '(LINE OF CREDIT), PROVIDE MINIMUM AMOUNT DUE, BASED ON CURRENT BALANCE', 
																			 '003' => '(COMMERCIAL CARD), PROVIDE MINIMUM AMOUNT DUE, BASED ON CURRENT BALANCE', 
																			 '004' => 'PROVIDE SCHEDULED MONTHLY PAYMENT', 
																			 '005' => 'PROVIDE MINIMUM AMOUNT DUE, BASED ON CURRENT BALANCE', 
																			 '006' => 'PROVIDE MINIMUM AMOUNT DUE, BASED ON CURRENT BALANCE', 
																			 '099' => 'PROVIDE MINIMUM AMOUNT DUE, BASED ON CURRENT BALANCE', '');
	
Export RemBal(String cd) := 	Case(cd,	 '001' => '(LOAN), PROVIDE TOTAL OUTSTANDING BALANCE ON LOAN', 
																	 '002' => '(LINE OF CREDIT), PROVIDE TOTAL OUTSTANDING BALANCE.', 
																	 '003' => '(COMMERCIAL CARD), PROVIDE TOTAL OUTSTANDING BALANCE.', 
																	 '004' => '(COMMERCIAL LEASE), PROVIDE TOTAL AMOUNT REMAINING ON LEASE', 
																	 '005' => '(LETTER OF CREDIT), PROVIDE TOTAL OUTSTANDING BALANCE.', 
																	 '006' => '(REVOLVING CHARGE/CREDIT CARD), PROVIDE TOTAL OUTSTANDING BALANCE.', 
																	 '099' => '(OTHER), PROVIDE TOTAL OUTSTANDING BALANCE.', '');

Export MaxNumPastDue(String cd) := 	Case(cd,	 '001' => 'OVER 0 DAYS PAST DUE', 
																					 '002' => 'OVER 30 DAYS PAST DUE', 
																					 '003' => 'OVER 60 DAYS PAST DUE', 
																					 '004' => 'OVER 90 DAYS PAST DUE', 
																					 '005' => 'OVER 120 DAYS PAST DUE', 
																					 '006' => 'OVER 150 DAYS PAST DUE', 
																					 '007' => 'OVER 180 DAYS PAST DUE', '');
	
Export MaxNumPymtCyc(String cd) := 	Case(cd,	 '000' => 'CURRENT ACCOUNT/NOT DELINQUENT', 
																						 '001' => 'OVER 0 DAYS PAST DUE', 
																						 '002' => 'OVER 30 DAYS PAST DUE', 
																						 '003' => 'OVER 60 DAYS PAST DUE', 
																						 '004' => 'OVER 90 DAYS PAST DUE', 
																						 '005' => 'OVER 120 DAYS PAST DUE', 
																						 '006' => 'OVER 150 DAYS PAST DUE', 
																						 '007' => 'OVER 180 DAYS PAST DUE', '');
	
Export ChrgOffTypeInd(String cd) := 	Case(cd,	 '001' => 'PRINCIPAL ONLY', 
																					 '002' => 'PRINCIPAL AND INTEREST', 
																					 '003' => 'AMOUNT EQUAL TO BAD DEBT RESERVE', '');
	
Export GovtGrnteeCat(String cd) := 	Case(cd,	 '001' => 'SBA7A', 
																				 '002' => 'SBA LOW DOC', 
																				 '003' => 'SBA EXPRESS', 
																				 '004' => 'SBA COMMUNITY EXPRESS', 
																				 '005' => 'SBA COMMUNITY ADJ AND INVEST PROGRAM = (CAIP)', 
																				 '006' => 'SBA CERTIFIED DEVELOPMENT CO = (CDC 504)', 
																				 '007' => 'SBA CAP LINES', 
																				 '100' => 'US TREASURY - PROGRAM TYPE UNKNOWN', 
																				 '200' => 'USDA - PROGRAM TYPE UNKNOWN', 
																				 '300' => 'HUD - PROGRAM TYPE UNKNOWN ', 
																				 '400' => 'VA - PROGRAM TYPE UNKNOWN', 
																				 '500' => 'US DOE - PROGRAM TYPE UNKNOWN ', 
																				 '600' => '(TO BE DETERMINED)', 
																				 '700' => 'STATE - STATE/PROGRAM TYPE UNKNOWN  ', 
																				 '800' => 'COUNTY - COUNTY/PROGRAM TYPE UNKNOWN', 
																				 '810' => 'CITY - CITY/PROGRAM TYPE UNKNOWN', '');
	
Export AccUpdtDelInd(String cd) := 	Case(cd,	 'BLANK' => 'NO CHANGE; REGULAR UPDATE', 
																				 '' => 'NO CHANGE; REGULAR UPDATE', 
																				 '000'  => 'NO CHANGE; REGULAR UPDATE', 
																				 '001' => 'CORRECTION/REPLACEMENT OF MOST RECENT ACCOUNT UPDATE', 
																				 '002' => 'DELETE MOST RECENT UPDATE PROVIDED FOR ACCOUNT', 
																				 '003' => 'DELETE ALL ACCOUNT HISTORY', 
																				 '080' => 'DELETE DUE TO LEGAL ISSUE = (MEMBER REPORTED)', 
																				 '090' => 'DELETE DUE TO FRAUD = (MEMBER REPORTED)', '');
	
Export AddrClssif(String cd) := 	Case(cd,	 '001' => 'BUSINESS LOCATION', 
																		 '002' => 'BILLING/ACCOUNTING/ACCOUNTS PAYABLE LOCATION ', 
																		 '003' => 'ADDRESS: IN CARE OF', 
																		 '004' => 'BUSINESS LOCATION AND IN CARE OF', 
																		 '005' => 'MAILING/SHIPPING ADDRESS', 
																		 '006' => 'BILLING AGENT', 
																		 '007' => 'HEADQUARTERS/CORPORATE OFFICE(S)', 
																		 '008' => 'SATELLITE /REGIONAL OFFICE/BRANCH ', 
																		 '009' => 'SERVICE LOCATION/METER LOCATION', 
																		 '010' => 'MILITARY ADDRESS', 
																		 '011' => 'HOME - RESIDENCE ONLY', 
																		 '012' => 'HOME - RESIDENCE WITH HOME BASED OFFICE', '');
	
Export GrntorOwnerInd(String cd) := 	Case(cd,	 '001' => 'OWNER', 
																					 '002' => 'GUARANTOR', 
																					 '003' => 'BOTH OWNER AND GUARANTOR', '');
	
Export ClssifCdType(String cd) := 	Case(cd,	 '001' => 'SIC CODE', 
																			 '002' => 'NAICS CODE', 
																			 '003' => 'DUNS NUMBER', '');
	
Export CollateralSecuredAccType(String cd) := 	Case(cd,	 '001' => 'EQUIPMENT', 
																									 '002' => 'BLANKET', 
																									 '003' => 'ACCOUNTS RECEIVABLE', 
																									 '004' => 'INVENTORY', 
																									 '005' => 'AR AND INVENTORY', 
																									 '006' => 'VEHICLE(S) ', 
																									 '007' => 'MARKETABLE SECURITIES', 
																									 '008' => 'COMMERCIAL REAL ESTATE', 
																									 '009' => 'RESIDENTIAL REAL ESTATE', 
																									 '010' => 'CASH', 
																									 '099' => 'OTHER', '');
	
Export ConvMaintenanceType(String cd) := 	Case(cd,	 '001' => 'SYSTEM CONVERSION', 
																								 '002' => 'ACQUISITION', 
																								 '003' => 'ACCOUNT TRANSFERRED TO SERVICE PROVIDER', 
																								 '004' => 'ACCOUNT TRANSFERRED FROM SERVICE PROVIDER', 
																								 '005' => 'ACCOUNT TRANSFERRED TO COLLECTION/RECOVERY - INTERNAL', 
																								 '006' => 'ACCOUNT TRANSFERRED TO COLLECTION/RECOVERY - EXTERNAL ', '');
	
EXPORT PhoneType(STRING cd)						:= 	CASE(cd,	'001' => 'LANDLINE - VOICE', 
																										'002' => 'LANDLINE - FAX', 
																										'003' => 'WIRELESS', 
																										'004' => 'VOIP (VOICE OVER IP)', '');
END;