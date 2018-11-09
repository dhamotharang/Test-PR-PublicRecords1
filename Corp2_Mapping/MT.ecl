import _control,lib_stringlib,corp2,corp2_mapping,corp2_raw_mt,scrubs, scrubs_corp2_mapping_mt_main,tools,ut,versioncontrol,std;

Export MT := module;  
	
	Export Update(string fileDate, string version, boolean pShouldSpray = _Dataset().bShouldSpray, boolean pOverwrite = false, pUseProd = Tools._Constants.IsDataland) := Function

		state_origin			:= 'MT';
		state_fips	 			:= '30';
		state_desc	 			:= 'MONTANA';
		
		
		Bad_RA_Names      := ['REVOKED-SOS-RULE 4-MONT.R.CIV.P','RESIGNATION OF AGENT'];
		Bad_Data          := ['NOT ENTERED','NONE STATED'];
		//TM pattern replacement				
		TM_pRplc := '([0-9][0-9A-Z]{1,2})(\\s-\\s[A-Z0-9\\s;&-]+[\\.,]*)';  
		
		//********************************************************************
		// Vendor Input Files 
		//********************************************************************
		ds_ABN                 := dedup(sort(distribute(Corp2_Raw_MT.Files(fileDate,puseprod).Input.ABN_Entity,    hash(BusinessEntityNumber)),record,local),record,local): independent;
		ds_BECORP              := dedup(sort(distribute(Corp2_Raw_MT.Files(fileDate,puseprod).Input.BECORP_Entity, hash(BusinessEntityNumber)),record,local),record,local): independent;
		ds_BELLC               := dedup(sort(distribute(Corp2_Raw_MT.Files(fileDate,puseprod).Input.BELLC_Entity,  hash(BusinessEntityNumber)),record,local),record,local): independent;
		ds_BELP                := dedup(sort(distribute(Corp2_Raw_MT.Files(fileDate,puseprod).Input.BELP_Entity,   hash(BusinessEntityNumber)),record,local),record,local): independent;
		ds_BELLP               := dedup(sort(distribute(Corp2_Raw_MT.Files(fileDate,puseprod).Input.BELLP_Entity,  hash(BusinessEntityNumber)),record,local),record,local): independent;
		ds_TM                  := dedup(sort(distribute(Corp2_Raw_MT.Files(fileDate,puseprod).Input.TM_Entity,     hash(BusinessEntityNumber)),record,local),record,local): independent;
		ds_FBN                 := dedup(sort(distribute(Corp2_Raw_MT.Files(fileDate,puseprod).Input.FBN_Entity,    hash(BusinessEntityNumber)),record,local),record,local): independent;
		ds_RelatedABN			     := dedup(sort(distribute(Corp2_Raw_MT.Files(fileDate,puseprod).Input.RelatedABN,    hash(BusinessEntityNumber)),record,local),record,local): independent;
		ds_RelatedTM           := dedup(sort(distribute(Corp2_Raw_MT.Files(fileDate,puseprod).Input.RelatedTM,     hash(BusinessEntityNumber)),record,local),record,local): independent;
				
		ds_Agent               := dedup(sort(distribute(Corp2_Raw_MT.Files(fileDate,puseprod).Input.Agent(corp2.t2u(RegisteredAgentNameOrEntityName) NOT IN Bad_RA_Names),  hash(BusinessEntityNumber)),record,local),record,local): independent;
		ds_Principal           := dedup(sort(distribute(Corp2_Raw_MT.Files(fileDate,puseprod).Input.Principal(corp2.t2u(PrincipalNameOrEntityName) <> 'NOT ENTERED'),       hash(BusinessEntityNumber)),record,local),record,local): independent;
		ds_Partner             := dedup(sort(distribute(Corp2_Raw_MT.Files(fileDate,puseprod).Input.Partner,   hash(BusinessEntityNumber)),record,local),record,local): independent;
		ds_Owner               := dedup(sort(distribute(Corp2_Raw_MT.Files(fileDate,puseprod).Input.Owner,     hash(BusinessEntityNumber)),record,local),record,local): independent;
		ds_Member              := dedup(sort(distribute(Corp2_Raw_MT.Files(fileDate,puseprod).Input.Member,    hash(BusinessEntityNumber)),record,local),record,local): independent;
		ds_Shares              := dedup(sort(distribute(Corp2_Raw_MT.Files(fileDate,puseprod).Input.Shares,    hash(BusinessEntityNumber)),record,local),record,local): independent;


    //********************************************************************
		// Normalize Registered Agent Addresses
		//********************************************************************
    Corp2_Raw_MT.Layouts.TempNormAgentLayoutIn normRAAddr(Corp2_Raw_MT.Layouts.FileAgentLayoutIn l, unsigned1 cnt) := transform
         ,skip(cnt=2 and corp2.t2u(l.AgentBusinessMailingPostalAddress1 + l.AgentBusinessMailingPostalAddress2 + l.AgentBusinessMailingPostalAddress3 + l.AgentBusinessMailingPostalAddress4 + l.AgentBusinessMailingPostalAddress5 + l.AgentBusinessMailingPostalAddress6) = '')				
		  	self.BusinessEntityNumber                  := corp2.t2u(l.BusinessEntityNumber);
				self.RegisteredAgentNameOrEntityName       := corp2.t2u(l.RegisteredAgentNameOrEntityName);
				self.AgentAddressTypeCode                  := choose(cnt ,'R'                ,'M');
				self.AgentAddressTypeDesc                  := choose(cnt ,'REGISTERED OFFICE','REGISTERED MAILING ADDRESS');
				self.AgentBusinessMailingAddress1          := choose(cnt ,l.AgentBusinessMailingPhysicalAddress1     ,l.AgentBusinessMailingPostalAddress1);
				self.AgentBusinessMailingAddress2          := choose(cnt ,l.AgentBusinessMailingPhysicalAddress2     ,l.AgentBusinessMailingPostalAddress2);
				self.AgentBusinessMailingAddress3          := choose(cnt ,l.AgentBusinessMailingPhysicalAddress3     ,l.AgentBusinessMailingPostalAddress3);
				self.AgentBusinessMailingCity              := choose(cnt ,l.AgentBusinessMailingPhysicalAddress4     ,l.AgentBusinessMailingPostalAddress4);    
				self.AgentBusinessMailingState             := choose(cnt ,l.AgentBusinessMailingPhysicalAddress5     ,l.AgentBusinessMailingPostalAddress5);    
				self.AgentBusinessMailingZipCode           := choose(cnt ,l.AgentBusinessMailingPhysicalAddress6     ,l.AgentBusinessMailingPostalAddress6); 
				self.AgentBusinessMailingCountry           := choose(cnt ,l.AgentBusinessMailingPhysicalAddress7     ,l.AgentBusinessMailingPostalAddress7); 
				self 						                           := l;
		end;

			NormRA	:= normalize(ds_Agent, 2, normRAAddr(left, counter),local);
			
		//********************************************************************
		// Perform Joins to create file that Corporations will be mapped from
		//********************************************************************
		//********************************************************************
		// Joining the BE-CORP file with the AGENTS and PRINCIPAL files
		//********************************************************************
    join_crpAgent := JOIN(ds_BECORP ,NormRA,
												   corp2.t2u(LEFT.BusinessEntityNumber) = corp2.t2u(RIGHT.BusinessEntityNumber),
													 TRANSFORM(Corp2_Raw_MT.Layouts.TempCorpLayoutIn,
																		 SELF := LEFT;
																		 SELF := RIGHT;
																		 SELF := [];
																		 ),
													 LEFT OUTER,LOCAL) : INDEPENDENT;
		
		 join_CrpAgABN := JOIN(join_crpAgent ,ds_RelatedABN,
														corp2.t2u(LEFT.BusinessEntityNumber)   = corp2.t2u(RIGHT.BusinessEntityNumber),
														TRANSFORM(Corp2_Raw_MT.Layouts.TempCorpLayoutIn,
																			SELF.RelatedABNId    := RIGHT.RelatedABNId;
																			SELF                 := LEFT;
																			SELF                 := [];
																			),
														LEFT OUTER,LOCAL) : INDEPENDENT;			
																							
		 join_CrpAgABNTM := JOIN(join_CrpAgABN ,ds_RelatedTM,
															corp2.t2u(LEFT.BusinessEntityNumber)   = corp2.t2u(RIGHT.BusinessEntityNumber),
															TRANSFORM(Corp2_Raw_MT.Layouts.TempCorpLayoutIn,
																				SELF.RelatedTMId   := RIGHT.RelatedTrademarkId;
																				SELF               := LEFT;
																				SELF               := [];
																				),
															LEFT OUTER,LOCAL) : INDEPENDENT;																			 
																	 
     Corp2_Raw_MT.Layouts.TempNormCorpLayoutIn NormCorpFiling(Corp2_Raw_MT.Layouts.TempCorpLayoutIn l, unsigned1 cnt) := transform
		    ,skip(cnt=2 and corp2.t2u(l.ReviverReinstatementDate) = '')
		 		self.temp_filing_date   := choose(cnt ,if(corp2.t2u(l.StateorCountryOfJurisdiction) not in [state_desc,state_origin,''],l.IncorporationDate,''),l.ReviverReinstatementDate);
				self.temp_filing_desc   := choose(cnt ,if(corp2.t2u(l.StateorCountryOfJurisdiction) not in [state_desc,state_origin,''],'HOME STATE REGISTRATION DATE',''),'REINSTATEMENT DATE');
				self                    := l;
		 end;
		 
		 NormCorpFileDate := normalize(join_CrpAgABNTM, 2, NormCorpFiling(left, counter),local);
		 
	
		 //********************************************************************
		 // Joining the BE-LLC file with the AGENTS file
		 //********************************************************************
		 join_LLCAgent := JOIN(ds_BELLC ,NormRA,
													 corp2.t2u(LEFT.BusinessEntityNumber)   = corp2.t2u(RIGHT.BusinessEntityNumber),
													 TRANSFORM(Corp2_Raw_MT.Layouts.TempLLCLayoutIn,
														  			 SELF := LEFT;
																		 SELF := RIGHT;
																		 SELF := [];
																		 ),
													 LEFT OUTER,LOCAL) : INDEPENDENT;
																	 
			join_LLCAgABN := JOIN(join_LLCAgent ,ds_RelatedABN,
															 corp2.t2u(LEFT.BusinessEntityNumber)   = corp2.t2u(RIGHT.BusinessEntityNumber),
															 TRANSFORM(Corp2_Raw_MT.Layouts.TempLLCLayoutIn,
																				 SELF.RelatedABNId    := RIGHT.RelatedABNId;
																				 SELF                 := LEFT;
																				 SELF                 := [];
																				 ),
															 LEFT OUTER,LOCAL) : INDEPENDENT;			
																								
			join_LLCAgABNTM := JOIN(join_LLCAgABN ,ds_RelatedTM,
																 corp2.t2u(LEFT.BusinessEntityNumber)   = corp2.t2u(RIGHT.BusinessEntityNumber),
																 TRANSFORM(Corp2_Raw_MT.Layouts.TempLLCLayoutIn,
																	 				 SELF.RelatedTMId   := RIGHT.RelatedTrademarkId;
																					 SELF               := LEFT;
																					 SELF               := [];
																					 ),
																 LEFT OUTER,LOCAL) : INDEPENDENT;		
																						
			 Corp2_Raw_MT.Layouts.TempNormLLCLayoutIn NormLLCFiling(Corp2_Raw_MT.Layouts.TempLLCLayoutIn l, unsigned1 cnt) := transform
					,skip(cnt=2 and corp2.t2u(l.ReviverReinstatementDate) = '')
					self.temp_filing_date   := choose(cnt ,if(corp2.t2u(l.StateorCountryOfJurisdiction) not in [state_desc,state_origin,''],l.OrganizationDate,''),l.ReviverReinstatementDate);
				  self.temp_filing_desc   := choose(cnt ,if(corp2.t2u(l.StateorCountryOfJurisdiction) not in [state_desc,state_origin,''],'HOME STATE REGISTRATION DATE',''),'REINSTATEMENT DATE');
					self                    := l;
			 end;
			 
			 NormLLCFileDate := normalize(join_LLCAgABNTM, 2, NormLLCFiling(left, counter),local);									 
												 
			//********************************************************************
			// Joining the BE-LP file with the AGENTS 
			//********************************************************************
      join_LPAgent := JOIN(ds_BELP ,NormRA,
													 corp2.t2u(LEFT.BusinessEntityNumber)   = corp2.t2u(RIGHT.BusinessEntityNumber),
													 TRANSFORM(Corp2_Raw_MT.Layouts.TempLPLayoutIn,
																		 SELF := LEFT;
																		 SELF := RIGHT;
																		 SELF := [];
																		 ),
													 LEFT OUTER,LOCAL) : INDEPENDENT;
			
			Corp2_Raw_MT.Layouts.TempNormLPLayoutIn NormLPFiling(Corp2_Raw_MT.Layouts.TempLPLayoutIn l, unsigned1 cnt) := transform
					,skip((cnt=2 and corp2.t2u(l.RenewalExpirationDate) = '') OR (cnt=3 and corp2.t2u(l.ExpirationNoticeDate) = ''))
					self.temp_filing_date   := choose(cnt ,if(corp2.t2u(l.StateorCountryOfJurisdiction) not in [state_desc,state_origin,''],l.FormationDate,'') ,l.RenewalExpirationDate,l.ExpirationNoticeDate);
				  self.temp_filing_desc   := choose(cnt ,if(corp2.t2u(l.StateorCountryOfJurisdiction) not in [state_desc,state_origin,''],'HOME STATE REGISTRATION DATE',''),'RENEWAL EXPIRATION DATE','EXPIRATION NOTICE DATE');
					self                    := l;
			 end;
			 
		  NormLPFileDate := normalize(join_LPAgent, 3, NormLPFiling(left, counter),local);			


		//********************************************************************
		// MAIN Corporations mapping
		//********************************************************************	
		//--------------------BE-CORP-----------------------//
		corp2_mapping.LayoutsCommon.Main CorpTransform(Corp2_Raw_MT.Layouts.TempNormCorpLayoutIn l, unsigned1 cnt) := transform		
				self.dt_vendor_first_reported								:= (unsigned4)fileDate;
				self.dt_vendor_last_reported								:= (unsigned4)fileDate;
				self.dt_first_seen													:= (unsigned4)fileDate;
				self.dt_last_seen														:= (unsigned4)fileDate;
				self.corp_ra_dt_first_seen									:= (unsigned4)fileDate;
				self.corp_ra_dt_last_seen										:= (unsigned4)fileDate;			
				self.corp_key																:= state_fips + '-' + corp2.t2u(l.BusinessEntityNumber);
				self.corp_vendor														:= state_fips;
				self.corp_state_origin											:= state_origin;			
				self.corp_process_date											:= fileDate;
				self.corp_orig_sos_charter_nbr							:= corp2.t2u(l.BusinessEntityNumber);									  									
				self.corp_legal_name                				:= corp2_mapping.fCleanBusinessName(state_origin,state_desc,l.BusinessEntityName).BusinessName;
				self.corp_ln_name_type_cd           				:= '01'; 
				self.corp_ln_name_type_desc								  := 'LEGAL'; 
				self.corp_address1_type_cd          				:= if(corp2.t2u(l.BusinessMailingAddress1) <> 'NOT ENTERED' and corp2_mapping.faddressexists(state_origin,state_desc,l.BusinessMailingAddress1,,l.BusinessMailingAddress4,l.BusinessMailingAddress5,l.BusinessMailingAddress6,l.BusinessMailingAddress7).ifaddressexists,'M','');
				self.corp_address1_type_desc          			:= if(corp2.t2u(l.BusinessMailingAddress1) <> 'NOT ENTERED' and corp2_mapping.faddressexists(state_origin,state_desc,l.BusinessMailingAddress1,,l.BusinessMailingAddress4,l.BusinessMailingAddress5,l.BusinessMailingAddress6,l.BusinessMailingAddress7).ifaddressexists,'MAILING','');
				self.corp_address1_line1            				:= if(corp2.t2u(l.BusinessMailingAddress1) <> 'NOT ENTERED',corp2_mapping.fcleanaddress(state_origin,state_desc,l.BusinessMailingAddress1,,l.BusinessMailingAddress4,l.BusinessMailingAddress5,l.BusinessMailingAddress6,l.BusinessMailingAddress7).AddressLine1,'');
				self.corp_address1_line2            				:= if(corp2.t2u(l.BusinessMailingAddress1) <> 'NOT ENTERED',corp2_mapping.fcleanaddress(state_origin,state_desc,l.BusinessMailingAddress1,,l.BusinessMailingAddress4,l.BusinessMailingAddress5,l.BusinessMailingAddress6,l.BusinessMailingAddress7).AddressLine2,'');
				self.corp_address1_line3            				:= if(corp2.t2u(l.BusinessMailingAddress1) <> 'NOT ENTERED',corp2_mapping.fcleanaddress(state_origin,state_desc,l.BusinessMailingAddress1,,l.BusinessMailingAddress4,l.BusinessMailingAddress5,l.BusinessMailingAddress6,l.BusinessMailingAddress7).AddressLine3,'');
				self.corp_prep_addr1_line1            		 	:= if(corp2.t2u(l.BusinessMailingAddress1) <> 'NOT ENTERED',corp2_mapping.fcleanaddress(state_origin,state_desc,l.BusinessMailingAddress1,,l.BusinessMailingAddress4,l.BusinessMailingAddress5,l.BusinessMailingAddress6,l.BusinessMailingAddress7).PrepAddrLine1,'');
				self.corp_prep_addr1_last_line          	 	:= if(corp2.t2u(l.BusinessMailingAddress1) <> 'NOT ENTERED',corp2_mapping.fcleanaddress(state_origin,state_desc,l.BusinessMailingAddress1,,l.BusinessMailingAddress4,l.BusinessMailingAddress5,l.BusinessMailingAddress6,l.BusinessMailingAddress7).PrepAddrLastLine,'');
				self.corp_inc_date                          := if(corp2.t2u(l.StateOrCountryOfJurisdiction) in [state_desc,state_origin,''],corp2_mapping.fvalidatedate(l.IncorporationDate).PastDate,'');
				self.corp_forgn_date                        := if(corp2.t2u(l.StateOrCountryOfJurisdiction) not in [state_desc,state_origin,''],corp2_mapping.fvalidatedate(l.QualificationDate).PastDate,'');
				self.corp_filing_date                       := corp2_mapping.fvalidatedate(l.temp_filing_date).PastDate;
				self.corp_filing_desc               			 	:= corp2.t2u(l.temp_filing_desc);
				self.corp_foreign_domestic_ind						 	:= corp2_raw_mt.functions.CorpForgnDomesticInd(l.BusinessEntityType);
				self.corp_forgn_state_cd            			 	:= if(corp2.t2u(l.StateorCountryOfJurisdiction) not in [state_desc,state_origin,''] ,corp2_raw_mt.functions.StateJurisdictionCode(l.StateorCountryOfJurisdiction) ,'');
				self.corp_forgn_state_desc          			 	:= if(self.corp_forgn_state_cd <> '', corp2.t2u(l.StateorCountryOfJurisdiction), '');			
				self.corp_status_desc												:= corp2.t2u(l.EntityStatusDescription);
				self.corp_status_date                       := corp2_mapping.fvalidatedate(l.InactiveDate).GeneralDate;
				self.corp_standing                  				:= if(corp2.t2u(l.EntityStatusDescription) = 'ACTIVE GOOD STANDING','Y','');
				self.corp_status_comment            				:= if(corp2.t2u(l.EntityStatusDescription[1..8]) = 'INACTIVE' ,ut.fn_RemoveSpecialChars(corp2.t2u(l.InactiveReason)) ,'');
				self.corp_inc_state                 			 	:= state_origin;
				self.corp_term_exist_exp            		 	 	:= choose(cnt,if(corp2.t2u(l.TermOfExistence) = 'PERPETUAL','',corp2_mapping.fvalidatedate(l.ExpirationDate).GeneralDate),
				                                                      corp2_mapping.fvalidatedate(l.ExpirationDate).GeneralDate);
				self.corp_term_exist_cd             			 	:= choose(cnt,if(corp2.t2u(l.TermOfExistence) = 'PERPETUAL','P','D'),if(corp2.t2u(l.TermOfExistence) = 'FUTURE DATE','F',''));
				self.corp_term_exist_desc           			 	:= map(self.corp_term_exist_cd    = 'P'  => 'PERPETUAL',
				                                                   self.corp_term_exist_cd    = 'F'  => 'FUTURE DATE',
				                                                   self.corp_term_exist_cd    = 'D'  => 'EXPIRATION DATE',
																													 '');				
				self.corp_orig_org_structure_desc   				:= corp2.t2u(l.BusinessEntityType);
				self.corp_orig_bus_type_desc        			 	:= corp2.t2u(l.BusinessEntitySubType);  
			  self.corp_for_profit_ind                    := map(corp2.t2u(l.BusinessEntityType) in ['DOMESTIC NON PROFIT CORPORATION','FOREIGN NONPROFIT CORPORATION']  => 'N',
				                                                   corp2.t2u(l.BusinessEntityType) in ['DOMESTIC PROFIT CORPORATION','FOREIGN PROFIT CORPORATION']         => 'Y',
																													 '');
				self.corp_ra_full_name               				:= corp2_mapping.fCleanBusinessName(state_origin,state_desc,l.RegisteredAgentNameOrEntityName).BusinessName;
				self.corp_ra_address_type_cd        				:= corp2.t2u(l.AgentAddressTypeCode);
				self.corp_ra_address_type_desc      				:= corp2.t2u(l.AgentAddressTypeDesc);
				self.corp_ra_address_line1		      				:= if(self.corp_ra_address_type_cd <> '',corp2_mapping.fcleanaddress(state_origin,state_desc,l.AgentBusinessMailingAddress1,l.AgentBusinessMailingAddress2 + ' ' + l.AgentBusinessMailingAddress3,l.AgentBusinessMailingCity,l.AgentBusinessMailingState,l.AgentBusinessMailingZipCode).AddressLine1,'');
				self.corp_ra_address_line2		      				:= if(self.corp_ra_address_type_cd <> '',corp2_mapping.fcleanaddress(state_origin,state_desc,l.AgentBusinessMailingAddress1,l.AgentBusinessMailingAddress2 + ' ' + l.AgentBusinessMailingAddress3,l.AgentBusinessMailingCity,l.AgentBusinessMailingState,l.AgentBusinessMailingZipCode).AddressLine2,'');
				self.corp_ra_address_line3		      				:= if(self.corp_ra_address_type_cd <> '',corp2_mapping.fcleanaddress(state_origin,state_desc,l.AgentBusinessMailingAddress1,l.AgentBusinessMailingAddress2 + ' ' + l.AgentBusinessMailingAddress3,l.AgentBusinessMailingCity,l.AgentBusinessMailingState,l.AgentBusinessMailingZipCode).AddressLine3,'');															
				self.ra_prep_addr_line1         					  := if(self.corp_ra_address_type_cd <> '',corp2_mapping.fcleanaddress(state_origin,state_desc,l.AgentBusinessMailingAddress1,l.AgentBusinessMailingAddress2 + ' ' + l.AgentBusinessMailingAddress3,l.AgentBusinessMailingCity,l.AgentBusinessMailingState,l.AgentBusinessMailingZipCode).PrepAddrLine1,'');
				self.ra_prep_addr_last_line      					  := if(self.corp_ra_address_type_cd <> '',corp2_mapping.fcleanaddress(state_origin,state_desc,l.AgentBusinessMailingAddress1,l.AgentBusinessMailingAddress2 + ' ' + l.AgentBusinessMailingAddress3,l.AgentBusinessMailingCity,l.AgentBusinessMailingState,l.AgentBusinessMailingZipCode).PrepAddrLastLine,'');
 				self.corp_purpose														:= if(corp2.t2u(l.purpose) not in Bad_Data, corp2.t2u(l.purpose),''); ;  
				// Note: corp_purpose are new, not a displayable field so this field will also go into corp_entity_desc like in the old mapper
				self.corp_entity_desc               				:= if(corp2.t2u(l.purpose) not in Bad_Data, corp2.t2u(l.purpose),'');
				self.corp_country_of_formation              := corp2.t2u(l.BusinessMailingAddress7);
				self.corp_filing_reference_nbr              := corp2.t2u(l.RelatedABNId);
				self.corp_internal_nbr                      := corp2.t2u(l.RelatedTMId);
				self.recordorigin													  := 'C';
				self																			  := l;
				self 																			  := [];
		end;
		
		MapBECorp := normalize(NormCorpFileDate, if(corp2.t2u(left.ExpirationDate) = '',1,2), CorpTransform(left, counter),local);
		
		//----------------------------BE-LLC-----------------------------
		corp2_mapping.LayoutsCommon.Main LLCTransform(Corp2_Raw_MT.Layouts.TempNormLLCLayoutIn l, unsigned1 cnt) := transform		
				self.dt_vendor_first_reported								:= (unsigned4)fileDate;
				self.dt_vendor_last_reported								:= (unsigned4)fileDate;
				self.dt_first_seen													:= (unsigned4)fileDate;
				self.dt_last_seen														:= (unsigned4)fileDate;
				self.corp_ra_dt_first_seen									:= (unsigned4)fileDate;
				self.corp_ra_dt_last_seen										:= (unsigned4)fileDate;			
        self.corp_key																:= state_fips + '-' + corp2.t2u(l.BusinessEntityNumber);
				self.corp_vendor														:= state_fips;
				self.corp_state_origin											:= state_origin;			
				self.corp_process_date											:= fileDate;
				self.corp_orig_sos_charter_nbr							:= corp2.t2u(l.BusinessEntityNumber);									  									
				self.corp_legal_name                				:= corp2_mapping.fCleanBusinessName(state_origin,state_desc,l.BusinessEntityName).BusinessName;
				self.corp_ln_name_type_cd           				:= '01'; 
				self.corp_ln_name_type_desc								  := 'LEGAL'; 
				self.corp_address1_type_cd          				:= if(corp2.t2u(l.BusinessMailingAddress1) <> 'NOT ENTERED' and corp2_mapping.faddressexists(state_origin,state_desc,l.BusinessMailingAddress1,,l.BusinessMailingAddress4,l.BusinessMailingAddress5,l.BusinessMailingAddress6,l.BusinessMailingAddress7).ifaddressexists,'M','');
				self.corp_address1_type_desc          			:= if(corp2.t2u(l.BusinessMailingAddress1) <> 'NOT ENTERED' and corp2_mapping.faddressexists(state_origin,state_desc,l.BusinessMailingAddress1,,l.BusinessMailingAddress4,l.BusinessMailingAddress5,l.BusinessMailingAddress6,l.BusinessMailingAddress7).ifaddressexists,'MAILING','');
				self.corp_address1_line1            				:= if(corp2.t2u(l.BusinessMailingAddress1) <> 'NOT ENTERED',corp2_mapping.fcleanaddress(state_origin,state_desc,l.BusinessMailingAddress1,,l.BusinessMailingAddress4,l.BusinessMailingAddress5,l.BusinessMailingAddress6,l.BusinessMailingAddress7).AddressLine1,'');
				self.corp_address1_line2            				:= if(corp2.t2u(l.BusinessMailingAddress1) <> 'NOT ENTERED',corp2_mapping.fcleanaddress(state_origin,state_desc,l.BusinessMailingAddress1,,l.BusinessMailingAddress4,l.BusinessMailingAddress5,l.BusinessMailingAddress6,l.BusinessMailingAddress7).AddressLine2,'');
				self.corp_address1_line3            				:= if(corp2.t2u(l.BusinessMailingAddress1) <> 'NOT ENTERED',corp2_mapping.fcleanaddress(state_origin,state_desc,l.BusinessMailingAddress1,,l.BusinessMailingAddress4,l.BusinessMailingAddress5,l.BusinessMailingAddress6,l.BusinessMailingAddress7).AddressLine3,'');
				self.corp_prep_addr1_line1            		 	:= if(corp2.t2u(l.BusinessMailingAddress1) <> 'NOT ENTERED',corp2_mapping.fcleanaddress(state_origin,state_desc,l.BusinessMailingAddress1,,l.BusinessMailingAddress4,l.BusinessMailingAddress5,l.BusinessMailingAddress6,l.BusinessMailingAddress7).PrepAddrLine1,'');
				self.corp_prep_addr1_last_line          	 	:= if(corp2.t2u(l.BusinessMailingAddress1) <> 'NOT ENTERED',corp2_mapping.fcleanaddress(state_origin,state_desc,l.BusinessMailingAddress1,,l.BusinessMailingAddress4,l.BusinessMailingAddress5,l.BusinessMailingAddress6,l.BusinessMailingAddress7).PrepAddrLastLine,'');
				self.corp_inc_date                          := if(corp2.t2u(l.StateorCountryOfJurisdiction) in [state_desc,state_origin,''],corp2_mapping.fvalidatedate(l.OrganizationDate).PastDate,'');
				self.corp_forgn_date                        := if(corp2.t2u(l.StateorCountryOfJurisdiction) not in [state_desc,state_origin,''],corp2_mapping.fvalidatedate(l.QualificationOfAForeignLLCInMontana).PastDate,'');
				self.corp_filing_date                       := corp2_mapping.fvalidatedate(l.temp_filing_date).PastDate;
				self.corp_filing_desc               			 	:= corp2.t2u(l.temp_filing_desc);
				self.corp_foreign_domestic_ind						 	:= corp2_raw_mt.functions.CorpForgnDomesticInd(l.BusinessEntityType);
				self.corp_forgn_state_cd            			 	:= if(corp2.t2u(l.StateorCountryOfJurisdiction) not in [state_desc,state_origin,''] ,corp2_raw_mt.functions.StateJurisdictionCode(l.StateorCountryOfJurisdiction) ,'');
				self.corp_forgn_state_desc          			 	:= if(self.corp_forgn_state_cd <> '', corp2.t2u(l.StateorCountryOfJurisdiction), '');			
				self.corp_status_desc												:= corp2.t2u(l.EntityStatusDescription);
				self.corp_status_date                       := corp2_mapping.fvalidatedate(l.InactiveDate).GeneralDate;
				self.corp_standing                  				:= if(corp2.t2u(l.EntityStatusDescription) = 'ACTIVE GOOD STANDING','Y','');
				self.corp_status_comment            				:= if(corp2.t2u(l.EntityStatusDescription[1..8]) = 'INACTIVE' ,ut.fn_RemoveSpecialChars(corp2.t2u(l.EntityStatusChangeReason)) ,'');
				self.corp_inc_state                 			 	:= state_origin;
				self.corp_term_exist_exp            		 	 	:= choose(cnt,if(corp2.t2u(l.TermOfExistence) = 'PERPETUAL','',corp2_mapping.fvalidatedate(l.ExpirationDate).GeneralDate),
				                                                      corp2_mapping.fvalidatedate(l.ExpirationDate).GeneralDate);
				self.corp_term_exist_cd             			 	:= choose(cnt,if(corp2.t2u(l.TermOfExistence) = 'PERPETUAL','P','D'),if(corp2.t2u(l.TermOfExistence) = 'FUTURE DATE','F',''));
				self.corp_term_exist_desc           			 	:= map(self.corp_term_exist_cd  = 'P'   => 'PERPETUAL',
 																													 self.corp_term_exist_cd  = 'F'   => 'FUTURE DATE',
				                                                   self.corp_term_exist_cd  = 'D'   => 'EXPIRATION DATE',
																													 '');				
				self.corp_orig_org_structure_desc   				:= corp2.t2u(l.BusinessEntityType);
				self.corp_orig_bus_type_desc        			 	:= corp2.t2u(l.BusinessEntitySubType);  
			  self.corp_for_profit_ind                    := map(corp2.t2u(l.BusinessEntityType) in ['DOMESTIC NON PROFIT CORPORATION','FOREIGN NONPROFIT CORPORATION']  => 'N',
				                                                   corp2.t2u(l.BusinessEntityType) in ['DOMESTIC PROFIT CORPORATION','FOREIGN PROFIT CORPORATION']         => 'Y',
																													 '');
				self.corp_ra_full_name               				:= corp2_mapping.fCleanBusinessName(state_origin,state_desc,l.RegisteredAgentNameOrEntityName).BusinessName;
				self.corp_ra_address_type_cd        				:= corp2.t2u(l.AgentAddressTypeCode);
				self.corp_ra_address_type_desc      				:= corp2.t2u(l.AgentAddressTypeDesc);
				self.corp_ra_address_line1		      				:= if(self.corp_ra_address_type_cd <> '',corp2_mapping.fcleanaddress(state_origin,state_desc,l.AgentBusinessMailingAddress1,l.AgentBusinessMailingAddress2 + ' ' + l.AgentBusinessMailingAddress3,l.AgentBusinessMailingCity,l.AgentBusinessMailingState,l.AgentBusinessMailingZipCode).AddressLine1,'');
				self.corp_ra_address_line2		      				:= if(self.corp_ra_address_type_cd <> '',corp2_mapping.fcleanaddress(state_origin,state_desc,l.AgentBusinessMailingAddress1,l.AgentBusinessMailingAddress2 + ' ' + l.AgentBusinessMailingAddress3,l.AgentBusinessMailingCity,l.AgentBusinessMailingState,l.AgentBusinessMailingZipCode).AddressLine2,'');
				self.corp_ra_address_line3		      				:= if(self.corp_ra_address_type_cd <> '',corp2_mapping.fcleanaddress(state_origin,state_desc,l.AgentBusinessMailingAddress1,l.AgentBusinessMailingAddress2 + ' ' + l.AgentBusinessMailingAddress3,l.AgentBusinessMailingCity,l.AgentBusinessMailingState,l.AgentBusinessMailingZipCode).AddressLine3,'');															
				self.ra_prep_addr_line1         					  := if(self.corp_ra_address_type_cd <> '',corp2_mapping.fcleanaddress(state_origin,state_desc,l.AgentBusinessMailingAddress1,l.AgentBusinessMailingAddress2 + ' ' + l.AgentBusinessMailingAddress3,l.AgentBusinessMailingCity,l.AgentBusinessMailingState,l.AgentBusinessMailingZipCode).PrepAddrLine1,'');
				self.ra_prep_addr_last_line      					  := if(self.corp_ra_address_type_cd <> '',corp2_mapping.fcleanaddress(state_origin,state_desc,l.AgentBusinessMailingAddress1,l.AgentBusinessMailingAddress2 + ' ' + l.AgentBusinessMailingAddress3,l.AgentBusinessMailingCity,l.AgentBusinessMailingState,l.AgentBusinessMailingZipCode).PrepAddrLastLine,'');
 				self.corp_purpose														:= if(corp2.t2u(l.purpose) not in Bad_Data,corp2.t2u(l.purpose),'');  
				// Note: corp_purpose are new, not a displayable field so this field will also go into corp_entity_desc like in the old mapper
				self.corp_entity_desc               				:= if(corp2.t2u(l.purpose) not in Bad_Data,corp2.t2u(l.purpose),'') ;
				self.corp_country_of_formation              := corp2.t2u(l.BusinessMailingAddress7);
				self.corp_addl_info												 	:= corp2.t2u(l.ManagementType);
				self.corp_llc_managed_desc                  := corp2.t2u(l.ManagementType);
				self.corp_filing_reference_nbr              := corp2.t2u(l.RelatedABNId);
				self.corp_internal_nbr                      := corp2.t2u(l.RelatedTMId);
				self.recordorigin													  := 'C';
				self																			  := l;
				self 																			  := [];
		end;
		
		MapBELLC := normalize(NormLLCFileDate, if(corp2.t2u(left.ExpirationDate) = '',1,2), LLCTransform(left, counter),local);
		 
		//--------------------BE-LP-----------------------//
		corp2_mapping.LayoutsCommon.Main LPTransform(Corp2_Raw_MT.Layouts.TempNormLPLayoutIn l, unsigned1 cnt) := transform		
				self.dt_vendor_first_reported								:= (unsigned4)fileDate;
				self.dt_vendor_last_reported								:= (unsigned4)fileDate;
				self.dt_first_seen													:= (unsigned4)fileDate;
				self.dt_last_seen														:= (unsigned4)fileDate;
				self.corp_ra_dt_first_seen									:= (unsigned4)fileDate;
				self.corp_ra_dt_last_seen										:= (unsigned4)fileDate;			
				self.corp_key																:= state_fips + '-' + corp2.t2u(l.BusinessEntityNumber);
				self.corp_vendor														:= state_fips;
				self.corp_state_origin											:= state_origin;			
				self.corp_process_date											:= fileDate;
				self.corp_orig_sos_charter_nbr							:= corp2.t2u(l.BusinessEntityNumber);									  									
				self.corp_legal_name                				:= corp2_mapping.fCleanBusinessName(state_origin,state_desc,l.BusinessEntityName).BusinessName;
				self.corp_ln_name_type_cd           				:= '01'; 
				self.corp_ln_name_type_desc								  := 'LEGAL'; 
				self.corp_address1_type_cd          				:= if(corp2.t2u(l.BusinessMailingAddress1) <> 'NOT ENTERED' and corp2_mapping.faddressexists(state_origin,state_desc,l.BusinessMailingAddress1,,l.BusinessMailingAddress4,l.BusinessMailingAddress5,l.BusinessMailingAddress6,l.BusinessMailingAddress7).ifaddressexists,'H','');
				self.corp_address1_type_desc          			:= if(corp2.t2u(l.BusinessMailingAddress1) <> 'NOT ENTERED' and corp2_mapping.faddressexists(state_origin,state_desc,l.BusinessMailingAddress1,,l.BusinessMailingAddress4,l.BusinessMailingAddress5,l.BusinessMailingAddress6,l.BusinessMailingAddress7).ifaddressexists,'HOME STATE','');
				self.corp_address1_line1            				:= if(corp2.t2u(l.BusinessMailingAddress1) <> 'NOT ENTERED',corp2_mapping.fcleanaddress(state_origin,state_desc,l.BusinessMailingAddress1,,l.BusinessMailingAddress4,l.BusinessMailingAddress5,l.BusinessMailingAddress6,l.BusinessMailingAddress7).AddressLine1,'');
				self.corp_address1_line2            				:= if(corp2.t2u(l.BusinessMailingAddress1) <> 'NOT ENTERED',corp2_mapping.fcleanaddress(state_origin,state_desc,l.BusinessMailingAddress1,,l.BusinessMailingAddress4,l.BusinessMailingAddress5,l.BusinessMailingAddress6,l.BusinessMailingAddress7).AddressLine2,'');
				self.corp_address1_line3            				:= if(corp2.t2u(l.BusinessMailingAddress1) <> 'NOT ENTERED',corp2_mapping.fcleanaddress(state_origin,state_desc,l.BusinessMailingAddress1,,l.BusinessMailingAddress4,l.BusinessMailingAddress5,l.BusinessMailingAddress6,l.BusinessMailingAddress7).AddressLine3,'');
				self.corp_prep_addr1_line1            		 	:= if(corp2.t2u(l.BusinessMailingAddress1) <> 'NOT ENTERED',corp2_mapping.fcleanaddress(state_origin,state_desc,l.BusinessMailingAddress1,,l.BusinessMailingAddress4,l.BusinessMailingAddress5,l.BusinessMailingAddress6,l.BusinessMailingAddress7).PrepAddrLine1,'');
				self.corp_prep_addr1_last_line          	 	:= if(corp2.t2u(l.BusinessMailingAddress1) <> 'NOT ENTERED',corp2_mapping.fcleanaddress(state_origin,state_desc,l.BusinessMailingAddress1,,l.BusinessMailingAddress4,l.BusinessMailingAddress5,l.BusinessMailingAddress6,l.BusinessMailingAddress7).PrepAddrLastLine,'');
				self.corp_inc_date                          := if(corp2.t2u(l.StateorCountryOfJurisdiction) in [state_desc,state_origin,''],corp2_mapping.fvalidatedate(l.FormationDate).PastDate,'');
				self.corp_forgn_date                        := if(corp2.t2u(l.StateorCountryOfJurisdiction) not in [state_desc,state_origin,''],corp2_mapping.fvalidatedate(l.RegistrationDate).PastDate,'');
				self.corp_filing_date                       := corp2_mapping.fvalidatedate(l.temp_filing_date).GeneralDate;
				self.corp_filing_desc               			 	:= corp2.t2u(l.temp_filing_desc);
				self.corp_foreign_domestic_ind						 	:= corp2_raw_mt.functions.CorpForgnDomesticInd(l.BusinessEntityType);
				self.corp_forgn_state_cd            			 	:= if(corp2.t2u(l.StateorCountryOfJurisdiction) not in [state_desc,state_origin,''] ,corp2_raw_mt.functions.StateJurisdictionCode(l.StateorCountryOfJurisdiction) ,'');
				self.corp_forgn_state_desc          			 	:= if(self.corp_forgn_state_cd <> '', corp2.t2u(l.StateorCountryOfJurisdiction), '');			
				self.corp_status_desc												:= corp2.t2u(l.EntityStatusDescription);
				self.corp_standing                  				:= if(corp2.t2u(l.EntityStatusDescription) = 'ACTIVE GOOD STANDING','Y','');
				self.corp_status_comment            				:= if(corp2.t2u(l.EntityStatusDescription[1..8]) = 'INACTIVE' ,ut.fn_RemoveSpecialChars(corp2.t2u(l.EntityStatusChangeReason)) ,'');
				self.corp_inc_state                 			 	:= state_origin;
				self.corp_term_exist_exp             			 	:= choose(cnt,if(corp2.t2u(l.TermOfExistence) = 'PERPETUAL','',corp2_mapping.fvalidatedate(l.DurationExpirationDate).GeneralDate),
				                                                      corp2_mapping.fvalidatedate(l.DurationExpirationDate).GeneralDate);
				self.corp_term_exist_cd             			 	:= choose(cnt,if(corp2.t2u(l.TermOfExistence) = 'PERPETUAL','P','D'),if(corp2.t2u(l.TermOfExistence) = 'FUTURE DATE','F',''));
				self.corp_term_exist_desc           			 	:= map(self.corp_term_exist_cd   = 'P'   => 'PERPETUAL',
				                                                   self.corp_term_exist_cd   = 'F'   => 'FUTURE DATE',
				                                                   self.corp_term_exist_cd   = 'D'   => 'EXPIRATION DATE',
																													 '');				
				self.corp_orig_org_structure_desc   				:= corp2.t2u(l.BusinessEntityType);
				self.corp_orig_bus_type_desc        			 	:= corp2.t2u(l.BusinessEntitySubType);  
			  self.corp_for_profit_ind                    := map(corp2.t2u(l.BusinessEntityType) in ['DOMESTIC NON PROFIT CORPORATION','FOREIGN NONPROFIT CORPORATION']  => 'N',
				                                                   corp2.t2u(l.BusinessEntityType) in ['DOMESTIC PROFIT CORPORATION','FOREIGN PROFIT CORPORATION']         => 'Y',
																													 '');
				self.corp_ra_full_name               				:= corp2_mapping.fCleanBusinessName(state_origin,state_desc,l.RegisteredAgentNameOrEntityName).BusinessName;
				self.corp_ra_address_type_cd        				:= corp2.t2u(l.AgentAddressTypeCode);
				self.corp_ra_address_type_desc      				:= corp2.t2u(l.AgentAddressTypeDesc);
				self.corp_ra_address_line1		      				:= if(self.corp_ra_address_type_cd <> '',corp2_mapping.fcleanaddress(state_origin,state_desc,l.AgentBusinessMailingAddress1,l.AgentBusinessMailingAddress2 + ' ' + l.AgentBusinessMailingAddress3,l.AgentBusinessMailingCity,l.AgentBusinessMailingState,l.AgentBusinessMailingZipCode).AddressLine1,'');
				self.corp_ra_address_line2		      				:= if(self.corp_ra_address_type_cd <> '',corp2_mapping.fcleanaddress(state_origin,state_desc,l.AgentBusinessMailingAddress1,l.AgentBusinessMailingAddress2 + ' ' + l.AgentBusinessMailingAddress3,l.AgentBusinessMailingCity,l.AgentBusinessMailingState,l.AgentBusinessMailingZipCode).AddressLine2,'');
				self.corp_ra_address_line3		      				:= if(self.corp_ra_address_type_cd <> '',corp2_mapping.fcleanaddress(state_origin,state_desc,l.AgentBusinessMailingAddress1,l.AgentBusinessMailingAddress2 + ' ' + l.AgentBusinessMailingAddress3,l.AgentBusinessMailingCity,l.AgentBusinessMailingState,l.AgentBusinessMailingZipCode).AddressLine3,'');															
				self.ra_prep_addr_line1         					  := if(self.corp_ra_address_type_cd <> '',corp2_mapping.fcleanaddress(state_origin,state_desc,l.AgentBusinessMailingAddress1,l.AgentBusinessMailingAddress2 + ' ' + l.AgentBusinessMailingAddress3,l.AgentBusinessMailingCity,l.AgentBusinessMailingState,l.AgentBusinessMailingZipCode).PrepAddrLine1,'');
				self.ra_prep_addr_last_line      					  := if(self.corp_ra_address_type_cd <> '',corp2_mapping.fcleanaddress(state_origin,state_desc,l.AgentBusinessMailingAddress1,l.AgentBusinessMailingAddress2 + ' ' + l.AgentBusinessMailingAddress3,l.AgentBusinessMailingCity,l.AgentBusinessMailingState,l.AgentBusinessMailingZipCode).PrepAddrLastLine,'');
 				self.corp_purpose														:= if(corp2.t2u(l.purpose) not in Bad_Data,corp2.t2u(l.purpose),'');  
				// Note: corp_purpose are new, not a displayable field so this field will also go into corp_entity_desc like in the old mapper
				self.corp_entity_desc               				:= if(corp2.t2u(l.purpose) not in Bad_Data,corp2.t2u(l.purpose),'');
				self.corp_country_of_formation              := corp2.t2u(l.BusinessMailingAddress7);
				self.recordorigin													  := 'C';
				self																			  := l;
				self 																			  := [];
		end;
		
		MapBELP := normalize(NormLPFileDate, if(corp2.t2u(left.DurationExpirationDate) = '',1,2), LPTransform(left, counter),local);
		
		//--------------------BE-LLP-----------------------//
		corp2_mapping.LayoutsCommon.Main LLPTransform(Corp2_Raw_MT.Layouts.FileBELLPLayoutIn l, unsigned1 cnt) := transform
		  ,skip(cnt=2 and corp2.t2u(l.RenewalExpirationDate) = '')
				self.dt_vendor_first_reported								:= (unsigned4)fileDate;
				self.dt_vendor_last_reported								:= (unsigned4)fileDate;
				self.dt_first_seen													:= (unsigned4)fileDate;
				self.dt_last_seen														:= (unsigned4)fileDate;
				self.corp_ra_dt_first_seen									:= (unsigned4)fileDate;
				self.corp_ra_dt_last_seen										:= (unsigned4)fileDate;			
				self.corp_key																:= state_fips + '-' + corp2.t2u(l.BusinessEntityNumber);
				self.corp_vendor														:= state_fips;
				self.corp_state_origin											:= state_origin;			
				self.corp_process_date											:= fileDate;
				self.corp_orig_sos_charter_nbr							:= corp2.t2u(l.BusinessEntityNumber);									  									
				self.corp_legal_name                				:= corp2_mapping.fCleanBusinessName(state_origin,state_desc,l.BusinessEntityName).BusinessName;
				self.corp_ln_name_type_cd           				:= '01'; 
				self.corp_ln_name_type_desc								  := 'LEGAL'; 
				self.corp_address1_type_cd          				:= if(corp2.t2u(l.BusinessMailingAddress1) <> 'NOT ENTERED' and corp2_mapping.faddressexists(state_origin,state_desc,l.BusinessMailingAddress1,,l.BusinessMailingAddress4,l.BusinessMailingAddress5,l.BusinessMailingAddress6,l.BusinessMailingAddress7).ifaddressexists,'M','');
				self.corp_address1_type_desc          			:= if(corp2.t2u(l.BusinessMailingAddress1) <> 'NOT ENTERED' and corp2_mapping.faddressexists(state_origin,state_desc,l.BusinessMailingAddress1,,l.BusinessMailingAddress4,l.BusinessMailingAddress5,l.BusinessMailingAddress6,l.BusinessMailingAddress7).ifaddressexists,'MAILING','');
				self.corp_address1_line1            				:= if(corp2.t2u(l.BusinessMailingAddress1) <> 'NOT ENTERED',corp2_mapping.fcleanaddress(state_origin,state_desc,l.BusinessMailingAddress1,,l.BusinessMailingAddress4,l.BusinessMailingAddress5,l.BusinessMailingAddress6,l.BusinessMailingAddress7).AddressLine1,'');
				self.corp_address1_line2            				:= if(corp2.t2u(l.BusinessMailingAddress1) <> 'NOT ENTERED',corp2_mapping.fcleanaddress(state_origin,state_desc,l.BusinessMailingAddress1,,l.BusinessMailingAddress4,l.BusinessMailingAddress5,l.BusinessMailingAddress6,l.BusinessMailingAddress7).AddressLine2,'');
				self.corp_address1_line3            				:= if(corp2.t2u(l.BusinessMailingAddress1) <> 'NOT ENTERED',corp2_mapping.fcleanaddress(state_origin,state_desc,l.BusinessMailingAddress1,,l.BusinessMailingAddress4,l.BusinessMailingAddress5,l.BusinessMailingAddress6,l.BusinessMailingAddress7).AddressLine3,'');
				self.corp_prep_addr1_line1            		 	:= if(corp2.t2u(l.BusinessMailingAddress1) <> 'NOT ENTERED',corp2_mapping.fcleanaddress(state_origin,state_desc,l.BusinessMailingAddress1,,l.BusinessMailingAddress4,l.BusinessMailingAddress5,l.BusinessMailingAddress6,l.BusinessMailingAddress7).PrepAddrLine1,'');
				self.corp_prep_addr1_last_line          	 	:= if(corp2.t2u(l.BusinessMailingAddress1) <> 'NOT ENTERED',corp2_mapping.fcleanaddress(state_origin,state_desc,l.BusinessMailingAddress1,,l.BusinessMailingAddress4,l.BusinessMailingAddress5,l.BusinessMailingAddress6,l.BusinessMailingAddress7).PrepAddrLastLine,'');
 				self.corp_foreign_domestic_ind						 	:= corp2_raw_mt.functions.CorpForgnDomesticInd(l.BusinessEntityType);
				self.corp_inc_date                          := corp2_mapping.fvalidatedate(l.FormationDate).PastDate;
				self.corp_forgn_date                        := corp2_mapping.fvalidatedate(l.RegistrationDate).PastDate;
				DateOfFormation                             := corp2_mapping.fvalidatedate(l.FormationDate).GeneralDate;
				//FormationDate willbe blank for a foreign partnership
				self.corp_filing_date                       := choose(cnt,
				                                                      if(corp2.t2u(l.RegistrationDate) <> '' and DateOfFormation <> '',DateOfFormation,''),
				                                                      corp2_mapping.fvalidatedate(l.RenewalExpirationDate).GeneralDate);
				self.corp_filing_desc               			 	:= choose(cnt,if(self.corp_filing_date <> '','HOME STATE REGISTRATION DATE',''),
				                                                          'RENEWAL EXPIRATION DATE');
				self.corp_status_desc												:= corp2.t2u(l.EntityStatusDescription);
				self.corp_standing                  				:= if(corp2.t2u(l.EntityStatusDescription) = 'ACTIVE GOOD STANDING','Y','');
				self.corp_status_comment            				:= if(corp2.t2u(l.EntityStatusDescription[1..8]) = 'INACTIVE' ,ut.fn_RemoveSpecialChars(corp2.t2u(l.EntityStatusChangeReason)) ,'');
				self.corp_inc_state                 			 	:= state_origin;
				self.corp_term_exist_exp            		 	 	:= corp2_mapping.fvalidatedate(l.ExpirationDate).GeneralDate;
				self.corp_term_exist_cd             			 	:= if(self.corp_term_exist_exp <> '','D','');
				self.corp_term_exist_desc           			 	:= if(self.corp_term_exist_cd = 'D', 'EXPIRATION DATE','');
  			self.corp_orig_org_structure_desc   				:= corp2.t2u(l.BusinessEntityType);
				self.corp_orig_bus_type_desc        			 	:= corp2.t2u(l.BusinessEntitySubType);  
			  self.corp_for_profit_ind                    := map(corp2.t2u(l.BusinessEntityType) in ['DOMESTIC NON PROFIT CORPORATION','FOREIGN NONPROFIT CORPORATION']  => 'N',
				                                                   corp2.t2u(l.BusinessEntityType) in ['DOMESTIC PROFIT CORPORATION','FOREIGN PROFIT CORPORATION']         => 'Y',
																													 '');
				self.corp_purpose														:= if(corp2.t2u(l.purpose) not in Bad_data,corp2.t2u(l.purpose),'');  
				// Note: corp_purpose are new, not a displayable field so this field will also go into corp_entity_desc like in the old mapper
				self.corp_entity_desc               				:= if(corp2.t2u(l.purpose) not in Bad_data,corp2.t2u(l.purpose),'');
				self.corp_country_of_formation              := corp2.t2u(l.BusinessMailingAddress7);
				self.recordorigin													  := 'C';
				self																			  := l;
				self 																			  := [];
		end;
		
		MapBELLP := normalize(ds_BELLP, 2, LLPTransform(left, counter),local);	
		
		//--------------------TRADEMARK-----------------------//
		corp2_mapping.LayoutsCommon.Main TMTransform(Corp2_Raw_MT.Layouts.FileTMLayoutIn l) := transform		
				self.dt_vendor_first_reported								:= (unsigned4)fileDate;
				self.dt_vendor_last_reported								:= (unsigned4)fileDate;
				self.dt_first_seen													:= (unsigned4)fileDate;
				self.dt_last_seen														:= (unsigned4)fileDate;
				self.corp_ra_dt_first_seen									:= (unsigned4)fileDate;
				self.corp_ra_dt_last_seen										:= (unsigned4)fileDate;			
				self.corp_key																:= state_fips + '-' + corp2.t2u(l.BusinessEntityNumber);
				self.corp_vendor														:= state_fips;
				self.corp_state_origin											:= state_origin;			
				self.corp_process_date											:= fileDate;
				self.corp_orig_sos_charter_nbr							:= corp2.t2u(l.BusinessEntityNumber);									  									
				self.corp_legal_name                				:= corp2_mapping.fCleanBusinessName(state_origin,state_desc,l.BusinessEntityName).BusinessName;
				self.corp_ln_name_type_cd           				:= '03'; 
				self.corp_ln_name_type_desc								  := 'TRADEMARK'; 
				self.corp_inc_date                          := corp2_mapping.fvalidatedate(l.FilingDate).PastDate;
 				self.corp_filing_date                       := corp2_mapping.fvalidatedate(l.NoticeDate).PastDate;
				self.corp_filing_desc               			 	:= if(self.corp_filing_date <> '', 'RENEWAL SENT','');
				self.corp_status_desc												:= corp2.t2u(l.EntityStatusDescription);
				self.corp_status_date                       := corp2_mapping.fvalidatedate(l.RenewalDate).GeneralDate;
				self.corp_standing                  				:= if(corp2.t2u(l.EntityStatusDescription) = 'ACTIVE GOOD STANDING','Y','');
				self.corp_status_comment            				:= if(corp2.t2u(l.EntityStatusDescription[1..8]) = 'INACTIVE' ,ut.fn_RemoveSpecialChars(corp2.t2u(l.EntityStatusChangeReason)) ,'');
				self.corp_inc_state                 			 	:= state_origin;
				self.corp_term_exist_exp            		 	 	:= corp2_mapping.fvalidatedate(l.ExpirationDate).GeneralDate;
				self.corp_term_exist_cd             			 	:= if(self.corp_term_exist_exp <> '','D','');
				self.corp_term_exist_desc           			 	:= if(self.corp_term_exist_cd  = 'D' , 'EXPIRATION DATE', '');
				self.corp_entity_desc               				:= corp2.t2u(l.DescriptionOfGoods);
				self.corp_comment                           := corp2.t2u(l.MannerOfUse);
				self.corp_trademark_first_use_date_in_state := corp2_mapping.fvalidatedate(l.DateOfFirstUseMontana).PastDate;
				self.corp_trademark_first_use_date          := corp2_mapping.fvalidatedate(l.DateOfFirstUseAnywhere).PastDate;
        self.corp_trademark_renewal_date            := corp2_mapping.fvalidatedate(l.RenewalDate).PastDate;		
				                                               
				string TM_pRplc                             := '([0-9][0-9A-Z]{1,2})(\\s-\\s[A-Z0-9\\s,\';&-]+[\\.,]*)';
				string tm_cln_class_desc                    := ut.fn_RemoveSpecialChars(l.ClassCodesDesc);
				string tm_class_codes                       := REGEXREPLACE(TM_pRplc,corp2.t2u(tm_cln_class_desc),'$1||');
				integer num_class_codes                     := lib_stringlib.StringLib.StringFindCount(tm_class_codes,'||');
				self.corp_trademark_class_desc1             := if(num_class_codes > 0,corp2_raw_mt.functions.TradeMarkClassCodeTable(tm_class_codes,num_class_codes,1),'');
				self.corp_trademark_class_desc2             := if(num_class_codes > 1,corp2_raw_mt.functions.TradeMarkClassCodeTable(tm_class_codes,num_class_codes,2),'');
				self.corp_trademark_class_desc3             := if(num_class_codes > 2,corp2_raw_mt.functions.TradeMarkClassCodeTable(tm_class_codes,num_class_codes,3),'');
				self.corp_trademark_class_desc4             := if(num_class_codes > 3,corp2_raw_mt.functions.TradeMarkClassCodeTable(tm_class_codes,num_class_codes,4),'');
				self.corp_trademark_class_desc5             := if(num_class_codes > 4,corp2_raw_mt.functions.TradeMarkClassCodeTable(tm_class_codes,num_class_codes,5),'');
				self.corp_trademark_class_desc6             := if(num_class_codes >= 6,corp2_raw_mt.functions.TradeMarkClassCodeTable(tm_class_codes,num_class_codes,6),'');
				self.recordorigin													  := 'C';
				self																			  := l;
				self 																			  := [];
		end;
		
		MapTM := project(ds_TM, TMTransform(left));
		
		//--------------------ABN-----------------------//
		corp2_mapping.LayoutsCommon.Main ABNTransform(Corp2_Raw_MT.Layouts.FileABNLayoutIn l) := transform		
				self.dt_vendor_first_reported								:= (unsigned4)fileDate;
				self.dt_vendor_last_reported								:= (unsigned4)fileDate;
				self.dt_first_seen													:= (unsigned4)fileDate;
				self.dt_last_seen														:= (unsigned4)fileDate;
				self.corp_ra_dt_first_seen									:= (unsigned4)fileDate;
				self.corp_ra_dt_last_seen										:= (unsigned4)fileDate;			
				self.corp_key																:= state_fips + '-' + corp2.t2u(l.BusinessEntityNumber);
				self.corp_vendor														:= state_fips;
				self.corp_state_origin											:= state_origin;			
				self.corp_process_date											:= fileDate;
				self.corp_orig_sos_charter_nbr							:= corp2.t2u(l.BusinessEntityNumber);									  									
				self.corp_legal_name                				:= corp2_mapping.fCleanBusinessName(state_origin,state_desc,l.BusinessEntityName).BusinessName;
				self.corp_ln_name_type_cd           				:= '06'; 
				self.corp_ln_name_type_desc								  := 'ASSUMED'; 
				self.corp_inc_date                          := corp2_mapping.fvalidatedate(l.RegistrationDate).PastDate;
        self.corp_status_desc												:= corp2.t2u(l.EntityStatusDescription);
				self.corp_status_date                       := corp2_mapping.fvalidatedate(l.RenewalDate).GeneralDate;
				self.corp_standing                  				:= if(corp2.t2u(l.EntityStatusDescription) = 'ACTIVE GOOD STANDING','Y','');
				self.corp_status_comment            				:= if(corp2.t2u(l.EntityStatusDescription[1..8]) = 'INACTIVE' ,ut.fn_RemoveSpecialChars(corp2.t2u(l.EntityStatusChangeReason)) ,'');
				self.corp_inc_state                 			 	:= state_origin;
				self.corp_term_exist_exp            		 	 	:= corp2_mapping.fvalidatedate(l.ExpirationDate).GeneralDate;
				self.corp_term_exist_cd             			 	:= if(self.corp_term_exist_exp <> '','D','');
				self.corp_term_exist_desc           			 	:= if(self.corp_term_exist_cd  = 'D' , 'EXPIRATION DATE', '');
				// Note: corp_purpose are new, not a displayable field so this field will also go into corp_entity_desc like in the old mapper
				self.corp_entity_desc               				:= if(corp2.t2u(l.BusinessDescription) not in Bad_Data,corp2.t2u(l.BusinessDescription),'');
				self.corp_purpose														:= if(corp2.t2u(l.BusinessDescription) not in Bad_Data,corp2.t2u(l.BusinessDescription),'');  
		    self.recordorigin													  := 'C';
				self																			  := l;
				self 																			  := [];
		end;
		
		MapABN := project(ds_ABN, ABNTransform(left));

		//--------------------FBN-----------------------//
    corp2_mapping.LayoutsCommon.Main FBNTransform(Corp2_Raw_MT.Layouts.FileFBNLayoutIn l) := transform		
				self.dt_vendor_first_reported								:= (unsigned4)fileDate;
				self.dt_vendor_last_reported								:= (unsigned4)fileDate;
				self.dt_first_seen													:= (unsigned4)fileDate;
				self.dt_last_seen														:= (unsigned4)fileDate;
				self.corp_ra_dt_first_seen									:= (unsigned4)fileDate;
				self.corp_ra_dt_last_seen										:= (unsigned4)fileDate;			
				self.corp_key																:= state_fips + '-' + corp2.t2u(l.BusinessEntityNumber);
				self.corp_vendor														:= state_fips;
				self.corp_state_origin											:= state_origin;			
				self.corp_process_date											:= fileDate;
				self.corp_orig_sos_charter_nbr							:= corp2.t2u(l.BusinessEntityNumber);									  									
				self.corp_legal_name                				:= corp2_mapping.fCleanBusinessName(state_origin,state_desc,l.BusinessEntityName).BusinessName;
				self.corp_ln_name_type_cd           				:= '10'; 
				self.corp_ln_name_type_desc								  := 'FOREIGN BUSINESS NAME'; 
				self.corp_inc_date                          := corp2_mapping.fvalidatedate(l.RegistrationDate).PastDate;
				self.corp_address1_type_cd          				:= if(corp2.t2u(l.BusinessMailingAddress1) <> 'NOT ENTERED' and corp2_mapping.faddressexists(state_origin,state_desc,l.BusinessMailingAddress1,,l.BusinessMailingAddress4,l.BusinessMailingAddress5,l.BusinessMailingAddress6,l.BusinessMailingAddress7).ifaddressexists,'M','');
				self.corp_address1_type_desc          			:= if(corp2.t2u(l.BusinessMailingAddress1) <> 'NOT ENTERED' and corp2_mapping.faddressexists(state_origin,state_desc,l.BusinessMailingAddress1,,l.BusinessMailingAddress4,l.BusinessMailingAddress5,l.BusinessMailingAddress6,l.BusinessMailingAddress7).ifaddressexists,'MAILING','');
				self.corp_address1_line1            				:= if(corp2.t2u(l.BusinessMailingAddress1) <> 'NOT ENTERED',corp2_mapping.fcleanaddress(state_origin,state_desc,l.BusinessMailingAddress1,,l.BusinessMailingAddress4,l.BusinessMailingAddress5,l.BusinessMailingAddress6,l.BusinessMailingAddress7).AddressLine1,'');
				self.corp_address1_line2            				:= if(corp2.t2u(l.BusinessMailingAddress1) <> 'NOT ENTERED',corp2_mapping.fcleanaddress(state_origin,state_desc,l.BusinessMailingAddress1,,l.BusinessMailingAddress4,l.BusinessMailingAddress5,l.BusinessMailingAddress6,l.BusinessMailingAddress7).AddressLine2,'');
				self.corp_address1_line3            				:= if(corp2.t2u(l.BusinessMailingAddress1) <> 'NOT ENTERED',corp2_mapping.fcleanaddress(state_origin,state_desc,l.BusinessMailingAddress1,,l.BusinessMailingAddress4,l.BusinessMailingAddress5,l.BusinessMailingAddress6,l.BusinessMailingAddress7).AddressLine3,'');
				self.corp_prep_addr1_line1            		 	:= if(corp2.t2u(l.BusinessMailingAddress1) <> 'NOT ENTERED',corp2_mapping.fcleanaddress(state_origin,state_desc,l.BusinessMailingAddress1,,l.BusinessMailingAddress4,l.BusinessMailingAddress5,l.BusinessMailingAddress6,l.BusinessMailingAddress7).PrepAddrLine1,'');
				self.corp_prep_addr1_last_line          	 	:= if(corp2.t2u(l.BusinessMailingAddress1) <> 'NOT ENTERED',corp2_mapping.fcleanaddress(state_origin,state_desc,l.BusinessMailingAddress1,,l.BusinessMailingAddress4,l.BusinessMailingAddress5,l.BusinessMailingAddress6,l.BusinessMailingAddress7).PrepAddrLastLine,'');
        self.corp_forgn_state_cd            			 	:= corp2_raw_mt.functions.StateJurisdictionCode(l.StateorCountryOfJurisdiction);
				self.corp_forgn_state_desc          			 	:= corp2.t2u(l.StateorCountryOfJurisdiction);			
 				self.corp_filing_date                       := corp2_mapping.fvalidatedate(l.DateOfOrganizationOrIncorporation).PastDate;
				self.corp_filing_desc               			 	:= if(self.corp_filing_date <> '', 'HOME STATE REGISTRATION DATE','');
				self.corp_status_desc												:= corp2.t2u(l.EntityStatusDescription);
				self.corp_status_date                       := corp2_mapping.fvalidatedate(l.RenewalDate).GeneralDate;
				self.corp_standing                  				:= if(corp2.t2u(l.EntityStatusDescription) = 'ACTIVE GOOD STANDING','Y','');
				self.corp_inc_state                 			 	:= state_origin;
				self.corp_term_exist_exp            		 	 	:= corp2_mapping.fvalidatedate(l.ExpirationDate).GeneralDate;
				self.corp_term_exist_cd             			 	:= if(self.corp_term_exist_exp <> '','D','');
				self.corp_term_exist_desc           			 	:= if(self.corp_term_exist_cd  = 'D' , 'EXPIRATION DATE', '');
				self.corp_orig_bus_type_desc        			 	:= corp2.t2u(l.BusinessType);  
				self.corp_entity_desc               				:= if(corp2.t2u(l.BusinessDescription) not in Bad_Data,corp2.t2u(l.BusinessDescription),'');
				self.corp_purpose               				    := if(corp2.t2u(l.BusinessDescription) not in Bad_Data,corp2.t2u(l.BusinessDescription),'');
		    self.recordorigin													  := 'C';
				self																			  := l;
				self 																			  := [];
		end;
		
		MapFBN := project(ds_FBN, FBNTransform(left));

   //--------------------RELATEDTM-----------------------//
    corp2_mapping.LayoutsCommon.Main ReltdTMTransform(Corp2_Raw_MT.Layouts.FileRelatedTrademarkLayoutIn l) := transform		
				self.dt_vendor_first_reported								:= (unsigned4)fileDate;
				self.dt_vendor_last_reported								:= (unsigned4)fileDate;
				self.dt_first_seen													:= (unsigned4)fileDate;
				self.dt_last_seen														:= (unsigned4)fileDate;
				self.corp_ra_dt_first_seen									:= (unsigned4)fileDate;
				self.corp_ra_dt_last_seen										:= (unsigned4)fileDate;			
				self.corp_key																:= state_fips + '-' + corp2.t2u(l.BusinessEntityNumber);
				self.corp_vendor														:= state_fips;
				self.corp_state_origin											:= state_origin;			
				self.corp_process_date											:= fileDate;
				self.corp_inc_state                 			 	:= state_origin;
				self.corp_orig_sos_charter_nbr							:= corp2.t2u(l.BusinessEntityNumber);									  									
				self.corp_legal_name                				:= corp2_mapping.fCleanBusinessName(state_origin,state_desc,l.RelatedTrademarkName).BusinessName;
				self.corp_ln_name_type_cd           				:= '03'; 
				self.corp_ln_name_type_desc								  := 'TRADEMARK'; 
				self.corp_filing_reference_nbr              := corp2.t2u(l.RelatedTrademarkID);	
				self.corp_internal_nbr                      := corp2.t2u(l.RelatedTrademarkID);	
		    self.recordorigin													  := 'C';
				self																			  := l;
				self 																			  := [];
		end;
		
		MapReltdTM := project(ds_RelatedTM, ReltdTMTransform(left));
		
		//--------------------RELATEDABN-----------------------//
    corp2_mapping.LayoutsCommon.Main ReltdABNTransform(Corp2_Raw_MT.Layouts.FileRelatedABNLayoutIn l) := transform		
				self.dt_vendor_first_reported								:= (unsigned4)fileDate;
				self.dt_vendor_last_reported								:= (unsigned4)fileDate;
				self.dt_first_seen													:= (unsigned4)fileDate;
				self.dt_last_seen														:= (unsigned4)fileDate;
				self.corp_ra_dt_first_seen									:= (unsigned4)fileDate;
				self.corp_ra_dt_last_seen										:= (unsigned4)fileDate;			
				self.corp_key																:= state_fips + '-' + corp2.t2u(l.BusinessEntityNumber);
				self.corp_vendor														:= state_fips;
				self.corp_state_origin											:= state_origin;			
				self.corp_process_date											:= fileDate;
				self.corp_inc_state                 			 	:= state_origin;
				self.corp_orig_sos_charter_nbr							:= corp2.t2u(l.BusinessEntityNumber);									  									
				self.corp_legal_name                				:= corp2_mapping.fCleanBusinessName(state_origin,state_desc,l.RelatedABNName).BusinessName;
				self.corp_ln_name_type_cd           				:= '06'; 
				self.corp_ln_name_type_desc								  := 'ASSUMED'; 
				self.corp_filing_reference_nbr              := corp2.t2u(l.RelatedABNId);	
				self.corp_internal_nbr                      := corp2.t2u(l.RelatedABNId);	
		    self.recordorigin													  := 'C';
				self																			  := l;
				self 																			  := [];
		end;
		
		MapReltdABN := project(ds_RelatedABN, ReltdABNTransform(left));
		
		All_Corp := MapBECorp + MapBELLC + MapBELP + MapBELLP + MapTM + MapABN + MapFBN + MapReltdTM + MapReltdABN;
    //********************************************************************
		// Perform Joins to create file that Contacts will be mapped from
		//********************************************************************
		
		Cont_Principal  	 := project(ds_Principal,
		                              transform(corp2_raw_mt.layouts.TempContactLayoutIn,
																	          self.BusinessEntityNumber    := left.BusinessEntityNumber;
																						self.ContType                := 'P';
																						self.ContDesc                := 'PRINCIPAL';
																						self.Cont_Full_Name          := left.PrincipalNameOrEntityName;
																						self.Title_Position          := left.PrincipalPosition;
																						self.Cont_address_line1      := left.PrincipalBusinessMailingAddress1;
																						self.Cont_address_line2      := left.PrincipalBusinessMailingAddress2;
																						self.Cont_address_line3      := left.PrincipalBusinessMailingAddress3;
																						self.Cont_city               := left.PrincipalBusinessMailingAddress4;
																						self.Cont_state              := left.PrincipalBusinessMailingAddress5;
																						self.Cont_zip                := left.PrincipalBusinessMailingAddress6;
																						self.Cont_country            := left.PrincipalBusinessMailingAddress7;
																						self.RelatedBusinessEntityId := left.PrincipalRelatedBusinessEntityId;
																					 	self                         := left; 
																						self                         := [];));
																						
		Cont_Partner  		 := project(ds_Partner,
		                              transform(corp2_raw_mt.layouts.TempContactLayoutIn,
																	          self.BusinessEntityNumber    := left.BusinessEntityNumber;
																						self.ContType                := 'PT';
																						self.ContDesc                := 'PARTNER';
																						self.Cont_Full_Name          := left.PartnerName;
																						self.Cont_address_line1      := left.PartnerBusinessMailingAddress1;
																						self.Cont_address_line2      := left.PartnerBusinessMailingAddress2;
																						self.Cont_address_line3      := left.PartnerBusinessMailingAddress3;
																						self.Cont_city               := left.PartnerBusinessMailingAddress4;
																						self.Cont_state              := left.PartnerBusinessMailingAddress5;
																						self.Cont_zip                := left.PartnerBusinessMailingAddress6;
																						self.Cont_country            := left.PartnerBusinessMailingAddress7;
																						self.RelatedBusinessEntityId := left.PartnerRelatedBusinessEntityId;
																					 	self                         := left; 
																						self                         := [];));																				
	
	  Cont_Owner  		   := project(ds_Owner,
		                              transform(corp2_raw_mt.layouts.TempContactLayoutIn,
																	          self.BusinessEntityNumber    := left.BusinessEntityNumber;
																						self.ContType                := 'O';
																						self.ContDesc                := 'OWNER';
																						self.Title_Position          := left.OwnerType;
																						self.Cont_Full_Name          := left.OwnerName;
																						self.Cont_address_line1      := left.OwnerAddress1;
																						self.Cont_address_line2      := left.OwnerAddress2;
																						self.Cont_address_line3      := left.OwnerAddress3;
																						self.Cont_city               := left.OwnerAddress4;
																						self.Cont_state              := left.OwnerAddress5;
																						self.Cont_zip                := left.OwnerAddress6;
																						self.Cont_country            := left.OwnerAddress7;
																						self.RelatedBusinessEntityId := left.OwnerRelatedBusinessEntityId;
																					 	self                         := left; 
																						self                         := [];));	
																						
		Cont_Member  		   := project(ds_Member,
		                              transform(corp2_raw_mt.layouts.TempContactLayoutIn,
																	          self.BusinessEntityNumber    := left.BusinessEntityNumber;
																						self.ContType                := 'P';
																						self.ContDesc                := 'PRINCIPAL';
																						self.Cont_Full_Name          := left.MemberName;
																						self.Cont_address_line1      := left.MemberBusinessMailingAddress1;
																						self.Cont_address_line2      := left.MemberBusinessMailingAddress2;
																						self.Cont_address_line3      := left.MemberBusinessMailingAddress3;
																						self.Cont_city               := left.MemberBusinessMailingAddress4;
																						self.Cont_state              := left.MemberBusinessMailingAddress5;
																						self.Cont_zip                := left.MemberBusinessMailingAddress6;
																						self.Cont_country            := left.MemberBusinessMailingAddress7;
																						self.RelatedBusinessEntityId := left.MemberRelatedBusinessEntityId;
																					 	self                         := left; 
																						self                         := [];));	
																						
		mapAll_Contacts := Cont_Principal + Cont_Partner + Cont_Owner + Cont_Member;
		
		join_ContCorp        := join(mapAll_Contacts,All_Corp,
																 corp2.t2u(left.BusinessEntityNumber) = corp2.t2u(right.Corp_Key[4..]),
																 transform(Corp2_Raw_MT.Layouts.TempContactLayoutIn,
																					 self.Corp_Legal_Name := right.Corp_Legal_Name;
																					 self                 := left;																							
																					 self                 := [];)
																,inner,local) : independent;

    //********************************************************************
		// MAIN Contacts mapping
		//********************************************************************
		corp2_mapping.LayoutsCommon.Main ContactTransform(Corp2_Raw_MT.Layouts.TempContactLayoutIn l) := transform
		  ,skip(corp2_mapping.fCleanBusinessName(state_origin,state_desc,l.cont_full_name).BusinessName in 
							['','VACANT','OPERATES WITHOUT','ABBREVIATED LIST','1 NONE STATED','NONE STATED','3 NONE STATED',
							 '2 NONE STATED','NONE LISTED','WITHOUT OPERATES','4 NONE STATED','*','ABBREVIATED LI ST',
							 'SAME AS SECR','OPERATES W/OUT','STATED NONE','NOT APPLICABLE','NOT REQUIRED','NONE NONE',
							 '2 NONE LISTED','1 NONE LISTED','3 NONE LISTED','DIRECTORS OPERATE WITHOUT'])
				self.dt_vendor_first_reported								:= (unsigned4)fileDate;
				self.dt_vendor_last_reported								:= (unsigned4)fileDate;
				self.dt_first_seen													:= (unsigned4)fileDate;
				self.dt_last_seen														:= (unsigned4)fileDate;
				self.corp_ra_dt_first_seen									:= (unsigned4)fileDate;
				self.corp_ra_dt_last_seen										:= (unsigned4)fileDate;			
				self.corp_key																:= state_fips + '-' + corp2.t2u(l.BusinessEntityNumber);
				self.corp_vendor														:= state_fips;
				self.corp_state_origin											:= state_origin;			
				self.corp_process_date											:= fileDate;
				self.corp_orig_sos_charter_nbr							:= corp2.t2u(l.BusinessEntityNumber);									  									
				self.corp_legal_name                				:= corp2.t2u(l.Corp_Legal_Name);
				self.corp_inc_state                 				:= state_origin;
				self.cont_type_cd  		        							:= corp2.t2u(l.ContType);	
				self.cont_type_desc  		    								:= corp2.t2u(l.ContDesc);	
				self.cont_full_name    	 	        					:= corp2_mapping.fCleanBusinessName(state_origin,state_desc,l.cont_full_name).BusinessName;
				self.cont_title1_desc		    								:= if(corp2.t2u(l.Title_Position) <> '',corp2_raw_mt.functions.ContTitle1Desc(l.Title_Position),'');
				self.cont_address_type_cd          					:= if(corp2.t2u(l.cont_address_line1) <> 'NOT ENTERED' and corp2_mapping.faddressexists(state_origin,state_desc,l.cont_address_line1,l.cont_address_line2 + ' ' + l.cont_address_line3,l.cont_city,l.cont_state,l.cont_zip,l.cont_country).ifaddressexists,'T','');
				self.cont_address_type_desc          				:= if(corp2.t2u(l.cont_address_line1) <> 'NOT ENTERED' and corp2_mapping.faddressexists(state_origin,state_desc,l.cont_address_line1,l.cont_address_line2 + ' ' + l.cont_address_line3,l.cont_city,l.cont_state,l.cont_zip,l.cont_country).ifaddressexists,'CONTACT','');		
				self.cont_address_line1	            				:= if(corp2.t2u(l.cont_address_line1) <> 'NOT ENTERED',corp2_mapping.fcleanaddress(state_origin,state_desc,l.cont_address_line1,l.cont_address_line2 + ' ' + l.cont_address_line3,l.cont_city,l.cont_state,l.cont_zip,l.cont_country).AddressLine1,'');
				self.cont_address_line2	            				:= if(corp2.t2u(l.cont_address_line1) <> 'NOT ENTERED',corp2_mapping.fcleanaddress(state_origin,state_desc,l.cont_address_line1,l.cont_address_line2 + ' ' + l.cont_address_line3,l.cont_city,l.cont_state,l.cont_zip,l.cont_country).AddressLine2,'');
				self.cont_address_line3	            				:= if(corp2.t2u(l.cont_address_line1) <> 'NOT ENTERED',corp2_mapping.fcleanaddress(state_origin,state_desc,l.cont_address_line1,l.cont_address_line2 + ' ' + l.cont_address_line3,l.cont_city,l.cont_state,l.cont_zip,l.cont_country).AddressLine3,'');
				self.cont_prep_addr_line1	            			:= if(corp2.t2u(l.cont_address_line1) <> 'NOT ENTERED',corp2_mapping.fcleanaddress(state_origin,state_desc,l.cont_address_line1,l.cont_address_line2 + ' ' + l.cont_address_line3,l.cont_city,l.cont_state,l.cont_zip,l.cont_country).PrepAddrLine1,'');
				self.cont_prep_addr_last_line	           	 	:= if(corp2.t2u(l.cont_address_line1) <> 'NOT ENTERED',corp2_mapping.fcleanaddress(state_origin,state_desc,l.cont_address_line1,l.cont_address_line2 + ' ' + l.cont_address_line3,l.cont_city,l.cont_state,l.cont_zip,l.cont_country).PrepAddrLastLine,'');
				self.cont_country                           := corp2_mapping.fCleanCountry(state_origin,state_desc,l.cont_state,l.cont_country).country;
				self.recordorigin														:= 'T';				
				self                            						:= l;
				self																				:= [];
		end;
		
		All_Cont	:= project(join_ContCorp,ContactTransform(left));	

   	
		//********************************************************************
		// AR mapping
		//********************************************************************
		corp2_mapping.LayoutsCommon.AR ARCorpTransform(Corp2_Raw_MT.Layouts.TempNormCorpLayoutIn l) := transform,
		  skip(corp2.t2u(l.InvoluntaryDissolutionIntentDate) = '' and corp2.t2u(l.ARLastFiledDate) = '')
				self.corp_key							  := state_fips + '-' +corp2.t2u(l.BusinessEntityNumber);
				self.corp_vendor						:= state_fips;		
				self.corp_state_origin			:= state_origin;
				self.corp_process_date			:= fileDate;
				self.corp_sos_charter_nbr		:= corp2.t2u(l.BusinessEntityNumber);
				self.ar_delinquent_dt       := corp2_mapping.fvalidatedate(l.InvoluntaryDissolutionIntentDate).PastDate;				
				self.ar_filed_dt            := corp2_mapping.fvalidatedate(l.ARLastFiledDate).PastDate;
			  self												:= [];
		end;
		
		map_ARCorp  := project(NormCorpFileDate, ARCorpTransform(left));
		
		corp2_mapping.LayoutsCommon.AR ARLLCTransform(Corp2_Raw_MT.Layouts.TempNormLLCLayoutIn l) := transform,
		  skip(corp2.t2u(l.InvoluntaryDissolutionIntentDate) = '' and corp2.t2u(l.ARLastFiledDate) = '')
				self.corp_key							  := state_fips + '-' +corp2.t2u(l.BusinessEntityNumber);
				self.corp_vendor						:= state_fips;		
				self.corp_state_origin			:= state_origin;
				self.corp_process_date			:= fileDate;
				self.corp_sos_charter_nbr		:= corp2.t2u(l.BusinessEntityNumber);
				self.ar_delinquent_dt       := corp2_mapping.fvalidatedate(l.InvoluntaryDissolutionIntentDate).PastDate;				
				self.ar_filed_dt            := corp2_mapping.fvalidatedate(l.ARLastFiledDate).PastDate;
			  self												:= [];
		end;
		
		map_ARLLC  := project(NormLLCFileDate, ARLLCTransform(left));

		
	  All_AR     := map_ARCorp + map_ARLLC;
		
	
		//********************************************************************
		// STOCK mapping
		//********************************************************************
		corp2_mapping.LayoutsCommon.Stock StockTransform(Corp2_Raw_MT.Layouts.FileSharesLayoutIn l) := transform
				self.corp_key								:= state_fips + '-' + corp2.t2u(l.BusinessEntityNumber);
				self.corp_vendor						:= state_fips;		
				self.corp_state_origin			:= state_origin;
				self.corp_process_date			:= fileDate;
				self.corp_sos_charter_nbr		:= corp2.t2u(l.BusinessEntityNumber);
				self.stock_type             := corp2_raw_mt.functions.stockType(l.AuthorizedSharesSeries);
				self.stock_class            := corp2.t2u(l.AuthorizedSharesClass);
				self.stock_authorized_nbr 	:= corp2.t2u(l.AuthorizedNumberOfShares);		
        self.stock_shares_issued   	:= corp2.t2u(l.AuthorizedSharesIssued);
				self.stock_par_value   	    := corp2.t2u(l.AuthorizedSharesParValueAmount);
				self												:= [];
		end;
		
		All_Stock	 	:= project(ds_Shares,StockTransform(left));
		
		
	//-----------------------------------------------------------//
	// Build the Final Mapped Files
	//-----------------------------------------------------------//
		mapMain	 := dedup(sort(distribute(All_Corp + All_Cont,hash(corp_key)) ,record,local) ,record,local) : independent;
		mapAR		 := dedup(sort(distribute(All_AR,hash(corp_key))             ,record,local) ,record,local) : independent;
		mapStock := dedup(sort(distribute(All_Stock,hash(corp_key))          ,record,local) ,record,local) : independent;


	//--------------------------------------------------------------------	
  // Scrubs for MAIN
  //--------------------------------------------------------------------
		Main_F := MapMain;
		Main_S := Scrubs_Corp2_Mapping_MT_Main.Scrubs;        // Scrubs module
		Main_N := Main_S.FromNone(Main_F); 										// Generate the error flags
		Main_T := Main_S.FromBits(Main_N.BitmapInfile);     	// Use the FromBits module; makes my bitmap datafile easier to get to
		Main_U := Main_S.FromExpanded(Main_N.ExpandedInFile); // Pass the expanded error flags into the Expanded module

	//Outputs reports
		Main_ErrorSummary					:= output(Main_U.SummaryStats, named('Main_ErrorSummary_MT'+filedate));
		Main_ScrubErrorReport 		:= output(choosen(Main_U.AllErrors, 1000), named('Main_ScrubErrorReport_MT'+filedate));
		Main_SomeErrorValues			:= output(choosen(Main_U.BadValues, 1000), named('Main_SomeErrorValues_MT'+filedate));
		Main_IsScrubErrors		 		:= IF(count(Main_U.AllErrors)<> 0,true,false);

		// Orbit Stats
		Main_OrbitStats						:= Main_U.OrbitStats();
		
		//Outputs files
		Main_CreateBitMaps				:= output(Main_N.BitmapInfile,,'~thor_data::corp_mt_main_scrubs_bits',overwrite,compressed);	//long term storage
		Main_TranslateBitMap			:= output(Main_T);
    
    //Creates Profile's alert template for Orbit - Can be copied & imported into Orbit; Only required first time & if scrub rules change
	  Main_AlertsCSVTemplate		:= Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_'+state_origin+'_Main','ScrubsAlerts', Main_OrbitStats, version,'Corp2_'+state_origin+'_Main').ProfileAlertsTemplate;
	  
		//Submits Profile's stats to Orbit
    Main_SubmitStats          := Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_MT_Main','ScrubsAlerts', Main_OrbitStats, version,'Corp_MT_Main').SubmitStats;

		Main_ScrubsWithExamples		:= Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_MT_Main','ScrubsAlerts', Main_OrbitStats, version,'Corp_MT_Main').CompareToProfile_with_Examples;
		
		Main_ScrubsAlert					:= Main_ScrubsWithExamples(RejectWarning = 'Y');
		Main_ScrubsAttachment			:= Scrubs.fn_email_attachment(Main_ScrubsAlert);
		Main_SendEmailFile				:= FileServices.SendEmailAttachData( corp2.Email_Notification_Lists.spray
																																	 ,'Scrubs CorpMain_MT Report' //subject
																																	 ,'Scrubs CorpMain_MT Report' //body
																																	 ,(data)Main_ScrubsAttachment
																																	 ,'text/csv'
																																	 ,'CorpMTMainScrubsReport.csv'
																																	 ,
																																	 ,
																																	 ,corp2.Email_Notification_Lists.spray
																																 );		
																																 
		Main_BadRecords := Main_T.ExpandedInFile( dt_vendor_first_reported_invalid 			  			 <> 0 or
																							dt_vendor_last_reported_invalid 							 <> 0 or
																							dt_first_seen_invalid 												 <> 0 or
																							dt_last_seen_invalid 									  			 <> 0 or
																							corp_ra_dt_first_seen_invalid 								 <> 0 or
																							corp_ra_dt_last_seen_invalid 					  			 <> 0 or
																							corp_key_invalid 											  			 <> 0 or
																							corp_vendor_invalid 													 <> 0 or
																							corp_state_origin_invalid 					 					 <> 0 or
																							corp_process_date_invalid						    			 <> 0 or
																							corp_orig_sos_charter_nbr_invalid 						 <> 0 or
																							corp_legal_name_invalid 											 <> 0 or
																							corp_inc_state_invalid												 <> 0 or	
																						  corp_ln_name_type_cd_invalid									 <> 0 or
																							corp_filing_date_invalid 			  							 <> 0 or
																							corp_inc_date_invalid 												 <> 0 or
																							corp_forgn_date_invalid 											 <> 0 or
																							corp_foreign_domestic_ind_invalid			  			 <> 0 or
																							corp_forgn_state_desc_invalid  							 	 <> 0 or	
																							corp_term_exist_cd_invalid										 <> 0 or
																							corp_term_exist_exp_invalid						  			 <> 0 or
																							corp_status_desc_invalid						    			 <> 0 or
																							corp_status_comment_invalid						  			 <> 0 or
																							corp_trademark_class_desc1_invalid						 <> 0 or
																							corp_trademark_class_desc2_invalid						 <> 0 or
																							corp_trademark_class_desc3_invalid						 <> 0 or
																							corp_trademark_class_desc4_invalid						 <> 0 or
																							corp_trademark_class_desc5_invalid						 <> 0 or
																							corp_trademark_class_desc6_invalid						 <> 0 or
																							corp_trademark_first_use_date_in_state_invalid <> 0 or
																							corp_trademark_first_use_date_invalid					 <> 0 or
																							corp_trademark_renewal_date_invalid						 <> 0 or
																						  cont_title1_desc_invalid                			 <> 0 or
																							recordorigin_invalid													 <> 0	);

		Main_GoodRecords	:= Main_T.ExpandedInFile(dt_vendor_first_reported_invalid 			  		 = 0 and
																							dt_vendor_last_reported_invalid 							 = 0 and
																							dt_first_seen_invalid 												 = 0 and
																							dt_last_seen_invalid 									  			 = 0 and
																							corp_ra_dt_first_seen_invalid 								 = 0 and
																							corp_ra_dt_last_seen_invalid 					 			   = 0 and
																							corp_key_invalid 											  			 = 0 and
																							corp_vendor_invalid 													 = 0 and
																							corp_state_origin_invalid 					 					 = 0 and
																							corp_process_date_invalid						   			   = 0 and
																							corp_orig_sos_charter_nbr_invalid 						 = 0 and
																							corp_legal_name_invalid 											 = 0 and
																							corp_inc_state_invalid												 = 0 and	
																						  corp_ln_name_type_cd_invalid									 = 0 and
																							corp_filing_date_invalid 			  							 = 0 and
																							corp_inc_date_invalid 												 = 0 and
																							corp_forgn_date_invalid 											 = 0 and
																							corp_foreign_domestic_ind_invalid			  			 = 0 and
																							corp_forgn_state_desc_invalid  								 = 0 and	
																							corp_term_exist_cd_invalid										 = 0 and
																							corp_term_exist_exp_invalid						  			 = 0 and
																							corp_status_desc_invalid						    		   = 0 and
																							corp_status_comment_invalid						  			 = 0 and
																							corp_trademark_class_desc1_invalid						 = 0 and
																							corp_trademark_class_desc2_invalid						 = 0 and
																							corp_trademark_class_desc3_invalid						 = 0 and
																							corp_trademark_class_desc4_invalid						 = 0 and
																							corp_trademark_class_desc5_invalid						 = 0 and
																							corp_trademark_class_desc6_invalid						 = 0 and
																							corp_trademark_first_use_date_in_state_invalid = 0 and
																							corp_trademark_first_use_date_invalid					 = 0 and
																							corp_trademark_renewal_date_invalid						 = 0 and
																						  cont_title1_desc_invalid                			 = 0 and
																							recordorigin_invalid													 = 0	);																					 																	
		
		Main_FailBuild	:= map(corp2_mapping.fCalcPercent(count(Main_N.ExpandedInFile(corp_orig_sos_charter_nbr_invalid<>0)),count(Main_N.ExpandedInFile),false) > Scrubs_Corp2_Mapping_MT_Main.Threshold_Percent.CORP_ORIG_SOS_CHARTER_NBR => true,
													 corp2_mapping.fCalcPercent(count(Main_N.ExpandedInFile(corp_legal_name_invalid<>0)),					 count(Main_N.ExpandedInFile),false) > Scrubs_Corp2_Mapping_MT_Main.Threshold_Percent.CORP_LEGAL_NAME 					=> true,
													 corp2_mapping.fCalcPercent(count(Main_N.ExpandedInFile(corp_key_invalid<>0)),						     count(Main_N.ExpandedInFile),false) > Scrubs_Corp2_Mapping_MT_Main.Threshold_Percent.CORP_KEY      						=> true,
													 count(Main_GoodRecords) = 0																																																																																				          => true,
													 false );

		Main_ApprovedRecords := project(Main_GoodRecords,transform(Corp2_Mapping.LayoutsCommon.Main,self := left));
	
	  Main_RejFile_Exists		:= IF(FileServices.FileExists(Corp2_Mapping._dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::main_' + state_origin),true,false);
		
	  Main_MT 		 					:= sequential(IF(count(Main_BadRecords) <> 0
																					,IF (poverwrite
																							,OUTPUT(Main_BadRecords,,Corp2_Mapping._Dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::Main_MT',overwrite,__compressed__,named('Sample_Rejected_MainRecs_MT'+filedate))
																							,sequential (IF(Main_RejFile_Exists,fileservices.deletelogicalfile(Corp2_Mapping._dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::main_'+ state_origin))
																							             ,OUTPUT(Main_BadRecords,,Corp2_Mapping._Dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::main_'+ state_origin,__compressed__,named('Sample_Rejected_MainRecs_MT'+filedate)))))
																		,output(Main_ScrubsWithExamples, ALL, NAMED('CorpMainMTScrubsReportWithExamples'+filedate))																		
																		//Send Alerts if Scrubs exceeds thresholds
																		,IF(COUNT(Main_ScrubsAlert) > 0, Main_SendEmailFile, OUTPUT('CORP2_MAPPING.MT - No "MAIN" Corp Scrubs Alerts'))
																		,Main_ErrorSummary
																		,Main_ScrubErrorReport
																		,Main_SomeErrorValues
																		//,Main_AlertsCSVTemplate
																		,Main_SubmitStats);
																			 
	
 //-------------------- Version Control -----------------------------------------------------//	
	VersionControl.macBuildNewLogicalFile('~thor_data400::in::corp2::'+version+'::main_mt'			,Main_ApprovedRecords ,main_out		     ,,,pOverwrite);		
	VersionControl.macBuildNewLogicalFile('~thor_data400::in::corp2::'+version+'::stock_mt'			,MapStock	            ,stock_out	     ,,,pOverwrite);
	VersionControl.macBuildNewLogicalFile('~thor_data400::in::corp2::'+version+'::ar_mt'				,MapAR		            ,ar_out			     ,,,pOverwrite);
	
	VersionControl.macBuildNewLogicalFile('~thor_data400::failed::corp2::'+version+'::main_mt'	,MapMain              ,write_fail_main ,,,pOverwrite);		
		
	mapMT:= sequential(   if(pshouldspray = true,Corp2_mapping.fSprayFiles(state_origin ,version,pOverwrite := pOverwrite))
											 	,main_out
												,ar_out
												,stock_out										
												,IF(Main_FailBuild <> true 
												  	,sequential( fileservices.addsuperfile(Corp2_Mapping._Dataset().thor_cluster_Files + 'in::'+Corp2_Mapping._Dataset().NameMapped+'::sprayed::ar'		,Corp2_Mapping._Dataset().thor_cluster_Files + 'in::corp2::'+version+'::ar_MT')
																				,fileservices.addsuperfile(Corp2_Mapping._Dataset().thor_cluster_Files + 'in::'+Corp2_Mapping._Dataset().NameMapped+'::sprayed::main'	,Corp2_Mapping._Dataset().thor_cluster_Files + 'in::corp2::'+version+'::Main_MT')																		 
																				,fileservices.addsuperfile(Corp2_Mapping._Dataset().thor_cluster_Files + 'in::'+Corp2_Mapping._Dataset().NameMapped+'::sprayed::stock',Corp2_Mapping._Dataset().thor_cluster_Files + 'in::corp2::'+version+'::stock_MT')
																				,if (count(Main_BadRecords) <> 0  
																						 ,Corp2_Mapping.Send_Email(state_origin ,version,count(Main_BadRecords)<>0,,,,count(Main_BadRecords),,,,count(Main_ApprovedRecords),count(mapAR),,count(mapStock)).RecordsRejected																				 
																						 ,Corp2_Mapping.Send_Email(state_origin ,version,count(Main_BadRecords)<>0,,,,count(Main_BadRecords),,,,count(Main_ApprovedRecords),count(mapAR),,count(mapStock)).MappingSuccess																				 
																						 )	 
																			)
														 ,sequential( write_fail_main //if it fails on main file threshold ,still writing mapped files!
																				 ,Corp2_Mapping.Send_Email(state_origin ,version).MappingFailed
																				)
													)
												,if (Main_IsScrubErrors 
														,Corp2_Mapping.Send_Email(state_origin,version,Main_IsScrubErrors).FieldsInvalidPerScrubs)
												,Main_MT	
										);
															
		isFileDateValid := if((string)Std.Date.Today() between ut.date_math(filedate,-31) and ut.date_math(filedate,31),true,false);
		return sequential (if (isFileDateValid 
														,mapMT
														,sequential (Corp2_Mapping.Send_Email(state_origin,filedate).InvalidFileDateParm
																				,FAIL('Corp2_Mapping.MT failed.  An invalid filedate was passed in as a parameter.')))); 	

 End; //Update Function

End;//End MT Module