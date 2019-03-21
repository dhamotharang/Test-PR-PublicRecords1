IMPORT corp2_mapping, ut, corp2,lib_stringlib;

EXPORT Functions := Module

		//****************************************************************************
		//fGetName_Type_Cd : returns the "corp_ln_name_type_cd".
		//****************************************************************************

		EXPORT fGetName_Type_Cd (STRING ECode) := FUNCTION
		
			code:= corp2.t2u(ECode);
			
		 RETURN MAP(code='00'=>'01',
								code='01'=>'01',
								code='02'=>'01',
								code='03'=>'01',
								code='04'=>'01',
								code='05'=>'01',
								code='06'=>'01',
								code='07'=>'01',
								code='08'=>'01',
								code='09'=>'01',
								code='10'=>'01',
								code='11'=>'01',
								code='12'=>'01',
								code='13'=>'01',
								code='14'=>'01',
								code='15'=>'01',
								code='16'=>'01',
								code='17'=>'01',
								code='18'=>'01',
								code='19'=>'01',
								code='20'=>'01',
								code='21'=>'01',
								code='22'=>'01',
								code='23'=>'01',
								code='BT'=>'01',
								code='CF'=>'01',
								code='CH'=>'01',
								code='CN'=>'01',
								code='CP'=>'01',
								code='CV'=>'01',
								code='FN'=>'F',
								code='FP'=>'01',
								code='GL'=>'01',
								code='LF'=>'01',
								code='LL'=>'01',
								code='LP'=>'01',
								code='MO'=>'09',
								code='NR'=>'07',
								code='PR'=>'01',
								code='RC'=>'01',
								code='RN'=>'04',
								code='RT'=>'01',
								code='SM'=>'05',
								code='TM'=>'03',
								code='UN'=>'01',
								code);
		end;								

		//****************************************************************************
		//fGetFilingDesc : returns the "event_filing_desc".
		//****************************************************************************

		EXPORT fGetFilingDesc (STRING ECode) := FUNCTION

					 code:= corp2.t2u(ECode);
					 
					 RETURN MAP(code='VQD' => 'CHG BUSNSS TYPE-DOM. LLP/STMNT OF QUALIFICATION',
											code='VQF' => 'CHG BUSNSS TYPE-FOR. LLP/STMNT OF QUALIFICATION',
											code='VPR' => 'CHANGE BUSINESS TYPE - PARTNERSHIP',
											code='TIC' => 'TRANSCRIPT CHECK',
											code='ICR' => 'SHARE INCREASE CREDIT',
											code='RCN' => 'UNLIC. FOR. NAME RESERV/OWNERS NAME CHANGE',
											code='CAA' => 'CHANGE RECORD ACCESS ADDRESS',
											code='CBA' => 'CHANGE PRINCIPAL BUSINESS ADDRESS',
											code='CDD' => 'CHANGE DOMESTIC AGENT ADDRESS',
											code='CDG' => 'CHANGE DOMESTIC AGENT',
											code='CFB' => 'CHANGE FROM BANK TO GENERAL CORP',
											code='CFD' => 'CHANGE FOREIGN AGENT ADDRESS',
											code='CFG' => 'CHANGE FOREIGN AGENT',
											code='CFN' => 'DOMESTIC/CHANGE FOR PROFIT TO NON-PROFIT',
											code='CFP' => 'DOMESTIC/CHANGE FOR PROFIT TO PROFESSIONAL',
											code='CHL' => 'DOMESTIC CHANGE OF LOCATION',
											code='CHN' => 'CHANGE OF NAME',
											code='CHP' => 'CHANGE OF PURPOSE',
											code='CHS' => 'DOMESTIC CHANGE OF SHARES',
											code='CHV' => 'DOMESTIC CHANGE OF STOCK VALUE',
											code='CLD' => 'CHANGE LIMITED/LIABILITY/PARTNERS AGENT ADDRESS',
											code='CLG' => 'CHANGE LIMITED/LIABILITY/PARTNERS AGENT',
											code='CLR' => 'AGENT CHANGE',
											code='CLT' => 'CANCELLATION NOTICE SERVED',
											code='CMA' => 'CHANGE-AMENDED ARTICLES',
											code='CMD' => 'CHANGE-AMENDMENT',
											code='CMP' => 'CHANGE MEMBERS/PARTNERS',
											code='COA' => 'CHANGE OF PRINCIPAL OFFICE ADDRESS',
											code='CPE' => 'CHANGE PERIOD OF EXISTENCE',
											code='CPF' => 'DOMESTIC/CHANGE PROFESSIONAL TO FOR PROFIT',
											code='CPO' => 'CHANGE PRINCIPAL OFFICE ADDRESS FOR FP',
											code='CSN' => 'DOMESTIC/CHANGE STOCK TO NON-STOCK',
											code='CSS' => 'DOMESTIC/CREATION OF STOCK SERIES',
											code='DEC' => 'DECREASE OF AUTHORIZED SHARES OF STOCK',
											code='FPP' => 'FOREIGN/CHANGE OF PRINCIPAL OFFICE',
											code='INC' => 'INCREASE OF AUTHORIZED STOCK SHARES',
											code='MOC' => 'MARK OF OWNERSHIP/REGISTRANT ADDRESS CHANGE',
											code='MON' => 'MARK OF OWNERSHIP/OWNERS NAME CHANGE',
											code='MOP' => 'MARK OF OWNERSHIP/CHANGE OF PARTNERS',
											code='NFC' => 'FICTITIOUS NAME/REGISTRANT ADDRESS CHANGE',
											code='NFN' => 'FICTITIOUS NAME/OWNERS NAME CHANGE',
											code='NFP' => 'FICTITIOUS NAME/CHANGE OF PARTNERS',
											code='RCC' => 'UNLIC. FOR. NAME RESERV./REGISTRANT ADDRESS CHANGE',
											code='RNC' => 'TRADE NAME/REGISTRANT ADDRESS CHANGE',
											code='RNN' => 'TRADE NAME/OWNERS NAME CHANGE',
											code='RNP' => 'TRADE NAME/CHANGE OF PARTNERS',
											code='SAA' => 'SERVICE ADDRESS ASSIGNMENT',
											code='SMC' => 'SERVICE MARK/REGISTRANT ADDRESS CHANGE',
											code='SMN' => 'SERVICE MARK/OWNERS NAME CHANGE',
											code='SMP' => 'SERVICE MARK/CHANGE PARTNERS',
											code='TMC' => 'TRADE MARK/REGISTRANT ADDRESS CHANGE',
											code='TMN' => 'TRADE MARK/OWNERS NAME CHANGE',
											code='TMP' => 'TRADE MARK/CHANGE OF PARTNERS',
											code='TRA' => 'DOMESTIC LIMITED PARTNERSHIP/TRUSTEE ASSIGNMENT',
											code='TRC' => 'DOMESTIC LIMITED PARTNERSHIP/TRUSTEE CHANGE',
											code='ADF' => 'ADDITIONAL FEE',
											code='CFO' => 'CHANGE TO COOPERATIVE',
											code='CHC' => 'DOMESTIC/CHANGE OF STATED CAPITAL',
											code='AAL' => 'ASSETS & ASSUMPTIONS OF LIABILITES',
											code='CSP' => 'CHANGE FOREIGN SHARES',
											code='CFS' => 'CHANGE STATE',
											code='CFA' => 'FOREIGN/ADDING ASSUME NAME',
											code='CAF' => 'FOREIGN/DELETING ASSUMED NAME',
											code='VCD' => 'CHANGE  TO DOMESTIC FOR PROFIT',
											code='VCP' => 'CHANGE  TO DOMESTIC PROFESSIONAL',
											code='VCF' => 'CHANGE BUSINESS TYPE TO FOREIGN FOR PROFIT',
											code='VCB' => 'CHANGE BUSINESS TYPE TO FOREIGN NATIONAL BANK',
											code='VCS' => 'CHANGE BUSINESS TYPE TO FOREIGN STATE BANK',
											code='VCE' => 'CHANGE BUSINESS TYPE TO FOREIGN PROFESSIONAL',
											code='VCH' => 'CHANGE BUSINESS TYPE TO FOREIGN NON PROFIT',
											code='VCC' => 'CHANGE BUSINESS TYPE TO FOREIGN CREDIT UNION',
											code='VCJ' => 'CHANGE BUSINESS TYPE TO FOREIGN COOPERATIVE',
											code='VCK' => 'CHANGE BUSINESS TYPE TO FOREIGN CHURCH',
											code='VCR' => 'CHANGE BUSINESS TYPE TO REAL ESTATE TRUST',
											code='VCT' => 'CHANGE BUSINESS TYPE TO BUSINESS TRUST',
											code='VCN' => 'CHANGE BUSINESS TYPE FOREIGN PROFIT-ASSUMED NAME',
											code='VCA' => 'CHANGE BUSINESS TYPE-FOR. NATL BANK-ASSUMED NAME',
											code='VCI' => 'CHANGE BUSINESS TYPE-FOR. STATE BANK-ASSUMED NAME',
											code='VCG' => 'CHANGE BUS. TYPE FOR. PROFESSIONAL ASSUMED NAME',
											code='VCM' => 'CHANGE BUSINESS TYPE FOREIGN CHURCH ASSUMED NAME',
											code='VCO' => 'CHANGE BUSINESS TYPE DOMESTIC LIMITED PARTNERSHIP',
											code='VCQ' => 'CHANGE BUSINESS TYPE FOREIGN LIMITED PARTNERSHIP',
											code='VCW' => 'CHANGE BUSINESS TYPE DOM. LIMITED LIABILITY CO.',
											code='VCX' => 'CHANGE BUSINESS TYPE FOR. LIMITED LIABILITY CO.',
											code='VCU' => 'CHANGE BUS DOM. LIMITED LIABILITY PARTNERSHIP',
											code='VCV' => 'CHANGE BUS TYPE FOR. LIMITED LIABILITY PARTNERSHIP',
											code='VCL' => 'CHANGE BUSINESS TYPE TO DOMESTIC ACT OF LAW',
											code='VCY' => 'CHANGE  TO FOREIGN NON PROFIT ASSUMED NAME',
											code='VNP' => 'CHANGE BUSINESS TYPE FOR. PROFIT LIM. LIAB. CO',
											code='VNN' => 'CHANGE BUSINESS TYPE FOR. NONPROFIT LIM. LIAB. CO',
											code='VNF' => 'CHANGE BUSINESS TYPE DOM. PROFIT LIM. LIAB. CO',
											code='VNO' => 'CHANGE BUSINESS TYPE DOM. NONPROFIT LIM. LIAB. CO',
								      '');

		END;			

		//****************************************************************************
		//org_structure_desc: returns the "corp_orig_org_structure_desc".
		//****************************************************************************

		EXPORT org_structure_desc(STRING BusType) := FUNCTION

						code:= corp2.t2u(BusType);
						
			RETURN map( code='00'=>'PROFESSIONAL TYPE',
									code='01'=>'ACCOUNTANT',
									code='02'=>'PODIATRY',
									code='03'=>'ARCHITECT',
									code='04'=>'ARCHITECT & ENGINEER',
									code='05'=>'ARCHITECT & ENGINEER & SURVEYOR',
									code='06'=>'ATTORNEY',
									code='07'=>'ARCHITECT & SURVEYOR',
									code='08'=>'CHIROPRACTOR',
									code='09'=>'DENTIST',
									code='10'=>'PHARMACIST',
									code='11'=>'ENGINEER',
									code='12'=>'ENGINEERS & SURVEYORS',
									code='13'=>'PSYCHOLOGIST',
									code='14'=>'SURVEYOR',
									code='15'=>'MASSAGE',
									code='16'=>'MECHANOTHERAPY',
									code='17'=>'MEDICAL',
									code='18'=>'VETERINARIAN',
									code='19'=>'OSTEOPATHY',
									code='20'=>'OPTOMETRIST',
									code='21'=>'PHYSICAL THERAPISTS',
									code='22'=>'REGISTERED NURSES',
									code='23'=>'OCCUPATIONAL THERAPISTS',
									code='BT'=>'BUSINESS TRUSTS',
									code='CF'=>'FOREIGN CORPORATION',
									code='CH'=>'CHURCH',
									code='CN'=>'CORPORATION FOR NON-PROFIT',
									code='CP'=>'CORPORATION FOR PROFIT',
									code='CV'=>'CONVERSION DEFAULT',
									code='FP'=>'FOREIGN LIMITED PARTNERSHIP',
									code='GL'=>'LIMITED LIABILITY PARTNERS',
									code='LF'=>'FOREIGN LIMITED LIABILITY COMPANY',
									code='LL'=>'DOMESTIC LIMITED LIABILITY COMPANY',
									code='LP'=>'LIMITED PARTNERSHIP',
									code='PR'=>'PARTNERSHIP',
									code='RC'=>'REGISTERED FOREIGN CORPORATION',
									code='RT'=>'REAL ESTATE TRUST',
									code='UN'=>'UNINCORPORATED NONPROFIT ASSOCIATION',
								  '');
		END;				
		
		//****************************************************************************
		//fGetTrademarkDesc: returns the "corp_trademark_class_desc1".
		//****************************************************************************
		EXPORT fGetTrademarkDesc(STRING BusClass) := FUNCTION

					 code:= corp2.t2u(BusClass);
						
					 RETURN	map(code='00'=>'GOODS OR SERVICES',
											code='01'=>'CHEMICALS',
											code='02'=>'PAINTS',
											code='03'=>'COSMETICS AND CLEANING PREPARATIONS',
											code='04'=>'LUBRICANTS AND FUELS',
											code='05'=>'PHARMACEUTICAL',
											code='06'=>'METAL GOODS',
											code='07'=>'MACHINERY',
											code='08'=>'HAND TOOLS',
											code='09'=>'ELECTRICAL AND SCIENTIFIC APPARATUS',
											code='10'=>'MEDICAL APPARATUS',
											code='11'=>'ENVIRONMENTAL CONTROL APPARATUS',
											code='12'=>'VEHICLES',
											code='13'=>'FIREARMS',
											code='14'=>'JEWELRY',
											code='15'=>'MUSICAL INSTRUMENTS',
											code='16'=>'PAPER GOODS AND PRINTED MATTER',
											code='17'=>'RUBBER GOODS',
											code='18'=>'LEATHER GOODS',
											code='19'=>'NON-METALLIC BUILDING MATERIALS',
											code='20'=>'FURNITURE AND ARTICLES NOT OTHERWISE CLASSIFIED',
											code='21'=>'HOUSEWARES AND GLASS',
											code='22'=>'CORDAGE AND FIBERS',
											code='23'=>'YARNS AND THREADS',
											code='24'=>'FABRICS',
											code='25'=>'CLOTHING',
											code='26'=>'FANCY GOODS',
											code='27'=>'FLOOR COVERINGS',
											code='28'=>'TOYS AND SPORTING GOODS',
											code='29'=>'MEATS AND PROCESSED FOODS',
											code='30'=>'STAPLE FOODS',
											code='31'=>'NATURAL AGRICULTURAL PRODUCTS',
											code='32'=>'LIGHT BEVERAGES',
											code='33'=>'WINES AND SPIRITS',
											code='34'=>'SMOKERS ARTICLES',
											code='35'=>'ADVERTISING AND BUSINESS',
											code='36'=>'INSURANCE AND FINANCIAL',
											code='37'=>'CONSTRUCTION AND REPAIR',
											code='38'=>'COMMUNICATION',
											code='39'=>'TRANSPORTATION AND STORAGE',
											code='40'=>'MATERIAL TREATMENT',
											code='41'=>'EDUCATION AND ENTERTAINMENT',
											code='42'=>'MISCELLANEOUS',
											code='43'=>'FOOD AND DRINK',
											code='44'=>'MEDICAL OR VETERINARY SERVICES',
											code='45'=>'PERSONAL AND SOCIAL SERVICES',
											code='LCP'=>'',// Per CI, LCP and LFA are errors.Should be ignored !!
											code='LFA'=>'',
											code='19790108 000000'=>'',//These are all vendor errors.
											code='20050812 090000'=>'',
											code='20080219 090000'=>'',
											code='20101227 090000'=>'',
											code='20110101 090000'=>'',
											code='20131225 000000'=>'',
											code='20140804 000000'=>'',
											code='20141017 090000'=>'',
											code='20150302 213542'=>'',
											code='20150509 213517'=>'',
											code='20150613 075906'=>'',
											code='20150622 125527'=>'',
											code='20150629 075424'=>'',
											code='20150715 063237'=>'',
											code='20150923 074336'=>'',
											code='20160217 160344'=>'',
											code='20160316 000000'=>'',
											code='20160526 000000'=>'',
											code='20160616 111121'=>'',
											code=''  =>'',
								      '**|'+code);
											
		END;			
				
		//Below table needs to be updated when we see new filing codes in Raw updates!	
		EXPORT Set_Of_Event_FilingCodes :=[ '00F','00N','00P','01F','01N','01P','02F','02N','02P','03F','03N','03P','04F','04N','04P','05F','05N',
																				'05P','06F','06N','06P','07F','07N','07P','08F','08N','08P','09F','09N','09P','10F','10N','10P','30F',
																				'30N','30P','31F','31N','31P','32F','32N','32P','33F','33N','33P','34F','34N','34P','35F','35N','35P',
																				'36F','36N','36P','37F','37N','37P','38F','38N','38P','39F','39N','39P','40F','40N','40P','41F','41N',
																				'41P','42F','42N','42P','43F','43N','43P','44F','44N','44P','45F','45N','45P','46F','46N','46P','47F',
																				'47N','47P','48F','48N','48P','49F','49N','49P','50F','50N','50P','51F','51N','51P','52F','52N','52P',
																				'53F','53N','53P','54F','54N','54P','55F','55N','55P','56F','56N','56P','57F','57N','57P','58F','58N',
																				'58P','59F','59N','59P','60F','60N','60P','61F','61N','61P','62F','62N','62P','63F','63N','63P','64F',
																				'64N','64P','65F','65N','65P','66F','66N','66P','67F','67N','67P','68F','68N','68P','69F','69N','69P',
																				'70F','70N','71F','71N','72F','72N','73F','73N','74F','74N','75F','75N','76F','76N','77F','77N','78F',
																				'78N','79F','79N','7LT','80F','80N','80P','81F','81N','81P','82F','82N','82P','83F','83N','83P','84F',
																				'84N','84P','85F','85N','85P','86F','86N','86P','87F','87N','87P','88F','88N','88P','89F','89N','89P',
																				'90F','90N','90P','91F','91N','91P','92F','92N','92P','93F','93N','93P','94F','94N','94P','95F','95N',
																				'95P','96F','96N','96P','97F','97N','97P','98F','98N','98P','99F','99N','99P','ABC','ABM','ACC','AGA',
																				'AGO','AGR','AGS','AGU','AHO','ALT','AMA','AMD','ANE','AOD','ARA','ARB','ARC','ARD','ARF','ARH','ARI',
																				'ARN','ARO','ARP','ARR','ARS','ART','ARU','ARY','AUT','AXA','BSA','BTA','BTN','BTS','BTW','BUA','CAC',
																				'CCE','CEX','CLC','CLF','CLL','CLN','CLP','CNF','CNL','CNN','CNO','CNP','CNR','CNV','COC','COD',
																				'COF','COL','CON','COO','COP','CPL','CPT','CPV','CQD','CQF','CRT','CSV','CTO','CUF','CVA','CVB','CVC',
																				'CVD','CVE','CVF','CVG','CVH','CVI','CVJ','CVK','CVL','CVM','CVN','CVO','CVP','CVQ','CVR','CVS','CVT',
																				'CVU','CVV','CVW','CVX','CVY','CVZ','DBA','DCE','DCO','DIS','DLT','DMR','FAC','FAM','FAN','FAP','FCE',
																				'FCR','FGA','FGO','FGR','FGS','FL2','FLA','FLB','FLC','FLF','FLN','FLO','FLP','FLS','FLT','FLU','FMR',
																				'FNA','FNB','FPC','FPO','FRE','FSA','FSB','FXA','FXT','GLT','LAD','LAG','LAM','LCA','LCN','LCP','LDS',
																				'LFA','LFC','LFN','LFP','LFS','LIC','LPA','LPC','LPD','LPF','LPN','LPR','LPS','LRA','LSA','LTR','MCX',
																				'MER','MEX','MFC','MIS','MNL','MOA','MOB','MOD','MOE','MOO','MOR','MOX','MPL','MRF','MRL','MRN','MRO',
																				'MRP','MUA','MUC','MUF','MUL','N/R','NEW','NFA','NFB','NFE','NFL','NFO','NFR','NFX','NRO','NRR','NRT',
																				'PAM','PCS','PDA','PDN','PDS','PEN','PER','PLF','PLL','PLR','PLT','PLW','PQD','PQF','PRS','PRT','PSC',
																				'PSX','RCA','RCB','RCE','RCO','RCR','RCX','REN','RNA','RNB','RNE','RNL','RNO','RNR','RNX','RTA','RTC',
																				'RTF','RTO','RTP','RTR','RTS','RTX','RXM','SAN','SMA','SMB','SME','SMO','SMR','SMX','SUB','SUC','SUD',
																				'RTD','SUR','TEM','TMA','TMB','TME','TMO','TMR','TMX','UNA','UNC','UND','UNL','UNO','UNR','UNS','UTH',
																				'VXC','SUM','VXE','VXF','VXI','VXL','VXP','VXU','VXX','XCE','XFF','XGA','XOL','XPA','XSS','XTD','XXX',
																				'VQD','VQF','VPR','TIC','ICR','RCN','CAA','CBA','CDD','CDG','CFB','CFD','CFG','CFN','CFP','CHL','CHN',
																				'CHP','CHS','CHV','CLD','CLG','CLR','CLT','CMA','CMD','CMP','COA','CPE','CPF','CPO','CSN','CSS','DEC',
																				'FPP','INC','MOC','MON','MOP','NFC','NFN','NFP','RCC','RNC','RNN','RNP','SAA','SMC','SMN','SMP','TMC',
																				'TMN','TMP','TRA','TRC','ADF','CFO','CHC','AAL','CSP','CFS','CFA','CAF','VCD','VCP','VCF','VCB','VCS',
																				'VCE','VCH','VCC','VCJ','VCK','VCR','VCT','VCN','VCA','VCI','VCG','VCM','VCO','VCQ','VCW','VCX','VCU',
																				'VCV','VCL','VCY','VNP','VNN','VNF','VNO',''];
																	

		
		//Below table needs to be updated when we see new AR Type codes in Raw updates!	
		EXPORT Set_Of_Ar_FilingCodes :=['00A','00L','01A','01L','02A','02L','03L','04A','05L','06A','07L','08A','09L','10A',
																		'11L','12A','13L','14A','16A','15L','17L','18A','60A','61A','62A','63A','64A','65A','66A','67A',
																		'68A','69A','70A','71A','72A','73A','74A','75A','76A','77A','78A','79A','80A','81A',
																		'82A','83A','84A','85A','86A','87A','88A','89A','90A','91A','92A','92L','93A','94A',
																		'95A','95L','96A','96L','97A','97L','98A','98L','99A','99L','ANR','71L','72L','73L',
																		'74L','75L','76L','77L','78L','79L','80L','81L','82L','84L','85L','86L','87L','88L',
																		'89L','90L','91L','93L','94L','04L','06L','08L','10L'];
																	
		//****************************************************************************
		//AR_TypeDesc: returns the "ar_type".
		//****************************************************************************
		EXPORT AR_TypeDesc(STRING code) := FUNCTION

					 uc:= corp2.t2u(code);
						
					 RETURN	map(code in ['ANR','00A','01A','60A','61A','62A','63A','64A',
															 '65A','66A','67A','68A','69A','70A','71A',
															 '72A','73A','74A','75A','76A','77A','78A',
															 '79A','80A','81A','82A','83A','84A','85A',
															 '86A','87A','88A','89A','90A','91A','93A',
															 '94A','95A','96A','97A','99A','98A','92A'] 		 => 'ANNUAL REPORT OF PROFESSIONAL CORP',
											code in ['71L','72L','73L','74L','75L','76L','77L',
															 '78L','79L','80L','81L','82L','84L','85L',
															 '86L','87L','88L','89L','90L','91L','92L',
															 '93L','94L','95L','96L','97L','98L','99L',
															 '00L','01L','02L','04L','06L','08L','10L'] 		 => 'ANNUAL REPORT/LIMITED LIABILITY PARTNERSHIP',
											code in['02A','04A','08A','10A','12A','14A','06A','18A'] => 'BIENNIAL REPORT OF PROFESSIONAL CORP',
											code in['03L','05L','07L','09L','11L','13L','15L','17L'] => 'BIENNIAL REPORT/LIMITED LIABILITY PARTNERSHIP',
											'');																
																	
		End;
		
  	EXPORT GetAddlInfo(string License_Type ,string Consent_Flag ,string Business_Location_Name ,string Business_Class )  := FUNCTION
   		
				LicenseType            := map(corp2.t2u(License_Type) = 'T'=>'LICENSE TYPE: TEMPORARY LICENSE',
																			corp2.t2u(License_Type) = 'P'=>'LICENSE TYPE: PERMANENT LICENSE',
																			''); 
				Consent								 := if(corp2.t2u(Consent_Flag) = 'Y' ,'RECEIVED CONSENT TO USE PROTECTED NAME' ,'');
				BusinessLoc            := if(corp2.t2u(Business_Location_Name)<>'','PRINCIPAL LOCATION: '+corp2.t2u(Business_Location_Name),'');
				Purpose								 := map( trim(Business_Class,left,right)='01'=>'CHEMICALS',
																			 trim(Business_Class,left,right)='02'=>'PAINTS',
																			 trim(Business_Class,left,right)='03'=>'COSMETICS AND CLEANING PREPARATIONS',
																			 trim(Business_Class,left,right)='04'=>'LUBRICANTS AND FUELS',
																			 trim(Business_Class,left,right)='05'=>'PHARMACEUTICAL',
																			 trim(Business_Class,left,right)='06'=>'METAL GOODS',
																			 trim(Business_Class,left,right)='07'=>'MACHINERY',
																			 trim(Business_Class,left,right)='08'=>'HAND TOOLS',
																	 		 trim(Business_Class,left,right)='09'=>'ELECTRICAL AND SCIENTIFIC APPARATUS',
																			 trim(Business_Class,left,right)='10'=>'MEDICAL APPARATUS',
																			 trim(Business_Class,left,right)='11'=>'ENVIRONMENTAL CONTROL APPARATUS',
																			 trim(Business_Class,left,right)='12'=>'VEHICLES',
																			 trim(Business_Class,left,right)='13'=>'FIREARMS',
																			 trim(Business_Class,left,right)='14'=>'JEWELRY',
																			 trim(Business_Class,left,right)='15'=>'MUSICAL INSTRUMENTS',
																			 trim(Business_Class,left,right)='16'=>'PAPER GOODS AND PRINTED MATTER',
																			 trim(Business_Class,left,right)='17'=>'RUBBER GOODS',
																			 trim(Business_Class,left,right)='18'=>'LEATHER GOODS',
																			 trim(Business_Class,left,right)='19'=>'NON-METALLIC BUILDING MATERIALS',
																			 trim(Business_Class,left,right)='20'=>'FURNITURE AND ARTICLES NOT OTHERWISE CLASSIFIED',
																			 trim(Business_Class,left,right)='21'=>'HOUSEWARES AND GLASS',
																			 trim(Business_Class,left,right)='22'=>'CORDAGE AND FIBERS',
																			 trim(Business_Class,left,right)='23'=>'YARNS AND THREADS',
																			 trim(Business_Class,left,right)='24'=>'FABRICS',
																			 trim(Business_Class,left,right)='25'=>'CLOTHING',
																			 trim(Business_Class,left,right)='26'=>'FANCY GOODS',
																			 trim(Business_Class,left,right)='27'=>'FLOOR COVERINGS',
																			 trim(Business_Class,left,right)='28'=>'TOYS AND SPORTING GOODS',
																			 trim(Business_Class,left,right)='29'=>'MEATS AND PROCESSED FOODS',
																			 trim(Business_Class,left,right)='30'=>'STAPLE FOODS',
																			 trim(Business_Class,left,right)='31'=>'NATURAL AGRICULTURAL PRODUCTS',
																			 trim(Business_Class,left,right)='32'=>'LIGHT BEVERAGES',
																			 trim(Business_Class,left,right)='33'=>'WINES AND SPIRITS',
																			 trim(Business_Class,left,right)='34'=>'SMOKERS ARTICLES',
																			 trim(Business_Class,left,right)='35'=>'ADVERTISING AND BUSINESS',
																			 trim(Business_Class,left,right)='36'=>'INSURANCE AND FINANCIAL',
																			 trim(Business_Class,left,right)='37'=>'CONSTRUCTION AND REPAIR',
																			 trim(Business_Class,left,right)='38'=>'COMMUNICATION',
																			 trim(Business_Class,left,right)='39'=>'TRANSPORTATION AND STORAGE',
																			 trim(Business_Class,left,right)='40'=>'MATERIAL TREATMENT',
																			 trim(Business_Class,left,right)='41'=>'EDUCATION AND ENTERTAINMENT',
																			 trim(Business_Class,left,right)='42'=>'SCIENTIFIC AND TECHNOLOGICAL',
																			 trim(Business_Class,left,right)='43'=>'PROVIDING FOOD AND DRINK',
																			 trim(Business_Class,left,right)='44'=>'MEDICAL,VETERINARY,HYGIENIC,AGRICULTURE,FORESTRY',
																			 trim(Business_Class,left,right)='45'=>'PERSONAL, SOCIAL AND SECURITY',
																			 '');
				TradeMark               :=if(trim(Purpose,left,right)<>'' ,'PURPOSE OF TRADEMARK OR SERVICE MARK: '+ Purpose,'');
				concatFields						:= trim(trim(LicenseType,left,right) + ';' + 
																				trim(Consent,left,right) + ';' 		 + 
																				trim(BusinessLoc,left,right) + ';' + 
																				trim(TradeMark,left,right),left,right
																				);
				tempExp								  := regexreplace('[;]*$',concatFields,'',NOCASE);
				tempExp2							  := regexreplace('^[;]*',tempExp,'',NOCASE);
				tempExp3							  := regexreplace('[;]+',tempExp2,';',NOCASE);
				addl_info              	:= lib_stringlib.StringLib.StringFindReplace(tempExp3,';','; ');
				return addl_info;

		END; 
		 
End;