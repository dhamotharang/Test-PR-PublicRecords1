Import ut, std, corp2, data_services, versioncontrol, Tools, Scrubs, Corp2_Mapping, Corp2_Raw_PA, Scrubs_Corp2_Mapping_PA_Main, Scrubs_Corp2_Mapping_PA_Event;

export PA := MODULE; 

	export Update(String filedate, string version, boolean pShouldSpray = Corp2_mapping._Dataset().bShouldSpray, boolean pOverwrite = false, boolean pUseProd = Tools._Constants.IsDataland) := Function

 	state_origin	:= 'PA';
	state_fips	 	:= '42';
	state_desc	 	:= 'PENNSYLVANIA';	
		
	// Vendor Input Data Files
	dCorporations := dedup(sort(distribute(Corp2_Raw_PA.Files(filedate,pUseProd).Input.CorporationsPipeDelim,hash(corp2.t2u(CorporationID))),record,local),record,local) : independent;
	dCorpName     := dedup(sort(distribute(Corp2_Raw_PA.Files(filedate,pUseProd).Input.CorpNamePipeDelim,hash(corp2.t2u(CorporationID))),record,local),record,local)     : independent;
	dAddress      := dedup(sort(distribute(Corp2_Raw_PA.Files(filedate,pUseProd).Input.Address.logical,hash(corp2.t2u(CorporationID))),record,local),record,local)       : independent;
	dOfficer      := dedup(sort(distribute(Corp2_Raw_PA.Files(filedate,pUseProd).Input.Officer.logical,hash(corp2.t2u(CorporationID))),record,local),record,local)       : independent;
	dFiling       := dedup(sort(distribute(Corp2_Raw_PA.Files(filedate,pUseProd).Input.Filing.logical,hash(corp2.t2u(CorporationID))),record,local),record,local)        : independent;
	dMerger       := dedup(sort(distribute(Corp2_Raw_PA.Files(filedate,pUseProd).Input.Merger.logical,hash(corp2.t2u(SurvivorCorporationID))),record,local),record,local): independent;

	// Vendor sends an empty Stock file.  The file will be checked to make sure it is empty as expected.  
	// If not empty, then the mapper will fail so development work can be done to begin mapping Stock data.
	dStock        := dedup(sort(distribute(Corp2_Raw_PA.Files(filedate,pUseProd).Input.Stock.logical,hash(CorporationID)),record,local),record,local) : independent;

	// Vendor lookup Files
	lookup_CorpStatus  := Corp2_Raw_PA.Files(filedate,pUseProd).Input.lookup_CorpStatus   : independent;		 
	lookup_CorpType    := Corp2_Raw_PA.Files(filedate,pUseProd).Input.lookup_CorpType     : independent;	
	lookup_NameType    := Corp2_Raw_PA.Files(filedate,pUseProd).Input.lookup_NameType     : independent;	
	lookup_AddrType    := Corp2_Raw_PA.Files(filedate,pUseProd).Input.lookup_AddrType     : independent;	
	//The lookup_OfficerParty contains 2.8 million records and therefore, distributing, sorting, and dedup'ing.
	lookup_OfficerParty:= dedup(sort(distribute(Corp2_Raw_PA.Files(filedate,pUseProd).Input.lookup_OfficerParty,hash(corp2.t2u(OfficerID))),record,local),record,local)  : independent;
	lookup_PartyType   := Corp2_Raw_PA.Files(filedate,pUseProd).Input.lookup_PartyType    : independent;	
	lookup_DocType     := Corp2_Raw_PA.Files(filedate,pUseProd).Input.lookup_DocType      : independent;	


 //---------------------------------------------------------------------	
 // Map Main file
 //---------------------------------------------------------------------
										
  // join Corporations and Address file
	jCorps_Addr          := join(dCorporations,dAddress,
															 corp2.t2u(left.CorporationID) = corp2.t2u(right.CorporationID),
															 transform(corp2_raw_pa.layouts.jCorporations_TempLay, 
															 self := left; self := right; self := [];),
															 left outer, local);
	
	// join Corporations/Address joined file to CorpName file
	jCorps_Addr_CorpName := join(jCorps_Addr,dCorpName,
															 corp2.t2u(left.CorporationID) = corp2.t2u(right.CorporationID),
															 transform(corp2_raw_pa.layouts.jCorporations_TempLay, 
															 self.CorporationNameID := right.CorporationNameID;
															 self.Name 							:= right.Name;
															 self.NameTypeID 				:= right.NameTypeID;
															 self := left; self := [];),
															 left outer, local);
	
  // join Corporations/Address/CorpName joined file to Merger file
	jAll                 := join(jCorps_Addr_CorpName,dMerger,
															 corp2.t2u(left.CorporationID) = corp2.t2u(right.survivorcorporationid),
															 transform(corp2_raw_pa.layouts.jCorporations_TempLay,
																 self.MergerID              := right.MergerID;
																 self.SurvivorCorporationID := right.SurvivorCorporationID;
																 self.MergedCorporationID   := right.MergedCorporationID;
																 self.MergerDate            := right.MergerDate;
																 self := left; self := [];),
															   left outer, local);
													 
  // Perform lookups needed for mapping the Main file "C" records
	 
  // lookup the CorpStatus Description	
	jlookup_CorpStatus      := join(jAll,lookup_CorpStatus
								                      ,corp2.t2u(left.CorporationStatusID) = corp2.t2u(right.CorpStatus)
																			,transform(corp2_raw_pa.layouts.jCorporations_TempLay,
																					 self.CorpStatusDesc := corp2.t2u(right.CorpStatusDesc);  		
																					 self := left; self := [];)
								                      ,left outer, lookup);
		
 
  // lookup the CorpType Description	
	jlookup_CorpType      := join(jlookup_CorpStatus,lookup_CorpType
								                     ,corp2.t2u(left.CorporationTypeID) = corp2.t2u(right.CorpTypeID)
								                     ,transform(corp2_raw_pa.layouts.jCorporations_TempLay,
																					 self.CorpTypeDesc := corp2.t2u(right.CorpTypeDesc);  		
																					 self := left; self := [];)
								                      ,left outer, lookup);
								
	// lookup the NameType Description	
	jlookup_NameType      := join(jlookup_CorpType,lookup_NameType
							                       ,corp2.t2u(left.NameTypeID) = corp2.t2u(right.NameTypeID)
								                     ,transform(corp2_raw_pa.layouts.jCorporations_TempLay,
																					 self.NameTypeDesc := corp2.t2u(right.NameTypeDesc);  		
																					 self := left; self := [];)
								                      ,left outer, lookup);
								
  // lookup the AddressType Description	
	Corp_Recs_toMap				:= join(jlookup_NameType,lookup_AddrType
																		 ,corp2.t2u(left.AddressTypeID) = corp2.t2u(right.AddressTypeID)
																		 ,transform(corp2_raw_pa.layouts.jCorporations_TempLay,
																				 self.AddressTypeDesc := corp2.t2u(right.AddressTypeDesc);  		
																				 self := left; self := [];)
																		 ,left outer, lookup);
		
	// Map Main file "C" Records
	Corp2_Mapping.LayoutsCommon.Main trfMainC(Corp2_Raw_PA.Layouts.jCorporations_TempLay input) := transform												   
		  self.dt_vendor_first_reported		  := (integer)fileDate;
			self.dt_vendor_last_reported		  := (integer)fileDate;
			self.dt_first_seen							  := (integer)fileDate;
			self.dt_last_seen								  := (integer)fileDate;
			self.corp_ra_dt_first_seen			  := (integer)fileDate;
			self.corp_ra_dt_last_seen				  := (integer)fileDate;
			self.corp_key										  := state_fips + '-' + corp2.t2u(input.entityid);
      self.corp_vendor								  := state_fips;
			self.corp_state_origin					  := state_origin;
			self.corp_process_date					  := fileDate;
			self.corp_orig_sos_charter_nbr	  := corp2.t2u(input.entityid);
			self.corp_legal_name						  := Corp2_mapping.fCleanBusinessName(state_origin,state_desc,input.name).BusinessName;
			self.corp_inc_state 						  := state_origin;
			self.corp_ln_name_type_cd         := if (corp2.t2u(input.nametypeid) <> '4' ,Corp2_Raw_PA.Functions.GetNameTypCd(input.nametypeid) ,'');
			self.corp_ln_name_type_desc       := Corp2_Raw_PA.Functions.GetNameTypDesc(input.nametypeid,input.nametypedesc);
			self.corp_address1_type_cd        := if ( Corp2_Mapping.fAddressExists(state_origin,state_desc,input.address2,input.address3,input.city,input.state,input.zip,input.country).ifAddressExists
																						   ,Corp2_Raw_PA.Functions.GetAddrCd(input.AddressTypeID) ,'');
			self.corp_address1_type_desc      := if ( Corp2_Mapping.fAddressExists(state_origin,state_desc,input.address2,input.address3,input.city,input.state,input.zip,input.country).ifAddressExists
																						   ,Corp2_Raw_PA.Functions.GetAddrDesc(input.AddressTypeID,input.AddressTypeDesc) ,'');
			self.corp_address1_line1          := Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.address2,input.address3,input.city,input.state,input.zip,input.country).AddressLine1;
			self.corp_address1_line2          := Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.address2,input.address3,input.city,input.state,input.zip,input.country).AddressLine2;
			self.corp_address1_line3          := Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.address2,input.address3,input.city,input.state,input.zip,input.country).AddressLine3	;	 
			self.corp_prep_addr1_line1        := Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.address2,input.address3,input.city,input.state,input.zip,input.country).PrepAddrLine1;	
			self.corp_prep_addr1_last_line    := Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.address2,input.address3,input.city,input.state,input.zip,input.country).PrepAddrLastLine;	
			self.corp_ra_full_name            := Corp2_mapping.fCleanBusinessName(state_origin,state_desc,input.registeredagentname).BusinessName;
			self.corp_agent_county            := corp2.t2u(input.county);
			self.corp_inc_county              := if(corp2.t2u(input.countyofincorporation) <> ''
																						 ,corp2.t2u(input.countyofincorporation) ,corp2.t2u(input.county));
			self.corp_country_of_formation    := Corp2_mapping.fCleanCountry(state_origin,state_desc,,input.countryofincorporation).country;
			self.corp_purpose                 := corp2.t2u(input.purpose);
			self.corp_orig_bus_type_desc      := corp2.t2u(input.purpose); //retaining from old mapper, because corp_purpose is a new field
			self.corp_dissolved_date          := Corp2_Mapping.fValidateDate(input.dissolvedate,'MMM_DD_CCYY').GeneralDate;
	    self.corp_addl_info 				      := if(self.corp_dissolved_date <> '' 
																							,'DISSOLVE DATE: '+ self.corp_dissolved_date[5..6]+'/'+self.corp_dissolved_date[7..8]+'/'+self.corp_dissolved_date[1..4] 
																							,''); //Retaining since corp_dissolved_date is a new field
			self.corp_inc_date                := if(corp2.t2u(input.stateofincorporation) in [state_origin,''] 
																							,Corp2_Mapping.fValidateDate(input.DateFormed,'MMM_DD_CCYY').PastDate, '');
		  self.corp_forgn_date              := if(corp2.t2u(input.stateofincorporation) not in [state_origin,''] 
																							,Corp2_Mapping.fValidateDate(input.DateFormed,'MMM_DD_CCYY').PastDate, '');
			self.corp_merger_id               := corp2.t2u(input.mergerid);
			self.corp_survivor_corporation_id := corp2.t2u(input.survivorcorporationid);
			self.corp_merged_corporation_id   := corp2.t2u(input.mergedcorporationid);
			self.corp_merger_date             := Corp2_Mapping.fValidateDate(input.mergerdate,'MMM_DD_CCYY').GeneralDate;
			self.corp_foreign_domestic_ind    := case(corp2.t2u(input.citizenship), 'D'=>'D', 'F'=>'F', '');
			self.corp_for_profit_ind          := if (corp2.t2u(input.corporationtypeid) in ['9','22','23','27','41'],'N', '');
			self.corp_forgn_state_cd 		 	    := if (corp2.t2u(input.stateofincorporation) not in [state_origin,'']
																				 	    ,corp2.t2u(input.stateofincorporation) ,'');
			self.corp_forgn_state_desc   	    := if (corp2.t2u(input.stateofincorporation) not in [state_origin,'']
																					    ,Corp2_Raw_PA.Functions.decode_state(corp2.t2u(input.stateofincorporation)),'');
 	    self.corp_orig_org_structure_cd   := if (corp2.t2u(input.corporationtypeid) <> '2', corp2.t2u(input.corporationtypeid), '') ;													 
      self.corp_orig_org_structure_desc := if (corp2.t2u(input.CorpTypeDesc) <> 'NAME REGISTRATION', corp2.t2u(input.CorpTypeDesc), '');
			self.corp_status_cd               := if (corp2.t2u(input.corporationstatusid) not in ['3','6'] ,corp2.t2u(input.corporationstatusid) ,'');	
			self.corp_status_desc             := if (corp2.t2u(input.corporationstatusid) not in ['3','6'], corp2.t2u(input.corpstatusdesc),'');			
      self.corp_name_status_cd          := if (corp2.t2u(input.corporationstatusid) in ['3','6'] ,corp2.t2u(input.corporationstatusid) ,'');
			self.corp_name_status_desc        := map(corp2.t2u(input.corporationstatusid) ='3' => corp2.t2u(input.corpstatusdesc),
																							 corp2.t2u(input.corporationstatusid) ='6' => 'NAME RESERVATION EXPIRATION' ,'');	
			self.corp_term_exist_exp  			  := Corp2_Mapping.fValidateDate(input.duration).GeneralDate;
			self.corp_term_exist_cd 		      := map(corp2.t2u(input.duration[1]) = 'P' => 'P',                                                                             
																					     self.corp_term_exist_exp <> ''     => 'D', '');
			self.corp_term_exist_desc  			  := case(self.corp_term_exist_cd, 'P'=>'PERPETUAL', 'D'=>'EXPIRATION DATE', '');
		  self.recordOrigin                 := 'C';			
			self                              := input;
		  self						                  := [];
	end;

	MapMainC         := PROJECT(Corp_Recs_toMap,trfMainC(left)) : independent;
	
	//----------------------------------------------
	//Perform joins needed to map Contact Records
  //----------------------------------------------
	Corp_CorpName_join  := join(dCorpName,dCorporations,
												   corp2.t2u(left.CorporationID) = corp2.t2u(right.CorporationID),
																	transform(corp2_raw_pa.layouts.jOfficers_TempLay,
													           self.CorpName_Name := left.name;
																		 self.EntityID := right.EntityID;
																		 self := left; self := right; self := []; ),
																	 left outer,	local	);
	
	dedupCorp     := DEDUP(Corp_CorpName_join, corp2.t2u(CorporationID)) : independent; 
	
  // One record for every record in the Officer file 
	Corp_Offic_join  := join(dOfficer,dedupCorp,
												   corp2.t2u(left.CorporationID) = corp2.t2u(right.CorporationID),
														transform(corp2_raw_pa.layouts.jOfficers_TempLay,
															self.OfficerID 				:= left.OfficerID ;
															self.CorporationID    := left.CorporationID;
															self.Name 						:= left.Name;
															self.Address1 				:= left.Address1;
															self.Address2 		 		:= left.Address2;
															self.Address3 		 		:= left.Address3;
															self.City 				 		:= left.City;
															self.State 				 		:= left.State;
															self.Zip 					 		:= left.Zip;
															self.CountryName      := left.CountryName;
															self.OwnerPercentage 	:= left.OwnerPercentage;
															self := right;  self := []; ),
														inner,	local	);

	Corp_Offic_dist	:= distribute(Corp_Offic_join,hash(OfficerID)) : independent;
	
  // lookup the PartyType ID  
	jlookup_PartyTypeID := join(Corp_Offic_dist,lookup_OfficerParty
								                   ,corp2.t2u(left.OfficerID) = corp2.t2u(right.OfficerID)
								                   ,transform(Corp2_Raw_PA.Layouts.jOfficers_TempLay,
																					 self.PartyTypeID := corp2.t2u(right.PartyTypeID);  
																					 self := left;  self := [];)
																	 ,left outer, local);
																	 
  // lookup the PartyType Description  
	Cont_Recs_toMap                := join(jlookup_PartyTypeID,lookup_PartyType
								                        ,corp2.t2u(left.PartyTypeID) = corp2.t2u(right.PartyTypeID)
								                        ,transform(Corp2_Raw_PA.Layouts.jOfficers_TempLay,
																						 self.PartyTypeDesc := corp2.t2u(right.PartyTypeDesc);  
																						 self := left;  self := [];)
																				,left outer, lookup);
	
	// Map Main file "T" Records
	Corp2_Mapping.LayoutsCommon.Main trfMainT(Corp2_Raw_PA.Layouts.jOfficers_TempLay input) := transform
	       ,skip(corp2.t2u(input.name) in ['','UNKNOWN UNKNOWN','NONE NONE','UNKNOWN','NA NA'] or
				       corp2.t2u(input.entityid) = '')
			self.dt_vendor_first_reported		 := (integer)fileDate;
			self.dt_vendor_last_reported		 := (integer)fileDate;
			self.dt_first_seen							 := (integer)fileDate;
			self.dt_last_seen								 := (integer)fileDate;
			self.corp_ra_dt_first_seen			 := (integer)fileDate;
			self.corp_ra_dt_last_seen				 := (integer)fileDate;
			self.corp_key										 := state_fips + '-' + corp2.t2u(input.entityid);
      self.corp_vendor								 := state_fips;
			self.corp_state_origin					 := state_origin;
			self.corp_process_date					 := fileDate;
			self.corp_orig_sos_charter_nbr	 := corp2.t2u(input.entityid);
			self.corp_legal_name						 := Corp2_mapping.fCleanBusinessName(state_origin,state_desc,input.CorpName_Name).BusinessName;
			self.corp_inc_state 						 := state_origin;
			self.cont_type_cd								 := if (corp2.t2u(input.partytypeid) <> '', 'T', '');
			self.cont_type_desc							 := if (corp2.t2u(input.partytypeid) <> '', 'CONTACT', '');
			self.cont_full_name              := Corp2_mapping.fCleanBusinessName(state_origin,state_desc,input.name).BusinessName;
			self.cont_title1_desc            := if (corp2.t2u(input.partytypeid) <> '1' ,corp2.t2u(input.PartyTypeDesc), '');
			self.cont_owner_percentage       := (integer)input.ownerpercentage;
	    self.cont_address_type_cd        := if (Corp2_Mapping.fAddressExists(state_origin,state_desc,input.address1,input.address2+' '+input.address3,input.city,input.state,input.zip,input.CountryName).ifAddressExists,'T','');
		  self.cont_address_type_desc      := if (Corp2_Mapping.fAddressExists(state_origin,state_desc,input.address1,input.address2+' '+input.address3,input.city,input.state,input.zip,input.CountryName).ifAddressExists,'CONTACT','');
			self.cont_address_line1          := Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.address1,input.address2+' '+input.address3,input.city,input.state,input.zip,input.CountryName).AddressLine1;
			self.cont_address_line2          := Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.address1,input.address2+' '+input.address3,input.city,input.state,input.zip,input.CountryName).AddressLine2;
			self.cont_address_line3          := Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.address1,input.address2+' '+input.address3,input.city,input.state,input.zip,input.CountryName).AddressLine3;
			self.cont_prep_addr_line1        := Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.address1,input.address2+' '+input.address3,input.city,input.state,input.zip,input.CountryName).PrepAddrLine1;	
			self.cont_prep_addr_last_line    := Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.address1,input.address2+' '+input.address3,input.city,input.state,input.zip,input.CountryName).PrepAddrLastLine;	
			self.recordOrigin                := 'T';			
			self                             := input;
		  self						                 := [];
	end;

	MapMainT  := PROJECT(Cont_Recs_toMap,trfMainT(left));

 //---------------------------------------------------------------------
 // End of Map Main file
 //---------------------------------------------------------------------
  
 //---------------------------------------------------------------------	
 // Map Events file
 //---------------------------------------------------------------------
	
 	Corp2_Raw_PA.Layouts.normFiling_layout normFilingtrf(Corp2_Raw_PA.Layouts.FilingLayoutIn l, unsigned1 cnt) := transform
				 ,skip((cnt=1 and l.FilingDate = '' and l.EffectiveDate <> '') or
				   		 (cnt=2 and l.EffectiveDate = '') or 
							 (cnt=2 and l.FilingDate = l.EffectiveDate))
		self.Norm_event_filing_date := choose(cnt ,l.FilingDate	,l.EffectiveDate);
		self.Norm_nmtyp  					  := choose(cnt ,if(l.FilingDate    <> '','F','')
																							,if(l.EffectiveDate <> '','E',''));
		self 											  := l;
	end;
	normFiling	    := normalize(dFiling, 2, normFilingtrf(left, counter)) : independent;	  
		
  Filing_Corp_join  := join(normFiling,dCorporations,
												   corp2.t2u(left.CorporationID) = corp2.t2u(right.CorporationID),
												   transform(corp2_raw_pa.layouts.jFilCorp_TempLay,
													           self.EntityID := right.EntityID;
																		 self := left; self := right; self := []; ),
																		 left outer,	local	): independent;	
	
	ARtypes := ['100','101','148','149','245','258','286','298','311','319','356'];	
		
  // Map to the Events Common Layout
	Corp2_Mapping.LayoutsCommon.Events trfEvent(Corp2_Raw_PA.Layouts.jFilCorp_TempLay  l, Corp2_Raw_PA.Layouts.lookupLay_DocType r) := transform		
			,skip(corp2.t2u(l.entityid) = '' or corp2.t2u(r.DocTypeID) in ['0',ARtypes])
		self.corp_key				           := state_fips + '-' + corp2.t2u(l.entityid);
		self.corp_vendor 			         := state_fips;
		self.corp_state_origin		     := state_origin;
		self.corp_process_date		     := fileDate;
		self.event_filing_cd 		       := corp2.t2u(r.DocTypeID);
		self.event_filing_desc 	       := Corp2_Raw_PA.Functions.ShortenDesc(r.DocTypeID,r.DocTypeDesc);
		self.event_filing_date         := Corp2_Mapping.fValidateDate(l.Norm_event_filing_date,'MMM_DD_CCYY').GeneralDate;
		self.event_date_type_cd        := case(l.Norm_nmtyp, 'F'=>'FIL'   , 'E'=>'EFF'      , '');
		self.event_date_type_desc      := case(l.Norm_nmtyp, 'F'=>'FILING', 'E'=>'EFFECTIVE', '');
		self:=[];
	end;

  Eventjoin := join(Filing_Corp_join,lookup_DocType
								   ,corp2.t2u(left.DocumentTypeId) = corp2.t2u(right.DocTypeID)
								   ,trfEvent(left,right)
									 ,lookup);
 //---------------------------------------------------------------------	
 // End of Map Events file
 //---------------------------------------------------------------------
  	

 //--------------------------------------------------------------------	
 // Map AR file
 //--------------------------------------------------------------------
 	// Map to the AR Common Layout	record will be created when the DocumentTypeID is equal to 
	Corp2_Mapping.LayoutsCommon.AR trfAr(Corp2_Raw_PA.Layouts.jFilCorp_TempLay input) := transform	
			,skip(corp2.t2u(input.entityid) = '' or corp2.t2u(input.documenttypeid) not in ARtypes)
		self.corp_key				       := state_fips + '-' + corp2.t2u(input.entityid);
		self.corp_sos_charter_nbr  := corp2.t2u(input.entityid);
		self.corp_vendor 			     := state_fips;
		self.corp_state_origin		 := state_origin;
		self.corp_process_date		 := fileDate;
		self.ar_type               := Corp2_Raw_PA.Functions.GetARType(input.documenttypeid);
		self.ar_comment 	         := self.ar_type; // Retaining from old mapper until new length of ar_type is displayable
		self.ar_filed_dt           := Corp2_Mapping.fValidateDate(input.Norm_event_filing_date,'MMM_DD_CCYY').GeneralDate;
		self                       := [];
	end;
 //--------------------------------------------------------------------	
 // End of Map AR file
 //--------------------------------------------------------------------


 //-----------------------------------------------------------//
 // Build the Final Mapped Files
 //-----------------------------------------------------------//
  mapMain  := dedup(sort(distribute(MapMainC + MapMainT,hash(corp_key)), record,local), record,local) : independent;	
 	mapEvent := dedup(sort(distribute(Eventjoin,hash(corp_key)), record,local), record,local) : independent;	
  mapAR    := dedup(sort(distribute(project(Filing_Corp_join,trfAr(left)),hash(corp_key)), record,local), record,local) : independent;

  //--------------------------------------------------------------------	
  // Scrubs for MAIN
  //--------------------------------------------------------------------
		Main_F := MapMain;
		Main_S := Scrubs_Corp2_Mapping_PA_Main.Scrubs;        // PA scrubs module
		Main_N := Main_S.FromNone(Main_F); 										// Generate the error flags
		Main_T := Main_S.FromBits(Main_N.BitmapInfile);     	// Use the FromBits module; makes my bitmap datafile easier to get to
		Main_U := Main_S.FromExpanded(Main_N.ExpandedInFile); // Pass the expanded error flags into the Expanded module

	//Outputs reports
		Main_ErrorSummary					:= output(Main_U.SummaryStats, named('Main_ErrorSummary_PA'+filedate));
		Main_ScrubErrorReport 		:= output(choosen(Main_U.AllErrors, 1000), named('Main_ScrubErrorReport_PA'+filedate));
		Main_SomeErrorValues			:= output(choosen(Main_U.BadValues, 1000), named('Main_SomeErrorValues_PA'+filedate));
		Main_IsScrubErrors		 		:= IF(count(Main_U.AllErrors)<> 0,true,false);

		// Orbit Stats
		Main_OrbitStats						:= Main_U.OrbitStats();
		
		//Outputs files
		Main_CreateBitMaps				:= output(Main_N.BitmapInfile,,'~thor_data::corp_PA_main_scrubs_bits',overwrite,compressed);	//long term storage
		Main_TranslateBitMap			:= output(Main_T);

    //Submits Profile's stats to Orbit
    Main_SubmitStats          := Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_PA_Main','ScrubsAlerts', Main_OrbitStats, version,'Corp_PA_Main').SubmitStats;
	
	  Main_ScrubsWithExamples		:= Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_PA_Main','ScrubsAlerts', Main_OrbitStats, version,'Corp_PA_Main').CompareToProfile_with_Examples;
		
		Main_ScrubsAlert					:= Main_ScrubsWithExamples(RejectWarning = 'Y');
		Main_ScrubsAttachment			:= Scrubs.fn_email_attachment(Main_ScrubsAlert);
		Main_SendEmailFile				:= FileServices.SendEmailAttachData( corp2.Email_Notification_Lists.spray
																																	 ,'Scrubs CorpMain_PA Report' //subject
																																	 ,'Scrubs CorpMain_PA Report' //body
																																	 ,(data)Main_ScrubsAttachment
																																	 ,'text/csv'
																																	 ,'CorpPAMainScrubsReport.csv'
																																	 ,
																																	 ,
																																	 ,corp2.Email_Notification_Lists.spray
																																 );		
																																 																													
		Main_BadRecords := Main_T.ExpandedInFile(	dt_vendor_first_reported_invalid 			 <> 0 or
																							dt_vendor_last_reported_invalid 			 <> 0 or
																							dt_first_seen_invalid 							 	 <> 0 or
																							dt_last_seen_invalid 									 <> 0 or
																							corp_ra_dt_first_seen_invalid 				 <> 0 or
																							corp_ra_dt_last_seen_invalid 					 <> 0 or
																							corp_key_invalid 							 				 <> 0 or
																							corp_vendor_invalid 									 <> 0 or
																							corp_state_origin_invalid 						 <> 0 or
																							corp_process_date_invalid 						 <> 0 or
																							corp_orig_sos_charter_nbr_invalid 		 <> 0 or
																							corp_legal_name_invalid 							 <> 0 or
																							corp_ln_name_type_cd_invalid 					 <> 0 or
																							corp_ln_name_type_desc_invalid 				 <> 0 or
																							corp_status_cd_invalid                 <> 0 or
																							corp_status_desc_invalid 							 <> 0 or
																							corp_inc_state_invalid 								 <> 0 or
																							corp_inc_date_invalid 								 <> 0 or
																							corp_term_exist_cd_invalid 						 <> 0 or
																							corp_term_exist_desc_invalid           <> 0 or
																							corp_term_exist_exp_invalid 					 <> 0 or
																							corp_foreign_domestic_ind_invalid 		 <> 0 or
																							corp_forgn_date_invalid 							 <> 0 or
																							corp_orig_org_structure_cd_invalid     <> 0 or
																							corp_orig_org_structure_desc_invalid 	 <> 0 or
																							corp_for_profit_ind_invalid 					 <> 0 or
																							corp_dissolved_date_invalid            <> 0 or
																							corp_merger_date_invalid               <> 0 or
																							corp_name_status_cd_invalid            <> 0 or
																							corp_address1_type_cd_invalid      		 <> 0 or
																							corp_address1_type_desc_invalid      	 <> 0 or
																							cont_type_cd_invalid      						 <> 0 or
																							cont_type_desc_invalid                 <> 0 or
																							cont_address_type_cd_invalid           <> 0 or
																							cont_address_type_desc_invalid         <> 0 or
																							cont_title1_desc_invalid               <> 0 or
																							corp_forgn_state_desc_invalid          <> 0 or
																							corp_name_status_desc_invalid 	       <> 0 );


		Main_GoodRecords	:= Main_T.ExpandedInFile( dt_vendor_first_reported_invalid 		   = 0 and
																								dt_vendor_last_reported_invalid 			 = 0 and
																								dt_first_seen_invalid 							 	 = 0 and
																								dt_last_seen_invalid 									 = 0 and
																								corp_ra_dt_first_seen_invalid 				 = 0 and
																								corp_ra_dt_last_seen_invalid 					 = 0 and
																								corp_key_invalid 							 				 = 0 and
																								corp_vendor_invalid 									 = 0 and
																								corp_state_origin_invalid 						 = 0 and
																								corp_process_date_invalid 						 = 0 and
																								corp_orig_sos_charter_nbr_invalid 		 = 0 and
																								corp_legal_name_invalid 							 = 0 and
																								corp_ln_name_type_cd_invalid 					 = 0 and
																								corp_ln_name_type_desc_invalid 				 = 0 and
																								corp_status_cd_invalid                 = 0 and
																								corp_status_desc_invalid 							 = 0 and
																								corp_inc_state_invalid 								 = 0 and
																								corp_inc_date_invalid 								 = 0 and
																								corp_term_exist_cd_invalid 						 = 0 and
																								corp_term_exist_desc_invalid           = 0 and
																								corp_term_exist_exp_invalid 					 = 0 and
																								corp_foreign_domestic_ind_invalid 		 = 0 and
																								corp_forgn_date_invalid 							 = 0 and
																								corp_orig_org_structure_cd_invalid     = 0 and
																								corp_orig_org_structure_desc_invalid 	 = 0 and
																								corp_for_profit_ind_invalid 					 = 0 and
																								corp_dissolved_date_invalid            = 0 and
																								corp_merger_date_invalid               = 0 and
																								corp_name_status_cd_invalid            = 0 and
																								corp_address1_type_cd_invalid      		 = 0 and
																								corp_address1_type_desc_invalid      	 = 0 and
																								cont_type_cd_invalid      						 = 0 and
																								cont_type_desc_invalid                 = 0 and
																								cont_address_type_cd_invalid           = 0 and
																								cont_address_type_desc_invalid         = 0 and
																								cont_title1_desc_invalid               = 0 and
																								corp_forgn_state_desc_invalid          = 0 and
																								corp_name_status_desc_invalid       	 = 0 );																												 																	
																																																																						
		Main_FailBuild	:= map(corp2_mapping.fCalcPercent(count(Main_N.ExpandedInFile(corp_orig_sos_charter_nbr_invalid<>0)),count(Main_N.ExpandedInFile),false) > Scrubs_Corp2_Mapping_PA_Main.Threshold_Percent.CORP_ORIG_SOS_CHARTER_NBR => true,
													 corp2_mapping.fCalcPercent(count(Main_N.ExpandedInFile(corp_legal_name_invalid<>0)),					 count(Main_N.ExpandedInFile),false) > Scrubs_Corp2_Mapping_PA_Main.Threshold_Percent.CORP_LEGAL_NAME 					=> true,
													 corp2_mapping.fCalcPercent(count(Main_N.ExpandedInFile(corp_status_cd_invalid<>0)),					 count(Main_N.ExpandedInFile),false) > Scrubs_Corp2_Mapping_PA_Main.Threshold_Percent.CORP_STATUS_CD 					 	=> true,
													 count(Main_GoodRecords) = 0																																																																																				          => true,
													 false );

		Main_ApprovedRecords := project(Main_GoodRecords,transform(Corp2_Mapping.LayoutsCommon.Main,self := left));
			
		Main_ALL		 						:= sequential( IF(count(Main_BadRecords) <> 0
																										,IF (poverwrite
																												,OUTPUT(Main_BadRecords,,Corp2_Mapping._Dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::main_'+state_origin,overwrite,__compressed__)
																												,OUTPUT(Main_BadRecords,,Corp2_Mapping._Dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::main_'+state_origin,__compressed__)
																												)
																							)
																					,output(Main_ScrubsWithExamples, all, named('CorpMainPAScrubsReportWithExamples'+filedate))
																					//Send Alerts if Scrubs exceeds thresholds
																					,IF(COUNT(Main_ScrubsAlert) > 0, Main_SendEmailFile, OUTPUT('CORP2_MAPPING.PAM - No "MAIN" Corp Scrubs Alerts'))
																					,Main_ErrorSummary
																					,Main_ScrubErrorReport
																					,Main_SomeErrorValues	
																					,Main_SubmitStats
																				);																	
	//--------------------------------------------------------------------	
  // Scrubs for Event
  //--------------------------------------------------------------------
		Event_F := MapEvent;
		Event_S := Scrubs_Corp2_Mapping_PA_Event.Scrubs;        // PA scrubs module
		Event_N := Event_S.FromNone(Event_F); 									// Generate the error flags
		Event_T := Event_S.FromBits(Event_N.BitmapInfile);     	// Use the FromBits module; makes my bitmap datafile easier to get to
		Event_U := Event_S.FromExpanded(Event_N.ExpandedInFile);// Pass the expanded error flags into the Expanded module

	//Outputs reports
		Event_ErrorSummary				:= output(Event_U.SummaryStats, named('Event_ErrorSummary_PA'+filedate));
		Event_ScrubErrorReport 		:= output(choosen(Event_U.AllErrors, 1000), named('Event_ScrubErrorReport_PA'+filedate));
		Event_SomeErrorValues			:= output(choosen(Event_U.BadValues, 1000), named('Event_SomeErrorValues_PA'+filedate));
		Event_IsScrubErrors		 		:= IF(count(Event_U.AllErrors)<> 0,true,false);

		// Orbit Stats
		Event_OrbitStats						:= Event_U.OrbitStats();
		
		//Outputs files
		Event_CreateBitMaps				:= output(Event_N.BitmapInfile,,'~thor_data::corp_PA_Event_scrubs_bits',overwrite,compressed);	//long term storage
		Event_TranslateBitMap			:= output(Event_T);
	
	  //Submits Profile's stats to Orbit
    Event_SubmitStats         := Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_PA_Event','ScrubsAlerts', Event_OrbitStats, version,'Corp_PA_Event').SubmitStats;
	
	  Event_ScrubsWithExamples	:= Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_PA_Event','ScrubsAlerts', Event_OrbitStats, version,'Corp_PA_Event').CompareToProfile_with_Examples;
		
		Event_ScrubsAlert					:= Event_ScrubsWithExamples(RejectWarning = 'Y');
		Event_ScrubsAttachment		:= Scrubs.fn_email_attachment(Event_ScrubsAlert);
		Event_SendEmailFile				:= FileServices.SendEmailAttachData( corp2.Email_Notification_Lists.spray
																																	 ,'Scrubs CorpEvent_PA Report' //subject
																																	 ,'Scrubs CorpEvent_PA Report' //body
																																	 ,(data)Event_ScrubsAttachment
																																	 ,'text/csv'
																																	 ,'CorpPAEventScrubsReport.csv'
																																	 ,
																																	 ,
																																	 ,corp2.Email_Notification_Lists.spray
																																 );		
																																 
		Event_BadRecords := Event_T.ExpandedInFile(	corp_key_invalid  		         <> 0 or
																								event_filing_cd_invalid		     <> 0 );	

		Event_GoodRecords	:= Event_T.ExpandedInFile(corp_key_invalid  		         = 0 and
																								event_filing_cd_invalid		     = 0  );																					 																	
		
		Event_FailBuild	:= map(corp2_mapping.fCalcPercent(count(Event_N.ExpandedInFile(corp_key_invalid<>0)),					   count(Event_N.ExpandedInFile),false) > Scrubs_Corp2_Mapping_PA_Event.Threshold_Percent.CORP_KEY      						=> true,
													 count(Event_GoodRecords) = 0																																																																																				        => true,
													 false );

		Event_ApprovedRecords := project(Event_GoodRecords,transform(Corp2_Mapping.LayoutsCommon.Events,self := left));		
		
		Event_ALL		 						:= sequential( IF(count(Event_BadRecords) <> 0
																								,IF (poverwrite
																										,OUTPUT(Event_BadRecords,,Corp2_Mapping._Dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::event_'+state_origin,overwrite,__compressed__)
																										,OUTPUT(Event_BadRecords,,Corp2_Mapping._Dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::event_'+state_origin,__compressed__)
																										)
																						)
																				,output(Event_ScrubsWithExamples, all, named('CorpEvent_PAScrubsReportWithExamples'+filedate))
																				//Send Alerts if Scrubs exceeds thresholds
																				,IF(COUNT(Event_ScrubsAlert) > 0, Event_SendEmailFile, OUTPUT('CORP2_MAPPING.PA - No "Event_" Corp Scrubs Alerts'))
																				,Event_ErrorSummary
																				,Event_ScrubErrorReport
																				,Event_SomeErrorValues	
																				,Event_SubmitStats
																			);	
																			
		//-------------------- Version Control -----------------------------------------------------//	
	  VersionControl.macBuildNewLogicalFile('~thor_data400::in::corp2::'+version+'::main_pa'	    ,Main_ApprovedRecords  ,main_out,,,pOverwrite);		
    VersionControl.macBuildNewLogicalFile('~thor_data400::in::corp2::'+version+'::event_pa'	    ,Event_ApprovedRecords,event_out,,,pOverwrite);
	  VersionControl.macBuildNewLogicalFile('~thor_data400::in::corp2::'+version+'::ar_pa'		    ,MapAR		            ,ar_out		,,,pOverwrite);
			
	  VersionControl.macBuildNewLogicalFile('~thor_data400::failed::corp2::'+version+'::main_pa'	,MapMain     ,write_fail_main	,,,pOverwrite);		
	  VersionControl.macBuildNewLogicalFile('~thor_data400::failed::corp2::'+version+'::event_pa'	,MapEvent    ,write_fail_event,,,pOverwrite);	
		
		countStock := count(dStock);
		
	  mapPA:= sequential(if(pshouldspray = true,Corp2_mapping.fSprayFiles(state_origin ,version,pOverwrite := pOverwrite))
												,IF (countStock > 1 
														,fail  ('Vendor started sending Stock data - Development work is needed!')
														,output('Stock file is empty as expected. Continuing.'))
												// ,Corp2_Raw_PA.Build_Bases(filedate,version,pUseProd).All // Determined build bases is not needed
												,main_out
												,event_out
												,ar_out
												,IF(Main_FailBuild <> true or Event_FailBuild <> true
														,sequential( fileservices.addsuperfile(Corp2_Mapping._Dataset().thor_cluster_Files + 'in::'+Corp2_Mapping._Dataset().NameMapped+'::sprayed::ar'		,Corp2_Mapping._Dataset().thor_cluster_Files + 'in::corp2::'+version+'::ar_pa')
																				,fileservices.addsuperfile(Corp2_Mapping._Dataset().thor_cluster_Files + 'in::'+Corp2_Mapping._Dataset().NameMapped+'::sprayed::event'	,Corp2_Mapping._Dataset().thor_cluster_Files + 'in::corp2::'+version+'::event_pa')
																				,fileservices.addsuperfile(Corp2_Mapping._Dataset().thor_cluster_Files + 'in::'+Corp2_Mapping._Dataset().NameMapped+'::sprayed::main'	,Corp2_Mapping._Dataset().thor_cluster_Files + 'in::corp2::'+version+'::main_pa')																		 
																				,if (count(Main_BadRecords) <> 0 or  count(Event_BadRecords) <> 0 
																						 ,Corp2_Mapping.Send_Email(state_origin ,version,count(Main_BadRecords)<>0,,count(Event_BadRecords)<>0,,count(Main_BadRecords),,count(Event_BadRecords),,count(Main_ApprovedRecords),count(mapAR),count(Event_ApprovedRecords)).RecordsRejected																				 
																						 ,Corp2_Mapping.Send_Email(state_origin ,version,count(Main_BadRecords)<>0,,count(Event_BadRecords)<>0,,count(Main_BadRecords),,count(Event_BadRecords),,count(Main_ApprovedRecords),count(mapAR),count(Event_ApprovedRecords)).MappingSuccess																				 
																						 )	 
																			)
														 ,sequential( write_fail_main//if it fails on  main file threshold ,still writing mapped files!
																				 ,write_fail_event
																				 ,Corp2_Mapping.Send_Email(state_origin ,version).MappingFailed
																				)
													)
												,if (Main_IsScrubErrors or Event_IsScrubErrors
													,Corp2_Mapping.Send_Email(state_origin ,version,Main_IsScrubErrors,false,Event_IsScrubErrors).FieldsInvalidPerScrubs)
												,Event_All
												,Main_All	
										);
															
 		isFileDateValid := if((string)Std.Date.Today() between ut.date_math(filedate,-31) and ut.date_math(filedate,31),true,false);
    return sequential (if (isFileDateValid
														,mapPA
														,sequential (Corp2_Mapping.Send_Email(state_origin,filedate).InvalidFileDateParm
																				,FAIL('Corp2_Mapping.PA failed.  An invalid filedate was passed in as a parameter.')))); 	


	end;	// end of Update function

end;  // end of Module