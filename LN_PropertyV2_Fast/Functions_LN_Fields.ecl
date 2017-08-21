IMPORT lib_word, lib_StringLib, LN_PropertyV2, LN_PropertyV2_Fast;
EXPORT Functions_LN_Fields := MODULE

	EXPORT ExtractBlock (VARSTRING Text_Field) := FUNCTION // https://bugzilla.seisint.com/show_bug.cgi?id=161068
		BlockDelim 	:= '\\bBLO?C?K?S? +SEC:?\\.? +(\\w+\\b)|\\bBLO?C?K?S? +NO:?\\.? +(\\w+\\b)|\\bBLO?C?K?S?:?\\.? +(\\w+\\b)|\\bBLOCK\\.?:?\\/?-? ?([0-9A-Z]+?)\\b|\\bBLK\\.?:?\\/?-? ?([0-9A-Z]+?)\\b';
		STRING t1 	:= StringLib.StringFindReplace(StringLib.StringFindReplace(StringLib.StringFindReplace(Text_Field,'-','_'),'_BLK','-BLK'),'_BLOCK','-BLOCK');
		STRING t2 	:= StringLib.StringFindReplace(StringLib.StringFindReplace(StringLib.StringFindReplace(t1,'BLK_','BLK-'),'BLOCK_','BLOCK-'),'"',' ');
		STRING t3 	:= 	IF(TRIM(REGEXFIND(BlockDelim,t2,1),LEFT,RIGHT)<>'',REGEXFIND(BlockDelim,t2,1),
											IF(TRIM(REGEXFIND(BlockDelim,t2,2),LEFT,RIGHT)<>'',REGEXFIND(BlockDelim,t2,2),
												IF(TRIM(REGEXFIND(BlockDelim,t2,3),LEFT,RIGHT)<>'',REGEXFIND(BlockDelim,t2,3),
													IF(TRIM(REGEXFIND(BlockDelim,t2,4),LEFT,RIGHT)<>'',REGEXFIND(BlockDelim,t2,4),
														IF(TRIM(REGEXFIND(BlockDelim,t2,5),LEFT,RIGHT)<>'',REGEXFIND(BlockDelim,t2,5),'')))));
		STRING t4 	:= REGEXREPLACE('^-+(?!$)',REGEXREPLACE('(?!$)-+$',StringLib.StringFindReplace(TRIM(t3,LEFT,RIGHT),'_','-'),' '),' ');
		STRING t5 	:= REGEXREPLACE('([-A-Z]{3,}$)',TRIM(REGEXREPLACE('^0+(?!$)',TRIM(t4,LEFT,RIGHT),' '),LEFT,RIGHT),' ');
		STRING t6 	:= REGEXREPLACE('^-+(?!$)',TRIM(REGEXREPLACE('(?!$)-+$',TRIM(t5,LEFT,RIGHT),' '),LEFT,RIGHT),' ');
		STRING t7 	:= StringLib.StringFindReplace(StringLib.StringFindReplace(StringLib.StringFindReplace(TRIM(t6,LEFT,RIGHT),'OF',' '),'ER',' '),'TR',' ');
		STRING t8 	:= IF(LENGTH(TRIM(t7,LEFT,RIGHT))<6,t7,' ');
		STRING20 OutBlock := TRIM(REGEXREPLACE('^-+(?!$)',TRIM(REGEXREPLACE('(?!$)-+$',TRIM(t8,LEFT,RIGHT),' '),LEFT,RIGHT),' '),LEFT,RIGHT);
		RETURN OutBlock;
	END;

	EXPORT ExtractLot (VARSTRING Text_Field) := FUNCTION // https://bugzilla.seisint.com/show_bug.cgi?id=161068
		LotDelim		:= '\\bLOT NUMB?E?R?([^A-Za-z(]+)|\\bLOT NOS?\\.?:?([^A-Za-z(]+)|\\bLO?TS?:? *([^A-Za-z(]+)';
		STRING t1		:= StringLib.StringFindReplace(Text_Field,' THRU ','-');
		STRING t2		:= REGEXREPLACE('([0-9.\'"]* ?X ?[0-9.\'"]+)',t1,' ');
		STRING t3		:= REGEXREPLACE('([0-9]{0,3},?[0-9]{3}\\.?[0-9]*) *SQ?F?T?',t2,' ');
		STRING t4		:= REGEXREPLACE('[0-9,]+ ([0-9,]*\\.?[0-9]+) *ACR?E?S?\\b',t3,' ');
		STRING t5		:= REGEXREPLACE('\\bLOT[ :]*[0-9]+[, ]+([0-9]{3,}) [ENSW]{0,2} ?[A-Z]{4,} [A-Z]{2,} ?[A-Z]*',t4,' ');
		STRING t6		:= StringLib.StringCleanSpaces(StringLib.StringFindReplace(StringLib.StringFindReplace(StringLib.StringFindReplace(t5,' AND ',' '),' L OTS',' LOTS'),'+',' '));
		STRING t7		:= StringLib.StringCleanSpaces(StringLib.StringFindReplace(StringLib.StringFindReplace(TRIM(t6,LEFT,RIGHT),'&',' '),',',' '));
		STRING t8		:=	IF(TRIM(REGEXFIND(LotDelim,t7,1),LEFT,RIGHT)<>'',REGEXFIND(LotDelim,t7,1),
											IF(TRIM(REGEXFIND(LotDelim,t7,2),LEFT,RIGHT)<>'',REGEXFIND(LotDelim,t7,2),
												IF(TRIM(REGEXFIND(LotDelim,t7,3),LEFT,RIGHT)<>'',REGEXFIND(LotDelim,t7,3),'')));
		STRING t9		:= REGEXREPLACE('[0-9]*\'[0-9]*',REGEXREPLACE('([0-9]*\\.[0-9]+)',REGEXREPLACE('([0-9]*\\/[ 0-9-]*)',TRIM(t8,LEFT,RIGHT), '~'),'~'),'~');
		STRING t10		:= StringLib.StringFilterOut(StringLib.StringFindReplace(TRIM(t9,LEFT,RIGHT),';',' '),'%"#:)*]~^.\\<>');
		STRING t11	:= REGEXREPLACE('^-+(?!$)',REGEXREPLACE('(?!$)-+$',trim(REGEXREPLACE('([0-9]{6,})',TRIM(t10,LEFT,RIGHT),' '),LEFT,RIGHT),' '),' ');
		STRING t12	:= StringLib.StringFindReplace(REGEXREPLACE('^0+(?!$)',trim(t11,LEFT,RIGHT),' '),'-,',',');
		STRING t13	:= StringLib.StringCleanSpaces(lib_word.striptail(TRIM(lib_word.striptail(lib_word.striptail(StringLib.StringFindReplace(TRIM(t12,LEFT,RIGHT),' - ','-'),'-'),'('),LEFT,RIGHT),','));
		SET OF STRING t14 := StringLib.SplitWords(TRIM(StringLib.StringFindReplace(StringLib.StringFindReplace(t13,'-,','-'),',-',','),LEFT,RIGHT),' ',FALSE);
		t15 := SET(DEDUP(DATASET(t14,{STRING lotnb})),lotnb);
		STRING t16	:= StringLib.CombineWords(t15,',');
		STRING20 outlot := TRIM(t16,LEFT,RIGHT);
		RETURN OutLot;
	END;
	 
	EXPORT ExtractUnit (RecordOf(ln_propertyv2.File_Assessment) In_Rec) := FUNCTION // https://bugzilla.seisint.com/show_bug.cgi?id=161068
		UnitDelim := '\\bAPTS? NU?O?M?B?E?R?\\.? *#?([0-9A-Z-]*)\\b|\\bAPTS? *#? ?([0-9A-Z-]*)\\b|\\bUNI?TS? NU?O?M?B?E?R?\\.? *([0-9A-Z-]*)\\b|\\bUNI?TS?-? *#? ?([0-9A-Z-]*)\\b';
		//stANDardized_lAND_use_code
		luse_set  := ['102',  //F-TOWNHOUSE/ROWHOUSE            
									'103',  //F-APARTMENT/HOTEL               
									'106',  //F-APARTMENT
									'112',  //F-CONDOMINIUM
									'113',  //F-CONDOMINIUM PROJECT       
									'115',  //F-DUPLEX
									'116',  //F-MID RISE CONDO
									'117',  //F-HIGH RISE CONDO
									'131',  //F-MULTI FAMILY 10 UNITS PLUS
									'132',  //F-MULTI FAMILY 10 UNITS LESS
									'133',  //F-MULTI FAMILY DWELLING
									'134',  //F-MIXED COMPLEX
									'151',  //F-QUADRUPLEX 
									'165',  //F-TRIPLEX
									'1002', //O-TOWNHOUSE
									'1003', //O-CLUSTER HOME
									'1004', //O-CONDOMINIUM
									'1005', //O-COOPERATIVE
									'1100', //O-RESIDENTIAL INCOME (GENERAL) (MULTI-FAMILY)
									'1101', //O-DUPLEX (2 UNITS, ANY COMBINATION)
									'1102', //O-TRIPLEX (3 UNITS, ANY COMBINATION)
									'1103', //O-QUADRUPLEX (4 UNITS, ANY COMBINATION)
									'1104', //O-APARTMENT HOUSE (5+ UNITS)
									'1105', //O-APARTMENT HOUSE (100+ UNITS)
									'1106', //O-GARDEN APARTMENTS (5+ UNITS)
									'1107', //O-HIGHRISE APARTMENTS
									'1110', //O-MULTI-FAMILY DWELLINGS (2+ UNITS)
									'1112', //O-APARTMENTS (GENERIC)
									'1114', //O-RESIDENTIAL CONDOMINIUM DEVELOPMENT
									'2042', //O-STORES & APARTMENTS
									'2043', //O-COMMERCIAL BUILDING/WAREHOUSE, MAIL ORDER, SHOW ROOM(NON-AUTO)
									'2044', //O-COMM/RES MIXED USE
									'3001', //O-PROFESSIONAL BLDG (LEGAL, INSURANCE, REAL ESTATE)
									'3002', //O-PROFESSIONAL BLDG (MULTI-STORY)
									'3003', //O-OFFICE BLDG (GENERAL)
									'3004', //O-OFFICE BLDG (MULTI-STORY)
									'3005', //O-DENTAL BLDG
									'3006', //O-MEDICAL BLDG
									'3007', //O-FINANCIAL BLDG (BANK; S&L; MTGE; LOAN; CREDIT)
									'3008', //O-CONDOMINIUM OFFICES
									'3009', //O-SKYSCRAPER (HIGHRISE)
									'3010', //O-MIXED USE (COMM/IND)
									'5013', //O-MULTI-TENANT INDUSTRIAL BLDG
									'5018'];//O-INDUSTRIAL LOFT BUILDING

		//Other_Buildings1_Code (building improvement code/amenities)
		bic_set 	:= ['C0C',  //F-APARTMENT COMMERCIAL          
									'C0Q',  //COMMERCIAL CONDO              
									'C6L',  //OFFICE LOW RISE               
									'C6Q',  //OFFICE CONDO                  
									'C6W',  //OFFICE HI RISE                
									'CNQ',  //RETAIL CONDO                  
									'M00',  //MULTI FAMILY                  
									'M02',  //TWO FAMILY                    
									'M03',  //THREE FAMILY                  
									'M04',  //FOUR FAMILY                   
									'M05',  //FIVE FAMILY                   
									'M06',  //SIX FAMILY                    
									'M07',  //SEVEN FAMILY                  
									'M08',  //EIGHT FAMILY                  
									'M09',  //NINE FAMILY                   
									'M0A',  //MULTI FAMILY HI RISE          
									'M0B',  //MULTI FAMILY LOW RISE         
									'M0L',  //MID RISE                      
									'M0M',  //MULTI-PLEX                    
									'M0P',  //COOP                          
									'M0T',  //MULTI FAMILY TOWNHOUSE        
									'M40',  //4-PLEX                        
									'M50',  //5-PLEX                        
									'M51',  //5-PLEX AND HIGHER             
									'M60',  //6-PLEX                        
									'M80',  //8-PLEX                        
									'M90',  //9-PLEX                        
									'MA0',  //APARTMENT                     
									'MAA',  //APARTMENT HI RISE             
									'MAB',  //APARTMENT LOW RISE            
									'MAC',  //APARTMENT CONDO               
									'MAH',  //APARTMENT GARDEN              
									'MAJ',  //APARTMENT GARAGE              
									'MAK',  //APARTMENT HOTEL               
									'MAL',  //APARTMENT MID RISE            
									'MAO',  //APARTMENT & OFFICE            
									'MAP',  //APARTMENT COOP                
									'MAR',  //F-APARTMENT RETIREMENT          
									'MAS',  //APARTMENT SENIOR              
									'MAT',  //APARTMENT TOWNHOUSE           
									'MC0',  //MULTI FAMILY CONDO            
									'MCA',  //CONDO HI RISE                 
									'MCB',  //CONDO LOW RISE                
									'MCE',  //CONDO APARTMENT               
									'MCH',  //CONDO GARDEN                  
									'MCM',  //CONDO-MULTIPLEX               
									'MCO',  //CONDO OFFICE                  
									'MCT',  //CONDO TOWNHOUSE               
									'MCU',  //CONDO PENTHOUSE               
									'MCV',  //CONDO COMMON AREA W. IMPRVMT  
									'MCW',  //CONDO COMMERCIAL & OPEN SPACE 
									'MD0',  //DUPLEX                        
									'MDC',  //DUPLEX CONDO                  
									'MDE',  //DUPLEX APARTMENT              
									'MDF',  //DUPLEX/TRIPLEX                
									'MT0',  //TRIPLEX                       
									'R0C',  //RESIDENTIAL CONDO             
									'R60',  //HIGH-RISE                     
									'RT0',  //TOWNHOUSE                     
									'YDA',  //CONDO & SINGLE FAMILY RESIDENC
									'YQR',  //APARTMENTS & RESIDENTIAL      
									'YSA']; //APARTMENT/STORE               

		//Style_Code (style/style)
		sty_set		:= ['CND',	//F-CONDOMINIUM
									'DUP',	//F-DUPLEX
									'HRI',	//F-HIGH RISE                     
									'LRI',	//F-LOW RISE                      
									'MLF',	//F-MULTI-FAMILY                  
									'MRI',	//F-MID RISE                      
									'QUA',	//F-QUADRAPLEX                    
									'TPX',	//F-TRIPLEX                       
									'TWN'];	//F-TOWNHOUSE                     
								
		//Document_Type (mortgage_deed_type/document_type)								
		doc_set		:= ['CN',	 //F-CONDOMINIUM DEED
									'CD']; //O-CONDOMINIUM DEED

		STRING t1 := 	IF(In_Rec.property_unit_number='' AND
										In_Rec.property_full_street_address<>'' AND
										(In_Rec.other_buildings1_code IN bic_set OR
										In_Rec.style_code IN sty_set OR
										In_Rec.document_type IN doc_set OR
										In_Rec.standardized_land_use_code IN luse_set),In_Rec.legal_brief_description,'');
		STRING t2 :=	IF(In_Rec.STATE_CODE='AZ',REGEXREPLACE('SUN CITY UNIT',REGEXREPLACE('SUN CITY WEST UNIT',t1,' '),' '),t1);
		STRING t3 :=	IF(TRIM(REGEXFIND(UnitDelim,t2,1),LEFT,RIGHT)<>'',TRIM(REGEXFIND(UnitDelim,t2,1),LEFT,RIGHT),
										IF(TRIM(REGEXFIND(UnitDelim,t2,2),LEFT,RIGHT)<>'',TRIM(REGEXFIND(UnitDelim,t2,2),LEFT,RIGHT),
											IF(TRIM(REGEXFIND(UnitDelim,t2,3),LEFT,RIGHT)<>'',TRIM(REGEXFIND(UnitDelim,t2,3),LEFT,RIGHT),
												IF(TRIM(REGEXFIND(UnitDelim,t2,4),LEFT,RIGHT)<>'',TRIM(REGEXFIND(UnitDelim,t2,4),LEFT,RIGHT),''))));
		STRING t4	:= REGEXREPLACE('ALL',REGEXREPLACE('APT',REGEXREPLACE('HSE',REGEXREPLACE('LOT',REGEXREPLACE('([A-Z]{3,}$)',t3,' '),' '),' '),' '),' ');
		STRING t5	:= REGEXREPLACE('^0+(?!$)',REGEXREPLACE('^-+(?!$)',REGEXREPLACE('(?!$)-+$',TRIM(REGEXREPLACE('OF',t4,' '),LEFT,RIGHT),' '),' '),' ');
		STRING6 OutUnit := IF(LENGTH(trim(t5,left,right))>6,trim(StringLib.StringFilterOut(t5,'-'),left,right),trim(t5,left,right));
		RETURN OutUnit;
	END;
	 
	EXPORT ExtractExempt (RecordOf(ln_propertyv2.File_Assessment) In_Rec) := FUNCTION // https://bugzilla.seisint.com/show_bug.cgi?id=161068
		sluc_set	:= ['601',		//F-TAX EXEMPT                    
									'9000',		//O-EXEMPT (FULL OR PARTIAL)
									'9209',		//O-OTHER EXEMPT PROPERTY
									'9210',		//O-CITY, MUNICIPAL, TOWN, VILLAGE OWNED (EXEMPT)
									'9211',		//O-COUNTY OWNED (EXEMPT)
									'9212',		//O-STATE OWNED (EXEMPT)
									'9213',		//O-FEDERAL PROPERTY (EXEMPT)
									'9214',		//O-PUBLIC HEALTH CARE FACILITY (EXEMPT)
									'9215'];	//O-COMMUNITY CENTER (EXEMPT)	

		STRING1 derived_exempt := IF(In_Rec.stANDardized_lAND_use_code IN sluc_set OR 
																(REGEXFIND('EXEMPT',In_Rec.assessee_name) AND 
																REGEXFIND('NON[- ]?EXEMPT',In_Rec.assessee_name,0)='') OR
																(REGEXFIND('EXEMPT',In_Rec.second_assessee_name) AND
																REGEXFIND('NON[- ]?EXEMPT',In_Rec.second_assessee_name,0)='') OR
																(REGEXFIND('EXEMPT',In_Rec.county_lAND_use_description) AND 
																REGEXFIND('NON[- ]?EXEMPT',In_Rec.county_lAND_use_description,0)=''),'Y','');
		RETURN derived_exempt;
	END;
	
	EXPORT ExtractVeteran (RecordOf(ln_propertyv2.File_Assessment) In_Rec) := FUNCTION // https://bugzilla.seisint.com/show_bug.cgi?id=161068
		STRING1 derived_veteran := IF(In_Rec.assessee_name<>'' AND 
																	In_Rec.second_assessee_name='' AND 
																	REGEXFIND('\\S* \\S*[,&] \\S*|\\S* \\S* AND \\S*',In_Rec.assessee_name,0)='' AND
																	In_Rec.assessee_relationship_code not in ['GV','CO'] AND
																	In_Rec.assessee_ownership_rights_code not in ['FM','IR','JT','JS','LV','RT','TR'] AND
																	((REGEXFIND('VETERAN',In_Rec.county_lAND_use_description) AND REGEXFIND('DISABLED|EXEMPT',In_Rec.county_lAND_use_description)) OR
																	(In_Rec.tax_exemption1_code='V' AND In_Rec.tax_exemption2_code<>'Z' AND In_Rec.tax_exemption3_code<>'Z' AND In_Rec.tax_exemption4_code<>'Z') OR
																	(In_Rec.tax_exemption2_code='V' AND In_Rec.tax_exemption1_code<>'Z' AND In_Rec.tax_exemption3_code<>'Z' AND In_Rec.tax_exemption4_code<>'Z') OR
																	(In_Rec.tax_exemption3_code='V' AND In_Rec.tax_exemption1_code<>'Z' AND In_Rec.tax_exemption2_code<>'Z' AND In_Rec.tax_exemption4_code<>'Z') OR 
																	(In_Rec.tax_exemption4_code='V' AND In_Rec.tax_exemption1_code<>'Z' AND In_Rec.tax_exemption2_code<>'Z' AND In_Rec.tax_exemption3_code<>'Z')),'1',
																	IF(REGEXFIND('\\S* \\S*[,&] \\S*|\\S* \\S* AND \\S*',In_Rec.assessee_name,0)='' AND
																			REGEXFIND('\\S* \\S*[,&] \\S*|\\S* \\S* AND \\S*',In_Rec.second_assessee_name,0)='' AND
																			In_Rec.assessee_relationship_code not in ['GV','CO'] AND
																			REGEXFIND('VETERAN',In_Rec.assessee_name) AND 
																			REGEXFIND('EXEMPT',In_Rec.assessee_name),'1',
																			IF(REGEXFIND('\\S* \\S*[,&] \\S*|\\S* \\S* AND \\S*',In_Rec.second_assessee_name,0)='' AND
																					REGEXFIND('\\S* \\S*[,&] \\S*|\\S* \\S* AND \\S*',In_Rec.assessee_name,0)='' AND
																					In_Rec.assessee_relationship_code not in ['GV','CO'] AND
																					REGEXFIND('VETERAN',In_Rec.second_assessee_name) AND 
																					REGEXFIND('EXEMPT',In_Rec.second_assessee_name),'2','')));
		RETURN derived_veteran;
	END;

	EXPORT ExtractCondo (RecordOf(ln_propertyv2.File_Assessment) In_Rec) := FUNCTION // https://bugzilla.seisint.com/show_bug.cgi?id=161068
		//StANDard_LAND_Use_Code	(lAND use/stANDardized_lAND_use)
		sluc_set	:= ['112',		//F-CONDOMINIUM
									'113',		//F-CONDOMINIUM PROJECT
									'1114',		//O-RESIDENTIAL CONDOMINIUM DEVELOPMENT
									'1004'];	//O-CONDOMINIUM

		//Other_Buildings1_Code (building improvement code/amenities)
		bic_set		:= ['MCA',		//F-CONDO HI RISE                  
									'MCB',		//F-CONDO LOW RISE                 
									'MCE',		//F-CONDO APARTMENT                
									'MCH',		//F-CONDO GARDEN                   
									'MCT',		//F-CONDO TOWNHOUSE                
									'MCU'];		//F-CONDO PENTHOUSE   

		//Style_Code (style/style)
		sty_set		:= ['CND'];		//F-CONDOMINIUM

		//Document_Type (mortgage_deed_type/document_type)								
		doc_set		:= ['CN',			//F-CONDOMINIUM DEED
									'CD'];		//O-CONDOMINIUM DEED

		STRING1 derived_condo := IF((In_Rec.stANDardized_lAND_use_code IN sluc_set OR
																In_Rec.other_buildings1_code IN bic_set OR 
																In_Rec.style_code IN sty_set OR 
																REGEXFIND(' CNDO| CONDO | CONDOMIN', In_Rec.assessee_name) OR
																REGEXFIND(' CNDO| CONDO | CONDOMIN', In_Rec.legal_brief_description) OR 
																REGEXFIND(' CNDO| CONDO | CONDOMIN', In_Rec.legal_subdivision_name) OR	
																REGEXFIND(' CNDO| CONDO | CONDOMIN', In_Rec.legal_assessor_map_ref) OR
																REGEXFIND(' CNDO| CONDO | CONDOMIN', In_Rec.county_lAND_use_description) OR
																REGEXFIND(' CNDO| CONDO | CONDOMIN', In_Rec.document_type) OR
																In_Rec.document_type IN doc_set) AND
																(REGEXFIND(' NOT CONDO', In_Rec.assessee_name,0)='' AND
																REGEXFIND(' NOT CONDO', In_Rec.legal_brief_description,0)='' AND
																REGEXFIND(' NOT CONDO', In_Rec.legal_subdivision_name,0)='' AND
																REGEXFIND(' NOT CONDO', In_Rec.legal_assessor_map_ref,0)='' AND
																REGEXFIND(' NOT CONDO', In_Rec.county_lAND_use_description,0)='' AND
																REGEXFIND(' NOT CONDO', In_Rec.document_type,0)=''),'Y','');
																
		RETURN derived_condo;
	END;

	EXPORT ExtractMH (RecordOf(ln_propertyv2.File_Assessment) In_Rec) := FUNCTION // https://bugzilla.seisint.com/show_bug.cgi?id=161068
		//StANDard_LAND_Use_Code	(lAND use/stANDardized_lAND_use)
		sluc_set	:= ['135',		//F-MOBILE HOME
									'136',		//F-MOBILE HOME PARK
									'137',		//F-MOBILE HOME
									'138',		//F-MANUFACTURED HOME
									'1006',		//O-MOBILE HOME
									'1016',		//O-MANUFACTURED, MODULAR, PRE-FABRICATED HOMES
									'1109'];	//O-MOBILE HOME PARK

		//Other_Buildings1_Code (building improvement code/amenities)
		bic_set		:= ['RM0',		//F-MOBILE HOME
									'RM1',		//F-MOBILE HOME SINGLE WIDE
									'RM2',		//F-MOBILE HOME DOUBLE WIDE
									'RMB',		//F-MOBILE HOME COOP
									'RMP',		//F-MOBILE HOME PARK
									'RMS',		//F-MOBILE HOME ROOM ADDITION
									'RSF',		//F-SINGLE FAMILY MANUFACTURED
									'R0F',		//F-MANUFACTURED HOME
									'2'];			//O-MOBILE HOME HOOKUP

		//Site_Influence1_Code (location influence/site influence)
		sic_set		:= ['IMH'];		//F-MOBILE HOME

		//Style_Code (style/style)
		sty_set		:= ['MOB',		//F-MOBILE HOME
									'P'];			//O-PREFAB,MODULAR

		STRING1 derived_MH := IF((In_Rec.assessed_improvement_value<>'' OR
															In_Rec.market_improvement_value<>'' OR
															In_Rec.homestead_homeowner_exemption<>'' OR
															In_Rec.building_area<>'' OR
															In_Rec.year_built<>'' OR
															In_Rec.no_of_buildings<>'' OR
															In_Rec.style_code<>'' OR
															In_Rec.building_class_code<>'' OR
															In_Rec.type_construction_code<>'' OR
															In_Rec.no_of_buildings<>'') AND
															(REGEXFIND('\\bMH | M HOME |MOBILE H|MOB HOME|MANUFACTURED ', In_Rec.legal_brief_description) OR
															REGEXFIND('\\bMH | M HOME |MOBILE H|MOB HOME|MANUFACTURED ', In_Rec.legal_subdivision_name) OR 
															REGEXFIND('MOBILE H', In_Rec.legal_assessor_map_ref) OR
															REGEXFIND('MOBILE H|MANUFACTURED', In_Rec.county_lAND_use_description) OR
															REGEXFIND('MOBILE H', In_Rec.document_type) OR
															In_Rec.stANDardized_lAND_use_code IN sluc_set OR
															In_Rec.other_buildings1_code IN bic_set OR 
															In_Rec.site_influence1_code IN sic_set OR 
															In_Rec.style_code IN sty_set OR 
															(In_Rec.record_type_code = 'MH' AND In_Rec.vendor_source_flag='O')),'Y','');
		RETURN derived_MH;
	END;

	EXPORT ExtractLuseCat (RecordOf(ln_propertyv2.File_Assessment) In_Rec) := FUNCTION // https://bugzilla.seisint.com/show_bug.cgi?id=161068
		sluc_comm_set := [//COMMERCIAL
											'1011', 	//RESIDENTIAL TIMESHARE
											'103',		//APARTMENT/HOTEL
											'106', 		//APARTMENT
											'1100', 	//RESIDENTIAL INCOME (GENERAL) (MULTI-FAMILY)
											'1104', 	//APARTMENT HOUSE (5+ UNITS)
											'1106', 	//GARDEN APARTMENTS (5+ UNITS)
											'1107', 	//HIGHRISE APARTMENTS
											'1108', 	//BOARDING HOUSE, ROOMING HOUSE, APT HOTEL, TRANSIENT LODGINGS
											'1112', 	//APARTMENTS (GENERIC)
											'127', 		//HOTEL
											'130',		//RESORT HOTEL
											'134',		//MIXED COMPLEX
											'142', 		//MOTEL
											'157', 		//NURSING HOME
											'164',		//TRANSIENT LODGING
											'167', 		//TIME SHARE
											'199', 		//TIME SHARE CONDO
											'200', 		//COMMERCIAL (NEC)
											'2000', 	//COMMERCIAL (GENERAL)
											'2001', 	//RETAIL STORES (PERSONAL SERVICES, PHOTOGRAPHY, TRAVEL)
											'2002', 	//STORE (MULTI-STORY)
											'2003', 	//STORE/OFFICE COMBO
											'2004', 	//DEPARTMENT STORE (APPAREL, HOUSEHOLD GOODS, FURNITURE)
											'2005', 	//DEPARTMENT STORE (MULTI-STORY)
											'2006', 	//GROCERY (SUPERMARKET)
											'2007', 	//SHOPPING CENTER (REGIONAL, MALL, W/ANCHOR)
											'2008', 	//SHOPPING CENTER (COMMUNITY - OPEN PLAZA)
											'2009', 	//SHOPPING CENTER (NEIGHBORHOOD - STRIP)
											'2010', 	//SHOPPING CENTER COMMON AREA (PARKING, ETC.)
											'2011', 	//VETERINARY/ANIMAL HOSPITAL
											'2012', 	//RESTAURANT
											'2013', 	//FAST FOOD/DRIVE-THRU
											'2014', 	//FOOD PREPARATION (TAKE OUT)
											'2015', 	//BAKERY
											'2016', 	//BAR / TAVERN
											'2017', 	//LIQUOR STORE
											'2018', 	//CONVENIENCE STORE (7-11)
											'202',		//MULTIPLE USES                 
											'2019', 	//CONVENIENCE STORE (WITH FUEL PUMP)
											'2020', 	//SERVICE STATION (FULL SERVICE)
											'2021', 	//SERVICE STATION WITH CONVENIENCE STORE/FOOD MART
											'2022', 	//TRUCK STOP
											'2023', 	//VEHICLE SALES/RENTAL (AUTO; TRUCK; RV; BOAT; ETC.)
											'2024', 	//GARAGE/AUTO REPAIR & RELATED
											'2025', 	//CAR WASH
											'2026', 	//DRY CLEANER (LAUNDRY)
											'2027', 	//SERVICE SHOP (TV; RADIO; ELECTRIC; PLUMBING)
											'2028', 	//NURSERY/GREENHOUSE (RETAIL/WHOLESALE)
											'2029', 	//WHOLESALE OUTLET, DISCOUNT STORE (FRANCHISE)
											'203',		//AUTO EQUIPMENT                
											'2030', 	//PRINTER (RETAIL)
											'2031', 	//STORAGE (MINI-WAREHOUSE)
											'2032', 	//PRE-SCHOOL/DAY CARE (PRIVATE)
											'2033', 	//MOTEL
											'2034', 	//HOTEL
											'2035', 	//PARKING GARAGE
											'2036', 	//PARKING LOT
											'2037', 	//FUNERAL HOME (MORTUARY)
											'2038', 	//CASINO
											'2039', 	//HOTEL-RESORT
											'204', 		//AUTO REPAIR
											'2040', 	//HOTEL/MOTEL
											'2041', 	//GAS STATION
											'2042', 	//STORES & APARTMENTS
											'2043', 	//COMMERCIAL BUILDING/WAREHOUSE, MAIL ORDER, SHOW ROOM(NON-AUTO)
											'2044', 	//COMM/RES MIXED USE
											'2045', 	//APPLIANCE STORE
											'2046', 	//KENNEL
											'2047', 	//LAUNDROMAT (SELF-SERVICE)
											'2048', 	//NIGHTCLUB (COCKTAIL LOUNGE)
											'205',		//AUTO SALES
											'2050',		//FARM SUPPLY & EQUIPMENT
											'2051',		//HOME IMPROVEMENT, GARDEN CENTER
											'2052',		//COMMERCIAL CONDO (NOT OFC)
											'2053',		//DRUG STORE/PHARMACY
											'2054',		//BED & BREAKFAST
											'207', 		//SALVAGE IMPRV                 
											'208', 		//AUTO WRECKING                 
											'209', 		//BUSINESS PARK                 
											'210', 		//CARWASH                       
											'211', 		//COMMERCIAL BUILDING
											'213', 		//COMMERCIAL CONDOMINIUM
											'217', 		//DEPARTMENT STORE              
											'220', 		//STORE FRANCHISE               
											'221', 		//FAST FOOD FRANCHISE
											'222', 		//FIN/INSURANCE/REAL ESTATE     
											'223', 		//FINANCIAL BUILDING
											'225', 		//FUNERAL HOME                  
											'226', 		//GARAGE
											'230',		//HOSPITAL                      
											'235',		//ANIMAL HOSPITAL/VET           
											'237', 		//MEDICAL BUILDING
											'238',		//MEDICAL CONDO                 
											'239',		//LABORATORY                    
											'240',		//LAUNDROMAT                    
											'242',		//NIGHTCLUB                     
											'243', 		//BAR
											'244', 		//OFFICE BUILDING
											'245', 		//OFFICE & RESIDENTIAL
											'246',		//OFFICE & SHOWROOM             
											'247', 		//OFFICE CONDO
											'257',		//PRODUCE MARKET                
											'258',		//PUBLIC STORAGE                
											'261', 		//RESTAURANT BUILDING
											'262', 		//RESTAURANT DRIVE IN
											'266', 		//SERVICE STATION
											'268',		//SERVICE STATION/MARKET        
											'269', 		//MISC COMMERCIAL SERVICES
											'270', 		//SHOPPING CENTER
											'273', 		//STRIP COMMERCIAL CENTER
											'276',		//APPAREL                       
											'278', 		//STORE BUILDING
											'279', 		//STORES & OFFICES
											'282', 		//RETAIL TRADE
											'283', 		//SUPERMARKET
											'284', 		//FOOD STORES
											'285',		//TAVERN                        
											'286',		//WHOLESALE                     
											'3000', 	//COMMERCIAL OFFICE (GENERAL)
											'3001', 	//PROFESSIONAL BLDG (LEGAL, INSURANCE, REAL ESTATE)
											'3002',		//PROFESSIONAL BLDG (MULTI-STORY)
											'3003', 	//OFFICE BLDG (GENERAL)
											'3004', 	//OFFICE BLDG (MULTI-STORY)
											'3005',		//DENTAL BLDG
											'3006', 	//MEDICAL BLDG
											'3007', 	//FINANCIAL BLDG (BANK; S&L; MTGE; LOAN; CREDIT)
											'3008', 	//CONDOMINIUM OFFICES
											'3012',		//MOBILE COMMERCIAL UNITS
											'4004',		//BOWLING ALLEY
											'4005',		//ARCADES
											'4006',		//SKATING RINK (ICE, ROLLER)
											'415', 		//COMMERCIAL ACREAGE
											'420', 		//COMMERCIAL LOT
											'4020',		//THEATER (MOVIE AND LEGITIMATE)
											'4021',		//THEATER (DRIVE-IN)
											'4022',		//AMUSEMENT PARK
											'430', 		//AGRICULTURAL LAND
											'4031',		//MINIATURE GOLF, GO-CARTS, WATER SLIDES
											'501',		//LIVESTOCK
											'509',		//RANCH
											'511',		//FARMS                         
											'515',		//DAIRY FARM
											'550',		//ORCHARD
											'570',		//TRUCK CROPS                   
											'575',		//VINEYARD
											'7001',		//FARM (IRRIGATED OR DRY)
											'7002',		//RANCH
											'7004',		//CROP LAND/FIELD CROPS/ROW CROPS (ALL SOIL CLASSES)
											'7005',		//ORCHARD (FRUIT; NUT)
											'7006',		//VINEYARD
											'7008',		//DAIRY
											'7016',		//LIVESTOCK
											'8002',		//COMMERCIAL VACANT
											'8008'];	//AGRICULTURAL-UNIMPROVED VACANT

		sluc_inds_set := [//INDUSTRIAL
											'300',		//INDUSTRIAL (NEC)              
											'301',		//COMMERCIAL/INDUSTRIAL         
											'302',		//BREWERY                       
											'303',		//BULK PLANT                    
											'304',		//CANNERY                       
											'308',		//CHEMICAL                      
											'309',		//TEXTILE/CLOTHES/CARPET INDUST 
											'310',		//PAPER & ALLIED INDUSTRY       
											'311',		//DUMP SITE                     
											'312',		//DURABLE GOODS                 
											'313',		//NON DURABLE GOODS             
											'316',		//FOOD PROCESSING               
											'318',		//GRAIN ELEVATOR                
											'320',		//HEAVY INDUSTRIAL              
											'321',		//INDUSTRIAL CONDOMINIUM        
											'322',		//INDUSTRIAL PARK               
											'323',		//INDUSTRIAL PLANT              
											'324',		//LIGHT INDUSTRIAL              
											'326',		//LUMBER YARD                   
											'328',		//LUMBER MILL                   
											'331',		//METAL PRODUCT                 
											'333',		//MINERAL RIGHTS                
											'334',		//MINERAL PROCESSING            
											'336',		//MINI WAREHOUSE                
											'338',		//MULTI TENANT INDUSTRIAL       
											'342',		//PACKING                       
											'344',		//PETROLEUM                     
											'349',		//MINE/QUARRY                   
											'352',		//R&D FACILITY                  
											'353',		//TECHNOLOGICAL INDUSTRY        
											'354',		//SHIPYARD                      
											'356',		//STOCKYARD                     
											'358',		//STORAGE                       
											'361',		//STORAGE TANKS                 
											'364',		//WAREHOUSE                     
											'366',		//WINERY                        
											'399',		//WINERY II                     
											'5000',		//INDUSTRIAL (GENERAL)
											'5001',		//MANUFACTURING (LIGHT)
											'5002',		//LIGHT INDUSTRIAL (10% IMPROVED OFFICE SPACE, MACHINE SHOP)
											'5003',		//WAREHOUSE
											'5004',		//STORAGE YARD (LIGHT EQUIPMENT/MATERIAL)
											'5005',		//PACKING PLANT (FRUIT; VEGETABLE; MEAT; DAIRY)
											'5006',		//ASSEMBLY (LIGHT)
											'5007',		//FOOD PROCESSING (CANDY; BAKERY; POTATO CHIPS)
											'5008',		//RECYCLING (METAL; PAPER; GLASS; ETC.)
											'5009',		//COMMUNICATION
											'5010',		//INDUSTRIAL CONDO
											'5011',		//R&D FACILITY (LABORATORY, RESEARCH)
											'5012',		//INDUSTRIAL PARK
											'5013',		//MULTI-TENANT INDUSTRIAL BLDG
											'5014',		//MARINE FACILITY/BOAT REPAIRS (SMALL CRAFT OR SAILBOAT)
											'5015',		//LUMBER & WOOD PRODUCT MFG (INCLUDING FURNITURE)
											'5016',		//PAPER PRODUCT MFG & RELATED PRODUCTS
											'5017',		//PRINTING & PUBLISHING
											'5018',		//INDUSTRIAL LOFT BUILDING
											'5019',		//CONTRACTING SERVICES
											'5020',		//INDUSTRIAL, COMMON AREA
											'6000',		//HEAVY INDUSTRIAL (GENERAL)
											'6001',		//TRANSPORTATION (ALSO SEE 6500 SERIES)
											'6002',		//DISTRIBUTION (INDUSTRIAL SALES)
											'6003',		//MINING (OIL; GAS; MINERAL)
											'6004',		//STORAGE YARD (JUNK; AUTO WRECKING; SALVAGE)
											'6005',		//DISTILLERY, BREWERY, BOTTLING
											'6006',		//REFINERY, PETROLEUM PRODUCTS
											'6007',		//MILL (FEED; GRAIN; PAPER; LUMBER; TEXTILE)
											'6008',		//FACTORY (APPAREL, TEXTILE PRODUCTS)
											'6009',		//PROCESSING PLANT (MINERALS; CEMENT; ROCK; GRAVEL)
											'6010',		//LUMBERYARD, BUILDING MATERIALS
											'6011',		//SHIPYARD/STORAGE - BUILT OR REPAIRED (SEAGOING VESSELS)
											'6012',		//STOCKYARD
											'6013',		//WASTE DISPOSAL, SEWAGE (PROCESSING, DISPOSAL, STORAGE, TREATMENT)
											'6014',		//QUARRIES (SAND; GRAVEL; ROCK)
											'6015',		//HEAVY MANUFACTURING
											'6016',		//LABOR CAMPS
											'6017',		//WINERY
											'6018',		//CHEMICAL
											'6019',		//INDUSTRIAL PLANT (METAL, RUBBER, PLASTIC)
											'6020',		//CANNERY
											'6021',		//TANKS/BULK STORAGE (GASOLINE, FUEL, ETC.)
											'6022',		//GRAIN ELEVATOR
											'6023',		//DUMP SITE
											'6024',		//COLD STORAGE
											'6025',		//SUGAR REFINERY
											'6500',		//TRANSPORTATION & COMMUNICATIONS, UTILITIES (GENERAL)
											'6501',		//AIRPORT AND RELATED
											'6502',		//RAILROAD AND RELATED
											'6503',		//STATE HWYS/FREEWAYS
											'6504',		//ROADS/STREETS
											'6505',		//BUS TERMINAL
											'6506',		//TELEPHONE, TELEGRAPH
											'6507',		//RADIO OR TV STATION
											'6508',		//TRUCK TERMINAL (MOTOR FREIGHT)
											'6509',		//CABLE TV STATION
											'6510',		//HARBOR & MARINE TRANSPORTATION
											'6511',		//MICROWAVE TRANSMISSION
											'6512',		//COMMERICAL AUTO TRANSPORTATION/STORAGE
											'6513'];	//POLLUTION CONTROL

		sluc_resd_set := [//RESIDENTIAL      
											'100', 		//RESIDENTIAL (NEC)
											'1000', 	//RESIDENTIAL (GENERAL) (SINGLE FAMILY)
											'1001', 	//SINGLE FAMILY RESIDENTIAL
											'1002', 	//TOWNHOUSE
											'1004', 	//CONDOMINIUM
											'1005', 	//COOPERATIVE
											'1006', 	//MOBILE HOME
											'1007', 	//ROW HOUSE
											'1008', 	//RURAL RESIDENCE (AGRICULTURAL)
											'1012', 	//CABIN
											'1013', 	//BUNGALOW
											'1016', 	//MANUFACTURED, MODULAR, PRE-FABRICATED HOMES
											'102', 		//TOWNHOUSE/ROWHOUSE
											'109', 		//CABIN
											'111',		//COOPERATIVE
											'1101', 	//DUPLEX (2 UNITS, ANY COMBINATION)
											'1102', 	//TRIPLEX (3 UNITS, ANY COMBINATION)
											'1103', 	//QUADRUPLEX (4 UNITS, ANY COMBINATION)
											'1109', 	//MOBILE HOME PARK
											'1110', 	//MULTI-FAMILY DWELLINGS (2+ UNITS)
											'1114', 	//RESIDENTIAL CONDOMINIUM DEVELOPMENT
											'112', 		//CONDOMINIUM
											'115', 		//DUPLEX
											'116', 		//MID RISE CONDO
											'117', 		//HIGH RISE CONDO
											'131',		//MULTI FAMILY 10 UNITS PLUS
											'132',		//MULTI FAMILY 10 UNITS LESS
											'133',		//MULTI FAMILY DWELLING
											'135', 		//MOBILE HOME LOT
											'136', 		//MOBILE HOME PARK
											'137', 		//MOBILE HOME
											'138', 		//MANUFACTURED HOME
											'148',		//PUD                           
											'151',		//QUADRUPLEX
											'160', 		//RURAL HOMESITE
											'163', 		//SFR
											'165', 		//TRIPLEX
											'1999', 	//Presumed Residential  
											'450',		//MULTI FAMILY ACREAGE          
											'452',		//MULTI FAMILY LOT              
											'454',		//VACANT MOBILE HOME            
											'460', 		//RESIDENTIAL ACREAGE
											'465', 		//RESIDENTIAL LOT
											'8001',		//RESIDENTIAL VACANT
											'8007',		//MULTI-FAMILY VACANT
											'264']; 	//SFR
	
		sluc_govt_set := [//GOVERNMENT
											'602',		//STATE PROPERTY
											'603',		//COUNTY PROPERTY
											'604',		//MUNICIPAL PROPERTY
											'605',		//POLICE/FIRE/CIVIL DEFENSE
											'606',		//US POSTAL SERVICE
											'614',		//FEDERAL PROPERTY
											'615',		//FEDERAL BUILDING
											'630',		//MILITARY BUILDING
											'880',		//UTILITIES
											'9200',		//GOVERNMENTAL/PUBLIC USE (GENERAL)
											'9201',		//MILITARY (OFFICE, BASE, POST, PORT, CAMP, RESERVE, WEAPON RANGE, TEST SITES)
											'9203',		//PUBLIC SCHOOL (ADMINISTRATION; CAMPUS; DORMS; INSTRUCTION)
											'9204',		//PUBLIC UNIVERSITY (COLLEGES)
											'9205',		//POST OFFICE
											'9207',		//ADMINISTRATIVE OFFICE (FEDERAL/STATE/LOCAL/COURT HOUSE)
											'9208',		//EMERGENCY (POLICE; FIRE; RESCUE; SHELTERS; ANIMAL SHELTER)
											'9210',		//CITY, MUNICIPAL, TOWN, VILLAGE OWNED (EXEMPT)
											'9211',		//COUNTY OWNED (EXEMPT)
											'9212',		//STATE OWNED (EXEMPT)
											'9213',		//FEDERAL PROPERTY (EXEMPT)
											'9216',		//PUBLIC UTILITY (ELECTRIC, WATER, GAS, ETC.)
											'9217'];	//WELFARE, SOCIAL SERVICE, LOW INCOME HOUSING (EXEMPT) (Low income housing in my opinion does not qualify for government)
	
		sluc_ignore_set := [//SFR to exclude commercial AND government selection
											'100', 		//RESIDENTIAL (NEC)
											'1000', 	//RESIDENTIAL (GENERAL) (SINGLE FAMILY)
											'1001', 	//SINGLE FAMILY RESIDENTIAL
											'163', 		//SFR
											'264', 		//SFR
											'415', 		//COMMERCIAL ACREAGE
											'420', 		//COMMERCIAL LOT
											'430', 		//AGRICULTURAL LAND
											'435', 		//INDUSTRIAL ACREAGE
											'440', 		//INDUSTRIAL LOT
											'450',		//MULTI FAMILY ACREAGE          
											'452',		//MULTI FAMILY LOT              
											'454',		//VACANT MOBILE HOME            
											'460', 		//RESIDENTIAL ACREAGE
											'465', 		//RESIDENTIAL LOT
											'8001',		//RESIDENTIAL VACANT
											'8002',		//COMMERCIAL VACANT
											'8003',		//INDUSTRIAL VACANT
											'8007',		//MULTI-FAMILY VACANT
											'8008'];	//AGRICULTURAL-UNIMPROVED VACANT

		sluc_unkn_set := ['998','999',''];
		
		STRING1 derived_Luse_Cat := IF((In_Rec.stANDardized_lAND_use_code in sluc_govt_set) OR
																	(In_Rec.stANDardized_lAND_use_code in sluc_unkn_set AND
																	(((REGEXFIND('GOVERNMENT LAND|U S GOVERNMENT|US GOVERNMENT|CITY OF |TOWN OF |VILLAGE OF |STATE OF |UNITED STATES| COUNTY ',In_Rec.assessee_name) AND
																	REGEXFIND('NOT AVAILABLE|NOT AVAIL |TRUST|\\(TE\\)',In_Rec.assessee_name,0)='') OR
																	In_Rec.assessee_relationship_code = 'GV' OR
																	REGEXFIND('GOVERNMENT LAND|GOV\'T LAND',In_Rec.legal_brief_description) OR
																	REGEXFIND('GOVERNMENT|GOV\'T',In_Rec.county_lAND_use_description) OR
																	REGEXFIND('GOVERNMENT',In_Rec.lot_size) OR
																	REGEXFIND('GOVERNMENT',In_Rec.zoning)) AND
																	REGEXFIND('BANK$|CO$|COMPANY|CORP$|INC$|LLC$|LP$|LTD$',TRIM(In_Rec.assessee_name,LEFT,RIGHT),0)='')),'G',
																	IF(In_Rec.stANDardized_lAND_use_code IN sluc_inds_set,'I',
																		IF((In_Rec.stANDardized_lAND_use_code in sluc_comm_set) OR
																			(In_Rec.stANDardized_lAND_use_code in sluc_unkn_set AND
																			In_Rec.assessee_relationship_code <> 'GV' AND
																			(In_Rec.assessee_relationship_code in ['CO','PA'] OR
																			REGEXFIND('COMMERCIAL',In_Rec.legal_brief_description) OR 
																			(REGEXFIND('COMMERCIAL',In_Rec.county_lAND_use_description) AND
																			REGEXFIND('VACANT',In_Rec.county_lAND_use_description,0)='') OR
																			REGEXFIND('COMMERCIAL',In_Rec.lot_size) OR
																			REGEXFIND('COMMERCIAL',In_Rec.zoning))),'C',
																			IF((In_Rec.stANDardized_lAND_use_code in sluc_resd_set) OR
																				(In_Rec.stANDardized_lAND_use_code in sluc_unkn_set AND
																				(REGEXFIND('RESIDENTIAL|RESID',In_Rec.legal_brief_description) OR 
																				 REGEXFIND('RESIDENCE|RESIDENTIAL',In_Rec.county_lAND_use_description) OR
																				 REGEXFIND('RESIDENTIAL|SINGLE FAM',In_Rec.lot_size) OR
																				 REGEXFIND('RESIDENCE|RESIDENTIAL|SINGLE FAM',In_Rec.zoning))),'R',''))));
		RETURN derived_Luse_Cat;
	END;
	
	EXPORT ExtractPropName (RecordOf(ln_propertyv2.File_Assessment) In_Rec) := FUNCTION
		sluc_set := [
								'100',	//F-RESIDENTIAL (NEC)
								'1000',	//O-RESIDENTIAL (GENERAL) (SINGLE FAMILY)
								'1001',	//O-SINGLE FAMILY RESIDENTIAL
								'1002',	//O-TOWNHOUSE
								'1004',	//O-CONDOMINIUM
								'1005',	//COOPERATIVE
								'1006',	//O-MOBILE HOME
								'1007',	//O-ROW HOUSE
								'1012',	//O-CABIN
								'1013',	//O-BUNGALOW
								'1016',	//O-MANUFACTURED, MODULAR, PRE-FABRICATED HOMES
								'102',	//F-TOWNHOUSE/ROWHOUSE
								'109',	//F-CABIN
								'1101',	//O-DUPLEX (2 UNITS, ANY COMBINATION)
								'1102',	//O-TRIPLEX (3 UNITS, ANY COMBINATION)
								'1103',	//O-QUADRUPLEX (4 UNITS, ANY COMBINATION)
								'1109',	//O-MOBILE HOME PARK
								'111',	//F-COOPERATIVE
								'1110',	//O-MULTI-FAMILY DWELLINGS (2+ UNITS)
								'1114',	//O-RESIDENTIAL CONDOMINIUM DEVELOPMENT
								'112',	//F-CONDOMINIUM
								'115',	//F-DUPLEX
								'116',	//F-MID RISE CONDO
								'117',	//F-HIGH RISE CONDO
								'131',	//F-MULTI FAMILY 10 UNITS PLUS
								'132',	//F-MULTI FAMILY 10 UNITS LESS
								'133',	//F-MULTI FAMILY DWELLING
								'135',	//F-MOBILE HOME LOT
								'136',	//F-MOBILE HOME PARK
								'137',	//F-MOBILE HOME
								'138',	//F-MANUFACTURED HOME
								'151',	//F-QUADRUPLEX
								'163',	//F-SFR
								'165',	//F-TRIPLEX
								'200',	//F-COMMERCIAL (NEC)
								'211',	//COMMERCIAL BUILDING
								'213',	//COMMERCIAL CONDOMINIUM
								'223',	//FINANCIAL BUILDING
								'237',	//MEDICAL BUILDING
								'238',	//MEDICAL CONDO
								'244',	//OFFICE BUILDING               
								'245',	//OFFICE & RESIDENTIAL          
								'246',	//OFFICE & SHOWROOM             
								'247',	//OFFICE CONDO                  
								'248',	//CONVERTED RESIDENCE           
								'264',	//F-SFR(?)
								'400',	//F-VACANT LAND (NEC)
								'465',	//F-RESIDENTIAL sub
								'8001',	//O-RESIDENTIAL VACANT
								'8000'	//O-VACANT (GENERAL)
								];
								
		issubdv  := '[ ^](SUBD | HOMES | S\\/D |(?=.{3})SUBD?I?V?I?S?I?O?N?: *(\\w+)|(\\w+ PHASE \\w+)'+
								'|(\\w+) +S UBDIV |(\\w+) +S\\/D|(\\w+) HEIGHTS|(\\w+) \\w+ CLUB |ADDN? |ADDN? TO (\\w+)\\b'+
								'|CLUB |ESTATES |HEIGHTS |HIGHLANDS |PHASE )|RANCHO |RANCHO \\w+|S UBDIV |SUB\\.? |SUBDIVISION '+
								'|VILL |\\D+? HIGHLANDS \\D+?|\\W+ ESTATES\\b|\\b(\\w+) +(?=.{3})SUBD?I?V?I?S?I?O?N?\\b'+
								'|\\b(\\w+) ADDN?\\b|\\b(\\w+) VILL\\b';
									
		selectsubdv(STRING ltext) := FUNCTION 
			SubdvDelim := [	'\\bAUDITORS (?=.{3})SUBD?I?V?I?S?I?O?N?\\.? ?N?O?U?M?B?E?R?\\.?#? ?[0-9]+\\b',
											'\\bSUBD?I?V?I?S?I?O?N?[:_] ?([\\w*\\s*]*) LO?TS?[:_]?',
											'\\bSUBD?I?V?I?S?I?O?N?[:_] ?([\\w*\\s*]*) BLO?C?K[:_]?',
											'\\bSUBD?I?V?I?S?I?O?N?[:_] ?([\\w*\\s*]*) UNIT',
											'\\bSUBD?I?V?I?S?I?O?N?[:_] ?([^\\*\\(\\),;:]*)',
											'\\(?,? ?([\\w*\\s&\\.]*?) (?=.{3})SUBD?I?V?I?S?I?O?N?\\)?\\b OF (?=.{3})SEE?C?T?I?O?N?\\b',
											'\\bSUBD?I?V?I?S?I?O?N? OF ([\\w*\\s*]*)\\b LO?TS?',
											'\\bSUBD?I?V?I?S?I?O?N? OF ([\\w*\\s*]*)\\b BLO?C?K',
											'\\bSUBD?I?V?I?S?I?O?N? OF ([^\\*\\(\\),;:]*)',
											'\\bBLO?C?K [0-9A-Z-]* OF ([\\w*\\s]*) (?=.{3})SUBD?I?V?I?S?I?O?N?\\b',
											'\\bBLO?C?K [0-9A-Z-]* OF ([\\w*\\s]*) S\\/D\\b',
											'\\bBLO?C?K [0-9A-Z-]* ([\\w*\\s]*) (?=.{3})SUBD?I?V?I?S?I?O?N?\\b',
											'\\bBLO?C?K [0-9A-Z-]* ([\\w*\\s]*) S\\/D\\b',
											'\\bLO?TS? [\\d* ?,?&?_?]* OF ([\\w*\\s]*) (?=.{3})SUBD?I?V?I?S?I?O?N?\\b',
											'\\bLO?TS? [\\d* ?,?&?_?]* OF ([\\w*\\s]*) S\\/D\\b',
											'\\bLO?TS? [\\d* ?,?&?_?]* ([\\w*\\s]*) (?=.{3})SUBD?I?V?I?S?I?O?N?\\b',
											'\\bLO?TS? [\\d* ?,?&?_?]* ([\\w*\\s]*) S\\/D\\b',
											'([^\\*\\(\\),;:=]*) (?=.{3})SUBD?I?V?I?S?I?O?N?\\)?\\b',
											'([^\\*\\(\\),;:=]*) S\\/D\\b',
											'\\b(ESTATES OF .*) UNIT',
											'\\b(ESTATES AT [^:,\\.\\/]+) LOTS?\\b',
											'\\b(ESTATES AT [^:,\\.\\/]+)',
											'\\b(ESTATES OF [^:,\\.\\/]+) LOTS?\\b',
											'\\b(ESTATES OF [^:,\\.\\/]+)',
											'([^\\*\\(\\),;:=]* VILLA [^\\*\\(\\),;:=]*)\\b',
											'\\b(T?H?E? ?VILL?A?G?E? AT [^:,\\.\\/]+) LOTS?\\b',
											'\\b(T?H?E? ?VILL?A?G?E? AT [^:,\\.\\/]+)',
											'\\b(T?H?E? ?VILL?A?G?E? OF[^:,\\.\\/]+) LOTS?\\b',
											'\\b(T?H?E? ?VILL?A?G?E? OF[^:,\\.\\/]+)',
											'([^\\*\\(\\),;:=]* ESTATES)\\b',
											'([^\\*\\(\\),;:=]* VILL?A?G?E?)\\b',
											'([\\w ]* HEIGHTS)\\b'];
			IgnoreList := 'SEC TWP RNG|\\bAMENDED PLAT\\b|\\bPLAT [0-9A-Z_]{1,4}\\b|\\bTO?WN?S?H?I?P-?:? ?[0-9A-Z_]+|\\bRA?NGE?_?:? ?[0-9A-Z_]+|'+
										'\\bSECT?I?O?N?\\.?:? [0-9A-Z_]+|\\bT\\d+\\w?\\b|\\bR\\d+\\w?\\b|\\bS\\d+\\w?\\b|BEING A |NOW KNOWN AS |\\bBL \\w+ LT \\w+\\b|'+
										'LEASEHOLD ONLY |NOT A LEGAL |[0-9,]+ SQFT|[0-9]+ FT \\b[0-9]+_[0-9]+\\b|\\bAKA |PERSONAL PROPERTY|\\b[0-9]+ FT ?O?F?$|'+
										'\\b\\d+_\\d+[ENSW]*?_\\d+[ENSW]*?\\b|\\b\\d+ \\d+\\b|\\bQUARTER [ENSW1234][ENSW1234]\\b|\\b[A-Z][A-Z] [0-9A-Z]{1}\\b|'+
										'\\bT ?[0-9A-Z]+\\b R ?[0-9A-Z]+\\b S ?[0-9A-Z]+\\b|INCORPORATION INTO VILLAGE|PERSONAL MOBILE HOME|MOBILE HOME|'+
										'REC APPROVED|SUBDIVISIONNAME|SUBDIVISION|\\bNAME |\\bFUTURE DEVELOPMENT |\\b[A-Z] ?[0-9]$|ASSESSOR USE ONLY'+
										'\\bPB ?[0-9]{1,4}\\b|\\bPG ?[0-9]{1,4}\\b|\\bLO?T ?[0-9]{1,4}\\b|\\bL\\d+\\b|\\bP\\d+\\b';
			DeleteList := '^ASSESSMENT$|^BEING A$|^BLOCK \\w{1,3}$|^CONDO$|^CORRECTED$|^ESTATES$|^FT OF$|^FT$|^IMPROVEMENT$|^LOT$|^OF$|^PHASE \\d+$|'+
										'^PT$|^SQ ?FT |^TRACT$|^VILLAGE$|^X? ?FT |^X ';
			STRING t02 := stringlib.StringFilterOut(stringlib.StringToUpperCase(ltext),'\'');
			STRING t04 := REGEXREPLACE('SUBD-BLOCK',REGEXREPLACE('SUB-DIV',REGEXREPLACE(' THRO?UG?H? ',REGEXREPLACE('([0-9\\.\'"]* ?F?T? ?X ?[0-9\\.\'"]+ )',trim(t02),' '),'-'),'SUBDIV'),'SUBD BLOCK');
			STRING t05 := REGEXREPLACE('\\bAMENDE?D?\\b',REGEXREPLACE('SUBD-AMEND',trim(t04),'SUBD AMEND'),' ');
			STRING t06 := TRIM(stringlib.StringCleanSpaces(stringlib.StringFindReplace(REGEXREPLACE('\\bUNRECO?R?D?E?D?\\b',stringlib.StringFindReplace(t05,'S UBDIV','SUBDIV'),' '),'-','_')),LEFT,RIGHT);
			STRING t08 := MAP(
											TRIM(REGEXFIND(SubdvDelim[1] ,t06,0))<>'' => REGEXFIND(SubdvDelim[1] ,t06,0),
											TRIM(REGEXFIND(SubdvDelim[2] ,t06,1))<>'' => REGEXFIND(SubdvDelim[2] ,t06,1),
											TRIM(REGEXFIND(SubdvDelim[3] ,t06,1))<>'' => REGEXFIND(SubdvDelim[3] ,t06,1),
											TRIM(REGEXFIND(SubdvDelim[4] ,t06,1))<>'' => REGEXFIND(SubdvDelim[4] ,t06,1),
											TRIM(REGEXFIND(SubdvDelim[5] ,t06,1))<>'' => REGEXFIND(SubdvDelim[5] ,t06,1),
											TRIM(REGEXFIND(SubdvDelim[6] ,t06,1))<>'' => REGEXFIND(SubdvDelim[6] ,t06,1),
											TRIM(REGEXFIND(SubdvDelim[7] ,t06,1))<>'' => REGEXFIND(SubdvDelim[7] ,t06,1),
											TRIM(REGEXFIND(SubdvDelim[8] ,t06,1))<>'' => REGEXFIND(SubdvDelim[8] ,t06,1),
											TRIM(REGEXFIND(SubdvDelim[9] ,t06,1))<>'' => REGEXFIND(SubdvDelim[9] ,t06,1),
											TRIM(REGEXFIND(SubdvDelim[10],t06,1))<>'' => REGEXFIND(SubdvDelim[10],t06,1),
											TRIM(REGEXFIND(SubdvDelim[11],t06,1))<>'' => REGEXFIND(SubdvDelim[11],t06,1),
											TRIM(REGEXFIND(SubdvDelim[12],t06,1))<>'' => REGEXFIND(SubdvDelim[12],t06,1),
											TRIM(REGEXFIND(SubdvDelim[13],t06,1))<>'' => REGEXFIND(SubdvDelim[13],t06,1),
											TRIM(REGEXFIND(SubdvDelim[14],t06,1))<>'' => REGEXFIND(SubdvDelim[14],t06,1),
											TRIM(REGEXFIND(SubdvDelim[15],t06,1))<>'' => REGEXFIND(SubdvDelim[15],t06,1),
											TRIM(REGEXFIND(SubdvDelim[16],t06,1))<>'' => REGEXFIND(SubdvDelim[16],t06,1),
											TRIM(REGEXFIND(SubdvDelim[17],t06,1))<>'' => REGEXFIND(SubdvDelim[17],t06,1),
											TRIM(REGEXFIND(SubdvDelim[18],t06,1))<>'' => REGEXFIND(SubdvDelim[18],t06,1),
											TRIM(REGEXFIND(SubdvDelim[19],t06,1))<>'' => REGEXFIND(SubdvDelim[19],t06,1),
											TRIM(REGEXFIND(SubdvDelim[20],t06,1))<>'' => REGEXFIND(SubdvDelim[20],t06,1),
											TRIM(REGEXFIND(SubdvDelim[21],t06,1))<>'' => REGEXFIND(SubdvDelim[21],t06,1),
											TRIM(REGEXFIND(SubdvDelim[22],t06,1))<>'' => REGEXFIND(SubdvDelim[22],t06,1),
											TRIM(REGEXFIND(SubdvDelim[23],t06,1))<>'' => REGEXFIND(SubdvDelim[23],t06,1),
											TRIM(REGEXFIND(SubdvDelim[24],t06,1))<>'' => REGEXFIND(SubdvDelim[24],t06,1),
											TRIM(REGEXFIND(SubdvDelim[25],t06,1))<>'' => REGEXFIND(SubdvDelim[25],t06,1),
											TRIM(REGEXFIND(SubdvDelim[26],t06,1))<>'' => REGEXFIND(SubdvDelim[26],t06,1),
											TRIM(REGEXFIND(SubdvDelim[27],t06,1))<>'' => REGEXFIND(SubdvDelim[27],t06,1),
											TRIM(REGEXFIND(SubdvDelim[28],t06,1))<>'' => REGEXFIND(SubdvDelim[28],t06,1),
											TRIM(REGEXFIND(SubdvDelim[29],t06,1))<>'' => REGEXFIND(SubdvDelim[29],t06,1),
											TRIM(REGEXFIND(SubdvDelim[30],t06,1))<>'' => REGEXFIND(SubdvDelim[30],t06,1),
											TRIM(REGEXFIND(SubdvDelim[31],t06,1))<>'' => REGEXFIND(SubdvDelim[31],t06,1),
											TRIM(REGEXFIND(SubdvDelim[32],t06,1))<>'' => REGEXFIND(SubdvDelim[32],t06,1),
										'');
			STRING t09 := if(REGEXFIND('\\bLO?TS?#? \\w & \\w & \\w (.+)',TRIM(t08,LEFT,RIGHT),1)<>'',
											REGEXFIND('\\bLO?TS?#? \\w & \\w & \\w (.+)',TRIM(t08,LEFT,RIGHT),1),
											TRIM(t08,LEFT,RIGHT));
			STRING t10 := if(REGEXFIND('\\bLO?TS?#? \\w & \\w (.+)',TRIM(t09,LEFT,RIGHT),1)<>'',
											REGEXFIND('\\bLO?TS?#? \\w & \\w (.+)',TRIM(t09,LEFT,RIGHT),1),
											TRIM(t09,LEFT,RIGHT));
			STRING t11 := if(REGEXFIND('\\bLO?TS?#? ?[\\w+,&\\s]+ ?\\bOF(.+)',TRIM(t10,LEFT,RIGHT),1)<>'',
											REGEXFIND('\\bLO?TS?#? ?[\\w+,&\\s]+ ?\\bOF(.+)',TRIM(t10,LEFT,RIGHT),1),
											TRIM(t10,LEFT,RIGHT));
			STRING t12 := if(REGEXFIND('\\bLO?TS?#? ?\\w{1,4}\\b(.+)',TRIM(t10,LEFT,RIGHT),1)<>'',
											REGEXFIND('\\bLO?TS?#? ?\\w{1,4}\\b(.+)',TRIM(t10,LEFT,RIGHT),1),
											TRIM(t10,LEFT,RIGHT));
			STRING t14 := if(REGEXFIND('\\bBL?O?C?K [\\w+,&\\s]+ ?\\bOF(.+)',TRIM(t12,LEFT,RIGHT),1)<>'',
											REGEXFIND('\\bBL?O?C?K [\\w+,&\\s]+ ?\\bOF(.+)',TRIM(t12,LEFT,RIGHT),1),
											TRIM(t12,LEFT,RIGHT));
			STRING t16 := if(REGEXFIND('\\bBL?O?C?K \\w{1,4}\\b(.+)',TRIM(t14,LEFT,RIGHT),1)<>'',
											REGEXFIND('\\bBL?O?C?K \\w{1,4}\\b(.+)',TRIM(t14,LEFT,RIGHT),1),
											TRIM(t14,LEFT,RIGHT));
			STRING t18 := if(REGEXFIND('(.+)\\bBL?O?C?K \\w+\\b',TRIM(t16,LEFT,RIGHT),1)<>'',
											REGEXFIND('(.+)\\bBL?O?C?K \\w+\\b',TRIM(t16,LEFT,RIGHT),1),
											TRIM(t16,LEFT,RIGHT));
			STRING t20 := if(REGEXFIND('(.*) OF LO?T \\w*',TRIM(t18,LEFT,RIGHT),1)<>'',
											REGEXFIND('(.*) OF LO?T \\w*',TRIM(t18,LEFT,RIGHT),1),
											TRIM(t18,LEFT,RIGHT));
			STRING t22 := if(REGEXFIND('\\d ?AC?R?E?S?,? (.+)',TRIM(t20,LEFT,RIGHT),1)<>'',
											REGEXFIND('\\d ?AC?R?E?S?,? (.+)',TRIM(t20,LEFT,RIGHT),1),
											TRIM(t20,LEFT,RIGHT));
			STRING t24 := if(REGEXFIND('\\bTO (.*)',TRIM(t22,LEFT,RIGHT),1)<>'',
											REGEXFIND('\\bTO (.*)',TRIM(t22,LEFT,RIGHT),1),
											TRIM(t22,LEFT,RIGHT));
			STRING t26 := if(REGEXFIND('\\bOF (.*)',TRIM(t24,LEFT,RIGHT),1)<>'' AND 
											REGEXFIND('ESTATES OF',TRIM(t24,LEFT,RIGHT),0)='' AND
											REGEXFIND('VILLAGE OF',TRIM(t24,LEFT,RIGHT),0)='',
											REGEXFIND('\\bOF (.*)',TRIM(t24,LEFT,RIGHT),1),
											TRIM(t24,LEFT,RIGHT));
			STRING t28 := if(REGEXFIND('\\bFOR (.*)',TRIM(t26,LEFT,RIGHT),1)<>'',
											REGEXFIND('\\bFOR (.*)',TRIM(t26,LEFT,RIGHT),1),
											TRIM(t26,LEFT,RIGHT));
			STRING t30 := if(REGEXFIND('\\bAT (.*)',TRIM(t28,LEFT,RIGHT),1)<>'' AND
											REGEXFIND('ESTATES AT',TRIM(t24,LEFT,RIGHT),0)='' AND
											REGEXFIND('VILLAGE AT',TRIM(t24,LEFT,RIGHT),0)='',
											REGEXFIND('\\bAT (.*)',TRIM(t28,LEFT,RIGHT),1),
											TRIM(t28,LEFT,RIGHT));
			STRING t31 := REGEXREPLACE('\\b[A-Z]+[0-9]+[A-Z]+\\b',REGEXREPLACE('\\bTRA?C?T? ?\\w+\\b',REGEXREPLACE('\\bCLASS \\w+',TRIM(t30,LEFT,RIGHT),' '),' '),' ');
			STRING t32 := if(REGEXFIND('(.*)? ?\\bUNITS? N?O? ?\\w+ ?(.*)?',TRIM(t31,LEFT,RIGHT),1)<>'' AND
											REGEXFIND('\\b[A-Z]{5,}',REGEXFIND('(.*)? ?\\bUNITS? N?O? ?\\w+ ?(.*)?',TRIM(t31,LEFT,RIGHT),1)),
											REGEXFIND('(.*)? ?\\bUNITS? N?O? ?\\w+ ?(.*)?',TRIM(t31,LEFT,RIGHT),1),
											if(REGEXFIND('(.*)? ?\\bUNITS? N?O? ?\\w+ ?(.*)?',TRIM(t31,LEFT,RIGHT),2)<>'',
												REGEXFIND('(.*)? ?\\bUNITS? N?O? ?\\w+ ?(.*)?',TRIM(t31,LEFT,RIGHT),2),
												TRIM(t30,LEFT,RIGHT)));
			STRING t34 := if(REGEXFIND('(.*)? ?\\bBU?I?LDI?N?G #?N?O? ?\\w+ ?(.*)?',TRIM(t32,LEFT,RIGHT),1)<>'' AND
											REGEXFIND('\\b[A-Z]{5,}',REGEXFIND('(.*)? ?\\bBU?I?LDI?N?G #?N?O? ?\\w+ ?(.*)?',TRIM(t32,LEFT,RIGHT),1)),
											REGEXFIND('(.*)? ?\\bBU?I?LDI?N?G #?N?O? ?\\w+ ?(.*)?',TRIM(t32,LEFT,RIGHT),1),
											if(REGEXFIND('(.*)? ?\\bBU?I?LDI?N?G #?N?O? ?\\w+ ?(.*)?',TRIM(t32,LEFT,RIGHT),2)<>'',
												REGEXFIND('(.*)? ?\\bBU?I?LDI?N?G #?N?O? ?\\w+ ?(.*)?',TRIM(t32,LEFT,RIGHT),2),
												TRIM(t32,LEFT,RIGHT)));
			STRING t36 := if(REGEXFIND('\\bINC?L?.? (.*)',TRIM(t34,LEFT,RIGHT),1)<>'',
											REGEXFIND('\\bINC?L?.? (.*)',TRIM(t34,LEFT,RIGHT),1),
											TRIM(t34,LEFT,RIGHT));
			STRING t38 := if(REGEXFIND('\\d+ F?T? WIDE (.*)',TRIM(t36,LEFT,RIGHT),1)<>'',
											REGEXFIND('\\d+ F?T? WIDE (.*)',TRIM(t36,LEFT,RIGHT),1),
											TRIM(t36,LEFT,RIGHT));
			STRING t40 := if(REGEXFIND('\\d+ ([\\d*\\D*\\s]*)$',TRIM(t38,LEFT,RIGHT),1)<>'' AND
											REGEXFIND('\\b[A-Z]{5,}',REGEXFIND('\\d+ ([\\d*\\D*\\s]*)$',TRIM(t38,LEFT,RIGHT),1)),
											REGEXFIND('\\d+ ([\\d*\\D*\\s]*)$',TRIM(t38,LEFT,RIGHT),1),
											TRIM(t38,LEFT,RIGHT));
			STRING t42 := stringlib.StringCleanSpaces(stringlib.StringFindReplace(stringlib.StringFindReplace(TRIM(t40,LEFT,RIGHT),'*',' '),'UNRECD',' '));
			STRING t44 := if(REGEXFIND('^[0-9_ ]*$',t42,0)<>'',
											' ',
											TRIM(t42,LEFT,RIGHT));

			STRING t46 := REGEXREPLACE(DeleteList,TRIM(REGEXREPLACE(IgnoreList,TRIM(REGEXFIND('[^:]*(?![^:]*\\s.*)$',trim(t44),0),LEFT,RIGHT),' '),LEFT,RIGHT),' ');
			STRING t48 := if(REGEXFIND('[0-9]+[NRST][DHT]',t46) or REGEXFIND('PHA?S?E? [0-9A-Z]+',t46) or 
											REGEXFIND('ADDI?T?I?O?N? [0-9A-Z]+',t46) or REGEXFIND('[0-9]_?[A-Z]?$',trim(t46,left,right)),
											TRIM(t46),
											REGEXFIND('[^0-9,]*\\b(?![^0-9,]*\\s.*)$',TRIM(t46),0));
			STRING t49 := REGEXREPLACE(DeleteList,TRIM(REGEXREPLACE(IgnoreList,trim(t48,LEFT,RIGHT),' '),LEFT,RIGHT),' ');
			STRING t50 := REGEXREPLACE('^[_ ]+(?!$)',TRIM(REGEXREPLACE('(?!$)[_ ]+$',TRIM(REGEXREPLACE('^0+(?!$)',TRIM(stringlib.StringFilterOut(t49,'+"#:;,()*[]~%\\/$'),LEFT,RIGHT),' '),LEFT,RIGHT),' '),LEFT,RIGHT),' ');
			STRING t52 := REGEXREPLACE('^[\\. ]+(?!$)',TRIM(REGEXREPLACE('(?!$)[\\. ]+$',TRIM(t50,LEFT,RIGHT),' '),LEFT,RIGHT),' ');
			STRING t54 := REGEXREPLACE('^[& ]+(?!$)',TRIM(REGEXREPLACE('(?!$)[& ]+$',TRIM(t52,LEFT,RIGHT),' '),LEFT,RIGHT),' ');
			STRING t56 := if(REGEXFIND('\\w{5,}',trim(t44,left,right),0)<>'',
											TRIM(t54,LEFT,RIGHT),
											' ');
			STRING t58 := TRIM(stringlib.StringCleanSpaces(stringlib.StringFindReplace(REGEXREPLACE('(?!$)__+',t56,'_'),'_','-')),LEFT,RIGHT);
			RETURN t58;
		END;

		STRING outsubdv := IF((REGEXFIND(issubdv,stringlib.StringCleanSpaces(In_Rec.legal_brief_description)) and 
														REGEXFIND('SUB LOT',stringlib.StringCleanSpaces(In_Rec.legal_brief_description),0)='') or
														(REGEXFIND('\\D+ HOMES ',stringlib.StringCleanSpaces(In_Rec.legal_brief_description)) and 
														REGEXFIND('MOBILE HOMES',stringlib.StringCleanSpaces(In_Rec.legal_brief_description),0)='')  and 
														In_Rec.standardized_land_use_code in sluc_set,selectsubdv(In_Rec.legal_brief_description),' ');
		RETURN outsubdv;

	END;

END;