Import corp2, std, ut;

EXPORT Functions :=Module;

	//********************************************************************
		//fGetName_desc: Returns "corp_ln_name_type_desc" 
	//********************************************************************	
	EXPORT   fGetName_desc(STRING desc) := FUNCTION
	
		uc  := corp2.t2u(desc);
		RETURN case(uc,
								'BUSINESS NAME RESERVATION'										=>'RESERVED',
								'BUSINESS TRUST'															=>'LEGAL',
								'COLLECTION AGENCY - DOMESTIC'								=>'LEGAL',
								'COLLECTION AGENCY - FOREIGN'									=>'LEGAL',
								'COMMERCIAL REGISTERED AGENT ENTITY'					=>'LEGAL',
								'COMMERCIAL REGISTERED AGENT INDIVIDUAL'			=>'LEGAL', 
								'CORPORATION - DOMESTIC - NON-PROFIT'					=>'LEGAL',
								'CORPORATION - DOMESTIC - PROFIT'							=>'LEGAL',
								'CORPORATION - FOREIGN - NON-PROFIT'					=>'LEGAL',
								'CORPORATION - FOREIGN - PROFIT'							=>'LEGAL',
								'CORPORATION - PROFESSIONAL'									=>'LEGAL',
								'DBA'																					=>'DBA',
								'LIMITED COOPERATIVE ASSOC - DOMESTIC'				=>'LEGAL',
								'LIMITED PARTNERSHIP - DOMESTIC'							=>'LEGAL',
								'LIMITED PARTNERSHIP - FOREIGN'								=>'LEGAL',
								'LLC - DOMESTIC'															=>'LEGAL',
								'LLC - FOREIGN'																=>'LEGAL',
								'LLC - PROFESSIONAL'													=>'LEGAL',
								'LLC - SERIES DOMESTIC'												=>'LEGAL',
								'LLC - SERIES FOREIGN'												=>'LEGAL',
								'LLP - DOMESTIC'															=>'LEGAL',
								'LLP - FOREIGN'																=>'LEGAL',
								'TRADEMARK'																		=>'TRADEMARK',
								'LLC - LOW PROFIT'														=>'LEGAL',
								'DBA - REAL ESTATE INV. TRUST'							  =>'DBA - REAL ESTATE INV. TRUST',
								'CORPORATION - BENEFIT CORPORATION'						=>'LEGAL',
								'CORPORATION - TRIBAL - NON-PROFIT'						=>'LEGAL',
								'CORPORATION - TRIBAL - PROFIT'								=>'LEGAL',
								'LTD LIABILITY LTD PARTNERSHIP - DOMESTIC'		=>'LEGAL',
								'LTD LIABILITY LTD PARTNERSHIP - FOREIGN'     =>'LEGAL',
								'CORPORATION - SOLE'												  =>'LEGAL',
								'LLC - SERIES TRIBAL'										  		=>'LEGAL',
								'LLC - TRIBAL'																=>'LEGAL',
								'LLC - PROFESSIONAL FOREIGN'									=>'LEGAL',
								'CERTIFICATION AUTHORITY'											=>'LEGAL',								 
								'REPOSITORY'																	=>'LEGAL',
								'CORPORATION - TRIBAL - PROFESSIONAL'					=>'LEGAL',
								'LIMITED COOPERATIVE ASSOC - FOREIGN'					=>'LEGAL', 
								'LLC - SERIES - TRIBAL'											  =>'LEGAL',
								'LLC - LOW-PROFIT'											 			=>'LEGAL',
								'TRADEMARK RESERVATION'											  =>'TRADEMARK',
								'CORPORATE NAME REGISTRATION'								  =>'REGISTRATION',
								'GENERAL PARTNERSHIP - DOMESTIC'						  =>'LEGAL',
								''																						=>'',
								'**|'+ uc);
END;								

	//********************************************************************
		//fGetName_cd: Returns "corp_ln_name_type_cd" 
	//********************************************************************	
	EXPORT  string fGetName_cd(STRING cd) := FUNCTION

		uc  := corp2.t2u(cd);
		RETURN case(uc,
								'BUSINESS NAME RESERVATION'										=>'07',
								'BUSINESS TRUST'															=>'01',
								'COLLECTION AGENCY - DOMESTIC'								=>'01',
								'COLLECTION AGENCY - FOREIGN'									=>'01',
								'COMMERCIAL REGISTERED AGENT ENTITY'					=>'01',
								'COMMERCIAL REGISTERED AGENT INDIVIDUAL'			=>'01', 
								'CORPORATION - DOMESTIC - NON-PROFIT'					=>'01',
								'CORPORATION - DOMESTIC - PROFIT'							=>'01',
								'CORPORATION - FOREIGN - NON-PROFIT'					=>'01',
								'CORPORATION - FOREIGN - PROFIT'							=>'01',
								'CORPORATION - PROFESSIONAL'									=>'01',
								'DBA'																					=>'02',
								'LIMITED COOPERATIVE ASSOC - DOMESTIC'				=>'01',
								'LIMITED PARTNERSHIP - DOMESTIC'							=>'01',
								'LIMITED PARTNERSHIP - FOREIGN'								=>'01',
								'LLC - DOMESTIC'															=>'01',
								'LLC - FOREIGN'																=>'01',
								'LLC - PROFESSIONAL'													=>'01',
								'LLC - SERIES DOMESTIC'												=>'01',
								'LLC - SERIES FOREIGN'												=>'01',
								'LLP - DOMESTIC'															=>'01',
								'LLP - FOREIGN'																=>'01',
								'TRADEMARK'																		=>'03',
								'LLC - LOW PROFIT'														=>'01',
								'DBA - REAL ESTATE INV. TRUST'							  =>'10',
								'CORPORATION - TRIBAL - NON-PROFIT'						=>'01',
								'CORPORATION - TRIBAL - PROFIT'								=>'01',
								'LTD LIABILITY LTD PARTNERSHIP - DOMESTIC'		=>'01',
								'LTD LIABILITY LTD PARTNERSHIP - FOREIGN'     =>'01',
								'CORPORATION - BENEFIT CORPORATION'						=>'01',
								'LTD LIABILITY LTD PARTNERSHIP'								=>'01',
								'CORPORATION - SOLE'												  =>'01',
								'LLC - SERIES TRIBAL'											    =>'01',
								'LLC - TRIBAL'																=>'01',
								'LLC - PROFESSIONAL FOREIGN'									=>'01',
								'CERTIFICATION AUTHORITY'											=>'01',								 
								'REPOSITORY'																	=>'01',
								'CORPORATION - TRIBAL - PROFESSIONAL'					=>'01',
								'LIMITED COOPERATIVE ASSOC - FOREIGN'				  =>'01', 
								'LLC - SERIES - TRIBAL'											  =>'01',
								'LLC - LOW-PROFIT'											 			=>'01',
								'TRADEMARK RESERVATION'											  =>'03',
								'CORPORATE NAME REGISTRATION'								  =>'09',
								'GENERAL PARTNERSHIP - DOMESTIC'						  =>'01',
								uc);
	END;	
	
		//********************************************************************
			//Get_State_Code: validates vendor codes and Returns '**' if we receive invalid or new codes from vendor 
		//********************************************************************	
		EXPORT Get_State_Code(string code) 
	        := map (corp2.t2u(code) in 
									['AA','AL','AK','AS','AZ','AR','BR','C','CA','CO','CT','DE','DC','FM','FL','GA',
									 'GU','HI','ID','IL','IN','IA','IE','KS','KY','LA','ME','MH','MD','MA',
									 'MI','MN','MS','MO','MT','NE','NV','NH','NJ','NM','NY','NC','ND','MP','MX',
									 'OH','OK','OR','PW','PA','PR','RI','SC','SD','TN','TX','UT','VT','VI','VA',
									 'WA','WV','WI','WY',
									 //Unload Codes
									 'AB','AU','BC','CH','CN','FR','GB','HK','JP','LX','NB',
									 'NG','NL','NU','ON','PE','PC','PH','PL','QB','QC','RP','SG','SP','SW'
									 ]=> corp2.t2u(code), 
									 corp2.t2u(code) in ['BA','BE','BG','BK','CH','EC','FU','OO','NA','QZ','XX','TC','TK','TO','UP',
																			'UN','US','WC','12','2',',','']=>'', //as per CI
								  '**');
									
	//********************************************************************
		//fGetStateDesc: Returns full name from "Two digit State_Code" 
	//********************************************************************	
	EXPORT  string fGetStateDesc(STRING state) := FUNCTION

		st  := corp2.t2u(state);
		RETURN case(st,
								'AL'=>'ALABAMA',
								'AK'=>'ALASKA',
								'AS'=>'AMERICAN SAMOA',
								'AZ'=>'ARIZONA',
								'AR'=>'ARKANSAS',
								'CA'=>'CALIFORNIA',
								'CO'=>'COLORADO',
								'C'=>'CANADA',
								'CT'=>'CONNECTICUT',
								'DE'=>'DELAWARE',
								'DC'=>'DISTRICT OF COLUMBIA',
								'FM'=>'FEDERATED STATES OF MICRONESIA',
								'FL'=>'FLORIDA',
								'GA'=>'GEORGIA',
								'GU'=>'GUAM',
								'HI'=>'HAWAII',
								'ID'=>'IDAHO',
								'IE'=>'IRELAND',
								'IL'=>'ILLINOIS',
								'IN'=>'INDIANA',
								'IA'=>'IOWA',
								'KS'=>'KANSAS',
								'KY'=>'KENTUCKY',
								'LA'=>'LOUISIANA',
								'ME'=>'MAINE',
								'MH'=>'MARSHALL ISLANDS',
								'MD'=>'MARYLAND',
								'MA'=>'MASSACHUSETTS',
								'MI'=>'MICHIGAN',
								'MN'=>'MINNESOTA',
								'MS'=>'MISSISSIPPI',
								'MO'=>'MISSOURI',
								'MT'=>'MONTANA',
								'MX'=>'MEXICO', 
								'NE'=>'NEBRASKA',
								'NV'=>'NEVADA',
								'NH'=>'NEW HAMPSHIRE',
								'NJ'=>'NEW JERSEY',
								'NM'=>'NEW MEXICO',
								'NY'=>'NEW YORK',
								'NC'=>'NORTH CAROLINA',
								'ND'=>'NORTH DAKOTA',
								'MP'=>'NORTHERN MARIANA ISLANDS',
								'OH'=>'OHIO',
								'OK'=>'OKLAHOMA',
								'OR'=>'OREGON',
								'PW'=>'PALAU',
								'PA'=>'PENNSYLVANIA',
								'PR'=>'PUERTO RICO',
								'RI'=>'RHODE ISLAND',
								'SC'=>'SOUTH CAROLINA',
								'SD'=>'SOUTH DAKOTA',
								'TN'=>'TENNESSEE',
								'TX'=>'TEXAS',
								'VT'=>'VERMONT',
								'VI'=>'VIRGIN ISLANDS',
								'VA'=>'VIRGINIA',
								'WA'=>'WASHINGTON',
								'WV'=>'WEST VIRGINIA',
								'WI'=>'WISCONSIN',
								'WY'=>'WYOMING',
								'AE'=>'ARMED FORCES EUROPE, THE IDDLE EAST, AND CANADA',
								'AA'=>'ARMED FORCES AMERICAS EXCEPT CANADA',
								'AP'=>'ARMED FORCES PACIFIC',
								'ON'=>'ONTARIO, CANADA',
								'JA'=>'JAPAN',
								'CN'=>'CANADA',
								'BR'=>'BRITISH COLUMBIA, CANADA',
								'NO'=>'NORWAY',
								'SA'=>'SASKATCHEWAN, CANADA',
								'TH'=>'NETHERLANDS',
								'BC'=>'BRITISH COLUMBIA',
								'MB'=>'MANITOBA',
								'NB'=>'NEW BRUNSWICK',
								'NL'=>'NEWFOUNDLAND AND LABRADOR',
								'NT'=>'NORTHWEST TERRITORIES',
								'NS'=>'NOVA SCOTIA',
								'NU'=>'NUNAVUT',
								'PE'=>'PRINCE EDWARD ISLAND',
								'QC'=>'QUEBEC',
								'SK'=>'SASKATCHEWAN',
								'YT'=>'YUKON',
								'IO'=>'BRITISH INDIAN OCEAN TERRITORY',
								//unload codes
								'AB'=>'ALBERTA',
								'AU'=>'AUSTRALIA',
								'BA'=>'',
								'BE'=>'',
								'BG'=>'',
								'BK'=>'',
								'CH'=>'',
								'EC'=>'',
								'FR'=>'FRANCE',
								'GB'=>'UNITED KINGDOM',
								'HK'=>'HONG KONG',
								'JP'=>'JAPAN',
								'LX'=>'LUXEMBOURG',
								'NG'=>'NIGERIA',
								'OO'=>'',
								'PH'=>'PHILIPPINES',
								'PC'=>'PHILIPPINES',
								'PL'=>'POLAND',
								'QB'=>'QUEBEC',
								'RP'=>'PANAMA',
								'SG'=>'SWITZERLAND',
								'SP'=>'SPAIN',
								'SW'=>'SWEDEN',
								'FU'=>'',
								'NA'=>'',
								'12'=>'',
								'2' =>'',
								',' =>'',
								'QZ'=>'',
								'TC'=>'',
								'TK'=>'',
								'TO'=>'',
								'UP'=>'',
								'UN'=>'',
								'US'=>'',
								'WC'=>'',
								'XX'=>'',
								''	=> '',
							  '**|'+ st);							
		END;	


	EXPORT fGet_addl_info(STRING Information_Type ,STRING Information) := FUNCTION
	
		corp_addl1        := If(corp2.t2u(Information_Type)not in ['ADDITIONAL PRINCIPALS','NUMBER OF PARTNERS',''] ,
													  map((string)(integer)corp2.t2u(Information) ='0'=> '',
																StringLib.StringFind(trim(Information,left,right),'NAICS',1)<>0 =>'', 
															  StringLib.StringFind(trim(Information,left,right),'.',1)<>0 =>corp2.t2u(Information_Type)+':'+ trim(Information,left,right),
															  StringLib.StringFind(trim(Information,left,right),',',1)<>0 =>corp2.t2u(Information_Type)+':'+ trim(Information,left,right),
															  corp2.t2u(Information_Type)+':'+ (string)(integer)trim(Information,left,right)
															 ),
														'');											
		corp_addl2        := If(corp2.t2u(Information_Type)='ADDITIONAL PRINCIPALS' ,
														map(corp2.t2u(Information)in ['YES','Y']=>'ADDITIONAL PRINCIPALS: Y',
																corp2.t2u(Information)in ['NO','N']=>'ADDITIONAL PRINCIPALS: N',
																''),
												 '');					
		corp_addl3        := If(StringLib.StringFind(trim(Information,left,right),'NAICS',1)<>0  and (integer) corp2.t2u(Information) <>0,'NAICS TITLE: '+ corp2.t2u(Information),'');					
		corp_addl4        := If(corp2.t2u(Information_Type)='NUMBER OF PARTNERS' and corp2.t2u(Information) <>'','NUMBER OF PARTNERS: '+ trim(Information),'');
		concatFields			:= trim(corp_addl1) + ';' + trim(corp_addl2) + ';' +trim(corp_addl3) + ';' +trim(corp_addl4) ; 
		tempExp						:= regexreplace('[;]*$',concatFields,'',NOCASE);
		tempExp2					:= regexreplace('^[;]*',tempExp,'',NOCASE);
		addl_info        	:= regexreplace('[;]+',tempExp2,';',NOCASE);
		RETURN addl_info;
				
	End;
	
  
  //Since Utah state site also displaying foreign characters in their names Rosemary had done some research online 
	//and provided correct names for those have foreign characters in vendor inputs.
	//Foreign accent characters that are in Utah corp names do not have common replacing characters 
	EXPORT fix_ForeignChar(STRING s) := FUNCTION

		uc_s  				 := corp2.t2u(s);				
		fix_uc_s       := map(uc_s='13Âº BARTENDING'			     															 =>'13 DEGREES BARTENDING',
													uc_s='ALION ECENI, LLC (FILED AS ALÃON)'    									 =>'ALION ECENI, LLC (FILED AS ALION)',
													uc_s='ÃSCEND CONSULTING'				 															 =>'ASCEND CONSULTING',
													uc_s='AMORÃ WEDDINGS & CELEBRATIONS LLC'  										 =>'AMOR WEDDINGS & CELEBRATIONS LLC',
													uc_s='ARETÃ MARKETING SOLUTIONS, L.L.C.'  									   =>'ARETE MARKETING SOLUTIONS, L.L.C.',
													uc_s='BELLISIMA MEDICAL SPA, L.L.C. (ON FORM BELLÃSIMA)'       =>'BELLISIMA MEDICAL SPA, L.L.C. (ON FORM BELLISIMA)',
													uc_s='CRÃPES PARTY LTD'			     														   =>'CREPES PARTY LTD',
													uc_s='DREA DESIGNS BEAUTY LLC (FILED DRÃA)' 							     =>'DREA DESIGNS BEAUTY LLC (FILED DREA)',
													uc_s='EL JARDÃN SPANISH CLASSES FOR KIDS L.L.C.' 				       =>'EL JARDIN SPANISH CLASSES FOR KIDS L.L.C',
													uc_s='ENGEL & VÃLKERS EDEN, LLC' 														   =>'ENGEL & VALKERS EDEN, LLC',
													uc_s='HOTÂ°SPOT BACKYARD FIRE PITS LIMITED LIABILITY COMPANY'  =>'HOT SPOT BACKYARD FIRE PITS LIMITED LIABILITY COMPANY',
													uc_s='KLÃTTRA LLC'						  															 =>'KLATTRA LLC',
													uc_s='LA MÃRE CLOTHING LLC'			 														   =>'LA MERE CLOTHING LLC',
													uc_s='LIBERTÃ LLC'							 															 =>'LIBERTA LLC',
													uc_s='LOHMEYER 360Â° MEDIA, LLC' 														   =>'LOHMEYER 360 DEGREES MEDIA, LLC',
													uc_s='LÃBER'										 															 =>'LABER',
													uc_s='MARIE PATÃ'							   														   =>'MARIE PATA',
													uc_s='MUÃOZ TRANSPORTING L.L.C.' 														   =>'MUAOZ TRANSPORTING L.L.C.',
													uc_s='OMÃDA, LLC'								 														   =>'OMADA, LLC',
													uc_s='ORGANIC BEAUTE BAR, LLC (FILED AS BEAUTÃ)' 						   =>'ORGANIC BEAUTE BAR, LLC (FILED AS BEAUTE)',
													uc_s='PARAÃSO LANDSCAPING , L.L.C.'                            =>'PARISO LANDSCAPING L.L.C.',
													uc_s='PRÃT COURIER SERVICES L.L.C.' 												   =>'PRAT COURIER SERVICES L.L.C.',
													uc_s='REJÃVE TRANQUILITY '                                     =>'REJUVE TRANQUILITY',
													uc_s='ROMER SOUND (FILED AS RÃMER)' 													 =>'ROMER SOUND (FILED AS ROMER)',
													uc_s='SLÃINTE LLC'						   															 =>'SLAINTE LLC',
													uc_s='SYRJÃLÃ-TAYLOR, LLC'			 															 =>'SYRJALA-TAYLOR, LLC',
													uc_s='TEÃLORED LASHES'																				 =>'TEELORED LASHES',
													uc_s='TOP ÃLITE NUTRITION'			 															 =>'TOP ELITE NUTRITION',
													uc_s='TRIPLE MONTAÃA LLC'			 															   =>'TRIPLE MONTANA LLC',
													uc_s='TÂ³ ENTERPRISES LLC'																		 =>'T3 ENTERPRISES LLC',
													uc_s='VIACOTÃ, L.L.C.'																				 =>'VIACOTA, L.L.C.',
													uc_s);
			return ut.fn_RemoveSpecialChars((string)Std.Uni.CleanAccents(fix_uc_s));		
			
		End;
		
End;
		