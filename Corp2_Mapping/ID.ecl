Import Corp2, VersionControl, ut, Corp2_Raw_id, Scrubs_Corp2_Mapping_ID_Main, Scrubs, Tools, Std;

Export ID := MODULE;

	Export Update(string fileDate, string version, boolean pShouldSpray = _Dataset().bShouldSpray, boolean pOverwrite = false, pUseProd = Tools._Constants.IsDataland) :=Function
		
		state_origin	:='ID';
		state_fips	 	:='16';	
		state_desc	 	:='IDAHO';
		
		Filings	      := dedup(sort(distribute(Corp2_Raw_ID.Files(filedate,pUseProd).input.Filing.logical,hash(control_no)),record,local),record,local)      	: independent; 
		FilingNames   := dedup(sort(distribute(Corp2_Raw_ID.Files(filedate,pUseProd).input.FilingName.logical,hash(control_no)),record,local),record,local)   : independent; 
		Parties	      := dedup(sort(distribute(Corp2_Raw_ID.Files(filedate,pUseProd).input.Party.logical,hash(control_no)),record,local),record,local)      	: independent; 
															
		//********************************************************************
		// Map CorpFile to MAIN
		//********************************************************************													
		CorpFile		  := join(Filings, Parties,
														corp2.t2u(left.control_no) = corp2.t2u(right.control_no),
														transform(Corp2_Raw_ID.Layouts.Temp_Filing_Party,
														self := left;	self := right; ),
														left outer,	local ) : independent;	
															
		Corp2_Mapping.LayoutsCommon.Main corpTransform(Corp2_Raw_ID.Layouts.Temp_Filing_Party l,integer ctr) := transform
			self.dt_vendor_first_reported			 := (integer)fileDate;
			self.dt_vendor_last_reported			 := (integer)fileDate;
			self.dt_first_seen								 := (integer)fileDate;
			self.dt_last_seen									 := (integer)fileDate;
			self.corp_ra_dt_first_seen				 := (integer)fileDate;
			self.corp_ra_dt_last_seen					 := (integer)fileDate;				
			self.corp_process_date						 := fileDate;			
			self.corp_key											 := state_fips + '-' + corp2.t2u(l.control_no);
			self.corp_vendor									 := state_fips;
			self.corp_state_origin						 := state_origin;
			self.corp_inc_state  					 		 := state_origin; 
			self.corp_orig_sos_charter_nbr		 := corp2.t2u(l.control_no);	
			self.corp_legal_name							 := Corp2_Mapping.fCleanBusinessName(state_origin,state_desc,l.filing_name).BusinessName;														
			self.corp_term_exist_cd            := if(corp2.t2u(l.duration_type) = 'PERPETUAL', 'P', '');
			self.corp_term_exist_desc          := if(corp2.t2u(l.duration_type) = 'PERPETUAL', 'PERPETUAL', ''); 
			self.corp_ln_name_type_cd					 := corp2_Raw_ID.Functions.NameTyp_CD(l.Filing_Type);	
			self.corp_ln_name_type_desc				 := corp2_Raw_ID.Functions.NameTyp_Desc(l.Filing_Type);		
		  self.corp_orig_org_structure_desc  := Corp2_Raw_ID.Functions.org_structure(l.Filing_Type);	
			self.corp_for_profit_ind      		 := corp2_Raw_ID.Functions.For_Profit(l.Filing_Type);
			self.corp_status_desc							 := corp2.t2u(l.status);
			self.corp_standing                 := if(corp2.t2u(l.status) = 'ACTIVE-GOOD STANDING' ,'Y', '');
			self.corp_orig_bus_type_desc			 := if(corp2.t2u(l.business_type) <> 'SEE IMAGE', corp2.t2u(l.business_type), '');
			Dom_or_For := corp2_Raw_ID.Functions.For_or_Dom(l.Filing_Type);
			self.corp_inc_date					  		 := if(Dom_or_For = 'D' ,Corp2_Mapping.fValidateDate(l.filing_date,'MM/DD/CCYY').PastDate,'');
			self.corp_forgn_date				  		 := if(Dom_or_For = 'F' ,Corp2_Mapping.fValidateDate(l.filing_date,'MM/DD/CCYY').PastDate,'');
		  self.corp_foreign_domestic_ind		 := Dom_or_For;
  		self.corp_forgn_state_cd    			 := if(corp2.t2u(l.formation_locale)not in [ state_desc ,''],Corp2_Raw_ID.Functions.StateCode(l.formation_locale), '');
			self.corp_forgn_state_desc    		 := if(corp2.t2u(l.formation_locale)not in [ state_desc ,''],Corp2_Raw_ID.Functions.StateDesc(l.formation_locale), '');
			self.corp_name_reservation_expiration_date := if(corp2.t2u(l.Filing_Type) = 'RESERVATION OF LEGAL ENTITY NAME'
			                                                ,Corp2_Mapping.fValidateDate(l.expiration_date,'MM/DD/CCYY').GeneralDate ,'');
			self.corp_status_date							 := Corp2_Mapping.fValidateDate(l.inactive_date,'MM/DD/CCYY').PastDate;
			self.corp_management_desc          := if(corp2.t2u(l.managed_by_type) not in['N','USA','UNITED STATES'] ,corp2.t2u(l.managed_by_type) ,'');
	    self.corp_public_mutual_corporation := if(corp2.t2u(l.public_benefit_yn) = 'Y' ,'PUBLIC BEN' ,'');	// field is only length of 10 so truncated to "PUBLIC BEN"		
			self.corp_fiscal_year_month        := if(Corp2_Mapping.fValidateDate(l.fiscal_year_close_month,'MM/DD/CCYY').PastDate <> ''
			                                         ,case(l.fiscal_year_close_month[1..2],
																							       '01' => 'JANUARY',		'02' => 'FEBRUARY',	'03' => 'MARCH',			
																										 '04' => 'APRIL',		  '05' => 'MAY',		  '06' => 'JUNE',
																										 '07' => 'JULY',      '08' => 'AUGUST', 	'09' => 'SEPT',      
																										 '10' => 'OCTOBER',   '11' => 'NOVEMBER', '12' => 'DECEMBER', '')
																								,'');
			temp_prin_country := if(Corp2_Raw_ID.Functions.CountryDesc(l.principle_country)[1..2]<> '**',Corp2_Raw_ID.Functions.CountryDesc(l.principle_country),'');
			prin3             := if(corp2.t2u(stringlib.stringfilter(l.principle_addr3,'0123456789')) = '' ,'' ,l.principle_addr3);
			self.corp_address1_line1						:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.principle_addr1,corp2.t2u(l.principle_addr2 + ' ' + prin3),l.principle_city,l.principle_state,l.principle_postal_code).AddressLine1;
			self.corp_address1_line2						:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.principle_addr1,corp2.t2u(l.principle_addr2 + ' ' + prin3),l.principle_city,l.principle_state,l.principle_postal_code).AddressLine2;
			self.corp_address1_line3						:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.principle_addr1,corp2.t2u(l.principle_addr2 + ' ' + prin3),l.principle_city,l.principle_state,l.principle_postal_code,temp_prin_country).AddressLine3;
			self.corp_prep_addr1_line1					:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.principle_addr1,corp2.t2u(l.principle_addr2 + ' ' + prin3),l.principle_city,l.principle_state,l.principle_postal_code,temp_prin_country).PrepAddrLine1;
			self.corp_prep_addr1_last_line			:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.principle_addr1,corp2.t2u(l.principle_addr2 + ' ' + prin3),l.principle_city,l.principle_state,l.principle_postal_code,temp_prin_country).PrepAddrLastLine;
			self.corp_address1_type_cd     			:= if(Corp2_Mapping.fAddressExists(state_origin,state_desc,l.principle_addr1,corp2.t2u(l.principle_addr2 + ' ' + prin3),l.principle_city,l.principle_state,l.principle_postal_code,temp_prin_country).ifAddressExists, 'B','');
			self.corp_address1_type_desc   			:= if(self.corp_address1_type_cd = 'B' ,'BUSINESS' ,'');
			temp_mail_country := if(Corp2_Raw_ID.Functions.CountryDesc(l.mail_country)[1..2]<> '**',Corp2_Raw_ID.Functions.CountryDesc(l.mail_country),'');
			mail3             := if(corp2.t2u(stringlib.stringfilter(l.mail_addr3,'0123456789')) = '' ,'' ,l.mail_addr3);
			self.corp_address2_line1						:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.mail_addr1,corp2.t2u(l.mail_addr2 + ' ' + mail3),l.mail_city,l.mail_state,l.mail_postal_code).AddressLine1;
			self.corp_address2_line2						:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.mail_addr1,corp2.t2u(l.mail_addr2 + ' ' + mail3),l.mail_city,l.mail_state,l.mail_postal_code).AddressLine2;
			self.corp_address2_line3						:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.mail_addr1,corp2.t2u(l.mail_addr2 + ' ' + mail3),l.mail_city,l.mail_state,l.mail_postal_code,temp_mail_country).AddressLine3;
			self.corp_prep_addr2_line1					:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.mail_addr1,corp2.t2u(l.mail_addr2 + ' ' + mail3),l.mail_city,l.mail_state,l.mail_postal_code,temp_mail_country).PrepAddrLine1;
			self.corp_prep_addr2_last_line			:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.mail_addr1,corp2.t2u(l.mail_addr2 + ' ' + mail3),l.mail_city,l.mail_state,l.mail_postal_code,temp_mail_country).PrepAddrLastLine;
			self.corp_address2_type_cd     			:= if(Corp2_Mapping.fAddressExists(state_origin,state_desc,l.mail_addr1,corp2.t2u(l.mail_addr2 + ' ' + mail3),l.mail_city,l.mail_state,l.mail_postal_code,temp_mail_country).ifAddressExists,	'M','');
			self.corp_address2_type_desc   			:= if(self.corp_address2_type_cd = 'M' ,'MAILING' ,'');
			self.corp_ra_full_name						  := choose(ctr, Corp2_Mapping.fCleanBusinessName(state_origin ,state_desc,corp2.t2u(l.first_name+' '+l.middle_name+' '+l.last_name)).BusinessName
			                                                 , Corp2_Mapping.fCleanBusinessName(state_origin ,state_desc,l.org_name).BusinessName);													   
			temp_country := if(Corp2_Raw_ID.Functions.CountryDesc(l.country)[1..2]<> '**',Corp2_Raw_ID.Functions.CountryDesc(l.country),'');
			temp_addr1   := if(corp2.t2u(l.addr1) in ['AGENT RESIGNED','INVALID'] ,'' ,l.addr1);
			self.corp_ra_address_line1					:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,temp_addr1,l.addr2,l.city,l.state,l.postal_code).AddressLine1;
			self.corp_ra_address_line2					:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,temp_addr1,l.addr2,l.city,l.state,l.postal_code).AddressLine2;
			self.corp_ra_address_line3					:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,temp_addr1,l.addr2,l.city,l.state,l.postal_code,temp_country).AddressLine3;
			self.ra_prep_addr_line1					    := Corp2_Mapping.fCleanAddress(state_origin,state_desc,temp_addr1,l.addr2,l.city,l.state,l.postal_code,temp_country).PrepAddrLine1;
			self.ra_prep_addr_last_line	        := Corp2_Mapping.fCleanAddress(state_origin,state_desc,temp_addr1,l.addr2,l.city,l.state,l.postal_code,temp_country).PrepAddrLastLine;
			self.corp_ra_address_type_cd     		:= if(Corp2_Mapping.fAddressExists(state_origin,state_desc,temp_addr1,l.addr2,l.city,l.state,l.postal_code,temp_country).ifAddressExists,	'R','');
			self.corp_ra_address_type_desc   		:= if(self.corp_ra_address_type_cd = 'R' ,'REGISTERED OFFICE' ,'');
			self.corp_agent_country             := temp_country;
			self.corp_agent_county              := corp2.t2u(l.county);
			self.InternalField1									:= Corp2_Raw_ID.Functions.CountryDesc(l.principle_country); //principle_country is being mapped for "corp_address1_line3", new vendor values will be caught through scrubs
			self.InternalField2									:= Corp2_Raw_ID.Functions.CountryDesc(l.mail_country);      //mail_country is being mapped for "corp_address2_line3", new vendor values will be caught through scrubs
			self.InternalField3                 := Corp2_Raw_ID.Functions.CountryDesc(l.country);           //country is being mapped for "corp_ra_address_line3", new vendor values will be caught through scrubs
			self.recordorigin										:= 'C';		
			self 																:= [];
						
		end; 

		MapCorp := Normalize(CorpFile, if(corp2.t2u(left.org_name)not in ['','NO AGENT'], 2, 1), 
														 corpTransform(left, counter));
		
		//********************************************************************
		//Map "Assumed Name" data to MAIN
		//********************************************************************	
		jAssumedName 		:= join(FilingNames, Filings,
															corp2.t2u(left.control_no) = corp2.t2u(right.control_no),
															transform(Corp2_Raw_ID.Layouts.Temp_FilingNames,
													    self := left;	self := right; ),
															left outer,	local ) : independent;		
		
		Corp2_mapping.LayoutsCommon.Main CorpTransform02(Corp2_Raw_ID.Layouts.Temp_FilingNames l) := transform
		     ,skip(corp2.t2u(l.Name_Type) not in ['ASSUMED NAME','FOREIGN NAME'])
			self.dt_vendor_first_reported						:= (integer)fileDate;
			self.dt_vendor_last_reported						:= (integer)fileDate;
			self.dt_first_seen											:= (integer)fileDate;
			self.dt_last_seen												:= (integer)fileDate;
			self.corp_ra_dt_first_seen							:= (integer)fileDate;
			self.corp_ra_dt_last_seen								:= (integer)fileDate;
			self.corp_key														:= state_fips +'-' + corp2.t2u(l.control_no);
			self.corp_vendor 												:= state_fips;
			self.corp_state_origin 									:= state_origin;
			self.corp_process_date 									:= fileDate;
			self.corp_orig_sos_charter_nbr 					:= corp2.t2u(l.control_no);
			self.corp_legal_name 										:= Corp2_Mapping.fCleanBusinessName(state_origin,state_desc,l.Name).BusinessName;
			self.corp_ln_name_type_cd             	:= case(corp2.t2u(l.name_type), 'FOREIGN NAME'=>'F', 'ASSUMED NAME'=>'06', '');
			self.corp_ln_name_type_desc           	:= case(corp2.t2u(l.name_type), 'FOREIGN NAME'=>'FOREIGN NAME', 'ASSUMED NAME'=>'ASSUMED', '');
      self.corp_inc_state                   	:= state_origin;
			self.corp_home_state_name								:= if(corp2.t2u(l.name_type) = 'FOREIGN NAME', self.corp_legal_name, '');
			Dom_or_For := corp2_Raw_ID.Functions.For_or_Dom(l.Filing_Type);
			self.corp_inc_date					  				 	:= if(Dom_or_For = 'D' ,Corp2_Mapping.fValidateDate(l.filing_date,'MM/DD/CCYY').PastDate,'');
			self.corp_forgn_date				  					:= if(Dom_or_For = 'F' ,Corp2_Mapping.fValidateDate(l.filing_date,'MM/DD/CCYY').PastDate,'');
			self.recordorigin												:= 'C';			
		  self   		                         			:= [];		
		end;
		
		MapAssumedNames	:= project(jAssumedName,CorpTransform02(left));
		
		MapMain 				:= dedup(sort(distribute(MapCorp + MapAssumedNames,hash(corp_key)),record,local),record,local) : independent;

		//********************************************************************
		// Map AR records
		//********************************************************************	
		Corp2_mapping.LayoutsCommon.AR ARTrf(Corp2_Raw_ID.Layouts.FilingLayoutIn l) := transform
		   ,skip(corp2.t2u(l.control_no) = '' or 
		        (Corp2_Mapping.fValidateDate(l.ar_due_date,'MM/DD/CCYY').GeneralDate + corp2.t2u(l.ar_exempt_yn) = ''))	
			self.corp_key													:= state_fips +'-' + corp2.t2u(l.control_no);
			self.corp_vendor 											:= state_fips;
			self.corp_state_origin 								:= state_origin;
			self.corp_process_date 								:= fileDate;
			self.corp_sos_charter_nbr 						:= corp2.t2u(l.control_no);			
			self.ar_due_dt                   			:= Corp2_Mapping.fValidateDate(l.ar_due_date,'MM/DD/CCYY').GeneralDate;
			self.ar_exempt												:= if(corp2.t2u(l.ar_exempt_yn) in ['Y','N'],corp2.t2u(l.ar_exempt_yn),'');
		  //This is an overloaded field until ar_exempt is customer facing.
			self.ar_comment                 			:= if(self.ar_exempt <> '','ANNUAL REPORT EXEMPT: ' + self.ar_exempt,'');
			self                            			:= [];
		end;
   
		MapAR   := dedup(sort(distribute(project(Filings,ARTrf(left)),hash(corp_key)),record,local),record,local) : independent;
														
		//********************************************************************
		// Map Stock records
		//********************************************************************	
		Corp2_mapping.LayoutsCommon.Stock StockTrf(Corp2_Raw_ID.Layouts.FilingLayoutIn l) := transform
		   ,skip(corp2.t2u(l.control_no) = '' or (string)(integer)corp2.t2u(l.common_shares)='0')
			self.corp_key													:= state_fips +'-' + corp2.t2u(l.control_no);
			self.corp_vendor 											:= state_fips;
			self.corp_state_origin 								:= state_origin;
			self.corp_process_date 								:= fileDate;
			self.corp_sos_charter_nbr 						:= corp2.t2u(l.control_no);			
			self.stock_shares_issued         			:= (string)(integer)corp2.t2u(l.common_shares);
			self                            			:= [];
		end;

		MapStock  := dedup(sort(distribute(project(Filings,StockTrf(left)),hash(corp_key)),record,local),record,local) : independent;

		
		//***********		MainFile Scrub Logic												 		
					
		Main_F := MapMain;
		Main_S := Scrubs_Corp2_Mapping_ID_Main.Scrubs;					  // Scrubs module
		Main_N := Main_S.FromNone(Main_F); 										   // Generate the error flags
		Main_T := Main_S.FromBits(Main_N.BitmapInfile);     		// Use the FromBits module; makes my bitmap datafile easier to get to
		Main_U := Main_S.FromExpanded(Main_N.ExpandedInFile);  // Pass the expanded error flags into the Expanded module

		//Outputs reports
		Main_ErrorSummary					:= output(Main_U.SummaryStats, named('Main_ErrorSummary_ID'+filedate));
		Main_ScrubErrorReport 		:= output(choosen(Main_U.AllErrors, 1000), named('Main_ScrubErrorReport_ID'+filedate));
		Main_SomeErrorValues			:= output(choosen(Main_U.BadValues, 1000), named('Main_SomeErrorValues_ID'+filedate));
		Main_IsScrubErrors		 		:= IF(count(Main_U.AllErrors)<> 0,true,false);   
		// Orbit Stats
		Main_OrbitStats						:= Main_U.OrbitStats();   
		//Outputs files
		Main_CreateBitMaps				:= output(Main_N.BitmapInfile,,'~thor_data::corp_ID_main_scrubs_bits',overwrite,compressed);	//long term storage
		Main_TranslateBitMap			:= output(Main_T);
		//Creates Profile's alert template for Orbit - can be copied and imported into Orbit; Only required if rules in Orbit change
		Main_AlertsCSVTemplate		:= Scrubs.OrbitProfileStatsPost310('Scrubs_Corp2_Mapping_'+state_origin+'_Main','ScrubsAlerts', Main_OrbitStats, version,'Corp2_'+state_origin+'_Main').ProfileAlertsTemplate;
		//Submits Profile's stats to Orbit
		Main_SubmitStats 			  	:= Scrubs.OrbitProfileStatsPost310('Scrubs_Corp2_Mapping_'+state_origin+'_Main','ScrubsAlerts', Main_OrbitStats, version,'Corp2_'+state_origin+'_Main').SubmitStats;
		Main_ScrubsWithExamples		:= Scrubs.OrbitProfileStatsPost310('Scrubs_Corp2_Mapping_'+state_origin+'_Main','ScrubsAlerts', Main_OrbitStats, version,'Corp2_'+state_origin+'_Main').CompareToProfile_with_Examples;
	
		Main_ScrubsAlert					:= Main_ScrubsWithExamples(RejectWarning = 'Y');
		Main_ScrubsAttachment			:= Scrubs.fn_email_attachment(Main_ScrubsAlert);
		Main_SendEmailFile				:= FileServices.SendEmailAttachData( corp2.Email_Notification_Lists.spray
																																	 ,'Scrubs CorpMain_ID Report' 	//subject
																																	 ,'Scrubs CorpMain_ID Report'  //body
																																	 ,(data)Main_ScrubsAttachment
																																	 ,'text/csv'
																																	 ,'CorpIDMainScrubsReport.csv'
																																	 ,
																																	 ,
																																	 ,corp2.Email_Notification_Lists.spray
																																 );

				Main_BadRecords		  := Main_N.ExpandedInFile(dt_vendor_first_reported_Invalid 		         <> 0 or
																										 dt_vendor_last_reported_Invalid 			         <> 0 or
																										 dt_first_seen_Invalid 								         <> 0 or
																										 dt_last_seen_Invalid 								         <> 0 or
																										 corp_ra_dt_first_seen_Invalid 				         <> 0 or
																										 corp_ra_dt_last_seen_Invalid 				         <> 0 or
																										 corp_key_Invalid 										         <> 0 or
																										 corp_vendor_Invalid 									         <> 0 or
																										 corp_state_origin_Invalid 						         <> 0 or
																										 corp_process_date_Invalid 						         <> 0 or
																										 corp_orig_sos_charter_nbr_Invalid 		         <> 0 or
																										 corp_legal_name_Invalid 							         <> 0 or
																										 corp_ln_name_type_cd_Invalid 				         <> 0 or
																										 corp_ln_name_type_desc_Invalid 			         <> 0 or
																										 corp_status_desc_Invalid 						         <> 0 or
																										 corp_status_date_Invalid 						         <> 0 or
																										 corp_inc_state_Invalid 							         <> 0 or
																										 corp_inc_date_Invalid 								         <> 0 or
																										 corp_foreign_domestic_ind_Invalid 		         <> 0 or
																										 corp_forgn_state_desc_Invalid 				         <> 0 or
																										 corp_forgn_date_Invalid 							         <> 0 or
																										 corp_term_exist_cd_Invalid                    <> 0 or
																										 corp_term_exist_desc_Invalid                  <> 0 or
																										 corp_orig_org_structure_desc_Invalid          <> 0 or
																										 corp_for_profit_ind_Invalid 					         <> 0 or
																										 corp_name_reservation_expiration_date_Invalid <> 0 or
																										 corp_orig_bus_type_desc_Invalid               <> 0 or
																										 corp_management_desc_Invalid                  <> 0 or
																										 corp_fiscal_year_month_Invalid                <> 0 or
																										 corp_agent_county_Invalid                     <> 0 or
																										 InternalField1_Invalid 							         <> 0 or
																										 InternalField2_Invalid 							         <> 0 or
																										 InternalField3_Invalid                        <> 0 or
																										 recordorigin_Invalid 								         <> 0
																								 );
																																											
		Main_GoodRecords		:=Main_N.ExpandedInFile(     dt_vendor_first_reported_Invalid 		         = 0 and
																										 dt_vendor_last_reported_Invalid 			         = 0 and
																										 dt_first_seen_Invalid 								         = 0 and
																										 dt_last_seen_Invalid 								         = 0 and
																										 corp_ra_dt_first_seen_Invalid 				         = 0 and
																										 corp_ra_dt_last_seen_Invalid 				         = 0 and
																										 corp_key_Invalid 										         = 0 and
																										 corp_vendor_Invalid 									         = 0 and
																										 corp_state_origin_Invalid 						         = 0 and
																										 corp_process_date_Invalid 						         = 0 and
																										 corp_orig_sos_charter_nbr_Invalid 		         = 0 and
																										 corp_legal_name_Invalid 							         = 0 and
																										 corp_ln_name_type_cd_Invalid 				         = 0 and
																										 corp_ln_name_type_desc_Invalid 			         = 0 and
																										 corp_status_desc_Invalid 						         = 0 and
																										 corp_status_date_Invalid 						         = 0 and
																										 corp_inc_state_Invalid 							         = 0 and
																										 corp_inc_date_Invalid 								         = 0 and
																										 corp_foreign_domestic_ind_Invalid 		         = 0 and
																										 corp_forgn_state_desc_Invalid 				         = 0 and
																										 corp_forgn_date_Invalid 							         = 0 and
																										 corp_term_exist_cd_Invalid                    = 0 and
																										 corp_term_exist_desc_Invalid                  = 0 and
																										 corp_orig_org_structure_desc_Invalid          = 0 and
																										 corp_for_profit_ind_Invalid 					         = 0 and
																										 corp_name_reservation_expiration_date_Invalid = 0 and
																										 corp_orig_bus_type_desc_Invalid               = 0 and
																										 corp_management_desc_Invalid                  = 0 and
																										 corp_fiscal_year_month_Invalid                = 0 and
																										 corp_agent_county_Invalid                     = 0 and
																										 InternalField1_Invalid 							         = 0 and
																										 InternalField2_Invalid 							         = 0 and
																										 InternalField3_Invalid                        = 0 and
																										 recordorigin_Invalid 								         = 0
																						 );
			
			Main_FailBuild	:= map( Corp2_Mapping.fCalcPercent (count(Main_N.ExpandedInFile(corp_key_invalid<>0)),count(Main_N.ExpandedInFile),false) 									 > Scrubs_Corp2_Mapping_ID_Main.Threshold_Percent.CORP_KEY										   => true,
															Corp2_Mapping.fCalcPercent (count(Main_N.ExpandedInFile(corp_orig_sos_charter_nbr_invalid<>0)),count(Main_N.ExpandedInFile),false) 	 > Scrubs_Corp2_Mapping_ID_Main.Threshold_Percent.CORP_ORIG_SOS_CHARTER_NBR 	   => true,
															Corp2_Mapping.fCalcPercent (count(Main_N.ExpandedInFile(corp_legal_name_invalid<>0)),count(Main_N.ExpandedInFile),false) 						 > Scrubs_Corp2_Mapping_ID_Main.Threshold_Percent.CORP_LEGAL_NAME 						   => true,
															count(Main_GoodRecords) = 0																																																																																											 => true,																		
															false
														);

		Main_ApprovedRecords := project(Main_GoodRecords,transform(Corp2_Mapping.LayoutsCommon.Main,self := left));
	
		Main_RejFile_Exists		:= IF(FileServices.FileExists(Corp2_Mapping._dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::main_' + state_origin),true,false);			
	  Main_ALL		 					:= sequential(IF(count(Main_BadRecords) <> 0
																					,IF (poverwrite
																							,OUTPUT(Main_BadRecords,,Corp2_Mapping._Dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::main_ID',overwrite,__compressed__,named('Sample_Rejected_MainRecs_ID'+filedate))
																							,sequential (IF(Main_RejFile_Exists,fileservices.deletelogicalfile(Corp2_Mapping._dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::main_'+ state_origin)),
																													 OUTPUT(Main_BadRecords,,Corp2_Mapping._Dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::main_'+ state_origin,__compressed__,named('Sample_Rejected_MainRecs_ID'+filedate)))))
																		,output(Main_ScrubsWithExamples, ALL, NAMED('CorpMainIDScrubsReportWithExamples'+filedate))																		
																		//Send Alerts if Scrubs exceeds thresholds
																		,IF(COUNT(Main_ScrubsAlert) > 0, Main_SendEmailFile, OUTPUT('CORP2_MAPPING.IDT - No "MAIN" Corp Scrubs Alerts'))
																		,Main_ErrorSummary
																		,Main_ScrubErrorReport
																		,Main_SomeErrorValues
																		,Main_SubmitStats);
			
  //-------------------- Version Control -----------------------------------------------------//	
	VersionControl.macBuildNewLogicalFile('~thor_data400::in::corp2::'+version+'::main_id'			,Main_ApprovedRecords ,main_out		     ,,,pOverwrite);		
	VersionControl.macBuildNewLogicalFile('~thor_data400::in::corp2::'+version+'::stock_id'			,MapStock	            ,stock_out	     ,,,pOverwrite);
	VersionControl.macBuildNewLogicalFile('~thor_data400::in::corp2::'+version+'::ar_id'				,MapAR		            ,ar_out			     ,,,pOverwrite);
	
	VersionControl.macBuildNewLogicalFile('~thor_data400::failed::corp2::'+version+'::main_id'	,MapMain              ,write_fail_main ,,,pOverwrite);		
		
	mapID:= sequential(   if(pshouldspray = true,Corp2_mapping.fSprayFiles(state_origin ,version,pOverwrite := pOverwrite))
												,main_out
												,ar_out
												,stock_out										
												,IF(Main_FailBuild <> true
														,sequential( fileservices.addsuperfile(Corp2_Mapping._Dataset().thor_cluster_Files + 'in::'+Corp2_Mapping._Dataset().NameMapped+'::sprayed::ar'		,Corp2_Mapping._Dataset().thor_cluster_Files + 'in::corp2::'+version+'::ar_ID')
																				,fileservices.addsuperfile(Corp2_Mapping._Dataset().thor_cluster_Files + 'in::'+Corp2_Mapping._Dataset().NameMapped+'::sprayed::main'	,Corp2_Mapping._Dataset().thor_cluster_Files + 'in::corp2::'+version+'::main_ID')																		 
																				,fileservices.addsuperfile(Corp2_Mapping._Dataset().thor_cluster_Files + 'in::'+Corp2_Mapping._Dataset().NameMapped+'::sprayed::stock',Corp2_Mapping._Dataset().thor_cluster_Files + 'in::corp2::'+version+'::stock_ID')
																				,if (count(Main_BadRecords) <> 0 
																						 ,Corp2_Mapping.Send_Email(state_origin ,version,count(Main_BadRecords)<>0,,,,count(Main_BadRecords),,,,count(Main_ApprovedRecords),count(mapAR),,count(mapStock)).RecordsRejected																				 
																						 ,Corp2_Mapping.Send_Email(state_origin ,version,count(Main_BadRecords)<>0,,,,count(Main_BadRecords),,,,count(Main_ApprovedRecords),count(mapAR),,count(mapStock)).MappingSuccess																				 
																						 )	 
																			)
														 ,sequential( write_fail_main//if it fails on  main file threshold ,still writing mapped files!
																				 ,Corp2_Mapping.Send_Email(state_origin ,version).MappingFailed
																				)
													)
												,if (Main_IsScrubErrors
														,Corp2_Mapping.Send_Email(state_origin ,version,Main_IsScrubErrors).FieldsInvalidPerScrubs)
												,Main_All	
										);
															
 		isFileDateValid := if((string)Std.Date.Today() between ut.date_math(filedate,-31) and ut.date_math(filedate,31),true,false);
		return sequential (if (isFileDateValid
														,mapID
														,sequential (Corp2_Mapping.Send_Email(state_origin,filedate).InvalidFileDateParm
																				,FAIL('Corp2_Mapping.ID failed.  An invalid filedate was passed in as a parameter.')))); 	

 End; //Update Function

End;//End ID Module