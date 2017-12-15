import corp2,corp2_mapping,corp2_raw_sc,scrubs,scrubs_corp2_mapping_sc_event,scrubs_corp2_mapping_sc_main,std,tools,ut,versioncontrol; 			 

export SC := MODULE;
	
	export Update(string fileDate, string version, boolean pShouldSpray = _Dataset().bShouldSpray, boolean pOverwrite = false, boolean pUseProd = Tools._Constants.IsDataland) := Function

		state_origin			 			:= 'SC';
		state_fips	 				 		:= '45';
		state_desc	 			 			:= 'SOUTH CAROLINA';

		CorpFile			 					:= dedup(sort(distribute(Corp2_Raw_SC.Files(fileDate,puseprod).input.CorpFile.Logical,hash(corpid)),record,local),record,local) 		: independent;
		CorpName			 					:= dedup(sort(distribute(Corp2_Raw_SC.Files(fileDate,puseprod).input.CorpName.Logical,hash(corpdbid)),record,local),record,local) 	: independent;
		CorpTXN			 						:= dedup(sort(distribute(Corp2_Raw_SC.Files(fileDate,puseprod).input.CorpTXN.Logical,hash(corpdbid)),record,local),record,local) 		: independent;
		NameTypes							  := ['ASM','FIC','FMR','REG','RES','UNAVAILABLE'];

		IsAddressWithWrongState := corp2.t2u(CorpFile.agentaddress1) <> '' and corp2.t2u(CorpFile.agentaddress2) <> '' and corp2.t2u(CorpFile.agentcity) = '';
		IsAddressInOneField		  := corp2.t2u(CorpFile.agentaddress1) <> '' and corp2.t2u(CorpFile.agentaddress2+CorpFile.agentcity) = '';
		IsAddressWithZipInCity  := CorpFile.agentaddress1 <> '' and CorpFile.agentcity <> '' and stringlib.stringfilter(CorpFile.agentcity,'0123456789') <> '';
		BadAddrInOneField				:= CorpFile(IsAddressInOneField) 			: independent; //The entire address is in agentaddress1
		BadAddrWrongState				:= CorpFile(IsAddressWithWrongState) 	: independent; //The correct state is in agentaddress2 and not agentcity
		BadAddrWithZipInCity		:= CorpFile(IsAddressWithZipInCity) 	: independent; //The city contains the city, state & zip
																																								 //Note: the agentstate seems to be defaulting to SC & doesn't always match the state located in the other fields)
		
		GoodAddresses						:= CorpFile(Not(IsAddressInOneField) and Not(IsAddressWithWrongState) and Not(IsAddressWithZipInCity));

		CorpCleanIncState	  	  := project(GoodAddresses, 
																			 transform(Corp2_Raw_SC.Layouts.CorpFileLayoutIn,
																								 self.incstate			:= Corp2_Raw_SC.Functions.State_or_Country(left.incstate);
																								 self 							:= left;
																								)
																			);
																			
		CorpFixedAddrInOneField := project(BadAddrInOneField, 
																			 transform(Corp2_Raw_SC.Layouts.CorpFileLayoutIn,
																								 self.agentaddress1 := Corp2_Raw_SC.Functions.Address(state_origin,state_desc,left.agentaddress1).addr;
																								 self.agentaddress2 := '';																								 
																								 self.agentcity 		:= Corp2_Raw_SC.Functions.Address(state_origin,state_desc,left.agentaddress1).city;
																								 self.agentstate		:= Corp2_Raw_SC.Functions.Address(state_origin,state_desc,left.agentaddress1).state;
																								 self.agentzip		  := Corp2_Raw_SC.Functions.Address(state_origin,state_desc,left.agentaddress1).zip;
																								 self.incstate			:= Corp2_Raw_SC.Functions.State_or_Country(left.incstate);
																								 self 							:= left;
																								)
																			);
																			
		CorpFixedAddrWrongState := project(BadAddrWrongState, 
																			 transform(Corp2_Raw_SC.Layouts.CorpFileLayoutIn,
																								 self.agentaddress1 := Corp2_Raw_SC.Functions.Address(state_origin,state_desc,left.agentaddress1+', '+left.agentaddress2).addr;
																								 self.agentaddress2 := '';
																								 self.agentcity 		:= Corp2_Raw_SC.Functions.Address(state_origin,state_desc,left.agentaddress1+', '+left.agentaddress2).city;
																								 self.agentstate		:= Corp2_Raw_SC.Functions.Address(state_origin,state_desc,left.agentaddress1+', '+left.agentaddress2).state;
																								 self.agentzip		  := Corp2_Raw_SC.Functions.Address(state_origin,state_desc,left.agentaddress1+', '+left.agentaddress2).zip;
																								 self.incstate			:= Corp2_Raw_SC.Functions.State_or_Country(left.incstate);
																								 self 							:= left;
																								)
																			);
																			
		CorpFixedAddrZipInCity  := project(BadAddrWithZipInCity, 
																			 transform(Corp2_Raw_SC.Layouts.CorpFileLayoutIn,
																								 self.agentaddress1 := Corp2_Raw_SC.Functions.Address(state_origin,state_desc,left.agentaddress1+', '+left.agentaddress2+', '+left.agentcity).addr;
																								 self.agentaddress2 := '';
																								 self.agentcity 		:= Corp2_Raw_SC.Functions.Address(state_origin,state_desc,left.agentaddress1+', '+left.agentaddress2+', '+left.agentcity).city;
																								 self.agentstate		:= Corp2_Raw_SC.Functions.Address(state_origin,state_desc,left.agentaddress1+', '+left.agentaddress2+', '+left.agentcity).state;
																								 self.agentzip		  := Corp2_Raw_SC.Functions.Address(state_origin,state_desc,left.agentaddress1+', '+left.agentaddress2+', '+left.agentcity).zip;
																								 self.incstate			:= Corp2_Raw_SC.Functions.State_or_Country(left.incstate);
																								 self 							:= left;
																								)
																			);
																			
		CorpFileFixed						:= CorpFixedAddrInOneField + CorpFixedAddrWrongState + CorpFixedAddrZipInCity + CorpCleanIncState;

		CorpFileCorpName	  		:= join(CorpFileFixed, CorpName,
																		corp2.t2u(left.corpid) 		= corp2.t2u(right.corpdbid) and corp2.t2u(right.associatedname) <> '',
																		transform(Corp2_Raw_SC.Layouts.TempCorpFileCorpNameLayoutIn,
																							self.corptypecode 		:= if(corp2.t2u(left.corpname) = corp2.t2u(right.associatedname) and right.associatedtype in ['ASM','FIC','FMR'],right.associatedtype,left.corptypecode);
																							self 									:= left;																																							 
																							self 									:= right;
																						 ),
																		left outer,
																		local
																	 );
																	 
		//********************************************************************
		// MAP MAIN
		//********************************************************************
		Corp2_mapping.LayoutsCommon.Main CorpFileTransform(Corp2_Raw_SC.Layouts.TempCorpFileCorpNameLayoutIn l) := transform
				self.dt_vendor_first_reported							:= (integer)filedate;
				self.dt_vendor_last_reported							:= (integer)filedate;
				self.dt_first_seen												:= (integer)filedate;
				self.dt_last_seen													:= (integer)filedate;
				self.corp_ra_dt_first_seen								:= (integer)filedate;
				self.corp_ra_dt_last_seen									:= (integer)filedate;			
				self.corp_key															:= state_fips + '-' + corp2.t2u(l.corpid);
				self.corp_vendor													:= state_fips;
				self.corp_state_origin										:= state_origin;			
				self.corp_process_date										:= filedate;		
				self.corp_orig_sos_charter_nbr 						:= corp2.t2u(l.corpid);
				self.corp_legal_name 											:= Corp2_Mapping.fCleanBusinessName(state_origin,state_desc,l.corpname).BusinessName;
				self.corp_ln_name_type_cd									:= Corp2_Raw_SC.Functions.CorpLNNameTypeCD(l.corptypecode); // Per CI: DO NOT MAP when AssociatedType/'UNAVAILABLE' , can have blank type_cd & desc
				self.corp_ln_name_type_desc								:= Corp2_Raw_SC.Functions.CorpLNNameTypeDesc(l.corptypecode);
				self.corp_filing_date											:= Corp2_Mapping.fValidateDate(l.effectivefilingdate,'CCYYMMDD').PastDate;
				self.corp_filing_desc											:= if(self.corp_filing_date <> '','EFFECTIVE','');
				self.corp_status_cd												:= corp2.t2u(l.corporationstatus);
				self.corp_status_desc											:= Corp2_Raw_SC.Functions.CorpStatusDesc(l.corporationstatus);
				//This is an overloaded field until corp_dissolved_date is customer facing.
				self.corp_status_date											:= Corp2_Mapping.fValidateDate(l.dissolveddate,'CCYYMMDD').PastDate;
				self.corp_standing												:= if(corp2.t2u(l.corporationstatus) = 'GDS','Y','');
				self.corp_inc_state												:= state_origin;
				self.corp_inc_date												:= if(corp2.t2u(l.domforcode) = '1',Corp2_Mapping.fValidateDate(l.originalfilingdate,'CCYYMMDD').PastDate,'');
				self.corp_term_exist_cd										:= map(corp2.t2u(l.expirationdate) = '' 																		      => 'P',
																												 Corp2_Mapping.fValidateDate(l.expirationdate,'CCYYMMDD').GeneralDate <> '' => 'D',
																												 '');
				self.corp_term_exist_exp									:= Corp2_Mapping.fValidateDate(l.expirationdate,'CCYYMMDD').GeneralDate;
				self.corp_term_exist_desc									:= map(self.corp_term_exist_cd = 'D' => 'EXPIRATION DATE',
																												 self.corp_term_exist_cd = 'P' => 'PERPETUAL',
																												 '');
				self.corp_foreign_domestic_ind						:= map(corp2.t2u(l.domforcode) = '1' => 'D',
																												 corp2.t2u(l.domforcode) = '2' => 'F',
																												 '');	
				self.corp_forgn_state_cd            			:= if(corp2.t2u(l.domforcode) = '2' and corp2.t2u(l.incstate) not in [state_origin,state_desc,''],Corp2_Raw_SC.Functions.CorpForgnStateCD(l.incstate),'');
				self.corp_forgn_state_desc          			:= if(corp2.t2u(l.domforcode) = '2' and corp2.t2u(l.incstate) not in [state_origin,state_desc,''],Corp2_Raw_SC.Functions.CorpForgnStateDesc(l.incstate),'');
				self.corp_forgn_date	            				:= if(corp2.t2u(l.domforcode) = '2',Corp2_Mapping.fValidateDate(l.originalfilingdate,'CCYYMMDD').PastDate,'');
				self.corp_orig_org_structure_cd						:= Corp2_Raw_SC.Functions.CorpOrigOrgStructureCD(l.corptypecode);
				self.corp_orig_org_structure_desc					:= Corp2_Raw_SC.Functions.CorpOrigOrgStructureDesc(l.corptypecode);
				self.corp_for_profit_ind									:= Corp2_Raw_SC.Functions.CorpForProfitInd(l.corptypecode);
				self.corp_ra_full_name										:= Corp2_Mapping.fCleanBusinessName(state_origin,state_desc,Corp2_Raw_SC.Functions.CorpRAFullName(l.agentname)).BusinessName;
				self.corp_ra_addl_info   									:= Corp2_Raw_SC.Functions.CorpRAAddlInfo(l.agentname);
				self.corp_ra_address_type_cd							:= if(Corp2_Mapping.fAddressExists(state_origin,state_desc,l.agentaddress1,l.agentaddress2,l.agentcity,l.agentstate,l.agentzip).ifAddressExists,'R','');
				self.corp_ra_address_type_desc						:= if(Corp2_Mapping.fAddressExists(state_origin,state_desc,l.agentaddress1,l.agentaddress2,l.agentcity,l.agentstate,l.agentzip).ifAddressExists,'REGISTERED OFFICE','');
				self.corp_ra_address_line1								:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.agentaddress1,l.agentaddress2,l.agentcity,l.agentstate,l.agentzip).AddressLine1;
				self.corp_ra_address_line2				 				:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.agentaddress1,l.agentaddress2,l.agentcity,l.agentstate,l.agentzip).AddressLine2;
				self.corp_ra_address_line3				 				:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.agentaddress1,l.agentaddress2,l.agentcity,l.agentstate,l.agentzip).AddressLine3;
				self.ra_prep_addr_line1										:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.agentaddress1,l.agentaddress2,l.agentcity,l.agentstate,l.agentzip).PrepAddrLine1;
				self.ra_prep_addr_last_line								:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.agentaddress1,l.agentaddress2,l.agentcity,l.agentstate,l.agentzip).PrepAddrLastLine;
				self.corp_agent_status_desc								:= if(stringlib.stringfind(corp2.t2u(l.agentname),'AGENT RESIGNED',1)<>0,corp2.t2u(l.agentname),'');
				self.corp_country_of_formation						:= map(Corp2_Raw_SC.Functions.Valid_US_State(l.incstate) 			 			=> 	'US',
																												 Corp2_Raw_SC.Functions.Country_Description(l.incstate) <> ''	=>	Corp2_Raw_SC.Functions.Country_Description(l.incstate),																												 
																												 corp2.t2u(l.incstate)
																												);
				self.corp_dissolved_date									:= Corp2_Mapping.fValidateDate(l.dissolveddate,'CCYYMMDD').PastDate;
				self.recordorigin													:= 'C';
				self 																			:= [];
						
		end;
		
		MapCorpMaster				:= project(CorpFileCorpName, CorpFileTransform(left));
															 
		Corp2_mapping.LayoutsCommon.Main CorpNameTransform(Corp2_Raw_SC.Layouts.TempCorpFileCorpNameLayoutIn l) := transform,
		skip (corp2.t2u(l.associatedtype) not in NameTypes)
				self.dt_vendor_first_reported							:= (integer)filedate;
				self.dt_vendor_last_reported							:= (integer)filedate;
				self.dt_first_seen												:= (integer)filedate;
				self.dt_last_seen													:= (integer)filedate;
				self.corp_ra_dt_first_seen								:= (integer)filedate;
				self.corp_ra_dt_last_seen									:= (integer)filedate;			
				self.corp_key															:= state_fips + '-' + corp2.t2u(l.corpdbid);
				self.corp_vendor													:= state_fips;
				self.corp_state_origin										:= state_origin;			
				self.corp_process_date										:= filedate;		
				self.corp_orig_sos_charter_nbr 						:= corp2.t2u(l.corpdbid);
				self.corp_legal_name 											:= Corp2_Mapping.fCleanBusinessName(state_origin,state_desc,l.associatedname).BusinessName;
				self.corp_ln_name_type_cd									:= Corp2_Raw_SC.Functions.CorpLNNameTypeCD_AT(l.associatedtype);
				self.corp_ln_name_type_desc								:= Corp2_Raw_SC.Functions.CorpLNNameTypeDesc_AT(l.associatedtype);
				self.corp_inc_state												:= state_origin;				
				self.corp_term_exist_cd										:= if(corp2.t2u(l.associatedtype) <> 'RES',
																												map(Corp2_Mapping.fValidateDate(l.expirationdt,'CCYYMMDD').GeneralDate <> '' => 'D',
																														corp2.t2u(l.expirationdt) = ''																			     => 'P',
																														''
																													 ),
																												''
																											 );
				self.corp_term_exist_exp									:= if(corp2.t2u(l.associatedtype) <> 'RES',Corp2_Mapping.fValidateDate(l.expirationdt,'CCYYMMDD').GeneralDate,'');
				self.corp_term_exist_desc									:= if(corp2.t2u(l.associatedtype) <> 'RES',
																												map(self.corp_term_exist_cd = 'D'	=> 'EXPIRATION DATE',
																														self.corp_term_exist_cd = 'P'	=> 'PERPETUAL',
																														''
																													 ),
																												''
																											 );
				self.corp_name_reservation_expiration_date:= if(corp2.t2u(l.associatedtype) = 'RES',Corp2_Mapping.fValidateDate(l.expirationdt,'CCYYMMDD').GeneralDate,'');
				self.corp_inc_date												:= if(corp2.t2u(l.domforcode) = '1',Corp2_Mapping.fValidateDate(l.originalfilingdate,'CCYYMMDD').PastDate,'');
		    self.corp_forgn_date	            				:= if(corp2.t2u(l.domforcode) = '2',Corp2_Mapping.fValidateDate(l.originalfilingdate,'CCYYMMDD').PastDate,'');
				self.recordorigin													:= 'C';				
				self																			:= [];
		end;


		DONOTMAP						:= corp2.t2u(CorpFileCorpName.associatedname) = corp2.t2u(CorpFileCorpName.corpname); 
		RemovedInvalidNames	:= CorpFileCorpName(not(DONOTMAP));
		ValidCorpNames			:= RemovedInvalidNames(associatedtype in NameTypes);
		MapCorpName					:= project(ValidCorpNames, CorpNameTransform(left));

		AllMain							:= dedup(sort(distribute(MapCorpMaster + MapCorpName, hash(corp_key)),record,local),record,local) : independent;

		Corp2_Mapping.LayoutsCommon.Main RollUpMain(Corp2_Mapping.LayoutsCommon.Main l, Corp2_Mapping.LayoutsCommon.Main r) := transform
			ra_address_exists									:= if(corp2.t2u(l.corp_ra_address_line1+l.corp_ra_address_line2+l.corp_ra_address_line3)<>'',true,false);
			self.corp_filing_date							:= if(l.corp_filing_date<>'',l.corp_filing_date,r.corp_filing_date);
			self.corp_filing_desc							:= if(l.corp_filing_desc<>'',l.corp_filing_desc,r.corp_filing_desc);
			self.corp_status_cd								:= if(l.corp_status_cd<>'',l.corp_status_cd,r.corp_status_cd);
			self.corp_status_desc							:= if(l.corp_status_desc<>'',l.corp_status_desc,r.corp_status_desc);
			self.corp_standing								:= if(l.corp_standing<>'',l.corp_standing,r.corp_standing);
			self.corp_inc_date								:= if(l.corp_inc_date<>'',l.corp_inc_date,r.corp_inc_date);
			self.corp_foreign_domestic_ind		:= if(l.corp_foreign_domestic_ind<>'',l.corp_foreign_domestic_ind,r.corp_foreign_domestic_ind);
			self.corp_orig_org_structure_cd		:= if(l.corp_orig_org_structure_cd<>'',l.corp_orig_org_structure_cd,r.corp_orig_org_structure_cd);
			self.corp_orig_org_structure_desc	:= if(l.corp_orig_org_structure_desc<>'',l.corp_orig_org_structure_desc,r.corp_orig_org_structure_desc);
			self.corp_for_profit_ind					:= if(l.corp_for_profit_ind<>'',l.corp_for_profit_ind,r.corp_for_profit_ind);
			self.corp_ra_full_name						:= if(l.corp_ra_full_name<>'',l.corp_ra_full_name,r.corp_ra_full_name);
			self.corp_ra_address_type_cd			:= if(ra_address_exists,l.corp_ra_address_type_cd,r.corp_ra_address_type_cd);
			self.corp_ra_address_type_desc		:= if(ra_address_exists,l.corp_ra_address_type_desc,r.corp_ra_address_type_desc);
			self.corp_ra_address_line1				:= if(ra_address_exists,l.corp_ra_address_line1,r.corp_ra_address_line1);
			self.corp_ra_address_line2				:= if(ra_address_exists,l.corp_ra_address_line2,r.corp_ra_address_line2);
			self.corp_ra_address_line3				:= if(ra_address_exists,l.corp_ra_address_line3,r.corp_ra_address_line3);
			self.ra_prep_addr_line1						:= if(ra_address_exists,l.ra_prep_addr_line1,r.ra_prep_addr_line1);
			self.ra_prep_addr_last_line				:= if(ra_address_exists,l.ra_prep_addr_last_line,r.ra_prep_addr_last_line);								
			self.corp_country_of_formation		:= if(l.corp_country_of_formation<>'',l.corp_country_of_formation,r.corp_country_of_formation);
			self 															:= l;
		end; 
		
		MapMain 				:= rollup( AllMain
															,RollUpMain(left, right)
															,except 
															 corp_filing_date
															,corp_filing_desc
															,corp_status_cd
															,corp_status_desc
															,corp_standing
															,corp_inc_date
															,corp_foreign_domestic_ind
															,corp_orig_org_structure_cd
															,corp_orig_org_structure_desc
															,corp_for_profit_ind
															,corp_ra_full_name
															,corp_ra_address_type_cd
															,corp_ra_address_type_desc
															,corp_ra_address_line1
															,corp_ra_address_line2
															,corp_ra_address_line3
															,ra_prep_addr_line1
															,ra_prep_addr_last_line
															,corp_country_of_formation
															,local
														 );

		//********************************************************************
		// MAP EVENTS
		//********************************************************************
		Corp2_mapping.LayoutsCommon.Events CorpTXNTransform(Corp2_Raw_SC.Layouts.TempCorpTXNLayout  l):=transform,
		skip(corp2.t2u(l.tranid)='LAR')	
				self.corp_key															:= state_fips + '-' + corp2.t2u(l.corpdbid);
				self.corp_vendor													:= state_fips;
				self.corp_state_origin										:= state_origin;			
				self.corp_process_date										:= filedate;
				self.corp_sos_charter_nbr									:= corp2.t2u(l.corpdbid);
				self.event_filing_date										:= Corp2_Mapping.fValidateDate(l.fileddate,'CCYY-MM-DD').PastDate;
				self.event_filing_cd											:= corp2.t2u(l.tranid);//scrubbing !
				self.event_filing_desc										:= Corp2_Raw_SC.Functions.EventFilingDesc(l.tranid,l.corptypecode);//scrubbing !
        self.event_desc														:= if(self.event_filing_desc = corp2.t2u(l.trncomment),'',corp2.t2u(l.trncomment));
				self																			:= [];
		end;

		CorpFileCorpTXN 	  := join(CorpFile, CorpTXN,
																corp2.t2u(left.corpid) = corp2.t2u(right.corpdbid),
																transform(Corp2_Raw_SC.Layouts.TempCorpTXNLayout,
																          self.corptypecode := corp2.t2u(left.corptypecode);
																					self 						  := right;
																				 ),
																inner,local):independent;

		CorpTXNMapped	:= project(CorpFileCorpTXN, CorpTXNTransform(left));
		MapCorpTXN		:= CorpTXNMapped(corp2.t2u(event_filing_date + event_filing_cd + event_filing_desc + event_desc)<>'');

		MapEvent			:= dedup(sort(distribute(MapCorpTXN, hash(corp_key)),record,local),record,local) : independent;
		
		//********************************************************************
		// MAP AR
		//********************************************************************
		Corp2_mapping.LayoutsCommon.AR CorpARTransform(Corp2_Raw_SC.Layouts.TempCorpTXNLayout l):=transform,
		skip(corp2.t2u(l.tranid)<>'LAR')
				self.corp_key															:= state_fips + '-' + corp2.t2u(l.corpdbid);
				self.corp_vendor													:= state_fips;
				self.corp_state_origin										:= state_origin;			
				self.corp_process_date										:= filedate;
				self.corp_sos_charter_nbr									:= corp2.t2u(l.corpdbid);
				self.ar_filed_dt													:= Corp2_Mapping.fValidateDate(l.fileddate,'CCYY-MM-DD').PastDate;
				self.ar_type															:= corp2.t2u(l.tranid);
				self.ar_comment														:= 'LLC ANNUAL REPORT';
				self																			:= [];
		end;
		
		CorpARMapped	:= project(CorpFileCorpTXN, CorpARTransform(left));	
		MapAR					:= dedup(sort(distribute(CorpARMapped, hash(corp_key)),record,local),record,local) : independent;
		
		//********************************************************************
		// SCRUB EVENT
		//********************************************************************	
		Event_F 									:= MapEvent;
		Event_S 									:= Scrubs_Corp2_Mapping_SC_Event.Scrubs;						// Scrubs module
		Event_N 									:= Event_S.FromNone(Event_F); 											// Generate the error flags
		Event_T 									:= Event_S.FromBits(Event_N.BitmapInfile);     			// Use the FromBits module; makes my bitmap datafile easier to get to
		Event_U 									:= Event_S.FromExpanded(Event_N.ExpandedInFile); 		// Pass the expanded error flags into the Expanded module
		
		//Outputs reports
		Event_ErrorSummary				:= output(Event_U.SummaryStats, named('Event_ErrorSummary_SC'+filedate));
		Event_ScrubErrorReport 		:= output(choosen(Event_U.AllErrors, 1000), named('Event_ScrubErrorReport_SC'+filedate));
		Event_SomeErrorValues			:= output(choosen(Event_U.BadValues, 1000), named('Event_SomeErrorValues_SC'+filedate));
		Event_IsScrubErrors		 		:= if(count(Event_U.AllErrors)<> 0,true,false);

		// Orbit Stats
		Event_OrbitStats					:= Event_U.OrbitStats();

		//Outputs files
		Event_CreateBitMaps				:= output(Event_N.BitmapInfile,,'~thor_data::corp_SC_event_scrubs_bits',overwrite,compressed);	//long term storage
		Event_TranslateBitMap			:= output(Event_T);

		//Creates Profile's alert template for Orbit - Can be copied & imported into Orbit; Only required first time & if scrub rules change
		Event_AlertsCSVTemplate	  := Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_'+ state_origin+'_Event','ScrubsAlerts', Event_OrbitStats, version,'Corp2_'+ state_origin+'_Event').ProfileAlertsTemplate;
		//Submits Profile's stats to Orbit
		Event_SubmitStats 				:= Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_'+ state_origin+'_Event','ScrubsAlerts', Event_OrbitStats, version,'Corp2_'+ state_origin+'_Event').SubmitStats;

		Event_ScrubsWithExamples	:= Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_'+ state_origin+'_Event','ScrubsAlerts', Event_OrbitStats, version,'Corp2_'+ state_origin+'_Event').CompareToProfile_with_Examples;
		Event_ScrubsAlert					:= Event_ScrubsWithExamples(RejectWarning = 'Y');
		Event_ScrubsAttachment		:= Scrubs.fn_email_attachment(Event_ScrubsAlert);
		Event_MailFile						:= FileServices.SendEmailAttachData(corp2.Email_Notification_Lists.spray
																																 ,'Scrubs CorpEvent_SC Report' //subject
																																 ,'Scrubs CorpEvent_SC Report' //body
																																 ,(data)Event_ScrubsAttachment
																																 ,'text/csv'
																																 ,'CorpSCEventScrubsReport.csv'
																																 ,
																																 ,
																																 ,corp2.Email_Notification_Lists.spray);

		Event_BadRecords				 	:= Event_N.ExpandedInFile(corp_key_Invalid							  			<> 0 or
																												corp_vendor_Invalid 									<> 0 or																						
																												corp_state_origin_Invalid 					 	<> 0 or
																												corp_process_date_Invalid							<> 0 or
																												corp_sos_charter_nbr_Invalid 					<> 0 or
																												event_filing_date_Invalid 						<> 0 or
																												event_filing_cd_Invalid 							<> 0 or
																												event_filing_desc_Invalid             <> 0
																											 );
																										 																	
		Event_GoodRecords					:= Event_N.ExpandedInFile(corp_key_Invalid							  			= 0 and
																												corp_vendor_Invalid 									= 0 and																				
																												corp_state_origin_Invalid 					 	= 0 and
																												corp_process_date_Invalid						  = 0 and
																												corp_sos_charter_nbr_Invalid 					= 0 and
																												event_filing_date_Invalid							= 0 and																															 
																												event_filing_cd_Invalid								= 0 and
																												event_filing_desc_Invalid             = 0
																											);

		Event_FailBuild					  := if(count(Event_GoodRecords) = 0,true,false);

		Event_ApprovedRecords			:= project(Event_GoodRecords,transform(Corp2_Mapping.LayoutsCommon.Events,self := left));		

		Event_ALL									:= sequential(if(count(Event_BadRecords) <> 0
																											,if(poverwrite
																													,output(Event_BadRecords,,Corp2_Mapping._Dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::event_'+state_origin,overwrite,__compressed__)
																													,output(Event_BadRecords,,Corp2_Mapping._Dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::event_'+state_origin,__compressed__)
																													)
																											)
																						 ,output(Event_ScrubsWithExamples, all, named('CorpEventSCScrubsReportWithExamples'+filedate))
																						 //Send Alerts if Scrubs exceeds thresholds
																						 ,if(count(Event_ScrubsAlert) > 0, Event_MailFile, output('CORP2_MAPPING.SC - No "EVENT" Corp Scrubs Alerts'))
																						 ,Event_ErrorSummary
																						 ,Event_ScrubErrorReport
																						 ,Event_SomeErrorValues	
																						 //,Event_AlertsCSVTemplate
																						 ,Event_SubmitStats
																					);

		//********************************************************************
		// SCRUB MAIN
		//********************************************************************	
		Main_F 										:= MapMain;
		Main_S 										:= Scrubs_Corp2_Mapping_SC_Main.Scrubs;					// Scrubs module
		Main_N 										:= Main_S.FromNone(Main_F); 										// Generate the error flags
		Main_T 										:= Main_S.FromBits(Main_N.BitmapInfile);     		// Use the FromBits module; makes my bitmap datafile easier to get to
		Main_U 										:= Main_S.FromExpanded(Main_N.ExpandedInFile); 	// Pass the expanded error flags into the Expanded module

		//Outputs reports
		Main_ErrorSummary					:= output(Main_U.SummaryStats, named('Main_ErrorSummary_SC'+filedate));
		Main_ScrubErrorReport 		:= output(choosen(Main_U.AllErrors, 1000), named('Main_ScrubErrorReport_SC'+filedate));
		Main_SomeErrorValues			:= output(choosen(Main_U.BadValues, 1000), named('Main_SomeErrorValues_SC'+filedate));
		Main_IsScrubErrors		 		:= if(count(Main_U.AllErrors)<> 0,true,false);

		// Orbit Stats
		Main_OrbitStats						:= Main_U.OrbitStats();

		//Outputs files
		Main_CreateBitMaps				:= output(Main_N.BitmapInfile,,'~thor_data::corp_sc_main_scrubs_bits',overwrite,compressed);	//long term storage
		Main_TranslateBitMap			:= output(Main_T);

		//Creates Profile's alert template for Orbit - can be copied and imported into Orbit; Only required if rules in Orbit change
		Main_AlertsCSVTemplate		:= Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_'+state_origin+'_Main','ScrubsAlerts', Main_OrbitStats, version,'Corp2_'+state_origin+'_Main').ProfileAlertsTemplate;
		//Submits Profile's stats to Orbit
		Main_SubmitStats 			  	:= Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_'+state_origin+'_Main','ScrubsAlerts', Main_OrbitStats, version,'Corp2_'+state_origin+'_Main').SubmitStats;
		Main_ScrubsWithExamples		:= Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_'+state_origin+'_Main','ScrubsAlerts', Main_OrbitStats, version,'Corp2_'+state_origin+'_Main').CompareToProfile_with_Examples;
		Main_ScrubsAlert					:= Main_ScrubsWithExamples(RejectWarning = 'Y');
		Main_ScrubsAttachment			:= Scrubs.fn_email_attachment(Main_ScrubsAlert);
		Main_MailFile							:= FileServices.SendEmailAttachData( corp2.Email_Notification_Lists.spray
																																	 ,'Scrubs CorpMain_SC Report' //subject
																																	 ,'Scrubs CorpMain_SC Report' //body
																																	 ,(data)Main_ScrubsAttachment
																																	 ,'text/csv'
																																	 ,'CorpSCMainScrubsReport.csv'
																																	 ,
																																	 ,
																																	 ,corp2.Email_Notification_Lists.spray);

		Main_BadRecords						:= Main_N.ExpandedInFile(dt_vendor_first_reported_Invalid 			<> 0 or
																											 dt_vendor_last_reported_Invalid 				<> 0 or
																											 dt_first_seen_Invalid 									<> 0 or
																											 dt_last_seen_Invalid 									<> 0 or
																											 corp_ra_dt_first_seen_Invalid 					<> 0 or
																											 corp_ra_dt_last_seen_Invalid 					<> 0 or
																											 corp_key_Invalid 											<> 0 or
																											 corp_supp_key_Invalid									<> 0 or
																											 corp_vendor_Invalid 										<> 0 or
																											 corp_state_origin_Invalid 					 		<> 0 or
																											 corp_process_date_Invalid						  <> 0 or
																											 corp_orig_sos_charter_nbr_Invalid 			<> 0 or
																											 corp_legal_name_Invalid 								<> 0 or																								 
																											 corp_ln_name_type_cd_Invalid 					<> 0 or
																											 corp_ln_name_type_desc_Invalid 				<> 0 or
																											 corp_status_cd_Invalid 								<> 0 or																										 
																											 corp_standing_Invalid 									<> 0 or
																											 corp_inc_state_Invalid 								<> 0 or
																											 corp_inc_date_Invalid 									<> 0 or
																											 corp_term_exist_cd_Invalid							<> 0 or
																											 corp_term_exist_exp_Invalid						<> 0 or
																											 corp_foreign_domestic_ind_Invalid			<> 0 or
																											 corp_forgn_state_cd_Invalid						<> 0 or
																											 corp_forgn_state_desc_Invalid					<> 0 or
																											 corp_forgn_date_Invalid 								<> 0 or
																											 corp_forgn_term_exist_cd_Invalid				<> 0 or
																											 corp_forgn_term_exist_exp_Invalid			<> 0 or
																											 corp_forgn_term_exist_desc_Invalid			<> 0 or
																											 corp_orig_org_structure_cd_Invalid			<> 0 or
																											 corp_orig_org_structure_desc_Invalid		<> 0 or
																											 corp_for_profit_ind_Invalid 						<> 0 or
																											 corp_ra_address_type_cd_Invalid 				<> 0 or
																											 corp_ra_address_type_desc_Invalid 			<> 0 or 
																											 recordorigin_Invalid										<> 0
																										);

		Main_GoodRecords				:= Main_N.ExpandedInFile(dt_vendor_first_reported_Invalid 			= 0 and
																										 dt_vendor_last_reported_Invalid 				= 0 and
																										 dt_first_seen_Invalid 									= 0 and
																										 dt_last_seen_Invalid 									= 0 and
																										 corp_ra_dt_first_seen_Invalid 					= 0 and
																										 corp_ra_dt_last_seen_Invalid 					= 0 and
																										 corp_key_Invalid 											= 0 and
																										 corp_supp_key_Invalid									= 0 and
																										 corp_vendor_Invalid 										= 0 and
																										 corp_state_origin_Invalid 					 		= 0 and
																										 corp_process_date_Invalid						  = 0 and
																										 corp_orig_sos_charter_nbr_Invalid 			= 0 and
																										 corp_legal_name_Invalid 								= 0 and
																										 corp_ln_name_type_cd_Invalid 					= 0 and
																										 corp_ln_name_type_desc_Invalid 				= 0 and
																										 corp_status_cd_Invalid 								= 0 and
																										 corp_standing_Invalid 									= 0 and
																										 corp_inc_state_Invalid 								= 0 and
																										 corp_inc_date_Invalid 									= 0 and
																										 corp_term_exist_cd_Invalid							= 0 and
																										 corp_term_exist_exp_Invalid						= 0 and
																										 corp_foreign_domestic_ind_Invalid			= 0 and
																										 corp_forgn_state_cd_Invalid						= 0 and																							 
																										 corp_forgn_state_desc_Invalid					= 0 and
																										 corp_forgn_date_Invalid 								= 0 and
																										 corp_forgn_term_exist_cd_Invalid				= 0 and
																										 corp_forgn_term_exist_exp_Invalid			= 0 and
																										 corp_forgn_term_exist_desc_Invalid			= 0 and
																										 corp_orig_org_structure_cd_Invalid			= 0 and
																										 corp_orig_org_structure_desc_Invalid		= 0 and
																										 corp_for_profit_ind_Invalid 						= 0 and
																										 corp_ra_address_type_cd_Invalid 				= 0 and
																										 corp_ra_address_type_desc_Invalid 			= 0 and 
																										 recordorigin_Invalid										= 0																								 
																								  );

		Main_FailBuild					:= map( corp2_mapping.fCalcPercent(count(Main_N.ExpandedInFile(corp_key_invalid<>0)),count(Main_N.ExpandedInFile),false) 										> Scrubs_Corp2_Mapping_SC_Main.Threshold_Percent.CORP_KEY										 => true,
																		corp2_mapping.fCalcPercent(count(Main_N.ExpandedInFile(corp_orig_sos_charter_nbr_invalid<>0)),count(Main_N.ExpandedInFile),false) 	> Scrubs_Corp2_Mapping_SC_Main.Threshold_Percent.CORP_ORIG_SOS_CHARTER_NBR 	 => true,
																		corp2_mapping.fCalcPercent(count(Main_N.ExpandedInFile(corp_legal_name_invalid<>0)),count(Main_N.ExpandedInFile),false) 						> Scrubs_Corp2_Mapping_SC_Main.Threshold_Percent.CORP_LEGAL_NAME 						 => true,
																		corp2_mapping.fCalcPercent(count(Main_N.ExpandedInFile(corp_ln_name_type_cd_invalid<>0)),count(Main_N.ExpandedInFile),false) 				> Scrubs_Corp2_Mapping_SC_Main.Threshold_Percent.CORP_LN_NAME_TYPE_CD		  	 => true,
																		corp2_mapping.fCalcPercent(count(Main_N.ExpandedInFile(corp_inc_date_invalid<>0)),count(Main_N.ExpandedInFile),false) 							> Scrubs_Corp2_Mapping_SC_Main.Threshold_Percent.CORP_INC_DATE 						 	 => true,
																	  count(Main_GoodRecords) = 0																																																																																											 => true,																		
																		false
																	);

		Main_ApprovedRecords		:= project(Main_GoodRecords,transform(Corp2_Mapping.LayoutsCommon.Main,self := left));

		Main_ALL		 						:= sequential( if(count(Main_BadRecords) <> 0
																							,if(poverwrite
																									,output(Main_BadRecords,,Corp2_Mapping._Dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::main_'+state_origin,overwrite,__compressed__)
																									,output(Main_BadRecords,,Corp2_Mapping._Dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::main_'+state_origin,__compressed__)
																									)
																							)
																					,output(Main_ScrubsWithExamples, all, named('CorpMainSCScrubsReportWithExamples'+filedate))
																					//Send Alerts if Scrubs exceeds thresholds
																					,if(count(Main_ScrubsAlert) > 0, Main_MailFile, output('CORP2_MAPPING.SC - No "MAIN" Corp Scrubs Alerts'))
																					,Main_ErrorSummary
																					,Main_ScrubErrorReport
																					,Main_SomeErrorValues	
																					//,Main_AlertsCSVTemplate
																				  ,Main_SubmitStats
																			);
																			
		//********************************************************************
		// UPDATE
		//********************************************************************

		Fail_Build						:= if(Event_FailBuild = true or Main_FailBuild = true,true,false);
		IsScrubErrors					:= if(Event_IsScrubErrors = true or Main_IsScrubErrors = true,true,false);

		VersionControl.macBuildNewLogicalFile(Corp2_Mapping._dataset().thor_cluster_Files + 'in::corp2::' 	+ version + '::Event_' 	+ state_origin, Event_ApprovedRecords, write_event,,,pOverwrite);
		VersionControl.macBuildNewLogicalFile(Corp2_Mapping._dataset().thor_cluster_Files + 'in::corp2::' 	+ version + '::Main_' 	+ state_origin, Main_ApprovedRecords , write_main,,,pOverwrite);
		VersionControl.macBuildNewLogicalFile(corp2_mapping._dataset().thor_cluster_Files + 'in::corp2::' 	+ version + '::Ar_' 		+ state_origin, mapAr 						   , Ar_out,,,pOverwrite);
		
		VersionControl.macBuildNewLogicalFile(Corp2_Mapping._dataset().thor_cluster_Files + 'fail::corp2::' + version + '::Event_' 	+ state_origin, Event_F	, write_fail_event,,,pOverwrite);
		VersionControl.macBuildNewLogicalFile(Corp2_Mapping._dataset().thor_cluster_Files + 'fail::corp2::' + version + '::Main_' 	+ state_origin, Main_F	, write_fail_main,,,pOverwrite);

		mapSC:= sequential ( if(pshouldspray = true,Corp2_mapping.fSprayFiles(state_origin,version,pOverwrite := pOverwrite))
												//,Corp2_Raw_SC.Build_Bases(filedate,version,puseprod).All  // Determined building of bases is not needed
												,Event_All
												,Main_All												
												,Ar_out	
   											,if(Fail_Build <> true	 
   													,sequential (write_event
   																			 ,write_main
   																			 ,fileservices.addsuperfile(Corp2_Mapping._Dataset().thor_cluster_Files + 'in::'+Corp2_Mapping._Dataset().NameMapped +'::sprayed::event'	,Corp2_Mapping._Dataset().thor_cluster_Files + 'in::corp2::'+version+'::event_'	+state_origin)
   																			 ,fileservices.addsuperfile(Corp2_Mapping._Dataset().thor_cluster_Files + 'in::'+Corp2_Mapping._Dataset().NameMapped +'::sprayed::main'		,Corp2_Mapping._Dataset().thor_cluster_Files + 'in::corp2::'+version+'::main_'	+state_origin)																 
   																			 ,fileservices.addsuperfile(corp2_mapping._Dataset().thor_cluster_Files + 'in::'+corp2_mapping._Dataset().NameMapped+'::sprayed::Ar'			,corp2_mapping._Dataset().thor_cluster_Files + 'in::corp2::'+version+'::Ar_' 		+state_origin)
   																			 ,if (count(Main_BadRecords) <> 0 or count(Event_BadRecords) <> 0
   																					  ,corp2_mapping.Send_Email(state_origin ,version,count(Main_BadRecords)<>0,,,,count(Main_BadRecords),,count(mapEvent),,count(Main_ApprovedRecords),count(mapAR),count(mapEvent),).RecordsRejected																				 
   																						,corp2_mapping.Send_Email(state_origin ,version,count(Main_BadRecords)<>0,,,,count(Main_BadRecords),,count(mapEvent),,count(Main_ApprovedRecords),count(mapAR),count(mapEvent),).MappingSuccess																				 
   																						)
   																			 ,if (IsScrubErrors
   																					 ,Corp2_Mapping.Send_Email(state_origin,version,Main_IsScrubErrors,,Event_IsScrubErrors,).FieldsInvalidPerScrubs
   																					 )
   																			 ) //if Fail_Build <> true																			
   													 ,SEQUENTIAL (write_fail_event
   																			 ,write_fail_main
   																			 ,Corp2_Mapping.Send_Email(state_origin,version).MappingFailed
   																			 ) //if Fail_Build = true

													 );
											);
											
		isFileDateValid := if((string)std.date.today() between ut.date_math(filedate,-30) and ut.date_math(filedate,30),true,false);
		return sequential (	 if (isFileDateValid
														 ,mapSC
														 ,sequential (Corp2_Mapping.Send_Email(state_origin,filedate).InvalidFileDateParm
																				  ,FAIL('Corp2_Mapping.'+state_origin+' failed.  An invalid filedate was passed in as a parameter.')
																				 )
														)
											);

	end;	// end of Update function

end;  // end of Module