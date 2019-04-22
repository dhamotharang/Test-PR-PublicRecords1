Import Corp2, VersionControl, ut, Corp2_Raw_id, Scrubs_Corp2_Mapping_ID_Main, Scrubs, Tools, Std;

Export ID := MODULE;

	Export Update(string fileDate, string version, boolean pShouldSpray = _Dataset().bShouldSpray, boolean pOverwrite = false,pUseProd = Tools._Constants.IsDataland) :=Function
		
		state_origin			:='ID';
		state_fips	 			:='16';	
		state_desc	 			:='IDAHO';
		
		Ds_vendorRaw	  	:=dedup(sort(distribute(Corp2_Raw_ID.Files(filedate,pUseProd).input.vendorRaw.logical,hash(corp2.t2u(file_type + file_number + dup_number_indicator))),record,local),record,local) : independent;

		Corp2_Mapping.LayoutsCommon.Main corpTransform(Corp2_Raw_ID.Layouts.vendorRawLayoutIn input) := transform
			
			legal_type										 		 := ['C','J','K','L','N','U','W'];			
			
			self.dt_vendor_first_reported			 := (integer)fileDate;
			self.dt_vendor_last_reported			 := (integer)fileDate;
			self.dt_first_seen								 := (integer)fileDate;
			self.dt_last_seen									 := (integer)fileDate;
			self.corp_ra_dt_first_seen				 := (integer)fileDate;
			self.corp_ra_dt_last_seen					 := (integer)fileDate;				
			self.corp_process_date						 := fileDate;			
			self.corp_key											 := state_fips + '-' + corp2.t2u(corp2.t2u(input.file_type) + corp2.t2u(input.file_number) + corp2.t2u(input.dup_number_indicator));
			self.corp_vendor									 := state_fips;
			self.corp_state_origin						 := state_origin;
			self.corp_inc_state  					 		 := state_origin; 
			self.corp_orig_sos_charter_nbr		 := corp2.t2u(corp2.t2u(input.file_type) + (string)(integer)input.file_number + corp2.t2u(input.dup_number_indicator));
			self.corp_legal_name							 := Corp2_Mapping.fCleanBusinessName(state_origin ,state_desc,input.file_name + ' ' + input.additional_name_line).BusinessName; 														
			self.corp_ln_name_type_cd					 := map( corp2.t2u(input.file_type)='D'=>'06',
																								 corp2.t2u(input.file_type)='G'=>'09',	
																								 corp2.t2u(input.file_type)='R'=>'07',
																								 corp2.t2u(input.file_type) in legal_type => '01',
																								 corp2.t2u(input.file_type)
																								);		
			self.corp_ln_name_type_desc				 := map( corp2.t2u(input.file_type)='D'=>'ASSUMED',	
																								 corp2.t2u(input.file_type)='G'=>'REGISTRATION',
																								 corp2.t2u(input.file_type)='R'=>'RESERVED',
																								 corp2.t2u(input.file_type) in legal_type => 'LEGAL',																								 
																							 '');		
			self.corp_agent_status_cd			  	 := if(corp2.t2u(input.office_held) = '' ,
																							 map(corp2.t2u(input.Officer_Type)='N'=>'',
																									 corp2.t2u(input.Officer_Type)
																									 ),
																							'');	
			self.corp_agent_status_desc				 := map( self.corp_agent_status_cd='A'=>'INITIAL',
																								 self.corp_agent_status_cd='C'=>'CURRENT',
																								 self.corp_agent_status_cd='D'=>'DISASSOCIATED',
																								 self.corp_agent_status_cd='P'=>'APPOINTED',
																								 self.corp_agent_status_cd='R'=>'RESIGNED',
																							 '');																											
			self.corp_ra_effective_date		  	  := if(corp2.t2u(input.office_held) = '',Corp2_Mapping.fValidateDate(input.date_appointed[2..9], 'CCYYMMDD').GeneralDate,'');
			self.corp_ra_full_name						  := if(corp2.t2u(input.office_held) = '', Corp2_Mapping.fCleanBusinessName(state_origin ,state_desc,input.officer_name).BusinessName,'');													   
			temp_ra_country 										:= if(corp2.t2u(input.office_held) = '' and Corp2_Raw_ID.Functions.CountryDesc(input.officer_country)[1..2]<> '**',Corp2_Raw_ID.Functions.CountryDesc(input.officer_country),'');
			self.corp_ra_address_line1				  := if(corp2.t2u(input.office_held) = '',Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.officer_street,input.officer_bldng,input.officer_city,input.officer_state,input.officer_zip5 +input.officer_zip4).AddressLine1,'');
			self.corp_ra_address_line2				  := if(corp2.t2u(input.office_held) = '',Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.officer_street,input.officer_bldng,input.officer_city,input.officer_state,input.officer_zip5 +input.officer_zip4).AddressLine2,'');
			self.corp_ra_address_line3				  := if(corp2.t2u(input.office_held) = '',Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.officer_street,input.officer_bldng,input.officer_city,input.officer_state,input.officer_zip5 +input.officer_zip4,temp_ra_country).AddressLine3,'');
			self.ra_prep_addr_line1						  := if(corp2.t2u(input.office_held) = '',Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.officer_street,input.officer_bldng,input.officer_city,input.officer_state,input.officer_zip5 +input.officer_zip4,temp_ra_country).PrepAddrLine1,'');
			self.ra_prep_addr_last_line				  := if(corp2.t2u(input.office_held) = '', Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.officer_street,input.officer_bldng,input.officer_city,input.officer_state,input.officer_zip5 +input.officer_zip4,temp_ra_country).PrepAddrLastLine,'');
			self.corp_ra_address_type_cd     	  := if(corp2.t2u(input.office_held) = '' and Corp2_Mapping.fAddressExists(state_origin,state_desc,input.officer_street,input.officer_bldng,input.officer_city,input.officer_state,input.officer_zip5 +input.officer_zip4,temp_ra_country).ifAddressExists,
																								'R','');
			self.corp_ra_address_type_desc   	  := if(corp2.t2u(input.office_held) = '' and Corp2_Mapping.fAddressExists(state_origin,state_desc,input.officer_street,input.officer_bldng,input.officer_city,input.officer_state,input.officer_zip5 +input.officer_zip4).ifAddressExists,
																								'REGISTERED OFFICE','');
			self.corp_forgn_state_cd    			  := if(corp2.t2u(input.state_of_origin)not in [ state_origin ,''],Corp2_Raw_ID.Functions.StateCode(input.state_of_origin), '' );
			self.corp_forgn_state_desc    		  := if(corp2.t2u(input.state_of_origin)not in [ state_origin ,''],Corp2_Raw_ID.Functions.StateDesc(input.state_of_origin), '' );
			self.corp_foreign_domestic_ind		  := map(corp2.t2u(input.state_of_origin)in [ state_origin ,'']			=>'D',
																								 corp2.t2u(input.state_of_origin) not in [ state_origin ,'']=>'F',
																								 '');
			self.corp_orig_org_structure_cd 	  := map(corp2.t2u(input.corporation_type) in ['D','Y','Z']=>'',
																								 corp2.t2u(input.corporation_type)   = 'X'				 =>corp2.t2u(input.file_type),
																								 corp2.t2u(input.corporation_type)
																								);									
			self.corp_orig_org_structure_desc   :=  map(corp2.t2u(input.corporation_type) in ['D','Y','Z'] => '',
																								  corp2.t2u(input.corporation_type)   = 'X'				 	 => Corp2_Raw_ID.Functions.FileTypeDesc(input.file_type),
																								  corp2_Raw_ID.Functions.OrgStrucDesc(input.corporation_type)
																								 );	
			self.corp_for_profit_ind      		  := map(corp2.t2u(input.corporation_type)in['N','U']=>'N',
																								 '');
			self.corp_inc_date                  := if(corp2.t2u(input.state_of_origin)in [state_origin, ''],Corp2_Mapping.fValidateDate(input.file_date[2..9], 'CCYYMMDD').pastDate  ,'');														
			self.corp_forgn_date 						    := if(corp2.t2u(input.state_of_origin) not in [state_origin, ''],Corp2_Mapping.fValidateDate(input.file_date[2..9], 'CCYYMMDD').pastDate ,'');									
			self.corp_status_cd									:= if(corp2.t2u(input.current_status) not in ['_','-'] ,corp2.t2u(input.current_status),''); // ['_','-'] per CI "Vendor Status Codes"						   
			self.corp_status_desc								:= Corp2_Raw_ID.Functions.StatusDesc(self.corp_status_cd);
			self.corp_standing									:= if(corp2.t2u(input.current_status)='G','Y','');						
			self.corp_status_date								:= Corp2_Mapping.fValidateDate(input.status_change_date[2..9], 'CCYYMMDD').pastDate;
			temp_corp_country 									:= if(Corp2_Raw_ID.Functions.CountryDesc(input.entity_country)[1..2]<> '**',Corp2_Raw_ID.Functions.CountryDesc(input.entity_country),'');
			self.corp_address1_line1						:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.entity_street,input.entity_bldng,input.entity_city,input.entity_state,input.entity_zip5 +input.entity_zip4).AddressLine1;
			self.corp_address1_line2						:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.entity_street,input.entity_bldng,input.entity_city,input.entity_state,input.entity_zip5 +input.entity_zip4).AddressLine2;
			self.corp_address1_line3						:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.entity_street,input.entity_bldng,input.entity_city,input.entity_state,input.entity_zip5 +input.entity_zip4,temp_corp_country).AddressLine3;
			self.corp_prep_addr1_line1					:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.entity_street,input.entity_bldng,input.entity_city,input.entity_state,input.entity_zip5 +input.entity_zip4,temp_corp_country).PrepAddrLine1;
			self.corp_prep_addr1_last_line			:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.entity_street,input.entity_bldng,input.entity_city,input.entity_state,input.entity_zip5 +input.entity_zip4,temp_corp_country).PrepAddrLastLine;
			self.corp_address1_type_cd     			:= if(Corp2_Mapping.fAddressExists(state_origin,state_desc,input.entity_street,input.entity_bldng,input.entity_city,input.entity_state,input.entity_zip5 +input.entity_zip4,temp_corp_country).ifAddressExists,
																								'M','');
			self.corp_address1_type_desc   			:= if(Corp2_Mapping.fAddressExists(state_origin,state_desc,input.entity_street,input.entity_bldng,input.entity_city,input.entity_state,input.entity_zip5 +input.entity_zip4,temp_corp_country).ifAddressExists,
																								'MAILING','');
			self.corp_orig_bus_type_desc				:= corp2.t2u(input.nature_of_business);
			self.InternalField1									:= corp2_Raw_ID.Functions.CountryDesc(input.entity_country); 	//entity_country is being mapped for "corp_address1_line3", new vendor values will be caught through scrubs!!
			self.InternalField2									:= corp2_Raw_ID.Functions.CountryDesc(input.officer_country); //officer_country is being mapped for "corp_ra_address_line3", new vendor values will be caught through scrubs!!
			self.recordorigin										:= 'C';		
			self 																:= [];
						
		end; 

		ds_corps := project(Ds_vendorRaw,corpTransform(Left));
															
		Corp2_Mapping.LayoutsCommon.Main contTransform(Corp2_Raw_ID.Layouts.vendorRawLayoutIn input) := transform, 
		skip( corp2.t2u(input.office_held) = '' or corp2.t2u(input.officer_type) = 'N' or corp2.t2u(input.officer_name) = '') //Per CI !! officer_type = 'N' ,DO NOT MAP /"NO OFFICERS TO REPORT"

			self.dt_vendor_first_reported				:= (integer)fileDate;
			self.dt_vendor_last_reported				:= (integer)fileDate;
			self.dt_first_seen									:= (integer)fileDate;
			self.dt_last_seen										:= (integer)fileDate;
			self.corp_ra_dt_first_seen					:= (integer)fileDate;
			self.corp_ra_dt_last_seen						:= (integer)fileDate;
			self.corp_key											  := state_fips + '-' + corp2.t2u(corp2.t2u(input.file_type) + corp2.t2u(input.file_number) + corp2.t2u(input.dup_number_indicator));
			self.corp_vendor									  := state_fips;
			self.corp_state_origin						  := state_origin;
			self.corp_inc_state  					 		  := state_origin; 
			self.corp_orig_sos_charter_nbr		  := corp2.t2u(corp2.t2u(input.file_type) + (string)(integer)input.file_number + corp2.t2u(input.dup_number_indicator));
			self.corp_legal_name								:= Corp2_Mapping.fCleanBusinessName(state_origin ,state_desc,input.file_name + ' ' + input.additional_name_line).BusinessName; 														 			
			self.cont_status_cd									:= if(corp2.t2u(input.officer_type) not in ['_','-'] ,corp2.t2u(input.officer_type),''); 															
			self.cont_status_desc								:= map( self.cont_status_cd = 'A' => 'INITIAL',
																									self.cont_status_cd = 'C' => 'CURRENT',
																									self.cont_status_cd = 'D' => 'DISSOCIATED',														
																									self.cont_status_cd = 'P' => 'APPOINTED',
																									self.cont_status_cd = 'R' => 'RESIGNED',
																									'');								
			self.cont_title1_desc								:= if(corp2.t2u(input.office_held) not in ['O','T','W'] ,Corp2_Raw_ID.Functions.Title_desc(input.office_held),'');														   
			self.cont_effective_date			  		:= Corp2_Mapping.fValidateDate(input.date_appointed[2..9], 'CCYYMMDD').GeneralDate;
			self.cont_full_name						  		:= Corp2_Mapping.fCleanBusinessName(state_origin ,state_desc,input.officer_name).BusinessName;
			temp_cont_country 									:= if(Corp2_Raw_ID.Functions.CountryDesc(input.officer_country)[1..2]<> '**',Corp2_Raw_ID.Functions.CountryDesc(input.officer_country),'');
			self.cont_Address_line1							:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.officer_street,input.officer_bldng,input.officer_city,input.officer_state,input.officer_zip5 +input.officer_zip4).AddressLine1;
			self.cont_Address_line2							:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.officer_street,input.officer_bldng,input.officer_city,input.officer_state,input.officer_zip5 +input.officer_zip4).AddressLine2;
			self.cont_Address_line3							:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.officer_street,input.officer_bldng,input.officer_city,input.officer_state,input.officer_zip5 +input.officer_zip4,temp_cont_country).AddressLine3;
			self.cont_prep_addr_line1						:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.officer_street,input.officer_bldng,input.officer_city,input.officer_state,input.officer_zip5 +input.officer_zip4,temp_cont_country).PrepAddrLine1;
			self.cont_prep_addr_last_line				:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.officer_street,input.officer_bldng,input.officer_city,input.officer_state,input.officer_zip5 +input.officer_zip4,temp_cont_country).PrepAddrLastLine;
			self.cont_Address_type_cd     			:= if(Corp2_Mapping.fAddressExists(state_origin,state_desc,input.officer_street,input.officer_bldng,input.officer_city,input.officer_state,input.officer_zip5 +input.officer_zip4,temp_cont_country).ifAddressExists,
																								'T','');
			self.cont_Address_type_desc   			:= if(Corp2_Mapping.fAddressExists(state_origin,state_desc,input.officer_street,input.officer_bldng,input.officer_city,input.officer_state,input.officer_zip5 +input.officer_zip4,temp_cont_country).ifAddressExists,
																								'CONTACT','');
			self.recordorigin										:= 'T';
			self 																:= [];	
			
		end;
				
		conts 		 := project(Ds_vendorRaw,contTransform(left));	
		MappedCorp := dedup(sort(distribute(ds_corps + conts ,hash(corp_key)),
														 record,local),
												record,local):independent;

		//***********		MainFile Scrub	Logic												 		
					
		Main_F := MappedCorp;
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
		Main_AlertsCSVTemplate		:= Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_'+state_origin+'_Main','ScrubsAlerts', Main_OrbitStats, version,'Corp2_'+state_origin+'_Main').ProfileAlertsTemplate;
		//Submits Profile's stats to Orbit
		Main_SubmitStats 			  	:= Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_'+state_origin+'_Main','ScrubsAlerts', Main_OrbitStats, version,'Corp2_'+state_origin+'_Main').SubmitStats;
		Main_ScrubsWithExamples		:= Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_'+state_origin+'_Main','ScrubsAlerts', Main_OrbitStats, version,'Corp2_'+state_origin+'_Main').CompareToProfile_with_Examples;
	
		Main_ScrubsAlert					:= Main_ScrubsWithExamples(RejectWarning = 'Y');
		Main_ScrubsAttachment			:= Scrubs.fn_email_attachment(Main_ScrubsAlert);
		Main_SendEmailFile				:= FileServices.SendEmailAttachData( corp2.Email_Notification_Lists.AttachedList
																																	 ,'Scrubs CorpMain_ID Report' 	//subject
																																	 ,'Scrubs CorpMain_ID Report'  //body
																																	 ,(data)Main_ScrubsAttachment
																																	 ,'text/csv'
																																	 ,'CorpIDMainScrubsReport.csv'
																																	);

			Main_BadRecords		  := Main_N.ExpandedInFile(	 dt_vendor_first_reported_Invalid 		<> 0 or
																										 dt_vendor_last_reported_Invalid 			<> 0 or
																										 dt_first_seen_Invalid 								<> 0 or
																										 dt_last_seen_Invalid 								<> 0 or
																										 corp_ra_dt_first_seen_Invalid 				<> 0 or
																										 corp_ra_dt_last_seen_Invalid 				<> 0 or
																										 corp_key_Invalid 										<> 0 or
																										 corp_vendor_Invalid 									<> 0 or
																										 corp_state_origin_Invalid 						<> 0 or
																										 corp_process_date_Invalid 						<> 0 or
																										 corp_orig_sos_charter_nbr_Invalid 		<> 0 or
																										 corp_legal_name_Invalid 							<> 0 or
																										 corp_ln_name_type_cd_Invalid 				<> 0 or
																										 corp_ln_name_type_desc_Invalid 			<> 0 or
																										 corp_status_cd_Invalid 							<> 0 or
																										 corp_status_desc_Invalid 						<> 0 or
																										 corp_status_date_Invalid 						<> 0 or
																										 corp_inc_state_Invalid 							<> 0 or
																										 corp_inc_date_Invalid 								<> 0 or
																										 corp_foreign_domestic_ind_Invalid 		<> 0 or
																										 corp_forgn_state_cd_Invalid 					<> 0 or
																										 corp_forgn_state_desc_Invalid 				<> 0 or
																										 corp_forgn_date_Invalid 							<> 0 or
																										 corp_orig_org_structure_cd_Invalid 	<> 0 or
																										 corp_orig_org_structure_desc_Invalid <> 0 or
																										 corp_for_profit_ind_Invalid 					<> 0 or
																										 cont_title1_desc_Invalid 						<> 0 or																										 
																										 cont_status_cd_Invalid								<> 0 or
																										 corp_agent_status_cd_Invalid 				<> 0 or
																										 InternalField1_Invalid 							<> 0 or
																										 InternalField2_Invalid 							<> 0 or
																										 recordorigin_Invalid 								<> 0
																								 );
																																											
		Main_GoodRecords		:=Main_N.ExpandedInFile( dt_vendor_first_reported_Invalid 		= 0 and
																								 dt_vendor_last_reported_Invalid 			= 0 and
																								 dt_first_seen_Invalid 								= 0 and
																								 dt_last_seen_Invalid 								= 0 and
																								 corp_ra_dt_first_seen_Invalid 				= 0 and
																								 corp_ra_dt_last_seen_Invalid 				= 0 and
																								 corp_key_Invalid 										= 0 and
																								 corp_vendor_Invalid 									= 0 and
																								 corp_state_origin_Invalid 						= 0 and
																								 corp_process_date_Invalid 						= 0 and
																								 corp_orig_sos_charter_nbr_Invalid 		= 0 and
																								 corp_legal_name_Invalid 							= 0 and
																								 corp_ln_name_type_cd_Invalid 				= 0 and
																								 corp_ln_name_type_desc_Invalid 			= 0 and
																								 corp_status_cd_Invalid 							= 0 and
																								 corp_status_desc_Invalid 						= 0 and
																								 corp_status_date_Invalid 						= 0 and
																								 corp_inc_state_Invalid 							= 0 and
																								 corp_inc_date_Invalid 								= 0 and
																								 corp_foreign_domestic_ind_Invalid 		= 0 and
																								 corp_forgn_state_cd_Invalid 					= 0 and
																								 corp_forgn_state_desc_Invalid 				= 0 and
																								 corp_forgn_date_Invalid 							= 0 and
																								 corp_orig_org_structure_cd_Invalid 	= 0 and
																								 corp_orig_org_structure_desc_Invalid = 0 and
																								 corp_for_profit_ind_Invalid 					= 0 and
																								 cont_title1_desc_Invalid 						= 0 and
																								 cont_status_cd_Invalid								= 0 and
																								 corp_agent_status_cd_Invalid 				= 0 and
																								 InternalField1_Invalid 							= 0 and
																								 InternalField2_Invalid 							= 0 and
																								 recordorigin_Invalid 								= 0
																						 );
			
			Main_FailBuild	:= map( Corp2_Mapping.fCalcPercent (count(Main_N.ExpandedInFile(corp_key_invalid<>0)),count(Main_N.ExpandedInFile),false) 									 > Scrubs_Corp2_Mapping_ID_Main.Threshold_Percent.CORP_KEY										   => true,
															Corp2_Mapping.fCalcPercent (count(Main_N.ExpandedInFile(corp_orig_sos_charter_nbr_invalid<>0)),count(Main_N.ExpandedInFile),false) 	 > Scrubs_Corp2_Mapping_ID_Main.Threshold_Percent.CORP_ORIG_SOS_CHARTER_NBR 	   => true,
															Corp2_Mapping.fCalcPercent (count(Main_N.ExpandedInFile(corp_legal_name_invalid<>0)),count(Main_N.ExpandedInFile),false) 						 > Scrubs_Corp2_Mapping_ID_Main.Threshold_Percent.CORP_LEGAL_NAME 						   => true,
															count(Main_GoodRecords) = 0																																																																																											 => true,																		
															false
														);

			Main_ApprovedRecords := project(Main_GoodRecords,transform(Corp2_Mapping.LayoutsCommon.Main,self := left));
			
		 //==========================================VERSION CONTROL====================================================
			VersionControl.macBuildNewLogicalFile(Corp2_Mapping._Dataset().thor_cluster_Files + 'in::corp2::'+version+'::main_'+ state_origin,Main_ApprovedRecords,corp_out,,,pOverwrite);
			VersionControl.macBuildNewLogicalFile(Corp2_Mapping._dataset().thor_cluster_Files + 'fail::corp2::'+version+'::Main_'+ state_origin	,Main_F	 ,write_fail_main  ,,,pOverwrite); 
			Main_RejFile_Exists		:=IF(FileServices.FileExists(Corp2_Mapping._dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::main_' + state_origin),true,false);			
			
			run_Main := 	sequential( IF( pshouldspray = TRUE,Corp2_mapping.fSprayFiles(state_origin ,version,pOverwrite := pOverwrite))
																//,Corp2_Raw_ID.Build_Bases(filedate,version,pUseProd).All  // Determined building of bases is not needed
																,corp_out
																,IF( Main_FailBuild <> true
																		 ,sequential(	fileservices.addsuperfile(Corp2_Mapping._Dataset().thor_cluster_Files + 'in::'+Corp2_Mapping._Dataset().NameMapped+'::sprayed::main',Corp2_Mapping._Dataset().thor_cluster_Files + 'in::corp2::'+version+'::main_ID')
																									,IF ( count(Main_BadRecords) <> 0
																														 ,Corp2_Mapping.Send_Email(state_origin ,version,count(Main_BadRecords)<>0,,,,count(Main_BadRecords),,,,count(Main_ApprovedRecords),,,).RecordsRejected																				 
																														 ,Corp2_Mapping.Send_Email(state_origin ,version,count(Main_BadRecords)<>0,,,,count(Main_BadRecords),,,,count(Main_ApprovedRecords),,,).MappingSuccess		
																										  )
																								)   
																			,sequential(write_fail_main 
																									,Corp2_Mapping.Send_Email(state_origin ,version).MappingFailed
																								 )
																		)
																	,sequential(IF(count(Main_BadRecords) <> 0
																									,IF (poverwrite
																												,OUTPUT(Main_BadRecords,,Corp2_Mapping._Dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::main_ID',overwrite,__compressed__,named('Sample_Rejected_MainRecs_ID'+filedate))
																												,sequential (IF(Main_RejFile_Exists,fileservices.deletelogicalfile(Corp2_Mapping._dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::main_'+ state_origin)),
																																		 OUTPUT(Main_BadRecords,,Corp2_Mapping._Dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::main_'+ state_origin,__compressed__,named('Sample_Rejected_MainRecs_ID'+filedate))
																																		 )
																											)
																									)
																							)
																 ,IF(Main_IsScrubErrors
																		 ,Corp2_Mapping.Send_Email(state_origin ,version,Main_IsScrubErrors,false,false,false).FieldsInvalidPerScrubs																				 
																		 )	
																	,IF(COUNT(Main_ScrubsAlert) > 0, 	Main_SendEmailFile, OUTPUT('CORP2_MAPPING.ID - No Corp Scrubs Alerts'))		
																	,output(Main_ScrubsWithExamples, ALL, NAMED('CorpMainScrubsReportWithExamples_ID'+filedate)) //Send Alerts if Scrubs exceeds thresholds
																	,Main_ErrorSummary
																	,Main_ScrubErrorReport																					
																	,Main_SomeErrorValues
																	//,Main_AlertsCSVTemplate
																	,Main_SubmitStats	
													    );
														
			//Validating the filedate entered is within 30 days												
			isFileDateValid := if((string)Std.Date.Today() between ut.date_math(filedate,-30) and ut.date_math(filedate,30),true,false);
			result		 			:= if(isFileDateValid
														,run_Main 
														,sequential (Corp2_Mapping.Send_Email(state_origin ,filedate).InvalidFileDateParm
																				 ,FAIL('Corp2_Mapping.ID failed. An invalid filedate was passed in as a parameter.')
																				 )
															
														);

			return result ;
			
	end;

end;	