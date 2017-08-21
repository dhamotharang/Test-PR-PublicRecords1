IMPORT corp2, corp2_mapping;

EXPORT Functions := Module

	EXPORT NameTypeCode(string code) := Function

	 uc := corp2.t2u(code);
	 return map(uc in['A','AA','B','BK','D','DF','DFPC','DLLC',
										 'DLPC','DPC','DPLC','F','FLCA','FLLC',
										 'FLPC','FPC','FPLC','FS','G','H','HA',
										 'IC','J','JPA','K','L','LCA','N','NBC',
										 'NDF','NF','NFLC','NLCA','NS','NT','P','RAD',
										 'SID']  =>'01',
							uc = 	 'M'     =>'03',
							uc = 	 'T'     =>'04',	
							uc = 	 'S'     =>'05',
							uc = 	 'VN'    =>'07',
							uc = 	 'RN'    =>'09',
							uc = 	 'PN'    =>'I',
						  uc);
	END;
																					
	EXPORT Orig_desc(string code) := case(code,
																				'A'   =>'DOMESTIC GP',
																				'AA'  =>'AGRICULTURAL ASSOCIATION',
																				'B'   =>'FOREIGN GP',
																				'BK'  =>'BANK',
																				'D'   =>'DOMESTIC CORP',
																				'DF'  =>'DOMESTIC FOREIGN CORP',
																				'DFPC'=>'DOMESTIC FOREIGN CORP PC',
																				'DLLC'=>'DOMESTIC LLC',
																				'DLPC'=>'DOMESTIC LLC PC',
																				'DPC' =>'DOMESTIC CORP PC',
																				'DPLC'=>'DOMESTIC PROFESSIONAL LLC',
																				'F'   =>'FOREIGN CORP',
																				'FLCA'=>'FOREIGN LCA',
																				'FLLC'=>'FOREIGN LLC',
																				'FLPC'=>'FOREIGN LLC PC',
																				'FPC' =>'FOREIGN CORP PC',
																				'FPLC'=>'FOREIGN PROFESSIONAL LLC',
																				'FS'  =>'FRATERNAL SOCIETY',
																				'G'   =>'DOMESTIC LLP',
																				'H'   =>'FOREIGN LLP',
																				'HA'  =>'HOSPITAL AUTHORITY',
																				'IC'  =>'INSURANCE COMPANY',
																				'J'   =>'DOMESTIC LLC',
																				'JPA' =>'JOINT PUBLIC AGENCY',
																				'K'   =>'FOREIGN LLC',
																				'L'   =>'DOMESTIC LP',
																				'LCA' =>'DOMESTIC LCA',
																				'N'   =>'NON-PROFIT (DOM) CORP',
																				'NBC' =>'NEBRASKA BENEFIT CORP',
																				'NDF' =>'NON-PROFIT DOMESTICATED FOREIGN CORP',
																				'NF'  =>'NON-PROFIT FOREIGN CORP',
																				'NFLC'=>'NON PROFIT FOREIGN LCA',
																				'NLCA'=>'NON PROFIT DOM LCA',
																				'NS'  =>'NON-STOCK CORP',
																				'NT'  =>'NON-TAXABLE CORP',
																				'P'   =>'FOREIGN LP',
																				'PN'  =>'PROTECTED NAME',
																				'RAD' =>'REGISTERED AGENT DESIGNATION',
																				'SID' =>'SANITARY & IMPROVEMENT DISTRICT',
																				'');

	EXPORT FarmExemptions(string code) := Function
	
   KC:=['A','B','C','D','E','F','G','H','I','J','K','L','M','N','S','X','Y','Z','-','Q']; //All known codes per CI
	 ExempDesc(string code) := case(code,
																	'A'=>'FAMILY OWNED',
																	'B'=>'NON-PROFIT',
																	'C'=>'INDIAN TRIBAL CORP',
																	'D'=>'CONT.INTEREST', 
																	'E'=>'EXPERIMENTAL',
																	'F'=>'POULTRY',
																	'G'=>'ALFALFA', 
																	'H'=>'SEEDS/PLANTS/SOD',
																	'I'=>'MINERAL RTS',
																	'J'=>'NONFARMING',
																	'K'=>'DEBT COLL',
																	'L'=>'ENCUMBRANCE',
																	'M'=>'SPRAYING',
																	'N'=>'LIVESTOCK',
																	'Q'=>'', // Per CI :Do not map
																  'S'=>'', // Per CI :Do not map
																  'X'=>'', // Per CI :Do not map
																  'Y'=>'', // Per CI :Do not map
																  'Z'=>'', // Per CI :Do not map
																	'-'=>'', // Per CI :Do not map
																	'');
		uc 		:= corp2.t2u(StringLib.StringFindReplace(code, ' ', ''));																
		//Per CI :Only first two descriptions due to field length limitations on common layout's "corp_farm_exemptions" (string 30)!	
		desc1 := if(uc[1] in KC ,ExempDesc(uc[1]),'');
		desc2 := if(uc[2] in KC ,ExempDesc(uc[2]),'');
		scrubs:= map( uc[1]<>'' and uc[1] not in KC  and uc[2]<>'' and uc[2] not in KC  => '**|'+ uc[1] + '**|'+ uc[2],	//two new codes 
							    uc[1]<>'' and uc[1] not in KC 																		=> '**|'+ uc[1],
									uc[2]<>'' and uc[2] not in KC																			=> '**|'+ uc[2],// new codes will be caught through scrubs from 1st code or 2nd code
								 '');
									 
		FullDesc:= map(desc1 <>'' and desc2 <>'' and scrubs[1..2]<>'**' =>trim(desc1) +', '  +  trim(desc2), // two valid codes
									 desc1 <>''  and uc[2]<>''and scrubs[1..2]='**'		=>trim(desc1) + scrubs , 		//if 2nd  code is new	 
									 desc2 <>''  and uc[1]<>''and scrubs[1..2]='**' 	=>scrubs +trim(desc2) ,		 //if 1st  code is new								
									 desc1 <>''  and scrubs[1..2]<>'**'								=>desc1  ,                 //if only one valid code
									 desc2 <>''  and scrubs[1..2]<>'**'								=>desc2  ,
									 scrubs); // two new codes 
		
		return FullDesc;

	End;
																					
	//****************************************************************************
		//fGetCountryDesc: returns the "Country Description".
	//****************************************************************************
	EXPORT fGetCountryDesc(STRING Code) := Function

	 uc := corp2.t2u(code);
	 return map(	uc ='ABW'=>'ARUBA',   
								uc ='ARE'=>'UNITED ARAB EMIRATES',   
								uc ='AUS'=>'AUSTRIA',
								uc ='BRB'=>'BARBADOS',  
								uc ='CAN'=>'CANADA',
								uc ='CHE'=>'SWITZERLAND',  
								uc ='DEU'=>'GERMANY',
								uc ='ESP'=>'SPAIN',  
								uc ='GBR'=>'UNITED KINGDOM', 
								uc ='IND'=>'INDIA',      
								uc ='IRL'=>'IRELAND', 
								uc ='JPN'=>'JAPAN',   
								uc ='MYS'=>'MALAYSIA',   
								uc ='NZL'=>'NEW ZEALAND',  
								uc ='OMN'=>'OMAN',   
								uc ='PAN'=>'PANAMA', 
								uc ='PER'=>'PERU',   
								uc ='PHL'=>'PHILIPPINES', 
								uc ='PRI'=>'PUERTO RICO',   
								uc ='REU'=>'REUNION',   
								uc ='RUS'=>'RUSSIAN FEDERATION',   
								uc ='SVN'=>'SLOVENIA',   
								uc ='USA'=>'UNITED STATES',   
								uc ='VIR'=>'', 
								uc ='VI' =>'', 
								uc ='ZAF'=>'SOUTH AFRICA', 
								uc=''    =>'',
								'**|'+ uc 
								);								
	end;



	//********************************************************************
	//fGetStateDesc: Returns full name from "Two digit State_Code" 
	//********************************************************************	
	EXPORT  string fGetStateDesc(STRING state) := FUNCTION

		st  := corp2.t2u(state);
		RETURN map( st ='ANT'=>'NETHERLANDS ANTILLES',       
								st ='ARE'=>'UNITED ARAB EMIRATES',       
								st ='AUS'=>'AUSTRALIA',      
								st ='BEN'=>'BENIN',       
								st ='BMU'=>'BERMUDA',     
								st ='BRB'=>'BARBADOS',       
								st ='CAN'=>'CANADA',     
								st ='CHE'=>'SWITZERLAND',       
								st ='CHL'=>'CHILE',     
								st ='CHN'=>'CHINA',      
								st ='COK'=>'COOK ISLANDS',      
								st ='CYM'=>'CAYMAN ISLANDS',       
								st ='DEU'=>'GERMANY',     
								st ='DNK'=>'DENMARK',       
								st ='FRA'=>'FRANCE',      
								st ='GBR'=>'UNITED KINGDOM',       
								st ='GRC'=>'GREECE',       
								st ='IDN'=>'INDONESIA',   
								st ='IND'=>'INDIA',       
								st ='IOT'=>'BRITISH INDIAN OCEAN TERRITORY',       
								st ='IRL'=>'IRELAND',       
								st ='ITA'=>'ITALY',     
								st ='JPN'=>'JAPAN',   
								st ='LIE'=>'LIECHTENSTEIN',     
								st ='LSO'=>'LESOTHO',       
								st ='LUX'=>'LUXEMBOURG',       
								st ='MEX'=>'MEXICO',      
								st ='MUS'=>'MAURITIUS',      
								st ='NLD'=>'NETHERLANDS',       
								st ='NZL'=>'NEW ZEALAND',      
								st ='ON'=> 'CANADA',       
								st ='PAN'=>'PANAMA',     
								st ='PHL'=>'PHILIPPINES',      
								st ='PRI'=>'PUERTO RICO',      
								st ='QAT'=>'QATAR',       
								st ='RUS'=>'RUSSIAN FEDERATION',       
								st ='SGP'=>'SINGAPORE',
								st ='SK'=>'SLOVAKIA (SLOVAK REPUBLIC)',      
								st ='SWZ'=>'SWAZILAND',     
								st ='TGO'=>'TOGO',      
								st ='TWN'=>'TAIWAN, PROVINCE OF CHINA',      
								st ='URY'=>'URUGUAY',       
								st ='USA'=>'UNITED STATES',       
								st ='VGB'=>'VIRGIN ISLANDS (BRITISH)',     
								st ='VIR'=>'VIRGIN ISLANDS (U.S.)',       
								st ='XCN'=>'CHEROKEE NATION',       
								st ='XCS'=>'CONFEDERATED SALISH AND KOOTENAI TRIBES OF THE FLATHEAD NATION',       
								st ='XOT'=>'OMAHA TRIBE',      
								st ='XPB'=>'PASKENTA BAND OF NOMLAKI INDIANS OF CALIFORNIA',    
								st ='XPT'=>'PONCA TRIBE',       
								st ='XSS'=>'SANTEE SIOUX NATION',       
								st ='XWT'=>'WINNEBAGO TRIBE',
								st ='XX' =>'',					
								st ='X'	 =>'',
								st ='00' =>'',
								st ='0'	 =>'',
								st ='930'=>'',
								st =''	 =>'',
								'**|'+ st);
						
	END;


	EXPORT GetCLassification (STRING Code) := function

		st  := corp2.t2u(code);
		RETURN map( st in ['1','01']=>'CHEMICALS',
								st in ['2','02']=>'PAINTS, COATINGS & PIGMENTS',
								st in ['3','03']=>'CLEANING PRODUCTS, BLEACHING & ABRASIVES, COSMETICS',
								st in ['4','04']=>'FUELS, INDUSTRIAL OILS AND GREASES, ILLUMINATES',
								st in ['5','05']=>'PHARMACEUTICAL, VETERINARY PRODUCTS, DIETETIC',
								st in ['6','06']=>'METALS, METAL CASTINGS, LOCKS, SAFES, HARDWARE',
								st in ['7','07']=>'MACHINES AND MACHINE TOOLS, PARTS',
								st in ['8','08']=>'HAND TOOLS AND IMPLEMENTS, CUTLERY',
								st in ['9','09']=>'COMPUTERS, SOFTWARE, ELECTRONIC INSTRUMENTS, & SCIENTIFIC APPLIANCES',
								st ='10'=>'MEDICAL, DENTAL INSTRUMENTS AND APPARATUS',
								st ='11'=>'APPLIANCES, LIGHTING, HEATING, SANITARY INSTALLATIONS',
								st ='12'=>'VEHICLES',
								st ='13'=>'FIREARMS, EXPLOSIVES AND PROJECTILES',
								st ='14'=>'PRECIOUS METAL WARE, JEWELLERY',
								st ='15'=>'MUSICAL INSTRUMENTS AND SUPPLIES',
								st ='16'=>'PAPER, ITEMS MADE OF PAPER, STATIONARY ITEMS',
								st ='17'=>'RUBBER, ASBESTOS, PLASTIC ITEMS',
								st ='18'=>'LEATHER AND SUBSTITUTE GOODS',
								st ='19'=>'CONSTRUCTION MATERIALS (BUILDING - NON METALLIC)',
								st ='20'=>'FURNITURE, MIRRORS',
								st ='21'=>'CROCKERY, CONTAINERS, UTENSILS, BRUSHES, CLEANING IMPLEMENTS',
								st ='22'=>'CORDAGE, ROPES, NETS, AWNINGS, SACKS, PADDING',
								st ='23'=>'YARNS, THREADS',
								st ='24'=>'FABRICS, BLANKETS, COVERS, TEXTILE',
								st ='25'=>'CLOTHING, FOOTWEAR AND HEADGEAR',
								st ='26'=>'SEWING NOTIONS, FANCY GOODS, LACE AND EMBROIDERY',
								st ='27'=>'CARPETS, LINOLEUM, WALL AND FLOOR COVERINGS (NON TEXTILE)',
								st ='28'=>'GAMES, TOYS, SPORTS EQUIPMENT',
								st ='29'=>'FOODS - DAIRY, MEAT, FISH, PROCESSED & PRESERVED FOODS',
								st ='30'=>'FOODS - SPICES, BAKERY GOODS, ICE, CONFECTIONERY',
								st ='31'=>'FRESH FRUIT & VEGETABLES, LIVE ANIMALS',
								st ='32'=>'BEER, ALES, SOFT DRINKS, CARBONATED WATERS',
								st ='33'=>'WINES, SPIRITS, LIQUEURS',
								st ='34'=>'TOBACCO, SMOKERS REQUISITES & MATCHES',
								st ='35'=>'ADVERTISING, BUSINESS CONSULTING',
								st ='36'=>'INSURANCE, FINANCIAL',
								st ='37'=>'CONSTRUCTION, REPAIR, CLEANING',
								st ='38'=>'COMMUNICATIONS',
								st ='39'=>'TRANSPORT, UTILITIES, STORAGE & WAREHOUSING',
								st ='40'=>'MATERIALS TREATMENT, WORKING',
								st ='41'=>'EDUCATION, AMUSEMENT, ENTERTAINMENT, REPRODUCTION',
								st ='42'=>'SCIENTIFIC AND TECHNOLOGICAL SERVICES AND RESEARCH AND DESIGN RELATING THERETO',
								st ='43'=>'SERVICES FOR PROVIDING FOOD AND DRINK; TEMPORARY ACCOMMODATIONS.',
								st ='44'=>'MEDICAL SERVICES; VETERINARY SERVICES; HYGIENIC AND BEAUTY CARE FOR HUMAN BEINGS OR ANIMALS',
								st ='45'=>'PERSONAL AND SOCIAL SERVICES RENDERED BY OTHERS TO MEET THE NEEDS OF INDIVIDUALS',
								st ='47'=>'PLANT HUSBANDRY',
								st ='48'=>'GAS HEATING AND ILLUMINATING',
								st ='49'=>'MOVABLE OR REMOVABLES CLOSURES',
								st ='51'=>'ABRASIVE TOOL MAKING PROCESS, MATERIAL OR COMPOSITION',
								st ='52'=>'STATIC STRUCTURES',
								st in ['0','00','46','50','MO','']=>'', //Per CI - Invalid - do not output
								'**|'+ corp2.t2u(code)
						);
	End;	
			
	Export Set_Of_Event_Codes :=[ 'A','AB','ABLA','AC','ACV','AD','ADM','AG','AL','ALGP','AM',
																'AO','AP','AR','ASAU','AT','ATR','C','CA','CB','CC','CERT',
																'CI','CO','Copy','CR','CRLA','CRLC','CRLL','CRNA','CRTO',
																'CSAU','DA','DAO','DCA','EL','EX','FA','FCA','FW','GR',
																'GR2','INT','INTL','IS','JD','LP','MI','MO','NA','NAG',
																'NC','NN','NP','NR','NRV','PAG2','PAGE','PC','PP','PR',
																'RA','RCOR','RD','RE','REIN','RERN','RG','RJAG','RL',
																'RLCA','RLLC','RLP','RLPA','RNLC','RNP','RNPA','RPPA',
																'RS','RV','SAU','SC','SCH','SCOR','SDEN','SDIS','SE',
																'SI','SM','SSCO','ST','TM','TN','TR',''];
															 
	Export Set_Of_AR_Codes :=['AAR','ANR','BR','LLPA','NBR'];

End;