﻿import ut, corrections;

//bug 29753 highlights a very rare case of 2 individuals with the same name and DOB

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
		'AT035183146689'
		// 'DD002168500989',
		// 'RG002168500989'
		];

	vendor_case_num_did := ['NF1986CR 002310000993117230',
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
		'TBCR25123002317955783'
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
		 'NFNF73380568033829391324102000CR00561820000601001472023472' // JIRA DF-18281
   ];

export fn_blank_the_did(dataset(recordof(Layout_OffenderWithADLFields)) in_crim) := function

	recordof(in_crim) t1(in_crim le) := transform
		 self.did := MAP(ut.st2abbrev(trim(le.orig_state, left, right))+trim(le.did, left, right) in did_st_set => '',
							trim(le.vendor, left, right)+trim(le.did, left, right) in did_vendor_set => '',
							trim(le.vendor, left, right)+trim(le.case_num,left,right)+trim(le.did, left, right) in vendor_case_num_did => '',
							trim(le.vendor)+trim(le.offender_key)+trim(le.did) in vendor_offenderkey_did => '',
							trim(le.did, left, right));
		 self.ssn := MAP(trim(le.vendor, left, right)+trim(le.did, left, right) in did_vendor_set => '',
										 trim(le.vendor, left, right)+trim(le.case_num,left,right)+trim(le.did, left, right) in vendor_case_num_did => '',
										 trim(le.vendor)+trim(le.offender_key)+trim(le.did) in vendor_offenderkey_did => '',
										 le.ssn);  
		 self     := le;
	end;

	p1 := project(in_crim,t1(left)): INDEPENDENT;

return p1;

end;