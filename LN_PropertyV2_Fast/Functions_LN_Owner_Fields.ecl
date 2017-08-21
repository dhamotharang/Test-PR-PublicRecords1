IMPORT lib_word, lib_StringLib, LN_PropertyV2, LN_PropertyV2_Fast;
EXPORT Functions_LN_Owner_Fields := MODULE

	EXPORT ExtractAssesOwnRghts (RecordOf(ln_propertyv2.File_Assessment) In_Rec) := FUNCTION
		code_comup := ' CP$|/CP$|\\(CP\\)'; 																																		// Community Property (CMP)
		code_corpn := '/CO$|\\(CO\\)|\\(A CORP\\)'; 																														// Corporation (COR)
		code_estat := '/ES$|\\(ES\\)|\\(EST\\)|\\(ESTATE\\)|ESTATE OF | EST OF'; 																// Estate (EST)
		code_exect := '/EX$|\\(EX\\)|EXECUTOR'; 																																// Executor (EXC)
		code_exmpt := ' XX$|/XX$|\\(XX\\)|EXEMPT FROMTAXATION|TAX EXEM|EXEMPT FROM TAX|\\(EXEMPT'; 							// Exempt (EXP)
		code_famtr := 'FAMILY TRUST| FTR$|/FTR$|\\(FTR\\)| FMTR$|/FMTR$|\\(FMTR\\)| FMT$|/FMT$|\\(FMT\\)'; 			// Family trust (FMT)
		code_guard := ' GD$|/GD$|\\(GD\\)|\\bAS GUARDIAN|GUARDIAN FOR|GUARDIAN OF|CUSTODIAN |\\(CO CUSTOD|'+
									'CONSERVATOR\\b|CONSERVATORSHIP'; 																												// Guardianship (GDS)
		code_heirs := '\\bHEIRS?\\b'; 																																					// Heirs (HRS)
		code_irvtr := ' IRT$|/IRT$|\\(IRT\\)| IT$|/IT$|\\(IT\\)|\\(IRREV TR|\\bIRREVOCABLE TR|'+
									'IRREVOCABLE LIVING TRUST'; 																															// Irrevocable trust (ITR)
		code_jntve := '/JV$|\\(JV\\)'; 																																					// Joint Venture (JVE)
		code_jtrsv := ' JS$|/JS$|\\(JS\\)|J/T/R/S|JTRS|JT/RS|AS JTRS|\\(JTWROS\\)|JTWROS|JLRS|JOINT SURV|JOINT TENANTS\\) RIGHT OF \\(SURV|'+
									'JOINT TENANTS\\) W/RIGHTS OF \\(SURV|JOINT TENANTS\\) W/R/O \\(SURV'; 										// Joint Tenants With Right of Survivorship (JTS)
		code_leasf := '/LF$|\\(LF\\)| LEASE$| LEASE FROM\\b'; 																									// Lease From (LEA)
		code_lifbe := '/LB$|\\(LB\\)|LIFETIME BENE'; 																														// Lifetime Benefit (LTB)
		code_lifst := '/LE$|\\(LE\\)|\\(L E\\)|LIFE EST|\\(L/E\\)|LF TENANT|LIFE TENANT'; 											// Life Estate (LFE)
		code_limpt := ' LP$|/LP$|\\(LP\\)|LIMITED PARTNERSHIP|LTD PARTNERSHIP|LTD PRTNRSHP'; 										// Limited Partnership (LPN)
		code_lvtrt := '/LT$|\\(LT\\)|LIVING TRUST| LIV TR| LV$|/LV$|\\(LV\\)|\\(LIV TR\\)|LIV/TR|TRUST BY WILL';// Living Trust (LVT)
		code_partn := ' PS$|/PS$|\\(PS\\)|PARTNERSHIP$|PRTNRSHP$|/PA$|\\(PA\\)'; 																// Partnership (PTS)
		code_perep := '/PR$|\\(PR\\)|REPRESENTATIVE OF|REPRESENTATIVE FOR|PERSONAL REPR|PERSONAL REP'; 					// Personal Representative (PRP)
		code_remai := ' RM$|/RM$|\\(RM\\)|REMAINDERMAN|RMDRMN'; 																								// Remainderman (RMD)
		code_revtr := ' RT$|/RT$|\\(RT\\)|\\bREV TR|\\bREVOCABLE TR'; 																					// Revocable trust (RTR)
		code_rosur := ' RS$|/RS$|\\(RS\\)|W/R SURV|W/RTS SURV|RIGHT OF SURV'; 																	// Right Of Survivorship (ROS)
		code_solep := '/SO$|\\(SO\\)|/SP$|\\(SP\\)|\\bSOLE OWN|\\bSOLE PROPR'; 																	// Sole Proprietorship (SOP)
		code_survi := '/SU$|\\(SU\\)|\\(SURV\\)|\\(SURVIVOR| OF SURV|SURVIVOR TR|, SURVIVOR$| SURVIVOR TITL'; 	// Survivor (SUV)
		code_tenat := ' JT$|/JT$|\\(JT\\)| J/T\\b|JNT TENAN|JNT TNT|JOINT TEN|JOINT OWN|AS JT\\b|JOINT TENANT'; // Joint Tenants (JTN)
		code_tenet := '/TY$|\\(TY\\)|\\(TBE\\)|\\bTBE\\b'; 																											// Tenants by Entirety (TBE)
		code_tenic := ' TC$|/TC$|\\(TC\\)|TENANTS IN COMMON|\\(TIC\\)|\\bTIC\\b'; 															// Tenants In Common (TIC)
		code_trodt := '/ ?TOD\\b|\\(TOD\\b|/TD\\b|\\(TD\\b|\\bTRANSFER ON DEATH\\b'; 														// Transfer on Death (TOD)
		code_trste := ' TE$|/TE$|\\(TE\\)|\\(TSTEE|\\(TRTEE|\\(CO TTEE|\\(CO-TTEE|\\(CO TR|\\(CO-TR|AS TRUSTE|'+
									'\\(TRUSTEE|TRUSTEE OF |TRUSTEES OF| TS$|/TS$|\\(TS\\) |BY TRUSTE|TRSTE'; 								// Trustee (TRE)
		code_trust := ' TR$|/TR$|\\(TR\\)|\\bTRUST\\b'; 																												// Trust (TRT)
		code_undin := ' UI$|/UI$|\\(UI\\)|UNDIVIDED INTEREST'; 																									// Undivided Interest (UDI)

		STRING3 OutOwnRghts :=
					// Irrevocable trust (ITR)
			MAP(regexfind(code_irvtr,trim(in_rec.assessee_name))				or  regexfind(code_irvtr,trim(in_rec.second_assessee_name)) or 
					regexfind(code_irvtr,trim(in_rec.contract_owner))				or  regexfind(code_irvtr,trim(in_rec.document_type))
					=> 'ITR',
					// Revocable trust (RTR)
				 (regexfind(code_revtr,trim(in_rec.assessee_name))				and regexfind('IRREVOC',in_rec.assessee_name,0)='')         or 
				 (regexfind(code_revtr,trim(in_rec.second_assessee_name))	and regexfind('IRREVOC',in_rec.second_assessee_name,0)='')  or 
				 (regexfind(code_revtr,trim(in_rec.contract_owner))				and regexfind('IRREVOC',in_rec.contract_owner,0)='')        or 
				 (regexfind(code_revtr,trim(in_rec.document_type))				and regexfind('IRREVOC',in_rec.document_type,0)='')
					=> 'RTR',
					// Family trust (FMT)
					regexfind(code_famtr,trim(in_rec.assessee_name))				or  regexfind(code_famtr,trim(in_rec.second_assessee_name)) or 
					regexfind(code_famtr,trim(in_rec.contract_owner))				or  regexfind(code_famtr,trim(in_rec.document_type))
					=> 'FMT',
					// Living Trust (LVT)
					regexfind(code_lvtrt,trim(in_rec.assessee_name))				or  regexfind(code_lvtrt,trim(in_rec.second_assessee_name)) or 
					regexfind(code_lvtrt,trim(in_rec.contract_owner))				or  regexfind(code_lvtrt,trim(in_rec.document_type))
					=> 'LVT',
					// Trust (TRT)
				 (regexfind(code_trust,trim(in_rec.assessee_name))				and 
				 regexfind('FAMILY TRUST|TRUST FUND| IN TRUST\\b|TRUST COMPANY',in_rec.assessee_name,0)='')        									  or 
				 (regexfind(code_trust,trim(in_rec.second_assessee_name))	and 
				 regexfind('FAMILY TRUST|TRUST FUND| IN TRUST\\b|TRUST COMPANY',in_rec.second_assessee_name,0)='') 									  or 
				 (regexfind(code_trust,trim(in_rec.contract_owner))				and 
				 regexfind('FAMILY TRUST|TRUST FUND| IN TRUST\\b|TRUST COMPANY',in_rec.contract_owner,0)='')       									  or 
				 (regexfind(code_trust,trim(in_rec.document_type))				and 
				 regexfind('FAMILY TRUST|TRUST FUND| IN TRUST\\b|TRUST COMPANY',in_rec.document_type,0)='')
				  => 'TRT',
					// Trustee (TRE)
				 (regexfind(code_trste,trim(in_rec.assessee_name))				and 
				 regexfind('BOARD OF TRUSTEE',in_rec.assessee_name,0)='')                																						  or 
				 (regexfind(code_trste,trim(in_rec.second_assessee_name))	and 
				 regexfind('BOARD OF TRUSTEE',in_rec.second_assessee_name,0)='')        																						  or 
				 (regexfind(code_trste,trim(in_rec.contract_owner))				and 
				 regexfind('BOARD OF TRUSTEE',in_rec.contract_owner,0)='')																													  or 
				 (regexfind(code_trste,trim(in_rec.document_type))				and 
				 regexfind('BOARD OF TRUSTEE',in_rec.document_type,0)='')
				  => 'TRE',
					// Community Property (CMP)
					regexfind(code_comup,trim(in_rec.assessee_name))				or  regexfind(code_comup,trim(in_rec.second_assessee_name)) or 
					regexfind(code_comup,trim(in_rec.contract_owner))				or  regexfind(code_comup,trim(in_rec.document_type))
					=> 'CMP',
					// Corporation (COR)
					regexfind(code_corpn,trim(in_rec.assessee_name))				or  regexfind(code_corpn,trim(in_rec.second_assessee_name)) or 
					regexfind(code_corpn,trim(in_rec.contract_owner))				or  regexfind(code_corpn,trim(in_rec.document_type))
					=> 'COR',
					// Estate (EST)
					regexfind(code_estat,trim(in_rec.assessee_name))				or  regexfind(code_estat,trim(in_rec.second_assessee_name)) or 
					regexfind(code_estat,trim(in_rec.contract_owner))				or  regexfind(code_estat,trim(in_rec.document_type))
					=> 'EST',
					// Executor (EXC)
					regexfind(code_exect,trim(in_rec.assessee_name))				or  regexfind(code_exect,trim(in_rec.second_assessee_name)) or 
					regexfind(code_exect,trim(in_rec.contract_owner))				or  regexfind(code_exect,trim(in_rec.document_type))
					=> 'EXC',
					// Exempt (EXP)
					regexfind(code_exmpt,trim(in_rec.assessee_name))				or  regexfind(code_exmpt,trim(in_rec.second_assessee_name)) or 
					regexfind(code_exmpt,trim(in_rec.contract_owner))				or  regexfind(code_exmpt,trim(in_rec.document_type))
					=> 'EXP',
					// Joint Tenants With Right of Survivorship (JTS)
					regexfind(code_jtrsv,trim(in_rec.assessee_name))				or  regexfind(code_jtrsv,trim(in_rec.second_assessee_name)) or 
					regexfind(code_jtrsv,trim(in_rec.contract_owner))				or  regexfind(code_jtrsv,trim(in_rec.document_type))
					=> 'JTS',
					// Joint Tenants (JTN)
					regexfind(code_tenat,trim(in_rec.assessee_name))				or  regexfind(code_tenat,trim(in_rec.second_assessee_name)) or 
					regexfind(code_tenat,trim(in_rec.contract_owner))				or  regexfind(code_tenat,trim(in_rec.document_type))
					=> 'JTN',
					// Right Of Survivorship (ROS)
					regexfind(code_rosur,trim(in_rec.assessee_name))				or  regexfind(code_rosur,trim(in_rec.second_assessee_name)) or 
					regexfind(code_rosur,trim(in_rec.contract_owner))				or  regexfind(code_rosur,trim(in_rec.document_type))
					=> 'ROS',
					// Joint Venture (JVE)
					regexfind(code_jntve,trim(in_rec.assessee_name))				or  regexfind(code_jntve,trim(in_rec.second_assessee_name)) or 
					regexfind(code_jntve,trim(in_rec.contract_owner))				or  regexfind(code_jntve,trim(in_rec.document_type))
					=> 'JVE',
					// Lease From (LEA)
					regexfind(code_leasf,trim(in_rec.assessee_name))				or  regexfind(code_leasf,trim(in_rec.second_assessee_name)) or 
					regexfind(code_leasf,trim(in_rec.contract_owner))				or  regexfind(code_leasf,trim(in_rec.document_type))
					=> 'LEA',
					// Life Estate (LFE)
					regexfind(code_lifst,trim(in_rec.assessee_name))				or  regexfind(code_lifst,trim(in_rec.second_assessee_name)) or 
					regexfind(code_lifst,trim(in_rec.contract_owner))				or  regexfind(code_lifst,trim(in_rec.document_type))
					=> 'LFE', 
					// Lifetime Benefit (LTB)
					regexfind(code_lifbe,trim(in_rec.assessee_name))				or  regexfind(code_lifbe,trim(in_rec.second_assessee_name)) or 
					regexfind(code_lifbe,trim(in_rec.contract_owner))				or  regexfind(code_lifbe,trim(in_rec.document_type))
					=> 'LTB',
					// Limited Partnership (LPN)
					regexfind(code_limpt,trim(in_rec.assessee_name))				or  regexfind(code_limpt,trim(in_rec.second_assessee_name)) or 
					regexfind(code_limpt,trim(in_rec.contract_owner))				or  regexfind(code_limpt,trim(in_rec.document_type))
					=> 'LPN',
					// Partnership (PTS)
					regexfind(code_partn,trim(in_rec.assessee_name))				or  regexfind(code_partn,trim(in_rec.second_assessee_name)) or 
					regexfind(code_partn,trim(in_rec.contract_owner))				or  regexfind(code_partn,trim(in_rec.document_type))
					=> 'PTS',
					// Personal Representative (PRP)
					regexfind(code_perep,trim(in_rec.assessee_name))				or  regexfind(code_perep,trim(in_rec.second_assessee_name)) or 
					regexfind(code_perep,trim(in_rec.contract_owner))				or  regexfind(code_perep,trim(in_rec.document_type))
					=> 'PRP',
					// Remainderman (RMD)
					regexfind(code_remai,trim(in_rec.assessee_name))				or  regexfind(code_remai,trim(in_rec.second_assessee_name)) or 
					regexfind(code_remai,trim(in_rec.contract_owner))				or  regexfind(code_remai,trim(in_rec.document_type))
					=> 'RMD',
					// Survivor (SUV)
					regexfind(code_survi,trim(in_rec.assessee_name))				or  regexfind(code_survi,trim(in_rec.second_assessee_name)) or 
					regexfind(code_survi,trim(in_rec.contract_owner))				or  regexfind(code_survi,trim(in_rec.document_type))
					=> 'SUV',
					// Sole Proprietorship (SOP)
					regexfind(code_solep,trim(in_rec.assessee_name))				or  regexfind(code_solep,trim(in_rec.second_assessee_name)) or 
					regexfind(code_solep,trim(in_rec.contract_owner))				or  regexfind(code_solep,trim(in_rec.document_type))
					=> 'SOP',
					// Tenants by Entirety (TBE)
					regexfind(code_tenet,trim(in_rec.assessee_name))				or  regexfind(code_tenet,trim(in_rec.second_assessee_name)) or 
					regexfind(code_tenet,trim(in_rec.contract_owner))				or  regexfind(code_tenet,trim(in_rec.document_type))
					=> 'TBE',
					// Tenants In Common (TIC)
					regexfind(code_tenic,trim(in_rec.assessee_name))				or  regexfind(code_tenic,trim(in_rec.second_assessee_name)) or 
					regexfind(code_tenic,trim(in_rec.contract_owner))				or  regexfind(code_tenic,trim(in_rec.document_type))
					=> 'TIC',
					// Undivided Interest (UDI)
					regexfind(code_undin,trim(in_rec.assessee_name))				or  regexfind(code_undin,trim(in_rec.second_assessee_name)) or 
					regexfind(code_undin,trim(in_rec.contract_owner))				or  regexfind(code_undin,trim(in_rec.document_type))
					=> 'UDI',
					// Transfer on Death (TOD)
					regexfind(code_trodt,trim(in_rec.assessee_name))				or  regexfind(code_trodt,trim(in_rec.second_assessee_name)) or 
					regexfind(code_trodt,trim(in_rec.contract_owner))				or  regexfind(code_trodt,trim(in_rec.document_type))
					=> 'TOD',
					// Heirs (HRS)
					regexfind(code_heirs,trim(in_rec.assessee_name))				or  regexfind(code_heirs,trim(in_rec.second_assessee_name)) or 
					regexfind(code_heirs,trim(in_rec.contract_owner))				or  regexfind(code_heirs,trim(in_rec.document_type))
					=> 'HRS',
					// Guardianship (GDS)
					regexfind(code_guard,trim(in_rec.assessee_name))				or  regexfind(code_guard,trim(in_rec.second_assessee_name)) or 
					regexfind(code_guard,trim(in_rec.contract_owner))				or  regexfind(code_guard,trim(in_rec.document_type))
					=> 'GDS',' ');
		RETURN OutOwnRghts;
	END;

	EXPORT ExtractDeedOwnRghts (RecordOf(ln_propertyv2.File_Deed) In_Rec) := FUNCTION
		// There are small differences between assessor codes and deed codes, they should not be merged.
		code_comup := ' CP$|/CP$|\\(CP\\)'; 																																		// Community Property (CMP)
		code_corpn := '/CO$|\\(CO\\)|\\(A CORP\\)'; 																														// Corporation (COR)
		code_estat := '/ES$|\\(ES\\)|\\(EST\\)|\\(ESTATE\\)|ESTATE OF | EST OF'; 																// Estate (EST)
		code_exect := '/EX$|\\(EX\\)|EXECUTOR'; 																																// Executor (EXC)
		code_famtr := 'FAMILY TRUST| FTR$|/FTR$|\\(FTR\\)| FMTR$|/FMTR$|\\(FMTR\\)| FMT$|/FMT$|\\(FMT\\)';			// Family trust (FMT)
		code_guard := ' GD$|/GD$|\\(GD\\)|\\bAS GUARDIAN|GUARDIAN FOR|GUARDIAN OF|CUSTODIAN |\\(CO CUSTOD|'+
									'CONSERVATOR\\b|CONSERVATORSHIP'; 																												// Guardianship (GDS)
		code_heirs := '\\bHEIRS?\\b'; 																																					// - Heirs (HRS)
		code_irvtr := ' IRT$|/IRT$|\\(IRT\\)| IT$|/IT$|\\(IT\\)|\\(IRREV TR|\\bIRREVOCABLE TR|'+
									'IRREVOCABLE LIVING TRUST'; 																															// Irrevocable trust (ITR)
		code_jtrsv := ' JS$|/JS$|\\(JS\\)|J/T/R/S|JTRS|JT/RS|AS JTRS|\\(JTWROS\\)|JTWROS|JLRS|JOINT SURV|JOINT TENANTS\\) RIGHT OF \\(SURV|'+
								'JOINT TENANTS\\) W/RIGHTS OF \\(SURV|JOINT TENANTS\\) W/R/O \\(SURV'; 											// Joint Tenants With Right of Survivorship (JTS)
		code_leasf := '/LF$|\\(LF\\)| LEASE$| LEASE FROM\\b'; 																									// Lease From (LEF)
		code_lifst := '/LE$|\\(LE\\)|\\(L E\\)|LIFE EST|\\(L/E\\)|LF TENANT|LIFE TENANT'; 											// Life Estate (LFE)
		code_limpt := ' LP$|/LP$|\\(LP\\)|LIMITED PARTNERSHIP|LTD PARTNERSHIP|LTD PRTNRSHP'; 										// Limited Partnership (LPN)
		code_lvtrt := '/LT$|\\(LT\\)|LIVING TRUST| LIV TR| LV$|/LV$|\\(LV\\)|\\(LIV TR\\)|LIV/TR|TRUST BY WILL';// Living Trust (LVT)
		code_partn := ' PS$|/PS$|\\(PS\\)|PARTNERSHIP$|PRTNRSHP$|/PA$|\\(PA\\)'; 																// Partnership (PTS)
		code_remai := ' RM$|/RM$|\\(RM\\)|REMAINDERMAN|RMDRMN'; 																								// Remainderman (RMD)
		code_revtr := '/RT$|\\(RT\\)|\\bREV TR|\\bREVOCABLE TR'; 																								// Revocable trust (RTR)
		code_rosur := '/RS$|\\(RS\\)|W/R SURV|W/RTS SURV|RIGHT OF SURV'; 																				// Right Of Survivorship (ROS)
		code_survi := '/SU$|\\(SU\\)|\\(SURV\\)|\\(SURVIVOR| OF SURV|SURVIVOR TR|, SURVIVOR$| SURVIVOR TITL'; 	// Survivor (SUV)
		code_tenat := ' JT$|/JT$|\\(JT\\)| J/T\\b|JNT TENAN|JNT TNT|JOINT TEN|JOINT OWN|AS JT\\b|JOINT TENANT'; // Joint Tenants (JTN)
		code_tenic := ' TC$|/TC$|\\(TC\\)|TENANTS IN COMMON|\\(TIC\\)';	 																				// Tenants In Common (TIC)
		code_trodt := '/ ?TOD\\b|\\(TOD\\b|\\(TD\\b|\\bTRANSFER ON DEATH\\b'; 																	// Transfer on Death (TOD)
		code_trste := ' TE$|/TE$|\\(TE\\)|\\(TSTEE|\\(TRTEE|\\(CO TTEE|\\(CO-TTEE|\\(CO TR|\\(CO-TR|AS TRUSTE|'+
									'\\(TRUSTEE|TRUSTEE OF |TRUSTEES OF| TS$|/TS$|\\(TS\\) |BY TRUSTE|TRSTE'; 								// Trustee (TRE)
		code_trust := ' TR$|/TR$|\\(TR\\)|\\bTRUST\\b'; 																												// Trust (TRT)
		code_undin := '/UI$|\\(UI\\)|UNDIVIDED INTEREST'; 																											// Undivided Interest (UDI)

		STRING3 OutOwnRghts := 
			MAP(regexfind(code_irvtr,trim(in_rec.name1))   or regexfind(code_irvtr,trim(in_rec.name2)) 					=> 'ITR',
				 (regexfind(code_revtr,trim(in_rec.name1))  and regexfind('IRREVOC',in_rec.name1,0)='') 					or 
				 (regexfind(code_revtr,trim(in_rec.name2))  and regexfind('IRREVOC',in_rec.name2,0)='') 					=> 'RTR',
					regexfind(code_famtr,trim(in_rec.name1))   or regexfind(code_famtr,trim(in_rec.name2)) 					=> 'FMT',
					regexfind(code_lvtrt,trim(in_rec.name1))   or regexfind(code_lvtrt,trim(in_rec.name2)) 					=> 'LVT',
				 (regexfind(code_trust,trim(in_rec.name1))  and 
				  regexfind('FAMILY TRUST|TRUST FUND| IN TRUST\\b|TRUST COMPANY',in_rec.name1,0)='')							or 
				 (regexfind(code_trust,trim(in_rec.name2))  and 
				  regexfind('FAMILY TRUST|TRUST FUND| IN TRUST\\b|TRUST COMPANY',in_rec.name2,0)='')							=> 'TRT',
				 (regexfind(code_trste,trim(in_rec.name1))  and regexfind('BOARD OF TRUSTEE',in_rec.name1,0)='') 	or 
				 (regexfind(code_trste,trim(in_rec.name2))  and regexfind('BOARD OF TRUSTEE',in_rec.name2,0)='') 	=> 'TRE',
					regexfind(code_comup,trim(in_rec.name1))   or regexfind(code_comup,trim(in_rec.name2)) 					=> 'CMP',
					regexfind(code_corpn,trim(in_rec.name1))   or regexfind(code_corpn,trim(in_rec.name2)) 					=> 'COR',
					regexfind(code_estat,trim(in_rec.name1))   or regexfind(code_estat,trim(in_rec.name2)) 					=> 'EST',
					regexfind(code_exect,trim(in_rec.name1))   or regexfind(code_exect,trim(in_rec.name2)) 					=> 'EXC',
					regexfind(code_jtrsv,trim(in_rec.name1))   or regexfind(code_jtrsv,trim(in_rec.name2)) 					=> 'JTS',
					regexfind(code_tenat,trim(in_rec.name1))   or regexfind(code_tenat,trim(in_rec.name2)) 					=> 'JTN',
					regexfind(code_rosur,trim(in_rec.name1))   or regexfind(code_rosur,trim(in_rec.name2)) 					=> 'ROS',
					regexfind(code_leasf,trim(in_rec.name1))   or regexfind(code_leasf,trim(in_rec.name2)) 					=> 'LEA',
					regexfind(code_lifst,trim(in_rec.name1))   or regexfind(code_lifst,trim(in_rec.name2)) 					=> 'LFE',
					regexfind(code_limpt,trim(in_rec.name1))   or regexfind(code_limpt,trim(in_rec.name2)) 					=> 'LPN',
					regexfind(code_partn,trim(in_rec.name1))   or regexfind(code_partn,trim(in_rec.name2)) 					=> 'PTS',
					regexfind(code_remai,trim(in_rec.name1))   or regexfind(code_remai,trim(in_rec.name2)) 					=> 'RMD',
					regexfind(code_survi,trim(in_rec.name1))   or regexfind(code_survi,trim(in_rec.name2)) 					=> 'SUV',
					regexfind(code_tenic,trim(in_rec.name1))   or regexfind(code_tenic,trim(in_rec.name2)) 					=> 'TIC',
					regexfind(code_undin,trim(in_rec.name1))   or regexfind(code_undin,trim(in_rec.name2)) 					=> 'UDI',
					regexfind(code_trodt,trim(in_rec.name1))   or regexfind(code_trodt,trim(in_rec.name2)) 					=> 'TOD',
					regexfind(code_heirs,trim(in_rec.name1))   or regexfind(code_heirs,trim(in_rec.name2)) 					=> 'HRS',
					regexfind(code_guard,trim(in_rec.name1))   or regexfind(code_guard,trim(in_rec.name2)) 					=> 'GDS',' ');
		RETURN OutOwnRghts;
	END;

	EXPORT ExtractAssesRelatType (RecordOf(ln_propertyv2.File_Assessment) In_Rec) := FUNCTION
		code_brsis := ', BS$|/BS$|\\(BS\\)|BROTHER AND SISTER|BROTHER/SISTER|BROTHER & SISTER';
		code_notbs := '[2-6] BS|CENTER|CHU?RCH|CLEANING|CNCL|COMPASS BS|COUNCIL|\\bDBA |DE BS|DODGE|ENTERPRISE|FAMILY|FIVE BS|FOUNDATION|'+
									'FOURS? BS|M D M B|MISS BS|MISTER BS|MR BS|PHD PA|SIX BS|SOCIETY|THREE BS|TRES BS|[1-9]+|\\bAUNT BS\\b|BANK,?\\b|'+
									'\\bBIG\\b|\\bEAST BS\\b|\\bINC\\b|\\bLLC\\b|\\bLTD\\b|\\bOF BS\\b|\\bTRUST\\b|\\b[A-Z][A-Z], BS\\b|^BS$';
		code_hubwf := ' HW$|/HW$| H&W |H/W|\\(HW\\)|\\(H & W\\)|&W\\)|& .*\\bWF\\b|& .*\\bWIFE\\b|& HUSB|, HUSB$|\\bHUSBAND$|HUSBAND & WI?FE|'+
									'HUSBAND AND WI?FE|HUS?BAND WIFE|HUSBAND/WIFE|WFE & HUSB|\\bAND .*\\bWI?FE?\\b|\\bCOUPLE\\b|\\bHIS WIFE\\b|'+
									'\\bETCON\\b|\\bETUX\\b|\\bETVIR\\b|\\bET CON\\b|\\bET UX\\b|\\bET VIR\\b';
		code_wife  := ' WF$|/WF$|\\(WF\\)|\\bWIFE\\b';
		code_dvrcd := '\\(DV\\)| \\(DIVORCED\\)|\\bDIVORCED\\b';
		code_marrd := '\\(MA\\)|\\bMARRIED\\b';
		code_unmrd := '\\bUNMARRIED\\b';
		code_decsd := '\\(DC\\)|\\bDECD\\b|\\bDECEASED\\b';
		code_singl := '\\bSINGLE,?\\b';
		code_ntsng := 'BEHALF OF SINGLE|CHURCH|CLUB|CONSTRUCTION|CORP|SINGLE & MULTI|SINGLE APART|SINGLE ASSET|SINGLE DAY|SINGLE LIVING|SINGLE LOT|'+
									'SINGLE MEM|SINGLE POINT|SINGLE PROPERTY|SINGLE ROOM|SINGLE SEARCH|SINGLE SOURCE|SINGLE STOP|SINGLE TENANT|SINGLE TREE|'+
									'SINGLE UNIT|SINGLE[ -]FA?M?|SINGLE[ -]HO|UNITED SINGL|VERITAS SINGLE|[1-9]+|\\bDBA\\b|\\bFUND|\\bINC\\b|\\bLLC\\b|'+
									'\\bLTD\\b|\\bTRUST\\b|^SINGLE,?\\b';
		code_widow := '\\bWIDOWE?R?$|\\(WIDOW\\)|/WIDOW,?\\b|\\bWIDOW OF\\b';

		STRING2 Outrelatyp := 
			MAP((regexfind('PERSONAL PROPERTY',in_rec.legal_brief_description,0)='' 	and	in_rec.record_type_code<>'PP') and
					(regexfind(code_brsis,trim(in_rec.assessee_name)) 										and 
					 regexfind('^\\w+,? BS$',trim(in_rec.assessee_name),0)='' 						and 
					 regexfind(code_notbs,trim(in_rec.assessee_name),0)='' 								and 
					 regexfind(code_notbs,trim(in_rec.second_assessee_name), 0)='') 			or
					(regexfind(code_brsis,trim(in_rec.second_assessee_name)) 							and 
					 regexfind(code_notbs,trim(in_rec.second_assessee_name),0)='' 				and
					 regexfind(code_notbs,trim(in_rec.assessee_name),0)='') 										=> 'BS',
					 regexfind(code_decsd,trim(in_rec.assessee_name)) 										or 
					 regexfind(code_decsd,trim(in_rec.second_assessee_name))										=> 'DC',
					(regexfind(code_dvrcd,trim(in_rec.assessee_name)) 										and
					 regexfind('FOR DIVORCED',in_rec.assessee_name,0)='')									or 
					(regexfind(code_dvrcd,trim(in_rec.second_assessee_name))							and
					 regexfind('FOR DIVORCED',in_rec.second_assessee_name,0)='')								=> 'DV',
					(regexfind(code_hubwf,trim(in_rec.assessee_name)) 										and 
					 regexfind('STATE H/W|H/W DEPT|H/W COMM',in_rec.assessee_name,0)='') 	or 
					(regexfind(code_hubwf,trim(in_rec.second_assessee_name)) 							and 
				   regexfind('STATE H/W|H/W DEPT|H/W COMM',in_rec.second_assessee_name,0)='') => 'HW',
				  (regexfind(code_wife, trim(in_rec.assessee_name)) 										and 
				 	 regexfind(code_hubwf,trim(in_rec.assessee_name),0)='')								or 
				  (regexfind(code_wife, trim(in_rec.second_assessee_name)) 							and 
				 	 regexfind(code_hubwf,trim(in_rec.second_assessee_name),0)='')							=> 'WF',
					(regexfind(code_marrd,trim(in_rec.assessee_name))											and
					 regexfind(code_unmrd,trim(in_rec.second_assessee_name),0)=''  				and 
					 regexfind(code_singl,trim(in_rec.second_assessee_name),0)='') 				or 
					(regexfind(code_marrd,trim(in_rec.second_assessee_name))							and 
					 regexfind(code_unmrd,trim(in_rec.assessee_name),0)=''  							and 
					 regexfind(code_singl,trim(in_rec.assessee_name),0)='')											=> 'MA',
				  (regexfind(code_singl,trim(in_rec.assessee_name)) 										and 
					 regexfind('^\\w+,? SINGLE$',trim(in_rec.assessee_name),0)='' 				and 
					 regexfind(code_ntsng,in_rec.assessee_name,0)=''											and
					 regexfind(code_marrd,trim(in_rec.second_assessee_name),0)='') 				or 
				  (regexfind(code_singl,trim(in_rec.second_assessee_name)) 							and 
					 regexfind(code_ntsng,in_rec.second_assessee_name,0)='' 							and
					 regexfind(code_marrd,trim(in_rec.assessee_name),0)='')											=> 'SI',
					(regexfind(code_unmrd,trim(in_rec.assessee_name)) 										and 
					 regexfind('FEDERAL|LLC|INC',in_rec.assessee_name,0)='' 							and 
					 regexfind(code_marrd,trim(in_rec.second_assessee_name),0)='') 				or 
					(regexfind(code_unmrd,trim(in_rec.second_assessee_name)) 							and 
					 regexfind('FEDERAL|LLC|INC',in_rec.second_assessee_name,0)='' 				and 
					 regexfind(code_marrd,trim(in_rec.assessee_name),0)='')											=> 'UN',
					 regexfind(code_widow,trim(in_rec.assessee_name)) 										or 
					 regexfind(code_widow,trim(in_rec.second_assessee_name))										=> 'WD',' ');
		RETURN Outrelatyp;
	END;

	EXPORT ExtractDeedRelatType (RecordOf(ln_propertyv2.File_Deed) In_Rec) := FUNCTION
		code_brsis := '/BS$|\\(BS\\)|BROTHER AND SISTER|BROTHER/SISTER';
		code_notbs := '[2-6] BS|CENTER|CHU?RCH|CLEANING|CNCL|COMPASS BS|COUNCIL|\\bDBA |DE BS|DODGE|ENTERPRISE|FAMILY|FIVE BS|FOUNDATION|'+
									'FOURS? BS|M D M B|MISS BS|MISTER BS|MR BS|PHD PA|SIX BS|SOCIETY|THREE BS|TRES BS|[1-9]+|\\bAUNT BS\\b|BANK,?\\b|'+
									'\\bBIG\\b|\\bEAST BS\\b|\\bINC\\b|\\bLLC\\b|\\bLTD\\b|\\bOF BS\\b|\\bTRUST\\b|\\b[A-Z][A-Z], BS\\b|^BS$';
		code_hubwf := ' HW$|/HW$| H&W |H/W|\\(HW\\)|\\(H & W\\)|&W\\)|& .*\\bWF\\b|& .*\\bWIFE\\b|& HUSB|, HUSB$|\\bHUSBAND$|HUSBAND & WI?FE|'+
									'HUSBAND AND WI?FE|HUS?BAND WIFE|HUSBAND/WIFE|WFE & HUSB|\\bAND .*\\bWI?FE?\\b|\\bCOUPLE\\b|\\bHIS WIFE\\b|'+
									'\\bETCON\\b|\\bETUX\\b|\\bETVIR\\b|\\bET CON\\b|\\bET UX\\b|\\bET VIR\\b';
		code_wife  := ' WF$|/WF$|\\(WF\\)|\\bWIFE\\b';
		code_dvrcd := '\\(DV\\)| \\(DIVORCED\\)|\\bDIVORCED\\b';
		code_marrd := '\\(MA\\)|\\bMARRIED\\b';
		code_unmrd := '\\bUNMARRIED\\b';
		code_decsd := '\\(DC\\)|\\bDECD\\b|\\bDECEASED\\b';
		code_singl := '\\bSINGLE,?\\b';
		code_ntsng := 'BEHALF OF SINGLE|CHURCH|CLUB|CONSTRUCTION|CORP|SINGLE & MULTI|SINGLE APART|SINGLE ASSET|SINGLE DAY|SINGLE LIVING|SINGLE LOT|'+
									'SINGLE MEM|SINGLE POINT|SINGLE PROPERTY|SINGLE ROOM|SINGLE SEARCH|SINGLE SOURCE|SINGLE STOP|SINGLE TENANT|SINGLE TREE|'+
									'SINGLE UNIT|SINGLE[ -]FA?M?|SINGLE[ -]HO|UNITED SINGL|VERITAS SINGLE|[1-9]+|\\bDBA\\b|\\bFUND|\\bINC\\b|\\bLLC\\b|'+
									'\\bLTD\\b|\\bTRUST\\b|^SINGLE,?\\b';
		code_widow := '\\bWIDOWE?R?$|\\(WIDOW\\)|/WIDOW,?\\b|\\bWIDOW OF\\b';

		STRING2 Outrelatyp := 
			MAP((regexfind(code_hubwf,trim(in_rec.name1)) 										and 
					 regexfind('STATE H/W|H/W DEPT|H/W COMM',in_rec.name1,0)='') 	or 
					(regexfind(code_hubwf,trim(in_rec.name2)) 										and 
				   regexfind('STATE H/W|H/W DEPT|H/W COMM',in_rec.name2,0)='') 	=> 'HW',
					(regexfind(code_wife, trim(in_rec.name1)) 										and 
				 	 regexfind(code_hubwf,trim(in_rec.name1),0)='')								or 
				  (regexfind(code_wife, trim(in_rec.name2)) 										and 
				 	 regexfind(code_hubwf,trim(in_rec.name2),0)='')								=> 'WF',
					(regexfind(code_singl,trim(in_rec.name1)) 										and 
					 regexfind('^\\w+,? SINGLE$',trim(in_rec.name1),0)='' 				and 
					 regexfind(code_ntsng,in_rec.name1,0)=''											and
					 regexfind(code_marrd,trim(in_rec.name2),0)='') 							or 
				  (regexfind(code_singl,trim(in_rec.name2)) 										and 
					 regexfind(code_ntsng,in_rec.name2,0)='' 											and
					 regexfind(code_marrd,trim(in_rec.name1),0)='')								=> 'SI',
					 regexfind(code_decsd,trim(in_rec.name1)) 										or 
					 regexfind(code_decsd,trim(in_rec.name2))											=> 'DC',
					(regexfind(code_marrd,trim(in_rec.name1))											and
					 regexfind(code_unmrd,trim(in_rec.name2),0)=''  							and 
					 regexfind(code_singl,trim(in_rec.name2),0)='') 							or 
					(regexfind(code_marrd,trim(in_rec.name2))											and 
					 regexfind(code_unmrd,trim(in_rec.name1),0)=''  							and 
					 regexfind(code_singl,trim(in_rec.name1),0)='')								=> 'MA',
					(regexfind(code_unmrd,trim(in_rec.name1)) 										and 
					 regexfind('FEDERAL|LLC|INC',in_rec.name1,0)='' 							and 
					 regexfind(code_marrd,trim(in_rec.name2),0)='') 							or 
					(regexfind(code_unmrd,trim(in_rec.name2)) 										and 
					 regexfind('FEDERAL|LLC|INC',in_rec.name2,0)='' 							and 
					 regexfind(code_marrd,trim(in_rec.name1),0)='')								=> 'UN',
				   regexfind(code_widow,trim(in_rec.name1)) 										or 
					 regexfind(code_widow,trim(in_rec.name2))											=> 'WD',
				  (regexfind(code_brsis,trim(in_rec.name1)) 										and 
					 regexfind('^\\w+,? BS$',trim(in_rec.name1),0)='' 						and 
					 regexfind(code_notbs,trim(in_rec.name1),0)='' 								and 
					 regexfind(code_notbs,trim(in_rec.name2), 0)='') 							or
					(regexfind(code_brsis,trim(in_rec.name2)) 										and 
					 regexfind(code_notbs,trim(in_rec.name2),0)='' 								and
					 regexfind(code_notbs,trim(in_rec.name1),0)='') 							=> 'BS',
					(regexfind(code_dvrcd,trim(in_rec.name1)) 										and
					 regexfind('FOR DIVORCED',in_rec.name1,0)='')									or 
					(regexfind(code_dvrcd,trim(in_rec.name2))											and
					 regexfind('FOR DIVORCED',in_rec.name2,0)='')									=> 'DV',' ');
		RETURN Outrelatyp;
	END;

	EXPORT ExtractPartyStatus (STRING ltext) := FUNCTION
		code_hubwf := ' HW$|/HW$| H&W |H/W|\\(HW\\)|\\(H & W\\)|&W\\)|& .*\\bWF\\b|& .*\\bWIFE\\b|& HUSB|, HUSB$|\\bHUSBAND$|HUSBAND & WI?FE|'+
									'HUSBAND AND WI?FE|HUS?BAND WIFE|HUSBAND/WIFE|WFE & HUSB|\\bAND .*\\bWI?FE?\\b|\\bCOUPLE\\b|\\bHIS WIFE\\b|'+
									'\\bETCON\\b|\\bETUX\\b|\\bETVIR\\b|\\bET CON\\b|\\bET UX\\b|\\bET VIR\\b';
		code_wife  := ' WF$|/WF$|\\(WF\\)|\\bWIFE\\b';
		code_dvrcd := '\\(DV\\)| \\(DIVORCED\\)|\\bDIVORCED\\b';
		code_marrd := '\\(MA\\)|\\bMARRIED\\b';
		code_unmrd := '\\bUNMARRIED\\b';
		code_decsd := '\\(DC\\)|\\bDECD\\b|\\bDEC\'D\\b|\\bDECEASED\\b';
		code_singl := '\\bSINGLE,?\\b';
		code_ntsng := 'BEHALF OF SINGLE|CHURCH|CLUB|CONSTRUCTION|CORP|SINGLE & MULTI|SINGLE APART|SINGLE ASSET|SINGLE DAY|SINGLE LIVING|SINGLE LOT|'+
									'SINGLE MEM|SINGLE POINT|SINGLE PROPERTY|SINGLE ROOM|SINGLE SEARCH|SINGLE SOURCE|SINGLE STOP|SINGLE TENANT|SINGLE TREE|'+
									'SINGLE UNIT|SINGLE[ -]FA?M?|SINGLE[ -]HO|UNITED SINGL|VERITAS SINGLE|[1-9]+|\\bDBA\\b|\\bFUND|\\bINC\\b|\\bLLC\\b|'+
									'\\bLTD\\b|\\bTRUST\\b|^SINGLE,?\\b';
		code_widow := '\\bWIDOWE?R?$|\\(WIDOW\\)|/WIDOW,?\\b|\\bWIDOW OF\\b';

		STRING2 OutPartyStatus := 
			MAP((regexfind(code_hubwf,trim(ltext)) 							and 
					 regexfind('STATE H/W|H/W DEPT|H/W COMM',ltext,0)='')	=> 'HW',
					(regexfind(code_wife, trim(ltext))							and 
				 	 regexfind(code_hubwf,trim(ltext),0)='') 							=> 'WF',
					(regexfind(code_singl,trim(ltext)) 							and 
					 regexfind('^\\w+,? SINGLE$',trim(ltext),0)='' 	and 
					 regexfind(code_ntsng,ltext,0)='')										=> 'SI',
					 regexfind(code_decsd,trim(ltext))										=> 'DC',
					 regexfind(code_marrd,trim(ltext))										=> 'MA',
					(regexfind(code_unmrd,trim(ltext)) 							and 
					 regexfind('FEDERAL|LLC|INC',ltext,0)='')							=> 'UN',
				   regexfind(code_widow,trim(ltext))										=> 'WD',
					(regexfind(code_dvrcd,trim(ltext)) 							and
					 regexfind('FOR DIVORCED',ltext,0)='')								=> 'DV',' ');
		RETURN OutPartyStatus;
	END;	

	EXPORT getValidDate (string ltext) := FUNCTION
		string8 today := lib_stringlib.StringLib.getdateYYYYMMDD();
		
		cd_estat := '/ES$|\\(ES\\)|\\(EST\\)|\\(ESTATE\\)|ESTATE OF | EST OF';
		cd_irvtr := ' IRT$|/IRT$|\\(IRT\\)| IT$|/IT$|\\(IT\\)|\\(IRREV TR|\\bIRREVOCABLE TR|IRREVOCABLE LIVING TRUST';
		cd_lifst := '/LE$|\\(LE\\)|\\(L E\\)|LIFE EST|\\(L/E\\)|LF TENANT|LIFE TENANT';
		cd_lvtrt := '/LT$|\\(LT\\)|LIVING TRUST| LIV TR| LV$|/LV$|\\(LV\\)|\\(LIV TR\\)|LIV/TR|TRUST BY WILL';
		cd_revtr := ' RT$|/RT$|\\(RT\\)|\\bREV TR|\\bREVOCABLE TR';
		cd_trste := ' TE$|/TE$|\\(TE\\)|\\(TSTEE|\\(TRTEE|\\(CO TTEE|\\(CO-TTEE|\\(CO TR|\\(CO-TR|AS TRUSTE|'+
								'\\(TRUSTEE|TRUSTEE OF |TRUSTEES OF| TS$|/TS$|\\(TS\\) |BY TRUSTE|TRSTE';
		cd_trust := ' TR$|/TR$|\\(TR\\)|\\bTRUST\\b';

		mv1 := '(([1][0-2])|(0{0,1}[1-9]))';
		mv2 := '(jan|january|feb|february|mar|march|apr|april|may|jun|june|'
					 +'jul|july|aug|august|sep|september|oct|october|nov|november|dec|december)';
		mv3 := '(([1][0-2])|(0[1-9]))';				
		yv1 := '([0-9][0-9])';
		yv2 := '(((19)|(20))'+yv1+')';

		string day := '((0{0,1}[1-9])|([1-2][0-9])|(3[0-1]))';
		string dv2 := '((0[1-9])|([1-2][0-9])|(3[0-1]))';
		string mon := '('+mv1+'|'+mv2+')';
		string yer := '('+yv1+'|'+yv2+')';
		string sep := '(( )*[\\\\\\-\\/\\., ]( )*)';

		string dmy := '('+day+sep+ mon+ sep+ yer+')';
		string my3 := '('+mon+ sep+ yer+')';
		string mdy := '('+mon +sep+ day+ sep+ yer+')';
		string ymd := '('+yer +sep+ day+ sep+ mon+')';
		string ydm := '('+yer +sep+ mon+ sep+day+')';
		string ym3 := '('+yer +sep+ mon+ ')';
		string ymd2:= '('+yv2+mv3+dv2+')';
		string dmy2:= '('+dv2+mv3+yv2+')';
		string mdy2:= '('+mv3+dv2+yv2+')';

		string date(unsigned1 mode) := '(( )|[^0-9]|^)' + map(
							 (mode=1) => dmy,
							 (mode=2) => mdy,
							 (mode=3) => ymd,
							 (mode=4) => ydm,
							 (mode=5) => ymd2,
							 (mode=6) => dmy2,
							 (mode=7) => mdy2,
							 (mode=8) => my3,
							 (mode=9) => ym3,
													 yv2)		+'(( )|[^0-9]|$)';
																	 
		f1(string t):= regexfind(date(2),regexreplace('#[\\d+-]+',t,' '),3,NOCASE);
		f2(string t):= regexfind(date(1),regexreplace('#[\\d+-]+',t,' '),3,NOCASE);
		f3(string t):= regexfind(date(3),regexreplace('#[\\d+-]+',t,' '),3,NOCASE);
		f4(string t):= regexfind(date(4),regexreplace('#[\\d+-]+',t,' '),3,NOCASE);
		f5(string t):= regexfind(date(5),regexreplace('#[\\d+-]+',t,' '),3,NOCASE);
		f6(string t):= regexfind(date(6),regexreplace('#[\\d+-]+',t,' '),3,NOCASE);
		f7(string t):= regexfind(date(7),regexreplace('#[\\d+-]+',t,' '),3,NOCASE);
		f8(string t):= regexfind(date(8),regexreplace('#[\\d+-]+',t,' '),3,NOCASE);
		f9(string t):= regexfind(date(9),regexreplace('#[\\d+-]+',t,' '),3,NOCASE);

		boolean hasValidDate := 
			(length(f1(ltext))>0) or (length(f2(ltext))>0) or (length(f3(ltext))>0) or
			(length(f4(ltext))>0) or (length(f5(ltext))>0) or (length(f6(ltext))>0) or
			(length(f7(ltext))>0) or (length(f8(ltext))>0) or (length(f9(ltext))>0) or
			(length(f9(ltext))>0) ;
		
		string4 formatyyyy (integer2 yyyy) := 
			if(yyyy < 100,if((integer1)today[1..2]<=yyyy,'19'+intformat(yyyy,2,1),'20'+intformat(yyyy,2,1)),intformat(yyyy,4,1));
		
		string reordate (set of string d, unsigned1 mode) := 
			map(mode=1 => formatyyyy((integer2)d[3])+intformat((integer1)d[2],2,1)+intformat((integer1)d[1],2,1), //dmy
					mode=2 => formatyyyy((integer2)d[3])+intformat((integer1)d[1],2,1)+intformat((integer1)d[2],2,1), //mdy
					mode=3 => formatyyyy((integer2)d[1])+intformat((integer1)d[2],2,1)+intformat((integer1)d[3],2,1), //ymd
					mode=4 => formatyyyy((integer2)d[1])+intformat((integer1)d[3],2,1)+intformat((integer1)d[2],2,1), //ydm
					mode=5 => formatyyyy((integer2)d[1])+intformat((integer1)d[2],2,1)+intformat((integer1)d[3],2,1), //ymd2
					mode=6 => formatyyyy((integer2)d[3])+intformat((integer1)d[2],2,1)+intformat((integer1)d[1],2,1), //dmy2
					mode=7 => formatyyyy((integer2)d[3])+intformat((integer1)d[1],2,1)+intformat((integer1)d[2],2,1), //mdy2
					mode=8 => formatyyyy((integer2)d[2])+intformat((integer1)d[1],2,1)+'01', //my3
					mode=9 => formatyyyy((integer2)d[1])+intformat((integer1)d[2],2,1)+'01', //ym3
										formatyyyy((integer2)d[1])+'1231'); //yv2

		string ValidDate :=
			// extract the first one found (i.e. prioritize order. try more detailed first)
			map((length(f1(ltext))>0) => reordate(StringLib.SplitWords(f1(ltext),regexfind('[\\\\\\-\\/\\., ]',f1(ltext),0),FALSE),2),
					(length(f2(ltext))>0) => reordate(StringLib.SplitWords(f2(ltext),regexfind('[\\\\\\-\\/\\., ]',f2(ltext),0),FALSE),1),
					(length(f3(ltext))>0) => reordate(StringLib.SplitWords(f3(ltext),regexfind('[\\\\\\-\\/\\., ]',f3(ltext),0),FALSE),3),
					(length(f4(ltext))>0) => reordate(StringLib.SplitWords(f4(ltext),regexfind('[\\\\\\-\\/\\., ]',f4(ltext),0),FALSE),4),
					(length(f5(ltext))>0) => reordate(StringLib.SplitWords(f5(ltext),regexfind('[\\\\\\-\\/\\., ]',f5(ltext),0),FALSE),5),
					(length(f6(ltext))>0) => reordate(StringLib.SplitWords(f6(ltext),regexfind('[\\\\\\-\\/\\., ]',f6(ltext),0),FALSE),6),
					(length(f7(ltext))>0) => reordate(StringLib.SplitWords(f7(ltext),regexfind('[\\\\\\-\\/\\., ]',f7(ltext),0),FALSE),7),
					(length(f8(ltext))>0) => reordate(StringLib.SplitWords(f8(ltext),regexfind('[\\\\\\-\\/\\., ]',f8(ltext),0),FALSE),8),
					(length(f9(ltext))>0) => reordate(StringLib.SplitWords(f9(ltext),regexfind('[\\\\\\-\\/\\., ]',f9(ltext),0),FALSE),9),
			 '');

		string response := IF(hasValidDate and (
													regexfind(cd_estat,ltext) or regexfind(cd_irvtr,ltext) or 
													regexfind(cd_lifst,ltext) or regexfind(cd_lvtrt,ltext) or 
													regexfind(cd_revtr,ltext) or regexfind(cd_trste,ltext) or 
													regexfind(cd_trust,ltext)),ValidDate,'');
		string onlyvaliddate := if((unsigned4)response>17000000,response,'');

		return onlyvaliddate;
	END;

	EXPORT extractinterest (STRING name) := FUNCTION
		Delim :='(\\b\\d+%) ?INTE?R?E?S?T?\\b|([0-9]+ ?& ?[0-9]+) INTE?R?E?S?T?\\b|([0-9]+ INT)E?R?E?S?T?\\b|([0-9]+\\/[0-9]*[0-9]+)\\)?[^\\/]|'+
						'(HALF) INTE?R?E?S?T?|(ONE THIRD) INTE?R?E?S?T?|(TWO THIRDS) INTE?R?E?S?T?|(ONE FOURTH) INTE?R?E?S?T?|(ONE FIFTH) INTE?R?E?S?T?|'+
						'(ONE SIXTH) INTE?R?E?S?T?|(FRAC)TIONAL INTEREST|([0-9]+ ?%)|([0-9]+ ?INT)E?R?E?S?T?\\b|([0-9]+/[0-9]+)\\b|([0-9]+INT)E?R?E?S?T?\\b|'+
						'(ONE HUNDRED) PERC|(NINETY) PERC|(EIGHTY) PERC|(SEVENTY) PERC|(SIXTY) PERC|(FIFTY) PERC|(FORTY) PERC|(THIRTY) PERC|(TWENTY) PERC|'+
						'(TEN) PERC|\\d+ ?PERC\\b';
		ignore:='24/7\\b|DATED [0-9]+|DTD [0-9]+|HALF INTERNATION|HALF INTL|HALF INT\'L|INTERESTS LP|OF PCTN|PERCENT ENTERPRISES|PERCENT INC|'+
						'PERCENT INVESTMENTS|PERCENT LLC|PERCENT PROPERTIES|PERCENT RENTALS|PERCENT, INC|PERCENT, LLC|\\b[ENSW][ENSW]* ?\\d+\\/\\d+\\b';
		frcwrd:='HALF|ONE THIRD|TWO THIRDS|ONE FOURTH|ONE FIFTH|ONE SIXTH';
		nbrwrd:='(TEN) PERC|(TWENTY) PERC|(THIRTY) PERC|(FORTY) PERC|(FIFTY) PERC|(SIXTY) PERC|(SEVENTY) PERC|(EIGHTY) PERC|(NINETY) PERC|'+
						'(ONE HUNDRED) PERC';
		prct_tbl:=dataset([	{'TEN','10'},{'TWENTY','20'},{'THIRTY','30'},{'FORTY','40'},{'FIFTY','50'},
												{'SIXTY','60'},{'SEVENTY','70'},{'EIGHTY','80'},{'NINETY','90'},{'ONE HUNDRED','100'}],
												{string pct_alp, string pct_nbr});
		percentDCT:=DICTIONARY(prct_tbl,{pct_alp => pct_nbr});

		frac_tbl:=dataset([	{'HALF','1/2'},{'ONE THIRD','1/3'},{'TWO THIRDS','2/3'},
												{'ONE FOURTH','1/4'},{'ONE FIFTH','1/5'},{'ONE SIXTH','1/6'}],
												{string frc_alp, string3 frc_nbr});
		fractionDCT:=DICTIONARY(frac_tbl,{frc_alp => frc_nbr});

		string calcpercent (set of string v) :=
			if(regexfind('\\d+',v[1]) and regexfind('\\d+',v[2]),regexreplace('0.0000',realformat(if((integer2)v[1]/(integer2)v[2]>1,0,round((integer2)v[1]/(integer2)v[2],4))*100,5,2)+'%',v[1]+'/'+v[2]),' ');

		string checkfield (string t) := 
			regexreplace('\\b0\\.00%|\\*\\*\\.\\*\\*%|PERCEN',if(regexfind('\\d+\\/\\d+',t),calcpercent(StringLib.SplitWords(t,'/',FALSE)),t),' ');
		
		mapword2frac(string frc_alp) := fractionDCT[frc_alp].frc_nbr;
		mapword2nbr(string pct_alp) := percentDCT[pct_alp].pct_nbr;
		
		string t1:= if(mapword2frac(regexfind(frcwrd,name,0))>'',regexreplace(regexfind(frcwrd,name,0),name,mapword2frac(regexfind(frcwrd,name,0))),name);
		string t2 := if(mapword2frac(regexfind(nbrwrd,t1,1))>'',regexreplace(regexfind(nbrwrd,t1,1),t1,mapword2frac(regexfind(nbrwrd,t1,1))),t1);
		string t3	:= regexreplace('\\d{1,4}\\/\\d{1,2}\\/\\d{0,4}',regexreplace(' \\/ ',regexreplace('\\bPERCENTA?G?E?\\b',t2,'%'),'\\/'),' ');
		string t4 := map(
										regexfind(delim,t3,1) >'' and regexfind(ignore,t3,0)='' => checkfield(regexfind(delim,t3,1)),
										regexfind(delim,t3,2) >'' and regexfind(ignore,t3,0)='' => checkfield(regexfind(delim,t3,2)),
										regexfind(delim,t3,3) >'' and regexfind(ignore,t3,0)='' => checkfield(regexfind(delim,t3,3)),
										regexfind(delim,t3,4) >'' and regexfind(ignore,t3,0)='' => checkfield(regexfind(delim,t3,4)),
										regexfind(delim,t3,5) >'' and regexfind(ignore,t3,0)='' => checkfield(regexfind(delim,t3,5)),
										regexfind(delim,t3,6) >'' and regexfind(ignore,t3,0)='' => checkfield(regexfind(delim,t3,6)),
										regexfind(delim,t3,7) >'' and regexfind(ignore,t3,0)='' => checkfield(regexfind(delim,t3,7)),
										regexfind(delim,t3,8) >'' and regexfind(ignore,t3,0)='' => checkfield(regexfind(delim,t3,8)),
										regexfind(delim,t3,9) >'' and regexfind(ignore,t3,0)='' => checkfield(regexfind(delim,t3,9)),
										regexfind(delim,t3,10)>'' and regexfind(ignore,t3,0)='' => checkfield(regexfind(delim,t3,10)),
										regexfind(delim,t3,11)>'' and regexfind(ignore,t3,0)='' => checkfield(regexfind(delim,t3,11)),
										regexfind(delim,t3,12)>'' and regexfind(ignore,t3,0)='' => checkfield(regexfind(delim,t3,12)),
										regexfind(delim,t3,13)>'' and regexfind(ignore,t3,0)='' => checkfield(regexfind(delim,t3,13)),
										regexfind(delim,t3,14)>'' and regexfind(ignore,t3,0)='' => checkfield(regexfind(delim,t3,14)),
										regexfind(delim,t3,15)>'' and regexfind(ignore,t3,0)='' => checkfield(regexfind(delim,t3,15)),
										regexfind(delim,t3,16)>'' and regexfind(ignore,t3,0)='' => checkfield(regexfind(delim,t3,16)),
										regexfind(delim,t3,17)>'' and regexfind(ignore,t3,0)='' => checkfield(regexfind(delim,t3,17)),
										regexfind(delim,t3,18)>'' and regexfind(ignore,t3,0)='' => checkfield(regexfind(delim,t3,18)),
										regexfind(delim,t3,19)>'' and regexfind(ignore,t3,0)='' => checkfield(regexfind(delim,t3,19)),
										regexfind(delim,t3,20)>'' and regexfind(ignore,t3,0)='' => checkfield(regexfind(delim,t3,20)),
										regexfind(delim,t3,21)>'' and regexfind(ignore,t3,0)='' => checkfield(regexfind(delim,t3,21)),
										regexfind(delim,t3,22)>'' and regexfind(ignore,t3,0)='' => checkfield(regexfind(delim,t3,22)),
										regexfind(delim,t3,23)>'' and regexfind(ignore,t3,0)='' => checkfield(regexfind(delim,t3,23)),
										regexfind(delim,t3,24)>'' and regexfind(ignore,t3,0)='' => checkfield(regexfind(delim,t3,24)),
										regexfind(delim,t3,25)>'' and regexfind(ignore,t3,0)='' => checkfield(regexfind(delim,t3,25)),
										regexfind(delim,t3,26)>'' and regexfind(ignore,t3,0)='' => checkfield(regexfind(delim,t3,26)),
									'');
		string6 t5 := StringLib.StringCleanSpaces(regexreplace(' %',regexreplace('INT',regexreplace('\\.00%',trim(t4,LEFT,RIGHT)[1..6],'%'),' INT'),'%'));
		return t5;
	END;

	EXPORT setgovtype (STRING name) := FUNCTION
		fedrl_delim:='UNITED STATES|\\bU ?S GOVE?R?N?M?E?N?T?|BUREAU OF';
		state_delim:='\\bSTATE OF|\\bSTATE H/W|H/W DEPT|H/W COMM|STATE LAND| OF SO CALI?F?O?R?N?I?A?$';
		local_delim:='CITY OF |\\bMUNICIP|\\bCOUNTY| CNTY?$\\b|TOWN OF |VILLAGE OF |CITY COUNCIL';
		ignore_delim:='NOT AVAILABLE|NOT AVAIL |TRUST|\\(TE\\)|CREDIT BUREAU| INC$|LLC';
		
		STRING1 outgovtype :=
		MAP(regexfind(state_delim,name) and (regexfind(ignore_delim,name,0)='') => 'S',
				regexfind(local_delim,name) and (regexfind(ignore_delim,name,0)='') => 'L',
				regexfind(fedrl_delim,name) and (regexfind(ignore_delim,name,0)='') => 'F','');
		RETURN outgovtype;
	END;
END;