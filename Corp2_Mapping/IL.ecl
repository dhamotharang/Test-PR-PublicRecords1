import address,corp2,corp2_mapping,corp2_raw_il,lib_stringlib,scrubs,scrubs_corp2_mapping_il_ar,
			 scrubs_corp2_mapping_il_event,scrubs_corp2_mapping_il_main,scrubs_corp2_mapping_il_stock,
			 std,tools,ut,versioncontrol; 			 
			 
export IL := MODULE; 

	export Update(string fileDate, string version, boolean pShouldSpray = _Dataset().bShouldSpray, boolean pOverwrite = false, boolean pUseProd = Tools._Constants.IsDataland, string pRunType) := Function

		state_origin			 			:= 'IL';
		state_fips	 				 		:= '17';
		state_desc	 			 			:= 'ILLINOIS';
		uc_runtype							:= corp2.t2u(pRunType);

	  MasterDaily							:= dedup(sort(distribute(Corp2_Raw_IL.Files(filedate,puseprod).Input.Daily.Master,hash(cd41100_file_number)),record,local),record,local) : independent;
	  MasterMonthly						:= dedup(sort(distribute(Corp2_Raw_IL.Files(filedate,puseprod).Input.Monthly.Master,hash(cd41100_file_number)),record,local),record,local) : independent;
		MasterEmpty							:= dataset([],Corp2_Raw_IL.Layouts.MasterLayoutIn);

		AssumedNamesDaily				:= dedup(sort(distribute(Corp2_Raw_IL.Files(filedate,puseprod).Input.Daily.AssumedNames,hash(cd40008_file_number)),record,local),record,local) : independent;
	  AssumedNamesMonthly			:= dedup(sort(distribute(Corp2_Raw_IL.Files(filedate,puseprod).Input.Monthly.AssumedNames,hash(cd40008_file_number)),record,local),record,local) : independent;
	  AssumedNamesEmpty				:= dataset([],Corp2_Raw_IL.Layouts.AssumedOldNamesLayoutIn);
		
		StockDaily							:= dedup(sort(distribute(Corp2_Raw_IL.Files(filedate,puseprod).Input.Daily.Stock,hash(cd40019_file_number)),record,local),record,local) : independent;
	  StockMonthly						:= dedup(sort(distribute(Corp2_Raw_IL.Files(filedate,puseprod).Input.Monthly.Stock,hash(cd40019_file_number)),record,local),record,local) : independent;
	  StockEmpty							:= dataset([],Corp2_Raw_IL.Layouts.StockLayoutIn);

	  Master							 		:= map(uc_runtype = 'DAILY' 		=> MasterDaily,
																	 uc_runtype = 'MONTHLY' 	=> MasterMonthly,
																	 MasterEmpty
																	);		

	  AssumedNames						:= map(uc_runtype = 'DAILY' 		=> AssumedNamesDaily,
																	 uc_runtype = 'MONTHLY' 	=> AssumedNamesMonthly,
																	 AssumedNamesEmpty
																	);

	  Stock										:= map(uc_runtype = 'DAILY' 		=> StockDaily,
																	 uc_runtype = 'MONTHLY' 	=> StockMonthly,
																	 StockEmpty																			 
																	);
																	
		//********************************************************************
		// PROCESS CORPORATE (MASTER) DATA
		//********************************************************************/ 
		Corp2_mapping.LayoutsCommon.Main MasterMainTransform(Corp2_Raw_IL.Layouts.MasterLayoutIn l) := transform
				isStateOfOrigin														:= if(Corp2_Raw_IL.Functions_DM.State_Foreign_Codes(l.cd41100_state_code) in [state_origin,state_desc,state_fips,''],true,false);
				self.dt_vendor_first_reported							:= (integer)fileDate;
				self.dt_vendor_last_reported							:= (integer)fileDate;
				self.dt_first_seen												:= (integer)fileDate;
				self.dt_last_seen													:= (integer)fileDate;
				self.corp_ra_dt_first_seen								:= (integer)fileDate;
				self.corp_ra_dt_last_seen									:= (integer)fileDate;			
				self.corp_key															:= state_fips + '-C-' + corp2.t2u(l.cd41100_file_number);
				self.corp_vendor													:= state_fips;
				self.corp_state_origin										:= state_origin;			
				self.corp_process_date										:= fileDate;
				self.corp_orig_sos_charter_nbr        		:= corp2.t2u(l.cd41100_file_number);
				self.corp_legal_name                  		:= Corp2_mapping.fCleanBusinessName(state_origin,state_desc,l.cd41100_corp_name).BusinessName;				
				self.corp_ln_name_type_cd   							:= if(corp2.t2u(l.cd41100_type_corp) = '3','09','01'); 
				self.corp_ln_name_type_desc 							:= if(corp2.t2u(l.cd41100_type_corp) = '3','REGISTRATION','LEGAL');
				self.corp_filing_desc											:= if(corp2.t2u(l.cd41100_type_corp) = '3' and Corp2_mapping.fValidateDate(l.cd41100_incorp_date,'CCYYMMDD').PastDate<>'','ORIGINAL REGISTRATION FILING DATE','');
				self.corp_status_cd 											:= corp2.t2u(l.cd41100_status);
				self.corp_status_desc 										:= Corp2_Raw_IL.Functions_DM.CorpStatusDesc(l.cd41100_status,l.cd41100_sec_name_addr);
				self.corp_status_date											:= if(corp2.t2u(l.cd41100_status) in ['04','06','07','08','12'],Corp2_mapping.fValidateDate(Corp2_Raw_IL.Functions_DM.CorpStatusDate(l.cd41100_sec_name_addr),'CCYYMMDD').GeneralDate,'');
				self.corp_standing												:= if(corp2.t2u(l.cd41100_status) in ['00'],'Y','');	//Status = 00 means "good standing"
			  self.corp_status_comment 									:= if(corp2.t2u(l.cd41100_status) in ['00'], 					//Status = 00 means "good standing"
																											  'STATUS BASED ON: (A) THE FRANCHISE TAXES/ANNUAL REPORTS HAVE BEEN FILED ON ' 	+
																											  'A TIMELY BASIS AND (B) THE ENTITY HAS A VALID REGISTERED AGENT. THESE ITEMS ' 	+
																											  'SHOULD BE VERIFIED',
																											  ''														 
																											 );
				self.corp_inc_state 											:= state_origin;
				self.corp_inc_date 												:= if(corp2.t2u(l.cd41100_type_corp) in ['4','5'] and isStateOfOrigin,Corp2_mapping.fValidateDate(l.cd41100_incorp_date,'CCYYMMDD').PastDate,'');
				self.corp_anniversary_month								:= Corp2_Raw_IL.Functions_DM.CorpAnniversaryMonth(self.corp_inc_date[5..6]);
				self.corp_term_exist_cd 									:= if(corp2.t2u(l.cd41100_type_corp) <> '3',
																												map(Corp2_mapping.fValidateDate(l.cd41100_duration_date,'CCYYMMDD').GeneralDate = ''  => 'P',
																														corp2.t2u(l.cd41100_duration_date) in ['99999999']								       					=> 'P',
																														Corp2_mapping.fValidateDate(l.cd41100_duration_date,'CCYYMMDD').GeneralDate <> '' => 'D',
																														''
																														),
																												''
																											 );
				self.corp_term_exist_exp 									:= if(self.corp_term_exist_cd = 'D',Corp2_mapping.fValidateDate(l.cd41100_duration_date,'CCYYMMDD').GeneralDate,'');
				self.corp_term_exist_desc 								:= map(self.corp_term_exist_cd = 'D' => 'EXPIRATION DATE',
																												 self.corp_term_exist_cd = 'P' => 'PERPETUAL',																												 
																												 ''
																												);
				self.corp_foreign_domestic_ind 						:= map (corp2.t2u(l.cd41100_type_corp) in ['4','5'] and isStateOfOrigin  		 => 'D',
																												  corp2.t2u(l.cd41100_type_corp) in ['5','6'] and not(isStateOfOrigin) => 'F',
																												  ''
																												 );
				self.corp_forgn_state_cd 									:= if(not(isStateOfOrigin),Corp2_Raw_IL.Functions_DM.State_Foreign_Codes(l.cd41100_state_code),'');
				self.corp_forgn_state_desc 								:= if(not(isStateOfOrigin),Corp2_Raw_IL.Functions_DM.CorpForgnStateDesc(l.cd41100_state_code),'');
				self.corp_forgn_date											:= map(corp2.t2u(l.cd41100_type_corp) = '6'														=> Corp2_mapping.fValidateDate(l.cd41100_incorp_date,'CCYYMMDD').PastDate,
																												 corp2.t2u(l.cd41100_type_corp) = '5'  and not(isStateOfOrigin) => Corp2_mapping.fValidateDate(l.cd41100_incorp_date,'CCYYMMDD').PastDate,
																												 ''
																												);
				self.corp_orig_org_structure_desc 				:= Corp2_Raw_IL.Functions_DM.CorpOrigOrgStructureDesc(l.cd41100_type_corp);
				self.corp_for_profit_ind									:= map(corp2.t2u(l.cd41100_type_corp) = '5'				 			 				=> 'N',
																												 corp2.t2u(l.cd41100_corp_intent) between '001' and '045' => 'P',
																												 corp2.t2u(l.cd41100_corp_intent) between '046' and '060' => 'N',
																												 ''
																												 );																												 
				self.corp_orig_bus_type_cd 								:= if(corp2.t2u(l.cd41100_corp_intent) = '000','',corp2.t2u(l.cd41100_corp_intent)); //scrubbing
				self.corp_orig_bus_type_desc 							:= Corp2_Raw_IL.Functions_DM.CorpOrigBusTypeDesc(l.cd41100_corp_intent);																											 
				//corp_addl_info is an overloaded field
				self.corp_addl_info 										  := map(corp2.t2u(l.cd41100_regulated_ind) = '0' => 'NOT REGULATED BY ILLINOIS COMMERCE COMMISSION',
																												 corp2.t2u(l.cd41100_regulated_ind) = '1' => 'REGULATED BY ILLINOIS COMMERCE COMMISSION',
																												 ''
																												);
				self.corp_ra_full_name										:= map(regexfind('(\\*)*( )*AGENT( )*VACATED( )*(\\*)*',corp2.t2u(l.cd41100_agent_name),0)<>'' => Corp2_mapping.fCleanBusinessName(state_origin,state_desc,regexreplace('(\\*)*( )*AGENT( )*VACATED( )*(\\*)*',corp2.t2u(l.cd41100_agent_name),'')).BusinessName,
																												 Corp2_mapping.fCleanBusinessName(state_origin,state_desc,l.cd41100_agent_name).BusinessName
																												);
				self.corp_ra_title_desc										:= if(self.corp_ra_full_name<>'','REGISTERED AGENT','');
				self.corp_ra_effective_date 							:= Corp2_mapping.fValidateDate(l.cd41100_agent_change_date,'CCYYMMDD').GeneralDate;
				tempAddress 															:= Address.CleanAddress182(l.cd41100_agent_street,l.cd41100_agent_zip); //used to get state
				self.corp_ra_address_type_cd          		:= if(Corp2_Mapping.fAddressExists(state_origin,state_desc,l.cd41100_agent_street,,l.cd41100_agent_city,tempAddress[115..116],l.cd41100_agent_zip).ifAddressExists,'R','');
				self.corp_ra_address_type_desc        		:= if(Corp2_Mapping.fAddressExists(state_origin,state_desc,l.cd41100_agent_street,,l.cd41100_agent_city,tempAddress[115..116],l.cd41100_agent_zip).ifAddressExists,'REGISTERED OFFICE','');
				self.corp_ra_address_line1								:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.cd41100_agent_street,,l.cd41100_agent_city,tempAddress[115..116],l.cd41100_agent_zip).AddressLine1;
				self.corp_ra_address_line2								:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.cd41100_agent_street,,l.cd41100_agent_city,tempAddress[115..116],l.cd41100_agent_zip).AddressLine2;
				self.corp_ra_address_line3								:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.cd41100_agent_street,,l.cd41100_agent_city,tempAddress[115..116],l.cd41100_agent_zip).AddressLine3;
				self.ra_prep_addr_line1										:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.cd41100_agent_street,,l.cd41100_agent_city,tempAddress[115..116],l.cd41100_agent_zip).PrepAddrLine1;
				self.ra_prep_addr_last_line								:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.cd41100_agent_street,,l.cd41100_agent_city,tempAddress[115..116],l.cd41100_agent_zip).PrepAddrLastLine;																												
				self.corp_agent_county										:= Corp2_Raw_IL.Functions_DM.CorpAgentCounty(l.cd41100_agent_county_code); //scrubbing
				self.corp_country_of_formation						:= Corp2_Raw_IL.Functions_DM.CorpCountryOfFormation(l.cd41100_state_code); //scrubbing
				self.corp_fiscal_year_month								:= if((integer)l.cd41100_fiscal_year=0,'',(string)(integer)l.cd41100_fiscal_year);
				self.corp_merged_corporation_id						:= if(corp2.t2u(l.cd41100_survivor_nbr) not in ['','00000000'],corp2.t2u(l.cd41100_file_number),'');
				self.corp_merger_date											:= if(corp2.t2u(l.cd41100_status) = '09',Corp2_mapping.fValidateDate(Corp2_Raw_IL.Functions_DM.CorpStatusDate(l.cd41100_sec_name_addr),'CCYYMMDD').GeneralDate,'');
				self.corp_merger_desc											:= 'TWO OR MORE CORPORATIONS MERGED/CONSOLIDATED';
				self.corp_merger_id												:= if(corp2.t2u(l.cd41100_status) = '09',
																											 map(corp2.t2u(l.cd41100_survivor_nbr) not in ['','00000000'] => corp2.t2u(l.cd41100_survivor_nbr),
																													 regexfind('[0-9]{8}$|[A-Z]{8}$',corp2.t2u(l.cd41100_sec_name_addr),0) //get the last 8 characters
																													),
																											 ''
																											);
				self.corp_merger_indicator								:= if(corp2.t2u(l.cd41100_status) = '09','N','');
				self.corp_name_reservation_date					  := if(corp2.t2u(l.cd41100_type_corp) = '3',Corp2_mapping.fValidateDate(l.cd41100_incorp_date,'CCYYMMDD').PastDate,'');
				self.corp_name_reservation_expiration_date:= if(corp2.t2u(l.cd41100_status) = '10',Corp2_mapping.fValidateDate(Corp2_Raw_IL.Functions_DM.CorpStatusDate(l.cd41100_sec_name_addr),'CCYYMMDD').GeneralDate,'');
				self.corp_name_status_date								:= if(corp2.t2u(l.cd41100_type_corp) = '3',Corp2_mapping.fValidateDate(l.cd41100_duration_date,'CCYYMMDD').PastDate,'');
				self.corp_name_status_desc					      := if(self.corp_name_status_date<>'','REGISTRATION RENEWAL DATE','');
				self.corp_organizational_comments					:= if(corp2.t2u(l.cd41100_regulated_ind) = '1','REGULATED BY ILLINOIS COMMERCE COMMISSION','');
				self.internalfield1												:= corp2.t2u(l.cd41100_type_corp); //for scrubbing purposes
				self.recordorigin													:= 'C';
				self 																			:= [];
		end;

		MapMaster				:= project(master,MasterMainTransform(left))  : independent;

		//********************************************************************
		// PROCESS CORPORATE CONTACT (CONT) DATA
		//*******************************************************************
		Corp2_mapping.LayoutsCommon.Main MasterContactsTransform(Corp2_Raw_IL.Layouts.MasterLayoutIn l,integer c) := transform,
		skip(c = 1 and corp2.t2u(l.cd41100_pres_name_addr) in ['','AS ABOVE','NONE','SAME','VACANT'] or
				 c = 2 and corp2.t2u(l.cd41100_sec_name_addr)  in ['','AS ABOVE','NONE','SAME','VACANT'] or
 				 c = 2 and corp2.t2u(l.cd41100_sec_name_addr[1..11])  = 'INVOLUNTARY'
				)
				self.dt_vendor_first_reported							:= (integer)fileDate;
				self.dt_vendor_last_reported							:= (integer)fileDate;
				self.dt_first_seen												:= (integer)fileDate;
				self.dt_last_seen													:= (integer)fileDate;
				self.corp_ra_dt_first_seen								:= (integer)fileDate;
				self.corp_ra_dt_last_seen									:= (integer)fileDate;			
				self.corp_key															:= state_fips + '-C-' + corp2.t2u(l.cd41100_file_number);
				self.corp_vendor													:= state_fips;
				self.corp_state_origin										:= state_origin;			
				self.corp_process_date										:= fileDate;
				self.corp_orig_sos_charter_nbr        		:= corp2.t2u(l.cd41100_file_number);
				self.corp_legal_name                  		:= Corp2_mapping.fCleanBusinessName(state_origin,state_desc,l.cd41100_corp_name).BusinessName;				
				self.corp_inc_state 											:= state_origin;
				temp_cont_name														:= choose(c,Corp2_Mapping.fCleanPersonName(state_origin,state_desc,'','',Corp2_Raw_IL.Functions_DM.ContName(l.cd41100_pres_name_addr)).LastName,
																															Corp2_Mapping.fCleanPersonName(state_origin,state_desc,'','',Corp2_Raw_IL.Functions_DM.ContName(l.cd41100_sec_name_addr)).LastName
																													 );
				//Removing any "full name" that is 3 or less characters.  These are invalid names.
				self.cont_full_name												:= if(length(corp2.t2u(temp_cont_name)) in [1,2,3],'',corp2.t2u(temp_cont_name));
				self.cont_type_cd													:= if(self.cont_full_name<>'','T','');
				self.cont_type_desc												:= if(self.cont_full_name<>'','CONTACT','');
				self.cont_title1_desc											:= choose(c,if(self.cont_full_name<>'','PRESIDENT',''),
																															if(self.cont_full_name<>'','SECRETARY','')
																													 );
				address2use 															:= choose(c,l.cd41100_pres_name_addr,
																															if(self.cont_full_name<>'' and regexfind(' SAME',corp2.t2u(l.cd41100_sec_name_addr),0)<>'' ,l.cd41100_pres_name_addr,l.cd41100_sec_name_addr)
																													 );
				tempContactAddress												:= choose(c,stringlib.splitwords(Corp2_Raw_IL.Functions_DM.ContAddress(address2use),'|',true),
																															stringlib.splitwords(Corp2_Raw_IL.Functions_DM.ContAddress(address2use),'|',true)
																													 );
				self.cont_address_type_cd		          		:= if(Corp2_Mapping.fAddressExists(state_origin,state_desc,tempContactAddress[1],,tempContactAddress[2],tempContactAddress[3],tempContactAddress[4]).ifAddressExists,'T','');
				self.cont_address_type_desc        				:= if(Corp2_Mapping.fAddressExists(state_origin,state_desc,tempContactAddress[1],,tempContactAddress[2],tempContactAddress[3],tempContactAddress[4]).ifAddressExists,'CONTACT','');																													 
				self.cont_address_line1										:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,tempContactAddress[1],,tempContactAddress[2],tempContactAddress[3],tempContactAddress[4]).AddressLine1;
				self.cont_address_line2										:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,tempContactAddress[1],,tempContactAddress[2],tempContactAddress[3],tempContactAddress[4]).AddressLine2;
				self.cont_address_line3										:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,tempContactAddress[1],,tempContactAddress[2],tempContactAddress[3],tempContactAddress[4]).AddressLine3;
				self.cont_prep_addr_line1     						:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,tempContactAddress[1],,tempContactAddress[2],tempContactAddress[3],tempContactAddress[4]).PrepAddrLine1;
				self.cont_prep_addr_last_line 						:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,tempContactAddress[1],,tempContactAddress[2],tempContactAddress[3],tempContactAddress[4]).PrepAddrLastLine;
				self.internalfield1												:= corp2.t2u(l.cd41100_type_corp); //for scrubbing purposes
				self.recordorigin													:= 'T';
				self 																			:= [];
		end;

		MasterContacts 		:= normalize(master, 2, MasterContactsTransform(left,counter));
		MapMasterContacts := MasterContacts(corp2.t2u(cont_full_name)<>'');
		
		
		jAssumedNames	:= join(AssumedNames, Master, 
											left.cd40008_file_number = right.cd41100_file_number,
											transform(Corp2_Raw_IL.Layouts.AssumedNames_TempLay, 
																 self.cd41100_state_code  := right.cd41100_state_code;
																 self.cd41100_type_corp 	:= right.cd41100_type_corp;
																 self.cd41100_incorp_date  := right.cd41100_incorp_date;
																 self := left; self := right; self := [];),
											left outer,local) : independent;
											
		Corp2_mapping.LayoutsCommon.Main AssumedNamesTransform(Corp2_Raw_IL.Layouts.AssumedNames_TempLay l) := transform
				self.dt_vendor_first_reported							:= (integer)fileDate;
				self.dt_vendor_last_reported							:= (integer)fileDate;
				self.dt_first_seen												:= (integer)fileDate;
				self.dt_last_seen													:= (integer)fileDate;
				self.corp_ra_dt_first_seen								:= (integer)fileDate;
				self.corp_ra_dt_last_seen									:= (integer)fileDate;			
				self.corp_key															:= state_fips + '-C-' + corp2.t2u(l.cd40008_file_number);
				self.corp_vendor													:= state_fips;
				self.corp_state_origin										:= state_origin;			
				self.corp_process_date										:= fileDate;		
				self.corp_orig_sos_charter_nbr        		:= corp2.t2u(l.cd40008_file_number);
				self.corp_legal_name                  		:= Corp2_mapping.fCleanBusinessName(state_origin,state_desc,l.cd40008_assumed_old_name).BusinessName;				
				self.corp_ln_name_type_cd   							:= map(corp2.t2u(l.cd40008_assumed_old_ind) in ['1','4','8','9'] => '06', //assumed
																												 corp2.t2u(l.cd40008_assumed_old_ind) in ['2'] 			 			 => 'P',  //prior
																												 corp2.t2u(l.cd40008_assumed_old_ind) in ['3','5','6','7'] => 'I',  //cancellation/expired
																												 corp2.t2u(l.cd40008_assumed_old_ind) //scrubbing
																												);
				self.corp_ln_name_type_desc 							:= Corp2_Raw_IL.Functions_DM.CorpLNNameTypeDesc(l.cd40008_assumed_old_ind);
				self.corp_inc_state 											:= state_origin;																												
				self.corp_name_comment        						:= Corp2_Raw_IL.Functions_DM.CorpNameComment(l.cd40008_date_cancel,l.cd40008_assumed_old_ind,l.cd40008_assumed_old_date,l.cd40008_assumed_curr_date);
				self.corp_name_status_desc								:= Corp2_Raw_IL.Functions_DM.CorpNameStatusDescription(l.cd40008_date_cancel,l.cd40008_assumed_curr_date);
				self.corp_name_status_date								:= map(self.corp_name_status_desc = 'NAME CANCELLED' 				=> Corp2_mapping.fValidateDate(l.cd40008_date_cancel,'CCYYMMDD').PastDate,
																												 self.corp_name_status_desc = 'ASSUMED NAME RENEWED'	=> Corp2_mapping.fValidateDate(l.cd40008_assumed_curr_date,'CCYYMMDD').PastDate,
																												 ''
																												);
				self.internalfield1												:= corp2.t2u(l.cd40008_assumed_old_ind); //for scrubbing purposes
				
				isStateOfOrigin														:= if(Corp2_Raw_IL.Functions_DM.State_Foreign_Codes(l.cd41100_state_code) in [state_origin,state_desc,state_fips,''],true,false);
				self.corp_inc_date 												:= if(corp2.t2u(l.cd41100_type_corp) in ['4','5'] and isStateOfOrigin,Corp2_mapping.fValidateDate(l.cd41100_incorp_date,'CCYYMMDD').PastDate,'');
				self.corp_forgn_date											:= map(corp2.t2u(l.cd41100_type_corp) = '6'														=> Corp2_mapping.fValidateDate(l.cd41100_incorp_date,'CCYYMMDD').PastDate,
																												 corp2.t2u(l.cd41100_type_corp) = '5'  and not(isStateOfOrigin) => Corp2_mapping.fValidateDate(l.cd41100_incorp_date,'CCYYMMDD').PastDate,
																												 '');
				self.recordorigin													:= 'C';
				self 																			:= [];
		end;
					
		MapAssumedNames	 := project(jAssumedNames, AssumedNamesTransform(left));
		
			 
		AllMain 					 := MapMaster + MapMasterContacts + MapAssumedNames;
		MapMain						 := dedup(sort(distribute(AllMain,hash(corp_key)),record,local),record,local) : independent;
		
		//********************************************************************
		// PROCESS CORPORATE ANNUAL REPORT DATA
		//********************************************************************
 		Corp2_mapping.LayoutsCommon.AR MasterARTransform(Corp2_Raw_IL.Layouts.MasterLayoutIn l, integer c) := transform,
		skip(c = 2 and (integer)(l.cd41100_pv_factor+l.cd41100_pv_paid_amount+l.cd41100_pv_ar_cap+l.cd41100_pv_del_run_date+l.cd41100_pv_run_date+l.cd41100_pv_paid_date+l.cd41100_pv_ill_cap)=0)
				self.corp_key															:= state_fips + '-C-' + corp2.t2u(l.cd41100_file_number);
				self.corp_vendor													:= state_fips;
				self.corp_state_origin										:= state_origin;			
				self.corp_process_date										:= fileDate;
				self.corp_sos_charter_nbr   			     		:= corp2.t2u(l.cd41100_file_number);
				self.ar_year							   			     		:= choose(c,Corp2_mapping.fValidateDate(l.cd41100_cr_paid_date,'CCYYMMDD').PastDate[1..4],
																															Corp2_mapping.fValidateDate(l.cd41100_pv_paid_date,'CCYYMMDD').PastDate[1..4]
																													 );
				self.ar_mailed_dt													:= choose(c,Corp2_mapping.fValidateDate(l.cd41100_cr_run_date,'CCYYMMDD').PastDate,
																															Corp2_mapping.fValidateDate(l.cd41100_pv_run_date,'CCYYMMDD').PastDate
																													 );
				self.ar_filed_dt													:= choose(c,Corp2_mapping.fValidateDate(l.cd41100_cr_paid_date,'CCYYMMDD').PastDate,
																															Corp2_mapping.fValidateDate(l.cd41100_pv_paid_date,'CCYYMMDD').PastDate
																													 );
				self.ar_delinquent_dt											:= choose(c,Corp2_mapping.fValidateDate(l.cd41100_cr_del_run_date,'CCYYMMDD').PastDate,
																															Corp2_mapping.fValidateDate(l.cd41100_pv_del_run_date,'CCYYMMDD').PastDate
																													 );
				self.ar_tax_factor												:= choose(c,if((integer)l.cd41100_cr_factor<>0,l.cd41100_cr_factor[1]+'.'+l.cd41100_cr_factor[2..],''),
																															if((integer)l.cd41100_pv_factor<>0,l.cd41100_pv_factor[1]+'.'+l.cd41100_pv_factor[2..],'')
																													 );
				self.ar_tax_amount_paid									  := choose(c,if((integer)l.cd41100_cr_paid_amount=0,'', Corp2_Raw_IL.Functions_DM.ARTaxAmountPaid(l.cd41100_cr_paid_amount,true)),
																															if((integer)l.cd41100_pv_paid_amount=0,'', Corp2_Raw_IL.Functions_DM.ARTaxAmountPaid(l.cd41100_pv_paid_amount,true))
																													 );
				self.ar_annual_report_cap									:= choose(c,if((integer)l.cd41100_ar_cap<>0,l.cd41100_ar_cap,''),
																															if((integer)l.cd41100_pv_ar_cap<>0,l.cd41100_pv_ar_cap,'')
																													 );
				self.ar_illinois_capital									:= choose(c,if((integer)l.cd41100_ill_cap=0,'','$'+(string)(integer)l.cd41100_ill_cap),
																															if((integer)l.cd41100_pv_ill_cap=0,'','$'+(string)(integer)l.cd41100_pv_ill_cap)
																													 );
				self.ar_comment														:= if(self.ar_illinois_capital<>'','NEW CAPITAL FROM BUSINESS IN IL','');
				self.ar_type															:= choose(c,'CURRENT','PREVIOUS');
				self.ar_status														:= if(corp2.t2u(l.cd41100_hold_prorate) = '1','CORPORATION HAS FAILED TO PAY THE REPORT OF ISSUANCES','');
				self.ar_paid_date													:= choose(c,Corp2_mapping.fValidateDate(l.cd41100_cr_paid_date,'CCYYMMDD').PastDate,
																															Corp2_mapping.fValidateDate(l.cd41100_pv_paid_date,'CCYYMMDD').PastDate
																													 );
				self.ar_extension_date										:= Corp2_mapping.fValidateDate(l.cd41100_extended_date,'CCYYMMDD').GeneralDate;
				self																			:= [];
		end;
															
		MapMaster2AR		:= normalize(Master, 2, MasterARTransform(left,counter));		
		MapAR					 	:= dedup(sort(distribute(MapMaster2AR,hash(corp_key)),record,local),record,local) : independent;

		//********************************************************************
		// PROCESS CORPORATE EVENT DATA
		//********************************************************************
		Corp2_mapping.LayoutsCommon.Events MasterEventsTransform(Corp2_Raw_IL.Layouts.MasterLayoutIn l) := transform
				self.corp_key															:= state_fips + '-C-' + corp2.t2u(l.cd41100_file_number);
				self.corp_vendor													:= state_fips;
				self.corp_state_origin										:= state_origin;			
				self.corp_process_date										:= fileDate;
				self.corp_sos_charter_nbr        					:= corp2.t2u(l.cd41100_file_number);
				self.event_filing_date										:= Corp2_mapping.fValidateDate(l.cd41100_date_last_change,'CCYYMMDD').PastDate;
				self.event_date_type_desc									:= if(self.event_filing_date<>'','DATE REQUIRING SECTION CODE','');
				self.event_desc														:= Corp2_Raw_IL.Functions_DM.EventDesc(l.cd41100_section_code);
				self 																			:= [];
		end;

		MapMaster2Events	:= project(master,MasterEventsTransform(left));
		Events						:= MapMaster2Events(corp2.t2u(event_filing_date+event_date_type_desc+event_desc)<>'');
		MapEvents				  := dedup(sort(distribute(Events,hash(corp_key)),record,local),record,local) : independent;

		//********************************************************************
		// PROCESS CORPORATE STOCK DATA
		//********************************************************************
		Corp2_mapping.LayoutsCommon.Stock MasterStockTransform(Corp2_Raw_IL.Layouts.MasterLayoutIn L) := transform
				self.corp_key															:= state_fips + '-C-' + corp2.t2u(l.cd41100_file_number);
				self.corp_vendor													:= state_fips;
				self.corp_state_origin										:= state_origin;			
				self.corp_process_date										:= fileDate;
				self.corp_sos_charter_nbr        					:= corp2.t2u(l.cd41100_file_number);
				self.stock_change_ind											:= if(Corp2_mapping.fValidateDate(l.cd41100_stock_date,'CCYYMMDD').PastDate<>'','Y','N');
				self.stock_change_date										:= Corp2_mapping.fValidateDate(l.cd41100_stock_date,'CCYYMMDD').PastDate;
				self.stock_change_in_cap									:= Corp2_mapping.fValidateDate(l.cd41100_cap_date,'CCYYMMDD').PastDate;
				self.stock_tax_capital										:= if((integer)l.cd41100_tax_cap=0,'','$'+ (string)(integer)l.cd41100_tax_cap);
				self.stock_total_capital									:= if((integer)l.cd41100_total_cap=0,'','$'+ (string)(integer)l.cd41100_total_cap);
				self 																			:= [];
		end;

		MasterStock					:= project(Master,MasterStockTransform(left));
		MapMasterStock			:= MasterStock(corp2.t2u(stock_change_date + stock_change_in_cap + stock_tax_capital + stock_total_capital) <> '');

		Corp2_mapping.LayoutsCommon.Stock StockTransform(Corp2_Raw_IL.Layouts.StockLayoutIn l) := transform
				self.corp_key															:= state_fips + '-C-' + corp2.t2u(l.cd40019_file_number);
				self.corp_vendor													:= state_fips;
				self.corp_state_origin										:= state_origin;			
				self.corp_process_date										:= fileDate;
				self.corp_sos_charter_nbr        					:= corp2.t2u(l.cd40019_file_number);
				self.stock_class													:= Corp2_Raw_IL.Functions_DM.StockClass(l.cd40019_stock_class);
				self.stock_shares_issued									:= if((integer)l.cd40019_issued_shares=0,'',Corp2_Raw_IL.Functions_DM.StockSharesIssued(l.cd40019_issued_shares));
				self.stock_authorized_nbr									:= if((integer)l.cd40019_authorized_shares=0,'',(string)(integer)l.cd40019_authorized_shares);
				self.stock_par_value											:= if((integer)l.cd40019_par_value=0,'',Corp2_Raw_IL.Functions_DM.StockParValue(l.cd40019_par_value));
				self.stock_voting_rights_ind							:= corp2.t2u(l.cd40019_voting_rights);
				self.stock_stock_series										:= Corp2_Raw_IL.Functions_DM.StockStockSeries(l.cd40019_stock_series);
				self 																			:= [];
		end;

		StockMaster				:= project(Stock,StockTransform(left));
		StockDist					:= sort(distribute(StockMaster,hash(corp_key)),corp_key,local) : independent;

		//Only keep those "stock" records that has an associated "master" record.
    MasterDist		 		:= distribute(MapMaster,hash(corp_key)): independent;		
		
		MappedStock				:= join(MasterDist,StockDist,
														  left.corp_key = right.corp_key,
															transform(Corp2_mapping.LayoutsCommon.Stock,
																				self := right;
																			 ),
															inner,
															local
														 );		

		AllStock					:= sort(distribute(MapMasterStock + MappedStock,hash(corp_key)),corp_key,local) : independent;
		
		Corp2_Mapping.LayoutsCommon.Stock RollUpStockTransform(Corp2_Mapping.LayoutsCommon.Stock l, Corp2_Mapping.LayoutsCommon.Stock r) := transform			
			self.stock_change_ind						:= if(l.stock_change_ind<>'',l.stock_change_ind,r.stock_change_ind);
			self.stock_change_date					:= if(l.stock_change_date<>'',l.stock_change_date,r.stock_change_date);
			self.stock_change_in_cap				:= if(l.stock_change_in_cap<>'',l.stock_change_in_cap,r.stock_change_in_cap);
			self.stock_tax_capital					:= if(l.stock_tax_capital<>'',l.stock_tax_capital,r.stock_tax_capital);
			self.stock_total_capital				:= if(l.stock_total_capital<>'',l.stock_total_capital,r.stock_total_capital);
			self.stock_class								:= if(l.stock_class<>'',l.stock_class,r.stock_class);
			self.stock_shares_issued				:= if(l.stock_shares_issued<>'',l.stock_shares_issued,r.stock_shares_issued);
			self.stock_authorized_nbr				:= if(l.stock_authorized_nbr<>'',l.stock_authorized_nbr,r.stock_authorized_nbr);
			self.stock_par_value						:= if(l.stock_par_value<>'',l.stock_par_value,r.stock_par_value);
			self.stock_voting_rights_ind		:= if(l.stock_voting_rights_ind<>'',l.stock_voting_rights_ind,r.stock_voting_rights_ind);
			self.stock_stock_series					:= if(l.stock_stock_series<>'',l.stock_stock_series,r.stock_stock_series);
			self														:= l;
		end; 
		
		//This rollup combines the stock records that were created from the master and stock files into one record.
		RollUpStock			 := rollup(AllStock,
															 left.corp_key = right.corp_key,
															 RollUpStockTransform(left, right),
															 local
															) : independent;	

		MapStock					:= dedup(sort(distribute(RollUpStock,hash(corp_key)),record,local),record,local) : independent;

	//********************************************************************
  // SCRUB AR 
  //********************************************************************	
		AR_F := MapAR;
		AR_S := Scrubs_Corp2_Mapping_IL_AR.Scrubs;				// Scrubs module
		AR_N := AR_S.FromNone(AR_F); 											// Generate the error flags
		AR_T := AR_S.FromBits(AR_N.BitmapInfile);     		// Use the FromBits module; makes my bitmap datafile easier to get to
		AR_U := AR_S.FromExpanded(AR_N.ExpandedInFile); 	// Pass the expanded error flags into the Expanded module

		//Outputs reports
		AR_ErrorSummary			 	 := output(AR_U.SummaryStats, named('AR_ErrorSummary_'+uc_runtype+'_IL'+filedate));
		AR_ScrubErrorReport 	 := output(choosen(AR_U.AllErrors, 1000), named('AR_ScrubErrorReport_'+uc_runtype+'_IL'+filedate));
		AR_SomeErrorValues		 := output(choosen(AR_U.BadValues, 1000), named('AR_SomeErrorValues_'+uc_runtype+'_IL'+filedate));
		AR_IsScrubErrors		 	 := IF(count(AR_U.AllErrors)<> 0,true,false);

		// Orbit Stats
		AR_OrbitStats				 	 := AR_U.OrbitStats();

		//Outputs files
		AR_CreateBitMaps			 := output(AR_N.BitmapInfile,,'~thor_data::corp_'+uc_runtype+'_IL_ar_scrubs_bits',overwrite,compressed);	//long term storage
		AR_TranslateBitMap		 := output(AR_T);

		//Submits Profile's stats to Orbit
		AR_SubmitStats 			   := Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_IL_AR'+uc_runtype,'ScrubsAlerts', AR_OrbitStats, version,'Corp_IL_AR',version+uc_runtype).SubmitStats;
		AR_ScrubsWithExamples  := Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_IL_AR'+uc_runtype,'ScrubsAlerts', AR_OrbitStats, version,'Corp_IL_AR',version+uc_runtype).CompareToProfile_with_Examples;

		AR_ScrubsAlert				 := AR_ScrubsWithExamples(RejectWarning = 'Y');
		AR_ScrubsAttachment	   := Scrubs.fn_email_attachment(AR_ScrubsAlert);
		AR_MailFile					   := FileServices.SendEmailAttachData(corp2.Email_Notification_Lists.AttachedList
																															,'Scrubs CorpAR_'+uc_runtype+'_IL Report' //subject
																															,'Scrubs CorpAR_'+uc_runtype+'_IL Report' //body
																															,(data)AR_ScrubsAttachment
																															,'text/csv'
																															,'Corp'+uc_runtype+'ILARScrubsReport.csv'																															
																															);

		AR_BadRecords				 := AR_N.ExpandedInFile(	
																								corp_key_Invalid							  			<> 0 or
																								corp_vendor_Invalid							  		<> 0 or
																								corp_state_origin_Invalid							<> 0 or
																								corp_process_date_Invalid							<> 0 or
																								corp_sos_charter_nbr_Invalid					<> 0 or
																								ar_year_Invalid							  				<> 0 or
																								ar_mailed_dt_Invalid							  	<> 0 or
																								ar_filed_dt_Invalid							  		<> 0 or
																								ar_delinquent_dt_Invalid							<> 0 or
																								ar_tax_factor_Invalid							  	<> 0 or
																								ar_tax_amount_paid_Invalid				  	<> 0 or
																								ar_illinois_capital_Invalid						<> 0 or
																								ar_paid_date_Invalid 									<> 0	
																							 );

		AR_GoodRecords			 := AR_N.ExpandedInFile(
																								corp_key_Invalid							  			= 0 and
																								corp_vendor_Invalid							  		= 0 and
																								corp_state_origin_Invalid							= 0 and
																								corp_process_date_Invalid							= 0 and
																								corp_sos_charter_nbr_Invalid					= 0 and
																								ar_year_Invalid							  				= 0 and
																								ar_mailed_dt_Invalid							  	= 0 and
																								ar_filed_dt_Invalid							  		= 0 and
																								ar_delinquent_dt_Invalid							= 0 and
																								ar_tax_factor_Invalid							  	= 0 and
																								ar_tax_amount_paid_Invalid				  	= 0 and
																								ar_illinois_capital_Invalid						= 0 and
																								ar_paid_date_Invalid 									= 0	
																								);

		AR_FailBuild					 := if(count(AR_GoodRecords) = 0,true,false);

		AR_ApprovedRecords		 := project(AR_GoodRecords,transform(Corp2_Mapping.LayoutsCommon.AR,self := left;));


		AR_ALL								 := sequential(IF(count(AR_BadRecords) <> 0
																								 ,IF (poverwrite
																										 ,OUTPUT(AR_BadRecords,,Corp2_Mapping._Dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::ar_'+uc_runtype+'_'+state_origin,overwrite,__compressed__)
																										 ,OUTPUT(AR_BadRecords,,Corp2_Mapping._Dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::ar_'+uc_runtype+'_'+state_origin,__compressed__)
																										 )
																								 )
																						  ,output(AR_ScrubsWithExamples, all, named('CorpAR'+uc_runtype+'ILScrubsReportWithExamples'+filedate))
																							//Send Alerts if Scrubs exceeds thresholds
																							,IF(COUNT(AR_ScrubsAlert) > 0, AR_MailFile, OUTPUT('CORP2_MAPPING.IL "'+uc_runtype+'" - No "AR" Corp Scrubs Alerts'))
																							,AR_ErrorSummary
																							,AR_ScrubErrorReport
																							,AR_SomeErrorValues			
																							,AR_SubmitStats
																					);

	//********************************************************************
  // SCRUB EVENT
  //********************************************************************	
		Event_F := MapEvents;
		Event_S := Scrubs_Corp2_Mapping_IL_Event.Scrubs;						// Scrubs module
		Event_N := Event_S.FromNone(Event_F); 											// Generate the error flags
		Event_T := Event_S.FromBits(Event_N.BitmapInfile);     			// Use the FromBits module; makes my bitmap datafile easier to get to
		Event_U := Event_S.FromExpanded(Event_N.ExpandedInFile); 		// Pass the expanded error flags into the Expanded module
		
		//Outputs reports
		Event_ErrorSummary				:= output(Event_U.SummaryStats, named('Event_ErrorSummary_'+uc_runtype+'_IL'+filedate));
		Event_ScrubErrorReport 		:= output(choosen(Event_U.AllErrors, 1000), named('Event_ScrubErrorReport_'+uc_runtype+'_IL'+filedate));
		Event_SomeErrorValues			:= output(choosen(Event_U.BadValues, 1000), named('Event_SomeErrorValues_'+uc_runtype+'_IL'+filedate));
		Event_IsScrubErrors		 		:= IF(count(Event_U.AllErrors)<> 0,true,false);

		// Orbit Stats
		Event_OrbitStats					:= Event_U.OrbitStats();

		//Outputs files
		Event_CreateBitMaps				:= output(Event_N.BitmapInfile,,'~thor_data::corp_'+uc_runtype+'_IL_event_scrubs_bits',overwrite,compressed);	//long term storage
		Event_TranslateBitMap			:= output(Event_T);

		//Submits Profile's stats to Orbit
		Event_SubmitStats 			 := Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_IL_Event','ScrubsAlerts', Event_OrbitStats, version,'Corp_IL_Event',version+uc_runtype).SubmitStats;
		Event_ScrubsWithExamples := Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_IL_Event','ScrubsAlerts', Event_OrbitStats, version,'Corp_IL_Event',version+uc_runtype).CompareToProfile_with_Examples;

		Event_ScrubsAlert					:= Event_ScrubsWithExamples(RejectWarning = 'Y');
		Event_ScrubsAttachment		:= Scrubs.fn_email_attachment(Event_ScrubsAlert);

		Event_MailFile						:= FileServices.SendEmailAttachData(corp2.Email_Notification_Lists.AttachedList
																																 ,'Scrubs CorpEvent_'+uc_runtype+'_IL Report' //subject
																																 ,'Scrubs CorpEvent_'+uc_runtype+'_IL Report' //body
																																 ,(data)Event_ScrubsAttachment
																																 ,'text/csv'
																																 ,'Corp'+uc_runtype+'ILEventScrubsReport.csv'
																																);

		Event_BadRecords				 	:= Event_N.ExpandedInFile(	
																												corp_key_Invalid							  			<> 0 or
																												corp_vendor_Invalid							  		<> 0 or
																												corp_state_origin_Invalid							<> 0 or
																												corp_process_date_Invalid							<> 0 or
																												corp_sos_charter_nbr_Invalid					<> 0 or
																												event_filing_date_Invalid							<> 0 or
																												event_desc_Invalid										<> 0
																											 );
		
		Event_GoodRecords					:= Event_N.ExpandedInFile(	
																												corp_key_Invalid							  			= 0 and
																												corp_vendor_Invalid							  		= 0 and
																												corp_state_origin_Invalid							= 0 and
																												corp_process_date_Invalid							= 0 and
																												corp_sos_charter_nbr_Invalid					= 0 and
																												event_filing_date_Invalid							= 0 and
																												event_desc_Invalid										= 0
																											);

		Event_FailBuild					  := if(count(Event_GoodRecords) = 0,true,false);

		Event_ApprovedRecords			:= project(Event_GoodRecords,transform(Corp2_Mapping.LayoutsCommon.Events,self := left));
	
		Event_ALL									:= sequential(IF(count(Event_BadRecords) <> 0
																							,IF (poverwrite
																									,OUTPUT(Event_BadRecords,,Corp2_Mapping._Dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::event_'+uc_runtype+'_'+state_origin,overwrite,__compressed__)
																									,OUTPUT(Event_BadRecords,,Corp2_Mapping._Dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::event_'+uc_runtype+'_'+state_origin,__compressed__)
																									)
																							 )
																					 ,output(Event_ScrubsWithExamples, all, named('CorpEvent'+uc_runtype+'ILScrubsReportWithExamples'+filedate))
																					 //Send Alerts if Scrubs exceeds thresholds
																					 ,IF(COUNT(Event_ScrubsAlert) > 0, Event_MailFile, OUTPUT('CORP2_MAPPING.IL "'+uc_runtype+'" - No "EVENT" Corp Scrubs Alerts'))
																					 ,Event_ErrorSummary
																					 ,Event_ScrubErrorReport
																					 ,Event_SomeErrorValues		
																					 ,Event_SubmitStats
																					);

	//********************************************************************
  // SCRUB MAIN
  //********************************************************************	
		Main_F := MapMain;
		Main_S := Scrubs_Corp2_Mapping_IL_Main.Scrubs;					// Scrubs module
		Main_N := Main_S.FromNone(Main_F); 											// Generate the error flags
		Main_T := Main_S.FromBits(Main_N.BitmapInfile);     		// Use the FromBits module; makes my bitmap datafile easier to get to
		Main_U := Main_S.FromExpanded(Main_N.ExpandedInFile); 	// Pass the expanded error flags into the Expanded module
		
		//Outputs reports
		Main_ErrorSummary					:= output(Main_U.SummaryStats, named('Main_ErrorSummary_'+uc_runtype+'_IL'+filedate));
		Main_ScrubErrorReport 		:= output(choosen(Main_U.AllErrors, 1000), named('Main_ScrubErrorReport_'+uc_runtype+'_IL'+filedate));
		Main_SomeErrorValues			:= output(choosen(Main_U.BadValues, 1000), named('Main_SomeErrorValues_'+uc_runtype+'_IL'+filedate));
		Main_IsScrubErrors		 		:= IF(count(Main_U.AllErrors)<> 0,true,false);

		// Orbit Stats
		Main_OrbitStats						:= Main_U.OrbitStats();

		//Outputs files
		Main_CreateBitMaps				:= output(Main_N.BitmapInfile,,'~thor_data::corp_'+uc_runtype+'_IL_main_scrubs_bits',overwrite,compressed);	//long term storage
		Main_TranslateBitMap			:= output(Main_T);

		//Submits Profile's stats to Orbit
		Main_SubmitStats 			    := Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_IL_Main','ScrubsAlerts', Main_OrbitStats, version,'Corp_IL_Main',version+uc_runtype).SubmitStats;
		Main_ScrubsWithExamples   := Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_IL_Main','ScrubsAlerts', Main_OrbitStats, version,'Corp_IL_Main',version+uc_runtype).CompareToProfile_with_Examples;

		Main_ScrubsAlert					:= Main_ScrubsWithExamples(RejectWarning = 'Y');
		Main_ScrubsAttachment			:= Scrubs.fn_email_attachment(Main_ScrubsAlert);
		Main_MailFile							:= FileServices.SendEmailAttachData(corp2.Email_Notification_Lists.AttachedList
																																 ,'Scrubs CorpMain_'+uc_runtype+'_IL Report' //subject
																																 ,'Scrubs CorpMain_'+uc_runtype+'_IL Report' //body
																																 ,(data)Main_ScrubsAttachment
																																 ,'text/csv'
																																 ,'Corp'+uc_runtype+'ILMainScrubsReport.csv'
																																);
																																 
		Main_BadRecords						:= Main_N.ExpandedInFile(	 
																											 dt_vendor_first_reported_Invalid 			<> 0 or
																											 dt_vendor_last_reported_Invalid 				<> 0 or
																											 dt_first_seen_Invalid 									<> 0 or
																											 dt_last_seen_Invalid 									<> 0 or
																											 corp_ra_dt_first_seen_Invalid 					<> 0 or
																											 corp_ra_dt_last_seen_Invalid 					<> 0 or
																											 corp_key_Invalid 											<> 0 or
																											 corp_vendor_Invalid 										<> 0 or
																											 corp_state_origin_Invalid 							<> 0 or
																											 corp_process_date_Invalid 							<> 0 or
																											 corp_orig_sos_charter_nbr_Invalid 			<> 0 or
																											 corp_legal_name_Invalid 								<> 0 or
																											 corp_ln_name_type_cd_Invalid 					<> 0 or
																											 corp_ln_name_type_desc_Invalid 				<> 0 or
																											 corp_status_cd_Invalid									<> 0 or
																											 corp_status_date_Invalid								<> 0 or
																											 corp_inc_state_Invalid 								<> 0 or
																											 corp_inc_date_Invalid 									<> 0 or
																											 corp_term_exist_cd_Invalid							<> 0 or
																											 corp_term_exist_exp_Invalid						<> 0 or
																											 corp_term_exist_desc_Invalid						<> 0 or
																											 corp_foreign_domestic_ind_Invalid			<> 0 or
																											 corp_forgn_state_cd_Invalid 						<> 0 or
																											 corp_forgn_state_desc_Invalid 					<> 0 or
																											 corp_forgn_date_Invalid 								<> 0 or
																											 corp_orig_org_structure_desc_Invalid		<> 0 or																									 
																											 corp_for_profit_ind_Invalid						<> 0 or
																											 corp_orig_bus_type_desc_Invalid 				<> 0 or
																											 corp_ra_effective_date_Invalid 				<> 0 or
																											 corp_agent_county_Invalid 							<> 0 or
																											 corp_country_of_formation_Invalid 			<> 0 or
																											 corp_merger_date_Invalid 							<> 0 or
																											 recordorigin_Invalid 									<> 0 or
																											 internalfield1_Invalid					 				<> 0
																										);

		Main_GoodRecords					:= Main_N.ExpandedInFile(	
																										 	 dt_vendor_first_reported_Invalid 			= 0 and
																											 dt_vendor_last_reported_Invalid 				= 0 and
																											 dt_first_seen_Invalid 									= 0 and
																											 dt_last_seen_Invalid 									= 0 and
																											 corp_ra_dt_first_seen_Invalid 					= 0 and
																											 corp_ra_dt_last_seen_Invalid 					= 0 and
																											 corp_key_Invalid 											= 0 and
																											 corp_vendor_Invalid 										= 0 and
																											 corp_state_origin_Invalid 							= 0 and
																											 corp_process_date_Invalid 							= 0 and
																											 corp_orig_sos_charter_nbr_Invalid 			= 0 and
																											 corp_legal_name_Invalid 								= 0 and
																											 corp_ln_name_type_cd_Invalid 					= 0 and
																											 corp_ln_name_type_desc_Invalid 				= 0 and
																											 corp_status_cd_Invalid									= 0 and
																											 corp_status_date_Invalid								= 0 and
																											 corp_inc_state_Invalid 								= 0 and
																											 corp_inc_date_Invalid 									= 0 and
																											 corp_term_exist_cd_Invalid							= 0 and
																											 corp_term_exist_exp_Invalid						= 0 and
																											 corp_term_exist_desc_Invalid						= 0 and
																											 corp_foreign_domestic_ind_Invalid			= 0 and
																											 corp_forgn_state_cd_Invalid 						= 0 and
																											 corp_forgn_state_desc_Invalid 					= 0 and
																											 corp_forgn_date_Invalid 								= 0 and
																											 corp_orig_org_structure_desc_Invalid		= 0 and
																											 corp_for_profit_ind_Invalid						= 0 and
																											 corp_orig_bus_type_desc_Invalid 				= 0 and
																											 corp_ra_effective_date_Invalid 				= 0 and
																											 corp_agent_county_Invalid 							= 0 and
																											 corp_country_of_formation_Invalid 			= 0 and																											 
																											 corp_merger_date_Invalid 							= 0 and
																											 recordorigin_Invalid					 					= 0	and
																											 internalfield1_Invalid					 				= 0																											 
																								  );

		Main_FailBuild					:= map( corp2_mapping.fCalcPercent(count(Main_N.ExpandedInFile(corp_key_invalid<>0)),count(Main_N.ExpandedInFile),false) 										> Scrubs_Corp2_Mapping_IL_Main.Threshold_Percent.CORP_KEY										 => true,
																		corp2_mapping.fCalcPercent(count(Main_N.ExpandedInFile(corp_orig_sos_charter_nbr_invalid<>0)),count(Main_N.ExpandedInFile),false) 	> Scrubs_Corp2_Mapping_IL_Main.Threshold_Percent.CORP_ORIG_SOS_CHARTER_NBR 	 => true,
																		corp2_mapping.fCalcPercent(count(Main_N.ExpandedInFile(corp_legal_name_invalid<>0)),count(Main_N.ExpandedInFile),false) 						> Scrubs_Corp2_Mapping_IL_Main.Threshold_Percent.CORP_LEGAL_NAME 						 => true,
																		corp2_mapping.fCalcPercent(count(Main_N.ExpandedInFile(corp_inc_date_invalid<>0)),count(Main_N.ExpandedInFile),false) 							> Scrubs_Corp2_Mapping_IL_Main.Threshold_Percent.CORP_INC_DATE 						 	 => true,
																	  count(Main_GoodRecords) = 0																																																																																											 => true,																		
																		false
																	);

		Main_ApprovedRecords		:= project(Main_GoodRecords,transform(Corp2_Mapping.LayoutsCommon.Main,self := left));


		Main_ALL		 						:= sequential( IF(count(Main_BadRecords) <> 0
																							,IF (poverwrite
																									,OUTPUT(Main_BadRecords,,Corp2_Mapping._Dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::main_'+uc_runtype+'_'+state_origin,overwrite,__compressed__)
																									,OUTPUT(Main_BadRecords,,Corp2_Mapping._Dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::main_'+uc_runtype+'_'+state_origin,__compressed__)
																									)
																							)
																					,output(Main_ScrubsWithExamples, all, named('CorpMain'+uc_runtype+'ILScrubsReportWithExamples'+filedate))
																					//Send Alerts if Scrubs exceeds thresholds
																					,IF(COUNT(Main_ScrubsAlert) > 0, Main_MailFile, OUTPUT('CORP2_MAPPING.IL "'+uc_runtype+'" - No "MAIN" Corp Scrubs Alerts'))
																					,Main_ErrorSummary
																					,Main_ScrubErrorReport
																					,Main_SomeErrorValues		
																					,Main_SubmitStats
																			);
												
	//********************************************************************
  // SCRUB STOCK
  //********************************************************************	
		Stock_F := MapStock;
		Stock_S := Scrubs_Corp2_Mapping_IL_Stock.Scrubs;						// Scrubs module
		Stock_N := Stock_S.FromNone(Stock_F); 											// Generate the error flags
		Stock_T := Stock_S.FromBits(Stock_N.BitmapInfile);     			// Use the FromBits module; makes my bitmap datafile easier to get to
		Stock_U := Stock_S.FromExpanded(Stock_N.ExpandedInFile); 		// Pass the expanded error flags into the Expanded module

		//Outputs reports
		Stock_ErrorSummary			 	:= output(Stock_U.SummaryStats, named('Stock_ErrorSummary_'+uc_runtype+'_IL'+filedate));
		Stock_ScrubErrorReport 	 	:= output(choosen(Stock_U.AllErrors, 1000), named('Stock_ScrubErrorReport_'+uc_runtype+'_IL'+filedate));
		Stock_SomeErrorValues		 	:= output(choosen(Stock_U.BadValues, 1000), named('Stock_SomeErrorValues_'+uc_runtype+'_IL'+filedate));
		Stock_IsScrubErrors		 	 	:= IF(count(Stock_U.AllErrors)<> 0,true,false);

		// Orbit Stats
		Stock_OrbitStats				 	:= Stock_U.OrbitStats();

		//Outputs files
		Stock_CreateBitMaps				:= output(Stock_N.BitmapInfile,,'~thor_data::corp_'+uc_runtype+'_il_scrubs_bits',overwrite,compressed);	//long term storage
		Stock_TranslateBitMap			:= output(Stock_T);

		//Submits Profile's stats to Orbit
		Stock_SubmitStats 			  := Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_IL_Stock','ScrubsAlerts', Stock_OrbitStats, version,'Corp_IL_Stock',version+uc_runtype).SubmitStats;
		Stock_ScrubsWithExamples  := Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_IL_Stock','ScrubsAlerts', Stock_OrbitStats, version,'Corp_IL_Stock',version+uc_runtype).CompareToProfile_with_Examples;

		Stock_ScrubsAlert					:= Stock_ScrubsWithExamples(RejectWarning = 'Y');
		Stock_ScrubsAttachment		:= Scrubs.fn_email_attachment(Stock_ScrubsAlert);
		Stock_MailFile						:= FileServices.SendEmailAttachData(corp2.Email_Notification_Lists.AttachedList
																																 ,'Scrubs CorpStock_'+uc_runtype+'_IL Report' //subject
																																 ,'Scrubs CorpStock_'+uc_runtype+'_IL Report' //body
																																 ,(data)Stock_ScrubsAttachment
																																 ,'text/csv'
																																 ,'Corp'+uc_runtype+'ILStockScrubsReport.csv'
																																);
																																 
		Stock_BadRecords					:= Stock_N.ExpandedInFile(	
																												corp_key_Invalid							  			<> 0 or
																												corp_vendor_Invalid 									<> 0 or
																												corp_state_origin_Invalid 					 	<> 0 or
																												corp_process_date_Invalid						  <> 0 or
																												corp_sos_charter_nbr_Invalid					<> 0 or
																												stock_class_Invalid	 									<> 0 or
																												stock_shares_issued_Invalid	 					<> 0 or
																												stock_authorized_nbr_Invalid	 				<> 0 or
																												stock_par_value_Invalid	 							<> 0 or
																												stock_change_ind_Invalid	 						<> 0 or
																												stock_change_date_Invalid	 						<> 0 or
																												stock_change_in_cap_Invalid	 					<> 0 or
																												stock_tax_capital_Invalid	 						<> 0 or
																												stock_total_capital_Invalid	 					<> 0 																												
																											 );

		Stock_GoodRecords					:= Stock_N.ExpandedInFile(	
																												corp_key_Invalid							  			= 0 and
																												corp_vendor_Invalid 									= 0 and
																												corp_state_origin_Invalid 					 	= 0 and
																												corp_process_date_Invalid						  = 0 and
																												corp_sos_charter_nbr_Invalid					= 0 and
																												stock_class_Invalid	 									= 0 and
																												stock_shares_issued_Invalid	 					= 0 and
																												stock_authorized_nbr_Invalid	 				= 0 and
																												stock_par_value_Invalid	 							= 0 and
																												stock_change_ind_Invalid	 						= 0 and
																												stock_change_date_Invalid	 						= 0 and
																												stock_change_in_cap_Invalid	 					= 0 and
																												stock_tax_capital_Invalid	 						= 0 and
																												stock_total_capital_Invalid	 					= 0
																											 );
																														
		Stock_FailBuild						:= if(count(Stock_GoodRecords) = 0,true,false);

		Stock_ApprovedRecords			:= project(Stock_GoodRecords,transform(Corp2_Mapping.LayoutsCommon.Stock,self := left));

		Stock_ALL									:= sequential( IF(count(Stock_BadRecords) <> 0
																							,IF (poverwrite
																									,OUTPUT(Stock_BadRecords,,Corp2_Mapping._Dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::stock_'+uc_runtype+'_'+state_origin,overwrite,__compressed__)
																									,OUTPUT(Stock_BadRecords,,Corp2_Mapping._Dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::stock_'+uc_runtype+'_'+state_origin,__compressed__)
																									)
																							)
																					,output(Stock_ScrubsWithExamples, all, named('CorpStock'+uc_runtype+'ILScrubsReportWithExamples'+filedate))
																					//Send Alerts if Scrubs exceeds thresholds
																					,IF(COUNT(Stock_ScrubsAlert) > 0, Stock_MailFile, OUTPUT('CORP2_MAPPING.IL "'+uc_runtype+'" - No "Stock" Corp Scrubs Alerts'))
																					,Stock_ErrorSummary
																					,Stock_ScrubErrorReport
																					,Stock_SomeErrorValues	
																					,Stock_SubmitStats
																					);
																					
		//********************************************************************
		// UPDATE
		//********************************************************************

		Fail_Build						:= IF(AR_FailBuild = true or Event_FailBuild = true or Main_FailBuild = true or Stock_FailBuild = true,true,false);
		IsScrubErrors					:= IF(AR_IsScrubErrors = true or Event_IsScrubErrors = true or Main_IsScrubErrors = true or Stock_IsScrubErrors = true,true,false);

		VersionControl.macBuildNewLogicalFile(Corp2_Mapping._dataset().thor_cluster_Files + 'in::corp2::' 	+ version + '::ar_' 	 + uc_runtype + '_' + state_origin, AR_ApprovedRecords	 , write_ar,,,pOverwrite);
		VersionControl.macBuildNewLogicalFile(Corp2_Mapping._dataset().thor_cluster_Files + 'in::corp2::' 	+ version + '::event_' + uc_runtype + '_' + state_origin, Event_ApprovedRecords, write_event,,,pOverwrite);
		VersionControl.macBuildNewLogicalFile(Corp2_Mapping._dataset().thor_cluster_Files + 'in::corp2::' 	+ version + '::main_'  + uc_runtype + '_' + state_origin, Main_ApprovedRecords , write_main,,,pOverwrite);
		VersionControl.macBuildNewLogicalFile(Corp2_Mapping._dataset().thor_cluster_Files + 'in::corp2::' 	+ version + '::stock_' + uc_runtype + '_' + state_origin, Stock_ApprovedRecords, write_stock,,,pOverwrite);

		VersionControl.macBuildNewLogicalFile(Corp2_Mapping._dataset().thor_cluster_Files + 'fail::corp2::' + version + '::ar_' 	 + uc_runtype + '_' + state_origin, AR_F		, write_fail_ar,,,pOverwrite);
		VersionControl.macBuildNewLogicalFile(Corp2_Mapping._dataset().thor_cluster_Files + 'fail::corp2::' + version + '::event_' + uc_runtype + '_' + state_origin, Event_F	, write_fail_event,,,pOverwrite);
		VersionControl.macBuildNewLogicalFile(Corp2_Mapping._dataset().thor_cluster_Files + 'fail::corp2::' + version + '::main_'  + uc_runtype + '_' + state_origin, Main_F	, write_fail_main,,,pOverwrite);
		VersionControl.macBuildNewLogicalFile(Corp2_Mapping._dataset().thor_cluster_Files + 'fail::corp2::' + version + '::stock_' + uc_runtype + '_' + state_origin, Stock_F	, write_fail_stock,,,pOverwrite);
	//mapIL:= sequential ( if(pshouldspray = true,Corp2_mapping.fSprayFiles(state_origin+'_'+uc_runtype,version,pOverwrite := pOverwrite))

		mapIL:= sequential ( if(pshouldspray = true,Corp2_mapping.fSprayFiles(state_origin,version,pOverwrite:=pOverwrite,pSuffix:=uc_runtype))
												//,if(uc_runtype = 'DAILY',Corp2_Raw_IL.Build_Bases_Daily(filedate,version,puseprod).All,Corp2_Raw_IL.Build_Bases_Monthly(filedate,version,puseprod).All)  //Determined that Build Bases is not needed
												,AR_All
												,Event_All
												,Main_All
												,Stock_All
												,if(Fail_Build <> true	 
													 ,sequential (write_ar
																			 ,write_event
																			 ,write_main
																			 ,write_stock	
																		   ,fileservices.addsuperfile(Corp2_Mapping._Dataset().thor_cluster_Files + 'in::'+Corp2_Mapping._Dataset().NameMapped +'::sprayed::ar'			,Corp2_Mapping._Dataset().thor_cluster_Files + 'in::corp2::'+version+'::ar_'		+ uc_runtype + '_' + state_origin)
																		   ,fileservices.addsuperfile(Corp2_Mapping._Dataset().thor_cluster_Files + 'in::'+Corp2_Mapping._Dataset().NameMapped +'::sprayed::event'	,Corp2_Mapping._Dataset().thor_cluster_Files + 'in::corp2::'+version+'::event_'	+ uc_runtype + '_' + state_origin)
																		   ,fileservices.addsuperfile(Corp2_Mapping._Dataset().thor_cluster_Files + 'in::'+Corp2_Mapping._Dataset().NameMapped +'::sprayed::main'		,Corp2_Mapping._Dataset().thor_cluster_Files + 'in::corp2::'+version+'::main_'	+ uc_runtype + '_' + state_origin)																		 
																		   ,fileservices.addsuperfile(Corp2_Mapping._Dataset().thor_cluster_Files + 'in::'+Corp2_Mapping._Dataset().NameMapped +'::sprayed::stock'	,Corp2_Mapping._Dataset().thor_cluster_Files + 'in::corp2::'+version+'::stock_'	+ uc_runtype + '_' + state_origin)
																		   ,if (count(Main_BadRecords) <> 0 or count(AR_BadRecords) <> 0 or count(Event_BadRecords) <> 0 or count(Stock_BadRecords)<>0
																					 ,Corp2_Mapping.Send_Email(state_origin,version,count(Main_BadRecords)<>0,count(AR_BadRecords)<>0,count(Event_BadRecords)<>0,count(Stock_BadRecords)<>0,count(Main_BadRecords),count(AR_BadRecords),count(Event_BadRecords),count(Stock_BadRecords),count(Main_ApprovedRecords),count(AR_ApprovedRecords),count(Event_ApprovedRecords),count(Stock_ApprovedRecords),,,uc_runtype).RecordsRejected																				 
																					 ,Corp2_Mapping.Send_Email(state_origin,version,count(Main_BadRecords)<>0,count(AR_BadRecords)<>0,count(Event_BadRecords)<>0,count(Stock_BadRecords)<>0,count(Main_BadRecords),count(AR_BadRecords),count(Event_BadRecords),count(Stock_BadRecords),count(Main_ApprovedRecords),count(AR_ApprovedRecords),count(Event_ApprovedRecords),count(Stock_ApprovedRecords),,,uc_runtype).MappingSuccess
																					 )
																			 ,if (IsScrubErrors
																					 ,Corp2_Mapping.Send_Email(state_origin,version,Main_IsScrubErrors,AR_IsScrubErrors,Event_IsScrubErrors,Stock_IsScrubErrors,,,,,,,,,,,uc_runtype).FieldsInvalidPerScrubs
																					 )
																			 ) //if Fail_Build <> true																			
													 ,sequential (write_fail_ar
																			 ,write_fail_event
																			 ,write_fail_main
																			 ,write_fail_stock												 
																			 ,Corp2_Mapping.Send_Email(state_origin,version,,,,,,,,,,,,,,,uc_runtype).MappingFailed
																			 ) //if Fail_Build = true
												   )
										);
			
		isFileDateValid := if((string)std.date.today() between ut.date_math(filedate,-30) and ut.date_math(filedate,30),true,false);
		return sequential (	 if (isFileDateValid and uc_runtype in ['DAILY','MONTHLY']
														,mapIL
														,sequential (if(isFileDateValid<>true
																						,Corp2_Mapping.Send_Email(state_origin,filedate,,,,,,,,,,,,,,,uc_runtype).InvalidFileDateParm
																						,Corp2_Mapping.Send_Email(state_origin,filedate,,,,,,,,,,,,,uc_runtype,'DAILY,MONTHLY',uc_runtype).InvalidFileRunType
																				)
																				,FAIL('Corp2_Mapping.'+state_origin+' '+uc_runtype+' failed.  An invalid filedate or runtype was passed in as a parameter.  The runtype must be "DAILY" or "MONTHLY".')
																				)
														)
											);
	
	end;	// end of Update function

end; //end IL