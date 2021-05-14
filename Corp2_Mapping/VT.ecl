import ut, tools, corp2, versioncontrol, scrubs, std, corp2_raw_vt, scrubs_corp2_mapping_vt_main;

export VT  := MODULE;

	export Update(string fileDate, string version, boolean pShouldSpray = _Dataset().bShouldSpray, boolean pOverwrite = false,pUseProd = Tools._Constants.IsDataland) :=Function
		
		state_origin			:= 'VT';
		state_fips	 			:= '50';
		state_desc	 			:= 'VERMONT';
		ds_Business      	:= dedup(sort(distribute(corp2_raw_vt.files(filedate,pUseProd).input.Business,hash(business_id)),record,local),record,local) : independent;		
		ds_Principals     := dedup(sort(distribute(corp2_raw_vt.files(filedate,pUseProd).input.Principals,hash(business_id)),record,local),record,local) : independent;
		ds_Owners      		:= dedup(sort(distribute(corp2_raw_vt.files(filedate,pUseProd).input.Owners,hash(tradename_id)),record,local),record,local)	 : independent;
		 
		//---------- Begin MAIN Mapping	
		//************
		//CREATE CORP BASE RECORDS for Domestic, Foreign, Trd_Name & Partnership Business Records
		//************
		corp2_mapping.LayoutsCommon.Main  transBus(Corp2_Raw_VT.Layouts.BusLayoutIn l, INTEGER C):= transform,
		skip( C=2 and 
					(corp2_mapping.fcleanbusinessname(state_origin,state_desc,l.business_name).businessname = corp2_mapping.fcleanbusinessname(state_origin,state_desc,l.foreign_business_name).businessname or
					 corp2_mapping.fcleanbusinessname(state_origin,state_desc,l.foreign_business_name).businessname=''
					 ) and
					(corp2.t2u(l.principal_office_address_1 + l.principal_office_address_2 + l.principal_office_city + l.principal_office_State + l.principal_office_Zip) =  corp2.t2u(l.foreign_address_1 + l.foreign_address_2 + l.foreign_City + l.foreign_State + l.foreign_Zip) or
					 corp2.t2u(l.foreign_address_1 + l.foreign_address_2 + l.foreign_City + l.foreign_State + l.foreign_Zip) = ''            
					)
			  )
			self.dt_vendor_first_reported						:=(integer)fileDate;
			self.dt_vendor_last_reported						:=(integer)fileDate;
			self.dt_first_seen											:=(integer)fileDate;
			self.dt_last_seen												:=(integer)fileDate;
			self.corp_ra_dt_first_seen							:=(integer)fileDate;
			self.corp_ra_dt_last_seen								:=(integer)fileDate;
			self.Corp_Process_Date            			:= fileDate; 
			self.Corp_Vendor                  			:= state_fips;
			self.Corp_State_Origin            			:= state_origin;
			self.Corp_Key                     			:= state_fips +'-'+ corp2.t2u(l.business_id);
			self.Corp_Orig_SOS_Charter_Nbr    			:= corp2.t2u(l.business_id);
			self.Corp_Orig_Org_Structure_Desc 			:= if(corp2.t2u(l.business_type) in ['TRADE NAME','ASSUMED BUSINESS NAME'],'',corp2.t2u(l.business_type));
			self.corp_home_state_name								:= corp2_mapping.fCleanBusinessName(state_origin,state_desc,l.foreign_business_name).BusinessName;
			self.Corp_Legal_Name       							:= choose(C,corp2_mapping.fcleanbusinessname(state_origin,state_desc,l.business_name).businessname,corp2_mapping.fcleanbusinessname(state_origin,state_desc,l.foreign_business_name).businessname);
			self.Corp_LN_Name_Type_CD   					  := choose(C, map(corp2.t2u(l.business_type) ='TRADE NAME'=>'04',
			                                                         corp2.t2u(l.business_type) ='ASSUMED BUSINESS NAME'=>'06',
																															 '01'),
			                                                     if(corp2.t2u(l.business_type) ='TRADE NAME','H','O')
																												);
			self.Corp_LN_Name_Type_Desc 						:= choose(C, map(corp2.t2u(l.business_type) ='TRADE NAME'=>'TRADENAME',
			                                                         corp2.t2u(l.business_type) ='ASSUMED BUSINESS NAME'=>'ASSUMED BUSINESS NAME',
																															 'LEGAL'),
																													 if(corp2.t2u(l.business_type) ='TRADE NAME','FOREIGN BUSINESS NAME','OTHER')
																												);
			self.Corp_Address1_Line1								:= choose(c,corp2_mapping.fCleanAddress(state_origin,state_desc,l.principal_office_address_1,l.principal_office_address_2,l.principal_office_city,l.principal_office_state,l.principal_office_zip).AddressLine1
																											   ,corp2_mapping.fCleanAddress(state_origin,state_desc,l.foreign_address_1,l.foreign_address_2,l.foreign_city,l.foreign_state,l.foreign_zip).AddressLine1
																										    );
			self.Corp_Address1_Line2				 				:= choose(c,corp2_mapping.fCleanAddress(state_origin,state_desc,l.principal_office_address_1,l.principal_office_address_2,l.principal_office_city,l.principal_office_state,l.principal_office_zip).AddressLine2
																											   ,corp2_mapping.fCleanAddress(state_origin,state_desc,l.foreign_address_1,l.foreign_address_2,l.foreign_city,l.foreign_state,l.foreign_zip).AddressLine2
																										   );
			self.Corp_Address1_Line3				  			:= choose(c,corp2_mapping.fCleanAddress(state_origin,state_desc,l.principal_office_address_1,l.principal_office_address_2,l.principal_office_city,l.principal_office_state,l.principal_office_zip).AddressLine3
																											   ,corp2_mapping.fCleanAddress(state_origin,state_desc,l.foreign_address_1,l.foreign_address_2,l.foreign_city,l.foreign_state,l.foreign_zip).AddressLine3
																										    );
			self.corp_prep_addr1_line1							:= choose(c,corp2_mapping.fCleanAddress(state_origin,state_desc,l.principal_office_address_1,l.principal_office_address_2,l.principal_office_city,l.principal_office_state,l.principal_office_zip).prepaddrline1
																											   ,corp2_mapping.fCleanAddress(state_origin,state_desc,l.foreign_address_1,l.foreign_address_2,l.foreign_city,l.foreign_state,l.foreign_zip).prepaddrline1
																											  );
			self.corp_prep_addr1_last_line					:= choose(c,corp2_mapping.fCleanAddress(state_origin,state_desc,l.principal_office_address_1,l.principal_office_address_2,l.principal_office_city,l.principal_office_state,l.principal_office_zip).prepaddrlastline
																											   ,corp2_mapping.fCleanAddress(state_origin,state_desc,l.foreign_address_1,l.foreign_address_2,l.foreign_city,l.foreign_state,l.foreign_zip).prepaddrlastline
																											  );
			self.Corp_Address1_Type_cd         			:= choose(c, if(corp2_mapping.fAddressExists(state_origin,state_desc,l.principal_office_address_1,l.principal_office_address_2,l.principal_office_city,l.principal_office_state,l.principal_office_zip).ifAddressExists,'B','')
																											   , if(corp2_mapping.fAddressExists(state_origin,state_desc,l.foreign_address_1,l.foreign_address_2,l.foreign_city,l.foreign_state,l.foreign_zip).ifAddressExists,'O','')
																												);
			self.Corp_Address1_Type_desc         		:= choose(c, if(corp2_mapping.fAddressExists(state_origin,state_desc,l.principal_office_address_1,l.principal_office_address_2,l.principal_office_city,l.principal_office_state,l.principal_office_zip).ifAddressExists,'BUSINESS','')
																											   , if(corp2_mapping.fAddressExists(state_origin,state_desc,l.foreign_address_1,l.foreign_address_2,l.foreign_city,l.foreign_state,l.foreign_zip).ifAddressExists,'OTHER','')
																											  );
			self.corp_address2_line1								:= corp2_mapping.fcleanaddress(state_origin,state_desc,l.mailing_address_1,l.mailing_address_2,l.mailing_city,l.mailing_state,l.mailing_zip).addressline1;
			self.corp_address2_line2				 				:= corp2_mapping.fcleanaddress(state_origin,state_desc,l.mailing_address_1,l.mailing_address_2,l.mailing_city,l.mailing_state,l.mailing_zip).addressline2;
			self.corp_address2_line3				  			:= corp2_mapping.fcleanaddress(state_origin,state_desc,l.mailing_address_1,l.mailing_address_2,l.mailing_city,l.mailing_state,l.mailing_zip).addressline3;
			self.corp_prep_addr2_line1							:= corp2_mapping.fcleanaddress(state_origin,state_desc,l.mailing_address_1,l.mailing_address_2,l.mailing_city,l.mailing_state,l.mailing_zip).prepaddrline1;
			self.corp_prep_addr2_last_line					:= corp2_mapping.fcleanaddress(state_origin,state_desc,l.mailing_address_1,l.mailing_address_2,l.mailing_city,l.mailing_state,l.mailing_zip).prepaddrlastline;
			self.corp_address2_type_cd         			:= if(corp2_mapping.faddressexists(state_origin,state_desc,l.mailing_address_1,l.mailing_address_2,l.mailing_city,l.mailing_state,l.mailing_zip).ifaddressexists,
																									  'M','');
			self.corp_address2_type_desc         		:= if(corp2_mapping.faddressexists(state_origin,state_desc,l.mailing_address_1,l.mailing_address_2,l.mailing_city,l.mailing_state,l.mailing_zip).ifaddressexists,
																									  'MAILING','');		
			self.Corp_Inc_State               			:= state_origin;			
			self.Corp_For_Profit_Ind          			:= map(corp2.t2u(l.business_type) ='DOMESTIC NON-PROFIT CORPORATION'   => 'N',
																										 corp2.t2u(l.business_type) ='DOMESTIC PROFIT CORPORATION'       => 'Y',
																										 corp2.t2u(l.business_type) ='FOREIGN NON-PROFIT CORPORATION'    => 'N',
   																									 corp2.t2u(l.business_type) ='FOREIGN PROFIT CORPORATION'        => 'Y',
   																									 '');
			self.Corp_Foreign_Domestic_Ind    			:= map(corp2.t2u(l.business_type)='GENERAL PARTNERSHIP' and  corp2.t2u(l.place_of_formation)  in [state_desc,state_origin,'']=>'D',
			                                               corp2.t2u(l.business_type)='GENERAL PARTNERSHIP' and  corp2.t2u(l.place_of_formation) not in [state_desc,state_origin,'']=>'F',
   																									 corp2.t2u(l.business_type)in Corp2_Raw_VT.Functions.Dom_Bus_list=>'D',
			                                               corp2.t2u(l.business_type)in Corp2_Raw_VT.Functions.For_Bus_list =>'F',
   																									 '');																					 
			//Per CI :Vendor format in raw data can be  ccyy-mm-dd or mm/dd/yyyy 
			vDate                										:= if(Corp2_Mapping.fValidateDate(l.business_origin_date,Corp2_Mapping.fFormatOfDate(l.business_origin_date)).PastDate <>'',Corp2_Mapping.fValidateDate(l.business_origin_date,Corp2_Mapping.fFormatOfDate(l.business_origin_date)).PastDate,
																										'');
			self.corp_inc_date											:= map(corp2.t2u(l.business_type)='GENERAL PARTNERSHIP' and  corp2.t2u(l.place_of_formation) in [state_desc,state_origin,''] =>vDate,
																										 corp2.t2u(l.place_of_formation) in [state_desc,state_origin,''] and corp2.t2u(l.business_type) not in Corp2_Raw_VT.Functions.For_Bus_list =>vDate,
																										 corp2.t2u(l.business_type) not in Corp2_Raw_VT.Functions.For_Bus_list =>vDate,
   																									 '');												 			
			self.corp_forgn_date										:= map(corp2.t2u(l.business_type)='GENERAL PARTNERSHIP' and  corp2.t2u(l.place_of_formation)  not in [state_desc,state_origin,'']=>vDate,
																										 corp2.t2u(l.place_of_formation)not in [state_desc,state_origin,''] and corp2.t2u(l.business_type) in Corp2_Raw_VT.Functions.For_Bus_list =>vDate,
																										 corp2.t2u(l.business_type)  in Corp2_Raw_VT.Functions.For_Bus_list =>vDate,
   																									 '');			
			//Per CI :Vendor format in raw data can be  ccyy-mm-dd or mm/dd/yyyy 
			self.Corp_Term_Exist_CD           			:= if(Corp2_Mapping.fValidateDate(l.term_date,Corp2_Mapping.fFormatOfDate(l.term_date)).PastDate <>'','D','');   
			self.Corp_Term_Exist_Exp          			:= if(self.Corp_Term_Exist_CD  <> '',Corp2_Mapping.fValidateDate(l.term_date,Corp2_Mapping.fFormatOfDate(l.term_date)).PastDate,'');   
			self.Corp_Term_Exist_Desc         			:= if(self.Corp_Term_Exist_Exp <> '','EXPIRATION DATE','');
			self.Corp_Forgn_State_CD          			:= if(corp2.t2u(l.place_of_formation) not in [state_desc,state_origin,''],Corp2_Raw_VT.Functions.StDesc2Abbrev(l.place_of_formation),'');
			self.Corp_Forgn_State_Desc        			:= map(self.Corp_Forgn_State_CD='**' =>'**|'+corp2.t2u(l.place_of_formation), //make sure to assign state codes for scrubs caught new vendor state descriptions!
																									   corp2.t2u(l.place_of_formation) not in [state_desc,state_origin,''] => corp2.t2u(l.place_of_formation),
																										 '');
			// The Corporation Type and Corporation SubType have very similar in values. Concatenate the fields outputting the value 
			// for Corporation Type first, a space, then Corporation SubType.  If the value of the Corporation Type is within the value of the Corporation SubType,
			// do not append the Corporation Type.
			string Corp_SubType               		 	:= if(corp2.t2u(l.corporation_subtype) <> '',regexreplace(corp2.t2u(l.corporation_type),corp2.t2u(l.corporation_subtype),''),''); 
			self.Corp_Orig_Bus_Type_Desc           	:= corp2.t2u(l.corporation_type + ' ' + Corp_SubType);
			self.Corp_Entity_Desc                  	:= corp2.t2u(l.business_description);
			//addl_info contains overloaded info from these fields :naics_code, fiscal_year_month, manager_managed, members_liable,member_organization
			self.corp_addl_info                			:= Corp2_Raw_VT.Functions.GetAddlInfo(l.naics_code,l.naics_subcode,l.fiscal_year_month,l.manager_managed,l.members_liable,l.member_organization);            
			self.Corp_ra_full_name            			:= corp2_mapping.fCleanBusinessName(state_origin,state_desc,l.registered_agent).BusinessName;
			self.corp_ra_address_line1            	:= corp2_mapping.fcleanaddress(state_origin,state_desc,l.agent_address_1,l.agent_address_2,l.agent_city,l.agent_state,l.agent_zip).addressline1;
			self.corp_ra_address_line2							:= corp2_mapping.fcleanaddress(state_origin,state_desc,l.agent_address_1,l.agent_address_2,l.agent_city,l.agent_state,l.agent_zip).addressline2;
			self.corp_ra_address_line3							:= corp2_mapping.fcleanaddress(state_origin,state_desc,l.agent_address_1,l.agent_address_2,l.agent_city,l.agent_state,l.agent_zip).addressline3;
			self.ra_prep_addr_line1									:= corp2_mapping.fcleanaddress(state_origin,state_desc,l.agent_address_1,l.agent_address_2,l.agent_city,l.agent_state,l.agent_zip).prepaddrline1;
			self.ra_prep_addr_last_line							:= corp2_mapping.fcleanaddress(state_origin,state_desc,l.agent_address_1,l.agent_address_2,l.agent_city,l.agent_state,l.agent_zip).prepaddrlastline;
			self.corp_ra_address_type_cd		  			:= if(corp2_mapping.faddressexists(state_origin,state_desc,l.agent_address_1,l.agent_address_2,l.agent_city,l.agent_state,l.agent_zip).ifaddressexists ,'R','');
			self.corp_ra_address_type_desc					:= if(corp2_mapping.faddressexists(state_origin,state_desc,l.agent_address_1,l.agent_address_2,l.agent_city,l.agent_state,l.agent_zip).ifaddressexists ,'REGISTERED OFFICE'	,'');									 
			self.corp_termination_date              := Corp2_Mapping.fValidateDate(l.termination_date,Corp2_Mapping.fFormatOfDate(l.termination_date)).GeneralDate;
			self.corp_fiscal_year_month             := Corp2_Raw_VT.Functions.GetMonth(l.fiscal_year_month);
			self.corp_manager_managed               := if(corp2.t2u(l.manager_managed) = 'YES','Y','');
			self.corp_purpose												:= corp2.t2u(l.business_description);
			self.corp_llc_managed_desc              := if(corp2.t2u(l.members_liable) = 'YES','MEMBERS LIABLE','');
			self.corp_has_members										:= if(corp2.t2u(l.member_organization) = 'YES','Y','');
			self.corp_dissolved_date                := Corp2_Mapping.fValidateDate(l.dissolved_date,Corp2_Mapping.fFormatOfDate(l.dissolved_date)).GeneralDate;
			self.corp_merger_date                   := Corp2_Mapping.fValidateDate(l.merged_date,Corp2_Mapping.fFormatOfDate(l.merged_date)).GeneralDate;
			self.corp_naics_desc                    := corp2.t2u(l.naics_code);
			//Added for scrub purposes; new vendor business_type values will be captured!,business_type values are crucial for dates & indicator fields!
			self.internalfield1											:= if(corp2.t2u(l.business_type)not in Corp2_Raw_VT.Functions.All_Bus_list,'**'+ corp2.t2u(l.business_type),'');
			self.recordOrigin												:= 'C';	
			self                              			:= [];

		END;
		
		normBus  			:= normalize(ds_Business,2,transBus(left,counter));
		normBus_dedup := dedup(sort(distribute(normBus,hash(Corp_Key)),record,local),record,local);

		//Normalize the date fields to be assigned to CORP_STATUS_DATE.  
		//There can be up to 7 dates, which can create 7 records
		corp2_mapping.LayoutsCommon.Main  Norm_Status(Corp2_Raw_VT.Layouts.BusLayoutIn l, INTEGER C):= transform,
		skip(C=7 and corp2.t2u(l.business_status) = 'TERMINATED' and Corp2_Mapping.fValidateDate(l.termination_date,Corp2_Mapping.fFormatOfDate(l.termination_date)).GeneralDate  <> '')

			self.Corp_Key         := state_fips +'-'+ corp2.t2u(l.business_id);
			self.Corp_Status_Desc := choose(C,if(Corp2_Mapping.fValidateDate(l.termination_date,Corp2_Mapping.fFormatOfDate(l.termination_date)).GeneralDate  <> '','TERMINATED',''), //overload 
																				if(Corp2_Mapping.fValidateDate(l.cessation_date,Corp2_Mapping.fFormatOfDate(l.cessation_date)).GeneralDate      <> '','CESSATION',''), 
																				if(Corp2_Mapping.fValidateDate(l.dissolved_date,Corp2_Mapping.fFormatOfDate(l.dissolved_date)).GeneralDate      <> '','DISSOLVED',''), //overload 
																				if(Corp2_Mapping.fValidateDate(l.withdrawal_date,Corp2_Mapping.fFormatOfDate(l.withdrawal_date)).GeneralDate    <> '','WITHDRAWAL',''),  
																				if(Corp2_Mapping.fValidateDate(l.merged_date,Corp2_Mapping.fFormatOfDate(l.merged_date)).GeneralDate      		  <> '','MERGED',''), //overload 
																				if(Corp2_Mapping.fValidateDate(l.cancellation_date,Corp2_Mapping.fFormatOfDate(l.cancellation_date)).GeneralDate<> '','CANCELLATION',''),
																				corp2.t2u(l.business_status)																				
																		 );
																			
			self.Corp_Status_Date := choose(C, if(self.Corp_Status_Desc = 'TERMINATED',Corp2_Mapping.fValidateDate(l.termination_date,Corp2_Mapping.fFormatOfDate(l.termination_date)).GeneralDate,''), //overload 
																				 if(self.Corp_Status_Desc = 'CESSATION',Corp2_Mapping.fValidateDate(l.cessation_date,Corp2_Mapping.fFormatOfDate(l.cessation_date)).GeneralDate,''),  
																				 if(self.Corp_Status_Desc = 'DISSOLVED',Corp2_Mapping.fValidateDate(l.dissolved_date,Corp2_Mapping.fFormatOfDate(l.dissolved_date)).GeneralDate,''), //overload 
																				 if(self.Corp_Status_Desc = 'WITHDRAWAL',Corp2_Mapping.fValidateDate(l.withdrawal_date,Corp2_Mapping.fFormatOfDate(l.withdrawal_date)).GeneralDate,''), 
																				 if(self.Corp_Status_Desc = 'MERGED',Corp2_Mapping.fValidateDate(l.merged_date,Corp2_Mapping.fFormatOfDate(l.merged_date)).GeneralDate,''), //overload 
																				 if(self.Corp_Status_Desc = 'CANCELLATION',Corp2_Mapping.fValidateDate(l.cancellation_date,Corp2_Mapping.fFormatOfDate(l.cancellation_date)).GeneralDate,''),
																				 if(corp2.t2u(l.business_status) = 'TERMINATED',Corp2_Mapping.fValidateDate(l.termination_date,Corp2_Mapping.fFormatOfDate(l.termination_date)).GeneralDate,'')
																		 );
			self                  := [];

		END;

		normBusStatus    := normalize(ds_Business,7,Norm_Status(left,counter));
		dedup_BusStatus  := dedup(sort(distribute(normBusStatus(trim(Corp_Status_Desc,left,right) <> ''),hash(Corp_Key)),record,local),record,local);
		jCorps_BusStatus := join(normBus_dedup,dedup_BusStatus,
														 corp2.t2u(left.Corp_Key) = corp2.t2u(right.Corp_Key),
														 transform(corp2_mapping.LayoutsCommon.Main,
																			 self.Corp_Status_Desc := right.Corp_Status_Desc;
																			 self.Corp_Status_Date := right.Corp_Status_Date;
																			 self         			   := left;),
														 left outer,local):independent;
														 
		mapCorp  					:=  distribute(jCorps_BusStatus ,hash(Corp_Key,corp_legal_name));
		
		//Per CI: Only mailing addresses & NO Business address then populating business addresses from Mailing addresses & blanking mailing addresses ;
		mapCorp_addr1_blank := mapCorp(corp2.t2u(corp_address2_line1 + corp_address2_line2 + corp_address2_line3 ) <>'' and 
																	 corp2.t2u(corp_address1_line1 + corp_address1_line2 + corp_address1_line3 ) ='' 
																	);
		corp2_mapping.LayoutsCommon.Main AddressTransform(corp2_mapping.LayoutsCommon.Main l ,corp2_mapping.LayoutsCommon.Main r):=transform
		
			self.corp_address1_line1				:= if(l.corp_address1_line1 ='',r.corp_address2_line1,l.corp_address1_line1);
			self.corp_address1_line2				:= if(l.corp_address1_line2 ='',r.corp_address2_line2,l.corp_address1_line2);
			self.corp_address1_line3				:= if(l.corp_address1_line3 ='',r.corp_address2_line3,l.corp_address1_line3);
			self.corp_prep_addr1_line1			:= if(l.corp_prep_addr1_line1 ='',r.corp_prep_addr2_line1,l.corp_prep_addr1_line1);
			self.corp_prep_addr1_last_line	:= if(l.corp_prep_addr1_last_line ='',r.corp_prep_addr2_last_line,l.corp_prep_addr1_last_line);	
			self.corp_address1_type_cd		  := if(l.corp_address1_type_cd ='','B',l.corp_address1_type_cd);
			self.corp_address1_type_desc	  := if(l.corp_address1_type_desc ='','BUSINESS',l.corp_address1_type_desc);
			self.corp_address2_line1				:= if(l.corp_address1_line1 ='','',l.corp_address2_line1);
			self.corp_address2_line2				:= if(l.corp_address1_line2 ='','',l.corp_address2_line2);
			self.corp_address2_line3				:= if(l.corp_address1_line3 ='','',l.corp_address2_line3);
			self.corp_prep_addr2_line1			:= if(l.corp_prep_addr1_line1 ='','',l.corp_prep_addr2_line1);
			self.corp_prep_addr2_last_line	:= if(l.corp_prep_addr1_last_line='','',l.corp_prep_addr2_last_line);
			self.corp_address2_type_cd		  := if(l.corp_address1_type_cd='','',l.corp_address2_type_cd);
			self.corp_address2_type_desc	  := if(l.corp_address1_type_desc='','',l.corp_address2_type_desc);
			self                            := l;
		
		End;
		
		mapCorp_addr 		:= join(mapCorp , mapCorp_addr1_blank ,
														trim(left.corp_key) 				= trim(right.corp_key) and
														trim(left.corp_legal_name)  = trim(right.corp_legal_name), 
														AddressTransform(left,right),
														left outer,local);	
												
		mapCorp_dedup := dedup(sort(distribute(mapCorp_addr,hash(corp_key)),record,local),record,local):independent; 
		
		//---------- Begin CONT Mapping	
		//**************
		//CREATE CONT BASE RECORDS for Domestic ,Foreign ,Partnership and Tradename Principal Records!
		//**************
		corp2_mapping.LayoutsCommon.Main  transPrn(Corp2_Raw_VT.Layouts.Temp_Prn_ContType l) := transform,
		skip(corp2.t2u(l.principal_name) in Corp2_Raw_VT.Functions.Filter_List or 
				 corp2_mapping.fCleanBusinessName(state_origin,state_desc,l.principal_name).businessname='')

			self.dt_vendor_first_reported		:=(integer)fileDate;
			self.dt_vendor_last_reported		:=(integer)fileDate;
			self.dt_first_seen							:=(integer)fileDate;
			self.dt_last_seen								:=(integer)fileDate;
			self.corp_ra_dt_first_seen			:=(integer)fileDate;
			self.corp_ra_dt_last_seen				:=(integer)fileDate;
			self.Corp_Key                   := state_fips +'-'+ corp2.t2u(l.business_id);
			self.Corp_Vendor                := state_fips;
			self.Corp_State_Origin          := state_origin;
			self.Corp_Inc_State             := state_origin;
			self.Corp_Process_Date          := fileDate; 
			self.Corp_Orig_SOS_Charter_Nbr  := corp2.t2u(l.business_id);
			self.Cont_full_Name             := corp2_mapping.fCleanBusinessName(state_origin,state_desc,l.principal_name).businessname;
			self.Cont_Type_CD               := if(l.cont_type='M','M','F');//overload
			self.Cont_Type_Desc             := if(l.cont_type='M','MEMBER/MANAGER/PARTNER','OFFICER');//overload
			self.Cont_Title1_Desc           := corp2.t2u(l.principal_title);
			self.cont_address_line1					:= corp2_mapping.fcleanaddress(state_origin,state_desc,l.business_address_1,l.business_address_2,l.business_city,l.business_state,l.business_zip).addressline1;
			self.cont_address_line2					:= corp2_mapping.fcleanaddress(state_origin,state_desc,l.business_address_1,l.business_address_2,l.business_city,l.business_state,l.business_zip).addressline2;
			self.cont_address_line3					:= corp2_mapping.fcleanaddress(state_origin,state_desc,l.business_address_1,l.business_address_2,l.business_city,l.business_state,l.business_zip).addressline3;
			self.cont_prep_addr_line1				:= corp2_mapping.fcleanaddress(state_origin,state_desc,l.business_address_1,l.business_address_2,l.business_city,l.business_state,l.business_zip).prepaddrline1;
			self.cont_prep_addr_last_line		:= corp2_mapping.fcleanaddress(state_origin,state_desc,l.business_address_1,l.business_address_2,l.business_city,l.business_state,l.business_zip).prepaddrlastline;
			self.cont_address_type_cd       := if(corp2_mapping.faddressexists(state_origin,state_desc,l.business_address_1,l.business_address_2,l.business_city,l.business_state,l.business_zip).ifaddressexists ,'T','');
			self.cont_address_type_desc     := if(corp2_mapping.faddressexists(state_origin,state_desc,l.business_address_1,l.business_address_2,l.business_city,l.business_state,l.business_zip).ifaddressexists ,'CONTACT','');
			self.recordorigin								:= 'T';		
			self                            := [];  

		END; 

		ds_Prin_cont := project(ds_Principals ,transPrn(left));
		
		//***************
		//CREATE CONT BASE RECORDS for Trade Owners Records
		//***************
		corp2_mapping.LayoutsCommon.Main  transTrdOwn(Corp2_Raw_VT.Layouts.TrdNamesOwnLayoutIn l) := transform,
		skip(corp2.t2u(l.tradename_business_owner) in Corp2_Raw_VT.Functions.Filter_List or 
				 corp2_mapping.fCleanBusinessName(state_origin,state_desc,l.tradename_business_owner).businessname='')
 
			self.dt_vendor_first_reported		:=(integer)fileDate;
			self.dt_vendor_last_reported		:=(integer)fileDate;
			self.dt_first_seen							:=(integer)fileDate;
			self.dt_last_seen								:=(integer)fileDate;
			self.corp_ra_dt_first_seen			:=(integer)fileDate;
			self.corp_ra_dt_last_seen				:=(integer)fileDate;
			self.Corp_Key                   := state_fips +'-'+ corp2.t2u(l.tradename_id);
			self.Corp_Vendor                := state_fips;
			self.Corp_State_Origin          := state_origin;
			self.Corp_Inc_State             := state_origin;
			self.Corp_Process_Date          := fileDate; 
			self.Corp_Orig_SOS_Charter_Nbr  := corp2.t2u(l.tradename_id);
			self.Cont_full_Name             := corp2_mapping.fCleanBusinessName(state_origin,state_desc,l.tradename_business_owner).BusinessName;
			self.Cont_Type_CD               := 'O';
			self.Cont_Type_Desc             := 'OWNER';
			self.recordorigin								:= 'T';	
			self                            := [];  
 
		END;
 
		ds_TradeOwner_cont    := project(ds_Owners,transTrdOwn(left));

		Cont_recs := dedup(sort(distribute(ds_Prin_cont +
																			 ds_TradeOwner_cont,hash(Corp_Key)),
														record,local),record,local):independent;
														
		//mapping corp_legal_name for contact rec's												
		Cont_recs_LName   := join(mapCorp_dedup,Cont_recs,
															corp2.t2u(left.Corp_Key) = corp2.t2u(right.Corp_Key), 
															transform(corp2_mapping.LayoutsCommon.Main,
																				self.Corp_Legal_Name := left.Corp_Legal_Name;
																				self         			   := right;), 
															inner,local);
															
															
		Corp2_Mapping.LayoutsCommon.Main legalNameFix_Trans(Corp2_Mapping.LayoutsCommon.Main  l):= transform
			
			self.corp_legal_name :=if(Corp2_Mapping.fSpecialChars(l.corp_legal_name)='FOUND', Corp2_Raw_VT.Functions.fix_ForeignChar(l.corp_legal_name), l.corp_legal_name);
			self								 :=l;
			
		end;
		
		legalNameFix          := project(mapCorp_dedup + Cont_recs_LName, legalNameFix_Trans(left)) ;
		MapMain 							:= dedup(sort(distribute(legalNameFix, hash(corp_key)),record,local),record,local) :independent;		
																 
		//---------- END CONT Mapping	
		//---------- END  MAIN Mapping	
		
		//---------- Begin AR Mapping ----------------------------------------------------------//
		//**********
		//CREATE AR BASE RECORDS for Domestic ,Foreign ,Partnership & Tradename Business Records
		//**********
		corp2_mapping.LayoutsCommon.AR    transDB_AR(Corp2_Raw_VT.Layouts.BusLayoutIn l):= transform,
		skip( trim(l.business_id)='' or 
					(Corp2_Mapping.fValidateDate(l.last_annual_report_date,Corp2_Mapping.fFormatOfDate(l.last_annual_report_date)).PastDate< '19521031' or
					 Corp2_Mapping.fValidateDate(l.last_annual_report_date,Corp2_Mapping.fFormatOfDate(l.last_annual_report_date)).PastDate='')
				 )

			self.Corp_Key					     := state_fips +'-'+ corp2.t2u(l.business_id);
			self.Corp_Vendor				   := state_fips;
			self.Corp_State_Origin		 := state_origin;
			self.Corp_Process_Date		 := fileDate; 
			self.Corp_SOS_Charter_Nbr	 := corp2.t2u(l.business_id);
			//Per CI :Vendor format in raw data can be  ccyy-mm-dd or mm/dd/yyyy !!Do not output any annual report year prior to 10-31-1952. The 1900 dates are just erroneous & add no value.
			self.AR_Report_Dt          := Corp2_Mapping.fValidateDate(l.last_annual_report_date,Corp2_Mapping.fFormatOfDate(l.last_annual_report_date)).PastDate;
			self                       := [];

		END; 

		DB_AR := project(ds_Business , transDB_AR(left));
		MapAR := dedup(sort(distribute(DB_AR, hash(corp_key)),record,local),record,local);
		//---------- END AR Mapping*************
		
		//--------------------------------------------------------------------	
		//@@@@@@@@@@@@@@	Scrubs for MAIN
		//--------------------------------------------------------------------
		Main_F 										:= MapMain; 
		Main_S 										:= Scrubs_corp2_mapping_VT_Main.Scrubs; 				     // Scrubs module
		Main_N 										:= Main_S.FromNone(Main_F); 											  // Generate the error flags
		Main_T 										:= Main_S.FromBits(Main_N.BitmapInfile);     		 	 // Use the FromBits module; makes my bitmap datafile easier to get to
		Main_U 										:= Main_S.FromExpanded(Main_N.ExpandedInFile); 		// Pass the expanded error flags into the Expanded module

		//Outputs reports
		Main_ErrorSummary					:= output(Main_U.SummaryStats, named('Main_ErrorSummary_VT_'+filedate));
		Main_ScrubErrorReport 		:= output(choosen(Main_U.AllErrors, 1000), named('Main_ScrubErrorReport_VT_'+filedate));
		Main_SomeErrorValues			:= output(choosen(Main_U.BadValues, 1000), named('Main_SomeErrorValues_VT_'+filedate));
		Main_IsScrubErrors		 		:= if(count(Main_U.AllErrors)<> 0,true,false);

		// Orbit Stats
		Main_OrbitStats						:= Main_U.OrbitStats();
		//Outputs files
		Main_CreateBitMaps				:= output(Main_N.BitmapInfile,,'~thor_data::corp_VT_main_scrubs_bits',overwrite,compressed);	//long term storage
		Main_TranslateBitMap			:= output(Main_T);
		//Creates Profile's alert template for Orbit - can be copied and imported into Orbit; Only required if rules in Orbit change
		Main_AlertsCSVTemplate	:= Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_'+state_origin+'_Main','ScrubsAlerts', Main_OrbitStats, version,'Corp2_'+state_origin+'_Main').ProfileAlertsTemplate;
		//Submits Profile's stats to Orbit
		Main_SubmitStats 			  := Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_'+state_origin+'_Main','ScrubsAlerts', Main_OrbitStats, version,'Corp2_'+state_origin+'_Main').SubmitStats;
		Main_ScrubsWithExamples	:= Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_'+state_origin+'_Main','ScrubsAlerts', Main_OrbitStats, version,'Corp2_'+state_origin+'_Main').CompareToProfile_with_Examples;
		
		Main_ScrubsAlert					:= Main_ScrubsWithExamples(RejectWarning = 'Y');
		Main_ScrubsAttachment			:= Scrubs.fn_email_attachment(Main_ScrubsAlert);
		Main_SendEmailFile				:= FileServices.SendEmailAttachData( corp2.Email_Notification_Lists.AttachedList
																																	 ,'Scrubs CorpMain_VT Report' 	//subject
																																	 ,'Scrubs CorpMain_VT Report'  //body
																																	 ,(data)Main_ScrubsAttachment
																																	 ,'text/csv'
																																	 ,'CorpVTMainScrubsReport.csv'
																																	);
																				 
		EXPORT Main_BadRecords		 := Main_N.ExpandedInFile( dt_vendor_first_reported_Invalid       <> 0 or
																												 dt_vendor_last_reported_Invalid 	      <> 0 or
																												 dt_first_seen_Invalid 			            <> 0 or
																												 dt_last_seen_Invalid 			     				<> 0 or
																												 corp_ra_dt_first_seen_Invalid 			    <> 0 or
																												 corp_ra_dt_last_seen_Invalid 			    <> 0 or
																												 corp_key_Invalid 			      					<> 0 or
																												 corp_vendor_Invalid 			      				<> 0 or
																												 corp_state_origin_Invalid 			     		<> 0 or
																												 corp_process_date_Invalid 			      	<> 0 or
																												 corp_orig_sos_charter_nbr_Invalid 		  <> 0 or
																												 corp_legal_name_Invalid 			      		<> 0 or
																												 corp_ln_name_type_cd_Invalid 			    <> 0 or
																												 corp_status_desc_Invalid 			      	<> 0 or
																												 corp_inc_state_Invalid 			      		<> 0 or
																												 corp_inc_date_Invalid 			      			<> 0 or
																												 corp_foreign_domestic_ind_Invalid 			<> 0 or
																												 corp_forgn_state_cd_Invalid 			      <> 0 or
																												 corp_forgn_state_desc_Invalid 			    <> 0 or
																												 corp_forgn_date_Invalid 			     			<> 0 or
																												 corp_for_profit_ind_Invalid 			      <> 0 or
																												 internalfield1_Invalid 			          <> 0 or
																												 recordorigin_Invalid 			      			<> 0 
																											);
																																		
		EXPORT Main_GoodRecords		:= Main_N.ExpandedInFile(  dt_vendor_first_reported_Invalid       = 0 and
																												 dt_vendor_last_reported_Invalid 	      = 0 and
																												 dt_first_seen_Invalid 			            = 0 and
																												 dt_last_seen_Invalid 			     				= 0 and
																												 corp_ra_dt_first_seen_Invalid 			    = 0 and
																												 corp_ra_dt_last_seen_Invalid 			    = 0 and
																												 corp_key_Invalid 			      					= 0 and
																												 corp_vendor_Invalid 			      				= 0 and
																												 corp_state_origin_Invalid 			     		= 0 and
																												 corp_process_date_Invalid 			      	= 0 and
																												 corp_orig_sos_charter_nbr_Invalid 		  = 0 and
																												 corp_legal_name_Invalid 			      		= 0 and
																												 corp_ln_name_type_cd_Invalid 			    = 0 and
																												 corp_status_desc_Invalid 			      	= 0 and
																												 corp_inc_state_Invalid 			      		= 0 and
																												 corp_inc_date_Invalid 			      			= 0 and
																												 corp_foreign_domestic_ind_Invalid 			= 0 and
																												 corp_forgn_state_cd_Invalid 			      = 0 and
																												 corp_forgn_state_desc_Invalid 			    = 0 and
																												 corp_forgn_date_Invalid 			     			= 0 and
																												 corp_for_profit_ind_Invalid 			      = 0 and
																												 internalfield1_Invalid 			          = 0 and
																												 recordorigin_Invalid 			      			= 0 
																					           	);

		EXPORT Main_FailBuild	:= map( corp2_mapping.fCalcPercent(count(Main_N.ExpandedInFile(corp_key_invalid<>0)),count(Main_N.ExpandedInFile),false) 										> Scrubs_corp2_mapping_VT_Main.Threshold_Percent.CORP_KEY										   => true,
																	corp2_mapping.fCalcPercent(count(Main_N.ExpandedInFile(corp_orig_sos_charter_nbr_invalid<>0)),count(Main_N.ExpandedInFile),false) 	> Scrubs_corp2_mapping_VT_Main.Threshold_Percent.CORP_ORIG_SOS_CHARTER_NBR 	   => true,
																	corp2_mapping.fCalcPercent(count(Main_N.ExpandedInFile(corp_legal_name_invalid<>0)),count(Main_N.ExpandedInFile),false) 						> Scrubs_corp2_mapping_VT_Main.Threshold_Percent.CORP_LEGAL_NAME 						   => true,
																	count(Main_GoodRecords) = 0																																																																																											 	 => true,																		
																	false
																);
							
		EXPORT Main_ApprovedRecords 	:= project(Main_GoodRecords,transform(corp2_mapping.LayoutsCommon.Main,self := left));

		//==========================================VERSION CONTROL====================================================
		Main_RejFile_Exists	:=if(FileServices.FileExists(corp2_mapping._dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::main_' + state_origin),true,false);		
		Main_ALL		 			  := sequential(if(count(Main_BadRecords) <> 0
																									,IF (poverwrite
																												,output(Main_BadRecords,,corp2_mapping._Dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::main_VT',overwrite,__compressed__,named('Sample_Rejected_MainRecs_VT_'+filedate))
																												,sequential (if(Main_RejFile_Exists,fileservices.deletelogicalfile(corp2_mapping._dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::main_'+ state_origin)),
																																		 output(Main_BadRecords,,corp2_mapping._Dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::main_'+ state_origin,__compressed__,named('Sample_Rejected_MainRecs_VT_'+filedate))
																																		 )
																											)
																	       )
																			,output(Main_ScrubsWithExamples, ALL, NAMED('CorpMainVTScrubsReportWithExamples'+filedate))																		
																			//Send Alerts if Scrubs exceeds thresholds
																			,if(count(Main_ScrubsAlert) > 0, Main_SendEmailFile, output('CORP2_MAPPING.'+state_origin+' - No "MAIN" Corp Scrubs Alerts'))
																			,Main_ErrorSummary
																			,Main_ScrubErrorReport
																			,Main_SomeErrorValues	
																			//,Main_AlertsCSVTemplate
																			,Main_SubmitStats
																		);	
		//==========================================VERSION CONTROL====================================================
		VersionControl.macBuildNewLogicalFile(corp2_mapping._dataset().thor_cluster_Files + 'in::corp2::' + version + '::Main_' + state_origin, Main_ApprovedRecords , main_out,,,pOverwrite);
		VersionControl.macBuildNewLogicalFile(corp2_mapping._dataset().thor_cluster_Files + 'in::corp2::' + version + '::Ar_' 	+ state_origin, mapAr ,Ar_out,,,pOverwrite);

		VersionControl.macBuildNewLogicalFile(corp2_mapping._dataset().thor_cluster_Files + 'fail::corp2::'+version+'::Main_' 	+ state_origin	,Main_F	 ,write_fail_main  ,,,pOverwrite); 
    
		mapVT:= sequential( if(pshouldspray = true,corp2_mapping.fSprayFiles(state_origin,version,pOverwrite := pOverwrite))
											  //,Corp2_Raw_VT.Build_Bases(filedate,version,puseprod).All  // Determined building of bases is not needed
												,main_out
												,Ar_out										
												,if(Main_FailBuild <> true
														,sequential( fileservices.addsuperfile(corp2_mapping._Dataset().thor_cluster_Files + 'in::'+corp2_mapping._Dataset().NameMapped+'::sprayed::main'	,corp2_mapping._Dataset().thor_cluster_Files + 'in::corp2::'+version+'::main_' 	+ state_origin)																		 
																				,fileservices.addsuperfile(corp2_mapping._Dataset().thor_cluster_Files + 'in::'+corp2_mapping._Dataset().NameMapped+'::sprayed::Ar'	,corp2_mapping._Dataset().thor_cluster_Files + 'in::corp2::'+version+'::Ar_' 	+ state_origin)
																				,if (count(Main_BadRecords) <> 0 
																							,corp2_mapping.Send_Email(state_origin ,version,count(Main_BadRecords)<>0,,,,count(Main_BadRecords),,,,count(Main_ApprovedRecords),count(mapAR)).RecordsRejected																				 
																							,corp2_mapping.Send_Email(state_origin ,version,count(Main_BadRecords)<>0,,,,count(Main_BadRecords),,,,count(Main_ApprovedRecords),count(mapAR)).MappingSuccess																				 
																						)
																				,IF(Main_IsScrubErrors
																						,Corp2_Mapping.Send_Email(state_origin ,version,Main_IsScrubErrors,false,false,false).FieldsInvalidPerScrubs																				 
																						)
																				)
														 ,sequential( write_fail_main  //if it fails on  main file threshold ,still writing mapped file!
																				 ,corp2_mapping.Send_Email(state_origin,version).MappingFailed
																				)
													   )
												,Main_All	
											);
											
    //Validating the filedate entered is within 30 days								
		isFileDateValid := if((string)Std.Date.Today() between ut.date_math(filedate,-30) and ut.date_math(filedate,30),true,false);
		result		 			:= if( isFileDateValid 
													 ,mapVT
													 ,sequential (corp2_mapping.Send_Email(state_origin,filedate).InvalidFileDateParm
																				,FAIL('corp2_mapping.'+state_origin+' failed. An invalid filedate was passed in as a parameter.')
																			 )
									       );
		return result;

	end;	// end of Update function

end;  // end of  module

	
	