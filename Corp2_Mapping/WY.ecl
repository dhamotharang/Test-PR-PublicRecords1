import corp2, corp2_raw_wy, scrubs, scrubs_corp2_mapping_wy_ar, scrubs_corp2_mapping_wy_main,
       scrubs_corp2_mapping_wy_stock, std, tools, ut, versioncontrol;

export WY := MODULE; 

	export Update(string fileDate, string version, boolean pShouldSpray = _Dataset().bShouldSpray, boolean pOverwrite = false, pUseProd = Tools._Constants.IsDataland) := function

		state_origin			 := 'WY';
		state_fips	 			 := '56';	
		state_desc	 			 := 'WYOMING';
		
	  Filing 						 := dedup(sort(distribute(Corp2_Raw_WY.Files(fileDate,puseprod).Input.Filing.Logical,hash(filing_id)),record,local),record,local)   : independent;
	  FilingAR					 := dedup(sort(distribute(Corp2_Raw_WY.Files(fileDate,puseprod).Input.FilingAR.Logical,hash(filing_id)),record,local),record,local) : independent;
	  Party							 := dedup(sort(distribute(Corp2_Raw_WY.Files(fileDate,puseprod).Input.Party.Logical,hash(source_id)),record,except party_id,local),record,except party_id,local) : independent;
	
		//********************************************************************																						
		//Found over 720,000 records with the entire address in addr1 field.
		//The following logic determines which records are formatted correctly
		//and which records needs fixed.
		//********************************************************************		
		PartyAddrFormattedOkay 				:=(corp2.t2u(Party.addr1) <> '' and
																		 corp2.t2u(Party.city)  <> '' and
																		 corp2.t2u(Party.state) <> '') or
																		(corp2.t2u(Party.addr1) =  '' and
																		 corp2.t2u(Party.addr2) =  '' and
																		 corp2.t2u(Party.addr3) =  '' and
																		 corp2.t2u(Party.city)	=  '' and
																		 corp2.t2u(Party.state) =  '');

		PartyAddrOkay 		:= Party(PartyAddrFormattedOkay) 			: independent;
		PartyAddrNotOkay	:= Party(not(PartyAddrFormattedOkay)) : independent;		
		
		//********************************************************************																						
		//Found over 720,000 records with the entire address in addr1 field.
		//The following transform parses the addr1 field into their respective
		//addr1, city, state, and zip fields.
		//********************************************************************																						
		Corp2_Raw_WY.Layouts.PartyLayoutIn ParseAddr1IntoParts(Corp2_Raw_WY.Layouts.PartyLayoutIn l) := transform
			self.postal_code													:= Corp2_mapping.fCleanZip(state_origin,state_desc,l.addr1,l.addr2+' '+l.addr3).zip;
			self.city	 																:= Corp2_Raw_WY.Functions.City(state_origin,state_desc,l.addr1,l.addr2,l.addr3,l.last_name,l.middle_name);
			self.state																:= Corp2_Raw_WY.Functions.State(state_origin,state_desc,l.addr1,l.addr2,l.addr3,l.last_name);
			self.addr1																:= Corp2_Raw_WY.Functions.Addr1(state_origin,state_desc,l.addr1,l.addr2,l.addr3,self.city,self.state,self.postal_code);
			self.country															:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.addr1+' '+l.addr2+' '+l.addr3,,self.city,self.state,self.postal_code).Country;		
			self.addr2																:= corp2.t2u(l.addr2);
			self.addr3																:= corp2.t2u(l.addr3);
			self 																			:= l;
		end;

		PartyFixedAddr   	:= project(PartyAddrNotOkay,ParseAddr1IntoParts(left));
		CorrectedPartyFile:= dedup(sort(distribute(PartyAddrOkay + PartyFixedAddr,hash(source_id)),record,local),record,local) : independent;
		
		//Some parties are retrieved by using the filing_annual_report_id from the most current "FILINGAR" record.  The filing_annual_report_id
		//is matched with the source_id of the "PARTY" file to obtain the parties/contacts.  
		FilingARByFilingYR	:= sort(FilingAR,filing_id,-filing_year,local);

		Corp2_Raw_WY.Layouts.FilingARLayoutIn  RollupFilingYear(Corp2_Raw_WY.Layouts.FilingARLayoutIn l, Corp2_Raw_WY.Layouts.FilingARLayoutIn r) := transform
			self.filing_year    					:= if(l.Filing_year > r.filing_year, l.filing_year, r.filing_year);
			self.filing_annual_report_id 	:= if(l.Filing_year > r.filing_year, l.filing_annual_report_id , r.filing_annual_report_id);
			self.filing_date							:= if(l.Filing_year > r.filing_year, l.filing_date,  r.filing_date);
			self 													:= l;
		end;

		KeepCurrentFilingAR	:= rollup(FilingARByFilingYR,RollupFilingYear(LEFT,RIGHT),filing_id);
		
		PartyAR						  := CorrectedPartyFile(corp2.t2u(source_type)='ANNUAL REPORT');
		PartyNonAR				  := CorrectedPartyFile(corp2.t2u(source_type)<>'ANNUAL REPORT');
		
		JoinPartyFilingAR		:= join(PartyAR, KeepCurrentFilingAR,
																left.source_ID =  right.filing_annual_report_id,
																transform(Corp2_Raw_WY.Layouts.PartyLayoutIn,
																					self.source_id := right.filing_id;
																					self					 := left;
																				 ),
																left outer
															 );
															 
		AllContacts			 		:= JoinPartyFilingAR + PartyNonAR : independent;
		
		PartyNeedsNorm		:= AllContacts(corp2.t2u(org_name)<>'' and corp2.t2u(first_name+middle_name+last_name)<>'');
		PartyNotNeedsNorm	:= AllContacts(corp2.t2u(org_name)=''   or corp2.t2u(first_name+middle_name+last_name)='');

		PartyNotNorm		  := project(PartyNotNeedsNorm,transform(Corp2_Raw_WY.Layouts.TempFilingWithParty,
																														 self.norm_name	:= if(corp2.t2u(left.org_name)<>'',left.org_name,left.first_name+' '+left.middle_name+' '+left.last_name);
																														 self.norm_fname:= left.first_name;
																														 self.norm_mname:= left.middle_name;
																														 self.norm_lname:= left.last_name;
																														 self 					:= left;
																														 self						:= [];
																														)
																);
																
		Corp2_Raw_WY.Layouts.TempFilingWithParty NormCorp(Corp2_Raw_WY.Layouts.PartyLayoutIn  l, unsigned1 c):= transform,
		skip(c = 2 and corp2.t2u(l.first_name+l.middle_name+l.last_name)='')
			self.norm_name													 := choose(c,l.org_name,l.first_name+' '+l.middle_name+' '+l.last_name);
			self.norm_fname 												 := choose(c,'',l.first_name);
			self.norm_mname 												 := choose(c,'',l.middle_name);
			self.norm_lname 												 := choose(c,'',l.last_name);
			self																		 := l;
			self																		 := [];
		end;
		
		PartyNorm				 		:= normalize(PartyNeedsNorm, 2, NormCorp(left,counter));
		AllPartyFile		 		:= sort(distribute(PartyNorm + PartyNotNorm,hash(source_id)),record,local) : independent;

		//********************************************************************
		//Join Filing & Party file to retrieve only Filing records with no
		//matching Party record.
		//********************************************************************
		OnlyFilingWithNoParty 		 									:= join(Filing,AllPartyFile,
																												corp2.t2u(left.filing_id) = corp2.t2u(right.source_id),
																												transform(Corp2_Raw_WY.Layouts.TempFilingWithParty,
																																	self 									:= left;
																																	self.party_id 				:= right.party_id;
																																	self.party_type 			:= right.party_type;
																																	self.source_id 				:= right.source_id;
																																	self.source_type 			:= right.source_type;
																																	self.org_name				 	:= right.org_name;
																																	self.first_name 			:= right.first_name;
																																	self.middle_name			:= right.middle_name;
																																	self.last_name 				:= right.last_name;
																																	self.individual_title := right.individual_title;
																																	self.addr1 						:= right.addr1;
																																	self.addr2 						:= right.addr2;
																																	self.addr3 						:= right.addr3;
																																	self.city 						:= right.city;
																																	self.county 					:= right.county;
																																	self.state 						:= right.state;
																																	self.postal_code 			:= right.postal_code;
																																	self.country 					:= right.country;
																																	self.norm_name				:= right.norm_name;
																																	self.norm_fname 			:= right.norm_fname;
																																	self.norm_mname 			:= right.norm_mname;
																																	self.norm_lname 			:= right.norm_lname;
																																 ),
																												left only,
																												local
																											 ) : independent;

		//********************************************************************
		//Join Filing & Party file where both Filing and Party records exist.
		//********************************************************************																						
		FilingWithParty 						 								:= join(Filing,AllPartyFile,
																												corp2.t2u(left.filing_id) <> '' and 
																												corp2.t2u(left.filing_id) = corp2.t2u(right.source_id),
																												transform(Corp2_Raw_WY.Layouts.TempFilingWithParty,
																																	self 									:= left;
																																	self.party_id 				:= right.party_id;
																																	self.party_type 			:= right.party_type;
																																	self.source_id 				:= right.source_id;
																																	self.source_type 			:= right.source_type;
																																	self.org_name				 	:= right.org_name;
																																	self.first_name 			:= right.first_name;
																																	self.middle_name			:= right.middle_name;
																																	self.last_name 				:= right.last_name;
																																	self.individual_title := right.individual_title;
																																	self.addr1 						:= right.addr1;
																																	self.addr2 						:= right.addr2;
																																	self.addr3 						:= right.addr3;
																																	self.city 						:= right.city;
																																	self.county 					:= right.county;
																																	self.state 						:= right.state;
																																	self.postal_code 			:= right.postal_code;
																																	self.country 					:= right.country;
																																	self.norm_name				:= right.norm_name;
																																	self.norm_fname 			:= right.norm_fname;
																																	self.norm_mname 			:= right.norm_mname;
																																	self.norm_lname 			:= right.norm_lname;
																																 ),
																												inner,
																												local
																											 ) : independent;	
		
		FilingWithPartyDedup := dedup(sort(distribute(FilingWithParty,hash(filing_id)),record,except party_id,local),record,except party_id) : independent;

		RAFile						:= FilingWithPartyDedup(corp2.t2u(party_type) in 		 ['COMMERCIAL REGISTERED AGENT','REGISTERED AGENT']) : independent;
		PartyFile					:= FilingWithPartyDedup(corp2.t2u(party_type) not in ['COMMERCIAL REGISTERED AGENT','REGISTERED AGENT']) : independent;

		CorporationFile 	:= OnlyFilingWithNoParty + RAFile : independent;
		
		//********************************************************************
		//Main file mapping from the FilingWithParty.
		//********************************************************************
		Corp2_Mapping.LayoutsCommon.Main FilingMainCorpTransform(Corp2_Raw_WY.Layouts.TempFilingWithParty  l):= transform
			self.dt_vendor_first_reported							 := (integer)fileDate;
			self.dt_vendor_last_reported							 := (integer)fileDate;
			self.dt_first_seen												 := (integer)fileDate;
			self.dt_last_seen													 := (integer)fileDate;
			self.corp_ra_dt_first_seen								 := (integer)fileDate;
			self.corp_ra_dt_last_seen									 := (integer)fileDate;			
			self.corp_key															 := state_fips + '-' + corp2.t2u(l.filing_id);
			self.corp_vendor													 := state_fips;
			self.corp_state_origin										 := state_origin;			
			self.corp_process_date										 := fileDate;
			self.corp_orig_sos_charter_nbr						 := corp2.t2u(l.filing_num);													  						
			self.corp_legal_name											 := Corp2_Mapping.fCleanBusinessName(state_origin,state_desc,l.filing_name).BusinessName;
			self.corp_ln_name_type_cd				 					 := map(corp2.t2u(l.filing_type) =  'TRADEMARK' 	 	=> '03',
																											  corp2.t2u(l.filing_type) =  'TRADE NAME' 		=> '04',
																											  corp2.t2u(l.filing_type) =  'RESERVED NAME' => '07',
																											  corp2.t2u(l.filing_type) <> '' 				 			=> '01',
																											  ''
																											 );
			self.corp_ln_name_type_desc			 					 := map(self.corp_ln_name_type_cd = '01' => 'LEGAL',
																											  self.corp_ln_name_type_cd = '03' => 'TRADEMARK',
																											  self.corp_ln_name_type_cd = '04' => 'TRADENAME',
																											  self.corp_ln_name_type_cd = '07' => 'RESERVED',
																											  ''
																											 );
			//corp_name_comment: remove in phase 2
			self.corp_name_comment								 		 := if(corp2.t2u(l.trademark_keywords)<>'' ,'TRADEMARK KEYWORDS: ' + corp2.t2u(l.trademark_keywords),'');																		 
			self.corp_address1_type_cd						 		 := if(Corp2_Mapping.fAddressExists(state_origin,state_desc,l.principle_addr1,l.principle_addr2+' '+l.principle_addr3,l.principle_city,l.principle_state,l.principle_postal_code,l.principle_country).ifAddressExists, 'B', '');
			self.corp_address1_type_desc					 		 := if(Corp2_Mapping.fAddressExists(state_origin,state_desc,l.principle_addr1,l.principle_addr2+' '+l.principle_addr3,l.principle_city,l.principle_state,l.principle_postal_code,l.principle_country).ifAddressExists, 'BUSINESS', '');
			self.corp_address1_line1									 := Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.principle_addr1,l.principle_addr2+' '+l.principle_addr3,l.principle_city,l.principle_state,l.principle_postal_code,l.principle_country).AddressLine1;
			self.corp_address1_line2				 					 := Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.principle_addr1,l.principle_addr2+' '+l.principle_addr3,l.principle_city,l.principle_state,l.principle_postal_code,l.principle_country).AddressLine2;
			self.corp_address1_line3				 					 := Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.principle_addr1,l.principle_addr2+' '+l.principle_addr3,l.principle_city,l.principle_state,l.principle_postal_code,l.principle_country).AddressLine3;
			self.corp_address2_type_cd			 					 := if(Corp2_Mapping.fAddressExists(state_origin,state_desc,l.mail_addr1,l.mail_addr2+' '+l.mail_addr3,l.mail_city,l.mail_state,l.mail_postal_code,l.mail_country).ifAddressExists, 'M', '');
			self.corp_address2_type_desc		 					 := if(Corp2_Mapping.fAddressExists(state_origin,state_desc,l.mail_addr1,l.mail_addr2+' '+l.mail_addr3,l.mail_city,l.mail_state,l.mail_postal_code,l.mail_country).ifAddressExists, 'MAILING', '');
			self.corp_address2_line1									 := Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.mail_addr1,l.mail_addr2+' '+l.mail_addr3,l.mail_city,l.mail_state,l.mail_postal_code,l.mail_country).AddressLine1;
			self.corp_address2_line2				 					 := Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.mail_addr1,l.mail_addr2+' '+l.mail_addr3,l.mail_city,l.mail_state,l.mail_postal_code,l.mail_country).AddressLine2;
			self.corp_address2_line3				 					 := Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.mail_addr1,l.mail_addr2+' '+l.mail_addr3,l.mail_city,l.mail_state,l.mail_postal_code,l.mail_country).AddressLine3;			
			self.corp_prep_addr1_line1								 := Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.principle_addr1,l.principle_addr2+' '+l.principle_addr3,l.principle_city,l.principle_state,l.principle_postal_code,l.principle_country).PrepAddrLine1;
			self.corp_prep_addr1_last_line						 := Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.principle_addr1,l.principle_addr2+' '+l.principle_addr3,l.principle_city,l.principle_state,l.principle_postal_code,l.principle_country).PrepAddrLastLine;
			self.corp_prep_addr2_line1								 := Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.mail_addr1,l.mail_addr2+' '+l.mail_addr3,l.mail_city,l.mail_state,l.mail_postal_code,l.mail_country).PrepAddrLine1;
			self.corp_prep_addr2_last_line						 := Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.mail_addr1,l.mail_addr2+' '+l.mail_addr3,l.mail_city,l.mail_state,l.mail_postal_code,l.mail_country).PrepAddrLastLine;			
			//corp_filing_date: remove in phase 2
			self.corp_filing_date						 					 := Corp2_Mapping.fValidateDate(l.filing_date,'MM/DD/CCYY').PastDate;
			//corp_filing_desc: remove in phase 2
			self.corp_filing_desc						 					 := if(self.corp_filing_date <> '' , 'FILING', '' );		
			self.corp_status_desc						 					 := corp2.t2u(l.status);
			self.corp_status_date						 					 := Corp2_Mapping.fValidateDate(l.inactive_date,'MM/DD/CCYY').PastDate;
			//corp_standing: remove in phase 2
			self.corp_standing							 					 := map(corp2.t2u(l.STANDING_TAX) = 'GOOD' 		 		=> 'Y',
																											  corp2.t2u(l.STANDING_TAX) = 'DELINQUENT'	=> 'N',
																											  ''
																											);		
			//corp_status_comment: remove in phase 2																											
			self.corp_status_comment      		  			 := if(corp2.t2u(l.standing_other)<>'','STANDING OTHER: '+corp2.t2u(l.standing_other),'');
			self.corp_inc_state							 					 := state_origin;
			self.corp_inc_date							 					 := if(corp2.t2u(l.formation_locale) in [state_origin,state_desc,''],Corp2_Mapping.fValidateDate(l.filing_date,'MM/DD/CCYY').PastDate,'');
			self.corp_term_exist_cd					 					 := map(regexfind('PERPETUAL',corp2.t2u(l.duration_term_type),0) <> ''	=> 'P',
																											  regexfind('EXPIRES -',corp2.t2u(l.duration_term_type),0)	<> ''	=> 'N',			
																											  regexfind('EXPIRES'	,corp2.t2u(l.duration_term_type),0)	<> ''	=> 'D',
																											  ''
																											 );
			self.corp_term_exist_exp									 := Corp2_Raw_WY.Functions.CorpTermExistExp(self.corp_term_exist_cd,l.duration_term_type,l.expiration_date);
			self.corp_term_exist_desc									 := map(self.corp_term_exist_cd = 'D' => 'DATE',
																											  self.corp_term_exist_cd = 'P' => 'PERPETUAL',
																											  self.corp_term_exist_cd = 'N' => 'NUMBER OF YEARS',																											 
																											  'UNKNOWN'
																											 );																											
			self.corp_foreign_domestic_ind 	 					 := map(corp2.t2u(l.domestic_yn) = 'Y' => 'D',
																											  corp2.t2u(l.domestic_yn) = 'N' => 'F',
																											  ''
																											);
			self.corp_forgn_state_cd				 					 := if(corp2.t2u(l.formation_locale) not in [state_origin,state_desc,''],Corp2_Raw_WY.Functions.CorpForgnStateCD(l.formation_locale),'');
			self.corp_forgn_state_desc			 					 := if(corp2.t2u(l.formation_locale) not in [state_origin,state_desc,''],Corp2_Raw_WY.Functions.CorpForgnStateDesc(l.formation_locale),'');	
			self.corp_forgn_date						 					 := if(corp2.t2u(l.formation_locale) not in [state_origin,state_desc,''],Corp2_Mapping.fValidateDate(l.filing_date,'MM/DD/CCYY').PastDate,'');		
			self.corp_orig_org_structure_desc					 := map(corp2.t2u(l.filing_type)='RESERVED NAME'	=>'',
																											  corp2.t2u(l.filing_type)='TRADE NAME'		=>'',
																											  corp2.t2u(l.filing_type)='TRADEMARK'			=>'',																					
																											  corp2.t2u(l.filing_type + ' ' + l.filing_subtype)
																											 );
			self.corp_for_profit_ind									 := map(corp2.t2u(l.filing_type) =  'NONPROFIT CORPORATION'									=> 'N',
																											  corp2.t2u(l.filing_type) =  'NONPROFIT CORPORATION RELIGIOUS' 			=> 'N',
																											  corp2.t2u(l.filing_type) =  'NONPROFIT CORPORATION PUBLIC BENEFIT' 	=> 'N',
																											  corp2.t2u(l.filing_type) =  'UNINCORPORATED NON-PROFIT' 						=> 'N',
																											  corp2.t2u(l.filing_type) =  'PROFIT CORPORATION'	 									=> 'Y',
																											  corp2.t2u(l.filing_type) =  'PROFIT CORPORATION CLOSE CORPORATION'	=> 'Y',
																											  ''
																											);
			self.corp_orig_bus_type_desc							 := corp2.t2u(l.purpose+' '+l.applicant_type);
			self.corp_ra_full_name										 := if(corp2.t2u(l.norm_name)  not in ['','NO AGENT','SAME'],Corp2_Mapping.fCleanBusinessName(state_origin,state_desc,l.norm_name).BusinessName,'');
			self.corp_ra_fname 												 := if(corp2.t2u(l.norm_fname) not in ['','NO AGENT','SAME'],Corp2_Mapping.fCleanPersonName(state_origin,state_desc,l.norm_fname,l.norm_mname,l.norm_lname).FirstName,'');
			self.corp_ra_mname 												 := if(corp2.t2u(l.norm_mname) not in ['','NO AGENT','SAME'],Corp2_Mapping.fCleanPersonName(state_origin,state_desc,l.norm_fname,l.norm_mname,l.norm_lname).MiddleName,'');
			self.corp_ra_lname 												 := if(corp2.t2u(l.norm_lname) not in ['','NO AGENT','SAME'],Corp2_Mapping.fCleanPersonName(state_origin,state_desc,l.norm_fname,l.norm_mname,l.norm_lname).LastName,'');
			//corp_ra_resign_date: remove in phase 2																											
			self.corp_ra_resign_date									 := Corp2_Mapping.fValidateDate(l.ra_resign_cert_letter_date,'MM/DD/CCYY').PastDate;
			self.corp_ra_addl_info        						 := Corp2_Raw_WY.Functions.CorpRAAddlInfo(l.county,l.standing_ra,l.org_name);
			self.corp_ra_address_type_cd			 				 := if(Corp2_Mapping.fAddressExists(state_origin,state_desc,l.addr1,l.addr2+' '+l.addr3,l.city,l.state,l.postal_code).ifAddressExists,'R','');
			self.corp_ra_address_type_desc		 				 := if(Corp2_Mapping.fAddressExists(state_origin,state_desc,l.addr1,l.addr2+' '+l.addr3,l.city,l.state,l.postal_code).ifAddressExists,'REGISTERED OFFICE','');
			self.corp_ra_address_line1								 := Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.addr1,l.addr2+' '+l.addr3,l.city,l.state,l.postal_code,l.country).AddressLine1;
			self.corp_ra_address_line2				 				 := Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.addr1,l.addr2+' '+l.addr3,l.city,l.state,l.postal_code,l.country).AddressLine2;
			self.corp_ra_address_line3				 				 := Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.addr1,l.addr2+' '+l.addr3,l.city,l.state,l.postal_code,l.country).AddressLine3;
			self.ra_prep_addr_line1						 				 := Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.addr1,l.addr2+' '+l.addr3,l.city,l.state,l.postal_code,l.country).PrepAddrLine1;
			self.ra_prep_addr_last_line				 				 := Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.addr1,l.addr2+' '+l.addr3,l.city,l.state,l.postal_code,l.country).PrepAddrLastLine;			
			self.corp_agent_country										 := Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.addr1,l.addr2+' '+l.addr3,l.city,l.state,l.postal_code,l.country).Country;
			self.corp_agent_county										 := corp2.t2u(l.county);
			self.corp_agent_status_desc								 := if(corp2.t2u(l.standing_ra)<>'','RA STANDING: ' + corp2.t2u(l.standing_ra),'');
			self.corp_name_reservation_expiration_date := if(corp2.t2u(l.filing_type)='RESERVED NAME',Corp2_Mapping.fValidateDate(l.expiration_date,'MM/DD/CCYY').GeneralDate,'');
			self.corp_name_status_desc								 := if(corp2.t2u(l.filing_type)='TRADE NAME' and Corp2_Mapping.fValidateDate(l.expiration_date,'MM/DD/CCYY').GeneralDate<>'',
																											 'TRADE NAME EXPIRATION DATE: ' + Corp2_Mapping.fValidateDate(l.expiration_date,'MM/DD/CCYY').GeneralDate,
																											 ''
																											 );
			self.corp_purpose													 := corp2.t2u(l.purpose+' '+l.applicant_type);
			self.corp_standing_other									 := corp2.t2u(l.standing_other);
			self.corp_tax_standing										 := corp2.t2u(l.standing_tax);
			self.corp_trademark_expiration_date				 := if(corp2.t2u(l.filing_type)='TRADEMARK',
																											 map(Corp2_Mapping.fValidateDate(l.expiration_date,'MM/DD/CCYY').GeneralDate<>'' 	=> Corp2_Mapping.fValidateDate(l.expiration_date,'MM/DD/CCYY').GeneralDate,
																													 Corp2_Mapping.fValidateDate(l.inactive_date,'MM/DD/CCYY').GeneralDate<>'' 		=> Corp2_Mapping.fValidateDate(l.inactive_date,'MM/DD/CCYY').GeneralDate,
																													 ''
																													),
																										''
																										);
			self.corp_trademark_keywords							 := corp2.t2u(l.trademark_keywords);
			self.recordorigin													 := 'C';
			self																			 := [];
		end;
		
		FilingMainCorp      := project(CorporationFile, FilingMainCorpTransform(left)) : independent;
																			
		//********************************************************************
		//Main file mapping from the Filing file where "old_names" exists.
		//********************************************************************
		Corp2_Mapping.LayoutsCommon.Main FilingOldNameTransform(Corp2_Raw_WY.Layouts.FilingLayoutIn l):= transform,
		skip(corp2.t2u(l.old_name) = '')
			self.dt_vendor_first_reported							 := (integer)fileDate;
			self.dt_vendor_last_reported							 := (integer)fileDate;
			self.dt_first_seen												 := (integer)fileDate;
			self.dt_last_seen													 := (integer)fileDate;
			self.corp_ra_dt_first_seen								 := (integer)fileDate;
			self.corp_ra_dt_last_seen									 := (integer)fileDate;			
			self.corp_key															 := state_fips + '-' + corp2.t2u(l.filing_id);
			self.corp_vendor													 := state_fips;
			self.corp_state_origin										 := state_origin;			
			self.corp_process_date										 := fileDate;		
			self.corp_orig_sos_charter_nbr						 := corp2.t2u(l.filing_num);
			self.corp_legal_name											 := Corp2_Mapping.fCleanBusinessName(state_origin,state_desc,l.old_name).BusinessName;
			self.corp_ln_name_type_cd									 := 'P';
			self.corp_ln_name_type_desc								 := 'PRIOR';
			self.corp_inc_state							 					 := state_origin;
			self.recordorigin													 := 'C';			
			self																			 := [];
		end;

		MapFilingOldName	:= project(Filing, FilingOldNameTransform(left));
		
		//********************************************************************
		//Main file mapping from the PartyFile as Corporation.
		//********************************************************************
		Corp2_Mapping.LayoutsCommon.Main PartyCorpTransform(Corp2_Raw_WY.Layouts.TempFilingWithParty  l):= transform
			self.dt_vendor_first_reported							:= (integer)fileDate;
			self.dt_vendor_last_reported							:= (integer)fileDate;
			self.dt_first_seen												:= (integer)fileDate;
			self.dt_last_seen													:= (integer)fileDate;
			self.corp_ra_dt_first_seen								:= (integer)fileDate;
			self.corp_ra_dt_last_seen									:= (integer)fileDate;			
			self.corp_key															:= state_fips + '-' + corp2.t2u(l.filing_id);
			self.corp_vendor													:= state_fips;
			self.corp_state_origin										:= state_origin;			
			self.corp_process_date										:= fileDate;
			self.corp_orig_sos_charter_nbr						:= corp2.t2u(l.filing_num);													  						
			self.corp_legal_name											:= Corp2_Mapping.fCleanBusinessName(state_origin,state_desc,l.filing_name).BusinessName;
			self.corp_ln_name_type_cd				 					:= map(corp2.t2u(l.filing_type) =  'TRADEMARK' 		 => '03',
																											 corp2.t2u(l.filing_type) =  'TRADE NAME' 	 => '04',
																											 corp2.t2u(l.filing_type) =  'RESERVED NAME' => '07',
																											 corp2.t2u(l.filing_type) <> '' 				 		 => '01',
																											 ''
																											);
			self.corp_ln_name_type_desc			 					:= map(self.corp_ln_name_type_cd = '01' => 'LEGAL',
																											 self.corp_ln_name_type_cd = '03' => 'TRADEMARK',
																											 self.corp_ln_name_type_cd = '04' => 'TRADENAME',
																											 self.corp_ln_name_type_cd = '07' => 'RESERVED',
																											 ''
																											);
			//corp_name_comment: remove in phase 2																											
			self.corp_name_comment								 		:= if(corp2.t2u(l.trademark_keywords)<>'' ,'TRADEMARK KEYWORDS: ' + corp2.t2u(l.trademark_keywords),'');																		 
			self.corp_address1_type_cd						 		:= if(Corp2_Mapping.fAddressExists(state_origin,state_desc,l.principle_addr1,l.principle_addr2+' '+l.principle_addr3,l.principle_city,l.principle_state,l.principle_postal_code,l.principle_country).ifAddressExists, 'B', '');
			self.corp_address1_type_desc					 		:= if(Corp2_Mapping.fAddressExists(state_origin,state_desc,l.principle_addr1,l.principle_addr2+' '+l.principle_addr3,l.principle_city,l.principle_state,l.principle_postal_code,l.principle_country).ifAddressExists, 'BUSINESS', '');
			self.corp_address1_line1									:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.principle_addr1,l.principle_addr2+' '+l.principle_addr3,l.principle_city,l.principle_state,l.principle_postal_code,l.principle_country).AddressLine1;
			self.corp_address1_line2				 					:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.principle_addr1,l.principle_addr2+' '+l.principle_addr3,l.principle_city,l.principle_state,l.principle_postal_code,l.principle_country).AddressLine2;
			self.corp_address1_line3				 					:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.principle_addr1,l.principle_addr2+' '+l.principle_addr3,l.principle_city,l.principle_state,l.principle_postal_code,l.principle_country).AddressLine3;
			self.corp_address2_type_cd			 					:= if(Corp2_Mapping.fAddressExists(state_origin,state_desc,l.mail_addr1,l.mail_addr2+' '+l.mail_addr3,l.mail_city,l.mail_state,l.mail_postal_code,l.mail_country).ifAddressExists, 'M', '');
			self.corp_address2_type_desc		 					:= if(Corp2_Mapping.fAddressExists(state_origin,state_desc,l.mail_addr1,l.mail_addr2+' '+l.mail_addr3,l.mail_city,l.mail_state,l.mail_postal_code,l.mail_country).ifAddressExists, 'MAILING', '');
			self.corp_address2_line1									:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.mail_addr1,l.mail_addr2+' '+l.mail_addr3,l.mail_city,l.mail_state,l.mail_postal_code,l.mail_country).AddressLine1;
			self.corp_address2_line2				 					:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.mail_addr1,l.mail_addr2+' '+l.mail_addr3,l.mail_city,l.mail_state,l.mail_postal_code,l.mail_country).AddressLine2;
			self.corp_address2_line3				 					:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.mail_addr1,l.mail_addr2+' '+l.mail_addr3,l.mail_city,l.mail_state,l.mail_postal_code,l.mail_country).AddressLine3;			
			//corp_filing_date: remove in phase 2
			self.corp_filing_date						 					:= Corp2_Mapping.fValidateDate(l.filing_date,'MM/DD/CCYY').PastDate;
			//corp_filing_desc: remove in phase 2
			self.corp_filing_desc						 					:= if(self.corp_filing_date <> '' , 'FILING', '' );		
			self.corp_status_desc						 					:= corp2.t2u(l.status);
			self.corp_status_date						 					:= Corp2_Mapping.fValidateDate(l.inactive_date,'MM/DD/CCYY').PastDate;
			//corp_standing: remove in phase 2
			self.corp_standing							 					:= map(corp2.t2u(l.STANDING_TAX) = 'GOOD' 		 	=> 'Y',
																											 corp2.t2u(l.STANDING_TAX) = 'DELINQUENT'	=> 'N',
																											 ''
																											);		
			self.corp_status_comment      		  			:= if(corp2.t2u(l.standing_other)<>'','STANDING OTHER: '+corp2.t2u(l.standing_other),'');
			self.corp_inc_state							 					:= state_origin;
			self.corp_inc_date							 					:= if(corp2.t2u(l.formation_locale) in [state_desc,''],Corp2_Mapping.fValidateDate(l.filing_date,'MM/DD/CCYY').PastDate,'');
			self.corp_term_exist_cd					 					:= map(regexfind('PERPETUAL',corp2.t2u(l.duration_term_type),0) <> ''	=> 'P',
																											 regexfind('EXPIRES -',corp2.t2u(l.duration_term_type),0)	<> ''	=> 'N',			
																											 regexfind('EXPIRES'	,corp2.t2u(l.duration_term_type),0)	<> ''	=> 'D',
																											 ''
																											);
			self.corp_term_exist_exp									:= Corp2_Raw_WY.Functions.CorpTermExistExp(self.corp_term_exist_cd,l.duration_term_type,l.expiration_date);
			self.corp_term_exist_desc									:= map(self.corp_term_exist_cd = 'D' => 'DATE',
																											 self.corp_term_exist_cd = 'P' => 'PERPETUAL',
																											 self.corp_term_exist_cd = 'N' => 'NUMBER OF YEARS',																											 
																											 'UNKNOWN'
																											 );																											
			self.corp_foreign_domestic_ind 	 					:= map(corp2.t2u(l.domestic_yn) = 'Y' => 'D',
																											 corp2.t2u(l.domestic_yn) = 'N' => 'F',
																											 ''
																											);
			self.corp_forgn_state_cd				 					:= if(corp2.t2u(l.formation_locale) not in [state_desc,''],Corp2_Raw_WY.Functions.CorpForgnStateCD(l.formation_locale),'');
			self.corp_forgn_state_desc			 					:= if(corp2.t2u(l.formation_locale) not in [state_desc,''],Corp2_Raw_WY.Functions.CorpForgnStateDesc(l.formation_locale),'');	
			self.corp_forgn_date						 					:= if(corp2.t2u(l.formation_locale) not in [state_desc,''],Corp2_Mapping.fValidateDate(l.filing_date,'MM/DD/CCYY').PastDate,'');		
			self.corp_orig_org_structure_desc					:= map(corp2.t2u(l.filing_type)='RESERVED NAME'	=>'',
																											 corp2.t2u(l.filing_type)='TRADE NAME'		=>'',
																											 corp2.t2u(l.filing_type)='TRADEMARK'			=>'',																					
																											 corp2.t2u(l.filing_type + ' ' + l.filing_subtype)
																											);
			self.corp_for_profit_ind									:= map(
																											 corp2.t2u(l.filing_type) =  'NONPROFIT CORPORATION'									=> 'N',
																											 corp2.t2u(l.filing_type) =  'NONPROFIT CORPORATION RELIGIOUS' 				=> 'N',
																											 corp2.t2u(l.filing_type) =  'NONPROFIT CORPORATION PUBLIC BENEFIT' 	=> 'N',
																											 corp2.t2u(l.filing_type) =  'UNINCORPORATED NON-PROFIT' 							=> 'N',
																											 corp2.t2u(l.filing_type) =  'PROFIT CORPORATION'	 										=> 'Y',
																											 corp2.t2u(l.filing_type) =  'PROFIT CORPORATION CLOSE CORPORATION'		=> 'Y',
																											 ''
																											);
			self.corp_orig_bus_type_desc						   := corp2.t2u(l.purpose+' '+l.applicant_type);
			self.corp_prep_addr1_line1								 := Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.principle_addr1,l.principle_addr2+' '+l.principle_addr3,l.principle_city,l.principle_state,l.principle_postal_code,l.principle_country).PrepAddrLine1;
			self.corp_prep_addr1_last_line						 := Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.principle_addr1,l.principle_addr2+' '+l.principle_addr3,l.principle_city,l.principle_state,l.principle_postal_code,l.principle_country).PrepAddrLastLine;		
			self.corp_prep_addr2_line1								 := Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.mail_addr1,l.mail_addr2+' '+l.mail_addr3,l.mail_city,l.mail_state,l.mail_postal_code,l.mail_country).PrepAddrLine1;
			self.corp_prep_addr2_last_line						 := Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.mail_addr1,l.mail_addr2+' '+l.mail_addr3,l.mail_city,l.mail_state,l.mail_postal_code,l.mail_country).PrepAddrLastLine;			
			self.corp_name_reservation_expiration_date := if(corp2.t2u(l.filing_type)='RESERVED NAME',Corp2_Mapping.fValidateDate(l.expiration_date,'MM/DD/CCYY').GeneralDate,'');
			self.corp_name_status_desc								 := if(corp2.t2u(l.filing_type)='TRADE NAME' and Corp2_Mapping.fValidateDate(l.expiration_date,'MM/DD/CCYY').GeneralDate<>'',
																											 'TRADE NAME EXPIRATION DATE: ' + Corp2_Mapping.fValidateDate(l.expiration_date,'MM/DD/CCYY').GeneralDate,
																											 ''
																											 );
			self.corp_purpose													 := corp2.t2u(l.purpose+' '+l.applicant_type);
			self.corp_standing_other									 := corp2.t2u(l.standing_other);
			self.corp_tax_standing										 := corp2.t2u(l.standing_tax);
			self.corp_trademark_expiration_date				 := if(corp2.t2u(l.filing_type)='TRADEMARK',
																											 map(Corp2_Mapping.fValidateDate(l.expiration_date,'MM/DD/CCYY').GeneralDate<>'' 	=> Corp2_Mapping.fValidateDate(l.expiration_date,'MM/DD/CCYY').GeneralDate,
																													 Corp2_Mapping.fValidateDate(l.inactive_date,'MM/DD/CCYY').GeneralDate<>'' 		=> Corp2_Mapping.fValidateDate(l.inactive_date,'MM/DD/CCYY').GeneralDate,
																													 ''
																													),
																										''
																										);
			self.corp_trademark_keywords							 := corp2.t2u(l.trademark_keywords);
			self.recordorigin													 := 'C';
			self																			 := [];
		end;

		MapPartyCorp			:= project(PartyFile, PartyCorpTransform(left)) : independent;

		//********************************************************************
		//Main file mapping from the PartyFile as Contacts.
		//********************************************************************		
		Corp2_Mapping.LayoutsCommon.Main PartyContTransform(Corp2_Raw_WY.Layouts.TempFilingWithParty  l):= transform
			self.dt_vendor_first_reported							 := (integer)fileDate;
			self.dt_vendor_last_reported							 := (integer)fileDate;
			self.dt_first_seen												 := (integer)fileDate;
			self.dt_last_seen													 := (integer)fileDate;
			self.corp_ra_dt_first_seen								 := (integer)fileDate;
			self.corp_ra_dt_last_seen									 := (integer)fileDate;			
			self.corp_key															 := state_fips + '-' + corp2.t2u(l.filing_id);
			self.corp_vendor													 := state_fips;
			self.corp_state_origin										 := state_origin;			
			self.corp_process_date										 := fileDate;
			self.corp_orig_sos_charter_nbr						 := corp2.t2u(l.filing_num);													  						
			self.corp_legal_name											 := Corp2_Mapping.fCleanBusinessName(state_origin,state_desc,l.filing_name).BusinessName;
			self.corp_ln_name_type_cd				 					 := map(corp2.t2u(l.filing_type) =  'TRADEMARK' 	 => '03',
																											  corp2.t2u(l.filing_type) =  'TRADE NAME' 	 => '04',
																											  corp2.t2u(l.filing_type) =  'RESERVED NAME'=> '07',
																											  corp2.t2u(l.filing_type) <> '' 				 		 => '01',
																											  ''
																											 );
			self.corp_ln_name_type_desc			 					 := map(self.corp_ln_name_type_cd = '01' => 'LEGAL',
																											  self.corp_ln_name_type_cd = '03' => 'TRADEMARK',
																											  self.corp_ln_name_type_cd = '04' => 'TRADENAME',
																											  self.corp_ln_name_type_cd = '07' => 'RESERVED',
																											  ''
																											 );													  						
			self.corp_inc_state							 					 := state_origin;
			self.cont_filing_desc											 := corp2.t2u(l.source_type);
			self.cont_full_name												 := Corp2_Raw_WY.Functions.ContFullName(state_origin,state_desc,l.norm_name);	
			self.cont_fname     											 := Corp2_Mapping.fCleanPersonName(state_origin,state_desc,l.norm_fname,l.norm_mname,l.norm_lname).FirstName;
			self.cont_mname     											 := Corp2_Mapping.fCleanPersonName(state_origin,state_desc,l.norm_fname,l.norm_mname,l.norm_lname).MiddleName;
			self.cont_lname     											 := Corp2_Mapping.fCleanPersonName(state_origin,state_desc,l.norm_fname,l.norm_mname,l.norm_lname).LastName;
			self.cont_title1_desc											 := if(corp2.t2u(self.cont_full_name)<>'',corp2.t2u(l.party_type),'');		
			self.cont_address_line1										 := Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.addr1,l.addr2+' '+l.addr3,l.city,l.state,l.postal_code,l.country).AddressLine1;
			self.cont_address_line2										 := Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.addr1,l.addr2+' '+l.addr3,l.city,l.state,l.postal_code,l.country).AddressLine2;
			self.cont_address_line3										 := Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.addr1,l.addr2+' '+l.addr3,l.city,l.state,l.postal_code,l.country).AddressLine3;
			self.cont_prep_addr_line1									 := Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.addr1,l.addr2+' '+l.addr3,l.city,l.state,l.postal_code,l.country).PrepAddrLine1;
			self.cont_prep_addr_last_line							 := Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.addr1,l.addr2+' '+l.addr3,l.city,l.state,l.postal_code,l.country).PrepAddrLastLine;
			self.cont_address_county									 := corp2.t2u(l.county);
			self.cont_country													 := Corp2_Raw_WY.Functions.CountryDescriptionTranslation(Corp2_Mapping.fCleanAddress(state_origin,state_desc,,,,,,l.country).Country);
			self.recordorigin													 := 'T';			
			self																			 := [];
		end;

		PartyContact		 			:= project(PartyFile, PartyContTransform(left)) : independent;

		//Remove any record that doesn't have a contact name even if an address exists
		MapPartyContact 		 	:= PartyContact(corp2.t2u(cont_full_name+cont_fname + cont_mname + cont_lname)<>''); 

		MainAll 							:= distribute(FilingMainCorp + MapPartyCorp + MapFilingOldName + MapPartyContact,hash(corp_key)) : independent;
		
		MappedCorporations		:= MainAll(recordorigin = 'C');
		MappedContacts				:= MainAll(recordorigin = 'T');

		HasRA							 		:= MappedCorporations(corp2.t2u(corp_ra_full_name+corp_ra_fname+corp_ra_mname+corp_ra_lname+
																												  corp_ra_resign_date+corp_ra_addl_info+corp_ra_address_type_cd+corp_ra_address_type_desc+
																												  corp_ra_address_line1+corp_ra_address_line2+corp_ra_address_line3+corp_agent_country+
																												  corp_agent_county+corp_agent_status_desc
																												 )<>''
																							 );

		HasNoRA						 		:= MappedCorporations(corp2.t2u(corp_ra_full_name+corp_ra_fname+corp_ra_mname+corp_ra_lname+
																												  corp_ra_resign_date+corp_ra_addl_info+corp_ra_address_type_cd+corp_ra_address_type_desc+
																												  corp_ra_address_line1+corp_ra_address_line2+corp_ra_address_line3+corp_agent_country+
																												  corp_agent_county+corp_agent_status_desc
																												 )=''
																							 );
		//This join places the corporation record and the ra record (that can exist in two different records
		//into one record.
	  MapRA2Corporation														:= join(HasNoRA,HasRA,
																												left.corp_key 				= right.corp_key and
																												left.corp_filing_date = right.corp_filing_date,
																												transform(Corp2_Mapping.LayoutsCommon.Main,
																																	self.dt_vendor_first_reported							:= if(left.dt_vendor_first_reported<>0,left.dt_vendor_first_reported,right.dt_vendor_first_reported);
																																	self.dt_vendor_last_reported							:= if(left.dt_vendor_last_reported<>0,left.dt_vendor_last_reported,right.dt_vendor_last_reported);
																																	self.dt_first_seen												:= if(left.dt_first_seen<>0,left.dt_first_seen,right.dt_first_seen);
																																	self.dt_last_seen													:= if(left.dt_last_seen<>0,left.dt_last_seen,right.dt_last_seen);
																																	self.corp_ra_dt_first_seen								:= if(left.corp_ra_dt_first_seen<>0,left.corp_ra_dt_first_seen,right.corp_ra_dt_first_seen);
																																	self.corp_ra_dt_last_seen									:= if(left.corp_ra_dt_last_seen<>0,left.corp_ra_dt_last_seen,right.corp_ra_dt_last_seen);
																																	self.corp_key															:= if(left.corp_key<>'',left.corp_key,right.corp_key);
																																	self.corp_vendor													:= if(left.corp_vendor<>'',left.corp_vendor,right.corp_vendor);
																																	self.corp_state_origin										:= if(left.corp_state_origin<>'',left.corp_state_origin,right.corp_state_origin);
																																	self.corp_process_date										:= if(left.corp_process_date<>'',left.corp_process_date,right.corp_process_date);
																																	self.corp_orig_sos_charter_nbr        		:= if(left.corp_orig_sos_charter_nbr<>'',left.corp_orig_sos_charter_nbr,right.corp_orig_sos_charter_nbr);
																																	self.corp_legal_name 											:= if(left.corp_legal_name<>'',left.corp_legal_name,right.corp_legal_name);
																																	self.corp_ln_name_type_cd 								:= if(left.corp_ln_name_type_cd<>'',left.corp_ln_name_type_cd,right.corp_ln_name_type_cd);
																																	self.corp_ln_name_type_desc 							:= if(left.corp_ln_name_type_desc<>'',left.corp_ln_name_type_desc,right.corp_ln_name_type_desc);
																																	self.corp_name_comment 										:= if(left.corp_name_comment<>'',left.corp_name_comment,right.corp_name_comment);
																																	self.corp_address1_type_cd 								:= if(left.corp_address1_type_cd<>'',left.corp_address1_type_cd,right.corp_address1_type_cd);
																																	self.corp_address1_type_desc 							:= if(left.corp_address1_type_desc<>'',left.corp_address1_type_desc,right.corp_address1_type_desc);
																																	self.corp_address1_line1 									:= if(left.corp_address1_line1<>'',left.corp_address1_line1,right.corp_address1_line1);
																																	self.corp_address1_line2 									:= if(left.corp_address1_line2<>'',left.corp_address1_line2,right.corp_address1_line2);
																																	self.corp_address1_line3 									:= if(left.corp_address1_line3<>'',left.corp_address1_line3,right.corp_address1_line3);
																																	self.corp_address2_type_cd 								:= if(left.corp_address2_type_cd<>'',left.corp_address2_type_cd,right.corp_address2_type_cd);
																																	self.corp_address2_type_desc 							:= if(left.corp_address2_type_desc<>'',left.corp_address2_type_desc,right.corp_address2_type_desc);
																																	self.corp_address2_line1 									:= if(left.corp_address2_line1<>'',left.corp_address2_line1,right.corp_address2_line1);
																																	self.corp_address2_line2 									:= if(left.corp_address2_line2<>'',left.corp_address2_line2,right.corp_address2_line2);
																																	self.corp_address2_line3 									:= if(left.corp_address2_line3<>'',left.corp_address2_line3,right.corp_address2_line3);																																		
																																	self.corp_filing_reference_nbr 						:= if(left.corp_filing_reference_nbr<>'',left.corp_filing_reference_nbr,right.corp_filing_reference_nbr);
																																	self.corp_filing_date 										:= if(left.corp_filing_date<>'',left.corp_filing_date,right.corp_filing_date);
																																	self.corp_filing_desc 										:= if(left.corp_filing_desc<>'',left.corp_filing_desc,right.corp_filing_desc);
																																	self.corp_status_desc 										:= if(left.corp_status_desc<>'',left.corp_status_desc,right.corp_status_desc);
																																	self.corp_status_date 										:= if(left.corp_status_date<>'',left.corp_status_date,right.corp_status_date);
																																	self.corp_standing 												:= if(left.corp_standing<>'',left.corp_standing,right.corp_standing);
																																	self.corp_status_comment									:= if(left.corp_status_comment<>'',left.corp_status_comment,right.corp_status_comment);
																																	self.corp_inc_state												:= if(left.corp_inc_state<>'',left.corp_inc_state,right.corp_inc_state);
																																	self.corp_inc_county 											:= if(left.corp_inc_county<>'',left.corp_inc_county,right.corp_inc_county);
																																	self.corp_inc_date 												:= if(left.corp_inc_date<>'',left.corp_inc_date,right.corp_inc_date);
																																	self.corp_term_exist_cd 									:= if(left.corp_term_exist_cd<>'',left. corp_term_exist_cd ,right.corp_term_exist_cd);
																																	self.corp_term_exist_exp 									:= if(left.corp_term_exist_exp<>'',left.corp_term_exist_exp,right.corp_term_exist_exp);
																																	self.corp_term_exist_desc									:= if(left.corp_term_exist_desc<>'',left. corp_term_exist_desc ,right.corp_term_exist_desc);
																																	self.corp_foreign_domestic_ind 						:= if(left.corp_foreign_domestic_ind<>'',left.corp_foreign_domestic_ind,right.corp_foreign_domestic_ind);
																																	self.corp_forgn_state_cd 									:= if(left.corp_forgn_state_cd<>'',left.corp_forgn_state_cd,right.corp_forgn_state_cd);
																																	self.corp_forgn_state_desc 								:= if(left.corp_forgn_state_desc<>'',left.corp_forgn_state_desc,right.corp_forgn_state_desc);
																																	self.corp_forgn_date 											:= if(left.corp_forgn_date<>'',left.corp_forgn_date,right.corp_forgn_date);
																																	self.corp_orig_org_structure_desc 				:= if(left.corp_orig_org_structure_desc<>'',left.corp_orig_org_structure_desc,right.corp_orig_org_structure_desc);
																																	self.corp_for_profit_ind 									:= if(left.corp_for_profit_ind<>'',left.corp_for_profit_ind,right.corp_for_profit_ind);
																																	self.corp_orig_bus_type_desc 							:= if(left.corp_orig_bus_type_desc<>'',left.corp_orig_bus_type_desc,right.corp_orig_bus_type_desc);
																																	self.corp_ra_full_name 										:= if(left.corp_ra_full_name<>'',left.corp_ra_full_name,right.corp_ra_full_name);
																																	self.corp_ra_fname												:= if(left.corp_ra_fname<>'',left.corp_ra_fname,right.corp_ra_fname);
																																	self.corp_ra_mname												:= if(left.corp_ra_mname<>'',left.corp_ra_mname,right.corp_ra_mname);
																																	self.corp_ra_lname												:= if(left.corp_ra_lname<>'',left.corp_ra_lname,right.corp_ra_lname);
																																	self.corp_ra_resign_date 									:= if(left.corp_ra_resign_date<>'',left.corp_ra_resign_date,right.corp_ra_resign_date);
																																	self.corp_ra_addl_info 										:= if(left.corp_ra_addl_info<>'',left.corp_ra_addl_info,right.corp_ra_addl_info);
																																	self.corp_ra_address_type_cd							:= if(left.corp_ra_address_type_cd<>'',left.corp_ra_address_type_cd,right.corp_ra_address_type_cd);
																																	self.corp_ra_address_type_desc						:= if(left.corp_ra_address_type_desc<>'',left.corp_ra_address_type_desc,right.corp_ra_address_type_desc);
																																	self.corp_ra_address_line1								:= if(left.corp_ra_address_line1<>'',left.corp_ra_address_line1,right.corp_ra_address_line1);
																																	self.corp_ra_address_line2								:= if(left.corp_ra_address_line2<>'',left.corp_ra_address_line2,right.corp_ra_address_line2);
																																	self.corp_ra_address_line3								:= if(left.corp_ra_address_line3<>'',left.corp_ra_address_line3,right.corp_ra_address_line3);
																																	self.corp_prep_addr1_line1 								:= if(left.corp_prep_addr1_line1<>'',left.corp_prep_addr1_line1,right.corp_prep_addr1_line1);
																																	self.corp_prep_addr1_last_line 						:= if(left.corp_prep_addr1_last_line<>'',left.corp_prep_addr1_last_line,right.corp_prep_addr1_last_line);
																																	self.corp_prep_addr2_line1 								:= if(left.corp_prep_addr2_line1<>'',left.corp_prep_addr2_line1,right.corp_prep_addr2_line1);
																																	self.corp_prep_addr2_last_line 						:= if(left.corp_prep_addr2_last_line<>'',left.corp_prep_addr2_last_line,right.corp_prep_addr2_last_line);
																																	self.ra_prep_addr_line1										:= if(left.ra_prep_addr_line1<>'',left.ra_prep_addr_line1,right.ra_prep_addr_line1);																																	
																																	self.ra_prep_addr_last_line								:= if(left.ra_prep_addr_last_line<>'',left.ra_prep_addr_last_line,right.ra_prep_addr_last_line);
																																	self.corp_agent_country										:= if(left.corp_agent_country<>'',left.corp_agent_country,right.corp_agent_country);
																																	self.corp_agent_county						 				:= if(left.corp_agent_county<>'',left.corp_agent_county,right.corp_agent_county);
																																	self.corp_agent_status_desc								:= if(left.corp_agent_status_desc<>'',left.corp_agent_status_desc,right.corp_agent_status_desc);
																																	self.corp_name_reservation_expiration_date:= if(left.corp_name_reservation_expiration_date<>'',left.corp_name_reservation_expiration_date,right.corp_name_reservation_expiration_date);
																																	self.corp_name_status_desc								:= if(left.corp_name_status_desc<>'',left.corp_name_status_desc,right.corp_name_status_desc);
																																	self.corp_purpose													:= if(left.corp_purpose<>'',left.corp_purpose,right.corp_purpose);
																																	self.corp_standing_other						 			:= if(left.corp_standing_other<>'',left.corp_standing_other,right.corp_standing_other);
																																	self.corp_tax_standing						 				:= if(left.corp_tax_standing<>'',left.corp_tax_standing,right.corp_tax_standing);
																																	self.corp_trademark_expiration_date				:= if(left.corp_trademark_expiration_date<>'',left.corp_trademark_expiration_date,right.corp_trademark_expiration_date);
																																	self.corp_trademark_keywords						 	:= if(left.corp_trademark_keywords<>'',left.corp_trademark_keywords,right.corp_trademark_keywords);
																																	self.cont_filing_desc											:= if(left.cont_filing_desc<>'',left.cont_filing_desc,right.cont_filing_desc); 
																																	self.cont_full_name												:= if(left.cont_full_name<>'',left.cont_full_name,right.cont_full_name); 
																																	self.cont_fname														:= if(left.cont_fname<>'',left.cont_fname,right.cont_fname); 
																																	self.cont_mname														:= if(left.cont_mname<>'',left.cont_mname,right.cont_mname); 
																																	self.cont_lname														:= if(left.cont_lname<>'',left.cont_lname,right.cont_lname); 
																																	self.cont_title1_desc											:= if(left.cont_title1_desc<>'',left.cont_title1_desc,right.cont_title1_desc); 
																																	self.cont_address_line1										:= if(left.cont_address_line1<>'',left.cont_address_line1,right.cont_address_line1); 
																																	self.cont_address_line2										:= if(left.cont_address_line2<>'',left.cont_address_line2,right.cont_address_line2); 
																																	self.cont_address_line3										:= if(left.cont_address_line3<>'',left.cont_address_line3,right.cont_address_line3); 
																																	self.cont_address_county									:= if(left.cont_address_county<>'',left.cont_address_county,right.cont_address_county); 
																																	self.cont_country													:= if(left.cont_country<>'',left.cont_country,right.cont_country); 
																																	self.cont_prep_addr_line1									:= if(left.cont_prep_addr_line1<>'',left.cont_prep_addr_line1,right.cont_prep_addr_line1); 
																																	self.cont_prep_addr_last_line						 	:= if(left.cont_prep_addr_last_line<>'',left.cont_prep_addr_last_line,right.cont_prep_addr_last_line); 
																																	self.recordorigin													:= if(left.recordorigin<>'',left.recordorigin,right.recordorigin);
																																	self																			:= left;
																																 ),																																	 
																												full outer,
																												local
																											 ) : independent;
																											 
		Corp2_Mapping.LayoutsCommon.Main legalNameFix_Trans(Corp2_Mapping.LayoutsCommon.Main  l):= transform
			self.corp_legal_name :=if(Corp2_Raw_WY.Functions.find_SpecialChars(l.corp_legal_name)='FOUND', Corp2_Raw_WY.Functions.fix_ForeignChar(l.corp_legal_name), l.corp_legal_name);
			self								 :=l;
		end;
		
		legalNameFix          := project(MapRA2Corporation+MappedContacts, legalNameFix_Trans(left)) ;
		MapMain 							:= dedup(sort(distribute(legalNameFix,hash(corp_key)),record,local),record,local) : independent;		

		//********************************************************************
		//AR File Mapping from the FilingAR file.
		//********************************************************************
		Corp2_Mapping.LayoutsCommon.AR ArTransform(Corp2_Raw_WY.Layouts.TempARWIthFiling l):= transform
			self.corp_key															:= state_fips + '-' +corp2.t2u(l.filing_id);
			self.corp_vendor													:= state_fips;
			self.corp_state_origin										:= state_origin;			
			self.corp_process_date										:= fileDate;
			self.corp_sos_charter_nbr									:= corp2.t2u(l.filing_num);
			self.ar_year															:= corp2.t2u(l.filing_year);
			self.ar_filed_dt													:= if(Corp2_Mapping.fValidateDate(l.filing_date,'MM/DD/CCYY').PastDate not in ['18000101',''],Corp2_Mapping.fValidateDate(l.filing_date,'MM/DD/CCYY').PastDate,'');
			self.ar_report_nbr												:= corp2.t2u(l.annual_report_num);
			//ar_tax_amount_paid: remove in phase 2			
			self.ar_tax_amount_paid										:= corp2.t2u(l.license_tax_amt);
			//ar_comment: remove in phase 2			
			self.ar_comment														:= if(corp2.t2u(l.status)<>'','ANNUAL REPORT STATUS: '+corp2.t2u(l.status),'');
			self.ar_exempt														:= corp2.t2u(l.ar_exempt_yn);
			self.ar_license_tax_amount								:= corp2.t2u(l.license_tax_amt);
			self.ar_status														:= corp2.t2u(l.status);
			self																			:= [];																																																							
		end;	

		//********************************************************************
		//Join Filing & AR file to use for mapping.
		//********************************************************************
		ARWithFiling 																:= join(Filing,FilingAR,
																												corp2.t2u(left.filing_id) = corp2.t2u(right.filing_id),
																												transform(Corp2_Raw_WY.Layouts.TempARWIthFiling,
																																 self := right;
																																 self := left;
																																),
																												inner,
																												local
																											 );
																	 
		All_AR								:= project(ARWithFiling, ArTransform(left)) : independent;
		MapAR					  			:= dedup(sort(distribute(All_AR,hash(corp_key)),record,local),record,local) : independent;

		//********************************************************************
		//Stock File Mapping from the Filing file.  Mapping Common Stock here.
		//********************************************************************
		Corp2_Mapping.LayoutsCommon.Stock CommonStockTransform(Corp2_Raw_WY.Layouts.FilingLayoutIn l):= transform,
		skip(corp2.t2u(l.common_shares) = '' and corp2.t2u(l.common_par_value) = '')
			self.corp_key															:= state_fips + '-' +corp2.t2u(l.filing_id);
			self.corp_vendor													:= state_fips;
			self.corp_state_origin										:= state_origin;			
			self.corp_process_date										:= fileDate;
			self.corp_sos_charter_nbr									:= corp2.t2u(l.filing_num);		
			self.stock_type														:= if(corp2.t2u(l.common_shares)<>'','COMMON','');	
			self.stock_shares_issued									:= Corp2_Raw_WY.Functions.StockSharesIssued(l.common_shares);
			self.stock_par_value											:= if(corp2.t2u(l.common_par_value)='0.00','',corp2.t2u(l.common_par_value));
			self.stock_additional_stock								:= corp2.t2u(l.additional_stock_yn);
			//stock_addl_info: remove in phase 2
			self.stock_addl_info											:= if(corp2.t2u(l.additional_stock_yn)<>'','ADDITIONAL STOCK: ' + corp2.t2u(l.additional_stock_yn),'');		
			self																			:= [];																																																							
		end;

		CommonStock						:= project(Filing, CommonStockTransform(left)) : independent;
		MapCommonStock				:= CommonStock(stock_shares_issued <> '' or stock_par_value <> '') : independent;

		//********************************************************************
		//Stock File Mapping from the Filing file.  Mapping Preferred Stock
		//here.
		//********************************************************************
		Corp2_Mapping.LayoutsCommon.Stock PreferredStockTransform(Corp2_Raw_WY.Layouts.FilingLayoutIn l):= transform,
		skip(corp2.t2u(l.preferred_shares) = '' and corp2.t2u(l.preferred_par_value) = '')
			self.corp_key															:= state_fips + '-' +corp2.t2u(l.filing_id);
			self.corp_vendor													:= state_fips;
			self.corp_state_origin										:= state_origin;			
			self.corp_process_date										:= fileDate;
			self.corp_sos_charter_nbr									:= corp2.t2u(l.filing_num);		
			self.stock_shares_issued									:= Corp2_Raw_WY.Functions.StockSharesIssued(l.preferred_shares);
			self.stock_type														:= if(corp2.t2u(self.stock_shares_issued)<>'','PREFERRED','');
			self.stock_par_value											:= if(corp2.t2u(l.preferred_par_value)='0.00','',corp2.t2u(l.preferred_par_value));			
			self																			:= [];																																																							
		end;

		MapPreferredStock			:= project(Filing, PreferredStockTransform(left)) : independent;	
		MapStock					  	:= dedup(sort(distribute(MapCommonStock + MapPreferredStock,hash(corp_key)),record,local),record,local) : independent;

		//********************************************************************
		// SCRUB AR 
		//********************************************************************	
		AR_F := MapAR;
		AR_S := Scrubs_Corp2_Mapping_WY_AR.Scrubs;				// Scrubs module
		AR_N := AR_S.FromNone(AR_F); 											// Generate the error flags
		AR_T := AR_S.FromBits(AR_N.BitmapInfile);     		// Use the FromBits module; makes my bitmap datafile easier to get to
		AR_U := AR_S.FromExpanded(AR_N.ExpandedInFile); 	// Pass the expanded error flags into the Expanded module

		//Outputs reports
		AR_ErrorSummary			 	 := output(AR_U.SummaryStats, named('AR_ErrorSummary_WY'+filedate));
		AR_ScrubErrorReport 	 := output(choosen(AR_U.AllErrors, 1000), named('AR_ScrubErrorReport_WY'+filedate));
		AR_SomeErrorValues		 := output(choosen(AR_U.BadValues, 1000), named('AR_SomeErrorValues_WY'+filedate));
		AR_IsScrubErrors		 	 := IF(count(AR_U.AllErrors)<> 0,true,false);

		// Orbit Stats
		AR_OrbitStats				 	 := AR_U.OrbitStats();

		//Outputs files
		AR_CreateBitMaps			 := output(AR_N.BitmapInfile,,'~thor_data::Corp_WY_AR_scrubs_bits',overwrite,compressed);	//long term storage
		AR_TranslateBitMap		 := output(AR_T);

		//Submits Profile's stats to Orbit
		AR_SubmitStats 			   := Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_WY_AR','ScrubsAlerts', AR_OrbitStats, version,'Corp_WY_AR').SubmitStats;
		AR_ScrubsWithExamples  := Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_WY_AR','ScrubsAlerts', AR_OrbitStats, version,'Corp_WY_AR').CompareToProfile_with_Examples;

		AR_ScrubsAlert				 := AR_ScrubsWithExamples(RejectWarning = 'Y');
		AR_ScrubsAttachment	   := Scrubs.fn_email_attachment(AR_ScrubsAlert);
		AR_MailFile					   := FileServices.SendEmailAttachData(corp2.Email_Notification_Lists.spray
																															,'Scrubs CorpAR_WY Report' //subject
																															,'Scrubs CorpAR_WY Report' //body
																															,(data)AR_ScrubsAttachment
																															,'text/csv'
																															,'CorpWYARScrubsReport.csv'
																															,
																															,
																															,corp2.Email_Notification_Lists.spray);

		AR_BadRecords				 := AR_N.ExpandedInFile(																					
																								corp_key_Invalid							  			<> 0 or
																								corp_vendor_Invalid 									<> 0 or
																								corp_state_origin_Invalid 					 	<> 0 or
																								corp_process_date_Invalid						  <> 0 or
																								corp_sos_charter_nbr_Invalid 					<> 0 or
																								ar_year_Invalid 											<> 0 or
																								ar_tax_amount_paid_Invalid 						<> 0 or
																								ar_comment_Invalid 										<> 0 or
																								ar_exempt_Invalid 										<> 0 or
																								ar_license_tax_amount_Invalid 				<> 0 or
																								ar_status_Invalid 										<> 0
																							 );
																									 																	
		AR_GoodRecords				:= AR_N.ExpandedInFile(
																								corp_key_Invalid							  			= 0 and
																								corp_vendor_Invalid 									= 0 and
																								corp_state_origin_Invalid 					 	= 0 and
																								corp_process_date_Invalid						  = 0 and
																								corp_sos_charter_nbr_Invalid 					= 0 and
																								ar_year_Invalid 											= 0 and
																								ar_tax_amount_paid_Invalid 						= 0 and
																								ar_comment_Invalid 										= 0 and
																								ar_exempt_Invalid 										= 0 and
																								ar_license_tax_amount_Invalid 				= 0 and
																								ar_status_Invalid 										= 0																									
																								);

		AR_FailBuild					 := if(count(AR_GoodRecords) = 0,true,false);

		AR_ApprovedRecords		 := project(AR_GoodRecords,transform(Corp2_Mapping.LayoutsCommon.AR,self := left;));

		AR_ALL								 := sequential(IF(count(AR_BadRecords) <> 0
																								 ,IF (poverwrite
																										 ,OUTPUT(AR_BadRecords,,Corp2_Mapping._Dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::ar_'+state_origin,overwrite,__compressed__)
																										 ,OUTPUT(AR_BadRecords,,Corp2_Mapping._Dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::ar_'+state_origin,__compressed__)
																										 )
																								 )
																						  ,output(AR_ScrubsWithExamples, ALL, NAMED('CorpARWYScrubsReportWithExamples'+filedate))
																							//Send Alerts if Scrubs exceeds thresholds
																							,IF(COUNT(AR_ScrubsAlert) > 0, AR_MailFile, OUTPUT('CORP2_MAPPING.WY - No "AR" Corp Scrubs Alerts'))
																							,AR_ErrorSummary
																							,AR_ScrubErrorReport
																							,AR_SomeErrorValues	
																							,AR_SubmitStats
																					);

		//********************************************************************
		// SCRUB MAIN
		//********************************************************************	
		Main_F := mapMain;
		Main_S := Scrubs_Corp2_Mapping_WY_Main.Scrubs;					// Scrubs module
		Main_N := Main_S.FromNone(Main_F); 										  // Generate the error flags
		Main_T := Main_S.FromBits(Main_N.BitmapInfile);     		// Use the FromBits module; makes my bitmap datafile easier to get to
		Main_U := Main_S.FromExpanded(Main_N.ExpandedInFile); 	// Pass the expanded error flags into the Expanded module

		//Outputs reports
		Main_ErrorSummary					:= output(Main_U.SummaryStats, named('Main_ErrorSummary_WY'+filedate));
		Main_ScrubErrorReport 		:= output(choosen(Main_U.AllErrors, 1000), named('Main_ScrubErrorReport_WY'+filedate));
		Main_SomeErrorValues			:= output(choosen(Main_U.BadValues, 1000), named('Main_SomeErrorValues_WY'+filedate));
		Main_IsScrubErrors		 		:= IF(count(Main_U.AllErrors)<> 0,true,false);

		// Orbit Stats
		Main_OrbitStats						:= Main_U.OrbitStats();

		//Outputs files
		Main_CreateBitMaps				:= output(Main_N.BitmapInfile,,'~thor_data::corp_wy_main_scrubs_bits',overwrite,compressed);	//long term storage
		Main_TranslateBitMap			:= output(Main_T);

		//Submits Profile's stats to Orbit
		Main_SubmitStats 			  := Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_WY_Main','ScrubsAlerts', Main_OrbitStats, version,'Corp_WY_Main').SubmitStats;
		Main_ScrubsWithExamples := Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_WY_Main','ScrubsAlerts', Main_OrbitStats, version,'Corp_WY_Main').CompareToProfile_with_Examples;

		Main_ScrubsAlert					:= Main_ScrubsWithExamples(RejectWarning = 'Y');
		Main_ScrubsAttachment			:= Scrubs.fn_email_attachment(Main_ScrubsAlert);
		Main_MailFile							:= FileServices.SendEmailAttachData(corp2.Email_Notification_Lists.spray
																																 ,'Scrubs CorpMain_WY Report' //subject
																																 ,'Scrubs CorpMain_WY Report' //body
																																 ,(data)Main_ScrubsAttachment
																																 ,'text/csv'
																																 ,'CorpWYMainScrubsReport.csv'
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
																											 corp_address2_type_cd_Invalid 					<> 0 or
																											 corp_address2_type_desc_Invalid 				<> 0 or																										 
																											 corp_filing_date_Invalid 							<> 0 or
																											 corp_filing_desc_Invalid 							<> 0 or
																											 corp_status_date_Invalid 							<> 0 or
																											 corp_standing_Invalid 									<> 0 or
																											 corp_inc_state_Invalid 								<> 0 or
																											 corp_inc_date_Invalid 									<> 0 or
																											 corp_term_exist_cd_Invalid 						<> 0 or
																											 corp_term_exist_desc_Invalid 					<> 0 or
																											 corp_foreign_domestic_ind_Invalid 			<> 0 or
																											 corp_forgn_state_cd_Invalid 						<> 0 or
																											 corp_forgn_state_desc_Invalid 					<> 0 or																											 
																											 corp_forgn_date_Invalid 								<> 0 or
																											 corp_forgn_term_exist_cd_Invalid 			<> 0 or
																											 corp_forgn_term_exist_desc_Invalid 		<> 0 or	
																											 corp_for_profit_ind_Invalid 						<> 0 or
																											 corp_ra_resign_date_Invalid 						<> 0 or
																											 corp_trademark_expiration_date_Invalid <> 0 or
																											 recordorigin_Invalid 									<> 0
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
																										 corp_address2_type_cd_Invalid 					= 0 and
																										 corp_address2_type_desc_Invalid 				= 0 and																										 
																										 corp_filing_date_Invalid 							= 0 and
																										 corp_filing_desc_Invalid 							= 0 and
																										 corp_status_date_Invalid 							= 0 and
																										 corp_standing_Invalid 									= 0 and
																										 corp_inc_state_Invalid 								= 0 and
																										 corp_inc_date_Invalid 									= 0 and
																										 corp_term_exist_cd_Invalid 						= 0 and
																										 corp_term_exist_desc_Invalid 					= 0 and
																										 corp_foreign_domestic_ind_Invalid 			= 0 and
																										 corp_forgn_state_cd_Invalid 						= 0 and
																										 corp_forgn_state_desc_Invalid 					= 0 and																											 
																										 corp_forgn_date_Invalid 								= 0 and
																										 corp_forgn_term_exist_cd_Invalid 			= 0 and
																										 corp_forgn_term_exist_desc_Invalid 		= 0 and	
																										 corp_for_profit_ind_Invalid 						= 0 and
																										 corp_ra_resign_date_Invalid 						= 0 and
																										 corp_trademark_expiration_date_Invalid = 0 and
																										 recordorigin_Invalid 									= 0
																								  );

		Main_FailBuild					:= map( corp2_mapping.fCalcPercent(count(Main_N.ExpandedInFile(corp_key_invalid<>0)),count(Main_N.ExpandedInFile),false) 										> Scrubs_Corp2_Mapping_WY_Main.Threshold_Percent.CORP_KEY										 => true,
																		corp2_mapping.fCalcPercent(count(Main_N.ExpandedInFile(corp_orig_sos_charter_nbr_invalid<>0)),count(Main_N.ExpandedInFile),false) 	> Scrubs_Corp2_Mapping_WY_Main.Threshold_Percent.CORP_ORIG_SOS_CHARTER_NBR 	 => true,
																		corp2_mapping.fCalcPercent(count(Main_N.ExpandedInFile(corp_legal_name_invalid<>0)),count(Main_N.ExpandedInFile),false) 						> Scrubs_Corp2_Mapping_WY_Main.Threshold_Percent.CORP_LEGAL_NAME 						 => true,
																	  count(Main_GoodRecords) = 0																																																																																											 => true,
																		false
																	);

		Main_ApprovedRecords		:= project(Main_GoodRecords,transform(Corp2_Mapping.LayoutsCommon.Main,self := left));

		Main_ALL		 			:= sequential( IF(count(Main_BadRecords) <> 0
																							,IF (poverwrite
																									,OUTPUT(Main_BadRecords,,Corp2_Mapping._Dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::main_'+state_origin,overwrite,__compressed__)
																									,OUTPUT(Main_BadRecords,,Corp2_Mapping._Dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::main_'+state_origin,__compressed__)
																									)
																							)
																					,output(Main_ScrubsWithExamples, ALL, NAMED('CorpMainWYScrubsReportWithExamples'+filedate))
																					//Send Alerts if Scrubs exceeds thresholds
																					,IF(COUNT(Main_ScrubsAlert) > 0, Main_MailFile, OUTPUT('CORP2_MAPPING.WY - No "MAIN" Corp Scrubs Alerts'))
																					,Main_ErrorSummary
																					,Main_ScrubErrorReport
																					,Main_SomeErrorValues		
																					,Main_SubmitStats
																			);

		//********************************************************************
		// SCRUB STOCK
		//********************************************************************	
		Stock_F := mapStock;
		Stock_S := Scrubs_Corp2_Mapping_WY_Stock.Scrubs;						// Scrubs module
		Stock_N := Stock_S.FromNone(Stock_F); 											// Generate the error flags
		Stock_T := Stock_S.FromBits(Stock_N.BitmapInfile);     			// Use the FromBits module; makes my bitmap datafile easier to get to
		Stock_U := Stock_S.FromExpanded(Stock_N.ExpandedInFile); 		// Pass the expanded error flags into the Expanded module

		//Outputs reports
		Stock_ErrorSummary			 	:= output(Stock_U.SummaryStats, named('Stock_ErrorSummary_WY'+filedate));
		Stock_ScrubErrorReport 	 	:= output(choosen(Stock_U.AllErrors, 1000), named('Stock_ScrubErrorReport_WY'+filedate));
		Stock_SomeErrorValues		 	:= output(choosen(Stock_U.BadValues, 1000), named('Stock_SomeErrorValues_WY'+filedate));
		Stock_IsScrubErrors		 	 	:= IF(count(Stock_U.AllErrors)<> 0,true,false);

		// Orbit Stats
		Stock_OrbitStats				 	:= Stock_U.OrbitStats();

		//Outputs files
		Stock_CreateBitMaps				:= output(Stock_N.BitmapInfile,,'~thor_data::corp_wy_scrubs_bits',overwrite,compressed);	//long term storage
		Stock_TranslateBitMap			:= output(Stock_T);

		//Submits Profile's stats to Orbit
		Stock_SubmitStats 			 := Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_WY_Stock','ScrubsAlerts', Stock_OrbitStats, version,'Corp_WY_Stock').SubmitStats;
		Stock_ScrubsWithExamples := Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_WY_Stock','ScrubsAlerts', Stock_OrbitStats, version,'Corp_WY_Stock').CompareToProfile_with_Examples;

		Stock_ScrubsAlert					:= Stock_ScrubsWithExamples(RejectWarning = 'Y');
		Stock_ScrubsAttachment		:= Scrubs.fn_email_attachment(Stock_ScrubsAlert);
		Stock_MailFile						:= FileServices.SendEmailAttachData(corp2.Email_Notification_Lists.spray
																																 ,'Scrubs CorpStock_WY Report' //subject
																																 ,'Scrubs CorpStock_WY Report' //body
																																 ,(data)Stock_ScrubsAttachment
																																 ,'text/csv'
																																 ,'CorpWYStockScrubsReport.csv'
																																 ,
																																 ,
																																 ,corp2.Email_Notification_Lists.spray);
		Stock_BadRecords					:= Stock_N.ExpandedInFile(	
																												corp_key_Invalid							  			<> 0 or
																												corp_vendor_Invalid 									<> 0 or
																												corp_state_origin_Invalid 					 	<> 0 or
																												corp_process_date_Invalid						  <> 0 or
																												corp_sos_charter_nbr_Invalid					<> 0 or
																												stock_shares_issued_Invalid						<> 0 or
																												stock_par_value_Invalid								<> 0 or
																												stock_addl_info_Invalid								<> 0
																											 );
																																							
		Stock_GoodRecords					:= Stock_N.ExpandedInFile(	
																												corp_key_Invalid							  			= 0 and
																												corp_vendor_Invalid 									= 0 and
																												corp_state_origin_Invalid 					 	= 0 and
																												corp_process_date_Invalid						  = 0 and
																												corp_sos_charter_nbr_Invalid					= 0 and
																												stock_shares_issued_Invalid		 				= 0 and
																												stock_shares_issued_Invalid						= 0 and
																												stock_par_value_Invalid								= 0 and
																												stock_addl_info_Invalid								= 0																												
																											 );
																														
		Stock_FailBuild						:= if(count(Stock_GoodRecords) = 0,true,false);

		Stock_ApprovedRecords			:= project(Stock_GoodRecords,transform(Corp2_Mapping.LayoutsCommon.Stock,self := left));

		Stock_ALL									:= sequential( IF(count(Stock_BadRecords) <> 0
																							,IF (poverwrite
																									,OUTPUT(Stock_BadRecords,,Corp2_Mapping._Dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::stock_'+state_origin,overwrite,__compressed__)
																									,OUTPUT(Stock_BadRecords,,Corp2_Mapping._Dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::stock_'+state_origin,__compressed__)
																									)
																							)
																					,output(Stock_ScrubsWithExamples, ALL, NAMED('CorpStockWYScrubsReportWithExamples'+filedate))
																					//Send Alerts if Scrubs exceeds thresholds
																					,IF(COUNT(Stock_ScrubsAlert) > 0, Stock_MailFile, OUTPUT('CORP2_MAPPING.WY - No "Stock" Corp Scrubs Alerts'))
																					,Stock_ErrorSummary
																					,Stock_ScrubErrorReport
																					,Stock_SomeErrorValues	
																					,Stock_SubmitStats
																					);	

	//********************************************************************
  // UPDATE
  //********************************************************************
	Fail_Build						:= IF(AR_FailBuild = true or Main_FailBuild = true or Stock_FailBuild = true,true,false);
	IsScrubErrors					:= IF(AR_IsScrubErrors = true or Main_IsScrubErrors = true or Stock_IsScrubErrors = true,true,false);

	VersionControl.macBuildNewLogicalFile(Corp2_Mapping._dataset().thor_cluster_Files + 'in::corp2::' 	+ version + '::AR_' 		+ state_origin, AR_ApprovedRecords	 , write_ar,,,pOverwrite);
	VersionControl.macBuildNewLogicalFile(Corp2_Mapping._dataset().thor_cluster_Files + 'in::corp2::' 	+ version + '::Main_' 	+ state_origin, Main_ApprovedRecords , write_main,,,pOverwrite);
	VersionControl.macBuildNewLogicalFile(Corp2_Mapping._dataset().thor_cluster_Files + 'in::corp2::' 	+ version + '::Stock_' 	+ state_origin, Stock_ApprovedRecords, write_stock,,,pOverwrite);

	VersionControl.macBuildNewLogicalFile(Corp2_Mapping._dataset().thor_cluster_Files + 'fail::corp2::' + version + '::AR_' 		+ state_origin, AR_F		, write_fail_ar,,,pOverwrite);
	VersionControl.macBuildNewLogicalFile(Corp2_Mapping._dataset().thor_cluster_Files + 'fail::corp2::' + version + '::Main_' 	+ state_origin, Main_F	, write_fail_main,,,pOverwrite);
	VersionControl.macBuildNewLogicalFile(Corp2_Mapping._dataset().thor_cluster_Files + 'fail::corp2::' + version + '::Stock_' 	+ state_origin, Stock_F	, write_fail_stock,,,pOverwrite);

	mapWY:= sequential ( if(pshouldspray = true,Corp2_mapping.fSprayFiles(state_origin,version,pOverwrite := pOverwrite))
											// ,Corp2_Raw_WY.Build_Bases(filedate,version,puseprod).All									
											,AR_All
											,Main_All
											,Stock_All									
											,if(Fail_Build <> true	 
												 ,sequential (write_ar
																		 ,write_main
																		 ,write_stock	
																		 ,fileservices.addsuperfile(Corp2_Mapping._Dataset().thor_cluster_Files + 'in::'+Corp2_Mapping._Dataset().NameMapped +'::sprayed::ar'			,Corp2_Mapping._Dataset().thor_cluster_Files + 'in::corp2::'+version+'::ar_'		+state_origin)
																		 ,fileservices.addsuperfile(Corp2_Mapping._Dataset().thor_cluster_Files + 'in::'+Corp2_Mapping._Dataset().NameMapped +'::sprayed::main'		,Corp2_Mapping._Dataset().thor_cluster_Files + 'in::corp2::'+version+'::main_'	+state_origin)																		 
																		 ,fileservices.addsuperfile(Corp2_Mapping._Dataset().thor_cluster_Files + 'in::'+Corp2_Mapping._Dataset().NameMapped +'::sprayed::stock'	,Corp2_Mapping._Dataset().thor_cluster_Files + 'in::corp2::'+version+'::stock_'	+state_origin)
																		 ,if (count(Main_BadRecords) <> 0 or count(AR_BadRecords) <> 0 or count(Stock_BadRecords)<>0
																				 ,Corp2_Mapping.Send_Email(state_origin,version,count(Main_BadRecords)<>0,count(AR_BadRecords)<>0,,count(Stock_BadRecords)<>0,count(Main_BadRecords),count(AR_BadRecords),,count(Stock_BadRecords),count(Main_ApprovedRecords),count(AR_ApprovedRecords),,count(Stock_ApprovedRecords)).RecordsRejected																				 
																				 ,Corp2_Mapping.Send_Email(state_origin,version,count(Main_BadRecords)<>0,count(AR_BadRecords)<>0,,count(Stock_BadRecords)<>0,count(Main_BadRecords),count(AR_BadRecords),,count(Stock_BadRecords),count(Main_ApprovedRecords),count(AR_ApprovedRecords),,count(Stock_ApprovedRecords)).MappingSuccess																				 
																				 )
																		 ,if (IsScrubErrors
																				 ,Corp2_Mapping.Send_Email(state_origin,version,Main_IsScrubErrors,AR_IsScrubErrors,,Stock_IsScrubErrors).FieldsInvalidPerScrubs
																				 )
																		 ) //if Fail_Build <> true																			
												 ,SEQUENTIAL (write_fail_ar
																		 ,write_fail_main
																		 ,write_fail_stock												 
																		 ,Corp2_Mapping.Send_Email(state_origin,version).MappingFailed
																		 ) //if Fail_Build = true
												 )
										);
										
	isFileDateValid := if((string)std.date.today() between ut.date_math(filedate,-30) and ut.date_math(filedate,30),true,false);
	return sequential (	 if (isFileDateValid
													,mapWY
													,sequential (Corp2_Mapping.Send_Email(state_origin,filedate).InvalidFileDateParm
																			,FAIL('Corp2_Mapping.'+state_origin+' failed.  An invalid filedate was passed in as a parameter.')
																			)
													)
										);

	end;	// end of Update function

end;  // end of Module
	