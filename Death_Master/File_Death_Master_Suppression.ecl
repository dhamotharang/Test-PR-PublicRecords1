﻿IMPORT	Death_Master,	Header,	ut;

//	To manually suppress a record add the record in V3 Format to this dataset.
//	This attribute suppresses on DID, SSN and State Death ID.
//	Comment out values on which you don't want to suppress and replace with ''
dSuppressRecs				:=	
	DATASET([
	// Bug: 177617 - Please remove Deceased record
		{'000059271196', 100, '20140303', ' ', ' ', '         ', 'ANDERSON            ', '    ', 'EVELYN         ', 'E              ', ' ', '20111203', '19290329', '18', '     ', '     ', 'IN', '   ', '  ', 'N', 'OBD', /*'OB00000022643595'*/'', 'OB', 'N'},
	// Bug: 175339 - Deceased record linked to alive person
		{'001370554281', 85, '20140303', ' ', ' ', '         ', 'JAMES               ', '    ', 'KYLE           ', '               ', ' ', '20130115', '19550601', '01', '     ', '     ', 'AL', '   ', '  ', 'N', 'OBD', /*'OB00000025329895'*/'', 'OB', 'N'},
	// Bug: 180986 - Linking of Robert Leche Johnston (64698)
		{'001148831985', 100, '20140731', ' ', ' ', '         ', 'JOHNSTON            ', '    ', 'ROBERT         ', 'LONNIE         ', ' ', '20140704', '19441101', '13', '     ', '     ', 'GA', '   ', '  ', 'N', 'TRB', /*'TR00000101493557'*/'', 'TR', 'N'},
	// Bug: 181280 - appended deceased record for Joann Burke DID 000325978840 (cdd64497)
		{'000325978840', 88, '20140303', ' ', ' ', '         ', 'BURKE               ', '    ', 'JOAN           ', 'M              ', ' ', '20110415', '19350814', '24', '     ', '     ', 'MD', '   ', '  ', 'N', 'OBD', /*'OB00000021208933'*/'', 'OB', 'N'},
	// Bug: 181745 - appended deceased records for Olga Uribe (64513)
		{'000885565998', 100, '20140303', ' ', ' ', '         ', 'URIBE               ', '    ', 'OLGAMARIA      ', 'G              ', ' ', '20131211', '19430831', '48', '     ', '     ', 'TX', '   ', '  ', 'N', 'OBD', /*'OB00000027455501'*/'', 'OB', 'N'}, 
		{'000885565998', 100, '20131226', ' ', ' ', '         ', 'URIBE               ', '    ', 'OLGAMARIA      ', 'G              ', ' ', '20131211', '19430831', '48', '     ', '     ', 'TX', '   ', '  ', 'N', 'TRB', /*'TR00000097376529'*/'', 'TR', 'N'},
	// Bug: 182456 - Escalation-Appended deceased record to Janet Bleckley ACC 64782
		{'000170829650', 100, '20080620', ' ', ' ', '         ', 'WILLIAMS            ', '    ', 'JANE           ', 'MARIE          ', ' ', '20010726', '19580614', '25', '02121', '     ', 'MA', '025', '  ', 'Y', 'MAS', /*'0396211500048091'*/'', 'DE', 'N'},
	// Bug: 182581 - Alive person marked as deceased
		{'000926850389', 99, '20100930', ' ', ' ', '         ', 'GILLESPIE           ', '    ', 'CLARKE         ', 'BARKLEY        ', ' ', '19901102', '        ', '48', '     ', '     ', 'TX', '439', '  ', 'Y', 'TEX', /*'T201010113725317'*/'', 'DE', 'N'},
	// Bug: 174674 - appended deceased record (Accurint 60134) - 2638083004
		{'002638083004', 85, '20140303', ' ', ' ', '         ', 'WALLER              ', 'JR  ', 'JOHNNY         ', '               ', ' ', '20120826', '19470401', '48', '     ', '     ', 'TX', '   ', '  ', 'N', 'OBD', /*'OB00000024412327'*/'', 'OB', 'N'},
	// Bug: 173682 - Deceasd linked to alive person
		{'001249117428', 85, '20140327', ' ', ' ', '         ', 'JOHNSON             ', '    ', 'NITA           ', '               ', ' ', '20140319', '19630404', '02', '     ', '     ', 'AK', '   ', '  ', 'N', 'TRB', /*'TR00000101053639'*/'', 'TR', 'N'}, 
		{'001249117428', 85, '20140331', ' ', ' ', '         ', 'JOHNSON             ', '    ', 'NITA           ', '               ', ' ', '20140321', '19630404', '02', '     ', '     ', 'AK', '   ', '  ', 'N', 'OBD', /*'OB00000028100405'*/'', 'OB', 'N'},
	// Bug: 183783 - Alive person marked as deceased
		{'002699777941', 98, '20100930', ' ', ' ', '         ', 'WHITEHURST          ', '    ', 'NEWBERN        ', 'HENRY          ', ' ', '19990306', '        ', '48', '     ', '     ', 'TX', '201', '  ', 'Y', 'TEX', /*'T201010112834200'*/'', 'DE', 'N'},
	// Bug: 177692 - Alive person being reported as deceased
		{'000351120961', 100, '20140303', ' ', ' ', '         ', 'KALIMAN             ', '    ', 'LOUIE          ', '               ', ' ', '20131001', '19440720', '53', '     ', '     ', 'WA', '   ', '  ', 'N', 'OBD', /*'OB00000026996751'*/'', 'OB', 'N'},
	// Bug: 185369 - appended deceased record- David R Carter (65109)
		{'000388100782', 85, '20131226', ' ', ' ', '         ', 'CARTER              ', '    ', 'DAVID          ', 'R              ', ' ', '19760422', '19600508', '  ', '     ', '     ', '  ', '   ', '  ', 'N', 'TRB', /*'TR00000096794519'*/'', 'TR', 'N'},
	// Bug: 185762 - TX Deceased records mixed SR/JR records 
		{'000428429018', 100, '20100930', ' ', ' ', '         ', 'DE ROUEN            ', '    ', 'CHARLES        ', 'JOSEPH         ', ' ', '19970219', '        ', '48', '     ', '     ', 'TX', '439', '  ', 'Y', 'TEX', /*'T201010111109763'*/'', 'DE', 'N'},
	// Bug: 183908 - Escalation-Appended deceased record to John Kevin Conboy ACC 64612
		{'000494472116', 100, '20140303', ' ', ' ', '         ', 'CONBOY              ', '    ', 'JOHN           ', 'K              ', ' ', '20130623', '19471114', '06', '     ', '     ', 'CA', '   ', '  ', 'N', 'OBD', /*'OB00000026396940'*/'', 'OB', 'N'},
	// Bug: 181863 - appended deceased record (65196) - William L Martin III
		{'001617966153', 100, '20140303', ' ', ' ', '         ', 'MARTIN              ', 'III ', 'WILLIAM        ', 'L              ', ' ', '20090324', '19470816', '18', '     ', '     ', 'IN', '   ', '  ', 'N', 'OBD', /*'OB00000016447711'*/'', 'OB', 'N'},
	// Bug: 181453 - appended TX deceased record for Samulel Linderman (cdd64338) 
    {'001521720514', 94, '20100930', ' ', ' ', '         ', 'LINDERMAN           ', 'SR  ', 'CURTIS         ', 'L              ', ' ', '19770904', '        ', '48', '     ', '     ', 'TX', '245', '  ', 'Y', 'TEX', /*'T201010114102062'*/'', 'DE', 'N'},
	// Bug: 181732 - appended deceased record (Accurint 64475) - Beverly Williams
    {'002715484375', 85, '20140303', ' ', ' ', '         ', 'WILLIAMS            ', '    ', 'BEVERLY        ', '               ', ' ', '20130727', '19611118', '06', '     ', '     ', 'CA', '   ', '  ', 'N', 'OBD', /*'OB00000026613801'*/'', 'OB', 'N'},
	// Bug: 185218 - Accurint 66018-Deceased Indicator Dispute
    {/*'000192383723'*/'', 98, '20060526', ' ', ' ', '         ', 'BERKSTEINER         ', '    ', 'JOSEPH         ', 'T              ', ' ', '19860728', '        ', '13', '     ', '     ', 'GA', '051', '  ', 'Y', 'GAH', '0391512106814564', 'DE', 'N'},
	// Bug: 186475 - appended deceased record (66270) - Larry Jackson
    {'001218371357', 100, '20130524', ' ', ' ', '         ', 'JACKSON             ', '    ', 'LARRY          ', '               ', ' ', '20060308', '19520707', '13', '31545', '     ', 'GA', '305', '  ', 'Y', 'GAA', /*'GA00000002447785'*/'', 'D3', 'N'},
	// Bug: 186895 - Accurint 66388-Deceased Indicator Dispute - DID - 117851000
    {'000117851000', 89, '20140530', ' ', ' ', '         ', 'BAKER               ', 'JR  ', 'ROBERT         ', 'JETHRO         ', ' ', '20140330', '00000000', '39', '43046', '     ', 'OH', '045', '  ', 'N', 'TRB', /*'TR00000101151215'*/'', 'TR', 'N'},
	// Bug: 186732 - Another Texas State Direct Deceased person linked to the wrong person
		{'000671532714', 96, '20100930', ' ', ' ', '         ', 'DONSBACH            ', '    ', 'CALVIN         ', 'DONALD         ', ' ', '19801111', '        ', '48', '     ', '     ', 'TX', '029', '  ', 'Y', 'TEX', /*'T201010110103277'*/'', 'DE', 'N'},
	// Bug: 182357 - Question on deceased data - DID - 2524359386 
    {'002524359386', 94, '20100930', ' ', ' ', '         ', 'THORMAN             ', '    ', 'CLOY           ', 'CHRISTOPHER    ', ' ', '19800215', '        ', '48', '     ', '     ', 'TX', '029', '  ', 'Y', 'TEX', /*'T201010112403480'*/'', 'DE', 'N'},
	// Bug: 188578 - Accurint 66735-Deceased Indicator Dispute - DID - 137746837
    {'000137746837', 85, '20140303', ' ', ' ', '         ', 'BARLEY              ', '    ', 'COLETA         ', '               ', ' ', '20040229', '        ', '48', '79563', '     ', 'TX', '441', '  ', 'N', 'OBD', /*'OB00000004223190'*/'', 'OB', 'N'},
	// Bug: 189808 - Linking for William Thomas LexID 2514844037 (66936) 
    {'002514844037', 85, '20140303', ' ', ' ', '         ', 'THOMAS              ', '    ', 'WILLIAM        ', 'M              ', ' ', '20061201', '19110727', '36', '     ', '     ', 'NY', '   ', '  ', 'N', 'OBD', /*'OB00000010910659'*/'', 'OB', 'N'},
	// Bug: 188964 - Deceased Indicator Dispute
    {/*'005874237166'*/'', 100, '20060526', ' ', ' ', /*'245314017'*/'', 'BUNDY               ', '    ', 'NANNIE         ', 'JUANITA        ', ' ', '19920203', '19101003', '37', '27893', '     ', 'NC', '195', '  ', 'Y', 'NCA', '0391512112681339', 'DE', 'N'},
	// Bug: 189056  - Deceased Indicator Dispute
    {/*'126169415702'*/'', 100, '20060526', ' ', ' ', /*'590141007'*/'', 'MILLER              ', '    ', 'GLORIA         ', '               ', ' ', '20020505', '19290119', '12', '33133', '     ', 'FL', '086', '  ', 'Y', 'FLH', '0391512106140073', 'DE', 'N'},
	// Bug: 189064 - Deceased Indicator Dispute
    {/*'001028571208'*/'', 100, '20140607', ' ', ' ', /*'476924887'*/'', 'LO                  ', '    ', 'VA             ', 'THAI           ', ' ', '20140519', '19450117', '27', '55122', '     ', 'MN', '037', '  ', 'Y', 'MIN', 'MN00000009546723', 'DE', 'N'},
	// Bug: 190097 - ESCALATION Deceased record for LexID 1183611802 (67242)
    {/*'001183611802'*/'', 100, '20130222', ' ', ' ', /*'076306356'*/'', 'HUDSON              ', '    ', 'MILDRED        ', 'WOULARD        ', ' ', '20120402', '19400323', '12', '32168', '     ', 'FL', '127', '  ', 'Y', 'FLH', '0413290000034750', 'DE', 'N'},
    {/*'001183611802'*/'', 100, '20120622', ' ', ' ', /*'076306356'*/'', 'HUDSON              ', '    ', 'MILDRED        ', 'WOULARD        ', ' ', '20120402', '19400323', '12', '32168', '     ', 'FL', '127', '  ', 'Y', 'FLH', '0410821500049119', 'DE', 'N'},
	// Bug: 190188 - Deceased record for LexID 002439830206 (67232)
    {/*'002439830206'*/'', 100, '20080808', ' ', ' ', /*'422232977'*/'', 'STEWART             ', '    ', 'WALTER         ', 'GABRIEL        ', ' ', '20080330', '19750517', '12', '32817', '     ', 'FL', '095', '  ', 'Y', 'FLH', '0396701400024566', 'DE', 'N'},
	// Bug: 174459 - Alive person marked as deceased - DID 673018079
    {'000673018079', 89, '20140303', ' ', ' ', '         ', 'DORSEY              ', '    ', 'CHARLES        ', 'H              ', ' ', '20090503', '19260220', '11', '     ', '     ', 'DC', '   ', '  ', 'N', 'OBD', /*'OB00000016694763'*/'', 'OB', 'N'},
	// Bug: 183445 - Accurint 65592-Deceased Indicator Dispute
    {'000683659353', 94, '20140303', ' ', ' ', '         ', 'DRIGGERS            ', 'JR  ', 'GORDON         ', 'B              ', ' ', '20041213', '        ', '45', '29461', '     ', 'SC', '015', '  ', 'N', 'OBD', /*'OB00000006037917'*/'', 'OB', 'N'},
	// Bug: 190223 - appended deceased record LexID 956179776 Emmett Gomez (67237)
    {'000956179776', 85, '20140303', ' ', ' ', '         ', 'GOMEZ               ', '    ', 'AMADO          ', '               ', ' ', '20130223', '19550101', '48', '     ', '     ', 'TX', '   ', '  ', 'N', 'OBD', /*'OB00000025679971'*/'', 'OB', 'N'},
	// Bug: 190788 - Appended deceased record (67178) Thomas Keith
    {'000736210335', 85, '20140303', ' ', ' ', '         ', 'KELLY               ', '    ', 'THOMAS         ', 'M              ', ' ', '20120513', '19571231', '42', '     ', '     ', 'PA', '   ', '  ', 'N', 'OBD', /*'OB00000023752787'*/'', 'OB', 'N'},
	// Bug: 191017 - Accurint 67421-Deceased Indicator Dispute
    {'001723565402', 85, '20150305', ' ', ' ', '         ', 'MILLER              ', '    ', 'ALAN           ', 'R              ', ' ', '20150219', '19490829', '20', '     ', '     ', 'KS', '   ', '  ', 'N', 'OBD', /*'OB00000030467946'*/'', 'OB', 'N'},
	// Bug: 192376 - Death record for Clifford Woodruff (cdd 67815)
    {'002760826591', 100, '20140303', ' ', ' ', '         ', 'WOODRUFF            ', '    ', 'CLIFFORD       ', 'E              ', ' ', '20090625', '19340213', '06', '     ', '     ', 'CA', '   ', '  ', 'N', 'OBD', /*'OB00000017147174'*/'', 'OB', 'N'},
	// Bug: 184123 - Accurint 65745-Deceased Indicator Dispute - DID - 1921444406
    {'001921444406', 85, '20150604', ' ', ' ', '         ', 'RICE                ', '    ', 'LISA           ', 'P              ', ' ', '20040819', '19631026', '48', '     ', '     ', 'TX', '   ', '  ', 'N', 'OBD', /*'OB00000005329419'*/'', 'OB', 'N'},
	// Bug: 185101 - RE: Record with incorrect deceased information
    {'000025137624', 100, '20151130', ' ', ' ', /*'264472450'*/'', 'SIEGEL              ', '    ', 'ALAN           ', 'DAVID          ', ' ', '20051217', '19600419', '12', '33071', '     ', 'FL', '011', '  ', 'N', 'ENC', /*'000025137624SENC'*/'', '64', 'N'},
	// Bug: 190639 - Appended deceased record for Daniel Kalenak (66190)
    {'001298450311', 100, '20140303', ' ', ' ', '         ', 'KALENAK             ', '    ', 'DAN            ', '               ', ' ', '20120123', '19240815', '48', '     ', '     ', 'TX', '   ', '  ', 'N', 'OBD', /*'OB00000023000605'*/'', 'OB', 'N'},
	// Bug: 194185 - Accurint 68345-Deceased Indicator Dispute - DID - 2367673245
    {'002367673245', 89, '20140303', ' ', ' ', '         ', 'SMITH               ', '    ', 'GEORGE         ', 'W              ', ' ', '20000423', '19381009', '21', '42431', '     ', 'KY', '107', '  ', 'N', 'OBD', /*'OB00000000068721'*/'', 'OB', 'N'},
	// Bug: 194659 - Alive person marked as deceased
    {'000567638929', 85, '20140303', ' ', ' ', '         ', 'MEYER               ', '    ', 'DANIEL         ', '               ', ' ', '20130314', '19530101', '29', '     ', '     ', 'MO', '   ', '  ', 'N', 'OBD', /*'OB00000025797992'*/'', 'OB', 'N'},
	//	Bug: 180081 - Deceasd linked to alive person (male v. female too) 
    {'001841480469', 85, '20140303', ' ', ' ', '         ', 'CLARK               ', '    ', 'STEVEN         ', '               ', ' ', '20100528', '19630812', '42', '     ', '     ', 'PA', '   ', '  ', 'N', 'OBD', /*'OB00000019095086'*/'', 'OB', 'N'}, 
	//	Bug: 185689 - A4L - Deceased records webstar: 6102360
    {'002795591192', 100, '20151217', ' ', ' ', '         ', 'ZAMBRANA            ', '    ', 'RAUL           ', 'M              ', ' ', '        ', '19690326', '51', '22003', '     ', 'VA', '059', '  ', 'N', 'TUN', /*'002795591192ZTUN'*/'', 'TN', 'Y'},
	//	Bug: 189318 - Query is coming back deceased
    {'002227821206', 100, '20151217', ' ', ' ', '         ', 'RYNKOWSKI           ', '    ', 'MARY           ', 'J              ', ' ', '        ', '        ', '26', '49686', '     ', 'MI', '055', '  ', 'N', 'TUN', /*'002227821206RTUN'*/'', 'TN', 'Y'}, 
	//	Bug: 195817 - Accurint 68915-Deceased Indicator Dispute - DID - 904907402
    {'000904907402', 97, '20140303', ' ', ' ', '         ', 'LEWIS               ', '    ', 'CYNTHIA        ', 'L              ', ' ', '20090705', '19541203', '37', '     ', '     ', 'NC', '   ', '  ', 'N', 'OBD', /*'OB00000017074557'*/'', 'OB', 'N'}, 
	//	Bug: 196245 - (Secure) FW: Deceased Accurint - T400032054 J CALLAN - DID - 351765897
    {'000351765897', 75, '20160104', ' ', ' ', /*'540820313'*/'', 'CALLAN              ', '    ', 'JOSEPH         ', 'ALBERT         ', ' ', '        ', '19641117', '04', '85029', '     ', 'AZ', '013', '  ', 'N', 'ENC', /*'000351765897CENC'*/'', '64', 'N'}, 
	//	Bug: 196377 - Death Master Record appended to incorrect social CDD: 69261	
    {/*'000000000000'*/'', 0, '20130524', ' ', ' ', /*'564299657'*/'', 'BRUMBLEY            ', '    ', 'MAXINE         ', 'IMOGENE        ', ' ', '20010329', '19260429', '06', '     ', '     ', 'CA', '   ', '  ', 'Y', 'CAL', 'CA00000000697082', 'D0', 'N'}, 
	//	Bug: 197617 - Un-append death Record from William King CDD: 69691
    {'000450840669', 99, '20130524', ' ', ' ', '         ', 'KING                ', '    ', 'WILLIAM        ', 'C              ', ' ', '20100130', '19531009', '13', '     ', '     ', 'GA', '001', '  ', 'Y', 'GAA', /*'GA00000005306875'*/'', 'D3', 'N'},
	//	Bug: 197303 - Accurint 69598-Deceased Indicator Dispute
    {'000759763640', 94, '20151210', ' ', ' ', '         ', 'MARTINEZ            ', '    ', 'ERNESTO        ', '               ', ' ', '20151203', '19590824', '34', '     ', '     ', 'NJ', '   ', '  ', 'N', 'TRB', /*'TR00000103073316'*/'', 'TR', 'N'},
	//	Bug: 198069 - Unlink appended Deathmaster record to William Lee Jr CDD: 69831
    {'001492963391', 89, '20150827', ' ', ' ', '         ', 'LEE                 ', 'JR  ', 'WILLIAM        ', 'R              ', ' ', '20150811', '19610916', '01', '     ', '     ', 'AL', '   ', '  ', 'N', 'OBD', /*'OB00000031812336'*/'', 'OB', 'N'},
	//	Bug: 198113 - appended deceased record for Michael Hall (62800) 
    {'001035055294', 85, '20140303', ' ', ' ', '         ', 'HALL                ', '    ', 'MICHAEL        ', 'E              ', ' ', '20120313', '19820521', '40', '     ', '     ', 'OK', '   ', '  ', 'N', 'OBD', /*'OB00000023355728'*/'', 'OB', 'N'},
	//	Bug: 198668 - Appended deceased record for David Herrera (66179)
    {'000576003154', 100, '20140303', ' ', ' ', '         ', 'HERRERA             ', '    ', 'DAVID          ', 'J              ', ' ', '20041126', '19720320', '06', '90680', '     ', 'CA', '059', '  ', 'N', 'OBD', /*'OB00000005903867'*/'', 'OB', 'N'},
 	//	Bug: 198004 - Accurint 69742-Deceased indicator dispute
		{'001195854194', 89, '20130919', ' ', ' ', '         ', 'HUNTZINGER          ', 'SR  ', 'JOHN           ', 'CHARLES        ', ' ', '20130910', '00000000', '10', '19963', '     ', 'DE', '005', '  ', 'N', 'TRB', /*'TR00000096391316'*/'', 'TR', 'N'},
	//	Bug: 200469 - Accurint 70571-Deceased Indicator Dispute
		{/*'000000000000'*/'', 0, '20130524', ' ', ' ', /*'498644749'*/'', 'FARRISJEWELL        ', '    ', 'LOURAINE       ', 'HARRIET        ', ' ', '20021112', '19210427', '06', '     ', '     ', 'CA', '   ', '  ', 'Y', 'CAL', 'CA00000001621631', 'D0', 'N'},
	//	Bug: 200857 - IL_Janie_Arington_Federal_Deceased - DID -79078379
		{'000079078379', 85, '20140303', ' ', ' ', '         ', 'ARRINGTON           ', '    ', 'JOHN           ', 'L              ', ' ', '20120801', '19510126', '42', '     ', '     ', 'PA', '   ', '  ', 'N', 'OBD', /*'OB00000024273545'*/'', 'OB', 'N'},
	//	Bug: 201720 - Accurint 70955-Deceased Indicator Dispute - DID - 2661186101
    {'002661186101', 85, '20140213', ' ', ' ', '         ', 'WATSON              ', '    ', 'DONNA          ', '               ', ' ', '20140119', '19570802', '06', '     ', '     ', 'CA', '   ', '  ', 'N', 'TRB', /*'TR00000099683503'*/'', 'TR', 'N'},
	//	Bug: 202676 - Death record for Leonard Pirilla CDD 69454
    {'001983122895', 100, '20160311', ' ', ' ', '168345286', 'PIRILLA             ', '    ', 'LEONARD        ', 'J              ', ' ', '        ', '19430108', '42', '15473', '     ', 'PA', '051', '  ', 'N', 'ENC', /*'001983122895PENC'*/'', '64', 'N'},
	//	Bug: 202383 - Red Cross Deceased Discrepancy
    {'074514314767', 94, '20140303', ' ', ' ', '         ', 'RIFFINDIFIL         ', '    ', 'ANNA           ', '               ', ' ', '20110314', '        ', '42', '17820', '     ', 'PA', '037', '  ', 'N', 'OBD', /*'OB00000020977924'*/'', 'OB', 'N'},
	//	Bug: 198899 - Consumer is not deceased 70097 - DID - 1246370291
    {'001246370291', 80, '20160325', ' ', ' ', '         ', 'JINDAL              ', '    ', 'PARVEEN        ', 'KUMAR          ', ' ', '20120522', '        ', '06', '93701', '     ', 'CA', '019', '  ', 'N', 'ENC', /*'001246370291JENC'*/'', '64', 'N'},
	//	Bug: 203766 - Death Master - Suppress FL death record with DID 2548222553
	//	DF-16175 - Death Master - Suppress LexID=2548222553 from all sources
    {'002548222553', 100, '20060526', ' ', ' ', /*'181469904'*/'', 'TRAPP               ', '    ', 'DAVID          ', 'ALAN           ', ' ', '20040112', '19561217', '12', '34773', '     ', 'FL', '097', '  ', 'Y', 'FLH', '0391512106549450', 'DE', 'N'},
	//	Bug: 203263 - Deceased Accurint ~ 4902756 Dan Pearson - DID - 1937212833
	//	DF-16074 - Deceased Accurint ~ 4902756 Dan Pearson - DID - 1937212833
		{'001937212833', 100, '20160324', ' ', ' ', '         ', 'PEARSON             ', '    ', 'DANIEL         ', 'D              ', ' ', '        ', '        ', '09', '06472', '     ', 'CT', '009', '  ', 'N', 'TUN', '001937212833PTUN', 'TN', 'Y'},
	//	DF-14558 - Unlink Death Record from LexID 2706392895 Janet Yoder
		{'002706392895', 75, '20160408', ' ', ' ', '         ', 'YODER               ', '    ', 'JANET          ', 'SUE            ', ' ', '20150524', '        ', '20', '67214', '     ', 'KS', '173', '  ', 'N', 'ENC', /*'002706392895YENC'*/'', '64', 'N'},
	//	DF-16604	Incorrectly Appended Death Record for RIchard Benson CDD:72871
    {'000187718731', 100, '20140303', ' ', ' ', '         ', 'BENSON              ', '    ', 'RICHARD        ', 'A              ', ' ', '20130811', '19290517', '17', '     ', '     ', 'IL', '   ', '  ', 'N', 'OBD', /*'OB00000026684478'*/'', 'OB', 'N'},
	//	DF-15688	Accurint 70169-Deceased Indicator Dispute - DID - 2651538097
    {'002651538097', 100, '20160422', ' ', ' ', '         ', 'WARDLEIGH           ', '    ', 'JAMES          ', 'P              ', ' ', '        ', '19391117', '32', '89502', '     ', 'NV', '031', '  ', 'N', 'TUN', /*'002651538097WTUN'*/'', 'TN', 'Y'},
	//	DF-15859	Person incorrectly listed as deceased
    {'002314318059', 85, '20140731', ' ', ' ', '         ', 'WILLIAMS            ', '    ', 'ALICE          ', 'L              ', ' ', '20101108', '19480809', '05', '     ', '     ', 'AR', '   ', '  ', 'N', 'OBD', /*'OB00000028921001'*/'', 'OB', 'N'}, 
	//	DF-15990	Unlinking of appended death record for Norma A Roberts
    {'002165643692', 85, '20150903', ' ', ' ', '         ', 'ROBERTS             ', '    ', 'NORMA          ', '               ', ' ', '20150818', '19480111', '12', '     ', '     ', 'FL', '   ', '  ', 'N', 'OBD', /*'OB00000031863959'*/'', 'OB', 'N'}, 
	//	DF-16232	Death record appended incorrectly to Eleanor Kelly CDD: 71947
    {'001370959570', 97, '20140303', ' ', ' ', '         ', 'KELLY               ', '    ', 'ELLEN          ', 'K              ', ' ', '20061222', '19510619', '30', '     ', '     ', 'MT', '   ', '  ', 'N', 'OBD', /*'OB00000011069121'*/'', 'OB', 'N'}, 
	//	DF-16350	Accurint 72201 Deceased Indicator Dipsute
    {'001576145339', 85, '20140303', ' ', ' ', '         ', 'MACLEAN             ', 'JR  ', 'ALLAN          ', 'P              ', ' ', '20001007', '        ', '25', '01824', '     ', 'MA', '017', '  ', 'N', 'OBD', /*'OB00000000387422'*/'', 'OB', 'N'},
	//	DF-16607	Unlinking death record incorrectly appended CDD: 72854
    {'001271895302', 85, '20140303', ' ', ' ', '         ', 'JONES               ', 'JR  ', 'ROBERT         ', 'J              ', ' ', '20070211', '19600706', '53', '     ', '     ', 'WA', '   ', '  ', 'N', 'OBD', /*'OB00000011480221'*/'', 'OB', 'N'}, 
	//	DF-16703	Deceased indicator Accurint 69564
    {'001425227676', 100, '20160526', ' ', ' ', '         ', 'KOZLOWSKI           ', '    ', 'SANDRA         ', 'J              ', ' ', '        ', '19500702', '08', '80132', '     ', 'CO', '041', '  ', 'N', 'TUN', /*'001425227676KTUN'*/'', 'TN', 'Y'}, 
	//	DF-16222	Accurint 71811-Deceased Indicator Dispute
    {'001971411599', 85, '20151022', ' ', ' ', '         ', 'PHILLIPS            ', '    ', 'JOHN           ', 'F              ', ' ', '20151004', '19370822', '18', '     ', '     ', 'IN', '   ', '  ', 'N', 'OBD', /*'OB00000032184639'*/'', 'OB', 'N'}, 
	//	DF-16676	Incorrectly appended Death Record for Richard Zackavich CDD:72980
    {'002794227350', 85, '20150917', ' ', ' ', '         ', 'ZACKAVICH           ', '    ', 'RICHARD        ', 'I              ', ' ', '20150902', '        ', '34', '08028', '     ', 'NJ', '015', '  ', 'N', 'OBD', /*'OB00000031948659'*/'', 'OB', 'N'},
	//	DF-16858	Consumer marked as deceased but is alive
		{'000752725740', 98, '20160603', ' ', ' ', '         ', 'STEWART             ', '    ', 'JOHN           ', 'ROBERT         ', ' ', '20140724', '19420530', '49', '84121', '     ', 'UT', '035', '  ', 'N', 'ENC', /*'000752725740SENC'*/'', '64', 'N'},
	//	DF-16285	Consumer Reporting as Deceased CDD: 72022 - DID - 2441972767
    {'002441972767', 100, '20160526', ' ', ' ', '         ', 'STINNER             ', '    ', 'JEAN           ', 'M              ', ' ', '        ', '19541101', '42', '19382', '     ', 'PA', '029', '  ', 'N', 'TUN', /*'002441972767STUN'*/'', 'TN', 'Y'},
	//	DF-16510	Incorrectly Appended Death Record CDD:72561
    {'001056563020', 99, '20160617', ' ', ' ', '         ', 'HARKINS             ', '    ', 'WILLIAM        ', '               ', ' ', '        ', '        ', '42', '16666', '     ', 'PA', '033', '  ', 'N', 'ENC', /*'001056563020HENC'*/'', '64', 'N'},
	//	DF-16578	Death record incorrectly appended for Tracey Carruthers CDD: 72764
    {'000660140505', 89, '20140303', ' ', ' ', '         ', 'DIXON               ', '    ', 'STACEY         ', 'M              ', ' ', '20100417', '19781118', '47', '     ', '     ', 'TN', '   ', '  ', 'N', 'OBD', /*'OB00000018867608'*/'', 'OB', 'N'}, 
	//	DF-16946	Deceased Indicator Accurint 72997
    {'002781046806', 100, '20160621', ' ', ' ', '         ', 'ARDAVAN             ', '    ', 'YAZDI          ', '               ', ' ', '        ', '        ', '06', '90037', '     ', 'CA', '037', '  ', 'N', 'TUN', /*'002781046806ATUN'*/'', 'TN', 'Y'},
	//	DF-16341	(Secure) Deceased Accurint ~ UL10030419 *encrypt*
    {'000729753505', 100, '20160720', ' ', ' ', '         ', 'PERMAN              ', '    ', 'EDWARD         ', 'P              ', ' ', '        ', '19501121', '42', '15201', '     ', 'PA', '003', '  ', 'N', 'TUN', /*'000729753505PTUN'*/'', 'TN', 'Y'}, 
	//	LNK-27	68168195508281998 Frank P Hixon (Wells Fargo - data question)
    {/*'001140990080'*/'', 100, '20141122', ' ', ' ', '         ', 'HIXON               ', '    ', 'FRANCES        ', 'JEANNE         ', ' ', '20110625', '19361007', '13', '30097', '     ', 'GA', '121', '  ', 'Y', 'GAA', 'GA00000011443635', 'D3', 'N'}, 
	//	DF-17022	Deceased CDD: 73691
    {/*'010951415759'*/'', 100, '20130524', ' ', ' ', /*'548977072'*/'', 'NORTON              ', '    ', 'STEPHEN        ', 'R              ', ' ', '20040521', '19500824', '06', '     ', '     ', 'CA', '   ', '  ', 'Y', 'CAL', 'CA00000003859297', 'D0', 'N'},
	// DF-16885	Question for you
    {/*'000000000000'*/'', 0, '20130705', ' ', ' ', /*'593967461'*/'', 'RAHAMAN             ', '    ', 'ALEEM          ', 'MOHAMED        ', ' ', '20130531', '19580922', '12', '33169', '     ', 'FL', '086', '  ', 'Y', 'FLH', '0414591900011254', 'DE', 'N'},
	//	LNK-50	LPL Financial - Active Client
    {/*'000000000000'*/'', 0, '20140413', ' ', ' ', /*'554371802'*/'', 'YAMAGA              ', '    ', 'CHRISTINA      ', '               ', ' ', '20120719', '19700626', '06', '90805', '     ', 'CA', '037', '  ', 'Y', 'CAL', 'CA00000007511824', 'D0', 'N'},
	//	DF-17483	Requested deceased record be suppressed
    {/*'002767807962'*/'', 100, '20040827', 'C', 'C', '482362482', 'WRAGE               ', '    ', 'MARGERY        ', 'L              ', 'V', '20040711', '19340718', '19', '50677', '     ', 'IA', '017', '  ', 'N', 'SSA', /*'482362482W040711'*/'', 'DE', 'N'},
	//	DF-17084	Accurint 73960 - Deceased Indicator - DID - 47390926095
    {/*'047390926095'*/'', 100, '20130524', ' ', ' ', '         ', 'HAWKINS             ', '    ', 'ASHLEY         ', 'CHARLOTTE      ', ' ', '20120727', '19861021', '39', '44109', '     ', 'OH', '035', '  ', 'Y', 'OHI', 'OH00000001107763', 'D@', 'N'},
	//	LNK-131	Death Master Source? CDD: 76091 KCRAM [Incident: 161006-000070]
    {/*'001858741539'*/'', 100, '20140413', ' ', ' ', /*'626802609'*/'', 'STEVENS             ', '    ', 'GEORGE         ', 'M              ', ' ', '20070531', '19500617', '06', '90293', '     ', 'CA', '037', '  ', 'Y', 'CAL', 'CA00000006944498', 'D0', 'N'}, 
    {/*'001858741539'*/'', 100, '20130524', ' ', ' ', /*'626802609'*/'', 'STEVENS             ', '    ', 'GEORGE         ', 'M              ', ' ', '20070531', '19500617', '06', '     ', '     ', 'CA', '   ', '  ', 'Y', 'CAL', 'CA00000005101742', 'D0', 'N'},
	//	DF-16443	*encrypt* / 1597016 Civic Financial Services, Inc DBA Titan Capital
    {'000603767201', 100, '20160922', ' ', ' ', '         ', 'DE LA TORRE         ', '    ', 'DAVID          ', '               ', ' ', '        ', '        ', '06', '92677', '     ', 'CA', '059', '  ', 'N', 'TUN', /*'000603767201DTUN'*/'', 'TN', 'Y'},
	//	LNK-152	ACCURINT 76549 THERESA JACKSON [Incident: 161024-000238]
    {/*'001464245891'*/'', 100, '20140413', ' ', ' ', /*'567566051'*/'', 'SCHWARTZ            ', '    ', 'GAIL           ', 'JOYCE          ', ' ', '20120304', '19440128', '06', '91306', '     ', 'CA', '037', '  ', 'Y', 'CAL', 'CA00000006862799', 'D0', 'N'},
	//	LNK-150	ACCURINT 75972 - DECEASED INDICATOR CEMBRY [Incident: 161022-000001]
    {/*'002417436184'*/'', 98, '20130524', ' ', ' ', /*'547988296'*/'', 'STANLEY             ', '    ', 'FLOYD          ', 'GENE           ', ' ', '20040812', '19510702', '06', '     ', '     ', 'CA', '   ', '  ', 'Y', 'CAL', 'CA00000005064498', 'D0', 'N'},
	//	LNK-133	Jira ticket needed for Deborah Griffin CDD: 76145 KCRAM [Incident: 161007-001115]
    {'000752877037', 97, '20140303', ' ', ' ', '         ', 'GRIFFIN             ', '    ', 'DEBORAH        ', 'E              ', ' ', '20080820', '19511113', '45', '     ', '     ', 'SC', '   ', '  ', 'N', 'OBD', /*'OB00000015005651'*/'', 'OB', 'N'}, 
	//	LNK-175	ACCURINT 77069 TJACKSON
    {'001399284475', 100, '20161202', ' ', ' ', /*'549484229'*/'', 'KIRBY               ', '    ', 'ROBERT         ', 'ROY            ', ' ', '        ', '19380420', '12', '32891', '     ', 'FL', '095', '  ', 'N', 'ENC', /*'001399284475KENC'*/'', '64', 'N'}, 
	//	LNK-155	Deceased indicator, CDD 76646, T JACKSON [Incident: 161031-000346]
    {'002278815880', 97, '20160901', ' ', ' ', '         ', 'SCHULTZ             ', '    ', 'KENNETH        ', 'L              ', ' ', '20160813', '19440422', '47', '     ', '     ', 'TN', '   ', '  ', 'N', 'OBD', /*'OB00000034584066'*/'', 'OB', 'N'}, 
	//	LNK-77	Fiserv - Deceased Information Being Returned
    {'002464650483', 100, '20161117', ' ', ' ', '         ', 'SULLIVAN            ', '    ', 'PEGGY          ', '               ', ' ', '        ', '19330101', '47', '37211', '     ', 'TN', '037', '  ', 'N', 'TUN', /*'002464650483STUN'*/'', 'TN', 'Y'}, 
	//	LNK-172	RISKVIEW 640039/ACDURINT 29150 TJACKSON [Incident: 161114-000065]
    {/*'002798335886'*/'', 100, '19990501', 'A', 'A', '118562126', 'ZAYAS               ', '    ', 'JOHN           ', '               ', ' ', '19860900', '19680120', '41', '02907', '     ', 'RI', '007', '  ', 'N', 'SSA', /*'118562126Z860900'*/'', 'DE', 'N'}, 
	//	LNK-192	ACCURINT 76932 - CEMBRY DECEASED INDICATOR
    {/*'053497790961'*/'', 100, '20041130', 'A', 'A', '260516594', 'BROWN               ', '    ', 'RASHAWN        ', '               ', ' ', '19870500', '19851106', '11', '31404', '     ', 'GA', '051', '  ', 'N', 'SSA', /*'260516594B870500'*/'', 'DE', 'N'},
	//	LNK-156	Jira Ticket Needed for Jessica Villarreal CDD: 76379 [Incident: 161031-000470]
    {'038898824487', 100, '20170120', ' ', ' ', '         ', 'VILLARREAL          ', '    ', 'JESSICA        ', '               ', ' ', '        ', '19880503', '48', '77506', '     ', 'TX', '201', '  ', 'N', 'TUN', /*'038898824487VTUN'*/'', 'TN', 'Y'},
	//	LNK-268	ACCURINT 77903 - CEMBRY - DECEASED INDCATOR [Incident: 170107-000088]
    {'002745550681', 100, '20161220', ' ', ' ', '         ', 'WINKLER             ', 'JR  ', 'WILLIAM        ', 'E              ', ' ', '        ', '19510719', '20', '67226', '     ', 'KS', '173', '  ', 'N', 'TUN', /*'002745550681WTUN'*/'', 'TN', 'Y'},
	//	LNK-270	ACCURINT 78052 - CEMBRY - DECEASED INDICATOR [Incident: 170107-000133]
    {'059456514174', 100, '20161220', ' ', ' ', '         ', 'BENZANT             ', '    ', 'FRANCHESC      ', '               ', ' ', '        ', '19851223', '24', '20740', '     ', 'MD', '033', '  ', 'N', 'TUN', /*'059456514174BTUN'*/'', 'TN', 'Y'},
	//	LNK-301	Health Equity - Deceased Individual - Hal Rhea
    {'002133451683', 100, '20170120', ' ', ' ', /*'410769187'*/'', 'RHEA                ', '    ', 'HAL            ', 'SALE           ', ' ', '        ', '        ', '47', '38120', '     ', 'TN', '157', '  ', 'N', 'ENC', /*'002133451683RENC'*/'', '64', 'N'},
	//	LNK-327	Accurint 79355 Jerry Huckabey deceased indicator [Incident: 170201-000037]
    {'001181180495', 100, '20170119', ' ', ' ', '         ', 'HUCKABEY            ', '    ', 'JERRY          ', 'A              ', ' ', '20170104', '        ', '47', '37719', '     ', 'TN', '129', '  ', 'N', 'OBD', /*'OB00000035653039'*/'', 'OB', 'N'},
	//	LNK-229	Jira ticket needed for Daniel Matrisciani CDD: 77622 KCRAM [Incident: 161213-000280]
    {'001635264213', 100, '20170120', ' ', ' ', '         ', 'MATRISCIANI         ', '    ', 'DANIEL         ', '               ', ' ', '        ', '        ', '36', '11238', '     ', 'NY', '047', '  ', 'N', 'TUN', /*'001635264213MTUN'*/'', 'TN', 'Y'},
	//	LNK-351	BG#1442904 Linn- Co Federal Credit Union
    {/*'142134905607'*/'', 100, '20040730', 'A', 'A', '543335037', 'DEBUTTS             ', '    ', 'DYLAN          ', 'T              ', 'V', '20040504', '19900524', '41', '97355', '89701', 'OR', '043', '  ', 'N', 'SSA', /*'543335037D040504'*/'', 'DE', 'N'},
	//	LNK-403 Verification for Christine Hemphill CDD 80909 ROSBORNE
    {/*'001100750258'*/'', 100, '20060526', ' ', ' ', /*'249801892'*/'', 'HEMPHILL            ', '    ', 'CHRISTINE      ', '               ', ' ', '20000406', '19420905', '37', '28208', '     ', 'NC', '119', '  ', 'Y', 'NCA', '0391512113008217', 'DE', 'N'},
	//	LNK-178	Acccurint 76985 TJackson
    {'001170416803', 100, '20170221', ' ', ' ', '         ', 'HOSSAIN             ', '    ', 'MUHAMMAD       ', 'ITRAT          ', ' ', '        ', '        ', '48', '77024', '     ', 'TX', '201', '  ', 'N', 'TUN', /*'001170416803HTUN'*/'', 'TN', 'Y'},
	//	LNK-323	Accurint 79134 Francesca Braley [Incident: 170131-001335]
    {'096563050440', 100, '20170407', ' ', ' ', '         ', 'BRALEY              ', '    ', 'FRANCESCA      ', 'E              ', ' ', '        ', '19730209', '51', '22901', '     ', 'VA', '003', '  ', 'N', 'TUN', /*'096563050440BTUN'*/'', 'TN', 'Y'},
	//	LNK-448	Health Equity - Jason Fawson - showing deceased and is not
    {/*'000782011773'*/'', 100, '20060526', ' ', ' ', '         ', 'LAWSON              ', '    ', 'JASON          ', 'D              ', ' ', '19821111', '19800810', '21', '41307', '     ', 'KY', '025', '  ', 'Y', 'KEN', '0391512110524955', 'DE', 'N'},
	//	LNK-533	Lincoln - 0000M72621 - Deceased Accurint (secure)
    {'000812929621', 100, '20170407', ' ', ' ', '         ', 'FINLEY              ', '    ', 'WM             ', 'F              ', ' ', '        ', '        ', '17', '62208', '     ', 'IL', '163', '  ', 'N', 'TUN', /*'000812929621FTUN'*/'', 'TN', 'Y'},
	//	LNK-379	Data Questions SSN deceased indicator... Accurint Dispute-80248 K. Martin [Incident: 170228-000042]
    {'000515930050', 100, '20170606', ' ', ' ', '         ', 'COROTTO             ', '    ', 'MARGARET       ', 'M              ', ' ', '        ', '        ', '06', '95370', '     ', 'CA', '109', '  ', 'N', 'TUN', /*'000515930050CTUN'*/'', 'TN', 'Y'},
	//	LNK-554	Deceased record needs suppressed
    {/*'001928908721'*/'', 100, '20140405', 'A', 'A', '473342533', 'PATTERSON           ', '    ', 'JEROME         ', 'R              ', 'V', '20140326', '19320321', '  ', '     ', '     ', '  ', '   ', '  ', 'N', 'SSA', /*'473342533P140326'*/'', 'DE', 'N'},
	//	LNK-561 Verification for Alfred Macaluso CDD 82462 ROSBORNE [Incident: 170509-000635]
    {'001572278661', 100, '20170602', ' ', ' ', '         ', 'MACALUSO            ', '    ', 'ALFRED         ', 'CHARLES        ', ' ', '19981217', '        ', '17', '60148', '     ', 'IL', '043', '  ', 'N', 'ENC', /*'001572278661MENC'*/'', '64', 'N'},
	//	LNK-575	Alive Consumer marked as deceased
		{/*'001146418435'*/'', 100, '19990501', 'A', 'A', '482563467', 'HOFFMAN             ', '    ', 'SANDRA         ', '               ', ' ', '19861100', '19571206', '23', '48640', '     ', 'MI', '111', '  ', 'N', 'SSA', /*'482563467H861100'*/'', 'DE', 'N'},
	//	LNK-447	Health Equity - Olugbenga Fadare
    {'191961589382', 100, '20170707', ' ', ' ', '         ', 'FADARE              ', '    ', 'OLUGBENGA      ', '               ', ' ', '        ', '19860830', '39', '44118', '     ', 'OH', '035', '  ', 'N', 'TUN', /*'191961589382FTUN'*/'', 'TN', 'Y'},
	// DF-21085 Death Master - Suppress JAMES PALMER death record from SSA
    {'001907266974', 100, '20160617', 'A', 'A', /*'086360734'*/'', 'PALMER              ', '    ', 'JAMES          ', 'LEWIS          ', 'P', '20160610', '19450316', '  ', '     ', '     ', '  ', '   ', '  ', 'N', 'SSA', /*'086360734P160610'*/'', 'D$', 'N'}
	], Header.Layout_Did_Death_MasterV3);

EXPORT	File_Death_Master_Suppression	:=	dSuppressRecs;
