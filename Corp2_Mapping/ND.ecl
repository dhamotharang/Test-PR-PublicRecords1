import ut, std, Corp2, Corp2_Mapping, Scrubs, Corp2_Raw_ND, Scrubs_Corp2_Mapping_ND_Main, _control, Tools, versioncontrol;  
 
 export ND:= MODULE;      
 
  export Update(string fileDate, string version, boolean pShouldSpray = _Dataset().bShouldSpray, boolean pOverwrite = false, pUseProd = Tools._Constants.IsDataland) := function
 		
		state_origin	 := 'ND';
		state_fips	 	 := '38';	
		state_desc	 	 := 'NORTH DAKOTA';	  
		
		// Vendor Input Files  
		Filing	       := dedup(sort(distribute(Corp2_Raw_ND.Files(filedate,pUseProd).input.Filing.logical,hash(SOS_CONTROL_ID)),record,local),record,local) : independent; 
		Owner          := dedup(sort(distribute(Corp2_Raw_ND.Files(filedate,pUseProd).input.Owner.logical,hash(SOS_CONTROL_ID)),record,local),record,local) : independent; 
	  Trademark	     := dedup(sort(distribute(Corp2_Raw_ND.Files(filedate,pUseProd).input.Trademark.logical,hash(SOS_CONTROL_ID)),record,local),record,local) : independent; 
    TrademarkClass := dedup(sort(distribute(Corp2_Raw_ND.Files(filedate,pUseProd).input.TrademarkClass,hash(SOS_CONTROL_ID)),sos_control_id,recPos,local),sos_control_id, keep(6)) : independent; 


		//------- Begin CORP Mapping ---------------------------------------------------------------------//	
	
	  // Map Corp from Filing input file 	
	  Corp2_Mapping.LayoutsCommon.Main corp1Trf(Corp2_Raw_ND.Layouts.FilingLayoutIn l, integer c):=transform
		  ,skip(c = 2 and corp2.t2u(l.RA_MAIL_ADDR1      + l.RA_MAIL_ADDR2      + l.RA_MAIL_ADDR3      + l.RA_MAIL_CITY      + l.RA_MAIL_STATE      + l.RA_MAIL_POSTAL_CODE) = '' or 
			      c = 2 and corp2.t2u(l.RA_PRINCIPLE_ADDR1 + l.RA_PRINCIPLE_ADDR2 + l.RA_PRINCIPLE_ADDR3 + l.RA_PRINCIPLE_CITY + l.RA_PRINCIPLE_STATE + l.RA_PRINCIPLE_POSTAL_CODE) = 
											corp2.t2u(l.RA_MAIL_ADDR1      + l.RA_MAIL_ADDR2      + l.RA_MAIL_ADDR3      + l.RA_MAIL_CITY      + l.RA_MAIL_STATE      + l.RA_MAIL_POSTAL_CODE))
 				   
	   	self.dt_vendor_first_reported	    := (integer)fileDate;
			self.dt_vendor_last_reported	    := (integer)fileDate;
			self.dt_first_seen				        := (integer)fileDate;
			self.dt_last_seen				          := (integer)fileDate;
			self.corp_ra_dt_first_seen		    := (integer)fileDate;
			self.corp_ra_dt_last_seen		      := (integer)fileDate;
			self.corp_key					            := state_fips + '-' + corp2.t2u(l.SOS_CONTROL_ID);
			self.corp_vendor					        := state_fips;
		  self.corp_state_origin            := state_origin;
			self.corp_inc_state               := state_origin;
			self.corp_process_date				    := fileDate;  
			self.corp_orig_sos_charter_nbr    := corp2.t2u(l.SOS_CONTROL_ID);
			self.corp_legal_name              := Corp2_mapping.fCleanBusinessName(state_origin,state_desc,l.FILING_NAME).BusinessName;
      self.corp_ln_name_type_desc       := Corp2_Raw_ND.Functions.NameTyp_desc(l.FILING_TYPE);			
			self.corp_ln_name_type_cd         := case(self.corp_ln_name_type_desc, 'LEGAL'=>'01', 'TRADENAME'=>'04', 'FBN'=>'F', '');
      self.corp_orig_org_structure_desc := corp2.t2u(l.FILING_TYPE);
  		self.corp_for_profit_ind          := Corp2_Raw_ND.Functions.For_Profit(l.FILING_TYPE);
			self.corp_addl_info               := corp2.t2u(l.BUSINESS_TYPE);
 			self.corp_purpose                 := if(corp2.t2u(l.PURPOSE) not in ['.','CURRENTLY INACTIVE','INACTIVE','NONE','N/A','NOT YET REPORTED','SEE FILE','X']
			                                       ,corp2.t2u(l.PURPOSE) ,'');
			self.corp_orig_bus_type_desc      := self.corp_purpose;
			self.corp_term_exist_exp          := Corp2_Mapping.fValidateDate(l.EXPIRATION_date,'MM/DD/CCYY').GeneralDate;
			self.corp_term_exist_cd           := map(self.corp_term_exist_exp <> ''           => 'D',
			                                         corp2.t2u(l.DURATION_TYPE) = 'PERPETUAL' => 'P', 
																							 '');
			self.corp_term_exist_desc         := map(self.corp_term_exist_cd = 'D'            => 'EXPIRATION DATE',
			                                         self.corp_term_exist_cd = 'P'            => 'PERPETUAL',
																							 corp2.t2u(l.DURATION_TYPE) = 'EXPIRES'   => 'EXPIRES',
																							 '');
		  
			HomJurDate := Corp2_Mapping.fValidateDate(l.FORM_HOME_JURIS_DATE,'MM/DD/CCYY').PastDate;
			DelEffDate := Corp2_Mapping.fValidateDate(l.DELAYED_EFFECTIVE_DATE,'MM/DD/CCYY').PastDate;
			self.corp_filing_cd               := if(HomJurDate <> '' ,'H' ,'');
      self.corp_filing_desc             := map(HomJurDate <> '' => 'HOME STATE',
			                                         DelEffDate <> '' => 'DELAYED EFFECTIVE DATE',
																							 '');
	    self.corp_filing_date             := if(HomJurDate <> '' ,HomJurDate ,DelEffDate);
		  self.corp_delayed_effective_date  := DelEffDate;
      self.corp_status_desc             := corp2.t2u(l.STATUS);
  		self.corp_status_date             := if(corp2.t2u(l.STATUS)[1..8] = 'INACTIVE' ,Corp2_Mapping.fValidateDate(l.INACTIVE_DATE,'MM/DD/CCYY').PastDate ,'');				
 			self.corp_foreign_domestic_ind    := map(corp2.t2u(l.FILING_TYPE) = 'TRADE NAME' and corp2.t2u(l.PRINCIPLE_STATE) in ['ND','']     => 'D',
                                               corp2.t2u(l.FILING_TYPE) = 'TRADE NAME' and corp2.t2u(l.PRINCIPLE_STATE) not in ['ND',''] => 'F',			
			                              					 Corp2_Raw_ND.Functions.For_or_Dom(l.FILING_TYPE));	
			self.corp_inc_date                := if(self.corp_foreign_domestic_ind = 'D'
																							,Corp2_Mapping.fValidateDate(l.FILING_DATE,'MM/DD/CCYY').PastDate ,'');	
			self.corp_forgn_date              := if(self.corp_foreign_domestic_ind = 'F'
																							,Corp2_Mapping.fValidateDate(l.FILING_DATE,'MM/DD/CCYY').PastDate ,'');	
			self.corp_forgn_state_cd          := if(corp2.t2u(l.FORMATION_LOCALE) not in [state_desc,''] 
																							,ut.st2abbrev(corp2.t2u(l.FORMATION_LOCALE)) ,'');
			self.corp_forgn_state_desc        := if(corp2.t2u(l.FORMATION_LOCALE) not in [state_desc,'']
																							,corp2.t2u(l.FORMATION_LOCALE) ,'');
			self.corp_country_of_formation    := Corp2_Mapping.fCleanCountry(state_origin,state_desc,l.PRINCIPLE_STATE,l.PRINCIPLE_COUNTRY).Country;
			
			excludeList  := ['ADDRESS NOT YET REPORTED','X','.'];
			addr1_street := corp2.t2u( if(corp2.t2u(l.PRINCIPLE_ADDR1) in excludeList ,'' ,corp2.t2u(l.PRINCIPLE_ADDR1)) + ' ' +
																 if(corp2.t2u(l.PRINCIPLE_ADDR2) in excludeList ,'' ,corp2.t2u(l.PRINCIPLE_ADDR2)) + ' ' +
																 if(corp2.t2u(l.PRINCIPLE_ADDR3) in excludeList ,'' ,corp2.t2u(l.PRINCIPLE_ADDR3)) );
			self.corp_address1_type_cd        := if (Corp2_Mapping.fAddressExists(state_origin,state_desc,addr1_street,,l.PRINCIPLE_CITY,l.PRINCIPLE_STATE,l.PRINCIPLE_POSTAL_CODE,l.PRINCIPLE_COUNTRY).ifAddressExists,'B','');
			self.corp_address1_type_desc      := if (Corp2_Mapping.fAddressExists(state_origin,state_desc,addr1_street,,l.PRINCIPLE_CITY,l.PRINCIPLE_STATE,l.PRINCIPLE_POSTAL_CODE,l.PRINCIPLE_COUNTRY).ifAddressExists,'BUSINESS','');
			self.corp_address1_line1					:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,addr1_street,,l.PRINCIPLE_CITY,l.PRINCIPLE_STATE,l.PRINCIPLE_POSTAL_CODE,l.PRINCIPLE_COUNTRY).AddressLine1;
			self.corp_address1_line2					:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,addr1_street,,l.PRINCIPLE_CITY,l.PRINCIPLE_STATE,l.PRINCIPLE_POSTAL_CODE,l.PRINCIPLE_COUNTRY).AddressLine2;
			self.corp_address1_line3					:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,addr1_street,,l.PRINCIPLE_CITY,l.PRINCIPLE_STATE,l.PRINCIPLE_POSTAL_CODE,l.PRINCIPLE_COUNTRY).AddressLine3;			
			self.corp_prep_addr1_line1				:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,addr1_street,,l.PRINCIPLE_CITY,l.PRINCIPLE_STATE,l.PRINCIPLE_POSTAL_CODE,l.PRINCIPLE_COUNTRY).PrepAddrLine1;			
			self.corp_prep_addr1_last_line	  := Corp2_Mapping.fCleanAddress(state_origin,state_desc,addr1_street,,l.PRINCIPLE_CITY,l.PRINCIPLE_STATE,l.PRINCIPLE_POSTAL_CODE,l.PRINCIPLE_COUNTRY).PrepAddrLastLine;
			
			addr2_street := corp2.t2u( if(corp2.t2u(l.MAIL_ADDR1) in excludeList ,'' ,corp2.t2u(l.MAIL_ADDR1)) + ' ' +
																 if(corp2.t2u(l.MAIL_ADDR2) in excludeList ,'' ,corp2.t2u(l.MAIL_ADDR2)) + ' ' +
																 if(corp2.t2u(l.MAIL_ADDR3) in excludeList ,'' ,corp2.t2u(l.MAIL_ADDR3)) );
			self.corp_address2_type_cd        := if (Corp2_Mapping.fAddressExists(state_origin,state_desc,addr2_street,,l.MAIL_CITY,l.MAIL_STATE,l.MAIL_POSTAL_CODE,l.MAIL_COUNTRY).ifAddressExists,'M','');
			self.corp_address2_type_desc      := if (Corp2_Mapping.fAddressExists(state_origin,state_desc,addr2_street,,l.MAIL_CITY,l.MAIL_STATE,l.MAIL_POSTAL_CODE,l.MAIL_COUNTRY).ifAddressExists,'MAILING','');
			self.corp_address2_line1					:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,addr2_street,,l.MAIL_CITY,l.MAIL_STATE,l.MAIL_POSTAL_CODE,l.MAIL_COUNTRY).AddressLine1;
			self.corp_address2_line2					:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,addr2_street,,l.MAIL_CITY,l.MAIL_STATE,l.MAIL_POSTAL_CODE,l.MAIL_COUNTRY).AddressLine2;
			self.corp_address2_line3					:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,addr2_street,,l.MAIL_CITY,l.MAIL_STATE,l.MAIL_POSTAL_CODE,l.MAIL_COUNTRY).AddressLine3;			
			self.corp_prep_addr2_line1				:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,addr2_street,,l.MAIL_CITY,l.MAIL_STATE,l.MAIL_POSTAL_CODE,l.MAIL_COUNTRY).PrepAddrLine1;			
			self.corp_prep_addr2_last_line	  := Corp2_Mapping.fCleanAddress(state_origin,state_desc,addr2_street,,l.MAIL_CITY,l.MAIL_STATE,l.MAIL_POSTAL_CODE,l.MAIL_COUNTRY).PrepAddrLastLine;
			
			self.corp_ra_full_name            := Corp2_mapping.fCleanBusinessName(state_origin,state_desc,l.RA_NAME).BusinessName;
			
			  
			self.corp_agent_status_desc       := if(corp2.t2u(l.FILING_TYPE) not in ['TRADE NAME', 'FICTITIOUS PARTNERSHIP NAME']
																						 ,corp2.t2u(l.STANDING_RA) ,'');	
			self.corp_ra_addl_info            := if (self.corp_agent_status_desc <> '', 'AGENT STATUS: ' + self.corp_agent_status_desc, '');
			self.corp_agent_country           := Corp2_Mapping.fCleanCountry(state_origin,state_desc,l.RA_PRINCIPLE_STATE,l.RA_PRINCIPLE_COUNTRY).Country;
			self.corp_ra_address_type_cd      := choose(c, if (Corp2_Mapping.fAddressExists(state_origin,state_desc,l.RA_PRINCIPLE_ADDR1,l.RA_PRINCIPLE_ADDR2 + ' ' + l.RA_PRINCIPLE_ADDR3,l.RA_PRINCIPLE_CITY,l.RA_PRINCIPLE_STATE,l.RA_PRINCIPLE_POSTAL_CODE,l.RA_PRINCIPLE_COUNTRY).ifAddressExists, 'R', ''),
																										 if (Corp2_Mapping.fAddressExists(state_origin,state_desc,l.RA_MAIL_ADDR1,     l.RA_MAIL_ADDR2      + ' ' + l.RA_MAIL_ADDR3     ,l.RA_MAIL_CITY     ,l.RA_MAIL_STATE     ,l.RA_MAIL_POSTAL_CODE     ,l.RA_MAIL_COUNTRY).ifAddressExists     , 'M', ''));			
			self.corp_ra_address_type_desc    := choose(c, if (Corp2_Mapping.fAddressExists(state_origin,state_desc,l.RA_PRINCIPLE_ADDR1,l.RA_PRINCIPLE_ADDR2 + ' ' + l.RA_PRINCIPLE_ADDR3,l.RA_PRINCIPLE_CITY,l.RA_PRINCIPLE_STATE,l.RA_PRINCIPLE_POSTAL_CODE,l.RA_PRINCIPLE_COUNTRY).ifAddressExists, 'REGISTERED OFFICE', ''),
																										 if (Corp2_Mapping.fAddressExists(state_origin,state_desc,l.RA_MAIL_ADDR1,     l.RA_MAIL_ADDR2      + ' ' + l.RA_MAIL_ADDR3     ,l.RA_MAIL_CITY     ,l.RA_MAIL_STATE     ,l.RA_MAIL_POSTAL_CODE     ,l.RA_MAIL_COUNTRY).ifAddressExists     , 'MAILING ADDRESS'  , ''));
			self.corp_ra_address_line1				:= choose(c, Corp2_Mapping.fCleanAddress(state_origin,state_desc ,l.RA_PRINCIPLE_ADDR1, l.RA_PRINCIPLE_ADDR2 + ' ' + l.RA_PRINCIPLE_ADDR3,l.RA_PRINCIPLE_CITY,l.RA_PRINCIPLE_STATE,l.RA_PRINCIPLE_POSTAL_CODE,l.RA_PRINCIPLE_COUNTRY).AddressLine1,
                                                     Corp2_Mapping.fCleanAddress(state_origin,state_desc ,l.RA_MAIL_ADDR1,      l.RA_MAIL_ADDR2      + ' ' + l.RA_MAIL_ADDR3     ,l.RA_MAIL_CITY     ,l.RA_MAIL_STATE     ,l.RA_MAIL_POSTAL_CODE     ,l.RA_MAIL_COUNTRY     ).AddressLine1);
			self.corp_ra_address_line2				:= choose(c, Corp2_Mapping.fCleanAddress(state_origin,state_desc ,l.RA_PRINCIPLE_ADDR1, l.RA_PRINCIPLE_ADDR2 + ' ' + l.RA_PRINCIPLE_ADDR3,l.RA_PRINCIPLE_CITY,l.RA_PRINCIPLE_STATE,l.RA_PRINCIPLE_POSTAL_CODE,l.RA_PRINCIPLE_COUNTRY).AddressLine2,
                                                     Corp2_Mapping.fCleanAddress(state_origin,state_desc ,l.RA_MAIL_ADDR1,      l.RA_MAIL_ADDR2      + ' ' + l.RA_MAIL_ADDR3     ,l.RA_MAIL_CITY     ,l.RA_MAIL_STATE     ,l.RA_MAIL_POSTAL_CODE     ,l.RA_MAIL_COUNTRY     ).AddressLine2);
			self.corp_ra_address_line3				:= choose(c, Corp2_Mapping.fCleanAddress(state_origin,state_desc ,l.RA_PRINCIPLE_ADDR1, l.RA_PRINCIPLE_ADDR2 + ' ' + l.RA_PRINCIPLE_ADDR3,l.RA_PRINCIPLE_CITY,l.RA_PRINCIPLE_STATE,l.RA_PRINCIPLE_POSTAL_CODE,l.RA_PRINCIPLE_COUNTRY).AddressLine3,			
                                                     Corp2_Mapping.fCleanAddress(state_origin,state_desc ,l.RA_MAIL_ADDR1,      l.RA_MAIL_ADDR2      + ' ' + l.RA_MAIL_ADDR3     ,l.RA_MAIL_CITY     ,l.RA_MAIL_STATE     ,l.RA_MAIL_POSTAL_CODE     ,l.RA_MAIL_COUNTRY     ).AddressLine3);
			self.ra_prep_addr_line1						:= choose(c, Corp2_Mapping.fCleanAddress(state_origin,state_desc ,l.RA_PRINCIPLE_ADDR1, l.RA_PRINCIPLE_ADDR2 + ' ' + l.RA_PRINCIPLE_ADDR3,l.RA_PRINCIPLE_CITY,l.RA_PRINCIPLE_STATE,l.RA_PRINCIPLE_POSTAL_CODE,l.RA_PRINCIPLE_COUNTRY).PrepAddrLine1,		
                                                     Corp2_Mapping.fCleanAddress(state_origin,state_desc ,l.RA_MAIL_ADDR1,      l.RA_MAIL_ADDR2      + ' ' + l.RA_MAIL_ADDR3     ,l.RA_MAIL_CITY     ,l.RA_MAIL_STATE     ,l.RA_MAIL_POSTAL_CODE     ,l.RA_MAIL_COUNTRY     ).PrepAddrLine1);
			self.ra_prep_addr_last_line 			:= choose(c, Corp2_Mapping.fCleanAddress(state_origin,state_desc ,l.RA_PRINCIPLE_ADDR1, l.RA_PRINCIPLE_ADDR2 + ' ' + l.RA_PRINCIPLE_ADDR3,l.RA_PRINCIPLE_CITY,l.RA_PRINCIPLE_STATE,l.RA_PRINCIPLE_POSTAL_CODE,l.RA_PRINCIPLE_COUNTRY).PrepAddrLastLine,
                                                     Corp2_Mapping.fCleanAddress(state_origin,state_desc ,l.RA_MAIL_ADDR1,      l.RA_MAIL_ADDR2      + ' ' + l.RA_MAIL_ADDR3     ,l.RA_MAIL_CITY     ,l.RA_MAIL_STATE     ,l.RA_MAIL_POSTAL_CODE     ,l.RA_MAIL_COUNTRY     ).PrepAddrLastLine);		  
			self.recordOrigin                 := 'C';
		  self                              := [];
    end;  
		
		//--------------------- Add CLASS_NAME to Trademarks ------------------------------------------
		TrademarkWithClass := join(Trademark, TrademarkClass,
															 corp2.t2u(left.SOS_CONTROL_ID) = corp2.t2u(right.SOS_CONTROL_ID),
																transform(Corp2_Raw_ND.Layouts.Temp_TrademarkWithClass,
																					self.CLASS_NAME := right.CLASS_NAME; 
																					self 						:= left;
																					self  					:= [];),
																	 left outer, local);
		
		// Denormalize to get the first 6 class_names into one record  
			
		Corp2_Raw_ND.Layouts.Temp_TrademarkWithClass DenormOfficers(Corp2_Raw_ND.Layouts.Temp_TrademarkWithClass L, Corp2_Raw_ND.Layouts.Temp_TrademarkWithClass R, INTEGER C) := TRANSFORM
			self.class1 	:= IF (C=1, R.class_name,L.class1);                  
			self.class2		:= IF (C=2, R.class_name,L.class2);
			self.class3		:= IF (C=3, R.class_name,L.class3); 
			self.class4		:= IF (C=4, R.class_name,L.class4); 
			self.class5		:= IF (C=5, R.class_name,L.class5); 
			self.class6		:= IF (C=6, R.class_name,L.class6); 
			self 					:= L;
		END;
		
		DenormalizedFile := sort(denormalize(TrademarkWithClass, TrademarkWithClass,
																					corp2.t2u(left.sos_control_id) = corp2.t2u(right.sos_control_id),
																					DenormOfficers(left,right,COUNTER)),
																          sos_control_id,class_name);
																					
		Corp2_Mapping.LayoutsCommon.Main corp2Trf(Corp2_Raw_ND.Layouts.Temp_TrademarkWithClass l):=transform
	
    	self.dt_vendor_first_reported	     := (integer)fileDate;
			self.dt_vendor_last_reported	     := (integer)fileDate;
			self.dt_first_seen				         := (integer)fileDate;
			self.dt_last_seen				           := (integer)fileDate;
			self.corp_ra_dt_first_seen		     := (integer)fileDate;
			self.corp_ra_dt_last_seen		       := (integer)fileDate;
			self.corp_key					             := state_fips + '-' + corp2.t2u(l.SOS_CONTROL_ID);
			self.corp_vendor					         := state_fips;
		  self.corp_state_origin             := state_origin;
			self.corp_inc_state                := state_origin;
			self.corp_process_date				     := fileDate;  
			self.corp_orig_sos_charter_nbr     := corp2.t2u(l.SOS_CONTROL_ID);
			self.corp_trademark_nbr            := corp2.t2u(l.SOS_CONTROL_ID);
			self.corp_ln_name_type_cd          := '03';
			self.corp_ln_name_type_desc        := 'TRADEMARK';
		  self.corp_legal_name               := Corp2_mapping.fCleanBusinessName(state_origin,state_desc,l.TRADEMARK_NAME).BusinessName;
			self.corp_filing_date              := Corp2_Mapping.fValidateDate(l.FILING_DATE,'MMM_DD_CCYY').PastDate;
			self.corp_trademark_filing_date    := Corp2_Mapping.fValidateDate(l.FILING_DATE,'MMM_DD_CCYY').PastDate;
      self.corp_trademark_status         := corp2.t2u(l.STATUS);
			self.corp_status_desc              := corp2.t2u(l.STATUS);
			self.corp_status_date              := if(corp2.t2u(l.STATUS)[1..8] = 'INACTIVE' ,Corp2_Mapping.fValidateDate(l.INACTIVE_DATE,'MMM_DD_CCYY').PastDate ,'');				
			self.corp_forgn_state_cd           := if(corp2.t2u(l.FORMATION_LOCALE) not in [state_desc,''] 
																							 ,ut.st2abbrev(corp2.t2u(l.FORMATION_LOCALE)) ,'');
			self.corp_forgn_state_desc         := if(corp2.t2u(l.FORMATION_LOCALE) not in [state_desc,'']
																							,corp2.t2u(l.FORMATION_LOCALE) ,'');
			self.corp_trademark_class_desc1    := corp2.t2u(l.class1);
			self.corp_trademark_class_desc2    := corp2.t2u(l.class2);
			self.corp_trademark_class_desc3    := corp2.t2u(l.class3);
			self.corp_trademark_class_desc4    := corp2.t2u(l.class4);
			self.corp_trademark_class_desc5    := corp2.t2u(l.class5);
			self.corp_trademark_class_desc6    := corp2.t2u(l.class6);
			self.corp_entity_desc              := corp2.t2u(if(corp2.t2u(l.class1) <> '' ,corp2.t2u(l.class1) ,'') + 
																											if(corp2.t2u(l.class2) <> '' ,'; ' + corp2.t2u(l.class2) ,'') +
																											if(corp2.t2u(l.class3) <> '' ,'; ' + corp2.t2u(l.class3) ,'') +
																											if(corp2.t2u(l.class4) <> '' ,'; ' + corp2.t2u(l.class4) ,'') +
																											if(corp2.t2u(l.class5) <> '' ,'; ' + corp2.t2u(l.class5) ,'') +
																											if(corp2.t2u(l.class6) <> '' ,'; ' + corp2.t2u(l.class6) ,'') );  
			self.corp_trademark_expiration_date:= Corp2_Mapping.fValidateDate(l.EXPIRATION_DATE,'MMM_DD_CCYY').GeneralDate;
			self.corp_term_exist_exp           := Corp2_Mapping.fValidateDate(l.EXPIRATION_DATE,'MMM_DD_CCYY').GeneralDate;
			self.corp_term_exist_cd            := if(self.corp_term_exist_exp <> '' ,'D' ,'');
			self.corp_term_exist_desc          := if(self.corp_term_exist_exp <> '' ,'EXPIRATION DATE' ,'');
		 	self.recordOrigin                  := 'C';
		  self                               := [];
    end; 
		
		MapCorpFiling     := normalize(Filing, 2, corp1Trf(left,counter));
		MapCorpTrademark  := project(DenormalizedFile, corp2Trf(left)) ;
		MapCorp           := MapCorpFiling + MapCorpTrademark;
  	
		//---------- End CORP Mapping --------------------------------------------------------------//

    
		//------- Begin CONTACTS Mapping ---------------------------------------------------------------------//	
		
		 // Map Contacts from Owner file
		 Corp2_Mapping.LayoutsCommon.Main cont1Trf(Corp2_Raw_ND.Layouts.OwnerLayoutIn l, integer c):=transform
				  ,skip(c = 1 and Corp2_mapping.fCleanBusinessName(state_origin,state_desc,l.NAME).BusinessName = '' or
					      c = 2 and Corp2_Mapping.fCleanBusinessName(state_origin,state_desc,l.FIRST_NAME + ' ' + l.MIDDLE_NAME + ' ' + l.LAST_NAME).BusinessName = '')

			self.dt_vendor_first_reported	    := (integer)fileDate;
			self.dt_vendor_last_reported	    := (integer)fileDate;
			self.dt_first_seen				        := (integer)fileDate;
			self.dt_last_seen				          := (integer)fileDate;
			self.corp_ra_dt_first_seen		    := (integer)fileDate;
			self.corp_ra_dt_last_seen		      := (integer)fileDate;
			self.corp_key					            := state_fips + '-' + corp2.t2u(l.SOS_CONTROL_ID);
			self.corp_vendor					        := state_fips;
		  self.corp_state_origin            := state_origin;
			self.corp_inc_state               := state_origin;
			self.corp_process_date				    := fileDate;  
			self.corp_orig_sos_charter_nbr    := corp2.t2u(l.SOS_CONTROL_ID);
			self.corp_legal_name              := Corp2_mapping.fCleanBusinessName(state_origin,state_desc,l.FILING_NAME).BusinessName;
      self.cont_full_name			          := choose(c, Corp2_Mapping.fCleanBusinessName(state_origin,state_desc,l.NAME).BusinessName
			                                             , Corp2_Mapping.fCleanBusinessName(state_origin,state_desc,l.FIRST_NAME + ' ' + l.MIDDLE_NAME + ' ' + l.LAST_NAME).BusinessName);			
			self.cont_type_cd         	      := 'O';
			self.cont_type_desc       	      := 'OWNER';
			self.cont_address_type_cd         := if (Corp2_Mapping.fAddressExists(state_origin,state_desc,l.MAIL_ADDR1,l.MAIL_ADDR2 + ' ' + L.MAIL_ADDR3,l.MAIL_CITY,l.MAIL_STATE,l.MAIL_POSTAL_CODE,l.MAIL_COUNTRY).ifAddressExists, 'M', '');			
			self.cont_address_type_desc       := if (Corp2_Mapping.fAddressExists(state_origin,state_desc,l.MAIL_ADDR1,l.MAIL_ADDR2 + ' ' + L.MAIL_ADDR3,l.MAIL_CITY,l.MAIL_STATE,l.MAIL_POSTAL_CODE,l.MAIL_COUNTRY).ifAddressExists, 'MAILING', '');
			self.cont_address_line1					  := Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.MAIL_ADDR1,l.MAIL_ADDR2 + ' ' + L.MAIL_ADDR3,l.MAIL_CITY,l.MAIL_STATE,l.MAIL_POSTAL_CODE,l.MAIL_COUNTRY).AddressLine1;
			self.cont_address_line2					  := Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.MAIL_ADDR1,l.MAIL_ADDR2 + ' ' + L.MAIL_ADDR3,l.MAIL_CITY,l.MAIL_STATE,l.MAIL_POSTAL_CODE,l.MAIL_COUNTRY).AddressLine2;
			self.cont_address_line3					  := Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.MAIL_ADDR1,l.MAIL_ADDR2 + ' ' + L.MAIL_ADDR3,l.MAIL_CITY,l.MAIL_STATE,l.MAIL_POSTAL_CODE,l.MAIL_COUNTRY).AddressLine3;			
			self.cont_prep_addr_line1				  := Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.MAIL_ADDR1,l.MAIL_ADDR2 + ' ' + L.MAIL_ADDR3,l.MAIL_CITY,l.MAIL_STATE,l.MAIL_POSTAL_CODE,l.MAIL_COUNTRY).PrepAddrLine1;			
			self.cont_prep_addr_last_line	    := Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.MAIL_ADDR1,l.MAIL_ADDR2 + ' ' + L.MAIL_ADDR3,l.MAIL_CITY,l.MAIL_STATE,l.MAIL_POSTAL_CODE,l.MAIL_COUNTRY).PrepAddrLastLine;
			self.cont_country                 := Corp2_Mapping.fCleanCountry(state_origin,state_desc,l.MAIL_STATE,l.MAIL_COUNTRY).Country;
			self.recordOrigin                 := 'T';	
			self                              := [];
		 end;  

	  // Map Contacts from Trademarks 		 
	  Corp2_Mapping.LayoutsCommon.Main cont2Trf(Corp2_Raw_ND.Layouts.TMLayoutIn  l):=transform
					
 			self.dt_vendor_first_reported	    := (integer)fileDate;
			self.dt_vendor_last_reported	    := (integer)fileDate;
			self.dt_first_seen				        := (integer)fileDate;
			self.dt_last_seen				          := (integer)fileDate;
			self.corp_ra_dt_first_seen		    := (integer)fileDate;
			self.corp_ra_dt_last_seen		      := (integer)fileDate;
			self.corp_key					            := state_fips + '-' + corp2.t2u(l.SOS_CONTROL_ID);
			self.corp_vendor					        := state_fips;
		  self.corp_state_origin            := state_origin;
			self.corp_inc_state               := state_origin;
			self.corp_process_date				    := fileDate;  
			self.corp_orig_sos_charter_nbr    := corp2.t2u(l.SOS_CONTROL_ID);
			self.corp_legal_name              := Corp2_mapping.fCleanBusinessName(state_origin,state_desc,l.TRADEMARK_NAME).BusinessName;
      self.cont_full_name			          := Corp2_Mapping.fCleanBusinessName(state_origin,state_desc,l.OWNER).BusinessName;
			self.cont_type_cd         	      := 'O';
			self.cont_type_desc       	      := 'OWNER';
			self.cont_address_type_cd         := if (Corp2_Mapping.fAddressExists(state_origin,state_desc,l.MAIL_ADDR1,l.MAIL_ADDR2 + ' ' + L.MAIL_ADDR3,l.MAIL_CITY,l.MAIL_STATE,l.MAIL_POSTAL_CODE,l.MAIL_COUNTRY).ifAddressExists, 'M', '');			
			self.cont_address_type_desc       := if (Corp2_Mapping.fAddressExists(state_origin,state_desc,l.MAIL_ADDR1,l.MAIL_ADDR2 + ' ' + L.MAIL_ADDR3,l.MAIL_CITY,l.MAIL_STATE,l.MAIL_POSTAL_CODE,l.MAIL_COUNTRY).ifAddressExists, 'MAILING', '');
			self.cont_address_line1					  := Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.MAIL_ADDR1,l.MAIL_ADDR2 + ' ' + L.MAIL_ADDR3,l.MAIL_CITY,l.MAIL_STATE,l.MAIL_POSTAL_CODE,l.MAIL_COUNTRY).AddressLine1;
			self.cont_address_line2					  := Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.MAIL_ADDR1,l.MAIL_ADDR2 + ' ' + L.MAIL_ADDR3,l.MAIL_CITY,l.MAIL_STATE,l.MAIL_POSTAL_CODE,l.MAIL_COUNTRY).AddressLine2;
			self.cont_address_line3					  := Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.MAIL_ADDR1,l.MAIL_ADDR2 + ' ' + L.MAIL_ADDR3,l.MAIL_CITY,l.MAIL_STATE,l.MAIL_POSTAL_CODE,l.MAIL_COUNTRY).AddressLine3;			
			self.cont_prep_addr_line1				  := Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.MAIL_ADDR1,l.MAIL_ADDR2 + ' ' + L.MAIL_ADDR3,l.MAIL_CITY,l.MAIL_STATE,l.MAIL_POSTAL_CODE,l.MAIL_COUNTRY).PrepAddrLine1;			
			self.cont_prep_addr_last_line	    := Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.MAIL_ADDR1,l.MAIL_ADDR2 + ' ' + L.MAIL_ADDR3,l.MAIL_CITY,l.MAIL_STATE,l.MAIL_POSTAL_CODE,l.MAIL_COUNTRY).PrepAddrLastLine;
			self.cont_country                 := Corp2_Mapping.fCleanCountry(state_origin,state_desc,l.MAIL_STATE,l.MAIL_COUNTRY).Country;
			self.cont_addl_info               := if(l.APPLICANT_TYPE <> '' ,'APPLICANT TYPE: ' + corp2.t2u(l.APPLICANT_TYPE) ,'');
			self.recordOrigin                 := 'T';	
			self                              := [];
	  end;
		
		MapContOwner 	    := normalize(Owner, 2, cont1Trf(left,counter));
		MapContTrademark3 := project(Trademark, cont2Trf(left));
		MapCont 	        := MapContOwner + MapContTrademark3;
    
		//---------- End CONTACTS Mapping --------------------------------------------------------------//
		
	 
		// Map AR from Filing input file
	  Corp2_Mapping.LayoutsCommon.AR arTrf(Corp2_Raw_ND.Layouts.FilingLayoutIn l):=transform
							,skip(corp2.t2u(l.SOS_CONTROL_ID) = '' or corp2.t2u(l.STANDING_AR) = '' or
							      corp2.t2u(l.FILING_TYPE) in ['TRADE NAME', 'FICTITIOUS PARTNERSHIP NAME'])
			self.corp_key					        := state_fips + '-' + corp2.t2u(l.SOS_CONTROL_ID);
			self.corp_vendor				      := state_fips;
			self.corp_state_origin			  := state_origin;
			self.corp_process_date			  := fileDate;
			self.corp_sos_charter_nbr		  := corp2.t2u(l.SOS_CONTROL_ID);
			self.ar_status                := corp2.t2u(l.STANDING_AR);
			self.ar_comment               := 'ANNUAL REPORT STANDING: '+ self.ar_status;
			self                          := [];
		end;   
		//---------- End AR Mapping --------------------------------------------------------------//
			
		//-----------------------------------------------------------//
		// Build the Final Mapped Files
		//-----------------------------------------------------------//
		MapMain := dedup(sort(distribute(MapCorp + MapCont,hash(corp_key)), record,local), record,local) : independent;	
		MapAR   := dedup(sort(distribute(project(Filing, arTrf(left)),hash(corp_key)), record,local), record,local) : independent;

  //--------------------------------------------------------------------	
  // Scrubs for MAIN
  //--------------------------------------------------------------------
		Main_F := MapMain;
		Main_S := Scrubs_Corp2_Mapping_ND_Main.Scrubs;        // ND scrubs module
		Main_N := Main_S.FromNone(Main_F); 										// Generate the error flags
		Main_T := Main_S.FromBits(Main_N.BitmapInfile);     	// Use the FromBits module; makes my bitmap datafile easier to get to
		Main_U := Main_S.FromExpanded(Main_N.ExpandedInFile); // Pass the expanded error flags into the Expanded module

	//Outputs reports
		Main_ErrorSummary					:= output(Main_U.SummaryStats, named('Main_ErrorSummary_ND'+filedate));
		Main_ScrubErrorReport 		:= output(choosen(Main_U.AllErrors, 1000), named('Main_ScrubErrorReport_ND'+filedate));
		Main_SomeErrorValues			:= output(choosen(Main_U.BadValues, 1000), named('Main_SomeErrorValues_ND'+filedate));
		Main_IsScrubErrors		 		:= IF(count(Main_U.AllErrors)<> 0,true,false);

		// Orbit Stats
		Main_OrbitStats						:= Main_U.OrbitStats();
		
		//Outputs files
		Main_CreateBitMaps				:= output(Main_N.BitmapInfile,,'~thor_data::corp_ND_main_scrubs_bits',overwrite,compressed);	//long term storage
		Main_TranslateBitMap			:= output(Main_T);
		
    //Submits Profile's stats to Orbit
    Main_SubmitStats          := Scrubs.OrbitProfileStatsPost310('Scrubs_Corp2_Mapping_ND_Main','ScrubsAlerts', Main_OrbitStats, version,'Corp_ND_Main').SubmitStats;
		
		Main_ScrubsWithExamples		:= Scrubs.OrbitProfileStatsPost310('Scrubs_Corp2_Mapping_ND_Main','ScrubsAlerts', Main_OrbitStats, version,'Corp_ND_Main').CompareToProfile_with_Examples;
		
		Main_ScrubsAlert					:= Main_ScrubsWithExamples(RejectWarning = 'Y');
		Main_ScrubsAttachment			:= Scrubs.fn_email_attachment(Main_ScrubsAlert);
		Main_SendEmailFile				:= FileServices.SendEmailAttachData( corp2.Email_Notification_Lists.spray
																																	 ,'Scrubs CorpMain_ND Report' //subject
																																	 ,'Scrubs CorpMain_ND Report' //body
																																	 ,(data)Main_ScrubsAttachment
																																	 ,'text/csv'
																																	 ,'CorpNDMainScrubsReport.csv'
																																	);		
	 																													
		Main_BadRecords := Main_T.ExpandedInFile(	dt_vendor_first_reported_invalid 	     <> 0 or
																							dt_vendor_last_reported_invalid 	     <> 0 or
																							dt_first_seen_invalid 			           <> 0 or
																							dt_last_seen_invalid 			             <> 0 or
																							corp_ra_dt_first_seen_invalid 		     <> 0 or
																							corp_ra_dt_last_seen_invalid 			     <> 0 or
																							corp_trademark_filing_date_invalid     <> 0 or
																							corp_key_invalid 			                 <> 0 or
																							corp_vendor_invalid 			             <> 0 or
																							corp_state_origin_invalid 			       <> 0 or
																							corp_process_date_invalid 			       <> 0 or
																							corp_orig_sos_charter_nbr_invalid      <> 0 or
																							corp_legal_name_invalid 			         <> 0 or
																							corp_filing_date_invalid               <> 0 or
																							corp_status_date_invalid               <> 0 or
																							corp_status_desc_invalid               <> 0 or
																							corp_inc_state_invalid 			           <> 0 or
																							corp_inc_date_invalid                  <> 0 or
																							corp_foreign_domestic_ind_invalid      <> 0 or
																							corp_forgn_date_invalid                <> 0 or
																							corp_for_profit_ind_invalid 			     <> 0 or
																							corp_delayed_effective_date_invalid    <> 0 or
																							corp_term_exist_exp_invalid 			     <> 0 or  
																							corp_trademark_expiration_date_invalid <> 0 or
																							recordorigin_invalid                   <> 0 or
																							corp_ln_name_type_cd_invalid           <> 0 or
																							corp_ln_name_type_desc_invalid         <> 0 );


		Main_GoodRecords	:= Main_T.ExpandedInFile( dt_vendor_first_reported_invalid 	     = 0 and
																								dt_vendor_last_reported_invalid 	     = 0 and
																								dt_first_seen_invalid 			           = 0 and
																								dt_last_seen_invalid 			             = 0 and
																								corp_ra_dt_first_seen_invalid 		     = 0 and
																								corp_ra_dt_last_seen_invalid 			     = 0 and
																								corp_trademark_filing_date_invalid     = 0 and
																								corp_key_invalid 			                 = 0 and
																								corp_vendor_invalid 			             = 0 and
																								corp_state_origin_invalid 			       = 0 and
																								corp_process_date_invalid 			       = 0 and
																								corp_orig_sos_charter_nbr_invalid      = 0 and
																								corp_legal_name_invalid 			         = 0 and
																								corp_filing_date_invalid               = 0 and
																								corp_status_date_invalid               = 0 and
																								corp_status_desc_invalid               = 0 and
																								corp_inc_state_invalid 			           = 0 and
																								corp_inc_date_invalid                  = 0 and
																								corp_foreign_domestic_ind_invalid      = 0 and
																								corp_forgn_date_invalid                = 0 and
																								corp_for_profit_ind_invalid 			     = 0 and
																								corp_delayed_effective_date_invalid    = 0 and
																							  corp_term_exist_exp_invalid 			     = 0 and  
																							  corp_trademark_expiration_date_invalid = 0 and
																								recordorigin_invalid                   = 0 and
																								corp_ln_name_type_cd_invalid           = 0 and
																								corp_ln_name_type_desc_invalid         = 0 );																														 																	
																																																																						
		Main_FailBuild	:= map(corp2_mapping.fCalcPercent(count(Main_N.ExpandedInFile(corp_orig_sos_charter_nbr_invalid<>0)),count(Main_N.ExpandedInFile),false) > Scrubs_Corp2_Mapping_ND_Main.Threshold_Percent.CORP_ORIG_SOS_CHARTER_NBR => true,
													 corp2_mapping.fCalcPercent(count(Main_N.ExpandedInFile(corp_legal_name_invalid<>0)),					 count(Main_N.ExpandedInFile),false) > Scrubs_Corp2_Mapping_ND_Main.Threshold_Percent.CORP_LEGAL_NAME 					=> true,
													 corp2_mapping.fCalcPercent(count(Main_N.ExpandedInFile(corp_key_invalid<>0)),						     count(Main_N.ExpandedInFile),false) > Scrubs_Corp2_Mapping_ND_Main.Threshold_Percent.CORP_KEY 					 	      => true,
													 count(Main_GoodRecords) = 0																																																																																				          => true,
													 false );

		Main_ApprovedRecords := project(Main_GoodRecords,transform(Corp2_Mapping.LayoutsCommon.Main,self := left));
			
		Main_ALL		 						:= sequential( IF(count(Main_BadRecords) <> 0
																										,IF (poverwrite
																												,OUTPUT(Main_BadRecords,,Corp2_Mapping._Dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::main_'+state_origin,overwrite,__compressed__)
																												,OUTPUT(Main_BadRecords,,Corp2_Mapping._Dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::main_'+state_origin,__compressed__)
																												)
																							)
																					,output(Main_ScrubsWithExamples, all, named('CorpMainNDScrubsReportWithExamples'+filedate))
																					//Send Alerts if Scrubs exceeds thresholds
																					,IF(COUNT(Main_ScrubsAlert) > 0, Main_SendEmailFile, OUTPUT('CORP2_MAPPING.ND - No "MAIN" Corp Scrubs Alerts'))
																					,Main_ErrorSummary
																					,Main_ScrubErrorReport
																					,Main_SomeErrorValues
																					,Main_SubmitStats
																				);																	
																		
		//-------------------- Version Control -----------------------------------------------------//	
	  VersionControl.macBuildNewLogicalFile('~thor_data400::in::corp2::'+version+'::main_ND'	,Main_ApprovedRecords,main_out ,,,pOverwrite);		
    VersionControl.macBuildNewLogicalFile('~thor_data400::in::corp2::'+version+'::ar_ND'		,MapAR	 ,ar_out,,,pOverwrite);
	
	  VersionControl.macBuildNewLogicalFile('~thor_data400::failed::corp2::'+version+'::main_ND',MapMain     ,write_fail_main	,,,pOverwrite);		
			
	  mapND:= sequential(if(pshouldspray = true,Corp2_mapping.fSprayFiles(state_origin ,version,pOverwrite := pOverwrite))
												,main_out
												,ar_out
												,IF(Main_FailBuild <> true  
														,sequential( fileservices.addsuperfile(Corp2_Mapping._Dataset().thor_cluster_Files + 'in::'+Corp2_Mapping._Dataset().NameMapped+'::sprayed::ar',Corp2_Mapping._Dataset().thor_cluster_Files + 'in::corp2::'+version+'::ar_ND')
																				,fileservices.addsuperfile(Corp2_Mapping._Dataset().thor_cluster_Files + 'in::'+Corp2_Mapping._Dataset().NameMapped+'::sprayed::main'	,Corp2_Mapping._Dataset().thor_cluster_Files + 'in::corp2::'+version+'::main_ND')																		 
																				,if (count(Main_BadRecords) <> 0 
																						 ,Corp2_Mapping.Send_Email(state_origin ,version,count(Main_BadRecords)<>0,,,,count(Main_BadRecords),,,,count(Main_ApprovedRecords),count(mapAR)).RecordsRejected																				 
																						 ,Corp2_Mapping.Send_Email(state_origin ,version,count(Main_BadRecords)<>0,,,,count(Main_BadRecords),,,,count(Main_ApprovedRecords),count(mapAR)).MappingSuccess	
																						 )	 
																			)
														 ,sequential( write_fail_main//if it fails on  main file threshold ,still writing mapped files!
																				 ,Corp2_Mapping.Send_Email(state_origin ,version).MappingFailed
																				)
													)
												,IF(Main_IsScrubErrors
													 ,Corp2_Mapping.Send_Email(state_origin ,version,Main_IsScrubErrors).FieldsInvalidPerScrubs)	
												,Main_All	
										);
		// File is not always received within exactly one month, so setting the file date check to allow for 35 days													
 		isFileDateValid := if((string)Std.Date.Today() between ut.date_math(filedate,-35) and ut.date_math(filedate,35),true,false);
    return sequential (if (isFileDateValid
														,mapND
														,sequential (Corp2_Mapping.Send_Email(state_origin,filedate).InvalidFileDateParm
																				,FAIL('Corp2_Mapping.ND failed.  An invalid filedate was passed in as a parameter.')))); 	

 End; //Update Function

End;//End ND Module
