export business_functions :=
module

	export fisActiveBusiness(string pcode, string pdescription) :=
	function
	
		isingoodstanding :=
			(		regexfind('active',pdescription,nocase)
			and (not regexfind('inactive',pdescription,nocase)))
			or regexfind('good',pdescription,nocase)
			or regexfind('in existence',pdescription,nocase)
			or regexfind('in use',pdescription,nocase)
			or regexfind('COMPLIANCE',pdescription,nocase)
			;
		isother := 
				regexfind('merged',pdescription,nocase)
			or regexfind('conversion',pdescription,nocase)
			or regexfind('conditionally dissolved',pdescription,nocase)
			or pdescription = ''
			;
		
		isdelinquent := 
				regexfind('NON-COMPLIANCE',pdescription,nocase)
			or regexfind('NOT IN GOOD STANDING',pdescription,nocase)
			or regexfind('PENDING GOOD STANDING',pdescription,nocase)
			or regexfind('ACTIVE - DISSOLVED',pdescription,nocase)
			or regexfind('ACTIVE - NON COMPLIANT',pdescription,nocase)
			or regexfind('ACTIVE - SUSPENDED',pdescription,nocase)
			or regexfind('ACTIVE-APPLICATION SUBMITTED',pdescription,nocase)
			or regexfind('ACTIVE-EXPIRATION OF BOND',pdescription,nocase)
			or regexfind('ACTIVE-EXPIRED LICENSE RENEWAL',pdescription,nocase)
			or regexfind('ACTIVE/REGISTERED AGENT RESIGNED',pdescription,nocase)
			or regexfind('ACTIVE-EXPIRED LICENSE RENEWAL',pdescription,nocase)
			or regexfind('ACTIVE-EXPIRED LICENSE RENEWAL',pdescription,nocase)
			or regexfind('ACTIVE-EXPIRED LICENSE RENEWAL',pdescription,nocase)
			or pdescription = ''
			;

		return map(
			 isingoodstanding and not isdelinquent and not isother =>	'G'
			,											'D'
		);
	end;

	export fisDissolved(string pcode, string pdescription) :=
	function
	
		isDissolved := 
				 regexfind('SUSPENDED'		,pdescription,nocase)
			or regexfind('CANCELLED'		,pdescription,nocase)
			or regexfind('SURRENDERED'	,pdescription,nocase)
			or regexfind('TERM EXPIRED'	,pdescription,nocase)
			or regexfind('DISSOLVED'		,pdescription,nocase)
			or regexfind('FORFEITED'		,pdescription,nocase)
			or regexfind('DELETED'			,pdescription,nocase)
			or regexfind('INACTIVE'			,pdescription,nocase)
			;
		
		return if(isDissolved, true, false);

	end;

	export 	fisReinstated(string pcode, string pdescription) :=
	function
	
		isDissolved := 
				 regexfind('REINSTATEMENT'		,pdescription,nocase)
			;
		
		return if(isDissolved, true, false);

	end;

	export fIsDerogEvent(string pdescription) :=
	function
	
		isDerog := 
			 regexfind('AGENT RESIGNED'																		,pdescription,nocase)
		or regexfind('CANCELLATION'																			,pdescription,nocase)
		or regexfind('DISSOLVE'																					,pdescription,nocase)
		or regexfind('DISSOLUTION'																			,pdescription,nocase)
		or regexfind('CERTIFICATE OF DISSOLUTION'												,pdescription,nocase)
		or regexfind('CERTIFICATE OF ELECTION TO DISSOLVE'							,pdescription,nocase)
		or regexfind('CERTIFICATE OF REVOCATION OF ELECTION TO DISSOLVE',pdescription,nocase)
		or regexfind('DISSOLVE A CONDITIONALLY DISSOLVED CORPORATION'		,pdescription,nocase)
		or regexfind('DISSOLVED (FOR SINGLE DOCUMENT)'									,pdescription,nocase)
		or regexfind('FRANCHISE TAX BOARD FORFEITURE'										,pdescription,nocase)
		or regexfind('FRANCHISE TAX BOARD RESTORATION'									,pdescription,nocase)
		or regexfind('FRANCHISE TAX BOARD REVIVER'											,pdescription,nocase)
		or regexfind('FRANCHISE TAX BOARD REVIVOR'											,pdescription,nocase)
		or regexfind('FRANCHISE TAX BOARD SUSPENSION'										,pdescription,nocase)
		or regexfind('SAVINGS & LOAN CERTIFICATE OF APPROVAL FORFEITED'	,pdescription,nocase)
		or regexfind('SECRETARY OF STATE FORFEITURE'										,pdescription,nocase)
		or regexfind('SECRETARY OF STATE REVIVER'												,pdescription,nocase)
		or regexfind('SECRETARY OF STATE SUSPENSION'										,pdescription,nocase)
		or regexfind('TERM EXPIRED'																			,pdescription,nocase)
		or regexfind('FOREIGN INSURANCE MERGER'													,pdescription,nocase)
		or regexfind('REVOCATION'																				,pdescription,nocase)
		or regexfind('APPLICATION FOR AMENDED CERTIFICATE OF AUTHORITY'	,pdescription,nocase)
		or regexfind('MERGER'																						,pdescription,nocase)
		or regexfind('DO NOT USE'																				,pdescription,nocase)
		or regexfind('CONVERSION'																				,pdescription,nocase)
		or regexfind('DEFICIENT'																				,pdescription,nocase)
		or regexfind('DISHONORED'																				,pdescription,nocase)
		or regexfind('RESIGNATION'																			,pdescription,nocase)
		or regexfind('NAME CHANGE'																			,pdescription,nocase)
		or regexfind('CORRECTION'																				,pdescription,nocase)
		or regexfind('SURREND'																					,pdescription,nocase)
		or regexfind('TERMINATION'																			,pdescription,nocase)
		or regexfind('WINDING UP'																				,pdescription,nocase)
		or regexfind('WRIT OF MANDATE'																	,pdescription,nocase)
		or regexfind('DON NOT USE'																			,pdescription,nocase)
		or regexfind('UNDELIVERABLE'																		,pdescription,nocase)
		or regexfind('OUT OF BUSINESS'																	,pdescription,nocase)
		or regexfind('CONSOLIDAITON'																		,pdescription,nocase)
		or regexfind('WITHDRAWAL'																				,pdescription,nocase)
		or regexfind('CONVERT OUT'																			,pdescription,nocase)
		or regexfind('MERGE'																						,pdescription,nocase)
		or regexfind('DEFUNCT'																					,pdescription,nocase)
		or regexfind('REJECTION'																				,pdescription,nocase)
		or regexfind('SURVIVING CORPORATION'														,pdescription,nocase)
		or regexfind('SURVIVOR FILE NO'																	,pdescription,nocase)
		or regexfind('INVOLUNTARY'																			,pdescription,nocase)
		or regexfind('DISS '																						,pdescription,nocase)
		or regexfind('DROPPING DBA'																			,pdescription,nocase)
		or regexfind('SURVIVOR FILE NO'																	,pdescription,nocase)
		or regexfind('RSGN'																							,pdescription,nocase)
		or regexfind('FORFEIT'																					,pdescription,nocase)
		or regexfind('FORFIETURE'																				,pdescription,nocase)
		or regexfind('CANCEL'																						,pdescription,nocase)
		or regexfind('ABANDONMENT'																			,pdescription,nocase)
		or regexfind('ABANDON '																					,pdescription,nocase)
		or regexfind('BANKRUPTCY'																				,pdescription,nocase)
		or regexfind('CONSOLIDATION'																		,pdescription,nocase)
		or regexfind('PROBLEM'																					,pdescription,nocase)
		or regexfind('NATURE OF BUSINESS CHANGED'												,pdescription,nocase)
			;
		
		return if(isDerog, true, false);

	end;

	export fStandardizeAddressType(string address_type,string pPrim_name) :=
	function
	
		laddress_type := trim(stringlib.stringtouppercase(address_type),left,right);
	
		return map(
			 laddress_type = 'AGENT/OWNER ADDRESS'                                                           => 'AGENT/OWNER ADDRESS'
			,laddress_type = 'AGENT/OWNER/CONTACT ADDRESS'                                                   => 'AGENT/OWNER/CONTACT ADDRESS'
			,laddress_type = 'ANNUAL REPORT - PRESIDENT ADDRESS'                                             => 'ANNUAL REPORT - PRESIDENT ADDRESS'
			,laddress_type = 'ANNUAL REPORT - SECRETARY ADDRESS'                                             => 'ANNUAL REPORT - SECRETARY ADDRESS'
			,laddress_type = 'APPLICANT ADDRESS'                                                             => 'APPLICANT ADDRESS'
			,laddress_type = 'AUTHORIZED REPRESENTATIVE ADDRESS'                                             => 'AUTHORIZED REPRESENTATIVE ADDRESS'
			,laddress_type = 'BUSINESS'                                                                      => 'BUSINESS ADDRESS'
			,laddress_type = 'BUSINESS ADDRESS'                                                              => 'BUSINESS ADDRESS'
			,laddress_type = 'CEO ADDRESS'                                                                   => 'CEO ADDRESS'
			,laddress_type = 'CHAIRMAN OR CHIEF EXECUTIVE OFFICER ADDRESS'                                   => 'CHAIRMAN OR CHIEF EXECUTIVE OFFICER ADDRESS'
			,laddress_type = 'CHARTER OFFICER ADDRESS'                                                       => 'CHARTER OFFICER ADDRESS'
			,laddress_type = 'CONTACT'                                                                       => 'CONTACT ADDRESS'
			,laddress_type = 'CONTACT ADDRESS'                                                               => 'CONTACT ADDRESS'
			,laddress_type = 'CORPORATE ADDRESS'                                                             => 'CORPORATE ADDRESS'
			,laddress_type = 'CORPORATE MAILING ADDRESS'                                                     => 'CORPORATE MAILING ADDRESS'
			,laddress_type = 'CORRESPONDENT ADDRESS'                                                         => 'CORRESPONDENT ADDRESS'
			,laddress_type = 'DOMICILE STREET ADDRESS'                                                       => 'DOMICILE STREET ADDRESS'
			,laddress_type = 'EXECUTIVE OFFICE'                                                              => 'EXECUTIVE ADDRESS'
			,laddress_type = 'FICTITOUS NAME CONTACT ADDRESS'                                                => 'FICTITIOUS NAME CONTACT ADDRESS'
			,laddress_type = 'FILING'                                                                        => 'FILING'
			,laddress_type = 'FOREIGN CORPORATION, LOUISIANA REGISTERED OFFICE'                              => 'FOREIGN CORPORATION, LOUISIANA REGISTERED OFFICE'
			,laddress_type = 'FOREIGN CORPORATION, PRINCIPAL BUSINESS ESTABLISHMENT IN LA'                   => 'FOREIGN CORPORATION, PRINCIPAL BUSINESS ESTABLISHMENT IN LA'
			,laddress_type = 'FOREIGN CORPORATION, PRINCIPAL BUSINESS OFFICE'                                => 'FOREIGN CORPORATION, PRINCIPAL BUSINESS OFFICE'
			,laddress_type = 'GENERAL PARTNER ADDRESS'                                                       => 'GENERAL PARTNER ADDRESS'
			,laddress_type = 'HOME ADDRESS'                                                                  => 'HOME ADDRESS'
			,laddress_type = 'HOME OFFICE / PRINCIPAL PLACE OF BUSINESS'                                     => 'HOME OFFICE / PRINCIPAL PLACE OF BUSINESS'
			,laddress_type = 'HOME OFFICE'                                                                   => 'HOME OFFICE ADDRESS'
			,laddress_type = 'INCORPORATOR ADDRESS'                                                          => 'INCORPORATOR ADDRESS'
			,laddress_type = 'LIMITED PARTNERSHIP ADDRESS'                                                   => 'LIMITED PARTNERSHIP ADDRESS'
			,laddress_type = 'LISTING'                                                                       => 'LISTING ADDRESS'
			,laddress_type = 'LISTING ADDRESS'                                                               => 'LISTING ADDRESS'
			,laddress_type = 'LOCAL OFFICE ADDRESS'                                                          => 'LOCAL OFFICE ADDRESS'
			,laddress_type = 'MAILING'                                                                       => 'MAILING ADDRESS'
			,laddress_type = 'MAILING ADDRESS'                                                               => 'MAILING ADDRESS'
			,laddress_type = 'MAILING ADDRESS ADDRESS'                                                       => 'MAILING ADDRESS'
			,laddress_type = 'MAIN BUSINESS ADDRESS'                                                         => 'MAIN BUSINESS ADDRESS'
			,laddress_type = 'MANAGER ADDRESS'                                                               => 'MANAGER ADDRESS'
			,laddress_type = 'MANAGER/MEMBER ADDRESS'                                                        => 'MANAGER/MEMBER ADDRESS'
			,laddress_type = 'MANAGING PARTNER ADDRESS'                                                      => 'MANAGING PARTNER ADDRESS'
			,laddress_type = 'MARKHOLDER ADDRESS'                                                            => 'MARK HOLDER ADDRESS'
			,laddress_type = 'MARKHOLDER'                                                                    => 'MARKHOLDER'
			,laddress_type = 'MEMBER ADDRESS'                                                                => 'MEMBER ADDRESS'
			,laddress_type = 'NAMEHOLDER ADDRESS'                                                            => 'NAME HOLDER ADDRESS'
			,laddress_type = 'NONFILEABLE CORRESPONDENT ADDRESS'                                             => 'NONFILEABLE CORRESPONDENT ADDRESS'
			,laddress_type = 'OFFICER ADDRESS'                                                               => 'OFFICER ADDRESS'
			,laddress_type = 'OFFICER'                                                                       => 'OFFICER ADDRESS'
			,laddress_type = 'OFFICER/PARTNER ADDRESS'                                                       => 'OFFICER/PARTNER ADDRESS'
			,laddress_type = 'OFFICER/PARTNER/MANAGER ADDRESS'                                               => 'OFFICER/PARTNER/MANAGER ADDRESS'
			,laddress_type = 'OTHER'                                                                         => 'OTHER ADDRESS'
			,laddress_type = 'OTHER ADDRESS'                                                                 => 'OTHER ADDRESS'
			,laddress_type = 'OWNER ADDRESS'                                                                 => 'OWNER ADDRESS'
			,laddress_type = 'PARTNER ADDRESS'                                                               => 'PARTNER ADDRESS'
			,laddress_type = 'PHYSICAL'                                                                      => 'PHYSICAL'
			,laddress_type = 'PRESIDENT ADDRESS'                                                             => 'PRESIDENT ADDRESS'
			,laddress_type = 'PREV REG. OFFICE'                                                              => 'PREV REG. OFFICE'
			,laddress_type = 'PREV REG MAILING'                                                              => 'PREV REG. OFFICE'
			,laddress_type = 'PREVIOUS BUSINESS'                                                             => 'PREVIOUS BUSINESS ADDRESS'
			,laddress_type = 'PREVIOUS MAILING'                                                              => 'PREVIOUS MAILING'
			,laddress_type = 'PREV MAILING'                                                                  => 'PREVIOUS MAILING'
			,laddress_type = 'PREV PRINCIPAL'                                                                => 'PREVIOUS PRINCIPAL OFFICE'
			,laddress_type = 'PREVIOUS PRINCIPAL OFFICE'                                                     => 'PREVIOUS PRINCIPAL OFFICE'
			,laddress_type = 'PREVIOUS REGISTERED OFFICE'                                                    => 'PREVIOUS REGISTERED OFFICE ADDRESS'
			,laddress_type = 'PREVIOUS UCC ADDRESS'                                                          => 'PREVIOUS UCC ADDRESS'
			,laddress_type = 'PRIMARY CORPORATE ADDRESS'                                                     => 'PRIMARY CORPORATE ADDRESS'
			,laddress_type = 'PRIMARY CORPORATE ADDRESS CONTACT ADDRESS'                                     => 'PRIMARY CORPORATE ADDRESS/CONTACT ADDRESS'
			,laddress_type = 'PRINCIPAL CONTACT RESIDENTIAL ADDRESS'                                         => 'PRINCIAL CONTCAT RESIDENTIAL ADDRESS'
			,laddress_type = 'PRINCIPAL OFFICE'                                                              => 'PRINCIPAL ADDRESS'
			,laddress_type = 'PRINCIPAL ADDRESS'                                                             => 'PRINCIPAL ADDRESS'
			,laddress_type = 'PRINCIPAL'                                                                     => 'PRINCIPAL ADDRESS'
			,laddress_type = 'PRINCIPAL BUSINESS ADDRESS'                                                    => 'PRINCIPAL BUSINESS ADDRESS'
			,laddress_type = 'PRINCIPAL CONTACT BUSINESS ADDRESS'                                            => 'PRINCIPAL CONTACT BUSINESS ADDRESS'
			,laddress_type = 'PRINCIPAL CORPORATE ADDRESS'                                                   => 'PRINCIPAL CORPORATE ADDRESS'
			,laddress_type = 'PRINCIPAL CORPORATE ADDRESS CONTACT ADDRESS'                                   => 'PRINCIPAL CORPORATE ADDRESS/CONTACT ADDRESS'
			,laddress_type = 'PRINCIPAL EXECUTIVE OFFICE ADDRESS'                                            => 'PRINCIPAL EXECUTIE OFFICE ADDRESS'
			,laddress_type = 'PRINCIPAL MAILING'                                                             => 'PRINCIPAL MAILING ADDRESS'
			,laddress_type = 'PRINCIPAL ADDRESS'                                                             => 'PRINCIPAL MAILING ADDRESS'
			,laddress_type = 'PRINCIPAL OFFICE'                                                              => 'PRINCIPAL OFFICE ADDRESS'
			,laddress_type = 'PRINCIPAL OFFICE ADDRESS'                                                      => 'PRINCIPAL OFFICE ADDRESS'
			,laddress_type = 'PRINCIPAL OFFICE IN NM'                                                        => 'PRINCIPAL OFFICE ADDRESS'
			,laddress_type = 'PRIOR ADDRESS'                                                                 => 'PRIOR ADDRESS'
			,laddress_type = 'PROCESS ADDRESS'                                                               => 'PROCESS ADDRESS'
			,laddress_type = 'PROCESS'                                                                       => 'PROCESS ADDRESS'
			,laddress_type = 'QUICK ACCOUNT'                                                                 => 'QUICK ACCOUNT'
			,laddress_type = 'REG. NAME OWNER'                                                               => 'REG. NAME OWNER'
			,laddress_type = 'REGISTERED AGENT ADDRESS'                                                      => 'REGISTERED AGENT ADDRESS'
			,laddress_type = 'REGISTERED AGENT MAILING ADDRESS'                                              => 'REGISTERED AGENT MAILING ADDRESS'
			,laddress_type = 'REGISTERED AGENT RESIDENTIAL ADDRESS'                                          => 'REGISTERED AGENT RESIDENTIAL ADDRESS'
			,laddress_type = 'REGISTERED NAME ADDRESS'                                                       => 'REGISTERED NAME ADDRESS'
			,laddress_type = 'REGISTERED OFFICE'                                                             => 'REGISTERED OFFICE ADDRESS'
			,laddress_type = 'REGISTRANT ADDRESS'                                                            => 'REGISTRANT ADDRESS'
			,laddress_type = 'REGISTRANT'                                                                    => 'REGISTRANT ADDRESS'
			,laddress_type = 'RESERVER'                                                                      => 'RESERVER ADDRESS'
			,laddress_type = 'RESIDENTIAL ADDRESS'                                                           => 'RESIDENTIAL ADDRESS'
			,laddress_type = 'SECONDARY CORPORATE ADDRESS'                                                   => 'SECONDARY CORPORATE ADDRESS'
			,laddress_type = 'SECONDARY CORPORATE ADDRESS CONTACT ADDRESS'                                   => 'SECONDARY CORPORATE ADDRESS/CONTACT ADDRESS'
			,laddress_type = 'SECRETARY ADDRESS'                                                             => 'SECRETARY ADDRESS'
			,laddress_type = 'SERVICE OF PROCESS ADDRESS'                                                    => 'SERVICE OF PROCESS ADDRESS'
			,laddress_type = 'SPECIAL ADDRESS INFORMATION'                                                   => 'SPECIAL ADDRESS INFORMATION'
			,laddress_type = 'STATUTORY AGENT CONTACT ADDRESS'                                               => 'STATUTORY AGENT CONTACT ADDRESS'
			,laddress_type = 'TRUSTEE ADDRESS'                                                               => 'TRUSTEE ADDRESS'
			,laddress_type = 'UCC ADDRESS'                                                                   => 'UCC ADDRESS'
			,''
		);
	end;

	export mymin(unsigned8 pnum1, unsigned8 pnum2) := map(pnum2 != 0 and pnum1 = 0 => pnum2
																								,pnum1 != 0 and pnum2 = 0 => pnum1
																								,pnum1 > pnum2						=> pnum2
																								,pnum1
																						);
	export mymax(unsigned8 pnum1, unsigned8 pnum2) := map(pnum2 != 0 and pnum1 = 0 => pnum2
																								,pnum1 != 0 and pnum2 = 0 => pnum1
																								,pnum1 > pnum2						=> pnum1
																								,pnum2
																						);


end;