EXPORT Rewrite_Common := MODULE
 IMPORT Address,_Control,_Validate,
 VersionControl, ut, corp2_mapping; 
  
 	
 EXPORT SprayEnvironment(STRING pSrcMachineName) := MODULE
 //Maps Logical Machine Names to their IP Addresses
  EXPORT STRING IP := MAP(StringLib.StringToLowerCase(pSrcMachineName) ='edata10'	        => _Control.IPAddress.edata10,
  	                      StringLib.StringToLowerCase(pSrcMachineName) ='edata11'	        => _Control.IPAddress.edata11,
  	                      StringLib.StringToLowerCase(pSrcMachineName) ='edata11b'        => _Control.IPAddress.edata11b,
  	                      StringLib.StringToLowerCase(pSrcMachineName) ='edata12'	        => _Control.IPAddress.edata12,
  	                      StringLib.StringToLowerCase(pSrcMachineName) ='edata14'	        => _Control.IPAddress.edata14,
  	                      StringLib.StringToLowerCase(pSrcMachineName) ='edata14a'        => _Control.IPAddress.edata14a,
  	                      StringLib.StringToLowerCase(pSrcMachineName) ='edata15'	        => _Control.IPAddress.edata15,
													StringLib.StringToLowerCase(pSrcMachineName) = 'bctlpedata10'   => _Control.IPAddress.bctlpedata10,      
													StringLib.StringToLowerCase(pSrcMachineName) = 'bctlpedata11'   => _Control.IPAddress.bctlpedata11,      
													StringLib.StringToLowerCase(pSrcMachineName) = 'bctlpedata12'   => _Control.IPAddress.bctlpedata12,      
  	                      StringLib.StringToLowerCase(pSrcMachineName) ='sdsmoxiedev01'   => _Control.IPAddress.sdsmoxiedev01,
  	                      StringLib.StringToLowerCase(pSrcMachineName) ='tapeload01'      => _Control.IPAddress.tapeload01,
  	                      StringLib.StringToLowerCase(pSrcMachineName) ='tapeload02'      => _Control.IPAddress.tapeload02,
  	                      StringLib.StringToLowerCase(pSrcMachineName) ='tapeload02b'     => _Control.IPAddress.tapeload02b,
                          StringLib.StringToLowerCase(pSrcMachineName) ='dataland_esp'    => _Control.IPAddress.dataland_esp,
  	                      StringLib.StringToLowerCase(pSrcMachineName) ='dataland_dali'   => _Control.IPAddress.dataland_dali,
  	                      StringLib.StringToLowerCase(pSrcMachineName) ='dataland_sasha'  => _Control.IPAddress.dataland_sasha,
                          StringLib.StringToLowerCase(pSrcMachineName) ='prod_thor_esp'   => _Control.IPAddress.prod_thor_esp ,
  	                      StringLib.StringToLowerCase(pSrcMachineName) ='prod_thor_dali'  => _Control.IPAddress.prod_thor_dali,
	                      StringLib.StringToLowerCase(pSrcMachineName) ='prod_thor_sasha' => _Control.IPAddress.prod_thor_sasha,'');
													 
	
	EXPORT 
	STRING GroupName := MAP(_Control.ThisCluster.GroupName = 'hthor' and
	   														 _Control.ThisEnvironment.name = 'Dataland' => 'thor_dataland_linux',
			  											   _Control.ThisCluster.GroupName = 'hthor' and
				  											 _Control.ThisEnvironment.name != 'Dataland' => 'thor400_92',
					  										 _Control.ThisCluster.GroupName);
	//Returns a name of Corp Rewrite Root Directory depends upon machine															
	EXPORT STRING RootDir := MAP(StringLib.StringToLowerCase(pSrcMachineName) ='bctlpedata12' => '/data/data_build_4/corporate_filings/sources',
	                             StringLib.StringToLowerCase(pSrcMachineName) ='tapeload02b' => '/corporations', //Needs to be verified!!!  
	                             '');
 END;
 
 Export	FixBadName(string100 pName)	:=	function
	string100 TempName	:=	if (StringLib.StringFind(pName, '"I"+ ',1) <> 0,
								StringLib.StringFindReplace(pName, '"I"+ ', ''),
								if (StringLib.StringFind(pName, '"I"+',1) <> 0,
										StringLib.StringFindReplace(pName, '"I"+', ''),
										if (StringLib.StringFind(pName, '"I"',1) <> 0,
												StringLib.StringFindReplace(pName, '"I"', ''),
												pName
											)
									)
								);
	return TempName;
 END;
 
 
 //Cleans up textual input from non-alphanumeric characters
 //Can also convert into Upper, Lower and Proper cases, and 
 //replace or leave spaces in the middle of multi-word strings
 EXPORT UniformInput(STRING pInput,
                     STRING1 pCase ='',//Upper. Also accepts L(ower) and P(proper)
									 	 BOOLEAN pReplaceSpaces = TRUE) := FUNCTION
		vCase := StringLib.StringToUpperCase(pCase);	
		vPattern := IF(pReplaceSpaces,'[^[:alnum:]]','[^[:alnum:] ]');
		vInput := TRIM(pInput,LEFT,RIGHT);
		vCleanInput := regexreplace(vPattern,vInput,'');
		RETURN MAP(vCase = 'U' => StringLib.StringToUpperCase(vCleanInput),
		           vCase = 'L' => StringLib.StringToLowerCase(vCleanInput),
							 vCase = 'P' => StringLib.StringToProperCase(vCleanInput),
							 vCleanInput);
 END;		
		
											
 
 //Generates a US State-based
 //unique keys (e.g. corp_key or 
 //corp sos charter number)
 //Also returns numeric or two-letter
 //abbreviations of the US States Fips, 
 //(Depending of the passed State Code being
 //numeric of alpha) or US States descriptions

 EXPORT GetUniqueKey(STRING2 pStateCode,
                     STRING  pVndURecId = '',
				             BOOLEAN pDashRequired = TRUE,
										 STRING  pAdditionalIndicator = '') := MODULE
	 SHARED STRING1 v_dash := IF(pDashRequired,'-','');
	 SHARED STRING2 vStateCode := UniformInput(pStateCode,'U');
   SHARED STRING2 vStateFips(STRING2 pStateCode):= IF(regexfind('[[:alpha:]]',vStateCode) AND
                                                      regexfind('[[:digit:]]',vStateCode),'', 
	  	                                                MAP(regexfind('[[:alpha:]]',vStateCode)=> MAP(vStateCode = 'AK'=> '02',vStateCode = 'AL'=> '01',
                                                                                                      vStateCode = 'AR'=> '05',vStateCode = 'AZ'=> '04',
                                                                                                      vStateCode = 'CA'=> '06',vStateCode = 'CO'=> '08',
                                                                                                      vStateCode = 'CT'=> '09',vStateCode = 'DC'=> '11',
                                                                                                      vStateCode = 'DE'=> '10',vStateCode = 'FL'=> '12',
                                                                                                      vStateCode = 'GA'=> '13',vStateCode = 'HI'=> '15',
                                                                                                      vStateCode = 'IA'=> '19',vStateCode = 'ID'=> '16',
                                                                                                      vStateCode = 'IL'=> '17',vStateCode = 'IN'=> '18',
                                                                                                      vStateCode = 'KS'=> '20',vStateCode = 'KY'=> '21',
                                                                                                      vStateCode = 'LA'=> '22',vStateCode = 'MA'=> '25',
                                                                                                      vStateCode = 'MD'=> '24',vStateCode = 'ME'=> '23',
                                                                                                      vStateCode = 'MI'=> '26',vStateCode = 'MN'=> '27',
                                                                                                      vStateCode = 'MO'=> '29',vStateCode = 'MS'=> '28',
                                                                                                      vStateCode = 'MT'=> '30',vStateCode = 'NC'=> '37',
                                                                                                      vStateCode = 'ND'=> '38',vStateCode = 'NE'=> '31',
                                                                                                      vStateCode = 'NH'=> '33',vStateCode = 'NJ'=> '34',
                                                                                                      vStateCode = 'NM'=> '35',vStateCode = 'NV'=> '32',
                                                                                                      vStateCode = 'NY'=> '36',vStateCode = 'OH'=> '39',
                                                                                                      vStateCode = 'OK'=> '40',vStateCode = 'OR'=> '41',
                                                                                                      vStateCode = 'PA'=> '42',vStateCode = 'PR'=> '72',
                                                                                                      vStateCode = 'RI'=> '44',vStateCode = 'SC'=> '45',
                                                                                                      vStateCode = 'SD'=> '46',vStateCode = 'TN'=> '47',
                                                                                                      vStateCode = 'TX'=> '48',vStateCode = 'UT'=> '49',
                                                                                                      vStateCode = 'VA'=> '51',vStateCode = 'VI'=> '78',
                                                                                                      vStateCode = 'VT'=> '50',vStateCode = 'WA'=> '53',
                                                                                                      vStateCode = 'WI'=> '55',vStateCode = 'WV'=> '54',
                                                                                                      vStateCode = 'WY'=> '56',''),
                                                          regexfind('[[:digit:]]',vStateCode)=> MAP((INTEGER)vStateCode = 2 => 'AK' ,(INTEGER)vStateCode = 1 => 'AL',  		                 
						                                                                            (INTEGER)vStateCode = 5 => 'AR' ,(INTEGER)vStateCode = 4 => 'AZ',      
						                                                                            (INTEGER)vStateCode = 6 => 'CA' ,(INTEGER)vStateCode = 8 => 'CO',      
						                                                                            (INTEGER)vStateCode = 9 => 'CT' ,(INTEGER)vStateCode = 11 => 'DC',      
							                                                                        (INTEGER)vStateCode = 10 => 'DE' ,(INTEGER)vStateCode = 12 => 'FL',  
							                                                                        (INTEGER)vStateCode = 13 => 'GA' ,(INTEGER)vStateCode = 15 => 'HI',  
							                                                                        (INTEGER)vStateCode = 19 => 'IA' ,(INTEGER)vStateCode = 16 => 'ID',  
							                                                                        (INTEGER)vStateCode = 17 => 'IL' ,(INTEGER)vStateCode = 18 => 'IN',  
							                                                                        (INTEGER)vStateCode = 20 => 'KS' ,(INTEGER)vStateCode = 21 => 'KY',  
							                                                                        (INTEGER)vStateCode = 22 => 'LA' ,(INTEGER)vStateCode = 25 => 'MA',  
							                                                                        (INTEGER)vStateCode = 24 => 'MD' ,(INTEGER)vStateCode = 23 => 'ME',  
							                                                                        (INTEGER)vStateCode = 26 => 'MI' ,(INTEGER)vStateCode = 27 => 'MN',  
							                                                                        (INTEGER)vStateCode = 29 => 'MO' ,(INTEGER)vStateCode = 28 => 'MS',  
							                                                                        (INTEGER)vStateCode = 30 => 'MT' ,(INTEGER)vStateCode = 37 => 'NC',  
							                                                                        (INTEGER)vStateCode = 38 => 'ND' ,(INTEGER)vStateCode = 31 => 'NE',  
							                                                                        (INTEGER)vStateCode = 33 => 'NH' ,(INTEGER)vStateCode = 34 => 'NJ',  
							                                                                        (INTEGER)vStateCode = 35 => 'NM' ,(INTEGER)vStateCode = 32 => 'NV',  
							                                                                        (INTEGER)vStateCode = 36 => 'NY' ,(INTEGER)vStateCode = 39 => 'OH',  
							                                                                        (INTEGER)vStateCode = 40 => 'OK' ,(INTEGER)vStateCode = 41 => 'OR',  
							                                                                        (INTEGER)vStateCode = 42 => 'PA' ,(INTEGER)vStateCode = 72 => 'PR',  
							                                                                        (INTEGER)vStateCode = 44 => 'RI' ,(INTEGER)vStateCode = 45 => 'SC',  
							                                                                        (INTEGER)vStateCode = 46 => 'SD' ,(INTEGER)vStateCode = 47 => 'TN',  
							                                                                        (INTEGER)vStateCode = 48 => 'TX' ,(INTEGER)vStateCode = 49 => 'UT',  
							                                                                        (INTEGER)vStateCode = 51 => 'VA' ,(INTEGER)vStateCode = 78 => 'VI',  
							                                                                        (INTEGER)vStateCode = 50 => 'VT' ,(INTEGER)vStateCode = 53 => 'WA',  
							                                                                        (INTEGER)vStateCode = 55 => 'WI' ,(INTEGER)vStateCode = 54 => 'WV',  
							                                                                        (INTEGER)vStateCode = 56 => 'WY' ,''),
		                                                                                               '') //End enclosing map
																								      ); //End if
																											
	 EXPORT StateFips := vStateFips(vStateCode);														
	 
	 SHARED STRING vStateDesc(STRING2 pStateCode):= IF(regexfind('[[:alpha:]]',vStateCode) AND
                                                       regexfind('[[:digit:]]',vStateCode),'', 
	  	                                               MAP(regexfind('[[:alpha:]]',vStateCode)=> MAP(vStateCode = 'AL' => 'ALABAMA',       vStateCode = 'AK' => 'ALASKA',
                                                                                                     vStateCode = 'AS' => 'AMERICAN SAMOA',vStateCode = 'AZ' => 'ARIZONA',
                                                                                                     vStateCode = 'AR' => 'ARKANSAS',      vStateCode = 'CA' => 'CALIFORNIA',
                                                                                                     vStateCode = 'CZ' => 'PANAMA CANAL ZONE',   vStateCode = 'CO' => 'COLORADO',
                                                                                                     vStateCode = 'CT' => 'CONNECTICUT',         vStateCode = 'DE' => 'DELAWARE',
                                                                                                     vStateCode = 'DC' => 'DISTRICT OF COLUMBIA',vStateCode = 'FL' => 'FLORIDA',
                                                                                                     vStateCode = 'GA' => 'GEORGIA',  vStateCode = 'GU' => 'GUAM',
                                                                                                     vStateCode = 'HI' => 'HAWAII',   vStateCode = 'ID' => 'IDAHO',
                                                                                                     vStateCode = 'IL' => 'ILLINOIS', vStateCode = 'IN' => 'INDIANA',
                                                                                                     vStateCode = 'IA' => 'IOWA',     vStateCode = 'KS' => 'KANSAS',
                                                                                                     vStateCode = 'KY' => 'KENTUCKY', vStateCode = 'LA' => 'LOUISIANA',
                                                                                                     vStateCode = 'ME' => 'MAINE',    vStateCode = 'MD' => 'MARYLAND',
                                                                                                     vStateCode = 'MA' => 'MASSACHUSETTS',  vStateCode = 'MI' => 'MICHIGAN',
                                                                                                     vStateCode = 'MN' => 'MINNESOTA',      vStateCode = 'MS' => 'MISSISSIPPI',
                                                                                                     vStateCode = 'MO' => 'MISSOURI',       vStateCode = 'MT' => 'MONTANA',
                                                                                                     vStateCode = 'NE' => 'NEBRASKA',       vStateCode = 'NV' => 'NEVADA',
                                                                                                     vStateCode = 'NH' => 'NEW HAMPSHIRE',  vStateCode = 'NJ' => 'NEW JERSEY',
                                                                                                     vStateCode = 'NM' => 'NEW MEXICO',     vStateCode = 'NY' => 'NEW YORK',
                                                                                                     vStateCode = 'NC' => 'NORTH CAROLINA', vStateCode = 'ND' => 'NORTH DAKOTA',
                                                                                                     vStateCode = 'OH' => 'OHIO',           vStateCode = 'OK' => 'OKLAHOMA',                                                                                                        
                                                                                                     vStateCode = 'OR' => 'OREGON',         vStateCode = 'PA' => 'PENNSYLVANIA',    
                                                                                                     vStateCode = 'PR' => 'PUERTO RICO',    vStateCode = 'RI' => 'RHODE ISLAND',
                                                                                                     vStateCode = 'SC' => 'SOUTH CAROLINA',	vStateCode = 'TN' => 'TENNESSEE',
                                                                                                     vStateCode = 'SD' => 'SOUTH DAKOTA',   vStateCode = 'UT' => 'UTAH',
                                                                                                     vStateCode = 'TX' => 'TEXAS',          vStateCode = 'VA' => 'VIRGINIA',
                                                                                                     vStateCode = 'VT' => 'VERMONT',        vStateCode = 'WA' => 'WASHINGTON',
                                                                                                     vStateCode = 'VI' => 'VIRGIN ISLANDS', vStateCode = 'WI' => 'WISCONSIN',
                                                                                                     vStateCode = 'WV' => 'WEST VIRGINIA',  vStateCode = 'WY' => 'WYOMING',
                                                                                                 ''),
                                                       
                                                       regexfind('[[:digit:]]',vStateCode)=> MAP((INTEGER)vStateCode = 1 => 'ALABAMA',              (INTEGER)vStateCode = 2 => 'ALASKA',
                                                                                                 (INTEGER)vStateCode = 3 => 'AMERICAN SAMOA',       (INTEGER)vStateCode = 4 => 'ARIZONA',
                                                                                                 (INTEGER)vStateCode = 5 => 'ARKANSAS',             (INTEGER)vStateCode = 6 => 'CALIFORNIA',
                                                                                                 (INTEGER)vStateCode = 7 => 'PANAMA CANAL ZONE',    (INTEGER)vStateCode = 8 => 'COLORADO',
                                                                                                 (INTEGER)vStateCode = 9 => 'CONNECTICUT',          (INTEGER)vStateCode = 10 => 'DELAWARE',
                                                                                                 (INTEGER)vStateCode = 11 => 'DISTRICT OF COLUMBIA',(INTEGER)vStateCode = 12 => 'FLORIDA',
                                                                                                 (INTEGER)vStateCode = 13 => 'GEORGIA',             (INTEGER)vStateCode = 14 => 'GUAM',
                                                                                                 (INTEGER)vStateCode = 15 => 'HAWAII',              (INTEGER)vStateCode = 16 => 'IDAHO',
                                                                                                 (INTEGER)vStateCode = 17 => 'ILLINOIS',            (INTEGER)vStateCode = 18 => 'INDIANA',
                                                                                                 (INTEGER)vStateCode = 19 => 'IOWA',                (INTEGER)vStateCode = 20 => 'KANSAS',
                                                                                                 (INTEGER)vStateCode = 21 => 'KENTUCKY',            (INTEGER)vStateCode = 22 => 'LOUISIANA',
                                                                                                 (INTEGER)vStateCode = 23 => 'MAINE',               (INTEGER)vStateCode = 24 => 'MARYLAND',
                                                                                                 (INTEGER)vStateCode = 25 => 'MASSACHUSETTS',       (INTEGER)vStateCode = 26 => 'MICHIGAN',
                                                                                                 (INTEGER)vStateCode = 27 => 'MINNESOTA',           (INTEGER)vStateCode = 28 => 'MISSISSIPPI',
                                                                                                 (INTEGER)vStateCode = 29 => 'MISSOURI',            (INTEGER)vStateCode = 30 => 'MONTANA',
                                                                                                 (INTEGER)vStateCode = 31 => 'NEBRASKA',            (INTEGER)vStateCode = 32 => 'NEVADA',
                                                                                                 (INTEGER)vStateCode = 33 => 'NEW HAMPSHIRE',       (INTEGER)vStateCode = 34 => 'NEW JERSEY',
                                                                                                 (INTEGER)vStateCode = 35 => 'NEW MEXICO',          (INTEGER)vStateCode = 36 => 'NEW YORK',
                                                                                                 (INTEGER)vStateCode = 37 => 'NORTH CAROLINA',      (INTEGER)vStateCode = 38 => 'NORTH DAKOTA',
                                                                                                 (INTEGER)vStateCode = 39 => 'OHIO',                (INTEGER)vStateCode = 40 => 'OKLAHOMA',
                                                                                                 (INTEGER)vStateCode = 41 => 'OREGON',              (INTEGER)vStateCode = 42 => 'PENNSYLVANIA',
                                                                                                 (INTEGER)vStateCode = 43 => 'PUERTO RICO',         (INTEGER)vStateCode = 44 => 'RHODE ISLAND',
                                                                                                 (INTEGER)vStateCode = 45 => 'SOUTH CAROLINA',      (INTEGER)vStateCode = 46 => 'SOUTH DAKOTA',
                                                                                                 (INTEGER)vStateCode = 47 => 'TENNESSEE',           (INTEGER)vStateCode = 48 => 'TEXAS',
                                                                                                 (INTEGER)vStateCode = 49 => 'UTAH',                (INTEGER)vStateCode = 50 => 'VERMONT',
                                                                                                 (INTEGER)vStateCode = 51 => 'VIRGINIA',            (INTEGER)vStateCode = 52 => 'VIRGIN ISLANDS',
                                                                                                 (INTEGER)vStateCode = 53 => 'WASHINGTON',          (INTEGER)vStateCode = 54 => 'WEST VIRGINIA',
                                                                                                 (INTEGER)vStateCode = 55 => 'WISCONSIN',           (INTEGER)vStateCode = 56 => 'WYOMING', 
                                                                                                 ''),
                                              	       '')//End enlosing map
                                                   ); //End if                                             		
	 
	 EXPORT StateDesc := vStateDesc(vStateCode);		
	 
	 STRING vAdditionalIndicator := IF(TRIM(pAdditionalIndicator) != '',
	                                   pAdditionalIndicator + v_dash,'');
	 EXPORT STRING UKey := vStateFips(vStateCode) + 
	                       v_dash + vAdditionalIndicator + 
												 pVndURecId;		
				
	END;
	
	//Returns US States codes or fips based upon
	//their (US States) passed descriptions
	EXPORT StateCodeFips_Reverse(STRING pStateDesc) := MODULE
    SHARED vStateDesc := UniformInput(pStateDesc,'U',false);
    
    EXPORT StateCode := MAP( vStateDesc = 'ALABAMA'             => 'AL',  vStateDesc = 'ALASKA'	    => 'AK',
                             vStateDesc = 'AMERICAN SAMOA'      => 'AS',  vStateDesc = 'ARIZONA'    => 'AZ',
                             vStateDesc = 'ARKANSAS'            => 'AR',  vStateDesc = 'CALIFORNIA' => 'CA',
                             vStateDesc = 'PANAMA CANAL ZONE'   => 'CZ',  vStateDesc = 'COLORADO'   => 'CO',
                             vStateDesc = 'CONNECTICUT'         => 'CT',  vStateDesc = 'DELAWARE'   => 'DE',
                             vStateDesc = 'DISTRICT OF COLUMBIA'=> 'DC',  vStateDesc = 'FLORIDA'    => 'FL',
                             vStateDesc = 'GEORGIA'             => 'GA',  vStateDesc = 'GUAM'	      => 'GU',
                             vStateDesc = 'HAWAII'              => 'HI',  vStateDesc = 'IDAHO'	    => 'ID',
                             vStateDesc = 'ILLINOIS'            => 'IL',  vStateDesc = 'INDIANA'    => 'IN',
                             vStateDesc = 'IOWA'                => 'IA',  vStateDesc = 'KANSAS'	    => 'KS',
                             vStateDesc = 'KENTUCKY'            => 'KY',  vStateDesc = 'LOUISIANA'  => 'LA',
                             vStateDesc = 'MAINE'               => 'ME',  vStateDesc = 'MARYLAND'   => 'MD',
                             vStateDesc = 'MASSACHUSETTS'       => 'MA',  vStateDesc = 'MICHIGAN'   => 'MI',
                             vStateDesc = 'MINNESOTA'           => 'MN',  vStateDesc = 'MISSISSIPPI'=> 'MS',
                             vStateDesc = 'MISSOURI'            => 'MO',  vStateDesc = 'MONTANA'    => 'MT',
                             vStateDesc = 'NEBRASKA'            => 'NE',  vStateDesc = 'NEVADA'	    => 'NV',
                             vStateDesc = 'NEW HAMPSHIRE'       => 'NH',  vStateDesc = 'NEW JERSEY' => 'NJ',
                             vStateDesc = 'NEW MEXICO'          => 'NM',  vStateDesc = 'NEW YORK'   => 'NY',
                             vStateDesc = 'NORTH CAROLINA'      => 'NC',  vStateDesc = 'NORTH DAKOTA' => 'ND',
                             vStateDesc = 'OHIO'                => 'OH',  vStateDesc = 'OKLAHOMA'     => 'OK',                                                                                                 
                             vStateDesc = 'OREGON'              => 'OR',  vStateDesc = 'PENNSYLVANIA' => 'PA', 
                             vStateDesc = 'PUERTO RICO'         => 'PR',  vStateDesc = 'RHODE ISLAND' => 'RI',
                             vStateDesc = 'SOUTH CAROLINA'      => 'SC',  vStateDesc = 'TENNESSEE'    => 'TN',
                             vStateDesc = 'SOUTH DAKOTA'        => 'SD',  vStateDesc = 'UTAH'	       => 'UT',
                             vStateDesc = 'TEXAS'               => 'TX',  vStateDesc = 'VIRGINIA'	   => 'VA',
                             vStateDesc = 'VERMONT'             => 'VT',  vStateDesc = 'WASHINGTON'	 => 'WA',
                             vStateDesc = 'VIRGIN ISLANDS'      => 'VI',  vStateDesc = 'WISCONSIN'	 => 'WI',
                             vStateDesc = 'WEST VIRGINIA'       => 'WV',  vStateDesc = 'WYOMING'	   => 'WY',
														 vStateDesc = 'FLA'       					=> 'FL',  vStateDesc = 'MASS'			   => 'MA',
                            '');
           
    EXPORT StateFips := MAP   (vStateDesc = 'ALABAMA'             => '1',  vStateDesc = 'ALASKA'	   =>  '2',  
                               vStateDesc = 'AMERICAN SAMOA'      => '3',  vStateDesc = 'ARIZONA'	   =>  '4',  
                               vStateDesc = 'ARKANSAS'            => '5',  vStateDesc = 'CALIFORNIA' =>  '6',  
                               vStateDesc = 'PANAMA CANAL ZONE'   => '7',  vStateDesc = 'COLORADO'	 =>  '8',  
                               vStateDesc = 'CONNECTICUT'         => '9',  vStateDesc = 'DELAWARE'	 =>  '10', 
                               vStateDesc = 'DISTRICT OF COLUMBIA'=> '11', vStateDesc = 'FLORIDA'	   =>  '12', 
                               vStateDesc = 'GEORGIA'             => '13', vStateDesc = 'GUAM'	     =>  '14', 
                               vStateDesc = 'HAWAII'              => '15', vStateDesc = 'IDAHO'	     =>  '16', 
                               vStateDesc = 'ILLINOIS'            => '17', vStateDesc = 'INDIANA'	   =>  '18', 
                               vStateDesc = 'IOWA'                => '19', vStateDesc = 'KANSAS'	   =>  '20', 
                               vStateDesc = 'KENTUCKY'            => '21', vStateDesc = 'LOUISIANA'	 =>  '22', 
                               vStateDesc = 'MAINE'               => '23', vStateDesc = 'MARYLAND'	 =>  '24', 
                               vStateDesc = 'MASSACHUSETTS'       => '25', vStateDesc = 'MICHIGAN'	 =>  '26', 
                               vStateDesc = 'MINNESOTA'           => '27', vStateDesc = 'MISSISSIPPI'	 =>  '28', 
                               vStateDesc = 'MISSOURI'            => '29', vStateDesc = 'MONTANA'	     =>  '30', 
                               vStateDesc = 'NEBRASKA'            => '31', vStateDesc = 'NEVADA'	     =>  '32', 
                               vStateDesc = 'NEW HAMPSHIRE'       => '33', vStateDesc = 'NEW JERSEY' 	 =>  '34', 
                               vStateDesc = 'NEW MEXICO'          => '35', vStateDesc = 'NEW YORK'	   =>  '36', 
                               vStateDesc = 'NORTH CAROLINA'      => '37', vStateDesc = 'NORTH DAKOTA' =>  '38', 
                               vStateDesc = 'OHIO'                => '39', vStateDesc = 'OKLAHOMA'	   =>  '40', 
                               vStateDesc = 'OREGON'              => '41', vStateDesc = 'PENNSYLVANIA'   =>  '42', 
                               vStateDesc = 'PUERTO RICO'         => '43', vStateDesc = 'RHODE ISLAND'   =>  '44', 
                               vStateDesc = 'SOUTH CAROLINA'      => '45', vStateDesc = 'SOUTH DAKOTA'   =>  '46', 
                               vStateDesc = 'TENNESSEE'           => '47', vStateDesc = 'TEXAS'	         =>  '48', 
                               vStateDesc = 'UTAH'                => '49', vStateDesc = 'VERMONT'	       =>  '50', 
                               vStateDesc = 'VIRGINIA'            => '51', vStateDesc = 'VIRGIN ISLAND'  =>  '52', 
                               vStateDesc = 'WASHINGTON'          => '53', vStateDesc = 'WEST VIRGINIA'  =>  '54', 
                               vStateDesc = 'WISCONSIN'           => '55', vStateDesc = 'WYOMING'    	   =>  '56', 
                              '');
  END;
                								
  
	//Returns True if the input string matches one of the patterns
	//associated with the US country name
	EXPORT BOOLEAN IsUnitedStates(STRING pCountry) := IF(regexfind(' *US *| *USA *| *UNITED *STATES *|UNITED *STATES *OF *AMERICA',UniformInput(pCountry,'U',false)),TRUE,FALSE);
		
	//Returns True if the input string matches 
	//one of the US State codes or FIPS
    EXPORT BOOLEAN IsUSState(STRING2 pState) := pState IN 
    ['AK','AL','AR','AZ','CA','CO','CT','DC','DE','FL','GA','HI','IA',
     'ID','IL','IN','KS','KY','LA','MA','MD','ME','MI','MN','MO','MS',
     'MT','NC','ND','NE','NH','NJ','NM','NV','NY','OH','OK','OR','PA',
     'PR','RI','SC','SD','TN','TX','UT','VA','VI','VT','WA','WI','WV','WY']
	  OR
	 (INTEGER) pState IN [1,2,4,5,6,8,9,10,11,12,13,15,16,17,
	                      18,19,20,21,22,23,24,25,26,27,28,29,30,31,
					      32,33,34,35,36,37,38,39,40,41,42,44,45,46,
					      47,48,49,50,51,53,54,55,56,72,78];
 
 //Prefixes logical file name
 EXPORT STRING RawFilePathPrerix := 'thor_data400::in::corp2::';                                
 
 //Prefixes logical file name that belongs to the "sprayed" area
 EXPORT STRING InFilePathPrefix := 'thor_data400::in::corp2::sprayed::';
 
 //Generates names of logical of super files
 EXPORT GetInFileName(STRING1 pFileType,//e.g R(aw) or M(apped)
                      STRING pFileIdentifier,
					  STRING2 pStateOrigin = '',
					  STRING8 pProcessDate = '',
                      BOOLEAN pTilda = false,
					  STRING  pSuffix = '') := FUNCTION
	 STRING v_InfilePathPrefix := MAP(pFileType = 'R' => RawFilePathPrerix,
	                                  pFileType = 'M' => InFilePathPrefix,'');
	 STRING1 vTilda := IF(pTilda,'~','');
	 STRING11 vProcessDate := pProcessDate + IF(pProcessDate != '',pSuffix + '::' ,'');
	 STRING  vFileIndentifier := pFileIdentifier + IF(pStateOrigin != '','::','');
	 STRING2 vStateOrigin := StringLib.StringToLowerCase(pStateOrigin);
	 RETURN regexreplace(' *',vTilda + v_InfilePathPrefix + 
	                          vProcessDate + vFileIndentifier + vStateOrigin,'');
 END;
 
 EXPORT STRING LookupPathPrefix := corp2_mapping._Dataset().foreign_prod + 'thor_data400::lookups::corp2::';
 
 EXPORT Layout_Lookup_ISO_Contry_Code_3 := 
 RECORD
   STRING3 code;
   STRING44 description;
   STRING3 iso_code_3n;
   STRING2 iso_code_2;
   STRING2 fips_code;
   STRING52 fips_desc;
   STRING3 iso_code;
   STRING55 iso_desc;
 END;

 EXPORT Lookup_ISO_Contry_Code_3 := 
 DATASET(LookupPathPrefix + 'lookup_iso_contry_code_3',
         Layout_Lookup_ISO_Contry_Code_3,THOR); 
 
 
 EXPORT Layout_Lookup_ISO_State_Desc :=
 RECORD
   STRING2 code;
   STRING30 description;
   STRING2 fips_code;
 END;
 
 EXPORT Lookup_ISO_State_Desc := 
 DATASET(LookupPathPrefix + 'lookup_iso_state_desc',
         Layout_Lookup_ISO_State_Desc,THOR); 
 
 
 
 //Generic Layout that describes any
 //variable length record
 EXPORT Layout_Generic := RECORD, MAXLENGTH(8192)
	 STRING  Payload;
 END;
 
  
  
 //Defines a variable-length dataset 
 EXPORT Generic_Dataset(STRING pSuperFileName,
		                STRING pSeparator = '') := DATASET(pSuperFileName,
 	                                                        Layout_Generic,
					    		                            CSV(HEADING(0),
								                                SEPARATOR([pSeparator]),
															    TERMINATOR(['\n','\r\n','\n\r']),
																 MAXLENGTH(8192)
															    ));
																
																
 //Generic Layout that describes any
 //variable length (typical)lookup record																							 
 EXPORT Layout_Generic_Lookup := RECORD, MAXLENGTH(512)
   STRING Code;
   STRING Description;
 END;
 																
											
													
																

 //Defines a variable-length lookup dataset 
 EXPORT Generic_Lookup_Dataset(STRING pSuperFileName,
		                       STRING pSeparator = '') := DATASET(pSuperFileName,
		                                                          Layout_Generic_Lookup,
					    			                              CSV(HEADING(0),
								                                      SEPARATOR([pSeparator]),
																	  TERMINATOR(['\n','\r\n','\n\r']),
																	  MAXLENGTH(8192)
															        ));		

 
 EXPORT Lookup_Province_Code := Generic_Lookup_Dataset(LookupPathPrefix + 'lookup_province_code',',');

 EXPORT Lookup_IRS_SIC := Generic_Lookup_Dataset(LookupPathPrefix + 'lookup_irs_sic','|');
						 
 EXPORT Lookup_STD_NAICS6 := Generic_Lookup_Dataset(LookupPathPrefix + 'lookup_std_naics6','|');

 
 
 //Wrapper around VersionControl.fSprayInputFiles
 EXPORT GenericSprayInpFiles_Variable(STRING pILFName, //Target sub file name
	                                  STRING pIP,
								      STRING pSourceDir,
									  STRING pUnixSrcFileNm,
									  STRING pISFName, //Target super file name
									  STRING pGroupName,
									  STRING pProcessDate,
									  STRING pRecordDelimiter='\n',
									  BOOLEAN pClearSuperFile = TRUE) := FUNCTION
	  //SHARED STRING InpLnkFile  := GetInFileName(pILFName);
	  //Preclean Input SuperFile
		
		lUpdateFreqency	:= regexfind('(daily|monthly|weekly)'	,pSourceDir	,0);
		state 					:= stringlib.stringtouppercase(regexreplace('^.*?/([[:alpha:]]{2})/.*$', pSourceDir, '$1'));
		lVersion				:= regexfind('[[:digit:]]{8}'		,pSourceDir	,0);
		
 	    FilesToSpray := DATASET([{pIP,
                                pSourceDir,												
                                pUnixSrcFileNm,                         
   	 	                        0, //Because it's delimited                                                            
 	 	                        pILFName,
                          	    [{pISFName}],    
							    pGroupName,
							    pProcessDate,
								'',
							    'VARIABLE',
							    '',
							    8192,
								'',
								pRecordDelimiter}],VersionControl.Layout_Sprays.Info); 
											  			 
	SprayedFile := VersionControl.fSprayInputFiles(FilesToSpray,,,TRUE,,,,,
	'CorpV2 ' + state + ' ' + lUpdateFreqency +  ' ' + lVersion); 
	
	RETURN sequential(
		 FileServices.ClearSuperFile(pISFName,pClearSuperFile)
		,SprayedFile
	);
 END;
 
 
 
 EXPORT STRING PatternDoingBusiness := 'DOING *BUSINESS *(AS|BY)';
 
 
 EXPORT STRING PatternUnknown := 
 '(NONE  *(SAME  *AS  *ABOVE)|NONE|NONE  *GIVEN.*|UNDER  *NONE|UNKNOWN' +
 '|N */ *A */ *[\054]|N */ *A|N *A */|N[.] *A[.]|U  *)';
 
 
 EXPORT BOOLEAN IsUnknown( STRING pPattern
                          ,STRING pStr ) := regexfind(pPattern,StringLib.StringToUpperCase(Trim(pStr,LEFT,RIGHT))); 
 
 EXPORT BOOLEAN IsKnown( STRING pPattern
                        ,STRING pStr ) := NOT IsUnknown(pPattern,pStr);
 
 EXPORT STRING ReplaceUnknown( STRING pPattern
                              ,STRING pStr
							  ,STRING ReplString = '') := UniformInput(regexreplace(pPattern,UniformInput(pStr,'U',false),ReplString),'U',false); 
															
 EXPORT STRING CleanupUnknown( STRING pPattern
                              ,STRING pStr
							  ,STRING pReplString) := IF(IsUnknown(PatternUnknown,pStr),'',pReplString);
 
 
 
 EXPORT STRING PatternSame := '(SAME *AS *ABOVE|SAME|ABOVE)';
  
 EXPORT STRING PatternStateUnknown := '(NO|UN|FF|NA|U *)';
 EXPORT STRING PatternZipUnknown := '(00000|99999)'; //Leave for back compatibility
 EXPORT STRING PatternZip5Unknown := '(00000|99999)';
 EXPORT STRING PatternZip4Unknown := '(0000|9999)';
 EXPORT STRING PatternUSCountryCodes := '(^U$|US|USA)'; 
 
 EXPORT STRING PatternValidYear := '[1-2][0-9][0-9][0-9]';
 
 
															
 //Converts a text string to it's HASH64 equivalent
 EXPORT GetLookupKey(STRING pText):= MODULE 
   EXPORT STRING KeyTxt := (UniformInput(pText,'U'));
	 EXPORT UNSIGNED INTEGER8 KeyNum := HASH64(KeyTxt);
 END;
 
 //Calls Address.CleanPersonFML73
 //or Address.CleanPersonLFM73 depend
 //upon passed parameter
 EXPORT CleanPerson73(STRING pName,
                      STRING1 pOrder = 'F') := MAP(StringLib.StringToUpperCase(pOrder) = 'F' => Address.CleanPersonFML73(pName),
                                                   StringLib.StringToUpperCase(pOrder) = 'L' => Address.CleanPersonLFM73(pName),'');
                                                   
 //Returns TRUE if Name Cleaner Score is greater
 //or equal to the passed Threshold and 
 //Company Cleaner does not indicate 
 //that the passed name is a company
 SHARED BOOLEAN IsItAPerson (STRING pName,
                            STRING1 pOrder = 'F',
							INTEGER pThreshold) := (INTEGER) CleanPerson73(pName,pOrder)[71..73] >= pThreshold AND
													                       Datalib.CompanyClean(pName)[41..120] = '';
 //Returns TRUE if IsItPerson is TRUE
 EXPORT BOOLEAN IsPerson(STRING pName, 
                         STRING1 pOrder = 'F',
						 INTEGER pThreshold = 85) := FUNCTION
   RETURN IsItAPerson(pName,pOrder,pThreshold);
 END;
 
 //Returns TRUE if IsItPerson is FALSE
 EXPORT BOOLEAN IsCompany(STRING pName, 
                          STRING1 pOrder = 'F',
						  INTEGER pThreshold = 85) := FUNCTION
   RETURN NOT IsItAPerson(pName,pOrder,pThreshold);
 END;

 //Brings US Zip codes to their standard format
 //99999-9999
 EXPORT CleanZip (STRING pZip,
                  BOOLEAN is_US_based = TRUE) := FUNCTION
  vZip := UniformInput(pZip);
  RETURN  MAP (is_US_based  =>  IF(LENGTH(vZip) >= 5 AND
	                             IsKnown(PatternZip5Unknown,vZip[1..5]),
	                             vZip[1..5] + 
						         IF(LENGTH(vZip) >= 9 AND 
								 IsKnown(PatternZip4Unknown,vZip[6..9]),
								 '-' + vZip[6..9],''),''),
			   NOT is_US_based => IF((INTEGER) pZip = 0,'',pZip),
			   '');
 END;
 
 //Returns TRUE if at least Address Line1 
 //and Zip Code or combination of City and State
 //exists.
 EXPORT BOOLEAN AddressExists( STRING pAddr1
                              ,STRING pAddr2
					          ,STRING pCity
				              ,STRING pState
				              ,STRING pZip) := 
				  	        IF( (UniformInput(pAddr1,,false) != '' OR UniformInput(pAddr2,,false) != '') 
	                        AND
	                        (UniformInput(pZip) != '' OR (UniformInput(pCity,,false) != '' AND UniformInput(pState) != ' ')),TRUE,FALSE);
 
 
 //Cleans address elements and forms
 //a standard AddressLine1(Addr1 + Addr2)
 //and AddressLine2(City + State + Zip) lines
 //that could be passed to the Address.MAC_Address_Clean
 EXPORT PreCleanAddress( STRING pAddr1 = ''
                        ,STRING pAddr2 = ''
						,STRING pCity  = ''
					    ,STRING pState = ''
						,STRING pZip  = '') := MODULE
	 EXPORT STRING Addr1 := ReplaceUnknown(PatternUnknown,pAddr1); 
	 EXPORT STRING Addr2 := ReplaceUnknown(PatternUnknown,pAddr2); 
	 EXPORT STRING City := ReplaceUnknown(PatternUnknown,pCity);
	 EXPORT STRING State := ReplaceUnknown(PatternStateUnknown,pState);
	 EXPORT STRING Zip :=   CleanZip(pZip);
	 EXPORT STRING AddressLine1 := (Addr1 + ' ' + Addr2);
	 EXPORT STRING AddressLine2 := (City + ' ' + State + ' ' + Zip);
 END; //PreCleanAddress
  
 EXPORT DateIsValid(STRING8 pDate) := _validate.date.fIsValid(UniformInput(pDate));
 EXPORT DateIsInvalid(STRING8 pDate) := NOT(_validate.date.fIsValid(UniformInput(pDate)));
 EXPORT CleanInvalidDates(STRING8 pDate) := IF(DateIsInvalid(pDate),'',pDate);
 
 //AssignCorpData_ TRANSFORMS propagate common "corp" fields values from 
 //Corporate Master Dataset down to Contact,Events,Stock, and
 //AR Datasets
 
 //AssignCorpData TRANSFORMS will stay as is to be back-compatible
 //with the previous rewrites
 EXPORT Corp2.Layout_Corporate_Direct_Cont_In AssignCorpData_Cont(Corp2.Layout_Corporate_Direct_Cont_In L,
                                                                  Corp2.Layout_Corporate_Direct_Corp_In R) := TRANSFORM
		
    SELF.dt_first_seen := R.dt_first_seen;
    SELF.dt_last_seen := R.dt_last_seen;
    SELF.corp_supp_key:= R.corp_supp_key;
    SELF.corp_vendor:= R.corp_vendor;
    SELF.corp_vendor_county:= R.corp_vendor_county;
    SELF.corp_vendor_subcode:= R.corp_vendor_subcode;
    SELF.corp_state_origin:= R.corp_state_origin;
    SELF.corp_process_date:= CleanInvalidDates(R.corp_process_date);
    SELF.corp_orig_sos_charter_nbr:= R.corp_orig_sos_charter_nbr;
    SELF.corp_legal_name:= R.corp_legal_name;
    SELF.corp_address1_type_cd:= R.corp_address1_type_cd;
    SELF.corp_address1_type_desc:= R.corp_address1_type_desc;
    SELF.corp_address1_line1:= R.corp_address1_line1;
    SELF.corp_address1_line2:= R.corp_address1_line2;
    SELF.corp_address1_line3:= R.corp_address1_line3;
    SELF.corp_address1_line4:= R.corp_address1_line4;
    SELF.corp_address1_line5:= R.corp_address1_line5;
    SELF.corp_address1_line6:= R.corp_address1_line6;
    SELF.corp_address1_effective_date:= CleanInvalidDates(R.corp_address1_effective_date);
    SELF.corp_phone_number:= R.corp_phone_number;
    SELF.corp_phone_number_type_cd:= R.corp_phone_number_type_cd;
    SELF.corp_phone_number_type_desc:= R.corp_phone_number_type_desc;
    SELF.corp_fax_nbr:= R.corp_fax_nbr;
    SELF.corp_email_address:= R.corp_email_address;
    SELF.corp_web_address:= R.corp_web_address;
		/* Removed the below fields for AID process.
    SELF.corp_addr1_prim_range:= R.corp_addr1_prim_range;
    SELF.corp_addr1_predir:= R.corp_addr1_predir;
    SELF.corp_addr1_prim_name:= R.corp_addr1_prim_name;
    SELF.corp_addr1_addr_suffix:= R.corp_addr1_addr_suffix;
    SELF.corp_addr1_postdir:= R.corp_addr1_postdir;
    SELF.corp_addr1_unit_desig:= R.corp_addr1_unit_desig;
    SELF.corp_addr1_sec_range:= R.corp_addr1_sec_range;
    SELF.corp_addr1_p_city_name:= R.corp_addr1_p_city_name;
    SELF.corp_addr1_v_city_name:= R.corp_addr1_v_city_name;
    SELF.corp_addr1_state:= R.corp_addr1_state;
    SELF.corp_addr1_zip5:= R.corp_addr1_zip5;
    SELF.corp_addr1_zip4:= R.corp_addr1_zip4;
    SELF.corp_addr1_cart:= R.corp_addr1_cart;
    SELF.corp_addr1_cr_sort_sz:= R.corp_addr1_cr_sort_sz;
    SELF.corp_addr1_lot:= R.corp_addr1_lot;
    SELF.corp_addr1_lot_order:= R.corp_addr1_lot_order;
    SELF.corp_addr1_dpbc:= R.corp_addr1_dpbc;
    SELF.corp_addr1_chk_digit:= R.corp_addr1_chk_digit;
    SELF.corp_addr1_rec_type:= R.corp_addr1_rec_type;
    SELF.corp_addr1_ace_fips_st:= R.corp_addr1_ace_fips_st;
    SELF.corp_addr1_county:= R.corp_addr1_county;
    SELF.corp_addr1_geo_lat:= R.corp_addr1_geo_lat;
    SELF.corp_addr1_geo_long:= R.corp_addr1_geo_long;
    SELF.corp_addr1_msa:= R.corp_addr1_msa;
    SELF.corp_addr1_geo_blk:= R.corp_addr1_geo_blk;
    SELF.corp_addr1_geo_match:= R.corp_addr1_geo_match;
    SELF.corp_addr1_err_stat:= R.corp_addr1_err_stat;
		*/
		// Added prep fields for AID process
		self.corp_prep_addr_line1     := R.corp_prep_addr1_line1;
		self.corp_prep_addr_last_line := R.corp_prep_addr1_last_line;
    SELF := L;
  END;
		
	EXPORT Corp2.Layout_Corporate_Direct_Event_In AssignCorpData_Event(Corp2.Layout_Corporate_Direct_Event_In L,
	                                                                   Corp2.Layout_Corporate_Direct_Corp_In R) := TRANSFORM

    SELF.corp_supp_key := R.corp_supp_key;
    SELF.corp_vendor := R.corp_vendor;
    SELF.corp_vendor_county := R.corp_vendor_county ;
    SELF.corp_vendor_subcode := R.corp_vendor_subcode;
    SELF.corp_state_origin := R.corp_state_origin;
    SELF.corp_process_date := R.corp_process_date;
    SELF.corp_sos_charter_nbr := R.corp_orig_sos_charter_nbr;
    SELF.event_filing_desc := IF(UniformInput(L.event_filing_desc,,false) != '',
		                             L.event_filing_desc,R.corp_entity_desc);
    SELF := L;
  END;
	
	EXPORT Corp2.Layout_Corporate_Direct_Stock_In AssignCorpData_Stock(Corp2.Layout_Corporate_Direct_Stock_In L,
                                                                     Corp2.Layout_Corporate_Direct_Corp_In R) := TRANSFORM
		SELF.corp_vendor := R.corp_vendor;
    SELF.corp_vendor_county := R.corp_vendor_county;
    SELF.corp_vendor_subcode := R.corp_vendor_subcode;
    SELF.corp_state_origin := R.corp_state_origin;
    SELF.corp_process_date := R.corp_process_date;
    SELF.corp_sos_charter_nbr := R.corp_orig_sos_charter_nbr;
	  SELF := L;
  END;
			
	EXPORT Corp2.Layout_Corporate_Direct_AR_In AssignCorpData_AR(Corp2.Layout_Corporate_Direct_AR_In L,
	                                                             Corp2.Layout_Corporate_Direct_Corp_In R) := TRANSFORM
	  SELF.corp_vendor := R.corp_vendor;
    SELF.corp_vendor_county := R.corp_vendor_county ;
    SELF.corp_vendor_subcode := R.corp_vendor_subcode;
    SELF.corp_state_origin := R.corp_state_origin;
    SELF.corp_process_date := R.corp_process_date;
    SELF.corp_sos_charter_nbr := R.corp_orig_sos_charter_nbr;
		SELF := L;
  END; 	 
	
  //Looks up commonly accepted corporate status 
  //descriptions
  EXPORT LookupStatusDesc(STRING2 pStatusCode) := FUNCTION
	 STRING2 vStatusCode := UniformInput(pStatusCode);
	 RETURN MAP(vStatusCode = '00'=>'GOOD STANDING',
              vStatusCode = '01'=>'REINSTATED',
              vStatusCode = '02'=>'INTENT TO DISSOLVE',
              vStatusCode = '03'=>'BANKRUPTCY',
              vStatusCode = '04'=>'UNACCEPTABLE PAYMENT',
              vStatusCode = '05'=>'AGENT VACATED',
              vStatusCode = '06'=>'WITHDRAWN',
              vStatusCode = '07'=>'REVOKED',
              vStatusCode = '08'=>'DISSOLVED',
              vStatusCode = '09'=>'MERGED/CONSOLIDATED',
              vStatusCode = '10'=>'REGISTERED NAME EXPIRATION',
              vStatusCode = '11'=>'EXPIRED',
              vStatusCode = '12'=>'REGISTERED NAME CANCELLATION',
              vStatusCode = '13'=>'SPECIAL ACT CORPORATION',
              vStatusCode = '14'=>'SUSPENDED','');
	 END; 
 
   //Formats numerical values to include commas and (optionally)
   //decimal point
   EXPORT FormatMoney(STRING pMoney,
	                  BOOLEAN pDecimalPoint = TRUE) := FUNCTION
			
		 integerpart:= IF(pDecimalPoint,pMoney[1 .. LENGTH(pMoney) - 2],pMoney);
	     fractional_part := pMoney[LENGTH(pMoney) - 1..LENGTH(pMoney)];
	     integer_with_commas := stringlib.stringreverse(regexreplace('([0-9]{3})(?=[0-9])',stringlib.stringreverse((STRING)(INTEGER) integerpart),'$1,'));
	     RETURN integer_with_commas + IF(pDecimalPoint,'.' + fractional_part,'');
   END;
	
   //Converts textual descriptions of numerical values at the beginning
   //of address line back to integer
   EXPORT StandardizedAddress(STRING pAddress) := FUNCTION
	 STRING _address := UniformInput(pAddress,'U',false);
     RETURN MAP(regexfind('(^ONE|ONE)',_address) => regexreplace('(^ONE|ONE)',_address,'1 '),
                regexfind('(^TWO|TWO)',_address) => regexreplace('(^TWO|TWO)',_address,'2'),
			    regexfind('(^THREE|THREE)',_address) => regexreplace('(^THREE|THREE)',_address,'3 '),
			    regexfind('(^FOUR|FOUR)',_address) => regexreplace('(^FOUR|FOUR)',_address,'4 '), 
				regexfind('(^FIVE|FIVE)',_address) => regexreplace('(^FIVE|FIVE)',_address,'5 '), 
				regexfind('(^SIX|SIX)',_address) => regexreplace('(^SIX|SIX)',_address,'6 '), 
				regexfind('(^SEVEN|SEVEN)',_address) => regexreplace('(^SEVEN|SEVEN)',_address,'7 '), 
				regexfind('(^EIGHT|EIGHT)',_address) => regexreplace('(^EIGHT|EIGHT)',_address,'8 '), 
				regexfind('(^NINE|NINE)',_address) => regexreplace('(^NINE|NINE)',_address,'9 '), 
				regexfind('(^TEN|TEN)',_address) => regexreplace('(^TEN|TEN)',_address,'10 '), 
				regexfind('(^FIRST|FIRST)',_address) => regexreplace('(^FIRST|FIRST)',_address,'1st '), 
				regexfind('(^SECOND|SECOND)',_address) => regexreplace('(^SECOND|SECOND)',_address,'2nd '), 
				regexfind('(^THIRD|THIRD)',_address) => regexreplace('(^THIRD|THIRD)',_address,'3rd '),_address); 
	 END;
	 
	//Translates textual descriptions of the calendar months
	//into their numeric calendar equivalents
    EXPORT	Translate_Month(STRING pDate, 
	                        INTEGER1 pStartPos, 
						    INTEGER1 pEndPos, 
							INTEGER1 pMonthFormat = 1
							) := FUNCTION 
	  //pFormat 1 - short(e.g 'SEP','OCT'), 2 - long(e.g 'SEPTEMBER','OCTOBER')											
      vMonth :=  UniformInput(pDate[pStartPos .. pEndPos],'U');
  
      RETURN MAP(pMonthFormat = 1 =>
		         IF(regexfind('[[:alpha:]]',vMonth) AND
                    regexfind('[[:digit:]]',vMonth),'', 
                    MAP(regexfind('[[:alpha:]]',vMonth)=> MAP(vMonth = 'JAN'=> '01',vMonth = 'FEB'=> '02',
                                                              vMonth = 'MAR'=> '03',vMonth = 'APR'=> '04',                                                    
                                                              vMonth = 'MAY'=> '05',vMonth = 'JUN'=> '06',                                                    
                                                              vMonth = 'JUL'=> '07',vMonth = 'AUG'=> '08',                                                    
                                                              vMonth = 'SEP'=> '09',vMonth = 'OCT'=> '10',
                                                              vMonth = 'NOV'=> '11',vMonth = 'DEC'=> '12',''),
                        regexfind('[[:digit:]]',vMonth)=> MAP((INTEGER)vMonth = 1 => 'JAN' ,(INTEGER)vMonth = 2 => 'FEB',  		  
	    	                                                  (INTEGER)vMonth = 3 => 'MAR' ,(INTEGER)vMonth = 4 => 'APR',
		                                                      (INTEGER)vMonth = 5 => 'MAY' ,(INTEGER)vMonth = 6 => 'JUN',
		                                                      (INTEGER)vMonth = 7 => 'JUL' ,(INTEGER)vMonth = 8 => 'AUG',
		                                                      (INTEGER)vMonth = 9 => 'SEP' ,(INTEGER)vMonth = 10 => 'OCT',
		                                                      (INTEGER)vMonth = 11 => 'NOV' ,(INTEGER)vMonth = 12 => 'DEC',''),
		                '') //End enclosing map
                    ), //End if
				 pMonthFormat = 2 =>	
				 IF(regexfind('[[:alpha:]]',vMonth) AND
                    regexfind('[[:digit:]]',vMonth),'', 
                    MAP(regexfind('[[:alpha:]]',vMonth)=> MAP(vMonth = 'JANUARY'=> '01',vMonth = 'FEBRUARY'=> '02',
                                                              vMonth = 'MARCH'=> '03',vMonth = 'APRIL'=> '04',                                                    
                                                              vMonth = 'MAY'=> '05',vMonth = 'JUNE'=> '06',                                                    
                                                              vMonth = 'JULY'=> '07',vMonth = 'AUGUST'=> '08',                                                    
                                                              vMonth = 'SEPTEMBER'=> '09',vMonth = 'OCTOBER'=> '10',
                                                              vMonth = 'NOVEMBER'=> '11',vMonth = 'DECEMBER'=> '12',''),
                        regexfind('[[:digit:]]',vMonth)=> MAP((INTEGER)vMonth = 1 => 'JANUARY' ,(INTEGER)vMonth = 2 => 'FEBRUARY',  		  
	    	                                                  (INTEGER)vMonth = 3 => 'MARCH' ,(INTEGER)vMonth = 4 => 'APRIL',
		                                                      (INTEGER)vMonth = 5 => 'MAY' ,(INTEGER)vMonth = 6 => 'JUNE',
		                                                      (INTEGER)vMonth = 7 => 'JULY' ,(INTEGER)vMonth = 8 => 'AUGUST',
		                                                      (INTEGER)vMonth = 9 => 'SEPTEMBER' ,(INTEGER)vMonth = 10 => 'OCTOBER',
		                                                      (INTEGER)vMonth = 11 => 'NOVEMBER' ,(INTEGER)vMonth = 12 => 'DECEMBER',''),
		                '') //End enclosing map
                    ), //End if
				 '');	 
 END; 
 
 /*
 ||Joins Corporate Master recordset with Contact, Event
 ||Stock, and AR recordsets for the purpose of propagating
 ||common values from Corporate Master recordset
 */
 EXPORT AddCorpData(DATASET(Corp2.Layout_Corporate_Direct_Corp_In)  _pCorp,
	                DATASET(Corp2.Layout_Corporate_Direct_Cont_In)  _pCont,
			        DATASET(Corp2.Layout_Corporate_Direct_Event_In) _pEvent,
			        DATASET(Corp2.Layout_Corporate_Direct_Stock_In) _pStock,
			        DATASET(Corp2.Layout_Corporate_Direct_AR_In)    _pAR,
					BOOLEAN pHashJoin = TRUE) := MODULE
	
	  
	   //Corp_Direct_Corp_Legal_0 := _pCorp(UniformInput(corp_ln_name_type_desc,'U') = 'LEGAL');
	   Corp_Direct_Corp_Legal_0 := _pCorp;
	   Corp_Direct_Corp_Legal_d := DISTRIBUTE(Corp_Direct_Corp_Legal_0,HASH32(UniformInput(Corp_Direct_Corp_Legal_0.corp_key)));
	   Corp_Direct_Corp_Legal_ds := SORT(Corp_Direct_Corp_Legal_d,corp_key,LOCAL);
	   EXPORT Corp_Direct_Corp_Legal_dds := DEDUP(Corp_Direct_Corp_Legal_ds,corp_key,LOCAL);
	 
	   EXPORT Corp_Direct_Cont := IF(COUNT(_pCont) > 0,
	                                 IF(pHashJoin, JOIN(_pCont,
	                                                    Corp_Direct_Corp_Legal_dds,
							                            UniformInput(LEFT.corp_key) = UniformInput(RIGHT.corp_key),
							                            AssignCorpData_Cont(LEFT,RIGHT),
							                            LEFT OUTER,HASH),
												   JOIN(DISTRIBUTE(_pCont,HASH32(UniformInput(corp_key))),
	                                                    Corp_Direct_Corp_Legal_dds,
		   					                            UniformInput(LEFT.corp_key) = UniformInput(RIGHT.corp_key),
										                AssignCorpData_Cont(LEFT,RIGHT),
										                LEFT OUTER,LOCAL)		
										),_pCont);
																				 
	    
	   EXPORT Corp_Direct_Event := IF(COUNT(_pEvent) > 0,
	                                  IF(pHashJoin, JOIN(_pEvent,
	                                                     Corp_Direct_Corp_Legal_dds,
		   					                             UniformInput(LEFT.corp_key) = UniformInput(RIGHT.corp_key),
										                 AssignCorpData_Event(LEFT,RIGHT),
										                 LEFT OUTER,HASH),
												    JOIN(DISTRIBUTE(_pEvent,HASH32(UniformInput(corp_key))),
	                                                     Corp_Direct_Corp_Legal_dds,
		   					                             UniformInput(LEFT.corp_key) = UniformInput(RIGHT.corp_key),
										                 AssignCorpData_Event(LEFT,RIGHT),
										                 LEFT OUTER,LOCAL)		 
										 ), _pEvent);
	
	   
	   EXPORT Corp_Direct_Stock := IF(COUNT(_pStock) > 0,
	                                  IF(pHashJoin, JOIN(_pStock,
	                                                     Corp_Direct_Corp_Legal_dds,
					   					                 UniformInput(LEFT.corp_key) = UniformInput(RIGHT.corp_key),
							   			                 AssignCorpData_Stock(LEFT,RIGHT),
									  	                 LEFT OUTER,HASH),
													JOIN(DISTRIBUTE(_pStock,HASH32(UniformInput(corp_key))),
	                                                     Corp_Direct_Corp_Legal_dds,
									                     UniformInput(LEFT.corp_key) = UniformInput(RIGHT.corp_key),
									                     AssignCorpData_Stock(LEFT,RIGHT),
									                     LEFT OUTER,LOCAL)	 
										 ), _pStock);
	     
	   
	   EXPORT Corp_Direct_AR := IF(COUNT(_pAR) > 0,
	                                IF(pHashJoin, JOIN(_pAR,
	                                                   Corp_Direct_Corp_Legal_dds,
									                   UniformInput(LEFT.corp_key) = UniformInput(RIGHT.corp_key),
									                   AssignCorpData_AR(LEFT,RIGHT),
									                   LEFT OUTER,HASH),
												   JOIN(DISTRIBUTE(_pAR,HASH32(UniformInput(corp_key))),
	                                                   Corp_Direct_Corp_Legal_dds,
									                   UniformInput(LEFT.corp_key) = UniformInput(RIGHT.corp_key),
									                   AssignCorpData_AR(LEFT,RIGHT),
									                   LEFT OUTER,LOCAL)
										 ),_pAR);
	
	END; //AddCorpData
	
  /* This module accepts Master, Contact, Events, Stocks.
  || and AR (already mapped) datasets,
  || generates files and links them (if not in debug mode)
  || to the "sprayed" area superfiles
  */
  EXPORT GenerateMappedOutput(DATASET(Corp2.Layout_Corporate_Direct_Corp_In) Corp_Direct_Corp,
	  			 			  DATASET(Corp2.Layout_Corporate_Direct_Cont_In) Corp_Direct_Cont,
							  DATASET(Corp2.Layout_Corporate_Direct_Event_In) Corp_Direct_Event,
							  DATASET(Corp2.Layout_Corporate_Direct_Stock_In) Corp_Direct_Stock,
							  DATASET(Corp2.Layout_Corporate_Direct_AR_In) Corp_Direct_AR,
							  STRING pFCrp_nm_qual = 'Corp',
                              STRING pFCnt_nm_qual = 'Cont',
							  STRING pFEvt_nm_qual = 'Event',
							  STRING pFStk_nm_qual = 'Stock',  
							  STRING pFAR_nm_qual = 'AR',
							  STRING pStateOrigin,
							  STRING pProcessDate,
							  BOOLEAN pDebugMode = FALSE,
							  STRING pSuffix = ''
								,boolean pOverwrite = false
							  ) := MODULE
      //Declare output file names
	  //Still need path like 'thor_data400::in::corp::'
	  SHARED STRING fName	(STRING pFileIdentifier) := GetInFileName('R',pFileIdentifier,pStateOrigin,pProcessDate,true,pSuffix);
 	  SHARED STRING fCrp := fName(pFCrp_nm_qual); 
	  SHARED STRING fCnt := fName(pFCnt_nm_qual);
	  SHARED STRING fEvt := fName(pFEvt_nm_qual);
	  SHARED STRING fStk := fName(pFStk_nm_qual);
	  SHARED STRING fAR := fName(pFAR_nm_qual);
	
	  //Linking to the superfiles section 
	  SHARED sfName(STRING pFileIdentifier) := GetInFileName('M',pFileIdentifier,,,true);
	  SHARED STRING sfCrp := sfName('Corp');
	  SHARED STRING sfCnt := sfName('Cont');
      SHARED STRING sfEvt := sfName('Event');
	  SHARED STRING sfStk := sfName('Stock');
	  SHARED STRING sfAR  := sfName('AR');
	
	
	  SHARED StartSFT := FileServices.StartSuperFileTransaction();
      SHARED FinishSFT := FileServices.FinishSuperFileTransaction();

	  SHARED RemoveCrp := IF(NOT pDebugMode AND FileServices.FileExists(fCrp),FileServices.RemoveSuperFile(sfCrp,fCrp));
	  SHARED CorpDatasetNotNull := COUNT(Corp_Direct_Corp) > 0;
		VersionControl.macBuildNewLogicalFile(fCrp	,Corp_Direct_Corp,corp_out	,,,pOverwrite);		

	  WriteCrp := IF(CorpDatasetNotNull, corp_out);
	  DebugCrp := IF(CorpDatasetNotNull, OUTPUT(CHOOSEN(Corp_Direct_Corp,100)));
      SHARED mfCrp := IF(NOT pDebugMode AND CorpDatasetNotNull,WriteCrp,DebugCrp);	
	  SHARED AddCrp := IF(NOT pDebugMode AND CorpDatasetNotNull,FileServices.AddSuperFile(sfCrp,fCrp));
	
		
	  SHARED RemoveCnt := IF(NOT pDebugMode AND FileServices.FileExists(fCnt),FileServices.RemoveSuperFile(sfCnt,fCnt));
	  SHARED ContDatasetNotNull := COUNT(Corp_Direct_Cont) > 0;

		VersionControl.macBuildNewLogicalFile(fCnt	,Corp_Direct_Cont,cont_out	,,,pOverwrite);		

	  WriteCnt := IF(ContDatasetNotNull, cont_out);
	  DebugCnt := IF(ContDatasetNotNull, OUTPUT(CHOOSEN(Corp_Direct_Cont,100)));
	  SHARED mfCnt := IF(NOT pDebugMode AND ContDatasetNotNull,WriteCnt,DebugCnt);
	  SHARED AddCnt := IF(NOT pDebugMode AND ContDatasetNotNull,FileServices.AddSuperFile(sfCnt,fCnt));

	
	  SHARED RemoveEvt := IF(NOT pDebugMode AND FileServices.FileExists(fEvt),FileServices.RemoveSuperFile(sfEvt,fEvt));											 
	  SHARED EvtDatasetNotNull := COUNT(Corp_Direct_Event) > 0;

		VersionControl.macBuildNewLogicalFile(fEvt	,Corp_Direct_Event,event_out	,,,pOverwrite);		

	  WriteEvt := IF(EvtDatasetNotNull, event_out);
	  DebugEvt := IF(EvtDatasetNotNull, OUTPUT(CHOOSEN(Corp_Direct_Event,100)));
	  SHARED mfEvt := IF(NOT pDebugMode AND EvtDatasetNotNull,WriteEvt,DebugEvt);	
	  SHARED AddEvt := IF(NOT pDebugMode AND EvtDatasetNotNull,FileServices.AddSuperFile(sfEvt,fEvt));

      SHARED RemoveStk := IF(NOT pDebugMode AND FileServices.FileExists(fStk),FileServices.RemoveSuperFile(sfStk,fStk));											 
	  SHARED StkDatasetNotNull := COUNT(Corp_Direct_Stock) > 0;

		VersionControl.macBuildNewLogicalFile(fStk	,Corp_Direct_Stock,stock_out	,,,pOverwrite);		

	  WriteStk := IF(StkDatasetNotNull, stock_out);
	  DebugStk := IF(StkDatasetNotNull, OUTPUT(CHOOSEN(Corp_Direct_Stock,100)));
	  SHARED mfStk := IF(NOT pDebugMode AND StkDatasetNotNull,WriteStk,DebugStk);	
	  SHARED AddStk := IF(NOT pDebugMode AND StkDatasetNotNull,FileServices.AddSuperFile(sfStk,fStk));
  
	
	  SHARED RemoveAR := IF(NOT pDebugMode AND FileServices.FileExists(fAR),FileServices.RemoveSuperFile(sfAR,fAR));											 
	  SHARED ARDatasetNotNull := COUNT(Corp_Direct_AR) > 0;

		VersionControl.macBuildNewLogicalFile(fAR	,Corp_Direct_AR,ar_out	,,,pOverwrite);		

	  WriteAR := IF(ARDatasetNotNull, ar_out);
	  DebugAR := IF(ARDatasetNotNull, OUTPUT(CHOOSEN(Corp_Direct_AR,100)));	
	  SHARED mfAR := IF(NOT pDebugMode AND ARDatasetNotNull,WriteAR,DebugAR);	
	  SHARED AddAR := IF(NOT pDebugMode AND ARDatasetNotNull,FileServices.AddSuperFile(sfAR,fAR));
	
	  
	  EXPORT AssocCrp := SEQUENTIAL(RemoveCrp,mfCrp,AddCrp);
	  EXPORT AssocCnt := SEQUENTIAL(RemoveCnt,mfCnt,AddCnt);
	  EXPORT AssocEvt := SEQUENTIAL(RemoveEvt,mfEvt,AddEvt);
 	  EXPORT AssocStk := SEQUENTIAL(RemoveStk,mfStk,AddStk);
	  EXPORT AssocAR :=  SEQUENTIAL(RemoveAR,mfAR,AddAR);
	END; //GenerateMappedOutput
	

    //A wrapper around AddCorpData and GenerateMappedOutput
    EXPORT AddCorpData_and_GenerateMappedOutput(DATASET(Corp2.Layout_Corporate_Direct_Corp_In)  pCorp,
	 			                                DATASET(Corp2.Layout_Corporate_Direct_Cont_In)  pCont,
							                    DATASET(Corp2.Layout_Corporate_Direct_Event_In) pEvent,
							                    DATASET(Corp2.Layout_Corporate_Direct_Stock_In) pStock,
							                    DATASET(Corp2.Layout_Corporate_Direct_AR_In)    pAR,
										        STRING pFCrp_nm_qual,
                                                STRING pFCnt_nm_qual,
							                    STRING pFEvt_nm_qual,
							                    STRING pFStk_nm_qual,
							                    STRING pFAR_nm_qual,
							                    STRING pStateOrigin,
							                    STRING pProcessDate,
										        BOOLEAN pDebugMode = FALSE,
										        STRING pSuffix = '',
												BOOLEAN pHashJoin = TRUE
												,boolean pOverwrite = false
											    ) := MODULE
  
	   //Assign Corp Fields
	   SHARED ACD := AddCorpData(pCorp,pCont,pEvent,pStock,pAR,pHashJoin);
	   EXPORT Corp_Direct_Cont := ACD.Corp_Direct_Cont;
	   EXPORT Corp_Direct_Event := ACD.Corp_Direct_Event;
	   EXPORT Corp_Direct_Stock := ACD.Corp_Direct_Stock;
	   EXPORT Corp_Direct_AR := ACD.Corp_Direct_AR;
	
	   //Output Mapped Files
	   SHARED GMA := GenerateMappedOutput(pCorp,
	                                      Corp_Direct_Cont,
				    				 	  Corp_Direct_Event,
										  Corp_Direct_Stock,
										  Corp_Direct_AR,
							              pFCrp_nm_qual,
                                          pFCnt_nm_qual,
							              pFEvt_nm_qual,
							              pFStk_nm_qual,
							              pFAR_nm_qual,
										  pStateOrigin,
										  pProcessDate,
										  pDebugMode,
										  pSuffix
											,pOverwrite);
	
   	   EXPORT Crp := GMA.AssocCrp;
	   EXPORT Cnt := GMA.AssocCnt;
	   EXPORT Evt := GMA.AssocEvt;
	   EXPORT Stk := GMA.AssocStk;
	   EXPORT AR  := GMA.AssocAR;
	END; //AddCorpData_and_GenerateMappedOutput
	
END; //Rewrite_Common