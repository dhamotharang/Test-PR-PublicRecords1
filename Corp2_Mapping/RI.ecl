Import corp2, corp2_raw_ri, scrubs, scrubs_corp2_mapping_ri_main, tools, ut, versioncontrol, _validate,std;

export RI := module 

	export Update(string fileDate, string version, boolean pShouldSpray = _Dataset().bShouldSpray, boolean pOverwrite = false ,pUseProd = Tools._Constants.IsDataland) := function

		state_origin				:= 'RI';
		state_fips	 				:= '44';
		state_desc	 				:= 'RHODE ISLAND';	

		Entities         	  := Corp2_Raw_RI.Files(filedate,pUseProd).input.Entities.logical;
		Inactive_Entities	  := Corp2_Raw_RI.Files(filedate,pUseProd).input.Inactive_Entities.logical; 
		amendments       	  := Corp2_Raw_RI.Files(filedate,pUseProd).input.amendments.logical; 
		Inactive_amendments := Corp2_Raw_RI.Files(filedate,pUseProd).input.Inactive_amendments.logical; 
		Names       			  := Corp2_Raw_RI.Files(filedate,pUseProd).input.Names.logical; 	
		Inactive_Names   	  := Corp2_Raw_RI.Files(filedate,pUseProd).input.Inactive_Names.logical; 	
		Officers       		  := Corp2_Raw_RI.Files(filedate,pUseProd).input.Officers.logical;	
		Inactive_Officers	  := Corp2_Raw_RI.Files(filedate,pUseProd).input.Inactive_Officers.logical; 	
		Stocks         		  := Corp2_Raw_RI.Files(filedate,pUseProd).input.Stocks.logical; 
		Inactive_Stocks  	  := Corp2_Raw_RI.Files(filedate,pUseProd).input.Inactive_Stocks.logical;		
    Merger              := Corp2_Raw_RI.Files(filedate,pUseProd).input.Mergers.logical;
		//Per CI: we are not using Inactive_Mergerfile in the code!
		//Inactive_Mergers 	  := Corp2_Raw_RI.Files(filedate,pUseProd).input.Inactive_Mergers.logical;
		
		//Per CI: layout is different for Active & Inactive Entities .Vendor is not sending "CountryOfIncorp" field for Inactive Entity data !
		ds_InACTEntities    := project(Inactive_Entities,transform(Corp2_Raw_RI.Layouts.EntitiesIN,self:=left;self:=[];));
		
		ds_full_Entities		:= dedup(sort(distribute(Entities   + ds_InACTEntities,hash((string)(integer)corp2.t2u(Entity_ID))),record,local),record,local): independent;
		ds_full_amendments	:= dedup(sort(distribute(Amendments +	Inactive_amendments,hash((string)(integer)corp2.t2u(Entity_ID))),record,local),record,local): independent;
		ds_full_Names				:= dedup(sort(distribute(Names			+	Inactive_Names,hash((string)(integer)corp2.t2u(Entity_ID))),record,local),record,local): independent;
		ds_full_Officers		:= dedup(sort(distribute(Officers	  +	Inactive_Officers,hash((string)(integer)corp2.t2u(Entity_ID))),record,local),record,local): independent;
		ds_full_Stocks			:= dedup(sort(distribute(Stocks 		+	Inactive_Stocks,hash((string)(integer)corp2.t2u(Entity_ID))),record,local),record,local): independent;
		Merger_SurvivingID  := dedup(sort(distribute(Merger,hash((string)(integer)corp2.t2u(SurvivingEntity_ID))),record,local),record,local): independent; 
		Merger_EntityID     := dedup(sort(distribute(Merger,hash((string)(integer)corp2.t2u(MergedEntity_ID))),record,local),record,local): independent; 
	
		Foreign_Type			  :=[ 'FOREIGN BUSINESS CORPORATION','FOREIGN CORPORATION','FOREIGN LIMITED LIABILITY COMPANY',
														'FOREIGN LIMITED LIABILITY PARTNERSHIP','FOREIGN LIMITED PARTNERSHIP','FOREIGN NON-PROFIT CORPORATION',
														'FOREIGN REGISTERED LIMITED LIABILITY PARTNERSHIP','FOREIGN TRUST'];

		corp2_mapping.LayoutsCommon.Main  trfCorpEntity(Corp2_Raw_RI.Layouts.EntitiesIN l) := transform		
		
			self.dt_vendor_first_reported				:=(integer)fileDate;
			self.dt_vendor_last_reported				:=(integer)fileDate;
			self.dt_first_seen									:=(integer)fileDate;
			self.dt_last_seen										:=(integer)fileDate;
			self.corp_ra_dt_first_seen					:=(integer)fileDate;
			self.corp_ra_dt_last_seen						:=(integer)fileDate;
			self.Corp_Process_Date            	:= fileDate; 
			self.Corp_Vendor                  	:= state_fips;
			self.Corp_State_Origin            	:= state_origin;
			self.corp_key												:= state_fips +'-' + (string)(integer)corp2.t2u(l.Entity_ID);
			self.corp_orig_sos_charter_nbr			:= (string)(integer)corp2.t2u(l.Entity_ID);
			self.corp_legal_name            		:= corp2_mapping.fCleanBusinessName(state_origin,state_desc,l.EntityName).BusinessName;
			self.corp_ln_name_type_cd       		:= map(Regexfind('REGISTRATION',l.status,nocase) => '09',
																								 Regexfind('RESERVATION',l.status,nocase)  => '07',
																								 '01');
			self.corp_ln_name_type_desc     		:= map(self.corp_ln_name_type_cd = '09' => 'REGISTRATION',
																								 self.corp_ln_name_type_cd = '07' => 'RESERVED',
																								 'LEGAL');	
			self.corp_for_profit_ind            :=map(Regexfind('NON-PROFIT' ,l.charter,nocase) => 'N',
																								Regexfind('PROFIT',l.charter,nocase)  		=> 'Y',
																								'');
			self.corp_inc_state             		:= state_origin;
			valid_Date                          := corp2_mapping.fValidateDate(l.DateOfOrganization).PastDate;
			self.corp_foreign_domestic_ind			:= map(corp2.t2u(l.StateOfIncorp)<> state_origin and corp2.t2u(l.charter) in foreign_type				  =>'F',
																								 corp2.t2u(l.StateOfIncorp)in[ state_origin,''] and corp2.t2u(l.charter) not in foreign_type=>'D',
																								 corp2.t2u(l.charter) not in foreign_type																				  					=>'D', //noticed in the data, states which are state_origin and have forein type & vice versa									 		 																				 =>'F',
																								 corp2.t2u(l.charter) in foreign_type																					  					  =>'F', //noticed in the data, states which are other than state_origin and have domestic type & vice versa  																												   =>'D',
																								 '');	
			self.corp_inc_date									:= map(corp2.t2u(l.StateOfIncorp)in[ state_origin,''] and corp2.t2u(l.charter) not in foreign_type=>valid_Date,
																								 corp2.t2u(l.charter) not in foreign_type																									  =>valid_Date, 
																							   '');
			self.corp_forgn_date								:= map(corp2.t2u(l.StateOfIncorp)<> state_origin and corp2.t2u(l.charter) in foreign_type=>valid_Date,
																								 corp2.t2u(l.charter) in foreign_type																							 =>valid_Date,
																								 '');	
			country_desc                   			:= if(Corp2_Raw_RI.Functions.ForgnCountryDesc(l.CountryOfIncorp)[1..2]<>'**',Corp2_Raw_RI.Functions.ForgnCountryDesc(l.CountryOfIncorp),'');
			businesscountry											:= if(Corp2_Raw_RI.Functions.ForgnCountryDesc(l.BusinessCountry)[1..2]<>'**',Corp2_Raw_RI.Functions.ForgnCountryDesc(l.BusinessCountry),'');
			mailingcountry											:= if(Corp2_Raw_RI.Functions.ForgnCountryDesc(l.MailingCountry)[1..2]<>'**',Corp2_Raw_RI.Functions.ForgnCountryDesc(l.MailingCountry),'');
			self.corp_address1_line1						:= corp2_mapping.fCleanAddress(State_origin,State_desc,l.BusinessAddr1,l.BusinessAddr2,l.BusinessCity,l.BusinessState,l.BusinessZip,businesscountry).AddressLine1;
			self.corp_address1_line2						:= corp2_mapping.fCleanAddress(State_origin,State_desc,l.BusinessAddr1,l.BusinessAddr2,l.BusinessCity,l.BusinessState,l.BusinessZip,businesscountry).AddressLine2;
			self.corp_address1_line3						:= corp2_mapping.fCleanAddress(State_origin,State_desc,l.BusinessAddr1,l.BusinessAddr2,l.BusinessCity,l.BusinessState,l.BusinessZip,businesscountry).AddressLine3;
			self.corp_prep_addr1_line1					:= corp2_mapping.fCleanAddress(State_origin,State_desc,l.BusinessAddr1,l.BusinessAddr2,l.BusinessCity,l.BusinessState,l.BusinessZip,businesscountry).PrepAddrLine1;
			self.corp_prep_addr1_last_line			:= corp2_mapping.fCleanAddress(State_origin,State_desc,l.BusinessAddr1,l.BusinessAddr2,l.BusinessCity,l.BusinessState,l.BusinessZip,businesscountry).PrepAddrLastLine;
			self.corp_address1_type_cd					:= if(corp2_mapping.fAddressExists(State_origin,State_desc,l.BusinessAddr1,l.BusinessAddr2,l.BusinessCity,l.BusinessState,l.BusinessZip,businesscountry).ifAddressExists,
																								'B','');
			self.corp_address1_type_desc				:= if(corp2_mapping.fAddressExists(State_origin,State_desc,l.BusinessAddr1,l.BusinessAddr2,l.BusinessCity,l.BusinessState,l.BusinessZip,businesscountry).ifAddressExists,
																								'BUSINESS','');
			self.corp_address2_line1						:= corp2_mapping.fCleanAddress(State_origin,State_desc,l.mailingaddr1,l.mailingaddr2,l.mailingCity,l.mailingState,l.mailingZip,mailingcountry).AddressLine1;
			self.corp_address2_line2						:= corp2_mapping.fCleanAddress(State_origin,State_desc,l.mailingaddr1,l.mailingaddr2,l.mailingCity,l.mailingState,l.mailingZip,mailingcountry).AddressLine2;
			self.corp_address2_line3						:= corp2_mapping.fCleanAddress(State_origin,State_desc,l.mailingaddr1,l.mailingaddr2,l.mailingCity,l.mailingState,l.mailingZip,mailingcountry).AddressLine3;
			self.corp_prep_addr2_line1					:= corp2_mapping.fCleanAddress(State_origin,State_desc,l.mailingaddr1,l.mailingaddr2,l.mailingCity,l.mailingState,l.mailingZip,mailingcountry).PrepAddrLine1;
			self.corp_prep_addr2_last_line			:= corp2_mapping.fCleanAddress(State_origin,State_desc,l.mailingaddr1,l.mailingaddr2,l.mailingCity,l.mailingState,l.mailingZip,mailingcountry).PrepAddrLastLine;
			self.corp_address2_type_cd					:= if(corp2_mapping.fAddressExists(State_origin,State_desc,l.mailingaddr1,l.mailingaddr2,l.mailingCity,l.mailingState,l.mailingZip,mailingcountry).ifAddressExists,
																						    'M','');
			self.corp_address2_type_desc				:= if(corp2_mapping.fAddressExists(State_origin,State_desc,l.mailingaddr1,l.mailingaddr2,l.mailingCity,l.mailingState,l.mailingZip,l.mailingcountry).ifAddressExists,
																						    'MAILING','');																					
			self.corp_ra_full_name              := if(corp2.t2u(l.AgentName)not in ['AGENT RESIGNED','REGISTERED AGENT RESIGNED','RESIGNED'],corp2_mapping.fCleanBusinessName(state_origin,state_desc,l.AgentName).BusinessName,'');
			List                                := '^\\x2d\\x23|^\\x23\\x23\\x23|^\\x23\\x23|^\\x23|^\\x2d';
			temp_AgentAddr1              			  := regexreplace(List,l.AgentAddr1,'');	//Removing beginning ## , _# special characters from agent address parts!	
			temp_AgentAddr2              			  := regexreplace(List,l.AgentAddr2,'');		
			self.corp_ra_address_line1				  := corp2_mapping.fCleanAddress(state_origin,state_desc,temp_AgentAddr1,temp_AgentAddr2,l.AgentCity,l.AgentState,l.AgentZip).AddressLine1;
			self.corp_ra_address_line2				  := corp2_mapping.fCleanAddress(state_origin,state_desc,temp_AgentAddr1,temp_AgentAddr2,l.AgentCity,l.AgentState,l.AgentZip).AddressLine2;
			self.corp_ra_address_line3				 	:= corp2_mapping.fCleanAddress(state_origin,state_desc,temp_AgentAddr1,temp_AgentAddr2,l.AgentCity,l.AgentState,l.AgentZip).AddressLine3;
			self.ra_prep_addr_line1							:= corp2_mapping.fCleanAddress(state_origin,state_desc,temp_AgentAddr1,temp_AgentAddr2,l.AgentCity,l.AgentState,l.AgentZip).PrepAddrLine1;
			self.ra_prep_addr_last_line					:= corp2_mapping.fCleanAddress(state_origin,state_desc,temp_AgentAddr1,temp_AgentAddr2,l.AgentCity,l.AgentState,l.AgentZip).PrepAddrLastLine;																						
			self.corp_ra_address_type_cd		  	:= if(corp2_mapping.fAddressExists(state_origin,state_desc,temp_AgentAddr1,temp_AgentAddr2,l.AgentCity,l.AgentState,l.AgentZip).ifAddressExists,'R','');
			self.corp_ra_address_type_desc		  := if(corp2_mapping.fAddressExists(state_origin,state_desc,temp_AgentAddr1,temp_AgentAddr2,l.AgentCity,l.AgentState,l.AgentZip).ifAddressExists,'REGISTERED OFFICE','');
			self.corp_country_of_formation 			:= corp2_mapping.fCleanCountry(state_origin,state_desc,'',country_desc).Country;
			self.corp_forgn_state_cd            := if(corp2.t2u(l.StateOfIncorp) not in [state_origin,''] , Corp2_Raw_RI.Functions.fGetStateCode(l.StateOfIncorp),'');
			self.corp_forgn_state_desc          := if(corp2.t2u(l.StateOfIncorp) not in [state_origin,''],Corp2_Raw_RI.Functions.fGetStateDesc(l.StateOfIncorp),'');
			self.corp_orig_org_structure_desc   := if(self.corp_ln_name_type_cd not in['09' ,'07'],corp2.t2u(l.charter),'');
			self.corp_status_desc								:= corp2.t2u(l.status);
			self.corp_organizational_comments   := if(corp2_mapping.fValidateDate(l.effectdate).GeneralDate <> '', 'EFFECTIVE DATE ' +corp2_mapping.fValidateDate(l.effectdate).GeneralDate,''); 
			self.corp_orig_bus_type_desc        := if(corp2.t2u(l.purpose) not in['INACTIVE','NONE'],corp2.t2u(l.purpose),'');
			self.corp_status_comment        		:= if(corp2.t2u(l.purpose) ='INACTIVE',corp2.t2u(l.purpose),'');
			self.corp_acts							        := corp2.t2u(l.chapter);
			self.corp_term_exist_exp            := if(self.corp_foreign_domestic_ind='D' and corp2_mapping.fValidateDate(l.Duration).GeneralDate<>'' ,corp2_mapping.fValidateDate(l.Duration).GeneralDate,'');
			self.corp_term_exist_cd             := map(corp2.t2u(l.Duration)=''=>'P',
																								 self.corp_term_exist_exp <>''=>'D',
																								 '');
			self.corp_term_exist_desc           := map(self.corp_term_exist_cd = 'D' => 'EXPIRATION DATE',
																								 self.corp_term_exist_cd = 'P' => 'PERPETUAL',
																								 '');
			//Per CI: overload values from filing Table will not be mapped in re corp!																				 
			self.corp_addl_info                 := map(corp2.t2u(l.isaddressedmaintained) = 'Y' => 'ADDRESS MAINTAINED',
																						     corp2.t2u(l.isaddressedmaintained) = 'N' => 'ADDRESS NOT MAINTAINED',
																								 '');
			self.corp_ra_addl_info              := if(corp2.t2u(l.IsAgentResigned) = 'Y', 'RESIGNED', '');
			self.Corp_Agent_Status_Desc					:= if(corp2.t2u(l.IsAgentResigned) = 'Y', 'REGISTERED AGENT RESIGNED','');
			self.corp_naic_code                 := Corp2_Raw_RI.Functions.GetNaicCode(l.NaicsCode);
			//new vendor Country codes will be caught through scrubs!!
			self.InternalField1									:= Corp2_Raw_RI.Functions.ForgnCountryDesc(l.CountryOfIncorp);
			self.InternalField2									:= Corp2_Raw_RI.Functions.ForgnCountryDesc(l.BusinessCountry);
			self.InternalField3									:= Corp2_Raw_RI.Functions.ForgnCountryDesc(l.MailingCountry);
			//Added for scrub purposes; new foreign charter values will be captured,those are not listed in foreign_type !!foreign charter values are crucial for dates & indicator fields!
			self.InternalField4									:= if(corp2.t2u(l.charter) not in foreign_type and Regexfind('^FOREIGN',corp2.t2u(l.charter),nocase),'**'+corp2.t2u(l.charter),'');
			self.recordOrigin										:= 'C';			
			self 																:= [];

		end;

		MapCorpEntity 		:= project(ds_full_Entities, trfCorpEntity(left)):independent;		
		dist_CorpEntity	  := distribute(MapCorpEntity,hash(corp_key,corp_legal_name)) ;
		
		//Per CI: Only mailing addresses & NO Business address then populating business addresses from Mailing addresses & blanking mailing addresses ;
		RI_addr1_blank 		:= MapCorpEntity(corp2.t2u(corp_address2_line1 + corp_address2_line2 + corp_address2_line3 ) <>'' and 
																			 corp2.t2u(corp_address1_line1 + corp_address1_line2 + corp_address1_line3 ) ='' 
																			 );
		corp2_mapping.LayoutsCommon.Main AddressTransform(corp2_mapping.LayoutsCommon.Main l ,corp2_mapping.LayoutsCommon.Main r):=transform
		
			self.corp_address1_line1				:= if(l.corp_address1_line1 ='',r.corp_address2_line1,l.corp_address1_line1);
			self.corp_address1_line2				:= if(l.corp_address1_line2 ='',r.corp_address2_line2,l.corp_address1_line2);
			self.corp_address1_line3				:= if(l.corp_address1_line3 ='',r.corp_address2_line3,l.corp_address1_line3);
			self.corp_prep_addr1_line1			:= if(l.corp_prep_addr1_line1 ='',r.corp_prep_addr2_line1,l.corp_prep_addr1_line1);
			self.corp_prep_addr1_last_line	:= if(l.corp_prep_addr1_last_line ='',r.corp_prep_addr2_last_line,l.corp_prep_addr1_last_line);	
			self.corp_address1_type_cd		  := if(l.corp_address1_type_cd ='' and l.corp_address2_type_cd<>'','B',l.corp_address1_type_cd);
			self.corp_address1_type_desc	  := if(l.corp_address1_type_desc =''and l.corp_address2_type_desc<>'','BUSINESS',l.corp_address1_type_desc);
			self.corp_address2_line1				:= if(l.corp_address1_line1 ='','',l.corp_address2_line1);
			self.corp_address2_line2				:= if(l.corp_address1_line2 ='','',l.corp_address2_line2);
			self.corp_address2_line3				:= if(l.corp_address1_line3 ='','',l.corp_address2_line3);
			self.corp_prep_addr2_line1			:= if(l.corp_prep_addr1_line1 ='','',l.corp_prep_addr2_line1);
			self.corp_prep_addr2_last_line	:= if(l.corp_prep_addr1_last_line='','',l.corp_prep_addr2_last_line);
			self.corp_address2_type_cd		  := if(l.corp_address1_type_cd=''and l.corp_address2_type_cd<>'','',l.corp_address2_type_cd);
			self.corp_address2_type_desc	  := if(l.corp_address1_type_desc=''and l.corp_address2_type_desc<>'','',l.corp_address2_type_desc);
			self                            := l;
		
		End;
   	dist_addr1_blank	:= distribute(RI_addr1_blank,hash(corp_key,corp_legal_name)) ;
		ds_RI_corps 			:= join(dist_CorpEntity ,  dist_addr1_blank ,
															left.corp_key  				= right.corp_key and
															left.corp_legal_name  = right.corp_legal_name, 
															AddressTransform(left,right),
															left outer,
															local);	
												
		RI_MapCorp			:= dedup(sort(distribute(ds_RI_corps ,hash(corp_key)),record,local),record,local):independent; 


    jds_full_Names	:= join(ds_full_Names, ds_full_Entities, 
													(string)(integer)corp2.t2u(left.Entity_ID) = (string)(integer)corp2.t2u(right.Entity_ID),
													transform(Corp2_Raw_RI.Layouts.NamesIn_TempLay, 
																		 self.StateOfIncorp       := right.StateOfIncorp;
																		 self.Charter             := right.Charter;
																		 self.DateOfOrganization  := right.DateOfOrganization;
																		 self := left; self := right; self := [];),
													left outer,local) : independent;
													
		corp2_mapping.LayoutsCommon.Main  trfCorpNames(Corp2_Raw_RI.Layouts.NamesIn_TempLay l) := transform,
		skip(corp2_mapping.fCleanBusinessName(state_origin,state_desc,l.Name).BusinessName='')

			self.dt_vendor_first_reported				:=(integer)fileDate;
			self.dt_vendor_last_reported				:=(integer)fileDate;
			self.dt_first_seen									:=(integer)fileDate;
			self.dt_last_seen										:=(integer)fileDate;
			self.corp_ra_dt_first_seen					:=(integer)fileDate;
			self.corp_ra_dt_last_seen						:=(integer)fileDate;
			self.Corp_Process_Date            	:= fileDate; 
			self.Corp_Vendor                  	:= state_fips;
			self.Corp_State_Origin            	:= state_origin;
			self.corp_inc_state             		:= state_origin;
			self.corp_key												:= state_fips +'-' + (string)(integer)corp2.t2u(l.Entity_ID);
			self.corp_orig_sos_charter_nbr			:= (string)(integer)corp2.t2u(l.Entity_ID);
			self.corp_legal_name            		:= corp2_mapping.fCleanBusinessName(state_origin,state_desc,l.Name).BusinessName; 
			self.corp_ln_name_type_cd       		:= map(Regexfind('FICTITIOUS',l.Name_Type,nocase) => 'F', //raw data has fictitious (foreign)
																								 corp2.t2u(l.Name_Type) = 'RESERVATION'  		=> '07',
																								 corp2.t2u(l.Name_Type) = 'REGISTRATION' 		=> '09',
																								 corp2.t2u(l.Name_Type) = 'CHG_NAME'     		=> 'P',
																								 corp2.t2u(l.Name_Type) = 'ACTUAL'      		=> 'I',
																								 corp2.t2u(l.Name_Type)
																								 );
			self.corp_ln_name_type_desc     		:= map(Regexfind('FICTITIOUS',l.Name_Type,nocase) => 'FBN',
																								 corp2.t2u(l.Name_Type) = 'RESERVATION'  		=> 'RESERVED',
																								 corp2.t2u(l.Name_Type) = 'REGISTRATION' 		=> 'REGISTRATION',
																								 corp2.t2u(l.Name_Type) = 'CHG_NAME'     		=> 'PRIOR',
																								 corp2.t2u(l.Name_Type) = 'ACTUAL'       		=> 'ACTUAL NAME',
																								 '');
			self.corp_orig_org_structure_desc   := if(self.corp_ln_name_type_cd not in['09' ,'07'],corp2.t2u(l.EntityTypeDescriptor),'');
			self.Corp_Name_Effective_Date       := if(corp2.t2u(l.Name_Type) <> 'RESERVATION' and corp2_mapping.fValidateDate(l.File_Dt).GeneralDate<>'' ,corp2_mapping.fValidateDate(l.File_Dt).GeneralDate,'');		
			self.Corp_Name_Reservation_Date     := if(corp2.t2u(l.Name_Type) = 'RESERVATION' and corp2_mapping.fValidateDate(l.File_Dt).pastDate<>'',corp2_mapping.fValidateDate(l.File_Dt).pastDate,'');		 
			valid_Date                          := corp2_mapping.fValidateDate(l.DateOfOrganization).PastDate;
			self.corp_inc_date									:= map(corp2.t2u(l.StateOfIncorp)in[ state_origin,''] and corp2.t2u(l.charter) not in foreign_type=>valid_Date,
																								 corp2.t2u(l.charter) not in foreign_type																									  =>valid_Date, 
																							   '');
			self.corp_forgn_date								:= map(corp2.t2u(l.StateOfIncorp)<> state_origin and corp2.t2u(l.charter) in foreign_type=>valid_Date,
																								 corp2.t2u(l.charter) in foreign_type																							 =>valid_Date,
																								 '');	
			self.recordOrigin										:= 'C';			
			self 																:= [];

		end;

		MapCorpNames  := project(jds_full_Names,  trfCorpNames(left)):independent;

		AllCorps			:= dedup(sort(distribute(RI_MapCorp  + 
																					 MapCorpNames ,hash(corp_key)),
																record,local),record,local) : independent;

		/*Per CI:"the merger data has three types of records - there is a code in the mergertype field: m for merger;  c for consolidation;  v for conversion
			the active entity data uses active merger file and mapped according to ci*/
		Join_Entiti_Merger 		 := join(Entities ,Merger_SurvivingID(corp2.t2u(MergerType) in ['M','C','V']),
																	 (string)(integer)corp2.t2u(left.Entity_ID) =(string)(integer)corp2.t2u(right.SurvivingEntity_ID),
																	 transform(Corp2_Raw_RI.Layouts.Temp_Entity_Merger,
																						 self:=left;
																						 self:=right;),
																		inner,local):independent;

		ds_Entiti_MCV             :=dedup(sort(Join_Entiti_Merger,record),record);
														
		corp2_mapping.LayoutsCommon.Main  trfEntityMCV(Corp2_Raw_RI.Layouts.Temp_Entity_Merger l) := transform

			self.corp_key												:=state_fips +'-' + (string)(integer)corp2.t2u(l.Entity_ID);
			self.Corp_Survivor_Corporation_Id   :=if(corp2.t2u(l.MergerType) in ['C','V'], (string)(integer)corp2.t2u(l.SurvivingEntity_ID), '');
		  self.corp_filing_date   					  :=if(corp2.t2u(l.MergerType) in ['C','V'], corp2_mapping.fValidateDate(l.MergerDate).PastDate, '');
			self.corp_filing_cd                 :=if(corp2.t2u(l.MergerType) in ['C','V'], 'X', '');
			self.corp_filing_desc								:=map(corp2.t2u(l.MergerType) = 'C' => 'CONSOLIDATION', 
			                                          corp2.t2u(l.MergerType) = 'V' => 'CONVERSION',
																								'');
			self.Corp_Organizational_Comments   :=map(corp2.t2u(l.MergerType) = 'C' => 'CONSOLIDATED WITH ' + corp2.t2u(l.MergedEntityName)+', '+ (string)(integer)corp2.t2u(l.MergedEntity_ID),
																								corp2.t2u(l.MergerType) = 'V' => 'CONVERTED FROM ' + corp2.t2u(l.MergedEntityName)+', '+ (string)(integer)corp2.t2u(l.MergedEntity_ID),
																								corp2.t2u(l.MergerType) = 'M' => 'MERGED WITH ' + corp2.t2u(l.MergedEntityName)+', '+ (string)(integer)corp2.t2u(l.MergedEntity_ID),
																								'');
			self.Corp_Merger_Indicator    			:=if(corp2.t2u(l.MergerType) = 'M', 'S', ''); 
			self.Corp_Merger_Id    						  :=if(corp2.t2u(l.MergerType) = 'M', (string)(integer)corp2.t2u(l.SurvivingEntity_ID), '');
			self.Corp_Merger_Date   					  :=if(corp2.t2u(l.MergerType) = 'M', corp2_mapping.fValidateDate(l.MergerDate).PastDate, '');
			self.Corp_Converted			  					:=if(corp2.t2u(l.MergerType) = 'V', 'N', '');
			valid_Date                          := corp2_mapping.fValidateDate(l.DateOfOrganization).PastDate;
			self.corp_inc_date									:= map(corp2.t2u(l.StateOfIncorp)in[ state_origin,''] and corp2.t2u(l.charter) not in foreign_type=>valid_Date,
																								 corp2.t2u(l.charter) not in foreign_type																									  =>valid_Date, 
																							   '');
			self.corp_forgn_date								:= map(corp2.t2u(l.StateOfIncorp)<> state_origin and corp2.t2u(l.charter) in foreign_type=>valid_Date,
																								 corp2.t2u(l.charter) in foreign_type																							 =>valid_Date,
																								 '');	
			self.recordOrigin										:='C';			
			self 																:=[];

		end;
		
		All_Entiti_Mergers := project(ds_Entiti_MCV   , trfEntityMCV(left));

		
		/*Per CI:"the merger data has three types of records - there is a code in the mergertype field: m for merger;  c for consolidation;  v for conversion
			the Inactive entity file and merger data join and mapped according to ci */			
		Join_InactEntiti_Merger 		 := join(Inactive_Entities ,Merger_EntityID(corp2.t2u(MergerType) in ['M','C','V']),
																				 (string)(integer)corp2.t2u(left.Entity_ID) =(string)(integer)corp2.t2u(right.MergedEntity_ID),
																					transform(Corp2_Raw_RI.Layouts.Temp_Entity_Merger,
																										self:=left;
																										self:=right;
																										self:=[];
																										),
																				 inner,local):independent;
																	 
		ds_InactEntitiMerger	:= distribute(Join_InactEntiti_Merger,hash((string)(integer)corp2.t2u(SurvivingEntity_ID)));
		
		//InactEntitiMerger join back to orginal Active Entity file to track back ActiveEntityName		
		Join_AEnti_InactEntitiMerger := join(ds_InactEntitiMerger,Entities , 
																				(string)(integer)corp2.t2u(left.SurvivingEntity_ID) =(string)(integer)corp2.t2u(right.Entity_ID),
																				 transform(Corp2_Raw_RI.Layouts.Temp_InActEntity_Merger,
																									 self.ActiveEntity_Name		:=right.EntityName;
																									 self											:=left;
																									 ),
																				 left outer,local):independent;

		ds_InactEntiti_MCV               :=dedup(sort(Join_AEnti_InactEntitiMerger,record),record);
	
		corp2_mapping.LayoutsCommon.Main  trfInact_EntityMCV(Corp2_Raw_RI.Layouts.Temp_InActEntity_Merger l) := transform
                           
			self.corp_key												:=state_fips +'-' + (string)(integer)corp2.t2u(l.Entity_ID);
			self.corp_filing_date   					  :=if(corp2.t2u(l.MergerType) in ['C','V'], corp2_mapping.fValidateDate(l.MergerDate).PastDate, '');
			self.corp_filing_cd  					  		:=if(corp2.t2u(l.MergerType) in ['C','V'], 'X', '');
			self.corp_filing_desc  					  	:=map(corp2.t2u(l.MergerType) = 'C' => 'CONSOLIDATION',
																								corp2.t2u(l.MergerType) = 'V' => 'CONVERSION',
																								'');
			self.Corp_Organizational_Comments   :=map(corp2.t2u(l.MergerType) = 'M' => 'MERGED INTO ' +  corp2.t2u(l.ActiveEntity_Name)+', '+ (string)(integer)corp2.t2u(l.SurvivingEntity_ID),
																								corp2.t2u(l.MergerType) = 'C' => 'CONSOLIDATED INTO ' +  corp2.t2u(l.ActiveEntity_Name)+', '+(string)(integer)corp2.t2u(l.SurvivingEntity_ID),
																								corp2.t2u(l.MergerType) = 'V' => 'CONVERTED INTO ' + corp2.t2u(l.ActiveEntity_Name)+', '+(string)(integer)corp2.t2u(l.SurvivingEntity_ID),
																						    '');
    	self.Corp_Merger_Indicator    			:=if(corp2.t2u(l.MergerType) = 'M', 'N', '');
    	self.Corp_Merger_Date   					  :=if(corp2.t2u(l.MergerType) = 'M', corp2_mapping.fValidateDate(l.MergerDate).PastDate, '');
    	self.corp_merger_name   					  :=if(corp2.t2u(l.MergerType) = 'M', corp2.t2u(l.ActiveEntity_Name), '');
			self.Corp_Converted			  				  :=if(corp2.t2u(l.MergerType) = 'V', 'Y', '');
			valid_Date                          := corp2_mapping.fValidateDate(l.DateOfOrganization).PastDate;
			self.corp_inc_date									:= map(corp2.t2u(l.StateOfIncorp)in[ state_origin,''] and corp2.t2u(l.charter) not in foreign_type=>valid_Date,
																								 corp2.t2u(l.charter) not in foreign_type																									  =>valid_Date, 
																							   '');
			self.corp_forgn_date								:= map(corp2.t2u(l.StateOfIncorp)<> state_origin and corp2.t2u(l.charter) in foreign_type=>valid_Date,
																								 corp2.t2u(l.charter) in foreign_type																							 =>valid_Date,
																								 '');	
			self.recordOrigin										:='C';			
			self 																:=[];

		end;

		All_InactEntiti_Mergers:= project(ds_InactEntiti_MCV  , trfInact_EntityMCV(left));
		
		dsMapMergers									:= dedup(sort(distribute(All_Entiti_Mergers + 
																													 All_InactEntiti_Mergers,hash(corp_key)),
																								record,local),record,local) : independent;

		corp2_mapping.LayoutsCommon.Main trfEntityWithMergers(corp2_mapping.LayoutsCommon.Main l, corp2_mapping.LayoutsCommon.Main  r) := transform

			self.Corp_Converted			  					:= r.Corp_Converted   ; 
			self.Corp_Survivor_Corporation_Id		:= r.Corp_Survivor_Corporation_Id   ; 
			self.corp_filing_date   					  := r.corp_filing_date   ; 	 
			self.corp_filing_cd                 := r.corp_filing_cd   ;
			self.corp_filing_desc								:= r.corp_filing_desc   ;
			self.Corp_Organizational_Comments	  := r.Corp_Organizational_Comments   ;
			self.Corp_Merger_Indicator    			:= r.Corp_Merger_Indicator   ; 
			self.Corp_Merger_Id    						  := r.Corp_Merger_Id   ; 
			self.Corp_Merger_Date 							:= r.Corp_Merger_Date   ;
			self.corp_merger_name               := r.corp_merger_name;
			self           										  := l;

		end;

		ds_corpMergerRecs := join(AllCorps,dsMapMergers,
															corp2.t2u(left.corp_key) = corp2.t2u(right.corp_key),
															trfEntityWithMergers(left,right),
															left outer,local):independent;
				
		ds_EntitieOfficer	:= join(ds_full_Entities,ds_full_Officers,
															(string)(integer)corp2.t2u(left.Entity_ID) = (string)(integer)corp2.t2u(right.Entity_ID),
															transform(Corp2_Raw_RI.Layouts.Temp_Officer_Entities,
																				self:= left;
																				self:= right;),
															left outer,local);
																
		corp2_mapping.LayoutsCommon.Main trfCont(Corp2_Raw_RI.Layouts.Temp_Officer_Entities l) := transform,
		skip( corp2_mapping.fCleanBusinessName(state_origin,state_desc,corp2.t2u(l.FirstName  + ' ' + l.MiddleName + ' ' + l.LastName+ ' ' + l.Suffix)).BusinessName ='' )

			self.corp_key										:= state_fips +'-' + (string)(integer)corp2.t2u(l.Entity_ID);
			self.dt_vendor_first_reported		:=(integer)fileDate;
			self.dt_vendor_last_reported	  :=(integer)fileDate;
			self.dt_first_seen							:=(integer)fileDate;
			self.dt_last_seen								:=(integer)fileDate;
			self.corp_ra_dt_first_seen			:=(integer)fileDate;
			self.corp_ra_dt_last_seen				:=(integer)fileDate;
			self.Corp_Process_Date          := fileDate; 
			self.Corp_Vendor                := state_fips;
			self.Corp_State_Origin          := state_origin;
			self.corp_inc_state             := state_origin;
			self.corp_orig_sos_charter_nbr	:= (string)(integer)corp2.t2u(l.Entity_ID);
			self.corp_legal_name            := corp2_mapping.fCleanBusinessName(state_origin,state_desc,l.EntityName).BusinessName;
			self.cont_full_name         	 	:= corp2_mapping.fCleanBusinessName(state_origin,state_desc,corp2.t2u(l.FirstName  + ' ' + l.MiddleName + ' ' + l.LastName+ ' ' + l.Suffix)).BusinessName;				 
			self.cont_type_cd  		        	:= 'F'; 
			self.cont_type_desc  		    		:= 'OFFICER';
			self.cont_title1_desc		    		:= corp2.t2u(l.IndividualTitle);
			country_desc                    := corp2_Raw_RI.Functions.ForgnCountryDesc(l.BusCountryCode);
			self.cont_address_type_cd				:= if(corp2_mapping.fAddressExists(state_origin,state_desc,l.BusAddr1,' ',l.BusCity,l.BusState,l.BusPostalCode,country_desc).ifAddressExists,'T', '');
			self.cont_address_type_desc			:= if(corp2_mapping.fAddressExists(state_origin,state_desc,l.BusAddr1,' ',l.BusCity,l.BusState,l.BusPostalCode,country_desc).ifAddressExists,'CONTACT', '');
			self.cont_address_line1					:= corp2_mapping.fCleanAddress(state_origin,state_desc,l.BusAddr1,' ',l.BusCity,l.BusState,l.BusPostalCode,country_desc).AddressLine1;
			self.cont_address_line2					:= corp2_mapping.fCleanAddress(state_origin,state_desc,l.BusAddr1,' ',l.BusCity,l.BusState,l.BusPostalCode,country_desc).AddressLine2;
			self.cont_address_line3					:= corp2_mapping.fCleanAddress(state_origin,state_desc,l.BusAddr1,' ',l.BusCity,l.BusState,l.BusPostalCode,country_desc).AddressLine3;																					  
			self.cont_prep_addr_line1				:= corp2_mapping.fCleanAddress(state_origin,state_desc,l.BusAddr1,' ',l.BusCity,l.BusState,l.BusPostalCode,country_desc).PrepAddrLine1;
			self.cont_prep_addr_last_line		:= corp2_mapping.fCleanAddress(state_origin,state_desc,l.BusAddr1,' ',l.BusCity,l.BusState,l.BusPostalCode,country_desc).PrepAddrLastLine;
			self.recordOrigin								:= 'T';			
			self													  := [];

		end;

		MapCont 		:= project(ds_EntitieOfficer, trfCont(left)): independent;	
		
    map_corp    := dedup(sort(distribute(ds_corpMergerRecs + 
																				 MapCont ,hash(corp_key)),
															record,local),record,local) : independent;
		
		corp2_mapping.LayoutsCommon.events  trfEvent(Corp2_Raw_RI.Layouts.AmendmentsIN l) := transform,
		skip(corp2.t2u(l.Entity_ID)='' or corp2_mapping.fValidateDate(l.EffectiveDate).PastDate = '' and
				 corp2.t2u(l.FilingCode) ='' and  corp2.t2u(l.FilingName) =''and corp2.t2u(l.Comments)='')

			self.corp_key							 := state_fips +'-' + (string)(integer)corp2.t2u(l.Entity_ID);
			self.corp_vendor					 := state_fips;		
			self.corp_state_origin		 := state_origin;
			self.corp_process_date		 := fileDate;
			self.corp_sos_charter_nbr	 := (string)(integer)corp2.t2u(l.Entity_ID);
			self.event_filing_date     := corp2_mapping.fValidateDate(l.EffectiveDate).PastDate;
			self.event_date_type_cd    := if(trim(self.event_filing_date)<>'','EFF','');
			self.event_date_type_desc  := if(trim(self.event_filing_date)<>'','EFFECTIVE','');
			self.event_filing_cd     	 := corp2.t2u(l.FilingCode);
			self.event_filing_desc     := corp2.t2u(l.FilingName);
			self.event_desc            := regexreplace('<BR>|\\*\\*',corp2.t2u(l.Comments),'');// Per CI:remove <br> at the beginning of the comment & remove ** beginning and ending of comment
			self											 := [];

		end;

		MapEvent := dedup(sort(distribute(project(ds_full_amendments,trfEvent(left)),hash(corp_key)),record,local),record,local):independent ;

		corp2_mapping.LayoutsCommon.stock trfStock(Corp2_Raw_RI.Layouts.StocksIN l) := transform,
		skip(corp2.t2u(l.Entity_ID)='')

			self.corp_key							:= state_fips +'-' + (string)(integer)corp2.t2u(l.Entity_ID);
			self.corp_vendor					:= state_fips;		
			self.corp_state_origin		:= state_origin;
			self.corp_process_date		:= fileDate;
			self.corp_sos_charter_nbr	:= (string)(integer)corp2.t2u(l.Entity_ID);
			self.stock_class         	:= corp2.t2u(l.StockClass);
			self.stock_Authorized_Nbr := if((integer)corp2.t2u(l.AuthorizedNumber) <> 0, (string)(integer)corp2.t2u(l.AuthorizedNumber), '');
			self.stock_nbr_par_shares := if((string)(integer)corp2.t2u(l.ParValuePerShare) in ['','0'], '', (string)(integer)corp2.t2u(l.ParValuePerShare));
			//overload
			self.stock_shares_issued	:= if (trim(l.TotalIssuedOutstanding,left,right) not in ['','0'],(string)(integer)corp2.t2u(l.TotalIssuedOutstanding), '');
			temp_Series      					:= if (trim(l.Series) <> '','SERIES OF STOCK: '+ corp2.t2u(l.Series),'');	
			temp_TotalIssued          := if((string)(integer)corp2.t2u(l.TotalIssuedOutstanding) not in ['','0'],'TOTAL SHARES ISSUED AND TOTAL OUTSTANDING NUMBER OF SHARES: ' + (string)(integer)corp2.t2u(l.TotalIssuedOutstanding),'');
			self.stock_Addl_Info      := map( trim(temp_Series) <> '' and trim(temp_TotalIssued)<>''=>temp_Series +' ,'+temp_TotalIssued,
			                                  trim(temp_Series) <> ''    													  =>temp_Series,
																				trim(temp_TotalIssued)<>''													  =>temp_TotalIssued,
																				'');
			self.Stock_Stock_Series   := corp2.t2u(l.Series);
			self											:= [];

		end;
		
		ds_Stock := project(ds_full_Stocks,trfStock(left)) (corp2.t2u(stock_class + stock_Authorized_Nbr + stock_Addl_Info + Stock_Stock_Series)<>'');
		MapStock := dedup(sort(distribute(ds_Stock,hash(corp_key)),record,local),record,local):independent ;

		corp2_mapping.LayoutsCommon.AR trfAnnualReport(Corp2_Raw_RI.Layouts.EntitiesIN l) := transform,
		skip (corp2.t2u(l.Entity_ID)='')

			self.corp_key								:= state_fips +'-' + (string)(integer)corp2.t2u(l.Entity_ID);
			self.corp_vendor						:= state_fips;		
			self.corp_state_origin			:= state_origin;
			self.corp_process_date			:= filedate;
			self.corp_sos_charter_nbr		:= (string)(integer)corp2.t2u(l.Entity_ID);		
			self.ar_year								:= if(stringlib.stringfilter(l.LastAnnualRptYear,'0123456789') <> '' and
																			  _validate.date.fIsValid(stringlib.stringfilter(l.LastAnnualRptYear,'0123456789'), _validate.date.Rules.YearValid),
																			  stringlib.stringfilter(l.LastAnnualRptYear,'0123456789'),''); 
			self.ar_comment							:= if(trim(self.ar_year)<>'','LAST ANNUAL REPORT FILED YEAR','');																		
			self												:= [];

		end;

		MapAR := dedup(sort(distribute(project(ds_full_Entities, trfAnnualReport(left))(trim(ar_year)<>''),hash(corp_key)),record,local),record,local):independent ;
														
		//--------------------------------------------------------------------	
		//@@@@@@@@@@@@@@	Scrubs for MAIN
		//--------------------------------------------------------------------
		Main_F 										:= map_corp;
		Main_S 										:= Scrubs_Corp2_Mapping_RI_Main.Scrubs; 				     // Scrubs module
		Main_N 										:= Main_S.FromNone(Main_F); 											  // Generate the error flags
		Main_T 										:= Main_S.FromBits(Main_N.BitmapInfile);     		 	 // Use the FromBits module; makes my bitmap datafile easier to get to
		Main_U 										:= Main_S.FromExpanded(Main_N.ExpandedInFile); 		// Pass the expanded error flags into the Expanded module

		//Outputs reports
		Main_ErrorSummary					:= output(Main_U.SummaryStats, named('Main_ErrorSummary_RI_' + filedate));
		Main_ScrubErrorReport 		:= output(choosen(Main_U.AllErrors, 1000), named('Main_ScrubErrorReport_RI_' + filedate));
		Main_SomeErrorValues			:= output(choosen(Main_U.BadValues, 1000), named('Main_SomeErrorValues_RI_' + filedate));
		Main_IsScrubErrors		 		:= IF(count(Main_U.AllErrors)<> 0,true,false);

		// Orbit Stats
		Main_OrbitStats						:= Main_U.OrbitStats();
		//Outputs files
		Main_CreateBitMaps				:= output(Main_N.BitmapInfile,,'~thor_data::corp_RI_main_scrubs_bits',overwrite,compressed);	//long term storage
		Main_TranslateBitMap			:= output(Main_T);
		//Creates Profile's alert template for Orbit - can be copied and imported into Orbit; Only required if rules in Orbit change
		Main_AlertsCSVTemplate		:= Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_'+state_origin+'_Main','ScrubsAlerts', Main_OrbitStats, version,'Corp2_'+state_origin+'_Main').ProfileAlertsTemplate;
		//Submits Profile's stats to Orbit
		Main_SubmitStats 			  	:= Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_'+state_origin+'_Main','ScrubsAlerts', Main_OrbitStats, version,'Corp2_'+state_origin+'_Main').SubmitStats;
		Main_ScrubsWithExamples		:= Scrubs.OrbitProfileStats('Scrubs_Corp_MappingMain_RI_' + filedate,'ScrubsAlerts', Main_OrbitStats, version,'Corp_RI_Main').CompareToProfile_with_Examples;
		
		Main_ScrubsAlert					:= Main_ScrubsWithExamples(RejectWarning = 'Y');
		Main_ScrubsAttachment			:= Scrubs.fn_email_attachment(Main_ScrubsAlert);
		Main_SendEmailFile				:= FileServices.SendEmailAttachData( corp2.Email_Notification_Lists.spray
																																	 ,'Scrubs CorpMain_RI Report' 	//subject
																																	 ,'Scrubs CorpMain_RI Report'  //body
																																	 ,(data)Main_ScrubsAttachment
																																	 ,'text/csv'
																																	 ,'CorpRIMainScrubsReport.csv'
																																	 ,
																																	 ,
																																	 ,corp2.Email_Notification_Lists.spray
																																 );
																					 
		EXPORT Main_BadRecords		  := Main_N.ExpandedInFile( dt_vendor_first_reported_Invalid	<> 0 or
																													dt_vendor_last_reported_Invalid		<> 0 or
																													dt_first_seen_Invalid							<> 0 or
																													dt_last_seen_Invalid							<> 0 or
																													corp_ra_dt_first_seen_Invalid			<> 0 or
																													corp_ra_dt_last_seen_Invalid			<> 0 or
																													corp_key_Invalid									<> 0 or
																													corp_vendor_Invalid								<> 0 or
																													corp_state_origin_Invalid					<> 0 or
																													corp_process_date_Invalid					<> 0 or
																													corp_orig_sos_charter_nbr_Invalid	<> 0 or
																													corp_legal_name_Invalid						<> 0 or
																													corp_ln_name_type_cd_Invalid			<> 0 or
																													corp_filing_date_Invalid					<> 0 or
																													corp_status_date_Invalid					<> 0 or
																													corp_inc_state_Invalid						<> 0 or
																													corp_inc_date_Invalid							<> 0 or
																													corp_term_exist_cd_Invalid				<> 0 or
																													corp_foreign_domestic_ind_Invalid	<> 0 or
																													corp_forgn_state_cd_Invalid				<> 0 or
																													corp_forgn_state_desc_Invalid		  <> 0 or
																													corp_forgn_date_Invalid						<> 0 or
																													corp_for_profit_ind_Invalid				<> 0 or
																													InternalField1_Invalid						<> 0 or
																													InternalField2_Invalid						<> 0 or
																													InternalField3_Invalid						<> 0 or
																													InternalField4_Invalid						<> 0 or
																													recordorigin_Invalid							<> 0
																								         );
																																			
		EXPORT Main_GoodRecords		:= Main_N.ExpandedInFile( dt_vendor_first_reported_Invalid   	 = 0 and
																													dt_vendor_last_reported_Invalid		 = 0 and
																													dt_first_seen_Invalid							 = 0 and
																													dt_last_seen_Invalid							 = 0 and
																													corp_ra_dt_first_seen_Invalid			 = 0 and
																													corp_ra_dt_last_seen_Invalid			 = 0 and
																													corp_key_Invalid									 = 0 and
																													corp_vendor_Invalid								 = 0 and
																													corp_state_origin_Invalid					 = 0 and
																													corp_process_date_Invalid					 = 0 and
																													corp_orig_sos_charter_nbr_Invalid	 = 0 and
																													corp_legal_name_Invalid						 = 0 and
																													corp_ln_name_type_cd_Invalid			 = 0 and
																													corp_filing_date_Invalid					 = 0 and
																													corp_status_date_Invalid					 = 0 and
																													corp_inc_state_Invalid						 = 0 and
																													corp_inc_date_Invalid							 = 0 and
																													corp_term_exist_cd_Invalid				 = 0 and
																													corp_foreign_domestic_ind_Invalid	 = 0 and
																													corp_forgn_state_cd_Invalid				 = 0 and
																													corp_forgn_state_desc_Invalid			 = 0 and
																													corp_forgn_date_Invalid						 = 0 and
																													corp_for_profit_ind_Invalid				 = 0 and
																													InternalField1_Invalid						 = 0 and
																													InternalField2_Invalid						 = 0 and
																													InternalField3_Invalid						 = 0 and
																													InternalField4_Invalid						 = 0 and
																													recordorigin_Invalid							 = 0
																							        );
																											
		EXPORT Main_FailBuild	:= map( corp2_mapping.fCalcPercent(count(Main_N.ExpandedInFile(corp_key_invalid<>0)),count(Main_N.ExpandedInFile),false) 										> Scrubs_Corp2_Mapping_RI_Main.Threshold_Percent.CORP_KEY										   => true,
																	corp2_mapping.fCalcPercent(count(Main_N.ExpandedInFile(corp_orig_sos_charter_nbr_invalid<>0)),count(Main_N.ExpandedInFile),false) 	> Scrubs_Corp2_Mapping_RI_Main.Threshold_Percent.CORP_ORIG_SOS_CHARTER_NBR 	   => true,
																	corp2_mapping.fCalcPercent(count(Main_N.ExpandedInFile(corp_legal_name_invalid<>0)),count(Main_N.ExpandedInFile),false) 						> Scrubs_Corp2_Mapping_RI_Main.Threshold_Percent.CORP_LEGAL_NAME 						   => true,
																	count(Main_GoodRecords) = 0																																																																																											 	 => true,																		
																	false
																);
								
		EXPORT Main_ApprovedRecords 	:= project(Main_GoodRecords,transform(corp2_mapping.LayoutsCommon.Main,self := left));

		Main_ALL		 			:= sequential(IF(count(Main_BadRecords) <> 0
																			,IF (poverwrite
																					 ,output(Main_BadRecords,,corp2_mapping._Dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::main_'	+ state_origin,overwrite,__compressed__)
																					 ,output(Main_BadRecords,,corp2_mapping._Dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::main_'	+ state_origin,__compressed__)
																					)
																	    )
																		,output(Main_ScrubsWithExamples, ALL, NAMED('CorpMainRIScrubsReportWithExamples'+filedate))																		
																		//Send Alerts if Scrubs exceeds thresholds
																		,IF(count(Main_ScrubsAlert) > 0, Main_SendEmailFile, output('corp2_mapping.'+state_origin+' - No "MAIN" Corp Scrubs Alerts'))
																		,Main_ErrorSummary
																		,Main_ScrubErrorReport
																		,Main_SomeErrorValues																		 
																		//,Main_AlertsCSVTemplate
																		,Main_SubmitStats				
																	);
		//==========================================VERSION CONTROL====================================================
		VersionControl.macBuildNewLogicalFile(corp2_mapping._dataset().thor_cluster_Files + 'in::corp2::' + version + '::Main_' 	+ state_origin, Main_ApprovedRecords , main_out,,,pOverwrite);
		VersionControl.macBuildNewLogicalFile(corp2_mapping._dataset().thor_cluster_Files + 'in::corp2::' + version + '::Event_' 	+ state_origin, mapEvent						 , event_out,,,pOverwrite);
		VersionControl.macBuildNewLogicalFile(corp2_mapping._dataset().thor_cluster_Files + 'in::corp2::' + version + '::Ar_' 		+ state_origin, mapAr 						   , Ar_out,,,pOverwrite);
		VersionControl.macBuildNewLogicalFile(corp2_mapping._dataset().thor_cluster_Files + 'in::corp2::' + version + '::stock_' 	+ state_origin, mapstock             , stock_out,,,pOverwrite);

		VersionControl.macBuildNewLogicalFile(corp2_mapping._dataset().thor_cluster_Files + 'fail::corp2::'+version+'::Main_' 	+ state_origin	,Main_F	 ,write_fail_main  ,,,pOverwrite); 

		mapRI:= sequential( if(pshouldspray = true,corp2_mapping.fSprayFiles(state_origin,version,pOverwrite := pOverwrite))
											  //,Corp2_Raw_RI.Build_Bases(filedate,version,pUseProd).All  // Determined build bases is not needed
												,main_out
												,event_out
												,Ar_out	
												,stock_out
												,IF( Main_FailBuild <> true
														,sequential( fileservices.addsuperfile(corp2_mapping._Dataset().thor_cluster_Files + 'in::'+corp2_mapping._Dataset().NameMapped+'::sprayed::event'	,corp2_mapping._Dataset().thor_cluster_Files + 'in::corp2::'+version+'::event_' 	+ state_origin)
																				,fileservices.addsuperfile(corp2_mapping._Dataset().thor_cluster_Files + 'in::'+corp2_mapping._Dataset().NameMapped+'::sprayed::main'		,corp2_mapping._Dataset().thor_cluster_Files + 'in::corp2::'+version+'::main_' 	+ state_origin)																		 
																				,fileservices.addsuperfile(corp2_mapping._Dataset().thor_cluster_Files + 'in::'+corp2_mapping._Dataset().NameMapped+'::sprayed::Ar'			,corp2_mapping._Dataset().thor_cluster_Files + 'in::corp2::'+version+'::Ar_' 	+ state_origin)
																				,fileservices.addsuperfile(corp2_mapping._Dataset().thor_cluster_Files + 'in::'+corp2_mapping._Dataset().NameMapped+'::sprayed::stock'	,corp2_mapping._Dataset().thor_cluster_Files + 'in::corp2::'+version+'::stock_' 	+ state_origin)
																				,if (count(Main_BadRecords) <> 0
																						 ,corp2_mapping.Send_Email(state_origin ,version,count(Main_BadRecords)<>0,,,,count(Main_BadRecords),,count(mapEvent),,count(Main_ApprovedRecords),count(mapAR),count(mapEvent),count(mapStock)).RecordsRejected																				 
																						 ,corp2_mapping.Send_Email(state_origin ,version,count(Main_BadRecords)<>0,,,,count(Main_BadRecords),,count(mapEvent),,count(Main_ApprovedRecords),count(mapAR),count(mapEvent),count(mapStock)).MappingSuccess																				 
																						 )
																				 ,if( Main_IsScrubErrors
																						 ,Corp2_Mapping.Send_Email(state_origin,version,Main_IsScrubErrors,false,false,false).FieldsInvalidPerScrubs
																						)		 
																				)
														 ,sequential( write_fail_main  //if it fails on  main file threshold ,still writing mapped file!
																				 ,corp2_mapping.Send_Email(state_origin,version).MappingFailed
																				)
													)
												,Main_All	
										 );
						
		//Validating the filedate entered is within 30 days					
		isFileDateValid := if((string)std.date.today() between ut.date_math(filedate,-30) and ut.date_math(filedate,30),true,false);
		result		 			:= if(isFileDateValid
													 ,mapRI
													 ,sequential (corp2_mapping.Send_Email(state_origin,filedate).InvalidFileDateParm
																				,FAIL('corp2_mapping.'+state_origin+' failed. An invalid filedate was passed in as a parameter.')
																			 )
								          );
		return result;

	end;	// end of Update function

end;  // end of  module