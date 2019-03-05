IMPORT ut, corp2_raw_ne, tools, corp2, versioncontrol, Scrubs, scrubs_corp2_mapping_ne_main, Scrubs_corp2_mapping_ne_Event, std;

EXPORT NE  := MODULE; 

	export Update(string fileDate, string version, boolean pShouldSpray = _Dataset().bShouldSpray, boolean pOverwrite = false, pUseProd = Tools._Constants.IsDataland) :=Function

		state_origin			:= 'NE';
		state_fips	 			:= '31';
		state_desc	 			:= 'NEBRASKA';
		
		CorpEntity				:= dedup(sort(distribute(Corp2_Raw_NE.Files(filedate,pUseProd).input.CorpEntity,hash(AcctNumber)),record,local),record,local)   : independent;
	  RegisteredAgent	  := dedup(sort(distribute(Corp2_Raw_NE.Files(filedate,pUseProd).input.RegisteredAgent,hash(AgentId)),record,local),record,local): independent;			
		CorpOfficers		  := dedup(sort(distribute(Corp2_Raw_NE.Files(filedate,pUseProd).input.CorpOfficers,hash(AcctNumber)),record,local),record,local) : independent;
		CorpActions				:= dedup(sort(distribute(Corp2_Raw_NE.Files(filedate,pUseProd).input.CorpActions,hash(AcctNumber)),record,local),record,local)   : independent;

		CorpTypeTable  	  := Corp2_Raw_NE.Files(filedate,pUseProd).input.CorpTypeTable     : independent;	 	
		ListOfStatesTable := Corp2_Raw_NE.Files(filedate,pUseProd).input.ListOfStatesTable : independent;	 
		CountryCodesTable	:= Corp2_Raw_NE.Files(filedate,pUseProd).input.CountryCodesTable : independent;	 
	
		//Corporation Recs Mappings
		
		//--------------------- Merge  RA_Agents ------------------------------------------
		CorpEntity_dist	:= distribute(CorpEntity,hash(RegAgentId));  // Distribute on RegAgentId for join to RegisteredAgent 
		DsEntityWithRA 	:= join(CorpEntity_dist, RegisteredAgent(corp2.t2u(AgentId) not in ['6178','175919']),	
														corp2.t2u(left.RegAgentId) = corp2.t2u(right.AgentId),
														transform(Corp2_Raw_NE.Layouts.Temp_CorpEntityWithRA,
																			self 	:= left;
																			self	:= right;
																			self  := [];	),
														left outer,local);

		//--------------------- Add CorpType Code ------------------------------------------
		DsEntityRA_CorpTypeDesc := join(DsEntityWithRA ,CorpTypeTable,
																		corp2.t2u(left.corptype) = corp2.t2u(right.description),
																		transform(Corp2_Raw_NE.Layouts.Temp_CorpEntityWithRA,
																							self.CorpTypeCode := right.Id; 
																							self 							:= left;
																							self  						:= [];),
																		 left outer, lookup);	
		
		//--------------------- Add State Description ----------------------------------------
		DsEntity_Stdesc 				:= join(DsEntityRA_CorpTypeDesc ,ListOfStatesTable,
																		corp2.t2u(left.QualifyingState) = corp2.t2u(right.stateCode) and corp2.t2u(right.StateCodeID) not in ['00',''],
																		transform(Corp2_Raw_NE.Layouts.Temp_CorpEntityWithRA,
																							self.StDesc := corp2.t2u(right.description); 
																							self 				:= left;
																							self  			:= [];),
																		left outer, lookup);	
		
		//--------------------- Add Country Description ----------------------------------------
		DsEntity_Cntrydesc 			:= join(DsEntity_Stdesc ,CountryCodesTable,
																	  corp2.t2u(left.CountryCode) = corp2.t2u(right.Code), 
																	  transform(Corp2_Raw_NE.Layouts.Temp_CorpEntityWithRA,
																						  self.CntryDesc := corp2.t2u(right.Description); 
																						  self 					 := left;
																							self  			   := [];),
																	  left outer, lookup);			
																		 
		corp2_mapping.LayoutsCommon.Main  corpMainTransform(Corp2_Raw_NE.Layouts.Temp_CorpEntityWithRA input,integer ctr):= transform,
				skip((ctr = 2 and 
							corp2.t2u(input.streetaddress1   +input.streetaddress2   +input.City   +input.state   +input.zipCode) = 
							corp2.t2u(input.DO_streetaddress1+input.DO_streetaddress2+input.DO_City+input.DO_state+input.DO_zipCode)) 
						)
			self.dt_vendor_first_reported							:=(integer)fileDate;
			self.dt_vendor_last_reported							:=(integer)fileDate;
			self.dt_first_seen												:=(integer)fileDate;
			self.dt_last_seen													:=(integer)fileDate;
			self.corp_ra_dt_first_seen								:=(integer)fileDate;
			self.corp_ra_dt_last_seen									:=(integer)fileDate;
			self.corp_process_date										:= fileDate;    	
			self.corp_key					    		  					:= state_fips +'-'+ corp2.t2u(input.AcctNumber);		
			self.corp_vendor													:= state_fips;		
			self.corp_state_origin										:= state_origin;
			self.corp_inc_state 										  := state_origin; 
			self.corp_orig_sos_charter_nbr						:= corp2.t2u(input.AcctNumber);				
			self.corp_legal_name											:= corp2_mapping.fCleanBusinessName(state_origin,state_desc,input.CorpStateName).BusinessName;
			self.corp_home_state_name									:= corp2_mapping.fCleanBusinessName(state_origin,state_desc,input.forgncorpname).BusinessName;
			self.corp_ln_name_type_cd									:= corp2_Raw_NE.Functions.NameTypeCode(input.CorpTypeCode);						
			self.corp_ln_name_type_desc								:= map(self.corp_ln_name_type_cd = '01'=>'LEGAL',
																											 self.corp_ln_name_type_cd = '03'=>'TRADEMARK',	
																											 self.corp_ln_name_type_cd = '04'=>'TRADENAME',
																											 self.corp_ln_name_type_cd = '05'=>'SERVICEMARK',
																											 self.corp_ln_name_type_cd = '07'=>'RESERVED', 
																											 self.corp_ln_name_type_cd = '09'=>'REGISTRATION',
																											 '');
			self.corp_orig_org_structure_cd					  := corp2.t2u(input.CorpTypeCode);															
			self.corp_orig_org_structure_desc				  := corp2.t2u(input.corptype);
			self.corp_for_profit_ind        					:= if(corp2.t2u(input.CorpTypeCode)in
																										 ['10159','10160','10162','10207','10208','10217','10218'],
																											'N',''); 
			self.corp_status_cd												:= case(corp2.t2u(input.Status),
																												'ACTIVE'   =>'A',
																												'INACTIVE' =>'I',
																												'SUSPENDED'=>'S',
																												'');
			self.corp_status_desc										 	:= corp2.t2u(input.Status);	//Scrubbing										
			self.corp_foreign_domestic_ind						:= map(corp2.t2u(input.QualifyingState)in[state_origin,''] and corp2.t2u(input.corptypecode) in Corp2_Raw_NE.Functions.domestic_type =>'D',
																											 corp2.t2u(input.QualifyingState)not in[state_origin] and corp2.t2u(input.corptypecode) in Corp2_Raw_NE.Functions.foreign_type =>'F',
																											 corp2.t2u(input.corptypecode) in Corp2_Raw_NE.Functions.foreign_type										 		 																	 =>'F',
																											 corp2.t2u(input.corptypecode) in Corp2_Raw_NE.Functions.domestic_type    																										 =>'D',
																											 '');
			valid_Date                              	:= corp2_mapping.fValidateDate(input.DateIncorp[1..10],'CCYY-MM-DD').PastDate;																								
			self.corp_inc_date												:= if(corp2.t2u(input.corptypecode) not in ['10221',Corp2_Raw_NE.Functions.foreign_type]
			                                                ,valid_Date ,'');
			self.corp_forgn_date											:= if(corp2.t2u(input.corptypecode) in Corp2_Raw_NE.Functions.foreign_type
			                                                ,valid_Date ,'');	
			self.corp_filing_date											:= if(corp2.t2u(input.corptypecode) = '10221' ,valid_Date ,'');
			self.corp_trademark_filing_date						:= if(corp2.t2u(input.corptypecode) = '10221' ,valid_Date ,'');
			self.corp_forgn_state_cd									:= if(corp2.t2u(input.QualifyingState) not in [state_origin,''],corp2.t2u(input.QualifyingState),'')	;												 											 
			self.corp_forgn_state_desc								:= if(corp2.t2u(input.QualifyingState) not in [state_origin,''],corp2.t2u(input.StDesc),'')	;	
			self.corp_country_of_formation		    		:= corp2.t2u(input.CntryDesc);
			self.corp_inc_county                      := corp2.t2u(input.countycode);
		  self.corp_address1_line1                  := choose(ctr	,corp2_mapping.fCleanAddress(state_origin,state_desc,input.streetaddress1,input.streetaddress2,input.City,input.state,input.zipCode,input.CntryDesc).AddressLine1
																															,corp2_mapping.fCleanAddress(state_origin,state_desc,input.DO_streetaddress1,input.DO_streetaddress2,input.DO_City,input.DO_state,input.DO_zipCode).AddressLine1);
			self.corp_address1_line2                  := choose(ctr	,corp2_mapping.fCleanAddress(state_origin,state_desc,input.streetaddress1,input.streetaddress2,input.City,input.state,input.zipCode,input.CntryDesc).AddressLine2
																															,corp2_mapping.fCleanAddress(state_origin,state_desc,input.DO_streetaddress1,input.DO_streetaddress2,input.DO_City,input.DO_state,input.DO_zipCode).AddressLine2);
			self.corp_address1_line3                  := choose(ctr	,corp2_mapping.fCleanAddress(state_origin,state_desc,input.streetaddress1,input.streetaddress2,input.City,input.state,input.zipCode,input.CntryDesc).AddressLine3
																															,corp2_mapping.fCleanAddress(state_origin,state_desc,input.DO_streetaddress1,input.DO_streetaddress2,input.DO_City,input.DO_state,input.DO_zipCode).AddressLine3);	
			self.corp_prep_addr1_line1                := choose(ctr	,corp2_mapping.fCleanAddress(state_origin,state_desc,input.streetaddress1,input.streetaddress2,input.City,input.state,input.zipCode,input.CntryDesc).PrepAddrLine1
																															,corp2_mapping.fCleanAddress(state_origin,state_desc,input.DO_streetaddress1,input.DO_streetaddress2,input.DO_City,input.DO_state,input.DO_zipCode).PrepAddrLine1);		
			self.corp_prep_addr1_last_line            := choose(ctr	,corp2_mapping.fCleanAddress(state_origin,state_desc,input.streetaddress1,input.streetaddress2,input.City,input.state,input.zipCode,input.CntryDesc).PrepAddrLastLine
																															,corp2_mapping.fCleanAddress(state_origin,state_desc,input.DO_streetaddress1,input.DO_streetaddress2,input.DO_City,input.DO_state,input.DO_zipCode).PrepAddrLastLine);		
		  self.corp_address1_type_cd                := choose(ctr	,if(corp2.t2u(input.corptype)not in Corp2_Raw_NE.Functions.contact_types
																																	,if(corp2_mapping.fAddressExists(state_origin,state_desc,input.streetaddress1,input.streetaddress2,input.City,input.state,input.zipCode,input.CntryDesc).ifAddressExists,'B','')
																																	,if(corp2_mapping.fAddressExists(state_origin,state_desc,input.streetaddress1,input.streetaddress2,input.City,input.state,input.zipCode,input.CntryDesc).ifAddressExists,'T',''))
																															,if(corp2_mapping.fAddressExists(state_origin,state_desc,input.DO_streetaddress1,input.DO_streetaddress2,input.DO_City,input.DO_state,input.DO_zipCode).ifAddressExists,'D','')
																											    );	
			self.corp_address1_type_desc              := choose(ctr	,if(corp2.t2u(input.corptype)not in Corp2_Raw_NE.Functions.contact_types
																																	,if(corp2_mapping.fAddressExists(state_origin,state_desc,input.streetaddress1,input.streetaddress2,input.City,input.state,input.zipCode,input.CntryDesc).ifAddressExists,'BUSINESS','')
																																	,if(corp2_mapping.fAddressExists(state_origin,state_desc,input.streetaddress1,input.streetaddress2,input.City,input.state,input.zipCode,input.CntryDesc).ifAddressExists,'CONTACT',''))
																															,if(corp2_mapping.fAddressExists(state_origin,state_desc,input.DO_streetaddress1,input.DO_streetaddress2,input.DO_City,input.DO_state,input.DO_zipCode).ifAddressExists,'DESIGNATED OFFICE','')
																											    );																										
			self.corp_orig_bus_type_desc							:= if(not ut.isNumeric(corp2.t2u(input.NatureOfBusiness)),corp2.t2u(input.NatureOfBusiness),'');
			TempDurationVal														:= map(corp2.t2u(input.duration)[1] = 'P'                           =>'P',												 
																											 corp2.t2u(input.duration) = 'CONDITIONAL'										=>'',
																											 regexfind('(.*)/(.*)/(.*)',corp2.t2u(input.duration)[1..10]) =>'D',  // Per CI: A year & date are populated together, just map the date EX: 01/01/2080 75 YEARS
																											 regexfind('^[0-9]*[ ]*YEARS?$',corp2.t2u(input.duration))		=>'N',  //  EX: 5 Years
																											 '');		
			ExpirationDate														:= corp2_mapping.fValidateDate(input.ExpirationDate[1..10],'CCYY-MM-DD').GeneralDate;								  																 						
			self.corp_term_exist_cd             			:= map(TempDurationVal = 'D' => 'D',
																											 TempDurationVal = 'P' => 'P',																											 
																											 TempDurationVal = 'N' => 'N',
																											 expirationDate  <> '' => 'D',																											 
																											 '');														  																		 
			self.corp_term_exist_desc									:= map(TempDurationVal = 'D' => 'EXPIRATION DATE',
																											 TempDurationVal = 'P' => 'PERPETUAL',	
																											 TempDurationVal = 'N' => 'NUMBER OF YEARS',
																											 expirationDate  <> '' => 'EXPIRATION DATE',
																											 '');											       															        		
			self.corp_term_exist_exp									:= map(TempDurationVal  = 'D'  => corp2_mapping.fValidateDate(input.duration[1..10],'MM/DD/CCYY').GeneralDate,		
																											 TempDurationVal  = 'N'  => regexfind('^[0-9]*',corp2.t2u(input.duration),0),
																											 expirationDate   <> ''  => expirationDate,
																											 '');	
			regAgentName                              := if(corp2.t2u(input.regAgentName) <> ''
																											,corp2.t2u(input.regAgentName)
																											,input.firstname +' '+ input.lastname);																								 
			self.corp_ra_full_name										:= corp2_mapping.fCleanBusinessName(state_origin,state_desc,regAgentName).BusinessName;
			self.corp_ra_address_line1            		:= corp2_mapping.fCleanAddress(state_origin,state_desc,input.RAStreetAddress1,input.RAStreetAddress2,input.RACity,input.RAState,input.RAZipcode).addressline1;
			self.corp_ra_address_line2								:= corp2_mapping.fcleanaddress(state_origin,state_desc,input.RAStreetAddress1,input.RAStreetAddress2,input.RACity,input.RAState,input.RAZipcode).addressline2;
			self.corp_ra_address_line3								:= corp2_mapping.fcleanaddress(state_origin,state_desc,input.RAStreetAddress1,input.RAStreetAddress2,input.RACity,input.RAState,input.RAZipcode).addressline3;
			self.ra_prep_addr_line1										:= corp2_mapping.fcleanaddress(state_origin,state_desc,input.RAStreetAddress1,input.RAStreetAddress2,input.RACity,input.RAState,input.RAZipcode).prepaddrline1;
			self.ra_prep_addr_last_line								:= corp2_mapping.fcleanaddress(state_origin,state_desc,input.RAStreetAddress1,input.RAStreetAddress2,input.RACity,input.RAState,input.RAZipcode).prepaddrlastline;
			self.corp_ra_address_type_cd		  				:= if(corp2_mapping.fAddressExists(state_origin,state_desc,input.RAStreetAddress1,input.RAStreetAddress2,input.RACity,input.RAState,input.RAZipcode).ifAddressExists , 'R', '');
			self.corp_ra_address_type_desc						:= if(corp2_mapping.fAddressExists(state_origin,state_desc,input.RAStreetAddress1,input.RAStreetAddress2,input.RACity,input.RAState,input.RAZipcode).ifAddressExists , 'REGISTERED OFFICE', '');									 
			// For scrub purposes; new vendor corptype values will be captured.  Corptype values are crucial for dates & indicator fields.
			self.internalfield1												:= if(corp2.t2u(input.CorpTypeCode)not in[Corp2_Raw_NE.Functions.domestic_type ,Corp2_Raw_NE.Functions.foreign_type]  
																											  and corp2.t2u(input.CorpType)not in[Corp2_Raw_NE.Functions.contact_types] 
																											  and self.CORP_LN_NAME_TYPE_CD not in ['01','03','04','05','07','09']
																											,'**|'+ corp2.t2u(input.CorpTypeCode)+'|'+corp2.t2u(input.CorpType) ,'');
			self.recordOrigin													:= 'C';	
			self																			:= [];

		end;

		mapCorp     := Normalize(DsEntity_Cntrydesc, 
														if(corp2.t2u(left.DO_streetaddress1+left.DO_streetaddress2+left.DO_City+left.DO_state+left.DO_zipCode)<>''
														,2,1) ,corpMainTransform(left, counter));

		//FOREIGN NAME Recs Mappings & Overloaded Transform
		corp2_mapping.LayoutsCommon.Main corpForgnNameTransform(Corp2_Raw_NE.Layouts.Temp_CorpEntityWithRA input):= transform,
				skip(corp2.t2u(input.forgnCorpName) = '')

			self.dt_vendor_first_reported		 			:= (integer)fileDate;
			self.dt_vendor_last_reported		 			:= (integer)fileDate;
			self.dt_first_seen							 			:= (integer)fileDate;
			self.dt_last_seen								 			:= (integer)fileDate;
			self.corp_ra_dt_first_seen			 			:= (integer)fileDate;
			self.corp_ra_dt_last_seen				 			:= (integer)fileDate;	
			self.corp_process_date				  			:= fileDate; 
			self.corp_key													:= state_fips +'-'+corp2.t2u(input.AcctNumber);
			self.corp_vendor											:= state_fips ;
			self.corp_state_origin								:= state_origin ;			
			self.corp_inc_state 									:= state_origin ; 
			self.corp_orig_sos_charter_nbr				:= corp2.t2u(input.AcctNumber);	
			self.corp_legal_name									:= corp2_mapping.fCleanBusinessName(state_origin,state_desc,input.forgnCorpName).BusinessName;
			self.corp_ln_name_type_cd 						:= '10';
			self.corp_ln_name_type_desc 					:= 'HOME STATE NAME'; 
			self.corp_name_comment							  := 'HOME STATE NAME';
			valid_Date                           	:= corp2_mapping.fValidateDate(input.DateIncorp[1..10],'CCYY-MM-DD').PastDate;
			self.corp_inc_date										:= if(corp2.t2u(input.corptypecode) not in ['10221',Corp2_Raw_NE.Functions.foreign_type]
			                                            ,valid_Date ,'');
			self.corp_forgn_date									:= if(corp2.t2u(input.corptypecode) in Corp2_Raw_NE.Functions.foreign_type
			                                            ,valid_Date ,'');														 			
			self.recordOrigin											:= 'C';			
			self																	:= [];
		end;

		mapCorpForgn	:= project(DsEntity_Cntrydesc ,corpForgnNameTransform(left));
		
		//Contact Recs Mappings from CorpEntity	
		corp2_mapping.LayoutsCommon.Main    contTransform1(Corp2_Raw_NE.Layouts.CorpEntityLayoutIn input) := transform,
			skip (corp2.t2u(input.corptype) not in Corp2_Raw_NE.Functions.contact_types or corp2.t2u(input.AcctNumber) = '' or
						corp2_mapping.fCleanBusinessName(state_origin,state_desc,input.name).BusinessName = '')
			// Per Rosemary, leaving this code in place even though currently none of these records would be built, 
			// because the vendor has the "name" field in their layout, but it is not being populated at this time.
			self.dt_vendor_first_reported		 			:= (integer)fileDate;
			self.dt_vendor_last_reported		 			:= (integer)fileDate;
			self.dt_first_seen							 			:= (integer)fileDate;
			self.dt_last_seen								 			:= (integer)fileDate;
			self.corp_ra_dt_first_seen			 			:= (integer)fileDate;
			self.corp_ra_dt_last_seen				 			:= (integer)fileDate;	
			self.corp_process_date				  			:= fileDate; 
			self.corp_key													:= state_fips +'-'+corp2.t2u(input.AcctNumber);
			self.corp_vendor											:= state_fips ;
			self.corp_state_origin								:= state_origin;				
			self.corp_inc_state 									:= state_origin; 
			self.corp_orig_sos_charter_nbr				:= corp2.t2u(input.AcctNumber);		
			self.corp_legal_name									:= corp2_mapping.fCleanBusinessName(state_origin,state_desc,input.CorpStateName).BusinessName;	
			self.Cont_full_name               		:= corp2_mapping.fCleanBusinessName(state_origin,state_desc,input.name).BusinessName;	
			self.cont_type_cd											:= 'O/I';
			self.cont_type_desc										:= 'OWNER/APPLICANT';
			self.cont_address_line1								:= corp2_mapping.fCleanAddress(state_origin,state_desc,input.streetaddress1,input.streetaddress2,input.City,input.state,input.zipCode).AddressLine1;
			self.cont_address_line2				 				:= corp2_mapping.fCleanAddress(state_origin,state_desc,input.streetaddress1,input.streetaddress2,input.City,input.state,input.zipCode).AddressLine2;
			self.cont_address_line3				  			:= corp2_mapping.fCleanAddress(state_origin,state_desc,input.streetaddress1,input.streetaddress2,input.City,input.state,input.zipCode).AddressLine3;
			self.cont_prep_addr_line1							:= corp2_mapping.fCleanAddress(state_origin,state_desc,input.streetaddress1,input.streetaddress2,input.City,input.state,input.zipCode).PrepAddrLine1;
			self.cont_prep_addr_last_line					:= corp2_mapping.fCleanAddress(state_origin,state_desc,input.streetaddress1,input.streetaddress2,input.City,input.state,input.zipCode).PrepAddrLastLine;
			self.cont_Address_type_cd         		:= if(corp2_mapping.fAddressExists(state_origin,state_desc,input.streetaddress1,input.streetaddress2,input.City,input.state,input.zipCode).ifAddressExists,
																									'T','');
			self.cont_Address_type_desc         	:= if(corp2_mapping.fAddressExists(state_origin,state_desc,input.streetaddress1,input.streetaddress2,input.City,input.state,input.zipCode).ifAddressExists,
																									'CONTACT','');	
			self.cont_address_county              := corp2.t2u(input.countycode);
			self.recordOrigin										  := 'T';			
			self																  := [];

		end;

		mapContEntity	:= project(CorpEntity,contTransform1(left));
		
	  //Contact Recs Mappings from CorpOfficers	
		dsCorpOfficerWithEntity		:= join(CorpOfficers,CorpEntity,
																			corp2.t2u(left.AcctNumber) = corp2.t2u(right.AcctNumber),
																			transform(Corp2_Raw_NE.Layouts.Temp_OfficersWithEntity,
																								self	:= left ;	
																								self	:= right;),
																			left outer,local) :independent;
												
		corp2_mapping.LayoutsCommon.Main    contTransform2(Corp2_Raw_NE.Layouts.Temp_OfficersWithEntity input,integer ctr) := transform,
			skip(corp2_mapping.fCleanBusinessName(state_origin,state_desc,input.FirstName + ' ' +input.MiddleName + ' ' + input.LastName).BusinessName= '')

			self.dt_vendor_first_reported		 			:= (integer)fileDate;
			self.dt_vendor_last_reported		 			:= (integer)fileDate;
			self.dt_first_seen							 			:= (integer)fileDate;
			self.dt_last_seen								 			:= (integer)fileDate;
			self.corp_ra_dt_first_seen			 			:= (integer)fileDate;
			self.corp_ra_dt_last_seen				 			:= (integer)fileDate;	
			self.corp_process_date				  			:= fileDate; 
			self.corp_key													:= state_fips +'-'+corp2.t2u(input.AcctNumber);
			self.corp_vendor											:= state_fips ;
			self.corp_state_origin								:= state_origin ;				
			self.corp_inc_state 									:= state_origin ; 
			self.corp_orig_sos_charter_nbr				:= corp2.t2u(input.AcctNumber);	
			self.corp_legal_name									:= corp2_mapping.fCleanBusinessName(state_origin,state_desc,input.CorpStateName).BusinessName;
			self.Cont_full_name               		:= corp2_mapping.fCleanBusinessName(state_origin,state_desc,input.FirstName + ' ' +input.MiddleName + ' ' + input.LastName).BusinessName;
			self.cont_address_line1								:= corp2_mapping.fCleanAddress(State_origin,State_desc,input.OfcrStreetAddress1,input.OfcrStreetAddress2,input.OfcrCity,input.OfcrState,input.OfcrZipcode).AddressLine1;
			self.cont_address_line2								:= corp2_mapping.fCleanAddress(State_origin,State_desc,input.OfcrStreetAddress1,input.OfcrStreetAddress2,input.OfcrCity,input.OfcrState,input.OfcrZipcode).AddressLine2;
			self.cont_address_line3								:= corp2_mapping.fCleanAddress(State_origin,State_desc,input.OfcrStreetAddress1,input.OfcrStreetAddress2,input.OfcrCity,input.OfcrState,input.OfcrZipcode).AddressLine3;
			self.cont_prep_addr_line1							:= corp2_mapping.fCleanAddress(State_origin,State_desc,input.OfcrStreetAddress1,input.OfcrStreetAddress2,input.OfcrCity,input.OfcrState,input.OfcrZipcode).PrepAddrline1;
			self.cont_prep_addr_last_line					:= corp2_mapping.fCleanAddress(State_origin,State_desc,input.OfcrStreetAddress1,input.OfcrStreetAddress2,input.OfcrCity,input.OfcrState,input.OfcrZipcode).PrepAddrLastLine;
			self.cont_Address_type_cd          		:= if(corp2_mapping.fAddressExists(State_origin,State_desc,input.OfcrStreetAddress1,input.OfcrStreetAddress2,input.OfcrCity,input.OfcrState,input.OfcrZipcode).ifAddressExists ,'T','');
			self.cont_Address_type_desc        		:= if(corp2_mapping.fAddressExists(State_origin,State_desc,input.OfcrStreetAddress1,input.OfcrStreetAddress2,input.OfcrCity,input.OfcrState,input.OfcrZipcode).ifAddressExists ,'CONTACT','');
			
			self.cont_title1_desc           		  := if(corp2.t2u(input.PositionHeld) not in corp2_Raw_NE.Functions.Invalid_Titles, corp2.t2u(input.PositionHeld) ,'');
			// overloaded field
			self.cont_type_cd										  := map(corp2.t2u(input.PositionHeld) in ['PRESIDENT','SECRETARY',
																																										 'TREASURER','DIRECTOR'] => 'F',			                          
			                          									 corp2.t2u(input.PositionHeld) in ['MEMBER','MANAGER']     => 'M',										
																									 '');
			// overloaded field
			self.cont_type_desc									  := map(corp2.t2u(input.PositionHeld) in ['PRESIDENT','SECRETARY',
																																									   'TREASURER','DIRECTOR'] => 'OFFICER',			                          
			                          								   corp2.t2u(input.PositionHeld) in ['MEMBER','MANAGER']     => 'MEMBER/MANAGER',										
																									 '');
			self.Cont_filing_date							 	 := corp2_mapping.fValidateDate(input.FilingDateTime[1..10],'CCYY-MM-DD').PastDate;	
			
			self.cont_effective_date 						 := choose(ctr
																										 ,corp2_mapping.fValidateDate(input.DateTakingOffice[1..10],'CCYY-MM-DD').PastDate
																										 ,corp2_mapping.fValidateDate(input.YearOutReported[4..7]+'-'+input.YearOutReported[1..2]+'-01','CCYY-MM-DD').PastDate);
			self.cont_effective_cd  						 := if(self.cont_effective_date <> '' ,choose(ctr,'A','T'), '');					
			self.cont_effective_desc 						 := if(self.cont_effective_date <> '' ,choose(ctr,'ASSIGNED','TERMINATION'), '');
			self.recordOrigin										 := 'T';			
			self																 := [];

		end;

		mapContOfficers		:= normalize(dsCorpOfficerWithEntity, if(corp2.t2u(left.YearOutReported)<>'',2,1),
															 contTransform2(left,counter));

		AllCorps	    := dedup(sort(distribute(mapCorp +  
																					 mapCorpForgn +  
																					 mapContEntity	+ 
																					 mapContOfficers , hash(corp_key)),
														record,local),record,local) :independent;

		
		//AR Recs Mappings  							
		corp2_mapping.LayoutsCommon.AR arTransform1(Corp2_Raw_NE.Layouts.CorpActionsLayoutIn input):= transform,
			skip(corp2.t2u(input.FilingTypeId) not in Corp2_Raw_NE.Functions.Set_Of_AR_Codes or
					 corp2.t2u(input.AcctNumber) = '' or
					 (integer)(input.taxpayment) = 0 and (integer)(input.taxreportnumber)= 0 and corp2_mapping.fValidateDate(input.taxReceiptDate[1..10],'CCYY-MM-DD').PastDate='' and
					 (integer)(input.DocumentNumber)= 0 and trim(input.FilingTypeDescription)= '' and corp2_mapping.fValidateDate(input.FilingDateTime[1..10],'CCYY-MM-DD').PastDate='' 
					 )
				 
			self.corp_key								:= state_fips +'-'+corp2.t2u(input.AcctNumber);
			self.corp_vendor						:= state_fips ;
			self.corp_state_origin			:= state_origin ;
			self.corp_process_date			:= fileDate;		
			self.corp_sos_charter_nbr 	:= corp2.t2u(input.AcctNumber);	
			self.ar_filed_dt						:= corp2_mapping.fValidateDate(input.FilingDateTime[1..10],'CCYY-MM-DD').PastDate;															
			self.ar_type								:= corp2.t2u(input.FilingTypeDescription);	
			self.ar_report_nbr				 	:= if((integer)(input.DocumentNumber)<> 0,corp2.t2u(input.DocumentNumber),'');
			self.ar_tax_amount_paid	    := if((integer)(input.taxpayment)<> 0,corp2.t2u(input.taxpayment),'');
			taxRptDate          				:= corp2_mapping.fValidateDate(input.taxReceiptDate[1..10],'CCYY-MM-DD').PastDate;	
			self.ar_paid_date           := taxRptDate;										
			taxRptNum                   := if((integer)(input.taxreportnumber)<> 0,Corp2.t2u(input.taxreportnumber),'');
			self.ar_comment             := map(trim(taxRptNum)<>'' and trim(taxRptDate)<>''=>'TAX REPORT NUMBER: '+taxRptNum+' '+'TAX RECEIPT DATE: '+taxRptDate,
																				 trim(taxRptNum)<>'' 												 =>'TAX REPORT NUMBER: '+taxRptNum ,
																				 trim(taxRptDate)<>''												 =>'TAX RECEIPT DATE: '+taxRptDate ,
																					'');  //'TAX RECEIPT DATE' overload verbiage 
			self											  := []; 

		end;

		ds_mapAr	:= project(CorpActions,arTransform1(left));
		MapAr			:= dedup(sort(distribute(ds_mapAr	,hash(corp_key)),
														record,local),record,local):independent; 
		
		//Event Recs Mappings  
		corp2_mapping.LayoutsCommon.Events EventTransform(Corp2_Raw_NE.Layouts.CorpActionsLayoutIn input,integer ctr):= transform,
			skip(corp2.t2u(input.AcctNumber) = '' or
			     corp2.t2u(input.FilingTypeId) in Corp2_Raw_NE.Functions.Set_Of_AR_Codes or
			     ctr = 2 and corp2_mapping.fValidateDate(input.FilingDateTime[1..10],'CCYY-MM-DD').PastDate = corp2_mapping.fValidateDate(input.EffectiveDate[1..10],'CCYY-MM-DD').GeneralDate or
		       (integer)(input.DocumentNumber)= 0 and corp2.t2u(input.FilingTypeDescription) = '' and corp2_mapping.fValidateDate(input.FilingDateTime[1..10],'CCYY-MM-DD').PastDate='' and
				   corp2_mapping.fValidateDate(input.EffectiveDate[1..10],'CCYY-MM-DD').GeneralDate=''
				   )
      self.corp_key										:= state_fips+'-' + corp2.t2u(input.AcctNumber);
			self.corp_vendor								:= state_fips ;
			self.corp_state_origin					:= state_origin ;
			self.corp_process_date					:= fileDate;
			self.corp_sos_charter_nbr 			:= corp2.t2u(input.AcctNumber);	
			self.event_filing_reference_nbr	:= if((integer)(input.DocumentNumber)<> 0,corp2.t2u(input.DocumentNumber),'');
			cleanFilDate                    := corp2_mapping.fValidateDate(input.FilingDateTime[1..10],'CCYY-MM-DD').PastDate;
			cleanEffDate 								    := corp2_mapping.fValidateDate(input.EffectiveDate[1..10],'CCYY-MM-DD').GeneralDate;
			self.event_filing_date         	:= choose(ctr,cleanFilDate,cleanEffDate);
			self.event_date_type_cd         := if(self.event_filing_date <> '' ,choose(ctr,'FIL','EFF') ,'');					
			self.event_date_type_desc       := if(self.event_filing_date <> '' ,choose(ctr,'FILING','EFFECTIVE') ,'');	
			self.event_filing_cd						:= corp2.t2u(input.FilingTypeId);
			self.event_filing_desc					:= corp2.t2u(input.FilingTypeDescription);
			// scrubs will catch codes that are neither AR recs or Event recs. 
			self.InternalField1             := if(corp2.t2u(input.FilingTypeId) not in Corp2_Raw_NE.Functions.Set_Of_Event_Codes
																						,'**|'+corp2.t2u(input.FilingTypeId)+'|'+corp2.t2u(input.FilingTypeDescription),'');
			self          									:= [];

		end;

		dsEvents			:= Normalize(CorpActions, if(corp2.t2u(left.EffectiveDate)<>'',2,1), EventTransform(left, counter)) (trim(event_filing_cd)<>''):independent;
    mapEvents			:= dedup(sort(distribute(dsEvents,hash(corp_key)),
																record,local),record,local):independent;
 		//--------------------------------------------------------------------	
		//	Scrubs for MAIN
		//--------------------------------------------------------------------
		Main_F 										:= AllCorps;
		Main_S 										:= Scrubs_corp2_mapping_NE_Main.Scrubs; 				     // Scrubs module
		Main_N 										:= Main_S.FromNone(Main_F); 											  // Generate the error flags
		Main_T 										:= Main_S.FromBits(Main_N.BitmapInfile);     		 	 // Use the FromBits module; makes my bitmap datafile easier to get to
		Main_U 										:= Main_S.FromExpanded(Main_N.ExpandedInFile); 		// Pass the expanded error flags into the Expanded module

		//Outputs reports
		Main_ErrorSummary					:= output(Main_U.SummaryStats, named('Main_ErrorSummary_NE_'+filedate ));
		Main_ScrubErrorReport 		:= output(choosen(Main_U.AllErrors, 1000), named('Main_ScrubErrorReport_NE_'+filedate ));
		Main_SomeErrorValues			:= output(choosen(Main_U.BadValues, 1000), named('Main_SomeErrorValues_NE_'+filedate ));
		Main_IsScrubErrors		 		:= IF(count(Main_U.AllErrors)<> 0,true,false);

		// Orbit Stats
		Main_OrbitStats						:= Main_U.OrbitStats();
		//Creates Profile's alert template for Orbit - Can be copied & imported into Orbit; Only required first time & if scrub rules change
		Main_AlertsCSVTemplate	  := Scrubs.OrbitProfileStatsPost310('Scrubs_Corp2_Mapping_'+ state_origin+'_Main','ScrubsAlerts', Main_OrbitStats, version,'Corp2_'+ state_origin+'_Main').ProfileAlertsTemplate;
	
		//Submits Profile's stats to Orbit
		Main_SubmitStats 					:= Scrubs.OrbitProfileStatsPost310('Scrubs_Corp2_Mapping_'+ state_origin+'_Main' ,'ScrubsAlerts', Main_OrbitStats, version,'Corp2_'+ state_origin+'_Main').SubmitStats;
		//Outputs files
		Main_CreateBitMaps				:= output(Main_N.BitmapInfile,,'~thor_data::corp_NE_main_scrubs_bits',overwrite,compressed);	//long term storage
		Main_TranslateBitMap			:= output(Main_T);
		Main_ScrubsWithExamples		:= Scrubs.OrbitProfileStatsPost310('Scrubs_Corp2_Mapping_'+ state_origin+'_Main' ,'ScrubsAlerts', Main_OrbitStats, version,'Corp2_'+ state_origin+'_Main').CompareToProfile_with_Examples;

		Main_ScrubsAlert					:= Main_ScrubsWithExamples(RejectWarning = 'Y');
		Main_ScrubsAttachment			:= Scrubs.fn_email_attachment(Main_ScrubsAlert);
		Main_SendEmailFile				:= FileServices.SendEmailAttachData( corp2.Email_Notification_Lists.spray
																																	 ,'Scrubs CorpMain_NE Report' //subject
																																	 ,'Scrubs CorpMain_NE Report' //body
																																	 ,(data)Main_ScrubsAttachment
																																	 ,'text/csv'
																																	 ,'CorpNEMainScrubsReport.csv'
																																	 ,
																																	 ,
																																	 ,corp2.Email_Notification_Lists.spray
																																 );	
																			 
		Main_BadRecords		  := Main_N.ExpandedInFile( dt_vendor_first_reported_Invalid 								<> 0 or
																									dt_vendor_last_reported_Invalid 								<> 0 or
																									dt_first_seen_Invalid 													<> 0 or
																									dt_last_seen_Invalid 														<> 0 or
																									corp_ra_dt_first_seen_Invalid 									<> 0 or
																									corp_ra_dt_last_seen_Invalid 										<> 0 or
																									corp_key_Invalid 																<> 0 or
																									corp_vendor_Invalid 														<> 0 or
																									corp_state_origin_Invalid 											<> 0 or
																									corp_process_date_Invalid 											<> 0 or
																									corp_orig_sos_charter_nbr_Invalid 							<> 0 or
																									corp_legal_name_Invalid 												<> 0 or
																									corp_ln_name_type_cd_Invalid 										<> 0 or
																									corp_filing_date_Invalid 												<> 0 or
																									corp_status_cd_Invalid 													<> 0 or
																									corp_inc_state_Invalid 													<> 0 or
																									corp_inc_date_Invalid 													<> 0 or
																									corp_term_exist_exp_Invalid 										<> 0 or
																									corp_term_exist_desc_Invalid 										<> 0 or
																									corp_foreign_domestic_ind_Invalid 							<> 0 or
																									corp_forgn_state_desc_Invalid 									<> 0 or
																									corp_forgn_date_Invalid 												<> 0 or
																									corp_for_profit_ind_Invalid 										<> 0 or
																									corp_orig_org_structure_cd_Invalid 							<> 0 or
																									corp_country_of_formation_Invalid								<> 0 or
																									internalfield1_Invalid												  <> 0 or
																									recordorigin_Invalid 														<> 0 
																						);
																																	
		Main_GoodRecords		:= Main_N.ExpandedInFile( dt_vendor_first_reported_Invalid 								= 0 and
																									dt_vendor_last_reported_Invalid 								= 0 and
																									dt_first_seen_Invalid 													= 0 and
																									dt_last_seen_Invalid 														= 0 and
																									corp_ra_dt_first_seen_Invalid 									= 0 and
																									corp_ra_dt_last_seen_Invalid 										= 0 and
																									corp_key_Invalid 																= 0 and
																									corp_vendor_Invalid 														= 0 and
																									corp_state_origin_Invalid 											= 0 and
																									corp_process_date_Invalid 											= 0 and
																									corp_orig_sos_charter_nbr_Invalid 							= 0 and
																									corp_legal_name_Invalid 												= 0 and
																									corp_ln_name_type_cd_Invalid 									  = 0 and
																									corp_filing_date_Invalid 												= 0 and
																									corp_status_cd_Invalid 													= 0 and
																									corp_inc_state_Invalid 													= 0 and
																									corp_inc_date_Invalid 													= 0 and
																									corp_term_exist_exp_Invalid 										= 0 and
																									corp_term_exist_desc_Invalid 										= 0 and
																									corp_foreign_domestic_ind_Invalid 							= 0 and
																									corp_forgn_state_desc_Invalid 									= 0 and
																									corp_forgn_date_Invalid 												= 0 and
																									corp_for_profit_ind_Invalid 										= 0 and
																									corp_orig_org_structure_cd_Invalid 							= 0 and
																									corp_country_of_formation_Invalid								= 0 and
																									internalfield1_Invalid												  = 0 and	
																									recordorigin_Invalid 														= 0 
																					);


		Main_FailBuild	:= map( corp2_mapping.fCalcPercent(count(Main_N.ExpandedInFile(corp_key_invalid<>0)),count(Main_N.ExpandedInFile),false) 										> Scrubs_corp2_mapping_NE_Main.Threshold_Percent.CORP_KEY										   => true,
														corp2_mapping.fCalcPercent(count(Main_N.ExpandedInFile(corp_orig_sos_charter_nbr_invalid<>0)),count(Main_N.ExpandedInFile),false) 	> Scrubs_corp2_mapping_NE_Main.Threshold_Percent.CORP_ORIG_SOS_CHARTER_NBR 	   => true,
														corp2_mapping.fCalcPercent(count(Main_N.ExpandedInFile(corp_legal_name_invalid<>0)),count(Main_N.ExpandedInFile),false) 						> Scrubs_corp2_mapping_NE_Main.Threshold_Percent.CORP_LEGAL_NAME 						   => true,
														false
													);
						
		Main_ApprovedRecords 	:= project(Main_GoodRecords,transform(corp2_mapping.LayoutsCommon.Main,self := left));
		
		Main_ALL		 					:= sequential(IF(count(Main_BadRecords) <> 0
																					,IF (poverwrite
																							,OUTPUT(Main_BadRecords,,corp2_mapping._Dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::main_' 	+ state_origin,overwrite,__compressed__)
																							,OUTPUT(Main_BadRecords,,corp2_mapping._Dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::main_' 	+ state_origin,__compressed__)
																							)
																				 )
																				,output(Main_ScrubsWithExamples, ALL, NAMED('CorpMainScrubsReportWithExamples_NE'+filedate))																		
																				//Send Alerts if Scrubs exceeds thresholds
																				,IF(COUNT(Main_ScrubsAlert) > 0, Main_SendEmailFile, OUTPUT('corp2_mapping.'+state_origin+' - No "MAIN" Corp Scrubs Alerts'))
																				,Main_ErrorSummary
																				,Main_ScrubErrorReport
																				,Main_SomeErrorValues																		 
																				//,Main_AlertsCSVTemplate
																				,Main_SubmitStats
																			);	

		//********************************************************************
		// SCRUB EVENT
		//********************************************************************	
		Event_F := mapEvents;
		Event_S := Scrubs_corp2_mapping_ne_Event.Scrubs;						// Scrubs module
		Event_N := Event_S.FromNone(Event_F); 											// Generate the error flags
		Event_T := Event_S.FromBits(Event_N.BitmapInfile);     			// Use the FromBits module; makes my bitmap datafile easier to get to
		Event_U := Event_S.FromExpanded(Event_N.ExpandedInFile); 		// Pass the expanded error flags into the Expanded module

		//Outputs reports
		Event_ErrorSummary				:= output(Event_U.SummaryStats, named('Event_ErrorSummary_NE'+filedate));
		Event_ScrubErrorReport 		:= output(choosen(Event_U.AllErrors, 1000), named('Event_ScrubErrorReport_NE'+filedate));
		Event_SomeErrorValues			:= output(choosen(Event_U.BadValues, 1000), named('Event_SomeErrorValues_NE'+filedate));
		Event_IsScrubErrors		 		:= IF(count(Event_U.AllErrors)<> 0,true,false);

		//Orbit Stats
		Event_OrbitStats					:= Event_U.OrbitStats();
			//Creates Profile's alert template for Orbit - Can be copied & imported into Orbit; Only required first time & if scrub rules change
		Event_AlertsCSVTemplate	  := Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_'+ state_origin+'_Event','ScrubsAlerts', Event_OrbitStats, version,'Corp2_'+ state_origin+'_Event').ProfileAlertsTemplate;
		//Submits Profile's stats to Orbit
		Event_SubmitStats 				:= Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_'+ state_origin+'_Event','ScrubsAlerts', Event_OrbitStats, version,'Corp2_'+ state_origin+'_Event').SubmitStats;
		//Outputs files
		Event_CreateBitMaps				:= output(Event_N.BitmapInfile,,'~thor_data::corp_ne_event_scrubs_bits',overwrite,compressed);	//long term storage
		Event_TranslateBitMap			:= output(Event_T);
		Event_ScrubsWithExamples	:= Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_'+ state_origin+'_Event','ScrubsAlerts', Event_OrbitStats, version,'Corp2_'+ state_origin+'_Event').CompareToProfile_with_Examples;
		
		Event_ScrubsAlert					:= Event_ScrubsWithExamples(RejectWarning = 'Y');
		Event_ScrubsAttachment		:= Scrubs.fn_email_attachment(Event_ScrubsAlert);
		Event_MailFile						:= FileServices.SendEmailAttachData( corp2.Email_Notification_Lists.spray
																																	 ,'Scrubs CorpEvent_NE Report' //subject
																																	 ,'Scrubs CorpEvent_NE Report' //body
																																	 ,(data)Event_ScrubsAttachment
																																	 ,'text/csv'
																																	 ,'CorpNEEventScrubsReport.csv'
																																	 ,
																																	 ,
																																	 ,corp2.Email_Notification_Lists.spray
																																 );

		Event_BadRecords		:= event_N.ExpandedInFile(corp_key_Invalid    						<> 0 or
																									corp_vendor_Invalid 					  <> 0 or
																									corp_state_origin_Invalid 		  <> 0 or
																									corp_process_date_Invalid		    <> 0 or
																									corp_sos_charter_nbr_Invalid    <> 0 or
																									event_filing_cd_Invalid 			  <> 0 or
																									InternalField1_Invalid          <> 0 
																									);
																																						
		Event_GoodRecords	  := event_N.ExpandedInFile(corp_key_Invalid 								= 0 and
																									corp_vendor_Invalid 						= 0 and
																									corp_state_origin_Invalid 			= 0 and
																									corp_process_date_Invalid				= 0 and
																									corp_sos_charter_nbr_Invalid 		= 0 and
																									event_filing_cd_Invalid 				= 0 and 
																									InternalField1_Invalid          = 0	
																									);
   
		Event_ApprovedRecords	:= project(Event_GoodRecords,transform(corp2_mapping.LayoutsCommon.Events,self := left));

		Event_ALL							:= sequential(IF(count(Event_BadRecords)<> 0
																					 ,IF(poverwrite
																					 ,OUTPUT(Event_BadRecords,,corp2_mapping._Dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::event_' 	+ state_origin,overwrite,__compressed__)
																									 ,OUTPUT(Event_BadRecords,,corp2_mapping._Dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::event_' 	+ state_origin,__compressed__)
																									 )
																						)
																					 ,output(Event_ScrubsWithExamples, ALL, NAMED('CorpEventScrubsReportWithExamples_NE'+filedate))
																					 //Send Alerts if Scrubs exceeds thresholds
																					 ,IF(COUNT(Event_ScrubsAlert) > 0, Event_MailFile, OUTPUT('corp2_mapping.'+state_origin+' - No "EVENT" Corp Scrubs Alerts'))
																					 ,Event_ErrorSummary
																					 ,Event_ScrubErrorReport
																					 ,Event_SomeErrorValues		
																					 //,Event_AlertsCSVTemplate
																					 ,Event_SubmitStats
																	       );


		//==========================================VERSION CONTROL====================================================
		IsScrubErrors	:= if(Event_IsScrubErrors = true or Main_IsScrubErrors = true,true,false);
		VersionControl.macBuildNewLogicalFile(corp2_mapping._dataset().thor_cluster_Files + 'in::corp2::' + version + '::Main_' 	+ state_origin, Main_ApprovedRecords , main_out,,,pOverwrite);
		VersionControl.macBuildNewLogicalFile(corp2_mapping._dataset().thor_cluster_Files + 'in::corp2::' + version + '::AR_' 		+ state_origin, mapAR	 , AR_out,,,pOverwrite);
		VersionControl.macBuildNewLogicalFile(corp2_mapping._dataset().thor_cluster_Files + 'in::corp2::' + version + '::Event_' 	+ state_origin, Event_ApprovedRecords, event_out,,,pOverwrite);
		
		VersionControl.macBuildNewLogicalFile(corp2_mapping._dataset().thor_cluster_Files + 'fail::corp2::'+version+'::Main_' 	+ state_origin	,Main_F	 ,write_fail_main  ,,,pOverwrite); 
		VersionControl.macBuildNewLogicalFile(corp2_mapping._dataset().thor_cluster_Files + 'fail::corp2::'+version+'::event_' 	+ state_origin	,Event_F ,write_fail_event ,,,pOverwrite);
		
		mapNE:= sequential( if(pshouldspray = true,corp2_mapping.fSprayFiles(state_origin,version,pOverwrite := pOverwrite))
											  ,main_out
												,event_out
												,ar_out
												,IF(Main_FailBuild <> true OR count(Event_GoodRecords) <> 0	
														,sequential( fileservices.addsuperfile(corp2_mapping._Dataset().thor_cluster_Files + 'in::'+corp2_mapping._Dataset().NameMapped+'::sprayed::ar'		,corp2_mapping._Dataset().thor_cluster_Files + 'in::corp2::'+version+'::ar_' 	+ state_origin)
																				,fileservices.addsuperfile(corp2_mapping._Dataset().thor_cluster_Files + 'in::'+corp2_mapping._Dataset().NameMapped+'::sprayed::event'	,corp2_mapping._Dataset().thor_cluster_Files + 'in::corp2::'+version+'::event_' 	+ state_origin)
																				,fileservices.addsuperfile(corp2_mapping._Dataset().thor_cluster_Files + 'in::'+corp2_mapping._Dataset().NameMapped+'::sprayed::main'	,corp2_mapping._Dataset().thor_cluster_Files + 'in::corp2::'+version+'::main_' 	+ state_origin)																		 
																					,if (count(Main_BadRecords) <> 0 or  count(Event_BadRecords) <> 0 
																							 ,corp2_mapping.Send_Email(state_origin,version,count(Main_BadRecords)<>0,,count(Event_BadRecords)<>0,,count(Main_BadRecords),,count(Event_BadRecords),,count(Main_ApprovedRecords),count(mapAR),count(Event_ApprovedRecords),).RecordsRejected																				 
																							 ,corp2_mapping.Send_Email(state_origin,version,count(Main_BadRecords)<>0,,count(Event_BadRecords)<>0,,count(Main_BadRecords),,count(Event_BadRecords),,count(Main_ApprovedRecords),count(mapAR),count(Event_ApprovedRecords),).MappingSuccess																				 
																							 )
																							 
																					,if(IsScrubErrors
																							,Corp2_Mapping.Send_Email(state_origin,version,Main_IsScrubErrors,false,Event_IsScrubErrors,false).FieldsInvalidPerScrubs
																				     )		 
																			  )
														 ,sequential( write_fail_main  //if it fails on  main file threshold ,still writing mapped files!
																				 ,write_fail_event
																				 ,corp2_mapping.Send_Email(state_origin,version).MappingFailed
																				)
													)
												,Event_All
												,Main_All	
										);
									
		//Validating the filedate entered is within 30 days		
		  isFileDateValid := if((string)Std.Date.Today() between ut.date_math(filedate,-30) and ut.date_math(filedate,30),true,false);
			result		 			:= if(isFileDateValid
													 ,mapNE
													 ,sequential (corp2_mapping.Send_Email(state_origin,filedate).InvalidFileDateParm
																				,FAIL('corp2_mapping.'+state_origin+'failed. An invalid filedate was passed in as a parameter.')
																			 )
											);
		return result;
 		
	end;	// end of Update function

end;  // end of  module
