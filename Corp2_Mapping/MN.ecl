import corp2, corp2_Mapping, corp2_raw_mn, scrubs, scrubs_corp2_Mapping_mn_event,
			 scrubs_corp2_Mapping_mn_main, scrubs_corp2_Mapping_mn_stock, std,
			 tools, versioncontrol, ut;

export MN := MODULE; 

	export Update(string fileDate, string version, boolean pShouldSpray = Corp2_Mapping._Dataset().bShouldSpray, boolean pOverwrite = false, pUseProd = Tools._Constants.IsDataland) := Function

		state_origin			:= 'MN';
		state_fips	 			:= '27';	
		state_desc	 			:= 'MINNESOTA';
		
		Master 						:= dedup(sort(distribute(corp2_raw_mn.Files(fileDate,puseprod).Input.Master,hash(master_id)),record,local),record,local)	: independent;
		FilingHist				:= dedup(sort(distribute(corp2_raw_mn.Files(fileDate,puseprod).Input.FilingHist,hash(master_id)),record,local),record,local)	: independent;
		NameAddr					:= dedup(sort(distribute(corp2_raw_mn.Files(fileDate,puseprod).Input.NameAddr,hash(master_id)),record,local),record,local)	: independent;

		//Valid Address and Name Type Codes for Corporations, RA's and Contacts
		CorporationAddressTypeList := ['2','4','5','7','8','9','11','16','18','9999']; 																//addr_type_number
		RAAddressTypeList					 := ['3','19','21','204'];  																												//addr_type_number
		RANameTypeList						 := ['4','19','202'];      																													//name_type_number
		ContactsNameTypeList			 := ['1','2','3','5','6','7','8','9','11','12','13','14','15','16','17','18'];			//name_type_number
		ContactsAddressTypeList		 := ['6','14','17'];   																															//addr_type_number		
		ARTypeList								 := ['ANNUAL RENEWAL','ANNUAL RENEWAL DEFERRED','ANNUAL REINSTATEMENT','BIENNIAL RENEWAL','BIENNIAL RENEWAL REACTIVATION','RENEWAL or FINAL RENEWAL'];

		//Project into temporary layout that contains a record_id that will be populated by "mac_sequence_records".
		NameAddrTemp						 	 := project(NameAddr,
																					transform(Corp2_Raw_MN.Layouts.Temp_NameAddrLayout,
																										self		:= left;
																										self		:= [];
																										)
																				 );
																				 
		//This macro adds a sequence number to the "NameAddr" address file for joining purposes.
		ut.MAC_Sequence_Records(NameAddrTemp, record_id, NameAddrWithSeq);
		
		//RA data appears on two separate records; Party name is on one record and the address is on a separate record.
		//The following logic finds the RA name and the RA address records and joins them in order to add the RA's name
		//to the associated address records.
		RAHasNameAddr						 	 := NameAddrWithSeq(name_type_number in RANameTypeList 	 and party_name<>'') : independent;
		RAWithAddr								 := NameAddrWithSeq(addr_type_number in RAAddressTypeList and party_name='')  : independent;

		AddRAPartyName					 	 := join(RAHasNameAddr, RAWithAddr,
																			 corp2.t2u(left.master_id) 						  = corp2.t2u(right.master_id) and
																			 corp2.t2u(left.original_filing_number) = corp2.t2u(right.original_filing_number) and
																			 corp2.t2u(left.filing_number) 					= corp2.t2u(right.filing_number),												 
																			 transform(Corp2_Raw_MN.Layouts.Temp_NameAddrLayout,
																								 self.name_type_number							:= if(right.name_type_number<>'',right.name_type_number,left.name_type_number);
																								 self.party_name										:= left.party_name;
																								 self																:= right;
																							  ),
																			 inner,
																			 local
																			) : independent;

		UpdateRAPartyName				 	 := join(NameAddrWithSeq, AddRAPartyName,
																			 left.record_id = right.record_id,							 
																			 transform(Corp2_Raw_MN.Layouts.Temp_NameAddrLayout,
																								 self.name_type_number							:= if(right.name_type_number<>'',right.name_type_number,left.name_type_number);
																								 self.party_name										:= if(right.party_name<>'',right.party_name,left.party_name);
																								 self																:= left;
																								),
																			 left outer
																			) : independent;
																			
		//Contact data appears on two separate records; Party name is on one record and the address is on a separate record.
		//The following logic finds the contact name and the contact address records and joins them in order to add the
		//contact's name to the associated address records.
		ContactHasNameAddr			 	 := UpdateRAPartyName(name_type_number in ContactsNameTypeList 		and party_name<>'') : independent;
		ContactWithAddr					 	 := UpdateRAPartyName(addr_type_number in ContactsAddressTypeList and party_name='') 	: independent;

		AddContactPartyName			 	 := join(ContactHasNameAddr, ContactWithAddr,
																			 corp2.t2u(left.master_id) 						  = corp2.t2u(right.master_id) and
																			 corp2.t2u(left.original_filing_number) = corp2.t2u(right.original_filing_number) and
																			 corp2.t2u(left.filing_number) 					= corp2.t2u(right.filing_number),									 
																			 transform(Corp2_Raw_MN.Layouts.Temp_NameAddrLayout,
																							   self.name_type_number							:= if(right.name_type_number<>'',right.name_type_number,left.name_type_number);																			 
																								 self.party_name										:= left.party_name;
																								 self																:= right;
																								),
																			 inner
																			) : independent;

		UpdateContactPartyName	 	 	:= join(UpdateRAPartyName, AddContactPartyName,
																			  left.record_id = right.record_id,							 
																			  transform(Corp2_Raw_MN.Layouts.Temp_NameAddrLayout,
																									self.name_type_number							:= if(right.name_type_number<>'',right.name_type_number,left.name_type_number);
																								  self.party_name										:= if(right.party_name<>'',right.party_name,left.party_name);
																								  self															:= left;
																								),
																			  left outer
																			 ) : independent;

		hasNoAddress 								:= corp2.t2u(UpdateContactPartyName.street_addr_line1 + UpdateContactPartyName.street_addr_line2 + UpdateContactPartyName.city + UpdateContactPartyName.regioncode + UpdateContactPartyName.postalcode)='';
		hasNameTypeNo								:= UpdateContactPartyName.name_type_number in RANameTypeList or UpdateContactPartyName.name_type_number in ContactsNameTypeList;
		
		//Based upon the previous AddRAPartyName and AddContactPartyName joins, these filters are identifying the "party" records and
		//the address records.  The file NameAddrUpdated contains the file where the "party name" exists on the associated "address
		//records and therefore the "party" records are no longer needed and can be removed. 
		//NOTE:  "ONLY IF THERE WAS AN ASSOCIATED ADDRESS RECORD" can the party record be removed.  
		//So any "party" record that did not have an associated address record will be kept.  That is what the "right only" join
		//below is trying to identify.
		NameAddrUpdatedParty				 := UpdateContactPartyName(hasNameTypeNo and hasNoAddress);
		NameAddrUpdatedNonParty			 := UpdateContactPartyName(not(hasNameTypeNo and hasNoAddress));

		NameAddrPartyKeep						 := join(NameAddrUpdatedNonParty, NameAddrUpdatedParty,
																				 corp2.t2u(left.master_id) 						  = corp2.t2u(right.master_id) 							and
																				 corp2.t2u(left.original_filing_number) = corp2.t2u(right.original_filing_number) and
																				 corp2.t2u(left.filing_number) 					= corp2.t2u(right.filing_number)          and
																				 corp2.t2u(left.party_name)							= corp2.t2u(right.party_name),
																				 transform(Corp2_Raw_MN.Layouts.Temp_NameAddrLayout,
																									 self	:= right;
																									),
																				 right only
																				) : independent;

		NameAddrUpdated						 	:= sort(distribute(NameAddrUpdatedNonParty + NameAddrPartyKeep,hash(master_id)),master_id,local) : independent;
		
		MasterNameAddr						  := join(Master, NameAddrUpdated,
																				corp2.t2u(left.Master_ID) =  corp2.t2u(right.Master_ID),
																				transform(Corp2_Raw_MN.Layouts.Temp_MasterNameAddrLayout,
																									self  									:= left;
																									self.street_addr_line1	:= corp2.t2u(right.street_addr_line1);
																									//preliminary cleanup on street_addr_line2
																									self.street_addr_line2	:= map(corp2.t2u(right.street_addr_line2) = self.street_addr_line1 => '',
																																								 corp2.t2u(right.street_addr_line2)
																																								);																									
																									//preliminary cleanup on city
																									self.city 							:= map(corp2.t2u(right.city) = 'MPLS' 								=> 'MINNEAPOLIS',
																																								 corp2.t2u(right.city) = 'BLMGTN' 							=> 'BLOOMINGTON',
																																								 corp2.t2u(right.city) = 'BLMNGTON'							=> 'BLOOMINGTON',
																																								 corp2.t2u(right.city) = 'BLMTGN'	 							=> 'BLOOMINGTON',
																																								 corp2.t2u(right.city) = self.street_addr_line1 => '',																																								 
																																								 corp2.t2u(right.city)
																																								);
																									//preliminary cleanup on regioncode (the state)
																									self.regioncode 				:= map(corp2.t2u(self.city) in ['MINNEAPOLIS',state_origin] 			 			 => state_origin,
																																								 corp2.t2u(right.regioncode) = 'UNITED STATES' 							 			 => '',
																																								 corp2.t2u(right.regioncode) = 'USA' 												 			 => '',																																					 
																																								 corp2.t2u(right.regioncode) = 'US' 															 => '',																																					 
																																								 stringlib.stringfind(corp2.t2u(right.regioncode),'SELECT',1) <> 0 => '',
																																								 corp2.t2u(right.regioncode) = self.street_addr_line1 						 => '',																																								 
																																								 corp2.t2u(right.regioncode)
																																								);																									
																									self 			:= right;
																								 ),
																				left outer,
																				local
																				) : independent;

		HasContacts								 := MasterNameAddr.name_type_number in ContactsNameTypeList or MasterNameAddr.addr_type_number in ContactsAddressTypeList;
		HasRACorporation					 := MasterNameAddr.name_type_number in RANameTypeList or MasterNameAddr.addr_type_number in RAAddressTypeList or MasterNameAddr.addr_type_number in CorporationAddressTypeList;

		Contacts								 	 := sort(distribute(MasterNameAddr(HasContacts),hash(master_id)),master_id,local) 			: independent; 
		RACorporations					 	 := sort(distribute(MasterNameAddr(HasRACorporation),hash(master_id)),master_id,local) 	: independent;

		//********************************************************************
		//Normalize Master before mapping main.
		//********************************************************************	
		Corp2_Raw_MN.Layouts.Temp_MasterNormalizedLayout NormTransform(Corp2_Raw_MN.Layouts.MasterLayoutIn l, integer c) := transform,
		//skip the secord record if the minnesota_business_name is the same as the home_busname
		skip(c=2 and  ut.companysimilar100(ut.cleancompany(l.minnesota_business_name),ut.cleancompany(l.home_busname))<= 10)
				self.legal_name														:= choose(c,
																														if(corp2.t2u(l.business_mark_type) in ['TRADEMARK','SERVICE MARK','COLLECTIVE MARK','CERTIFICATION MARK'] and corp2.t2u(l.mark_logo) <> ''
																															,Corp2_Mapping.fCleanBusinessName(state_origin,state_desc,l.mark_logo).BusinessName
																															,Corp2_Mapping.fCleanBusinessName(state_origin,state_desc,l.minnesota_business_name).BusinessName
																															),
																														Corp2_Mapping.fCleanBusinessName(state_origin,state_desc,l.home_busname).BusinessName
																													 );
				self.name_type_desc   										:= choose(c,
																														if(corp2.t2u(l.business_mark_type) not in ['TRADEMARK','SERVICE MARK','COLLECTIVE MARK','CERTIFICATION MARK']
																															,Corp2_Raw_MN.Functions.NameTypeDesc(l.bus_type_code)
																															,corp2.t2u(l.business_mark_type)
																															),
																															'HOME NAME'
																													 );
				self																			:= l;
		end;
		
	  MasterNormalized 	:= normalize(Master,if(corp2.t2u(left.Home_BusName)<>'',2,1),NormTransform(left,counter));																																																			 

		//********************************************************************
		//This begins the MAIN Mapping.
		//********************************************************************	
		Corp2_Mapping.LayoutsCommon.Main CorpTransform(Corp2_Raw_MN.Layouts.Temp_MasterNormalizedLayout l, Corp2_Raw_MN.Layouts.Temp_MasterNameAddrLayout r) := transform
				self.dt_vendor_first_reported							:= (unsigned4)fileDate;
				self.dt_vendor_last_reported							:= (unsigned4)fileDate;
				self.dt_first_seen												:= (unsigned4)fileDate;
				self.dt_last_seen													:= (unsigned4)fileDate;
				self.corp_ra_dt_first_seen								:= (unsigned4)fileDate;
				self.corp_ra_dt_last_seen									:= (unsigned4)fileDate;			
				self.corp_key															:= if(corp2.t2u(l.original_filing_number)<>'',state_fips + '-' + corp2.t2u(l.master_id[1..8] + l.original_filing_number),'');
				self.corp_vendor													:= state_fips;
				self.corp_state_origin										:= state_origin;			
				self.corp_process_date										:= fileDate;
				self.corp_orig_sos_charter_nbr						:= corp2.t2u(l.original_filing_number);										  									
				self.corp_legal_name											:= corp2.t2u(l.legal_name); 			//normalized field: already cleaned by Corp2_Mapping.fCleanBusinessName
				self.corp_ln_name_type_cd    							:= Corp2_Raw_MN.Functions.NameTypeCode(l.bus_type_code);
				self.corp_ln_name_type_desc   						:= corp2.t2u(l.name_type_desc);	  //normalized field
				self.corp_address1_type_cd								:= if(corp2.t2u(r.addr_type_number) in CorporationAddressTypeList,
																												map(Corp2_Mapping.fAddressExists(state_origin,state_desc,r.street_addr_line1,r.street_addr_line2,r.city,r.regioncode,r.postalcode,r.countryname).ifAddressExists => Corp2_Raw_MN.Functions.AddressTypeCode(r.addr_type_number)
																													 ,''
																													 )
																											 ,''
																											 );																										 
				self.corp_address1_type_desc							:= if(self.corp_address1_type_cd<>'',Corp2_Raw_MN.Functions.AddressTypeDesc(r.addr_type_number),'');
				self.corp_address1_line1					  			:= if(self.corp_address1_type_cd<>'',Corp2_Mapping.fCleanAddress(state_origin,state_desc,r.street_addr_line1,r.street_addr_line2,r.city,r.regioncode,r.postalcode,r.countryname).AddressLine1,'');
				self.corp_address1_line2									:= if(self.corp_address1_type_cd<>'',Corp2_Mapping.fCleanAddress(state_origin,state_desc,r.street_addr_line1,r.street_addr_line2,r.city,r.regioncode,r.postalcode,r.countryname).AddressLine2,'');
				self.corp_address1_line3									:= if(self.corp_address1_type_cd<>'',Corp2_Mapping.fCleanAddress(state_origin,state_desc,r.street_addr_line1,r.street_addr_line2,r.city,r.regioncode,r.postalcode,r.countryname).AddressLine3,'');
				self.corp_status_desc				    					:= corp2.t2u(l.business_filing_status);	
				self.corp_standing		    		     			 	:= if(corp2.t2u(l.business_filing_status)='ACTIVE','Y','');	
				self.corp_inc_state					   						:= state_origin;
				self.corp_inc_date				    		  			:= if(corp2.t2u(l.home_jurisdiction) in [state_desc,''],Corp2_Mapping.fValidateDate(l.filing_date).PastDate,'');
				self.corp_foreign_domestic_ind      			:= Corp2_Raw_MN.Functions.ForeignDomesticIndicator(l.bus_type_code,l.Is_LLL_Partnership);
				self.corp_forgn_state_cd		    					:= if(corp2.t2u(l.home_jurisdiction) not in [state_desc,''],Corp2_Raw_MN.Functions.State_Codes(l.home_jurisdiction),'');
				self.corp_forgn_state_desc	  						:= if(corp2.t2u(l.home_jurisdiction) not in [state_desc,''],Corp2_Raw_MN.Functions.State_or_Country(l.home_jurisdiction),'');
				self.corp_forgn_date				    					:= if(corp2.t2u(l.home_jurisdiction) not in [state_desc,''],Corp2_Mapping.fValidateDate(l.filing_date).PastDate,'');  
				self.corp_term_exist_cd				  					:= if(Corp2_Mapping.fValidateDate(l.expiration_date).GeneralDate<>'','D','');  
				self.corp_term_exist_exp			  					:= if(Corp2_Mapping.fValidateDate(l.expiration_date).GeneralDate<>'',Corp2_Mapping.fValidateDate(l.expiration_date).GeneralDate,'');   										 						
				self.corp_term_exist_desc			  					:= if(Corp2_Mapping.fValidateDate(l.expiration_date).GeneralDate<>'','EXPIRATION DATE','');  
				self.corp_orig_org_structure_cd 					:= Corp2_Raw_MN.Functions.OrgStructureCode(l.bus_type_code);
				self.corp_orig_org_structure_desc					:= Corp2_Raw_MN.Functions.OrgStructureDesc(l.is_lll_partnership,l.Bus_Type_Code);
				self.corp_for_profit_ind          			  := Corp2_Raw_MN.Functions.CorpForProfitInd(l.bus_type_code,l.is_llc_non_profit);																										 
				self.corp_entity_desc             			  := Corp2_Raw_MN.Functions.EntityDesc(l.Bus_Type_Code,l.Is_LLL_Partnership,l.is_professional,l.Mark_Classification_Number,l.Services_Description);
				self.corp_acts                   			    := corp2.t2u(l.Governing_Statute);
				self.corp_addl_info                 			:= Corp2_Raw_MN.Functions.CorpAddlInfo(l.Mark_First_Use_Date,l.Mark_logo);
				self.corp_ra_full_name										:= if(corp2.t2u(r.name_type_number) in RANameTypeList,Corp2_Mapping.fCleanBusinessName(state_origin,state_desc,r.party_name).BusinessName,'');
				self.corp_ra_title_desc             			:= if(self.corp_ra_full_name <> '' and corp2.t2u(r.name_type_number) in ['19'],'INDIVIDUAL CONTACT FOR AGENT','');
				self.corp_ra_address_type_cd							:= if(Corp2_Mapping.fAddressExists(state_origin,state_desc,r.street_addr_line1,r.street_addr_line2,r.city,r.regioncode,r.postalcode,r.countryname).ifAddressExists,
																												if(corp2.t2u(r.addr_type_number) in RAAddressTypeList,corp2.t2u(r.addr_type_number),'')
																											 ,''
																											 );	
				self.corp_ra_address_type_desc						:= if(self.corp_ra_address_type_cd<>'',Corp2_Raw_MN.Functions.AddressTypeDesc(r.addr_type_number),'');
				self.corp_ra_address_line1								:= if(self.corp_ra_address_type_cd<>'',Corp2_Mapping.fCleanAddress(state_origin,state_desc,r.street_addr_line1,r.street_addr_line2,r.city,r.regioncode,r.postalcode,r.countryName).AddressLine1,'');
				self.corp_ra_address_line2								:= if(self.corp_ra_address_type_cd<>'',Corp2_Mapping.fCleanAddress(state_origin,state_desc,r.street_addr_line1,r.street_addr_line2,r.city,r.regioncode,r.postalcode,r.countryName).AddressLine2,'');
				self.corp_ra_address_line3								:= if(self.corp_ra_address_type_cd<>'',Corp2_Mapping.fCleanAddress(state_origin,state_desc,r.street_addr_line1,r.street_addr_line2,r.city,r.regioncode,r.postalcode,r.countryName).AddressLine3,'');
				self.corp_prep_addr1_line1     						:= if(self.corp_address1_type_cd	<>'',Corp2_Mapping.fCleanAddress(state_origin,state_desc,r.street_addr_line1,r.street_addr_line2,r.city,r.regioncode,r.postalcode,r.countryName).PrepAddrLine1,'');
				self.corp_prep_addr1_last_line     				:= if(self.corp_address1_type_cd	<>'',Corp2_Mapping.fCleanAddress(state_origin,state_desc,r.street_addr_line1,r.street_addr_line2,r.city,r.regioncode,r.postalcode,r.countryname).PrepAddrLastLine,'');
				self.ra_prep_addr_line1        						:= if(self.corp_ra_address_type_cd<>'',Corp2_Mapping.fCleanAddress(state_origin,state_desc,r.street_addr_line1,r.street_addr_line2,r.city,r.regioncode,r.postalcode,r.countryname).PrepAddrLine1,'');
				self.ra_prep_addr_last_line    						:= if(self.corp_ra_address_type_cd<>'',Corp2_Mapping.fCleanAddress(state_origin,state_desc,r.street_addr_line1,r.street_addr_line2,r.city,r.regioncode,r.postalcode,r.countryname).PrepAddrLastLine,'');
				//Note: cont_type_cd is being Mapped with name_type_number because this field is not being directly Mapped anywhere else and
				//this is a critical field. A scrub rule exists to indicate if any new name_type_numbers are introduced by the vendor
				//so the records can be Mapped correctly.
				self.cont_type_cd       									:= corp2.t2u(r.name_type_number);
				//Note: cont_address_type_cd is being Mapped with addr_type_number because this field is not being directly Mapped anywhere else and
				//this is a critical field. A scrub rule exists to indicate if any new addr_type_number are introduced by the vendor
				//so the records can be Mapped correctly.
				self.cont_address_type_cd									:= corp2.t2u(r.addr_type_number);				
				self.corp_governing_statute								:= corp2.t2u(l.governing_statute);				
				self.corp_home_state_name									:= corp2.t2u(l.home_busname);
				self.corp_is_professional									:= if(corp2.t2u(l.is_professional) = '1','Y','');
				self.corp_renewal_date										:= Corp2_Mapping.fValidateDate(l.next_renewal_due_date).GeneralDate;
				self.corp_trademark_classification_nbr 		:= corp2.t2u(l.mark_classification_number);
				self.corp_trademark_first_use_date				:= Corp2_Mapping.fValidateDate(l.mark_first_use_date).PastDate;
				self.corp_trademark_business_mark_type 		:= corp2.t2u(l.business_mark_type);
				self.corp_trademark_expiration_date				:= Corp2_Mapping.fValidateDate(l.expiration_date).GeneralDate;
				self.corp_trademark_logo									:= corp2.t2u(l.mark_logo);
				self.corp_trademark_used_1								:= corp2.t2u(l.services_description);
				self.recordorigin													:= 'C';
				self 																			:= [];
		end;

				
	  MapCorp		:= join(MasterNormalized, RACorporations,
											corp2.t2u(left.Master_ID) =  corp2.t2u(right.Master_ID),
										  CorpTransform(left,right),
											left outer,
											local
											);																																																			 

		Corp2_Mapping.LayoutsCommon.Main ContTransform(Corp2_Raw_MN.Layouts.Temp_MasterNormalizedLayout l, Corp2_Raw_MN.Layouts.Temp_MasterNameAddrLayout r) := transform
				self.dt_vendor_first_reported							:= (unsigned4)fileDate;
				self.dt_vendor_last_reported							:= (unsigned4)fileDate;
				self.dt_first_seen												:= (unsigned4)fileDate;
				self.dt_last_seen													:= (unsigned4)fileDate;
				self.corp_ra_dt_first_seen								:= (unsigned4)fileDate;
				self.corp_ra_dt_last_seen									:= (unsigned4)fileDate;			
				self.corp_key															:= if(corp2.t2u(l.original_filing_number)<>'',state_fips + '-' + corp2.t2u(l.master_id[1..8] + l.original_filing_number),'');
				self.corp_vendor													:= state_fips;
				self.corp_state_origin										:= state_origin;			
				self.corp_process_date										:= fileDate;
				self.corp_orig_sos_charter_nbr						:= corp2.t2u(l.original_filing_number);										  						
				self.corp_legal_name											:= corp2.t2u(l.legal_name); 			//normalized field: already cleaned by Corp2_Mapping.fCleanBusinessName
				self.corp_inc_state					   						:= state_origin;																											
				//Note: cont_type_cd is being mapped with name_type_number. A scrub rule exists to indicate if any new name_type_numbers are introduced by the vendor
				//so the records can be mapped correctly.
				self.cont_type_cd       									:= corp2.t2u(r.name_type_number);
				self.cont_type_desc      									:= if(corp2.t2u(r.name_type_number)<>'',Corp2_Raw_MN.Functions.ContTypeDesc(r.name_type_number),'');
				self.cont_full_name                				:= Corp2_Mapping.fCleanBusinessName(state_origin,state_desc,r.party_name).BusinessName;
				self.cont_title1_desc         	  				:= if(self.cont_full_name<>'' and corp2.t2u(r.name_type_number)<>'',Corp2_Raw_MN.Functions.ContTitle1Desc(r.name_type_number),'');
				self.cont_address_line1					  				:= if(corp2.t2u(r.addr_type_number) in ContactsAddressTypeList and Corp2_Mapping.fAddressExists(state_origin,state_desc,r.street_addr_line1,r.street_addr_line2,r.city,r.regioncode,r.postalcode,r.countryname).ifAddressExists,Corp2_Mapping.fCleanAddress(state_origin,state_desc,r.street_addr_line1,r.street_addr_line2,r.city,r.regioncode,r.postalcode,r.countryname).AddressLine1,'');
				self.cont_address_line2										:= if(corp2.t2u(r.addr_type_number) in ContactsAddressTypeList and Corp2_Mapping.fAddressExists(state_origin,state_desc,r.street_addr_line1,r.street_addr_line2,r.city,r.regioncode,r.postalcode,r.countryname).ifAddressExists,Corp2_Mapping.fCleanAddress(state_origin,state_desc,r.street_addr_line1,r.street_addr_line2,r.city,r.regioncode,r.postalcode,r.countryname).AddressLine2,'');
				self.cont_address_line3										:= if(corp2.t2u(r.addr_type_number) in ContactsAddressTypeList and Corp2_Mapping.fAddressExists(state_origin,state_desc,r.street_addr_line1,r.street_addr_line2,r.city,r.regioncode,r.postalcode,r.countryname).ifAddressExists,Corp2_Mapping.fCleanAddress(state_origin,state_desc,r.street_addr_line1,r.street_addr_line2,r.city,r.regioncode,r.postalcode,r.countryname).AddressLine3,'');
				//Note: cont_address_type_cd is being Mapped with addr_type_number. A scrub rule exists to indicate if any new addr_type_number are introduced by the vendor
				//so the records can be Mapped correctly.				
				self.cont_address_type_cd         				:= corp2.t2u(r.addr_type_number);
				self.cont_address_type_desc       				:= if(corp2.t2u(r.addr_type_number) in ContactsAddressTypeList and Corp2_Mapping.fAddressExists(state_origin,state_desc,r.street_addr_line1,r.street_addr_line2,r.city,r.regioncode,r.postalcode,r.countryname).ifAddressExists,'CONTACT ADDRESS','');
				self.cont_prep_addr_line1      					  := if(corp2.t2u(r.addr_type_number) in ContactsAddressTypeList and Corp2_Mapping.fAddressExists(state_origin,state_desc,r.street_addr_line1,r.street_addr_line2,r.city,r.regioncode,r.postalcode,r.countryname).ifAddressExists,Corp2_Mapping.fCleanAddress(state_origin,state_desc,r.street_addr_line1,r.street_addr_line2,r.city,r.regioncode,r.postalcode,r.countryname).PrepAddrLine1,'');
				self.cont_prep_addr_last_line   					:= if(corp2.t2u(r.addr_type_number) in ContactsAddressTypeList and Corp2_Mapping.fAddressExists(state_origin,state_desc,r.street_addr_line1,r.street_addr_line2,r.city,r.regioncode,r.postalcode,r.countryname).ifAddressExists,Corp2_Mapping.fCleanAddress(state_origin,state_desc,r.street_addr_line1,r.street_addr_line2,r.city,r.regioncode,r.postalcode,r.countryname).PrepAddrLastLine,'');
				self.recordorigin													:= 'T';
				self 																			:= [];			
		end;

	  MapContacts		:= join(MasterNormalized, Contacts,
													corp2.t2u(left.Master_ID) =  corp2.t2u(right.Master_ID),
													ContTransform(left,right),
													inner,
													local
													);	

		AllMain				:= MapCorp + MapContacts;

		MapMain				:= dedup(sort(distribute(AllMain,hash(corp_key)),record, local),record, local): independent;

		//********************************************************************
		//This begins the EVENTS Mapping.
		//********************************************************************	
		Corp2_Mapping.LayoutsCommon.Events EventTransform(Corp2_RAW_MN.Layouts.FilingHistLayoutIn l ,integer c) := transform,
		skip(c = 2 and Corp2_Mapping.fValidateDate(l.effective_date).GeneralDate = '')
					self.corp_key														:= if(corp2.t2u(l.original_filing_number)<>'',state_fips + '-' + corp2.t2u(l.master_id[1..8] + l.original_filing_number),'');
					self.corp_vendor								  			:= state_fips;
					self.corp_state_origin									:= state_origin;			
					self.corp_process_date									:= fileDate;
					self.corp_sos_charter_nbr								:= corp2.t2u(l.original_filing_number);
					self.event_filing_date           			 	:= choose(c,Corp2_Mapping.fValidateDate(l.filing_date).PastDate,Corp2_Mapping.fValidateDate(l.effective_date).GeneralDate);
					self.event_date_type_cd									:= choose(c,if(Corp2_Mapping.fValidateDate(l.filing_date).PastDate<>'','FIL',''),if(Corp2_Mapping.fValidateDate(l.effective_date).GeneralDate<>'','EFF','')); 
					self.event_date_type_desc								:= choose(c,if(Corp2_Mapping.fValidateDate(l.filing_date).PastDate<>'','FILING',''),if(Corp2_Mapping.fValidateDate(l.effective_date).GeneralDate<>'','EFFECTIVE',''));
					self.event_filing_desc		        			:= corp2.t2u(l.filing_action);
					self.event_filing_reference_nbr   			:= map(regexfind('WEB|DEFER|PROFIL',corp2.t2u(l.filing_number),0)<>'' => '',
																												 corp2.t2u(l.filing_number)
																												);
					self                              			:= [];
		end; 

		EventsNorm := normalize(FilingHist(corp2.t2u(filing_action) not in [ARTypeList]),2,EventTransform(left,counter));
		MapEvent	 := dedup(sort(distribute(EventsNorm,hash(corp_key)),record, local),record, local): independent;

		//********************************************************************
		//This begins the ANNUAL REPORT (AR) Mapping.
		//********************************************************************	
		Corp2_Mapping.LayoutsCommon.AR ARFilingHistTransform(Corp2_RAW_MN.Layouts.FilingHistLayoutIn l) := transform
					self.corp_key														:= if(corp2.t2u(l.original_filing_number)<>'',state_fips + '-' + corp2.t2u(l.master_id[1..8] + l.original_filing_number),'');
					self.corp_vendor								  			:= state_fips;
					self.corp_state_origin									:= state_origin;			
					self.corp_process_date									:= fileDate;
					self.corp_sos_charter_nbr								:= corp2.t2u(l.original_filing_number);
					self.ar_report_nbr											:= if(regexfind('WEB|DEFER|PROFIL',corp2.t2u(l.filing_number),0)<>'','',corp2.t2u(l.filing_number));
					self.ar_type														:= corp2.t2u(l.filing_action);
					self.ar_filed_dt												:= Corp2_Mapping.fValidateDate(l.filing_date).PastDate;
					effectivedate														:= Corp2_Mapping.fValidateDate(l.effective_date).GeneralDate;
					self.ar_comment													:= if(effectivedate<>'',
																												'ARRUAL REPORT EFFECTIVE DATE: '+effectivedate[5..6]+'/'+effectivedate[7..8]+'/'+effectivedate[1..4],
																												''
																											 );
					self                              			:= [];
		end; 

		ARFilingHist := project(FilingHist(corp2.t2u(filing_action) in [ARTypeList]),ARFilingHistTransform(left));
 
		Corp2_Mapping.LayoutsCommon.AR ARMasterTransform(Corp2_RAW_MN.Layouts.MasterLayoutIn l) := transform,
		skip(corp2.t2u(l.next_renewal_due_date)='')
					self.corp_key														:= if(corp2.t2u(l.original_filing_number)<>'',state_fips + '-' + corp2.t2u(l.master_id[1..8] + l.original_filing_number),'');
					self.corp_vendor								  			:= state_fips;
					self.corp_state_origin									:= state_origin;			
					self.corp_process_date									:= fileDate;
					self.corp_sos_charter_nbr								:= corp2.t2u(l.original_filing_number);
					self.ar_due_dt													:= Corp2_Mapping.fValidateDate(l.next_renewal_due_date).GeneralDate;
					self																		:= [];
		end; 		

		ARMaster		:= project(Master,ARMasterTransform(left));
		All_AR			:= ARFilingHist + ARMaster;
		MapAR 			:= dedup(sort(distribute(All_AR, hash(corp_key)),record, local),record, local): independent;

		//********************************************************************
		// Note: Not scrubbing AR 
		//********************************************************************	
		AR_ApprovedRecords := MapAR;

		//********************************************************************
		//This begins the STOCK Mapping.
		//********************************************************************	 
		Corp2_Mapping.LayoutsCommon.Stock stockTransform(Corp2_RAW_MN.Layouts.MasterLayoutIn l) := transform,
		skip(corp2.t2u(l.Number_of_Shares)='')
					self.corp_key														:= if(corp2.t2u(l.original_filing_number)<>'',state_fips + '-' + corp2.t2u(l.master_id[1..8] + l.original_filing_number),'');
					self.corp_vendor											  := state_fips;
					self.corp_state_origin									:= state_origin;			
					self.corp_process_date									:= fileDate;
					self.corp_sos_charter_nbr								:= corp2.t2u(l.original_filing_number);
					self.stock_authorized_nbr								:= Corp2_Raw_MN.Functions.StockAuthorizedNbr(l.number_of_shares);
					self																		:= [];
		end;
		
		StockProj 	:= project(Master, stockTransform(left));
		//Note: Stock is being filtered here because cleanup is being done via the function StockAuthorizedNbr
		//			that validates the number_of_shares and could return a blank.
		StockFilt 	:= StockProj(stock_authorized_nbr<>'');
		MapStock 		:= dedup(sort(distribute(StockFilt, hash(corp_key)),record, local),record, local) : independent;

	//********************************************************************
  // SCRUB EVENT
  //********************************************************************	
		Event_F := MapEvent;
		Event_S := Scrubs_Corp2_Mapping_MN_Event.Scrubs;						// Scrubs module
		Event_N := Event_S.FromNone(Event_F); 											// Generate the error flags
		Event_T := Event_S.FromBits(Event_N.BitMapInfile);     			// Use the FromBits module; makes my bitMap datafile easier to get to
		Event_U := Event_S.FromExpanded(Event_N.ExpandedInFile); 		// Pass the expanded error flags into the Expanded module
		
		//Outputs reports
		Event_ErrorSummary				:= output(Event_U.SummaryStats, named('Event_ErrorSummary_MN'+filedate));
		Event_ScrubErrorReport 		:= output(choosen(Event_U.AllErrors, 1000), named('Event_ScrubErrorReport_MN'+filedate));
		Event_SomeErrorValues			:= output(choosen(Event_U.BadValues, 1000), named('Event_SomeErrorValues_MN'+filedate));
		Event_IsScrubErrors		 		:= if(count(Event_U.AllErrors)<> 0,true,false);

		// Orbit Stats
		Event_OrbitStats					:= Event_U.OrbitStats();

		//Outputs files
		Event_CreateBitMaps				:= output(Event_N.BitMapInfile,,'~thor_data::corp_mn_event_scrubs_bits',overwrite,compressed);	//long term storage
		Event_TranslateBitMap			:= output(Event_T);

		//Submits Profile's stats to Orbit
		Event_SubmitStats 			 := Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_MN_Event','ScrubsAlerts', Event_OrbitStats, version,'Corp_MN_Event').SubmitStats;
		Event_ScrubsWithExamples := Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_MN_Event','ScrubsAlerts', Event_OrbitStats, version,'Corp_MN_Event').CompareToProfile_with_Examples;

		Event_ScrubsAlert					:= Event_ScrubsWithExamples(RejectWarning = 'Y');
		Event_ScrubsAttachment		:= Scrubs.fn_email_attachment(Event_ScrubsAlert);
		Event_MailFile						:= FileServices.SendEmailAttachData(corp2.Email_Notification_Lists.AttachedList
																																 ,'Scrubs CorpEvent_MN Report' //subject
																																 ,'Scrubs CorpEvent_MN Report' //body
																																 ,(data)Event_ScrubsAttachment
																																 ,'text/csv'
																																 ,'CorpMNEventScrubsReport.csv'
																														);

		Event_BadRecords				 	:= Event_N.ExpandedInFile(	
																												corp_key_Invalid							  			<> 0 or
																												corp_vendor_Invalid 									<> 0 or																						
																												corp_state_origin_Invalid 					 	<> 0 or
																												corp_process_date_Invalid							<> 0 or
																												corp_sos_charter_nbr_Invalid 					<> 0 or
																												event_filing_date_Invalid 						<> 0 or
																												event_date_type_cd_Invalid 						<> 0 or
																												event_date_type_desc_Invalid 					<> 0
																											 );
																										 																	
		Event_GoodRecords					:= Event_N.ExpandedInFile(	
																												corp_key_Invalid							  			= 0 and
																												corp_vendor_Invalid 									= 0 and																				
																												corp_state_origin_Invalid 					 	= 0 and
																												corp_process_date_Invalid						  = 0 and
																												corp_sos_charter_nbr_Invalid 					= 0 and
																												event_filing_date_Invalid							= 0 and																															 
																												event_date_type_cd_Invalid		 				= 0 and
																												event_date_type_desc_Invalid					= 0
																											);

		Event_FailBuild					  := if(count(Event_GoodRecords) = 0,true,false);

		Event_ApprovedRecords			:= project(Event_GoodRecords,transform(Corp2_Mapping.LayoutsCommon.Events,self := left));
		

		Event_ALL									:= sequential(if(count(Event_BadRecords) <> 0
																											,if(poverwrite
																													,output(Event_BadRecords,,Corp2_Mapping._Dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::event_'+state_origin,overwrite,__compressed__)
																													,output(Event_BadRecords,,Corp2_Mapping._Dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::event_'+state_origin,__compressed__)
																													)
																											)
																									 ,output(Event_ScrubsWithExamples, all, named('CorpEventMNScrubsReportWithExamples'+filedate))
																									 //Send Alerts if Scrubs exceeds thresholds
																									 ,if(count(Event_ScrubsAlert) > 0, Event_MailFile, output('CORP2_MAPPING.MN - No "EVENT" Corp Scrubs Alerts'))
																									 ,Event_ErrorSummary
																									 ,Event_ScrubErrorReport
																									 ,Event_SomeErrorValues		
																									 ,Event_SubmitStats
																								);

	//********************************************************************
  // SCRUB MAIN
  //********************************************************************	
		Main_F := MapMain;
		Main_S := Scrubs_Corp2_Mapping_MN_Main.Scrubs;					// Scrubs module
		Main_N := Main_S.FromNone(Main_F); 											// Generate the error flags
		Main_T := Main_S.FromBits(Main_N.BitMapInfile);     		// Use the FromBits module; makes my bitMap datafile easier to get to
		Main_U := Main_S.FromExpanded(Main_N.ExpandedInFile); 	// Pass the expanded error flags into the Expanded module

		//Outputs reports
		Main_ErrorSummary					:= output(Main_U.SummaryStats, named('Main_ErrorSummary_MN'+filedate));
		Main_ScrubErrorReport 		:= output(choosen(Main_U.AllErrors, 1000), named('Main_ScrubErrorReport_MN'+filedate));
		Main_SomeErrorValues			:= output(choosen(Main_U.BadValues, 1000), named('Main_SomeErrorValues_MN'+filedate));
		Main_IsScrubErrors		 		:= if(count(Main_U.AllErrors)<> 0,true,false);

		// Orbit Stats
		Main_OrbitStats						:= Main_U.OrbitStats();

		//Outputs files
		Main_CreateBitMaps				:= output(Main_N.BitMapInfile,,'~thor_data::corp_mn_main_scrubs_bits',overwrite,compressed);	//long term storage
		Main_TranslateBitMap			:= output(Main_T);

		//Submits Profile's stats to Orbit
		Main_SubmitStats 			  := Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_MN_Main','ScrubsAlerts', Main_OrbitStats, version,'Corp_MN_Main').SubmitStats;
		Main_ScrubsWithExamples := Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_MN_Main','ScrubsAlerts', Main_OrbitStats, version,'Corp_MN_Main').CompareToProfile_with_Examples;

		Main_ScrubsAlert					:= Main_ScrubsWithExamples(RejectWarning = 'Y');
		Main_ScrubsAttachment			:= Scrubs.fn_email_attachment(Main_ScrubsAlert);
		Main_MailFile							:= FileServices.SendEmailAttachData(corp2.Email_Notification_Lists.spray
																																 ,'Scrubs CorpMain_MN Report' //subject
																																 ,'Scrubs CorpMain_MN Report' //body
																																 ,(data)Main_ScrubsAttachment
																																 ,'text/csv'
																																 ,'CorpMNMainScrubsReport.csv'
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
																											 corp_status_desc_Invalid 							<> 0 or
																											 corp_standing_Invalid 									<> 0 or
																											 corp_inc_state_Invalid 								<> 0 or
																											 corp_inc_date_Invalid 									<> 0 or
																											 corp_forgn_state_cd_Invalid 						<> 0 or
																											 corp_forgn_state_desc_Invalid 					<> 0 or
																											 corp_forgn_date_Invalid 								<> 0 or
																											 cont_type_cd_Invalid										<> 0 or
																											 cont_address_type_cd_Invalid						<> 0 or
																											 corp_renewal_date_Invalid 							<> 0 or
																											 corp_trademark_first_use_date_Invalid 	<> 0 or
																											 corp_trademark_expiration_date_Invalid <> 0 or 
																											 recordorigin_Invalid										<> 0
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
																										 corp_status_desc_Invalid 							= 0 and
																										 corp_standing_Invalid 									= 0 and
																										 corp_inc_state_Invalid 								= 0 and
																										 corp_inc_date_Invalid 									= 0 and
																										 corp_forgn_state_cd_Invalid 						= 0 and
																										 corp_forgn_state_desc_Invalid 					= 0 and
																										 corp_forgn_date_Invalid 								= 0 and
																										 cont_type_cd_Invalid										= 0 and
																										 cont_address_type_cd_Invalid						= 0 and																										 
																										 corp_renewal_date_Invalid 							= 0 and
																										 corp_trademark_first_use_date_Invalid 	= 0 and
																										 corp_trademark_expiration_date_Invalid = 0 and
																										 recordorigin_Invalid 									= 0																										 
																								  );

		Main_FailBuild					:= map( corp2_Mapping.fCalcPercent(count(Main_N.ExpandedInFile(corp_key_invalid<>0)),count(Main_N.ExpandedInFile),false) 										> Scrubs_Corp2_Mapping_MN_Main.Threshold_Percent.CORP_KEY										 => true,
																		corp2_Mapping.fCalcPercent(count(Main_N.ExpandedInFile(corp_orig_sos_charter_nbr_invalid<>0)),count(Main_N.ExpandedInFile),false) 	> Scrubs_Corp2_Mapping_MN_Main.Threshold_Percent.CORP_ORIG_SOS_CHARTER_NBR 	 => true,
																		corp2_Mapping.fCalcPercent(count(Main_N.ExpandedInFile(corp_legal_name_invalid<>0)),count(Main_N.ExpandedInFile),false) 						> Scrubs_Corp2_Mapping_MN_Main.Threshold_Percent.CORP_LEGAL_NAME 						 => true,
																		corp2_Mapping.fCalcPercent(count(Main_N.ExpandedInFile(corp_ln_name_type_cd_invalid<>0)),count(Main_N.ExpandedInFile),false) 				> Scrubs_Corp2_Mapping_MN_Main.Threshold_Percent.CORP_LN_NAME_TYPE_CD		  	 => true,
																		corp2_Mapping.fCalcPercent(count(Main_N.ExpandedInFile(corp_inc_date_invalid<>0)),count(Main_N.ExpandedInFile),false) 							> Scrubs_Corp2_Mapping_MN_Main.Threshold_Percent.CORP_INC_DATE 						 	 => true,
																	  count(Main_GoodRecords) = 0																																																																																											 => true,																		
																		false
																	);

		Main_ApprovedRecords		:= project(Main_GoodRecords,transform(Corp2_Mapping.LayoutsCommon.Main,self := left));


		Main_ALL		 			:= sequential( if(count(Main_BadRecords) <> 0
																							,if(poverwrite
																									,output(Main_BadRecords,,Corp2_Mapping._Dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::main_'+state_origin,overwrite,__compressed__)
																									,output(Main_BadRecords,,Corp2_Mapping._Dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::main_'+state_origin,__compressed__)
																									)
																							)
																					,output(Main_ScrubsWithExamples, all, named('CorpMainMNScrubsReportWithExamples'+filedate))
																					//Send Alerts if Scrubs exceeds thresholds
																					,if(count(Main_ScrubsAlert) > 0, Main_MailFile, output('CORP2_MAPPING.MN - No "MAIN" Corp Scrubs Alerts'))
																					,Main_ErrorSummary
																					,Main_ScrubErrorReport
																					,Main_SomeErrorValues	
																					,Main_SubmitStats
																			);

	//********************************************************************
  // SCRUB STOCK
  //********************************************************************	
		Stock_F := MapStock;
		Stock_S := Scrubs_Corp2_Mapping_MN_Stock.Scrubs;						// Scrubs module
		Stock_N := Stock_S.FromNone(Stock_F); 											// Generate the error flags
		Stock_T := Stock_S.FromBits(Stock_N.BitMapInfile);     			// Use the FromBits module; makes my bitMap datafile easier to get to
		Stock_U := Stock_S.FromExpanded(Stock_N.ExpandedInFile); 		// Pass the expanded error flags into the Expanded module

		//Outputs reports
		Stock_ErrorSummary			 	:= output(Stock_U.SummaryStats, named('Stock_ErrorSummary_MN'+filedate));
		Stock_ScrubErrorReport 	 	:= output(choosen(Stock_U.AllErrors, 1000), named('Stock_ScrubErrorReport_MN'+filedate));
		Stock_SomeErrorValues		 	:= output(choosen(Stock_U.BadValues, 1000), named('Stock_SomeErrorValues_MN'+filedate));
		Stock_IsScrubErrors		 	 	:= if(count(Stock_U.AllErrors)<> 0,true,false);

		// Orbit Stats
		Stock_OrbitStats				 	:= Stock_U.OrbitStats();

		//Outputs files
		Stock_CreateBitMaps				:= output(Stock_N.BitMapInfile,,'~thor_data::corp_mn_scrubs_bits',overwrite,compressed);	//long term storage
		Stock_TranslateBitMap			:= output(Stock_T);

		//Submits Profile's stats to Orbit
		Stock_SubmitStats 			 := Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_MN_Stock','ScrubsAlerts', Stock_OrbitStats, version,'Corp_MN_Stock').SubmitStats;
		Stock_ScrubsWithExamples := Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_MN_Stock','ScrubsAlerts', Stock_OrbitStats, version,'Corp_MN_Stock').CompareToProfile_with_Examples;

		Stock_ScrubsAlert					:= Stock_ScrubsWithExamples(RejectWarning = 'Y');
		Stock_ScrubsAttachment		:= Scrubs.fn_email_attachment(Stock_ScrubsAlert);
		Stock_MailFile						:= FileServices.SendEmailAttachData(corp2.Email_Notification_Lists.spray
																																 ,'Scrubs CorpStock_MN Report' //subject
																																 ,'Scrubs CorpStock_MN Report' //body
																																 ,(data)Stock_ScrubsAttachment
																																 ,'text/csv'
																																 ,'CorpMNEventScrubsReport.csv'
																																 ,
																																 ,
																																 ,corp2.Email_Notification_Lists.spray);

		Stock_BadRecords					:= Stock_N.ExpandedInFile(	
																												corp_key_Invalid							  			<> 0 or
																												corp_vendor_Invalid 									<> 0 or
																												corp_state_origin_Invalid 					 	<> 0 or
																												corp_process_date_Invalid						  <> 0 or
																												corp_sos_charter_nbr_Invalid					<> 0 or
																												stock_authorized_nbr_Invalid	 				<> 0 
																											 );
																																														
		Stock_GoodRecords					:= Stock_N.ExpandedInFile(	
																												corp_key_Invalid							  			= 0 and
																												corp_vendor_Invalid 									= 0 and
																												corp_state_origin_Invalid 					 	= 0 and
																												corp_process_date_Invalid						  = 0 and
																												corp_sos_charter_nbr_Invalid					= 0 and
																												stock_authorized_nbr_Invalid	 				= 0 
																											 );
																														
		Stock_FailBuild						:= if(count(Stock_GoodRecords) = 0,true,false);

		Stock_ApprovedRecords			:= project(Stock_GoodRecords,transform(Corp2_Mapping.LayoutsCommon.Stock,self := left));

		Stock_ALL									:= sequential( if(count(Stock_BadRecords) <> 0
																							,if(poverwrite
																									,output(Stock_BadRecords,,Corp2_Mapping._Dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::stock_'+state_origin,overwrite,__compressed__)
																									,output(Stock_BadRecords,,Corp2_Mapping._Dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::stock_'+state_origin,__compressed__)
																									)
																							)
																					,output(Stock_ScrubsWithExamples, all, named('CorpStockMNScrubsReportWithExamples'+filedate))
																					//Send Alerts if Scrubs exceeds thresholds
																					,if(count(Stock_ScrubsAlert) > 0, Stock_MailFile, output('CORP2_MAPPING.MN - No "Stock" Corp Scrubs Alerts'))
																					,Stock_ErrorSummary
																					,Stock_ScrubErrorReport
																					,Stock_SomeErrorValues	
																					,Stock_SubmitStats
																					);	

	//********************************************************************
  // UPDATE
  //********************************************************************

	Fail_Build						:= if(Event_FailBuild = true or Main_FailBuild = true or Stock_FailBuild = true,true,false);
	IsScrubErrors					:= if(Event_IsScrubErrors = true or Main_IsScrubErrors = true or Stock_IsScrubErrors = true,true,false);

	VersionControl.macBuildNewLogicalFile(Corp2_Mapping._dataset().thor_cluster_Files + 'in::corp2::' 	+ version + '::AR_' 		+ state_origin, AR_ApprovedRecords	 , write_ar,,,pOverwrite);
	VersionControl.macBuildNewLogicalFile(Corp2_Mapping._dataset().thor_cluster_Files + 'in::corp2::' 	+ version + '::Event_' 	+ state_origin, Event_ApprovedRecords, write_event,,,pOverwrite);
	VersionControl.macBuildNewLogicalFile(Corp2_Mapping._dataset().thor_cluster_Files + 'in::corp2::' 	+ version + '::Main_' 	+ state_origin, Main_ApprovedRecords , write_main,,,pOverwrite);
	VersionControl.macBuildNewLogicalFile(Corp2_Mapping._dataset().thor_cluster_Files + 'in::corp2::' 	+ version + '::Stock_' 	+ state_origin, Stock_ApprovedRecords, write_stock,,,pOverwrite);

	VersionControl.macBuildNewLogicalFile(Corp2_Mapping._dataset().thor_cluster_Files + 'fail::corp2::' + version + '::Event_' 	+ state_origin, Event_F	, write_fail_event,,,pOverwrite);
	VersionControl.macBuildNewLogicalFile(Corp2_Mapping._dataset().thor_cluster_Files + 'fail::corp2::' + version + '::Main_' 	+ state_origin, Main_F	, write_fail_main,,,pOverwrite);
	VersionControl.macBuildNewLogicalFile(Corp2_Mapping._dataset().thor_cluster_Files + 'fail::corp2::' + version + '::Stock_' 	+ state_origin, Stock_F	, write_fail_stock,,,pOverwrite);

	MapMN:= sequential ( if(pshouldspray = true,Corp2_Mapping.fSprayFiles(state_origin,version,pOverwrite := pOverwrite))
											// ,Corp2_Raw_MN.Build_Bases(filedate,version,puseprod).All
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
																		 ,if (count(Main_BadRecords) <> 0 or count(Event_BadRecords) <> 0 or count(Stock_BadRecords)<>0
																				 ,Corp2_Mapping.Send_Email(state_origin,version,count(Main_BadRecords)<>0,,count(Event_BadRecords)<>0,count(Stock_BadRecords)<>0,count(Main_BadRecords),,count(Event_BadRecords),count(Stock_BadRecords),count(Main_ApprovedRecords),count(AR_ApprovedRecords),count(Event_ApprovedRecords),count(Stock_ApprovedRecords)).RecordsRejected																				 
																				 ,Corp2_Mapping.Send_Email(state_origin,version,count(Main_BadRecords)<>0,,count(Event_BadRecords)<>0,count(Stock_BadRecords)<>0,count(Main_BadRecords),,count(Event_BadRecords),count(Stock_BadRecords),count(Main_ApprovedRecords),count(AR_ApprovedRecords),count(Event_ApprovedRecords),count(Stock_ApprovedRecords)).MappingSuccess																				 
																				 )
																		 ,if (IsScrubErrors
																				 ,Corp2_Mapping.Send_Email(state_origin,version,Main_IsScrubErrors,,Event_IsScrubErrors,Stock_IsScrubErrors).FieldsInvalidPerScrubs
																				 )
																		 ) //if Fail_Build <> true																			
												 ,sequential (write_fail_event
																		 ,write_fail_main
																		 ,write_fail_stock												 
																		 ,Corp2_Mapping.Send_Email(state_origin,version).MappingFailed
																		 ) //if Fail_Build = true
												 )
										);
										
	isFileDateValid := if((string)std.date.today() between ut.date_math(filedate,-30) and ut.date_math(filedate,30),true,false);
	return sequential (	 if (isFileDateValid
													,MapMN
													,sequential (Corp2_Mapping.Send_Email(state_origin,filedate).InvalidFileDateParm
																			,FAIL('Corp2_Mapping.'+state_origin+' failed.  An invalid filedate was passed in as a parameter.')
																			)
													)
										);

	end;	// end of Update function

end;  // end of Module