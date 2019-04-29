import corp2,corp2_mapping,corp2_raw_la,lib_stringlib,scrubs,scrubs_corp2_mapping_la_ar,
			 scrubs_corp2_mapping_la_event,scrubs_corp2_mapping_la_main,std,tools,ut,versioncontrol; 

export LA := MODULE;  

	export Update(string fileDate, string version, boolean pShouldSpray = _Dataset().bShouldSpray, boolean pOverwrite = false, pUseProd = Tools._Constants.IsDataland) := function

		state_origin			 			:= 'LA';
		state_fips	 				 		:= '22';
		state_desc	 			 			:= 'LOUISIANA';

		CorpsEntities			 	 		:= dedup(sort(distribute(Corp2_Raw_LA.Files(filedate,puseprod).input.CorpsEntities.Logical,hash(entityid)),record,local),record,local) : independent;
		Agents			 	 			 		:= dedup(sort(distribute(Corp2_Raw_LA.Files(filedate,puseprod).input.Agents.Logical,hash(agent_entityid)),record,local),record,local) : independent;
		Filings			 	 			 		:= dedup(sort(distribute(Corp2_Raw_LA.Files(filedate,puseprod).input.Filings.Logical,hash(filing_entityid)),record,local),record,local) : independent;
		Mergers 					 	 		:= dedup(sort(distribute(Corp2_Raw_LA.Files(filedate,puseprod).input.Mergers.Logical,hash(merger_entityid)),record,local),record,local) : independent;
		PreviousNames 			 		:= dedup(sort(distribute(Corp2_Raw_LA.Files(filedate,puseprod).input.PreviousNames.Logical,hash(pre_entityid)),record,local),record,local) : independent;
		TradeServices 			 		:= dedup(sort(distribute(Corp2_Raw_LA.Files(filedate,puseprod).input.TradeServices.Logical,hash(trade_entityid)),record,local),record,local) : independent;
		NameReservs 				 		:= dedup(sort(distribute(Corp2_Raw_LA.Files(filedate,puseprod).input.NameReservs.Logical,hash(reservationnumber)),record,local),record,local) : independent;

		//The lists below are the valid "chartercategory" values:
		DomesticCharterList	:= ['A','B','C','D','E','G','H','I','J','K','N','R','S','T','U','W','Y','AA','BB'];
		ForeignCharterList	:= ['F','L','M','P','Q','V','X','Z','EE'];	

		//********************************************************************
		//NOTE:  CorpsEntities: contains corp data (this is the primary/master file).
		//			 Agents:			 	contains both corp (agents/ra) & contact (officer) data.	
		//			 Filings:			 	contains only event & ar data.
		//			 NameReservs:		contains both corp & contact data.
		//			 PreviousNames:	contains both corp & event data.
		//			 TradeServices: contains both corp, contact & event data.
		//			 Mergers:				contains only event data.
		//********************************************************************
			
		//This transform normalizes all "child" addresses in the CorpsEntities file.  Basically, a new
		//dataset is created that contains a separate record for each address in the CorpsEntities file.
		//Note: The left parameter is the parent record, right parameter is the child dataset.
		CorpsEntitiesNorm 	  := normalize(CorpsEntities,
																			 left.CorpAddress,
																			 transform(Corp2_Raw_LA.Layouts.CorpsEntitiesChild,
																								 self.addr_entityid 								:= left.entityid;
																								 //This regex removes the state value from the city.
																								 self.city													:= if(regexfind('\\,[ ]*'+corp2.t2u(right.stateorprovince)+'$',corp2.t2u(right.city),0)<>'',
																																													regexreplace('\\,[ ]*'+corp2.t2u(right.stateorprovince)+'$',corp2.t2u(right.city),''),
																																													corp2.t2u(right.city)
																																													);
																								 self    														:= right;
																								),
																			 local
																			); 
																				
		CorpsEntitiesNormSort:= sort(distribute(CorpsEntitiesNorm, hash(addr_entityid)),addr_entityid,local) : independent;
		
		//This join attaches all the "child" addresses (the new "child" address file created above with its
		//associated record in the CorpsEntities file.
		CorpEntitiesJoin			:= join(CorpsEntities,CorpsEntitiesNormSort,
																	corp2.t2u(left.entityid) = corp2.t2u(right.addr_entityid),
																	transform(Corp2_Raw_LA.Layouts.Temp_Corp,
																						self.addresstype												:= right.addresstype;	
																						self.address1														:= right.address1;			
																						self.address2														:= right.address2;			
																						self.city																:= right.city;				
																						self.stateorprovince										:= right.stateorprovince;	
																						self.zipcode														:= right.zipcode;			
																						self.country														:= right.country;
																						self.parish															:= right.parish;
																						self         														:= left;
																					 ),
																	left outer,
																	local
																 );

		//This transform normalizes all "child" agents in the Agents file. Basically, a new
		//dataset is created that contains a separate record for each agent in the Agents file.		
		//Note: The left parameter is the parent record, right parameter is the Agents child dataset.
		AgentsNorm	 					:= normalize(Agents,
																			 left.agents,
																			 transform(Corp2_Raw_LA.Layouts.AgentsChild,
																								 self.agents_entityid 							:= left.agent_entityid;
																								 self							 									:= right;
																								),
																			 local
																			);

    AgentsNormSort 			:= sort(distribute(AgentsNorm, hash(agents_entityid)),agents_entityid,local) : independent;
	
		AgentsJoin	 		 			:= join(Agents,AgentsNormSort,
																	corp2.t2u(left.agent_entityid) = corp2.t2u(right.agents_entityid),
																	transform(Corp2_Raw_LA.Layouts.Temp_Agents,
																						self.firstname  												:= right.firstname;	
																						self.lastname  													:= right.lastname;	
																						self.agent_address1  										:= right.agent_address1;	
																						self.agent_address2  										:= right.agent_address2;	
																						self.agent_city  												:= right.agent_city;	
																						self.agent_state  											:= right.agent_state;	
																						self.postalcode  												:= right.postalcode;	
																						self.titles  														:= right.titles;	
																						self.emailaddress  		  								:= right.emailaddress;	
																						self.dateappointed  										:= right.dateappointed;	
																						self         														:= left;
																					 ),
																	left outer,
																	local
																 );

    CorpEntitiesJoinSort	:= sort(distribute(CorpEntitiesJoin, hash(entityid)),entityid,local) : independent;
		AgentsJoinSort        := sort(distribute(AgentsJoin, hash(agent_entityid)),agent_entityid,local) : independent;
		
   	CorpAgentsJoin		 		:= join(CorpEntitiesJoinSort,AgentsJoinSort,
																	corp2.t2u(left.entityid) = corp2.t2u(right.agent_entityid),
																	transform(Corp2_Raw_LA.Layouts.Temp_CorpAgents,
																						self         														:= left;
																						self																		:= right;
																						self  																	:= [];
																					 ),
																	left outer,
																	local
																 ) : independent;
	
		//********************************************************************
		//BEGIN MAPPING MAIN
		//NOTE: Map the joined Corporation and Agents File as corporation
		//********************************************************************			
		Corp2_Mapping.LayoutsCommon.Main CorpAgentsCorpTransform(Corp2_Raw_LA.Layouts.Temp_CorpAgents l) := transform
			self.dt_vendor_first_reported							:= (integer)fileDate;
			self.dt_vendor_last_reported							:= (integer)fileDate;
			self.dt_first_seen												:= (integer)fileDate;
			self.dt_last_seen													:= (integer)fileDate;
			self.corp_ra_dt_first_seen								:= (integer)fileDate;
			self.corp_ra_dt_last_seen									:= (integer)fileDate;			
			self.corp_key															:= state_fips + '-' + corp2.t2u(stringlib.stringfilterout(l.entityid,'.')); //remove any periods
			self.corp_vendor													:= state_fips;
			self.corp_state_origin										:= state_origin;			
			self.corp_process_date										:= fileDate;		
     	self.corp_orig_sos_charter_nbr        		:= corp2.t2u(stringlib.stringfilterout(l.entityid,'.')); //remove any periods
		  self.corp_legal_name                  		:= Corp2_mapping.fCleanBusinessName(state_origin,state_desc,l.entityname).BusinessName;
			self.corp_ln_name_type_cd             		:= '01';
			self.corp_ln_name_type_desc           		:= 'LEGAL';																									
			self.corp_address1_line1									:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.address1,l.address2,l.city,l.stateorprovince,l.zipcode,l.country).AddressLine1;
			self.corp_address1_line2				 					:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.address1,l.address2,l.city,l.stateorprovince,l.zipcode,l.country).AddressLine2;
			self.corp_address1_line3				 					:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.address1,l.address2,l.city,l.stateorprovince,l.zipcode,l.country).AddressLine3;
			self.corp_address1_type_cd								:= if(Corp2_Mapping.fAddressExists(state_origin,state_desc,self.corp_address1_line1,self.corp_address1_line2+self.corp_address1_line3,l.city,l.stateorprovince,l.zipcode,l.country).ifAddressExists,
																											map(corp2.t2u(l.addresstype) = 'DOMICILE ADDRESS'  => 'B',
																													corp2.t2u(l.addresstype) = 'LA. REG. OFFICE'   => 'G',
																													corp2.t2u(l.addresstype) = 'PRINCIPAL BUS./LA' => 'L',
																													corp2.t2u(l.addresstype) = 'MAILING ADDRESS'	 => 'M',
																													corp2.t2u(l.addresstype) = 'PRINCIPAL OFFICE'  => 'O',
																													''
																												 ),
																											''
																										 );
			self.corp_address1_type_desc							:= if(Corp2_Mapping.fAddressExists(state_origin,state_desc,self.corp_address1_line1,self.corp_address1_line2+self.corp_address1_line3,l.city,l.stateorprovince,l.zipcode,l.country).ifAddressExists,
																											map(corp2.t2u(l.addresstype) = 'DOMICILE ADDRESS'  => 'BUSINESS',
																												  corp2.t2u(l.addresstype) = 'LA. REG. OFFICE'   => 'REGISTERED OFFICE',
																												  corp2.t2u(l.addresstype) = 'PRINCIPAL BUS./LA' => 'PRINCIPAL OFFICE/LOUISIANA',
																													corp2.t2u(l.addresstype) = 'MAILING ADDRESS'	 => 'MAILING',																													
																												  corp2.t2u(l.addresstype) = 'PRINCIPAL OFFICE'  => 'PRINCIPAL OFFICE',
																													''
																												 ),
																											''
																										 );
			self.corp_prep_addr1_line1								:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.address1,l.address2,l.city,l.stateorprovince,l.zipcode,l.country).PrepAddrLine1;
			self.corp_prep_addr1_last_line				 		:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.address1,l.address2,l.city,l.stateorprovince,l.zipcode,l.country).PrepAddrLastLine;																										 
      self.corp_status_desc                 		:= corp2.t2u(l.entitystatus);			
		  self.corp_status_date                 		:= if(corp2.t2u(l.inactivereason) <> '',
																											map(corp2.t2u(l.entitystatus) =  'ACTIVE' => Corp2_Mapping.fValidateDate(l.inactivedate[1..10],'CCYYMMDD').PastDate,
																													corp2.t2u(l.entitystatus) <> 'ACTIVE' => Corp2_Mapping.fValidateDate(l.inactiveactiondate[1..10],'CCYYMMDD').PastDate,																											
																													''
																												 ),
																											''
																										 );
			self.corp_standing					  						:= map(corp2.t2u(l.goodstdstatus) in ['YES','Y'] => 'Y',
																											 corp2.t2u(l.goodstdstatus) in ['NO' ,'N'] => 'N',
																											 ''
																											);																										 
			self.corp_status_comment              		:= corp2.t2u(l.inactivereason);
		  self.corp_inc_state                 		  := state_origin;
		  self.corp_inc_county                 		  := stringlib.stringfilter(corp2.t2u(l.parish),'ABCDEFGHIJKLMNOPQRSTUVWXYZ ');
			self.corp_inc_date                    		:= if(corp2.t2u(l.chartercategory) in DomesticCharterList,Corp2_Mapping.fValidateDate(l.entitystartdate[1..10],'CCYY-MM-DD').PastDate,''); 
		  self.corp_foreign_domestic_ind						:= map(corp2.t2u(l.chartercategory) in DomesticCharterList =>'D',
																											 corp2.t2u(l.chartercategory) in ForeignCharterList  =>'F',			
																											 ''
																										  );
		  self.corp_forgn_date											:= if(corp2.t2u(l.chartercategory) in ForeignCharterList,Corp2_Mapping.fValidateDate(l.entitystartdate[1..10],'CCYY-MM-DD').PastDate,'');
		  self.corp_orig_org_structure_cd    	  		:= corp2.t2u(l.chartercategory);
			self.corp_orig_org_structure_desc 				:= Corp2_Raw_LA.Functions.CorpOrigOrgStructureDesc(l.chartercategory);
		  self.corp_for_profit_ind									:= if(corp2.t2u(l.chartercategory) in ['G','N','V','X'],'N','');
			self.corp_ra_full_name										:= Corp2_Mapping.fCleanBusinessName(state_origin,state_desc,l.firstname+' '+l.lastname).BusinessName;
			self.corp_ra_address_type_cd          		:= if(Corp2_Mapping.fAddressExists(state_origin,state_desc,l.agent_address1,l.agent_address2,l.agent_city,l.agent_state,l.postalcode).ifAddressExists,'R','');
			self.corp_ra_address_type_desc        		:= if(Corp2_Mapping.fAddressExists(state_origin,state_desc,l.agent_address1,l.agent_address2,l.agent_city,l.agent_state,l.postalcode).ifAddressExists,'REGISTERED OFFICE','');
			self.corp_ra_address_line1								:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.agent_address1,l.agent_address2,l.agent_city,l.agent_state,l.postalcode).AddressLine1;		
			self.corp_ra_address_line2				 				:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.agent_address1,l.agent_address2,l.agent_city,l.agent_state,l.postalcode).AddressLine2;
			self.corp_ra_address_line3				 				:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.agent_address1,l.agent_address2,l.agent_city,l.agent_state,l.postalcode).AddressLine3;
			self.corp_ra_email_address								:= corp2.t2u(l.emailaddress);			
			self.corp_ra_effective_date           		:= Corp2_Mapping.fValidateDate(l.dateappointed,'CCYY-MM-DD').PastDate;			
			self.ra_prep_addr_line1										:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.agent_address1,l.agent_address2,l.agent_city,l.agent_state,l.postalcode).PrepAddrLine1;		
			self.ra_prep_addr_last_line				 				:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.agent_address1,l.agent_address2,l.agent_city,l.agent_state,l.postalcode).PrepAddrLastLine;
			self.corp_country_of_formation						:= Corp2_Raw_LA.Functions.CountryCodeTranslation(state_origin,state_desc,l.country); 
			self.recordorigin													:= 'C';
		  self                                  		:= [];
    end;

		//Note titles = '' => represent corporation records that contains no agent information.
		HasCorpAgents 	:= corp2.t2u(CorpAgentsJoin.titles) = 'AGENT' or corp2.t2u(CorpAgentsJoin.titles) = '';
		CorpAgents			:= project(CorpAgentsJoin(HasCorpAgents),CorpAgentsCorpTransform(left)) : independent;
		
		MailAgents			:= distribute(CorpAgents(corp_address1_type_cd 		 in ['M']),hash(corp_key)) : independent;
		NonMailAgents		:= distribute(CorpAgents(corp_address1_type_cd not in ['M']),hash(corp_key)) : independent;

		//This join maps the "mailing" address to the corp_address2_* fields and the "non-mailing" addresses to the 
		//corp_address1_* fields.
		MoveMailAddr		:= join(MailAgents,NonMailAgents,
													  left.corp_key = right.corp_key,
													  transform(Corp2_Mapping.LayoutsCommon.Main,
																			self.dt_vendor_first_reported			:= if(left.dt_vendor_first_reported<>0,left.dt_vendor_first_reported,right.dt_vendor_first_reported);
																			self.dt_vendor_last_reported			:= if(left.dt_vendor_last_reported<>0,left.dt_vendor_last_reported,right.dt_vendor_last_reported);
																			self.dt_first_seen								:= if(left.dt_first_seen<>0,left.dt_first_seen,right.dt_first_seen);
																			self.dt_last_seen									:= if(left.dt_last_seen<>0,left.dt_last_seen,right.dt_last_seen);
																			self.corp_ra_dt_first_seen				:= if(left.corp_ra_dt_first_seen<>0,left.corp_ra_dt_first_seen,right.corp_ra_dt_first_seen);
																			self.corp_ra_dt_last_seen					:= if(left.corp_ra_dt_last_seen<>0,left.corp_ra_dt_last_seen,right.corp_ra_dt_last_seen);
																			self.corp_key											:= if(left.corp_key<>'',left.corp_key,right.corp_key);
																			self.corp_vendor									:= if(left.corp_vendor<>'',left.corp_vendor,right.corp_vendor);
																			self.corp_state_origin						:= if(left.corp_state_origin<>'',left.corp_state_origin,right.corp_state_origin);		
																			self.corp_process_date						:= if(left.corp_process_date<>'',left.corp_process_date,right.corp_process_date);
																			self.corp_orig_sos_charter_nbr  	:= if(left.corp_orig_sos_charter_nbr<>'',left.corp_orig_sos_charter_nbr,right.corp_orig_sos_charter_nbr);
																			self.corp_legal_name            	:= if(left.corp_legal_name<>'',left.corp_legal_name,right.corp_legal_name);
																			self.corp_ln_name_type_cd       	:= if(left.corp_ln_name_type_cd<>'',left.corp_ln_name_type_cd,right.corp_ln_name_type_cd);
																			self.corp_ln_name_type_desc     	:= if(left.corp_ln_name_type_desc<>'',left.corp_ln_name_type_desc,right.corp_ln_name_type_desc);
																			self.corp_address1_line1					:= right.corp_address1_line1;
																			self.corp_address1_line2					:= right.corp_address1_line2;
																			self.corp_address1_line3					:= right.corp_address1_line3;
																			self.corp_address1_type_cd				:= right.corp_address1_type_cd;
																			self.corp_address1_type_desc			:= right.corp_address1_type_desc;
																			self.corp_prep_addr1_line1				:= right.corp_prep_addr1_line1;
																			self.corp_prep_addr1_last_line		:= right.corp_prep_addr1_last_line;								
																			self.corp_address2_line1					:= left.corp_address1_line1;
																			self.corp_address2_line2					:= left.corp_address1_line2;
																			self.corp_address2_line3					:= left.corp_address1_line3;
																			self.corp_address2_type_cd				:= left.corp_address1_type_cd;
																			self.corp_address2_type_desc			:= left.corp_address1_type_desc;							
																			self.corp_prep_addr2_line1				:= left.corp_prep_addr1_line1;
																			self.corp_prep_addr2_last_line		:= left.corp_prep_addr1_last_line;
																			self.corp_status_desc							:= if(left.corp_status_desc<>'',left.corp_status_desc,right.corp_status_desc);	
																			self.corp_status_date							:= if(left.corp_status_date<>'',left.corp_status_date,right.corp_status_date);
																			self.corp_standing								:= if(left.corp_standing<>'',left.corp_standing,right.corp_standing);
																			self.corp_status_comment					:= if(left.corp_status_comment<>'',left.corp_status_comment,right.corp_status_comment);
																			self.corp_inc_state								:= if(left.corp_inc_state<>'',left.corp_inc_state,right.corp_inc_state);
																			self.corp_inc_county							:= if(left.corp_inc_county<>'',left.corp_inc_county,right.corp_inc_county);
																			self.corp_inc_date								:= if(left.corp_inc_date<>'',left.corp_inc_date,right.corp_inc_date);
																			self.corp_foreign_domestic_ind		:= if(left.corp_foreign_domestic_ind<>'',left.corp_foreign_domestic_ind,right.corp_foreign_domestic_ind);
																			self.corp_forgn_date							:= if(left.corp_forgn_date<>'',left.corp_forgn_date,right.corp_forgn_date);
																			self.corp_orig_org_structure_cd   := if(left.corp_orig_org_structure_cd<>'',left.corp_orig_org_structure_cd,right.corp_orig_org_structure_cd);
																			self.corp_orig_org_structure_desc := if(left.corp_orig_org_structure_desc<>'',left.corp_orig_org_structure_desc,right.corp_orig_org_structure_desc);
																			self.corp_for_profit_ind					:= if(left.corp_for_profit_ind<>'',left.corp_for_profit_ind,right.corp_for_profit_ind);
																			self.corp_ra_full_name						:= if(left.corp_ra_full_name<>'',left.corp_ra_full_name,right.corp_ra_full_name);
																			self.corp_ra_address_type_cd			:= if(left.corp_ra_address_type_cd<>'',left.corp_ra_address_type_cd,right.corp_ra_address_type_cd);
																			self.corp_ra_address_type_desc		:= if(left.corp_ra_address_type_desc<>'',left.corp_ra_address_type_desc,right.corp_ra_address_type_desc);
																			self.corp_ra_address_line1				:= if(left.corp_ra_address_line1<>'',left.corp_ra_address_line1,right.corp_ra_address_line1);
																			self.corp_ra_address_line2				:= if(left.corp_ra_address_line2<>'',left.corp_ra_address_line2,right.corp_ra_address_line2);
																			self.corp_ra_address_line3				:= if(left.corp_ra_address_line3<>'',left.corp_ra_address_line3,right.corp_ra_address_line3);
																			self.corp_ra_email_address				:= if(left.corp_ra_email_address<>'',left.corp_ra_email_address,right.corp_ra_email_address);
																			self.corp_ra_effective_date				:= if(left.corp_ra_effective_date<>'',left.corp_ra_effective_date,right.corp_ra_effective_date);
																			self.ra_prep_addr_line1						:= if(left.ra_prep_addr_line1<>'',left.ra_prep_addr_line1,right.ra_prep_addr_line1);
																			self.ra_prep_addr_last_line				:= if(left.ra_prep_addr_last_line<>'',left.ra_prep_addr_last_line,right.ra_prep_addr_last_line);
																			self.corp_country_of_formation		:= if(left.corp_country_of_formation<>'',left.corp_country_of_formation,right.corp_country_of_formation);
																			self.recordorigin									:= if(left.recordorigin<>'',left.recordorigin,right.recordorigin);																		
																			self															:= left;
																		 ),
													  full outer,
													  local
														);
																												
		MailAddrMoved 	:= sort(MoveMailAddr,record,local);

		Corp2_Mapping.LayoutsCommon.Main rollupaddress(Corp2_Mapping.LayoutsCommon.Main l, Corp2_Mapping.LayoutsCommon.Main r) := transform
			address1_exists										:= if(corp2.t2u(l.corp_address1_line1+l.corp_address1_line2+l.corp_address1_line3)<>'',true,false);
			self.corp_address1_line1					:= if(address1_exists,l.corp_address1_line1,r.corp_address2_line1);
			self.corp_address1_line2					:= if(address1_exists,l.corp_address1_line2,r.corp_address2_line2);
			self.corp_address1_line3					:= if(address1_exists,l.corp_address1_line3,r.corp_address2_line3);
			self.corp_address1_type_cd				:= if(address1_exists,l.corp_address1_type_cd,r.corp_address2_type_cd);
			self.corp_address1_type_desc			:= if(address1_exists,l.corp_address1_type_desc,r.corp_address2_type_desc);
			self.corp_prep_addr1_line1				:= if(address1_exists,l.corp_prep_addr1_line1,r.corp_prep_addr2_line1);
			self.corp_prep_addr1_last_line		:= if(address1_exists,l.corp_prep_addr1_last_line,r.corp_prep_addr2_last_line);								
			self.corp_address2_line1					:= if(address1_exists,l.corp_address2_line1,'');
			self.corp_address2_line2					:= if(address1_exists,l.corp_address2_line2,'');
			self.corp_address2_line3					:= if(address1_exists,l.corp_address2_line3,'');
			self.corp_address2_type_cd				:= if(address1_exists,l.corp_address2_type_cd,'');
			self.corp_address2_type_desc			:= if(address1_exists,l.corp_address2_type_desc,'');							
			self.corp_prep_addr2_line1				:= if(address1_exists,l.corp_prep_addr2_line1,'');
			self.corp_prep_addr2_last_line		:= if(address1_exists,l.corp_prep_addr2_last_line,'');
			self 															:= l;
		end; 
		
		//This rollup maps the "mailing" address that exists in the corp_address2_* fields to the corp_address1_* fields
		//if no address exists in the "corp_address1_* fields.  Also, the "non-mailing" addresses are rolled
		//with their respective "mailing" address if multiple addresses exist.
		RolledupAddress := rollup( MailAddrMoved
															,rollupaddress(left, right)
															,except 
															 corp_address1_line1
															,corp_address1_line2
															,corp_address1_line3
															,corp_address1_type_cd
															,corp_address1_type_desc
															,corp_prep_addr1_line1
															,corp_prep_addr1_last_line
															,corp_address2_line1
															,corp_address2_line2
															,corp_address2_line3
															,corp_address2_type_cd
															,corp_address2_type_desc
															,corp_prep_addr2_line1
															,corp_prep_addr2_last_line
															,local
														 );

		//The above rollup did not handle addresses where there was only one record (so no rollup performed) but they still
		//had a "mailing" address in the "corp_address2_*" fields and no address in the "corp_address1_* fields and therefore, 
		//the "corp2_address2_*" fields needed to be moved to "corp_address1_*" fields.  This project maps the "mailing"
		//address that exists in the "corp_address2_*" fields to the "corp_address1_*" fields if no "corp_address1_*" exists.
		MapCorpAgents		:= project(RolledUpAddress,
											 transform(corp2_mapping.LayoutsCommon.main,
																 address1_exists									:= if(corp2.t2u(left.corp_address1_line1+left.corp_address1_line2+left.corp_address1_line3)<>'',true,false);
																 self.corp_address1_line1					:= if(address1_exists,left.corp_address1_line1,left.corp_address2_line1);
																 self.corp_address1_line2					:= if(address1_exists,left.corp_address1_line2,left.corp_address2_line2);
																 self.corp_address1_line3					:= if(address1_exists,left.corp_address1_line3,left.corp_address2_line3);
																 self.corp_address1_type_cd				:= if(address1_exists,left.corp_address1_type_cd,left.corp_address2_type_cd);
																 self.corp_address1_type_desc			:= if(address1_exists,left.corp_address1_type_desc,left.corp_address2_type_desc);
																 self.corp_prep_addr1_line1				:= if(address1_exists,left.corp_prep_addr1_line1,left.corp_prep_addr2_line1);
																 self.corp_prep_addr1_last_line		:= if(address1_exists,left.corp_prep_addr1_last_line,left.corp_prep_addr2_last_line);								
																 self.corp_address2_line1					:= if(address1_exists,left.corp_address2_line1,'');		
																 self.corp_address2_line2					:= if(address1_exists,left.corp_address2_line2,'');
																 self.corp_address2_line3					:= if(address1_exists,left.corp_address2_line3,'');
																 self.corp_address2_type_cd				:= if(address1_exists,left.corp_address2_type_cd,'');
																 self.corp_address2_type_desc			:= if(address1_exists,left.corp_address2_type_desc,'');							
																 self.corp_prep_addr2_line1				:= if(address1_exists,left.corp_prep_addr2_line1,'');
																 self.corp_prep_addr2_last_line		:= if(address1_exists,left.corp_prep_addr2_last_line,'');
																 self 															:= left;
																)
												);
													 
		//********************************************************************
		//MAPPING MAIN
		//NOTE: Map the joined CorpsEntities and Agents File as contacts
		//********************************************************************			
		Corp2_Mapping.LayoutsCommon.Main CorpAgentsContTransform(Corp2_Raw_LA.Layouts.Temp_CorpAgents l) := transform,
		skip(corp2_mapping.fCleanBusinessName(state_origin,state_desc,l.firstname+' '+l.lastname).BusinessName='')
			self.dt_vendor_first_reported							:= (integer)fileDate;
			self.dt_vendor_last_reported							:= (integer)fileDate;
			self.dt_first_seen												:= (integer)fileDate;
			self.dt_last_seen													:= (integer)fileDate;
			self.corp_ra_dt_first_seen								:= (integer)fileDate;
			self.corp_ra_dt_last_seen									:= (integer)fileDate;			
			self.corp_key															:= state_fips + '-' + corp2.t2u(stringlib.stringfilterout(l.entityid,'.')); //remove any periods
			self.corp_vendor													:= state_fips;
			self.corp_state_origin										:= state_origin;			
			self.corp_process_date										:= fileDate;		
     	self.corp_orig_sos_charter_nbr        		:= corp2.t2u(stringlib.stringfilterout(l.entityid,'.')); //remove any periods
		  self.corp_legal_name                  		:= Corp2_mapping.fCleanBusinessName(state_origin,state_desc,l.entityname).BusinessName;
		  self.corp_inc_state                 		  := state_origin;
			self.cont_full_name												:= Corp2_Mapping.fCleanBusinessName(state_origin,state_desc,l.firstname+' '+l.lastname).BusinessName;
      self.cont_type_cd   	                		:= 'T';
	    self.cont_type_desc                   		:= 'CONTACT';
			self.cont_title1_desc             	  		:= corp2.t2u(l.titles);
			self.cont_address_line1										:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.agent_address1,l.agent_address2,l.agent_city,l.agent_state,l.postalcode).AddressLine1;
			self.cont_address_line2										:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.agent_address1,l.agent_address2,l.agent_city,l.agent_state,l.postalcode).AddressLine2;
			self.cont_address_line3										:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.agent_address1,l.agent_address2,l.agent_city,l.agent_state,l.postalcode).AddressLine3;
			self.cont_prep_addr_line1									:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.agent_address1,l.agent_address2,l.agent_city,l.agent_state,l.postalcode).PrepAddrLine1;
			self.cont_prep_addr_last_line							:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.agent_address1,l.agent_address2,l.agent_city,l.agent_state,l.postalcode).PrepAddrLastLine;
			self.cont_address_type_cd             		:= if(Corp2_Mapping.fAddressExists(state_origin,state_desc,self.cont_address_line1,self.cont_address_line2+self.cont_address_line3,l.agent_city,l.agent_state,l.postalcode).ifAddressExists,'T','');
      self.cont_address_type_desc           		:= if(Corp2_Mapping.fAddressExists(state_origin,state_desc,self.cont_address_line1,self.cont_address_line2+self.cont_address_line3,l.agent_city,l.agent_state,l.postalcode).ifAddressExists,'CONTACT','');
			self.cont_email_address										:= corp2.t2u(l.emailaddress);
			self.recordorigin													:= 'T';			
      self                                  		:= [];
		end;
		
		Contacts 				:= CorpAgentsJoin(not(HasCorpAgents));
		MapOfficers			:= project(Contacts,CorpAgentsContTransform(left));

		//********************************************************************
		//MAPPING MAIN
		//NOTE: Map the NameReservs File as corporation
		//********************************************************************
		jNameReservs	:= join(NameReservs, CorpsEntities, 
													corp2.t2u(stringlib.stringfilterout(left.reservationnumber,'.')) = corp2.t2u(stringlib.stringfilterout(right.entityid,'.')),
													transform(Corp2_Raw_LA.Layouts.NameReservs_TempLay, 
																		 self.chartercategory  := right.chartercategory;
																		 self.entitystartdate  := right.entitystartdate;
																		 self := left; self := right; self := [];),
													left outer,local) : independent;
		
		Corp2_Mapping.LayoutsCommon.Main NameReservsCorpTransform(Corp2_Raw_LA.Layouts.NameReservs_TempLay l) := transform
			self.dt_vendor_first_reported							:= (integer)fileDate;
			self.dt_vendor_last_reported							:= (integer)fileDate;
			self.dt_first_seen												:= (integer)fileDate;
			self.dt_last_seen													:= (integer)fileDate;
			self.corp_ra_dt_first_seen								:= (integer)fileDate;
			self.corp_ra_dt_last_seen									:= (integer)fileDate;			
			self.corp_key															:= state_fips + '-' + corp2.t2u(stringlib.stringfilterout(l.reservationnumber,'.')); //remove any periods
			self.corp_vendor													:= state_fips;
			self.corp_state_origin										:= state_origin;			
			self.corp_process_date										:= fileDate;		     	
    	self.corp_orig_sos_charter_nbr        		:= corp2.t2u(stringlib.stringfilterout(l.reservationnumber,'.')); //remove any periods
			self.corp_legal_name                  		:= Corp2_mapping.fCleanBusinessName(state_origin,state_desc,l.namereserved).BusinessName;
			self.corp_ln_name_type_cd             		:= '07';
			self.corp_ln_name_type_desc           		:= 'RESERVED';
			self.corp_name_comment                		:= corp2.t2u(l.namereservationtype);	//overloaded field
			self.corp_filing_date                 		:= Corp2_Mapping.fValidateDate(l.datereserved,'CCYY-MM-DD').PastDate;	//overloaded field
      self.corp_filing_desc            	  			:= if(self.corp_filing_date<>'','RESERVED','');					//overloaded field
      self.corp_status_desc                			:= map(corp2.t2u(l.isactive) = '0' => 'NOT CURRENT',		//overloaded field
																											 corp2.t2u(l.isactive) = '1' => 'CURRENT',
																											 ''
																											);
		  self.corp_inc_state                 		  := state_origin;																											
			self.corp_term_exist_exp  		            := Corp2_Mapping.fValidateDate(l.dateexpiration[1..10],'CCYY-MM-DD').GeneralDate; //overloaded
			self.corp_term_exist_cd               		:= if(self.corp_term_exist_exp <> '','D',''); 																											 //overloaded
			self.corp_term_exist_desc             		:= if(self.corp_term_exist_exp <> '','EXPIRATION DATE','');																					 //overloaded
      self.corp_name_reservation_date						:= Corp2_Mapping.fValidateDate(l.datereserved[1..10],'CCYY-MM-DD').PastDate;
      self.corp_name_reservation_expiration_date:= Corp2_Mapping.fValidateDate(l.dateexpiration[1..10],'CCYY-MM-DD').GeneralDate;
      self.corp_name_reservation_nbr						:= corp2.t2u(l.reservationnumber);
			self.corp_name_reservation_type						:= corp2.t2u(l.namereservationtype);
      self.corp_name_status_cd									:= corp2.t2u(l.isactive);
      self.corp_name_status_desc								:= map(corp2.t2u(l.isactive) = '1' => 'ACTIVE',
																											 corp2.t2u(l.isactive) = '0' => 'INACTIVE',
																											 ''
																											);
			self.corp_inc_date                    		:= if(corp2.t2u(l.chartercategory) in DomesticCharterList,Corp2_Mapping.fValidateDate(l.entitystartdate[1..10],'CCYY-MM-DD').PastDate,''); 
			self.corp_forgn_date											:= if(corp2.t2u(l.chartercategory) in ForeignCharterList,Corp2_Mapping.fValidateDate(l.entitystartdate[1..10],'CCYY-MM-DD').PastDate,'');
			self.recordorigin													:= 'C';																											
		  self                                  		:= [];
		
    end;

		MapNameReservsCorp		:= project(jNameReservs,NameReservsCorpTransform(left));	

		//********************************************************************
		//MAPPING MAIN
		//NOTE: Map the NameReservs File as contact
		//********************************************************************		
		Corp2_Mapping.LayoutsCommon.Main NameReservContTransform(Corp2_Raw_LA.Layouts.NameReservsLayoutIn l) := transform,
		skip(corp2_mapping.fCleanBusinessName(state_origin,state_desc,l.contactperson).BusinessName='')		
			self.dt_vendor_first_reported							:= (integer)fileDate;
			self.dt_vendor_last_reported							:= (integer)fileDate;
			self.dt_first_seen												:= (integer)fileDate;
			self.dt_last_seen													:= (integer)fileDate;
			self.corp_ra_dt_first_seen								:= (integer)fileDate;
			self.corp_ra_dt_last_seen									:= (integer)fileDate;			
			self.corp_key															:= state_fips + '-' + corp2.t2u(stringlib.stringfilterout(l.reservationnumber,'.')); //remove any periods
			self.corp_vendor													:= state_fips;
			self.corp_state_origin										:= state_origin;			
			self.corp_process_date										:= fileDate;		     	
    	self.corp_orig_sos_charter_nbr        		:= corp2.t2u(stringlib.stringfilterout(l.reservationnumber,'.')); //remove any periods
			self.corp_legal_name                  		:= Corp2_mapping.fCleanBusinessName(state_origin,state_desc,l.namereserved).BusinessName;
		  self.corp_inc_state                 		  := state_origin;																											
			self.cont_type_cd               	  			:= if(Corp2_Mapping.fCleanPersonName(state_origin,state_desc,'','',l.contactperson).LastName<>'','01','');
			self.cont_type_desc               	  		:= if(Corp2_Mapping.fCleanPersonName(state_origin,state_desc,'','',l.contactperson).LastName<>'','RESERVER','');
			self.cont_full_name												:= Corp2_Mapping.fCleanBusinessName(state_origin,state_desc,l.contactperson).BusinessName;
			self.cont_address_line1										:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.address1,l.address2,l.city,l.stateorprovince,l.zipcode,l.country).AddressLine1;
			self.cont_address_line2										:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.address1,l.address2,l.city,l.stateorprovince,l.zipcode,l.country).AddressLine2;
			self.cont_address_line3										:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.address1,l.address2,l.city,l.stateorprovince,l.zipcode,l.country).AddressLine3;
			self.cont_address_type_cd             		:= if(Corp2_Mapping.fAddressExists(state_origin,state_desc,self.cont_address_line1,self.cont_address_line2+self.cont_address_line3,l.city,l.stateorprovince,l.zipcode,l.country).ifAddressExists,'T','');
      self.cont_address_type_desc           		:= if(Corp2_Mapping.fAddressExists(state_origin,state_desc,self.cont_address_line1,self.cont_address_line2+self.cont_address_line3,l.city,l.stateorprovince,l.zipcode,l.country).ifAddressExists,'CONTACT','');		
			self.cont_prep_addr_line1									:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.address1,l.address2,l.city,l.stateorprovince,l.zipcode,l.country).PrepAddrLine1;
			self.cont_prep_addr_last_line							:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.address1,l.address2,l.city,l.stateorprovince,l.zipcode,l.country).PrepAddrLastLine;			
			self.cont_country													:= Corp2_Raw_LA.Functions.CountryCodeTranslation(state_origin,state_desc,l.country); 
			self.recordorigin													:= 'T';			
			self                                  		:= [];
		end;

		MapNameReservsCont			:= project(NameReservs,NameReservContTransform(left));

		//This normalize transform for the TradeServices' file normalizes on documenttype within EntityFilings.
		//Note: The left parameter is the parent record, right parameter is the TradeServices' child dataset.				
		TradeDocTypeNorm			:= normalize(TradeServices,
																			 left.Amendment,
																			 transform(Corp2_Raw_LA.Layouts.AmendmentChild,
																								 self.amend_entityid 								:= left.trade_entityid;
																								 self         											:= right;
																								),
																			 local
																			);

		//This normalize transform for the TradeServices' file normalizes on previousapplicantname within previousapplicants.
		//Note: The left parameter is the parent record, right parameter is the TradeServices' child dataset.				
		TradePrevAppNorm 		:= normalize(TradeServices,
																		 left.previousapp,
																		 transform(Corp2_Raw_LA.Layouts.PreviousAppChild,
																							 self.previousapp_entityid 					:= left.trade_entityid;
																							 self         											:= right;
																							),
																		 local
																		);

		//This normalize transform for the TradeServices' file normalizes on "class".
		//Note: The left parameter is the parent record, right parameter is the TradeServices' child dataset.
		TradeClassNorm				:= normalize(TradeServices,
																			 left.RegEntity,
																			 transform(Corp2_Raw_LA.Layouts.RegClassChild,
																								 self.regentity_entityid 						:= left.trade_entityid;
																								 self         											:= right;
																								),
																			 local
																			);
																				
		TradeDocTypeNormSort	:= sort(distribute(TradeDocTypeNorm, hash(amend_entityid)),amend_entityid,local) : independent;
																
		//Join the normalized Document Type records to the TradeServices' file.
		TradeDocTypeJoin			:= join(TradeServices,TradeDocTypeNormSort,
																	left.trade_EntityID = right.amend_entityid,
																	transform(Corp2_Raw_LA.Layouts.Temp_Trade,
																						self.documenttype  											:= right.documenttype;
																						self.dateofamendment    								:= right.dateofamendment;			
																						self.amendmentnumber   									:= right.amendmentnumber;				
																						self																		:= left;
																					 ),
																	left outer,
																	local
																 );

		TradeDocTypeJoinSort := sort(distribute(TradeDocTypeJoin, hash(trade_entityid)),trade_entityid,local) : independent;
		TradePrevAppNormSort := sort(distribute(TradePrevAppNorm, hash(previousapp_entityid)),previousapp_entityid,local) : independent;
		
		//Now join the normalized Previous Applicant records to the TradeServices' file.
		DocTypePrevAppJoin		:= join(TradeDocTypeJoinSort,TradePrevAppNormSort,
																	left.trade_entityid = right.previousapp_entityid,
																	transform(Corp2_Raw_LA.Layouts.Temp_TradePrevApp,
																						self.previousapplicantname  							:= right.previousapplicantname;	
																						self.previousapplicantadd   							:= right.previousapplicantadd;			
																						self.dateofchange   											:= right.dateofchange;				
																						self																			:= left;
																					 ),
																	left outer,
																	local
																 );
		
		DocTypePrevAppJoinSort  := sort(distribute(DocTypePrevAppJoin, hash(trade_entityid)),trade_entityid,local) : independent;
		TradeClassNormSort      := sort(distribute(TradeClassNorm, hash(regentity_entityid)),regentity_entityid,local) : independent;
		
		TradeDocPrevClassJoin   := join(DocTypePrevAppJoinSort,TradeClassNormSort,
																	  left.trade_entityid = right.regentity_entityid,
																	  transform(Corp2_Raw_LA.Layouts.Temp_TradePrevAppClass,
																						  self.classification											:= right.classification;
																						  self																			:= left;
																						 ),
																	  left outer,
																	  local
																	 );

		TradeServicesJoin	     := project(TradeDocPrevClassJoin,
																			transform(Corp2_Raw_LA.Layouts.Temp_TradePrevAppAddress,
																								address 		 													:= stringlib.splitwords(left.previousApplicantAdd,'/',true)[1];
																								citystatezip 													:= stringlib.splitwords(left.previousApplicantAdd,'/',true)[2];
																								city																	:= stringlib.splitwords(citystatezip,',',true)[1];
																								statezip															:= stringlib.splitwords(citystatezip,',',true)[2];	
																								self.prevapp_addr											:= corp2.t2u(address);
																								self.prevapp_city											:= corp2.t2u(city);
																								self.prevapp_st												:= stringlib.stringfilterout(corp2.t2u(statezip),'0123456789'); //remove digits
																								self.prevapp_zip											:= stringlib.stringfilter(corp2.t2u(statezip),'0123456789'); 		//keep only digits
																								self																	:= left;
																							 )
																			) : independent;
																					
		//********************************************************************
		//MAPPING MAIN
		//NOTE: Map the TradeServices File as corporation
		//********************************************************************				
	  jTradeServicesJoin	:= join(TradeServicesJoin, CorpsEntities, 
													corp2.t2u(stringlib.stringfilterout(left.trade_entityid,'.')) = corp2.t2u(stringlib.stringfilterout(right.entityid,'.')),
													transform(Corp2_Raw_LA.Layouts.TradePrevAppAddress_TempLay, 
																		 self.chartercategory  := right.chartercategory;
																		 self.entitystartdate  := right.entitystartdate;
																		 self := left; self := right; self := [];),
													left outer,local) : independent;
	
		Corp2_Mapping.LayoutsCommon.Main  TradeServicesCorpTransform(Corp2_Raw_LA.Layouts.TradePrevAppAddress_TempLay l) := transform
			self.dt_vendor_first_reported							 	:= (integer)fileDate;
			self.dt_vendor_last_reported							 	:= (integer)fileDate;
			self.dt_first_seen												 	:= (integer)fileDate;
			self.dt_last_seen													 	:= (integer)fileDate;
			self.corp_ra_dt_first_seen								 	:= (integer)fileDate;
			self.corp_ra_dt_last_seen									 	:= (integer)fileDate;
			self.corp_key																:= state_fips + '-' + corp2.t2u(stringlib.stringfilterout(l.trade_entityid,'.')); //remove any periods
			self.corp_vendor														:= state_fips;
			self.corp_state_origin											:= state_origin;			
			self.corp_process_date											:= fileDate;		     	
    	self.corp_orig_sos_charter_nbr        			:= corp2.t2u(stringlib.stringfilterout(l.trade_entityid,'.')); //remove any periods
			self.corp_legal_name                  			:= Corp2_mapping.fCleanBusinessName(state_origin,state_desc,l.tradeservicename).BusinessName;
			self.corp_ln_name_type_cd             			:= map(corp2.t2u(l.trademarktype) 		= 'YES' => '03',
																											   corp2.t2u(l.tradenametype) 		= 'YES'	=> '04',
																											   corp2.t2u(l.servicemarktype)	  = 'YES'	=> '05',
																											   ''
																											  );
			self.corp_ln_name_type_desc             	 	:= map(corp2.t2u(l.trademarktype) 		= 'YES' => 'TRADEMARK',
																											   corp2.t2u(l.tradenametype) 		= 'YES'	=> 'TRADENAME',
																											   corp2.t2u(l.servicemarktype)	  = 'YES'	=> 'SERVICEMARK',
																											   ''
																											  );																											
			self.corp_filing_date                 		 	:= if(self.corp_ln_name_type_cd in ['04','05'],Corp2_Mapping.fValidateDate(l.registereddate,'CCYY-MM-DD').PastDate,'');
			self.corp_filing_desc            	  			 	:= if(self.corp_filing_date <> '','REGISTRATION','');
			self.corp_status_desc                 		 	:= if(self.corp_ln_name_type_cd in ['04','05'],corp2.t2u(l.status),'');	
			self.corp_inc_state                   		 	:= state_origin;
			self.corp_term_exist_exp              		 	:= if(self.corp_ln_name_type_cd in ['04','05'],Corp2_Mapping.fValidateDate(l.dateofexpiration,'CCYY-MM-DD').GeneralDate,'');
			self.corp_term_exist_cd               		 	:= if(self.corp_term_exist_exp<>'','D',''); 
			self.corp_term_exist_desc             		 	:= if(self.corp_term_exist_exp<>'','EXPIRATION DATE','');										 
			self.corp_foreign_domestic_ind						 	:= map(corp2.t2u(l.corporatestate) = '' 		 				 										 										 => '', //most values are blank
																											   corp2.t2u(l.corporatestate) in [state_origin,state_desc]															 => 'D',
																											   stringlib.stringfind(corp2.t2u(l.corporatestate),'UNKNOWN',1)<> 0 										 => '', //per CI will find either UNKNOWN OR UNKNOWN STATE
																											   Corp2_Raw_LA.Functions.CorpForgnStateCD(state_origin,state_desc,l.corporatestate)<>'' => 'F',
																												 ''
																											  );
			self.corp_forgn_state_cd              		 	:= if(corp2.t2u(l.corporatestate) not in [state_origin,state_desc,''],Corp2_Raw_LA.Functions.CorpForgnStateCD(state_origin,state_desc,l.corporatestate),''); //most values are blank
			self.corp_forgn_state_desc            		 	:= if(self.corp_forgn_state_cd<>'',Corp2_Raw_LA.Functions.CorpForgnStateDesc(state_origin,state_desc,l.corporatestate),''); //most values are blank
			self.corp_orig_bus_type_desc          		 	:= if(self.corp_ln_name_type_cd in ['04','05'],Corp2_Raw_LA.Functions.CorpOrigBusTypeDesc(l.classification),'');			
      self.corp_entity_desc                 		 	:= if(self.corp_ln_name_type_cd in ['04','05'],corp2.t2u(l.businessdescription),'');
			//This is an overloaded field.
			self.corp_addl_info                   		 	:= if(self.corp_ln_name_type_cd in ['03','04','05'],Corp2_Raw_LA.Functions.CorpAddlInfo(l.firstdateusedinlouisiana,l.firstuseddate),'');	
			self.corp_trademark_first_use_date				 	:= if(self.corp_ln_name_type_cd = '03',Corp2_Mapping.fValidateDate(l.firstuseddate[1..10],'CCYY-MM-DD').PastDate,'');
			self.corp_trademark_first_use_date_in_state	:= if(self.corp_ln_name_type_cd = '03',Corp2_Mapping.fValidateDate(l.firstdateusedinlouisiana[1..10],'CCYY-MM-DD').PastDate,'');
			self.corp_trademark_class_desc1		 				 	:= if(self.corp_ln_name_type_cd = '03',corp2.t2u(l.businessdescription),'');
			self.corp_trademark_expiration_date				 	:= if(self.corp_ln_name_type_cd = '03',Corp2_Mapping.fValidateDate(l.dateofexpiration[1..10],'CCYY-MM-DD').GeneralDate,'');
			self.corp_trademark_filing_date						 	:= if(self.corp_ln_name_type_cd = '03',Corp2_Mapping.fValidateDate(l.registereddate[1..10],'CCYY-MM-DD').PastDate,'');
			self.corp_trademark_status								 	:= if(self.corp_ln_name_type_cd = '03',corp2.t2u(l.status),'');
			self.corp_inc_date                    		  := if(corp2.t2u(l.chartercategory) in DomesticCharterList,Corp2_Mapping.fValidateDate(l.entitystartdate[1..10],'CCYY-MM-DD').PastDate,''); 
			self.corp_forgn_date											  := if(corp2.t2u(l.chartercategory) in ForeignCharterList,Corp2_Mapping.fValidateDate(l.entitystartdate[1..10],'CCYY-MM-DD').PastDate,'');
			self.recordorigin													 	:= 'C';			
		  self                                  		 	:= [];
    end;

		MapTradeServicesCorp				:= project(jTradeServicesJoin,TradeServicesCorpTransform(left));

		//********************************************************************
		//MAPPING MAIN
		//NOTE: Map the TradeServices File as contact
		//********************************************************************		
		Corp2_Mapping.LayoutsCommon.Main TradeServicesContTransform(Corp2_Raw_LA.Layouts.Temp_TradePrevAppAddress l) := transform,
		skip(corp2_mapping.fCleanBusinessName(state_origin,state_desc,l.applicantname).BusinessName='')		
			self.dt_vendor_first_reported								:= (integer)fileDate;
			self.dt_vendor_last_reported								:= (integer)fileDate;
			self.dt_first_seen													:= (integer)fileDate;
			self.dt_last_seen														:= (integer)fileDate;
			self.corp_ra_dt_first_seen									:= (integer)fileDate;
			self.corp_ra_dt_last_seen										:= (integer)fileDate;			
			self.corp_key																:= state_fips + '-' + corp2.t2u(stringlib.stringfilterout(l.trade_entityid,'.')); //remove any periods
			self.corp_vendor														:= state_fips;
			self.corp_state_origin											:= state_origin;			
			self.corp_process_date											:= fileDate;		     	
    	self.corp_orig_sos_charter_nbr        			:= corp2.t2u(stringlib.stringfilterout(l.trade_entityid,'.')); //remove any periods
			self.corp_legal_name                  			:= Corp2_mapping.fCleanBusinessName(state_origin,state_desc,l.tradeservicename).BusinessName;
			self.corp_ln_name_type_cd             			:= map(corp2.t2u(l.trademarktype) 		= 'YES' => '03',
																												 corp2.t2u(l.tradenametype) 		= 'YES'	=> '04',
																												 corp2.t2u(l.servicemarktype)		= 'YES'	=> '05',
																												 ''
																												);
			self.corp_ln_name_type_desc             		:= map(corp2.t2u(l.trademarktype) 		= 'YES' => 'TRADEMARK',
																												 corp2.t2u(l.tradenametype) 		= 'YES'	=> 'TRADENAME',
																												 corp2.t2u(l.servicemarktype)		= 'YES'	=> 'SERVICEMARK',
																												 ''
																												);					
		  self.corp_inc_state                 		  	:= state_origin;
			self.cont_full_name													:= Corp2_Mapping.fCleanBusinessName(state_origin,state_desc,l.applicantname).BusinessName;
			self.cont_type_cd               	  				:= if(self.cont_full_name<>'','I','');
      self.cont_type_desc               	  			:= if(self.cont_full_name<>'','APPLICANT','');
			self.cont_address_line1											:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.addressline1,,l.trade_city,l.state,l.postalcode,l.trade_country).AddressLine1;
			self.cont_address_line2											:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.addressline1,,l.trade_city,l.state,l.postalcode,l.trade_country).AddressLine2;
			self.cont_address_line3											:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.addressline1,,l.trade_city,l.state,l.postalcode,l.trade_country).AddressLine3;
			self.cont_address_type_cd             			:= if(Corp2_Mapping.fAddressExists(state_origin,state_desc,self.cont_address_line1,self.cont_address_line2+self.cont_address_line3,l.trade_city,l.state,l.postalcode,l.trade_country).ifAddressExists,'T','');
      self.cont_address_type_desc           			:= if(Corp2_Mapping.fAddressExists(state_origin,state_desc,self.cont_address_line1,self.cont_address_line2+self.cont_address_line3,l.trade_city,l.state,l.postalcode,l.trade_country).ifAddressExists,'CONTACT','');
			self.cont_prep_addr_line1										:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.addressline1,,l.trade_city,l.state,l.postalcode,l.trade_country).PrepAddrLine1;
			self.cont_prep_addr_last_line								:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.addressline1,,l.trade_city,l.state,l.postalcode,l.trade_country).PrepAddrLastLine;			
			self.cont_country														:= Corp2_Raw_LA.Functions.CountryCodeTranslation(state_origin,state_desc,l.trade_country); 
			self.recordorigin														:= 'T';
      self                              					:= [];
		end;
		
		MapTradeServicesCont			:= project(TradeServicesJoin,TradeServicesContTransform(left));
		
		//This normalize transform for the PreviousNames' file normalizes on previousentitynames.
		//Note: The left parameter is the parent record, right parameter is the PreviousNames' child dataset.
		PreviousNamesNorm					:= normalize(PreviousNames,
																					 left.previousnames,
																					 transform(Corp2_Raw_LA.Layouts.PreviousNameChild,
																										 self.prev_name_entityid						:= left.pre_entityid;
																										 self         											:= right;
																										),
																					 local
																					);
																				
		PreviousNamesNormSort  		:= sort(distribute(PreviousNamesNorm, hash(prev_name_entityid)),prev_name_entityid,local) : independent;
		
		//Join the normalized "PreviousNames" file to the PreviousNames' raw file.
		PrevNameJoin 							:= join(PreviousNames,PreviousNamesNormSort,
																			left.pre_entityid = right.prev_name_entityid,
																			transform(Corp2_Raw_LA.Layouts.Temp_PreviousName,
																								self.previousentityname  								:= right.previousentityname;
																								self.dateofchange1											:= right.dateofchange1;	
																								self.amendmentnumber1  									:= right.amendmentnumber1;
																								self         														:= left;
																							 ),
																			left outer,
																			local
																		 );
																	 
		PrevNameJoinSorted 			:= sort(distribute(PrevNameJoin, hash(pre_entityid)),pre_entityid,local) : independent;															 
																	 
		//Join the normalized "PreviousNames" file to the CorpsEntities' raw file.
		PrevNameCorpsJoin 			:= join(CorpsEntities,PrevNameJoinSorted,
																			left.entityid = right.pre_entityid,
																			transform(Corp2_Raw_LA.Layouts.Temp_PreviousName,
																								self         														:= right;
																							 ),
																			inner,
																			local
																		 ) : independent;
																	 
		//********************************************************************
		//MAPPING MAIN
		//NOTE: Map the PreviousNames File as corporation
		//********************************************************************		
		jPrevNameCorpsJoin	:= join(PrevNameCorpsJoin, CorpsEntities, 
													corp2.t2u(stringlib.stringfilterout(left.Pre_EntityID,'.')) = corp2.t2u(stringlib.stringfilterout(right.entityid,'.')),
													transform(Corp2_Raw_LA.Layouts.PreviousNames_TempLay, 
																		 self.chartercategory  := right.chartercategory;
																		 self.entitystartdate  := right.entitystartdate;
																		 self := left; self := right; self := [];),
													left outer,local) : independent;
		
		Corp2_Mapping.LayoutsCommon.Main PreviousNamesCorpTransform(Corp2_Raw_LA.Layouts.PreviousNames_TempLay l) := transform,
		skip(Corp2_mapping.fCleanBusinessName(state_origin,state_desc,l.previousentityname).BusinessName = '')
			self.dt_vendor_first_reported							 	:= (integer)fileDate;
			self.dt_vendor_last_reported								:= (integer)fileDate;
			self.dt_first_seen													:= (integer)fileDate;
			self.dt_last_seen														:= (integer)fileDate;
			self.corp_ra_dt_first_seen									:= (integer)fileDate;
			self.corp_ra_dt_last_seen										:= (integer)fileDate;			
			self.corp_key																:= state_fips + '-' + corp2.t2u(stringlib.stringfilterout(l.pre_entityid,'.')); //remove any periods
			self.corp_vendor														:= state_fips;
			self.corp_state_origin											:= state_origin;			
			self.corp_process_date											:= fileDate;		     	
    	self.corp_orig_sos_charter_nbr        			:= corp2.t2u(stringlib.stringfilterout(l.pre_entityid,'.')); //remove any periods
		  self.corp_legal_name                  			:= Corp2_mapping.fCleanBusinessName(state_origin,state_desc,l.previousentityname).BusinessName;
			self.corp_ln_name_type_cd             			:= 'P';
			self.corp_ln_name_type_desc           			:= 'PRIOR';
		  self.corp_inc_state                 		  	:= state_origin;
			//Note: amendmentnumber1 (amendment number) now appears in an event record; removed from corp_name_comment
			self.corp_name_comment                			:= if(corp2.t2u(l.entitycurrentname)<>'','NAME CHANGED TO CURRENT NAME: '+corp2.t2u(l.entitycurrentname),'');
			self.corp_name_status_date									:= Corp2_Mapping.fValidateDate(l.dateofchange1,'CCYY-MM-DD').PastDate;
			self.corp_name_status_desc									:= if(self.corp_name_status_date<>'','DATE OF NAME CHANGE FILING','');			
		  self.corp_inc_date                    		:= if(corp2.t2u(l.chartercategory) in DomesticCharterList,Corp2_Mapping.fValidateDate(l.entitystartdate[1..10],'CCYY-MM-DD').PastDate,''); 
			self.corp_forgn_date											:= if(corp2.t2u(l.chartercategory) in ForeignCharterList,Corp2_Mapping.fValidateDate(l.entitystartdate[1..10],'CCYY-MM-DD').PastDate,'');
			self.recordorigin														:= 'C';			
			self                                  			:= [];
    end;
		
		MapPreviousNamesCorp	:= project(jPrevNameCorpsJoin,PreviousNamesCorpTransform(left));
		 
		AllMain		:= MapCorpAgents 							+ 
								 MapOfficers								+
								 MapPreviousNamesCorp			 	+
								 MapNameReservsCorp 				+ 
								 MapNameReservsCont 				+ 
								 MapTradeServicesCorp 			+ 
								 MapTradeServicesCont;
										 
		MapMain				:= dedup(sort(distribute(AllMain,hash(corp_key)),record,local),record,local) : independent;

		//********************************************************************
		//BEGIN MAPPING EVENTS
		//********************************************************************		
		Corp2_Mapping.LayoutsCommon.Events PreviousNamesEventTransform(Corp2_Raw_LA.Layouts.Temp_PreviousName l) := transform,
		skip(corp2.t2u(l.amendmentnumber1) = '' and corp2.t2u(l.previousentityname) = '' and
				 corp2_mapping.fvalidatedate(l.dateofchange1,'CCYY-MM-DD').pastdate = ''
				)
			self.corp_key																:= state_fips + '-' + corp2.t2u(stringlib.stringfilterout(l.pre_entityid,'.')); //remove any periods			
			self.corp_vendor														:= state_fips;
			self.corp_state_origin											:= state_origin;			
			self.corp_process_date											:= filedate; 
			self.corp_sos_charter_nbr										:= corp2.t2u(stringlib.stringfilterout(l.pre_entityid,'.')); //remove any periods
      self.event_filing_reference_nbr    					:= corp2.t2u(l.amendmentnumber1);
      self.event_filing_date            					:= Corp2_Mapping.fValidateDate(l.dateofchange1,'CCYY-MM-DD').PastDate;
      self.event_date_type_desc            				:= if(self.event_filing_date<>'','DATE NAME CHANGED','');
      self.event_desc                   					:= if(corp2.t2u(l.previousentityname)<>'','NAME CHANGED FROM: '+corp2.t2u(l.previousentityname),'');
      self                              					:= [];
		end;
		
		MapPreviousNameEvents		:= project(PrevNameCorpsJoin,PreviousNamesEventTransform(left));

		Corp2_Mapping.LayoutsCommon.Events TradeEventTransform(Corp2_Raw_LA.Layouts.Temp_TradePrevAppAddress l) := transform,
		skip(corp2.t2u(l.amendmentnumber) = '' and Corp2_Mapping.fValidateDate(l.dateofamendment[1..10],'CCYY-MM-DD').PastDate = '') 
			self.corp_key																:= state_fips + '-' + corp2.t2u(stringlib.stringfilterout(l.trade_entityid,'.')); //remove any periods
			self.corp_vendor														:= state_fips;
			self.corp_state_origin											:= state_origin;			
			self.corp_process_date											:= filedate;
			self.corp_sos_charter_nbr										:= corp2.t2u(stringlib.stringfilterout(l.trade_entityid,'.')); //remove any periods
			self.event_filing_reference_nbr							:= corp2.t2u(l.amendmentnumber);
			self.event_filing_date            					:= Corp2_Mapping.fValidateDate(l.dateofamendment[1..10],'CCYY-MM-DD').PastDate;
			self.event_date_type_desc										:= if(self.event_filing_date<>'','DATE OF AMENDMENT','');
		//The xpath is unknown to retrieve l.amendmenttype.  The data analyst has contacted the vendor.			
		//self.event_desc       		  		  					:= corp2.t2u(l.amendmenttype);
      self                              					:= [];
		end;

		HasNoARPT 							:= TradeServicesJoin.documenttype <> 'ANNRP';
		HasARPT									:= NOT(HasNoARPT);

		MapTradeServiceEvents 	:= project(TradeServicesJoin(HasNoARPT),TradeEventTransform(left));

		//This first normalize for the Mergers' file normalizes on mergerdate.
		//Note: The left parameter is the parent record, right parameter is the Merger child dataset.
		MergerDateNorm   				:= normalize(Mergers,
																				 left.mergers,
																				 transform(Corp2_Raw_LA.Layouts.MergersChild,
																									 self.merger_entityid 							:= left.merger_entityid;
																									 self								  							:= right;
																								  ),
																				 local
																				) : independent;

		//This second normalize for the Mergers' file normalizes on entitynames within the partiesinvolved.
		//Note: The left parameter is the parent record, right parameter is the Merger child dataset.
		MergerPartiesNorm  			:= normalize(MergerDateNorm,
																				 left.mergParties,
																				 transform(Corp2_Raw_LA.Layouts.MergerParties,
																									 self.entityid 											:= left.merger_entityid;
																									 self         											:= right;
																								  ),
																				 local
																				);
																				
		MergerDateNormSort   		:= sort(distribute(MergerDateNorm, hash(Merger_EntityID)),Merger_EntityID,local) : independent;
		//Join the normalized Merger dates to the Mergers' file.
		MergerDateJoin			 		:= join(Mergers,MergerDateNormSort,
																	  left.Merger_EntityID = right.Merger_EntityID,
																	  transform(Corp2_Raw_LA.Layouts.Temp_MergerEntity,
																						  self.mergerdate													:= right.mergerdate;		
																						  self.role																:= right.role;
																						  self         														:= left;
																						),
																	  left outer,
																		local
																	 );
		MergerDateJoinSort    	:= sort(distribute(MergerDateJoin, hash(Merger_EntityID)),Merger_EntityID,local) : independent;
    MergerPartiesNormSort 	:= sort(distribute(MergerPartiesNorm, hash(EntityID)),EntityID,local) : independent;
		
		//Join the normalized Merger Parties to the Mergers' file.
		MergerPartiesJoin		 		:= join(MergerDateJoinSort,MergerPartiesNormSort,
																	  left.Merger_EntityID = right.EntityID,
																	  transform(Corp2_Raw_LA.Layouts.Temp_Merger,
																						  self.merger_entityname 									:= right.merger_entityname;
																						  self									 									:= left;
																						 ),
																	  left outer,
																	  local
																	 );
																	 
    MergerPartiesJoinSort  	:= sort(distribute(MergerPartiesJoin, hash(merger_entityid)),merger_entityid,local) : independent;		
		//Join the CorpEntities "master" file to the normalized Merger file.
		CorpMergersJoin	 		  	:= join(CorpEntitiesJoinSort,MergerPartiesJoinSort,
																		corp2.t2u(left.entityid) = corp2.t2u(right.merger_entityid),
																		transform(Corp2_Raw_LA.Layouts.Temp_CorpMergers,
																							self 																		:= left;
																							self 																		:= right;
																							self 																		:= [];
																						 ),
																		inner,
																		local
																	 );

		Corp2_Mapping.LayoutsCommon.Events MergersEventTransform(Corp2_Raw_LA.Layouts.Temp_CorpMergers l) := transform,
		skip(corp2_mapping.fvalidatedate(l.mergerdate[1..10],'CCYY-MM-DD').PastDate = '' and
				 corp2.t2u(l.role+l.entityname) = ''
				)
			self.corp_key																:= state_fips + '-' + corp2.t2u(stringlib.stringfilterout(l.entityid,'.')); //remove any periods
			self.corp_vendor														:= state_fips;
			self.corp_state_origin											:= state_origin;			
			self.corp_process_date											:= filedate;
			self.corp_sos_charter_nbr										:= corp2.t2u(stringlib.stringfilterout(l.entityid,'.')); //remove any periods
      self.event_filing_date            					:= Corp2_Mapping.fValidateDate(l.mergerdate[1..10],'CCYY-MM-DD').PastDate;
      self.event_date_type_cd            					:= if(self.event_filing_date <> '','MER','');
      self.event_date_type_desc          					:= if(self.event_filing_date <> '','MERGER','');
      self.event_desc                   					:= corp2.t2u(l.role+' '+l.entityid+' '+l.entityname);
      self                              					:= [];
		end;
		
		MapMergersEvents		:= project(CorpMergersJoin,MergersEventTransform(left));
		
		//This normalize transform for the Filings' file normalizes on filingdate.
		//Note: The left parameter is the parent record, right parameter is the Filings' child dataset.
		FilingsDateNorm	 		:= normalize(Filings,
																		 left.filings,
																		 transform(Corp2_Raw_LA.Layouts.FilingsChild,
																							 self.filing_entityid 							:= left.filing_entityid;
																							 self							 									:= right;
																							),
																		 local
																		);
																				
		FilingsDateNormSort  := sort(distribute(FilingsDateNorm, hash(filing_entityid)),filing_entityid,local) : independent;																		
		//Join the normalized Filings' file back to the raw Filings' file.
		FilingsJoin			 	 	 := join(Filings,FilingsDateNormSort,
																 left.filing_entityid = right.filing_entityid,
																 transform(Corp2_Raw_LA.Layouts.Temp_Filings,
																					 self.filingdate													:= right.filingdate;			
																					 self.filingtype													:= right.filingtype;		
																					 self.filingid														:= right.filingid;
																					 self         														:= left;	
																					),
																  left outer,
																	local
																 );
   	
	  FilingsJoinSort      := sort(distribute(FilingsJoin, hash(filing_entityid)),filing_entityid,local) : independent;
   	CorpFilingsJoin	 		 := join(CorpEntitiesJoinSort,FilingsJoinSort,
																 corp2.t2u(left.entityid) = corp2.t2u(right.filing_entityid),
																 transform(Corp2_Raw_LA.Layouts.Temp_CorpFilings,
																	 				 self         														:= left;	
																					 self																		:= right;
																					 self         														:= [];
																					),
																 left outer,
																 local
																) : independent;

		//Map the normalized Filings File
		Corp2_Mapping.LayoutsCommon.Events EventTransform(Corp2_Raw_LA.Layouts.Temp_CorpFilings l) := transform
			self.corp_key																:= state_fips + '-' + corp2.t2u(stringlib.stringfilterout(l.entityid,'.')); //remove any periods
			self.corp_vendor														:= state_fips;
			self.corp_state_origin											:= state_origin;			
			self.corp_process_date											:= filedate;
			self.corp_sos_charter_nbr										:= corp2.t2u(stringlib.stringfilterout(l.entityid,'.')); //remove any periods
      self.event_filing_reference_nbr   					:= corp2.t2u(l.filingid);
			self.event_filing_date            					:= Corp2_Mapping.fValidateDate(l.filingdate[1..10],'CCYY-MM-DD').PastDate;
			self.event_date_type_cd            					:= 'FIL';
			self.event_date_type_desc            				:= 'FILING';
      self.event_filing_cd                				:= corp2.t2u(l.filingtype);
			self.event_filing_desc 											:= Corp2_Raw_LA.Functions.EventFilingDesc(l.filingtype);
      self                                				:= [];
		end;

		HasNoAR 								:= CorpFilingsJoin.filingtype <> 'ANNRP' and stringlib.stringfind(corp2.t2u(CorpFilingsJoin.filingtype),'AR',1) <> 4;
		HasAR										:= NOT(HasNoAR);

		CorpFilingsEvents				:= project(CorpFilingsJoin(HasNoAR),EventTransform(left));
																	 
		MapCorpFilingsEvents	  := CorpFilingsEvents(corp2.t2u(event_filing_reference_nbr + event_filing_date + event_filing_cd + event_filing_desc)<>'');

		AllEvents   						:= MapPreviousNameEvents + MapMergersEvents + MapCorpFilingsEvents + MapTradeServiceEvents;

		HasDateNameChanged 	 		:=	AllEvents(event_date_type_desc 		 in ['DATE NAME CHANGED']);
		NoDateNameChanged 	 		:=	AllEvents(event_date_type_desc not in ['DATE NAME CHANGED']);

		//The "DATE NAME CHANGED" comes in the "previousnames" file and another "NMCHG" record comes in "filings" file.  Per
		//the CI, it was requested that these two records be joined together.  This join places the two records into one record.
		JoinedEvents				 	 	:=	join(NoDateNameChanged,HasDateNameChanged,
																		 left.corp_key 					= right.corp_key and
																		 left.event_filing_date = right.event_filing_date,
																		 transform(corp2_mapping.LayoutsCommon.events,
																							 self.event_date_type_desc := if(left.event_filing_cd = 'NMCHG','DATE NAME CHANGED',left.event_date_type_desc);
																							 self.event_desc 					 := if(left.event_filing_cd = 'NMCHG',right.event_desc,left.event_desc);
																							 self						 					 := left;
																							),
																		 full outer,
																		 local
																		);
																		
		MapEvents								:= dedup(sort(distribute(JoinedEvents(corp2.t2u(corp_key)<>''),hash(corp_key)),record,local),record,local) : independent;

		//********************************************************************
		//BEGIN MAPPING AR
		//********************************************************************	
		CorpFilingsJoinSort     := sort(distribute(CorpFilingsJoin, hash(EntityID)),EntityID,local) : independent;
		TradeServicesJoinSort   := sort(distribute(TradeServicesJoin, hash(trade_EntityID)),trade_EntityID,local) : independent;
   	CorpFilingsJoinTrade    := join(CorpFilingsJoinSort,TradeServicesJoinSort,
																		corp2.t2u(left.EntityID) = corp2.t2u(right.trade_EntityID),
																		transform(Corp2_Raw_LA.Layouts.Temp_CorpFilingsTrade,
																						  self																			:= left;
																						  self																			:= right;
																					   ),
																		left outer
																	 );

		Corp2_Mapping.LayoutsCommon.AR arTransform(Corp2_Raw_LA.Layouts.Temp_CorpFilingsTrade l) := transform
			self.corp_key																:= state_fips + '-' + corp2.t2u(stringlib.stringfilterout(l.entityid,'.')); //remove any periods
			self.corp_vendor														:= state_fips;
			self.corp_state_origin											:= state_origin;			
			self.corp_process_date											:= filedate;
			self.corp_sos_charter_nbr										:= corp2.t2u(stringlib.stringfilterout(l.entityid,'.')); //remove any periods
      self.ar_year                      					:= if(ut.isNumeric(l.filingtype[1..2]),corp2.t2u(l.filingtype[1..2]),'');
      self.ar_filed_dt                 						:= Corp2_Mapping.fValidateDate(l.filingdate[1..10],'CCYY-MM-DD').PastDate;
			self.ar_report_nbr               					 	:= if((integer)(string)corp2.t2u(l.FilingID)<>0 ,corp2.t2u(l.FilingID),'');
			self.ar_comment                   					:= 'ANNUAL REPORT'; 										
			self                             					  := [];
	  end;

		HasANNRP		:= corp2.t2u(CorpFilingsJoinTrade.filingtype)		='ANNRP' or
									 corp2.t2u(CorpFilingsJoinTrade.documenttype)	='ANNRP' or
									 stringlib.stringfind(corp2.t2u(CorpFilingsJoinTrade.filingtype),'AR',1)<>0;
		
		AR					:= project(CorpFilingsJoinTrade(HasANNRP),arTransform(left));
		MapAR				:= dedup(sort(distribute(AR(ar_report_nbr<>'' or ar_filed_dt<>'' or ar_year<>''),hash(corp_key)),record,local),record,local) : independent;

	//********************************************************************
  // SCRUB AR 
  //********************************************************************	
		AR_F := mapAR;
		AR_S := Scrubs_Corp2_Mapping_LA_AR.Scrubs;				// Scrubs module
		AR_N := AR_S.FromNone(AR_F); 											// Generate the error flags
		AR_T := AR_S.FromBits(AR_N.BitmapInfile);     		// Use the FromBits module; makes my bitmap datafile easier to get to
		AR_U := AR_S.FromExpanded(AR_N.ExpandedInFile); 	// Pass the expanded error flags into the Expanded module

		//Outputs reports
		AR_ErrorSummary			 	 := output(AR_U.SummaryStats, named('AR_ErrorSummary_LA'+filedate));
		AR_ScrubErrorReport 	 := output(choosen(AR_U.AllErrors, 1000), named('AR_ScrubErrorReport_LA'+filedate));
		AR_SomeErrorValues		 := output(choosen(AR_U.BadValues, 1000), named('AR_SomeErrorValues_LA'+filedate));
		AR_IsScrubErrors		 	 := IF(count(AR_U.AllErrors)<> 0,true,false);

		// Orbit Stats
		AR_OrbitStats				 	 := AR_U.OrbitStats();

		//Outputs files
		AR_CreateBitMaps			 := output(AR_N.BitmapInfile,,'~thor_data::corp_la_ar_scrubs_bits',overwrite,compressed);	//long term storage
		AR_TranslateBitMap		 := output(AR_T);

		//Submits Profile's stats to Orbit
		AR_SubmitStats 			   := Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_LA_AR','ScrubsAlerts', AR_OrbitStats, version,'Corp_LA_AR').SubmitStats;
		AR_ScrubsWithExamples  := Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_LA_AR','ScrubsAlerts', AR_OrbitStats, version,'Corp_LA_AR').CompareToProfile_with_Examples;

		AR_ScrubsAlert				 := AR_ScrubsWithExamples(RejectWarning = 'Y');
		AR_ScrubsAttachment	   := Scrubs.fn_email_attachment(AR_ScrubsAlert);
		AR_MailFile					   := FileServices.SendEmailAttachData(corp2.Email_Notification_Lists.AttachedList
																															,'Scrubs CorpAR_LA Report' //subject
																															,'Scrubs CorpAR_LA Report' //body
																															,(data)AR_ScrubsAttachment
																															,'text/csv'
																															,'CorpLAARScrubsReport.csv'
																														);

		AR_BadRecords				 := AR_N.ExpandedInFile(	
																								corp_key_Invalid							  			<> 0 or
																								corp_vendor_Invalid 									<> 0 or
																								corp_state_origin_Invalid 					 	<> 0 or
																								corp_process_date_Invalid						  <> 0 or
																								corp_sos_charter_nbr_Invalid 					<> 0 or
																								ar_year_Invalid 											<> 0 or 
																								ar_filed_dt_Invalid 									<> 0 or
																								ar_report_dt_Invalid 									<> 0
																							 );
																							 
		AR_GoodRecords				:= AR_N.ExpandedInFile(
																								corp_key_Invalid							  			= 0 and
																								corp_vendor_Invalid 									= 0 and
																								corp_state_origin_Invalid 					 	= 0 and
																								corp_process_date_Invalid						  = 0 and
																								corp_sos_charter_nbr_Invalid 					= 0 and
																								ar_year_Invalid 											= 0 and 
																								ar_filed_dt_Invalid 									= 0 and
																								ar_report_dt_Invalid 									= 0
																								);

		AR_FailBuild					 := if(count(AR_GoodRecords) = 0,true,false);

		AR_ApprovedRecords		 := project(AR_GoodRecords,transform(Corp2_Mapping.LayoutsCommon.AR,self := left;));


		AR_ALL								 := sequential(IF(count(AR_BadRecords) <> 0
																								 ,IF (poverwrite
																										 ,OUTPUT(AR_BadRecords,,Corp2_Mapping._Dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::ar_'+state_origin,overwrite,__compressed__)
																										 ,OUTPUT(AR_BadRecords,,Corp2_Mapping._Dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::ar_'+state_origin,__compressed__)
																										 )
																								 )
																						  ,output(AR_ScrubsWithExamples, ALL, NAMED('CorpARLAScrubsReportWithExamples'+filedate))
																							//Send Alerts if Scrubs exceeds thresholds
																							,IF(COUNT(AR_ScrubsAlert) > 0, AR_MailFile, OUTPUT('CORP2_MAPPING.LA - No "AR" Corp Scrubs Alerts'))
																							,AR_ErrorSummary
																							,AR_ScrubErrorReport
																							,AR_SomeErrorValues		
																							,AR_SubmitStats
																					);

	//********************************************************************
  // SCRUB EVENT
  //********************************************************************	
		Event_F := MapEvents;
		Event_S := Scrubs_Corp2_Mapping_LA_Event.Scrubs;						// Scrubs module
		Event_N := Event_S.FromNone(Event_F); 											// Generate the error flags
		Event_T := Event_S.FromBits(Event_N.BitmapInfile);     			// Use the FromBits module; makes my bitmap datafile easier to get to
		Event_U := Event_S.FromExpanded(Event_N.ExpandedInFile); 		// Pass the expanded error flags into the Expanded module
		
		//Outputs reports
		Event_ErrorSummary				:= output(Event_U.SummaryStats, named('Event_ErrorSummary_LA'+filedate));
		Event_ScrubErrorReport 		:= output(choosen(Event_U.AllErrors, 1000), named('Event_ScrubErrorReport_LA'+filedate));
		Event_SomeErrorValues			:= output(choosen(Event_U.BadValues, 1000), named('Event_SomeErrorValues_LA'+filedate));
		Event_IsScrubErrors		 		:= IF(count(Event_U.AllErrors)<> 0,true,false);

		// Orbit Stats
		Event_OrbitStats					:= Event_U.OrbitStats();
		
		//Outputs files
		Event_CreateBitMaps				:= output(Event_N.BitmapInfile,,'~thor_data::corp_la_event_scrubs_bits',overwrite,compressed);	//long term storage
		Event_TranslateBitMap			:= output(Event_T);

		//Submits Profile's stats to Orbit
		Event_SubmitStats 			  := Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_LA_Event','ScrubsAlerts', Event_OrbitStats, version,'Corp_LA_Event').SubmitStats;
		Event_ScrubsWithExamples  := Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_LA_Event','ScrubsAlerts', Event_OrbitStats, version,'Corp_LA_Event').CompareToProfile_with_Examples;

		Event_ScrubsAlert					:= Event_ScrubsWithExamples(RejectWarning = 'Y');
		Event_ScrubsAttachment		:= Scrubs.fn_email_attachment(Event_ScrubsAlert);
		Event_MailFile						:= FileServices.SendEmailAttachData(corp2.Email_Notification_Lists.spray
																																 ,'Scrubs CorpEvent_LA Report' //subject
																																 ,'Scrubs CorpEvent_LA Report' //body
																																 ,(data)Event_ScrubsAttachment
																																 ,'text/csv'
																																 ,'CorpLAEventScrubsReport.csv'
																																 ,
																																 ,
																																 ,corp2.Email_Notification_Lists.spray);

		Event_BadRecords				 	:= Event_N.ExpandedInFile(	
																												corp_key_Invalid							  			<> 0 or
																												corp_vendor_Invalid 									<> 0 or																						
																												corp_state_origin_Invalid 					 	<> 0 or
																												corp_process_date_Invalid							<> 0 or
																												corp_sos_charter_nbr_Invalid 					<> 0 or
																												event_filing_reference_nbr_Invalid		<> 0 or
																												event_filing_date_Invalid 						<> 0 or																												
																												event_date_type_cd_Invalid 						<> 0 or
																												event_filing_cd_Invalid			 					<> 0
																											 );

		Event_GoodRecords					:= Event_N.ExpandedInFile(	
																												corp_key_Invalid							  			= 0 and
																												corp_vendor_Invalid 									= 0 and																				
																												corp_state_origin_Invalid 					 	= 0 and
																												corp_process_date_Invalid						  = 0 and
																												corp_sos_charter_nbr_Invalid 					= 0 and
																												event_filing_reference_nbr_Invalid		= 0 and
																												event_filing_date_Invalid							= 0 and																												
																												event_date_type_cd_Invalid		 				= 0 and
																												event_filing_cd_Invalid								= 0
																											);

		Event_FailBuild					  := if(count(Event_GoodRecords) = 0,true,false);

		Event_ApprovedRecords			:= project(Event_GoodRecords,transform(Corp2_Mapping.LayoutsCommon.Events,self := left));
		

		Event_ALL									:= sequential(IF(count(Event_BadRecords) <> 0
																											,IF (poverwrite
																													,OUTPUT(Event_BadRecords,,Corp2_Mapping._Dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::event_'+state_origin,overwrite,__compressed__)
																													,OUTPUT(Event_BadRecords,,Corp2_Mapping._Dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::event_'+state_origin,__compressed__)
																													)
																											)
																									 ,output(Event_ScrubsWithExamples, ALL, NAMED('CorpEventLAScrubsReportWithExamples'+filedate))
																									 //Send Alerts if Scrubs exceeds thresholds
																									 ,IF(COUNT(Event_ScrubsAlert) > 0, Event_MailFile, OUTPUT('CORP2_MAPPING.LA - No "EVENT" Corp Scrubs Alerts'))
																									 ,Event_ErrorSummary
																									 ,Event_ScrubErrorReport
																									 ,Event_SomeErrorValues		
																									 ,Event_SubmitStats
																								);

	//********************************************************************
  // SCRUB MAIN
  //********************************************************************	
		Main_F := mapMain;
		Main_S := Scrubs_Corp2_Mapping_LA_Main.Scrubs;					// Scrubs module
		Main_N := Main_S.FromNone(Main_F); 											// Generate the error flags
		Main_T := Main_S.FromBits(Main_N.BitmapInfile);     		// Use the FromBits module; makes my bitmap datafile easier to get to
		Main_U := Main_S.FromExpanded(Main_N.ExpandedInFile); 	// Pass the expanded error flags into the Expanded module

		//Outputs reports
		Main_ErrorSummary					:= output(Main_U.SummaryStats, named('Main_ErrorSummary_LA'+filedate));
		Main_ScrubErrorReport 		:= output(choosen(Main_U.AllErrors, 1000), named('Main_ScrubErrorReport_LA'+filedate));
		Main_SomeErrorValues			:= output(choosen(Main_U.BadValues, 1000), named('Main_SomeErrorValues_LA'+filedate));
		Main_IsScrubErrors		 		:= IF(count(Main_U.AllErrors)<> 0,true,false);

		// Orbit Stats
		Main_OrbitStats						:= Main_U.OrbitStats();
		
		//Outputs files
		Main_CreateBitMaps				:= output(Main_N.BitmapInfile,,'~thor_data::corp_la_main_scrubs_bits',overwrite,compressed);	//long term storage
		Main_TranslateBitMap			:= output(Main_T);

		//Submits Profile's stats to Orbit
		Main_SubmitStats 			    := Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_LA_Main','ScrubsAlerts', Main_OrbitStats, version,'Corp_LA_Main').SubmitStats;
		Main_ScrubsWithExamples   := Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_LA_Main','ScrubsAlerts', Main_OrbitStats, version,'Corp_LA_Main').CompareToProfile_with_Examples;

		Main_ScrubsAlert					:= Main_ScrubsWithExamples(RejectWarning = 'Y');
		Main_ScrubsAttachment			:= Scrubs.fn_email_attachment(Main_ScrubsAlert);
		Main_MailFile							:= FileServices.SendEmailAttachData(corp2.Email_Notification_Lists.spray
																																 ,'Scrubs CorpMain_LA Report' //subject
																																 ,'Scrubs CorpMain_LA Report' //body
																																 ,(data)Main_ScrubsAttachment
																																 ,'text/csv'
																																 ,'CorpLAMainScrubsReport.csv'
																																 ,
																																 ,
																																 ,corp2.Email_Notification_Lists.spray);

		Main_BadRecords						:= Main_N.ExpandedInFile(	
																											 dt_vendor_first_reported_Invalid 							<> 0 or
																											 dt_vendor_last_reported_Invalid 								<> 0 or
																											 dt_first_seen_Invalid 													<> 0 or
																											 dt_last_seen_Invalid 													<> 0 or
																											 corp_ra_dt_first_seen_Invalid 									<> 0 or
																											 corp_ra_dt_last_seen_Invalid 									<> 0 or
																											 corp_key_Invalid 															<> 0 or
																											 corp_vendor_Invalid 														<> 0 or
																											 corp_state_origin_Invalid			 					 			<> 0 or
																											 corp_process_date_Invalid									  	<> 0 or
																											 corp_orig_sos_charter_nbr_Invalid 							<> 0 or
																											 corp_legal_name_Invalid			 									<> 0 or
																											 corp_ln_name_type_cd_Invalid 									<> 0 or
																											 corp_ln_name_type_desc_Invalid									<> 0 or
																											 corp_status_desc_Invalid			 									<> 0 or
																											 corp_status_date_Invalid 											<> 0 or
																											 corp_standing_Invalid 													<> 0 or
																											 corp_status_comment_Invalid 										<> 0 or
																											 corp_inc_state_Invalid 												<> 0 or
																											 corp_inc_county_Invalid			 									<> 0 or
																											 corp_inc_date_Invalid 													<> 0 or
																											 corp_term_exist_cd_Invalid 										<> 0 or
																											 corp_term_exist_exp_Invalid 										<> 0 or
																											 corp_term_exist_desc_Invalid 									<> 0 or
																											 corp_foreign_domestic_ind_Invalid 							<> 0 or
																											 corp_forgn_state_cd_Invalid			 							<> 0 or
																											 corp_forgn_state_desc_Invalid 									<> 0 or
																											 corp_forgn_date_Invalid 												<> 0 or
																											 corp_orig_org_structure_cd_Invalid							<> 0 or
																											 corp_for_profit_ind_Invalid										<> 0 or
																											 corp_ra_effective_date_Invalid									<> 0 or
																											 corp_ra_address_type_desc_Invalid							<> 0 or
																											 corp_ra_address_line3_Invalid									<> 0 or
																											 cont_filing_date_Invalid												<> 0 or
																											 cont_filing_desc_Invalid												<> 0 or
																											 cont_type_cd_Invalid														<> 0 or
																											 cont_type_desc_Invalid													<> 0 or
																											 corp_country_of_formation_Invalid							<> 0 or
																											 corp_name_reservation_date_Invalid							<> 0 or
																											 corp_name_reservation_expiration_date_Invalid	<> 0 or
																											 corp_name_reservation_nbr_Invalid							<> 0 or
																											 corp_name_status_date_Invalid									<> 0 or
																											 corp_name_status_desc_Invalid									<> 0 or
																											 corp_trademark_first_use_date_Invalid 					<> 0 or
																											 corp_trademark_first_use_date_in_state_Invalid <> 0 or
																											 corp_trademark_status_Invalid 									<> 0 or
																											 cont_country_Invalid 													<> 0 or
																											 recordorigin_Invalid 													<> 0
																										);

		Main_GoodRecords				:= Main_N.ExpandedInFile(	
																											 dt_vendor_first_reported_Invalid 							= 0 and
																											 dt_vendor_last_reported_Invalid 								= 0 and
																											 dt_first_seen_Invalid 													= 0 and
																											 dt_last_seen_Invalid 													= 0 and
																											 corp_ra_dt_first_seen_Invalid 									= 0 and
																											 corp_ra_dt_last_seen_Invalid 									= 0 and
																											 corp_key_Invalid 															= 0 and
																											 corp_vendor_Invalid 														= 0 and
																											 corp_state_origin_Invalid			 					 			= 0 and
																											 corp_process_date_Invalid									  	= 0 and
																											 corp_orig_sos_charter_nbr_Invalid 							= 0 and
																											 corp_legal_name_Invalid			 									= 0 and
																											 corp_ln_name_type_cd_Invalid 									= 0 and
																											 corp_ln_name_type_desc_Invalid									= 0 and
																											 corp_status_desc_Invalid			 									= 0 and
																											 corp_status_date_Invalid 											= 0 and
																											 corp_standing_Invalid 													= 0 and
																											 corp_status_comment_Invalid 										= 0 and
																											 corp_inc_state_Invalid 												= 0 and
																											 corp_inc_county_Invalid			 									= 0 and
																											 corp_inc_date_Invalid 													= 0 and
																											 corp_term_exist_cd_Invalid 										= 0 and
																											 corp_term_exist_exp_Invalid 										= 0 and
																											 corp_term_exist_desc_Invalid 									= 0 and
																											 corp_foreign_domestic_ind_Invalid 							= 0 and
																											 corp_forgn_state_cd_Invalid			 							= 0 and
																											 corp_forgn_state_desc_Invalid 									= 0 and
																											 corp_forgn_date_Invalid 												= 0 and
																											 corp_orig_org_structure_cd_Invalid							= 0 and
																											 corp_for_profit_ind_Invalid										= 0 and
																											 corp_ra_effective_date_Invalid									= 0 and
																											 corp_ra_address_type_desc_Invalid							= 0 and
																											 corp_ra_address_line3_Invalid									= 0 and
																											 cont_filing_date_Invalid												= 0 and
																											 cont_filing_desc_Invalid												= 0 and
																											 cont_type_cd_Invalid														= 0 and
																											 cont_type_desc_Invalid													= 0 and
																											 corp_country_of_formation_Invalid							= 0 and
																											 corp_name_reservation_date_Invalid							= 0 and
																											 corp_name_reservation_expiration_date_Invalid	= 0 and
																											 corp_name_reservation_nbr_Invalid							= 0 and
																											 corp_name_status_date_Invalid									= 0 and
																											 corp_name_status_desc_Invalid									= 0 and
																											 corp_trademark_first_use_date_Invalid 					= 0 and
																											 corp_trademark_first_use_date_in_state_Invalid = 0 and
																											 corp_trademark_status_Invalid 									= 0 and
																											 cont_country_Invalid 													= 0 and
																											 recordorigin_Invalid 													= 0
																								  );

		Main_FailBuild					:= map( corp2_mapping.fCalcPercent(count(Main_N.ExpandedInFile(corp_key_invalid<>0)),count(Main_N.ExpandedInFile),false) 										> Scrubs_Corp2_Mapping_LA_Main.Threshold_Percent.CORP_KEY										 => true,
																		corp2_mapping.fCalcPercent(count(Main_N.ExpandedInFile(corp_orig_sos_charter_nbr_invalid<>0)),count(Main_N.ExpandedInFile),false) 	> Scrubs_Corp2_Mapping_LA_Main.Threshold_Percent.CORP_ORIG_SOS_CHARTER_NBR 	 => true,
																		corp2_mapping.fCalcPercent(count(Main_N.ExpandedInFile(corp_legal_name_invalid<>0)),count(Main_N.ExpandedInFile),false) 						> Scrubs_Corp2_Mapping_LA_Main.Threshold_Percent.CORP_LEGAL_NAME 						 => true,
																		corp2_mapping.fCalcPercent(count(Main_N.ExpandedInFile(corp_ln_name_type_cd_invalid<>0)),count(Main_N.ExpandedInFile),false) 				> Scrubs_Corp2_Mapping_LA_Main.Threshold_Percent.CORP_LN_NAME_TYPE_CD		  	 => true,
																		corp2_mapping.fCalcPercent(count(Main_N.ExpandedInFile(corp_inc_date_invalid<>0)),count(Main_N.ExpandedInFile),false) 							> Scrubs_Corp2_Mapping_LA_Main.Threshold_Percent.CORP_INC_DATE 						 	 => true,
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
																					,output(Main_ScrubsWithExamples, ALL, NAMED('CorpMainLAScrubsReportWithExamples'+filedate))
																					//Send Alerts if Scrubs exceeds thresholds
																					,IF(COUNT(Main_ScrubsAlert) > 0, Main_MailFile, OUTPUT('CORP2_MAPPING.LA - No "MAIN" Corp Scrubs Alerts'))
																					,Main_ErrorSummary
																					,Main_ScrubErrorReport
																					,Main_SomeErrorValues			
																					,Main_SubmitStats
																			);

	//********************************************************************
  // UPDATE
  //********************************************************************

	Fail_Build						:= IF(AR_FailBuild = true or Event_FailBuild = true or Main_FailBuild = true,true,false);
	IsScrubErrors					:= IF(AR_IsScrubErrors = true or Event_IsScrubErrors = true or Main_IsScrubErrors = true,true,false);

	VersionControl.macBuildNewLogicalFile(Corp2_Mapping._dataset().thor_cluster_Files + 'in::corp2::' 	+ version + '::AR_' 		+ state_origin, AR_ApprovedRecords	 , write_ar,,,pOverwrite);
	VersionControl.macBuildNewLogicalFile(Corp2_Mapping._dataset().thor_cluster_Files + 'in::corp2::' 	+ version + '::Event_' 	+ state_origin, Event_ApprovedRecords, write_event,,,pOverwrite);
	VersionControl.macBuildNewLogicalFile(Corp2_Mapping._dataset().thor_cluster_Files + 'in::corp2::' 	+ version + '::Main_' 	+ state_origin, Main_ApprovedRecords , write_main,,,pOverwrite);

	VersionControl.macBuildNewLogicalFile(Corp2_Mapping._dataset().thor_cluster_Files + 'fail::corp2::' + version + '::AR_' 		+ state_origin, AR_F		, write_fail_ar,,,pOverwrite);
	VersionControl.macBuildNewLogicalFile(Corp2_Mapping._dataset().thor_cluster_Files + 'fail::corp2::' + version + '::Event_' 	+ state_origin, Event_F	, write_fail_event,,,pOverwrite);
	VersionControl.macBuildNewLogicalFile(Corp2_Mapping._dataset().thor_cluster_Files + 'fail::corp2::' + version + '::Main_' 	+ state_origin, Main_F	, write_fail_main,,,pOverwrite);

	mapLA:= sequential ( if(pshouldspray = true,Corp2_mapping.fSprayFiles(state_origin,version,pOverwrite := pOverwrite))
											// ,Corp2_Raw_LA.Build_Bases(filedate,version,puseprod).All  // Determined build bases is not needed
											,AR_All
											,Event_All
											,Main_All
											,if(Fail_Build <> true	 
												 ,sequential (write_ar
																		 ,write_event
																		 ,write_main
																		 ,fileservices.addsuperfile(Corp2_Mapping._Dataset().thor_cluster_Files + 'in::'+Corp2_Mapping._Dataset().NameMapped +'::sprayed::ar'			,Corp2_Mapping._Dataset().thor_cluster_Files + 'in::corp2::'+version+'::ar_'		+state_origin)
																		 ,fileservices.addsuperfile(Corp2_Mapping._Dataset().thor_cluster_Files + 'in::'+Corp2_Mapping._Dataset().NameMapped +'::sprayed::event'	,Corp2_Mapping._Dataset().thor_cluster_Files + 'in::corp2::'+version+'::event_'	+state_origin)
																		 ,fileservices.addsuperfile(Corp2_Mapping._Dataset().thor_cluster_Files + 'in::'+Corp2_Mapping._Dataset().NameMapped +'::sprayed::main'		,Corp2_Mapping._Dataset().thor_cluster_Files + 'in::corp2::'+version+'::main_'	+state_origin)																		 
																		 ,if (count(Main_BadRecords) <> 0 or count(AR_BadRecords) <> 0 or count(Event_BadRecords) <> 0
																				 ,Corp2_Mapping.Send_Email(state_origin,version,count(Main_BadRecords)<>0,count(AR_BadRecords)<>0,count(Event_BadRecords)<>0,,count(Main_BadRecords),count(AR_BadRecords),count(Event_BadRecords),,count(Main_ApprovedRecords),count(AR_ApprovedRecords),count(Event_ApprovedRecords)).RecordsRejected																				 
																				 ,Corp2_Mapping.Send_Email(state_origin,version,count(Main_BadRecords)<>0,count(AR_BadRecords)<>0,count(Event_BadRecords)<>0,,count(Main_BadRecords),count(AR_BadRecords),count(Event_BadRecords),,count(Main_ApprovedRecords),count(AR_ApprovedRecords),count(Event_ApprovedRecords)).MappingSuccess																				 
																				 )
																		 ,if (IsScrubErrors
																				 ,Corp2_Mapping.Send_Email(state_origin,version,Main_IsScrubErrors,AR_IsScrubErrors,Event_IsScrubErrors).FieldsInvalidPerScrubs
																				 )
																		 ) //if Fail_Build <> true																			
												 ,sequential (write_fail_ar
																		 ,write_fail_event
																		 ,write_fail_main
																		 ,Corp2_Mapping.Send_Email(state_origin,version).MappingFailed
																		 ) //if Fail_Build = true
												 )
										);
										
	isFileDateValid := if((string)std.date.today() between ut.date_math(filedate,-30) and ut.date_math(filedate,30),true,false);
	return sequential (	 if (isFileDateValid
													,mapLA
													,sequential (Corp2_Mapping.Send_Email(state_origin,filedate).InvalidFileDateParm
																			,FAIL('Corp2_Mapping.'+state_origin+' failed.  An invalid filedate was passed in as a parameter.')
																			)
													)
										);

	end;	// end of Update function					 
	
end; // end of LA module