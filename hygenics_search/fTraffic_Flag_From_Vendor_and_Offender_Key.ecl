sVendor82TrafficSet		// OK-29_Counties have traffic/infraction if positions 7-9 of offender_key have any of these
 := [
	'CRT',
	'MRT',
	'NFT',
	'TR ',
	'TRI',
	'TRC',
	'TRI',
	'T  ',
	'TV ',
	'BTR',
	'WL '
	]
 ;

sVendor89TrafficSet		// OH-Putnam have traffic if "TR D" is found in between two sets of numbers (99999 TR D 99999)
 :=	[
	'TR D'
	]
 ;

export fTraffic_Flag_From_Vendor_and_Offender_Key(string5 pVendor, string pOffenderKey)
 :=
  case(pVendor,
	   '82' => 	if(pOffenderKey[7..9] in sVendor82TrafficSet,'Y','N'),
	   '89'=>	if(trim(regexreplace('[0-9]+',regexreplace('^[0-9]+',pOffenderKey,''),''),left,right) in sVendor89TrafficSet,'Y','N'),
     '8K' =>  if(stringlib.stringfind(pOffenderKey,'TRD',1)>0 OR stringlib.stringfind(pOffenderKey,'TRC',1)>0,'Y','N'),     //OH_SANDUSKY_CTY_CPC 	TRC
		 		 
		 '8N' =>  if(stringlib.stringfind(pOffenderKey,'TRC',1)>0 OR 
		             stringlib.stringfind(pOffenderKey,'TRD',1)>0 OR stringlib.stringfind(pOffenderKey,'CT',1)>0,'Y','N'),      //OH_HURONCTY_NRWLK_MC	
		 
		 '8U' =>  if(stringlib.stringfind(pOffenderKey,'-TRD-',1)>0,'Y','N'),	
		 '8X' =>  if(stringlib.stringfind(pOffenderKey,'TRC',1)>0 OR stringlib.stringfind(pOffenderKey,'TRD',1)>0,'Y','N'),	    //OH_JEFFERSON_STUBNVI	TRC	
		 
		 '8T' =>  if(stringlib.stringfind(pOffenderKey,'CT',1)>0 OR stringlib.stringfind(pOffenderKey,'TR',1)>0,'Y','N'),       //FL_CITRUS_CTY 
		 '9A' =>  if(stringlib.stringfind(pOffenderKey,'TRD',1)>0,'Y','N'),
		 
		 '9B' =>  if(stringlib.stringfind(pOffenderKey,'TRC',1)>0 OR stringlib.stringfind(pOffenderKey,'TRD',1)>0,'Y','N'),     //OH_CUYAHOG_LNDHRSTMC	TRC
		 
		 '9E' =>  if(stringlib.stringfind(pOffenderKey,'TRC',1)>0 OR stringlib.stringfind(pOffenderKey,'TRD',1)>0,'Y','N'),     //OH_GREENE_FAIRBORNMC	TRC
		 '9H' =>  if(stringlib.stringfind(pOffenderKey,'TRD',1)>0,'Y','N'),
		 
		 '9I' =>  if(stringlib.stringfind(pOffenderKey,'TRC',1)>0 OR stringlib.stringfind(pOffenderKey,'TRD',1)>0,'Y','N'),     //OH_MARION_CTY_MC    	TRC
		 
		 '9J' =>  if(stringlib.stringfind(pOffenderKey,'TRC',1)>0 OR stringlib.stringfind(pOffenderKey,'TRD',1)>0,'Y','N'),     //OH_MEDINA_WADSWRTHMC	TRC
		 
		 '9K' =>  if(stringlib.stringfind(pOffenderKey,'TRC',1)>0 OR stringlib.stringfind(pOffenderKey,'TRD',1)>0,'Y','N'),     //OH_MEIGS_CTY_MC     	TRC
		 
		 '9N' =>  if(stringlib.stringfind(pOffenderKey,'TRC',1)>0 OR stringlib.stringfind(pOffenderKey,'-TRD-',1)>0,'Y','N'),   //OH_DARKE_CTY_MC     	TRC	
		 
		 '9R' =>  if(stringlib.stringfind(pOffenderKey,'-TRC-',1)>0 OR stringlib.stringfind(pOffenderKey,'-TRD-',1)>0,'Y','N'), //OH_STARK_CTYMASLONMC	TRC	

		 '9S' =>  if(stringlib.stringfind(pOffenderKey,'-TRC-',1)>0 OR stringlib.stringfind(pOffenderKey,'-TRD-',1)>0,'Y','N'), //OH_STARK_CTY_CANTON_	TRC	
		 
		 '9L' =>  if(stringlib.stringfind(pOffenderKey,'CT',1)>0 OR stringlib.stringfind(pOffenderKey,'TR',1)>0,'Y','N'),       //FL_ST_LUCIE_CTY_CRC 	TR,TRC
		 
	   	   
     '6M' =>  if(stringlib.stringfind(pOffenderKey,'TRC',1)>0 OR stringlib.stringfind(pOffenderKey,'TRD',1)>0,'Y','N'), // 	OH_BUTLERFAIRFELD_MC
		 '7H' =>  if(stringlib.stringfind(pOffenderKey,'TRC',1)>0 OR stringlib.stringfind(pOffenderKey,'TRD',1)>0,'Y','N'), // 	OH_GALLIA_GALIPLS_MC
		 'OC' =>  if(stringlib.stringfind(pOffenderKey,'TRC',1)>0 OR stringlib.stringfind(pOffenderKey,'TRD',1)>0,'Y','N'), // 	OHMONTGOMRY_DAYTN_MC
		 'OX' =>  if(stringlib.stringfind(pOffenderKey,'TRC',1)>0 OR stringlib.stringfind(pOffenderKey,'TRD',1)>0,'Y','N'), // 	OH_CUYHOGA_EUCLID_MC
		 'PI' =>  if(stringlib.stringfind(pOffenderKey,'TRC',1)>0 OR stringlib.stringfind(pOffenderKey,'TRD',1)>0,'Y','N'), // 	OHMNGMRY_N_LEBNON_CC
		 'PJ' =>  if(stringlib.stringfind(pOffenderKey,'TRC',1)>0 OR stringlib.stringfind(pOffenderKey,'TRD',1)>0,'Y','N'), // 	OH_CUYHOGA_BEREA_MC 
		 'PK' =>  if(stringlib.stringfind(pOffenderKey,'TRC',1)>0 OR stringlib.stringfind(pOffenderKey,'TRD',1)>0,'Y','N'), // 	OH_MNGMRY_HUBRHTS_CC
		 'PL' =>  if(stringlib.stringfind(pOffenderKey,'TRC',1)>0 OR stringlib.stringfind(pOffenderKey,'TRD',1)>0,'Y','N'), // 	OH_MNGMRY_KETERIN_MC
		 'PO' =>  if(stringlib.stringfind(pOffenderKey,'TRC',1)>0 OR stringlib.stringfind(pOffenderKey,'TRD',1)>0,'Y','N'), // 	OH_STARK_CTY        
		 'QP' =>  if(stringlib.stringfind(pOffenderKey,'TRC',1)>0 OR stringlib.stringfind(pOffenderKey,'TRD',1)>0,'Y','N'), // 	OH_LAKE_CTY_MENTR_MC
		 'QQ' =>  if(stringlib.stringfind(pOffenderKey,'TRC',1)>0 OR stringlib.stringfind(pOffenderKey,'TRD',1)>0,'Y','N'), // 	OH_LAKE_CTY_PAINS_MC
		 'QU' =>  if(stringlib.stringfind(pOffenderKey,'TRC',1)>0 OR stringlib.stringfind(pOffenderKey,'TRD',1)>0,'Y','N'), // 	OH_HAMILTON_CTY     
		 'VK' =>  if(stringlib.stringfind(pOffenderKey,'TRC',1)>0 OR stringlib.stringfind(pOffenderKey,'TRD',1)>0,'Y','N'), // 	OH_AUGLAIZE_CTY     
		 'VL' =>  if(stringlib.stringfind(pOffenderKey,'TRC',1)>0 OR stringlib.stringfind(pOffenderKey,'TRD',1)>0,'Y','N'), // 	OH_BELMONT_CTY_EDIST
		 'VM' =>  if(stringlib.stringfind(pOffenderKey,'TRC',1)>0 OR stringlib.stringfind(pOffenderKey,'TRD',1)>0,'Y','N'), // 	OH_BELMONT_CTY_NDIST
		 'VN' =>  if(stringlib.stringfind(pOffenderKey,'TRC',1)>0 OR stringlib.stringfind(pOffenderKey,'TRD',1)>0,'Y','N'), // 	OH_BELMONT_CTY_WDIST
		 'VW' =>  if(stringlib.stringfind(pOffenderKey,'TRC',1)>0 OR stringlib.stringfind(pOffenderKey,'TRD',1)>0,'Y','N'), // 	OH_COSHOCTON_CTY_MC 
		 'WM' =>  if(stringlib.stringfind(pOffenderKey,'TRC',1)>0 OR stringlib.stringfind(pOffenderKey,'TRD',1)>0,'Y','N'), // 	OH_CUYAHOGA_GARFHTMC
		 'WO' =>  if(stringlib.stringfind(pOffenderKey,'TRC',1)>0 OR stringlib.stringfind(pOffenderKey,'TRD',1)>0,'Y','N'), // 	OH_CUYAHOGA_RKYRIVMC
		 'WQ' =>  if(stringlib.stringfind(pOffenderKey,'TRC',1)>0 OR stringlib.stringfind(pOffenderKey,'TRD',1)>0,'Y','N'), // 	OH_ERIE_VERMILION_MC
		 'WS' =>  if(stringlib.stringfind(pOffenderKey,'TRC',1)>0 OR stringlib.stringfind(pOffenderKey,'TRD',1)>0,'Y','N'), // 	OH_JEFFERSON_TORONTO
     'WU' =>  if(stringlib.stringfind(pOffenderKey,'TRC',1)>0 OR stringlib.stringfind(pOffenderKey,'TRD',1)>0,'Y','N'), // 	OH_HIGHLAND_HILLSBMC
		 'WX' =>  if(stringlib.stringfind(pOffenderKey,'TRC',1)>0 OR stringlib.stringfind(pOffenderKey,'TRD',1)>0,'Y','N'), // 	OH_JEFFERSON_DILLONV
		 'WZ' =>  if(stringlib.stringfind(pOffenderKey,'TRC',1)>0 OR stringlib.stringfind(pOffenderKey,'TRD',1)>0,'Y','N'), // 	OH_JEFFERSON_WNTERSV
		 'XZ' =>  if(stringlib.stringfind(pOffenderKey,'TRC',1)>0 OR stringlib.stringfind(pOffenderKey,'TRD',1)>0,'Y','N'), // 	OH_LORAIN_AVONLAKEMC
	   'YC' =>  if(stringlib.stringfind(pOffenderKey,'TRC',1)>0 OR stringlib.stringfind(pOffenderKey,'TRD',1)>0,'Y','N'), // 	OH_LORAIN_CTY_MC    
     'YF' =>  if(stringlib.stringfind(pOffenderKey,'TRC',1)>0 OR stringlib.stringfind(pOffenderKey,'TRD',1)>0,'Y','N'), // 	OH_LUCAS_SYLVANIA_MC
     'YK' =>  if(stringlib.stringfind(pOffenderKey,'TRC',1)>0 OR stringlib.stringfind(pOffenderKey,'TRD',1)>0,'Y','N'), // 	OH_MNTGMRY_MIAMSBRGM
     'YT' =>  if(stringlib.stringfind(pOffenderKey,'TRC',1)>0 OR stringlib.stringfind(pOffenderKey,'TRD',1)>0,'Y','N'), // 	OH_SHELBY_SIDNEY_MC 
     'YU' =>  if(stringlib.stringfind(pOffenderKey,'TRC',1)>0 OR stringlib.stringfind(pOffenderKey,'TRD',1)>0,'Y','N'), // 	OH_TRUMBUL_GIRARD_MC
     'QT'	=>  if(stringlib.stringfind(pOffenderKey,'TRC',1)>0 ,'Y','N'), // 	OH_MEDINA_CTY_MC
     'QW'	=>  if(stringlib.stringfind(pOffenderKey,'TRC',1)>0 ,'Y','N'), // 	OH_ADAMS_CTY_COURT
     'VR'	=>  if(stringlib.stringfind(pOffenderKey,'TRC',1)>0 ,'Y','N'), // 	OH_CHAMPAIGN_CTY
     'YE'	=>  if(stringlib.stringfind(pOffenderKey,'TRD',1)>0 ,'Y','N'), // 	OH_LUCAS_MAUMEE_MC  


		 'W0028'=>  if(stringlib.stringfind(pOffenderKey,'TRC',1)>0 OR stringlib.stringfind(pOffenderKey,'TRD',1)>0,'Y','N'), // 	OH_ERIE_CTY_HURON_MC
		 'W0031'=>  if(stringlib.stringfind(pOffenderKey,'TRC',1)>0 OR stringlib.stringfind(pOffenderKey,'TRD',1)>0,'Y','N'), // 	OH_HARRISON_CTY_MC  
		 'W0034'=>  if(stringlib.stringfind(pOffenderKey,'TRC',1)>0 OR stringlib.stringfind(pOffenderKey,'TRD',1)>0,'Y','N'), // 	OH_MARION_CTY_MC    
		 'W0035'=>  if(stringlib.stringfind(pOffenderKey,'TRC',1)>0 OR stringlib.stringfind(pOffenderKey,'TRD',1)>0,'Y','N'), // 	OH_MERCER_CTY_CELINA
     'W0036'=>  if(stringlib.stringfind(pOffenderKey,'TRC',1)>0 OR stringlib.stringfind(pOffenderKey,'TRD',1)>0,'Y','N'), // 	OH_SENECA_CTY_FOSTOR
		 'W0037'=>  if(stringlib.stringfind(pOffenderKey,'TRC',1)>0 OR stringlib.stringfind(pOffenderKey,'TRD',1)>0,'Y','N'), // 	OH_WOOD_CTY_PERRYSBU
		 'W0150'=>  if(stringlib.stringfind(pOffenderKey,'TRC',1)>0 OR stringlib.stringfind(pOffenderKey,'TRD',1)>0,'Y','N'), // 	OH_WARRENCTY_LEBN_MC
		 'W0153'=>  if(stringlib.stringfind(pOffenderKey,'TRC',1)>0 OR stringlib.stringfind(pOffenderKey,'TRD',1)>0,'Y','N'), // 	OH_ERIE_SANDUSKY_MC 
		 'W0252' =>  if(stringlib.stringfind(pOffenderKey,'TRC',1)>0 OR stringlib.stringfind(pOffenderKey,'TRD',1)>0,'Y','N'),  //OHIO_AUGLAIZE_COUNTY_MUNICIPAL_COURT_CW	
		 
		 'W0257' =>  if(stringlib.stringfind(pOffenderKey,'TRC',1)>0 OR stringlib.stringfind(pOffenderKey,'TRD',1)>0,'Y','N'),  //OHIO_JEFFERSON_COUNTY_DILLONVALE_MUNICIPAL_COURT_CW	

		 'W0258' =>  if(stringlib.stringfind(pOffenderKey,'TRC',1)>0 OR stringlib.stringfind(pOffenderKey,'TRD',1)>0,'Y','N'),  //OHIO_MORGAN_COUNTY_MUNICIPAL_COURT_CW	
		 
		 'W0259' =>  if(stringlib.stringfind(pOffenderKey,'TRC',1)>0 OR stringlib.stringfind(pOffenderKey,'TRD',1)>0,'Y','N'),  //OHIO_LICKING_COUNTY_COMMON_PLEAS_COURT_CW
		 'W0318' =>  if(stringlib.stringfind(pOffenderKey,'TRC',1)>0 OR stringlib.stringfind(pOffenderKey,'TRD',1)>0,'Y','N'),  //
		 'W0319' =>  if(stringlib.stringfind(pOffenderKey,'TRC',1)>0 OR stringlib.stringfind(pOffenderKey,'TRD',1)>0,'Y','N'),  //
			
		 '') ;
         
