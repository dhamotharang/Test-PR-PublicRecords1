import corp2, corp2_raw_me, scrubs, scrubs_corp2_mapping_me_ar, scrubs_corp2_mapping_me_main, std, tools, ut, versioncontrol;

export ME := MODULE; 
 	
	export Update(string fileDate, string version, boolean pShouldSpray = Corp2_Mapping._Dataset().bShouldSpray, boolean pOverwrite = false, pUseProd = Tools._Constants.IsDataland) := Function

		state_origin			 				:= 'ME';
		state_fips	 				 			:= '23';
		state_desc	 			 				:= 'MAINE';

		CorpBulk			 						:= dedup(sort(distribute(Corp2_Raw_ME.Files(fileDate,puseprod).Input.CorpBulk.Logical,hash(corp_id)),record,local),record,local) : independent;

		//Build an extended file for collecting multiple addresses
		CorpBulkExtended 					:= project(CorpBulk,transform(Corp2_Raw_ME.Layouts.Temp_CorpBulkDenormLayoutIn,
																													  self.addr_type	 := if(corp2.t2u(left.addr_name+left.addr_1+left.addr_2+left.city+left.state+left.country+left.zip1+left.zip2)='','',left.addr_type);
																													  self						 := left;
																													  self 						 := [];
																													 )
																				);

		//Sort records in order for denormalize
		CorpBulkExtendedSorted 		:= sort(CorpBulkExtended,corp_id,nam_seq_no,local);
		
		Corp2_Raw_ME.Layouts.Temp_CorpBulkDenormLayoutIn DenormAddr(Corp2_Raw_ME.Layouts.Temp_CorpBulkDenormLayoutIn l, Corp2_Raw_ME.Layouts.CorpBulkLayoutIn r) := transform			
				self.home_office_addr_type 							:= if(r.addr_type='H',r.addr_type,l.home_office_addr_type);
				self.home_office_addr_name 							:= if(r.addr_type='H',r.addr_name,l.home_office_addr_name);
				self.home_office_addr_1 						  	:= if(r.addr_type='H',r.addr_1,l.home_office_addr_1);
				self.home_office_addr_2    							:= if(r.addr_type='H',r.addr_2,l.home_office_addr_2);
				self.home_office_city   							  := if(r.addr_type='H',r.city,l.home_office_city);
				self.home_office_state     							:= if(r.addr_type='H',r.state,l.home_office_state);
				self.home_office_country   							:= if(r.addr_type='H',r.country,l.home_office_country);
				self.home_office_zip1      							:= if(r.addr_type='H',r.zip1,l.home_office_zip1);
				self.home_office_zip2      							:= if(r.addr_type='H',r.zip2,l.home_office_zip2);
				self.home_office_other_addr_type 				:= if(r.addr_type='M',r.addr_type,l.home_office_other_addr_type);
				self.home_office_other_addr_name	 			:= if(r.addr_type='M',r.addr_name,l.home_office_other_addr_name);
				self.home_office_other_addr_1				    := if(r.addr_type='M',r.addr_1,l.home_office_other_addr_1);
				self.home_office_other_addr_2 				  := if(r.addr_type='M',r.addr_2,l.home_office_other_addr_2);
				self.home_office_other_city   			  	:= if(r.addr_type='M',r.city,l.home_office_other_city);
				self.home_office_other_state 	 			    := if(r.addr_type='M',r.state,l.home_office_other_state);
				self.home_office_other_country	 			  := if(r.addr_type='M',r.country,l.home_office_other_country);
				self.home_office_other_zip1   			    := if(r.addr_type='M',r.zip1,l.home_office_other_zip1);
				self.home_office_other_zip2      				:= if(r.addr_type='M',r.zip2,l.home_office_other_zip2);
				self 			 			 												:= l;
				self																		:= [];
		end;

		CorpBulkDenormed 					:= denormalize(CorpBulkExtendedSorted,CorpBulk,
																						 left.corp_id 		= right.corp_id and
																						 left.nam_seq_no	=	right.nam_seq_no,
																						 DenormAddr(left,right)
																						);
																						
		//Note: A,F,N are Assumed and Prior type records																						
		CorpBulk_NonPrior					:= CorpBulkDenormed(name_type not in ['A','F','N']);
		CorpBulk_Prior						:= CorpBulkDenormed(name_type 		in ['A','F','N']);

		//********************************************************************
		//This begins the MAIN mapping for non-prior & non-assumed type records.
		//Note: The transform maps the corporation records.  Plus, all fields
		//			are mapped here except for the the RA fields since multiple
		//			RA Addresses exist.
		//********************************************************************
		Corp2_Mapping.LayoutsCommon.Main CorpBulk_Transform(Corp2_Raw_ME.Layouts.Temp_CorpBulkDenormLayoutIn l) := transform
				self.dt_vendor_first_reported									:= (unsigned4)fileDate;
				self.dt_vendor_last_reported									:= (unsigned4)fileDate;
				self.dt_first_seen														:= (unsigned4)fileDate;
				self.dt_last_seen															:= (unsigned4)fileDate;
				self.corp_ra_dt_first_seen										:= (unsigned4)fileDate;
				self.corp_ra_dt_last_seen											:= (unsigned4)fileDate;			
				self.corp_key																	:= state_fips + '-' + corp2.t2u(l.corp_id);
				self.corp_vendor															:= state_fips;
				self.corp_state_origin												:= state_origin;			
				self.corp_process_date												:= fileDate;
				self.corp_orig_sos_charter_nbr								:= corp2.t2u(l.corp_id);
				self.corp_legal_name													:= Corp2_mapping.fCleanBusinessName(state_origin,state_desc,l.corp_name).BusinessName;
				self.corp_ln_name_type_cd											:= Corp2_Raw_ME.Functions.LNNameTypeCD(l.name_type,l.corp_id[9..10]);
				self.corp_ln_name_type_desc										:= Corp2_Raw_ME.Functions.LNNameTypeDesc(l.name_type,l.corp_id[9..10]);
				self.corp_address1_type_cd					 		 			:= if(Corp2_mapping.fAddressExists(state_origin,state_desc,l.home_office_addr_name,l.home_office_addr_1+''+l.home_office_addr_2,l.home_office_city,l.home_office_state,l.home_office_zip1+l.home_office_zip2,l.home_office_country).ifAddressExists,corp2.t2u(l.home_office_addr_type),'');
				self.corp_address1_type_desc						 			:= if(Corp2_mapping.fAddressExists(state_origin,state_desc,l.home_office_addr_name,l.home_office_addr_1+''+l.home_office_addr_2,l.home_office_city,l.home_office_state,l.home_office_zip1+l.home_office_zip2,l.home_office_country).ifAddressExists and corp2.t2u(l.home_office_addr_type)='H','HOME OFFICE','');
				self.corp_address1_line1											:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.home_office_addr_name,l.home_office_addr_1+''+l.home_office_addr_2,l.home_office_city,l.home_office_state,l.home_office_zip1+l.home_office_zip2,l.home_office_country).AddressLine1;
				self.corp_address1_line2											:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.home_office_addr_name,l.home_office_addr_1+''+l.home_office_addr_2,l.home_office_city,l.home_office_state,l.home_office_zip1+l.home_office_zip2,l.home_office_country).AddressLine2;
				self.corp_address1_line3											:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.home_office_addr_name,l.home_office_addr_1+''+l.home_office_addr_2,l.home_office_city,l.home_office_state,l.home_office_zip1+l.home_office_zip2,l.home_office_country).AddressLine3;
				self.corp_prep_addr1_line1										:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.home_office_addr_name,l.home_office_addr_1+''+l.home_office_addr_2,l.home_office_city,l.home_office_state,l.home_office_zip1+l.home_office_zip2,l.home_office_country).PrepAddrLine1;
				self.corp_prep_addr1_last_line								:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.home_office_addr_name,l.home_office_addr_1+''+l.home_office_addr_2,l.home_office_city,l.home_office_state,l.home_office_zip1+l.home_office_zip2,l.home_office_country).PrepAddrLastLine;
				self.corp_address2_type_cd					 		 			:= if(Corp2_mapping.fAddressExists(state_origin,state_desc,l.home_office_other_addr_name,l.home_office_other_addr_1+''+l.home_office_other_addr_2,l.home_office_city,l.home_office_other_state,l.home_office_other_zip1+l.home_office_other_zip2,l.home_office_other_country).ifAddressExists,corp2.t2u(l.home_office_other_addr_type),'');
				self.corp_address2_type_desc						 			:= if(Corp2_mapping.fAddressExists(state_origin,state_desc,l.home_office_other_addr_name,l.home_office_other_addr_1+''+l.home_office_other_addr_2,l.home_office_city,l.home_office_other_state,l.home_office_other_zip1+l.home_office_other_zip2,l.home_office_other_country).ifAddressExists and corp2.t2u(l.home_office_other_addr_type)='M','HOME OFFICE OTHER','');
				self.corp_address2_line1											:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.home_office_other_addr_name,l.home_office_other_addr_1+''+l.home_office_other_addr_2,l.home_office_other_city,l.home_office_other_state,l.home_office_other_zip1+l.home_office_other_zip2,l.home_office_other_country).AddressLine1;
				self.corp_address2_line2											:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.home_office_other_addr_name,l.home_office_other_addr_1+''+l.home_office_other_addr_2,l.home_office_other_city,l.home_office_other_state,l.home_office_other_zip1+l.home_office_other_zip2,l.home_office_other_country).AddressLine2;
				self.corp_address2_line3											:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.home_office_other_addr_name,l.home_office_other_addr_1+''+l.home_office_other_addr_2,l.home_office_other_city,l.home_office_other_state,l.home_office_other_zip1+l.home_office_other_zip2,l.home_office_other_country).AddressLine3;
				self.corp_prep_addr2_line1										:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.home_office_other_addr_name,l.home_office_other_addr_1+''+l.home_office_other_addr_2,l.home_office_other_city,l.home_office_other_state,l.home_office_other_zip1+l.home_office_other_zip2,l.home_office_other_country).PrepAddrLine1;
				self.corp_prep_addr2_last_line								:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.home_office_other_addr_name,l.home_office_other_addr_1+''+l.home_office_other_addr_2,l.home_office_other_city,l.home_office_other_state,l.home_office_other_zip1+l.home_office_other_zip2,l.home_office_other_country).PrepAddrLastLine;				
				self.corp_filing_date													:= Corp2_Raw_ME.Functions.FilingDate(l.qual_date,l.file_date,l.corp_id[9..10]);
				self.corp_filing_desc             			  		:= Corp2_Raw_ME.Functions.FilingDesc(l.qual_date,l.file_date,l.corp_id[9..10]);
				self.corp_status_cd														:= corp2.t2u(l.corp_status);
				self.corp_status_desc													:= Corp2_Raw_ME.Functions.CorpStatusDesc(l.corp_status);
				self.corp_inc_state														:= state_origin;
				self.corp_inc_date                  					:= if(corp2.t2u(l.jurisdiction) in [state_origin,''],Corp2_Raw_ME.Functions.IncDate(l.incorp_date,l.qual_date,l.file_date),'');
				self.corp_term_exist_cd		 										:= map(corp2.t2u(l.expire_date)	= '' 																		 => 'P',
																														 Corp2_Mapping.fValidateDate(l.expire_date,'CCYYMMDD').GeneralDate <> '' => 'D',
																														 ''
																														);
				self.corp_term_exist_exp	 										:= Corp2_Mapping.fValidateDate(l.expire_date,'CCYYMMDD').GeneralDate;
				self.corp_term_exist_desc 										:= map(corp2.t2u(l.expire_date)	= '' 																		 => 'PERPETUAL',
																														 Corp2_Mapping.fValidateDate(l.expire_date,'CCYYMMDD').GeneralDate <> '' => 'EXPIRATION DATE',
																														 ''
																														);
				self.corp_foreign_domestic_ind								:= map(corp2.t2u(l.jurisdiction) in [state_origin,'']			=> 'D',
																														 corp2.t2u(l.jurisdiction) not in [state_origin,''] => 'F',
																														 ''
																														);
				self.corp_forgn_state_cd											:= if(corp2.t2u(l.jurisdiction) not in [state_origin,''],corp2.t2u(l.jurisdiction),'');
				self.corp_forgn_state_desc										:= if(corp2.t2u(l.jurisdiction) not in [state_origin,''],Corp2_Raw_ME.Functions.CorpForgnStateDesc(l.jurisdiction),'');
				self.corp_forgn_date                  				:= if(corp2.t2u(l.jurisdiction) not in [state_origin,''],Corp2_Raw_ME.Functions.ForgnDate(l.incorp_date,l.qual_date,l.file_date),'');
				self.corp_orig_org_structure_cd 							:= if(self.corp_ln_name_type_cd	in ['','01','07'],corp2.t2u(l.corp_id[9..10]),'');
				self.corp_orig_org_structure_desc 			  		:= if(self.corp_ln_name_type_cd	in ['','01','07'],Corp2_Raw_ME.Functions.CorpOrigOrgStructureDesc(l.corp_id[9..10]),'');
				self.corp_for_profit_ind											:= if(corp2.t2u(l.corp_id[9..10]) in ['N','ND','NF','NR','RN'],'N','');
				self.corp_orig_bus_type_desc									:= if(self.corp_ln_name_type_cd	in ['','01','07'] and corp2.t2u(l.coop_name) not in ['LIST45',''],corp2.t2u(l.coop_name),'');
				//Note: corp_addl_info is a overloaded field
				self.corp_addl_info                 			    := Corp2_Raw_ME.Functions.CorpAddlInfo(l.close_ind,l.fiduciary_ind,l.pa_ind,l.public_mutual,l.directors_to,l.directors_from,l.members_ind,l.corp_id);		
				ra_address_type																:= if(corp2.t2u(l.addr_type) in ['C','O'] and Corp2_mapping.fAddressExists(state_origin,state_desc,l.addr_1,l.addr_2,l.city,l.state,l.zip1+l.zip2,l.country).ifAddressExists,corp2.t2u(l.addr_type),'');
				self.corp_ra_full_name												:= if(ra_address_type<>'',Corp2_mapping.fCleanBusinessName(state_origin,state_desc,l.addr_name).BusinessName,'');
				self.corp_ra_address_type_cd					 	 			:= if(ra_address_type<>'',corp2.t2u(l.addr_type),'');
				self.corp_ra_address_type_desc						 		:= if(ra_address_type<>'',
																														map(corp2.t2u(l.addr_type) = 'C' => 'REGISTERED OFFICE',
																																corp2.t2u(l.addr_type) = 'O' => 'REGISTERED OFFICE OTHER',														
																																''
																															 ),
																														''
																													 );
				self.corp_ra_address_line1										:= if(ra_address_type<>'',Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.addr_1,l.addr_2,l.city,l.state,l.zip1+l.zip2,l.country).AddressLine1,'');
				self.corp_ra_address_line2										:= if(ra_address_type<>'',Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.addr_1,l.addr_2,l.city,l.state,l.zip1+l.zip2,l.country).AddressLine2,'');
				self.corp_ra_address_line3										:= if(ra_address_type<>'',Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.addr_1,l.addr_2,l.city,l.state,l.zip1+l.zip2,l.country).AddressLine3,'');
				self.ra_prep_addr_line1												:= if(ra_address_type<>'',Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.addr_1,l.addr_2,l.city,l.state,l.zip1+l.zip2,l.country).PrepAddrLine1,'');
				self.ra_prep_addr_last_line										:= if(ra_address_type<>'',Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.addr_1,l.addr_2,l.city,l.state,l.zip1+l.zip2,l.country).PrepAddrLastLine,'');
				self.corp_country_of_formation								:= Corp2_Raw_ME.Functions.CorpCountryOfFormation(l.jurisdiction);
				self.corp_has_members													:= if(corp2.t2u(l.members_ind) in ['Y','N'],corp2.t2u(l.members_ind),'');
				self.corp_organizational_comments							:= if(corp2.t2u(l.quasi_ind) = 'Y','QUASI CORPORATION','');
				self.corp_management_desc											:= map(corp2.t2u(l.close_ind) = 'C' => 'COMPANY HAS MANAGERS',
																														 corp2.t2u(l.close_ind) = 'N' => 'COMPANY HAS DIRECTORS',
																														 corp2.t2u(l.close_ind) = 'W' => 'COMPANY HAS MEMBERS',
																														 corp2.t2u(l.close_ind) = 'Y' => 'COMPANY HAS SHAREHOLDERS',
																														 ''
																														);
				self.corp_foreign_fiduciary_capacity_in_state := if(corp2.t2u(l.fiduciary_ind) in ['Y','N'],corp2.t2u(l.fiduciary_ind),'');
				self.corp_is_professional											:= if(corp2.t2u(l.pa_ind) in ['Y','N'],corp2.t2u(l.pa_ind),'');
				self.corp_public_mutual_corporation						:= map(stringlib.stringfind(corp2.t2u(l.public_mutual),'PUBLIC',1) <> 0 => corp2.t2u(l.public_mutual),
																														 stringlib.stringfind(corp2.t2u(l.public_mutual),'MUTUAL',1) <> 0 => corp2.t2u(l.public_mutual),
																														 ''
																														);
        self.corp_directors_from_to										:= Corp2_Raw_ME.Functions.CorpDirectorsFromTo(l.directors_to,l.directors_from);
				self.corp_purpose															:= corp2.t2u(l.purpose);
				self.internalfield1														:= corp2.t2u(l.name_type); //for scrub purposes
				self.recordorigin															:= 'C';
				self 																					:= [];
		end;

		Map_CorpBulk_NonPrior		:= project(CorpBulk_NonPrior,CorpBulk_Transform(left));

		//********************************************************************
		//This begins the MAIN mapping for prior & assumed type records.
		//********************************************************************
		Corp2_Mapping.LayoutsCommon.Main NameOnly_Transform(Corp2_Raw_ME.Layouts.Temp_CorpBulkDenormLayoutIn l) := transform
				self.dt_vendor_first_reported									:= (unsigned4)fileDate;
				self.dt_vendor_last_reported									:= (unsigned4)fileDate;
				self.dt_first_seen														:= (unsigned4)fileDate;
				self.dt_last_seen															:= (unsigned4)fileDate;
				self.corp_ra_dt_first_seen										:= (unsigned4)fileDate;
				self.corp_ra_dt_last_seen											:= (unsigned4)fileDate;			
				self.corp_key																	:= state_fips + '-' + corp2.t2u(l.corp_id);
				self.corp_vendor															:= state_fips;
				self.corp_state_origin												:= state_origin;			
				self.corp_process_date												:= fileDate;
				self.corp_orig_sos_charter_nbr								:= corp2.t2u(l.corp_id);
				self.corp_legal_name													:= Corp2_mapping.fCleanBusinessName(state_origin,state_desc,l.corp_name).BusinessName;
				self.corp_ln_name_type_cd											:= Corp2_Raw_ME.Functions.LNNameTypeCD(l.name_type,l.corp_id[9..10]);
				self.corp_ln_name_type_desc										:= Corp2_Raw_ME.Functions.LNNameTypeDesc(l.name_type,l.corp_id[9..10]);
				self.corp_inc_state														:= state_origin;				
				self.corp_inc_date                  					:= if(corp2.t2u(l.jurisdiction) in [state_origin,''],Corp2_Raw_ME.Functions.IncDate(l.incorp_date,l.qual_date,l.file_date),'');
				self.corp_forgn_date                  				:= if(corp2.t2u(l.jurisdiction) not in [state_origin,''],Corp2_Raw_ME.Functions.ForgnDate(l.incorp_date,l.qual_date,l.file_date),'');
				self.internalfield1														:= corp2.t2u(l.name_type); //for scrub purposes
				self.recordorigin															:= 'C';
				self 																					:= [];
		end;

		Map_CorpBulk_Prior			:= project(CorpBulk_Prior,NameOnly_Transform(left));

		//********************************************************************
		//This begins the MAIN mapping.
		//Note: The third RA address is mapped here, if it exists
		//********************************************************************
		Corp2_Mapping.LayoutsCommon.Main RA_Addr_Transform(Corp2_Mapping.LayoutsCommon.Main l, Corp2_Raw_ME.Layouts.Temp_CorpBulkDenormLayoutIn r) := transform
				self.corp_ra_full_name												:= Corp2_mapping.fCleanBusinessName(state_origin,state_desc,r.cra_entity_name).BusinessName;
				city				 																	:= stringlib.splitwords(corp2.t2u(r.cra_mail_addr3),',',true)[1];
				statezip																			:= stringlib.splitwords(corp2.t2u(r.cra_mail_addr3),',',true)[2];
				state																					:= stringlib.splitwords(corp2.t2u(statezip),' ',true)[1];
				zip																						:= stringlib.splitwords(corp2.t2u(statezip),' ',true)[2];
				self.corp_ra_address_type_cd									:= if(Corp2_Mapping.fAddressExists(state_origin,state_desc,r.cra_mail_addr1,r.cra_mail_addr2,city,state,zip).ifAddressExists,'M','');
				self.corp_ra_address_type_desc								:= if(Corp2_Mapping.fAddressExists(state_origin,state_desc,r.cra_mail_addr1,r.cra_mail_addr2,city,state,zip).ifAddressExists,'MAILING ADDRESS','');
				self.corp_ra_address_line1										:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,r.cra_mail_addr1,r.cra_mail_addr2,city,state,zip).AddressLine1;
				self.corp_ra_address_line2										:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,r.cra_mail_addr1,r.cra_mail_addr2,city,state,zip).AddressLine2;
				self.corp_ra_address_line3										:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,r.cra_mail_addr1,r.cra_mail_addr2,city,state,zip).AddressLine3;
				self.ra_prep_addr_line1												:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,r.cra_mail_addr1,r.cra_mail_addr2,city,state,zip).PrepAddrLine1;
				self.ra_prep_addr_last_line										:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,r.cra_mail_addr1,r.cra_mail_addr2,city,state,zip).PrepAddrLastLine;				
				self																					:= l;
		end;

		Map_RA_Addr  						:= join(Map_CorpBulk_NonPrior,CorpBulk_NonPrior(corp2.t2u(cra_mail_addr1 + cra_mail_addr2 + cra_mail_addr3) <> ''),
																		corp2.t2u(left.corp_orig_sos_charter_nbr) = corp2.t2u(right.corp_id),
																		RA_Addr_Transform(left,right),
																		inner,
																		local
																	 );
																	 
		AllMain		 							:= dedup(sort(distribute(Map_CorpBulk_NonPrior + Map_CorpBulk_Prior + Map_RA_Addr,hash(corp_key)),record,local),record,local) : independent;

		Corp2_Mapping.LayoutsCommon.Main RollUp_RA_Transform(Corp2_Mapping.LayoutsCommon.Main l, Corp2_Mapping.LayoutsCommon.Main r) := transform			
			has_ra													:= if(corp2.t2u(l.corp_ra_full_name + l.corp_ra_address_line1 + l.corp_ra_address_line2 + l.corp_ra_address_line3)<>'',true,false);
			self.corp_ra_full_name					:= if(has_ra,corp2.t2u(l.corp_ra_full_name),corp2.t2u(r.corp_ra_full_name));
			self.corp_ra_address_type_cd		:= if(has_ra,corp2.t2u(l.corp_ra_address_type_cd),corp2.t2u(r.corp_ra_address_type_cd));
			self.corp_ra_address_type_desc	:= if(has_ra,corp2.t2u(l.corp_ra_address_type_desc),corp2.t2u(r.corp_ra_address_type_desc));
			self.corp_ra_address_line1			:= if(has_ra,corp2.t2u(l.corp_ra_address_line1),corp2.t2u(r.corp_ra_address_line1));
			self.corp_ra_address_line2			:= if(has_ra,corp2.t2u(l.corp_ra_address_line2),corp2.t2u(r.corp_ra_address_line2));
			self.corp_ra_address_line3			:= if(has_ra,corp2.t2u(l.corp_ra_address_line3),corp2.t2u(r.corp_ra_address_line3));
			self.ra_prep_addr_line1					:= if(has_ra,corp2.t2u(l.ra_prep_addr_line1),corp2.t2u(r.ra_prep_addr_line1));								
			self.ra_prep_addr_last_line			:= if(has_ra,corp2.t2u(l.ra_prep_addr_last_line),corp2.t2u(r.ra_prep_addr_last_line));
			self														:= l;
		end; 
		
		//This rollup combines those records where the records are identical except for 
		//the ra information.  In some cases, there is one record with ra data and
		//one without ra data.
		MapMain						 := rollup(AllMain
																,left.corp_key 									= right.corp_key 								and
																 left.corp_legal_name 					= right.corp_legal_name 				and
																 left.corp_ln_name_type_cd			= right.corp_ln_name_type_cd 		and
																(left.corp_ra_full_name 				= right.corp_ra_full_name				or corp2.t2u(left.corp_ra_full_name) = '' 			or corp2.t2u(right.corp_ra_full_name) = '') 			and
																(left.corp_ra_address_type_cd 	= right.corp_ra_address_type_cd or corp2.t2u(left.corp_ra_address_type_cd) = '' or corp2.t2u(right.corp_ra_address_type_cd) = '')	and
																(left.ra_prep_addr_line1 				= right.ra_prep_addr_line1 			or corp2.t2u(left.ra_prep_addr_line1) = '' 			or corp2.t2u(right.ra_prep_addr_line1) = '') 			and
																(left.ra_prep_addr_last_line 		= right.ra_prep_addr_last_line  or corp2.t2u(left.ra_prep_addr_last_line) = '' 	or corp2.t2u(right.ra_prep_addr_last_line) = '')																
																,RollUp_RA_Transform(left, right)
																,local
															 ) : independent;

		//********************************************************************
		//This begins the AR mapping.
		//********************************************************************
		Corp2_Mapping.LayoutsCommon.AR ARTransform(string fileDate, Corp2_Raw_ME.Layouts.CorpBulkLayoutIn l) := transform			
				self.corp_key														:= state_fips + '-' + corp2.t2u(l.corp_id);
				self.corp_vendor												:= state_fips;
				self.corp_state_origin									:= state_origin;			
				self.corp_process_date									:= fileDate;
				self.corp_sos_charter_nbr								:= corp2.t2u(l.corp_id);
				self.ar_comment													:= if(corp2.t2u(l.rpt_dlnq_ind)='Y',
																										  map(corp2.t2u(l.ar_dcn) <> '' => corp2.t2u(l.ar_dcn) + ' REPORT DELINQUENT',
																													corp2.t2u(l.ar_dcn) =  '' => 'REPORT DELINQUENT',
																													''
																												 ),
																											corp2.t2u(l.ar_dcn)
																											);
				self																		:= [];
		end;
		
		AllAR					 						:= project(CorpBulk, ARTransform(fileDate,left));
		MapAR		 									:= dedup(sort(distribute(AllAR(corp2.t2u(ar_comment)<>''),hash(corp_key)),record,local),record,local) : independent;

		//********************************************************************
		// SCRUB AR 
		//********************************************************************	
		AR_F := MapAR;
		AR_S := Scrubs_Corp2_Mapping_ME_AR.Scrubs;				// Scrubs module
		AR_N := AR_S.FromNone(AR_F); 											// Generate the error flags
		AR_T := AR_S.FromBits(AR_N.BitmapInfile);     		// Use the FromBits module; makes my bitmap datafile easier to get to
		AR_U := AR_S.FromExpanded(AR_N.ExpandedInFile); 	// Pass the expanded error flags into the Expanded module

		//Outputs reports
		AR_ErrorSummary			 	 := output(AR_U.SummaryStats, named('AR_ErrorSummary_ME'+fileDate));
		AR_ScrubErrorReport 	 := output(choosen(AR_U.AllErrors, 1000), named('AR_ScrubErrorReport_ME'+fileDate));
		AR_SomeErrorValues		 := output(choosen(AR_U.BadValues, 1000), named('AR_SomeErrorValues_ME'+fileDate));
		AR_IsScrubErrors		 	 := IF(count(AR_U.AllErrors)<> 0,true,false);

		// Orbit Stats
		AR_OrbitStats				 	 := AR_U.OrbitStats();

		//Outputs files
		AR_CreateBitMaps			 := output(AR_N.BitmapInfile,,'~thor_data::corp_ME_ar_scrubs_bits',overwrite,compressed);	//long term storage
		AR_TranslateBitMap		 := output(AR_T);

		//Submits Profile's stats to Orbit
		AR_SubmitStats 			   := Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_ME_AR','ScrubsAlerts', AR_OrbitStats, version,'Corp_ME_AR').SubmitStats;
		AR_ScrubsWithExamples  := Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_ME_AR','ScrubsAlerts', AR_OrbitStats, version,'Corp_ME_AR').CompareToProfile_with_Examples;

		AR_ScrubsAlert				 := AR_ScrubsWithExamples(RejectWarning = 'Y');
		AR_ScrubsAttachment	   := Scrubs.fn_email_attachment(AR_ScrubsAlert);
		AR_MailFile					   := FileServices.SendEmailAttachData(corp2.Email_Notification_Lists.AttachedList
																															,'Scrubs CorpAR_ME Report' //subject
																															,'Scrubs CorpAR_ME Report' //body
																															,(data)AR_ScrubsAttachment
																															,'text/csv'
																															,'CorpMEARScrubsReport.csv'
																															);

		AR_BadRecords				 		:= AR_N.ExpandedInFile(	
																										corp_key_Invalid							  			<> 0 or
																										corp_vendor_Invalid 									<> 0 or
																										corp_state_origin_Invalid 					 	<> 0 or
																										corp_process_date_Invalid						  <> 0 or
																										corp_sos_charter_nbr_Invalid 					<> 0 or
																										ar_report_nbr_Invalid									<> 0															
																									 );

		AR_GoodRecords						:= AR_N.ExpandedInFile(
																										 corp_key_Invalid							  			= 0 and
																										 corp_vendor_Invalid 									= 0 and
																										 corp_state_origin_Invalid 					 	= 0 and
																										 corp_process_date_Invalid					  = 0 and
																										 corp_sos_charter_nbr_Invalid 				= 0 and
																										 ar_report_nbr_Invalid								= 0
																									 );


		AR_FailBuild					 		:= if(count(AR_GoodRecords) = 0,true,false);

		AR_ApprovedRecords		 		:= project(AR_GoodRecords,transform(Corp2_Mapping.LayoutsCommon.AR,self := left;));


		AR_ALL								 		:= sequential(IF(count(AR_BadRecords) <> 0
																						  ,IF (poverwrite
																								  ,OUTPUT(AR_BadRecords,,Corp2_Mapping._Dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::ar_'+state_origin,overwrite,__compressed__)
																								  ,OUTPUT(AR_BadRecords,,Corp2_Mapping._Dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::ar_'+state_origin,__compressed__)
																								  )
																						  )
																					 ,output(AR_ScrubsWithExamples, all, named('CorpARMEScrubsReportWithExamples'+fileDate))
																					 //Send Alerts if Scrubs exceeds thresholds
																					 ,IF(COUNT(AR_ScrubsAlert) > 0, AR_MailFile, OUTPUT('CORP2_MAPPING.ME - No "AR" Corp Scrubs Alerts'))
																					 ,AR_ErrorSummary
																					 ,AR_ScrubErrorReport
																					 ,AR_SomeErrorValues	
																					 ,AR_SubmitStats
																					);
																					
	//********************************************************************
  // SCRUB MAIN
  //********************************************************************	
		Main_F := MapMain;
		Main_S := Scrubs_Corp2_Mapping_ME_Main.Scrubs;					// Scrubs module
		Main_N := Main_S.FromNone(Main_F); 											// Generate the error flags
		Main_T := Main_S.FromBits(Main_N.BitMapInfile);     		// Use the FromBits module; makes my bitMap datafile easier to get to
		Main_U := Main_S.FromExpanded(Main_N.ExpandedInFile); 	// Pass the expanded error flags into the Expanded module

		//Outputs reports
		Main_ErrorSummary					:= output(Main_U.SummaryStats, named('Main_ErrorSummary_ME'+fileDate));
		Main_ScrubErrorReport 		:= output(choosen(Main_U.AllErrors, 1000), named('Main_ScrubErrorReport_ME'+fileDate));
		Main_SomeErrorValues			:= output(choosen(Main_U.BadValues, 1000), named('Main_SomeErrorValues_ME'+fileDate));
		Main_IsScrubErrors		 		:= if(count(Main_U.AllErrors)<> 0,true,false);

		// Orbit Stats
		Main_OrbitStats						:= Main_U.OrbitStats();

		//Outputs files
		Main_CreateBitMaps				:= output(Main_N.BitMapInfile,,'~thor_data::corp_ME_main_scrubs_bits',overwrite,compressed);	//long term storage
		Main_TranslateBitMap			:= output(Main_T);

		//Submits Profile's stats to Orbit
		Main_SubmitStats 			    := Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_ME_Main','ScrubsAlerts', Main_OrbitStats, version,'Corp_ME_Main').SubmitStats;
		Main_ScrubsWithExamples   := Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_ME_Main','ScrubsAlerts', Main_OrbitStats, version,'Corp_ME_Main').CompareToProfile_with_Examples;

		Main_ScrubsAlert					:= Main_ScrubsWithExamples(RejectWarning = 'Y');
		Main_ScrubsAttachment			:= Scrubs.fn_email_attachment(Main_ScrubsAlert);
		Main_MailFile							:= FileServices.SendEmailAttachData(corp2.Email_Notification_Lists.spray
																																 ,'Scrubs CorpMain_ME Report' //subject
																																 ,'Scrubs CorpMain_ME Report' //body
																																 ,(data)Main_ScrubsAttachment
																																 ,'text/csv'
																																 ,'CorpMEMainScrubsReport.csv'
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
																											 corp_ln_name_type_desc_Invalid					<> 0 or
																											 corp_address1_line3_Invalid						<> 0 or
																											 corp_filing_date_Invalid								<> 0 or
																											 corp_status_cd_Invalid									<> 0 or
																											 corp_status_desc_Invalid								<> 0 or
																											 corp_inc_state_Invalid 								<> 0 or
																											 corp_inc_date_Invalid 									<> 0 or
																											 corp_term_exist_exp_Invalid						<> 0 or
																											 corp_forgn_state_cd_Invalid 						<> 0 or
																											 corp_forgn_state_desc_Invalid 					<> 0 or
																											 corp_forgn_date_Invalid 								<> 0 or
																											 corp_orig_org_structure_desc_Invalid		<> 0 or
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
																										 corp_address1_line3_Invalid						= 0 and
																										 corp_filing_date_Invalid								= 0 and
    																								 corp_status_cd_Invalid									= 0 and
    																								 corp_status_desc_Invalid								= 0 and																										 
																										 corp_inc_state_Invalid 								= 0 and
																										 corp_inc_date_Invalid 									= 0 and
																										 corp_term_exist_exp_Invalid						= 0 and
																										 corp_forgn_state_cd_Invalid 						= 0 and
																										 corp_forgn_state_desc_Invalid 					= 0 and
																										 corp_forgn_date_Invalid 								= 0 and
																										 corp_orig_org_structure_desc_Invalid		= 0 and																		 
																										 recordorigin_Invalid 									= 0 and																								 
																										 internalfield1_Invalid									= 0
																								  );

		Main_FailBuild					:= map( corp2_Mapping.fCalcPercent(count(Main_N.ExpandedInFile(corp_key_invalid<>0)),count(Main_N.ExpandedInFile),false) 										> Scrubs_Corp2_Mapping_ME_Main.Threshold_Percent.CORP_KEY										 => true,
																		corp2_Mapping.fCalcPercent(count(Main_N.ExpandedInFile(corp_orig_sos_charter_nbr_invalid<>0)),count(Main_N.ExpandedInFile),false) 	> Scrubs_Corp2_Mapping_ME_Main.Threshold_Percent.CORP_ORIG_SOS_CHARTER_NBR 	 => true,
																		corp2_Mapping.fCalcPercent(count(Main_N.ExpandedInFile(corp_legal_name_invalid<>0)),count(Main_N.ExpandedInFile),false) 						> Scrubs_Corp2_Mapping_ME_Main.Threshold_Percent.CORP_LEGAL_NAME 						 => true,
																		corp2_Mapping.fCalcPercent(count(Main_N.ExpandedInFile(corp_ln_name_type_cd_invalid<>0)),count(Main_N.ExpandedInFile),false) 				> Scrubs_Corp2_Mapping_ME_Main.Threshold_Percent.CORP_LN_NAME_TYPE_CD		  	 => true,
																		corp2_Mapping.fCalcPercent(count(Main_N.ExpandedInFile(corp_inc_date_invalid<>0)),count(Main_N.ExpandedInFile),false) 							> Scrubs_Corp2_Mapping_ME_Main.Threshold_Percent.CORP_INC_DATE 						 	 => true,
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
																					,output(Main_ScrubsWithExamples, all, named('CorpMainMEScrubsReportWithExamples'+fileDate))
																					//Send Alerts if Scrubs exceeds thresholds
																					,if(count(Main_ScrubsAlert) > 0, Main_MailFile, output('CORP2_MAPPING.ME - No "MAIN" Corp Scrubs Alerts'))
																					,Main_ErrorSummary
																					,Main_ScrubErrorReport
																					,Main_SomeErrorValues		
																					,Main_SubmitStats
																			);

	//********************************************************************
  // UPDATE
  //********************************************************************

	Fail_Build						:= if(AR_FailBuild = true or Main_FailBuild = true,true,false);
	IsScrubErrors					:= if(AR_IsScrubErrors = true or Main_IsScrubErrors = true,true,false);

	VersionControl.macBuildNewLogicalFile(Corp2_Mapping._dataset().thor_cluster_Files + 'in::corp2::' 	+ version + '::AR_' 		+ state_origin, AR_ApprovedRecords	 , write_ar,,,pOverwrite);
	VersionControl.macBuildNewLogicalFile(Corp2_Mapping._dataset().thor_cluster_Files + 'in::corp2::' 	+ version + '::Main_' 	+ state_origin, Main_ApprovedRecords , write_main,,,pOverwrite);

	VersionControl.macBuildNewLogicalFile(Corp2_Mapping._dataset().thor_cluster_Files + 'fail::corp2::' + version + '::AR_' 		+ state_origin, AR_F		, write_fail_ar,,,pOverwrite);
	VersionControl.macBuildNewLogicalFile(Corp2_Mapping._dataset().thor_cluster_Files + 'fail::corp2::' + version + '::Main_' 	+ state_origin, Main_F	, write_fail_main,,,pOverwrite);

	MapME := sequential( if(pshouldspray = true,Corp2_Mapping.fSprayFiles(state_origin,version,pOverwrite := pOverwrite))
											// ,Corp2_Raw_ME.Build_Bases(filedate,version,puseprod).All // Determined that building bases is not needed
											,AR_All
											,Main_All
											,if(Fail_Build <> true	 
												 ,sequential (write_ar
																		 ,write_main
																		 ,fileservices.addsuperfile(Corp2_Mapping._Dataset().thor_cluster_Files + 'in::'+Corp2_Mapping._Dataset().NameMapped +'::sprayed::ar'		,Corp2_Mapping._Dataset().thor_cluster_Files + 'in::corp2::'+version+'::ar_'		+state_origin)
																		 ,fileservices.addsuperfile(Corp2_Mapping._Dataset().thor_cluster_Files + 'in::'+Corp2_Mapping._Dataset().NameMapped +'::sprayed::main'	,Corp2_Mapping._Dataset().thor_cluster_Files + 'in::corp2::'+version+'::main_'	+state_origin)																		 
																		 ,if (count(Main_BadRecords) <> 0 or count(AR_BadRecords) <> 0
																				 ,Corp2_Mapping.Send_Email(state_origin,version,count(Main_BadRecords)<>0,count(AR_BadRecords)<>0,,,count(Main_BadRecords),count(AR_BadRecords),,,count(Main_ApprovedRecords),count(AR_ApprovedRecords),,).RecordsRejected																				 
																				 ,Corp2_Mapping.Send_Email(state_origin,version,count(Main_BadRecords)<>0,count(AR_BadRecords)<>0,,,count(Main_BadRecords),count(AR_BadRecords),,,count(Main_ApprovedRecords),count(AR_ApprovedRecords),,).MappingSuccess																				 
																				 )
																		 ,if (IsScrubErrors
																				 ,Corp2_Mapping.Send_Email(state_origin,version,Main_IsScrubErrors,AR_IsScrubErrors,,).FieldsInvalidPerScrubs
																				 )
																		 ) //if Fail_Build <> true																			
												 ,sequential (write_fail_ar
																		 ,write_fail_main
																		 ,Corp2_Mapping.Send_Email(state_origin,version).MappingFailed
																		 ) //if Fail_Build = true
												 )
										);
										
	isFileDateValid := if((string)std.date.today() between ut.date_math(filedate,-30) and ut.date_math(filedate,30),true,false);
	return sequential (	 if (isFileDateValid
													,MapME
													,sequential (Corp2_Mapping.Send_Email(state_origin,filedate).InvalidFileDateParm
																			,FAIL('Corp2_Mapping.'+state_origin+' failed.  An invalid filedate was passed in as a parameter.')
																			)
													)
										);

	end;	// end of Update function

end;  // end of Module