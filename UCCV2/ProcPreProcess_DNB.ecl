import tools;

export procPreProcess_DNB(string filedate) := function;

Jurisdiction_layout	:=	record
	string		code;
	string		state;
end;

dsInput	:=	UCCV2.File_DNB_ALL_In;

Jurisdiction	:=	dataset('~thor_data400::lookup::uccv2::jurisdiction',Jurisdiction_layout,csv(separator('\t'),TERMINATOR(['\n','\r\n']),MAXLENGTH(8192)));

UCCV2.Layout_File_DnB_FinancingStatement_in	trfFinancial(UCCV2.Layout_File_Variable_All	pInput)	:=	transform
	self.process_date				:=	filedate;
	self.ENTITY_ID					:=	pInput.line[1..6];
	self.ACTION_CODE				:=	pInput.line[7];
	self.DEF_GLOBAL_AGN			:=	pInput.line[8];
	self.DEF_DATA_LENGTH		:=	(string)(integer)pInput.line[9..12];	
	self.F_FING_ENTY_ID			:=	pInput.line[13..23];	
	self.FILG_OFC_DUNS_NBR	:=	pInput.line[24..32];	
	self.FILING_JURISDICTION:=	'';
	self.FILG_STMT_FILG_NBR	:=	pInput.line[33..46];
	self.FILG_NBR_FULL			:=	pInput.line[47..60];
	self.FILG_STMT_TYPE_CD	:=	pInput.line[61];
	self.FILG_STMT_TYPE_DEC	:=	map(pInput.line[61] = '1'	=>	'AMENDMENT',
																	pInput.line[61]	=	'2'	=>	'ORIGINAL',
																	pInput.line[61]	=	'3'	=>	'TERMINATION',
																	pInput.line[61] =	'4'	=>	'CONTINUATION',
																	pInput.line[61]	=	'5'	=>	'ASSIGNMENT',
																	pInput.line[61]	=	'6'	=>	'RELEASE',
																	pInput.line[61]	=	'7'	=>	'PARTIAL RELEASE',
																	pInput.line[61]	=	'8'	=>	'SUBORDINATION',
																	''
																	);
	self.FILG_DT						:=	pInput.line[62..69];
	self.XREF_DT						:=	if ((integer)pInput.line[70..77] = 0,
																		'',
																		pInput.line[70..77]
																	);
	self.XREF_NBR						:=	pInput.line[78..91];
	self.FILG_OFC_NME				:=	pInput.line[92..211];
	self.FILG_OFC_STR_ADR		:=	pInput.line[212..275];
	self.FILG_OFC_CITY_NME	:=	pInput.line[276..305];
	self.FILG_OFC_CNTY_NME	:=	pInput.line[306..335];
	self.FILG_OFC_ST_NME		:=	pInput.line[336..337];
	self.FILG_OFC_POST_CD		:=	pInput.line[338..346];
	self.DT_LAST_UPD				:=	pInput.line[347..354];
	self.TIME_LAST_UPD			:=	pInput.line[355..360];
	self.DT_ENTD						:=	pInput.line[361..368];
	self.TIME_ENTD					:=	pInput.line[369..374];
	self.CONT_TYPE					:=	if ((integer)pInput.line[375] = 0,
																		'',
																		pInput.line[375]
																	);
	self.CONT_DESC					:=	map(pInput.line[375]	=	'1'	=>	'LEASE',
																	pInput.line[375]	=	'2'	=>	'RENTAL',
																	pInput.line[375]	=	'3'	=>	'SALE',
																	pInput.line[375]	=	'4'	=>	'REFINANCE',
																	pInput.line[375]	=	'5'	=>	'WHOLESALE',
																	pInput.line[375]	=	'8'	=>	'UNKNOWN',
																	pInput.line[375]	=	'9'	=>	'OTHER',
																	''
																	);
	self.DISTBN_CTRL_CD			:=	pInput.line[376];
	self.FILG_EXPN_DT				:=	if ((integer)pInput.line[377..384] = 0,
																		'',
																		pInput.line[377..384]
																	);
	self.FILG_NBR_PG				:=	if ((integer)pInput.line[385..387] = 0,
																		'',
																		(string)(integer)pInput.line[385..387]
																	);
	self.FILG_TIME					:=	pInput.line[388..391];
	self.RECVDDT						:=	pInput.line[392..399];
	self.VERNDT							:=	pInput.line[400..407];
	self.MIN_REQM_MET_INDC	:=	pInput.line[408];
	self.PRTY_CD						:=	pInput.line[409..411];
	self.prep_addr_line1		:=	pInput.line[212..275];
	self.prep_addr_last_line:=	if	(pInput.line[276..305] != '',
																			StringLib.StringCleanSpaces(trim(pInput.line[276..305]) + ', ' + trim(pInput.line[336..337]) + ' ' + trim(pInput.line[338..342])),
																			StringLib.StringCleanSpaces(trim(pInput.line[336..337]) + ' ' + trim(pInput.line[338..342]))
																	 );
end;

FinancialStmtIn	:=	project(dsInput(line[1..4]='FSAA'),trfFinancial(left));

UCCV2.Layout_File_DnB_FinancingStatement_in	joinJurisdiction(UCCV2.Layout_File_DnB_FinancingStatement_in l, Jurisdiction_layout r)	:=	transform	
	self.FILING_JURISDICTION:=	r.state;
	self										:=	l;
end;

Join4Jurisdiction	:=	join(	FinancialStmtIn,
														Jurisdiction,
														left.FILG_OFC_DUNS_NBR = right.code,
														joinJurisdiction(left,right),
														lookup
													 );
													 
FinancingStatement				:=	output(Join4Jurisdiction,,'~thor_data400::in::uccv2::'+filedate+'::dnb::financingstatement',overwrite);
AddSuperFinStmt						:=	fileservices.addsuperfile('~thor_data400::in::uccv2::DNB::financingstatement','~thor_data400::in::uccv2::'+filedate+'::dnb::financingstatement');
AddSuperFinStmtProcessed	:=	fileservices.addsuperfile('~thor_data400::in::uccv2::DNB::financingstatement::processed','~thor_data400::in::uccv2::'+filedate+'::dnb::financingstatement');

fGetTitle(string4 code)	:=	function
	string35 title	:=	map(code	=	'0001'	=>	'ACCOUNTANT',
													code	=	'0002'	=>	'ACCOUNTING MANAGER',
													code	=	'0003'	=>	'ADMINISTRATOR',
													code	=	'0004'	=>	'ADMINISTRATIVE ASSISTANT',
													code	=	'0005'	=>	'ATTORNEY',
													code	=	'0006'	=>	'AUDITOR',
													code	=	'0007'	=>	'BOOKKEEPER',
													code	=	'0008'	=>	'CASHIER',
													code	=	'0009'	=>	'CERTIFIED PUBLIC ACCOUNTANT',
													code	=	'0010'	=>	'CHAIRMAN',
													code	=	'0011'	=>	'CHAIRMAN OF THE BOARD',
													code	=	'0012'	=>	'CHIEF EXECUTIVE OFFICER',
													code	=	'0013'	=>	'CHIEF FINANCIAL OFFICER',
													code	=	'0014'	=>	'CLERK',
													code	=	'0015'	=>	'COMPTROLLER',
													code	=	'0016'	=>	'CONTROLLER',
													code	=	'0017'	=>	'CREDIT MANAGER',
													code	=	'0018'	=>	'EXECUTIVE SECRETARY',
													code	=	'0019'	=>	'DIRECTOR',
													code	=	'0020'	=>	'EXECUTIVE VICE PRESIDENT',
													code	=	'0021'	=>	'GENERAL MANAGER',
													code	=	'0022'	=>	'GENERAL PARTNER',
													code	=	'0023'	=>	'LIMITED PARTNER',
													code	=	'0024'	=>	'MANAGER',
													code	=	'0025'	=>	'OFFICE MANAGER',
													code	=	'0026'	=>	'OWNER',
													code	=	'0027'	=>	'PARTNER',
													code	=	'0028'	=>	'PRESIDENT',
													code	=	'0029'	=>	'SECRETARY',
													code	=	'0030'	=>	'SECRETARY-TREASURER',
													code	=	'0031'	=>	'TREASURER',
													code	=	'0032'	=>	'VICE PRESIDENT',
													code	=	'0033'	=>	'SPOKESPERSON',
													code	=	'0034'	=>	'CHIEF OPERATING OFFICER',
													code	=	'0035'	=>	'SENIOR VICE PRESIDENT',
													code	=	'0036'	=>	'ASSISTANT VICE PRESIDENT',
													code	=	'0037'	=>	'EXECUTIVE DIRECTOR',
													code	=	'0038'	=>	'INCORPORATOR',
													''
												);

	return title;	
end;

UCCV2.Layout_File_DnB_FinancingComment_in	trfFinComment(UCCV2.Layout_File_Variable_All	pInput)	:=	transform
	self.process_date				:=	filedate;
	self.ENTITY_ID					:=	pInput.line[1..6];
	self.ACTION_CODE				:=	pInput.line[7];
	self.DEF_GLOBAL_AGN			:=	pInput.line[8];
	self.DEF_DATA_LENGTH		:=	(string)(integer)pInput.line[9..12];	
	self.F_FING_ENTY_ID			:=	pInput.line[13..23];	
	self.FING_CMT_SEQNBR		:=	pInput.line[24..25];
	self.CMNT_DESC					:=	map(pInput.line[26..27] = '01' =>	'DEFERRED COMMENT ON THE FINANCING STATEMENT',
																	pInput.line[26..27] = '02' =>	'DECLINED COMMENT ON THE FINANCING STATEMENT',	
																	pInput.line[26..27] = '03' =>	'STATED THAT THE FINANCING STATEMENT WAS TERMINATED',
																	pInput.line[26..27] = '04' => 'STATED THAT THE FINANCING STATEMENT WAS CONTINUED',
																	pInput.line[26..27] = '05' =>	'STATED THAT THE FINANCING STATEMENT WAS ASSIGNED', 
																	pInput.line[26..27] = '06' =>	'STATED THAT THE FINANCING STATEMENT WAS RELEASED',
 																	''
																 );
	self.CMNT_DT						:=	pInput.line[28..35];
	self.SRC_INDV_TTL				:=	fGetTitle(pInput.line[36..39]);
	self.SRC_INDV_TTL2			:=	fGetTitle(pInput.line[40..43]);	
	self.SRC_INDV_TTL3			:=	fGetTitle(pInput.line[44..47]);	
	self.SRC_BUS_NME				:=	pInput.line[48..167];
	self.SRC_INDV_NME				:=	pInput.line[168..242];
	self.SRC_INDV_TTL_DESC	:=	pInput.line[243..282];
	self.TXT								:=	pINput.line[283..532];
end;
	
FinCommentIn	:=	project(dsInput(line[1..4]='FSCA'),trfFinComment(left));

FinancingComment						:=	output(FinCommentIn,,'~thor_data400::in::uccv2::'+filedate+'::dnb::financingcomment',overwrite);
AddSuperFinComment					:=	fileservices.addsuperfile('~thor_data400::in::uccv2::DNB::financingcomment','~thor_data400::in::uccv2::'+filedate+'::dnb::financingcomment');
AddSuperFinCommentProcessed	:=	fileservices.addsuperfile('~thor_data400::in::uccv2::DNB::financingcomment::processed','~thor_data400::in::uccv2::'+filedate+'::dnb::financingcomment');

UCCV2.Layout_File_DnB_Collateral_in	trfCollateral(UCCV2.Layout_File_Variable_All	pInput)	:=	transform
	self.process_date				:=	filedate;
	self.ENTITY_ID					:=	pInput.line[1..6];
	self.ACTION_CODE				:=	pInput.line[7];
	self.DEF_GLOBAL_AGN			:=	pInput.line[8];
	self.DEF_DATA_LENGTH		:=	(string)(integer)pInput.line[9..12];	
	self.F_FING_ENTY_ID			:=	pInput.line[13..23];	
	self.FING_COLL_SEQ_NBR	:=	pInput.line[24..26];
	self.COLL_CD						:=	pInput.line[27..28];
	self.COLL								:=	map(pInput.line[27..28] = '01' => 'EQUIPMENT',
																	pInput.line[27..28] = '02' => 'FIXTURES',
																	pInput.line[27..28] = '03' => 'INVENTORY',
																	pInput.line[27..28] = '04' => 'GENERAL INTANGIBLE(S)',
																	pInput.line[27..28] = '05' => 'CHATTEL PAPER',
																	pInput.line[27..28] = '06' => 'CONTRACT RIGHTS',
																	pInput.line[27..28] = '07' => 'ACCOUNTS RECEIVABLE',
																	pInput.line[27..28] = '08' => 'COMPUTER EQUIPMENT',
																	pInput.line[27..28] = '09' => 'MACHINERY',
																	pInput.line[27..28] = '10' => 'BUSINESS MACHINERY/EQUIPMENT',
																	pInput.line[27..28] = '11' => 'UNSPECIFIED',
																	pInput.line[27..28] = '12' => 'NEGOTIABLE INSTRUMENTS',
																	pInput.line[27..28] = '13' => 'FARM PRODUCTS/CROPS',
																	pInput.line[27..28] = '14' => 'VEHICLES',
																	pInput.line[27..28] = '15' => 'CONSTRUCTION EQUIPMENT/MACHINERY',
																	pInput.line[27..28] = '16' => 'AGRICULTURAL EQUIPMENT',
																	pInput.line[27..28] = '17' => 'ASSETS',
																	pInput.line[27..28] = '18' => 'ACCOUNT(S)',
																	pInput.line[27..28] = '19' => 'NOTES RECEIVABLE',
																	pInput.line[27..28] = '20' => 'CONSIGNED MERCHANDISE',
																	pInput.line[27..28] = '21' => 'BUILDING(S)',
																	pInput.line[27..28] = '22' => 'REAL PROPERTY',
																	pInput.line[27..28] = '23' => 'AS SPECIFIED',
																	pInput.line[27..28] = '24' => 'INDUSTRIAL EQUIPMENT/MACHINERY',
																	pInput.line[27..28] = '25' => 'TIMBER',
																	pInput.line[27..28] = '26' => 'LIVESTOCK',
																	pInput.line[27..28] = '27' => 'BUILDING MATERIALS',
																	pInput.line[27..28] = '28' => 'COMMUNICATIONS EQUIPMENT',
																	pInput.line[27..28] = '29' => 'OIL, GAS AND MINERALS',
																	pInput.line[27..28] = '30' => 'AQUA CULTURE STOCK',
																	pInput.line[27..28] = '31' => 'TEXTILE GOODS',
																	pInput.line[27..28] = '32' => 'TRANSPORTATION EQUIPMENT',
																	pInput.line[27..28] = '33' => 'PRODUCTS',
																	pInput.line[27..28] = '34' => 'PROCEEDS',
																	pInput.line[27..28] = '35' => 'PRODUCTS AND PROCEEDS',
																	pInput.line[27..28] = '37' => 'ALL ASSETS',
																	pInput.line[27..28] = '38' => 'CAPITAL STOCK',
																	pInput.line[27..28] = '39' => 'PARTNERSHIP INTEREST',
																	pInput.line[27..28] = '40' => 'MOBILE HOMES',
																	''
																);
									
	self.COLL_CD_PRQUAL			:=	pInput.line[29];
	self.COLL_PRQUAL				:=	map(pInput.line[29]	=	'1'	=>	'SPECIFIED',
																	pInput.line[29]	=	'2'	=>	'ALL',
																	pInput.line[29]	=	'3'	=>	'LEASED',
																	pInput.line[29]	=	'4'	=>	'VARIOUS',
																	pInput.line[29]	=	'5'	=>	'CERTAIN',
																	''
																);
	self.COLL_CD_POQUAL			:=	pInput.line[30];
	self.COLL_POQUAL				:=	map(pInput.line[30]	=	'1'	=>	'AND PROCEEDS',
																	pInput.line[30]	=	'2'	=>	'INCLUDING PROCEEDS AND PRODUCTS',
																	pInput.line[30]	=	'3'	=>	'LEASAND PRODUCTSED',
																	''
																	);
																	
	self.COLL_DESC					:=	pInput.line[31..280];
	self.COLL_PRTY_CD				:=	pInput.line[281..283];
end;
	
CollateralIn	:=	project(dsInput(line[1..4]='FSDA'),trfCollateral(left));

Collateral									:=	output(CollateralIn,,'~thor_data400::in::uccv2::'+filedate+'::dnb::collateral',overwrite);
AddSuperCollateral					:=	fileservices.addsuperfile('~thor_data400::in::uccv2::DNB::collateral','~thor_data400::in::uccv2::'+filedate+'::dnb::collateral');
AddSuperCollateralProcessed	:=	fileservices.addsuperfile('~thor_data400::in::uccv2::DNB::collateral::processed','~thor_data400::in::uccv2::'+filedate+'::dnb::collateral');

fGetMachineType(string3 code)	:=	function
	string145 MachType	:=	map(code = '001' => 'CECRAWLER DOZER',
															code = '002' => 'CELOADER BACKHOE',
															code = '003' => 'CEWHEEL LOADER',
															code = '004' => 'CESCRAPER',
															code = '005' => 'CEMOTOR GRADER',
															code = '006' => 'CEEXCAVATOR',
															code = '007' => 'CECRANE',
															code = '008' => 'CEDRAGLINE',
															code = '009' => 'CEOFF ROAD TRUCK',
															code = '010' => 'CECRAWLER LOADER',
															code = '011' => 'CETRAILER',
															code = '012' => 'CECOMPACTOR',
															code = '013' => 'CEAIR COMPRESSOR',
															code = '014' => 'CEDRILL',
															code = '015' => 'CEMINER',
															code = '016' => 'CEPAVER',
															code = '017' => 'CESWEEPER',
															code = '018' => 'CEGENERATOR SET',
															code = '019' => 'CECONVEYOR',
															code = '020' => 'CEPERSONNEL LIFT',
															code = '021' => 'CESKIDDER',
															code = '022' => 'CELOG LOADER',
															code = '023' => 'CEGRAPPLE',
															code = '024' => 'CECHIPPER',
															code = '025' => 'CETRACTOR/LOADER',
															code = '026' => 'CEIND. TRACTOR',
															code = '027' => 'CEFORKLIFT',
															code = '028' => 'CESKID STEER LDR',
															code = '029' => 'CETRENCHER',
															code = '032' => 'CEUTILITY-TLB',
															code = '033' => 'CELIFT TRUCK',
															code = '036' => 'CEUTILITY TRACTOR',
															code = '044' => 'CE4 WD AG TRACTOR',
															code = '045' => 'CEWHEEL DOZER',
															code = '050' => 'CERUBBER TIRE',
															code = '055' => 'CEMACHINE TOOLS',
															code = '060' => 'CESHOOTING BOOM',
															code = '065' => 'CETOOLCARRIER',
															code = '070' => 'CEMINI',
															code = '071' => 'CEARTICULATED HAULER',
															code = '098' => 'CETRUCK',
															code = '099' => 'CEXXX',
															code = '111' => 'DPMAINFRM MEM. UPGRADE',
															code = '113' => 'DPMAINFRAME MDL CHANGE',
															code = '115' => 'DPMAINFRAME COMPUTER',
															code = '118' => 'DPMAINFRAME FEAT. ADDN',
															code = '120' => 'DPMICRO-COMPUTER',
															code = '121' => 'DPMEMORY UPGRADE',
															code = '123' => 'DPCPU MODEL CHANGE',
															code = '124' => 'DPMINI-COMPUTER',
															code = '125' => 'DPCPU',
															code = '126' => 'DPLEDGER CARD MACH',
															code = '128' => 'DPCPU FEATURE ADDITION',
															code = '130' => 'DPPROCESS CONTROL SYS',
															code = '140' => 'DPPOWER/ENERGY MGT.',
															code = '150' => 'DPDATA COLLECTION',
															code = '160' => 'WPWORD PROC SYSTEM',
															code = '161' => 'WPSTANDALONE WP SYSTEM',
															code = '163' => 'WPMULTI-TERM WP SYSTEM',
															code = '170' => 'WPTYPESETTER',
															code = '171' => 'WPCOMPOSER',
															code = '172' => 'WPSTANDALONE PTS',
															code = '173' => 'WPDIR. ENTRY KYBD SYS',
															code = '174' => 'WPFRONT END SYSTEM',
															code = '175' => 'WPDISP/HEADLINER PTS',
															code = '176' => 'WPCOMPOSITION TERMINAL',
															code = '180' => 'DPBRIDGE',
															code = '181' => 'DPGATEWAY',
															code = '182' => 'DPROUTER',
															code = '183' => 'DPHUB',
															code = '185' => '  FLATBED SCANNER',
															code = '186' => '  SHEETFED SCANNER',
															code = '187' => '  SLIDE/PHOTO SCANNER',
															code = '188' => '  BAR 															code SCANNER',
															code = '189' => '0 GENERIC SCANNER',
															code = '210' => 'DPPRINTER',
															code = '211' => 'DPLINE PRINTER',
															code = '212' => 'DPMATRIX PRINTER',
															code = '213' => 'DPLASER PRINTER',
															code = '214' => 'DPTHERMAL PRINTER',
															code = '215' => 'DPDAISY WHEEL PRINTER',
															code = '216' => 'DPTELEPRINTER',
															code = '217' => 'DPPRINTER/PLOTTER',
															code = '218' => 'DPION DEPOSITION PTR',
															code = '219' => 'DPINK JET PRINTER',
															code = '220' => 'DPDISK DRIVE',
															code = '221' => 'DPDISKETTE DRIVE',
															code = '222' => 'DPTAPE DRIVE',
															code = '223' => 'DPCASSETTE DRIVE',
															code = '224' => 'DPCONTROL UNIT',
															code = '225' => 'DPADD-ON MEMORY',
															code = '226' => 'DPMDL CHANGE-I/O EQUIP',
															code = '227' => 'DPDISK UPGRADE',
															code = '228' => '  OPTICAL DISK DRIVE',
															code = '229' => '  OPTICAL JUKEBOX',
															code = '230' => 'DPDISPLAY STATION',
															code = '231' => 'DPREMOTE/COMM TERMINAL',
															code = '232' => 'DPCONSOLE TYPEWRITER',
															code = '233' => 'DPPAPER TAPE',
															code = '234' => 'DPKEYPUNCH',
															code = '235' => 'DPCARD I/O',
															code = '236' => 'DPGRAPHICS DISPLAY',
															code = '237' => 'DPDATA ENTRY STATION',
															code = '238' => 'DPPROGRAMMABLE DATA ST',
															code = '239' => 'DPTERMINAL',
															code = '240' => 'CPXEROGRAPHIC DUPLTR',
															code = '250' => 'DPBANK TERMINALS',
															code = '251' => 'DPTELLER TERMINAL',
															code = '252' => 'DPMICR READER',
															code = '253' => 'DPPROOF SYSTEM',
															code = '255' => 'DPBANK EQUIPMENT',
															code = '260' => 'DPPOINT OF SALE TERM',
															code = '261' => 'DPOCR-READER',
															code = '280' => 'DPDATA MODULE',
															code = '281' => 'DPDISK PACK',
															code = '282' => 'DPTAPE',
															code = '283' => 'DPDISKETTES',
															code = '285' => 'DPCUT SHEET FEEDER',
															code = '286' => 'DPDAISY WHEELS',
															code = '287' => 'DPENVELOPE FEEDER',
															code = '288' => '  TAPE LIBRARY',
															code = '289' => '  TAPE AUTOLOADER',
															code = '290' => '  FAX/COPY/PRINT/SCAN',
															code = '291' => '  FAX/COPY/PRINT',
															code = '292' => '  COPY/PRINT/SCAN',
															code = '293' => '  COPY/PRINT',
															code = '294' => '  FAX/PRINT',
															code = '296' => '  FAX/COPY/SCAN',
															code = '300' => 'DPPLATEMAKER',
															code = '430' => 'WPTEXT EDITOR DISPLAY',
															code = '431' => 'WPMAG CARD',
															code = '432' => 'WPDISPLAY WORKSTATION',
															code = '440' => 'WPDISPLAY TYPING SYS',
															code = '441' => 'WPCRT/DISKETTE TYP SYS',
															code = '442' => 'WPELECTRONIC TYPEWRTR',
															code = '443' => 'WPMAG CARD/SEL-TYPEWRT',
															code = '520' => 'CPCOPIER',
															code = '521' => 'CPCOPIER/DUPLICATOR',
															code = '522' => '  ENGINEERING COPIER',
															code = '551' => 'WPFACSIMILE MACHINE',
															code = '552' => 'WPCOMM WP/ELECTR MAIL',
															code = '600' => 'KSTELE. SYS. -MDL UNKN',
															code = '601' => 'KSELECT. KEY TELE SYS',
															code = '602' => 'KSELECTRO KEY TELE SYS',
															code = '603' => 'PBPBX SYSTEM',
															code = '604' => 'PBDUAL-FUNCT. KEY/PBX',
															code = '605' => 'PBPBX SOFTWARE',
															code = '820' => 'DPSOFTWARE',
															code = '821' => 'DPOPERATING SYSTEM',
															code = '822' => 'DPNETWORK SOFTWARE',
															''
														);
	return MachType;
end;

UCCV2.Layout_File_DnB_CollateralItem_in	trfCollateralItem(UCCV2.Layout_File_Variable_All	pInput)	:=	transform
	self.process_date				:=	filedate;
	self.ENTITY_ID					:=	pInput.line[1..6];
	self.ACTION_CODE				:=	pInput.line[7];
	self.DEF_GLOBAL_AGN			:=	pInput.line[8];
	self.DEF_DATA_LENGTH		:=	(string)(integer)pInput.line[9..12];	
	self.F_FING_ENTY_ID			:=	pInput.line[13..23];
	
	self.F_FING_COLL_SEQ		:=	pInput.line[24..26];
	self.FING_ITEM_SEQ_NBR	:=	pInput.line[27..29];
	self.MACH_CD_PRIM				:=	pInput.line[30..32];
	self.MACH_PRIM					:=	fGetMachineType(pInput.line[30..32]); 
	self.MACH_CD_SECDY			:=	pInput.line[33..35];
	self.MACH_SECDY					:=	fGetMachineType(pInput.line[33..35]);
	self.MFR_CD							:=	pInput.line[36..40];	
	self.MFR_NAME						:=	pInput.line[41..160];	
	self.MODEL							:=	pInput.line[161..175];	
	self.MODEL_YR						:=	if ((integer)pInput.line[176..179] = 0,
																		'',
																		pInput.line[176..179]
																	);		
	self.MODEL_DESC					:=	pInput.line[180..229];		
	self.COLL_ITEM_QTY_NULL	:=	if ((integer)pInput.line[230..230] = 0,
																		'',
																		pInput.line[230..230]
																	);
	self.COLL_ITEM_QTY			:=	pInput.line[231..235];	
	self.YR_MFD							:=	if ((integer)pInput.line[236..239] = 0,
																		'',	
																		pInput.line[236..239]
																	);
	self.NEW_USED_INDC			:=	pInput.line[240..240];		
	self.SER_NBR						:=	pInput.line[241..270];	
	self.SZ_CLASS_CD				:=	pInput.line[271..271];
end;
	
CollateralItemIn	:=	project(dsINput(line[1..4]='FSDH'),trfCollateralItem(left));

CollateralItem									:=	output(CollateralItemIn,,'~thor_data400::in::uccv2::'+filedate+'::dnb::collateralitem',overwrite);
AddSuperCollateralItem					:=	fileservices.addsuperfile('~thor_data400::in::uccv2::DNB::collateralitem','~thor_data400::in::uccv2::'+filedate+'::dnb::collateralitem');
AddSuperCollateralItemProcessed	:=	fileservices.addsuperfile('~thor_data400::in::uccv2::DNB::collateralitem::processed','~thor_data400::in::uccv2::'+filedate+'::dnb::collateralitem');

UCCV2.Layout_File_DnB_Debtor_in	trfDebtor(UCCV2.Layout_File_Variable_All	pInput)	:=	transform
	self.process_date				:=	filedate;
	self.ENTITY_ID					:=	pInput.line[1..6];
	self.ACTION_CODE				:=	pInput.line[7];
	self.DEF_GLOBAL_AGN			:=	pInput.line[8];
	self.DEF_DATA_LENGTH		:=	(string)(integer)pInput.line[9..12];	
	self.F_FING_ENTY_ID			:=	pInput.line[13..23];	
	
	self.GNG_DBTR_SEQ_NBR		:=	pInput.line[24..26];
	self.BUS_DUNS_NULL			:=	pInput.line[27];	
	self.BUS_DUNS_NBR				:=	if ((integer)pInput.line[28..36] = 0,
																		'',
																		pInput.line[28..36]
																	);
	self.BUS_DUNS_ID				:=	pInput.line[37..47];	
	self.HQ_BUS_DUNS_NULL		:=	pInput.line[48];	
	self.BUS_HQ_DUNS_NBR		:=	if ((integer)pInput.line[49..57] = 0,
																		'',
																		pInput.line[49..57]
																	);
	self.BUS_HQ_ENTITY_ID		:=	if ((integer)pInput.line[58..68] = 0,
																		'',
																		pInput.line[58..68]
																	);
	self.BUS_CITY_CD				:=	if ((integer)pInput.line[69..72] = 0,
																		'',
																		pInput.line[69..72] 
																	);
	self.BUS_ST_CD					:=	if ((integer)pInput.line[73..75] = 0,
																		'',
																		pInput.line[73..75]
																	);
	self.FILG_NME						:=	StringLib.StringToUpperCase(pInput.line[76..195]);
	self.FILG_STR_ADR				:=	pInput.line[196..259];
	self.FILG_CITY_NME			:=	pInput.line[260..289];
	self.FILG_ST_NAME				:=	pInput.line[290..291];
	self.FILG_FOR_REG				:=	pInput.line[292..361];
	self.FILG_CTRY_NME			:=	pInput.line[362..401];
	self.FILG_POST_CD				:=	pInput.line[402..410];
	self.MTCH_TYP_CD				:=	if ((integer)pInput.line[411] = 0,
																		'',
																		pInput.line[411]
																	);
	self.prep_addr_line1		:=	pInput.line[196..259];
	self.prep_addr_last_line:=	if	(pInput.line[260..289] != '',
																			StringLib.StringCleanSpaces(trim(pInput.line[260..289]) + ', ' + trim(pInput.line[290..291]) + ' ' + trim(pInput.line[402..406])),
																			StringLib.StringCleanSpaces(trim(pInput.line[290..291]) + ' ' + trim(pInput.line[402..406]))
																	);
	self										:=	[];
	end;
	
DebtorIn	:=	project(dsInput(line[1..4]='FSBA'),trfDebtor(left));

debtor									:=	output(DebtorIn,,'~thor_data400::in::uccv2::'+filedate+'::dnb::debtor',overwrite);
AddSuperdebtor					:=	fileservices.addsuperfile('~thor_data400::in::uccv2::DNB::debtor','~thor_data400::in::uccv2::'+filedate+'::dnb::debtor');
AddSuperdebtorProcessed	:=	fileservices.addsuperfile('~thor_data400::in::uccv2::DNB::debtor::processed','~thor_data400::in::uccv2::'+filedate+'::dnb::debtor');

UCCV2.Layout_File_DnB_SecuredParty_in	trfSecuredParty(UCCV2.Layout_File_Variable_All	pInput)	:=	transform
	self.process_date				:=	filedate;
	self.ENTITY_ID					:=	pInput.line[1..6];
	self.ACTION_CODE				:=	pInput.line[7];
	self.DEF_GLOBAL_AGN			:=	pInput.line[8];
	self.DEF_DATA_LENGTH		:=	(string)(integer)pInput.line[9..12];	
	self.F_FING_ENTY_ID			:=	pInput.line[13..23];
	self.SCRD_PRTY_SEQ_NBR	:=	if ((integer)pInput.line[24..26] = 0,
																		'',
																		pInput.line[24..26]
																	);
	self.L_BUS_DUNS_NULL		:=	pInput.line[27..27];
	self.BUS_DUNS_NBR				:=	if ((integer)pInput.line[28..36] = 0,
																		'',	
																		pInput.line[28..36]
																	);
	self.BUS_ENTY_ID				:=	pInput.line[37..47]; 
	self.LHQ_BUS_DUNS_NULL	:=	pInput.line[48..48];
	self.BUS_HQ_DUNS_NBR		:=	if ((integer)pInput.line[49..57] = 0,
																		'',
																		pInput.line[49..57]
																	);
	self.BUS_HQ_ENTITY_ID		:=	if ((integer)pInput.line[58..68] = 0,
																		'',
																		pInput.line[58..68]
																	);
	self.BUS_CITY_CD				:=	if ((integer)pInput.line[69..72] = 0,
																		'',
																		pInput.line[69..72]
																	);
	self.BUS_ST_CD					:=	if ((integer)pInput.line[73..75] = 0,
																		'',
																		pInput.line[73..75]
																	);
	self.ASGE_INDC					:=	pInput.line[76..76];		
	self.FILG_NME						:=	pInput.line[77..196];		
	self.FILG_STR_ADR				:=	pInput.line[197..260];		
	self.FILG_CITY_NME			:=	pInput.line[261..290];	
	self.FILG_ST_NAME				:=	pInput.line[291..292];	
	self.FILG_FOR_REG				:=	pInput.line[293..362];		
	self.FILG_CTRY_NME			:=	pInput.line[363..402];	
	self.FILG_POST_CD				:=	pInput.line[403..411];
	self.MTCH_TYPE_CD				:=	pInput.line[412..412];	
	self.prep_addr_line1		:=	pInput.line[197..260];
	self.prep_addr_last_line:=	if	(pInput.line[261..290] != '',
																			StringLib.StringCleanSpaces(trim(pInput.line[261..290]) + ', ' + trim(pInput.line[291..292]) + ' ' + trim(pInput.line[403..407])),
																			StringLib.StringCleanSpaces(trim(pInput.line[291..292]) + ' ' + trim(pInput.line[403..407]))
																	);	
	self										:=	[];
end;
	
SecuredPartyIn	:=	project(dsInput(line[1..4]='FSEA'),trfSecuredParty(left));


SecuredParty									:=	output(SecuredPartyIn,,'~thor_data400::in::uccv2::'+filedate+'::dnb::securedparty',overwrite);
AddSupersecuredparty					:=	fileservices.addsuperfile('~thor_data400::in::uccv2::DNB::securedparty','~thor_data400::in::uccv2::'+filedate+'::dnb::securedparty');
AddSupersecuredpartyProcessed	:=	fileservices.addsuperfile('~thor_data400::in::uccv2::DNB::securedparty::processed','~thor_data400::in::uccv2::'+filedate+'::dnb::securedparty');

UCCV2.Layout_File_DnB_Signer_in	trfSignor(UCCV2.Layout_File_Variable_All	pInput)	:=	transform
	self.process_date				:=	filedate;
	self.ENTITY_ID					:=	pInput.line[1..6];
	self.ACTION_CODE				:=	pInput.line[7];
	self.DEF_GLOBAL_AGN			:=	pInput.line[8];
	self.DEF_DATA_LENGTH		:=	(string)(integer)pInput.line[9..12];	
	self.F_FING_ENTY_ID			:=	pInput.line[13..23];	
	self.FING_DBTR_SEQ			:=	pInput.line[24..26];
	self.FING_SGNR_SEQ_NBR	:=	(string)(integer)pInput.line[27..28];
	self.FING_SGNR_TTL			:=	fGetTitle(pInput.line[29..32]);
	self.FING_SGNR_TTL2			:=	fGetTitle(pInput.line[33..36]);	
	self.FING_SGNR_TTL3			:=	fGetTitle(pInput.line[37..40]);		
	self.INDV_NME						:=	pInput.line[41..115];
	self.FING_SGNR_TTL_DESC	:=	pInput.line[116..155];	
end;
	
SignorIn	:=	project(dsInput(line[1..4]='FSBH'),trfSignor(left));

signor									:=	output(SignorIn,,'~thor_data400::in::uccv2::'+filedate+'::dnb::signer',overwrite);
AddSupersignor					:=	fileservices.addsuperfile('~thor_data400::in::uccv2::DNB::signer','~thor_data400::in::uccv2::'+filedate+'::dnb::signer');
AddSupersignorProcessed	:=	fileservices.addsuperfile('~thor_data400::in::uccv2::DNB::signer::processed','~thor_data400::in::uccv2::'+filedate+'::dnb::signer');

statsds := uccv2.File_DnB_FinancingStatement_in(FILG_OFC_ST_NME <> '');

string_rec := record
	string name := 'UCC';
	statsds.FILG_OFC_ST_NME;
	count(group);
end;

ds := sort(table(statsds,string_rec,FILG_OFC_ST_NME,few),FILG_OFC_ST_NME);

stats_rec := record
	string name := 'UCC';
	string states := '';
end;	



ds1 := dataset([{'UCC',''}],stats_rec);


stats_rec norm_recs(ds1 l,ds r) := transform
	self.states := l.states + r.FILG_OFC_ST_NME + '\n';
	self := l;
end;

norm_out := denormalize(ds1,ds,left.name = right.name,
						norm_recs(left,right));

						
retval := if (fileservices.getsuperfilesubcount(Cluster.Cluster_In + 'in::uccv2::US_DNB::ALL') > 0,
							sequential(parallel(	sequential( FinancingStatement
																,AddSuperFinStmt
																,AddSuperFinStmtProcessed
															),
										sequential( FinancingComment
																,AddSuperFinComment
																,AddSuperFinCommentProcessed
															),
										sequential( Collateral
																,AddSuperCollateral
																,AddSuperCollateralProcessed
															),
										sequential( CollateralItem
																,AddSuperCollateralItem
																,AddSuperCollateralItemProcessed
															),	
										sequential( debtor
																,AddSuperdebtor
																,AddSuperdebtorProcessed
															),	
										sequential( SecuredParty
																,AddSuperSecuredParty
																,AddSuperSecuredPartyProcessed
															),
										sequential( signor
																,AddSupersignor
																,AddSupersignorProcessed
															)																
										),
										if (not Tools._Constants.IsDataland,
													FileServices.sendemail('Anantha.Venkatachalam@lexisnexisrisk.com,randy.reyes@lexisnexisrisk.com, data.receiving@lexisnexis.com','UCC US DNB STATE STATS - ' + filedate,
																									norm_out[1].states
																								 )
												)
											)
										,
										output('No new files available for us_dnb')
										);

 
return retval;

end;