import corp2,corp2_raw_nh,scrubs,scrubs_corp2_mapping_nh_ar,scrubs_corp2_mapping_nh_event,
			 scrubs_corp2_mapping_nh_main,scrubs_corp2_mapping_nh_stock,std,tools,ut,versioncontrol;

export NH := MODULE; 

	export Update(string fileDate, string version, boolean pShouldSpray = Corp2_Mapping._Dataset().bShouldSpray, boolean pOverwrite = false, pUseProd = Tools._Constants.IsDataland) := Function
	
		state_origin			 				:= 'NH';
		state_fips	 				 			:= '33';
		state_desc	 			 				:= 'NEW HAMPSHIRE';
		
		Corporation			 					:= dedup(sort(distribute(Corp2_Raw_NH.Files(fileDate,puseprod).Input.Corporation.Logical,hash(CorporationID)),record,local),record,local) : independent;
		Address					 					:= dedup(sort(distribute(Corp2_Raw_NH.Files(fileDate,puseprod).Input.Address.Logical,hash(CorporationID)),record,local),record,local) : independent;
		Filing					 					:= dedup(sort(distribute(Corp2_Raw_NH.Files(fileDate,puseprod).Input.Filing.Logical,hash(CorporationID)),record,local),record,local) : independent;
		Merger										:= dedup(sort(distribute(Corp2_Raw_NH.Files(fileDate,puseprod).Input.Merger.Logical,hash(MergerID)),record,local),record,local) : independent;
		MergerSurvivor						:= distribute(Merger,hash(SurvivorCorporationID));
		MergerNonSurvivor					:= distribute(Merger,hash(MergedCorporationID));
		CorporationName	 					:= dedup(sort(distribute(Corp2_Raw_NH.Files(fileDate,puseprod).Input.CorporationName.Logical,hash(CorporationID)),record,local),record,local) : independent;
		Officer					 					:= dedup(sort(distribute(Corp2_Raw_NH.Files(fileDate,puseprod).Input.Officer.Logical,hash(CorporationID)),record,local),record,local) : independent;
		Stock						 					:= dedup(sort(distribute(Corp2_Raw_NH.Files(fileDate,puseprod).Input.Stock.Logical,hash(CorporationID)),record,local),record,local) : independent;

		DocumentIDTable 					:= Corp2_Raw_NH.Files(fileDate,puseprod).Input.DocumentIDTable   : independent; 
		StockClassTable 					:= Corp2_Raw_NH.Files(fileDate,puseprod).Input.StockClassTable 	 : independent; 
		CorpTypeTable 						:= Corp2_Raw_NH.Files(fileDate,puseprod).Input.CorpTypeTable 	 	 : independent; 
		StatusTable 							:= Corp2_Raw_NH.Files(fileDate,puseprod).Input.StatusTable 		 	 : independent;
		NameTypeTable 						:= Corp2_Raw_NH.Files(fileDate,puseprod).Input.NameTypeTable 		 : independent; 
		OffPartyTypeTable 				:= Corp2_Raw_NH.Files(fileDate,puseprod).Input.OffPartyTypeTable : independent; 
		PartyTypeTable 						:= Corp2_Raw_NH.Files(fileDate,puseprod).Input.PartyTypeTable 	 : independent; 

		OfficerFixState						:= project(Officer,
																				 transform(Corp2_Raw_NH.Layouts.OfficerLayoutIn,
																									 self.state						:= Corp2_Raw_NH.Functions.Fix_State(left.city, left.state);
																									 self.countryname			:= Corp2_Raw_NH.Functions.Fix_Country(left.countryname);
																									 self									:= left;
																									)
																				);
																					
		AddressFixState						:= project(Address,
																				 transform(Corp2_Raw_NH.Layouts.AddressLayoutIn,
																									 self.state						:= Corp2_Raw_NH.Functions.Fix_State(left.city, left.state);
																									 self.country 				:= Corp2_Raw_NH.Functions.Fix_Country(left.country);
																									 self									:= left;
																									)
																				);

		//Join Filing and DocumentIDTable - for Events & AR mapping
		AddDocumentID2Filing			:= join(Filing, DocumentIDTable,
																			corp2.t2u(left.DocumentTypeID) = right.TableCode,
																			transform(Corp2_Raw_NH.Layouts.TempFilingWithCorpLayoutIn,
																								self.docidcode					:= right.tablecode;
																								self.dociddesc					:= right.tabledesc;
																								self										:= left;
																								self										:= [];
																							 ),
																			left outer,
																			lookup
																		 );	
								 	
		Events_AR_File		 				:= join(AddDocumentID2Filing, Corporation,
																			corp2.t2u(left.CorporationID) = corp2.t2u(right.CorporationID),
																			transform(Corp2_Raw_NH.Layouts.TempFilingWithCorpLayoutIn,
																								self										:= right;
																								self										:= left;
																						 ),
																			inner,
																			local
																		 ) : independent;	

		//Join Stock and StockClassTable - for Stock mapping
		AddStockClass2Stock				:= join(Stock, StockClassTable,
																			corp2.t2u(left.StockClassID) = right.TableCode,
																			transform(Corp2_Raw_NH.Layouts.TempStockWithCorpLayoutIn,
																								self.stockclasscode			:= right.tablecode;
																								self.stockclassdesc			:= right.tabledesc;
																								self										:= left;
																								self										:= [];
																						 ),
																			left outer,
																			lookup
																		 );
								 
		StockFile				 					:= join(AddStockClass2Stock, Corporation,
																			corp2.t2u(left.CorporationID) = corp2.t2u(right.CorporationID),
																			transform(Corp2_Raw_NH.Layouts.TempStockWithCorpLayoutIn,
																								self 										:= right;
																								self										:= left;
																							 ),
																			inner,
																			local
																		 );
															 


		//Join Corporation with the following files: CorpTypeTable, StatusTable, CorporationName, NameTypeTable, Address, & Merger (survivor & non-survivor)
		AddCorpType2Corp					:= join(Corporation, CorpTypeTable,
																			corp2.t2u(left.CorporationTypeID) = right.TableCode,
																			transform(Corp2_Raw_NH.Layouts.TempCorporationLayoutIn,
																								self.corptypecode						:= right.tablecode;
																								self.corptypedesc						:= right.tabledesc;
																								self.countryofincorporation := Corp2_Raw_NH.Functions.Fix_Country_Of_Incorporation(left.countryofincorporation);
																								self												:= left;
																								self												:= [];
																							 ),
																			left outer,
																			lookup
																		 );		
	
		AddStatusDesc2Corp 			  := join(AddCorpType2Corp, StatusTable,
																			corp2.t2u(left.CorporationStatusID) = corp2.t2u(right.TableCode),
																			transform(Corp2_Raw_NH.Layouts.TempCorporationLayoutIn,
																								self.statuscode						:= right.tablecode;
																								self.statusdesc						:= right.tabledesc;
																								self											:= left;
																							 ),
																			left outer,
																			lookup
																		 );		

		AddCorpName2Corp					:= join(AddStatusDesc2Corp, CorporationName,
																			corp2.t2u(left.corporationid) = corp2.t2u(right.corporationid),
																			transform(Corp2_Raw_NH.Layouts.TempCorporationLayoutIn,
																								self							 					:= right;
																								self												:= left;
																							 ),
																			left outer,
																			local
																		 );
																			 
		AddNameType2Corp					:= join(AddCorpName2Corp, NameTypeTable,
																			corp2.t2u(left.NameTypeID) = corp2.t2u(right.TableCode),
																			transform(Corp2_Raw_NH.Layouts.TempCorporationLayoutIn,
																								self.nametypecode						:= right.tablecode;
																								self.nametypedesc						:= right.tabledesc;
																								self												:= left;
																							 ),
																			left outer,
																			lookup
																		 );
																			 
		AddAddress2Corp 					:= join(AddNameType2Corp, AddressFixState,
																			corp2.t2u(left.CorporationID) = corp2.t2u(right.CorporationID),
																			transform(Corp2_Raw_NH.Layouts.TempCorporationLayoutIn,
																								self.corporationid					:= left.corporationid;
																								self 												:= right;
																								self												:= left;
																							 ),
																			left outer,
																			local
																		 );	
		//Add Merger Survivor records
		CorporationFile1					 	:= join(AddAddress2Corp, MergerSurvivor,
																				corp2.t2u(left.CorporationID) = corp2.t2u(right.survivorcorporationid),
																				transform(Corp2_Raw_NH.Layouts.TempCorporationLayoutIn,
																									self.corporationid											:= left.corporationid;
																									self.survivor_mergerid									:= right.mergerid;
																									self.survivor_survivorcorporationid			:= right.survivorcorporationid;
																									self.survivor_mergedcorporationid				:= right.mergedcorporationid;
																									self.survivor_mergerdate								:= right.mergerdate;
																									self																		:= left;
																								 ),
																				left outer,
																				local
																			 );

		//Note: Need to concatenate Merger "Non-Survivor" records onto corporation file that already includes the Merger "Survivor" records.
		CorporationFile2						:= join(AddAddress2Corp, MergerNonSurvivor,
																				corp2.t2u(left.CorporationID) = corp2.t2u(right.mergedcorporationid),
																				transform(Corp2_Raw_NH.Layouts.TempCorporationLayoutIn,
																									self.corporationid											:= left.corporationid;
																									self.nonsurvivor_mergerid								:= right.mergerid;
																									self.nonsurvivor_survivorcorporationid	:= right.survivorcorporationid;
																									self.nonsurvivor_mergedcorporationid		:= right.mergedcorporationid;
																									self.nonsurvivor_mergerdate							:= right.mergerdate;
																									self																		:= left;
																								 ),
																				inner,
																				local
																			 );
																			 
		CorporationFile := distribute(CorporationFile1 + CorporationFile2,hash(corporationid));
		
		//Join for "Contacts": Officer, OffPartyTypeTable, & PartyTypeTable		
		AddOfficer2Cont						:= join(Corporation, OfficerFixState,
																			corp2.t2u(left.CorporationID) = corp2.t2u(right.CorporationID),
																			transform(Corp2_Raw_NH.Layouts.TempContactsLayoutIn,
																								self												:= left;
																								self												:= right;
																								self												:= [];
																							 ),
																			inner,
																			local
																		 );

		AddCorpName2Cont						:= join(AddOfficer2Cont, CorporationName,
																				corp2.t2u(left.corporationid) = corp2.t2u(right.corporationid),
																				transform(Corp2_Raw_NH.Layouts.TempContactsLayoutIn,
																									self							 					:= right;
																									self												:= left;
																								 ),
																				left outer,
																				local
																			 );

		AddOffPartyType2Cont			:= join(AddCorpName2Cont, OffPartyTypeTable,
																			corp2.t2u(left.officerid) = corp2.t2u(right.offid),
																			transform(Corp2_Raw_NH.Layouts.TempContactsLayoutIn,
																								self			 									:= right;
																								self												:= left;
																							 ),
																			left outer,
																			lookup
																		 );

		ContactFile								:= join(AddOffPartyType2Cont, PartyTypeTable,
																			corp2.t2u(left.PartyTypeID) = corp2.t2u(right.TableCode),
																			transform(Corp2_Raw_NH.Layouts.TempContactsLayoutIn,
																								self.partytypecode					:= right.tablecode;
																								self.partytypedesc					:= right.tabledesc;
																								self												:= left;
																							 ),
																			left outer,
																			lookup
																		 );

		//********************************************************************
		//This begins the MAIN mapping.
		//Note: The Corporation and RA data is mapped here.
		//********************************************************************
		Corp2_mapping.LayoutsCommon.Main CorporationTransform(Corp2_Raw_NH.Layouts.TempCorporationLayoutIn l) := transform
				self.dt_vendor_first_reported						:= (unsigned4)fileDate;
				self.dt_vendor_last_reported						:= (unsigned4)fileDate;
				self.dt_first_seen											:= (unsigned4)fileDate;
				self.dt_last_seen												:= (unsigned4)fileDate;
				self.corp_ra_dt_first_seen							:= (unsigned4)fileDate;
				self.corp_ra_dt_last_seen								:= (unsigned4)fileDate;			
				self.corp_key														:= state_fips + '-' + corp2.t2u(l.corporationid);
				self.corp_vendor												:= state_fips;
				self.corp_state_origin									:= state_origin;			
				self.corp_process_date									:= fileDate;
				self.corp_orig_sos_charter_nbr					:= corp2.t2u(l.corporationnumber);
				self.corp_ln_name_type_cd								:= Corp2_Raw_NH.Functions.CorpLNNameTypeCD(l.nametypeid,l.corporationtypeid);
				self.corp_ln_name_type_desc							:= Corp2_Raw_NH.Functions.CorpLNNameTypeDesc(l.nametypeid,l.corporationtypeid,l.nametypedesc);
				self.corp_legal_name 									 	:= Corp2_Mapping.fCleanBusinessName(state_origin,state_desc,l.corpname).BusinessName;
				self.corp_address1_type_cd	      			:= if(corp2.t2u(l.addresstypeid) not in ['10','11','14'] and Corp2_Mapping.fAddressExists(state_origin,state_desc,l.address1,l.address2+l.address3,l.city,l.state,l.zip).ifaddressexists,
																											Corp2_Raw_NH.Functions.CorpAddressTypeCD(l.addresstypeid),
																											''
																										 );
				self.corp_address1_type_desc      			:= if(self.corp_address1_type_cd <> '',
																											Corp2_Raw_NH.Functions.CorpAddressTypeDesc(l.addresstypeid),
																											''
																										 );
				self.corp_address1_line1								:= if(self.corp_address1_type_cd<>'',Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.address1,l.address2+l.address3,l.city,l.state,l.zip,l.country).AddressLine1,'');
				self.corp_address1_line2								:= if(self.corp_address1_type_cd<>'',Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.address1,l.address2+l.address3,l.city,l.state,l.zip,l.country).AddressLine2,'');
				self.corp_address1_line3								:= if(self.corp_address1_type_cd<>'',Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.address1,l.address2+l.address3,l.city,l.state,l.zip,l.country).AddressLine3,'');
				self.corp_prep_addr1_line1							:= if(self.corp_address1_type_cd<>'',Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.address1,l.address2+l.address3,l.city,l.state,l.zip,l.country).PrepAddrLine1,'');
				self.corp_prep_addr1_last_line					:= if(self.corp_address1_type_cd<>'',Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.address1,l.address2+l.address3,l.city,l.state,l.zip,l.country).PrepAddrLastLine,'');
				self.corp_orig_org_structure_cd					:= if(corp2.t2u(l.corporationtypeid) not in ['63','75'],corp2.t2u(l.corporationtypeid),'');
				self.corp_orig_org_structure_desc				:= if(corp2.t2u(l.corporationtypeid) not in ['63','75'],corp2.t2u(l.corptypedesc),'');
				self.corp_for_profit_ind								:= if(corp2.t2u(l.corporationtypeid) 		 in ['25'],'N','');
				self.corp_orig_bus_type_desc						:= Corp2_Raw_NH.Functions.CorpOrigBusTypeDesc(l.purpose);
				self.corp_status_cd											:= corp2.t2u(l.corporationstatusid);
				self.corp_status_desc										:= corp2.t2u(l.statusdesc);
				self.corp_status_date										:= Corp2_Mapping.fValidateDate(l.dissolvedate,'CCYY-MM-DD').PastDate;				
				self.corp_standing											:= if(corp2.t2u(l.corporationstatusid) = '3','Y','');
				self.corp_foreign_domestic_ind					:= corp2.t2u(l.citizenship);
				self.corp_inc_date											:= if(corp2.t2u(l.citizenship) = 'D',Corp2_Mapping.fValidateDate(l.dateformed,'CCYY-MM-DD').PastDate,'');
				self.corp_term_exist_cd									:= map(corp2.t2u(l.duration) = 'PERPETUAL' 																	=> 'P',
																											 Corp2_Mapping.fValidateDate(l.duration,'MM/DD/CCYY').GeneralDate<>'' => 'D',
																											 ''
																											);
				self.corp_term_exist_desc								:= map(self.corp_term_exist_cd = 'P'	=> 'PERPETUAL',
																											 self.corp_term_exist_cd = 'D'	=> 'EXPIRATION DATE',
																											 ''
																											);
				self.corp_term_exist_exp								:= Corp2_Mapping.fValidateDate(l.duration,'MM/DD/CCYY').GeneralDate;
				self.corp_inc_state											:= state_origin;
				self.corp_inc_county										:= if(corp2.t2u(l.countyofincorporation) not in ['UNKNOWN'],corp2.t2u(l.countyofincorporation),'');
				self.corp_forgn_state_cd								:= if(corp2.t2u(l.citizenship) = 'F' and corp2.t2u(l.stateofincorporation) not in [state_origin,'','XX'],corp2.t2u(l.stateofincorporation),'');
				self.corp_forgn_state_desc							:= if(corp2.t2u(l.citizenship) = 'F' and corp2.t2u(l.stateofincorporation) not in [state_origin,'','XX'],Corp2_Raw_NH.Functions.State_Description(l.stateofincorporation),'');
				self.corp_forgn_date										:= if(corp2.t2u(l.citizenship) = 'F',Corp2_Mapping.fValidateDate(l.dateformed,'CCYY-MM-DD').PastDate,'');
				self.corp_ra_full_name							 		:= Corp2_mapping.fCleanBusinessName(state_origin,state_desc,l.registeredagentname).BusinessName;
				self.corp_ra_address_type_cd	      		:= if(corp2.t2u(l.addresstypeid) in ['10','11','14'] and Corp2_Mapping.fAddressExists(state_origin,state_desc,l.address1,l.address2+l.address3,l.city,l.state,l.zip).ifaddressexists,
																											Corp2_Raw_NH.Functions.CorpAddressTypeCD(l.addresstypeid),
																											''
																										 );
				self.corp_ra_address_type_desc      		:= if(self.corp_ra_address_type_cd<>'',
																											Corp2_Raw_NH.Functions.CorpAddressTypeDesc(l.addresstypeid),
																											''
																										 );
				self.corp_ra_address_line1							:= if(self.corp_ra_address_type_cd<>'',Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.address1,l.address2+l.address3,l.city,l.state,l.zip,l.country).AddressLine1,'');
				self.corp_ra_address_line2							:= if(self.corp_ra_address_type_cd<>'',Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.address1,l.address2+l.address3,l.city,l.state,l.zip,l.country).AddressLine2,'');
				self.corp_ra_address_line3							:= if(self.corp_ra_address_type_cd<>'',Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.address1,l.address2+l.address3,l.city,l.state,l.zip,l.country).AddressLine3,'');
				self.ra_prep_addr_line1									:= if(self.corp_ra_address_type_cd<>'',Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.address1,l.address2+l.address3,l.city,l.state,l.zip,l.country).PrepAddrLine1,'');
				self.ra_prep_addr_last_line							:= if(self.corp_ra_address_type_cd<>'',Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.address1,l.address2+l.address3,l.city,l.state,l.zip,l.country).PrepAddrLastLine,'');
				self.corp_agent_county									:= stringlib.stringfilter(corp2.t2u(l.county),' ABCDEFGHIJKLMNOPQRSTUVWXYZ');
				self.corp_country_of_formation					:= Corp2_Mapping.fCleanCountry(state_origin,state_desc,,l.countryofincorporation).Country;
				self.corp_dissolved_date								:= Corp2_Mapping.fValidateDate(l.dissolvedate,'CCYY-MM-DD').PastDate;
				self.corp_home_state_name								:= if(corp2.t2u(l.nametypeid) in ['13','15'],corp2.t2u(l.corpname),'');
				self.corp_merger_indicator							:= map(corp2.t2u(l.survivor_mergerid)	 	 <> '' => 'S',
																											 corp2.t2u(l.nonsurvivor_mergerid) <> '' => 'N',
																											 ''
																											);
				self.corp_merged_corporation_id					:= if(corp2.t2u(l.survivor_mergedcorporationid) <> '',corp2.t2u(l.survivor_mergedcorporationid),'');
				self.corp_merger_date										:= map(corp2.t2u(l.survivor_mergerdate)	   <> '' => Corp2_Mapping.fValidateDate(l.survivor_mergerdate,'CCYY-MM-DD').PastDate,
																											 corp2.t2u(l.nonsurvivor_mergerdate) <> '' => Corp2_Mapping.fValidateDate(l.nonsurvivor_mergerdate,'CCYY-MM-DD').PastDate,
																											 ''
																											);
				self.corp_merger_desc										:= map(corp2.t2u(l.survivor_mergedcorporationid)	  <> '' => 'CORPORATION MERGED WITH: ' + corp2.t2u(l.survivor_mergedcorporationid),
																											 corp2.t2u(l.nonsurvivor_mergedcorporationid) <> '' => 'CORPORATION MERGED INTO: ' + corp2.t2u(l.nonsurvivor_mergedcorporationid),
																											 ''
																											);
				self.corp_merger_id											:= if(corp2.t2u(l.nonsurvivor_mergedcorporationid) <> '',corp2.t2u(l.nonsurvivor_mergedcorporationid),'');
				self.internalfield1				      				:= corp2.t2u(l.addresstypeid); //scubbing				
				self.recordorigin												:= 'C';
				self 																		:= [];
		end; 

		CorporationData	 	 				:= project(CorporationFile,CorporationTransform(left));

		HasRAAddress			 				:= CorporationData(corp2.t2u(corp_ra_address_line1+corp_ra_address_line2+corp_ra_address_line3)<>'');
		HasNoRAAddress		 				:= CorporationData(corp2.t2u(corp_ra_address_line1+corp_ra_address_line2+corp_ra_address_line3)='');

		MapCorporation						:= join(HasNoRAAddress, HasRAAddress,
																			corp2.t2u(left.corp_key) 							 = corp2.t2u(right.corp_key) and
																			corp2.t2u(left.corp_ln_name_type_desc) = corp2.t2u(right.corp_ln_name_type_desc) and
																			corp2.t2u(left.corp_ra_full_name)			 = corp2.t2u(right.corp_ra_full_name),
																			transform(Corp2_mapping.LayoutsCommon.Main,
																								self.corp_ra_address_type_cd		:= right.corp_ra_address_type_cd;
																								self.corp_ra_address_type_desc	:= right.corp_ra_address_type_desc;
																								self.corp_ra_address_line1			:= right.corp_ra_address_line1;
																								self.corp_ra_address_line2			:= right.corp_ra_address_line2;
																								self.corp_ra_address_line3			:= right.corp_ra_address_line3;
																								self.ra_prep_addr_line1					:= right.ra_prep_addr_line1;
																								self.ra_prep_addr_last_line			:= right.ra_prep_addr_last_line;
																								self														:= if(corp2.t2u(left.corp_key)<>'',left,right);
																							 ),
																			full outer,
																			local
																		 );
																		 
		//********************************************************************
		//Continue the MAIN mapping.
		//Note: The Contact data is mapped here.
		//********************************************************************
		Corp2_mapping.LayoutsCommon.Main ContactTransform(Corp2_Raw_NH.Layouts.TempContactsLayoutIn l) := transform
				self.dt_vendor_first_reported						:= (unsigned4)fileDate;
				self.dt_vendor_last_reported						:= (unsigned4)fileDate;
				self.dt_first_seen											:= (unsigned4)fileDate;
				self.dt_last_seen												:= (unsigned4)fileDate;
				self.corp_ra_dt_first_seen							:= (unsigned4)fileDate;
				self.corp_ra_dt_last_seen								:= (unsigned4)fileDate;			
				self.corp_key														:= state_fips + '-' + corp2.t2u(l.corporationid);
				self.corp_vendor												:= state_fips;
				self.corp_state_origin									:= state_origin;			
				self.corp_process_date									:= fileDate;
				self.corp_orig_sos_charter_nbr					:= corp2.t2u(l.corporationnumber);
				self.corp_legal_name 									 	:= Corp2_Mapping.fCleanBusinessName(state_origin,state_desc,l.corpname).BusinessName;
				self.corp_inc_state											:= state_origin;				
				self.cont_type_cd												:= 'F';
				self.cont_type_desc											:= 'OFFICER';
				self.cont_full_name 									 	:= Corp2_Mapping.fCleanBusinessName(state_origin,state_desc,l.name).BusinessName;
				self.cont_title1_desc               		:= corp2.t2u(l.partytypedesc);
				self.cont_address_type_cd	      				:= if(Corp2_Mapping.fAddressExists(state_origin,state_desc,l.Address1,l.Address2+l.Address3,l.City,l.state,l.Zip).ifaddressexists,'T','');
				self.cont_address_type_desc    	  			:= if(Corp2_Mapping.fAddressExists(state_origin,state_desc,l.Address1,l.Address2+l.Address3,l.City,l.state,l.Zip).ifaddressexists,'CONTACT','');
				self.cont_address_line1									:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.Address1,l.Address2+l.Address3,l.City,l.state,l.Zip).AddressLine1;
				self.cont_address_line2									:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.Address1,l.Address2+l.Address3,l.City,l.state,l.Zip).AddressLine2;
				self.cont_address_line3									:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.Address1,l.Address2+l.Address3,l.City,l.state,l.Zip).AddressLine3;
				self.recordorigin												:= 'T';
				self 																		:= [];
		end;
		
		MapContacts			:= project(ContactFile,ContactTransform(left));
		
		MapMain		 			:= dedup(sort(distribute(MapCorporation + MapContacts,hash(corp_key)),record,local),record,local) : independent;

		//********************************************************************
		//This begins the AR mapping.
		//********************************************************************
		Corp2_mapping.LayoutsCommon.AR ARTransform(Corp2_Raw_NH.Layouts.TempFilingWithCorpLayoutIn l):= transform,
		skip(corp2.t2u(l.documenttypeid)<>'113')
				self.corp_key														:= state_fips + '-' + corp2.t2u(l.corporationid);
				self.corp_vendor												:= state_fips;
				self.corp_state_origin									:= state_origin;			
				self.corp_process_date									:= fileDate;
				self.corp_sos_charter_nbr								:= corp2.t2u(l.corporationnumber);		
				self.ar_report_nbr							 				:= map(Corp2_Mapping.fValidateDate(l.documentid,'MM/DD/CCYY').GeneralDate<>'' => '', //if a date, blank out
																											 stringlib.stringfilterout(corp2.t2u(l.documentid),'=.`')='' 			=> '', //if only special characters, blank out
																											 stringlib.stringfind(corp2.t2u(l.documentid),'DATE',1) <>0				=> '', //if contains the word "DATE", blank out
																											 stringlib.stringfind(corp2.t2u(l.documentid),'VOL',1)  <>0				=> '', //if contains the word "VOL", blank out
																											 stringlib.stringfind(corp2.t2u(l.documentid),'V:',1)  <>0				=> '', //if contains the word "V:" (represents VOL), blank out
																											 corp2.t2u(l.documentid)
																											);				
				self.ar_year														:= if(Corp2_Mapping.fValidateDate(l.filingdate,'CCYY-MM-DD').PastDate<>'',Corp2_Mapping.fValidateDate(l.filingdate,'CCYY-MM-DD').PastDate[1..4],'');
				self.ar_filed_dt												:= Corp2_Mapping.fValidateDate(l.filingdate,'CCYY-MM-DD').PastDate;
				self.ar_report_dt												:= Corp2_Mapping.fValidateDate(l.filingdate,'CCYYMMDD').PastDate;
				self.ar_comment													:= Corp2_Raw_NH.Functions.ARComment(l.effectivedate);
				self 																		:= [];
		end;
			
		AllAR						:= project(Events_AR_File, ARTransform(left));
		MapAR						:= dedup(sort(distribute(AllAR,hash(corp_key)),record,local),record,local) : independent;

		//********************************************************************
		//This begins the Event mapping.
		//********************************************************************
		Corp2_mapping.LayoutsCommon.Events EventFilingTransform(Corp2_Raw_NH.Layouts.TempFilingWithCorpLayoutIn l, integer c) := transform,
		skip(corp2.t2u(l.documenttypeid)='113' or
				 c = 2 and Corp2_Mapping.fValidateDate(l.filingdate,'CCYY-MM-DD').PastDate = Corp2_Mapping.fValidateDate(l.effectivedate,'CCYY-MM-DD').GeneralDate
				)
				self.corp_key														:= state_fips + '-' + corp2.t2u(l.corporationid);
				self.corp_vendor												:= state_fips;
				self.corp_state_origin									:= state_origin;			
				self.corp_process_date									:= fileDate;
				self.corp_sos_charter_nbr								:= corp2.t2u(l.corporationnumber);
				self.event_filing_reference_nbr 				:= map(Corp2_Mapping.fValidateDate(l.documentid,'MM/DD/CCYY').GeneralDate<>'' => '', //if a date, blank out
																											 stringlib.stringfilterout(corp2.t2u(l.documentid),'=.`')='' 			=> '', //if only special characters, blank out
																											 stringlib.stringfind(corp2.t2u(l.documentid),'DATE',1) <>0				=> '', //if contains the word "DATE", blank out
																											 stringlib.stringfind(corp2.t2u(l.documentid),'VOL',1)  <>0				=> '', //if contains the word "VOL", blank out
																											 stringlib.stringfind(corp2.t2u(l.documentid),'V:',1)  <>0				=> '', //if contains the word "V:" (represents VOL), blank out
																											 corp2.t2u(l.documentid)
																											);
				self.event_filing_date									:= choose(c,Corp2_Mapping.fValidateDate(l.filingdate,'CCYY-MM-DD').PastDate,
																														Corp2_Mapping.fValidateDate(l.effectivedate,'CCYY-MM-DD').GeneralDate
																												 );
				self.event_date_type_cd									:= choose(c,if(Corp2_Mapping.fValidateDate(l.filingdate,'CCYY-MM-DD').PastDate<>'','FIL',''),
																														if(Corp2_Mapping.fValidateDate(l.effectivedate,'CCYY-MM-DD').GeneralDate<>'','EFF','')
																												 );				
				self.event_date_type_desc								:= choose(c,if(Corp2_Mapping.fValidateDate(l.filingdate,'CCYY-MM-DD').PastDate<>'','FILING',''),
																														if(Corp2_Mapping.fValidateDate(l.effectivedate,'CCYY-MM-DD').GeneralDate<>'','EFFECTIVE','')
																												 );
				self.event_desc													:= corp2.t2u(l.dociddesc);
				self 																		:= [];	
		end;
		
		AllEvent 				:= normalize(Events_AR_File, if(Corp2_Mapping.fValidateDate(left.effectivedate,'CCYY-MM-DD').GeneralDate<>'',2,1),EventFilingTransform(left,counter));
		MapEvent				:= dedup(sort(distribute(AllEvent,hash(corp_key)),record,local),record,local) : independent;

		//********************************************************************
		//This begins the Stock mapping.
		//********************************************************************
		Corp2_mapping.LayoutsCommon.Stock StockTransform(Corp2_Raw_NH.Layouts.TempStockWithCorpLayoutIn l) := transform	
				self.corp_key														:= state_fips + '-' + corp2.t2u(l.corporationid);
				self.corp_vendor												:= state_fips;
				self.corp_state_origin									:= state_origin;			
				self.corp_process_date									:= fileDate;
				self.corp_sos_charter_nbr								:= corp2.t2u(l.corporationnumber);
				self.stock_class												:= Corp2_Raw_NH.Functions.StockClass(l.stockclassdesc);
				self.stock_authorized_nbr								:= if((integer)l.authorizedshares <> 0,stringlib.stringfilterout((string)(integer)l.authorizedshares,'-'),''); //remove negative, if exists
				self.stock_shares_issued								:= if((integer)l.issuedshares <> 0,(string)(integer)l.issuedshares,'');
		    self.stock_par_value										:= if((integer)l.parvalue <> 0,stringlib.stringfilterout((string)(integer)l.parvalue,'-'),''); 								 //remove negative, if exists
				self																		:= [];
		end;

		AllStock				:= project(StockFile, StockTransform(left));
		MapStock				:= dedup(sort(distribute(AllStock,hash(corp_key)),record,local),record,local) : independent;

		//********************************************************************
		// SCRUB AR 
		//********************************************************************	
		AR_F := MapAR;
		AR_S := Scrubs_Corp2_Mapping_NH_AR.Scrubs;				// Scrubs module
		AR_N := AR_S.FromNone(AR_F); 											// Generate the error flags
		AR_T := AR_S.FromBits(AR_N.BitmapInfile);     		// Use the FromBits module; makes my bitmap datafile easier to get to
		AR_U := AR_S.FromExpanded(AR_N.ExpandedInFile); 	// Pass the expanded error flags into the Expanded module

		//Outputs reports
		AR_ErrorSummary			 	 := output(AR_U.SummaryStats, named('AR_ErrorSummary_NH'+fileDate));
		AR_ScrubErrorReport 	 := output(choosen(AR_U.AllErrors, 1000), named('AR_ScrubErrorReport_NH'+fileDate));
		AR_SomeErrorValues		 := output(choosen(AR_U.BadValues, 1000), named('AR_SomeErrorValues_NH'+fileDate));
		AR_IsScrubErrors		 	 := IF(count(AR_U.AllErrors)<> 0,true,false);

		// Orbit Stats
		AR_OrbitStats				 	 := AR_U.OrbitStats();

		//Outputs files
		AR_CreateBitMaps			 := output(AR_N.BitmapInfile,,'~thor_data::corp_NH_ar_scrubs_bits',overwrite,compressed);	//long term storage
		AR_TranslateBitMap		 := output(AR_T);

		//Submits Profile's stats to Orbit
		AR_SubmitStats 			   := Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_NH_AR','ScrubsAlerts', AR_OrbitStats, version,'Corp_NH_AR').SubmitStats;
		AR_ScrubsWithExamples  := Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_NH_AR','ScrubsAlerts', AR_OrbitStats, version,'Corp_NH_AR').CompareToProfile_with_Examples;

		AR_ScrubsAlert				 := AR_ScrubsWithExamples(RejectWarning = 'Y');
		AR_ScrubsAttachment	   := Scrubs.fn_email_attachment(AR_ScrubsAlert);
		AR_MailFile					   := FileServices.SendEmailAttachData(corp2.Email_Notification_Lists.AttachedList
																															,'Scrubs CorpAR_NH Report' //subject
																															,'Scrubs CorpAR_NH Report' //body
																															,(data)AR_ScrubsAttachment
																															,'text/csv'
																															,'CorpNHARScrubsReport.csv'
																														);

		AR_BadRecords				 		:= AR_N.ExpandedInFile(	
																										corp_key_Invalid							  			<> 0 or
																										corp_vendor_Invalid 									<> 0 or
																										corp_state_origin_Invalid 					 	<> 0 or
																										corp_process_date_Invalid						  <> 0 or
																										corp_sos_charter_nbr_Invalid 					<> 0 or
																										ar_year_Invalid 											<> 0 or
																										ar_filed_dt_Invalid 									<> 0 or
																										ar_report_dt_Invalid 									<> 0 or
																										ar_report_nbr_Invalid 								<> 0
																									 );

		AR_GoodRecords						:= AR_N.ExpandedInFile(
																										corp_key_Invalid							  			= 0 and
																										corp_vendor_Invalid 									= 0 and
																										corp_state_origin_Invalid 					 	= 0 and
																										corp_process_date_Invalid						  = 0 and
																										corp_sos_charter_nbr_Invalid 					= 0 and
																										ar_year_Invalid 											= 0 and
																										ar_filed_dt_Invalid 									= 0 and
																										ar_report_dt_Invalid 									= 0 and
																										ar_report_nbr_Invalid 								= 0
																									 );

		AR_FailBuild					 		:= if(count(AR_GoodRecords) = 0,true,false);

		AR_ApprovedRecords		 		:= project(AR_GoodRecords,transform(Corp2_Mapping.LayoutsCommon.AR,self := left;));


		AR_ALL								 		:= sequential(IF(count(AR_BadRecords) <> 0
																						  ,IF (poverwrite
																								  ,OUTPUT(AR_BadRecords,,Corp2_Mapping._Dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::ar_'+state_origin,overwrite,__compressed__)
																								  ,OUTPUT(AR_BadRecords,,Corp2_Mapping._Dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::ar_'+state_origin,__compressed__)
																								  )
																						  )
																					 ,output(AR_ScrubsWithExamples, all, named('CorpARNHScrubsReportWithExamples'+fileDate))
																					 //Send Alerts if Scrubs exceeds thresholds
																					 ,IF(COUNT(AR_ScrubsAlert) > 0, AR_MailFile, OUTPUT('CORP2_MAPPING.NH - No "AR" Corp Scrubs Alerts'))
																					 ,AR_ErrorSummary
																					 ,AR_ScrubErrorReport
																					 ,AR_SomeErrorValues		
																					 ,AR_SubmitStats
																					);

		//********************************************************************
		// SCRUB EVENT 
		//********************************************************************	
		Event_F := MapEvent;
		Event_S := Scrubs_Corp2_Mapping_NH_Event.Scrubs;					// Scrubs module
		Event_N := Event_S.FromNone(Event_F); 										// Generate the error flags
		Event_T := Event_S.FromBits(Event_N.BitmapInfile);     		// Use the FromBits module; makes my bitmap datafile easier to get to
		Event_U := Event_S.FromExpanded(Event_N.ExpandedInFile); 	// Pass the expanded error flags into the Expanded module

		//Outputs reports
		Event_ErrorSummary			 	:= output(Event_U.SummaryStats, named('Event_ErrorSummary_NH'+fileDate));
		Event_ScrubErrorReport 	 	:= output(choosen(Event_U.AllErrors, 1000), named('Event_ScrubErrorReport_NH'+fileDate));
		Event_SomeErrorValues		 	:= output(choosen(Event_U.BadValues, 1000), named('Event_SomeErrorValues_NH'+fileDate));
		Event_IsScrubErrors		 	 	:= IF(count(Event_U.AllErrors)<> 0,true,false);

		// Orbit Stats
		Event_OrbitStats				 	:= Event_U.OrbitStats();

		//Outputs files
		Event_CreateBitMaps			 	:= output(Event_N.BitmapInfile,,'~thor_data::corp_NH_Event_scrubs_bits',overwrite,compressed);	//long term storage
		Event_TranslateBitMap		 	:= output(Event_T);

		//Submits Profile's stats to Orbit
		Event_SubmitStats 			 := Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_NH_Event','ScrubsAlerts', Event_OrbitStats, version,'Corp_NH_Event').SubmitStats;
		Event_ScrubsWithExamples := Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_NH_Event','ScrubsAlerts', Event_OrbitStats, version,'Corp_NH_Event').CompareToProfile_with_Examples;

		Event_ScrubsAlert				 	:= Event_ScrubsWithExamples(RejectWarning = 'Y');
		Event_ScrubsAttachment	  := Scrubs.fn_email_attachment(Event_ScrubsAlert);
		Event_MailFile					  := FileServices.SendEmailAttachData(corp2.Email_Notification_Lists.spray
																															,'Scrubs CorpEvent_NH Report' //subject
																															,'Scrubs CorpEvent_NH Report' //body
																															,(data)Event_ScrubsAttachment
																															,'text/csv'
																															,'CorpNHEventScrubsReport.csv'
																															,
																															,
																															,corp2.Email_Notification_Lists.spray);

		Event_BadRecords				 	:= Event_N.ExpandedInFile(	
																											corp_key_Invalid							  			<> 0 or
																											corp_vendor_Invalid 									<> 0 or
																											corp_state_origin_Invalid 					 	<> 0 or
																											corp_process_date_Invalid						  <> 0 or
																											corp_sos_charter_nbr_Invalid 					<> 0 or
																											Event_filing_reference_nbr_Invalid 		<> 0 or
																											Event_filing_date_Invalid 						<> 0 or
																											Event_date_type_cd_Invalid 						<> 0 or
																											Event_date_type_desc_Invalid 					<> 0 or
																											Event_desc_Invalid 					 					<> 0
																										 );

		Event_GoodRecords					:= Event_N.ExpandedInFile(
																											corp_key_Invalid							  			= 0 and
																											corp_vendor_Invalid 									= 0 and
																											corp_state_origin_Invalid 					 	= 0 and
																											corp_process_date_Invalid						  = 0 and
																											corp_sos_charter_nbr_Invalid 					= 0 and
																											Event_filing_reference_nbr_Invalid 		= 0 and
																											Event_filing_date_Invalid 						= 0 and
																											Event_date_type_cd_Invalid 						= 0 and
																											Event_date_type_desc_Invalid 					= 0 and
																											Event_desc_Invalid 					  				= 0																										 
																										 );

		Event_FailBuild					 	:= if(count(Event_GoodRecords) = 0,true,false);

		Event_ApprovedRecords		 	:= project(Event_GoodRecords,transform(Corp2_Mapping.LayoutsCommon.Events,self := left;));


		Event_ALL								 	:= sequential(IF(count(Event_BadRecords) <> 0
																						,IF (poverwrite
																								,OUTPUT(Event_BadRecords,,Corp2_Mapping._Dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::Event_'+state_origin,overwrite,__compressed__)
																								,OUTPUT(Event_BadRecords,,Corp2_Mapping._Dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::Event_'+state_origin,__compressed__)
																								)
																						)
																				 ,output(Event_ScrubsWithExamples, all, named('CorpEventNHScrubsReportWithExamples'+fileDate))
																				 //Send Alerts if Scrubs exceeds thresholds
																				 ,IF(COUNT(Event_ScrubsAlert) > 0, Event_MailFile, OUTPUT('CORP2_MAPPING.NH - No "Event" Corp Scrubs Alerts'))
																				 ,Event_ErrorSummary
																				 ,Event_ScrubErrorReport
																				 ,Event_SomeErrorValues			
																				 ,Event_SubmitStats
																				);

	//********************************************************************
  // SCRUB MAIN
  //********************************************************************	
		Main_F := MapMain;
		Main_S := Scrubs_Corp2_Mapping_NH_Main.Scrubs;					// Scrubs module
		Main_N := Main_S.FromNone(Main_F); 											// Generate the error flags
		Main_T := Main_S.FromBits(Main_N.BitmapInfile);     		// Use the FromBits module; makes my bitmap datafile easier to get to
		Main_U := Main_S.FromExpanded(Main_N.ExpandedInFile); 	// Pass the expanded error flags into the Expanded module

		//Outputs reports
		Main_ErrorSummary					:= output(Main_U.SummaryStats, named('Main_ErrorSummary_NH'+fileDate));
		Main_ScrubErrorReport 		:= output(choosen(Main_U.AllErrors, 1000), named('Main_ScrubErrorReport_NH'+fileDate));
		Main_SomeErrorValues			:= output(choosen(Main_U.BadValues, 1000), named('Main_SomeErrorValues_NH'+fileDate));
		Main_IsScrubErrors		 		:= IF(count(Main_U.AllErrors)<> 0,true,false);

		// Orbit Stats
		Main_OrbitStats						:= Main_U.OrbitStats();

		//Outputs files
		Main_CreateBitMaps				:= output(Main_N.BitmapInfile,,'~thor_data::corp_NH_main_scrubs_bits',overwrite,compressed);	//long term storage
		Main_TranslateBitMap			:= output(Main_T);

		//Submits Profile's stats to Orbit
		Main_SubmitStats 			    := Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_NH_Main','ScrubsAlerts', Main_OrbitStats, version,'Corp_NH_Main').SubmitStats;
		Main_ScrubsWithExamples   := Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_NH_Main','ScrubsAlerts', Main_OrbitStats, version,'Corp_NH_Main').CompareToProfile_with_Examples;

		Main_ScrubsAlert					:= Main_ScrubsWithExamples(RejectWarning = 'Y');
		Main_ScrubsAttachment			:= Scrubs.fn_email_attachment(Main_ScrubsAlert);
		Main_MailFile							:= FileServices.SendEmailAttachData(corp2.Email_Notification_Lists.spray
																																 ,'Scrubs CorpMain_NH Report' //subject
																																 ,'Scrubs CorpMain_NH Report' //body
																																 ,(data)Main_ScrubsAttachment
																																 ,'text/csv'
																																 ,'CorpNHMainScrubsReport.csv'
																																 ,
																																 ,
																																 ,corp2.Email_Notification_Lists.spray);

		Main_BadRecords						:= Main_N.ExpandedInFile(	
																											 dt_vendor_first_reported_Invalid 			<> 0 or
																											 dt_vendor_last_reported_Invalid 				<> 0 or
																											 dt_first_seen_Invalid 									<> 0 or
																											 dt_last_seen_Invalid 									<> 0 or
																											 corp_ra_dt_first_seen_Invalid 					<> 0 or
																											 corp_ra_dt_last_seen_Invalid 					<> 0 or
																											 corp_key_Invalid 											<> 0 or
																											 corp_vendor_Invalid 										<> 0 or
																											 corp_state_origin_Invalid 					 		<> 0 or
																											 corp_process_date_Invalid						  <> 0 or
																											 corp_orig_sos_charter_nbr_Invalid 			<> 0 or
																											 corp_legal_name_Invalid 								<> 0 or
																											 corp_ln_name_type_cd_Invalid 					<> 0 or
																											 corp_ln_name_type_desc_Invalid 				<> 0 or
																											 corp_address1_type_cd_Invalid 					<> 0 or
																											 corp_address1_type_desc_Invalid 				<> 0 or
																											 corp_status_cd_Invalid 								<> 0 or
																											 corp_status_desc_Invalid 							<> 0 or
																											 corp_standing_Invalid 									<> 0 or
																											 corp_inc_state_Invalid 								<> 0 or
																											 corp_inc_date_Invalid 									<> 0 or
																											 corp_term_exist_cd_Invalid 						<> 0 or
																											 corp_term_exist_exp_Invalid 						<> 0 or
																											 corp_term_exist_desc_Invalid 					<> 0 or
																											 corp_foreign_domestic_ind_Invalid 			<> 0 or
																											 corp_forgn_state_cd_Invalid  					<> 0 or
																											 corp_forgn_state_desc_Invalid 					<> 0 or
																											 corp_forgn_date_Invalid 								<> 0 or
																											 corp_orig_org_structure_cd_Invalid			<> 0 or
																											 corp_orig_org_structure_desc_Invalid 	<> 0 or
																											 corp_for_profit_ind_Invalid 						<> 0 or
																											 corp_ra_address_type_desc_Invalid 			<> 0 or
																											 cont_title1_desc_Invalid 							<> 0 or
																											 cont_title2_desc_Invalid 							<> 0 or
																											 cont_title3_desc_Invalid 							<> 0 or
																											 cont_title4_desc_Invalid 							<> 0 or
																											 cont_title5_desc_Invalid 							<> 0 or
																											 cont_address_type_cd_Invalid 					<> 0 or
																											 corp_merged_corporation_id_Invalid 		<> 0 or
																											 corp_merger_date_Invalid 							<> 0 or
																											 corp_merger_id_Invalid 								<> 0 or
																											 corp_merger_indicator_Invalid 					<> 0 or
																											 recordorigin_Invalid 									<> 0 or
																											 internalfield1_Invalid									<> 0																								 
																											 
																										);
																								 																	
		Main_GoodRecords				:= Main_N.ExpandedInFile(	
																											 dt_vendor_first_reported_Invalid 			= 0 and
																											 dt_vendor_last_reported_Invalid 				= 0 and
																											 dt_first_seen_Invalid 									= 0 and
																											 dt_last_seen_Invalid 									= 0 and
																											 corp_ra_dt_first_seen_Invalid 					= 0 and
																											 corp_ra_dt_last_seen_Invalid 					= 0 and
																											 corp_key_Invalid 											= 0 and
																											 corp_vendor_Invalid 										= 0 and
																											 corp_state_origin_Invalid 					 		= 0 and
																											 corp_process_date_Invalid						  = 0 and
																											 corp_orig_sos_charter_nbr_Invalid 			= 0 and
																											 corp_legal_name_Invalid 								= 0 and
																											 corp_ln_name_type_cd_Invalid 					= 0 and
																											 corp_ln_name_type_desc_Invalid 				= 0 and
																											 corp_address1_type_cd_Invalid 					= 0 and
																											 corp_address1_type_desc_Invalid 				= 0 and
																											 corp_status_cd_Invalid 								= 0 and
																											 corp_status_desc_Invalid 							= 0 and
																											 corp_standing_Invalid 									= 0 and
																											 corp_inc_state_Invalid 								= 0 and
																											 corp_inc_date_Invalid 									= 0 and
																											 corp_term_exist_cd_Invalid 						= 0 and
																											 corp_term_exist_exp_Invalid 						= 0 and
																											 corp_term_exist_desc_Invalid 					= 0 and
																											 corp_foreign_domestic_ind_Invalid 			= 0 and
																											 corp_forgn_state_cd_Invalid  					= 0 and
																											 corp_forgn_state_desc_Invalid 					= 0 and
																											 corp_forgn_date_Invalid 								= 0 and
																											 corp_orig_org_structure_cd_Invalid			= 0 and
																											 corp_orig_org_structure_desc_Invalid 	= 0 and
																											 corp_for_profit_ind_Invalid 						= 0 and
																											 corp_ra_address_type_desc_Invalid 			= 0 and
																											 cont_title1_desc_Invalid 							= 0 and
																											 cont_title2_desc_Invalid 							= 0 and
																											 cont_title3_desc_Invalid 							= 0 and
																											 cont_title4_desc_Invalid 							= 0 and
																											 cont_title5_desc_Invalid 							= 0 and
																											 cont_address_type_cd_Invalid 					= 0 and
																											 corp_merged_corporation_id_Invalid 		= 0 and
																											 corp_merger_date_Invalid 							= 0 and
																											 corp_merger_id_Invalid 								= 0 and
																											 corp_merger_indicator_Invalid 					= 0 and
																											 recordorigin_Invalid 									= 0 and
																											 internalfield1_Invalid									= 0																								 
																								  );

		Main_FailBuild					:= map( corp2_mapping.fCalcPercent(count(Main_N.ExpandedInFile(corp_key_invalid<>0)),count(Main_N.ExpandedInFile),false) 										> Scrubs_Corp2_Mapping_NH_Main.Threshold_Percent.CORP_KEY										 => true,
																		corp2_mapping.fCalcPercent(count(Main_N.ExpandedInFile(corp_orig_sos_charter_nbr_invalid<>0)),count(Main_N.ExpandedInFile),false) 	> Scrubs_Corp2_Mapping_NH_Main.Threshold_Percent.CORP_ORIG_SOS_CHARTER_NBR 	 => true,
																		corp2_mapping.fCalcPercent(count(Main_N.ExpandedInFile(corp_legal_name_invalid<>0)),count(Main_N.ExpandedInFile),false) 						> Scrubs_Corp2_Mapping_NH_Main.Threshold_Percent.CORP_LEGAL_NAME 						 => true,
																	  count(Main_GoodRecords) = 0																																																																																											 => true,																		
																		false
																	);

		Main_ApprovedRecords		:= project(Main_GoodRecords,transform(Corp2_Mapping.LayoutsCommon.Main,self := left));


		Main_ALL		 						:= sequential( IF(count(Main_BadRecords) <> 0
																						 ,IF (poverwrite
																								 ,OUTPUT(Main_BadRecords,,Corp2_Mapping._Dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::main_'+state_origin,overwrite,__compressed__)
																								 ,OUTPUT(Main_BadRecords,,Corp2_Mapping._Dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::main_'+state_origin,__compressed__)
																								 )
																						 )
																					,output(Main_ScrubsWithExamples, all, named('CorpMainNHScrubsReportWithExamples'+fileDate))
																					//Send Alerts if Scrubs exceeds thresholds
																					,IF(COUNT(Main_ScrubsAlert) > 0, Main_MailFile, OUTPUT('CORP2_MAPPING.NH - No "MAIN" Corp Scrubs Alerts'))
																					,Main_ErrorSummary
																					,Main_ScrubErrorReport
																					,Main_SomeErrorValues		
																					,Main_SubmitStats
																				 );

	//********************************************************************
  // SCRUB STOCK
  //********************************************************************	
		Stock_F := mapStock;
		Stock_S := Scrubs_Corp2_Mapping_NH_Stock.Scrubs;						// Scrubs module
		Stock_N := Stock_S.FromNone(Stock_F); 											// Generate the error flags
		Stock_T := Stock_S.FromBits(Stock_N.BitmapInfile);     			// Use the FromBits module; makes my bitmap datafile easier to get to
		Stock_U := Stock_S.FromExpanded(Stock_N.ExpandedInFile); 		// Pass the expanded error flags into the Expanded module

		//Outputs reports
		Stock_ErrorSummary			 	:= output(Stock_U.SummaryStats, named('Stock_ErrorSummary_NH'+fileDate));
		Stock_ScrubErrorReport 	 	:= output(choosen(Stock_U.AllErrors, 1000), named('Stock_ScrubErrorReport_NH'+fileDate));
		Stock_SomeErrorValues		 	:= output(choosen(Stock_U.BadValues, 1000), named('Stock_SomeErrorValues_NH'+fileDate));
		Stock_IsScrubErrors		 	 	:= IF(count(Stock_U.AllErrors)<> 0,true,false);

		// Orbit Stats
		Stock_OrbitStats				 	:= Stock_U.OrbitStats();

		//Outputs files
		Stock_CreateBitMaps				:= output(Stock_N.BitmapInfile,,'~thor_data::corp_NH_scrubs_bits',overwrite,compressed);	//long term storage
		Stock_TranslateBitMap			:= output(Stock_T);

		//Submits Profile's stats to Orbit
		Stock_SubmitStats 			  := Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_NH_Stock','ScrubsAlerts', Stock_OrbitStats, version,'Corp_NH_Stock').SubmitStats;
		Stock_ScrubsWithExamples  := Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_NH_Stock','ScrubsAlerts', Stock_OrbitStats, version,'Corp_NH_Stock').CompareToProfile_with_Examples;

		Stock_ScrubsAlert					:= Stock_ScrubsWithExamples(RejectWarning = 'Y');
		Stock_ScrubsAttachment		:= Scrubs.fn_email_attachment(Stock_ScrubsAlert);
		Stock_MailFile						:= FileServices.SendEmailAttachData(corp2.Email_Notification_Lists.spray
																																 ,'Scrubs CorpStock_NH Report' //subject
																																 ,'Scrubs CorpStock_NH Report' //body
																																 ,(data)Stock_ScrubsAttachment
																																 ,'text/csv'
																																 ,'CorpNHStockScrubsReport.csv'
																																 ,
																																 ,
																																 ,corp2.Email_Notification_Lists.spray);

		Stock_BadRecords					:= Stock_N.ExpandedInFile(	
																												corp_key_Invalid							  			<> 0 or
																												corp_vendor_Invalid 									<> 0 or
																												corp_state_origin_Invalid 					 	<> 0 or
																												corp_process_date_Invalid						  <> 0 or
																												corp_sos_charter_nbr_Invalid					<> 0 or
																												stock_class_Invalid	 									<> 0 or 
																												stock_shares_issued_Invalid	 					<> 0 or
																												stock_authorized_nbr_Invalid	 				<> 0 or
																												stock_par_value_Invalid	 							<> 0 
																											 );

		Stock_GoodRecords					:= Stock_N.ExpandedInFile(	
																												corp_key_Invalid							  			= 0 and
																												corp_vendor_Invalid 									= 0 and
																												corp_state_origin_Invalid 					 	= 0 and
																												corp_process_date_Invalid						  = 0 and
																												corp_sos_charter_nbr_Invalid					= 0 and
																												stock_class_Invalid		 								= 0 and
																												stock_shares_issued_Invalid		 				= 0 and 
																												stock_authorized_nbr_Invalid		 			= 0 and 
																												stock_par_value_Invalid		 						= 0 
																											 );
																														
		Stock_FailBuild						:= if(count(Stock_GoodRecords) = 0,true,false);

		Stock_ApprovedRecords			:= project(Stock_GoodRecords,transform(Corp2_Mapping.LayoutsCommon.Stock,self := left));

		Stock_ALL									:= sequential( IF(count(Stock_BadRecords) <> 0
																							 ,IF (poverwrite
																									 ,OUTPUT(Stock_BadRecords,,Corp2_Mapping._Dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::stock_'+state_origin,overwrite,__compressed__)
																									 ,OUTPUT(Stock_BadRecords,,Corp2_Mapping._Dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::stock_'+state_origin,__compressed__)
																									 )
																							)
																						,output(Stock_ScrubsWithExamples, all, named('CorpStockNHScrubsReportWithExamples'+fileDate))
																						//Send Alerts if Scrubs exceeds thresholds
																						,IF(COUNT(Stock_ScrubsAlert) > 0, Stock_MailFile, OUTPUT('CORP2_MAPPING.NH - No "Stock" Corp Scrubs Alerts'))
																						,Stock_ErrorSummary
																						,Stock_ScrubErrorReport
																						,Stock_SomeErrorValues	
																						,Stock_SubmitStats
																					 );	

	//********************************************************************
  // UPDATE
  //********************************************************************
	Fail_Build						:= IF(AR_FailBuild = true or Event_FailBuild = true or Main_FailBuild = true or Stock_FailBuild = true,true,false);
	IsScrubErrors					:= IF(AR_IsScrubErrors = true or Event_IsScrubErrors = true  or Main_IsScrubErrors = true or Stock_IsScrubErrors = true,true,false);

	VersionControl.macBuildNewLogicalFile(Corp2_Mapping._dataset().thor_cluster_Files + 'in::corp2::' 	+ version + '::AR_' 		+ state_origin, AR_ApprovedRecords	 , write_ar,,,pOverwrite);
	VersionControl.macBuildNewLogicalFile(Corp2_Mapping._dataset().thor_cluster_Files + 'in::corp2::' 	+ version + '::Event_' 	+ state_origin, Event_ApprovedRecords, write_event,,,pOverwrite);
	VersionControl.macBuildNewLogicalFile(Corp2_Mapping._dataset().thor_cluster_Files + 'in::corp2::' 	+ version + '::Main_' 	+ state_origin, Main_ApprovedRecords , write_main,,,pOverwrite);	
	VersionControl.macBuildNewLogicalFile(Corp2_Mapping._dataset().thor_cluster_Files + 'in::corp2::' 	+ version + '::Stock_' 	+ state_origin, Stock_ApprovedRecords, write_stock,,,pOverwrite);

	VersionControl.macBuildNewLogicalFile(Corp2_Mapping._dataset().thor_cluster_Files + 'fail::corp2::' + version + '::AR_' 		+ state_origin, AR_F		, write_fail_ar,,,pOverwrite);
	VersionControl.macBuildNewLogicalFile(Corp2_Mapping._dataset().thor_cluster_Files + 'fail::corp2::' + version + '::Event_' 	+ state_origin, Event_F	, write_fail_event,,,pOverwrite);
	VersionControl.macBuildNewLogicalFile(Corp2_Mapping._dataset().thor_cluster_Files + 'fail::corp2::' + version + '::Main_' 	+ state_origin, Main_F	, write_fail_main,,,pOverwrite);
	VersionControl.macBuildNewLogicalFile(Corp2_Mapping._dataset().thor_cluster_Files + 'fail::corp2::' + version + '::Stock_' 	+ state_origin, Stock_F	, write_fail_stock,,,pOverwrite);

	mapNH := sequential (if(pshouldspray = true,Corp2_mapping.fSprayFiles(state_origin,version,pOverwrite := pOverwrite))
											// ,Corp2_Raw_NH.Build_Bases(filedate,version,puseprod).All									
											,AR_All
											,Event_All
											,Main_All
											,Stock_All									
											,if(Fail_Build <> true	 
												 ,sequential (write_ar
																		 ,write_event
																		 ,write_main
																		 ,write_stock	
																		 ,fileservices.addsuperfile(Corp2_Mapping._Dataset().thor_cluster_Files + 'in::'+Corp2_Mapping._Dataset().NameMapped +'::sprayed::ar'			,Corp2_Mapping._Dataset().thor_cluster_Files + 'in::corp2::'+version+'::ar_'		+state_origin)
																		 ,fileservices.addsuperfile(Corp2_Mapping._Dataset().thor_cluster_Files + 'in::'+Corp2_Mapping._Dataset().NameMapped +'::sprayed::event'	,Corp2_Mapping._Dataset().thor_cluster_Files + 'in::corp2::'+version+'::event_'	+state_origin)																		 
																		 ,fileservices.addsuperfile(Corp2_Mapping._Dataset().thor_cluster_Files + 'in::'+Corp2_Mapping._Dataset().NameMapped +'::sprayed::main'		,Corp2_Mapping._Dataset().thor_cluster_Files + 'in::corp2::'+version+'::main_'	+state_origin)																		 
																		 ,fileservices.addsuperfile(Corp2_Mapping._Dataset().thor_cluster_Files + 'in::'+Corp2_Mapping._Dataset().NameMapped +'::sprayed::stock'	,Corp2_Mapping._Dataset().thor_cluster_Files + 'in::corp2::'+version+'::stock_'	+state_origin)
																		 ,if(count(Main_BadRecords) <> 0 or count(AR_BadRecords) <> 0 or count(Event_BadRecords)<>0 or count(Stock_BadRecords)<>0
																				 ,Corp2_Mapping.Send_Email(state_origin,version,count(Main_BadRecords)<>0,count(AR_BadRecords)<>0,count(Event_BadRecords)<>0,count(Stock_BadRecords)<>0,count(Main_BadRecords),count(AR_BadRecords),count(Event_BadRecords),count(Stock_BadRecords),count(Main_ApprovedRecords),count(AR_ApprovedRecords),count(Event_ApprovedRecords),count(Stock_ApprovedRecords)).RecordsRejected																				 
																				 ,Corp2_Mapping.Send_Email(state_origin,version,count(Main_BadRecords)<>0,count(AR_BadRecords)<>0,count(Event_BadRecords)<>0,count(Stock_BadRecords)<>0,count(Main_BadRecords),count(AR_BadRecords),count(Event_BadRecords),count(Stock_BadRecords),count(Main_ApprovedRecords),count(AR_ApprovedRecords),count(Event_ApprovedRecords),count(Stock_ApprovedRecords)).MappingSuccess																				 
																				 )
																		 ,if(IsScrubErrors
																				 ,Corp2_Mapping.Send_Email(state_origin,version,Main_IsScrubErrors,AR_IsScrubErrors,Event_IsScrubErrors,Stock_IsScrubErrors).FieldsInvalidPerScrubs
																				 )
																		 ) //if Fail_Build <> true																			
												 ,SEQUENTIAL (write_fail_ar
																		 ,write_fail_event
																		 ,write_fail_main
																		 ,write_fail_stock												 
																		 ,Corp2_Mapping.Send_Email(state_origin,version).MappingFailed
																		 ) //if Fail_Build = true
												 )
										);
										
	isFileDateValid := if((string)std.date.today() between ut.date_math(filedate,-30) and ut.date_math(filedate,30),true,false);
	return sequential (	 if(isFileDateValid
													,mapNH
													,sequential (Corp2_Mapping.Send_Email(state_origin,filedate).InvalidFileDateParm
																			,FAIL('Corp2_Mapping.'+state_origin+' failed.  An invalid filedate was passed in as a parameter.')
																			)
													)
										);

	end;	// end of Update function		 
	
end; // end of NH module