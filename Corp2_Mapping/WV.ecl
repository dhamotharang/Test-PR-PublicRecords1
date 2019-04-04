Import _Control, Corp2, Corp2_Raw_WV, Scrubs, Scrubs_Corp2_Mapping_WV_Main, Tools, UT, VersionControl, Std, _validate ;

Export WV 	:= Module

	export Update( string fileDate,string version, boolean pShouldSpray = _Dataset().bShouldSpray, boolean pOverwrite = false,pUseProd = Tools._Constants.IsDataland) :=Function 

		state_origin			:= 'WV';
		state_fips	 			:= '54';	
		state_desc	 			:= 'WEST VIRGINIA';
		
		ds_Addresses   		:= dedup(sort(distribute(Corp2_Raw_WV.Files(filedate,pUseProd).Input.Addresses.logical,hash(record_did1)),record,local),record,local):independent;
		ds_amendments    	:= dedup(sort(distribute(Corp2_Raw_WV.Files(filedate,pUseProd).Input.amendments.logical,hash(record_did1)),record,local),record,local):independent;
		ds_annualreports 	:= dedup(sort(distribute(Corp2_Raw_WV.Files(filedate,pUseProd).Input.annualreports.logical,hash(record_did)),record,local),record,local):independent;
		ds_corporations  	:= dedup(sort(distribute(Corp2_Raw_WV.Files(filedate,pUseProd).Input.corporations.logical,hash(record_did)),record,local),record,local):independent;
		ds_dissolutions  	:= dedup(sort(distribute(Corp2_Raw_WV.Files(filedate,pUseProd).Input.dissolutions.logical,hash(record_did1)),record,local),record,local) :independent;
		ds_dbas   			  := dedup(sort(distribute(Corp2_Raw_WV.Files(filedate,pUseProd).Input.dbas.logical,hash(record_did)),record,local),record,local):independent;
		ds_mergers   	 		:= dedup(sort(distribute(Corp2_Raw_WV.Files(filedate,pUseProd).Input.mergers.logical,hash(SurvivingCorpID,MergingCorpID)),record,local),record,local):independent;
		ds_namechanges   	:= dedup(sort(distribute(Corp2_Raw_WV.Files(filedate,pUseProd).Input.namechanges.logical,hash(record_did)),record,local),record,local):independent;
		ds_subsidiaries  	:= dedup(sort(distribute(Corp2_Raw_WV.Files(filedate,pUseProd).Input.subsidiaries.logical,hash(record_did)),record,local),record,local):independent;
		
		list1:='SAME ADDRESS AS ABOVE|SAME ADDRESS|SAME ADDR|SAME AS ABOVE|SAME ADDRESS FOR ALL|^DSAME AS|^SAME AS|SAME ADD|SAME AS OTHER|';
		list2:='^--SAME ADDRESS|^SAME$|\\(SAME|\\{SAME|^SAME$|^SAME |^SAME\\,|SAME\\**|SAME\\. AS|^SAMEAS|^SAMES|^SAMEE|^DSAME|^SAMED$|^SAMEA S|^SAME A|^SAMES A';
		list :=list1 + list2;
		//According to CI ,Street1 can contain SAME, SAME AS ABOVE, SAME ADDRESS AS ABOVE in that case Address info from the preceding record will be picked up using same gropup recordid
		Corp2_Raw_WV.Layouts.AddressesLayoutIn   trfAddr(Corp2_Raw_WV.Layouts.AddressesLayoutIn l ,Corp2_Raw_WV.Layouts.AddressesLayoutIn r)	:=	transform
				
			samegroup    				:= if(l.record_did1 = r.record_did1,true,false);					
			self.Street1 				:= if(samegroup and regexfind(list ,corp2.t2u(r.Street1),nocase), l.Street1, r.street1);		
			self.Street2 				:= if(samegroup and regexfind(list ,corp2.t2u(r.Street1),nocase), l.Street2, r.street2);		
			self.country				:= if(samegroup and regexfind(list ,corp2.t2u(r.Street1),nocase), l.country,r.country);
			self.StateProvince  := if(samegroup and regexfind(list ,corp2.t2u(r.Street1),nocase), l.StateProvince,r.StateProvince);
			self.city 					:= if(samegroup and regexfind(list ,corp2.t2u(r.Street1),nocase), l.city,r.city);
			self.zipcode 				:= if(samegroup and regexfind(list ,corp2.t2u(r.Street1),nocase), l.zipcode ,r.zipcode);								   
			self         				:= r;
										
		end;

		New_addr_clean	:=	iterate(ds_Addresses,trfAddr(left,right)) :independent;

		//********************************************************************
		//Join corporations & Addresses file to get the corresponding addr info for corp filings 
		//********************************************************************
		joinCorp_addr := join(ds_corporations,New_addr_clean ,
													corp2.t2u(left.record_did) = corp2.t2u(right.record_did1),
													transform(Corp2_Raw_WV.Layouts.Temp_corp_Addr,
																		self := left;
																		self := right;
																		),
													left outer,local):independent;
													
		Corp2_Mapping.LayoutsCommon.Main wv_corpTransform_Business(Corp2_Raw_WV.Layouts.Temp_corp_Addr input):=transform
		
			address1_type_list										:= ['PRINCIPAL OFFICE ADDRESS','LOCAL OFFICE ADDRESS','DESIGNATED OFFICE ADDRESS','HOME STATE MAILING ADDRESS'];											
			self.dt_vendor_first_reported		 			:= (integer)fileDate;
			self.dt_vendor_last_reported		 			:= (integer)fileDate;
			self.dt_first_seen							 			:= (integer)fileDate;
			self.dt_last_seen								 			:= (integer)fileDate;
			self.corp_ra_dt_first_seen			 			:= (integer)fileDate;
			self.corp_ra_dt_last_seen				 			:= (integer)fileDate;	
			self.corp_process_date				  			:= fileDate; 
			self.corp_vendor					  					:= state_fips;
			self.corp_state_origin            		:= state_origin	;
			self.corp_inc_state                   := state_origin;						 
			self.corp_orig_sos_charter_nbr   			:= corp2.t2u(input.record_did);
			self.corp_key					      					:= state_fips+'-'+ corp2.t2u(input.record_did);
			self.corp_legal_name                  := Corp2_Mapping.fCleanBusinessName(state_origin ,state_desc,input.name).BusinessName; 
			SELF.corp_ln_name_type_cd         		:= map(corp2.t2u(input.businesstype)='EMB'=>'I',
																									 corp2.t2u(input.businesstype)='NRG'=>'09',
																									 corp2.t2u(input.businesstype)='NRS'=>'07',
																									 corp2.t2u(input.businesstype) in['TM','TMO']=>'03',
																									 '01'
																									 );
			SELF.corp_ln_name_type_desc           := map( corp2.t2u(input.businesstype)='EMB'=>'OTHER',
																										corp2.t2u(input.businesstype)='NRG'=>'NAME REGISTRATION',
																										corp2.t2u(input.businesstype)='NRS'=>'NAME RESERVATION',
																										corp2.t2u(input.businesstype) in['TM','TMO']=>'TRADEMARK',																										
																										'LEGAL'
																									);
			self.corp_Filing_date                 := Corp2_Mapping.fValidateDate(input.EffectiveDate,'MM/DD/CCYY').GeneralDate;
			self.corp_Filing_desc                 := if(Corp2_Mapping.fValidateDate(input.EffectiveDate,'MM/DD/CCYY').GeneralDate<>'' ,'EFFECTIVE','');
			self.corp_inc_date                    := if(corp2.t2u(input.CharterType)='D', Corp2_Mapping.fValidateDate(input.FilingDate,'MM/DD/CCYY').pastDate, '');
			self.corp_forgn_date                  := if(corp2.t2u(input.CharterType)='F', Corp2_Mapping.fValidateDate(input.FilingDate,'MM/DD/CCYY').pastDate, '');																						
			self.corp_orig_org_structure_cd       := if(corp2.t2u(input.businesstype) not in ['NRG', 'NRS','TM','TMO'],corp2.t2u(input.businesstype),'');												
			self.corp_orig_org_structure_desc    	:= Corp2_Raw_WV.Functions.fGetOrg_structure_desc(input.businesstype); 
			self.corp_foreign_domestic_ind        := if(corp2.t2u(input.CharterType)in ['D','F'],corp2.t2u(input.CharterType),'');
			self.corp_forgn_state_cd         	   	:= if(corp2.t2u(input.CharterStateProvince)not in[ state_origin,''],Corp2_Raw_WV.Functions.Get_State_Code(input.CharterStateProvince),'');
			self.corp_forgn_state_desc        		:= if(corp2.t2u(input.CharterStateProvince)not in[ state_origin,''],Corp2_Raw_WV.Functions.fGetStateDesc(input.CharterStateProvince),'');
			self.corp_inc_county                  := if(corp2.t2u(input.CharterCounty)not in['57','60','64','71','97','98'],Corp2_Raw_WV.Functions.fGetCountyDesc(input.CharterCounty),'');
			self.corp_for_profit_ind              := map(corp2.t2u(input.BusinessClass)='P' =>'Y',
																									 corp2.t2u(input.BusinessClass)='N'	=>'N',
																									 '');
			self.corp_termination_date   					:= If(corp2.t2u(input.businesstype) not in ['LLC', 'LLP','TMO'] ,Corp2_Mapping.fValidateDate(input.TerminationDate,'MM/DD/CCYY').GeneralDate, '');								 
			self.corp_trademark_expiration_date 	:= If(corp2.t2u(input.businesstype) = 'TMO',Corp2_Mapping.fValidateDate(input.TerminationDate,'MM/DD/CCYY').GeneralDate, '');								 
  		self.Corp_Termination_Cd	          	:= map(corp2.t2u(input.businesstype)  in ['LLC', 'LLP','TMO']=>'',
																									 corp2.t2u(input.TerminationReason) in ['0','D','S','O','Y','`']=>'', //Per CI : 'No code descriptions - leave blank'
																									 corp2.t2u(input.TerminationReason)
																									);																				
			self.Corp_Termination_Desc 						:= Corp2_Raw_WV.Functions.fGetTerminationDesc(self.Corp_Termination_Cd);
			self.corp_status_date              		:= If(corp2.t2u(input.businesstype) not in ['LLC', 'LLP'] ,Corp2_Mapping.fValidateDate(input.TerminationDate,'MM/DD/CCYY').pastDate, '');	
			self.corp_status_Cd	          				:= map(corp2.t2u(input.businesstype)  in ['LLC', 'LLP']=>'',
																									 corp2.t2u(input.TerminationReason) in ['0','D','S','O','Y','`']=>'', //Per CI : 'No code descriptions - leave blank'
																									 corp2.t2u(input.TerminationReason)
																									 );
			self.corp_status_Desc 								:= if(((ut.date_slashed_mmddyyyy_to_yyyymmdd(input.TerminationDate) > ut.GetDate) OR trim(input.TerminationDate,left,right) = '') AND
			                                              corp2.t2u(input.TerminationReason) in ['X',''], 'ACTIVE', 'NOT ACTIVE');
			self.corp_status_Comment              := if(corp2.t2u(input.businesstype) <> 'TMO',Corp2_Raw_WV.Functions.fGetStatusDesc(self.Corp_Termination_Cd),'');//overload
			Self.corp_term_exist_cd 							:= If(corp2.t2u(input.businesstype)  In ['LLC', 'LLP', 'TMO'] and Corp2_Mapping.fValidateDate(input.TerminationDate,'MM/DD/CCYY').GeneralDate<>'', 'D','');
			Self.corp_term_exist_exp 							:= If(corp2.t2u(input.businesstype)  In ['LLC', 'LLP', 'TMO'],Corp2_Mapping.fValidateDate(input.TerminationDate,'MM/DD/CCYY').GeneralDate,'');
			Self.corp_term_exist_desc 				    := If(corp2.t2u(input.businesstype)  In ['LLC', 'LLP', 'TMO'] and Corp2_Mapping.fValidateDate(input.TerminationDate,'MM/DD/CCYY').GeneralDate<>'','EXPIRATION DATE','');
			self.corp_address1_line1							:= if(corp2.t2u(input.ContactType)in address1_type_list,Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.street1,input.street2,input.City,input.stateProvince,input.zipCode).AddressLine1,'');
			self.corp_address1_line2				 			:= if(corp2.t2u(input.ContactType)in address1_type_list,Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.street1,input.street2,input.City,input.stateProvince,input.zipCode).AddressLine2,'');
			self.corp_address1_line3				  		:= if(corp2.t2u(input.ContactType)in address1_type_list,Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.street1,input.street2,input.City,input.stateProvince,input.zipCode).AddressLine3,'');
			self.corp_prep_addr1_line1						:= if(corp2.t2u(input.ContactType)in address1_type_list,Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.street1,input.street2,input.City,input.stateProvince,input.zipCode).PrepAddrLine1,'');
			self.corp_prep_addr1_last_line				:= if(corp2.t2u(input.ContactType)in address1_type_list,Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.street1,input.street2,input.City,input.stateProvince,input.zipCode).PrepAddrLastLine,'');
			self.corp_address1_type_cd         		:= if(Corp2_Mapping.fAddressExists(state_origin,state_desc,input.street1,input.street2,input.City,input.stateProvince,input.zipCode).ifAddressExists,
																									map( corp2.t2u(input.ContactType)='PRINCIPAL OFFICE ADDRESS'=>'B',
																											 corp2.t2u(input.ContactType)='DESIGNATED OFFICE ADDRESS'=>'D',
																											 corp2.t2u(input.ContactType)='LOCAL OFFICE ADDRESS'=>'L',
																											 corp2.t2u(input.ContactType)='HOME STATE MAILING ADDRESS'=>'H',
																											 ''),
																									'');
			self.corp_address1_type_desc         	:= if(Corp2_Mapping.fAddressExists(state_origin,state_desc,input.street1,input.street2,input.City,input.stateProvince,input.zipCode).ifAddressExists,
																									map( corp2.t2u(input.ContactType)='PRINCIPAL OFFICE ADDRESS'=>'BUSINESS',
																											 corp2.t2u(input.ContactType)='DESIGNATED OFFICE ADDRESS'=>'DESIGNATED OFFICE',
																											 corp2.t2u(input.ContactType)='LOCAL OFFICE ADDRESS'=>'LOCAL OFFICE',
																											 corp2.t2u(input.ContactType)='HOME STATE MAILING ADDRESS'=>'HOME STATE',
																											 ''),
																									'');
			self.corp_address2_line1							:= if(corp2.t2u(input.ContactType)='MAILING ADDRESS',Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.street1,input.street2,input.City,input.stateProvince,input.zipCode).AddressLine1,'');
			self.corp_address2_line2				 			:= if(corp2.t2u(input.ContactType)='MAILING ADDRESS',Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.street1,input.street2,input.City,input.stateProvince,input.zipCode).AddressLine2,'');
			self.corp_address2_line3				  		:= if(corp2.t2u(input.ContactType)='MAILING ADDRESS',Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.street1,input.street2,input.City,input.stateProvince,input.zipCode).AddressLine3,'');
			self.corp_prep_addr2_line1						:= if(corp2.t2u(input.ContactType)='MAILING ADDRESS',Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.street1,input.street2,input.City,input.stateProvince,input.zipCode).PrepAddrLine1,'');
			self.corp_prep_addr2_last_line				:= if(corp2.t2u(input.ContactType)='MAILING ADDRESS',Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.street1,input.street2,input.City,input.stateProvince,input.zipCode).PrepAddrLastLine,'');
			self.corp_address2_type_cd         		:= if(Corp2_Mapping.fAddressExists(state_origin,state_desc,input.street1,input.street2,input.City,input.stateProvince,input.zipCode).ifAddressExists and corp2.t2u(input.ContactType)='MAILING ADDRESS','M','');
			self.corp_address2_type_desc         	:= if(Corp2_Mapping.fAddressExists(state_origin,state_desc,input.street1,input.street2,input.City,input.stateProvince,input.zipCode).ifAddressExists and corp2.t2u(input.ContactType)='MAILING ADDRESS','MAILING','');
			self.Corp_ra_full_name                := if(corp2.t2u(input.ContactType)='NOTICE OF PROCESS ADDRESS',Corp2_Mapping.fCleanBusinessName(state_origin ,state_desc,input.ContactName).BusinessName,'');
			self.corp_ra_address_line1            := if(corp2.t2u(input.ContactType)='NOTICE OF PROCESS ADDRESS',Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.street1,input.street2,input.City,input.stateProvince,input.zipCode).AddressLine1,'');
			self.corp_ra_address_line2						:= if(corp2.t2u(input.ContactType)='NOTICE OF PROCESS ADDRESS',Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.street1,input.street2,input.City,input.stateProvince,input.zipCode).AddressLine2,'');
			self.corp_ra_address_line3						:= if(corp2.t2u(input.ContactType)='NOTICE OF PROCESS ADDRESS',Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.street1,input.street2,input.City,input.stateProvince,input.zipCode).AddressLine3,'');;
			self.ra_prep_addr_line1								:= if(corp2.t2u(input.ContactType)='NOTICE OF PROCESS ADDRESS',Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.street1,input.street2,input.City,input.stateProvince,input.zipCode).PrepAddrLine1,'');
			self.ra_prep_addr_last_line						:= if(corp2.t2u(input.ContactType)='NOTICE OF PROCESS ADDRESS',Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.street1,input.street2,input.City,input.stateProvince,input.zipCode).PrepAddrLastLine,'');
			self.corp_ra_address_type_cd		  		:= if(Corp2_Mapping.fAddressExists(state_origin,state_desc,input.street1,input.street2,input.City,input.stateProvince,input.zipCode).ifAddressExists and corp2.t2u(input.ContactType)='NOTICE OF PROCESS ADDRESS','R','');
			self.corp_ra_address_type_desc				:= if(Corp2_Mapping.fAddressExists(state_origin,state_desc,input.street1,input.street2,input.City,input.stateProvince,input.zipCode).ifAddressExists and corp2.t2u(input.ContactType)='NOTICE OF PROCESS ADDRESS','REGISTERED OFFICE','');										 
			self.corp_country_of_formation		    := if(StringLib.StringFind(corp2.t2u(input.ContactType),'ADDRESS',1)= 0 ,Corp2_Raw_WV.Functions.fGetCountryDesc(input.country),'');
			self.recordorigin									    := 'C';																					
			self																  := [];

		End;
		
		mapCorp 	:= project(joinCorp_addr, wv_corpTransform_Business(left)) ;			
					
		d_mapCorp := distribute(mapCorp	,hash(corp_key,corp_legal_name)):independent;
		
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
				self.Corp_ra_full_name        := if(r.Corp_ra_full_name<>'',					r.Corp_ra_full_name,				l.Corp_ra_full_name);
				self.corp_ra_address_line1    := if(r.corp_ra_address_line1 <> '', 		r.corp_ra_address_line1, 		l.corp_ra_address_line1);
				self.corp_ra_address_line2		:= if(r.corp_ra_address_line2 <> '',		r.corp_ra_address_line2, 		l.corp_ra_address_line2);
				self.corp_ra_address_line3		:= if(r.corp_ra_address_line3 <> '', 		r.corp_ra_address_line3, 		l.corp_ra_address_line3);
				self.ra_prep_addr_line1				:= if(r.ra_prep_addr_line1 <> '',			  r.ra_prep_addr_line1, 			l.ra_prep_addr_line1);
				self.ra_prep_addr_last_line		:= if(r.ra_prep_addr_last_line <> '', 	r.ra_prep_addr_last_line,		l.ra_prep_addr_last_line);
				self.corp_ra_address_type_cd	:= if(r.corp_ra_address_type_cd <> '',  r.corp_ra_address_type_cd,	l.corp_ra_address_type_cd);
				self.corp_ra_address_type_desc:= if(r.corp_ra_address_type_desc<> '', r.corp_ra_address_type_desc,l.corp_ra_address_type_desc);
				self.corp_country_of_formation:= if(r.corp_country_of_formation<> '', r.corp_country_of_formation,l.corp_country_of_formation);
				self 													:= l;
				
			end;

		  denorm_Corp	:= denormalize( d_mapCorp
																	,d_mapCorp
																	,left.corp_key = right.corp_key  and
																	 left.corp_legal_name = right.corp_legal_name
																	,tGetStandardized(left,right)
																	,local
															    ):independent;			

		Corp2_Raw_WV.Layouts.slim_NormMerger_lay  TSurvvor_nonSurvivor(Corp2_Raw_WV.Layouts.mergersLayoutIn l,integer ctr):=transform

			self.Corp_Merger_Name								:= choose(ctr,corp2.t2u(l.SurvivingCorpName),corp2.t2u(l.MergingCorpName));
			self.Corp_Survivor_Corporation_ID 	:= corp2.t2u(l.SurvivingCorpID);
			self.corp_merged_corporation_id     := if(trim(l.MergingCorpID,left,right)<>'0',corp2.t2u(l.MergingCorpID),'');
			self.Corp_Merger_Indicator					:= choose(ctr,if(corp2.t2u(l.SurvivingCorpName)<>'','S',''),if(corp2.t2u(l.MergingCorpName)<>'','N',''));
			self.Corp_Merger_Date								:= Corp2_Mapping.fValidateDate(l.MergerDate,'MM/DD/CCYY').pastDate;
			self																:= l;

		end;

		map_Survvor_nonSurvivor 	  	 := normalize(ds_mergers,if(trim(left.SurvivingCorpName)<>'' and trim(left.MergingCorpName)<>'', 2,1),TSurvvor_nonSurvivor(left,counter));

		Corp2_Mapping.LayoutsCommon.Main  wv_corpTransform_Survivor(Corp2_Mapping.LayoutsCommon.Main l ,Corp2_Raw_WV.Layouts.slim_NormMerger_lay r):=transform
			
			self.Corp_Merger_Name								:= Corp2_Mapping.fCleanBusinessName(state_origin ,state_desc,r.Corp_Merger_Name).BusinessName;
			self.Corp_Survivor_Corporation_ID 	:= r.Corp_Survivor_Corporation_ID ;
			self.corp_merged_corporation_id     := r.corp_merged_corporation_id;
			self.Corp_Merger_Indicator					:= r.Corp_Merger_Indicator;
			self.Corp_Merger_Date               := r.Corp_Merger_Date;
			self                                := l;

		end;

		dsCorp_Survivor 	  	 := join(distribute(denorm_Corp,hash(corp_orig_sos_charter_nbr)), distribute(map_Survvor_nonSurvivor,hash(Corp_Survivor_Corporation_ID)),
																	 corp2.t2u(left.corp_orig_sos_charter_nbr)	=	corp2.t2u(right.Corp_Survivor_Corporation_ID),
																	 wv_corpTransform_Survivor(left,right),
																	 left outer,local);		

		Corp2_Mapping.LayoutsCommon.Main wv_corpTransform_Dissolutions(Corp2_Mapping.LayoutsCommon.Main l,Corp2_Raw_WV.Layouts.DissolutionsLayoutIn r):=transform

			self.Corp_Action_Employment_Security_Approval_Date	:= Corp2_Mapping.fValidateDate(r.ESApprovalDate,'MM/DD/CCYY').pastDate;
			self.Corp_Action_Tax_Dept_Approval_Date							:= Corp2_Mapping.fValidateDate(r.TaxApprovalDate,'MM/DD/CCYY').pastDate;
			self.Corp_Action_Pending_cd     	       						:= map(corp2.t2u(r.ActionPending)='F'=>'',
																																 corp2.t2u(r.ActionPending) in ['0','D','O','Q']=>'', //per CI : No code descriptions - leave blank
																																 corp2.t2u(r.ActionPending)
																																 );																														
			self.Corp_Action_Pending_desc				              	:= Corp2_Raw_WV.Functions.fGetTerminationDesc(self.Corp_Action_Pending_cd); 
			self																								:= l;

		end; 		

		mapDissolutions   :=  join(dsCorp_Survivor,ds_dissolutions,
															 corp2.t2u(left.corp_orig_sos_charter_nbr) =	corp2.t2u(right.record_did1), 
															 wv_corpTransform_Dissolutions(left,right),
															 left outer,local
														  );

		Corp2_Mapping.LayoutsCommon.Main wv_contactTransform(Corp2_Raw_WV.Layouts.Temp_corp_Addr	input):=transform,
		skip(StringLib.StringFind(corp2.t2u(input.ContactType),'ADDRESS',1)<> 0 or corp2.t2u(input.ContactName)='')

			self.dt_vendor_first_reported		  := (integer)fileDate;
			self.dt_vendor_last_reported		 	:= (integer)fileDate;
			self.dt_first_seen							  := (integer)fileDate;
			self.dt_last_seen								 	:= (integer)fileDate;
			self.corp_ra_dt_first_seen			 	:= (integer)fileDate;
			self.corp_ra_dt_last_seen				 	:= (integer)fileDate;	
			self.corp_process_date				  	:= fileDate; 
			self.corp_vendor					  			:= state_fips;
			self.corp_state_origin            := state_origin	;
			self.corp_inc_state               := state_origin;	 
			self.corp_orig_sos_charter_nbr   	:= corp2.t2u(input.record_did);
			self.corp_key					      			:= state_fips+'-'+ corp2.t2u(input.record_did);
			self.corp_legal_name              := Corp2_Mapping.fCleanBusinessName(state_origin ,state_desc,input.name).BusinessName; 
			self.cont_full_name               := map(StringLib.StringFind(corp2.t2u(input.ContactName),'SAME',1)<>0 =>'' ,
																							 StringLib.StringFind(corp2.t2u(input.ContactName),'NONE',1)<>0 =>'',
																							 Corp2_Mapping.fCleanBusinessName(state_origin ,state_desc,input.ContactName).BusinessName
																							);
			self.cont_title1_desc             := corp2.t2u(input.ContactType);
			self.cont_address_line1						:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.street1,input.street2,input.city,input.stateProvince,input.zipCode).AddressLine1;
			self.cont_address_line2						:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.street1,input.street2,input.city,input.stateProvince,input.zipCode).AddressLine2;
			self.cont_address_line3						:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.street1,input.street2,input.city,input.stateProvince,input.zipCode).AddressLine3;
			self.cont_prep_addr_line1					:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.street1,input.street2,input.city,input.stateProvince,input.zipCode).PrepAddrLine1;
			self.cont_prep_addr_last_line			:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.street1,input.street2,input.city,input.stateProvince,input.zipCode).PrepAddrLastLine;
			self.cont_Address_type_cd         := if(Corp2_Mapping.fAddressExists(state_origin,state_desc,input.street1,input.street2,input.city,input.stateProvince,input.zipCode).ifAddressExists ,'T','');
			self.cont_Address_type_desc       := if(Corp2_Mapping.fAddressExists(state_origin,state_desc,input.street1,input.street2,input.city,input.stateProvince,input.zipCode).ifAddressExists ,'CONTACT','');
			self.recordorigin									:= 'T';																					
			self															:= [];

		End;	

		mapCont                             :=project(joinCorp_addr, wv_contactTransform(left));
		
		jds_dbas	:= join(ds_dbas, ds_corporations, 
											corp2.t2u(left.record_did) = corp2.t2u(right.record_did),
											transform(Corp2_Raw_WV.Layouts.dbas_TempLay, 
																 self.CharterType := right.CharterType;
																 self.FilingDate 	:= right.FilingDate;
																 self := left; self := right; self := [];),
											left outer,local) : independent;
											
		Corp2_Mapping.LayoutsCommon.Main wv_corpTransform_DBAS(Corp2_Raw_WV.Layouts.dbas_TempLay input):=transform,
		skip(corp2.t2u(input.record_did)='' OR Corp2_Mapping.fCleanBusinessName(state_origin ,state_desc,input.DBAname).BusinessName='')

			self.dt_vendor_first_reported		   := (integer)fileDate;
			self.dt_vendor_last_reported		 	 := (integer)fileDate;
			self.dt_first_seen							   := (integer)fileDate;
			self.dt_last_seen								 	 := (integer)fileDate;
			self.corp_ra_dt_first_seen			 	 := (integer)fileDate;
			self.corp_ra_dt_last_seen				 	 := (integer)fileDate;	
			self.corp_process_date						 := fileDate;
			self.corp_vendor					  			 := state_fips;
			self.corp_state_origin      			 := state_origin	;
			self.corp_key					      			 := state_fips + '-' + corp2.t2u(input.record_did);
			self.corp_orig_sos_charter_nbr		 := corp2.t2u(input.record_did);
			self.corp_legal_name             	 := Corp2_Mapping.fCleanBusinessName(state_origin ,state_desc,input.DBAname).BusinessName; 
			self.corp_inc_state                := state_origin;
			self.corp_ln_name_type_cd          := map(corp2.t2u(input.DBAType) = 'TN'                    => '04',
			                                          corp2.t2u(input.DBAType) = 'FTN'                   => 'FN',
																								corp2.t2u(input.DBAType) = 'GTN'                   => 'GN',
																								corp2.t2u(input.DBAType) = 'STN'                   => 'SN',
																								corp2.t2u(input.DBAType) = 'TM'                    => '03',
																								corp2.t2u(input.DBAType) = 'FDB'                   => 'F',
																								corp2.t2u(input.DBAType) in ['FDA','F','FD','TMO'] => '', //Per CI : 'FDA','F' -No code descriptions - leave blank
																								corp2.t2u(input.DBAType)
																								);
			self.corp_ln_name_type_desc        := map(corp2.t2u(input.DBAType) = 'TN'                    => 'TRADENAME',
			                                          corp2.t2u(input.DBAType) = 'FTN'                   => 'FICTITIOUS TRADENAME',
																								corp2.t2u(input.DBAType) = 'GTN'                   => 'GENERAL PARTNER TRADENAME',
																								corp2.t2u(input.DBAType) = 'STN'                   => 'SOLE PROPRIETOR TRADENAME',
																								corp2.t2u(input.DBAType) = 'TM'                    => 'TRADEMARK',
																								corp2.t2u(input.DBAType) = 'FDB'                   => 'FICTITIOUS NAME',	
																								corp2.t2u(input.DBAType) in ['FDA','F','FD','TMO'] => '',
																								'');
			self.corp_foreign_domestic_ind     := if(corp2.t2u(input.DBAType)= 'FDB','F','');
			self.Corp_Name_Effective_Date    	 := if(corp2.t2u(input.DBAType)in['FDB','TN','FTN','GTN','STN'],Corp2_Mapping.fValidateDate(input.EffectiveDate,'MM/DD/CCYY').GeneralDate,'');
			self.Corp_Name_Status_Desc				 := map(corp2.t2u(input.DBAType)= 'FDB' and Corp2_Mapping.fValidateDate(input.TerminationDate,'MM/DD/CCYY').pastDate<>'' => 'DATE FOREIGN DBA TERMINATES: '+ Corp2_Mapping.fValidateDate(input.TerminationDate,'MM/DD/CCYY').pastDate,																							
																							  corp2.t2u(input.DBAType) in ['TN','FTN','GTN','STN'] and Corp2_Mapping.fValidateDate(input.TerminationDate,'MM/DD/CCYY').pastDate<>'' => 'DATE TRADENAME TERMINATES: '+ Corp2_Mapping.fValidateDate(input.TerminationDate,'MM/DD/CCYY').pastDate,
																							'');
			self.Corp_Trademark_Expiration_Date:= if(corp2.t2u(input.DBAType) in ['TM','TMO'],Corp2_Mapping.fValidateDate(input.TerminationDate,'MM/DD/CCYY').GeneralDate,'');
			self.Corp_Trademark_Filing_Date    := if(corp2.t2u(input.DBAType)='TM',Corp2_Mapping.fValidateDate(input.EffectiveDate,'MM/DD/CCYY').GeneralDate,'');
			self.Corp_Trademark_Logo           := if(corp2.t2u(input.DBAType)='TM',corp2.t2u(input.DBAname),'');	
			self.corp_status_date              := Corp2_Mapping.fValidateDate(input.TerminationDate,'MM/DD/CCYY').pastDate;
   		self.corp_status_desc              := if(trim(self.corp_status_date)<>'','TERMINATED',''); 		
			self.Corp_Termination_date         := Corp2_Mapping.fValidateDate(input.TerminationDate,'MM/DD/CCYY').pastDate;
			self.Corp_Termination_desc				 := if(trim(self.Corp_Termination_date)<>'','TERMINATED',''); 
			self.corp_filing_date    	 				 := if(corp2.t2u(input.DBAType)in ['TM','TN','FDB'],Corp2_Mapping.fValidateDate(input.EffectiveDate,'MM/DD/CCYY').pastDate,'');
			self.corp_filing_cd    	 				   := if(self.corp_filing_date<>'','X','');	
			self.corp_filing_desc    	 				 := if(self.corp_filing_date<>'','EFFECTIVE DATE','');
			self.corp_inc_date                 := if(corp2.t2u(input.CharterType)='D', Corp2_Mapping.fValidateDate(input.FilingDate,'MM/DD/CCYY').pastDate, '');
			self.corp_forgn_date               := if(corp2.t2u(input.CharterType)='F', Corp2_Mapping.fValidateDate(input.FilingDate,'MM/DD/CCYY').pastDate, '');																						
			self.recordorigin									 := 'C';																					
			self															 := [];

		end;	

		mapDBA  		      := project(jds_dbas, wv_corpTransform_DBAS(left));
		
		jds_namechanges	:= join(ds_namechanges, ds_corporations, 
											corp2.t2u(left.record_did) = corp2.t2u(right.record_did),
											transform(Corp2_Raw_WV.Layouts.namechanges_TempLay, 
																 self.CharterType := right.CharterType;
																 self.FilingDate 	:= right.FilingDate;
																 self := left; self := right; self := [];),
											left outer,local) : independent;
											
		Corp2_Mapping.LayoutsCommon.Main  wv_corpTransform_nameChanges(Corp2_Raw_WV.Layouts.namechanges_TempLay input):=transform,
		skip(corp2.t2u(input.record_did)='' or corp2.t2u(input.oldname)='')

			self.dt_vendor_first_reported		 	:= (integer)fileDate;
			self.dt_vendor_last_reported		 	:= (integer)fileDate;
			self.dt_first_seen							 	:= (integer)fileDate;
			self.dt_last_seen								 	:= (integer)fileDate;
			self.corp_ra_dt_first_seen			 	:= (integer)fileDate;
			self.corp_ra_dt_last_seen				 	:= (integer)fileDate;	
			self.corp_vendor					  			:= state_fips;
			self.corp_state_origin      			:= state_origin	;
			self.corp_process_date						:= fileDate;
			self.corp_key					      			:= state_fips + '-' + corp2.t2u(input.record_did);
			self.corp_orig_sos_charter_nbr		:= corp2.t2u(input.record_did);
			self.corp_legal_name              := Corp2_Mapping.fCleanBusinessName(state_origin ,state_desc,input.oldname).BusinessName;
			self.corp_ln_name_type_cd         := if(self.corp_legal_name <>'','P','');
			self.corp_ln_name_type_desc       := if(self.corp_legal_name <>'','PRIOR','');
			self.corp_inc_state               := state_origin;
			self.Corp_Name_effective_date  		:= Corp2_Mapping.fValidateDate(input.ChangeDate,'MM/DD/CCYY').GeneralDate; 
			self.corp_name_comment            := if(self.Corp_Name_effective_date<>'' ,'CHANGE DATE: '+ trim(input.ChangeDate,left,right),''); //overload
			self.corp_inc_date                := if(corp2.t2u(input.CharterType)='D', Corp2_Mapping.fValidateDate(input.FilingDate,'MM/DD/CCYY').pastDate, '');
			self.corp_forgn_date              := if(corp2.t2u(input.CharterType)='F', Corp2_Mapping.fValidateDate(input.FilingDate,'MM/DD/CCYY').pastDate, '');																						
  		self.recordorigin									:= 'C';
			self                              := [];

		end; 

		mapNamechanges  := project(jds_namechanges	, wv_corpTransform_nameChanges(left));

		//According to CI ,Street1 can contain SAME, SAME AS ABOVE, SAME ADDRESS AS ABOVE in that case Address info from the preceding record will be picked up using Recordid
		Corp2_Raw_WV.Layouts.subsidiariesLayoutIn trfSubs(Corp2_Raw_WV.Layouts.subsidiariesLayoutIn l,Corp2_Raw_WV.Layouts.subsidiariesLayoutIn r)	:=	transform
		 
			samegroup    				:= if(l.record_did = r.record_did,true,false); 		
			self.Street1 				:= if(samegroup and regexfind(list ,corp2.t2u(r.Street1),nocase), l.Street1, r.street1);		
			self.Street2 				:= if(samegroup and regexfind(list ,corp2.t2u(r.Street1),nocase), l.Street2, r.street2);	
			self.StateProvince  := if(samegroup and regexfind(list ,corp2.t2u(r.Street1),nocase), l.StateProvince,r.StateProvince);
			self.city 					:= if(samegroup and regexfind(list ,corp2.t2u(r.Street1),nocase), l.city,r.city);
			self.zipcode 				:= if(samegroup and regexfind(list ,corp2.t2u(r.Street1),nocase), l.zipcode ,r.zipcode);								   
			self         				:= r; 
									
		end;

		Clean_ds_subsidiaries	:=	iterate(ds_subsidiaries, trfSubs(left,right));

		jClean_ds_subsidiaries	:= join(Clean_ds_subsidiaries, ds_corporations, 
											corp2.t2u(left.record_did) = corp2.t2u(right.record_did),
											transform(Corp2_Raw_WV.Layouts.subsidiaries_TempLay, 
																 self.CharterType := right.CharterType;
																 self.FilingDate 	:= right.FilingDate;
																 self := left; self := right; self := [];),
											left outer,local) : independent;
											
		Corp2_Mapping.LayoutsCommon.Main wv_corpTransform_subsidiaries(Corp2_Raw_WV.Layouts.subsidiaries_TempLay input):=transform,
		skip(corp2.t2u(input.record_did)='' OR corp2.t2u(input.subsidiaryname)='')
		
			self.dt_vendor_first_reported		 		:= (integer)fileDate;
			self.dt_vendor_last_reported		 		:= (integer)fileDate;
			self.dt_first_seen							 		:= (integer)fileDate;
			self.dt_last_seen								 		:= (integer)fileDate;
			self.corp_ra_dt_first_seen			 		:= (integer)fileDate;
			self.corp_ra_dt_last_seen				 		:= (integer)fileDate;	
			self.corp_process_date							:= fileDate;
			self.corp_inc_state                 := state_origin;
			self.corp_vendor					  				:= state_fips;
			self.corp_state_origin      				:= state_origin	;
			self.corp_key					      			  := state_fips+'-'+  corp2.t2u(input.record_did);
			self.corp_orig_sos_charter_nbr		  := corp2.t2u(input.record_did);
			self.corp_ln_name_type_cd         	:= if(input.subsidiaryname <>'','SU','');
			self.corp_ln_name_type_desc       	:= if(input.subsidiaryname <>'','SUBSIDIARY CORP LEGAL NAME','');
			self.corp_legal_name              	:= Corp2_Mapping.fCleanBusinessName(state_origin ,state_desc,input.subsidiaryname).BusinessName;
			self.corp_address1_line1						:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.street1,input.street2,input.City,input.stateProvince,input.zipCode).AddressLine1;
			self.corp_address1_line2				 		:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.street1,input.street2,input.City,input.stateProvince,input.zipCode).AddressLine2;
			self.corp_address1_line3				  	:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.street1,input.street2,input.City,input.stateProvince,input.zipCode).AddressLine3;
			self.corp_prep_addr1_line1					:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.street1,input.street2,input.City,input.stateProvince,input.zipCode).PrepAddrLine1;
			self.corp_prep_addr1_last_line			:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.street1,input.street2,input.City,input.stateProvince,input.zipCode).PrepAddrLastLine;
			self.corp_address1_type_cd         	:= if(Corp2_Mapping.fAddressExists(state_origin,state_desc,input.street1,input.street2,input.City,input.stateProvince,input.zipCode).ifAddressExists,'S','');
			self.corp_address1_type_desc			 	:= if(Corp2_Mapping.fAddressExists(state_origin,state_desc,input.street1,input.street2,input.City,input.stateProvince,input.zipCode).ifAddressExists,'SUBSIDIARY CORP ADDRESS','');
			self.corp_inc_date                  := if(corp2.t2u(input.CharterType)='D', Corp2_Mapping.fValidateDate(input.FilingDate,'MM/DD/CCYY').pastDate, '');
			self.corp_forgn_date                := if(corp2.t2u(input.CharterType)='F', Corp2_Mapping.fValidateDate(input.FilingDate,'MM/DD/CCYY').pastDate, '');																						
			self.recordorigin									 	:= 'C';
			self                               	:= [];

		end; 

		mapSubsidiaries   := project(jClean_ds_subsidiaries, wv_corpTransform_subsidiaries(left));		
				
		joinCorp_amend    := join(ds_corporations,ds_amendments,
															corp2.t2u(left.record_did) = corp2.t2u(right.record_did1),
																		transform(Corp2_Raw_WV.Layouts.Temp_corp_amend,
																							self := left;
																							self := right;
																							),
														 left outer,local );
		
		Corp2_Mapping.LayoutsCommon.Events wv_eventTransform1(Corp2_Raw_WV.Layouts.Temp_corp_amend input):=transform,
		skip(corp2.t2u(input.record_did)='')

			self.corp_vendor					  		:= state_fips;
			self.corp_state_origin          := state_origin	;
			self.corp_process_date			    := fileDate;
			self.corp_key					      		:= state_fips + '-' + corp2.t2u(input.record_did);
			self.corp_sos_charter_nbr		    := corp2.t2u(input.record_did);
			self.event_desc              		:= corp2.t2u(input.Amendment);
			self.event_filing_date          := Corp2_Mapping.fValidateDate(input.Amendmentdate,'MM/DD/CCYY').pastDate;
			self                            := [];

		end; 

		mapEvent1 	:= project(joinCorp_amend, wv_eventTransform1(left))(corp2.t2u(event_desc + event_filing_date)<>'') ;

		joinCorp_Dissolutions:= join(ds_corporations,ds_Dissolutions,
																 corp2.t2u(left.record_did) = corp2.t2u(right.record_did1),
																 transform(Corp2_Raw_WV.Layouts.Temp_corp_Dissolutions ,
																					 self := left;
																					 self := right;
																					 ),
																 left outer,local):independent;	
														 
		Corp2_Mapping.LayoutsCommon.Events wv_eventTransform2(Corp2_Raw_WV.Layouts.Temp_corp_Dissolutions   input):=transform,
		skip(corp2.t2u(input.record_did)='' or corp2.t2u(input.HistoryNumber + input.ArtDissolutionDate + input.WCApprovalDate + input.ApprovalReqDate )='')

			self.corp_vendor					  		:= state_fips;
			self.corp_state_origin      		:= state_origin	;
			self.corp_process_date					:= fileDate;
			self.corp_key					      		:= state_fips + '-' + corp2.t2u(input.record_did);
			self.corp_sos_charter_nbr				:= corp2.t2u(input.record_did);
			self.event_filing_reference_nbr := if(corp2.t2u(input.HistoryNumber)<>'','FILING NO: '+corp2.t2u(input.HistoryNumber),'');
			self.event_filing_date          := Corp2_Mapping.fValidateDate(input.ArtDissolutionDate,'MM/DD/CCYY').pastDate;
			self.event_date_type_cd         := If(trim(self.event_filing_date)<>'','DIS','');
			self.event_date_type_desc       := If(trim(self.event_filing_date)<>'','DISSOLUTION','');
			self.Event_Revocation_Comment1  := if(Corp2_Mapping.fValidateDate(input.WCApprovalDate,'MM/DD/CCYY').pastDate<>'','WORKER COMPENSATION DIVISION APPROVAL DATE: '+trim(input.WCApprovalDate,left,right),'');
			self.Event_Revocation_Comment2  := if(Corp2_Mapping.fValidateDate(input.ApprovalReqDate,'MM/DD/CCYY').pastDate<>'','APPROVAL REQUESTED  DATE: '+trim(input.ApprovalReqDate,left,right),'');
			self                            := [];

		end; 

		mapEvent2		:= project(joinCorp_Dissolutions, wv_eventTransform2(left));
		
		Corp2_Mapping.LayoutsCommon.AR wv_arTransform(Corp2_Raw_WV.Layouts.annualreportsLayoutIn input):=transform,
		skip(corp2.t2u(input.record_did)='' )

			self.corp_vendor					  := state_fips;
			self.corp_state_origin      := state_origin	;
			self.corp_process_date			:= fileDate;
			self.corp_key					      := state_fips + '-' + corp2.t2u(input.record_did);
			self.corp_sos_charter_nbr		:= corp2.t2u(input.record_did);
			self.ar_report_nbr          := if((integer)input.HistoryNumber<>0,corp2.t2u(input.HistoryNumber),''); 
			self.ar_filed_dt            := Corp2_Mapping.fValidateDate(input.dateFiled,'MM/DD/CCYY').pastDate;
			self.ar_year								:= if (_validate.date.fIsValid(stringlib.stringfilter(input.filingfor,'0123456789'), 
																				 _validate.date.Rules.YearValid),corp2.t2u(input.filingfor),''); 
			self                        := [];

		end; 

		mapAR1 		:= project(ds_annualreports, wv_arTransform(left))(corp2.t2u(ar_report_nbr + ar_filed_dt+ ar_year)<>'') ;

		Corp2_Mapping.LayoutsCommon.AR wv_arTransform2(Corp2_Raw_WV.Layouts.Temp_corp_Dissolutions input):=transform,
		skip(corp2.t2u(input.record_did)='' or (integer)input.HistoryNumber=0)

			self.corp_vendor					  := state_fips;
			self.corp_state_origin      := state_origin	;
			self.corp_process_date			:= fileDate;
			self.corp_key					      := state_fips + '-' + corp2.t2u(input.record_did);
			self.corp_sos_charter_nbr		:= corp2.t2u(input.record_did);
			self.ar_report_nbr          := if((integer)input.HistoryNumber<>0,corp2.t2u(input.HistoryNumber),'');
			self                        := [];

		end; 

		mapAR2 		:= project(joinCorp_Dissolutions, wv_arTransform2(left));
		
		Corp2_Mapping.LayoutsCommon.stock wv_stockTransform(Corp2_Raw_WV.Layouts.corporationsLayoutIn input):=transform,
		skip(corp2.t2u(input.record_did)='')

			self.corp_vendor					  			:= state_fips;
			self.corp_state_origin            := state_origin	;
			self.corp_process_date			      := fileDate;
			self.corp_key					      			:= state_fips + '-' + corp2.t2u(input.record_did);
			self.corp_sos_charter_nbr		      := corp2.t2u(input.record_did);
			self.stock_authorized_nbr			  	:= if((integer)input.TotalAuthorizedShares <> 0 ,trim(input.TotalAuthorizedShares,left,right),'');
			self.stock_par_value              := if((integer)input.parValue <> 0 ,trim(input.parValue,left,right),'');
			//overloaded field
			self.stock_tax_capital            := map((integer)input.parValue 						  = 0 =>'',
																							 (integer)input.TotalAuthorizedShares = 0 =>'',
																							 (integer)input.parValue = 0 and (integer)input.TotalAuthorizedShares <> 0 => (string)( 25 * (integer)trim(input.TotalAuthorizedShares,left,right)),
																							 (integer)input.parValue <> 0 and (integer)input.TotalAuthorizedShares<> 0 =>(string)((integer)trim(input.TotalAuthorizedShares,left,right) * (integer)trim(input.parValue,left,right)),
																							 '');
			self                              := [];

		end;

		ds_stock  := project(ds_corporations, wv_stockTransform(left))(corp2.t2u(stock_authorized_nbr + stock_par_value + stock_tax_capital)<>'') ;
		mapStock  := dedup(sort(distribute(ds_stock,hash(corp_key)),record,local),record,local) ;

		MapCorpRecs:= dedup(sort(distribute( mapDissolutions  + 
																				 mapCont 					+ 
																				 mapDBA 					+ 
																				 mapSubsidiaries  + 
																				 mapNamechanges
																				 ,hash(corp_key)
																				 ),
												record,local),record,local): independent;
												
		Corp2_Mapping.LayoutsCommon.Main legalNameFix_Trans(Corp2_Mapping.LayoutsCommon.Main  l):= transform
			
			self.corp_legal_name :=if(Corp2_Mapping.fSpecialChars(l.corp_legal_name)='FOUND', Corp2_Raw_WV.Functions.fix_ForeignChar(l.corp_legal_name), l.corp_legal_name);
			self								 :=l;
			
		end;
		
		legalNameFix          := project(MapCorpRecs, legalNameFix_Trans(left)) ;
		MapMain 							:= dedup(sort(distribute(legalNameFix,hash(corp_key)),record,local),record,local) : independent;		
																	 
		mapEvents	:= dedup(sort(distribute(mapEvent1 + 
																			 mapEvent2,hash(corp_key)
																			),
											 record,local),record,local): independent;

		mapAR     := dedup(sort(distribute(mapAR1 +
																			 mapAR2 ,hash(corp_key)
																			 ),
											 record,local),record,local): independent;

		//***********		MainFile Scrub										 		

		Main_F := mapMain;
		Main_S := Scrubs_Corp2_Mapping_WV_Main.Scrubs;					  // Scrubs module
		Main_N := Main_S.FromNone(Main_F); 										   // Generate the error flags
		Main_T := Main_S.FromBits(Main_N.BitMapInfile);     		// Use the FromBits module; makes my BitMap datafile easier to get to
		Main_U := Main_S.FromExpanded(Main_N.ExpandedInFile);  // Pass the expanded error flags into the Expanded module

		//Outputs reports
		Main_ErrorSummary					:= output(Main_U.SummaryStats, named('Main_ErrorSummary_WV_'+filedate));
		Main_ScrubErrorReport 		:= output(choosen(Main_U.AllErrors, 1000), named('Main_ScrubErrorReport_WV_'+filedate));
		Main_SomeErrorValues			:= output(choosen(Main_U.BadValues, 1000), named('Main_SomeErrorValues_WV_'+filedate));
		Main_IsScrubErrors		 		:= IF(count(Main_U.AllErrors)<> 0,true,false);

		// Orbit Stats
		Main_OrbitStats						:= Main_U.OrbitStats();

		//Outputs files
		Main_CreateBitMaps				:= output(Main_N.BitMapInfile,,'~thor_data::corp_WV_main_scrubs_bits',overwrite,compressed);	//long term storage
		Main_TranslateBitMap			:= output(Main_T);
		//Creates Profile's alert template for Orbit - can be copied and imported into Orbit; Only required if rules in Orbit change
		Main_AlertsCSVTemplate		:= Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_'+state_origin+'_Main','ScrubsAlerts', Main_OrbitStats, version,'Corp2_'+state_origin+'_Main').ProfileAlertsTemplate;
		//Submits Profile's stats to Orbit
		Main_SubmitStats 			  	:= Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_'+state_origin+'_Main','ScrubsAlerts', Main_OrbitStats, version,'Corp2_'+state_origin+'_Main').SubmitStats;
		Main_ScrubsWithExamples		:= Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_'+state_origin+'_Main','ScrubsAlerts', Main_OrbitStats, version,'Corp2_'+state_origin+'_Main').CompareToProfile_with_Examples;
	
		Main_ScrubsAlert					:= Main_ScrubsWithExamples(RejectWarning = 'Y');
		Main_ScrubsAttachment			:= Scrubs.fn_email_attachment(Main_ScrubsAlert);
		Main_SendEmailFile				:= FileServices.SendEmailAttachData( corp2.Email_Notification_Lists.spray
																																	 ,'Scrubs CorpMain_WV Report' 	//subject
																																	 ,'Scrubs CorpMain_WV Report' //body
																																	 ,(data)Main_ScrubsAttachment
																																	 ,'text/csv'
																																	 ,'CorpWVMainScrubsReport.csv'
																																	 ,
																																	 ,
																																	 ,corp2.Email_Notification_Lists.spray
																																 );

		Main_BadRecords		  := Main_N.ExpandedInFile(	dt_vendor_first_reported_Invalid 			<>0  or
																									dt_vendor_last_reported_Invalid 			<>0  or
																									dt_first_seen_Invalid 								<>0  or
																									dt_last_seen_Invalid 									<>0  or
																									corp_ra_dt_first_seen_Invalid 				<>0  or
																									corp_ra_dt_last_seen_Invalid 					<>0  or
																									corp_key_Invalid 											<>0  or
																									corp_vendor_Invalid 									<>0  or
																									corp_state_origin_Invalid 					 	<>0  or
																									corp_process_date_Invalid						  <>0  or
																									corp_orig_sos_charter_nbr_Invalid 		<>0  or
																									corp_legal_name_Invalid 							<>0  or
																									corp_inc_state_Invalid 								<>0  or
																									corp_orig_org_structure_cd_Invalid 	  <>0  or
																									corp_ln_name_type_cd_invalid					<>0  or
																									corp_forgn_state_cd_Invalid         	<>0  or
																									corp_forgn_state_desc_Invalid        	<>0  or
																									corp_inc_county_Invalid						  	<>0  or
																									corp_inc_date_Invalid						  		<>0  or
																									corp_foreign_domestic_ind_Invalid			<>0  or
																									corp_forgn_date_Invalid						  	<>0  or
																									corp_orig_org_structure_cd_Invalid		<>0  or
																									corp_orig_org_structure_desc_Invalid	<>0  or
																									corp_for_profit_ind_Invalid						<>0  or
																									corp_action_pending_cd_Invalid				<>0  or
																									corp_country_of_formation_Invalid			<>0  or
																									corp_termination_cd_Invalid						<>0  or
																									corp_termination_desc_Invalid					<>0  or
																									recordorigin_Invalid                  <>0  or
																									corp_Action_Pending_desc_Invalid			<>0
																						 );
																																									
		Main_GoodRecords		:=Main_N.ExpandedInFile(dt_vendor_first_reported_Invalid 			= 0 and
																								dt_vendor_last_reported_Invalid 			= 0 and
																								dt_first_seen_Invalid 								= 0 and
																								dt_last_seen_Invalid 									= 0 and
																								corp_ra_dt_first_seen_Invalid 				= 0 and
																								corp_ra_dt_last_seen_Invalid 					= 0 and
																								corp_key_Invalid 											= 0 and
																								corp_vendor_Invalid 									= 0 and
																								corp_state_origin_Invalid 					 	= 0 and
																								corp_process_date_Invalid						  = 0 and
																								corp_orig_sos_charter_nbr_Invalid 		= 0 and
																								corp_legal_name_Invalid 							= 0 and
																								corp_inc_state_Invalid 								= 0 and
																								corp_orig_org_structure_cd_Invalid 	  = 0 and
																								corp_ln_name_type_cd_invalid					= 0 and 
																								corp_forgn_state_cd_Invalid         	=	0 and
																								corp_forgn_state_desc_Invalid        	= 0 and
																								corp_inc_county_Invalid						  	= 0 and
																								corp_inc_date_Invalid						  		= 0 and
																								corp_foreign_domestic_ind_Invalid			= 0 and
																								corp_forgn_date_Invalid						  	= 0 and
																								corp_orig_org_structure_cd_Invalid		= 0 and
																								corp_orig_org_structure_desc_Invalid	= 0 and
																								corp_for_profit_ind_Invalid						= 0 and
																								corp_action_pending_cd_Invalid				= 0 and
																								corp_country_of_formation_Invalid			= 0 and
																								corp_termination_cd_Invalid						= 0 and
																								corp_termination_desc_Invalid					= 0 and
																								recordorigin_Invalid                  = 0 and
																								corp_Action_Pending_desc_Invalid			= 0
																					);

		Main_FailBuild	:= map( Corp2_Mapping.fCalcPercent(count(Main_N.ExpandedInFile(corp_key_invalid<>0)),count(Main_N.ExpandedInFile),false) 										> Scrubs_Corp2_Mapping_WV_Main.Threshold_Percent.CORP_KEY										   => true,
														Corp2_Mapping.fCalcPercent(count(Main_N.ExpandedInFile(corp_orig_sos_charter_nbr_invalid<>0)),count(Main_N.ExpandedInFile),false) 	> Scrubs_Corp2_Mapping_WV_Main.Threshold_Percent.CORP_ORIG_SOS_CHARTER_NBR 	   => true,
														Corp2_Mapping.fCalcPercent(count(Main_N.ExpandedInFile(corp_legal_name_invalid<>0)),count(Main_N.ExpandedInFile),false) 						> Scrubs_Corp2_Mapping_WV_Main.Threshold_Percent.CORP_LEGAL_NAME 						   => true,
														count(Main_GoodRecords) = 0																																																																																											 	 => true,																		
														false
													);
		Main_ApprovedRecords := project(Main_GoodRecords,transform(Corp2_Mapping.LayoutsCommon.Main,self := left));

		//==========================================VERSION CONTROL====================================================
		VersionControl.macBuildNewLogicalFile(Corp2_Mapping._dataset().thor_cluster_Files + 'in::corp2::'+version+'::main_' 	+ state_origin,Main_ApprovedRecords,corp_out,,,pOverwrite);
		VersionControl.macBuildNewLogicalFile(Corp2_Mapping._dataset().thor_cluster_Files + 'in::corp2::'+version+'::stock_' 	+ state_origin,mapStock 					 ,stock_out,,,pOverwrite);
		VersionControl.macBuildNewLogicalFile(Corp2_Mapping._dataset().thor_cluster_Files + 'in::corp2::'+version+'::Event_' 	+ state_origin,mapEvents					 ,Event_out,,,pOverwrite);
		VersionControl.macBuildNewLogicalFile(Corp2_Mapping._dataset().thor_cluster_Files + 'in::corp2::'+version+'::AR_' 		+ state_origin,mapAR 							 ,AR_out,,,pOverwrite);

		VersionControl.macBuildNewLogicalFile(Corp2_Mapping._dataset().thor_cluster_Files + 'fail::corp2::'+version+'::Main_' + state_origin		,Main_F	,write_fail_main  ,,,pOverwrite); 
		Main_RejFile_Exists		:=IF(FileServices.FileExists(Corp2_Mapping._dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::main_' + state_origin),true,false);			

		run_Main := sequential( IF( pshouldspray = TRUE,Corp2_Mapping.fSprayFiles( state_origin,version,pOverwrite := pOverwrite))
													  // ,Corp2_Raw_WV.Build_Bases(filedate,version,pUseProd).All  // Determined build bases is not needed
														,corp_out
														,ar_out
														,event_out
														,stock_out
														,IF( Main_FailBuild <> true
																 ,sequential( fileservices.addsuperfile(Corp2_Mapping._Dataset().thor_cluster_Files + 'in::'+Corp2_Mapping._Dataset().Namemapped+'::sprayed::main'  ,Corp2_Mapping._Dataset().thor_cluster_Files + 'in::corp2::'+version+'::main_' 	+ state_origin)
																						 ,fileservices.addsuperfile(Corp2_Mapping._Dataset().thor_cluster_Files + 'in::'+Corp2_Mapping._Dataset().Namemapped+'::sprayed::ar'	  ,Corp2_Mapping._Dataset().thor_cluster_Files + 'in::corp2::'+version+'::ar_' 	  + state_origin)
																						 ,fileservices.addsuperfile(Corp2_Mapping._Dataset().thor_cluster_Files + 'in::'+Corp2_Mapping._Dataset().Namemapped+'::sprayed::event' ,Corp2_Mapping._Dataset().thor_cluster_Files + 'in::corp2::'+version+'::event_' + state_origin)
																						 ,fileservices.addsuperfile(Corp2_Mapping._Dataset().thor_cluster_Files + 'in::'+Corp2_Mapping._Dataset().Namemapped+'::sprayed::stock' ,Corp2_Mapping._Dataset().thor_cluster_Files + 'in::corp2::'+version+'::stock_' + state_origin)
																						 ,IF ( count(Main_BadRecords) <> 0
																									,Corp2_Mapping.Send_Email( state_origin,version,count(Main_BadRecords)<>0,,,,count(Main_BadRecords),,,,count(Main_ApprovedRecords),count(mapAR),count(mapEvents),count(mapStock)).RecordsRejected																				 
																									,Corp2_Mapping.Send_Email( state_origin,version,count(Main_BadRecords)<>0,,,,count(Main_BadRecords),,,,count(Main_ApprovedRecords),count(mapAR),count(mapEvents),count(mapStock)).mappingSuccess		
																									)
																						 )   
																	,sequential( write_fail_main
																							,Corp2_Mapping.Send_Email( state_origin,version).mappingFailed
																						 )
																)
															,sequential(IF(count(Main_BadRecords) <> 0
																							,IF (poverwrite
																									 ,OUTPUT(Main_BadRecords,,Corp2_Mapping._Dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::main_' 	+ state_origin,overwrite,__compressed__,named('Sample_Rejected_Recs_WV_'+filedate))
																									 ,sequential (IF(Main_RejFile_Exists,fileservices.deletelogicalfile(Corp2_Mapping._dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::main_'+ state_origin)),
																																	OUTPUT(Main_BadRecords,,Corp2_Mapping._Dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::main_'+ state_origin,__compressed__,named('Sample_Rejected_MainRecs_WV_'+filedate))
																																 )
																										)
																						 )
																				 ,IF(Main_IsScrubErrors
																						 ,Corp2_Mapping.Send_Email(state_origin,version,Main_IsScrubErrors,false,false,false).FieldsInvalidPerScrubs																				 
																						 )	
																				,IF(COUNT(Main_ScrubsAlert) > 0, 	Main_SendEmailFile, OUTPUT('Corp2_Mapping.'+state_origin+'  - No Corp Scrubs Alerts'))		
																				,output(Main_ScrubsWithExamples, ALL, NAMED('CorpMainWVScrubsReportWithExamples'+filedate)) //Send Alerts if Scrubs exceeds thresholds
																				,Main_ErrorSummary
																				,Main_ScrubErrorReport																					
																				,Main_SomeErrorValues
																				//,Main_AlertsCSVTemplate
																				,Main_SubmitStats																
																			 )
											);
											
		//Validating the filedate entered is within 30 days										 
		isFileDateValid := if((string)Std.Date.Today() between ut.date_math(filedate,-30) and ut.date_math(filedate,30),true,false);
		result		 			:= if(isFileDateValid
													,run_Main 
													,sequential(Corp2_Mapping.Send_Email( state_origin,filedate).InvalidFileDateParm
																			,FAIL('Corp2_Mapping.'+state_origin+' failed. An invalid filedate was passed in as a parameter.')
																			)
												);

		return result;
		
	end;

end;