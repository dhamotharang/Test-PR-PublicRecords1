IMPORT corp2, corp2_mapping, corp2_raw_nm;

EXPORT Functions := Module

		//********************************************************************
		//CorpForeignDomesticInd: Returns "corp_foreign_domestic_ind".
		//********************************************************************	
		EXPORT CorpForeignDomesticInd(STRING s) := FUNCTION
					 uc_s  := corp2.t2u(s);
					 RETURN map(
											uc_s='DOMESTIC AGENCY CONNECTED'                         										=> 'D',
											uc_s='DOMESTIC COOPERATIVE EXEMPT'                     											=> 'D',
											uc_s='DOMESTIC COOPERATIVE REPORTER'                       									=> 'D',
											uc_s='DOMESTIC CREDIT UNION'														 										=> 'D',
											uc_s='DOMESTIC FINANCIAL EXEMPT'                         										=> 'D',
											uc_s='DOMESTIC INSURANCE COMPANY - MUTUAL'							 										=> 'D',
											uc_s='DOMESTIC LIMITED LIABILITY COMPANY'                										=> 'D',
											uc_s='DOMESTIC NONPROFIT'                                										=> 'D',
											uc_s='DOMESTIC NONPROFIT CORPORATION'                    										=> 'D',
											uc_s='DOMESTIC NONPROFIT EXEMPT'                         										=> 'D',
											uc_s='DOMESTIC NONPROFIT MARKETING COOPERATIVE ASSOCIATION WITHOUT SHARES'	=> 'D',
											uc_s='DOMESTIC NONPROFIT WATER USERS ASSOCIATION WITHOUT SHARES'						=> 'D',
											uc_s='DOMESTIC PARTNERSHIP TO GENERAL LIABILITY COMPANY' 										=> 'D',
											uc_s='DOMESTIC PROFESSIONAL CORPORATION'                 										=> 'D',
											uc_s='DOMESTIC PROFIT'                                  	 									=> 'D',
											uc_s='DOMESTIC PROFIT COOPERATIVE ASSOCIATION WITH SHARES'									=> 'D',
											uc_s='DOMESTIC PROFIT COOPERATIVE ASSOCIATION WITHOUT SHARES'								=> 'D',
											uc_s='DOMESTIC PROFIT CORPORATION'                       										=> 'D',
											uc_s='DOMESTIC PROFIT EXEMPT'                            										=> 'D',
											uc_s='DOMESTIC PROFIT PROFESSIONAL ASSOCIATION' 				 										=> 'D',
											uc_s='DOMESTIC PROFIT PROFESSIONAL CORPORATION'          										=> 'D',
											uc_s='DOMESTIC REDOMESTICATED'                           										=> 'D',
											uc_s='DOMESTIC RURAL ELECTRIC COOPERATIVE'																	=> 'D',
											uc_s='DOMESTIC SANITARY PROJECT ASSOCIATIONS'																=> 'D',
											uc_s='DOMESTIC SAVINGS AND LOAN'																						=> 'D',
											uc_s='DOMESTIC STATE BANK'																									=> 'D',
											uc_s='FOREIGN BUSINESS TRUST'                            										=> 'F',
											uc_s='FOREIGN COOPERATIVE'																									=> 'F',
											uc_s='FOREIGN COOPERATIVE EXEMPT'                        										=> 'F',
											uc_s='FOREIGN COOPERATIVE REPORTER'                      										=> 'F',
											uc_s='FOREIGN FEDERAL SAVINGS BANK'																					=> 'F',
											uc_s='FOREIGN FINANCIAL EXEMPT'                         										=> 'F',
											uc_s='FOREIGN LIMITED LIABILITY COMPANY'               										  => 'F',
											uc_s='FOREIGN NONPROFIT'                                 										=> 'F',
											uc_s='FOREIGN NONPROFIT CORPORATION'                    									  => 'F',
											uc_s='FOREIGN NONPROFIT EXEMPT'                          										=> 'F',
											uc_s='FOREIGN PROFESSIONAL CORPORATION'                  										=> 'F',
											uc_s='FOREIGN PROFIT'                                    										=> 'F',
											uc_s='FOREIGN PROFIT CORPORATION'                      										  => 'F',
											uc_s='FOREIGN PROFIT COOPERATIVE ASSOCIATION WITHOUT SHARES'								=> 'F',
											uc_s='FOREIGN PROFIT EXEMPT'                             										=> 'F',
											uc_s='FOREIGN PROFIT PROFESSIONAL ASSOCIATION'															=> 'F',
											uc_s='FOREIGN PROFIT PROFESSIONAL CORPORATION'															=> 'F',
											uc_s='FOREIGN PROFIT TELEPHONE COOPERATIVE ASSOCIATION WITHOUT SHARES'			=> 'F',
											uc_s='FOREIGN RURAL ELECTRIC COOPERATIVE'																		=> 'F',
											uc_s='OTHER/DOMESTIC AGENCY CONNECTED'																			=> 'D',
											uc_s='OTHER/DOMESTIC COOPERATIVE EXEMPT'																		=> 'D',
											uc_s='OTHER/DOMESTIC COOPERATIVE REPORTER'																	=> 'D',
											uc_s='OTHER/DOMESTIC NONPROFIT EXEMPT'																			=> 'D',
											uc_s='OTHER/DOMESTIC PROFIT EXEMPT'																					=> 'D',
											uc_s='OTHER/FOREIGN COOPERATIVE EXEMPT'																			=> 'F',
											uc_s='OTHER/FOREIGN PROFIT EXEMPT'																					=> 'F',
											uc_s='OTHER/NO CORP TYPE FROM MNFRM'																				=> 'D',
					            //Begins old 4 letter codes 7/18/2016
					            uc_s='DLLC'   														                                  => 'D',
											uc_s='DPPA' 														                                    => 'D',
											uc_s='DPRX'  														                                   	=> 'D',
											uc_s='DRNP'													                                     		=> 'D',
											uc_s='FLLC'                                     														=> 'F',
											uc_s='FPPC'                                    															=> 'F',
											uc_s='FRNP'                                     														=> 'F',
											uc_s='FPXX'                                     														=> 'F',
											//Begins old codes 6/28/2016
											uc_s='DCR'	                                    														=> 'D',
											uc_s='DCX'	                                    														=> 'D',
											uc_s='DFX'	                                    														=> 'D',
											uc_s='DLC'	                                    														=> 'D',
											uc_s='DNA'	                                    														=> 'D',
											uc_s='DNP'	                                    														=> 'D',
											uc_s='DNX'	                                    														=> 'D',
											uc_s='DPC'	                                    														=> 'D',
											uc_s='DPR'	                                    														=> 'D',
											uc_s='DPX'	                                    														=> 'D',
											uc_s='DRD'	                                    														=> 'D',
											uc_s='FBT'	                                    														=> 'F',
											uc_s='FCR'	                                    														=> 'F',
											uc_s='FCX'	                                    														=> 'F',
											uc_s='FFX'	                                    														=> 'F',
											uc_s='FLC'	                                    														=> 'F',
											uc_s='FNP'	                                    														=> 'F',
											uc_s='FNX'	                                    														=> 'F',
											uc_s='FPC'	                                    														=> 'F',
											uc_s='FPR'	                                   															=> 'F',
											uc_s='FPX'	                                    														=> 'F',			
											''
										 );
		END;
		
		//********************************************************************
		//CorpForProfitInd: Returns "corp_for_profit_ind".
		//********************************************************************	
		EXPORT CorpForProfitInd(STRING s) := FUNCTION
					 uc_s  := corp2.t2u(s);
					 RETURN map(uc_s='DOMESTIC NONPROFIT'                                										=> 'N',
											uc_s='DOMESTIC NONPROFIT CORPORATION'                    										=> 'N',
											uc_s='DOMESTIC NONPROFIT EXEMPT'                         										=> 'N',
											uc_s='DOMESTIC NONPROFIT MARKETING COOPERATIVE ASSOCIATION WITHOUT SHARES'	=> 'N',
											uc_s='DOMESTIC NONPROFIT WATER USERS ASSOCIATION WITHOUT SHARES'						=> 'N',
											uc_s='DOMESTIC PROFIT'                                  	 									=> 'Y',
											uc_s='DOMESTIC PROFIT COOPERATIVE ASSOCIATION WITH SHARES'									=> 'Y',
											uc_s='DOMESTIC PROFIT COOPERATIVE ASSOCIATION WITHOUT SHARES'								=> 'Y',
											uc_s='DOMESTIC PROFIT CORPORATION'                       										=> 'Y',
											uc_s='DOMESTIC PROFIT EXEMPT'                            										=> 'Y',
											uc_s='DOMESTIC PROFIT PROFESSIONAL ASSOCIATION' 				 										=> 'Y',
											uc_s='DOMESTIC PROFIT PROFESSIONAL CORPORATION'          										=> 'Y',
											uc_s='FOREIGN NONPROFIT'                                 										=> 'N',
											uc_s='FOREIGN NONPROFIT CORPORATION'                    									  => 'N',
											uc_s='FOREIGN NONPROFIT EXEMPT'                          										=> 'N',
											uc_s='FOREIGN PROFIT'                                    										=> 'Y',
											uc_s='FOREIGN PROFIT CORPORATION'                      										  => 'Y',
											uc_s='FOREIGN PROFIT COOPERATIVE ASSOCIATION WITHOUT SHARES'								=> 'Y',
											uc_s='FOREIGN PROFIT EXEMPT'                             										=> 'Y',
											uc_s='FOREIGN PROFIT PROFESSIONAL ASSOCIATION'															=> 'Y',
											uc_s='FOREIGN PROFIT PROFESSIONAL CORPORATION'															=> 'Y',
											uc_s='FOREIGN PROFIT TELEPHONE COOPERATIVE ASSOCIATION WITHOUT SHARES'			=> 'Y',
											uc_s='OTHER/DOMESTIC NONPROFIT EXEMPT'																			=> 'N',
											uc_s='OTHER/DOMESTIC PROFIT EXEMPT'																					=> 'Y',
											uc_s='OTHER/FOREIGN PROFIT EXEMPT'																					=> 'Y',
 					            //Begins old 4 letter codes 7/18/2016
					            uc_s='DPPA'      															                              => 'Y',
											uc_s='DPRX'                                     														=> 'Y',
											uc_s='DRNP'                                     														=> 'N',
											uc_s='FPPC'                                     														=> 'Y',
											uc_s='FRNP'                                     														=> 'N',
											uc_s='FPXX'                                     														=> 'Y',
											//Begins old codes 6/28/2016
											uc_s='DPR'	                                    														=> 'Y',
											uc_s='DPX'	                                    														=> 'Y',
											uc_s='FPR'	                                    														=> 'Y',
											uc_s='FPX'	                                    														=> 'Y',
											uc_s='DNP'	                                    														=> 'N',
											uc_s='DNX'	                                    														=> 'N',
											uc_s='FNP'	                                    														=> 'N',
											uc_s='FNX'	                                    														=> 'N',
											''
										);
		END;
		
		//********************************************************************
		//CorpOrigOrgStructureCD: Returns "corp_orig_org_structure_cd".
		//Note: If corptype is a description then return a blank else return
		//			the code.
		//********************************************************************	
		EXPORT CorpOrigOrgStructureCD(STRING s) := FUNCTION
					 uc_s  := corp2.t2u(s);

					 RETURN map(uc_s='DOMESTIC AGENCY CONNECTED'                         										=> '',
											uc_s='DOMESTIC COOPERATIVE EXEMPT'                     											=> '',
											uc_s='DOMESTIC COOPERATIVE REPORTER'                       									=> '',
											uc_s='DOMESTIC CREDIT UNION'														 										=> '',
											uc_s='DOMESTIC FINANCIAL EXEMPT'                         										=> '',
											uc_s='DOMESTIC INSURANCE COMPANY - MUTUAL'							 										=> '',
											uc_s='DOMESTIC LIMITED LIABILITY COMPANY'                										=> '',
											uc_s='DOMESTIC NONPROFIT'                                										=> '',
											uc_s='DOMESTIC NONPROFIT CORPORATION'                    										=> '',
											uc_s='DOMESTIC NONPROFIT EXEMPT'                         										=> '',
											uc_s='DOMESTIC NONPROFIT MARKETING COOPERATIVE ASSOCIATION WITHOUT SHARES'	=> '',
											uc_s='DOMESTIC NONPROFIT WATER USERS ASSOCIATION WITHOUT SHARES'						=> '',
											uc_s='DOMESTIC PARTNERSHIP TO GENERAL LIABILITY COMPANY' 										=> '',
											uc_s='DOMESTIC PROFESSIONAL CORPORATION'                 										=> '',
											uc_s='DOMESTIC PROFIT'                                  	 									=> '',
											uc_s='DOMESTIC PROFIT COOPERATIVE ASSOCIATION WITH SHARES'									=> '',
											uc_s='DOMESTIC PROFIT COOPERATIVE ASSOCIATION WITHOUT SHARES'								=> '',
											uc_s='DOMESTIC PROFIT CORPORATION'                       										=> '',
											uc_s='DOMESTIC PROFIT EXEMPT'                            										=> '',
											uc_s='DOMESTIC PROFIT PROFESSIONAL ASSOCIATION' 				 										=> 'DOMES',
											uc_s='DOMESTIC PROFIT PROFESSIONAL CORPORATION'          										=> '',
											uc_s='DOMESTIC REDOMESTICATED'                           										=> '',
											uc_s='DOMESTIC RURAL ELECTRIC COOPERATIVE'																	=> '',
											uc_s='DOMESTIC SANITARY PROJECT ASSOCIATIONS'																=> '',
											uc_s='DOMESTIC SAVINGS AND LOAN'																						=> '',
											uc_s='DOMESTIC STATE BANK'																									=> '',
											uc_s='FOREIGN BUSINESS TRUST'                            										=> '',
											uc_s='FOREIGN COOPERATIVE'																									=> '',
											uc_s='FOREIGN COOPERATIVE EXEMPT'                        										=> '',
											uc_s='FOREIGN COOPERATIVE REPORTER'                      										=> '',
											uc_s='FOREIGN FEDERAL SAVINGS BANK'																					=> '',
											uc_s='FOREIGN FINANCIAL EXEMPT'                         										=> '',
											uc_s='FOREIGN LIMITED LIABILITY COMPANY'               										  => '',
											uc_s='FOREIGN NONPROFIT'                                 										=> '',
											uc_s='FOREIGN NONPROFIT CORPORATION'                    									  => '',
											uc_s='FOREIGN NONPROFIT EXEMPT'                          										=> '',
											uc_s='FOREIGN PROFESSIONAL CORPORATION'                  										=> '',
											uc_s='FOREIGN PROFIT'                                    										=> '',
											uc_s='FOREIGN PROFIT CORPORATION'                      										  => '',
											uc_s='FOREIGN PROFIT COOPERATIVE ASSOCIATION WITHOUT SHARES'								=> '',
											uc_s='FOREIGN PROFIT EXEMPT'                             										=> '',
											uc_s='FOREIGN PROFIT PROFESSIONAL ASSOCIATION'															=> '',
											uc_s='FOREIGN PROFIT PROFESSIONAL CORPORATION'															=> '',
											uc_s='FOREIGN PROFIT TELEPHONE COOPERATIVE ASSOCIATION WITHOUT SHARES'			=> '',
											uc_s='FOREIGN RURAL ELECTRIC COOPERATIVE'																		=> '',
											uc_s='LIMITED PARTNERSHIP TO GENERAL LIABILITY COMPANY'  										=> '',
											uc_s='NO CORP TYPE FROM MNFRM'                           										=> '',
											uc_s='OTHER/DOMESTIC AGENCY CONNECTED'																			=> '',
											uc_s='OTHER/DOMESTIC COOPERATIVE EXEMPT'																		=> '',
											uc_s='OTHER/DOMESTIC COOPERATIVE REPORTER'																	=> '',
											uc_s='OTHER/DOMESTIC NONPROFIT EXEMPT'																			=> '',
											uc_s='OTHER/DOMESTIC PROFIT EXEMPT'																					=> '',
											uc_s='OTHER/FOREIGN COOPERATIVE EXEMPT'																			=> '',
											uc_s='OTHER/FOREIGN PROFIT EXEMPT'																					=> '',
											uc_s='OTHER/NO CORP TYPE FROM MNFRM'																				=> '',
											//Added 8/11/2016
											uc_s in ['DOMES']																														=> uc_s,
  				  					//Begins old 4 letter codes 7/18/2016
					            uc_s in ['DLLC','DPPA','DPRX','DRNP']                   										=> uc_s,
											uc_s in ['FLLC','FPPC','FRNP','FPXX']                    										=> uc_s,
											//Begins old codes 6/28/2016
					            uc_s in ['DCR','DCX','DFX','DLC','DNA','DNP','DNX','DPC','DPR','DPX','DRD'] => uc_s,
					            uc_s in ['FBT','FCR','FCX','FFX','FLC','FNP','FNX','FPC','FPR','FPX'] 			=> uc_s,
					            uc_s in ['LPC','PLC','ZZ'] 																									=> uc_s,
											'**|'+uc_s
										 );
		END;
		
		//********************************************************************
		//CorpOrigOrgStructureDesc: Returns "corp_orig_org_structure_desc".
		//********************************************************************	
		EXPORT CorpOrigOrgStructureDesc(STRING s) := FUNCTION
					 uc_s  := corp2.t2u(s);

					 RETURN map(uc_s='DOMES'																						 										=> 'DOMESTIC PROFIT PROFESSIONAL ASSOCIATION',
											uc_s='DOMESTIC AGENCY CONNECTED'                         										=> uc_s,
											uc_s='DOMESTIC COOPERATIVE EXEMPT'                     											=> uc_s,
											uc_s='DOMESTIC COOPERATIVE REPORTER'                       									=> uc_s,
											uc_s='DOMESTIC CREDIT UNION'														 										=> uc_s,
											uc_s='DOMESTIC FINANCIAL EXEMPT'                         										=> uc_s,
											uc_s='DOMESTIC INSURANCE COMPANY - MUTUAL'							 										=> uc_s,
											uc_s='DOMESTIC LIMITED LIABILITY COMPANY'                										=> uc_s,
											uc_s='DOMESTIC NONPROFIT'                                										=> uc_s,
											uc_s='DOMESTIC NONPROFIT CORPORATION'                    										=> uc_s,
											uc_s='DOMESTIC NONPROFIT EXEMPT'                         										=> uc_s,
											uc_s='DOMESTIC NONPROFIT MARKETING COOPERATIVE ASSOCIATION WITHOUT SHARES'	=> 'DOMESTIC NONPROFIT MARKETING COOPERATIVE ASSO WO SHARES',
											uc_s='DOMESTIC NONPROFIT WATER USERS ASSOCIATION WITHOUT SHARES'						=> uc_s,
											uc_s='DOMESTIC PARTNERSHIP TO GENERAL LIABILITY COMPANY' 										=> uc_s,
											uc_s='DOMESTIC PROFESSIONAL CORPORATION'                 										=> uc_s,
											uc_s='DOMESTIC PROFIT'                                  	 									=> uc_s,
											uc_s='DOMESTIC PROFIT COOPERATIVE ASSOCIATION WITH SHARES'									=> uc_s,
											uc_s='DOMESTIC PROFIT COOPERATIVE ASSOCIATION WITHOUT SHARES'								=> uc_s,
											uc_s='DOMESTIC PROFIT CORPORATION'                       										=> uc_s,
											uc_s='DOMESTIC PROFIT EXEMPT'                            										=> uc_s,
											uc_s='DOMESTIC PROFIT PROFESSIONAL ASSOCIATION' 				 										=> uc_s,
											uc_s='DOMESTIC PROFIT PROFESSIONAL CORPORATION'          										=> uc_s,
											uc_s='DOMESTIC REDOMESTICATED'                           										=> uc_s,
											uc_s='DOMESTIC RURAL ELECTRIC COOPERATIVE'																	=> uc_s,
											uc_s='DOMESTIC SANITARY PROJECT ASSOCIATIONS'																=> uc_s,
											uc_s='DOMESTIC SAVINGS AND LOAN'																						=> uc_s,
											uc_s='DOMESTIC STATE BANK'																									=> uc_s,
											uc_s='FOREIGN BUSINESS TRUST'                            										=> uc_s,
											uc_s='FOREIGN COOPERATIVE'																									=> uc_s,
											uc_s='FOREIGN COOPERATIVE EXEMPT'                        										=> uc_s,
											uc_s='FOREIGN COOPERATIVE REPORTER'                      										=> uc_s,
											uc_s='FOREIGN FEDERAL SAVINGS BANK'																					=> uc_s,
											uc_s='FOREIGN FINANCIAL EXEMPT'                         										=> uc_s,
											uc_s='FOREIGN LIMITED LIABILITY COMPANY'               										  => uc_s,
											uc_s='FOREIGN NONPROFIT'                                 										=> uc_s,
											uc_s='FOREIGN NONPROFIT CORPORATION'                    									  => uc_s,
											uc_s='FOREIGN NONPROFIT EXEMPT'                          										=> uc_s,
											uc_s='FOREIGN PROFESSIONAL CORPORATION'                  										=> uc_s,
											uc_s='FOREIGN PROFIT'                                    										=> uc_s,
											uc_s='FOREIGN PROFIT CORPORATION'                      										  => uc_s,
											uc_s='FOREIGN PROFIT COOPERATIVE ASSOCIATION WITHOUT SHARES'								=> uc_s,
											uc_s='FOREIGN PROFIT EXEMPT'                             										=> uc_s,
											uc_s='FOREIGN PROFIT PROFESSIONAL ASSOCIATION'															=> uc_s,
											uc_s='FOREIGN PROFIT PROFESSIONAL CORPORATION'															=> uc_s,
											uc_s='FOREIGN PROFIT TELEPHONE COOPERATIVE ASSOCIATION WITHOUT SHARES'			=> 'FOREIGN PROFIT TELEPHONE COOPERATIVE ASSO WO SHARES',
											uc_s='FOREIGN RURAL ELECTRIC COOPERATIVE'																		=> uc_s,
											uc_s='LIMITED PARTNERSHIP TO GENERAL LIABILITY COMPANY'  										=> uc_s,
											uc_s='NO CORP TYPE FROM MNFRM'                           										=> uc_s,
											uc_s='OTHER/DOMESTIC AGENCY CONNECTED'																			=> uc_s,
											uc_s='OTHER/DOMESTIC COOPERATIVE EXEMPT'																		=> uc_s,
											uc_s='OTHER/DOMESTIC COOPERATIVE REPORTER'																	=> uc_s,
											uc_s='OTHER/DOMESTIC NONPROFIT EXEMPT'																			=> uc_s,
											uc_s='OTHER/DOMESTIC PROFIT EXEMPT'																					=> uc_s,
											uc_s='OTHER/FOREIGN COOPERATIVE EXEMPT'																			=> uc_s,
											uc_s='OTHER/FOREIGN PROFIT EXEMPT'																					=> uc_s,
											uc_s='OTHER/NO CORP TYPE FROM MNFRM'																				=> uc_s,
  				  					//Begins old 4 letter codes 7/18/2016
					            uc_s='DLLC'                                              										=> 'DOMESTIC LIMITED LIABILITY COMPANY',
											uc_s='DPPA'                                             									 	=> 'DOMESTIC PROFIT PROFESSIONAL CORPORATION',
											uc_s='DPRX'                                              										=> 'DOMESTIC PROFIT CORPORATION',
											uc_s='DRNP'                                              										=> 'DOMESTIC NONPROFIT CORPORATION',
											uc_s='FLLC'                                              										=> 'FOREIGN LIMITED LIABILITY COMPANY',
											uc_s='FPPC'                                              										=> 'FOREIGN PROFIT PROFESSIONAL CORPORATION',
											uc_s='FRNP'                                              										=> 'FOREIGN NONPROFIT CORPORATION',
											uc_s='FPXX'                                              										=> 'FOREIGN PROFIT CORPORATION',
											//Begins old codes 6/28/2016
											uc_s='DCR' 	                                             										=> 'DOMESTIC COOPERATIVE REPORTER',
											uc_s='DCX'	                                             										=> 'DOMESTIC COOPERATIVE EXEMPT',
											uc_s='DFX'	                                             										=> 'DOMESTIC FINANCIAL EXEMPT',
											uc_s='DLC'	                                             										=> 'DOMESTIC LIMITED LIABILITY COMPANY',
											uc_s='DNA'	                                             										=> 'DOMESTIC AGENCY CONNECTED',
											uc_s='DNP'	                                             										=> 'DOMESTIC NONPROFIT',
											uc_s='DNX'	                                             										=> 'DOMESTIC NONPROFIT EXEMPT',
											uc_s='DPC'	                                             										=> 'DOMESTIC PROFESSIONAL CORPORATION',
											uc_s='DPR'	                                             										=> 'DOMESTIC PROFIT',
											uc_s='DPX'	                                             										=> 'DOMESTIC PROFIT EXEMPT',
											uc_s='DRD'	                                             										=> 'DOMESTIC REDOMESTICATED',
											uc_s='FBT'	                                             										=> 'FOREIGN BUSINESS TRUST',
											uc_s='FCR'	                                             										=> 'FOREIGN COOPERATIVE REPORTER',
											uc_s='FCX'	                                             										=> 'FOREIGN COOPERATIVE EXEMPT',
											uc_s='FFX'	                                             										=> 'FOREIGN FINANCIAL EXEMPT',
											uc_s='FLC'	                                            										=> 'FOREIGN LIMITED LIABILITY COMPANY',
											uc_s='FNP'	                                             										=> 'FOREIGN NONPROFIT',
											uc_s='FNX'	                                             										=> 'FOREIGN NONPROFIT EXEMPT',
											uc_s='FPC'	                                             										=> 'FOREIGN PROFESSIONAL CORPORATION',
											uc_s='FPR'	                                             										=> 'FOREIGN PROFIT',
											uc_s='FPX'	                                             										=> 'FOREIGN PROFIT EXEMPT',
											uc_s='LPC'	                                            										=> 'LIMITED PARTNERSHIP TO GENERAL LIABILITY COMPANY',
											uc_s='PLC'	                                             										=> 'DOMESTIC PARTNERSHIP TO GENERAL LIABILITY COMPANY',
											uc_s='ZZ' 	                                             										=> 'NO CORP TYPE FROM MNFRM',
											'**|'+uc_s
										 );
		END;
		
		//********************************************************************
		//CorpStatusCD: Returns "corp_status_cd".
		//********************************************************************	
		EXPORT CorpStatusCD(STRING s) := FUNCTION
					 uc_s  := corp2.t2u(s);
					 RETURN map(uc_s not in ['NM','USA'] => uc_s,
											''
											);
		END;
		
		//********************************************************************
		//CorpStatusDesc: Returns "corp_status_desc".
		//********************************************************************	
		EXPORT CorpStatusDesc(STRING s) := FUNCTION
					 uc_s  := corp2.t2u(s);
					 RETURN map(uc_s='AC'=>'ACTIVE',
											uc_s='AP'=>'PROCESS OF APPEAL',
											uc_s='BK'=>'BANKRUPTCY-RECEIVERSHIP',
											uc_s='BT'=>'BUSINESS TRANSACTED',
											uc_s='CA'=>'CANCELLATION',
											uc_s='CO'=>'CONSOLIDATED',
											uc_s='CR'=>'CANCELLATION OF REGISTRATION',
											uc_s='CV'=>'CONVERSION',
											uc_s='DH'=>'DISSOLUTION HEARING',
											uc_s='DS'=>'DISSOLVED',
											uc_s='DV'=>'VOLUNTARY DISSOLUTION',
											uc_s='EE'=>'EXISTENCE EXPIRED AUTOMATICALLY',
											uc_s='EX'=>'EXEMPT',
											uc_s='FE'=>'FUTURE EFFECTIVE',
											uc_s='FF'=>'FORFEITED',
											uc_s='FR'=>'FINAL REPORT',
											uc_s='IS'=>'INVOLUNTARILY STRICKEN',
											uc_s='LF'=>'LATE-FILER',
											uc_s='MG'=>'MERGED-OUT',
											uc_s='MO'=>'MERGED-OUT OF EXISTENCE',
											uc_s='NC'=>'NEW CORPORATION',
											uc_s='NF'=>'NON-FILER',
											uc_s='NG'=>'NOT IN GOOD STANDING',																								
											uc_s='RF'=>'REVOKED AND BEYOND APPEAL PERIOD',
											uc_s='RI'=>'RE-INSTATEMENT',
											uc_s='RR'=>'RETURNED REPORT',
											uc_s='RV'=>'REVOKED',
											uc_s='SD'=>'STATEMENT OF INTENT TO DISSOLVE',
											uc_s='SU'=>'SUSPENSION',
											uc_s='TC'=>'CORPORATION TAX CLEARANCE',
											uc_s='WD'=>'WITHDRAWN',
											uc_s='ZZ'=>'NOSTAT',
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