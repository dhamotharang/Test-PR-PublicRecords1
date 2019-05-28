import corp2, corp2_mapping, corp2_raw_co, scrubs, scrubs_corp2_mapping_co_ar,
			 scrubs_corp2_mapping_co_event, scrubs_corp2_mapping_co_main, std, tools,
			 ut, versioncontrol;

export CO := MODULE; 
	
	export Update(String filedate, string version, boolean pShouldSpray = Corp2_mapping._Dataset().bShouldSpray, boolean pOverwrite = false, boolean pUseProd = Tools._Constants.IsDataland, string tmfiledate = '') := Function

		state_origin			 		:= 'CO';
		state_fips	 			 		:= '08';	
		state_desc	 			 		:= 'COLORADO';

		CorpMstr				 		 	:= dedup(sort(distribute(Corp2_Raw_CO.Files(filedate,,,puseprod).Input.CorpMstr.Logical,hash(entityid)),record,local),record,local) : independent;
		CorpTrdnm 					 	:= dedup(sort(distribute(Corp2_Raw_CO.Files(filedate,,,puseprod).Input.CorpTrdnm.Logical,hash(tradenameid)),record,local),record,local) : independent;
		CorpHist						 	:= dedup(sort(distribute(Corp2_Raw_CO.Files(filedate,,,puseprod).Input.CorpHist,hash(histentityid)),record,local),record,local) : independent;
		TradeMarkHistory	 		:= dedup(sort(distribute(Corp2_Raw_CO.Files(,,version,puseprod).Base.TMHistory.logical,hash(trademarkid)),record, local),record,local) : independent;

		//Note:  CorpHistIsATradeMark identifies "trademark" type records in the CorpHist file.
		CorpHistIsATradeMark 	:= CorpHist(regexfind('^STATEMENT OF TRADEMARK',corp2.t2u(HistDesc),0)<>'');

		//********************************************************************
		//Normalize the Corporation Master file on address.
		//********************************************************************
		HasNoRaAddresses	 	:= CorpMstr(corp2.t2u(agentprinaddr1+agentprinaddr2+agentprincity+agentprinstate+agentprinzip+agentprincountry+
																							agentmailaddr1+agentmailaddr2+agentmailcity+agentmailstate+agentmailzip+agentmailcountry) =  '') : independent;

		HasNoRaAddress			:= project(HasNoRaAddresses,
																	 transform(Corp2_Raw_CO.Layouts.Temp_NormalizedMstr,
																						 self.jurisdiction		:= Corp2_Raw_CO.Functions.Jurisdiction(left.jurisdiction);
																						 self									:= left;
																						 self									:= [];
																						 )
																	);

		HasPrinAddresses 		:= CorpMstr(corp2.t2u(agentprinaddr1+agentprinaddr2+agentprincity+agentprinstate+agentprinzip+agentprincountry) <> '' and
																	  corp2.t2u(agentmailaddr1+agentmailaddr2+agentmailcity+agentmailstate+agentmailzip+agentmailcountry) =  '') : independent;

		HasPrinAddress			:= project(HasPrinAddresses,
																	 transform(Corp2_Raw_CO.Layouts.Temp_NormalizedMstr,
																						 self.jurisdiction		:= Corp2_Raw_CO.Functions.Jurisdiction(left.jurisdiction);
																						 self.norm_address1		:= corp2.t2u(left.agentprinaddr1);
																						 self.norm_address2		:= corp2.t2u(left.agentprinaddr2);
																						 self.norm_city				:= corp2.t2u(left.agentprincity);
																						 self.norm_state			:= corp2.t2u(left.agentprinstate);
																						 self.norm_zip				:= corp2.t2u(left.agentprinzip);
																						 self.norm_country		:= corp2.t2u(left.agentprincountry);
																						 self.norm_addrtype		:= 'R';
																						 self.norm_addrdesc		:= 'REGISTERED OFFICE';
																						 self									:= left;
																						 self									:= [];
																						 )
																	);
																	
		HasMailAddresses 		:= CorpMstr(corp2.t2u(agentprinaddr1+agentprinaddr2+agentprincity+agentprinstate+agentprinzip+agentprincountry) =  '' and
																	  corp2.t2u(agentmailaddr1+agentmailaddr2+agentmailcity+agentmailstate+agentmailzip+agentmailcountry) <> '') : independent;

		HasMailAddress			:= project(HasMailAddresses,
																	 transform(Corp2_Raw_CO.Layouts.Temp_NormalizedMstr,
																						 self.jurisdiction		:= Corp2_Raw_CO.Functions.Jurisdiction(left.jurisdiction);
																						 self.norm_address1		:= corp2.t2u(left.agentmailaddr1);
																						 self.norm_address2		:= corp2.t2u(left.agentmailaddr2);
																						 self.norm_city				:= corp2.t2u(left.agentmailcity);
																						 self.norm_state			:= corp2.t2u(left.agentmailstate);		
																						 self.norm_zip				:= corp2.t2u(left.agentmailzip);
																						 self.norm_country		:= corp2.t2u(left.agentmailcountry);
																						 self.norm_addrtype		:= 'M';
																						 self.norm_addrdesc		:= 'AGENT MAILING ADDRESS';
																						 self									:= left;
																						 self									:= [];
																						)
																	);
																						 
		Has2AgentAddresses 	:= CorpMstr(corp2.t2u(agentprinaddr1+agentprinaddr2+agentprincity+agentprinstate+agentprinzip+agentprincountry) <> '' and
																	  corp2.t2u(agentmailaddr1+agentmailaddr2+agentmailcity+agentmailstate+agentmailzip+agentmailcountry) <> '') : independent;
			
		Corp2_Raw_CO.Layouts.Temp_NormalizedMstr NormalizeMasterAgentAddress(Corp2_Raw_CO.Layouts.CorpMstrLayoutIn l, unsigned1 c) := transform
			self.jurisdiction 													:= Corp2_Raw_CO.Functions.Jurisdiction(l.jurisdiction);
			self.norm_address1													:= choose(c,l.agentprinaddr1,l.agentmailaddr1);
			self.norm_address2													:= choose(c,l.agentprinaddr2,l.agentmailaddr2);
			self.norm_city															:= choose(c,l.agentprincity,l.agentmailcity);
			self.norm_state															:= choose(c,l.agentprinstate,l.agentmailstate);		
			self.norm_zip																:= choose(c,l.agentprinzip,l.agentmailzip);
			self.norm_country														:= choose(c,l.agentprincountry,l.agentmailcountry);
			self.norm_addrtype													:= choose(c,'R','M');
			self.norm_addrdesc													:= choose(c,'REGISTERED OFFICE','AGENT MAILING ADDRESS');
			self 																				:= l;
			self 																				:= [];
		end;
	
		NormalizeMasterAgentAddr := normalize(Has2AgentAddresses,2,NormalizeMasterAgentAddress(left, counter)) : independent;
		AllCorpMstr							 := NormalizeMasterAgentAddr + HasMailAddress + HasPrinAddress + HasNoRaAddress : independent;
		
		//********************************************************************
		//Normalize the Corporation Master file on Agent person name and 
		//Agent Organization's name.
		//********************************************************************
		HasNoNames					:= AllCorpMstr(corp2.t2u(agentfirstname+agentmiddlename+agentlastname+agentorgname)='');

		HasNoName						:= project(HasNoNames,
																	 transform(Corp2_Raw_CO.Layouts.Temp_NormalizedMstr,
																						 self									:= left;
																						 self									:= [];
																						 )
																	);

		HasOnlyPersonName		:= AllCorpMstr(corp2.t2u(agentfirstname+agentmiddlename+agentlastname)<>'' and corp2.t2u(agentorgname)='');
		
		HasPersonName				:= project(HasOnlyPersonName,
																	 transform(Corp2_Raw_CO.Layouts.Temp_NormalizedMstr,
																						 self.norm_agentname				:= left.agentfirstname+' '+left.agentmiddlename+' '+left.agentlastname;
																						 self												:= left;
																						 self												:= [];
																						)
																	);
																	
		HasOnlyOrgName			:= AllCorpMstr(corp2.t2u(agentfirstname+agentmiddlename+agentlastname)=''  and corp2.t2u(agentorgname)<>'');

		HasOrgName					:= project(HasOnlyOrgName,
																	 transform(Corp2_Raw_CO.Layouts.Temp_NormalizedMstr,
																						 self.norm_agentname				:= corp2.t2u(stringlib.stringfilterout(left.agentorgname,'^!~`".,*:/)('));
																						 self												:= left;
																						 self												:= [];
																						)
																	);
																	
		HasBothNames							:= AllCorpMstr(corp2.t2u(agentfirstname+agentmiddlename+agentlastname)<>'' and corp2.t2u(agentorgname)<>'');

		Corp2_Raw_CO.Layouts.Temp_NormalizedMstr NormalizeAgentName(Corp2_Raw_CO.Layouts.Temp_NormalizedMstr l, unsigned1 c) := transform
			self.norm_agentname		 											:= choose(c,stringlib.stringfilterout(l.agentorgname,'^!~`".,*:/)('),l.agentfirstname+' '+l.agentmiddlename+' '+l.agentlastname);
			self 																				:= l;
			self																				:= [];
		end;

		NormalizeCorpMstr		     := normalize(HasBothNames,2,NormalizeAgentName(left, counter)) : independent;
		AllCorpMaster						 := NormalizeCorpMstr + HasOrgName + HasPersonName + HasNoName: independent;

		//********************************************************************
		//Begin MAIN File processing. 
		//********************************************************************
		Corp2_Mapping.LayoutsCommon.Main CorpTransform(Corp2_Raw_CO.Layouts.Temp_NormalizedMstr l) := transform
			self.dt_vendor_first_reported								:= (integer)filedate;
			self.dt_vendor_last_reported								:= (integer)filedate;
			self.dt_first_seen													:= (integer)filedate;
			self.dt_last_seen														:= (integer)filedate;
			self.corp_ra_dt_first_seen									:= (integer)filedate;
			self.corp_ra_dt_last_seen										:= (integer)filedate;					
			self.corp_key																:= state_fips + '-' + corp2.t2u(l.entityid);			
			self.corp_vendor														:= state_fips;
			self.corp_state_origin											:= state_origin;
			self.corp_process_date											:= filedate;
			self.corp_orig_sos_charter_nbr							:= corp2.t2u(l.entityid);
			self.corp_legal_name												:= Corp2_Raw_CO.Functions.CorpLegalName(state_origin,state_desc,l.entityname);
			self.corp_ln_name_type_cd										:= '01';
			self.corp_ln_name_type_desc									:= 'LEGAL';
			self.corp_address1_type_cd									:= if(Corp2_Mapping.fAddressExists(state_origin,state_desc,l.prinaddr1,l.prinaddr2,l.princity,l.prinstate,l.prinZip,l.princountry).ifAddressExists, 'B', '');
			self.corp_address1_type_desc								:= if(Corp2_Mapping.fAddressExists(state_origin,state_desc,l.prinaddr1,l.prinaddr2,l.princity,l.prinstate,l.prinZip,l.princountry).ifAddressExists, 'BUSINESS', '');
			self.corp_address1_line1										:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.prinaddr1,l.prinaddr2,l.princity,l.prinstate,l.prinZip,l.princountry).AddressLine1;
			self.corp_address1_line2								 		:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.prinaddr1,l.prinaddr2,l.princity,l.prinstate,l.prinZip,l.princountry).AddressLine2;
			self.corp_address1_line3								 		:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.prinaddr1,l.prinaddr2,l.princity,l.prinstate,l.prinZip,l.princountry).AddressLine3;
			self.corp_prep_addr1_line1									:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.prinaddr1,l.prinaddr2,l.princity,l.prinstate,l.prinZip,l.princountry).PrepAddrLine1;
			self.corp_prep_addr1_last_line							:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.prinaddr1,l.prinaddr2,l.princity,l.prinstate,l.prinZip,l.princountry).PrepAddrLastLine;
			self.corp_address2_type_cd							 		:= if(Corp2_Mapping.fAddressExists(state_origin,state_desc,l.mailaddr1,l.mailaddr2,l.mailcity,l.mailstate,l.mailzip,l.mailcountry).ifAddressExists, 'M', '');
			self.corp_address2_type_desc						 		:= if(Corp2_Mapping.fAddressExists(state_origin,state_desc,l.mailaddr1,l.mailaddr2,l.mailcity,l.mailstate,l.mailzip,l.mailcountry).ifAddressExists, 'MAILING', '');
			self.corp_address2_line1										:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.mailaddr1,l.mailaddr2,l.mailcity,l.mailstate,l.mailzip,l.mailcountry).AddressLine1;
			self.corp_address2_line2								 		:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.mailaddr1,l.mailaddr2,l.mailcity,l.mailstate,l.mailzip,l.mailcountry).AddressLine2;
			self.corp_address2_line3								 		:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.mailaddr1,l.mailaddr2,l.mailcity,l.mailstate,l.mailzip,l.mailcountry).AddressLine3;
			self.corp_prep_addr2_line1									:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.mailaddr1,l.mailaddr2,l.mailcity,l.mailstate,l.mailzip,l.mailcountry).PrepAddrLine1;
			self.corp_prep_addr2_last_line							:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.mailaddr1,l.mailaddr2,l.mailcity,l.mailstate,l.mailzip,l.mailcountry).PrepAddrLastLine;
			self.corp_status_desc												:= corp2.t2u(l.entityStatus);
			self.corp_inc_state													:= state_origin;
			self.corp_inc_date       				   	        := if(corp2.t2u(l.jurisdiction) in [state_origin,state_desc,''],Corp2_Mapping.fValidateDate(l.entityformdate,'MM/DD/CCYY').PastDate,'');
	    self.corp_term_exist_cd											:= map(corp2.t2u(l.perpetualflag) = 'Y' => 'P',
																												 corp2.t2u(l.perpetualflag) = 'N' => 'D',
																												 ''
																												);
	    self.corp_term_exist_exp										:= Corp2_Mapping.fValidateDate(l.termdate,'MM/DD/CCYY').GeneralDate;
	    self.corp_term_exist_desc										:= map(corp2.t2u(l.perpetualflag) = 'Y' 									 										=> 'PERPETUAL',
																												 Corp2_Mapping.fValidateDate(l.termdate,'MM/DD/CCYY').GeneralDate <> '' => 'EXPIRATION DATE',
																												 ''
																												);
			self.corp_foreign_domestic_ind							:= Corp2_Raw_CO.Functions.CorpForeignDomesticInd(l.entitytype);
			self.corp_forgn_state_cd            				:= if(corp2.t2u(l.jurisdiction) not in [state_origin,state_desc,''],Corp2_Raw_CO.Functions.CorpForgnStateCD(l.jurisdiction),'');
			self.corp_forgn_state_desc         				 	:= if(corp2.t2u(l.jurisdiction) not in [state_origin,state_desc,''],Corp2_Raw_CO.Functions.CorpForgnStateDesc(l.jurisdiction),'');
			self.corp_forgn_date 												:= if(corp2.t2u(l.jurisdiction) not in [state_origin,state_desc,''],Corp2_Mapping.fValidateDate(l.entityformdate,'MM/DD/CCYY').PastDate,'');
			self.corp_orig_org_structure_cd     				:= corp2.t2u(l.entitytype);
			self.corp_orig_org_structure_desc   				:= Corp2_Raw_CO.Functions.CorpTypeTable(l.entitytype);
			self.corp_for_profit_ind										:= Corp2_Raw_CO.Functions.CorpForProfitInd(l.entitytype);
			self.corp_ra_full_name		  			  				:= Corp2_Mapping.fCleanBusinessName(state_origin,state_desc,l.norm_agentname).BusinessName;
			self.corp_ra_address_type_cd			  				:= if(Corp2_Mapping.fAddressExists(state_origin,state_desc,l.norm_address1,l.norm_address2,l.norm_city,l.norm_state,l.norm_zip,l.norm_country).ifAddressExists,l.norm_addrtype,'');
			self.corp_ra_address_type_desc		  				:= if(Corp2_Mapping.fAddressExists(state_origin,state_desc,l.norm_address1,l.norm_address2,l.norm_city,l.norm_state,l.norm_zip,l.norm_country).ifAddressExists,l.norm_addrdesc,'');
			self.corp_ra_address_line1			 	  				:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.norm_address1,l.norm_address2,l.norm_city,l.norm_state,l.norm_zip,l.norm_country).AddressLine1;
			self.corp_ra_address_line2			 	  				:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.norm_address1,l.norm_address2,l.norm_city,l.norm_state,l.norm_zip,l.norm_country).AddressLine2;
			self.corp_ra_address_line3				 				 	:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.norm_address1,l.norm_address2,l.norm_city,l.norm_state,l.norm_zip,l.norm_country).AddressLine3;
			self.ra_prep_addr_line1						  				:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.norm_address1,l.norm_address2,l.norm_city,l.norm_state,l.norm_zip,l.norm_country).PrepAddrLine1;
			self.ra_prep_addr_last_line				  				:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.norm_address1,l.norm_address2,l.norm_city,l.norm_state,l.norm_zip,l.norm_country).PrepAddrLastLine;
			self.recordorigin														:= 'C';
			self															  				:= [];
		end;

		MapCorpMstr				:= project(AllCorpMaster, CorpTransform(left)) : independent;

		//********************************************************************
		//Map the CorpTrdnm file (Tradenames) 
		//********************************************************************
		Corp2_Mapping.LayoutsCommon.Main corpTrdNameTransform(Corp2_Raw_CO.Layouts.CorpTrdnmLayoutIn l) := transform
			self.dt_vendor_first_reported								:= (integer)filedate;
			self.dt_vendor_last_reported								:= (integer)filedate;
			self.dt_first_seen													:= (integer)filedate;
			self.dt_last_seen														:= (integer)filedate;
			self.corp_ra_dt_first_seen									:= (integer)filedate;
			self.corp_ra_dt_last_seen										:= (integer)filedate;
			self.corp_key																:= state_fips + '-' + corp2.t2u(l.tradenameid);
			self.corp_vendor														:= state_fips;
			self.corp_state_origin											:= state_origin;
			self.corp_process_date											:= filedate;
			self.corp_orig_sos_charter_nbr							:= corp2.t2u(l.tradenameid);
			self.corp_legal_name												:= Corp2_Raw_CO.Functions.CorpLegalName(state_origin,state_desc,l.tradename);
			self.corp_ln_name_type_cd										:= '04';													   
			self.corp_ln_name_type_desc									:= 'TRADENAME';
	    self.corp_filing_date												:= Corp2_Mapping.fValidateDate(l.effdate,'MM/DD/CCYY').PastDate;
			self.corp_inc_state													:= state_origin;
			self.recordorigin														:= 'C';			
			self																				:= [];
		end; 	

		MapTrdnmCorp	:= project(CorpTrdnm, corpTrdNameTransform(left)) : independent;

		//********************************************************************
		//Normalize the tradename file on address
		//********************************************************************
		Corp2_Raw_CO.Layouts.Temp_NormalizedTrdnm NormalizeTrdNMAddress(Corp2_Raw_CO.Layouts.CorpTrdnmLayoutIn l, unsigned1 c) := transform,
		skip((c = 2 and corp2.t2u(l.mailaddr1+l.mailaddr2+l.mailcity+l.mailstate+l.mailzip+l.mailcountry) = '') or
				 (c = 1 and corp2.t2u(l.prinaddr1+l.prinaddr2+l.princity+l.prinstate+l.prinzip+l.princountry) = '' 																and
										corp2.t2u(l.mailaddr1+l.mailaddr2+l.mailcity+l.mailstate+l.mailzip+l.mailcountry) <> '') or
				 (c = 2	and corp2.t2u(l.prinaddr1+l.prinaddr2+l.princity+l.prinstate+l.prinzip+l.princountry) = ''																and
										corp2.t2u(l.mailaddr1+l.mailaddr2+l.mailcity+l.mailstate+l.mailzip+l.mailcountry) = '')
				)	
			self.norm_address1													:= choose(c,l.prinaddr1,l.mailaddr1);,
			self.norm_address2	 												:= choose(c,l.prinaddr2,l.mailaddr2);
			self.norm_city															:= choose(c,l.princity,l.mailcity);
			self.norm_state															:= choose(c,l.prinstate,l.mailstate);		
			self.norm_zip																:= choose(c,l.prinzip,l.mailzip);
			self.norm_country														:= choose(c,l.princountry,l.mailcountry);
			self.norm_addrtype													:= choose(c,'B','M');
			self.norm_addrdesc													:= choose(c,'BUSINESS','MAILING');
			self 																				:= l;
			self 																				:= [];			
		end;

		NormalizeTrdnmAddr := normalize(CorpTrdnm,2,NormalizeTrdNMAddress(left, counter)) : independent;	

		//********************************************************************
		//Normalize the tradename file on organization name and person name.
		//********************************************************************
		Corp2_Raw_CO.Layouts.Temp_NormalizedTrdnm NormalizeTrdNMName(Corp2_Raw_CO.Layouts.Temp_NormalizedTrdnm l, unsigned1 c) := transform,
		skip((c = 2 and corp2.t2u(l.firstname+l.middlename+l.lastname) = '') 															 or
				 (c = 1 and corp2.t2u(l.regorg) = '' and corp2.t2u(l.firstname+l.middlename+l.lastname) <> '') or 
				 (c = 2 and corp2.t2u(l.regorg) = '' and corp2.t2u(l.firstname+l.middlename+l.lastname) =  '')
				)
			self.norm_trdnmname		 											:= choose(c,l.regorg,l.firstname+' '+l.middlename+' '+l.lastname);
			self.norm_trdnmfirstname										:= choose(c,'',l.firstname);
			self.norm_trdnmmiddlename	 									:= choose(c,'',l.middlename);
			self.norm_trdnmlastname											:= choose(c,'',l.lastname);
			self.norm_trdnmsuffix												:= choose(c,'',l.suffix);
			self 																				:= l;
		end;

		NormalizeCorpTrdnm := normalize(NormalizeTrdnmAddr,2,NormalizeTrdNMName(left, counter)) : independent;	

		//********************************************************************
		//Map the normalized tradename file to populate the contact info.
		//********************************************************************
		Corp2_Mapping.LayoutsCommon.Main ContTRDNMTransform(Corp2_Raw_CO.Layouts.Temp_NormalizedTrdnm l) := transform,
		skip(corp2.t2u(l.norm_trdnmname)='')
			self.dt_vendor_first_reported								:= (integer)filedate;
			self.dt_vendor_last_reported								:= (integer)filedate;
			self.dt_first_seen													:= (integer)filedate;
			self.dt_last_seen														:= (integer)filedate;
			self.corp_ra_dt_first_seen									:= (integer)filedate;
			self.corp_ra_dt_last_seen										:= (integer)filedate;			
			self.corp_key																:= state_fips + '-' + corp2.t2u(l.tradenameid);
			self.corp_vendor														:= state_fips;
			self.corp_state_origin											:= state_origin;
			self.corp_process_date											:= filedate;
			self.corp_orig_sos_charter_nbr							:= corp2.t2u(l.tradenameid);
			self.corp_legal_name												:= Corp2_Raw_CO.Functions.CorpLegalName(state_origin,state_desc,l.tradename);
			self.corp_inc_state													:= state_origin;
			self.cont_full_name													:= Corp2_Raw_CO.Functions.ContFullName(state_origin,state_desc,l.norm_trdnmname);
			self.cont_fname    					 								:= Corp2_Mapping.fCleanPersonName(state_origin,state_desc,l.norm_trdnmfirstname,l.norm_trdnmmiddlename,l.norm_trdnmlastname).FirstName;
			self.cont_mname   				  								:= Corp2_Mapping.fCleanPersonName(state_origin,state_desc,l.norm_trdnmfirstname,l.norm_trdnmmiddlename,l.norm_trdnmlastname).MiddleName;
			self.cont_lname  					   								:= Corp2_Mapping.fCleanPersonName(state_origin,state_desc,l.norm_trdnmfirstname,l.norm_trdnmmiddlename,l.norm_trdnmlastname).LastName;
			self.cont_suffix														:= if(corp2.t2u(self.cont_fname+self.cont_mname+self.cont_lname)<>'',corp2.t2u(l.norm_trdnmsuffix),'');
			self.cont_title1_desc												:= 'TRADENAME REGISTRANT';
			self.cont_address_type_cd										:= if(Corp2_Mapping.fAddressExists(state_origin,state_desc,l.norm_address1,l.norm_address2,l.norm_city,l.norm_state,l.norm_zip,l.norm_country).ifAddressExists,l.norm_addrtype, '');
			self.cont_address_type_desc									:= if(Corp2_Mapping.fAddressExists(state_origin,state_desc,l.norm_address1,l.norm_address2,l.norm_city,l.norm_state,l.norm_zip,l.norm_country).ifAddressExists,l.norm_addrdesc, '');
			self.cont_address_line1											:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.norm_address1,l.norm_address2,l.norm_city,l.norm_state,l.norm_zip,l.norm_country).AddressLine1;
			self.cont_address_line2											:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.norm_address1,l.norm_address2,l.norm_city,l.norm_state,l.norm_zip,l.norm_country).AddressLine2;
			self.cont_address_line3											:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.norm_address1,l.norm_address2,l.norm_city,l.norm_state,l.norm_zip,l.norm_country).AddressLine3;																					  
			self.cont_effective_date										:= Corp2_Mapping.fValidateDate(l.effdate,'MM/DD/CCYY').GeneralDate;
			self.cont_prep_addr_line1										:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.norm_address1,l.norm_address2,l.norm_city,l.norm_state,l.norm_zip,l.norm_country).PrepAddrLine1;
			self.cont_prep_addr_last_line								:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.norm_address1,l.norm_address2,l.norm_city,l.norm_state,l.norm_zip,l.norm_country).PrepAddrLastLine;
			self.recordorigin														:= 'T';
			self 																				:= [];	
		end;

		TRDNMRegistrants 		:= project(NormalizeCorpTrdnm, ContTRDNMTransform(left));
		
		MapTrdnmCont		 		:= TRDNMRegistrants(corp2.t2u(cont_full_name) <> ''): independent; //remove any names that were blanked out because they were invalid

		//********************************************************************
		//Begin TRADEMARK Processing:
		//
		//A "MAIN" corporation record needs to be created for Trademark records
		//within the CorpHist file.  
		//
		//Note:  The Trademark file does not contain historical records and 
		//			 therefore "main" corporation records are created from the 
		//			 CorpHist file.  These records are identified as follows:
		//			 Any "HistDesc" that contains the words "STATEMENT OF TRADEMARK"
		//			 within the CORPHIST file (see "CorpHistIsATradeMark" above).
		//Note:  All Trademark records in the Trademark file have a corresponding 
		//			 record in the CorpHist file.
		//********************************************************************

		//********************************************************************
		//Normalize the TradeMarkHistory file on agent's address 
		//********************************************************************
		Corp2_Raw_CO.Layouts.Temp_NormalizedTradeMark NormTMAgentAddrTransform(Corp2_Raw_CO.Layouts.TradeMarkLayoutIn l, unsigned1 c) := transform,
		skip((c = 2 and corp2.t2u(l.agentmailaddress1+l.agentmailaddress2+l.agentmailcitytm+l.agentmailst+l.agentmailziptm+l.agentmailcountrytm) = '') or
				 (c = 1 and corp2.t2u(l.agentphyaddr1+l.agentphyaddr2+l.agentphycity+l.agentphyst+l.agentphyzip+l.agentphycountry) = '' 																and
										corp2.t2u(l.agentmailaddress1+l.agentmailaddress2+l.agentmailcitytm+l.agentmailst+l.agentmailziptm+l.agentmailcountrytm) <> '') or
				 (c = 2	and corp2.t2u(l.agentphyaddr1+l.agentphyaddr2+l.agentphycity+l.agentphyst+l.agentphyzip+l.agentphycountry) = ''																and
										corp2.t2u(l.agentmailaddress1+l.agentmailaddress2+l.agentmailcitytm+l.agentmailst+l.agentmailziptm+l.agentmailcountrytm) = '')
				)						
			self.norm_address1													:= choose(c,l.agentphyaddr1,l.agentmailaddress1);
			self.norm_address2	 												:= choose(c,l.agentphyaddr2,l.agentmailaddress2);
			self.norm_city															:= choose(c,l.agentphycity,l.agentmailcitytm);
			self.norm_state															:= choose(c,l.agentphyst,l.agentmailst);
			self.norm_zip																:= choose(c,l.agentphyzip,l.agentmailziptm);
			self.norm_country														:= choose(c,l.agentphycountry,l.agentmailcountrytm);
			self.norm_addrtype													:= choose(c,'R','M');
			self.norm_addrdesc													:= choose(c,'REGISTERED OFFICE','AGENT MAILING ADDRESS');
			self 																				:= l;
			self 																				:= [];
		end;

		HasAgentAddress 			:= TradeMarkHistory(corp2.t2u(agentmailaddress1+agentmailaddress2+agentmailcitytm+agentmailst+agentmailziptm+agentmailcountrytm+
																												agentphyaddr1+agentphyaddr2+agentphycity+agentphyst+agentphyzip+agentphycountry)<>'');
		HasNoAgentAddress 		:= TradeMarkHistory(corp2.t2u(agentmailaddress1+agentmailaddress2+agentmailcitytm+agentmailst+agentmailziptm+agentmailcountrytm+
																												agentphyaddr1+agentphyaddr2+agentphycity+agentphyst+agentphyzip+agentphycountry)='');
																												
		NormAgentAddress			:= normalize(HasAgentAddress,2,NormTMAgentAddrTransform(left, counter));

		NoAgentAddressProj		:= project(HasNoAgentAddress,transform(Corp2_Raw_CO.Layouts.Temp_NormalizedTradeMark,self := left; self := [];));																							 

		AllTMAgentAddress			:= NormAgentAddress + NoAgentAddressProj;
		
		//********************************************************************
		//Normalize the TradeMarkHistory file on agent's person name and 
		//organization name.
		//********************************************************************
		Corp2_Raw_CO.Layouts.Temp_NormalizedTradeMark NormTMAgentNamesTransform(Corp2_Raw_CO.Layouts.Temp_NormalizedTradeMark l, unsigned1 c) := transform,
		skip((c = 2 and corp2.t2u(l.agentfname+l.agentmname+l.agentlname) = '') 															  or
				 (c = 1 and corp2.t2u(l.agentorg) = '' and corp2.t2u(l.agentfname+l.agentmname+l.agentlname) <> '') or 
				 (c = 2 and corp2.t2u(l.agentorg) = '' and corp2.t2u(l.agentfname+l.agentmname+l.agentlname) =  '')
				)						
			self.norm_agentname		 											:= choose(c,l.agentorg,l.agentfname+' '+l.agentmname+' '+l.agentlname);
			self.norm_agentfname												:= choose(c,'',l.agentfname);
			self.norm_agentmname	 											:= choose(c,'',l.agentmname);
			self.norm_agentlname												:= choose(c,'',l.agentlname);
			self.norm_agentsuffix												:= choose(c,'',l.agentsufx);
			self 																				:= l;
		end;

		HasAgentNames 				:= AllTMAgentAddress(corp2.t2u(agentfname+agentmname+agentlname+agentorg) <> '');
		HasNoAgentNames 			:= AllTMAgentAddress(corp2.t2u(agentfname+agentmname+agentlname+agentorg) = '');

		NormAgentNames				:= normalize(HasAgentNames,2,NormTMAgentNamesTransform(left, counter));

		AllAgentNames					:= NormAgentNames + HasNoAgentNames;

		FinalTradeMark				:= join(CorpHistIsATradeMark,AllAgentNames,
																	corp2.t2u(left.histentityid) = corp2.t2u(right.trademarkid),
																	transform(Corp2_Raw_CO.Layouts.Temp_NormalizedTradeMark,
																						self.histentityid := left.histentityid;
																						self.tranid				:= left.tranid;
																						self							:= right;
																						),
																	right outer,
																	local
																	) : independent;
																	
		//********************************************************************
		//Map the Trademark records that come from the TradeMarkHistory file.
		//********************************************************************
		Corp2_Mapping.LayoutsCommon.Main CorpTMTransform(Corp2_Raw_CO.Layouts.Temp_NormalizedTradeMark l) := transform
			self.dt_vendor_first_reported								:= (integer)filedate;
			self.dt_vendor_last_reported								:= (integer)filedate;
			self.dt_first_seen													:= (integer)filedate;
			self.dt_last_seen														:= (integer)filedate;
			self.corp_ra_dt_first_seen									:= (integer)filedate;
			self.corp_ra_dt_last_seen										:= (integer)filedate;
			self.corp_key																:= state_fips + '-' + corp2.t2u(l.trademarkid);
			self.corp_vendor														:= state_fips;
			self.corp_state_origin											:= state_origin;
			self.corp_process_date											:= filedate;
			self.corp_orig_sos_charter_nbr							:= corp2.t2u(l.trademarkid);
			self.corp_legal_name												:= Corp2_Raw_CO.Functions.CorpLegalName(state_origin,state_desc,l.trdmkdscr);			
			self.corp_ln_name_type_cd										:= '03';											          
			self.corp_ln_name_type_desc									:= 'TRADEMARK';
			//This is an overloaded field
			self.corp_filing_date												:= Corp2_Mapping.fValidateDate(l.effectdte,'MM/DD/CCYY').PastDate;	    
			//This is an overloaded field
			self.corp_filing_desc												:= if(self.corp_filing_date<>'','EFFECTIVE DATE','');
			//This is an overloaded field
			self.corp_status_desc												:= corp2.t2u(l.status);
			self.corp_inc_state													:= state_origin;
			self.corp_inc_date													:= ''; //corp_inc_date is intentionally not being mapped
      self.corp_term_exist_cd											:= if(Corp2_Mapping.fValidateDate(l.expirdte,'MM/DD/CCYY').GeneralDate <> '','D','');														
      self.corp_term_exist_exp										:= Corp2_Mapping.fValidateDate(l.expirdte,'MM/DD/CCYY').GeneralDate;	
      self.corp_term_exist_desc										:= if(Corp2_Mapping.fValidateDate(l.expirdte,'MM/DD/CCYY').GeneralDate <> '','EXPIRATION DATE','');
			//This is an overloaded field
			self.corp_orig_bus_type_desc								:= corp2.t2u(l.gsdesc);
		  self.corp_addl_info													:= if(corp2.t2u(l.specdesc) not in ['UNKNOWN',''],corp2.t2u('SPECIMEN DESCRIPTION: '+l.specdesc),'');
      self.corp_ra_full_name											:= Corp2_Mapping.fCleanBusinessName(state_origin,state_desc,l.norm_agentname).BusinessName;
			self.corp_ra_address_type_cd							  := if(Corp2_Mapping.fAddressExists(state_origin,state_desc,l.norm_address1,l.norm_address2,l.norm_city,l.norm_state,l.norm_zip,l.norm_country).ifAddressExists,l.norm_addrtype,'');
			self.corp_ra_address_type_desc				  		:= if(Corp2_Mapping.fAddressExists(state_origin,state_desc,l.norm_address1,l.norm_address2,l.norm_city,l.norm_state,l.norm_zip,l.norm_country).ifAddressExists,l.norm_addrdesc,'');
			self.corp_ra_address_line1			 			  		:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.norm_address1,l.norm_address2,l.norm_city,l.norm_state,l.norm_zip,l.norm_country).AddressLine1;
			self.corp_ra_address_line2			 	  				:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.norm_address1,l.norm_address2,l.norm_city,l.norm_state,l.norm_zip,l.norm_country).AddressLine2;
			self.corp_ra_address_line3						  		:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.norm_address1,l.norm_address2,l.norm_city,l.norm_state,l.norm_zip,l.norm_country).AddressLine3;
			self.ra_prep_addr_line1						  				:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.norm_address1,l.norm_address2,l.norm_city,l.norm_state,l.norm_zip,l.norm_country).PrepAddrLine1;
			self.ra_prep_addr_last_line						  		:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.norm_address1,l.norm_address2,l.norm_city,l.norm_state,l.norm_zip,l.norm_country).PrepAddrLastLine;									  
			self.corp_trademark_class_desc1							:= corp2.t2u(l.gsdesc);
	    self.corp_trademark_first_use_date					:= Corp2_Mapping.fValidateDate(l.effectdte,'MM/DD/CCYY').PastDate;	    
			self.corp_trademark_first_use_date_in_state	:= Corp2_Mapping.fValidateDate(l.frstusedco,'MM/DD/CCYY').PastDate;
			self.corp_trademark_filing_date							:= Corp2_Mapping.fValidateDate(l.fileddate,'MM/DD/CCYY').PastDate;
			self.corp_trademark_keywords								:= if(corp2.t2u(l.specdesc) not in ['UNKNOWN',''],corp2.t2u(l.specdesc),'');
      self.corp_trademark_status									:= corp2.t2u(l.status);
			self.recordorigin														:= 'C';																							 
			self 																				:= [];
		end;

		MapTradeMarkCorp			:= project(FinalTradeMark,CorpTMTransform(left)) : independent;

		//********************************************************************
		//Normalize the trademark file on business address
		//********************************************************************		
		Corp2_Raw_CO.Layouts.Temp_NormalizedTradeMark NormTMOwnerAddressTransform(Corp2_Raw_CO.Layouts.Temp_NormalizedTradeMark l, unsigned1 c) := transform,
		skip((c = 2 and corp2.t2u(l.busmailaddr1	+l.busmailaddr2	+l.busmailcity	+l.busmailst		+l.busmailzip	+l.busmailcountry) 	= '') or
				 (c = 1 and corp2.t2u(l.busphyaddr1		+l.busphyaddr2	+l.busphycity		+l.busphystate	+l.busphyzip	+l.busphycountry) 	= ''	and
										corp2.t2u(l.busmailaddr1	+l.busmailaddr2	+l.busmailcity	+l.busmailst		+l.busmailzip	+l.busmailcountry) <> '') or
				 (c = 2	and corp2.t2u(l.busphyaddr1		+l.busphyaddr2	+l.busphycity		+l.busphystate	+l.busphyzip	+l.busphycountry) 	= ''	and
										corp2.t2u(l.busmailaddr1	+l.busmailaddr2	+l.busmailcity	+l.busmailst		+l.busmailzip	+l.busmailcountry) 	= '')
				)					
			self.norm_address1													:= choose(c,l.busphyaddr1,l.busmailaddr1);
			self.norm_address2	 												:= choose(c,l.busphyaddr2,l.busmailaddr2);
			self.norm_city															:= choose(c,l.busphycity,l.busmailcity);
			self.norm_state															:= choose(c,l.busphystate,l.busmailst);		
			self.norm_zip																:= choose(c,l.busphyzip,l.busmailzip);
			self.norm_country														:= choose(c,l.busphycountry,l.busmailcountry);
			self.norm_addrtype													:= choose(c,'B','M');
			self.norm_addrdesc													:= choose(c,'BUSINESS','MAILING');
			self 																				:= l;
			self 																				:= [];			
		end;
		
		HasOwnerAddress 			:= FinalTradeMark(corp2.t2u(busmailaddr1+busmailaddr2+busmailcity+busmailst+busmailzip+busmailcountry+
																											busphyaddr1+busphyaddr2+busphycity+busphystate+busphyzip+busphycountry)<> '');
		HasNoOwnerAddress			:= FinalTradeMark(corp2.t2u(busmailaddr1+busmailaddr2+busmailcity+busmailst+busmailzip+busmailcountry+
																											busphyaddr1+busphyaddr2+busphycity+busphystate+busphyzip+busphycountry)= '');

		NormOwnerAddress 			:= normalize(HasOwnerAddress,2,NormTMOwnerAddressTransform(left, counter));

		AllTMOwnerAddress			:= NormOwnerAddress + HasNoOwnerAddress : independent;
		
		//********************************************************************
		//Normalize the trademark file on owner's person name and organization
		//name.
		//********************************************************************
		Corp2_Raw_CO.Layouts.Temp_NormalizedTradeMark NormTMOwnerNameTransform(Corp2_Raw_CO.Layouts.Temp_NormalizedTradeMark l, unsigned1 c) := transform,
		skip((c = 2 and corp2.t2u(l.ownerfname+l.ownermname+l.ownerlname) = '') 															 	or
				 (c = 1 and corp2.t2u(l.ownerorg) = '' and corp2.t2u(l.ownerfname+l.ownermname+l.ownerlname) <> '') or 
				 (c = 2 and corp2.t2u(l.ownerorg) = '' and corp2.t2u(l.ownerfname+l.ownermname+l.ownerlname) =  '')
				)					
			self.norm_ownername		 											:= choose(c,l.ownerorg,l.ownerfname+' '+l.ownermname+' '+l.ownerlname);
			self.norm_ownerfirstname										:= choose(c,'',l.ownerfname);
			self.norm_ownermiddlename	 									:= choose(c,'',l.ownermname);
			self.norm_ownerlastname											:= choose(c,'',l.ownerlname);
			self.norm_ownersuffix												:= choose(c,'',l.ownersuffix);
			self 																				:= l;
		end;
		
		HasOwnerName		 				:= AllTMOwnerAddress(corp2.t2u(ownerorg+ownerfname+ownermname+ownerlname) <> '');
		HasNoOwnerName	 				:= AllTMOwnerAddress(corp2.t2u(ownerorg+ownerfname+ownermname+ownerlname) =	 '');

		NormOwnerName						:= normalize(HasOwnerName,2,NormTMOwnerNameTransform(left, counter)) : independent;	

		FinalTrademarkContacts	:= NormOwnerName + HasNoOwnerName;

		//********************************************************************
		//Map the normalized trademark records that contains an owner's name/org
		//********************************************************************
		Corp2_Mapping.LayoutsCommon.Main ContactTMTransform(Corp2_Raw_CO.Layouts.Temp_NormalizedTradeMark l) := transform,
		skip(corp2.t2u(l.norm_ownername)='')
			self.dt_vendor_first_reported								:= (integer)filedate;
			self.dt_vendor_last_reported								:= (integer)filedate;
			self.dt_first_seen													:= (integer)filedate;
			self.dt_last_seen														:= (integer)filedate;
			self.corp_ra_dt_first_seen									:= (integer)filedate;
			self.corp_ra_dt_last_seen										:= (integer)filedate;			
			self.corp_key																:= state_fips + '-' + corp2.t2u(l.trademarkid);
			self.corp_vendor														:= state_fips;
			self.corp_state_origin											:= state_origin;
			self.corp_process_date											:= filedate;
			self.corp_orig_sos_charter_nbr							:= corp2.t2u(l.trademarkid);
			self.corp_legal_name												:= Corp2_Raw_CO.Functions.CorpLegalName(state_origin,state_desc,l.trdmkdscr);			
			self.corp_ln_name_type_cd										:= '03';											          
			self.corp_ln_name_type_desc									:= 'TRADEMARK';					
			self.corp_inc_state													:= state_origin;
			self.cont_full_name													:= Corp2_Raw_CO.Functions.ContFullName(state_origin,state_desc,l.norm_ownername);
			self.cont_fname  					   								:= Corp2_Mapping.fCleanPersonName(state_origin,state_desc,l.norm_ownerfirstname,l.norm_ownermiddlename,l.norm_ownerlastname).FirstName;
			self.cont_mname  					   								:= Corp2_Mapping.fCleanPersonName(state_origin,state_desc,l.norm_ownerfirstname,l.norm_ownermiddlename,l.norm_ownerlastname).MiddleName;
			self.cont_lname   				  								:= Corp2_Mapping.fCleanPersonName(state_origin,state_desc,l.norm_ownerfirstname,l.norm_ownermiddlename,l.norm_ownerlastname).LastName;
			self.cont_suffix														:= if(corp2.t2u(self.cont_fname+self.cont_mname+self.cont_lname)<>'',corp2.t2u(l.norm_ownersuffix),'');
			self.cont_title1_desc												:= 'TRADEMARK OWNER';
			self.cont_address_type_cd										:= if(Corp2_Mapping.fAddressExists(state_origin,state_desc,l.norm_address1,l.norm_address2,l.norm_city,l.norm_state,l.norm_zip,l.norm_country).ifAddressExists,l.norm_addrtype, '');
			self.cont_address_type_desc									:= if(Corp2_Mapping.fAddressExists(state_origin,state_desc,l.norm_address1,l.norm_address2,l.norm_city,l.norm_state,l.norm_zip,l.norm_country).ifAddressExists,l.norm_addrdesc, '');
			self.cont_address_line1											:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.norm_address1,l.norm_address2,l.norm_city,l.norm_state,l.norm_zip,l.norm_country).AddressLine1;
			self.cont_address_line2											:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.norm_address1,l.norm_address2,l.norm_city,l.norm_state,l.norm_zip,l.norm_country).AddressLine2;
			self.cont_address_line3											:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.norm_address1,l.norm_address2,l.norm_city,l.norm_state,l.norm_zip,l.norm_country).AddressLine3;
			self.cont_prep_addr_line1										:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.norm_address1,l.norm_address2,l.norm_city,l.norm_state,l.norm_zip,l.norm_country).PrepAddrLine1;
			self.cont_prep_addr_last_line								:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.norm_address1,l.norm_address2,l.norm_city,l.norm_state,l.norm_zip,l.norm_country).PrepAddrLastLine;
			self.recordorigin														:= 'T';
			self 																				:= [];	
		end;

		MapTradeMarkContacts	:= project(FinalTrademarkContacts,ContactTMTransform(left)) : independent;

		//********************************************************************
		//Map the CorpHist "trademark" type records.
		//********************************************************************

		//This join outputs only those CorpHist records that do not have an associated 
		//record in the TradeMarkHistory file and are "trademark" type records.  Basically
		//this means that we are missing a record in the TrademarkHistory file and need
		//to create a TradeMark record from the CorpHist file.
		//Note:  The CorpHist contains "summary" info for "trademark" type records.
		CorpHistTradeMarkOnly	:= join(CorpHistIsATradeMark,TradeMarkHistory,
																	corp2.t2u(left.histentityid) = corp2.t2u(right.trademarkid),
																	transform(Corp2_Raw_CO.Layouts.CorpHistLayoutIn,
																						self := left;
																						self := [];
																						),
																	left only,
																	local
																	) : independent;

		//********************************************************************
		//Map the trademark records in the CorpHist file.
		//********************************************************************
		Corp2_Mapping.LayoutsCommon.Main CorpHistTransform(Corp2_Raw_CO.Layouts.CorpHistLayoutIn l) := transform
			self.dt_vendor_first_reported								:= (integer)filedate;
			self.dt_vendor_last_reported								:= (integer)filedate;
			self.dt_first_seen													:= (integer)filedate;
			self.dt_last_seen														:= (integer)filedate;
			self.corp_ra_dt_first_seen									:= (integer)filedate;
			self.corp_ra_dt_last_seen										:= (integer)filedate;
			self.corp_key																:= state_fips + '-' + corp2.t2u(l.histentityid);
			self.corp_vendor														:= state_fips;
			self.corp_state_origin											:= state_origin;
			self.corp_process_date											:= filedate;
			self.corp_orig_sos_charter_nbr							:= corp2.t2u(l.histentityid);
			self.corp_legal_name												:= Corp2_Raw_CO.Functions.CorpLegalName(state_origin,state_desc,l.name);			
			self.corp_ln_name_type_cd										:= '03';											          
			self.corp_ln_name_type_desc									:= 'TRADEMARK';
			self.corp_filing_date												:= Corp2_Mapping.fValidateDate(l.effdate,'MM/DD/CCYY').PastDate;
			self.corp_filing_desc												:= if(self.corp_filing_date<>'','EFFECTIVE DATE','');
			self.corp_inc_date													:= ''; //corp_inc_date is intentionally not being mapped
			self.corp_inc_state													:= state_origin;
			self.recordorigin														:= 'C';																							 
			self 																				:= [];
		end;

		MapCorpHistTM					:= project(CorpHistTradeMarkOnly,CorpHistTransform(left)) : independent;

		AllMain								:= dedup(sort(distribute(MapCorpMstr + MapTrdnmCorp + MapTrdnmCont + MapTradeMarkCorp + MapTradeMarkContacts + MapCorpHistTM,hash(corp_orig_sos_charter_nbr)), record ,local), record, local) : independent;		

		//Filter out "known" bad records that that are not to be rejected by scrubs per the data insight team.
		MapMain								:= Corp2_Raw_CO.Filter.Main(AllMain);

		//********************************************************************
		//Begin AR File processing. 
		//********************************************************************

		//********************************************************************
		//Extract from the CorpHist file the "EVENT" type records and the "AR" 
		//type records.  Here the "AR" records are identified and everything
		//else is considered an "EVENT".
		//********************************************************************
		ARList						 		:= 'ANNUAL|PERIODIC|REPORT PRINTED|FILE REPORT';

		ProcessHistAsAR			  := regexfind(ARList,corp2.t2u(CorpHist.HistDesc)) = true;
		ProcessCommentAsAR	  := regexfind(ARList,corp2.t2u(CorpHist.Comment))  = true;

		CorpHistAR						:= distribute(CorpHist(ProcessHistAsAR or ProcessCommentAsAR),hash(histentityid)) : independent;
		
		CorpAR 								:= join(MapMain, CorpHistAR,
																	corp2.t2u(left.corp_orig_sos_charter_nbr) = corp2.t2u(right.histentityid),
																	transform(Corp2_Raw_CO.Layouts.CorpHistLayoutIn,
																						self := right;
																					 ),
																	inner,
																	local
																 );

		Corp2_Mapping.LayoutsCommon.AR ARTransform(Corp2_Raw_CO.Layouts.CorpHistLayoutIn l) := transform
			self.corp_key																:= state_fips + '-' + corp2.t2u(l.histentityid);
			self.corp_vendor														:= state_fips;				
			self.corp_state_origin											:= state_origin;
			self.corp_process_date											:= filedate;
			self.corp_sos_charter_nbr										:= corp2.t2u(l.histentityid);
			self.ar_filed_dt														:= Corp2_Mapping.fValidateDate(l.recdate,'MM/DD/CCYY').PastDate;
			self.ar_report_nbr													:= if(corp2.t2u(l.tranid) not in ['NOT INDEXED'],corp2.t2u(l.tranid),'');
			self.ar_comment															:= if(corp2.t2u(l.histdesc) <> '' and corp2.t2u(l.comment) <> '',corp2.t2u(l.histdesc + '; ' + l.comment),corp2.t2u(l.histdesc + l.comment));
			self																				:= [];
		end;
																		
		ARMapped			  := project(CorpAR, ARTransform(left)) : independent;	
		MapAR       	  := dedup(sort(distribute(ARMapped,hash(corp_key)), record,local), record,local) : independent;

		//********************************************************************
		//Begin Event File processing. 
		//********************************************************************		
		HistEvents  	 		:= CorpHist(not(ProcessHistAsAR) and not(ProcessCommentAsAR)) : independent;
		
		CorpMstrHistEvents		:= join(MapMain,HistEvents,
																	corp2.t2u(left.corp_orig_sos_charter_nbr) = corp2.t2u(right.histentityid),
																	transform(Corp2_Raw_CO.Layouts.CorpHistLayoutIn,
																						self := right;
																					 ),
																	inner,
																	local
																 );			

		Corp2_Mapping.LayoutsCommon.Events	EventTransform(Corp2_Raw_CO.Layouts.CorpHistLayoutIn l) := transform
			self.corp_key																:= state_fips + '-' + corp2.t2u(l.histentityid);
			self.corp_vendor														:= state_fips;
			self.corp_state_origin											:= state_origin;			
			self.corp_process_date											:= filedate;
			self.corp_sos_charter_nbr										:= corp2.t2u(l.histentityid);
			self.event_filing_reference_nbr							:= if(corp2.t2u(l.tranid) not in ['','NOT INDEXED'],corp2.t2u(l.tranid),'');
			self.event_filing_date											:= Corp2_Mapping.fValidateDate(l.recdate,'MM/DD/CCYY').PastDate;
			self.event_filing_desc											:= corp2.t2u(l.histdesc);
			self.event_desc															:= corp2.t2u(l.comment);
			self																				:= [];
		end;

		MapEvent 						:= project(CorpMstrHistEvents, EventTransform(left));

		MapEvents		    		:= dedup(sort(distribute(MapEvent,hash(corp_key)), record,local), record,local) : independent;
																				
		//********************************************************************
		// SCRUB AR 
		//********************************************************************	
		AR_F := MapAR;
		AR_S := Scrubs_Corp2_Mapping_CO_AR.Scrubs;				// Scrubs module
		AR_N := AR_S.FromNone(AR_F); 											// Generate the error flags
		AR_T := AR_S.FromBits(AR_N.BitmapInfile);     		// Use the FromBits module; makes my bitmap datafile easier to get to
		AR_U := AR_S.FromExpanded(AR_N.ExpandedInFile); 	// Pass the expanded error flags into the Expanded module

		//Outputs reports
		AR_ErrorSummary			 	 := output(AR_U.SummaryStats, named('AR_ErrorSummary_CO'+filedate));
		AR_ScrubErrorReport 	 := output(choosen(AR_U.AllErrors, 1000), named('AR_ScrubErrorReport_CO'+filedate));
		AR_SomeErrorValues		 := output(choosen(AR_U.BadValues, 1000), named('AR_SomeErrorValues_CO'+filedate));
		AR_IsScrubErrors		 	 := if(count(AR_U.AllErrors)<> 0,true,false);

		// Orbit Stats
		AR_OrbitStats				 	 := AR_U.OrbitStats();

		//Outputs files
		AR_CreateBitMaps			 := output(AR_N.BitmapInfile,,'~thor_data::Corp_CO_AR_scrubs_bits',overwrite,compressed);	//long term storage
		AR_TranslateBitMap		 := output(AR_T);

		//Submits Profile's stats to Orbit
		AR_SubmitStats 			   := Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_CO_AR','ScrubsAlerts', AR_OrbitStats, version,'Corp_CO_AR').SubmitStats;
		AR_ScrubsWithExamples  := Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_CO_AR','ScrubsAlerts', AR_OrbitStats, version,'Corp_CO_AR').CompareToProfile_with_Examples;

		AR_ScrubsAlert				 := AR_ScrubsWithExamples(RejectWarning = 'Y');
		AR_ScrubsAttachment	   := Scrubs.fn_email_attachment(AR_ScrubsAlert);
		AR_MailFile					   := FileServices.SendEmailAttachData(corp2.Email_Notification_Lists.AttachedList
																															,'Scrubs CorpAR_CO Report' //subject
																															,'Scrubs CorpAR_CO Report' //body
																															,(data)AR_ScrubsAttachment
																															,'text/csv'
																															,'CorpCOARScrubsReport.csv'
																															);

		AR_BadRecords				 	 := AR_N.ExpandedInFile(																					
																									corp_key_Invalid							  			<> 0 or
																									corp_vendor_Invalid 									<> 0 or
																									corp_state_origin_Invalid 					 	<> 0 or
																									corp_process_date_Invalid						  <> 0 or
																									corp_sos_charter_nbr_Invalid 					<> 0 or
																									ar_filed_dt_Invalid 									<> 0 or
																									ar_report_nbr_Invalid 								<> 0
																								 );

		AR_GoodRecords				 := AR_N.ExpandedInFile(
																									corp_key_Invalid							  			= 0 and
																									corp_vendor_Invalid 									= 0 and
																									corp_state_origin_Invalid 					 	= 0 and
																									corp_process_date_Invalid						  = 0 and
																									corp_sos_charter_nbr_Invalid 					= 0 and
																									ar_filed_dt_Invalid 									= 0 and
																									ar_report_nbr_Invalid 								= 0																						
																								 );

		AR_FailBuild					 := if(count(AR_GoodRecords) = 0,true,false);

		AR_ApprovedRecords		 := project(AR_GoodRecords,transform(Corp2_Mapping.LayoutsCommon.AR,self := left;));

		AR_ALL								 := sequential(if(count(AR_BadRecords) <> 0
																								 ,if(poverwrite
																										 ,output(AR_BadRecords,,Corp2_Mapping._Dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::ar_'+state_origin,overwrite,__compressed__)
																										 ,output(AR_BadRecords,,Corp2_Mapping._Dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::ar_'+state_origin,__compressed__)
																										 )
																								 )
																				,output(AR_ScrubsWithExamples, all, named('CorpARCOScrubsReportWithExamples'+filedate))
																				//Send Alerts if Scrubs exceeds thresholds
																				,if(count(AR_ScrubsAlert) > 0, AR_MailFile, output('CORP2_MAPPING.CO - No "AR" Corp Scrubs Alerts'))
																				,AR_ErrorSummary
																				,AR_ScrubErrorReport
																				,AR_SomeErrorValues		
																				,AR_SubmitStats
																			 );
																					
		//********************************************************************
		// SCRUB EVENT
		//********************************************************************	
		Event_F := MapEvents;
		Event_S := Scrubs_Corp2_Mapping_CO_Event.Scrubs;						// Scrubs module
		Event_N := Event_S.FromNone(Event_F); 											// Generate the error flags
		Event_T := Event_S.FromBits(Event_N.BitmapInfile);     			// Use the FromBits module; makes my bitmap datafile easier to get to
		Event_U := Event_S.FromExpanded(Event_N.ExpandedInFile); 		// Pass the expanded error flags into the Expanded module
		
		//Outputs reports
		Event_ErrorSummary					:= output(Event_U.SummaryStats, named('Event_ErrorSummary_CO'+filedate));
		Event_ScrubErrorReport 			:= output(choosen(Event_U.AllErrors, 1000), named('Event_ScrubErrorReport_CO'+filedate));
		Event_SomeErrorValues				:= output(choosen(Event_U.BadValues, 1000), named('Event_SomeErrorValues_CO'+filedate));
		Event_IsScrubErrors		 			:= if(count(Event_U.AllErrors)<> 0,true,false);

		// Orbit Stats
		Event_OrbitStats						:= Event_U.OrbitStats();

		//Outputs files
		Event_CreateBitMaps					:= output(Event_N.BitmapInfile,,'~thor_data::corp_co_event_scrubs_bits',overwrite,compressed);	//long term storage
		Event_TranslateBitMap				:= output(Event_T);
		
		//Submits Profile's stats to Orbit
		Event_SubmitStats 			    := Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_CO_Event','ScrubsAlerts', Event_OrbitStats, version,'Corp_CO_Event').SubmitStats;
		Event_ScrubsWithExamples    := Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_CO_Event','ScrubsAlerts', Event_OrbitStats, version,'Corp_CO_Event').CompareToProfile_with_Examples;

		Event_ScrubsAlert						:= Event_ScrubsWithExamples(RejectWarning = 'Y');
		Event_ScrubsAttachment			:= Scrubs.fn_email_attachment(Event_ScrubsAlert);
		Event_MailFile							:= FileServices.SendEmailAttachData(corp2.Email_Notification_Lists.spray
																																				 ,'Scrubs CorpEvent_CO Report' //subject
																																				 ,'Scrubs CorpEvent_CO Report' //body
																																				 ,(data)Event_ScrubsAttachment
																																				 ,'text/csv'
																																				 ,'CorpCOEventScrubsReport.csv'
																																				 ,
																																				 ,
																																				 ,corp2.Email_Notification_Lists.spray);

		Event_BadRecords				 		:= Event_N.ExpandedInFile(	
																															 corp_key_Invalid							  			<> 0 or
																															 corp_vendor_Invalid 									<> 0 or																						
																															 corp_state_origin_Invalid 					 	<> 0 or
																															 corp_process_date_Invalid						<> 0 or
																															 corp_sos_charter_nbr_Invalid 				<> 0 or
																															 event_filing_reference_nbr_Invalid		<> 0 or																															 
																															 event_filing_date_Invalid		 				<> 0
																															);

		Event_GoodRecords					:= Event_N.ExpandedInFile(	
																															corp_key_Invalid							  			= 0 and
																															corp_vendor_Invalid 									= 0 and																				
																															corp_state_origin_Invalid 					 	= 0 and
																															corp_process_date_Invalid						  = 0 and
																															corp_sos_charter_nbr_Invalid 					= 0 and
																														  event_filing_reference_nbr_Invalid		= 0 and																															 
																															event_filing_date_Invalid		 					= 0
																														);

		Event_FailBuild					  := if(count(Event_GoodRecords) = 0,true,false);

		Event_ApprovedRecords			:= project(Event_GoodRecords,transform(Corp2_Mapping.LayoutsCommon.Events,self := left));
		
		Event_ALL									:= sequential(if(count(Event_BadRecords) <> 0
																											,if(poverwrite
																													,output(Event_BadRecords,,Corp2_Mapping._Dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::event_co',overwrite,__compressed__)
																													,output(Event_BadRecords,,Corp2_Mapping._Dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::event_co',__compressed__)
																													)
																											)
																									 ,output(Event_ScrubsWithExamples, all, named('CorpEventCOScrubsReportWithExamples'+filedate))
																									 //Send Alerts if Scrubs exceeds thresholds
																									 ,if(count(Event_ScrubsAlert) > 0, Event_MailFile, output('CORP2_MAPPING.CO - No "EVENT" Corp Scrubs Alerts'))
																									 ,Event_ErrorSummary
																									 ,Event_ScrubErrorReport
																									 ,Event_SomeErrorValues			
																									 ,Event_SubmitStats
																								);

		//********************************************************************
		// SCRUB MAIN
		//********************************************************************	
		Main_F := mapMain;
		Main_S := Scrubs_Corp2_Mapping_CO_Main.Scrubs;					// Scrubs module
		Main_N := Main_S.FromNone(Main_F); 											// Generate the error flags
		Main_T := Main_S.FromBits(Main_N.BitmapInfile);     		// Use the FromBits module; makes my bitmap datafile easier to get to
		Main_U := Main_S.FromExpanded(Main_N.ExpandedInFile); 	// Pass the expanded error flags into the Expanded module

		//Outputs reports
		Main_ErrorSummary					:= output(Main_U.SummaryStats, named('Main_ErrorSummary_CO'+filedate));
		Main_ScrubErrorReport 		:= output(choosen(Main_U.AllErrors, 1000), named('Main_ScrubErrorReport_CO'+filedate));
		Main_SomeErrorValues			:= output(choosen(Main_U.BadValues, 1000), named('Main_SomeErrorValues_CO'+filedate));
		Main_IsScrubErrors		 		:= if(count(Main_U.AllErrors)<> 0,true,false);

		// Orbit Stats
		Main_OrbitStats						:= Main_U.OrbitStats();

		//Outputs files
		Main_CreateBitMaps				:= output(Main_N.BitmapInfile,,'~thor_data::corp_co_main_scrubs_bits',overwrite,compressed);	//long term storage
		Main_TranslateBitMap			:= output(Main_T);

		//Submits Profile's stats to Orbit
		Main_SubmitStats 			    := Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_CO_Main','ScrubsAlerts', Main_OrbitStats, version,'Corp_CO_Main').SubmitStats;
		Main_ScrubsWithExamples   := Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_CO_Main','ScrubsAlerts', Main_OrbitStats, version,'Corp_CO_Main').CompareToProfile_with_Examples;

		Main_ScrubsAlert					:= Main_ScrubsWithExamples(RejectWarning = 'Y');
		Main_ScrubsAttachment			:= Scrubs.fn_email_attachment(Main_ScrubsAlert);
		Main_MailFile							:= FileServices.SendEmailAttachData(corp2.Email_Notification_Lists.spray
																																 ,'Scrubs CorpMain_CO Report' //subject
																																 ,'Scrubs CorpMain_CO Report' //body
																																 ,(data)Main_ScrubsAttachment
																																 ,'text/csv'
																																 ,'CorpCOMainScrubsReport.csv'
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
																											 corp_address1_line3_Invalid 						<> 0 or
																											 corp_address2_type_cd_Invalid 					<> 0 or
																											 corp_address2_type_desc_Invalid 				<> 0 or
																											 corp_address2_line3_Invalid 						<> 0 or
																											 corp_filing_date_Invalid 							<> 0 or
																											 corp_status_desc_Invalid 							<> 0 or
																											 corp_inc_state_Invalid 								<> 0 or
																											 corp_inc_date_Invalid 									<> 0 or
																											 corp_term_exist_cd_Invalid 						<> 0 or
																											 corp_term_exist_exp_Invalid 						<> 0 or
																											 corp_term_exist_desc_Invalid 					<> 0 or
																											 corp_foreign_domestic_ind_Invalid 			<> 0 or
																											 corp_forgn_state_cd_Invalid 						<> 0 or
																											 corp_forgn_state_desc_Invalid					<> 0 or
																											 corp_forgn_date_Invalid 								<> 0 or
																											 corp_orig_org_structure_cd_Invalid			<> 0 or
																											 corp_for_profit_ind_Invalid 						<> 0 or
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
																											 corp_address1_line3_Invalid 						= 0 and
																											 corp_address2_type_cd_Invalid 					= 0 and
																											 corp_address2_type_desc_Invalid 				= 0 and
																											 corp_address2_line3_Invalid 						= 0 and
																											 corp_filing_date_Invalid 							= 0 and
																											 corp_status_desc_Invalid 							= 0 and
																											 corp_inc_state_Invalid 								= 0 and
																											 corp_inc_date_Invalid 									= 0 and
																											 corp_term_exist_cd_Invalid 						= 0 and
																											 corp_term_exist_exp_Invalid 						= 0 and
																											 corp_term_exist_desc_Invalid 					= 0 and
																											 corp_foreign_domestic_ind_Invalid 			= 0 and
																											 corp_forgn_state_cd_Invalid 						= 0 and
																											 corp_forgn_state_desc_Invalid					= 0 and
																											 corp_forgn_date_Invalid 								= 0 and
																											 corp_orig_org_structure_cd_Invalid			= 0 and																										 
																											 corp_for_profit_ind_Invalid 						= 0 and
																											 recordorigin_Invalid 									= 0	
																								  );

		Main_FailBuild					:= map( corp2_mapping.fCalcPercent(count(Main_N.ExpandedInFile(corp_key_invalid<>0)),count(Main_N.ExpandedInFile),false) 										> Scrubs_Corp2_Mapping_CO_Main.Threshold_Percent.CORP_KEY										 => true,
																		corp2_mapping.fCalcPercent(count(Main_N.ExpandedInFile(corp_orig_sos_charter_nbr_invalid<>0)),count(Main_N.ExpandedInFile),false) 	> Scrubs_Corp2_Mapping_CO_Main.Threshold_Percent.CORP_ORIG_SOS_CHARTER_NBR 	 => true,
																		corp2_mapping.fCalcPercent(count(Main_N.ExpandedInFile(corp_legal_name_invalid<>0)),count(Main_N.ExpandedInFile),false) 						> Scrubs_Corp2_Mapping_CO_Main.Threshold_Percent.CORP_LEGAL_NAME 						 => true,
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
																					,output(Main_ScrubsWithExamples, all, named('CorpMainCOScrubsReportWithExamples'+filedate))
																					//Send Alerts if Scrubs exceeds thresholds
																					,if(count(Main_ScrubsAlert) > 0, Main_MailFile, output('CORP2_MAPPING.CO - No "MAIN" Corp Scrubs Alerts'))
																					,Main_ErrorSummary
																					,Main_ScrubErrorReport
																					,Main_SomeErrorValues	
																					,Main_SubmitStats
																			);

	//********************************************************************
  // UPDATE
  //********************************************************************

	Fail_Build						:= if(AR_FailBuild = true or Main_FailBuild = true or Event_FailBuild = true,true,false);
	IsScrubErrors					:= if(AR_IsScrubErrors = true or Main_IsScrubErrors = true or Event_IsScrubErrors = true,true,false);

	VersionControl.macBuildNewLogicalFile(Corp2_Mapping._dataset().thor_cluster_Files + 'in::corp2::' 	+ version + '::ar_' 		+ state_origin, AR_ApprovedRecords	 , write_ar,,,pOverwrite);
	VersionControl.macBuildNewLogicalFile(Corp2_Mapping._dataset().thor_cluster_Files + 'in::corp2::' 	+ version + '::main_' 	+ state_origin, Main_ApprovedRecords , write_main,,,pOverwrite);
	VersionControl.macBuildNewLogicalFile(Corp2_Mapping._dataset().thor_cluster_Files + 'in::corp2::' 	+ version + '::event_' 	+ state_origin, Event_ApprovedRecords, write_event,,,pOverwrite);

	VersionControl.macBuildNewLogicalFile(Corp2_Mapping._dataset().thor_cluster_Files + 'fail::corp2::' + version + '::ar_' 		+ state_origin, AR_F		, write_fail_ar,,,pOverwrite);
	VersionControl.macBuildNewLogicalFile(Corp2_Mapping._dataset().thor_cluster_Files + 'fail::corp2::' + version + '::main_' 	+ state_origin, Main_F	, write_fail_main,,,pOverwrite);
	VersionControl.macBuildNewLogicalFile(Corp2_Mapping._dataset().thor_cluster_Files + 'fail::corp2::' + version + '::event_' 	+ state_origin, Event_F	, write_fail_event,,,pOverwrite);

	mapCO:= sequential (if(pshouldspray = true
												,sequential(Corp2_mapping.fSprayFiles(stringlib.stringtolowercase(state_origin),filedate,pOverwrite := pOverwrite)
																	 ,Corp2_mapping.fSprayFiles(stringlib.stringtolowercase(state_origin+'tm'),tmfiledate,pOverwrite := pOverwrite)
																	 )
												)
											// ,Corp2_Raw_CO.Build_Bases(filedate,tmfiledate,version,puseprod).All
											,Corp2_Raw_CO.Build_TradeMarkHistory(filedate,tmfiledate,version,puseprod,poverwrite).ALL
											,AR_All
											,Main_All
											,Event_All									
											,if(Fail_Build <> true	 
												 ,sequential (write_ar
																		 ,write_main
																		 ,write_event	
																		 ,fileservices.addsuperfile(Corp2_Mapping._Dataset().thor_cluster_Files + 'in::'+Corp2_Mapping._Dataset().NameMapped +'::sprayed::ar'			,Corp2_Mapping._Dataset().thor_cluster_Files + 'in::corp2::'+version+'::ar_'		+state_origin)
																		 ,fileservices.addsuperfile(Corp2_Mapping._Dataset().thor_cluster_Files + 'in::'+Corp2_Mapping._Dataset().NameMapped +'::sprayed::main'		,Corp2_Mapping._Dataset().thor_cluster_Files + 'in::corp2::'+version+'::main_'	+state_origin)																		 
																		 ,fileservices.addsuperfile(Corp2_Mapping._Dataset().thor_cluster_Files + 'in::'+Corp2_Mapping._Dataset().NameMapped +'::sprayed::event'	,Corp2_Mapping._Dataset().thor_cluster_Files + 'in::corp2::'+version+'::event_'	+state_origin)																 
																		 ,if(count(Main_BadRecords) <> 0 or count(AR_BadRecords) <> 0 or count(Event_BadRecords)<>0
																				 ,Corp2_Mapping.Send_Email(state_origin,version,count(Main_BadRecords)<>0,count(AR_BadRecords)<>0,count(Event_BadRecords)<>0,,count(Main_BadRecords),count(AR_BadRecords),count(Event_BadRecords),,count(Main_ApprovedRecords),count(AR_ApprovedRecords),count(Event_ApprovedRecords)).RecordsRejected																				 
																				 ,Corp2_Mapping.Send_Email(state_origin,version,count(Main_BadRecords)<>0,count(AR_BadRecords)<>0,count(Event_BadRecords)<>0,,count(Main_BadRecords),count(AR_BadRecords),count(Event_BadRecords),,count(Main_ApprovedRecords),count(AR_ApprovedRecords),count(Event_ApprovedRecords)).MappingSuccess																				 
																				 )
																		 ,if(IsScrubErrors
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
										
	isFileDateValid 	:= true;
	isTMFileDateValid := true;
	
	return sequential (if( isFileDateValid and isTMFileDateValid
												,mapCO
												,sequential (Corp2_Mapping.Send_Email(state_origin,filedate).InvalidFileDateParm
																		,FAIL('Corp2_Mapping.'+state_origin+' failed.  An invalid filedate or trademark fileate was passed in as a parameter.')
																		)
												)
										);

	end;	// end of Update function

end;  // end of Module