import corp2, corp2_mapping, corp2_raw_ks, scrubs, scrubs_corp2_mapping_ks_ar,
			 scrubs_corp2_mapping_ks_main, scrubs_corp2_mapping_ks_stock, std, tools,
			 ut, versioncontrol;

export KS := module 

	export Update(string filedate, string version, boolean pShouldSpray = _Dataset().bShouldSpray, boolean pOverwrite = false, pUseProd = Tools._Constants.IsDataland) := Function

		state_origin		:= 'KS';
		state_fips	 		:= '20';	
		state_desc	 		:= 'KANSAS';
		
		//Input File definitions
		CPABREPRANo 		:= dedup(sort(distribute(Corp2_Raw_KS.Files(filedate,puseprod).Input.CPABREP.Logical, hash(ranum)), record, local), record, local) : independent;					//The primary corporation file
		CPABREPCorpNo		:= dedup(sort(distribute(Corp2_Raw_KS.Files(filedate,puseprod).Input.CPABREP.Logical, hash(corp_number)), record, local), record, local) : independent; 	//The primary corporation file
		CPADREP 				:= dedup(sort(distribute(Corp2_Raw_KS.Files(filedate,puseprod).Input.CPADREP.Logical, hash(ranum)), record, local), record, local) : independent;					//The resident agent (RA) file
		CPAEREP 				:= dedup(sort(distribute(Corp2_Raw_KS.Files(filedate,puseprod).Input.CPAEREP.Logical, hash(cnnumber)), record, local), record, local) : independent;			//The compressed name file
		CPAHST 					:= dedup(sort(distribute(Corp2_Raw_KS.Files(filedate,puseprod).Input.CPAHST.Logical, hash(corp_number)), record, local), record, local) : independent;		//The history file
		CPAQREP					:= dedup(sort(distribute(Corp2_Raw_KS.Files(filedate,puseprod).Input.CPAQREP.Logical, hash(corp_num)), record, local), record, local) : independent;			//The corporation name extension file (if corp name exceeds limit)
		CPBCREP					:= dedup(sort(distribute(Corp2_Raw_KS.Files(filedate,puseprod).Input.CPBCREP.Logical, hash(pnnumber)), record, local), record, local) : independent;			//The previous corporation names file	

		//Input Table definitions
		TableCPAKREP		:= dedup(sort(distribute(Corp2_Raw_KS.Files(filedate,puseprod).Input.CPAKREP, hash(corp_stat_code)), record, local), record, local) : independent;				//The corporation status file
 		TableCPANREP 		:= dedup(sort(distribute(Corp2_Raw_KS.Files(filedate,puseprod).Input.CPANREP, hash(code)), record, local), record, local) : independent;										//The state-country reference file
		TableCPASREP 		:= dedup(sort(distribute(Corp2_Raw_KS.Files(filedate,puseprod).Input.CPASREP, hash(county_code)),record, local), record, local) : independent;						//The county-city reference file
		TableCRPTYP  		:= dedup(sort(distribute(Corp2_Raw_KS.Files(filedate,puseprod).Input.CRPTYP, hash(corporation_type)),record, local), record, local) : independent;				//The corporation type file
		TableCPALREP 		:= dedup(sort(distribute(Corp2_Raw_KS.Files(filedate,puseprod).Input.CPALREP, hash(a_r_status)), record, local), record, local) : independent;						//Annual report status file

		//********************************************************************
		//UniqueCounty's purpose is to get a unique county and its' description
		//that will be mapped later to corp_agent_county.
		//********************************************************************
		UniqueCounty								:= dedup(sort(distribute(TableCPASREP,hash(county_code)),county_code,local),county_code,local) : independent;
																			 
		GetRACounty 								:= join (CPADREP,UniqueCounty
																				,corp2.t2u(left.racounty) = corp2.t2u(right.county_code)
																				,transform(Corp2_Raw_KS.Layouts.Temp_CPADREP_CPASREP,
																									 self := left;
																									 self := right;
																									)
																				,left outer
																				,lookup
																			 );
																			 
		//********************************************************************
		//Join the Corporation file with the RA file
		//********************************************************************
		CorpRA 											:= join (CPABREPRANo,GetRACounty
																			  ,corp2.t2u(left.ranum) = corp2.t2u(right.ranum)
																			  ,transform(Corp2_Raw_KS.Layouts.Temp_CPABREP_CPADREP,
																									 self := right;
																									 self := left;
																									 self := [];																									 
																								  )
																			  ,left outer
																			  ,local
																			 );
																			 
		//********************************************************************
		//Join the Corporation/RA file with the CPAHST file to get the 
		//agriculture_code.
		//********************************************************************
		CPAHST_with_agricode 				:= dedup(sort(CPAHST(corp2.t2u(agriculture_code)<>''),corp_number,agriculture_code),corp_number,agriculture_code);
		
		CorpRAHst 									:= join(CorpRA, CPAHST_with_agricode
																			 ,corp2.t2u(left.corp_number) = corp2.t2u(right.corp_number)
																			 ,transform(Corp2_Raw_KS.Layouts.Temp_CPABREP_CPADREP,
																									self.agriculture_code		:= corp2.t2u(right.agriculture_code);
																									self										:= left;
																								 )
																			 ,left outer
																			 ,local
																			 );

		//********************************************************************
		//CPAQREP contains the continuation of the corporation name
		//(that exists in the CPABREP file) if it is longer than 70 characters.  
		//********************************************************************
		cpaqrep_ext 						  := project(CPAQREP,transform(Corp2_Raw_KS.Layouts.Temp_CPAQREP,self := left;self := [];));		
		cpaqrep_ext_srt 					:= sort(cpaqrep_ext, corp_num, corp_seqnum);
	
		Corp2_Raw_KS.Layouts.Temp_CPAQREP  denormCPAQREP(Corp2_Raw_KS.Layouts.Temp_CPAQREP l, Corp2_Raw_KS.Layouts.Temp_CPAQREP r, integer c) := transform,
		skip(corp2.t2u(r.corp_name_cont) = '')
			self.corp_name_cont_2 	:= if(c = 2, r.corp_name_cont, '');
	    self.corp_name_cont_3 	:= if(c = 3, r.corp_name_cont, '');			
			self 										:= l;
		end;
	
		//********************************************************************
		//Denormalize the CPAQREP records to get the all the corp_name parts 
		//in one record.
		//********************************************************************	
		denorm_cpaqrep 						:= denormalize(cpaqrep_ext_srt, cpaqrep_ext_srt
																						,corp2.t2u(left.corp_num) = corp2.t2u(right.corp_num)
																						,denormCPAQREP(left, right, counter)
																						);
								
		dedup_denorm_cpaqrep 			:= dedup(sort(distribute(denorm_cpaqrep,hash(corp_num)),corp_num,corp_seqnum,local), corp_num,local);

		//********************************************************************
		//Add the remaining corporation name parts to the temporary layout.
		//********************************************************************	
		CorpRAHstName			:= join (CorpRAHst, dedup_denorm_cpaqrep
																  ,corp2.t2u(left.corp_number) = corp2.t2u(right.corp_num)
																  ,transform(Corp2_Raw_KS.Layouts.Temp_CPABREP_CPADREP,
																						 self.corp_name_cont    := right.corp_name_cont;
																						 self.corp_name_cont_2  := right.corp_name_cont_2;
																						 self.corp_name_cont_3  := right.corp_name_cont_3;
																						 self                   := left;
																						 self                   := [];
																					  )
																 ,left outer
																 ,local
																);
		
		//********************************************************************
		//This begins the translation of all the lookup tables.
		//********************************************************************

		//********************************************************************
		//Get the country code.
		//Note: state:				 represents the business address
		//			state_country: represents the state and country of formation
		//			country: 			 represents the current location of the company
		//********************************************************************
		//********************************************************************
		// Join to get the translation for corp status description and the 
		// country of formation that is mapped to corp_country_code.
		//********************************************************************		
		JoinCountryCode 	:= join(CorpRAHstName, TableCPAKREP 
															 ,corp2.t2u(left.corp_stat) = corp2.t2u(right.corp_stat_code)
															 ,transform(Corp2_Raw_KS.Layouts.Temp_CPABREP_CPADREP,
																					self.corp_country_code := if(Corp2_Mapping.fCleanAddress(state_origin,state_desc,,,,left.state_country,,).country = 'US'
																																				,'USA'
																																				,Corp2_Mapping.fCleanAddress(state_origin,state_desc,,,,left.state_country,,).country
																																			 );
																					self.corp_status_desc  := corp2.t2u(right.long_desc);
																					self                   := left;
															 )
															 ,left outer
															 ,lookup
															);	
		
		//********************************************************************
		// Join to get the translation for Corporation_type code
		// Note:  TableCRPTYP is no longer being used since the corp_typ_desc
		//				field doesn't reflect the vendor's website.
		//********************************************************************			

		//********************************************************************
		// Join to get the translation for Country code
		// Note:  Some of the "countries" are states.  Translating US states
		//				to US.
		//********************************************************************		
		JoinCountryDesc	:= join(JoinCountryCode, TableCPANREP
															 ,corp2.t2u(left.state_country) = corp2.t2u(right.Code)
															 ,transform(Corp2_Raw_KS.Layouts.Temp_CPABREP_CPADREP,
																					self.corp_country_desc := map(Corp2_Raw_KS.Functions.State_Codes(corp2.t2u(right.name))<>''  => right.name,
																																				corp2.t2u(right.name) = 'UNITED STATES OF AMERICA' 						 => 'US',                                    
																																				corp2.t2u(right.name)
																																				);
																					self                   := left;
																				 )
															 ,left outer
															 ,lookup
															 );

		//********************************************************************
		// Join to get the ar status
		//********************************************************************	
		JoinARStatus 	 := join(JoinCountryDesc, TableCPALREP
															,corp2.t2u(left.a_r_status) = corp2.t2u(right.a_r_status)
															,transform(Corp2_Raw_KS.Layouts.Temp_CPABREP_CPADREP,
																				 self.ar_status					 := corp2.t2u(right.long_arsc_desc);
																				 self                    := left;
																				)
															,left outer
															,lookup
														 );
											 
		JoinARStatusDist	:= sort(distribute(JoinARStatus,hash(corp_number)),record,local);

		//********************************************************************
		//Those records that do have a previous corporation name are mapped
		//here.
		//********************************************************************		
		CPBCREP_CPAEREP_join			:= join (CPBCREP, CPAEREP
																			,corp2.t2u(left.pnnumber) 		= corp2.t2u(right.cnnumber) 		 and
																			 corp2.t2u(left.pnseqnum) 		= corp2.t2u(right.cn_seq_number) and																			
																			 corp2.t2u(right.cn_cur_pre)	= 'V'
																			,transform(Corp2_Raw_KS.Layouts.Temp_CPABREP_CPADREP,
																								 self.corp_number				 := if(corp2.t2u(right.cnnumber)<>'',right.cnnumber,left.pnnumber);																								 																			
																								 self.cn_cur_pre			   := right.cn_cur_pre;
																								 self.cn_file_date			 := right.cn_file_date;
																								 self                    := left;
																								 self                    := [];
																								)
																			,left outer
																			,local
																		 );

		CPBCREP_CPAEREP						:= sort(distribute(CPBCREP_CPAEREP_join,hash(corp_number)),record, local);

		FullFile									:= join (JoinARStatusDist, CPBCREP_CPAEREP
																			,corp2.t2u(left.corp_number) = corp2.t2u(right.corp_number)
																			,transform(Corp2_Raw_KS.Layouts.Temp_CPABREP_CPADREP,
																								 self.pncorpname				 := right.pncorpname;
																								 self.pname1						 := right.pname1;
																								 self.pname2				 		 := right.pname2;																								 
																								 self.cn_cur_pre			   := right.cn_cur_pre;
																								 self.cn_file_date			 := right.cn_file_date;
																								 self                    := left;
																								)
																			,left outer
																			,local
																		 ) : independent;

		//******************************* MAIN  ******************************
		
		//********************************************************************
		//This begins the MAIN mapping.  Two transforms are used to map corp
		//data. Those records that do not have a previous corporation name
		//are mapped here.
		//********************************************************************		
		Corp2_Mapping.LayoutsCommon.Main  MainTransform(Corp2_Raw_KS.Layouts.Temp_CPABREP_CPADREP l) := transform
			self.dt_vendor_first_reported							:= (unsigned4)filedate;
			self.dt_vendor_last_reported							:= (unsigned4)filedate;
			self.dt_first_seen												:= (unsigned4)filedate;
			self.dt_last_seen													:= (unsigned4)filedate;
			self.corp_ra_dt_first_seen								:= (unsigned4)filedate;
			self.corp_ra_dt_last_seen									:= (unsigned4)filedate;
			self.corp_key															:= state_fips + '-' + corp2.t2u(l.corp_number);
			self.corp_vendor													:= state_fips;
			self.corp_state_origin										:= state_origin;
			self.corp_process_date										:= filedate;
			self.corp_orig_sos_charter_nbr						:= corp2.t2u(l.corp_number);
			self.corp_legal_name											:= Corp2_mapping.fCleanBusinessName(state_origin,state_desc,regexreplace('[ ]{2,}',l.corp_name+l.corp_name_cont+l.corp_name_cont_2+l.corp_name_cont_3,'')).BusinessName;
			self.corp_ln_name_type_cd           			:= map(corp2.t2u(l.corp_stat) = 'NN' => '07',
																											 corp2.t2u(l.corp_stat) = 'BR' => '09',
																										  '01'
																											);
			self.corp_ln_name_type_desc         			:= map(corp2.t2u(l.corp_stat) = 'NN' => 'RESERVATION',
																										   corp2.t2u(l.corp_stat) = 'BR' => 'REGISTRATION',
																									    'LEGAL'
																											);				
			self.corp_address1_type_cd          			:= if(Corp2_Mapping.fAddressExists(state_origin,state_desc,l.attn_line+l.address_1,l.address_2,l.city,l.state,l.zip).ifaddressexists,'B','');
			self.corp_address1_type_desc        			:= if(Corp2_Mapping.fAddressExists(state_origin,state_desc,l.attn_line+l.address_1,l.address_2,l.city,l.state,l.zip).ifaddressexists,'BUSINESS','');
			self.corp_address1_line1            			:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.attn_line+l.address_1,l.address_2,l.city,l.state,l.zip).addressline1;
			self.corp_address1_line2            			:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.attn_line+l.address_1,l.address_2,l.city,l.state,l.zip).addressline2;
			self.corp_address1_line3            			:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.attn_line+l.address_1,l.address_2,l.city,l.state,l.zip,l.country).addressline3;
			self.corp_prep_addr1_line1      					:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.attn_line + l.address_1 ,l.address_2,l.city,l.state,l.zip).prepaddrline1;
			self.corp_prep_addr1_last_line 						:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.attn_line + l.address_1 ,l.address_2,l.city,l.state,l.zip).prepaddrlastline;
			self.corp_status_cd												:= corp2.t2u(l.corp_stat);
			self.corp_status_desc											:= corp2.t2u(l.corp_status_desc);
			self.corp_status_date											:= Corp2_Mapping.fValidateDate(l.forfeiture_date,'CCYYMMDD').PastDate;
      self.corp_inc_state                 			:= state_origin;
			self.corp_inc_date				    		  			:= if(corp2.t2u(l.state_country) in [state_origin,''],Corp2_Mapping.fValidateDate(l.date_of_incorp,'CCYYMMDD').PastDate,'');
			self.corp_fed_tax_id                			:= Corp2_Raw_KS.Functions.CorpFedTaxID(l.fein);
			self.corp_term_exist_cd             			:= map(corp2.t2u(l.expiration_date)[1..4] = '9999'													 => 'P',
																											 Corp2_Mapping.fValidateDate(l.expiration_date,'CCYYMMDD').GeneralDate <> '' => 'D',
																											 ''
																										  );
			self.corp_term_exist_exp            			:= Corp2_Mapping.fValidateDate(l.expiration_date,'CCYYMMDD').GeneralDate;
			self.corp_term_exist_desc           			:= map(self.corp_term_exist_cd = 'D' => 'EXPIRATION DATE',
																											 self.corp_term_exist_cd = 'P' => 'PERPETUAL',
																											 ''
																										  );																										
			self.corp_foreign_domestic_ind						:= Corp2_Raw_KS.Functions.ForeignDomesticInd(l.corporation_type);
			//State Code and Descriptions exist in TableCPANREP
			self.corp_forgn_state_cd           			 	:= map(corp2.t2u(l.state_country) in [state_origin,'XXX','XX','US','USA',''] 								=> '',
																											 corp2.t2u(l.state_country)
																										  );		
			self.corp_forgn_state_desc          			:= map(corp2.t2u(l.state_country) in [state_origin,'XXX','XX','US','USA',''] 								=> '',
																											 corp2.t2u(l.state_country) not in [''] and corp2.t2u(l.corp_country_desc) = '' => Corp2_Raw_KS.Functions.Country_Code_Translation(l.state_country),
																											 corp2.t2u(l.corp_country_desc) not in ['']																			 			=> corp2.t2u(l.corp_country_desc),
																											 '**'
																										  );
			self.corp_forgn_date                			:= if(corp2.t2u(l.state_country) not in [state_origin,''],Corp2_Mapping.fValidateDate(l.date_of_incorp,'CCYYMMDD').PastDate,'');
			self.corp_orig_org_structure_cd     			:= Corp2_Raw_KS.Functions.CorpOrigOrgStructureCD(l.corporation_type); //scrubbed
			self.corp_orig_org_structure_desc   			:= Corp2_Raw_KS.Functions.CorpOrigOrgStructureDesc(l.corporation_type);
			self.corp_for_profit_ind									:= map(corp2.t2u(l.corporation_type) in ['DF','FF'] => 'Y', //for profit
																											 corp2.t2u(l.corporation_type) in ['FN','NP'] => 'N', //not for profit
																											 ''
																										  );
			self.corp_orig_bus_type_cd          			:= if(corp2.t2u(l.close_corp) = 'Y', 'Y','');
			self.corp_orig_bus_type_desc        			:= if(corp2.t2u(l.close_corp) = 'Y', 'CLOSE CORPORATION','');
			self.corp_ra_full_name            				:= Corp2_mapping.fCleanBusinessName(state_origin,state_desc,Corp2_Raw_KS.Functions.CorpRAFullName(l.raname)).BusinessName;
			self.corp_ra_address_type_cd		     			:= if(Corp2_Mapping.fAddressExists(state_origin,state_desc,l.raaddr1,l.raaddr2,l.racity,l.rastate,l.razip5).ifaddressexists,'R','');
			self.corp_ra_address_type_desc      			:= if(Corp2_Mapping.fAddressExists(state_origin,state_desc,l.raaddr1,l.raaddr2,l.racity,l.rastate,l.razip5).ifaddressexists,'REGISTERED OFFICE','');
			self.corp_ra_address_line1         				:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.raaddr1,l.raaddr2,l.racity,l.rastate,l.razip5+l.razip4).addressline1;
			self.corp_ra_address_line2          			:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.raaddr1,l.raaddr2,l.racity,l.rastate,l.razip5+l.razip4).addressline2;
			self.corp_ra_address_line3          			:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.raaddr1,l.raaddr2,l.racity,l.rastate,l.razip5+l.razip4).addressline3;	
			self.ra_prep_addr_line1         					:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.raaddr1,l.raaddr2,l.racity,l.rastate,l.razip5).prepaddrline1;
			self.ra_prep_addr_last_line     					:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.raaddr1,l.raaddr2,l.racity,l.rastate,l.razip5).prepaddrlastline;
			self.corp_action_tax_dept_approval_date		:= Corp2_Mapping.fValidateDate(l.extension_date,'CCYYMMDD').GeneralDate;
			self.corp_agent_county										:= if(corp2.t2u(l.county_name)<>'',corp2.t2u(l.county_name),corp2.t2u(l.racounty));
			self.corp_agent_status_cd									:= corp2.t2u(l.rastatus);
			self.corp_agent_id												:= corp2.t2u(l.ranum);
			self.corp_agriculture_flag								:= corp2.t2u(l.agriculture_code);
			self.corp_country_of_formation						:= if(Corp2_Mapping.fCleanCountry(state_origin,state_desc,'',l.state_country).Country <> '',
																											Corp2_Mapping.fCleanCountry(state_origin,state_desc,'',l.state_country).Country,
																											Corp2_Mapping.fCleanCountry(state_origin,state_desc,'',l.corp_country_desc).Country
																											);
			self.corp_fiscal_year_month								:= corp2.t2u(l.tax_closing);
		  self.corp_name_status_cd									:= if(corp2.t2u(l.corp_stat) in ['EN','NN'],corp2.t2u(l.corp_stat),'');
			self.corp_name_status_desc								:= if(corp2.t2u(l.corp_stat) in ['EN','NN'],corp2.t2u(l.corp_status_desc),'');
			self.recordorigin													:= 'C';
			self 																			:= l;
			self 																			:= [];
		end;

		MapCorp	:= project(FullFile, MainTransform(left));

		corp2_mapping.layoutscommon.main  PriorTransform(Corp2_Raw_KS.Layouts.Temp_CPABREP_CPADREP l) := transform
			self.dt_vendor_first_reported							:= (unsigned4)filedate;
			self.dt_vendor_last_reported							:= (unsigned4)filedate;
			self.dt_first_seen												:= (unsigned4)filedate;
			self.dt_last_seen													:= (unsigned4)filedate;
			self.corp_ra_dt_first_seen								:= (unsigned4)filedate;
			self.corp_ra_dt_last_seen									:= (unsigned4)filedate;
			self.corp_key															:= state_fips + '-' + corp2.t2u(l.corp_number);
			self.corp_vendor													:= state_fips;
			self.corp_state_origin										:= state_origin;
			self.corp_process_date										:= filedate;
			self.corp_orig_sos_charter_nbr						:= corp2.t2u(l.corp_number);
			self.corp_legal_name											:= Corp2_mapping.fCleanBusinessName(state_origin,state_desc,l.pncorpname+l.pname1+l.pname2).BusinessName;
			self.corp_ln_name_type_cd           			:= 'P';
			self.corp_ln_name_type_desc         			:= 'PRIOR';
      self.corp_inc_state                 			:= state_origin;
			self.corp_filing_date			    		  			:= Corp2_Mapping.fValidateDate(l.cn_file_date,'CCYYMMDD').PastDate;
			self.corp_filing_desc											:= if(self.corp_filing_date<>'','DATE NAME CHANGED','');
			self.corp_inc_date				    		  			:= if(corp2.t2u(l.state_country) in [state_origin,''],Corp2_Mapping.fValidateDate(l.date_of_incorp,'CCYYMMDD').PastDate,'');
			self.corp_forgn_date                			:= if(corp2.t2u(l.state_country) not in [state_origin,''],Corp2_Mapping.fValidateDate(l.date_of_incorp,'CCYYMMDD').PastDate,'');
			self.recordorigin													:= 'C';
			self 																			:= l;
			self 																			:= [];
		end;

		MapPriorCorpNames						:= project(FullFile(corp2.t2u(pncorpname+pname1+pname2)<>''), PriorTransform(left));
		mapMain											:= dedup(sort(distribute(MapCorp + MapPriorCorpNames,hash(corp_key)),record,local),record,local) : independent;

		//**************************** ANNUAL REPORT *************************
		
		//********************************************************************
		//Join the "full file" with the history file.  
		//********************************************************************
		full_dist		:= distribute(FullFile,hash(corp_number));
		CorpHst			:= join (full_dist, CPAHST
														,corp2.t2u(left.corp_number) = corp2.t2u(right.corp_number)
														,transform(Corp2_Raw_KS.Layouts.Temp_CPABREP_CPAHST,
																			 self                   := left;
																			 self										:= right;
																			 self                   := [];
																			)
													 ,left outer
													 ,local
													);		

		//********************************************************************
		//This begins the ANNUAL REPORT (AR) mapping.
		//********************************************************************	
		corp2_mapping.layoutscommon.ar ARTransform(Corp2_Raw_KS.Layouts.Temp_CPABREP_CPAHST  l) := transform
			self.corp_key															:= state_fips +'-' + corp2.t2u(l.corp_number);		
			self.corp_vendor													:= state_fips;		
			self.corp_state_origin										:= state_origin;
			self.corp_process_date										:= filedate;
			self.corp_sos_charter_nbr									:= corp2.t2u(l.corp_number);
			self.ar_due_dt														:= Corp2_Mapping.fValidateDate(l.a_r_due,'CCYYMMDD').GeneralDate;
			self.ar_filed_dt													:= Corp2_Mapping.fValidateDate(l.filing_ar_date,'CCYYMMDD').PastDate;
			self.ar_report_dt													:= Corp2_Mapping.fValidateDate(l.validation_date,'CCYYMMDD').PastDate;
			self.ar_report_nbr												:= corp2.t2u(l.validation_number + l.validation_sub);
			self.ar_tax_amount_paid										:= corp2.t2u(l.amount_paid);
      self.ar_roll                        			:= if(corp2.t2u(l.microfilm_roll)  <> '', (string)(integer)corp2.t2u(l.microfilm_roll), '');
			self.ar_frame                       			:= if(corp2.t2u(l.microfilm_frame) <> '', (string)(integer)corp2.t2u(l.microfilm_frame), '');
			self.ar_comment														:= if((integer)corp2.t2u(l.number_of_pages) <> 0,
																											'NUMBER OF PAGES: ' + (string)(integer)corp2.t2u(l.number_of_pages),
																											''
																										 );
			self.ar_status														:= corp2.t2u(l.ar_status);																											
			self.ar_paid_date													:= Corp2_Mapping.fValidateDate(l.transaction_date,'CCYYMMDD').PastDate;
			self 																			:= [];
		end;
													
		MapCorpHist2AR 		 := project(CorpHst, ARTransform(left));
		MapARFiltered	     := MapCorpHist2AR(corp2.t2u(ar_due_dt+ar_filed_dt+ar_report_dt+ar_report_nbr+ar_tax_amount_paid+ar_roll+ar_frame+ar_comment+ar_status+ar_paid_date)<>'');
		MapAR			 		 		 := dedup(sort(distribute(MapARFiltered,hash(corp_key)),record,local),record,local) : independent;


		//******************************* STOCK ******************************

		//********************************************************************
		//This begins the STOCK mapping.  No record is created if the field
		//named stock_issued is 0.
		//********************************************************************	
		corp2_mapping.layoutscommon.stock StockTransform(Corp2_Raw_KS.Layouts.Temp_CPABREP_CPADREP l) := transform,
		skip ((integer) l.stock_issued = 0) 
			self.corp_key															:= state_fips + '-' + corp2.t2u(l.corp_number);		
			self.corp_vendor													:= state_fips;		
			self.corp_state_origin										:= state_origin;
			self.corp_process_date										:= filedate;
			self.corp_sos_charter_nbr									:= corp2.t2u(l.corp_number);
			self.stock_shares_issued									:= (string)(integer)corp2.t2u(l.stock_issued);
			self 																			:= [];
		end;
		
		Stock 											:= project(FullFile, StockTransform(left));
		MapStock										:= dedup(sort(distribute(Stock,hash(corp_key)),record,local),record,local) : independent;

		//********************************************************************
		// SCRUB AR 
		//********************************************************************	
		AR_F := MapAR;
		AR_S := Scrubs_Corp2_Mapping_KS_AR.Scrubs;				// Scrubs module
		AR_N := AR_S.FromNone(AR_F); 											// Generate the error flags
		AR_T := AR_S.FromBits(AR_N.BitmapInfile);     		// Use the FromBits module; makes my bitmap datafile easier to get to
		AR_U := AR_S.FromExpanded(AR_N.ExpandedInFile); 	// Pass the expanded error flags into the Expanded module

		//Outputs reports
		AR_ErrorSummary			 	 := output(AR_U.SummaryStats, named('AR_ErrorSummary_KS'+filedate));
		AR_ScrubErrorReport 	 := output(choosen(AR_U.AllErrors, 1000), named('AR_ScrubErrorReport_KS'+filedate));
		AR_SomeErrorValues		 := output(choosen(AR_U.BadValues, 1000), named('AR_SomeErrorValues_KS'+filedate));
		AR_IsScrubErrors		 	 := IF(count(AR_U.AllErrors)<> 0,true,false);

		// Orbit Stats
		AR_OrbitStats				 	 := AR_U.OrbitStats();

		//Outputs files
		AR_CreateBitMaps			 := output(AR_N.BitmapInfile,,'~thor_data::corp_ks_ar_scrubs_bits',overwrite,compressed);	//long term storage
		AR_TranslateBitMap		 := output(AR_T);

		//Submits Profile's stats to Orbit
		AR_SubmitStats 			   := Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_KS_AR','ScrubsAlerts', AR_OrbitStats, version,'Corp_KS_AR').SubmitStats;
		AR_ScrubsWithExamples  := Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_KS_AR','ScrubsAlerts', AR_OrbitStats, version,'Corp_KS_AR').CompareToProfile_with_Examples;

		AR_ScrubsAlert				 := AR_ScrubsWithExamples(RejectWarning = 'Y');
		AR_ScrubsAttachment	   := Scrubs.fn_email_attachment(AR_ScrubsAlert);
		AR_MailFile					   := FileServices.SendEmailAttachData(corp2.Email_Notification_Lists.AttachedList
																															,'Scrubs CorpAR_KS Report' //subject
																															,'Scrubs CorpAR_KS Report' //body
																															,(data)AR_ScrubsAttachment
																															,'text/csv'
																															,'CorpKSARScrubsReport.csv'
																														);

		AR_BadRecords				 		:= AR_N.ExpandedInFile(	
																										corp_key_Invalid							  			<> 0 or
																										corp_vendor_Invalid 									<> 0 or
																										corp_state_origin_Invalid 					 	<> 0 or
																										corp_process_date_Invalid						  <> 0 or
																										corp_sos_charter_nbr_Invalid 					<> 0 or
																										ar_due_dt_Invalid 										<> 0 or
																										ar_filed_dt_Invalid 									<> 0 or
																										ar_report_dt_Invalid 									<> 0 or
																										ar_report_nbr_Invalid 								<> 0 or
																										ar_roll_Invalid 											<> 0 or
																										ar_frame_Invalid 											<> 0 or
																										ar_status_Invalid 										<> 0 or
																										ar_paid_date_Invalid 									<> 0																	
																									 );
																									 																	
		AR_GoodRecords						:= AR_N.ExpandedInFile(
																											corp_key_Invalid							  			= 0 and
																											corp_vendor_Invalid 									= 0 and
																											corp_state_origin_Invalid 					 	= 0 and
																											corp_process_date_Invalid						  = 0 and
																											corp_sos_charter_nbr_Invalid 					= 0 and
																											ar_due_dt_Invalid 										= 0 and
																											ar_filed_dt_Invalid 									= 0 and
																											ar_report_nbr_Invalid 								= 0 and
																											ar_roll_Invalid 											= 0 and
																											ar_frame_Invalid 											= 0 and
																											ar_status_Invalid 										= 0 and																											
																											ar_paid_date_Invalid 									= 0																									
																										 );

		AR_FailBuild					 		:= if(count(AR_GoodRecords) = 0,true,false);

		AR_ApprovedRecords		 		:= project(AR_GoodRecords,transform(Corp2_Mapping.LayoutsCommon.AR,self := left;));


		AR_ALL								 		:= sequential(IF(count(AR_BadRecords) <> 0
																						  ,IF (poverwrite
																								  ,OUTPUT(AR_BadRecords,,Corp2_Mapping._Dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::ar_'+state_origin,overwrite,__compressed__)
																								  ,OUTPUT(AR_BadRecords,,Corp2_Mapping._Dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::ar_'+state_origin,__compressed__)
																								  )
																						  )
																					 ,output(AR_ScrubsWithExamples, all, named('CorpARKSScrubsReportWithExamples'+filedate))
																					 //Send Alerts if Scrubs exceeds thresholds
																					 ,IF(COUNT(AR_ScrubsAlert) > 0, AR_MailFile, OUTPUT('CORP2_MAPPING.KS - No "AR" Corp Scrubs Alerts'))
																					 ,AR_ErrorSummary
																					 ,AR_ScrubErrorReport
																					 ,AR_SomeErrorValues	
																					 ,AR_SubmitStats
																					);

	//********************************************************************
  // SCRUB MAIN
  //********************************************************************	
		Main_F := mapMain;
		Main_S := Scrubs_Corp2_Mapping_KS_Main.Scrubs;					// Scrubs module
		Main_N := Main_S.FromNone(Main_F); 											// Generate the error flags
		Main_T := Main_S.FromBits(Main_N.BitmapInfile);     		// Use the FromBits module; makes my bitmap datafile easier to get to
		Main_U := Main_S.FromExpanded(Main_N.ExpandedInFile); 	// Pass the expanded error flags into the Expanded module

		//Outputs reports
		Main_ErrorSummary					:= output(Main_U.SummaryStats, named('Main_ErrorSummary_KS'+filedate));
		Main_ScrubErrorReport 		:= output(choosen(Main_U.AllErrors, 1000), named('Main_ScrubErrorReport_KS'+filedate));
		Main_SomeErrorValues			:= output(choosen(Main_U.BadValues, 1000), named('Main_SomeErrorValues_KS'+filedate));
		Main_IsScrubErrors		 		:= IF(count(Main_U.AllErrors)<> 0,true,false);

		// Orbit Stats
		Main_OrbitStats						:= Main_U.OrbitStats();

		//Outputs files
		Main_CreateBitMaps				:= output(Main_N.BitmapInfile,,'~thor_data::corp_ks_main_scrubs_bits',overwrite,compressed);	//long term storage
		Main_TranslateBitMap			:= output(Main_T);

		//Submits Profile's stats to Orbit
		Main_SubmitStats 			    := Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_KS_Main','ScrubsAlerts', Main_OrbitStats, version,'Corp_KS_Main').SubmitStats;
		Main_ScrubsWithExamples   := Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_KS_Main','ScrubsAlerts', Main_OrbitStats, version,'Corp_KS_Main').CompareToProfile_with_Examples;

		Main_ScrubsAlert					:= Main_ScrubsWithExamples(RejectWarning = 'Y');
		Main_ScrubsAttachment			:= Scrubs.fn_email_attachment(Main_ScrubsAlert);
		Main_MailFile							:= FileServices.SendEmailAttachData(corp2.Email_Notification_Lists.spray
																																 ,'Scrubs CorpMain_KS Report' //subject
																																 ,'Scrubs CorpMain_KS Report' //body
																																 ,(data)Main_ScrubsAttachment
																																 ,'text/csv'
																																 ,'CorpKSMainScrubsReport.csv'
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
																											 corp_filing_date_Invalid 							<> 0 or
																											 corp_inc_state_Invalid 								<> 0 or
																											 corp_inc_date_Invalid 									<> 0 or
																											 corp_fed_tax_id_Invalid 								<> 0 or
																											 corp_term_exist_cd_Invalid 						<> 0 or
																											 corp_term_exist_exp_Invalid 						<> 0 or
																											 corp_term_exist_desc_Invalid 					<> 0 or
																											 corp_foreign_domestic_ind_Invalid 			<> 0 or
																											 corp_forgn_state_desc_Invalid 					<> 0 or
																											 corp_forgn_date_Invalid 								<> 0 or
																											 corp_orig_org_structure_cd_Invalid			<> 0 or
																											 corp_for_profit_ind_Invalid 						<> 0 or
																											 corp_fiscal_year_month_Invalid 				<> 0 or
																											 corp_name_status_cd_Invalid 						<> 0 or
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
																										 corp_filing_date_Invalid 							= 0 and
																										 corp_inc_state_Invalid 								= 0 and
																										 corp_inc_date_Invalid 									= 0 and
																										 corp_fed_tax_id_Invalid 								= 0 and
																										 corp_term_exist_cd_Invalid 						= 0 and
																										 corp_term_exist_exp_Invalid 						= 0 and
																										 corp_term_exist_desc_Invalid 					= 0 and
																										 corp_foreign_domestic_ind_Invalid 			= 0 and
																										 corp_forgn_state_desc_Invalid 					= 0 and
																										 corp_forgn_date_Invalid 								= 0 and
																										 corp_orig_org_structure_cd_Invalid			= 0 and
																										 corp_for_profit_ind_Invalid 						= 0 and
																										 corp_fiscal_year_month_Invalid 				= 0 and
																										 corp_name_status_cd_Invalid 						= 0 and
																										 recordorigin_Invalid 									= 0
																								  );

		Main_FailBuild					:= map( corp2_mapping.fCalcPercent(count(Main_N.ExpandedInFile(corp_key_invalid<>0)),count(Main_N.ExpandedInFile),false) 										> Scrubs_Corp2_Mapping_KS_Main.Threshold_Percent.CORP_KEY										 => true,
																		corp2_mapping.fCalcPercent(count(Main_N.ExpandedInFile(corp_orig_sos_charter_nbr_invalid<>0)),count(Main_N.ExpandedInFile),false) 	> Scrubs_Corp2_Mapping_KS_Main.Threshold_Percent.CORP_ORIG_SOS_CHARTER_NBR 	 => true,
																		corp2_mapping.fCalcPercent(count(Main_N.ExpandedInFile(corp_legal_name_invalid<>0)),count(Main_N.ExpandedInFile),false) 						> Scrubs_Corp2_Mapping_KS_Main.Threshold_Percent.CORP_LEGAL_NAME 						 => true,
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
																					,output(Main_ScrubsWithExamples, all, named('CorpMainKSScrubsReportWithExamples'+filedate))
																					//Send Alerts if Scrubs exceeds thresholds
																					,IF(COUNT(Main_ScrubsAlert) > 0, Main_MailFile, OUTPUT('CORP2_MAPPING.KS - No "MAIN" Corp Scrubs Alerts'))
																					,Main_ErrorSummary
																					,Main_ScrubErrorReport
																					,Main_SomeErrorValues			
																					,Main_SubmitStats
																				 );

	//********************************************************************
  // SCRUB STOCK
  //********************************************************************	
		Stock_F := mapStock;
		Stock_S := Scrubs_Corp2_Mapping_KS_Stock.Scrubs;						// Scrubs module
		Stock_N := Stock_S.FromNone(Stock_F); 											// Generate the error flags
		Stock_T := Stock_S.FromBits(Stock_N.BitmapInfile);     			// Use the FromBits module; makes my bitmap datafile easier to get to
		Stock_U := Stock_S.FromExpanded(Stock_N.ExpandedInFile); 		// Pass the expanded error flags into the Expanded module

		//Outputs reports
		Stock_ErrorSummary			 	:= output(Stock_U.SummaryStats, named('Stock_ErrorSummary_KS'+filedate));
		Stock_ScrubErrorReport 	 	:= output(choosen(Stock_U.AllErrors, 1000), named('Stock_ScrubErrorReport_KS'+filedate));
		Stock_SomeErrorValues		 	:= output(choosen(Stock_U.BadValues, 1000), named('Stock_SomeErrorValues_KS'+filedate));
		Stock_IsScrubErrors		 	 	:= IF(count(Stock_U.AllErrors)<> 0,true,false);

		// Orbit Stats
		Stock_OrbitStats				 	:= Stock_U.OrbitStats();

		//Outputs files
		Stock_CreateBitMaps				:= output(Stock_N.BitmapInfile,,'~thor_data::corp_ks_scrubs_bits',overwrite,compressed);	//long term storage
		Stock_TranslateBitMap			:= output(Stock_T);

		//Submits Profile's stats to Orbit
		Stock_SubmitStats 			  := Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_KS_Stock','ScrubsAlerts', Stock_OrbitStats, version,'Corp_KS_Stock').SubmitStats;
		Stock_ScrubsWithExamples  := Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_KS_Stock','ScrubsAlerts', Stock_OrbitStats, version,'Corp_KS_Stock').CompareToProfile_with_Examples;

		Stock_ScrubsAlert					:= Stock_ScrubsWithExamples(RejectWarning = 'Y');
		Stock_ScrubsAttachment		:= Scrubs.fn_email_attachment(Stock_ScrubsAlert);
		Stock_MailFile						:= FileServices.SendEmailAttachData(corp2.Email_Notification_Lists.spray
																																 ,'Scrubs CorpStock_KS Report' //subject
																																 ,'Scrubs CorpStock_KS Report' //body
																																 ,(data)Stock_ScrubsAttachment
																																 ,'text/csv'
																																 ,'CorpKSStockScrubsReport.csv'
																																 ,
																																 ,
																																 ,corp2.Email_Notification_Lists.spray);

		Stock_BadRecords					:= Stock_N.ExpandedInFile(	
																												corp_key_Invalid							  			<> 0 or
																												corp_vendor_Invalid 									<> 0 or
																												corp_state_origin_Invalid 					 	<> 0 or
																												corp_process_date_Invalid						  <> 0 or
																												corp_sos_charter_nbr_Invalid					<> 0 or
																												stock_shares_issued_Invalid	 					<> 0 
																											 );
																																							
		Stock_GoodRecords					:= Stock_N.ExpandedInFile(	
																												corp_key_Invalid							  			= 0 and
																												corp_vendor_Invalid 									= 0 and
																												corp_state_origin_Invalid 					 	= 0 and
																												corp_process_date_Invalid						  = 0 and
																												corp_sos_charter_nbr_Invalid					= 0 and
																												stock_shares_issued_Invalid		 				= 0 
																											 );
																														
		Stock_FailBuild						:= if(count(Stock_GoodRecords) = 0,true,false);

		Stock_ApprovedRecords			:= project(Stock_GoodRecords,transform(Corp2_Mapping.LayoutsCommon.Stock,self := left));

		Stock_ALL									:= sequential( IF(count(Stock_BadRecords) <> 0
																							 ,IF (poverwrite
																									 ,OUTPUT(Stock_BadRecords,,Corp2_Mapping._Dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::stock_'+state_origin,overwrite,__compressed__)
																									 ,OUTPUT(Stock_BadRecords,,Corp2_Mapping._Dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::stock_'+state_origin,__compressed__)
																									 )
																							)
																						,output(Stock_ScrubsWithExamples, all, named('CorpStockKSScrubsReportWithExamples'+filedate))
																						//Send Alerts if Scrubs exceeds thresholds
																						,IF(COUNT(Stock_ScrubsAlert) > 0, Stock_MailFile, OUTPUT('CORP2_MAPPING.KS - No "Stock" Corp Scrubs Alerts'))
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

	mapKS:= sequential ( if(pshouldspray = true,Corp2_mapping.fSprayFiles(state_origin,version,pOverwrite := pOverwrite))
											// ,Corp2_Raw_KS.Build_Bases(filedate,version,puseprod).All // Determined building of bases not needed							
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
																		 ,if(count(Main_BadRecords) <> 0 or count(AR_BadRecords) <> 0 or count(Stock_BadRecords)<>0
																				 ,Corp2_Mapping.Send_Email(state_origin,version,count(Main_BadRecords)<>0,count(AR_BadRecords)<>0,,count(Stock_BadRecords)<>0,count(Main_BadRecords),count(AR_BadRecords),,count(Stock_BadRecords),count(Main_ApprovedRecords),count(AR_ApprovedRecords),,count(Stock_ApprovedRecords)).RecordsRejected																				 
																				 ,Corp2_Mapping.Send_Email(state_origin,version,count(Main_BadRecords)<>0,count(AR_BadRecords)<>0,,count(Stock_BadRecords)<>0,count(Main_BadRecords),count(AR_BadRecords),,count(Stock_BadRecords),count(Main_ApprovedRecords),count(AR_ApprovedRecords),,count(Stock_ApprovedRecords)).MappingSuccess																				 
																				 )
																		 ,if(IsScrubErrors
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
	return sequential (	 if(isFileDateValid
													,mapKS
													,sequential (Corp2_Mapping.Send_Email(state_origin,filedate).InvalidFileDateParm
																			,FAIL('Corp2_Mapping.'+state_origin+' failed.  An invalid filedate was passed in as a parameter.')
																			)
													)
										);

	end;	// end of Update function

end;  // end of Module