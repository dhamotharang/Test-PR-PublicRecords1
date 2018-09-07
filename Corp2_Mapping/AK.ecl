Import ut, std, Tools, corp2, versioncontrol, Scrubs, Corp2_Raw_AK, Scrubs_Corp2_Mapping_AK_Main;
  
Export AK := Module 
 
 Export Update(String fileDate, String version, boolean pShouldSpray = _Dataset().bShouldSpray, boolean pOverwrite = false, pUseProd = Tools._Constants.IsDataland) := function
 
  // Raw Vendor Input files	
 CorporationsRaw := Corp2_Raw_AK.Files(filedate,pUseProd).input.Corporations.Logical;
 OfficialsRaw    := Corp2_Raw_AK.Files(filedate,pUseProd).input.Officials.Logical;
 
 // Distribute on business_id, then sort and dedup on the whole record
 distCorp        := dedup(sort(distribute(CorporationsRaw,hash(EntityNumber)),record,local), record,local) : independent;
 Officials       := dedup(sort(distribute(OfficialsRaw,hash(ParentEntityNumber)),record,local), record,local) : independent;

 // Sort Corporations on EntityNumber
 Corporations    := sort(distribute(CorporationsRaw,hash(EntityNumber)),record,local) : independent;
 
 state_origin		 := 'AK' ;
 state_fips	 		 := '02';
 state_desc	 		 := 'ALASKA';
	 
	// Normalize on the two corp legal names:  LegalName & AssumedName											 
	corp2_raw_ak.layouts.norm1Corp_layout norm1trf(corp2_raw_ak.layouts.CorporationsLayoutIn l, unsigned1 cnt) := transform,
											SKIP((cnt=1 and l.legalname = '') or (cnt=2 and l.assumedname = ''))
		self.Norm_corp_legal_name	     := choose(cnt,l.legalname,l.assumedname);
		self.Norm_nmtyp  							 := choose(cnt,'l','a');
		self 													 := l;
	end;
	norm1Corp	:= normalize(Corporations, 2, norm1trf(left, counter));
	
	
  // Normalize on the two RA Addresses:  RegisteredMailing & RegisteredPhys											 
	corp2_raw_ak.layouts.normalizedCorp_layout norm2trf(corp2_raw_ak.layouts.norm1Corp_layout l, unsigned1 cnt) := transform,
	      skip((cnt=2 and l.registeredphysaddress1 + l.registeredphysaddress2 + l.registeredphyscity + 
					              l.registeredphysstateprovince + l.registeredphyszip + l.registeredphyscountry =  '')    or
					   (cnt=1 and l.registeredmailingaddress1 + l.registeredmailingaddress2 + l.registeredmailingcity + 
											  l.registeredmailingstateprovince + l.registeredmailingzip + l.registeredmailingcountry =  '' 
										and l.registeredphysaddress1 + l.registeredphysaddress2 + l.registeredphyscity + 
											  l.registeredphysstateprovince + l.registeredphyszip + l.registeredphyscountry <> '' )   or
						 (cnt=2 and l.registeredmailingaddress1 + l.registeredmailingaddress2 + l.registeredmailingcity +
											  l.registeredmailingstateprovince + l.registeredmailingzip + l.registeredmailingcountry =  '' 
										and l.registeredphysaddress1 + l.registeredphysaddress2 + l.registeredphyscity +
											  l.registeredphysstateprovince + l.registeredphyszip + l.registeredphyscountry  = '' ) 	 )
							
		self.Norm_raAddress1		  := choose(cnt,l.RegisteredMailingAddress1			,l.RegisteredPhysAddress1);
		self.Norm_raAddress2		  := choose(cnt,l.RegisteredMailingAddress2			,l.RegisteredPhysAddress2);
		self.Norm_raCity		      := choose(cnt,l.RegisteredMailingCity		 			,l.RegisteredPhysCity);
		self.Norm_raStateProvince := choose(cnt,l.RegisteredMailingStateProvince,l.RegisteredPhysStateProvince);
		self.Norm_raZip		        := choose(cnt,l.RegisteredMailingZip					,l.RegisteredPhysZip);
		self.Norm_raCountry		    := choose(cnt,l.RegisteredMailingCountry			,l.RegisteredPhysCountry);
		
		mAddr := l.registeredmailingaddress1 + l.registeredmailingaddress2 + l.registeredmailingcity 
			  	 + l.registeredmailingstateprovince + l.registeredmailingzip + l.registeredmailingcountry;
	  pAddr := l.registeredphysaddress1 + l.registeredphysaddress2 + l.registeredphyscity 
					 + l.registeredphysstateprovince + l.registeredphyszip + l.registeredphyscountry;
						
		self.Norm_raAddrType := map(cnt=1 and mAddr <> ''                 => 'mail',
															  cnt=2 and pAddr <> ''                 => 'phys',
																cnt=1 and mAddr =  '' and pAddr  = '' => '',
																cnt=2 and mAddr =  '' and pAddr <> '' => 'phys',
																'');  
		self			           := l;
	end;
	normalizedCorp	:= normalize(norm1Corp, 2, norm2trf(left, counter));		
	
	corp2_raw_ak.layouts.normalizedCorp_layout TrfFixBadNames(corp2_raw_ak.layouts.normalizedCorp_layout l)	:=	transform
		TempName	:=	map(l.EntityNumber='10004410' and (corp2.T2U(l.Norm_corp_legal_name) = 'HANNAH KHLMAN PHOTOGRAPHY LLC.' or corp2.t2u(l.Norm_corp_legal_name)='HANNAH KÃ¥HLMAN PHOTOGRAPHY LLC.')														=> 'HANNAH KÅHLMAN PHOTOGRAPHY LLC.',
											l.EntityNumber='10012491' and  corp2.t2u(l.Norm_corp_legal_name) = 'NESTL PROFESSIONAL BEVERAGES'																																												=> 'NESTLÉ PROFESSIONAL BEVERAGES',
											l.EntityNumber='10013258' and  corp2.t2u(l.Norm_corp_legal_name) = 'CRÃªPE CIRCLES' 																																																		=> 'CRÊPE CIRCLES',
											l.EntityNumber='10014512' and  corp2.t2u(l.Norm_corp_legal_name) = 'KUDATAAN KAHÃ­DI'																																																		=> 'KUDATAAN KAHÍDI',
											l.EntityNumber='10014700' and  corp2.t2u(l.Norm_corp_legal_name) = 'ELÃN PROPERTIES REI, LLC'																																														=> 'ELÁN PROPERTIES REI, LLC',
											l.EntityNumber='10021057' and (corp2.t2u(l.Norm_corp_legal_name) = 'COZY BEAR CAF & EATING HOUSE'   or corp2.t2u(l.Norm_corp_legal_name)='COZY BEAR CAFÃ & EATING HOUSE')								=> 'COZY BEAR CAFÉ & EATING HOUSE',
											l.EntityNumber='10026840' and  corp2.t2u(l.Norm_corp_legal_name) = 'ALASKA CHAPTER NO. 97 OF THE INSTITUTE OF REAL ESTATE MGMT. OF THE NAT\'L ASSOC. OF REALTORSÂ®, INC.' 							=> 'ALASKA CHAPTER NO. 97 OF THE INSTITUTE OF REAL ESTATE MGMT. OF THE NAT\'L ASSOC. OF REALTORS, INC.',
											l.EntityNumber='10030098' and (corp2.t2u(l.Norm_corp_legal_name) = 'EÂ² CONSULTING LLC' or corp2.t2u(l.Norm_corp_legal_name)='E CONSULTING LLC')																				=> 'E2 CONSULTING LLC',
											l.EntityNumber='10030331' and (corp2.t2u(l.Norm_corp_legal_name) = 'AVÃ© HOLISTIC HEALTH & CHIROPRACTIC LLC' or corp2.t2u(l.Norm_corp_legal_name)='AV HOLISTIC HEALTH & CHIROPRACTIC LLC')	=> 'AVÉ HOLISTIC HEALTH & CHIROPRACTIC LLC',
											l.EntityNumber='10038329' and (corp2.t2u(l.Norm_corp_legal_name) = 'JENNIFER RENÃ© PHOTOGRAPHY LLC' or corp2.t2u(l.Norm_corp_legal_name)='JENNIFER REN PHOTOGRAPHY LLC')								=> 'JENNIFER RENÉ PHOTOGRAPHY LLC',
											l.EntityNumber='10038520' and  corp2.t2u(l.Norm_corp_legal_name) = 'ON THE WAY CAF LLC'																																																	=> 'ON THE WAY CAFÉ LLC',
											l.EntityNumber='10039672' and  corp2.t2u(l.Norm_corp_legal_name) = 'MORMOR AND SSTRE LLC'																																																=> 'MORMOR AND SOSTRE LLC',
											l.EntityNumber='10045310' and (corp2.t2u(l.Norm_corp_legal_name) = 'AVANC ACCOUNTING, LLC' or corp2.t2u(l.Norm_corp_legal_name)='AVANCÃ© ACCOUNTING, LLC')															=> 'AVANCÉ ACCOUNTING, LLC',
											l.EntityNumber='10053546' and (corp2.t2u(l.Norm_corp_legal_name) = 'GOLDEN WOLFWEALTH MANAGEMENT, LLC' or corp2.t2u(l.Norm_corp_legal_name)='GOLDEN WOLFÂ WEALTH MANAGEMENT, LLC')			=> 'GOLDEN WOLF WEALTH MANAGEMENT, LLC',
											l.EntityNumber='10055830' and  corp2.t2u(l.Norm_corp_legal_name) = 'ORO DIAMANT'																																																				=> 'ORO DIAMANTÉ',
											l.EntityNumber='10057816' and (corp2.t2u(l.Norm_corp_legal_name) = '9245-4362 QUBEC INC.' or corp2.t2u(l.Norm_corp_legal_name)='9245-4362 QUÃ©BEC INC.')																=> '9245-4362 QUÉBEC INC.',
											l.EntityNumber='10057875' and (corp2.t2u(l.Norm_corp_legal_name) = 'DIX AU CARR INC.' or corp2.t2u(l.Norm_corp_legal_name)='DIX AU CARRÃ© INC.')																				=> 'DIX AU CARRÉ INC.',
											l.EntityNumber='10060708' and (corp2.t2u(l.Norm_corp_legal_name) = 'ORO DIAMANT LLC' or corp2.t2u(l.Norm_corp_legal_name)='ORO DIAMANTÃ© LLC')																					=> 'ORO DIAMANTÉ LLC',
											l.EntityNumber='10064692' and  corp2.t2u(l.Norm_corp_legal_name) = 'CHRIS SHELDEN ROLFINGÂ® LLC' 																																												=> 'CHRIS SHELDEN ROLFING LLC',
											l.EntityNumber='10067364' and  corp2.t2u(l.Norm_corp_legal_name) = '64 N BREW' 																																																					=> '64 N BREW',
											l.EntityNumber='10068911' and	 corp2.t2u(l.Norm_corp_legal_name) = 'MTIF PRODUCATIONS'  																																																=> 'MÔTIF PRODUCATIONS',
											l.EntityNumber='10068911' and (corp2.t2u(l.Norm_corp_legal_name) = 'MTIF PRODUCTIONS' or corp2.t2u(l.Norm_corp_legal_name)='MÃ´TIF PRODUCTIONS')																				=> 'MÔTIF PRODUCTIONS',
											l.EntityNumber='10072013' and (corp2.t2u(l.Norm_corp_legal_name) = 'MOES OVERHAUL & EQUIPMENT SERVICE LLC' or corp2.t2u(l.Norm_corp_legal_name)='MOEÂ¿S OVERHAUL & EQUIPMENT SERVICE LLC')	=> 'MOE\'S OVERHAUL & EQUIPMENT SERVICE LLC',
											l.EntityNumber='10073327' and (corp2.t2u(l.Norm_corp_legal_name) = 'OOSIKS KISS, LLC' or corp2.t2u(l.Norm_corp_legal_name)='OOSIKÂ¿S KISS, LLC') 																				=> 'OOSIK\'S KISS, LLC',
											l.EntityNumber='10073372' and (corp2.t2u(l.Norm_corp_legal_name) = 'PERSONALSERVICEREALTYLLC' or corp2.t2u(l.Norm_corp_legal_name)='PERSONALÂ SERVICEÂ REALTYÂ LLC')										=> 'PERSONAL SERVICE REALTY LLC',
											l.EntityNumber='10073949' and (corp2.t2u(l.Norm_corp_legal_name) = 'BELLA CAF & BISTRO INC' or corp2.t2u(l.Norm_corp_legal_name)='BELLA CAFÃ© & BISTRO INC')		 												=> 'BELLA CAFÉ & BISTRO INC',
											l.EntityNumber='10074034' and (corp2.t2u(l.Norm_corp_legal_name) = 'BLM LLC' or corp2.t2u(l.Norm_corp_legal_name)='BLÃ¼M LLC')																													=> 'BLÜM LLC',
											l.EntityNumber='10075674' and (corp2.t2u(l.Norm_corp_legal_name) = 'DUBHDA PROPERTIES, LLC' or corp2.t2u(l.Norm_corp_legal_name)='Ã DUBHDA PROPERTIES, LLC')														=> 'Ó DUBHDA PROPERTIES, LLC',
											l.EntityNumber='10075751' and  corp2.t2u(l.Norm_corp_legal_name) = 'RIÃ¦KT CONSULTING, LLC'																																															=> 'RIKT CONSULTING, LLC',
											l.EntityNumber='10076263' and  corp2.t2u(l.Norm_corp_legal_name) = '60Â° NORTH SEAFOODS, LLC' 										 																																			=> '60 NORTH SEAFOODS, LLC',
											l.EntityNumber='10076573' and  corp2.t2u(l.Norm_corp_legal_name) = 'ALASKA REALTORSÂ®'																																																	=> 'ALASKA REALTORS®',
											l.EntityNumber='10076918' and  corp2.t2u(l.Norm_corp_legal_name) = 'KIMS KOREAN BBQ LLC'																																																=> 'KIM\'S KOREAN BBQ LLC',
											l.EntityNumber='10078750' and (corp2.t2u(l.Norm_corp_legal_name) = 'BORIKN CRAVINGS' or corp2.t2u(l.Norm_corp_legal_name)='BORIKÃN CRAVINGS') 																					=> 'BORIKÉN CRAVINGS',
											l.EntityNumber='10078940' and  corp2.t2u(l.Norm_corp_legal_name) = '61Âº NORTH PHOTOGRAPY BY BRYEN & LISA'																																							=> '61 NORTH PHOTOGRAPY BY BRYEN & LISA',
											l.EntityNumber='100792' 	and  corp2.t2u(l.Norm_corp_legal_name) = 'SHAKEELÃ¢Â¿Â¿S GIFTS & NOVELTIES, LLC.'																																							=> 'SHAKEEL\'S GIFTS & NOVELTIES, LLC.',
											l.EntityNumber='10081955' and (corp2.t2u(l.Norm_corp_legal_name) = 'LAO GACHO, LLC' or corp2.t2u(l.Norm_corp_legal_name)='LAÃ§O GAÃºCHO, LLC')																					=> 'LACO GAUCHO, LLC',
											l.EntityNumber='10082423' and  corp2.t2u(l.Norm_corp_legal_name) = 'RICHS ALASKAN FLYING ADVENTURES L.L.C.'																																							=> 'RICH\'S ALASKAN FLYING ADVENTURES L.L.C.',
											l.EntityNumber='10082777' and (corp2.t2u(l.Norm_corp_legal_name) = 'CHUGACH CHTEAU, LLC' or corp2.t2u(l.Norm_corp_legal_name)='CHUGACH CHÃ¢TEAU, LLC')																	=> 'CHUGACH CHATEAU, LLC',
											l.EntityNumber='10083885' and (corp2.t2u(l.Norm_corp_legal_name) = 'E&B LIVING GARYS DREAM LLC' or corp2.t2u(l.Norm_corp_legal_name)='E&B LIVING GARYÂ¿S DREAM LLC')										=> 'E&B LIVING GARY\'S DREAM LLC',
											l.EntityNumber='10084263' and (corp2.t2u(l.Norm_corp_legal_name) = 'HUBBARDS CUPBOARDS LLC' or corp2.t2u(l.Norm_corp_legal_name)='HUBBARDÂ¿S CUPBOARDS LLC')														=> 'HUBBARD\'S CUPBOARDS LLC',
											l.EntityNumber='101392'   and (corp2.t2u(l.Norm_corp_legal_name) = '59° NORTH COHOUSING COMMUNITY ASSOCIATION, INC.' or corp2.t2u(l.Norm_corp_legal_name)='59Â° NORTH COHOUSING COMMUNITY ASSOCIATION, INC.') => '59 NORTH COHOUSING COMMUNITY ASSOCIATION, INC.',
											l.EntityNumber='103460'   and (corp2.t2u(l.Norm_corp_legal_name) = 'KNSHA, INC.' or corp2.t2u(l.Norm_corp_legal_name)='KÃNSHA, INC.')																										=> 'KÃNSHA, INC.',
											l.EntityNumber='108805'   and  corp2.t2u(l.Norm_corp_legal_name) = 'GARAGETOWN USAÂ¿ CONDOMINIUMS, SOUTH ANCHORAGE OWNERS ASSOCIATION INC.'																							=> 'GARAGETOWN USA CONDOMINIUMS, SOUTH ANCHORAGE OWNERS ASSOCIATION INC.',
											l.EntityNumber='112462'   and  corp2.t2u(l.Norm_corp_legal_name) = 'KEITHÃ¢Â¿Â¿S THAWING, LLC'																																													=> 'KEITH\'S THAWING, LLC',
											l.EntityNumber='115510'   and (corp2.t2u(l.Norm_corp_legal_name) = 'THOMPSONÃ¢Â¿Â¿S TECHNICAL SOLUTIONS' or corp2.t2u(l.Norm_corp_legal_name)='THOMPSONâS TECHNICAL SOLUTIONS')					=> 'THOMPSON\'S TECHNICAL SOLUTIONS',
											l.EntityNumber='123282'   and (corp2.t2u(l.Norm_corp_legal_name) = 'F³ ENERGY SYSTEM, LLC' or corp2.t2u(l.Norm_corp_legal_name)='FÂ³ ENERGY SYSTEM, LLC')																=> 'F3 ENERGY SYSTEM, LLC',
											l.EntityNumber='124416'   and (corp2.t2u(l.Norm_corp_legal_name) = 'DR. CRAIG BGIN AND ASSOCIATES LLC.' or corp2.t2u(l.Norm_corp_legal_name)='DR. CRAIG BÃ©GIN AND ASSOCIATES LLC.')		=> 'DR. CRAIG BÉGIN AND ASSOCIATES LLC.',
											l.EntityNumber='134375'   and  corp2.t2u(l.Norm_corp_legal_name) = '55Â° NORTH, INC.'																																																		=> '55 NORTH, INC.',
											l.EntityNumber='99656'    and  corp2.t2u(l.Norm_corp_legal_name) = 'SHAKEELÃ¢Â¿Â¿S HALLMARK, LLC'																																												=> 'SHAKEEL\'S HALLMARK, LLC',
											l.EntityNumber='10088797' and (corp2.t2u(l.Norm_corp_legal_name) = 'AIRMOBILEÂ® ALASKA CORP'																																														=> 'AIRMOBILE ALASKA CORP',
											l.EntityNumber='10089497' and (corp2.t2u(l.Norm_corp_legal_name) = 'ANÃ¡ASKI KU.OO'																																																			=> 'ANÁASKI KU.OO',
											l.EntityNumber='10088448' and (corp2.t2u(l.Norm_corp_legal_name) = 'Ã…NGSTRÃ¶M IMAGING SOLUTIONS, LLC' or corp2.t2u(l.Norm_corp_legal_name)='ÃNGSTRÃ¶M IMAGING SOLUTIONS, LLC')					=> 'ÅNGSTRÖM IMAGING SOLUTIONS, LLC',
											l.Norm_corp_legal_name);
		self.Norm_corp_legal_name	:=	ut.fn_RemoveSpecialChars((string)Std.Uni.CleanAccents(TempName));
		self	:=	l;
	end;
	
	FixBadNames	:= project(normalizedCorp, TrfFixBadNames(left));

	
	//** Note **
  //  In the old mapper, they normalized on Entity Mailing and Entity Physical addresses
	//                          mapping them to corp_address1.  
	//  But in this new mapper, Entity Mailing address maps to corp_address1 and
  //                          Physical Mailing address maps to corp_address2.
	//  This results in fewer records in the final mapped Corporation (Main) file.
	
	// ------------------------------------------------------------------------
	// Map the Corp records of Main from the Corporations Normalized file
	// ------------------------------------------------------------------------
		corp2_Mapping.LayoutsCommon.Main CorpMainTransform(corp2_raw_ak.layouts.normalizedCorp_layout l):= transform
			self.dt_vendor_first_reported		 := (integer)fileDate;
			self.dt_vendor_last_reported		 := (integer)fileDate;
			self.dt_first_seen							 := (integer)fileDate;
			self.dt_last_seen								 := (integer)fileDate;
			self.corp_ra_dt_first_seen			 := (integer)fileDate;
			self.corp_ra_dt_last_seen				 := (integer)fileDate;
			self.corp_key										 := state_fips + '-' + corp2.t2u(l.entitynumber);
      self.corp_vendor								 := state_fips;
			self.corp_state_origin					 := state_origin;
			self.corp_process_date					 := fileDate;
			self.corp_orig_sos_charter_nbr	 := corp2.t2u(l.entitynumber);
			self.corp_legal_name						 := Corp2_Mapping.fCleanBusinessName(state_origin,state_desc,l.Norm_corp_legal_name).BusinessName;	
			self.corp_inc_state 						 := state_origin;
      
			legal_list                       := ['BUSINESS CORPORATION', 'COOP ELECTRIC AND TELEPHONE', 'COOPERATIVE CORPORATION',
																					 'LIMITED LIABILITY COMPANY', 'LIMITED LIABILITY PARTNERSHIP', 'LIMITED PARTNERSHIP',
																					 'NONPROFIT CORPORATION',	'PROFESSIONAL CORPORATION', 'RELIGIOUS CORPORATION'];			
      regis_list                       := ['BUSINESS NAME REGISTRATION', 'FOREIGN CORPORATE NAME REGISTRATION'];		
			
			self.corp_ln_name_type_cd				 := map(l.Norm_nmtyp='a'                                 								=>'06',  
																							l.Norm_nmtyp='l' and corp2.t2u(l.corptype) in legal_list				=>'01',  
																							l.Norm_nmtyp='l' and corp2.t2u(l.corptype) = 'NAME RESERVATION' =>'07',  
																							l.Norm_nmtyp='l' and corp2.t2u(l.corptype) in regis_list        =>'09', 
																					    corp2.t2u(l.corptype));
			self.corp_ln_name_type_desc			 := map(l.Norm_nmtyp='a'                                 								=>'ASSUMED',  
																							l.Norm_nmtyp='l' and corp2.t2u(l.corptype) in legal_list				=>'LEGAL',  
																							l.Norm_nmtyp='l' and corp2.t2u(l.corptype) = 'NAME RESERVATION'	=>'RESERVED',  
																							l.Norm_nmtyp='l' and corp2.t2u(l.corptype) in regis_list        =>'REGISTRATION',  
																					    '');																				
			self.corp_orig_org_structure_desc:= if (corp2.t2u(l.corptype) in legal_list ,corp2.t2u(l.corptype) ,'');
			self.corp_foreign_domestic_ind   := if (corp2.t2u(l.HomeState) in [state_desc,state_origin,''] ,'D' ,'F');
			self.corp_for_profit_ind 			   := if (corp2.t2u(l.corptype) = 'NONPROFIT CORPORATION' ,'N' ,'');
			self.corp_inc_date							 := if (corp2.t2u(l.HomeState) in [state_desc,state_origin,'']
																						 ,Corp2_Mapping.fValidateDate(l.AKFormedDate).PastDate ,''); 
			self.corp_forgn_date 						 := if (corp2.t2u(l.HomeState) not in [state_desc,state_origin,'']
																						 ,Corp2_Mapping.fValidateDate(l.AKFormedDate).PastDate ,'');												 
			self.corp_forgn_state_cd 		 	   := if (corp2.t2u(l.HomeState) not in [state_desc,state_origin,'']
																					  	,Corp2_Raw_AK.functions.GetHomeState_CD(l.HomeState),'');
			self.corp_forgn_state_desc   	   := if (corp2.t2u(l.HomeState) not in [state_desc,state_origin,'']
																						  ,corp2.t2u(l.HomeState),'');
			self.Corp_Country_of_Formation   := corp2_mapping.fCleanCountry(state_origin,state_desc,'',l.homecountry).Country; 																				
			self.corp_status_desc 					 := corp2.t2u(l.status);																		
			self.corp_standing            	 := if (corp2.t2u(l.status) = 'GOOD STANDING', 'Y', '');
			self.Corp_Name_Status_Desc       := if (corp2.t2u(l.status) = 'ACTIVE NAME', corp2.t2u(l.status), '');																		
			self.corp_term_exist_cd 		     := map(corp2.t2u(l.DurationExpirationDate) = 'PERPETUAL'                  => 'P',
																					     Corp2_Mapping.fValidateDate(l.DurationExpirationDate).GeneralDate <> '' => 'D',
																						   '');
			self.corp_term_exist_desc  			 := map(self.corp_term_exist_cd = 'P' => 'PERPETUAL',
																					    self.corp_term_exist_cd = 'D' => 'EXPIRATION DATE',
																						   '');
			self.corp_term_exist_exp  			 := Corp2_Mapping.fValidateDate(l.DurationExpirationDate).GeneralDate;																				 
			self.corp_ra_full_name					 := Corp2_Mapping.fCleanBusinessName(state_origin,state_desc,l.RegisteredAgent).BusinessName;	 
			self.corp_ra_title_desc          := if (self.corp_ra_full_name <> '', 'REGISTERED AGENT', ''); // from old mapper
			
			self.corp_address1_type_cd       := if (Corp2_Mapping.fAddressExists(state_origin,state_desc,l.entityMailingAddress1,l.entityMailingAddress2,l.entityMailingCity,l.entityMailingStateProvince,l.entityMailingZip,l.entityMailingCountry).ifAddressExists,'M','');	
			self.corp_address1_type_desc     := if (Corp2_Mapping.fAddressExists(state_origin,state_desc,l.entityMailingAddress1,l.entityMailingAddress2,l.entityMailingCity,l.entityMailingStateProvince,l.entityMailingZip,l.entityMailingCountry).ifAddressExists,'MAILING','');
			self.corp_address1_line1				 := Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.entityMailingAddress1,l.entityMailingAddress2,l.entityMailingCity,l.entityMailingStateProvince,l.entityMailingZip,l.entityMailingCountry).AddressLine1;
			self.corp_address1_line2				 := Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.entityMailingAddress1,l.entityMailingAddress2,l.entityMailingCity,l.entityMailingStateProvince,l.entityMailingZip,l.entityMailingCountry).AddressLine2;
			self.corp_address1_line3				 := Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.entityMailingAddress1,l.entityMailingAddress2,l.entityMailingCity,l.entityMailingStateProvince,l.entityMailingZip,l.entityMailingCountry).AddressLine3;			
			self.corp_prep_addr1_line1			 := Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.entityMailingAddress1,l.entityMailingAddress2,l.entityMailingCity,l.entityMailingStateProvince,l.entityMailingZip,l.entityMailingCountry).PrepAddrLine1;			
			self.corp_prep_addr1_last_line	 := Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.entityMailingAddress1,l.entityMailingAddress2,l.entityMailingCity,l.entityMailingStateProvince,l.entityMailingZip,l.entityMailingCountry).PrepAddrLastLine;

      self.corp_address2_type_cd       := if (Corp2_Mapping.fAddressExists(state_origin,state_desc,l.entityPhysAddress1,l.entityPhysAddress2,l.entityPhysCity,l.entityPhysStateProvince,l.entityPhysZip,l.entityPhysCountry).ifAddressExists,'B','');	
			self.corp_address2_type_desc     := if (Corp2_Mapping.fAddressExists(state_origin,state_desc,l.entityPhysAddress1,l.entityPhysAddress2,l.entityPhysCity,l.entityPhysStateProvince,l.entityPhysZip,l.entityPhysCountry).ifAddressExists,'BUSINESS','');
			self.corp_address2_line1				 := Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.entityPhysAddress1,l.entityPhysAddress2,l.entityPhysCity,l.entityPhysStateProvince,l.entityPhysZip,l.entityPhysCountry).AddressLine1;
			self.corp_address2_line2				 := Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.entityPhysAddress1,l.entityPhysAddress2,l.entityPhysCity,l.entityPhysStateProvince,l.entityPhysZip,l.entityPhysCountry).AddressLine2;
			self.corp_address2_line3				 := Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.entityPhysAddress1,l.entityPhysAddress2,l.entityPhysCity,l.entityPhysStateProvince,l.entityPhysZip,l.entityPhysCountry).AddressLine3;			
			self.corp_prep_addr2_line1			 := Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.entityPhysAddress1,l.entityPhysAddress2,l.entityPhysCity,l.entityPhysStateProvince,l.entityPhysZip,l.entityPhysCountry).PrepAddrLine1;			
			self.corp_prep_addr2_last_line	 := Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.entityPhysAddress1,l.entityPhysAddress2,l.entityPhysCity,l.entityPhysStateProvince,l.entityPhysZip,l.entityPhysCountry).PrepAddrLastLine;

			RA_AddrExists                    := Corp2_Mapping.fAddressExists(state_origin,state_desc,l.Norm_raAddress1,l.Norm_raAddress2,l.Norm_raCity,l.Norm_raStateProvince,l.Norm_raZip,l.Norm_raCountry).ifAddressExists; 
			self.corp_ra_address_type_cd		 := if (RA_AddrExists ,map(l.Norm_raAddrtype = 'mail' =>'M', l.Norm_raAddrtype = 'phys' =>'B', '') ,'');
			self.corp_ra_address_type_desc	 := if (RA_AddrExists	,map(l.Norm_raAddrtype = 'mail' =>'REGISTERED AGENT MAILING ADDRESS', l.Norm_raAddrtype = 'phys' =>'REGISTERED AGENT ADDRESS',	'')	,'');
			self.corp_ra_address_line1			 := Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.Norm_raAddress1,l.Norm_raAddress2,l.Norm_raCity,l.Norm_raStateProvince,l.Norm_raZip,l.Norm_raCountry).AddressLine1;
			self.corp_ra_address_line2			 := Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.Norm_raAddress1,l.Norm_raAddress2,l.Norm_raCity,l.Norm_raStateProvince,l.Norm_raZip,l.Norm_raCountry).AddressLine2;
			self.corp_ra_address_line3			 := Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.Norm_raAddress1,l.Norm_raAddress2,l.Norm_raCity,l.Norm_raStateProvince,l.Norm_raZip,l.Norm_raCountry).AddressLine3;			
			self.RA_prep_addr_line1				   := Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.Norm_raAddress1,l.Norm_raAddress2,l.Norm_raCity,l.Norm_raStateProvince,l.Norm_raZip,l.Norm_raCountry).PrepAddrLine1;			
			self.RA_prep_addr_last_line	     := Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.Norm_raAddress1,l.Norm_raAddress2,l.Norm_raCity,l.Norm_raStateProvince,l.Norm_raZip,l.Norm_raCountry).PrepAddrLastLine;
									
			self.recordOrigin                := 'C';																				
			self														 := [];
	end; 

	MapCorpMain	:= project(FixBadNames, CorpMainTransform(left));
	
	// Join the Mapped Corporations and Raw Officials files on Entity Number
	dedupCorp := DEDUP(SORT(DISTRIBUTE(MapCorpMain, hash(corp_orig_sos_charter_nbr)), corp_orig_sos_charter_nbr,local),	corp_orig_sos_charter_nbr,local);
	sortOffc  := SORT(DISTRIBUTE(Officials,HASH(corp2.t2u(ParentEntityNumber))),corp2.t2u(ParentEntityNumber),local); 
	
  // One record for every record in the Officials file that has a corresponding Corporations record 
	Corp_Offc_Join  := JOIN(sortOffc,dedupCorp,
												 corp2.t2u(LEFT.ParentEntityNumber) = corp2.t2u(RIGHT.corp_orig_sos_charter_nbr),
												 TRANSFORM(corp2_raw_ak.layouts.OfficialsLayoutIn ,SELF.ParentRecordType := RIGHT.Corp_Country_of_Formation; SELF := LEFT; SELF := []; ), 
												 INNER, LOCAL	);	
	
	// --------------------------------------------------------------------------------
	// Map the Contact records from the Officials file joined with Mapped Corp
	// --------------------------------------------------------------------------------
		corp2_Mapping.LayoutsCommon.Main ContMainTransform(corp2_raw_ak.layouts.OfficialsLayoutIn l):= transform
      self.dt_vendor_first_reported		 := (integer)fileDate;
			self.dt_vendor_last_reported		 := (integer)fileDate;
			self.dt_first_seen							 := (integer)fileDate;
			self.dt_last_seen								 := (integer)fileDate;
			self.corp_ra_dt_first_seen			 := (integer)fileDate;
			self.corp_ra_dt_last_seen				 := (integer)fileDate;
			self.corp_key										 := state_fips + '-' + corp2.t2u(l.ParentEntityNumber);
      self.corp_vendor								 := state_fips;
			self.corp_state_origin					 := state_origin;
			self.corp_process_date					 := fileDate;
			self.corp_orig_sos_charter_nbr	 := corp2.t2u(l.ParentEntityNumber);
			self.corp_legal_name						 := Corp2_Mapping.fCleanBusinessName(state_origin,state_desc,l.ParentEntityName).BusinessName;	
			self.corp_inc_state 						 := state_origin;		
			self.Corp_Country_of_Formation   := l.ParentRecordType; // Corp_Country_of_Formation from the Corp file carried over in this field from the join
			self.cont_full_name              := corp2.t2u(l.officialFirstName + ' ' + l.officialLastOrEntityName);
			self.cont_type_desc              := if (corp2.t2u(l.officialTitle) <> 'UNKNOWN HISTORIC' ,corp2.t2u(l.officialTitle), '');
			self.recordOrigin                := 'T';
			self								             := l;
			self								             := [];
	end; 

	MapContMain	:= project(Corp_Offc_Join, ContMainTransform(left));
	
	// ----------------------------------------------
	// Map the AR file from the Corporations raw file
	// ----------------------------------------------
	corp2_Mapping.LayoutsCommon.AR ARTransform(corp2_raw_ak.layouts.CorporationsLayoutIn l):= transform
			self.corp_key								:= state_fips + '-' + corp2.t2u(l.entitynumber);
      self.corp_vendor					  := state_fips;
			self.corp_state_origin			:= state_origin;
			self.corp_process_date			:= fileDate;
			self.corp_sos_charter_nbr	  := corp2.t2u(l.entitynumber);
			self.ar_due_dt 							:= Corp2_Mapping.fValidateDate(l.NextBrDueDate).GeneralDate;	
			self											  := [];
	 end; 
 
  MapAR1 := project(Corporations, ARTransform(left));

	//-----------------------------------------------------------//
	// Build the Final Mapped Files
	//-----------------------------------------------------------//
	MapMain := dedup(sort(distribute(MapCorpMain + MapContMain,hash(corp_key)), record,local), record,local) : independent;
	MapAR	  := dedup(sort(distribute(MapAR1(ar_due_dt <> ''),hash(corp_key)), record,local), record,local) : independent;
	
	
//======================SCRUBS LOGIC=====================================
		Main_F := MapMain;
		Main_S := Scrubs_Corp2_Mapping_AK_Main.Scrubs;        // AK scrubs module
		Main_N := Main_S.FromNone(Main_F); 										// Generate the error flags
		Main_T := Main_S.FromBits(Main_N.BitmapInfile);     	// Use the FromBits module; makes my bitmap datafile easier to get to
		Main_U := Main_S.FromExpanded(Main_N.ExpandedInFile); // Pass the expanded error flags into the Expanded module

	//Outputs reports
		Main_ErrorSummary					:= output(Main_U.SummaryStats, named('Main_ErrorSummary_AK'+filedate));
		Main_ScrubErrorReport 		:= output(choosen(Main_U.AllErrors, 1000), named('Main_ScrubErrorReport_AK'+filedate));
		Main_SomeErrorValues			:= output(choosen(Main_U.BadValues, 1000), named('Main_SomeErrorValues_AK'+filedate));
		Main_IsScrubErrors		 		:= IF(count(Main_U.AllErrors)<> 0,true,false);

		// Orbit Stats
		Main_OrbitStats						:= Main_U.OrbitStats();
		
		//Outputs files
		Main_CreateBitMaps				:= output(Main_N.BitmapInfile,,'~thor_data::corp_AK_main_scrubs_bits',overwrite,compressed);	//long term storage
		Main_TranslateBitMap			:= output(Main_T);
	 
	 	//Submits Profile's stats to Orbit
		Main_SubmitStats 					:= Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_AK_Main','ScrubsAlerts', Main_OrbitStats, version,'Corp_AK_Main').SubmitStats;
		
		Main_ScrubsWithExamples		:= Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_AK_Main','ScrubsAlerts', Main_OrbitStats, version,'Corp_AK_Main').CompareToProfile_with_Examples;
		
		Main_ScrubsAlert					:= Main_ScrubsWithExamples(RejectWarning = 'Y');
		Main_ScrubsAttachment			:= Scrubs.fn_email_attachment(Main_ScrubsAlert);
		Main_SendEmailFile				:= FileServices.SendEmailAttachData( corp2.Email_Notification_Lists.spray
																																	 ,'Scrubs CorpMain_AK Report' //subject
																																	 ,'Scrubs CorpMain_AK Report' //body
																																	 ,(data)Main_ScrubsAttachment
																																	 ,'text/csv'
																																	 ,'CorpAKMainScrubsReport.csv'
																																	 ,
																																	 ,
																																	 ,corp2.Email_Notification_Lists.spray
																																 );
																															
		Main_BadRecords := Main_T.ExpandedInFile(	dt_vendor_first_reported_invalid 			 <> 0 or
																							dt_vendor_last_reported_invalid 			 <> 0 or
																							dt_first_seen_invalid 							 	 <> 0 or
																							dt_last_seen_invalid 									 <> 0 or
																							corp_ra_dt_first_seen_invalid 				 <> 0 or
																							corp_ra_dt_last_seen_invalid 					 <> 0 or
																							corp_key_invalid 							 				 <> 0 or
																							corp_vendor_invalid 									 <> 0 or
																							corp_state_origin_invalid 						 <> 0 or
																							corp_process_date_invalid 						 <> 0 or
																							corp_orig_sos_charter_nbr_invalid 		 <> 0 or
																							corp_legal_name_invalid 							 <> 0 or
																							corp_ln_name_type_cd_invalid 					 <> 0 or
																							corp_status_desc_invalid 							 <> 0 or
																							corp_standing_invalid 								 <> 0 or
																							corp_inc_state_invalid 								 <> 0 or
																							corp_inc_date_invalid 								 <> 0 or
																							corp_term_exist_cd_invalid 						 <> 0 or
																							corp_term_exist_exp_invalid 					 <> 0 or
																							corp_term_exist_desc_invalid 					 <> 0 or
																							corp_foreign_domestic_ind_invalid 		 <> 0 or
																							corp_forgn_date_invalid 							 <> 0 or
																							corp_forgn_state_cd_invalid            <> 0 or
																							corp_orig_org_structure_desc_invalid 	 <> 0 or
																							corp_for_profit_ind_invalid 					 <> 0 or
																							corp_country_of_formation_invalid 		 <> 0 or
																							corp_Name_Status_Desc_invalid 	       <> 0 );

		Main_GoodRecords	:= Main_T.ExpandedInFile( dt_vendor_first_reported_invalid 		 = 0 and
																								dt_vendor_last_reported_invalid 			 = 0 and
																								dt_first_seen_invalid 							 	 = 0 and
																								dt_last_seen_invalid 									 = 0 and
																								corp_ra_dt_first_seen_invalid 				 = 0 and
																								corp_ra_dt_last_seen_invalid 					 = 0 and
																								corp_key_invalid 							 				 = 0 and
																								corp_vendor_invalid 									 = 0 and
																								corp_state_origin_invalid 						 = 0 and
																								corp_process_date_invalid 						 = 0 and
																								corp_orig_sos_charter_nbr_invalid 		 = 0 and
																								corp_legal_name_invalid 							 = 0 and
																								corp_ln_name_type_cd_invalid 					 = 0 and
																								corp_status_desc_invalid 							 = 0 and
																								corp_standing_invalid 								 = 0 and
																								corp_inc_state_invalid 								 = 0 and
																								corp_inc_date_invalid 								 = 0 and
																								corp_term_exist_cd_invalid 						 = 0 and
																								corp_term_exist_exp_invalid 					 = 0 and
																								corp_term_exist_desc_invalid 					 = 0 and
																								corp_foreign_domestic_ind_invalid 		 = 0 and
																								corp_forgn_date_invalid 							 = 0 and
																								corp_forgn_state_cd_invalid            = 0 and
																								corp_orig_org_structure_desc_invalid 	 = 0 and
																								corp_for_profit_ind_invalid 					 = 0 and
																								corp_country_of_formation_invalid 		 = 0 and
																								corp_Name_Status_Desc_invalid 	       = 0 );																											 																	

		Main_FailBuild	:= map(corp2_mapping.fCalcPercent(count(Main_N.ExpandedInFile(corp_key_invalid<>0)),count(Main_N.ExpandedInFile),false) 								 > Scrubs_Corp2_Mapping_AK_Main.Threshold_Percent.CORP_KEY									=> true,
													 corp2_mapping.fCalcPercent(count(Main_N.ExpandedInFile(corp_orig_sos_charter_nbr_invalid<>0)),count(Main_N.ExpandedInFile),false) > Scrubs_Corp2_Mapping_AK_Main.Threshold_Percent.CORP_ORIG_SOS_CHARTER_NBR => true,
													 corp2_mapping.fCalcPercent(count(Main_N.ExpandedInFile(corp_legal_name_invalid<>0)),count(Main_N.ExpandedInFile),false) 					 > Scrubs_Corp2_Mapping_AK_Main.Threshold_Percent.CORP_LEGAL_NAME 					=> true,
													 corp2_mapping.fCalcPercent(count(Main_N.ExpandedInFile(corp_country_of_formation_invalid<>0)),count(Main_N.ExpandedInFile),false) > Scrubs_Corp2_Mapping_AK_Main.Threshold_Percent.CORP_COUNTRY_OF_FORMATION	=> true,
													 count(Main_GoodRecords) = 0																																																																																				          => true,										 
													 false );

		Main_ApprovedRecords := project(Main_GoodRecords,transform(Corp2_Mapping.LayoutsCommon.Main,self := left));
		
	
 //=======================================VERSION CONTROL=============================================================
  VersionControl.macBuildNewLogicalFile(Corp2_Mapping._Dataset().thor_cluster_Files + 'in::corp2::'+version+'::main_AK'    ,Main_ApprovedRecords,Main_out      ,,,pOverwrite);	
  VersionControl.macBuildNewLogicalFile(Corp2_Mapping._Dataset().thor_cluster_Files + 'failed::corp2::'+version+'::main_AK',MapMain             ,write_fail_main,,,pOverwrite);
	VersionControl.macBuildNewLogicalFile(Corp2_Mapping._Dataset().thor_cluster_Files + 'in::corp2::'+version+'::ar_AK'      ,MapAR               ,AR_out        ,,,pOverwrite);			
  VersionControl.macBuildNewLogicalFile(Corp2_Mapping._Dataset().thor_cluster_Files + 'failed::corp2::'+version+'::ar_AK'  ,MapAR               ,write_fail_AR  ,,,pOverwrite);  
	
  Main_RejFile_Exists		:= IF(FileServices.FileExists(Corp2_Mapping._dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::main_ak'),true,false);																											 

	mapAK := sequential(	IF( pshouldspray = TRUE,Corp2_mapping.fSprayFiles(state_origin ,version,pOverwrite := pOverwrite))
														  // ,Corp2_Raw_AK.Build_Bases(filedate,version,puseprod).All  // Determined building bases is not needed
															,Main_out
															,AR_out
															,IF(Main_FailBuild <> true
																	,sequential( fileservices.addsuperfile(Corp2_Mapping._Dataset().thor_cluster_Files + 'in::'+Corp2_Mapping._Dataset().NameMapped+'::sprayed::main',Corp2_Mapping._Dataset().thor_cluster_Files + 'in::corp2::'+version+'::main_ak')
																							,fileservices.addsuperfile(Corp2_Mapping._Dataset().thor_cluster_Files + 'in::'+Corp2_Mapping._Dataset().NameMapped+'::sprayed::ar'  ,Corp2_Mapping._Dataset().thor_cluster_Files + 'in::corp2::'+version+'::ar_ak')																							 
																							 ,IF (count(Main_BadRecords) <> 0
																							 		 ,Corp2_Mapping.Send_Email(state_origin,version,count(Main_BadRecords)<>0,,,,count(Main_BadRecords),,,,count(Main_ApprovedRecords),count(mapAR)).RecordsRejected																				 
																						       ,Corp2_Mapping.Send_Email(state_origin,version,count(Main_BadRecords)<>0,,,,count(Main_BadRecords),,,,count(Main_ApprovedRecords),count(mapAR)).MappingSuccess ))
																							 ,sequential( write_fail_main
																	             ,write_fail_ar
																							 ,Corp2_Mapping.Send_Email(state_origin ,version).MappingFailed )	)			
																,IF(count(Main_BadRecords) <> 0
																		,IF ( poverwrite
																					,OUTPUT(Main_BadRecords,,Corp2_Mapping._Dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::main_'+ state_origin,overwrite,__compressed__,named('Sample_Rejected_Recs_AK'+filedate))
																					,sequential (IF(Main_RejFile_Exists,fileservices.deletelogicalfile(Corp2_Mapping._dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::main_'+ state_origin)),
																												OUTPUT(Main_BadRecords,,Corp2_Mapping._Dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::main_'+ state_origin,__compressed__,named('Sample_Rejected_Recs_AK'+filedate))))
																	 )
															 ,IF(Main_IsScrubErrors
																	 ,Corp2_Mapping.Send_Email(state_origin ,version,Main_IsScrubErrors,false,false,false).FieldsInvalidPerScrubs	)	
																,IF(COUNT(Main_ScrubsAlert) > 0, 	Main_SendEmailFile, OUTPUT('CORP2_MAPPING.AK - No Corp Scrubs Alerts_AK'))		
																,output(Main_ScrubsWithExamples, ALL, NAMED('MainAKScrubsWithExamples'+filedate)) //Send Alerts if Scrubs exceeds thresholds
																,Main_ErrorSummary
																,Main_ScrubErrorReport																					
																,Main_SomeErrorValues
																,Main_SubmitStats
															);
															
 		isFileDateValid := if((string)Std.Date.Today() between ut.date_math(filedate,-30) and ut.date_math(filedate,30),true,false);
		return sequential (if (isFileDateValid
														,mapAK
														,sequential (Corp2_Mapping.Send_Email(state_origin,filedate).InvalidFileDateParm
																				,FAIL('Corp2_Mapping.AK failed.  An invalid filedate was passed in as a parameter.')))); 	

 End; //Update Function

End;//End AK Module