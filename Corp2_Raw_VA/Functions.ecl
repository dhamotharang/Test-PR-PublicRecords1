IMPORT corp2;

EXPORT Functions := Module		
		//****************************************************************************
		//Valid_US_State_Codes: returns whether the state is a valid us state.
		//****************************************************************************
		EXPORT Valid_US_State_Codes(string s) := FUNCTION
					 RETURN map (corp2.t2u(s) in ['AK','AL','AR','AS','AZ','CA','CO','CT','CZ','DC','DE','FL','GA','GU','HI',
																				'IA','ID','IL','IN','KS','KY','LA','MA','MD','ME','MH','MI','MN','MO','MS',
																				'MT','NC','NH','NJ','NM','NV','NY','OH','OK','OR','PA','PR','RI','SC','SD',
																				'TN','TT','ND','NE','TX','UT','VA','VI','VT','WA','WI','WV','WY',''] => true,false);
		END;
		
		//Per CI:Vendor is sending below Foreign codes & will be populated in "corp_forgn_state_desc" field(corresponding "corp_forgn_state_cd" will have blank)
    EXPORT Special_Codes(string s) := FUNCTION
		 RETURN map (corp2.t2u(s) in ['AF','AI','AU','BE','BG','BH','BL','BM','BR','CB','CH','CONFEDERATED SALISH AND KOOTENAI TR',          
																	'CQ','CR','CY','DN','EASTERN BAND OF CHEROKEE INDIANS','EG','ES','ET','FEDERAL','FI','FR','GB',
																	'GE','GH','HK','IR','IS','IT','JP','KN','KO','LB','LC','LU','MU','NG','NL','NO','NT','NZ','PH',
																	'PO','SA','SG','SL','SV','SW','TC','TU','VG','U.S. GOVERNMENT','ZA'] => true,false);
	END;																				
		//****************************************************************************
		//State_Description: returns whether the state is a valid us state.
		//****************************************************************************
		EXPORT State_Code_Translation(string s) := FUNCTION

					 uc_s := corp2.t2u(stringlib.stringfilter(corp2.t2u(s),' ABCDEFGHIJKLMNOPQRSTUVWXYZ'));

	         RETURN map(uc_s = 'AL' => 'ALABAMA',
											uc_s = 'AK' => 'ALASKA', 
											uc_s = 'AR' => 'ARKANSAS', 
											uc_s = 'AS' => 'AMERICAN SAMOA', 
											uc_s = 'AZ' => 'ARIZONA', 
											uc_s = 'CA' => 'CALIFORNIA', 
											uc_s = 'CO' => 'COLORADO', 
											uc_s = 'CT' => 'CONNECTICUT',
											uc_s = 'CZ' => 'CANAL ZONE',										
											uc_s = 'DC' => 'DISTRICT OF COLUMBIA', 
											uc_s = 'DE' => 'DELAWARE', 
											uc_s = 'FL' => 'FLORIDA',
											uc_s = 'GA' => 'GEORGIA', 
											uc_s = 'GU' => 'GUAM', 
											uc_s = 'HI' => 'HAWAII', 
											uc_s = 'IA' => 'IOWA', 
											uc_s = 'ID' => 'IDAHO', 
											uc_s = 'IL' => 'ILLINOIS', 
											uc_s = 'IN' => 'INDIANA', 
											uc_s = 'KS' => 'KANSAS', 
											uc_s = 'KY' => 'KENTUCKY', 
											uc_s = 'LA' => 'LOUISIANA', 
											uc_s = 'MA' => 'MASSACHUSETTS', 
											uc_s = 'MD' => 'MARYLAND', 
											uc_s = 'ME' => 'MAINE' , 
											uc_s = 'MH' => 'MARSHALL ISLANDS' , 
											uc_s = 'MI' => 'MICHIGAN', 
											uc_s = 'MN' => 'MINNESOTA', 
											uc_s = 'MO' => 'MISSOURI', 
											uc_s = 'MS' => 'MISSISSIPPI', 
											uc_s = 'MT' => 'MONTANA', 
											uc_s = 'NC' => 'NORTH CAROLINA', 
											uc_s = 'ND' => 'NORTH DAKOTA', 
											uc_s = 'NE' => 'NEBRASKA', 
											uc_s = 'NH' => 'NEW HAMPSHIRE', 
											uc_s = 'NJ' => 'NEW JERSEY', 
											uc_s = 'NM' => 'NEW MEXICO', 
											uc_s = 'NV' => 'NEVADA', 
											uc_s = 'NY' => 'NEW YORK', 
											uc_s = 'OH' => 'OHIO', 
											uc_s = 'OK' => 'OKLAHOMA', 
											uc_s = 'OR' => 'OREGON', 
											uc_s = 'PA' => 'PENNSYLVANIA', 
											uc_s = 'PR' => 'PUERTO RICO', 
											uc_s = 'RI' => 'RHODE ISLAND', 
											uc_s = 'SC' => 'SOUTH CAROLINA', 
											uc_s = 'SD' => 'SOUTH DAKOTA', 
											uc_s = 'TN' => 'TENNESSEE', 
											uc_s = 'TT' => 'TRUST TERRITORIES',
											uc_s = 'TX' => 'TEXAS',
											uc_s = 'UT' => 'UTAH', 
											uc_s = 'VA' => 'VIRGINIA', 
											uc_s = 'VI' => 'VIRGIN ISLANDS', 
											uc_s = 'VT' => 'VERMONT', 
											uc_s = 'WA' => 'WASHINGTON', 
											uc_s = 'WI' => 'WISCONSIN', 
											uc_s = 'WV' => 'WEST VIRGINIA', 
											uc_s = 'WY' => 'WYOMING',
											'**|'+uc_s
										 );
		END;


		//****************************************************************************
		//CorpOrigBusTypeDesc: returns the corp_status_desc.
		//****************************************************************************
		EXPORT CorpOrigBusTypeDesc(string s) := FUNCTION
					 uc_s := corp2.t2u(s);
	         RETURN map(uc_s in ['0','00'] => 'GENERAL',
											uc_s = '11'        => 'ELECTRIC',
											uc_s = '12'        => 'TELEPHONE',
											uc_s = '13'        => 'GAS',
											uc_s = '14'        => 'WATER',
											uc_s = '15'        => 'WATER-SEWER',
											uc_s = '16'        => 'SEWER',
											uc_s = '18'        => 'RADIO COMMON CARRIER',
											uc_s = '20'        => 'BANKS AND CREDIT UNIONS',
											uc_s = '22'        => 'FEDERAL BANKS',
											uc_s = '23'        => 'BANK W/LIMITED CERTIFICATE',
											uc_s = '25'        => 'BANK & INSURANCE AGENT',
											uc_s = '26'        => 'MRTG/INSURANCE',
											uc_s = '30'        => 'INSURANCE COMPANIES',
											uc_s = '31'        => 'INSURANCE CONSULTANT',
											uc_s = '35'        => 'INSURANCE AGENCIES',
											uc_s = '36'        => 'MORTGAGE CO',
											uc_s = '40'        => 'OTHER FINANCIAL INSTITUTIONS',
											uc_s = '41'        => 'INSURANCE REGULATED ENTITIES',
											uc_s = '42'        => 'INS COMPANY & INS AGENCY',
											uc_s = '43'        => 'INS COMPANY & INS REG ENTITY',
											uc_s = '50'        => 'OTHER PUBLIC SERVICE',
											uc_s = '51'        => 'RAILWAYS',
											uc_s = '60'        => 'OTHER CHARITABLE INSTITUTIONS',
											uc_s = '61'        => 'FOUNDATIONS',
											uc_s = '62'        => 'VOLUNTEER RESCUE SQUADS/FIRE DEPTS',
											uc_s = '63'        => 'RELIGIOUS CEMETERIES',
											uc_s = '64'        => 'ORPHANAGES',
											uc_s = '65'        => 'CHURCHES AND RELIGIOUS DENOMINATIONS',
											uc_s = '66'        => 'ANIMAL AND CHILDREN\'S WELFARE',
											uc_s = '67'        => 'SPECIAL HOSPITALS AND COLLEGES',
											uc_s = '68'        => 'HISTORICAL/LITERARY SOCIETIES',
											uc_s = '69'        => 'ARTS AND SCIENCES',
											uc_s = '70'        => 'OTHER PROFESSIONAL COMPANIES',
											uc_s = '71'        => 'DOCTORS',
											uc_s = '72'        => 'LAWYERS/ATTORNEYS',
											uc_s = '73'        => 'ARCHITECTS',
											uc_s = '74'        => 'AUDIOLOGIST',
											uc_s = '75'        => 'SPEECH PATHOLOGIST',
											uc_s = '76'        => 'CLINICAL NURSE SPECIALIST',
											uc_s = '77'        => 'HOUSING COOPERATIVES',
											uc_s = '80'        => 'AGRICULTURAL COOPERATIVES',
											uc_s = '81'        => 'OTHER COOPERATIVES',
											uc_s = '84'        => 'WATER & SEWER AUTHORITIES',
											uc_s = '85'        => 'COMMUNITY DEVELOPMENT AUTHORITIES',
											uc_s = '86'        => 'WIRELESS SERVICE (BROADBAND) AUTHORITIES',
											uc_s = '87'        => 'ELECTRIC AUTHORITIES',
											uc_s = '89'        => 'OTHER AUTHORITIES',
											uc_s = '95'        => 'BENEFIT CORPORATIONS',
											''
										 );
		END;



		//****************************************************************************
		//CorpStatusDesc: returns the corp_status_desc.
		//****************************************************************************
		//Please note:  The vendor shall provide text values instead of codes. 
		//							The value is NO LONGER being derived based on a code. 
		//****************************************************************************
		EXPORT CorpStatusDesc(string s) := FUNCTION
					 uc_s := corp2.t2u(s);
	         RETURN map(uc_s = 'ACTIVE'    => 'ACTIVE',
											uc_s = 'INACTIVE'  => 'INACTIVE',
											uc_s = 'PENDINACT' => 'PENDING ACTIVE',
											uc_s = ''          => '',
											'**|'+uc_s
										 );
		END;

		//****************************************************************************
		//CorpAgentStatusDesc: returns the corp_agent_status_desc.
		//****************************************************************************
		//Please note:  The vendor shall provide text values instead of codes. 
		//							The value is NO LONGER being derived based on a code. 
		//****************************************************************************
		EXPORT CorpAgentStatusDesc(string s) := FUNCTION
					 uc_s := corp2.t2u(s);
	         RETURN map(uc_s = 'ACTIVE'              => 'ACTIVE',
											uc_s = 'INACTIVE'            => 'INACTIVE',
											uc_s = 'RESIGNED'            => 'RESIGNED',
											uc_s = 'PENDING RESIGNATION' => 'PENDING RESIGNATION',
											uc_s = ''                    => '',
											'**|'+uc_s

										 );
		END;
		
		//****************************************************************************
		//Corps_Assess_Ind_Translation: returns the assessment description.
		//****************************************************************************
		EXPORT Corps_Assess_Ind_Translation(string s) := FUNCTION
					 uc_s := corp2.t2u(s);
	         RETURN map(uc_s = '0'  => 'NORMAL ASSESSMENT',
											uc_s = '1'  => 'NON-ASSESSED-MUST FILE ANNUAL REPORT AND RA',
											uc_s = '2'  => 'NON-ASSESSED-NOT REQ TO FILE RA OR ANNUAL REPORT',
											uc_s = '3'  => 'NORMAL ASSESSMENT-RA, ANNUAL REPORT NOT REQUIRED',
											uc_s = '4'  => 'COOPERATIVES-(STORING AND MARKETING)',
											'' 
										 );
		END;
		
		//****************************************************************************
		//CorpRALocation: returns whether the location is a valid location.
		//****************************************************************************
		//Commenting out per code review feedback. Since the vendor has not sent us a 
		//table with the correct RA County information we will not map it at this time
		//****************************************************************************
		// EXPORT CorpRALocation(string s) := FUNCTION

					 // uc_s := corp2.t2u(stringlib.stringfilter(corp2.t2u(s),' 0123456789'));

	         // RETURN map(uc_s = '001' => 'FOREIGN',                                          
											// uc_s = '100' => 'ACCOMACK',                                   
											// uc_s = '101' => 'ALBEMARLE',                                  
											// uc_s = '102' => 'ALLEGHANY',                                  
											// uc_s = '103' => 'AMELIA',                                     
											// uc_s = '104' => 'AMHERST',                                    
											// uc_s = '105' => 'APPOMATTOX',                                 
											// uc_s = '106' => 'ARLINGTON',                                  
											// uc_s = '107' => 'AUGUSTA',                                    
											// uc_s = '108' => 'BATH',                                       
											// uc_s = '109' => 'BEDFORD',                                    
											// uc_s = '110' => 'BLAND',                                      
											// uc_s = '111' => 'BOTETOURT',                                  
											// uc_s = '112' => 'BRUNSWICK',                                  
											// uc_s = '113' => 'BUCHANAN',                                   
											// uc_s = '114' => 'BUCKINGHAM',                                 
											// uc_s = '115' => 'CAMPBELL',                                   
											// uc_s = '116' => 'CAROLINE',                                   
											// uc_s = '117' => 'CARROLL',                                    
											// uc_s = '118' => 'CHARLES CITY',                               
											// uc_s = '119' => 'CHARLOTTE',                                  
											// uc_s = '120' => 'CHESTERFIELD',                               
											// uc_s = '121' => 'CLARKE',                                     
											// uc_s = '122' => 'CRAIG',                                      
											// uc_s = '123' => 'CULPEPER',                                   
											// uc_s = '124' => 'CUMBERLAND',                                 
											// uc_s = '125' => 'DICKENSON',                                  
											// uc_s = '126' => 'DINWIDDIE',                                  
											// uc_s = '128' => 'ESSEX',                                      
											// uc_s = '129' => 'FAIRFAX',                                    
											// uc_s = '130' => 'FAUQUIER',                                   
											// uc_s = '131' => 'FLOYD',                                     
											// uc_s = '132' => 'FLUVANNA',                                   
											// uc_s = '133' => 'FRANKLIN',                                   
											// uc_s = '134' => 'FREDERICK',                                  
											// uc_s = '135' => 'GILES',                                      
											// uc_s = '136' => 'GLOUCESTER',                                 
											// uc_s = '137' => 'GOOCHLAND',                                  
											// uc_s = '138' => 'GRAYSON',                                    
											// uc_s = '139' => 'GREENE',                                     
											// uc_s = '140' => 'GREENSVILLE',                                
											// uc_s = '141' => 'HALIFAX',                                    
											// uc_s = '142' => 'HANOVER',                                    
											// uc_s = '143' => 'HENRICO',                                    
											// uc_s = '144' => 'HENRY',                                      
											// uc_s = '145' => 'HIGHLAND',                                   
											// uc_s = '146' => 'ISLE OF WIGHT',                              
											// uc_s = '147' => 'JAMES CITY',                                 
											// uc_s = '148' => 'KING GEORGE',                                
											// uc_s = '149' => 'KING & QUEEN',                               
											// uc_s = '150' => 'KING WILLIAM',                               
											// uc_s = '151' => 'LANCASTER',                                  
											// uc_s = '152' => 'LEE',                                        
											// uc_s = '153' => 'LOUDOUN',                                    
											// uc_s = '154' => 'LOUISA',                                     
											// uc_s = '155' => 'LUNENBURG',                                  
											// uc_s = '156' => 'MADISON',                                    
											// uc_s = '157' => 'MATHEWS',                                    
											// uc_s = '158' => 'MECKLENBURG',                                
											// uc_s = '159' => 'MIDDLESEX',                                  
											// uc_s = '160' => 'MONTGOMERY',                                 
											// uc_s = '162' => 'NELSON',                                     
											// uc_s = '163' => 'NEW KENT',                                   
											// uc_s = '165' => 'NORTHAMPTON',                                
											// uc_s = '166' => 'NORTHUMBERLAND',                             
											// uc_s = '167' => 'NOTTOWAY',                                   
											// uc_s = '168' => 'ORANGE',                                     
											// uc_s = '169' => 'PAGE',                                       
											// uc_s = '170' => 'PATRICK',                                    
											// uc_s = '171' => 'PITTSYLVANIA',                               
											// uc_s = '173' => 'PRINCE EDWARD',                              
											// uc_s = '174' => 'PRINCE GEORGE',                              
											// uc_s = '176' => 'PRINCE WILLIAM',                             
											// uc_s = '177' => 'PULASKI',                                    
											// uc_s = '178' => 'RAPPAHANNOCK',                               
											// uc_s = '179' => 'RICHMOND',                                   
											// uc_s = '180' => 'ROANOKE',                                    
											// uc_s = '181' => 'ROCKBRIDGE',                                 
											// uc_s = '182' => 'ROCKINGHAM',                                 
											// uc_s = '183' => 'RUSSELL',                                    
											// uc_s = '184' => 'SCOTT',                                      
											// uc_s = '185' => 'SHENANDOAH',                                 
											// uc_s = '186' => 'SMYTH',                                      
											// uc_s = '187' => 'SOUTHAMPTON',                                
											// uc_s = '188' => 'SPOTSYLVANIA',                               
											// uc_s = '189' => 'STAFFORD',                                   
											// uc_s = '190' => 'SURRY',                                      
											// uc_s = '191' => 'SUSSEX',                                     
											// uc_s = '192' => 'TAZEWELL',                                   
											// uc_s = '193' => 'WARREN',                                     
											// uc_s = '195' => 'WASHINGTON',                                 
											// uc_s = '196' => 'WESTMORELAND',                               
											// uc_s = '197' => 'WISE',                                       
											// uc_s = '198' => 'WYTHE',
											// uc_s = '199' => 'YORK',                                       
											// uc_s = '200' => 'ALEXANDRIA CITY',                                   
											// uc_s = '201' => 'BRISTOL CITY',                                      
											// uc_s = '202' => 'BUENA VISTA CITY',                                  
											// uc_s = '203' => 'CHARLOTTESVILLE CITY',                              
											// uc_s = '205' => 'DANVILLE CITY',                                     
											// uc_s = '206' => 'FREDERICKSBURG CITY',                               
											// uc_s = '207' => 'HAMPTON CITY',                                      
											// uc_s = '209' => 'HOPEWELL CITY',                                     
											// uc_s = '210' => 'LYNCHBURG CITY',                                    
											// uc_s = '211' => 'NEWPORT NEWS CITY',                                 
											// uc_s = '212' => 'NORFOLK CITY',                                      
											// uc_s = '213' => 'PETERSBURG CITY',                                   
											// uc_s = '214' => 'PORTSMOUTH CITY',                                   
											// uc_s = '215' => 'RADFORD CITY',                                      
											// uc_s = '216' => 'RICHMOND CITY',                                     
											// uc_s = '217' => 'ROANOKE CITY',                                      
											// uc_s = '219' => 'STAUNTON CITY',                                     
											// uc_s = '220' => 'SUFFOLK CITY',                                      
											// uc_s = '222' => 'WINCHESTER CITY',                                   
											// uc_s = '223' => 'MARTINSVILLE CITY',                                 
											// uc_s = '225' => 'WAYNESBORO CITY',                                   
											// uc_s = '227' => 'COLONIAL HEIGHTS CITY',                             
											// uc_s = '228' => 'VIRGINIA BEACH CITY',                               
											// uc_s = '236' => 'CHESAPEAKE CITY',                                   
											// uc_s = '239' => 'SALEM CITY',                                        
											// uc_s = '301' => 'COVINGTON CITY',        
											// uc_s = '302' => 'EMPORIA CITY',        
											// uc_s = '303' => 'FAIRFAX CITY',           
											// uc_s = '304' => 'FALLS CHURCH',         
											// uc_s = '305' => 'FRANKLIN CITY',     
											// uc_s = '306' => 'GALAX CITY',                                        
											// uc_s = '308' => 'MANASSAS CITY',    
											// uc_s = '309' => 'HARRISONBURG CITY',      
											// uc_s = '310' => 'LEXINGTON CITY',       
											// uc_s = '311' => 'POQUOSON CITY',              
											// uc_s = '312' => 'NORTON CITY',                		
											// uc_s = '315' => 'MANASSAS PARK',          
											// uc_s = '316' => 'WILLIAMSBURG CITY',    
											// uc_s = '901' => 'EXEMPT',
											// '');
		// END;
		


END;