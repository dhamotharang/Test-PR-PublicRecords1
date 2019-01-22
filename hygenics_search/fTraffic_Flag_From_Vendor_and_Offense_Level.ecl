/*sVendor08TrafficSet := ['T'];

export fTraffic_Flag_From_Vendor_and_Offense_Level(string2 pVendor, string5 pOffenseLevel) :=
  case(pVendor, '' => if(trim(pOffenseLevel,right) in sVendor08TrafficSet,'Y','N'),
  	   '');*/
			 
			 
			 
/*2012-03-14T19:03:53Z (Vani Chikte)
added hygenics sources
*/
sVendor08TrafficSet		// NC
 := [
	 'T'
	]
 ;

sVendor31TrafficSet		// Oregon court court_offense_level values deemed non-felony or misdemeanor
 := [
	'BINF',
	'UVIO',
	'AINF',
	'DINF',
	'CINF',
	'UINF',
	'AVIO',
	'VIO',
	'ORD',
	'INF',
	'AVI',
	'UVI',
	'VI',
	'DVIO',
	'VVIO',
	'BVIO',
	'IF',
	'UORD',
	'AIF',
	'V',
	'UIF',
	'CIF',
	'I',
	'BVI',
	'VINF',
	'CVIO',
	'UVIL',
	'VVI',
	'2VIO',
	'MVIO',
	'VVOI'
	]
 ;

sVendor44TrafficSet		// FL Osceola
 := [
	 'TT'
	]
 ;

sVendor48TrafficSet		// UT Court
 := [
	 'I',
	 'IN'
	]
 ;

sVendor57TrafficSet		// VA Fairfax
 := [
	 'I',
	 'ORD'
	]
 ;

sVendor60TrafficSet		// TX Denton
 := [
	 'MT',
	 'MTA'
	]
 ;
 
sVendor1YTrafficSet		// MO Court
 := [
	 'O'
	]
 ;

sVendor3FTrafficSet		// OH Brown Court
 := [
	 'T'
	]
 ;

sVendor3ITrafficSet		// OH Lawrence Court
 := [
	 'T'
	]
 ;
 
sVendor3JTrafficSet		// OH Pickaway Court
 := [
	 'T'
	]
 ;
 
sVendor3KTrafficSet		// TX Grayson Court
 := ['MCT', 'T' ]
 ;
 
sVendor3LTrafficSet		// TX Lamar Court
 := [
	 'T'
	]
 ;
 
sVendor3NTrafficSet		// LA East Baton Rouge Court
 := [
	 'TR'
	]
 ;

sVendor3OTrafficSet		// LA Jefferson Court
 := ['C',
	 'T'
	]
 ;
 
sVendor4DTrafficSet		// OH Brown Court
 := [
	 'T'
	]
 ;
//----------------------------------------------------
//Hygenics sources
//----------------------------------------------------
sVendorCMTrafficSet		// CA_VENTURA_CTY
 := [ 'I','T'
	  ];
		
sVendorFHTrafficSet  //  FL_ALACHUA_CTY
:= [ 'I','MM'
	  ];

sVendorFETrafficSet		// FL_BROWARD_CTY
 := ['TI','TC','I',
	   'TT'////,'MO'
	  ];

sVendorFKTrafficSet		// FL_CHARLOTTE_CTY
 := ['T'
	  ];
		
sVendorFGTrafficSet		// FL_HILLSBOROUGH_CTY
 := ['I'////,'MO','CO'
	  ];
		
sVendorFCTrafficSet		// FL_LEE_CTY
 := ['I',
	   'IN' 
		];
		
sVendorFMTrafficSet		// FL_LEON_CTY
 := ['T','I','CT',
     'TI','TR-CO'////,'CO','MO'
	  ];		

sVendorFUTrafficSet		// FL_MARION_CTY
 := ['I','IN'
	  ];
		
sVendorFBTrafficSet		// FL_SARASOTA_CTY
 := ['T','CT'
	  ];		
		
sVendorIBTrafficSet		// IL_COOK_CTY
 := [ 'T',
     'TT',
		 'T2',
		 'T4',
		 'TA',
		 'TH',
		 'TM'////,'MM','MO'
	  ];
		
sVendorLBTrafficSet		// LA_ST_TAMMANY_CTY
 := ['T',
     'I'
	  ];
		
sVendorPRTrafficSet		// VA_FAIRFAX_CTY
 := ['I'
	  ];		
		
sVendorZ1TrafficSet
		 := ['T',/*'TNC',*/'TP'
	  ];
		
sVendorNBTrafficSet
		 := ['T', ////'CO','MM','MO',   
         //'TC',
         //'TCM',
				 //'TCP',
				 'TM',
				 'TR',
				 'I'
				 //'TRM'
				 ];  
sVendorUATrafficSet		// UT Court
 := ['T',
	 'I',
	 'IN'
	]
 ;
 sVendorNFTrafficSet
 := ['IN'	,'I'] ;
 
 sVendorRATrafficSet
 := ['V','T'];
 
 sVendorHATrafficSet
 := ['V','I'];
 
 sVendorFVTrafficSet
 := ['V','T','I','I1','I2'];
 
 sVendorMFTrafficSet
 := ['V','I'];
 
 sVendorUVTrafficSet
 := ['TU','TP','TA','T','TB','TC','T4'];
 

sVendorTrafficSet	
:= ['T','TA','TB','TI','T1','T0','T2','T1A','T1B','TIA','TIB','CT','T','I','TR','IN','MTV','MT','TM','CT','T/MI'////,'CO','COR','MM','MO','MO1','MO2' 
		];
		
sVendorTrafficSetNoMMMO	
:= ['T','TA','TB','TI','T1','T0','T2','T1A','T1B','TIA','TIB','CT','T','I','TR','IN','TC'
    ////,'COR'
]		;

sVendorTrafficSetNoCT
:= ['T','TA','TB','TI','T1','T0','T2','T1A','T1B','TIA','TIB','T','I','TR','IN'
    
]		;

sVendorMMTrafficSet	
:= ['MM','T','I'];

sVendorMTTrafficSet	
:= ['T','I','PMT','MT'];

S_vendor_standard_NO_CT := 	['UN','UP','VG'];

sVendor7VTrafficSet := 	['PVI','PVM2','TVI','TVM1','TVM2','CT','CTI','CTM1','CTM2'];

S_vendor_standard := [
'UW','KP','TE','TF','FP','FS','GH','IC','BA','BZ','CS','PU','RR',
'RE','CF','OC','TD','FO','OA','PM','PO','PQ','PB','OF','OQ','OI','PD','OT','OP','OJ',
'PL','ON','OW','OS','PO','PH','EZ','PF','OV','OL','OU','PC','OC','OB','OZ','TF',
'TH','TM','TQ','TO','MG','Z9','TB','WB','PY','PI','FA','FQ','TL','2E','RC','CC',
'FT','QX','TI', '1U','2D','CK',

'QJ','QI','QN','QO','QL','PZ','QZ','QY','QR','QS','QP','QQ','QV','QW','QT',
'QU','TS','TV','RV','RQ','RP','RY','RX','RO','RN','RM','RL','RK','RJ','VK',
'VD','UO','UL','UJ','UK','UH','UI','UF','VR','UE','UB','UC','UN','UP','UQ','UR',
'UU','UX','UY','UZ','VC','VF','VI','VJ','VL','VM','VN','VO',
'VP','VU','VW','VX','VY','VZ','WM','WN','WO','WP','WQ','WR','WS','WT','WU','WW',
'WX','WZ','XX','XY','XZ','YA','YB','YC','YD','YE','YF','YH','YK','YL','YM','YN','YU','YZ',

'3A','3N','6F','6G','3U','3V','3W','3P','3S','3Z','4Q','4P','4R','4U',
'4T','4V','4A','4I','4H','4K','4J','4M','4L','4O','4N','4Z','ZZ','ZY','ZX','ZW','ZV',
'ZU','ZT','ZS','ZR','ZQ','ZP','ZO','ZN','ZM','ZL','ZK','ZJ','ZI','ZH','ZG','ZF',
'ZE','ZD','RS','RT','OX','RU','2Z','ZC','7C','QM','UR','6O','6N',

'TU','B1','5A','5B','5C','5D','5H','5J','5L','5P','6J','YG','91',

'CH','FR','VB','CG','7U','7W','7X'
];	                    

//-------------------------------------------------------'FN','SA','VG','3B','4S','5G', //traffic records have issue
export fTraffic_Flag_From_Vendor_and_Offense_Level(string5 pVendor, string5 pOffenseLevel)
 :=
  map(
	
	pVendor = '08' => if(trim(pOffenseLevel,right) in sVendor08TrafficSet,'Y','N'),
	pVendor = '31' => if(trim(pOffenseLevel,right) in sVendor31TrafficSet,'Y','N'),
	pVendor = '44' => if(trim(pOffenseLevel,right) in sVendor44TrafficSet,'Y','N'),
	pVendor = '45' => if(pOffenseLevel[1] = 'T','Y','N'),
	pVendor = '48' => if(trim(pOffenseLevel,right) in sVendor48TrafficSet,'Y','N'),
	pVendor = '57' => if(trim(pOffenseLevel,right) in sVendor57TrafficSet,'Y','N'),
	pVendor = '60' => if(trim(pOffenseLevel,right) in sVendor60TrafficSet,'Y','N'),
	pVendor = '1Y' => if(trim(pOffenseLevel,right) in sVendor1YTrafficSet,'Y','N'),
	pVendor = '3F' => if(trim(pOffenseLevel,right) in sVendor3FTrafficSet,'Y','N'),
	pVendor = '3I' => if(trim(pOffenseLevel,right) in sVendor3ITrafficSet,'Y','N'),
	pVendor = '3J' => if(trim(pOffenseLevel,right) in sVendor3JTrafficSet,'Y','N'),
	pVendor = '3K' => if(trim(pOffenseLevel,right) in sVendor3KTrafficSet,'Y','N'),
	pVendor = '3L' => if(trim(pOffenseLevel,right) in sVendor3LTrafficSet,'Y','N'),
	pVendor = '3N' => if(trim(pOffenseLevel,right) in sVendor3NTrafficSet,'Y','N'),
	pVendor = '3O' => if(trim(pOffenseLevel,right) in sVendor3OTrafficSet,'Y','N'),
	pVendor = '4D' => if(trim(pOffenseLevel,right) in sVendor4DTrafficSet,'Y','N'),
		 
//----------------------------------------------------------------------------		 
//Hygenics sources
//----------------------------------------------------------------------------

  pVendor =  'CM' => if(trim(pOffenseLevel,right) in sVendorCMTrafficSet,'Y','N'),		
	pVendor =	 'FH' => if(trim(pOffenseLevel,right) in sVendorFHTrafficSet,'Y','N'),
	pVendor =	 'FE' => if(trim(pOffenseLevel,right) in sVendorFETrafficSet,'Y','N'),	
	pVendor =	 'FK' => if(trim(pOffenseLevel,right) in sVendorFKTrafficSet,'Y','N'),	
	pVendor =	 'FG' => if(trim(pOffenseLevel,right) in sVendorFGTrafficSet,'Y','N'),	
	pVendor =	 'FC' => if(trim(pOffenseLevel,right) in sVendorFCTrafficSet,'Y','N'),	
	pVendor =	 'FM' => if(trim(pOffenseLevel,right) in sVendorFMTrafficSet,'Y','N'),	
	pVendor =	 'FU' => if(trim(pOffenseLevel,right) in sVendorFUTrafficSet,'Y','N'),	
	pVendor =	 'FB' => if(trim(pOffenseLevel,right) in sVendorFBTrafficSet,'Y','N'),
	pVendor IN['IB','7Y'] => if(trim(pOffenseLevel,right) in sVendorIBTrafficSet,'Y','N'),
	pVendor =	 'LB' => if(trim(pOffenseLevel,right) in sVendorLBTrafficSet,'Y','N'),
	pVendor =	 'PR' => if(trim(pOffenseLevel,right) in sVendorPRTrafficSet,'Y','N'),		 
	pVendor =	 'UA' => if(trim(pOffenseLevel,right) in sVendorUATrafficSet,'Y','N'),
	pVendor =	 'Z1' => if(trim(pOffenseLevel,right) in sVendorZ1TrafficSet,'Y','N'),
	pVendor =	 'NB' => if(trim(pOffenseLevel,right) in sVendorNBTrafficSet,'Y','N'),
	pVendor =	 'NF' => if(trim(pOffenseLevel,right) in sVendorNFTrafficSet,'Y','N'),
	pVendor =	 'RA' => if(trim(pOffenseLevel,right) in sVendorRATrafficSet,'Y','N'),
	pVendor =	 'HA' => if(trim(pOffenseLevel,right) in sVendorHATrafficSet,'Y','N'),
	pVendor =	 'CP' => if(trim(pOffenseLevel,right) in sVendorHATrafficSet,'Y','N'),
	pVendor =	 'MF' => if(trim(pOffenseLevel,right) in sVendorMFTrafficSet,'Y','N'),
	// commented once we hear from risk view we can decide 
	//pVendor =	 'RN' => if(trim(pOffenseLevel,right) in sVendorMMTrafficSet,'Y','N'),
  //pVendor =	 'QY' => if(trim(pOffenseLevel,right) in sVendorMMTrafficSet,'Y','N'),
  //pVendor =	 'QY' => if(trim(pOffenseLevel,right) in sVendorMMTrafficSet,'Y','N'),
  //pVendor =	 'VR' => if(trim(pOffenseLevel,right) in sVendorMMTrafficSet,'Y','N'),
  //pVendor =	 'RO' => if(trim(pOffenseLevel,right) in sVendorMMTrafficSet,'Y','N'),
	//pVendor =	 'PT' => if(pOffenseLevel[1] IN [ 'V','I'],'Y','N'), temprarily removing infraction and violation as traffic
	pVendor =	 '5W' => if(pOffenseLevel IN [ /*'TV',*/'T'],'Y','N'), //TV doesn't look traffic
	pVendor =	 'CF' => if(trim(pOffenseLevel,right) in sVendorTrafficSet,'Y','N'),
  pVendor =	 '5Q' => if(trim(pOffenseLevel,right) in sVendorMTTrafficSet,'Y','N'),
	pVendor =	 '5X' => if(trim(pOffenseLevel,right) in sVendorMTTrafficSet,'Y','N'),
	pVendor =	 '6E' => if(trim(pOffenseLevel,right) in sVendorMTTrafficSet,'Y','N'),
	pVendor =	 '7G' => if(trim(pOffenseLevel,right) in sVendorMTTrafficSet,'Y','N'),
	pVendor =	 '7N' => if(trim(pOffenseLevel,right) in sVendorMTTrafficSet,'Y','N'),	
	pVendor =	 '5Y' => if(trim(pOffenseLevel,right) in sVendorMTTrafficSet,'Y','N'),
	pVendor =	 '7O' => if(trim(pOffenseLevel,right) in sVendorMTTrafficSet,'Y','N'),
	pVendor =	 '6L' => if(trim(pOffenseLevel,right) in sVendorMTTrafficSet,'Y','N'),
	// pVendor =	 '6S' => if(trim(pOffenseLevel,right) in sVendorMTTrafficSet,'Y','N'), //these don't look traffic
	pVendor =	 'CI' => if(trim(pOffenseLevel,right) in sVendorMTTrafficSet,'Y','N'),
	pVendor =	 'RW' => if(trim(pOffenseLevel,right) in sVendorMTTrafficSet,'Y','N'),
	
	pVendor =	 'US' => if(trim(pOffenseLevel,right) in sVendorTrafficSetNoMMMO,'Y','N'),
	pVendor =	 'UV' => if(trim(pOffenseLevel,right) in sVendorUVTrafficSet,'Y','N'),
	pVendor =	 'UW' => if(trim(pOffenseLevel,right) in sVendorTrafficSetNoMMMO,'Y','N'),
	//pVendor =	 'UP' => if(trim(pOffenseLevel,right) in sVendorTrafficSetNoMMMO,'Y','N'), //handled in NO_CT
	pVendor =	 '7A' => if(trim(pOffenseLevel,right) in ['MAT','MBT','MCT','MUT'],'Y','N'),
	pVendor =	 '7C' => if(trim(pOffenseLevel,right) in sVendorTrafficSetNoMMMO,'Y','N'),
	pVendor =	 '7D' => if(trim(pOffenseLevel,right) in sVendorTrafficSetNoMMMO,'Y','N'),
	pVendor =	 '7E' => if(trim(pOffenseLevel,right) in sVendorTrafficSetNoMMMO,'Y','N'),
	pVendor =	 '7F' => if(trim(pOffenseLevel,right) in sVendorTrafficSetNoMMMO,'Y','N'),
	pVendor =	 'FV' => if(trim(pOffenseLevel,right) in sVendorFVTrafficSet,'Y','N'),
	pVendor =	 '7V' => if(trim(pOffenseLevel,right) in sVendor7VTrafficSet,'Y','N'),
	pVendor =  'FN' => if(pOffenseLevel = 'CT','Y','N'),
	pVendor IN	S_vendor_standard_NO_CT=> if(trim(pOffenseLevel,right) in sVendorTrafficSetNoCT,'Y','N'),
	pVendor IN	S_vendor_standard => if(trim(pOffenseLevel,right) in sVendorTrafficSet,'Y','N'),
	pVendor =	'8S' => if(trim(pOffenseLevel,right) in ['MT'],'Y','N'),
	pVendor =	'8T' => if(trim(pOffenseLevel,right) in ['CVT','CT'],'Y','N'),
	pVendor =	'9J' => if(trim(pOffenseLevel,right) in ['T'],'Y','N'),
	pVendor =	'9L' => if(trim(pOffenseLevel,right) in ['TI','T','CT'],'Y','N'),
	pVendor =	'9N' => if(trim(pOffenseLevel,right) in ['T'],'Y','N'),
	pVendor =	'9W' => if(trim(pOffenseLevel,right) in ['MT'],'Y','N'),
		//Crimwise Sources
	pVendor =	'W0002' => if(trim(pOffenseLevel,right) in ['MT','GMT','T','PMT','FT'],'Y','N'),
	pVendor IN ['W0016'] => if(trim(pOffenseLevel,right) in ['TI','CT'],'Y','N'),
  pVendor IN ['W0017'] => if(trim(pOffenseLevel,right) in ['T','TI'],'Y','N'),
	
	pVendor IN ['W0027','8R',	'W0271','W0272','W0273','W0274','W0275','W0277','W0278','W0279','W0280',
	            'W0281','W0282','W0283','W0284','W0285','W0286','W0287','W0288','W0289','W0292','W0294',
							'W0295','W0296','W0297','W0298','W0299','W0301','W0302','W0304','W0306','W0307','W0309',
							'I0002','I0010','I0031','I0015','I0016','I0032','I0005','I0006' ] => if(trim(pOffenseLevel,right) in ['T'],'Y','N'),
						 

	pVendor IN ['W0037','10B','10C'] => if(trim(pOffenseLevel,right) in ['T'],'Y','N'),
  pVendor IN ['W0038'] => if(trim(pOffenseLevel,right) in ['T','TA'],'Y','N'),  
	pVendor IN ['W0156'] => if(trim(pOffenseLevel,right) in ['T','MT'],'Y','N'),
	pVendor IN ['W0253'] => if(trim(pOffenseLevel,right) in ['CT'],'Y','N'),
	pVendor IN ['I0008'] => if(trim(pOffenseLevel,right) in ['T','V'],'Y','N'),
	pVendor IN ['I0018'] => if(trim(pOffenseLevel,right) in ['T','PO'],'Y','N'),
  

  ''
	)
 ;			 