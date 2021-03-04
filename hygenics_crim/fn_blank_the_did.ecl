﻿//bug 29753 highlights a very rare case of 2 individuals with the same name and DOB

	did_st_set := ['WA000137071458'];

	did_vendor_set := ['TB000070308134',	
		'TB000214803073',	
		'TB000330437615',	
		'TB000333276841',	
		'TB000843184142',	
		'TB000959403354',	
		'TB001014056852',	
		'TB001063346398',	
		'TB001067044191',	
		'TB001113850260',	
		'TB001148441584',	
		'TB001163299475',	
		'TB001173820620',	
		'TB001263157971',	
		'TB001369763635',	
		'TB001433214576',	
		'TB001517399556',	
		'TB001759462400',	
		'TB001804364553',	
		'TB002180272453',	
		'TB002182254379',	
		'TB002339383159',	
		'TB002340318797',	
		'TB002786882328',	
		'TB010509176342',	
		'03000035949478',	//vendor code not updated
		'CP001950637938',	
		'CP002712443495',	
		'CP003212683190',	
		'MH002203529056',	
		'TA050127759775',	
		'NF000122483251',	
		'NF000254820120',	
		'NF000919434902',	
		'NF001001038301',	
		'NF001112068405',	
		'NF001281635581',	
		'NF001665469562',	
		'Z1001827900895',	
		'VB000469009868',	
		'VB000959403354',	
		'VB000993117230',	
		'VB001369763635',	
		'VB007492130957',	
		'CK001728902068',	
		'18001171965981',	//vendor code not updated
		'CI000816148011',	
		'FE000756141428',	
		'FE001669222601',	
		'FU003212683190',	
		'2Q000567609059',	//vendor code not updated
		'2W001207068128',	//vendor code not updated
		'PT000898160991',	
		'PT002212416650',	
		'PT002414829850',	
		'PT003283712465',	
		'FH000288540329',	
		'FN002023063152',	
		'TR001694847890',	
		'NA000586403984',	
		'IB001641488099',	
		'IB002135270437',	
		'PU001667132974',	
		'47001163299475',	//vendor code not updated
		'CL000780645354',	
		'CL001543576099',	
		'CL002182961044',	
		'CL002375427703',	
		'67000288540329',	//vendor code not updated
		'67003212683190',	//vendor code not updated
		'FV000260277358',	
		'FV000588107631',	
		'FV000833339757',	
		'FV001222152935',	
		'FV001724632592',	
		'FV002023063152',	
		'FV002120228383',	
		'FV002202468450',	
		'MB001256032551',	
		'MB001724632592',	
		'TD000719291358',	
		'IC033638328663',	
		'MF001720362252',	
		'MF002368702838',	
		'MF002511841178',	
		'MF002665359501',	
		'MV001433214576',	
		'MV002354446602',	
		'BL001827900895',	
		'AT001171965981',	//vendor code not updated
		'DD001827900895',	
		'DI001223108383',	
		'DI002120228383',	
		'DM000985843685',	
		'DQ000731871636',	
		'DQ002638383768',	
		'DV001256032551',	
		'DV001724632592',	
		'DV002697383655',	
		'EA000729814470',	
		'ED000291428155',	
		'ED000610919379',	
		'ED001215964977',	
		'EG000019818743',	
		'EG121931118975',	
		'EH000613441541',	
		'EJ000567609059',	
		'EL001067044191',	
		'EL001369763635',
		'PU000449543567',
		'VB002720797188',
		'FV001651144738',
		'EL002603193973',
		'BM000401981991',
		'TB000392758776',
		'DI002730924573',
		'FM002730924573',
		'FN002730924573',
		'FV002730924573',
		'EL001082840085',
    'TB001082840085',
    'TD001082840085',
    'TE001082840085',
		'RE149217009929',
		'TB007344251708',
		'FS001543764893',
		'PU001799852577',
		'CH000072745801',
		'3Y166132487325',
		'NA001615701361',
		'IB000216061475',
		'AT000598607569',
		'FV002175436344',
		'TB001837566244',
		'PU043770675851',
		'PV043770675851',
		'MH002027413881',
		'IC000157812797',
		'FV001898505891',
		'TP036678985141',
		'FV000315334620',
		'CN001837919494',
		'PT001060273815',
		'EG001076572311',
		'CH000961958275',
		'CN000961958275',
		'BS000961958275',
		'BQ002382228969',
		'GB000685065043',
		'VB000685065043',
		'TE001357273458',
		'DQ000097920802',
		'HE000097920802',
		'IB000097920802',
		'EK000700970737',
		'NA000991609707',
		'BN001280096657',
		'WF000523214505',
		'EL004280619339',
		'TB004280619339',
		'CG001941787657',
		'CK000321795110',
		'TB002724648270',
		'VB002592214950',
		'AT000549670722',
		'FP001763194394',
		'BL000953185983',
		'DD000953185983',
		'RF000953185983',
		'Z1000953185983',
		'CX000512945357',
		'FE000512945357',
		'FO000512945357',
		'FV000512945357',
		'EE011320552597',
		'OE011320552597',
		'PG011320552597',
		'WJ011320552597',
		'EE002175925236',
		'WJ002175925236',
		'WA000612388496',
		'ED002090038787',
		'WF002090038787',
		'FV000013214461',
		'FE000013214461',
		'TB002327708594',
		'TE002327708594',
		'TB000894362485',
		'2Q002551289628',
		'WH109912628037',
		'63000341216640',
		'CH002546224959',
		'5Q000117676577',
		'EM001172428569',
		'NS001172428569',
		'UA001172428569',
		'Z1001172428569',
		'EL001443573036',
		'TJ001443573036',
		'PS002770688132',
		'2A002770688132',
		'CH149771281339',
		'CH038946458976',
		'CH002475529843',
		'CN002475529843',
		'EL001604283162',
		'RV001876900281',
		'VB040188122603',
		'CH000428493218',
		'DW000296736435',
		'DV000296736435',
		'MB000429739004',
		'DW000429739004',
		'EV114622671622',
		'DV002728953994',
		'DW002728953994',
		'MB002728953994',
		'MH014001233961',
		'EK000742046874',
		'RP000742046874',
		'FV001714204157',
		'NF000591766527',
		'AT002359238778',
		'DW002573351416',
		'DV002573351416',
		'6W002573351416',
		'WA002333753607',
		'Z8002333753607',
		'73001573967439',
		'PU001387369039',
		'DQ001588231962',
		'US001588231962',
		'CH000967893519',
		'CH001112242611',
		'TV001551432987',
		'EK142135032572',
		'NF002367994444',
		'EK001196477725',
		'TA001196477725',
		'NF002600864709',
		'FC002517333791',
		'FV002517333791',
		'CH129498552323',
		'VB000065781869',
		'EV000525625791',
		'NF000525625791',
		'WG000525625791',
		'TV001862774727',
		'CL002240612421',
		'CH002240612421',
		'FV002325980156',
		'FV000721959447',
		'EG002377003884',
		'LJ002377003884',
		'TV001356298789',
		'UU000475954575',
		'LV145203183536',
		'NF145203183536',
		'NF000753943043',
		'5Q002170218509',
		'NF000731335296',
		'ED001950637938',
		'WF001950637938',
		'NF002709896301',
		'FG000277479991',
		'HH014934919860',
		'FO002295885360',
		'FV002295885360',
		'Z1000192311708',
		'NF000313776866',
		'EL002179215391',
		'TB002179215391',
		'TE002179215391',
		'7G001881629844',
		'EK000569064722',
		'63000961811685',
		'TB000961811685',
		'7A000304477265',
		'FC000304477265',
		'ZY000304477265',
		'ZZ000304477265',
		'FV001271885018',
		'73001096551418',
  'NF001647359273',
		'TS001869254553',
		'Z9001869254553',
		'DW002135901592',
		'MB002135901592',
		'6W002135901592',
		'CL002408644068',
		'NF031918588835',
		'VB031918588835',
		'DI001527723915',
		'FE001527723915',
		'TS001516358789',
		'NF001839831285',
		'DI001632531736',
		'FE001632531736',
		'FV001632531736',
		'NF001632531736',
		'FE000029826617',
		'FJ000029826617',
		'NF001291078114',
		'5L001291078114',
		'7A001291078114',
		'ED002714143020',
		'WF002714143020',
		'77001893029091',
		'TB001893029091',
		'EU001207197277',
		'MG001207197277',
		'NF001207197277',
		'6S001207197277',
		'NF002182300752',
		'NF001979819174',
		'MH001513648037',
		'TV001026117314',
		'TS008914469409',
		'7G008914469409',
		'DI002143795673',
		'NF002238797852',
		'TU001972384099',
		'NF000566955962',
		'NF000575725820',
		'TV000405053790',
		'CL000003267524',
		'TS000003267524',
		'TU070887007326',
		'PU000722770103',
		'FV001509192727',
		'TJ002317955783',
		'NF001053707845',
		'TB000096886549',
		'TE000096886549',
		'IV000409032243',
		'NF000409032243',
		'UG000761470951',
		'NF002394944859',
		'DQ001926649343',
		'IB001926649343',
		'UG000432067071',
		'TV000108062572',
		'UL000108062572',
		'FV000873456265',
		'UO000873456265',
		'EK001741544300',
		'NF001686422322',
		'7A188189769102',
		'NF001906522480',
		'W0003145738986754',
		'W0004145738986754',
		'NF000120835768',
		'TS001504984259',
		'W0037000437505121',
		'YE000437505121',
		'VK000437505121',
		'HA001366574762',
		'NF160924381235',
		'VB000332352558',
		'NF000332352558',
		'FO000511873285',
		'CL001636647532',
		'UG001636647532',
		'8I001983503494',
		'CL000143133411',
		'TS000143133411',
		'TB000960796215',
		'NF000029837236',
		'UL000301277452',
		'CH154974782030',
		'CH001355256355',
		'TV001355256355',
		'VE000924763396',
		'8I001144491103',
		'NF000155543037',
		'NF006596006812',
		'NF000549651760',
		'NF001057203868',
		'NF001155283142',
		'NF093134607110',
		'NF001006873422',
		'NF001047778868',
		'CG000896130343',
		'NF000349402171',
		'TS000944354935',
		'NF139673719433',
		'6W038176341404',
		'DW038176341404',
		'DV038176341404',
		'CN163491041562',
		'TV000903812557',
		'NF001493144909',
		'NF000200291334',
		'EK145958279930',
		'EL145958279930',
		'NF001050596253',
		'W0027001050596253',
		'NF000122936968',
		'BQ003863894589',
		'CH003863894589',
		'US001256902053',
		'GW000483457781',
		'NF001466913859',
		'NF000427655508',
		'NF002392954701',
		'NF002452575997',
		'VB002452575997',
		'NF001692030266',
		'NF002482805819',
		'NF001915622624',
		'NF000551468371',
		'AT038535481224',
		'5W002300166171',
		'CL000498310548',
		'EL000730909747',
		'MV000730909747',
		'TB000730909747',
		'TJ000730909747',
		'FN000714272992',
		'CG063132961784',
		'TV000087484282',
		'NF001064844143',
		'NF001552822301',
		'NF002481613802',
		'TS000229044589',
		'AT035183146689',
		'Z1002076600553',
		'NF002076600553',
		'NF000278437238',
		'FO000889340556',
		'MV000889340556',
		'TJ000889340556',
		'CH002611212602',
		'FG006585036862',
		'NF000569551974',
		'UA002330374389',
		'FO002197733117',
		'ED001012144568',
		'WF001012144568',
		'EV002723204875',
		'NF002723204875',
		'MP012994937417',
		'TE012994937417',
		'TR012994937417',
		'WF000566720040',
		'7Y002143146478',
		'EK001045553166',
		'VK041419572857',
		'TV001247131777',
		'DQ000060640576',
  'VB001853398984',
  'NF001715636609',
  'UF001885143363',
  'NF002330052217',
  'Z1002330052217',
 	'NF001057395934',
	 'DV002153681027',
	 'DW002153681027',
	 'MG001981974902',
	 'IB001392687562',
	 'VB002747761045',
	 'NF000892084168',
	 'UL002322987415',
	 'NF145636505242',
	 'EB001654045762',
	 'KB001654045762',
	 'NB001654045762',
	 'VG001654045762',
	 'YC000687532391',
	 'NC000598207591',
	 'TV000959219243',
	 'CL170122709956',
	 'NF000053831726',
	 'PU000053831726',
	 'NF001680432306',
	 'NF034996921727',
	 'UU187758100352',
	 'NF000930670713',
	 'W0150000664963208',
	 'QL001319917072',
	 'W0015001319917072',
	 'NF001159883744',
	 '7Y000007230069',
	 'W0192076565592511',
	 '63001416139048',
	 'NF002233834908',
	 'FV001940268854',
	 'NF001940268854',
	 'CL002320635202',
	 'NF191178553776',
	 'TV002488514706',
	 'PJ001026587069',
	 'MG001904434465',
	 'MF000300315045',
	 'PR000300315045',
	 'PU000300315045',
	 'VB000300315045',
	 'FO006586906643',
	 '9L006586906643',
	 'EL006586906643',
	 'DI150190629381',
	 'CX002360477413',
	 'DI002360477413',
	 'FE002360477413',
	 'FC131110654694',
	 'FG131110654694',
	 'W0041131110654694',
	 'FE002473611685',
	 'EV001271045685',
	 'WG001271045685',
	 'FO001251104398',
	 'TB074167959800',
	 'FV001716514708',
	 'MG003316508123',
	 'FG001762380703',
	 '7A191676233621',
	 'NF002765673276',
	 'EK000722350111',
	 'TB169956490139',
	 'TI169956490139',
	 'W0063169956490139',
	 'W0163169956490139',
	 'TB002604324971',
	 'DI046179167733',
	 'FR046179167733',
	 'GK046179167733',
	 'W0003000863908977',
	 'DI000957506690',
	 'I0044000957506690',
	 'VG000073561885',
	 'VB000200491937',
	 'W003000200491937',
	 'Z9050235972218',
	 '7G000925288632',
	 '3K000537434328',
	 'TB000537434328',
	 'TF000537434328',
	 'I0008002483679176',
	 'RA002483679176',	
	 'I0010187904528055',
	 'PU120066456016',
	 'DQ000408453122',	 
	 'IB000408453122',
	 'I0101195807222720',
	 'NF006586575153',
	 '7G014252588262',
	 'MH014252588262',
	 'W0002014252588262',
	 '6W190276290460',
	 'WB161824585211',
	 'I0115161824585211',
	 'BL000827523266',
	 'RF000827523266',
	 '5P001660908611',
	 '7A001660908611',
	 'NF001660908611',
	 'RT001660908611',
	 'I0016002252943135',
	 'I0114003561684594',
	 'Z1010846018346',
	 'BE002722489992',
	 'NS047589635171',
	 'UA047589635171',
	 'I0013056506544741',
	 'BS190778762094',
	 'W0105190778762094',
	 'W0114190778762094',
	 'RC035021935207',
	 'DU033640666456',
	 'I0005033640666456',
	 'MF033640666456',
	 'NF000292209006',
	 '8Y062041861429',
	 'I0077062041861429',
	 'I0078062041861429',
	 'KP062041861429',
	 'OC062041861429',
	 'I0073000300679288',
	 'NF000300679288',
	 'VB000300679288',
	 '7G013888015122', // DF-28092
	 'IG013888015122', // DF-28092
	 'MH013888015122', // DF-28092
	 'EU001199617661', // DF-28098
	 '6W000290937270', // DF-28104
	 'DV000290937270', // DF-28104
	 'DW000290937270', // DF-28104
	 'W0063000290937270', // DF-28104
	 'MB038230483865', // DF-28111
	 'PU002160779267', // DF-28124
	 'PV002160779267', // DF-28124
	 '6W002522832982', // DF-28126
	 'PV191110158506', // DF-28130
	 'I0102001203993107', // DF-28156
	 '8K000170154681', // DF-28157
	 'I0081000170154681', // DF-28157
	 'W0335152098194482', // DF-28187
	 '7G152098194482', // DF-28187
	 'MH152098194482', // DF-28187
	 'W0003033639841869', // DF-28266
	 'VB033639841869', // DF-28266
	 'BY002735383332', // DF-28314
	 'CH002735383332', // DF-28314
	 'VB002735383332', // DF-28314
	 '8S082813088195', // DF-28359
	 'TB082813088195', // DF-28359
	 'TF082813088195', // DF-28359
	 'WA001204401551', // DF-28376
	 'I0087099579823690', // DF-28380
	 'EK000176942468', // DF-28436
	 'VB000176942468', // DF-28436
	 'TE000176942468', // DF-28436
	 'Z9188599862143', // DF-28457
	 'W0003000100452810', // DF-28465
	 'W0004000100452810', // DF-28465
	 'VB001363942486', // DF-28470
	 'FO000809800437', // DF-28444
	 'UL001100441137', // DF-28499
	 'I0081002418049094', // DF-28533
	 '8K002418049094', // DF-28533
	 'VB000641124555', // DF-28554
	 '7B000016327927', // DF-28553
	 'UA000016327927', // DF-28553
	 'I0095001621860362', // DF-28579
	 'TF001621860362', // DF-28579
	 'I0063000203385248' // DF-28626
		// 'DD002168500989', //bug 198566
		// 'RG002168500989'
		];

	vendor_case_number_did := ['NF1986CR 002310000993117230',
		'NF1991CR 005714000993117230',
		'NF2009CR 052012001722381798',
		'VB071GC0200093400000061812824',
		'VB131GC0700361500010509176342',
		'TRCC1 346672000363026703',
		'TRCC1 363792000363026703',
		'TRCC7 826297000363026703',
		'TRCC7 826298000363026703',
		'TRCC7 953965000363026703',
		'NA00003276000586404384',
		'NA03000502000586404384',
		'MF0B00256466000901054917', //vc                        
		'MF899347017000901054917', //vc
		'MF12K99000884000901054917',    //vc                    
		'MF6B00341865000901054917',    //vc                     
		'MF6R00017863000901054917',     //vc
		'PUCR-0000316-11001173991631',
		'TBM-0959759002125282167',
		'NF2011CR001093000400617057',
		'TBCR25123002317955783',
		'7AG409379000910166108', //JIRA DF-22396
		'CHSH372635060272064276', //JIRA DF-22398
		'PUMJ-07103-TR-0001200-2019190794633935', //JIRA DF-28026
  'PUMJ-07103-TR-0001201-2019190794633935', //JIRA DF-28026
  'PUMJ-07103-TR-0001203-2019190794633935', //JIRA DF-28026
  'PUMJ-38111-NT-0000979-2014190794633935', //JIRA DF-28026
  'PUMJ-38202-CR-0000173-2018190794633935', //JIRA DF-28026
  'PVCP-46-CR-0006417-2018190794633935', //JIRA DF-28026
  'PVCP-46-CR-0006576-2015190794633935', //JIRA DF-28026
  'PVCP-46-CR-0006780-2015190794633935',  //JIRA DF-28026
	 'VB003GC9900280900000209924977',  //JIRA DF-28040
  'VB003GC9900281000000209924977',  //JIRA DF-28040
  'VB009GT0100439400000209924977',  //JIRA DF-28040
  'VB003GC9900280800000209924977',  //JIRA DF-28040
  'VB003GC9900280700000209924977',  //JIRA DF-28040
  'VB009GT0100439500000209924977',  //JIRA DF-28040
	 'NF2402017CR 700610192421225575',  //JIRA DF-28072
		'W000255CR096200013888015122', // JIRA DF-28092
		'W000255VB145887013888015122', // JIRA DF-28092
		'NF0302009CR 701900006553427232', // JIRA DF-28109
		'NF5902008CR 725704006553427232', // JIRA DF-28109
		'NF5902010CR 705936006553427232', // JIRA DF-28109
		'NF5902011CR 708648006553427232', // JIRA DF-28109
		'I01152016CM000691001153737036', // JIRA DF-28132
		'WB2010CT000884001153737036', // JIRA DF-28132
		'WB2016CM000691001153737036' // JIRA DF-28132
    ];
		
		vendor_offenderkey_did := [
     'EJEJ00147214001685423412',   //'SCSC00147214001685423412', vc
     '010103656875001799409994', //could not find this person with this name and DOB ask chuck //vc 
     'Z1Z12099886130253703583M-0747-TR-200800189520080124001754102221', //  '11115627746323538417001754102221',ask chuck the dob is diff    
     'Z1Z12099886130253703583M-0747-TR-200601613020060627001754102221', //  '11115627746323538417001754102221',ask chuck the dob is diff 
     'Z1Z12099886130253703583M-0747-TR-200102126220011015001754102221', //  '11115627746323538417001754102221',ask chuck the dob is diff 
     'Z1Z12099886130253703583M-0341-TR-201100491620110705001754102221', //  '11115627746323538417001754102221',ask chuck the dob is diff 
		 
     'VBVB16890514896365001056057GT060011810020060308001105937771',  //'1212057GT0600118100001105937771',
     'VBVB16890514896365001056013GC040022880020040616001105937771', //'1212013GC0400228800001105937771',
     'VBVB16890514896365001056013GT030657120020031117001105937771', //'1212013GT0306571200001105937771',
     'VBVB16890514896365001056179GT010168380020011213001105937771',    //'1212179GT0101683800001105937771'
		 'DJDJ0000658230000920880831',
		 'FOFO12744137279170997762M0806565120081113000549670722', // Bug 145611
     'FOFO12744137279170997762F1300657020130320000549670722', // Bug 145611
     'FOFO12744137279170997762F1001913820100701000549670722', // Bug 145611
     'FOFO1141936669728912382F76006675A19760806000549670722', // Bug 145611
     'FOFO1141936669728912382F7100580919710720000549670722',  // Bug 145611
     'FOFO1141936669728912382F7100532219710628000549670722',  // Bug 145611
     'FOFO1141936669728912382F7100515519710622000549670722',  // Bug 145611
     'FOFO1141936669728912382F70006938B19700807000549670722', // Bug 145611
     'FOFO1141936669728912382F0901332720090422000549670722',  // Bug 145611
		 '5H5H867570497650377227441986BS20031126002345222559',    // Bug 175642
		 'NFNF121134447349438742392003CR22692920030608',          // Bug 179229
		 '7A7A713819876787507212661946820020528002662473403',     // Bug 195883
		 '7A7A7138198767875072126F66022120010614002662473403',    // Bug 195883
		 '5C5C713819876787507212661946820020528002662473403',     // Bug 195883
		 'NFNF106393839760016937492005CRS05416620051115001472023472', // Bug 195961
     'NFNF165589194051042305272008CR00252720081008001472023472', // Bug 195961
		 'NFNF165589194051042305272009CR05204520091105001472023472', // Bug 195961
		 'NFNF165589194051042305272009CR70120320090630001472023472', // Bug 195961
		 'NFNF165589194051042305272009CRS05198220090916001472023472', // Bug 195961
		 'NFNF165589194051042305272011CR05881620110928001472023472', // Bug 195961
		 'NFNF165589194051042305272011CRS05037220110127001472023472', // Bug 195961
		 'NFNF165589194051042305272011CRS05881120110928001472023472', // Bug 195961
		 'NFNF165589194051042305272015CR00067120150513001472023472', // Bug 195961
		 'NFNF180428326353625683232001CR00166420011114001472023472', // Bug 195961
		 'NFNF180428326353625683232001CR00174020011204001472023472', // Bug 195961
		 'NFNF180428326353625683232001IF00813720011113001472023472', // Bug 195961
		 'NFNF180428326353625683232002CRS05074320020322001472023472', // Bug 195961
		 'NFNF180428326353625683232002CRS05202720020404001472023472', // Bug 195961
		 'NFNF180428326353625683232002CRS05273320020507001472023472', // Bug 195961
		 'NFNF180428326353625683232002CRS05293320020514001472023472', // Bug 195961
		 'NFNF180428326353625683232003CR05199920030326001472023472', // Bug 195961
		 'NFNF180428326353625683232003CRS00104720030626001472023472', // Bug 195961
		 'NFNF180428326353625683232003CRS05199720030326001472023472', // Bug 195961
		 'NFNF180428326353625683232003CRS05870920031229001472023472', // Bug 195961
		 'NFNF300301000328567102011CRS00691920111003001472023472', // Bug 195961
		 'NFNF73380568033829391322000CR00561820000601001472023472', // Bug 195961
		 'NFNF73380568033829391322000CRS05072120000803001472023472', // Bug 195961
		 'NFNF99512016376684177002002CR00204220020906001472023472', // Bug 195961
     'NFNF143632535617644689665301986CR00231019870129000993117230', // JIRA DF-18281
     'NFNF52011672615891364593301991CR00571419920113000993117230', // JIRA DF-18281
		 'NFNF59404201572389122338702009CR05201220091003001722381798', // JIRA DF-18281
		 'NFNF57442910744274284805902011CR00109320110113000400617057', // JIRA DF-18281
		 'NFNF165589194051042305273102009CR05204520091105001472023472', // JIRA DF-18281
		 'NFNF180428326353625683236502001CR00174020011204001472023472', // JIRA DF-18281
		 'NFNF165589194051042305277202008CR00252720081008001472023472', // JIRA DF-18281
		 'NFNF165589194051042305277202009CRS05198220090916001472023472', // JIRA DF-18281
		 'NFNF180428326353625683234102002CRS05273320020507001472023472', // JIRA DF-18281
		 'NFNF180428326353625683234102003CRS05199720030326001472023472', // JIRA DF-18281
		 'NFNF106393839760016937497202005CRS05416620051115001472023472', // JIRA DF-18281
		 'NFNF180428326353625683234102002CRS05202720020404001472023472', // JIRA DF-18281
		 'NFNF180428326353625683234102003CR05199920030326001472023472', // JIRA DF-18281
		 'NFNF121134447349438742395902003CR22692920030608002434550258', // JIRA DF-18281
		 'NFNF165589194051042305273102011CRS05881120110928001472023472', // JIRA DF-18281
		 'NFNF165589194051042305273102011CR05881620110928001472023472', // JIRA DF-18281
		 'NFNF180428326353625683234102001IF00813720011113001472023472', // JIRA DF-18281
     'NFNF180428326353625683234102002CRS05074320020322001472023472', // JIRA DF-18281
		 'NFNF180428326353625683236502003CRS00104720030626001472023472', // JIRA DF-18281
		 'NFNF165589194051042305277202009CR70120320090630001472023472', // JIRA DF-18281
		 'NFNF165589194051042305274102015CR00067120150513001472023472', // JIRA DF-18281
		 'NFNF165589194051042305274102011CRS05037220110127001472023472', // JIRA DF-18281
		 'NFNF180428326353625683234102003CRS05870920031229001472023472', // JIRA DF-18281
		 'NFNF180428326353625683234102002CRS05293320020514001472023472', // JIRA DF-18281
		 'NFNF180428326353625683236502001CR00166420011114001472023472', // JIRA DF-18281
		 'NFNF300301000328567103102011CRS00691920111003001472023472', // JIRA DF-18281
		 'NFNF73380568033829391324102000CRS05072120000803001472023472', // JIRA DF-18281
		 'NFNF99512016376684177004102002CR00204220020906001472023472', // JIRA DF-18281
		 'NFNF73380568033829391324102000CR00561820000601001472023472', // JIRA DF-18281
	  '7G7G1054917606846148071601VB1153920110411051501888115', // JIRA DF-24328
	  '7G7G1054917606846148071604CR0980420090217051501888115', // JIRA DF-24328
	  'W0002W00021054917606846148071604CR0980420090217051501888115', // JIRA DF-24328
		'MHMH1727417511100750108619005106002214393020', // JIRA DF-28699
		'MHMH1727417511100750108619014209002214393020', // JIRA DF-28699
		'I0037I00371725940615654859522604475160101019860417000913940983', // JIRA DF-28637
		'TETE7359606231618614284F-131248820141110002604324971', // JIRA DF-28741
		'TETE7359606231618614284F-141246820140515002604324971', // JIRA DF-28741
		'7E7E1026217109355719926811-2008-TR-036974-0001-XX20080611000015920671',  //  JIRA DF-28746
'7E7E1026217109355719926811-2008-TR-049724-0001-XX20080908000015920671',  //  JIRA DF-28746
'FEFE1026217109355719926801072766TI40A20010822000015920671',  //  JIRA DF-28746
'FEFE1026217109355719926803001082CF10A20030120000015920671',  //  JIRA DF-28746
'FEFE1026217109355719926808129982TI40A20081225000015920671',  //  JIRA DF-28746
'FEFE1026217109355719926808131091TI30A20081202000015920671',  //  JIRA DF-28746
'FEFE1026217109355719926809009178TI30A20090128000015920671',  //  JIRA DF-28746
'FEFE1026217109355719926809016964TI30A20090221000015920671',  //  JIRA DF-28746
'FEFE1702922760197406706114009222CF10A20140706000015920671',  //  JIRA DF-28746
'FEFE1702922760197406706114010082CF10A20140724000015920671',  //  JIRA DF-28746
'FEFE1702922760197406706114013664TI30A20140213000015920671',  //  JIRA DF-28746
'FEFE1702922760197406706118040295TI30A20180730000015920671',  //  JIRA DF-28746
'FEFE1702922760197406706195069485TI40A19950922000015920671',  //  JIRA DF-28746
'FOFO10262171093557199268000000000M0903652020090618000015920671',  //  JIRA DF-28746
'FOFO10262171093557199268000000000M9205900819920319000015920671',  //  JIRA DF-28746
'FVFV1026217109355719926892002960MM40A19920619000015920671',  //  JIRA DF-28746
'FVFV1026217109355719926895013717CF10A19950822000015920671',  //  JIRA DF-28746
'FVFV10262171093557199268M9205900819920727000015920671',  //  JIRA DF-28746
'FVFV1060397323573072839200029715MM10A20001115000015920671',  //  JIRA DF-28746
'FVFV1702922760197406706100004454MM40A000015920671',  //  JIRA DF-28746
'I0063I006310262171093557199268132009MM0365200001XX20090618000015920671',  //  JIRA DF-28746
'I0072I007210262171093557199268TRD950935119951109000015920671',  //  JIRA DF-28746
'DIDIG16650001248730968',  //  JIRA DF-28754
'FHFH3962572792822633065012008CF001995A20080507001248730968',  //  JIRA DF-28754
'FHFH3962572792822633065012009CF000639A20090219001248730968',  //  JIRA DF-28754
'FHFH3962572792822633065012009CF000641B20090219001248730968',  //  JIRA DF-28754
'FHFH3962572792822633065012009MM000740A20090127001248730968',  //  JIRA DF-28754
'FHFH3962572792822633065012009MM006688A20090830001248730968',  //  JIRA DF-28754
'FHFH3962572792822633065012010CF003015A20100729001248730968',  //  JIRA DF-28754
'FHFH3962572792822633065012010CF003986A20101001001248730968',  //  JIRA DF-28754
'FHFH3962572792822633065012011CF004038A20111003001248730968',  //  JIRA DF-28754
'FHFH3962572792822633065012012MM007429A20121101001248730968',  //  JIRA DF-28754
'FHFH3962572792822633065012013MM003723A20130617001248730968',  //  JIRA DF-28754
'FHFH3962572792822633065012013MM004091A20130702001248730968',  //  JIRA DF-28754
'FHFH3962572792822633065012014CF004140A20141117001248730968',  //  JIRA DF-28754
'FHFH3962572792822633065012015CF000751A20150301001248730968',  //  JIRA DF-28754
'FHFH3962572792822633065012015CF002057A20150624001248730968',  //  JIRA DF-28754
'FHFH3962572792822633065012015CT001497A20150301001248730968',  //  JIRA DF-28754
'FHFH3962572792822633065012016CF000247A20160120001248730968',  //  JIRA DF-28754
'FHFH3962572792822633065012016CT001042A20160419001248730968',  //  JIRA DF-28754
'FHFH3962572792822633065012016CT001227A20160510001248730968',  //  JIRA DF-28754
'FHFH3962572792822633065012019CF002533A20190814001248730968',  //  JIRA DF-28754
'FHFH3962572792822633065012019CT001541A20190814001248730968',  //  JIRA DF-28754
'FHFH3962572792822633065012020CF002468A20200819001248730968',  //  JIRA DF-28754
'FHFH3962572792822633065012020CF003551A20201120001248730968',  //  JIRA DF-28754
'FHFH3962572792822633065012020MM000911A20200506001248730968',  //  JIRA DF-28754
'I0044I00441434935366533317263919900629001248730968',  //  JIRA DF-28754
'W0322W03221598461950670603054119900629BLACKMALE001248730968',  //  JIRA DF-28754
'FHFH3962572792822633065012015MM002220A20141117001248730968', // JIRA DF-28754
'DQDQN20933001274309971',  //  JIRA DF-28755
'WTWT1096721094123346385590CRB0035119900423001458859923',  //  JIRA DF-28756
'EVEV0777878001770626976',  //  JIRA DF-28758  
'I0046I00460777878001770626976', // JIRA DF-28758
'NFNF71694401386334173112801999CR01139319990609001770626976', // JIRA DF-28758
'NFNF71694401386334173112802002CR05786720020809001770626976', // JIRA DF-28758
'NFNF71694401386334173112802003CR00923920030902001770626976', // JIRA DF-28758
'NFNF71694401386334173112802006CR01023520061114001770626976', // JIRA DF-28758
'NFNF71694401386334173112802020CR70090920200123001770626976', // JIRA DF-28758
'NFNF71694401386334173112902001CR00436820011024001770626976', // JIRA DF-28758
'WGWG0777878001770626976',  //  JIRA DF-28758
'FMFM7611759514546393107371998MM003908A0010019980317001643485890',  //  JIRA DF-28762
'FMFM7611759514546393107371998MM003908AXXXXX001643485890',  //  JIRA DF-28762
'FVFV7611759514546393107C9803908A001643485890',  //  JIRA DF-28762
'FVFV7611759514546393107C9803908A19980317001643485890',  //  JIRA DF-28762
'GDGD143267038557319514412303277E05-R-059001643485890',  //  JIRA DF-28762
'GDGD143267038557319514412303277E05-R-059001643485890',  //  JIRA DF-28762
'GDGD143267038557319514412303277E10021991001643485890',  //  JIRA DF-28762
'GDGD143267038557319514412303277E10021991001643485890',  //  JIRA DF-28762
'GDGD143267038557319514412303277E10022347001643485890',  //  JIRA DF-28762
'GDGD143267038557319514412303277E10022347001643485890',  //  JIRA DF-28762
'I0151I0151108645637697564039014-2044J1220140705167738778929', // JIRA DF-28832
'4S4S576627511621402571M30193920110104002576869263',  // JIRA DF-28843
'7A7A576627511621402571M30193920110104002576869263',  // JIRA DF-28843
'7A7A576627511621402571M30194020110104002576869263',  // JIRA DF-28843
'4T4T576627511621402571M30194020110104002576869263',  // JIRA DF-28843
'7E7E98763773198045821611-2014-TR-020612-0001-XX20140710001205279083',  // JIRA DF-28895
'7E7E98763773198045821611-2014-TR-020613-0001-XX20140710001205279083',  // JIRA DF-28895
'W0037W003714667621274922710250TRD120227820120507000175987108',  // JIRA DF-28902
'W0319W03199573019807714510571TRD9405290000175987108',  // JIRA DF-28902
'7Q7Q11065524722328930334000007381365',    // JIRA DF-28900
'7Q7Q12124786991547920406000007381365',    // JIRA DF-28900
'ATAT  10483608191982020920130308000007381365',    // JIRA DF-28900
'ATAT  10483608191982020920130321000007381365',    // JIRA DF-28900
'ATAT  10483608191982020920130722000007381365',    // JIRA DF-28900
'ATAT16296958261982020920191110000007381365',    // JIRA DF-28900
'ATAT36373768441982020920180316000007381365',    // JIRA DF-28900
'ATAT36373768441982020920190308000007381365',    // JIRA DF-28900
'ATAT36373768441982020920190811000007381365',    // JIRA DF-28900
'ATAT36373768441982020920200110000007381365',    // JIRA DF-28900
'ATAT36373768441982020920200530000007381365',    // JIRA DF-28900
'FOFO10802989705981224879050006495F0202664620020907000007381365',    // JIRA DF-28900
'FOFO10929948161922026133000000000B0401857920040407000007381365',    // JIRA DF-28900
'FOFO10929948161922026133000000000B0505037420051004000007381365',    // JIRA DF-28900
'FOFO10929948161922026133000000000B1900616420190308000007381365',    // JIRA DF-28900
'FOFO10929948161922026133000000000F0103644120011130000007381365',    // JIRA DF-28900
'FOFO10929948161922026133000000000F1300672820130322000007381365',    // JIRA DF-28900
'FOFO10929948161922026133000000000F1301695420130723000007381365',    // JIRA DF-28900
'FOFO10929948161922026133000000000F1500422920150227000007381365',    // JIRA DF-28900
'FOFO10929948161922026133000000000F2000783820200601000007381365',    // JIRA DF-28900
'FOFO10929948161922026133000000000M1700258920170127000007381365',    // JIRA DF-28900
'FOFO10929948161922026133000000000M1800721920180317000007381365',    // JIRA DF-28900
'FOFO12399242340144922749050006495B1903005120191111000007381365',    // JIRA DF-28900
'FOFO12399242340144922749050006495M0500222320050114000007381365',    // JIRA DF-28900
'FVFV10802989705981224879F02026646000007381365',    // JIRA DF-28900
'FVFV10929948161922026133F01036441000007381365',    // JIRA DF-28900
'I0005I00051236831920684891857700000020V0SLS000007381365',    // JIRA DF-28900
'I0005I00051236831920684891857700000020V0SLS20180301000007381365',    // JIRA DF-28900
'I0005I00051236831920684891857700000020W0SLS000007381365',    // JIRA DF-28900
'I0005I00051236831920684891857700000020W0SLS20180301000007381365',    // JIRA DF-28900
'I0005I00051236831920684891857700000020X0SLS000007381365',    // JIRA DF-28900
'I0005I00051236831920684891857700000020X0SLS20180301000007381365',    // JIRA DF-28900
'I0005I00051236831920684891857700000020Y0SLS000007381365',    // JIRA DF-28900
'I0005I00051236831920684891857700000020Y0SLS20180301000007381365',    // JIRA DF-28900
'I0005I00051236831920684891858400000020Z0SLS000007381365',    // JIRA DF-28900
'I0005I0005123683192068489185840000002100SLS000007381365',    // JIRA DF-28900
'I0005I0005123683192068489185840000002110SLS000007381365',    // JIRA DF-28900
'I0005I0005123683192068489185840000002120SLS000007381365',    // JIRA DF-28900
'I0005I00051236831920684891858500000020Z0SLS000007381365',    // JIRA DF-28900
'I0005I00051236831920684891858500000020Z0SLS20180301000007381365',    // JIRA DF-28900
'I0005I0005123683192068489185850000002100SLS000007381365',    // JIRA DF-28900
'I0005I0005123683192068489185850000002100SLS20180301000007381365',    // JIRA DF-28900
'I0005I0005123683192068489185850000002110SLS000007381365',    // JIRA DF-28900
'I0005I0005123683192068489185850000002110SLS20180301000007381365',    // JIRA DF-28900
'I0005I0005123683192068489185850000002120SLS000007381365',    // JIRA DF-28900
'I0005I0005123683192068489185850000002120SLS20180301000007381365',    // JIRA DF-28900
'I0063I006310802989705981224879132001CF0364410001XX20011130000007381365',    // JIRA DF-28900
'I0063I006310802989705981224879132002CF0266460001XX20020907000007381365',    // JIRA DF-28900
'I0063I006310802989705981224879132013CF0067280001XX20130322000007381365',    // JIRA DF-28900
'I0063I006310929948161922026133132001CF0364410001XX20011130000007381365',    // JIRA DF-28900
'I0063I006310929948161922026133132004CO0185790001XX20040407000007381365',    // JIRA DF-28900
'I0063I006310929948161922026133132005CO0503740001XX20051004000007381365',    // JIRA DF-28900
'I0063I006310929948161922026133132013CF0067280001XX20130322000007381365',    // JIRA DF-28900
'I0063I006310929948161922026133132013CF0169540001XX20130723000007381365',    // JIRA DF-28900
'I0063I006310929948161922026133132015CF0042290001XX20150227000007381365',    // JIRA DF-28900
'I0063I006310929948161922026133132017MM0025890001XX20170127000007381365',    // JIRA DF-28900
'I0063I006310929948161922026133132018MM0072190001XX20180317000007381365',    // JIRA DF-28900
'I0063I006310929948161922026133132019MM0061640001XX20190308000007381365',    // JIRA DF-28900
'I0063I006312399242340144922749132002CF0266460001XX20020907000007381365',    // JIRA DF-28900
'I0063I006312399242340144922749132005MM0022230001XX20050114000007381365',    // JIRA DF-28900
'I0063I006312399242340144922749132019MM0300510001XX20191111000007381365',    // JIRA DF-28900
'VEVE880277727445234612219820000000007381365',    // JIRA DF-28900
'I0043I00431119628753930531732719590705000506606258',  // JIRA DF-28908
'DQDQM20901000195151742',  // JIRA DF-28910
'USUS102177084618845293122010CF1070000195151742',  // JIRA DF-28910
'USUS102177084618845293122012CF747000195151742',  // JIRA DF-28910
'I0095I0095206420696694806592815-07010J520151130000195151742',  // JIRA DF-28910
'I0095I0095206420696694806592815-07010J5A20151225000195151742',  // JIRA DF-28910
'I0095I0095206420696694806592815-07011J520151130000195151742',  // JIRA DF-28910
'TFTF206420696694806592815-07010J520151130000195151742',  // JIRA DF-28910
'TFTF206420696694806592815-07010J5A20151225000195151742',  // JIRA DF-28910
'TFTF206420696694806592815-07011J520151130000195151742',  // JIRA DF-28910
'TFTF2064206966948065928CR-2016-01277-C20160217000195151742',  // JIRA DF-28910
'EUEU00353676001725317707', // JIRA DF-28913
'7A7A499596451671958966072717GU20170806001152595444', // JIRA DF-28914
'7A7A499596451671958966072718GU20170806001152595444', // JIRA DF-28914
'PVPV9107011757972196240CP-06-CR-0000587-2004001152595444', // JIRA DF-28914
'PUPU5531030104043674649TR-0000832-0920090413100359321368', // JIRA DF-28921
'PUPU9566279905335262506MJ-38113-TR-0002247-201620160523100359321368', // JIRA DF-28921
'PUPU9566279905335262506MJ-38113-TR-0002248-201620160523100359321368', // JIRA DF-28921
'PUPU9566279905335262506MJ-38113-TR-0002249-201620160523100359321368', // JIRA DF-28921
'PVPV17478875036102143407CP-51-CR-0016028-2009100359321368', // JIRA DF-28921
'PVPV17478875036102143407MC-51-CR-0040660-2009100359321368', // JIRA DF-28921
'PVPV5361836520327886699MC-51-CR-0002140-2012100359321368', // JIRA DF-28921
'PVPV5531030104043674649CP-51-CR-0010072-2010100359321368', // JIRA DF-28921
'PVPV5531030104043674649MC-51-CR-0019067-2010100359321368', // JIRA DF-28921
'PVPV5531030104043674649MC-51-CR-0051309-2010100359321368', // JIRA DF-28921
'I0010I00101415507545384632596907CR111420070111000475294212', // JIRA DF-28932
'I0010I00101415507545384632596907CR170820070228000475294212', // JIRA DF-28932
'I0010I00101705187257968937392007CR111420070111000475294212', // JIRA DF-28932
'I0010I00101705187257968937392007CR170820070228000475294212', // JIRA DF-28932
'I0128I01281705187257968937392007CR111420070111000475294212', // JIRA DF-28932
'NFNF170518725796893739204002012IF71791520120730000475294212', // JIRA DF-28932
'NFNF170518725796893739206302001CR01107420011214000475294212', // JIRA DF-28932
'VBVB17051872579689373920730GT050127480020051102000475294212',  // JIRA DF-28932
'I0006I00061267306707874217544509-97-K-0156319970430000535150561', // JIRA DF-28969
'I0006I00061510121648506017789010-97-K-0005319970508000535150561', // JIRA DF-28969
'NGNG1201832659601088545509-97-K-0156319970430000535150561', // JIRA DF-28969
'NGNG1575599215216357060010-97-K-0005319970508000535150561',  // JIRA DF-28969
'I0043I0043779665787585084036219550919000189509788',  // JIRA DF-28971
'BWBW171975774725685840751967013020060309000777058769', // JIRA DF-28970
'BWBW171975774725685840751967013020061018000777058769', // JIRA DF-28970
'CLCL11575942229288202576BAM00232619970930000777058769', // JIRA DF-28970
'I0014I00141157594222928820257604377BBJL20060710000777058769', // JIRA DF-28970
'I0014I0014115759422292882025762519676JL20060724000777058769', // JIRA DF-28970
'I0014I001411575942229288202576317265JL20060809000777058769', // JIRA DF-28970
'NFNF166633679346892840381702002CR05733420020912000777058769', // JIRA DF-28970
'NFNF55012681062346035291702003CR00382320030326000777058769', // JIRA DF-28970
'TVTV1157594222928820257604377BBJL20060710000777058769', // JIRA DF-28970
'TVTV115759422292882025762519676JL20060724000777058769', // JIRA DF-28970
'TVTV11575942229288202576317265JL20060809000777058769', // JIRA DF-28970
'TVTV5501268106234603529551456JL19980123000777058769',  // JIRA DF-28970
'I0014I00141172033357975905591721736TJCM20040223001748752766', // JIRA DF-28973
'I0014I00141659660583538379815321736TJCM20040223001748752766', // JIRA DF-28973
'Z1Z116599441475872386736J-0203-CT-202000104620200525001748752766' // JIRA DF-28973
   ];

export fn_blank_the_did(dataset(recordof(hygenics_crim.Layout_Common_Crim_Offender_new)) in_crim) := function

	recordof(in_crim) t1(in_crim le) := transform
		 self.did := MAP(trim(le.state, left, right)+trim(le.did, left, right) in did_st_set => '',
							trim(le.vendor, left, right)+trim(le.did, left, right) in did_vendor_set => '',
							trim(le.vendor, left, right)+trim(le.case_number,left,right)+trim(le.did, left, right) in vendor_case_number_did => '',
							trim(le.vendor)+trim(le.offender_key)+trim(le.did) in vendor_offenderkey_did => '',
							trim(le.did, left, right));
		 self.ssn := MAP(trim(le.vendor, left, right)+trim(le.did, left, right) in did_vendor_set => '',
										 trim(le.vendor, left, right)+trim(le.case_number,left,right)+trim(le.did, left, right) in vendor_case_number_did => '',
										 trim(le.vendor)+trim(le.offender_key)+trim(le.did) in vendor_offenderkey_did => '',
										 le.ssn);  
		 self     := le;
	end;

	p1 := project(in_crim,t1(left));

return p1;

end;