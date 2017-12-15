Import  corp2, corp2_raw_nc, scrubs, scrubs_corp2_mapping_nc_main, scrubs_corp2_mapping_nc_event, scrubs_corp2_mapping_nc_ar, tools, ut, versioncontrol, std ;

export NC:=MODULE; 

export Update( string fileDate,string version, boolean pShouldSpray = _Dataset().bShouldSpray, boolean pOverwrite = false,pUseProd = Tools._Constants.IsDataland) :=Function
		
		state_origin 				 		:='NC';
		state_fips	 				 		:='37' ;	
		state_desc	 				 		:='NORTH CAROLINA';

		ds_corporations 		 		:=dedup(sort(distribute(corp2_raw_nc.Files(filedate,pUseProd).Input.corporations.logical,hash(Corp_EntityID)),record,local),record,local):independent;
		ds_namereservations  		:=dedup(sort(distribute(corp2_raw_nc.Files(filedate,pUseProd).Input.NameReservations.logical,hash(EntityID)),record,local),record,local):independent;
		//Per CI :Do not output if the ENAME contains "DROP" or "," 							 
	  ds_names   			     		:=project(corp2_raw_nc.Files(filedate,pUseProd).Input.names.logical(corp2.t2u(Ename) not in ['DROP',',']),transform(corp2_raw_nc.Layouts.NamesLayoutIn,self := left;));
		clean_names        			:=dedup(sort(distribute(ds_Names,hash(Name_EntityID)),record,local),record,local):independent;		
		ds_filings 			 		 		:=dedup(sort(distribute(corp2_raw_nc.Files(filedate,pUseProd).Input.Filings.logical,hash(Filings_PitemID)),record,local),record,local):independent;
		ds_stock  					 		:=dedup(sort(distribute(corp2_raw_nc.Files(filedate,pUseProd).Input.Stock.logical,hash(Stock_PitemID)),record,local),record,local):independent;
		ds_pendingfilings 	 		:=dedup(sort(distribute(corp2_raw_nc.Files(filedate,pUseProd).Input.PendingFilings.logical,hash(Filings_PitemID)),record,local),record,local):independent;
		ds_corpofficers   	 		:=dedup(sort(distribute(corp2_raw_nc.Files(filedate,pUseProd).Input.CorpOfficers.logical,hash(Offi_PitemID)),record,local),record,local):independent; 
  	ds_parse_addr						:=corp2_raw_nc.functions.ds_addr_trns(corp2_raw_nc.Files(filedate,pUseProd).Input.Addresses.logical);
		ds_addresses 						:=dedup(sort(distribute(ds_parse_addr,hash(Address_EntityID)),record,local),record,local):independent;	
		AR_Type_List				 		:=['AART', 'AN', 'AN98', 'ANF', 'ANLP', 'ANRC', 'ANRL', 'ANRN','ANRT'];	
		
		joinCorp_Lname 			 		:=join(ds_corporations,clean_names,
																	 trim(left.Corp_EntityID,left,right) = trim(right.Name_EntityID,left,right),
																	 transform(corp2_raw_nc.Layouts.Temp_Corp_Name,
																						 self :=left;
																						 self	:=right;
																					 ),
																	 left outer,local): independent;										 
		
		joinCorp_LName_Addr 		:=join(ds_addresses,joinCorp_Lname,
																	 trim(left.Address_EntityID,left,right) = trim(right.Corp_EntityID,left,right),
																	 transform(corp2_raw_nc.layouts.Temp_nc_full_addr,								 
																						 self	:=right;									 
																						 self :=left;																											
																						),
																	 right outer,local):independent;
																	 
		slim_Corp							 :=project(joinCorp_LName_Addr,transform(corp2_raw_nc.layouts.Temp_SlimCorp_addr,self := left;));
		raw_corp	         		 :=dedup(sort(distribute(slim_Corp,hash(Corp_PitemID)),record,local),record,local):independent;		
		
		corp2_mapping.LayoutsCommon.Main corpLegal_Transform(corp2_raw_nc.layouts.Temp_SlimCorp_addr l):=transform

			self.dt_vendor_first_reported		 	 :=(integer)fileDate;
			self.dt_vendor_last_reported		 	 :=(integer)fileDate;
			self.dt_first_seen							 	 :=(integer)fileDate;
			self.dt_last_seen								 	 :=(integer)fileDate;
			self.corp_ra_dt_first_seen			 	 :=(integer)fileDate;
			self.corp_ra_dt_last_seen				 	 :=(integer)fileDate;					
			self.corp_process_date					   :=fileDate;
			self.corp_key										   :=state_fips +'-'+ corp2.t2u(l.Corp_PitemID);
			self.corp_vendor								   :=state_fips ;
			self.corp_state_origin 					   :=state_origin  ;				
			self.corp_inc_state                :=state_origin ;
			self.corp_orig_sos_charter_nbr	   :=corp2.t2u(l.CorpNum); //Per CI ,some charter numbers are zero filled or blank.
			self.corp_legal_name						   :=corp2_mapping.fCleanBusinessName(state_origin,state_desc,L.Ename).BusinessName;
			self.corp_ln_name_type_cd          :=corp2_raw_nc.functions.CorplnNameTypeCD(l.NtypeID);
			self.corp_ln_name_type_desc        :=corp2_raw_nc.functions.CorplnNameTypeDESC(l.NtypeID);
			self.corp_orig_org_structure_cd    :=corp2.t2u(l.CorpType);
			self.corp_orig_org_structure_desc  :=corp2_raw_nc.functions.CorpOrigOrgStructDesc(l.CorpType);
			self.corp_for_profit_ind     			 :=corp2_raw_nc.functions.CorpForProfitInd(l.CorpType);
			self.corp_status_cd                :=corp2.t2u(l.Status); 
			self.corp_status_desc              :=corp2_raw_nc.functions.GetStatusDesc(l.Status);	
			self.corp_foreign_domestic_ind     :=map(corp2.t2u(l.Citzenship)='D'=>'D',
																							 corp2.t2u(l.Citzenship)in ['F','N']=>'F',
																							 '');
			self.corp_inc_date                 :=if(corp2.t2u(l.Citzenship)='D',corp2_mapping.fValidateDate(l.DateFormed, 'CCYY-MM-DD').GeneralDate,'');
			self.corp_forgn_date               :=if(corp2.t2u(l.Citzenship)in ['F','N'],corp2_mapping.fValidateDate(l.DateFormed, 'CCYY-MM-DD').GeneralDate,'');
			self.corp_home_incorporated_county :=if(corp2.t2u(l.countyOfInc)<>'UNKNOWN',corp2.t2u(l.countyOfInc),'') ;			//full verbiage from vendor																	
			self.corp_dissolved_date           :=corp2_mapping.fValidateDate(l.DissolveDate, 'CCYY-MM-DD').PastDate;
			duration_Plist 										 :='INDEFINITE|INFINITE|NO LIMIT|NO DURATION|NOT LIMITED|PERPETUA|PERPETUAL|PEREPTUAL|PERPETUAL|UNLIMTED|UNLIMITE';
 			self.corp_term_exist_cd            :=map(corp2_mapping.fValidateDate(l.Duration, 'MM/DD/CCYY').GeneralDate<>''					  =>'D',	//'08/17/20014'
   																							 corp2_mapping.fValidateDate(l.Duration, 'MMM_DD_CCYY').GeneralDate<>''					=>'D',	//Dec 25 2015
   																							 regexfind('ONE|FIFTY',l.Duration,nocase)																				=>'N',
   																							 regexfind('YEAR',l.Duration,nocase) and (string)(integer)l.Duration <>'0'			=>'N',
   																							 regexfind(duration_Plist,l.Duration,nocase)																		=>'P',
   																							 '');	
			self.corp_term_exist_exp            :=map(corp2_mapping.fValidateDate(l.Duration, 'MM/DD/CCYY').GeneralDate<>''		=>corp2_mapping.fValidateDate(l.Duration, 'MM/DD/CCYY').GeneralDate,
																								corp2_mapping.fValidateDate(l.Duration, 'MMM_DD_CCYY').GeneralDate<>''	=>corp2_mapping.fValidateDate(l.Duration, 'MMM_DD_CCYY').GeneralDate,//Dec 25 2015
																								regexfind('ONE',l.Duration,nocase)																			=>'1',
																								regexfind('FIFTY',l.Duration,nocase)																		=>'50',
																								regexfind('YEAR',l.Duration,nocase)and (string)(integer)l.Duration <>'0'=>(string)(integer)l.Duration,
																								'');
			self.corp_term_exist_desc           :=map(self.corp_term_exist_cd ='N'=>'NUMBER OF YEARS',
																								self.corp_term_exist_cd ='P'=>'PERPETUAL',
																								self.corp_term_exist_cd ='D'=>'EXPIRATION DATE',
																								'');

			self.corp_country_of_formation		  :=corp2_mapping.fCleancountry(state_origin,state_desc,'',l.countryOfInc).country;		//full verbiage from vendor															
			self.corp_forgn_state_cd            :=if(corp2.t2u(l.StateOfInc)not in [state_origin,''] ,corp2_raw_nc.Functions.Get_State_Code(l.StateOfInc),''); 
			self.corp_forgn_state_desc          :=if(corp2.t2u(l.StateOfInc)not in [state_origin,''] ,corp2_raw_nc.Functions.fGetStateDesc(l.StateOfInc),'');
			self.corp_purpose               		:=corp2.t2u(l.Purpose);
			self.corp_profession               	:=if(corp2.t2u(l.Profession)<>'UNKNOWN' ,corp2.t2u(l.Profession),'');
			self.corp_llc_managed_ind           :=if(corp2.t2u(l.Managed)='1','Y','');
			self.corp_has_members               :=if(corp2.t2u(l.Members)='1','Y','');
			self.corp_llc_managed_desc          :=if(corp2.t2u(l.MemberManaged)='1','MEMBER MANAGED','');
			self.corp_fiscal_year_month         :=corp2_raw_nc.functions.fGetfiscalMonth(l.FiscalMonth);
			self.corp_orig_bus_type_desc        :=if(l.Purpose<>'',corp2.t2u(l.Purpose),''); 
			self.corp_entity_desc				  			:=if(l.Profession<>'',corp2.t2u(l.Profession),'');//overloaded 
			self.corp_anniversary_month			  	:=corp2_raw_nc.functions.fGetfiscalMonth(l.FiscalMonth);//overloaded 		
			self.corp_addl_info       					:=corp2_raw_nc.Functions.Addl_Info(l.Managed,l.Members,l.countyofinc,l.MemberManaged);
			self.corp_address1_line1				    :=map(corp2.t2u(l.b_addr1+l.b_addr2+l.b_addr3+l.b_city+l.b_state+l.b_zip)<>''=>corp2_mapping.fCleanAddress(state_origin,state_desc,l.b_addr1+ ' ' +l.b_addr2,l.b_addr3,l.b_city,l.b_state,l.b_zip).AddressLine1,
																								corp2.t2u(l.o_addr1+l.o_addr2+l.o_addr3+l.o_city+l.o_state+l.o_zip)<>''=>corp2_mapping.fCleanAddress(state_origin,state_desc,l.o_addr1+ ' ' +l.o_addr2,l.o_addr3,l.o_city,l.o_state,l.o_zip).AddressLine1,
																								'');
			self.corp_address1_line2						:=map(corp2.t2u(l.b_addr1+l.b_addr2+l.b_addr3+l.b_city+l.b_state+l.b_zip)<>''=>corp2_mapping.fCleanAddress(state_origin,state_desc,l.b_addr1+ ' ' +l.b_addr2,l.b_addr3,l.b_city,l.b_state,l.b_zip).AddressLine2,
																								corp2.t2u(l.o_addr1+l.o_addr2+l.o_addr3+l.o_city+l.o_state+l.o_zip)<>''=>corp2_mapping.fCleanAddress(state_origin,state_desc,l.o_addr1+ ' ' +l.o_addr2,l.o_addr3,l.o_city,l.o_state,l.o_zip).AddressLine2,
																								'');
			self.corp_address1_line3						:=map(corp2.t2u(l.b_addr1+l.b_addr2+l.b_addr3+l.b_city+l.b_state+l.b_zip)<>''=>corp2_mapping.fCleanAddress(state_origin,state_desc,l.b_addr1+ ' ' +l.b_addr2,l.b_addr3,l.b_city,l.b_state,l.b_zip).AddressLine3,
																								corp2.t2u(l.o_addr1+l.o_addr2+l.o_addr3+l.o_city+l.o_state+l.o_zip)<>''=>corp2_mapping.fCleanAddress(state_origin,state_desc,l.o_addr1+ ' ' +l.o_addr2,l.o_addr3,l.o_city,l.o_state,l.o_zip).AddressLine3,
																								'');
			self.corp_prep_addr1_line1					:=map(corp2.t2u(l.b_addr1+l.b_addr2+l.b_addr3+l.b_city+l.b_state+l.b_zip)<>''=>corp2_mapping.fCleanAddress(state_origin,state_desc,l.b_addr1+ ' ' +l.b_addr2,l.b_addr3,l.b_city,l.b_state,l.b_zip).prepaddrline1,
																								corp2.t2u(l.o_addr1+l.o_addr2+l.o_addr3+l.o_city+l.o_state+l.o_zip)<>''=>corp2_mapping.fCleanAddress(state_origin,state_desc,l.o_addr1+ ' ' +l.o_addr2,l.o_addr3,l.o_city,l.o_state,l.o_zip).prepaddrline1,
																								'');
			self.corp_prep_addr1_last_line			:=map(corp2.t2u(l.b_addr1+l.b_addr2+l.b_addr3+l.b_city+l.b_state+l.b_zip)<>''=>corp2_mapping.fCleanAddress(state_origin,state_desc,l.b_addr1+ ' ' +l.b_addr2,l.b_addr3,l.b_city,l.b_state,l.b_zip).prepaddrlastline,
																								corp2.t2u(l.o_addr1+l.o_addr2+l.o_addr3+l.o_city+l.o_state+l.o_zip)<>''=>corp2_mapping.fCleanAddress(state_origin,state_desc,l.o_addr1+ ' ' +l.o_addr2,l.o_addr3,l.o_city,l.o_state,l.o_zip).prepaddrlastline,
																								'');
			self.corp_address1_type_cd      		:=map(corp2.t2u(l.b_addr1+l.b_addr2+l.b_addr3+l.b_city+l.b_state+l.b_zip)<>''and corp2_mapping.fAddressExists(state_origin,state_desc,l.b_addr1+ ' ' +l.b_addr2,l.b_addr3,l.b_city,l.b_state,l.b_zip).ifAddressExists =>'B',
																								corp2.t2u(l.o_addr1+l.o_addr2+l.o_addr3+l.o_city+l.o_state+l.o_zip)<>''and corp2_mapping.fAddressExists(state_origin,state_desc,l.o_addr1+ ' ' +l.o_addr2,l.o_addr3,l.o_city,l.o_state,l.o_zip).ifAddressExists =>'O',
																								'');
			self.corp_address1_type_desc    		:=map(corp2.t2u(l.b_addr1+l.b_addr2+l.b_addr3+l.b_city+l.b_state+l.b_zip)<>'' and corp2_mapping.fAddressExists(state_origin,state_desc,l.b_addr1+ ' ' +l.b_addr2,l.b_addr3,l.b_city,l.b_state,l.b_zip).ifAddressExists =>'BUSINESS',
																								corp2.t2u(l.o_addr1+l.o_addr2+l.o_addr3+l.o_city+l.o_state+l.o_zip)<>'' and corp2_mapping.fAddressExists(state_origin,state_desc,l.o_addr1+ ' ' +l.o_addr2,l.o_addr3,l.o_city,l.o_state,l.o_zip).ifAddressExists =>'OTHER',
																								'');
			self.corp_address2_line1						:=corp2_mapping.fCleanAddress(state_origin,state_desc,l.m_Addr1+ ' ' +l.m_Addr2,l.m_Addr3,l.m_city,l.m_State,l.m_Zip).AddressLine1;
			self.corp_address2_line2				 		:=corp2_mapping.fCleanAddress(state_origin,state_desc,l.m_Addr1+ ' ' +l.m_Addr2,l.m_Addr3,l.m_city,l.m_State,l.m_Zip).AddressLine2;
			self.corp_address2_line3				 		:=corp2_mapping.fCleanAddress(state_origin,state_desc,l.m_Addr1+ ' ' +l.m_Addr2,l.m_Addr3,l.m_city,l.m_State,l.m_Zip).AddressLine3;
			self.corp_prep_addr2_line1					:=corp2_mapping.fCleanAddress(state_origin,state_desc,l.m_Addr1+ ' ' +l.m_Addr2,l.m_Addr3,l.m_city,l.m_State,l.m_Zip).PrepAddrLine1;
			self.corp_prep_addr2_last_line			:=corp2_mapping.fCleanAddress(state_origin,state_desc,l.m_Addr1+ ' ' +l.m_Addr2,l.m_Addr3,l.m_city,l.m_State,l.m_Zip).PrepAddrLastLine;
			self.corp_address2_type_cd					:=if(corp2_mapping.fAddressExists(state_origin,state_desc,l.m_Addr1+ ' ' +l.m_Addr2,l.m_Addr3,l.m_city,l.m_State,l.m_Zip).ifAddressExists ,
																							 'M','');
			self.corp_address2_type_desc				:=if(corp2_mapping.fAddressExists(state_origin,state_desc,l.m_Addr1+ ' ' +l.m_Addr2,l.m_Addr3,l.m_city,l.m_State,l.m_Zip).ifAddressExists ,
																							 'MAILING','');	
			self.corp_inc_county                :=corp2.t2u(l.b_countyname);
			self.corp_home_state_name           :=if(corp2.t2u(l.NtypeID) ='13',corp2_mapping.fCleanBusinessName(state_origin,state_desc,L.Ename).BusinessName,'');	
			self.recordorigin									  :='C';	
			self                      					:=[];

		end; 	

		MapCorpLegal 				:= project(raw_corp,corpLegal_Transform(LEFT));
		d_mapCorp 					:= dedup(sort(distribute(MapCorpLegal	,hash(corp_key)),record,local),record,local):independent;
		
		NC_addr1_blank 			:= d_mapCorp(corp2.t2u(corp_address2_line1 + corp_address2_line2 + corp_address2_line3 ) <>'' and corp2.t2u(corp_address1_line1 + corp_address1_line2 + corp_address1_line3 ) ='');
			
		//Per CI: Maping business addresses from Mailing addresses & blanking mailing addresses ,if there are only mailing addresses;
		corp2_mapping.LayoutsCommon.Main AddressTransform(corp2_mapping.LayoutsCommon.Main l ,corp2_mapping.LayoutsCommon.Main r):=transform
		
			self.corp_address1_line1					:= if(l.corp_address1_line1 ='',r.corp_address2_line1,l.corp_address1_line1);
			self.corp_address1_line2					:= if(l.corp_address1_line2 ='',r.corp_address2_line2,l.corp_address1_line2);
			self.corp_address1_line3					:= if(l.corp_address1_line3 ='',r.corp_address2_line3,l.corp_address1_line3);
			self.corp_prep_addr1_line1				:= if(l.corp_prep_addr1_line1 ='',r.corp_prep_addr2_line1,l.corp_prep_addr1_line1);
			self.corp_prep_addr1_last_line		:= if(l.corp_prep_addr1_last_line ='',r.corp_prep_addr2_last_line,l.corp_prep_addr1_last_line);	
			self.corp_address1_type_cd		    := if(l.corp_address1_type_cd ='','B',l.corp_address1_type_cd);
			self.corp_address1_type_desc	    := if(l.corp_address1_type_desc ='','BUSINESS',l.corp_address1_type_desc);
			self.corp_address2_line1					:= if(l.corp_address1_line1 ='','',l.corp_address2_line1);
			self.corp_address2_line2					:= if(l.corp_address1_line2 ='','',l.corp_address2_line2);
			self.corp_address2_line3					:= if(l.corp_address1_line3 ='','',l.corp_address2_line3);
			self.corp_prep_addr2_line1				:= if(l.corp_prep_addr1_line1 ='','',l.corp_prep_addr2_line1);
			self.corp_prep_addr2_last_line		:= if(l.corp_prep_addr1_last_line='','',l.corp_prep_addr2_last_line);
			self.corp_address2_type_cd		    := if(l.corp_address1_type_cd='','',l.corp_address2_type_cd);
			self.corp_address2_type_desc	    := if(l.corp_address1_type_desc='','',l.corp_address2_type_desc);
			self                              := l;
		
		End;
   		
		ds_NC_corps := join(d_mapCorp,NC_addr1_blank,
												left.corp_key = right.corp_key ,
												AddressTransform(left,right),
												left outer,
												local):independent;												
													
		Corp2_Mapping.LayoutsCommon.main tGetStandardized(Corp2_Mapping.LayoutsCommon.main  l	,Corp2_Mapping.LayoutsCommon.main  r) :=transform

			self.corp_address1_type_cd   	:= if(r.corp_address1_type_cd <> '', 		r.corp_address1_type_cd, 		l.corp_address1_type_cd);
			self.corp_address1_type_desc	:= if(r.corp_address1_type_desc <> '', 	r.corp_address1_type_desc,  l.corp_address1_type_desc);
			self.corp_address1_line1			:= if(r.corp_address1_line1 <> '', 			r.corp_address1_line1, 			l.corp_address1_line1);
			self.corp_address1_line2 			:= if(r.corp_address1_line2 <> '', 			r.corp_address1_line2, 			l.corp_address1_line2);
			self.corp_address1_line3 			:= if(r.corp_address1_line3 <> '', 		  r.corp_address1_line3, 		  l.corp_address1_line3);
			self.corp_prep_addr1_line1		:= if(r.corp_prep_addr1_line1 <> '', 		r.corp_prep_addr1_line1,	  l.corp_prep_addr1_line1);
			self.corp_prep_addr1_last_line:= if(r.corp_prep_addr1_last_line<> '', r.corp_prep_addr1_last_line,l.corp_prep_addr1_last_line);
			self.corp_address2_line1		  := if(r.corp_address2_line1 <> '', 			r.corp_address2_line1, 			l.corp_address2_line1);
			self.corp_address2_line2			:= if(r.corp_address2_line2 <> '',			r.corp_address2_line2, 			l.corp_address2_line2);
			self.corp_address2_line3 			:= if(r.corp_address2_line3 <> '',		  r.corp_address2_line3, 			l.corp_address2_line3);
			self.corp_address2_type_cd   	:= if(r.corp_address2_type_cd <> '', 		r.corp_address2_type_cd, 		l.corp_address2_type_cd);
			self.corp_address2_type_desc	:= if(r.corp_address2_type_desc <> '', 	r.corp_address2_type_desc, 	l.corp_address2_type_desc);
			self.corp_prep_addr2_line1		:= if(r.corp_prep_addr2_line1 <> '', 		r.corp_prep_addr2_line1, 		l.corp_prep_addr2_line1);
			self.corp_prep_addr2_last_line:= if(r.corp_prep_addr2_last_line<> '', r.corp_prep_addr2_last_line,l.corp_prep_addr2_last_line);
			self.corp_country_of_formation:= if(r.corp_country_of_formation<> '', r.corp_country_of_formation,l.corp_country_of_formation);
			self.corp_inc_county					:= if(r.corp_inc_county<> '',						r.corp_inc_county,					l.corp_inc_county);
			self 													:= l;

		end;
		
		ds_MapCorp  := distribute (ds_NC_corps ,hash(corp_key,corp_legal_name)) ;
		denorm_Corp	:= denormalize( ds_MapCorp,
																ds_MapCorp,
																left.corp_key 				= right.corp_key  and
																left.corp_legal_name 	= right.corp_legal_name,  
																tGetStandardized(left,right),
																local
															) ;

		dsCorpAddr_dedup 	:=dedup(sort(distribute(denorm_Corp,hash(corp_key)),record,local),record,local):independent;
		
		slim_ra						:=project(joinCorp_LName_Addr,transform(corp2_raw_nc.layouts.Temp_Addr_ra,self := left;));
		slim_name					:=project(clean_names,transform(corp2_raw_nc.layouts.Temp_Name_ra,self.ra_name :=left.ename;self := left;));
	
		//distributing on AgentEntityID & joining with Name's file to get RA names!
		ds_Agents 				:= distribute(slim_ra((string)(integer)agententityid not in['-1','-2','0'] and (string)(integer)atypeid in ['10','13']),hash(agententityid));
		ds_slim_name 			:= dedup(sort(distribute(slim_name,hash(Name_EntityID)),record,local),record,local);
		
   	ds_corpAgents			:= join(ds_slim_name,ds_Agents,
														  trim(left.Name_EntityID,left,right)= trim(right.AgentEntityID,left,right), 
														  transform(corp2_raw_nc.layouts.Temp_SlimCorp_ra,
																			  self :=left;																				
																			  self :=right;
																			 ),
														  inner,local):independent;	
																 
	  ds_corpRa         :=dedup(sort(distribute(ds_corpAgents ,hash(Corp_PitemID)),record,local),record,local):independent;		
		
		//mapping agent fields											
		corp2_mapping.LayoutsCommon.Main corpLegal_RA_Addr(corp2_raw_nc.Layouts.Temp_SlimCorp_ra l ):=	transform

			self.corp_key										  	:=state_fips +'-'+ corp2.t2u(l.Corp_PitemID);
			self.corp_orig_sos_charter_nbr	  	:=corp2.t2u(l.CorpNum);
			self.corp_ra_address_Line1					:=map(corp2.t2u(l.r_addr1+l.r_addr2+l.r_addr3+l.r_city+l.r_state+l.r_zip)<>''=>corp2_mapping.fCleanAddress(state_origin,state_desc,l.r_Addr1+ ' ' +l.r_Addr2,l.r_Addr3,l.r_city,l.r_State,l.r_Zip).AddressLine1,
																								corp2.t2u(l.rm_addr1+l.rm_addr2+l.rm_addr3+l.rm_city+l.rm_state+l.rm_zip)<>''=>corp2_mapping.fCleanAddress(state_origin,state_desc,l.rm_Addr1+ ' ' +l.rm_Addr2,l.rm_Addr3,l.rm_city,l.rm_State,l.rm_Zip).AddressLine1,
																							 '');
			self.corp_ra_address_Line2					:=map(corp2.t2u(l.r_addr1+l.r_addr2+l.r_addr3+l.r_city+l.r_state+l.r_zip)<>''=>corp2_mapping.fCleanAddress(state_origin,state_desc,l.r_Addr1+ ' ' +l.r_Addr2,l.r_Addr3,l.r_city,l.r_State,l.r_Zip).AddressLine2,
																								corp2.t2u(l.rm_addr1+l.rm_addr2+l.rm_addr3+l.rm_city+l.rm_state+l.rm_zip)<>''=>corp2_mapping.fCleanAddress(state_origin,state_desc,l.rm_Addr1+ ' ' +l.rm_Addr2,l.rm_Addr3,l.rm_city,l.rm_State,l.rm_Zip).AddressLine2,
																								'');
			self.corp_ra_address_Line3					:=map(corp2.t2u(l.r_addr1+l.r_addr2+l.r_addr3+l.r_city+l.r_state+l.r_zip)<>''=>corp2_mapping.fCleanAddress(state_origin,state_desc,l.r_Addr1+ ' ' +l.r_Addr2,l.r_Addr3,l.r_city,l.r_State,l.r_Zip).AddressLine3,
																								corp2.t2u(l.rm_addr1+l.rm_addr2+l.rm_addr3+l.rm_city+l.rm_state+l.rm_zip)<>''=>corp2_mapping.fCleanAddress(state_origin,state_desc,l.rm_Addr1+ ' ' +l.rm_Addr2,l.rm_Addr3,l.rm_city,l.rm_State,l.rm_Zip).AddressLine3,
																								'');
			self.ra_prep_addr_line1							:=map(corp2.t2u(l.r_addr1+l.r_addr2+l.r_addr3+l.r_city+l.r_state+l.r_zip)<>''=>corp2_mapping.fCleanAddress(state_origin,state_desc,l.r_Addr1+ ' ' +l.r_Addr2,l.r_Addr3,l.r_city,l.r_State,l.r_Zip).prepaddrline1,
																								corp2.t2u(l.rm_addr1+l.rm_addr2+l.rm_addr3+l.rm_city+l.rm_state+l.rm_zip)<>''=>corp2_mapping.fCleanAddress(state_origin,state_desc,l.rm_Addr1+ ' ' +l.rm_Addr2,l.rm_Addr3,l.rm_city,l.rm_State,l.rm_Zip).prepaddrline1,
																								'');
			self.ra_prep_addr_last_line					:=map(corp2.t2u(l.r_addr1+l.r_addr2+l.r_addr3+l.r_city+l.r_state+l.r_zip)<>''=>corp2_mapping.fCleanAddress(state_origin,state_desc,l.r_Addr1+ ' ' +l.r_Addr2,l.r_Addr3,l.r_city,l.r_State,l.r_Zip).prepaddrlastline,
																								corp2.t2u(l.rm_addr1+l.rm_addr2+l.rm_addr3+l.rm_city+l.rm_state+l.rm_zip)<>''=>corp2_mapping.fCleanAddress(state_origin,state_desc,l.rm_Addr1+ ' ' +l.rm_Addr2,l.rm_Addr3,l.rm_city,l.rm_State,l.rm_Zip).prepaddrlastline,
																								'');
			self.corp_ra_address_type_cd      	:=map(corp2.t2u(l.r_addr1+l.r_addr2+l.r_addr3+l.r_city+l.r_state+l.r_zip)<>'' and corp2_mapping.fAddressExists(state_origin,state_desc,l.r_Addr1+ ' ' +l.r_Addr2,l.r_Addr3,l.r_city,l.r_State,l.r_Zip).ifAddressExists =>'R',
																								corp2.t2u(l.rm_addr1+l.rm_addr2+l.rm_addr3+l.rm_city+l.rm_state+l.rm_zip)<>'' and corp2_mapping.fAddressExists(state_origin,state_desc,l.rm_Addr1+ ' ' +l.rm_Addr2,l.rm_Addr3,l.rm_city,l.rm_State,l.rm_Zip).ifAddressExists =>'RM',
																								'');																							
			self.corp_ra_address_type_desc    	:=map(corp2.t2u(l.r_addr1+l.r_addr2+l.r_addr3+l.r_city+l.r_state+l.r_zip)<>'' and corp2_mapping.fAddressExists(state_origin,state_desc,l.r_Addr1+ ' ' +l.r_Addr2,l.r_Addr3,l.r_city,l.r_State,l.r_Zip).ifAddressExists =>'REGISTERED OFFICE',
																								corp2.t2u(l.rm_addr1+l.rm_addr2+l.rm_addr3+l.rm_city+l.rm_state+l.rm_zip)<>'' and corp2_mapping.fAddressExists(state_origin,state_desc,l.rm_Addr1+ ' ' +l.rm_Addr2,l.rm_Addr3,l.rm_city,l.rm_State,l.rm_Zip).ifAddressExists =>'REGISTERED MAILING',
																								'');																				 
			self.Corp_ra_full_name            	:=corp2_mapping.fCleanBusinessName(state_origin ,state_desc,corp2.t2u(l.ra_name)).BusinessName;
			self.corp_agent_county            	:=corp2.t2u(l.R_countyname);
			self.corp_ra_title_desc	          	:=if(corp2.t2u(l.AtypeID)in ['10','13']	,
																							 map(corp2.t2u(l.NtypeID)='25' =>'COMMISSION',
																									 corp2.t2u(l.NtypeID)='26' =>'PREV COMMISSION',
																									 corp2.t2u(l.NtypeID)='36' =>'PERSONAL CONTACT',
																									 corp2.t2u(l.NtypeID)='40' =>'PREVIOUS PERSONAL CONTACT',
																									 ''),
																							'');
			self.recordorigin									  :='C';	
			self                      					:=[];

		end; 	

		DsCorpAddrRA		:=project(ds_corpRa ,corpLegal_RA_Addr(LEFT)); 
		MapCorpAddrRA 	:=dedup(sort(distribute(DsCorpAddrRA ,hash(corp_key)),record,local),record,local);
    
		corp2_mapping.LayoutsCommon.Main MergeCorpLegal_withRA(corp2_mapping.LayoutsCommon.Main l , corp2_mapping.LayoutsCommon.Main  r ) :=transform

			self.Corp_ra_full_name            :=l.Corp_ra_full_name ;
			self.corp_ra_address_Line1				:=l.corp_ra_address_Line1;
			self.corp_ra_address_Line2				:=l.corp_ra_address_Line2;
			self.corp_ra_address_Line3				:=l.corp_ra_address_Line3;
			self.ra_prep_addr_line1						:=l.ra_prep_addr_line1;
			self.ra_prep_addr_last_line				:=l.ra_prep_addr_last_line;
			self.corp_ra_address_type_cd      :=l.corp_ra_address_type_cd;																							
			self.corp_ra_address_type_desc    :=l.corp_ra_address_type_desc;
			self.corp_agent_county						:=l.corp_agent_county;
			self.corp_ra_title_desc						:=l.corp_ra_title_desc;
			self 															:=r;

		end; 

		joinCorpLegal_withRA :=join(MapCorpAddrRA,dsCorpAddr_dedup,
																corp2.t2u(left.corp_key) = corp2.t2u(right.corp_key), 
																MergeCorpLegal_withRA(left,right),
																right outer,local):independent;
													
		//Name Reservation is not a complete unload each time!
		joinCorp_NameRes :=join(ds_corporations,ds_namereservations	,
														corp2.t2u(left.Corp_EntityID) = corp2.t2u(right.EntityID),
														transform(corp2_raw_nc.Layouts.Temp_Corp_NameRes,
																			self 	:=left;
																			self	:=right;
																		 ),
														inner,local):independent;

		joinCorpNameRes_Name:=join(joinCorp_NameRes,Clean_Names ,
															 corp2.t2u(left.Corp_EntityID) = corp2.t2u(right.Name_EntityID),
															 transform(corp2_raw_nc.Layouts.Temp_CorpNameRes_Name,
																				 self :=left;
																				 self	:=right;
																				),
															 left outer,local):independent;

		corp2_mapping.LayoutsCommon.Main corpTrans_ReserverdNames(corp2_raw_nc.Layouts.Temp_CorpNameRes_Name l):=transform,
		skip(corp2_mapping.fCleanBusinessName(state_origin,state_desc,L.Ename).BusinessName='')

			self.dt_vendor_first_reported		 						:=(integer)fileDate;
			self.dt_vendor_last_reported		 						:=(integer)fileDate;
			self.dt_first_seen							 						:=(integer)fileDate;
			self.dt_last_seen								 						:=(integer)fileDate;
			self.corp_ra_dt_first_seen			 						:=(integer)fileDate;
			self.corp_ra_dt_last_seen				 						:=(integer)fileDate;					
			self.corp_process_date					 					  :=fileDate;
			self.corp_key										  					:=state_fips +'-'+ corp2.t2u(l.Corp_PitemID);
			self.corp_vendor								 					  :=state_fips ;
			self.corp_state_origin 					  					:=state_origin  ;
			self.corp_orig_sos_charter_nbr	  					:=corp2.t2u(l.CorpNum);
			self.corp_legal_name						  					:=corp2_mapping.fCleanBusinessName(state_origin ,state_desc,l.Ename).BusinessName;					 
			self.corp_ln_name_type_cd             			:='07';
			self.corp_ln_name_type_desc           			:='RESERVED';
			self.corp_term_exist_exp          					:=corp2_mapping.fValidateDate(l.ExpirationDate, 'CCYY-MM-DD').GeneralDate; 
			self.corp_term_exist_cd          						:=if(self.corp_term_exist_exp<>'','D','');
			self.corp_term_exist_desc         					:=if(self.corp_term_exist_exp<>'','EXPIRATION DATE','');
			self.corp_inc_state               					:=state_origin ;										  
			self.corp_forgn_state_cd          					:=if(corp2.t2u(l.NameRes_StateOfInc)not in [state_origin,''] ,corp2_raw_nc.Functions.Get_State_Code(l.NameRes_StateOfInc),''); 
			self.corp_forgn_state_desc       						:=if(corp2.t2u(l.NameRes_StateOfInc)not in [state_origin,''] ,corp2_raw_nc.Functions.fGetStateDesc(l.NameRes_StateOfInc),'');
			self.corp_name_reservation_date             :=corp2_mapping.fValidateDate(l.FilingDate, 'CCYY-MM-DD').pastDate; 
			self.corp_name_reservation_expiration_date  :=corp2_mapping.fValidateDate(l.ExpirationDate, 'CCYY-MM-DD').GeneralDate; 
			self.corp_inc_date                          :=if(corp2.t2u(l.Citzenship)='D',corp2_mapping.fValidateDate(l.DateFormed, 'CCYY-MM-DD').GeneralDate,'');
			self.corp_forgn_date                        :=if(corp2.t2u(l.Citzenship)in ['F','N'],corp2_mapping.fValidateDate(l.DateFormed, 'CCYY-MM-DD').GeneralDate,'');
			self.recordorigin									  				:='C';	
			self                                        :=[];

		end; 

		MapNameRes   		  :=project(joinCorpNameRes_Name,corpTrans_ReserverdNames(left)):independent;
		
		dsCorpPitemID     :=distribute(ds_corporations,hash(Corp_PitemID)):independent; // distributing on Corp_PitemID will be used for joining stock rec's!
		joinCorpOfficers  :=join(dsCorpPitemID, ds_CorpOfficers ,
														 trim(left.Corp_PitemID,left,right) = trim(right.Offi_PitemID,left,right),
														 transform(corp2_raw_nc.Layouts.Temp_Corp_Officers,
																			 self :=left;
																			 self	:=right;
																			 ),
														 inner,local):independent;
											 
		DSjoinCorpOfficers := distribute(joinCorpOfficers,hash(Corp_EntityID));

		//Per CI- Names file will have people names & contact names which are companies in single filed -Ename!!
		joinCorpOfficers_name := join(DSjoinCorpOfficers,Clean_Names ,
																	trim(left.Corp_EntityID,left,right) = trim(right.Name_EntityID,left,right),
																	transform(corp2_raw_nc.Layouts.Temp_Corp_Officers_Name,
																						self 	:=left;
																						self	:=right;
																						),
																	inner,local):independent;
													 
		corp2_mapping.LayoutsCommon.main nc_contactTransform(corp2_raw_nc.Layouts.Temp_Corp_Officers_Name l):=transform,
		skip(corp2_mapping.fCleanBusinessName(state_origin ,state_desc,l.Ename).BusinessName='' or trim(l.Corp_PitemID)='')

			self.dt_vendor_first_reported		 	:=(integer)fileDate;
			self.dt_vendor_last_reported		 	:=(integer)fileDate;
			self.dt_first_seen							 	:=(integer)fileDate;
			self.dt_last_seen								 	:=(integer)fileDate;
			self.corp_ra_dt_first_seen			 	:=(integer)fileDate;
			self.corp_ra_dt_last_seen				 	:=(integer)fileDate;					
			self.corp_process_date					  :=fileDate;
			self.corp_key					      	 		:=state_fips + '-' +corp2.t2u(l.Corp_PitemID);  
			self.corp_vendor				    	 		:=state_fips ;
			self.corp_state_origin 				 		:=state_origin;								
			self.corp_inc_state               :=state_origin ;
			self.corp_orig_sos_charter_nbr 		:=corp2.t2u(l.CorpNum);
			self.Cont_full_name            		:=corp2_mapping.fCleanBusinessName(state_origin ,state_desc,L.Ename).BusinessName;
			self.cont_title1_desc          		:=corp2.t2u(l.Offi_Tittle);
			self.cont_type_cd          				:=if(corp2.t2u(l.EntityTypeID) in ['1','2'],corp2.t2u(l.EntityTypeID),'');
			self.cont_type_desc          			:=map(corp2.t2u(l.EntityTypeID)='1'=>'PERSONAL',
																							corp2.t2u(l.EntityTypeID)='2'=>'COMMERCIAL',
																						  '' );
			self.cont_address_type_cd					:=if(corp2_mapping.fAddressExists(state_origin,state_desc,l.Addr1+ ' ' +l.Addr2,l.Addr3,l.city,l.State,l.Zip).ifAddressExists,'T','');				
			self.cont_address_type_desc				:=if(corp2_mapping.fAddressExists(state_origin,state_desc,l.Addr1+ ' ' +l.Addr2,l.Addr3,l.city,l.State,l.Zip).ifAddressExists,'CONTACT','');
			self.cont_address_line1 					:=corp2_mapping.fCleanAddress(state_origin,state_desc,l.Addr1+ ' ' +l.Addr2,l.Addr3,l.city,l.State,l.Zip).AddressLine1;
			self.cont_address_line2 					:=corp2_mapping.fCleanAddress(state_origin,state_desc,l.Addr1+ ' ' +l.Addr2,l.Addr3,l.city,l.State,l.Zip).AddressLine2;
			self.cont_address_line3 					:=corp2_mapping.fCleanAddress(state_origin,state_desc,l.Addr1+ ' ' +l.Addr2,l.Addr3,l.city,l.State,l.Zip).AddressLine3;
			self.cont_prep_addr_line1					:=corp2_mapping.fCleanAddress(state_origin,state_desc,l.Addr1+ ' ' +l.Addr2,l.Addr3,l.city,l.State,l.Zip).PrepAddrLine1;
			self.cont_prep_addr_last_line			:=corp2_mapping.fCleanAddress(state_origin,state_desc,l.Addr1+ ' ' +l.Addr2,l.Addr3,l.city,l.State,l.Zip).PrepAddrLastLine;
			self.cont_addl_info								:=if(corp2.t2u(l.Directors)='1','DIRECTORS: YES','');
			self.recordorigin									:='T';	
			self                           		:=[];
				
		end;

		MapCont  	:= project(joinCorpOfficers_name,nc_contactTransform(left));		
		dsMapCont := dedup(sort(distribute(MapCont,hash(corp_key)),record,local),record,local) :independent;
		   
		joinConts :=join(dsMapCont,joinCorpLegal_withRA,
										 trim(left.corp_key,left,right)=trim(right.corp_key,left,right) ,
										 transform(corp2_mapping.LayoutsCommon.Main,
															 self.corp_legal_name 		:=right.corp_legal_name;
															 self                    :=left;
															),
										 left outer,local):independent;
															
		AllCorps :=dedup(sort(distribute(joinCorpLegal_withRA	 + 
																		 joinConts    +
																		 MapNameRes, hash(corp_key)),
													record,local),record,local) :independent;

		joinStockFileCorp := join(dsCorpPitemID ,ds_stock, 
															corp2.t2u(left.Corp_PitemID)= corp2.t2u(right.Stock_PitemID),
															transform(corp2_raw_nc.Layouts.Temp_Corp_StockFile,
																				self :=left;
																				self :=right;
																				),
															left outer,local):independent;

		corp2_mapping.LayoutsCommon.Stock nc_stockTransform(corp2_raw_nc.Layouts.Temp_Corp_StockFile input):=transform,
		skip(corp2.t2u(input.Corp_PitemID) ='')

				self.corp_process_date					  :=fileDate;
				self.corp_key										  :=state_fips +'-'+ corp2.t2u(input.Corp_PitemID);
				self.corp_vendor								  :=state_fips ;
				self.corp_state_origin 					  :=state_origin  ;
				self.corp_sos_charter_nbr	 				:=corp2.t2u(input.CorpNum);
				self.stock_class				      		:=corp2.t2u(input.Class);
				//overloaded
				self.stock_shares_issued			  	:=if((string)(integer)input.Shares='0','',(string)(integer)input.Shares);
				self.stock_par_value              :=if((string)(integer)input.ParValue='0','',(string)(integer)input.ParValue);
				self.stock_authorized_nbr					:=if((string)(integer)input.Shares='0','',(string)(integer)input.Shares);
				self.stock_nbr_par_shares					:=map((string)(integer)input.NoParValue ='1' =>'0',
																								(string)(integer)input.NoParValue ='0' =>'',
																								'');
				self.stock_addl_info              :=map(corp2_mapping.fValidateDate(input.Created, 'CCYY-MM-DD').pastDate <>''=>'CREATED DATE: '+input.Created[6..7] +'/'+input.Created[9..10]+'/'+input.Created[1..4] ,''); 
				self                              :=[];

		end; 

		dsStock  			:= project(joinStockFileCorp, nc_stockTransform(left))(corp2.t2u(stock_class + stock_shares_issued + stock_par_value + stock_authorized_nbr + stock_nbr_par_shares + stock_addl_info)<>'');
		MapStock  		:= dedup(sort(distribute(dsStock ,hash(corp_key)),record,local),record,local) :independent;

		joinFilingCorp:= join( dsCorpPitemID,ds_filings,
													 trim(left.Corp_PitemID,left,right)=trim(right.Filings_PitemID,left,right),
													 transform(corp2_raw_nc.Layouts.Temp_Corp_Filings,
																		 self :=left;
																		 self	:=right;
																		),
													 left outer,local):independent;
										 
		corp2_mapping.LayoutsCommon.AR  nc_arTransform(corp2_raw_nc.Layouts.Temp_Corp_Filings input):=transform,
		skip(corp2.t2u(input.DocumentType)not in AR_Type_List or corp2.t2u(input.Corp_PitemID)='' )
																																									
			self.corp_process_date		:=fileDate;
			self.corp_key							:=state_fips +'-'+ corp2.t2u(input.Corp_PitemID);
			self.corp_vendor					:=state_fips ;
			self.corp_state_origin 		:=state_origin ;
			self.corp_sos_charter_nbr	:=corp2.t2u(input.CorpNum);
			self.ar_due_dt            :=corp2_mapping.fValidateDate(input.AnnualRptDueDate, 'CCYY-MM-DD').GeneralDate;
			self.ar_report_nbr        :=corp2.t2u(input.DocumentID);
			self.ar_type							:=corp2_raw_nc.functions.fGetARTypeDesc(input.DocumentType);																									
			self.ar_filed_dt          :=corp2_mapping.fValidateDate(input.FilingDate, 'CCYY-MM-DD').pastDate;
			self.ar_comment           :=if(corp2_mapping.fValidateDate(input.EffectiveDate, 'CCYY-MM-DD').GeneralDate <>'',
																		 'ANNUAL REPORT EFFECTIVE DATE: ' +input.EffectiveDate[6..7] +'/'+input.EffectiveDate[9..10]+'/'+input.EffectiveDate[1..4],'');			// mm/dd/yyyy	 per CI 																
			self                      :=[];

		end;
												
		MapFilings    				 :=project(joinFilingCorp, nc_arTransform(left))(corp2.t2u(ar_due_dt+ar_report_nbr+ar_type+ar_filed_dt+ar_comment)<>'');

		joinPendingFilingsCorp :=join(dsCorpPitemID,ds_PendingFilings,
																	trim(left.Corp_PitemID,left,right)=trim(right.Filings_PitemID,left,right),
																	transform(corp2_raw_nc.Layouts.Temp_Corp_PendingFilings,
																						self 	:=left;
																						self	:=right;
																						),
																	left outer,local):independent;
														 
		corp2_mapping.LayoutsCommon.AR  nc_AR_PendingFilingsTrans(corp2_raw_nc.Layouts.Temp_Corp_PendingFilings input):=transform,
		skip(corp2.t2u(input.DocumentType)not in AR_Type_List or corp2.t2u(input.Corp_PitemID)='' )
																																								
			self.corp_process_date		:=fileDate;
			self.corp_key							:=state_fips +'-'+ corp2.t2u(input.Corp_PitemID);
			self.corp_vendor					:=state_fips ;
			self.corp_state_origin 		:=state_origin ;
			self.corp_sos_charter_nbr	:=corp2.t2u(input.CorpNum);
			self.ar_due_dt            :=corp2_mapping.fValidateDate(input.AnnualRptDueDate, 'CCYY-MM-DD').GeneralDate;
			self.ar_report_nbr        :=corp2.t2u(input.DocumentID);
			self.ar_type							:=corp2_raw_nc.functions.fGetARTypeDesc(input.DocumentType);																							
			self.ar_filed_dt          :=corp2_mapping.fValidateDate(input.FilingDate, 'CCYY-MM-DD').pastDate;
			self.ar_comment           :=if(corp2_mapping.fValidateDate(input.EffectiveDate, 'CCYY-MM-DD').GeneralDate <>'',
																		 'ANNUAL REPORT EFFECTIVE DATE: ' +input.EffectiveDate[6..7] +'/'+input.EffectiveDate[9..10]+'/'+input.EffectiveDate[1..4],'');	
			self                      :=[];

		end;

		MapPendingFilings   := project(joinPendingFilingsCorp, nc_AR_PendingFilingsTrans(left))(corp2.t2u(ar_due_dt+ar_report_nbr+ar_type+ar_filed_dt+ar_comment)<>'');
		MapAR   						:= dedup(sort(distribute(MapFilings + 
																								 MapPendingFilings ,hash(corp_key)),
																			record,local),record,local):independent ; 

		corp2_mapping.LayoutsCommon.Events nc_event1Transform(corp2_raw_nc.Layouts.Temp_Corp_NameRes input):=transform,
		skip(corp2.t2u(input.DocmentType) in AR_Type_List or corp2.t2u(input.Corp_PitemID)='' )
																					 
			self.corp_key					      		:=state_fips +'-'+ corp2.t2u(input.Corp_PitemID);  
			self.corp_vendor				    		:=state_fips ;
			self.corp_state_origin 					:=state_origin;
			self.corp_process_date					:=fileDate;
			self.corp_sos_charter_nbr				:=corp2.t2u(input.CorpNum);	
			self.event_filing_cd						:=corp2.t2u(input.DocmentType);
			self.event_filing_desc					:=corp2_raw_nc.functions.fGetEventDesc(input.DocmentType); 
			self.event_filing_date					:=corp2_mapping.fValidateDate(input.FilingDate, 'CCYY-MM-DD').pastDate;
			self                         		:=[];

		end;

		MapEvent1	:=project(joinCorp_NameRes, nc_event1Transform(left)) (corp2.t2u(event_filing_cd + event_filing_date)<>'');

		corp2_mapping.LayoutsCommon.Events nc_event2Transform(corp2_raw_nc.Layouts.Temp_Corp_Filings input,integer ctr):=transform,
		skip(corp2.t2u(input.DocumentType) in AR_Type_List or corp2.t2u(input.Corp_PitemID )='' )
																			 
			self.corp_key					      		:=state_fips +'-'+ corp2.t2u(input.Corp_PitemID);  
			self.corp_vendor				    		:=state_fips ;
			self.corp_state_origin 					:=state_origin;
			self.corp_process_date					:=fileDate;
			self.corp_sos_charter_nbr				:=corp2.t2u(input.CorpNum);
			self.event_filing_reference_nbr :=corp2.t2u(input.DocumentID);
			CleanFilingDate                 :=corp2_mapping.fValidateDate(input.FilingDate, 'CCYY-MM-DD').pastDate;
			cleanEffDate 								    :=corp2_mapping.fValidateDate(input.EffectiveDate, 'CCYY-MM-DD').GeneralDate;
			self.event_filing_date         	:=choose(ctr,CleanFilingDate,cleanEffDate);
			self.event_date_type_cd         :=choose(ctr,if(trim(self.event_filing_date)<>'','FIL',''),if(trim(self.event_filing_date)<>'','EFF',''));					
			self.event_date_type_desc       :=choose(ctr,if(trim(self.event_filing_date)<>'','FILING',''),if(trim(self.event_filing_date)<>'','EFFECTIVE',''));
			self.event_filing_cd        		:=corp2.t2u(input.DocumentType);
			self.event_filing_desc        	:=corp2_raw_nc.functions.fGetEventDesc(input.DocumentType); 
			self                         		:=[];

		end;

		MapEvent2 	:=normalize(joinFilingCorp, if(trim(left.EffectiveDate)<>'' ,2,1), nc_event2Transform(left, counter)) (corp2.t2u(event_filing_reference_nbr + event_filing_date + event_filing_cd)<>'');

		corp2_mapping.LayoutsCommon.Events nc_event3Transform(corp2_raw_nc.Layouts.Temp_Corp_PendingFilings input,integer ctr):=transform,
		skip(corp2.t2u(input.DocumentType) in AR_Type_List or corp2.t2u(input.Corp_PitemID )='' )
																			 
			self.corp_key					      		:=state_fips +'-'+ corp2.t2u(input.Corp_PitemID);  
			self.corp_vendor				    		:=state_fips ;
			self.corp_state_origin 					:=state_origin;
			self.corp_process_date					:=fileDate;
			self.corp_sos_charter_nbr				:=corp2.t2u(input.CorpNum);
			self.event_filing_reference_nbr :=corp2.t2u(input.DocumentID);
			CleanFilingDate                 :=corp2_mapping.fValidateDate(input.FilingDate, 'CCYY-MM-DD').pastDate;
			cleanEffDate 								    :=corp2_mapping.fValidateDate(input.EffectiveDate, 'CCYY-MM-DD').GeneralDate;
			self.event_filing_date         	:=choose(ctr,CleanFilingDate,cleanEffDate);
			self.event_date_type_cd         :=choose(ctr,if(trim(self.event_filing_date)<>'','FIL',''),if(trim(self.event_filing_date)<>'','EFF',''));					
			self.event_date_type_desc       :=choose(ctr,if(trim(self.event_filing_date)<>'','FILING',''),if(trim(self.event_filing_date)<>'','EFFECTIVE',''));
			self.event_filing_cd        		:=corp2.t2u(input.DocumentType);
			self.event_filing_desc        	:=corp2_raw_nc.functions.fGetEventDesc(input.DocumentType); 
			self                         		:=[];

		end;

		MapEvent3 := normalize(joinPendingFilingsCorp, if(trim(left.EffectiveDate)<>'' ,2,1), nc_event3Transform(left, counter)) (corp2.t2u(event_filing_reference_nbr + event_filing_date + event_filing_cd)<>'');
		AllEvent  := dedup(sort(distribute( MapEvent1 + 
																				MapEvent2 +
																				MapEvent3 ,hash(corp_key)),
														record,local),record,local) :independent;
					
		//--------------------------------------------------------------------	
		//Scrubs for MAIN
		//--------------------------------------------------------------------
		Main_F 										:=AllCorps;
		Main_S 										:=Scrubs_corp2_mapping_NC_Main.Scrubs; 				     // Scrubs module
		Main_N 										:=Main_S.FromNone(Main_F); 											  // Generate the error flags
		Main_T 										:=Main_S.FromBits(Main_N.BitmapInfile);     		 // Use the FromBits module; makes my bitmap datafile easier to get to
		Main_U 										:=Main_S.FromExpanded(Main_N.ExpandedInFile); 	// Pass the expanded error flags into the Expanded module

		//Outputs reports
		Main_ErrorSummary					:=output(Main_U.SummaryStats, named('Main_ErrorSummary_NC_' +filedate));
		Main_ScrubErrorReport 		:=output(choosen(Main_U.AllErrors, 1000), named('Main_ScrubErrorReport_NC_' +filedate));
		Main_SomeErrorValues			:=output(choosen(Main_U.BadValues, 1000), named('Main_SomeErrorValues_NC_' +filedate));
		Main_IsScrubErrors		 		:=if(count(Main_U.AllErrors)<> 0,true,false);

		// Orbit Stats
		Main_OrbitStats						:= Main_U.OrbitStats();
		//Creates Profile's alert template for Orbit - Can be copied & imported into Orbit; Only required first time & if scrub rules change
		Main_AlertsCSVTemplate	  := Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_'+ state_origin+'_Main','ScrubsAlerts', Main_OrbitStats, version,'Corp2_'+ state_origin+'_Main').ProfileAlertsTemplate;
		//Submits Profile's stats to Orbit
		Main_SubmitStats 					:= Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_'+ state_origin+'_Main' ,'ScrubsAlerts', Main_OrbitStats, version,'Corp2_'+ state_origin+'_Main').SubmitStats;
					
		//Outputs files
		Main_CreateBitMaps				:=output(Main_N.BitmapInfile,,'~thor_data::corp_NC_main_scrubs_bits',overwrite,compressed);	//long term storage
		Main_TranslateBitMap			:=output(Main_T);
		Main_ScrubsWithExamples		:=Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_'+ state_origin+'_Main','ScrubsAlerts', Main_OrbitStats, version,'Corp2_'+ state_origin+'_Main').CompareToProfile_with_Examples;

		Main_ScrubsAlert					:=Main_ScrubsWithExamples(RejectWarning = 'Y');
		Main_ScrubsAttachment			:=Scrubs.fn_email_attachment(Main_ScrubsAlert);
		Main_SendEmailFile				:=FileServices.SendEmailAttachData( corp2.Email_Notification_Lists.spray
																																 ,'Scrubs CorpMain_NC Report'  //subject
																																 ,'Scrubs CorpMain_NC Report' //body
																																 ,(data)Main_ScrubsAttachment
																																 ,'text/csv'
																																 ,'CorpNCMainScrubsReport.csv'
																																 ,
																																 ,
																																 ,corp2.Email_Notification_Lists.spray
																														   );
																												 
		EXPORT Main_BadRecords		:=Main_N.ExpandedInFile(dt_vendor_last_reported_Invalid 			<> 0 or
																											dt_first_seen_Invalid 								<> 0 or
																											dt_last_seen_Invalid 									<> 0 or
																											corp_ra_dt_first_seen_Invalid 				<> 0 or
																											corp_ra_dt_last_seen_Invalid 					<> 0 or
																											corp_key_Invalid 											<> 0 or
																											corp_vendor_Invalid 									<> 0 or
																											corp_state_origin_Invalid 						<> 0 or
																											corp_process_date_Invalid 						<> 0 or
																											corp_orig_sos_charter_nbr_Invalid 		<> 0 or
																											corp_legal_name_Invalid 							<> 0 or
																											corp_ln_name_type_cd_Invalid 					<> 0 or
																											corp_filing_date_Invalid 							<> 0 or
																											corp_status_cd_Invalid 								<> 0 or
																											corp_inc_state_Invalid 								<> 0 or
																											corp_inc_date_Invalid 								<> 0 or
																											corp_fed_tax_id_Invalid 							<> 0 or
																											corp_term_exist_cd_Invalid 						<> 0 or
																											corp_foreign_domestic_ind_Invalid 		<> 0 or
																											corp_forgn_state_cd_Invalid 					<> 0 or
																											corp_forgn_state_desc_Invalid 				<> 0 or
																											corp_forgn_date_Invalid 							<> 0 or
																											corp_orig_org_structure_cd_Invalid 		<> 0 or
																											corp_for_profit_ind_Invalid 					<> 0 or
																											corp_agent_assign_date_Invalid 				<> 0 or
																											recordorigin_Invalid 									<> 0 																										
																								 );		
																					
		EXPORT Main_GoodRecords		:=Main_N.ExpandedInFile(dt_vendor_last_reported_Invalid 			= 0 and
																											dt_first_seen_Invalid 								= 0 and
																											dt_last_seen_Invalid 									= 0 and
																											corp_ra_dt_first_seen_Invalid 				= 0 and
																											corp_ra_dt_last_seen_Invalid 					= 0 and
																											corp_key_Invalid 											= 0 and
																											corp_vendor_Invalid 									= 0 and
																											corp_state_origin_Invalid 						= 0 and
																											corp_process_date_Invalid 						= 0 and
																											corp_orig_sos_charter_nbr_Invalid 		= 0 and
																											corp_legal_name_Invalid 							= 0 and
																											corp_ln_name_type_cd_Invalid 					= 0 and
																											corp_filing_date_Invalid 							= 0 and
																											corp_status_cd_Invalid 								= 0 and
																											corp_inc_state_Invalid 								= 0 and
																											corp_inc_date_Invalid 								= 0 and
																											corp_fed_tax_id_Invalid 							= 0 and
																											corp_term_exist_cd_Invalid 						= 0 and
																											corp_foreign_domestic_ind_Invalid 		= 0 and
																											corp_forgn_state_cd_Invalid 					= 0 and
																											corp_forgn_state_cd_Invalid 					= 0 and
																											corp_forgn_date_Invalid 							= 0 and
																											corp_orig_org_structure_cd_Invalid 		= 0 and
																											corp_for_profit_ind_Invalid 					= 0 and
																											corp_agent_assign_date_Invalid 				= 0 and
																											recordorigin_Invalid 									= 0 
																								);		

		Main_ApprovedRecords 	:=project(Main_GoodRecords,transform(corp2_mapping.LayoutsCommon.Main,self :=left));

		EXPORT Main_FailBuild	:=map(corp2_mapping.fCalcPercent(count(Main_N.ExpandedInFile(corp_key_invalid<>0)),count(Main_N.ExpandedInFile),false) 										> Scrubs_corp2_mapping_NC_Main.Threshold_Percent.CORP_KEY										 => true,
																corp2_mapping.fCalcPercent(count(Main_N.ExpandedInFile(corp_orig_sos_charter_nbr_invalid<>0)),count(Main_N.ExpandedInFile),false) 	> Scrubs_corp2_mapping_NC_Main.Threshold_Percent.CORP_ORIG_SOS_CHARTER_NBR 	 => true,
																corp2_mapping.fCalcPercent(count(Main_N.ExpandedInFile(corp_legal_name_invalid<>0)),count(Main_N.ExpandedInFile),false) 						> Scrubs_corp2_mapping_NC_Main.Threshold_Percent.CORP_LEGAL_NAME 						 => true,
																count(Main_GoodRecords) = 0																																																																																											 => true,																		
																false
																 );
																	
		Main_RejFile_Exists		:=if(FileServices.FileExists(corp2_mapping._dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::main_' + state_origin),true,false);			
		Main_ALL		 					:=sequential(if(count(Main_BadRecords) <> 0
																		,IF (poverwrite
																				,OUTPUT(Main_BadRecords,,corp2_mapping._Dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::main_NC',overwrite,__compressed__,named('Sample_Rejected_MainRecs_NC_'+filedate))
																				,sequential (if(Main_RejFile_Exists,fileservices.deletelogicalfile(corp2_mapping._dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::main_'+ state_origin)),
																										 OUTPUT(Main_BadRecords,,corp2_mapping._Dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::main_'+ state_origin,__compressed__,named('Sample_Rejected_MainRecs_NC_'+filedate))
																										 )
																				)
																		)
																,output(Main_ScrubsWithExamples, ALL, NAMED('CorpMainNCScrubsReportWithExamples_'+filedate))																		
																//Send Alerts if Scrubs exceeds thresholds
																,if(count(Main_ScrubsAlert) > 0,Main_SendEmailFile, OUTPUT('corp2_mapping.NC - No "MAIN" Corp Scrubs Alerts'))
																,Main_ErrorSummary
																,Main_ScrubErrorReport
																,Main_SomeErrorValues
																//,Main_AlertsCSVTemplate
																,Main_SubmitStats
																	);

		//********************************************************************
		// SCRUB EVENT
		//********************************************************************	
		Event_F :=AllEvent;
		Event_S :=Scrubs_corp2_mapping_NC_Event.Scrubs;						 // Scrubs module
		Event_N :=Event_S.FromNone(Event_F); 											// Generate the error flags
		Event_T :=Event_S.FromBits(Event_N.BitmapInfile);     	 // Use the FromBits module; makes my bitmap datafile easier to get to
		Event_U :=Event_S.FromExpanded(Event_N.ExpandedInFile); // Pass the expanded error flags into the Expanded module

		//Outputs reports
		Event_ErrorSummary				:=output(Event_U.SummaryStats, named('Event_ErrorSummary_NC_'+filedate));
		Event_ScrubErrorReport 		:=output(choosen(Event_U.AllErrors, 1000), named('Event_ScrubErrorReport_NC_'+filedate));
		Event_SomeErrorValues			:=output(choosen(Event_U.BadValues, 1000), named('Event_SomeErrorValues_NC_'+filedate));
		Event_IsScrubErrors		 		:=if(count(Event_U.AllErrors)<> 0,true,false);

		// Orbit Stats
		Event_OrbitStats					:= Event_U.OrbitStats();
			//Creates Profile's alert template for Orbit - Can be copied & imported into Orbit; Only required first time & if scrub rules change
		Event_AlertsCSVTemplate	  := Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_'+ state_origin+'_Event','ScrubsAlerts', Event_OrbitStats, version,'Corp2_'+ state_origin+'_Event').ProfileAlertsTemplate;
		//Submits Profile's stats to Orbit
		Event_SubmitStats 				:= Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_'+ state_origin+'_Event','ScrubsAlerts', Event_OrbitStats, version,'Corp2_'+ state_origin+'_Event').SubmitStats;

		//Outputs files
		Event_CreateBitMaps				:=output(Event_N.BitmapInfile,,'~thor_data::corp_NC_event_scrubs_bits',overwrite,compressed);	//long term storage
		Event_TranslateBitMap			:=output(Event_T);
		Event_ScrubsWithExamples	:=Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_'+ state_origin+'_Event','ScrubsAlerts', Event_OrbitStats, version,'Corp2_'+ state_origin+'_Event').CompareToProfile_with_Examples;

		Event_ScrubsAlert					:=Event_ScrubsWithExamples(RejectWarning = 'Y');
		Event_ScrubsAttachment		:=Scrubs.fn_email_attachment(Event_ScrubsAlert);
		Event_MailFile						:=FileServices.SendEmailAttachData( corp2.Email_Notification_Lists.spray
																																 ,'Scrubs CorpEvent_NC Report'  //Subject
																																 ,'Scrubs CorpEvent_NC Report' //body
																																 ,(data)Event_ScrubsAttachment
																																 ,'text/csv'
																																 ,'CorpNCEventScrubsReport.csv'
																																 ,
																																 ,
																																 ,corp2.Email_Notification_Lists.spray
																																 );

		Event_BadRecords		  :=event_N.ExpandedInFile(corp_key_Invalid							  <> 0 or
																									 corp_vendor_Invalid 						<> 0 or
																									 corp_state_origin_Invalid 		  <> 0 or
																									 corp_process_date_Invalid			<> 0 or
																									 corp_sos_charter_nbr_Invalid 	<> 0 or
																									 corp_state_origin_Invalid 			<> 0 or
																									 event_filing_cd_Invalid 			  <> 0
																									);
																																								
		Event_GoodRecords	  :=event_N.ExpandedInFile(corp_key_Invalid							  			= 0 and
																								 corp_vendor_Invalid 									= 0 and
																								 corp_state_origin_Invalid 					 	= 0 and
																								 corp_process_date_Invalid						= 0 and
																								 corp_sos_charter_nbr_Invalid 				= 0 and
																								 corp_state_origin_Invalid 						= 0 and
																								 event_filing_cd_Invalid 							= 0
																									);
											
		Event_ApprovedRecords			:=project(Event_GoodRecords,transform(corp2_mapping.LayoutsCommon.Events,self :=left));

		Event_RejFile_Exists			:=if(FileServices.FileExists(corp2_mapping._dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::event_' + state_origin),true,false);			
		Event_ALL									:=sequential(if(count(Event_BadRecords)<> 0
																						 ,if(poverwrite
																								,OUTPUT(Event_BadRecords,,corp2_mapping._Dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::event_NC',overwrite,__compressed__,named('Sample_Rejected_Event_Recs_NC_'+filedate))
																								,sequential (if(Event_RejFile_Exists,fileservices.deletelogicalfile(corp2_mapping._dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::event_'+ state_origin)),
																														 OUTPUT(Main_BadRecords,,corp2_mapping._Dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::event_'+ state_origin,__compressed__,named('Sample_Rejected_Event_Recs_NC_'+filedate))
																														)
																								)
																						)
																					 ,output(Event_ScrubsWithExamples, ALL, NAMED('CorpEventNCScrubsReportWithExamples_'+filedate))
																					 //Send Alerts if Scrubs exceeds thresholds
																					 ,if(count(Event_ScrubsAlert) > 0, Event_MailFile, OUTPUT('corp2_mapping.NC - No "EVENT" Corp Scrubs Alerts'))
																					 ,Event_ErrorSummary
																					 ,Event_ScrubErrorReport
																					 ,Event_SomeErrorValues																			 
																				 //,Event_AlertsCSVTemplate
																					,Event_SubmitStats
																				);
		//********************************************************************
		// SCRUB AR 
		//********************************************************************	
		AR_F :=MapAR;
		AR_S :=Scrubs_corp2_mapping_NC_AR.Scrubs;				   // Scrubs module
		AR_N :=AR_S.FromNone(AR_F); 											// Generate the error flags
		AR_T :=AR_S.FromBits(AR_N.BitmapInfile);     		 // Use the FromBits module; makes my bitmap datafile easier to get to
		AR_U :=AR_S.FromExpanded(AR_N.ExpandedInFile); 	// Pass the expanded error flags into the Expanded module

		//outputs reports
		AR_ErrorSummary			 		:=output(AR_U.SummaryStats, named('AR_ErrorSummary_NC_'+filedate));
		AR_ScrubErrorReport 	 	:=output(choosen(AR_U.AllErrors, 1000), named('AR_ScrubErrorReport_NC_'+filedate));
		AR_SomeErrorValues		 	:=output(choosen(AR_U.BadValues, 1000), named('AR_SomeErrorValues_NC_'+filedate));
		AR_IsScrubErrors		 	 	:=if(count(AR_U.AllErrors)<> 0,true,false);

		// Orbit Stats
		AR_OrbitStats				 		:=AR_U.OrbitStats();
	  //Creates Profile's alert template for Orbit - Can be copied & imported into Orbit; Only required first time & if scrub rules change
		AR_AlertsCSVTemplate	  := Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_'+ state_origin+'_AR','ScrubsAlerts', AR_OrbitStats, version,'Corp2_'+ state_origin+'_AR').ProfileAlertsTemplate;
		//Submits Profile's stats to Orbit
		AR_SubmitStats 					:= Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_'+ state_origin+'_AR','ScrubsAlerts', AR_OrbitStats, version,'Corp2_'+ state_origin+'_AR').SubmitStats;

		//outputs files
		AR_CreateBitmaps			 	:=output(AR_N.BitmapInfile,,'~thor_data::corp_nc_ar_scrubs_bits',overwrite,compressed);	//long term storage
		AR_TranslateBitmap		 	:=output(AR_T);

		AR_ScrubsWithExamples 	:=Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_'+ state_origin+'_AR','ScrubsAlerts', AR_OrbitStats, version,'Corp2_'+ state_origin+'_AR').CompareToProfile_with_Examples;
		AR_ScrubsAlert				 	:=AR_ScrubsWithExamples(RejectWarning = 'Y');
		AR_ScrubsAttachment	 		:=Scrubs.fn_email_attachment(AR_ScrubsAlert);
		AR_MailFile					 		:=FileServices.SendEmailAttachData(corp2.Email_Notification_Lists.spray
																															 ,'Scrubs CorpAR_NC Report'  //subject
																															 ,'Scrubs CorpAR_NC Report' //body
																															 ,(data)AR_ScrubsAttachment
																															 ,'text/csv'
																															 ,'CorpNCARScrubsReport.csv'
																															 ,
																															 ,
																															 ,corp2.Email_Notification_Lists.spray
																															);

		AR_Badrecords				 		:=AR_N.ExpandedInFile( corp_key_Invalid							  			<> 0 or
																									 corp_vendor_Invalid 									<> 0 or
																									 corp_state_origin_Invalid 					 	<> 0 or
																									 corp_process_date_Invalid						<> 0 or
																									 corp_sos_charter_nbr_Invalid 				<> 0 or
																									 ar_filed_dt_Invalid 									<> 0 or
																									 ar_type_Invalid 											<> 0
																									);
																																							
		AR_Goodrecords				 :=AR_N.ExpandedInFile(corp_key_Invalid							  			= 0 and
																								 corp_vendor_Invalid 									= 0 and
																								 corp_state_origin_Invalid 					 	= 0 and
																								 corp_process_date_Invalid						= 0 and
																								 corp_sos_charter_nbr_Invalid 				= 0 and
																								 ar_filed_dt_Invalid 									= 0 and
																								 ar_type_Invalid 											= 0
																								);

		AR_Approvedrecords		 :=project(AR_Goodrecords,transform(corp2_mapping.LayoutsCommon.AR,self :=left;));   

		AR_ALL								 :=sequential(if(count(AR_Badrecords) <> 0
																				 ,if (poverwrite
																							,output(AR_Badrecords,,corp2_mapping._Dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::ar_NC',overwrite,__compressed__)
																							,output(AR_Badrecords,,corp2_mapping._Dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::ar_NC',__compressed__)
																						 )
																				 )
																				,output(AR_ScrubsWithExamples, ALL, NAMED('CorpARNCScrubsReportWithExamples'+filedate))
																				//Send Alerts if Scrubs exceeds thresholds
																				,if(count(AR_ScrubsAlert) > 0, AR_MailFile, output('corp2_mapping.NC - No "AR" Corp Scrubs Alerts'))
																				,AR_ErrorSummary
																				,AR_ScrubErrorReport
																				,AR_SomeErrorValues																				 
																			//,AR_AlertsCSVTemplate
																				,AR_SubmitStats
																		);

		//==========================================VERSION CONTROL====================================================
		IsScrubErrors	:= if(Main_IsScrubErrors = true or Event_IsScrubErrors = true or AR_IsScrubErrors=true ,true,false);
		versionControl.macBuildNewLogicalFile(corp2_mapping._dataset().thor_cluster_Files + 'in::corp2::'+version+'::main_'  + state_origin		,Main_ApprovedRecords	,main_out		,,,pOverwrite);		
		versionControl.macBuildNewLogicalFile(corp2_mapping._dataset().thor_cluster_Files + 'in::corp2::'+version+'::event_' + state_origin		,Event_ApprovedRecords,event_out	,,,pOverwrite);
		versionControl.macBuildNewLogicalFile(corp2_mapping._dataset().thor_cluster_Files + 'in::corp2::'+version+'::ar_' 	 + state_origin		,AR_ApprovedRecords	  ,ar_out			,,,pOverwrite);
		versionControl.macBuildNewLogicalFile(corp2_mapping._dataset().thor_cluster_Files + 'in::corp2::'+version+'::stock_' + state_origin		,MapStock						  ,stock_out	,,,pOverwrite);

		VersionControl.macBuildNewLogicalFile(corp2_mapping._dataset().thor_cluster_Files + 'fail::corp2::'+version+'::Main_' 	+ state_origin	,Main_F	  ,write_fail_main  ,,,pOverwrite); 
		VersionControl.macBuildNewLogicalFile(corp2_mapping._dataset().thor_cluster_Files + 'fail::corp2::'+version+'::event_' 	+ state_origin	,Event_F	,write_fail_event ,,,pOverwrite); 
		VersionControl.macBuildNewLogicalFile(corp2_mapping._dataset().thor_cluster_Files + 'fail::corp2::'+version+'::AR_' 		+ state_origin  ,AR_F		  ,write_fail_ar  	,,,pOverwrite); 

		mapNC:=sequential(if(pshouldspray = true,corp2_mapping.fSprayFiles(state_origin ,version,pOverwrite :=pOverwrite))
										  // ,corp2_raw_nc.Build_Bases(filedate,version,pUseProd).All  // Determined building of bases is not needed
											,main_out
											,event_out
											,ar_out	
											,stock_out
											,if(Main_FailBuild <> true or count(Event_GoodRecords) <> 0 OR count(Event_GoodRecords) <> 0	
													,sequential( fileservices.addsuperfile(corp2_mapping._Dataset().thor_cluster_Files + 'in::'+corp2_mapping._Dataset().NameMapped+'::sprayed::ar'			,corp2_mapping._Dataset().thor_cluster_Files + 'in::corp2::'+version+'::ar_NC')
																			,fileservices.addsuperfile(corp2_mapping._Dataset().thor_cluster_Files + 'in::'+corp2_mapping._Dataset().NameMapped+'::sprayed::event'	,corp2_mapping._Dataset().thor_cluster_Files + 'in::corp2::'+version+'::event_NC')
																			,fileservices.addsuperfile(corp2_mapping._Dataset().thor_cluster_Files + 'in::'+corp2_mapping._Dataset().NameMapped+'::sprayed::main'		,corp2_mapping._Dataset().thor_cluster_Files + 'in::corp2::'+version+'::main_NC')	
																			,fileservices.addsuperfile(corp2_mapping._Dataset().thor_cluster_Files + 'in::'+corp2_mapping._Dataset().NameMapped+'::sprayed::stock'	,corp2_mapping._Dataset().thor_cluster_Files + 'in::corp2::'+version+'::stock_NC')																		 
																			,if (count(Main_BadRecords) <> 0 or  count(Event_BadRecords) <> 0 or  count(AR_BadRecords) <> 0 
																					 ,corp2_mapping.Send_Email(state_origin,version,count(Main_Badrecords)<>0,count(AR_Badrecords)<>0,count(Event_Badrecords)<>0,,count(Main_Badrecords),count(AR_Badrecords),count(Event_Badrecords),,count(Main_Approvedrecords),count(AR_Approvedrecords),count(Event_Approvedrecords),count(MapStock)).recordsRejected																				 
																					 ,corp2_mapping.Send_Email(state_origin,version,count(Main_Badrecords)<>0,count(AR_Badrecords)<>0,count(Event_Badrecords)<>0,,count(Main_Badrecords),count(AR_Badrecords),count(Event_Badrecords),,count(Main_Approvedrecords),count(AR_Approvedrecords),count(Event_Approvedrecords),count(MapStock)).mappingSuccess																				 
																					)	
																		,if(IsScrubErrors
																				,corp2_mapping.Send_Email(state_origin ,version,Main_IsScrubErrors,AR_IsScrubErrors,Event_IsScrubErrors,false).FieldsInvalidPerScrubs
																				)					
																		)
													 ,sequential( write_fail_main//if it fails on  main file threshold ,still writing mapped files!
																			 ,write_fail_event
																			 ,write_fail_ar
																			 ,corp2_mapping.Send_Email(state_origin ,version).MappingFailed
																			)
												 )
										,Event_All
										,Main_All
										,AR_ALL
									);
						
		//Validating the filedate entered is within 30 days								
		isFileDateValid := if((string)Std.Date.Today() between ut.date_math(filedate,-30) and ut.date_math(filedate,30),true,false);
		result		 			:= if(isFileDateValid
													,mapNC
													,sequential (corp2_mapping.Send_Email(state_origin ,filedate).InvalidFileDateParm
																			 ,FAIL('corp2_mapping.NC failed.  An invalid filedate was passed in as a parameter.')
																			)
												 );
		return result;

	end;	// end of Update function
      
end;  // end of Module 
      	