Import _Control, Corp2, Corp2_Raw_SD, lib_stringlib, Scrubs, Scrubs_Corp2_Mapping_SD_Main, Scrubs_Corp2_Mapping_SD_Event, Tools, UT, VersionControl, std;

Export SD	:= Module
	
 Export Update(String filedate, string version, boolean pShouldSpray = Corp2_mapping._Dataset().bShouldSpray, boolean pOverwrite = false,pUseProd = Tools._Constants.IsDataland) := Function
		
	state_origin				:= 'SD' ;
	state_fips	 				:= '46';
	state_desc	 				:= 'SOUTH DAKOTA';	
	ds_vendor_mainFile	:= dedup(sort(distribute(Corp2_Raw_SD.Files(filedate,pUseProd).Input.ds_vendor_rawMain,hash(org_corporate_id)),record,local),record,local):independent; 
	ds_vendor_amendFile := dedup(sort(distribute(Corp2_Raw_SD.Files(filedate,pUseProd).Input.vendor_amend.logical,hash(org_corporate_id)),record,local),record,local):independent; 
	ds_vendor_arFile    := dedup(sort(distribute(Corp2_Raw_SD.Files(filedate,pUseProd).Input.vendor_ar.logical,hash(org_corporate_id)),record,local),record,local):independent; 

	Corp2_Mapping.LayoutsCommon.Main SD_corpTransform(Corp2_Raw_SD.Layouts.vendor_mainLayout L, integer ctr):=	transform

		foreign_list												:= ['FA','FB','FC','FF','FG','FL','FM','FN','FP','FR','FT','RG'];
		domestic_list												:= ['BK','BL','CH','CI','CO','DA','DB','DF','DL','DM','DP','DR',
																						'DT','EM','FD','FK','GP','ID','IN','MP','NS','PF','PU','RA',
																						'RD','RL','RN','RP','RS','SD','SG','TD','UB','WD'];
	 legal_list														:= ['BK','BL','CH','CI','CO','DA','DB','DF',
																						'DL','DM','DP','DR','DT','EM','FA','FB',
																						'FC','FD','FF','FG','FK','FL','FM','FN','FP',
																						'FR','FT','GP','ID','IN','MP','NS','PF',
																						'PU','RA','RD','SD','SG','TD','WD'];																											
		corporateID_Type 										:= corp2.t2u(l.org_corporate_id[1..2]);// Two digit Alpha character code 
		
		self.dt_vendor_first_reported		 	  := (integer)fileDate;
		self.dt_vendor_last_reported		 	  := (integer)fileDate;
		self.dt_first_seen							 	  := (integer)fileDate;
		self.dt_last_seen								 	  := (integer)fileDate;
		self.corp_ra_dt_first_seen			 	  := (integer)fileDate;
		self.corp_ra_dt_last_seen				 	  := (integer)fileDate;
		self.corp_process_date					  	:= fileDate;
		self.corp_key										    := state_fips +'-'+ corp2.t2u(l.org_corporate_id); 
		self.corp_vendor								    := state_fips;
		self.corp_state_origin							:= state_origin;
		self.corp_legal_name                := Corp2_Mapping.fCleanBusinessName(state_origin,state_desc,l.org_name).BusinessName;
		self.corp_ln_name_type_cd           := map(corporateID_Type in legal_list				     => '01', 
																							 corporateID_Type = 'UB'				       		 => '02', 
																							 corporateID_Type = 'RG'									 => '09', 
																							 corporateID_Type in ['RL','RN','RP','RS'] => '07',
																							 corporateID_Type);
		self.corp_ln_name_type_desc         := map(corporateID_Type in legal_list					   => 'LEGAL', 
																							 corporateID_Type = 'UB'				       		 => 'DBA', 
																							 corporateID_Type = 'RG'									 => 'REGISTRATION', 
																						   corporateID_Type in ['RL','RN','RP','RS'] => 'RESERVED',
																							 '');
		self.corp_orig_sos_charter_nbr      := corp2.t2u(l.org_corporate_id);
		self.corp_orig_org_structure_cd  	  := if(corp2.t2u(l.entity_type) not in ['RG','RL','RN','RP','RS','UB'],corp2.t2u(l.entity_type),'');
		self.corp_orig_org_structure_desc  	:= Corp2_Raw_SD.Functions.CorpOrigOrgStructDesc(l.entity_type);
		self.corp_foreign_domestic_ind			:= map(corp2.t2u(l.entity_type) in domestic_list and corp2.t2u(l.corp_home_state) in [state_origin,'']     => 'D',
																							 corp2.t2u(l.entity_type) in foreign_list and corp2.t2u(l.corp_home_state) not in [state_origin,''] => 'F',
																							 '');
		self.corp_inc_date                  := map(corporateID_Type in domestic_list and
																							 (corp2.t2u(l.corp_home_state) = '' or corp2.t2u(l.corp_home_state) in [state_origin])=>Corp2_Mapping.fValidateDate(l.corp_date,'CCYY-MM-DD').PastDate,
																							 '');
		self.corp_forgn_date                := map(corporateID_Type in foreign_list and
																							 corp2.t2u(l.corp_home_state) not in [state_origin,'S'] => Corp2_Mapping.fValidateDate(l.corp_date,'CCYY-MM-DD').PastDate,
																							 '');
		self.Corp_for_profit_ind            := if(corp2.t2u(l.entity_type) in ['FN','NS'],'N','');
		//When the business address is blank as it is for RESERVED businesses, we will move the mailing address to address1
		self.corp_address1_line1						:= if(Corp2_Mapping.fAddressExists(state_origin,state_desc,l.address_1,l.address_2,l.city,l.State,l.Zip).ifAddressExists,
		                                          Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.address_1,l.address_2,l.city,l.State,l.Zip).AddressLine1,
																							Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.mailing_address_1,l.mailing_address_2,l.mailing_city,l.mailing_state,l.mailing_zip).AddressLine1);
		self.corp_address1_line2				 		:= if(Corp2_Mapping.fAddressExists(state_origin,state_desc,l.address_1,l.address_2,l.city,l.State,l.Zip).ifAddressExists,
		                                          Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.address_1,l.address_2,l.city,l.State,l.Zip).AddressLine2,
																							Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.mailing_address_1,l.mailing_address_2,l.mailing_city,l.mailing_state,l.mailing_zip).AddressLine2);
		self.corp_address1_line3				 		:= if(Corp2_Mapping.fAddressExists(state_origin,state_desc,l.address_1,l.address_2,l.city,l.State,l.Zip).ifAddressExists,
		                                          Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.address_1,l.address_2,l.city,l.State,l.Zip).AddressLine3,
																							Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.mailing_address_1,l.mailing_address_2,l.mailing_city,l.mailing_state,l.mailing_zip).AddressLine3);
		self.corp_prep_addr1_line1					:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.address_1,l.address_2,l.city,l.State,l.Zip).PrepAddrLine1;
		self.corp_prep_addr1_last_line			:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.address_1,l.address_2,l.city,l.State,l.Zip).PrepAddrLastLine;
		self.corp_address1_type_cd					:= if(Corp2_Mapping.fAddressExists(state_origin,state_desc,l.address_1,l.address_2,l.city,l.State,l.Zip).ifAddressExists,'B',
																							if(Corp2_Mapping.fAddressExists(state_origin,state_desc,l.mailing_address_1,l.mailing_address_2,l.mailing_city,l.mailing_state,l.mailing_zip).ifAddressExists,
																							'M',''));
		self.corp_address1_type_desc				:= if(Corp2_Mapping.fAddressExists(state_origin,state_desc,l.address_1,l.address_2,l.city,l.State,l.Zip).ifAddressExists,'BUSINESS',
																							if(Corp2_Mapping.fAddressExists(state_origin,state_desc,l.mailing_address_1,l.mailing_address_2,l.mailing_city,l.mailing_state,l.mailing_zip).ifAddressExists,
																							'MAILING',''));
		self.corp_address2_line1						:= if(Corp2_Mapping.fAddressExists(state_origin,state_desc,l.address_1,l.address_2,l.city,l.State,l.Zip).ifAddressExists,
		                                          Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.mailing_address_1,l.mailing_address_2,l.mailing_city,l.mailing_state,l.mailing_zip).AddressLine1,'');
		self.corp_address2_line2				 		:= if(Corp2_Mapping.fAddressExists(state_origin,state_desc,l.address_1,l.address_2,l.city,l.State,l.Zip).ifAddressExists,    
		                                          Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.mailing_address_1,l.mailing_address_2,l.mailing_city,l.mailing_state,l.mailing_zip).AddressLine2,'');
		self.corp_address2_line3				 		:= if(Corp2_Mapping.fAddressExists(state_origin,state_desc,l.address_1,l.address_2,l.city,l.State,l.Zip).ifAddressExists,
		                                          Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.mailing_address_1,l.mailing_address_2,l.mailing_city,l.mailing_state,l.mailing_zip).AddressLine3,'');
		self.corp_prep_addr2_line1					:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.mailing_address_1,l.mailing_address_2,l.mailing_city,l.mailing_state,l.mailing_zip).PrepAddrLine1;
		self.corp_prep_addr2_last_line			:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.mailing_address_1,l.mailing_address_2,l.mailing_city,l.mailing_state,l.mailing_zip).PrepAddrLastLine;
		self.corp_address2_type_cd					:= if(Corp2_Mapping.fAddressExists(state_origin,state_desc,l.mailing_address_1,l.mailing_address_2,l.mailing_city,l.mailing_state,l.mailing_zip).ifAddressExists AND
																							Corp2_Mapping.fAddressExists(state_origin,state_desc,l.address_1,l.address_2,l.city,l.State,l.Zip).ifAddressExists,
																							'M','');
		self.corp_address2_type_desc				:= if(Corp2_Mapping.fAddressExists(state_origin,state_desc,l.mailing_address_1,l.mailing_address_2,l.mailing_city,l.mailing_state,l.mailing_zip).ifAddressExists AND
		                                          Corp2_Mapping.fAddressExists(state_origin,state_desc,l.address_1,l.address_2,l.city,l.State,l.Zip).ifAddressExists,
																							'MAILING','');
		self.corp_ra_full_name 							:= Corp2_Mapping.fCleanBusinessName(state_origin,state_desc,l.agent_name).BusinessName;
		self.corp_ra_addl_info              := if(corp2.t2u(l.craid) <> '','CRAID: ' + corp2.t2u(l.craid),'');
		self.corp_ra_address_Line1					:= choose(ctr,Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.agent_address1,l.agent_address2,l.agent_city,l.agent_state,l.agent_zip).AddressLine1
																										 ,Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.agent_mailing_address1,l.agent_mailing_address2,l.agent_mailing_city,l.agent_mailing_state,l.agent_mailing_zip).AddressLine1
																									);
		self.corp_ra_address_Line2				 	:= choose(ctr,Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.agent_address1,l.agent_address2,l.agent_city,l.agent_state,l.agent_zip).AddressLine2
																										 ,Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.agent_mailing_address1,l.agent_mailing_address2,l.agent_mailing_city,l.agent_mailing_state,l.agent_mailing_zip).AddressLine2
																									);
		self.corp_ra_address_Line3				 	:= choose(ctr,Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.agent_address1,l.agent_address2,l.agent_city,l.agent_state,l.agent_zip).AddressLine3
																										 ,Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.agent_mailing_address1,l.agent_mailing_address2,l.agent_mailing_city,l.agent_mailing_state,l.agent_mailing_zip).AddressLine3
																									);
		self.ra_prep_addr_line1							:= choose(ctr,Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.agent_address1,l.agent_address2,l.agent_city,l.agent_state,l.agent_zip).prepaddrline1
																										 ,Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.agent_mailing_address1,l.agent_mailing_address2,l.agent_mailing_city,l.agent_mailing_state,l.agent_mailing_zip).prepaddrline1
																									);
		self.ra_prep_addr_last_line					:= choose(ctr,Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.agent_address1,l.agent_address2,l.agent_city,l.agent_state,l.agent_zip).prepaddrlastline
																										 ,Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.agent_mailing_address1,l.agent_mailing_address2,l.agent_mailing_city,l.agent_mailing_state,l.agent_mailing_zip).prepaddrlastline
																									);
		self.corp_ra_address_type_cd        := choose(ctr, if(Corp2_Mapping.fAddressExists(state_origin,state_desc,l.agent_address1,l.agent_address2,l.agent_city,l.agent_state,l.agent_zip).ifAddressExists,'R','')
																										 , if(Corp2_Mapping.fAddressExists(state_origin,state_desc,l.agent_mailing_address1,l.agent_mailing_address2,l.agent_mailing_city,l.agent_mailing_state,l.agent_mailing_zip).ifAddressExists,'M','')
																									);																							
		self.corp_ra_address_type_desc      := choose(ctr, if(Corp2_Mapping.fAddressExists(state_origin,state_desc,l.agent_address1,l.agent_address2,l.agent_city,l.agent_state,l.agent_zip).ifAddressExists,'REGISTERED OFFICE','')
																										 , if(Corp2_Mapping.fAddressExists(state_origin,state_desc,l.agent_mailing_address1,l.agent_mailing_address2,l.agent_mailing_city,l.agent_mailing_state,l.agent_mailing_zip).ifAddressExists,'REGISTERED AGENT MAILING ADDRESS','')
																									);
		self.corp_addl_info              		:= map(corp2.t2u(l.llc_managed_ind) = 'A' => 'MANAGER-MANAGED',
		                                           corp2.t2u(l.llc_managed_ind) = 'M' => 'MEMBER-MANAGED',
																							 ''
																							 );
	
		self.corp_inc_state                 := state_origin ;
		self.Corp_Country_Of_Formation		  := Corp2_Mapping.fCleanCountry(state_origin,state_desc,'',l.corp_country).Country;													
		self.corp_forgn_state_cd            := if(corp2.t2u(l.corp_home_state) not in [state_origin,''] and not ut.isNumeric(l.corp_home_state) , 
																							Corp2_Raw_SD.Functions.Get_State_Code(l.corp_home_state),''); // according to CI ,not to populate when it has numeric values 
		self.corp_forgn_state_desc          := if(corp2.t2u(l.corp_home_state) not in [state_origin,''] and not ut.isNumeric(l.corp_home_state) ,
																						  Corp2_Raw_SD.Functions.fGetStateDesc(l.corp_home_state),'');
		self.corp_term_exist_cd             := map(corp2.t2u(l.corp_term)  = 'PERPETUAL' => 'P',
		                                           corp2.t2u(l.corp_term)  = 'EXPIRES'   => 'E',
																							 ''
																							 );
		self.corp_term_exist_desc           := map(corp2.t2u(l.corp_term)  = 'PERPETUAL' => 'PERPETUAL',
		                                           corp2.t2u(l.corp_term)  = 'EXPIRES'   => 'EXPIRES',
																							 ''
																							 );
		self.corp_status_cd                 := if(corp2.t2u(l.entity_status) in ['D','I','S','V','G'],corp2.t2u(l.entity_status),''); 
		self.corp_status_desc               := Corp2_Raw_SD.Functions.CorpStatusDesc(l.entity_status); 
		self.corp_standing                  := if(corp2.t2u(l.entity_status) = 'G','Y','');								 
		self.corp_llc_managed_ind           := if(corp2.t2u(l.llc_managed_ind) in ['A','M'],corp2.t2u(l.llc_managed_ind) ,'');
		self.corp_llc_managed_desc          := map(corp2.t2u(l.llc_managed_ind) = 'A' => 'MANAGER-MANAGED',
		                                           corp2.t2u(l.llc_managed_ind) = 'M' => 'MEMBER-MANAGED',
																							 ''
																							 );
		self.corp_agent_id              		:= corp2.t2u(l.craid); 
		self.corp_agent_commercial          := if(corp2.t2u(l.craid) <> '','Y','');
		/* Two digit Alpha character codes (New/vendor sent) will be caught through scrubs!
			 those get a chance to examine add them to[foreign_list or domestic_list] for date's */
		self.InternalField1                 := if(corporateID_Type not in [domestic_list,foreign_list] ,'**|'+corporateID_Type,'') ;	
		self.recordorigin									  := 'C';	
		self																:= [];

	End;
	
  mapCorp_norm := normalize(ds_vendor_mainFile, if(trim(left.agent_mailing_address1 + left.agent_mailing_city,left,right) <> '',2,1),SD_corpTransform(LEFT, counter)); 
	mapCorp      := dedup(sort(distribute(mapCorp_norm,hash(corp_key)),record,local),record,local) : independent;
	
	corp2_Mapping.LayoutsCommon.AR sd_arTransform(Corp2_Raw_SD.Layouts.vendor_arLayout  L):=	transform, 
	skip(corp2.t2u(l.change_type) not in ['AR','ARA'] or corp2.t2u(l.org_corporate_id) = '')

		self.corp_key							:= state_fips + '-' +  corp2.t2u(l.org_corporate_id);
		self.corp_vendor					:= state_fips;
		self.corp_state_origin		:= state_origin ;
		self.corp_process_date		:= fileDate;
		self.corp_sos_charter_nbr	:= corp2.t2u(l.org_corporate_id);
		self.ar_report_nbr        := corp2.t2u(l.ann_report_id);
		self.ar_filed_dt					:= Corp2_Mapping.fValidateDate(l.date_of_change,'CCYY-MM-DD').PastDate;
		self.ar_year 							:= if((unsigned4)l.ar_year <> 0,trim(l.ar_year,left,right),'') ;
		self.ar_type						  := map(corp2.t2u(l.change_type) = 'AR'  => 'ANNUAL REPORT',
		                                 corp2.t2u(l.change_type) = 'ARA' => 'ANNUAL REPORT AMENDMENT',
																		 ''
																		 );
		self											:= [];

	end; 

	sd_AR	 := project(ds_vendor_arFile , sd_arTransform(left))(trim(ar_filed_dt) <> '' or trim(AR_Year) <> '' or trim(ar_type) <> '');		
	MapAR  := dedup(sort(distribute(sd_AR,hash(corp_key)),record,local),record,local) : independent;
	
	corp2_Mapping.LayoutsCommon.EVENTS sd_amendTransform(Corp2_Raw_SD.Layouts.vendor_amendLayout  L):=	transform,
  skip(corp2.t2u(l.change_type) in ['AR','ARA'] or corp2.t2u(l.org_corporate_id) = '')

		self.corp_key	                  := state_fips + '-' +  corp2.t2u(l.org_corporate_id);
		self.corp_vendor	              := state_fips;
		self.corp_state_origin	        := state_origin ;
		self.corp_process_date	        := fileDate;
		self.corp_sos_charter_nbr	      := corp2.t2u(l.org_corporate_id);
		self.event_filing_reference_nbr := corp2.t2u(l.amendment_id);
		self.event_filing_date	        := Corp2_Mapping.fValidateDate(l.date_of_change,'CCYY-MM-DD').PastDate;
		self.event_date_type_cd	        := if(self.event_filing_date <> '', 'FIL', '');
		self.event_date_type_desc       := if(self.event_filing_date <> '', 'FILING',	'');
		self.event_filing_cd	          := corp2.t2u(l.change_type);
		self.event_filing_desc  	      := Corp2_Raw_SD.Functions.fGetEventFilingDesc(l.change_type);
		self	                          := [];

	end; 

	sd_Event := project(ds_vendor_amendFile , sd_amendTransform(left))(trim(event_filing_date) <> '' or trim(event_filing_cd) <> '');
	MapEvent := dedup(sort(distribute(sd_Event,hash(corp_key)),record,local),record,local) : independent;
	
//********************************************************************
// SCRUB MAIN
//********************************************************************

	Main_F := mapCorp;
	Main_S := Scrubs_Corp2_Mapping_SD_Main.Scrubs;					// Scrubs module
	Main_N := Main_S.FromNone(Main_F); 											// Generate the error flags
	Main_T := Main_S.FromBits(Main_N.BitmapInfile);     		// Use the FromBits module; makes my bitmap datafile easier to get to
	Main_U := Main_S.FromExpanded(Main_N.ExpandedInFile); 	// Pass the expanded error flags into the Expanded module

	//Outputs reports
	Main_ErrorSummary					:= output(Main_U.SummaryStats, named('Main_ErrorSummary_SD'+filedate));
	Main_ScrubErrorReport 		:= output(choosen(Main_U.AllErrors, 1000), named('Main_ScrubErrorReport_SD'+filedate));
	Main_SomeErrorValues			:= output(choosen(Main_U.BadValues, 1000), named('Main_SomeErrorValues_SD'+filedate));
	Main_IsScrubErrors		 		:= IF(count(Main_U.AllErrors)<> 0,true,false);

	// Orbit Stats
	Main_OrbitStats						:= Main_U.OrbitStats();
	//Outputs files
	Main_CreateBitMaps				:= output(Main_N.BitmapInfile,,'~thor_data::corp_SD_main_scrubs_bits',overwrite,compressed);	//long term storage
	Main_TranslateBitMap			:= output(Main_T);
	//Creates Profile's alert template for Orbit - can be copied and imported into Orbit; Only required if rules in Orbit change
	Main_AlertsCSVTemplate		:= Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_'+state_origin+'_Main','ScrubsAlerts', Main_OrbitStats, version,'Corp2_'+state_origin+'_Main').ProfileAlertsTemplate;
	//Submits Profile's stats to Orbit
	Main_SubmitStats 			  	:= Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_'+state_origin+'_Main','ScrubsAlerts', Main_OrbitStats, version,'Corp2_'+state_origin+'_Main').SubmitStats;
	Main_ScrubsWithExamples		:= Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_'+state_origin+'_Main','ScrubsAlerts', Main_OrbitStats, version,'Corp2_'+state_origin+'_Main').CompareToProfile_with_Examples;
	
	Main_ScrubsAlert					:= Main_ScrubsWithExamples(RejectWarning = 'Y');
	Main_ScrubsAttachment			:= Scrubs.fn_email_attachment(Main_ScrubsAlert);
	Main_MailFile							:= FileServices.SendEmailAttachData( corp2.Email_Notification_Lists.spray
																																 ,'Scrubs CorpMain_SD Report' //subject
																																 ,'Scrubs CorpMain_SD Report' //body
																																 ,(data)Main_ScrubsAttachment
																																 ,'text/csv'
																																 ,'CorpSDMainScrubsReport.csv'
																																 ,
																																 ,
																																 ,corp2.Email_Notification_Lists.spray
																															);

		Main_BadRecords		  := Main_N.ExpandedInFile(  dt_vendor_first_reported_Invalid					<> 0 or
																									 dt_vendor_last_reported_Invalid					<> 0 or
																									 dt_first_seen_Invalid								  	<> 0 or
																									 dt_last_seen_Invalid										  <> 0 or
																									 corp_ra_dt_first_seen_Invalid					  <> 0 or
																									 corp_ra_dt_last_seen_Invalid					    <> 0 or
																									 corp_key_Invalid													<> 0 or
																									 corp_vendor_Invalid											<> 0 or
																									 corp_state_origin_Invalid								<> 0 or
																									 corp_process_date_Invalid								<> 0 or
																									 corp_orig_sos_charter_nbr_Invalid				<> 0 or
																									 corp_legal_name_Invalid									<> 0 or
																									 corp_ln_name_type_cd_Invalid							<> 0 or
																									 corp_ln_name_type_desc_Invalid						<> 0 or
																									 corp_status_cd_Invalid										<> 0 or
																									 corp_status_desc_Invalid									<> 0 or
																									 corp_status_date_Invalid									<> 0 or
																									 corp_inc_state_Invalid										<> 0 or
																									 corp_inc_date_Invalid										<> 0 or
																									 corp_foreign_domestic_ind_Invalid				<> 0 or
																									 corp_forgn_state_cd_Invalid							<> 0 or
																									 corp_forgn_date_Invalid									<> 0 or
																									 corp_orig_org_structure_cd_Invalid				<> 0 or
																									 corp_for_profit_ind_Invalid							<> 0 or
																									 corp_agent_assign_date_Invalid						<> 0 or
																									 corp_farm_status_cd_Invalid							<> 0 or
																									 corp_farm_status_desc_Invalid						<> 0 or
																									 recordorigin_Invalid											<> 0 or
																									 InternalField1_Invalid										<> 0
																								);
																																										
	Main_GoodRecords		:= Main_N.ExpandedInFile(		 dt_vendor_first_reported_Invalid					= 0 and
																									 dt_vendor_last_reported_Invalid					= 0 and
																									 dt_first_seen_Invalid								  	= 0 and
																									 dt_last_seen_Invalid										  = 0 and
																									 corp_ra_dt_first_seen_Invalid					  = 0 and
																									 corp_ra_dt_last_seen_Invalid					    = 0 and
																									 corp_key_Invalid													= 0 and
																									 corp_vendor_Invalid											= 0 and
																									 corp_state_origin_Invalid								= 0 and
																									 corp_process_date_Invalid								= 0 and
																									 corp_orig_sos_charter_nbr_Invalid				= 0 and
																									 corp_legal_name_Invalid									= 0 and
																									 corp_ln_name_type_cd_Invalid							= 0 and
																									 corp_ln_name_type_desc_Invalid						= 0 and
																									 corp_status_cd_Invalid										= 0 and
																									 corp_status_desc_Invalid									= 0 and
																									 corp_status_date_Invalid									= 0 and
																									 corp_inc_state_Invalid										= 0 and
																									 corp_inc_date_Invalid										= 0 and
																									 corp_foreign_domestic_ind_Invalid				= 0 and
																									 corp_forgn_state_cd_Invalid							= 0 and
																									 corp_forgn_date_Invalid									= 0 and
																									 corp_orig_org_structure_cd_Invalid				= 0 and
																									 corp_for_profit_ind_Invalid							= 0 and
																									 corp_agent_assign_date_Invalid						= 0 and
																									 corp_farm_status_cd_Invalid							= 0 and
																									 corp_farm_status_desc_Invalid						= 0 and
																									 recordorigin_Invalid											= 0 and
																									 InternalField1_Invalid										= 0
																							);


	Main_FailBuild	:= map( Corp2_Mapping.fCalcPercent(count(Main_N.ExpandedInFile(corp_key_invalid<>0)),count(Main_N.ExpandedInFile),false) 										> Scrubs_Corp2_Mapping_SD_Main.Threshold_Percent.CORP_KEY										   => true,
													Corp2_Mapping.fCalcPercent(count(Main_N.ExpandedInFile(corp_orig_sos_charter_nbr_invalid<>0)),count(Main_N.ExpandedInFile),false) 	> Scrubs_Corp2_Mapping_SD_Main.Threshold_Percent.CORP_ORIG_SOS_CHARTER_NBR 	   => true,
													Corp2_Mapping.fCalcPercent(count(Main_N.ExpandedInFile(corp_legal_name_invalid<>0)),count(Main_N.ExpandedInFile),false) 						> Scrubs_Corp2_Mapping_SD_Main.Threshold_Percent.CORP_LEGAL_NAME 						   => true,
													count(Main_GoodRecords) = 0																																																																																											 	 => true,																		
													false
												);

	Main_ApprovedRecords	:= project(Main_GoodRecords,transform(Corp2_Mapping.LayoutsCommon.Main,self := left));
	
	Main_RejFile_Exists		:= IF(FileServices.FileExists(Corp2_Mapping._dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::main_' + state_origin),true,false);			
	Main_ALL		 					:= sequential(IF(count(Main_BadRecords) <> 0
																					,IF (poverwrite
																							,OUTPUT(Main_BadRecords,,Corp2_Mapping._Dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::main_sd',overwrite,__compressed__,named('Sample_Rejected_MainRecs_SD'+filedate))
																							,sequential (IF(Main_RejFile_Exists,fileservices.deletelogicalfile(Corp2_Mapping._dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::main_'+ state_origin)),
																													 OUTPUT(Main_BadRecords,,Corp2_Mapping._Dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::main_'+ state_origin,__compressed__,named('Sample_Rejected_MainRecs_SD'+filedate))
																													 )
																							)
																				)
																		,output(Main_ScrubsWithExamples, ALL, NAMED('CorpMainSDScrubsReportWithExamples'+filedate))																		
																		//Send Alerts if Scrubs exceeds thresholds
																		,IF(COUNT(Main_ScrubsAlert) > 0, Main_MailFile, OUTPUT('CORP2_MAPPING.SD - No "MAIN" Corp Scrubs Alerts'))
																		,Main_ErrorSummary
																		,Main_ScrubErrorReport
																		,Main_SomeErrorValues
																		//,Main_AlertsCSVTemplate
																		,Main_SubmitStats				
																	);

//********************************************************************
// SCRUB EVENT
//********************************************************************	
	Event_F := mapEvent;
	Event_S := Scrubs_Corp2_Mapping_SD_Event.Scrubs;						// Scrubs module
	Event_N := Event_S.FromNone(Event_F); 											// Generate the error flags
	Event_T := Event_S.FromBits(Event_N.BitmapInfile);     			// Use the FromBits module; makes my bitmap datafile easier to get to
	Event_U := Event_S.FromExpanded(Event_N.ExpandedInFile); 		// Pass the expanded error flags into the Expanded module
	
	//Outputs reports
	Event_ErrorSummary				:= output(Event_U.SummaryStats, named('Event_ErrorSummary_SD'+filedate));
	Event_ScrubErrorReport 		:= output(choosen(Event_U.AllErrors, 1000), named('Event_ScrubErrorReport_SD'+filedate));
	Event_SomeErrorValues			:= output(choosen(Event_U.BadValues, 1000), named('Event_SomeErrorValues_SD'+filedate));
	Event_IsScrubErrors		 		:= IF(count(Event_U.AllErrors)<> 0,true,false);

	// Orbit Stats
	Event_OrbitStats					:= Event_U.OrbitStats();

	//Outputs files
	Event_CreateBitMaps				:= output(Event_N.BitmapInfile,,'~thor_data::corp_SD_event_scrubs_bits',overwrite,compressed);	//long term storage
	Event_TranslateBitMap			:= output(Event_T);
	//Creates Profile's alert template for Orbit - Can be copied & imported into Orbit; Only required first time & if scrub rules change
	Event_AlertsCSVTemplate	  := Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_'+ state_origin+'_Event','ScrubsAlerts', Event_OrbitStats, version,'Corp2_'+ state_origin+'_Event').ProfileAlertsTemplate;
	//Submits Profile's stats to Orbit
	Event_SubmitStats 				:= Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_'+ state_origin+'_Event','ScrubsAlerts', Event_OrbitStats, version,'Corp2_'+ state_origin+'_Event').SubmitStats;

	Event_ScrubsWithExamples	:= Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_'+ state_origin+'_Event','ScrubsAlerts', Event_OrbitStats, version,'Corp2_'+ state_origin+'_Event').CompareToProfile_with_Examples;
	
	Event_ScrubsAlert					:= Event_ScrubsWithExamples(RejectWarning = 'Y');
	Event_ScrubsAttachment		:= Scrubs.fn_email_attachment(Event_ScrubsAlert);
	Event_MailFile						:= FileServices.SendEmailAttachData( corp2.Email_Notification_Lists.spray
																																 ,'Scrubs CorpEvent_SD Report' //Subject
																																 ,'Scrubs CorpEvent_SD Report' //body
																																 ,(data)Event_ScrubsAttachment
																																 ,'text/csv'
																																 ,'CorpSDEventScrubsReport.csv'
																																 ,
																																 ,
																																 ,corp2.Email_Notification_Lists.spray);

 Event_BadRecords		  := event_N.ExpandedInFile(corp_key_Invalid 							  <> 0 or
																								corp_vendor_Invalid 					  <> 0 or
																								corp_state_origin_Invalid 		  <> 0 or
																								corp_process_date_Invalid		    <> 0 or
																								corp_sos_charter_nbr_Invalid    <> 0 or
																								corp_state_origin_Invalid   	  <> 0 or
																								event_filing_cd_Invalid 			  <> 0
																								);
																																										
	Event_GoodRecords	  := event_N.ExpandedInFile(corp_key_Invalid 											= 0 or
																								corp_vendor_Invalid 									= 0 or
																								corp_state_origin_Invalid 					 	= 0 or
																								corp_process_date_Invalid						  = 0 or
																								corp_sos_charter_nbr_Invalid 					= 0 or
																								corp_state_origin_Invalid 						= 0 or
																								event_filing_cd_Invalid 							= 0
																								);
																								
	Event_FailBuild	:= map( Corp2_Mapping.fCalcPercent(count(event_N.ExpandedInFile(corp_key_invalid<>0)),count(event_N.ExpandedInFile),false) 							> Scrubs_Corp2_Mapping_SD_event.Threshold_Percent.CORP_KEY							  => true,
													Corp2_Mapping.fCalcPercent(count(event_N.ExpandedInFile(corp_sos_charter_nbr_invalid<>0)),count(event_N.ExpandedInFile),false) 	> Scrubs_Corp2_Mapping_SD_event.Threshold_Percent.CORP_sos_CHARTER_NBR 	  => true,
													Corp2_Mapping.fCalcPercent(count(event_N.ExpandedInFile(event_filing_cd_Invalid<>0)),count(event_N.ExpandedInFile),false) 	    > Scrubs_Corp2_Mapping_SD_event.Threshold_Percent.event_filing_cd				  => true,
													count(Event_GoodRecords) = 0																																																																																											 						=> true,																		
													false);
													
	Event_ApprovedRecords			:= project(Event_GoodRecords,transform(Corp2_Mapping.LayoutsCommon.Events,self := left));
	
	Event_RejFile_Exists			:= IF(FileServices.FileExists(Corp2_Mapping._dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::event_' + state_origin),true,false);			
	Event_ALL									:= sequential(IF(count(Event_BadRecords)<> 0
																						 ,if(poverwrite
																								,OUTPUT(Event_BadRecords,,Corp2_Mapping._Dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::event_sd',overwrite,__compressed__,named('Sample_Rejected_Event_Recs_SD'+filedate))
																								,sequential (IF(Event_RejFile_Exists,fileservices.deletelogicalfile(Corp2_Mapping._dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::event_'+ state_origin)),
																														 OUTPUT(Main_BadRecords,,Corp2_Mapping._Dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::event_'+ state_origin,__compressed__,named('Sample_Rejected_Event_Recs_SD'+filedate))
																														)
																								)
																						)
																					 ,output(Event_ScrubsWithExamples, ALL, NAMED('CorpEventSDScrubsReportWithExamples'+filedate))
																					 //Send Alerts if Scrubs exceeds thresholds
																					 ,IF(COUNT(Event_ScrubsAlert) > 0, Event_MailFile, OUTPUT('CORP2_MAPPING.SD - No "EVENT" Corp Scrubs Alerts'))
																					 ,Event_ErrorSummary
																					 ,Event_ScrubErrorReport
																					 ,Event_SomeErrorValues		
																					 //,Event_AlertsCSVTemplate
																					 ,Event_SubmitStats
																					);


//==========================================VERSION CONTROL====================================================

 	IsScrubErrors					:= IF(Event_IsScrubErrors = TRUE OR Main_IsScrubErrors = TRUE,TRUE,FALSE);

	VersionControl.macBuildNewLogicalFile(Corp2_Mapping._dataset().thor_cluster_Files + 'in::corp2::' + version + '::AR_sd', mapar	 , AR_out,,,pOverwrite);
	VersionControl.macBuildNewLogicalFile(Corp2_Mapping._dataset().thor_cluster_Files + 'in::corp2::' + version + '::Event_sd', Event_ApprovedRecords, event_out,,,pOverwrite);
	VersionControl.macBuildNewLogicalFile(Corp2_Mapping._dataset().thor_cluster_Files + 'in::corp2::' + version + '::Main_sd', Main_ApprovedRecords , main_out,,,pOverwrite);
	
	VersionControl.macBuildNewLogicalFile(Corp2_Mapping._dataset().thor_cluster_Files + 'fail::corp2::'+version+'::Main_' 	+ state_origin	,Main_F	 ,write_fail_main  ,,,pOverwrite); 
	VersionControl.macBuildNewLogicalFile(Corp2_Mapping._dataset().thor_cluster_Files + 'fail::corp2::'+version+'::event_' 	+ state_origin	,Event_F	,write_fail_event  ,,,pOverwrite); 
			
	mapSD:= sequential(   if(pshouldspray = true,Corp2_mapping.fSprayFiles(state_origin ,version,pOverwrite := pOverwrite))
											  //,Corp2_Raw_SD.Build_Bases(filedate,version,pUseProd).All  // Determined building of bases is not needed
												,main_out
												,event_out
												,ar_out
												,IF(Main_FailBuild <> true or Event_FailBuild <> true
														 ,sequential(fileservices.addsuperfile(Corp2_Mapping._Dataset().thor_cluster_Files + 'in::'+Corp2_Mapping._Dataset().NameMapped+'::sprayed::ar'		 ,Corp2_Mapping._Dataset().thor_cluster_Files + 'in::corp2::'+version+'::ar_SD')
																				 ,fileservices.addsuperfile(Corp2_Mapping._Dataset().thor_cluster_Files + 'in::'+Corp2_Mapping._Dataset().NameMapped+'::sprayed::event' ,Corp2_Mapping._Dataset().thor_cluster_Files + 'in::corp2::'+version+'::event_SD')
																				 ,fileservices.addsuperfile(Corp2_Mapping._Dataset().thor_cluster_Files + 'in::'+Corp2_Mapping._Dataset().NameMapped+'::sprayed::main'	 ,Corp2_Mapping._Dataset().thor_cluster_Files + 'in::corp2::'+version+'::main_SD')																		 
                                         ,if (count(Main_BadRecords) <> 0 or  count(Event_BadRecords) <> 0 
																						 ,Corp2_Mapping.Send_Email(state_origin ,version,count(Main_BadRecords)<>0,,count(Event_BadRecords)<>0,,count(Main_BadRecords),,count(Event_BadRecords),,count(Main_ApprovedRecords),count(mapAR),count(Event_ApprovedRecords)).RecordsRejected																				 
																						 ,Corp2_Mapping.Send_Email(state_origin ,version,count(Main_BadRecords)<>0,,count(Event_BadRecords)<>0,,count(Main_BadRecords),,count(Event_BadRecords),,count(Main_ApprovedRecords),count(mapAR),count(Event_ApprovedRecords)).MappingSuccess																				 
																						 )	
																				 ,if(IsScrubErrors
																				 ,Corp2_Mapping.Send_Email(state_origin,version,Main_IsScrubErrors,false,Event_IsScrubErrors,false).FieldsInvalidPerScrubs
																				 )
																			 )
														 ,sequential( write_fail_main //if it fails on  main file threshold ,still writing mapped files!
																				 ,write_fail_event
																				 ,Corp2_Mapping.Send_Email(state_origin ,version).MappingFailed
																				)
													)
												,Event_All
												,Main_All	
										);
										
		//Validating the filedate entered is within 30 days				
		isFileDateValid := if((string)Std.Date.Today() between ut.date_math(filedate,-30) and ut.date_math(filedate,30),true,false);
		result		 			:= if (isFileDateValid
													 ,mapSD
													 ,sequential(Corp2_Mapping.Send_Email(state_origin ,filedate).InvalidFileDateParm
																				 ,FAIL('Corp2_Mapping.SD failed.  An invalid filedate was passed in as a parameter.')
																			)
												  );
		return result;

 end;	// end of Update function

end;  // end of Module