import address,corp2,corp2_raw_il,scrubs,scrubs_corp2_mapping_il_lp_ar,scrubs_corp2_mapping_il_lp_main,std,ut,versioncontrol,tools;

export IL_LP := module 

	 export Update(string fileDate, string version, boolean pShouldSpray = _Dataset().bShouldSpray, boolean pOverwrite = false, boolean pUseProd = Tools._Constants.IsDataland) := Function

		state_origin			 				:= 'IL';
		state_fips	 				 			:= '17';
		state_desc	 			 				:= 'ILLINOIS';

		FileMaster								:= dedup(sort(distribute(Corp2_Raw_IL.Files(fileDate,puseprod).Input.LP.Master,hash(lp_file_number_52001)),record,local),record,local) : independent;
		FileAdmittingNames				:= dedup(sort(distribute(Corp2_Raw_IL.Files(fileDate,puseprod).Input.LP.AdmittingNames,hash(lp_file_number_52017)),record,local),record,local) : independent;
		FileAssumedNames					:= dedup(sort(distribute(Corp2_Raw_IL.Files(fileDate,puseprod).Input.LP.AssumedNames,hash(lp_file_number_52005)),record,local),record,local) : independent;
		FileGeneraLPartner				:= dedup(sort(distribute(Corp2_Raw_IL.Files(fileDate,puseprod).Input.LP.GeneraLPartner,hash(lp_file_number_52004)),record,local),record,local) : independent;
		FileOldNames							:= dedup(sort(distribute(Corp2_Raw_IL.Files(fileDate,puseprod).Input.LP.OldNames,hash(lp_file_number_52006)),record,local),record,local) : independent;

		alpha											:= 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';

		//********************************************************************
		// PROCESS CORPORATE (MASTER) DATA
		//********************************************************************
		Corp2_mapping.LayoutsCommon.Main LPTransform(Corp2_Raw_IL.Layouts.LPLayoutIn l, integer c) := transform,
		skip(c = 2 and (corp2.t2u(l.lp_agent_firm_name_52001) = '' or stringlib.stringfilter(corp2.t2u(l.lp_agent_name_52001),alpha) = stringlib.stringfilter(corp2.t2u(l.lp_agent_firm_name_52001),alpha)))
				self.dt_vendor_first_reported							:= (integer)fileDate;
				self.dt_vendor_last_reported							:= (integer)fileDate;
				self.dt_first_seen												:= (integer)fileDate;
				self.dt_last_seen													:= (integer)fileDate;
				self.corp_ra_dt_first_seen								:= (integer)fileDate;
				self.corp_ra_dt_last_seen									:= (integer)fileDate;			
				self.corp_key															:= state_fips + '-LP-' + corp2.t2u(l.lp_file_number_52001);
				self.corp_vendor													:= state_fips;
				self.corp_state_origin										:= state_origin;
				self.corp_process_date										:= fileDate;
				self.corp_orig_sos_charter_nbr        		:= corp2.t2u(l.lp_file_number_52001);
				self.corp_legal_name                  		:= Corp2_mapping.fCleanBusinessName(state_origin,state_desc,l.lp_partnership_name_52001).BusinessName;
				self.corp_ln_name_type_cd 								:= '01';
				self.corp_ln_name_type_desc 							:= 'LEGAL';
				self.corp_address1_type_cd 								:= if(Corp2_Mapping.fAddressExists(state_origin,state_desc,l.lp_records_office_street_52001,,l.lp_records_office_city_52001,l.lp_records_office_state_52001,l.lp_records_office_zip_52001).ifAddressExists,'B','');
				self.corp_address1_type_desc 							:= if(Corp2_Mapping.fAddressExists(state_origin,state_desc,l.lp_records_office_street_52001,,l.lp_records_office_city_52001,l.lp_records_office_state_52001,l.lp_records_office_zip_52001).ifAddressExists,'BUSINESS','');
				self.corp_address1_line1									:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.lp_records_office_street_52001,,l.lp_records_office_city_52001,l.lp_records_office_state_52001,l.lp_records_office_zip_52001).AddressLine1;
				self.corp_address1_line2									:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.lp_records_office_street_52001,,l.lp_records_office_city_52001,l.lp_records_office_state_52001,l.lp_records_office_zip_52001).AddressLine2;
				self.corp_address1_line3									:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.lp_records_office_street_52001,,l.lp_records_office_city_52001,l.lp_records_office_state_52001,l.lp_records_office_zip_52001).AddressLine3;
				self.corp_filing_date					 						:= Corp2_mapping.fValidateDate(l.lp_date_org_filed_52001,'CCYYMMDD').PastDate;
				self.corp_filing_cd					 							:= if(Corp2_mapping.fValidateDate(l.lp_date_org_filed_52001,'CCYYMMDD').PastDate<>'','X','');
				self.corp_filing_desc					 						:= if(Corp2_mapping.fValidateDate(l.lp_date_org_filed_52001,'CCYYMMDD').PastDate<>'','ORIGINAL DATE FILED AT COUNTY LEVEL','');
				self.corp_status_cd 											:= corp2.t2u(l.lp_status_52001);
				self.corp_status_desc 										:= Corp2_Raw_IL.Functions_LP.CorpStatusDesc(l.lp_status_52001);
				self.corp_status_date 										:= Corp2_mapping.fValidateDate(l.lp_status_date_52001,'CCYYMMDD').PastDate;
				self.corp_inc_state												:= state_origin;
				self.corp_inc_county											:= if(Corp2_mapping.fValidateDate(l.lp_date_sos_filed_52001,'CCYYMMDD').PastDate<>'',Corp2_Raw_IL.Functions_LP.County(l.lp_filing_org_cnty_filed_52001),'');
				self.corp_inc_date 												:= if(corp2.t2u(l.lp_business_state_52001) in ['',state_origin,state_desc],Corp2_mapping.fValidateDate(l.lp_date_sos_filed_52001,'CCYYMMDD').PastDate,'');
				self.corp_term_exist_cd 									:= map(Corp2_mapping.fValidateDate(l.lp_date_duration_52001,'CCYYMMDD').GeneralDate<>'' => 'D', //is valid date
																												 corp2.t2u(l.lp_date_duration_52001) in [''] 																			=> 'P', //is blank
																												 Corp2_mapping.fValidateDate(l.lp_date_duration_52001,'CCYYMMDD').GeneralDate=''  => 'P', //is not valid date(includes dates of all 9's)
																												 ''
																												);
				self.corp_term_exist_exp 									:= if(corp2.t2u(l.lp_date_duration_52001)<>'',Corp2_mapping.fValidateDate(l.lp_date_duration_52001,'CCYYMMDD').GeneralDate,'');
				self.corp_term_exist_desc 								:= map(self.corp_term_exist_cd = 'D' => 'EXPIRATION DATE',
																												 self.corp_term_exist_cd = 'P' => 'PERPETUAL',
																												 ''
																												);
				self.corp_forgn_date											:= if(corp2.t2u(l.lp_business_state_52001) in ['',state_origin,state_desc],'',Corp2_mapping.fValidateDate(l.lp_date_sos_filed_52001,'CCYYMMDD').PastDate);
				self.corp_foreign_domestic_ind 						:= if(corp2.t2u(l.lp_business_state_52001) in ['',state_origin,state_desc],'D','F');
				self.corp_forgn_state_cd 									:= if(corp2.t2u(l.lp_business_state_52001) in ['',state_origin,state_desc],'',Corp2_Raw_IL.Functions_LP.State_Foreign_Codes(l.lp_business_state_52001));
				self.corp_forgn_state_desc 								:= if(corp2.t2u(l.lp_business_state_52001) in ['',state_origin,state_desc],'',Corp2_Raw_IL.Functions_LP.CorpForgnStateDesc(l.lp_business_state_52001));
				self.corp_orig_org_structure_desc 				:= 'LIMITED PARTNERSHIP';
				self.corp_addl_info												:= if(Corp2_mapping.fValidateDate(l.lp_date_sos_filed_52001,'CCYYMMDD').PastDate<>'' and corp2.t2u(l.lp_filing_org_doc_nbr_52001)<>'',
																												'ORIGINAL FILING NUMBER: ' + corp2.t2u(l.lp_filing_org_doc_nbr_52001),
																												''
																											 );
				self.corp_ra_full_name										:= choose(c,map(regexfind('(\\*)*( )*AGENT( )*VACATED( )*(\\*)*',corp2.t2u(l.lp_agent_name_52001),0)<>'' => Corp2_mapping.fCleanBusinessName(state_origin,state_desc,regexreplace('(\\*)*( )*AGENT( )*VACATED( )*(\\*)*',corp2.t2u(l.lp_agent_name_52001),'')).BusinessName,
																																  Corp2_mapping.fCleanBusinessName(state_origin,state_desc,l.lp_agent_name_52001).BusinessName
																																 ),
																															map(regexfind('(\\*)*( )*AGENT( )*VACATED( )*(\\*)*',corp2.t2u(l.lp_agent_firm_name_52001),0)<>'' => Corp2_mapping.fCleanBusinessName(state_origin,state_desc,regexreplace('(\\*)*( )*AGENT( )*VACATED( )*(\\*)*',corp2.t2u(l.lp_agent_firm_name_52001),'')).BusinessName,
																																  Corp2_mapping.fCleanBusinessName(state_origin,state_desc,l.lp_agent_firm_name_52001).BusinessName
																																 )
																													 );
				self.corp_ra_effective_date 							:= Corp2_mapping.fValidateDate(l.lp_date_agent_chge_52001,'CCYYMMDD').GeneralDate;
				tempRAAddress 														:= Address.CleanAddress182(l.lp_agent_street_52001,l.lp_agent_zip_52001); //used to get state
				self.corp_ra_address_type_cd							:= if(Corp2_Mapping.fAddressExists(state_origin,state_desc,l.lp_agent_street_52001,,l.lp_agent_city_52001,tempRAAddress[115..116],l.lp_agent_zip_52001).ifAddressExists,'R','');
				self.corp_ra_address_type_desc						:= if(Corp2_Mapping.fAddressExists(state_origin,state_desc,l.lp_agent_street_52001,,l.lp_agent_city_52001,tempRAAddress[115..116],l.lp_agent_zip_52001).ifAddressExists,'REGISTERED OFFICE','');
				self.corp_ra_address_line1								:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.lp_agent_street_52001,,l.lp_agent_city_52001,tempRAAddress[115..116],l.lp_agent_zip_52001).AddressLine1;
				self.corp_ra_address_line2								:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.lp_agent_street_52001,,l.lp_agent_city_52001,tempRAAddress[115..116],l.lp_agent_zip_52001).AddressLine2;
				self.corp_ra_address_line3								:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.lp_agent_street_52001,,l.lp_agent_city_52001,tempRAAddress[115..116],l.lp_agent_zip_52001).AddressLine3;
				self.ra_prep_addr_line1										:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.lp_agent_street_52001,,l.lp_agent_city_52001,tempRAAddress[115..116],l.lp_agent_zip_52001).PrepAddrLine1;
				self.ra_prep_addr_last_line								:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.lp_agent_street_52001,,l.lp_agent_city_52001,tempRAAddress[115..116],l.lp_agent_zip_52001).PrepAddrLastLine;																												
				self.corp_agent_county										:= Corp2_Raw_IL.Functions_LP.County(l.lp_agent_cnty_code_52001);
				self.corp_country_of_formation						:= if(Corp2_Raw_IL.Functions_LP.CorpCountryOfFormation(l.lp_business_state_52001)[1..2]<>'**',
																												Corp2_Mapping.fCleanCountry(state_origin,state_desc,,Corp2_Raw_IL.Functions_LP.CorpCountryOfFormation(l.lp_business_state_52001)).Country,
																												''
																											 );
				self.corp_home_incorporated_county				:= corp2.t2u(l.lp_records_office_cnty_52001);
				self.corp_organizational_comments					:= if(Corp2_mapping.fValidateDate(l.lp_date_effective_52001,'CCYYMMDD').GeneralDate<>'',
																												'LP ELECTED TO COMMENCE BUSINESS ON THE FOLLOWING DATE: '+Corp2_mapping.fValidateDate(l.lp_date_effective_52001,'CCYYMMDD').GeneralDate,
																												''
																											 );
				self.corp_partner_contributions_total			:= if((integer)l.lp_contributions_52001=0,'',(string)(integer)l.lp_contributions_52001);
				self.recordorigin													:= 'C';
				self 																			:= [];																												
	  end;

		MapFileMaster 					:= normalize(FileMaster,2,LPTransform(left,counter)) : independent;
	
	
	  jFileAssumedNames	:= join(FileAssumedNames, FileMaster, 
															left.lp_file_number_52005 = right.lp_file_number_52001,
															transform(Corp2_Raw_IL.Layouts.LPAssumedNames_TempLay, 
																				 self.lp_business_state_52001 := right.lp_business_state_52001;
																				 self.lp_date_sos_filed_52001 := right.lp_date_sos_filed_52001;
																				 self := left; self := right; self := [];),
															left outer,local) : independent;
															
		Corp2_mapping.LayoutsCommon.Main AssumedNamesTransform(Corp2_Raw_IL.Layouts.LPAssumedNames_TempLay l) := transform
				self.dt_vendor_first_reported							:= (integer)fileDate;
				self.dt_vendor_last_reported							:= (integer)fileDate;
				self.dt_first_seen												:= (integer)fileDate;
				self.dt_last_seen													:= (integer)fileDate;
				self.corp_ra_dt_first_seen								:= (integer)fileDate;
				self.corp_ra_dt_last_seen									:= (integer)fileDate;			
				self.corp_key															:= state_fips + '-LP-' + corp2.t2u(l.lp_file_number_52005);
				self.corp_vendor													:= state_fips;
				self.corp_state_origin										:= state_origin;			
				self.corp_process_date										:= fileDate;
				self.corp_orig_sos_charter_nbr        		:= corp2.t2u(l.lp_file_number_52005);
				self.corp_legal_name                  		:= Corp2_mapping.fCleanBusinessName(state_origin,state_desc,l.lp_assumed_name_52005).BusinessName;
				self.corp_ln_name_type_cd 								:= '06';
				self.corp_ln_name_type_desc 							:= 'ASSUMED NAME';
				//corp_name_comment contains two overloaded fields:  lp_assumed_date_adopted_52005 and lp_assumed_date_renew_52005
				self.corp_name_comment										:= Corp2_Raw_IL.Functions_LP.CorpNameComment(l.lp_assumed_date_cancel_52005,l.lp_assumed_cancel_code_52005,l.lp_assumed_date_adopted_52005,l.lp_assumed_date_renew_52005);
				self.corp_inc_state												:= state_origin;																											 
				self.corp_name_effective_date							:= Corp2_mapping.fValidateDate(l.lp_assumed_date_adopted_52005,'CCYYMMDD').GeneralDate;
				self.corp_name_status_date								:= Corp2_mapping.fValidateDate(l.lp_assumed_date_renew_52005,'CCYYMMDD').GeneralDate;
				self.corp_name_status_desc								:= if(Corp2_mapping.fValidateDate(l.lp_assumed_date_renew_52005,'CCYYMMDD').GeneralDate<>'','RENEW DATE','');
				self.corp_inc_date 												:= if(corp2.t2u(l.lp_business_state_52001) in ['',state_origin,state_desc],Corp2_mapping.fValidateDate(l.lp_date_sos_filed_52001,'CCYYMMDD').PastDate,'');
				self.corp_forgn_date											:= if(corp2.t2u(l.lp_business_state_52001) in ['',state_origin,state_desc],'',Corp2_mapping.fValidateDate(l.lp_date_sos_filed_52001,'CCYYMMDD').PastDate);
				self.recordorigin													:= 'C';
				self 																			:= [];					
	  end;

		MapFileAssumedNames	:= project(jFileAssumedNames,AssumedNamesTransform(left));

		
		jFileAdmittingNames	:= join(FileAdmittingNames, FileMaster, 
															left.lp_file_number_52017 = right.lp_file_number_52001,
															transform(Corp2_Raw_IL.Layouts.LPAdmittingNames_TempLay, 
																				 self.lp_business_state_52001 := right.lp_business_state_52001;
																				 self.lp_date_sos_filed_52001 := right.lp_date_sos_filed_52001;
																				 self := left; self := right; self := [];),
															left outer,local) : independent;
															
		Corp2_mapping.LayoutsCommon.Main AdmittingNamesTransform(Corp2_Raw_IL.Layouts.LPAdmittingNames_TempLay l) := transform
				self.dt_vendor_first_reported							:= (integer)fileDate;
				self.dt_vendor_last_reported							:= (integer)fileDate;
				self.dt_first_seen												:= (integer)fileDate;
				self.dt_last_seen													:= (integer)fileDate;
				self.corp_ra_dt_first_seen								:= (integer)fileDate;
				self.corp_ra_dt_last_seen									:= (integer)fileDate;			
				self.corp_key															:= state_fips + '-LP-' + corp2.t2u(l.lp_file_number_52017);
				self.corp_vendor													:= state_fips;
				self.corp_state_origin										:= state_origin;			
				self.corp_process_date										:= fileDate;
				self.corp_orig_sos_charter_nbr        		:= corp2.t2u(l.lp_file_number_52017);
				self.corp_legal_name                  		:= Corp2_mapping.fCleanBusinessName(state_origin,state_desc,l.lp_admitting_name_52017).BusinessName;
				self.corp_ln_name_type_cd 								:= '08';
				self.corp_ln_name_type_desc 							:= 'ADMITTING NAME';
				self.corp_inc_state												:= state_origin;				
				self.corp_name_effective_date							:= Corp2_mapping.fValidateDate(l.lp_date_filed_52017,'CCYYMMDD').GeneralDate;
				self.corp_inc_date 												:= if(corp2.t2u(l.lp_business_state_52001) in ['',state_origin,state_desc],Corp2_mapping.fValidateDate(l.lp_date_sos_filed_52001,'CCYYMMDD').PastDate,'');
				self.corp_forgn_date											:= if(corp2.t2u(l.lp_business_state_52001) in ['',state_origin,state_desc],'',Corp2_mapping.fValidateDate(l.lp_date_sos_filed_52001,'CCYYMMDD').PastDate);
				self.recordorigin													:= 'C';
				self 																			:= [];					
	  end;
		
		MapLPAdmittingNames := project(jFileAdmittingNames,AdmittingNamesTransform(left));


		jFileOldNames	:= join(FileOldNames, FileMaster, 
															left.lp_file_number_52006 = right.lp_file_number_52001,
															transform(Corp2_Raw_IL.Layouts.LPOldNames_TempLay, 
																				 self.lp_business_state_52001 := right.lp_business_state_52001;
																				 self.lp_date_sos_filed_52001 := right.lp_date_sos_filed_52001;
																				 self := left; self := right; self := [];),
															left outer,local) : independent;
															
		Corp2_mapping.LayoutsCommon.Main OldNamesTransform(Corp2_Raw_IL.Layouts.LPOldNames_TempLay l) := transform
				self.dt_vendor_first_reported							:= (integer)fileDate;
				self.dt_vendor_last_reported							:= (integer)fileDate;
				self.dt_first_seen												:= (integer)fileDate;
				self.dt_last_seen													:= (integer)fileDate;
				self.corp_ra_dt_first_seen								:= (integer)fileDate;
				self.corp_ra_dt_last_seen									:= (integer)fileDate;			
				self.corp_key															:= state_fips + '-LP-' + corp2.t2u(l.lp_file_number_52006);
				self.corp_vendor													:= state_fips;
				self.corp_state_origin										:= state_origin;			
				self.corp_process_date										:= fileDate;
				self.corp_orig_sos_charter_nbr        		:= corp2.t2u(l.lp_file_number_52006);
				self.corp_legal_name                  		:= Corp2_mapping.fCleanBusinessName(state_origin,state_desc,l.lp_old_name_52006).BusinessName;
				self.corp_ln_name_type_cd 								:= 'P';
				self.corp_ln_name_type_desc 							:= 'PRIOR NAME';
				self.corp_inc_state												:= state_origin;				
				self.corp_name_effective_date							:= Corp2_mapping.fValidateDate(l.lp_date_filed_52006,'CCYYMMDD').GeneralDate;
				self.corp_inc_date 												:= if(corp2.t2u(l.lp_business_state_52001) in ['',state_origin,state_desc],Corp2_mapping.fValidateDate(l.lp_date_sos_filed_52001,'CCYYMMDD').PastDate,'');
				self.corp_forgn_date											:= if(corp2.t2u(l.lp_business_state_52001) in ['',state_origin,state_desc],'',Corp2_mapping.fValidateDate(l.lp_date_sos_filed_52001,'CCYYMMDD').PastDate);
				self.recordorigin													:= 'C';
				self 																			:= [];					
	  end;
		
		MapLPOldNames := project(jFileOldNames,OldNamesTransform(left));
		
		//********************************************************************
		// PROCESS CORPORATE CONTACT (CONT) DATA
		//********************************************************************
		Corp2_mapping.LayoutsCommon.Main GeneralPartnerTransform(Corp2_Raw_IL.Layouts.LPGeneralPartnerLayoutIn l) := transform,
		skip(corp2.t2u(l.lp_gp_name_52004) = '')
				self.dt_vendor_first_reported							:= (integer)fileDate;
				self.dt_vendor_last_reported							:= (integer)fileDate;
				self.dt_first_seen												:= (integer)fileDate;
				self.dt_last_seen													:= (integer)fileDate;
				self.corp_ra_dt_first_seen								:= (integer)fileDate;
				self.corp_ra_dt_last_seen									:= (integer)fileDate;			
				self.corp_key															:= state_fips + '-LP-' + corp2.t2u(l.lp_file_number_52004);
				self.corp_vendor													:= state_fips;
				self.corp_state_origin										:= state_origin;			
				self.corp_process_date										:= fileDate;
				self.corp_orig_sos_charter_nbr        		:= corp2.t2u(l.lp_file_number_52004);
				self.corp_legal_name                  		:= ''; //mapped from LP "master" file later
				self.cont_type_cd 												:= 'M';
				self.cont_type_desc					 							:= 'MEMBER/MANAGER/PARTNER';				
				self.cont_title1_desc											:= 'GENERAL PARTNER';
				self.cont_effective_date									:= Corp2_mapping.fValidateDate(l.lp_gp_file_date_52004,'CCYYMMDD').GeneralDate;
				self.cont_effective_desc									:= if(self.cont_effective_date<>'','START DATE','');
				self.cont_full_name												:= Corp2_Raw_IL.Functions_LP.ContFullName(l.lp_gp_name_52004);
				self.cont_address_type_cd 								:= if(Corp2_Mapping.fAddressExists(state_origin,state_desc,l.lp_gp_street_52004,,l.lp_gp_city_52004,l.lp_gp_state_52004,l.lp_mm_zip_52004).ifAddressExists,'T','');
				self.cont_address_type_desc 							:= if(Corp2_Mapping.fAddressExists(state_origin,state_desc,l.lp_gp_street_52004,,l.lp_gp_city_52004,l.lp_gp_state_52004,l.lp_mm_zip_52004).ifAddressExists,'CONTACT','');
				self.cont_address_line1										:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.lp_gp_street_52004,,l.lp_gp_city_52004,l.lp_gp_state_52004,l.lp_mm_zip_52004).AddressLine1;
				self.cont_address_line2										:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.lp_gp_street_52004,,l.lp_gp_city_52004,l.lp_gp_state_52004,l.lp_mm_zip_52004).AddressLine2;
				self.cont_address_line3										:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.lp_gp_street_52004,,l.lp_gp_city_52004,l.lp_gp_state_52004,l.lp_mm_zip_52004).AddressLine3;
				self.corp_inc_state												:= state_origin;				
				self.cont_prep_addr_line1     						:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.lp_gp_street_52004,,l.lp_gp_city_52004,l.lp_gp_state_52004,l.lp_mm_zip_52004).PrepAddrLine1;
				self.cont_prep_addr_last_line 						:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.lp_gp_street_52004,,l.lp_gp_city_52004,l.lp_gp_state_52004,l.lp_mm_zip_52004).PrepAddrLastLine;
				self.recordorigin													:= 'T'; 
				self 																			:= [];					
	  end;

		GeneraLPartner   			  := project(FileGeneraLPartner,GeneralPartnerTransform(left));
		MapFileGeneraLPartner   := GeneraLPartner(cont_full_name<>''); //added filter here to remove any contacts that were found invalid

		//Update the "MapFileGeneraLPartner" file with the corp_legal_name from the master file.
		UpdatedLPGeneralPartner	:= join(MapFileMaster,MapFileGeneraLPartner,
																		left.corp_key = right.corp_key,
																		transform(Corp2_mapping.LayoutsCommon.Main,
																						  self.corp_legal_name := left.corp_legal_name;
																							self 								 := right;
																						 ),
																		inner,
																		local
																	 );

		AllNonMasterLPFiles			     := MapFileAssumedNames + MapLPAdmittingNames + MapLPOldNames + UpdatedLPGeneralPartner;

		//Only keep those "LP " records that has an associated "FileMaster" record.
		AllNonMasterLP			 		:= join(MapFileMaster,AllNonMasterLPFiles,
																		left.corp_key = right.corp_key,
																		transform(Corp2_mapping.LayoutsCommon.Main,
																							self := right;
																						 ),
																		inner,
																		local
																	 );

		AllMain									:= MapFileMaster + AllNonMasterLP;
		MapMain									:= dedup(sort(distribute(AllMain,hash(corp_key)),record,local),record,local) : independent;

		//********************************************************************
		// PROCESS CORPORATE ANNUAL REPORT DATA
		//********************************************************************
		Corp2_mapping.LayoutsCommon.AR  AnnualReportTransform(Corp2_Raw_IL.Layouts.LPLayoutIn l) := transform,
		skip(corp2.t2u(l.lp_date_br_mailed_52001+l.lp_date_br_filed_52001+l.lp_date_br_deliq_52001+l.lp_renewal_year_month_52001)='')
				self.corp_key															:= state_fips + '-LP-' + corp2.t2u(l.lp_file_number_52001);
				self.corp_vendor													:= state_fips;
				self.corp_state_origin										:= state_origin;			
				self.corp_process_date										:= fileDate;
				self.corp_sos_charter_nbr									:= corp2.t2u(l.lp_file_number_52001);
				self.ar_mailed_dt 												:= Corp2_mapping.fValidateDate(l.lp_date_br_mailed_52001,'CCYYMMDD').PastDate;
				self.ar_due_dt 														:= if((integer)l.lp_renewal_year_month_52001=0,'',l.lp_renewal_year_month_52001);
				self.ar_filed_dt 													:= Corp2_mapping.fValidateDate(l.lp_date_br_filed_52001,'CCYYMMDD').PastDate;
				self.ar_comment														:= 'BIENNIAL REPORT REQUIRED';			
				self.ar_deliquent_report_mail_date				:= Corp2_mapping.fValidateDate(l.lp_date_br_deliq_52001,'CCYYMMDD').PastDate;
				self 																			:= [];
	  end;
		
		AllAR									:= project(FileMaster,AnnualReportTransform(left));
		MapAR									:= dedup(sort(distribute(AllAR,hash(corp_key)),record,local),record,local) : independent;
		
		//********************************************************************
		// SCRUB AR 
		//********************************************************************	
		AR_F := MapAR;
		AR_S := Scrubs_Corp2_Mapping_IL_LP_AR.Scrubs;			// Scrubs module
		AR_N := AR_S.FromNone(AR_F); 											// Generate the error flags
		AR_T := AR_S.FromBits(AR_N.BitmapInfile);     		// Use the FromBits module; makes my bitmap datafile easier to get to
		AR_U := AR_S.FromExpanded(AR_N.ExpandedInFile); 	// Pass the expanded error flags into the Expanded module

		//Outputs reports
		AR_ErrorSummary			 	 := output(AR_U.SummaryStats, named('AR_ErrorSummary_LP_IL'+filedate));
		AR_ScrubErrorReport 	 := output(choosen(AR_U.AllErrors, 1000), named('AR_ScrubErrorReport_LP_IL'+filedate));
		AR_SomeErrorValues		 := output(choosen(AR_U.BadValues, 1000), named('AR_SomeErrorValues_LP_IL'+filedate));
		AR_IsScrubErrors		 	 := IF(count(AR_U.AllErrors)<> 0,true,false);

		// Orbit Stats
		AR_OrbitStats				 	 := AR_U.OrbitStats();

		//Outputs files
		AR_CreateBitMaps			 := output(AR_N.BitmapInfile,,'~thor_data::corp_LP_IL_ar_scrubs_bits',overwrite,compressed);	//long term storage
		AR_TranslateBitMap		 := output(AR_T);

		//Submits Profile's stats to Orbit
		AR_SubmitStats 			   := Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_IL_LP_AR','ScrubsAlerts', AR_OrbitStats, version,'Corp_IL_LP_AR').SubmitStats;
		AR_ScrubsWithExamples  := Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_IL_LP_AR','ScrubsAlerts', AR_OrbitStats, version,'Corp_IL_LP_AR').CompareToProfile_with_Examples;

		AR_ScrubsAlert				 := AR_ScrubsWithExamples(RejectWarning = 'Y');
		AR_ScrubsAttachment	   := Scrubs.fn_email_attachment(AR_ScrubsAlert);
		AR_MailFile					   := FileServices.SendEmailAttachData(corp2.Email_Notification_Lists.AttachedList
																															,'Scrubs CorpAR_LP_IL Report' //subject
																															,'Scrubs CorpAR_LP_IL Report' //body
																															,(data)AR_ScrubsAttachment
																															,'text/csv'
																															,'CorpLPILARScrubsReport.csv'																															
																															);

		AR_BadRecords				 := AR_N.ExpandedInFile(	
																								corp_key_Invalid							  			<> 0 or
																								corp_vendor_Invalid							  		<> 0 or
																								corp_state_origin_Invalid							<> 0 or
																								corp_process_date_Invalid							<> 0 or
																								corp_sos_charter_nbr_Invalid					<> 0 or
																								ar_mailed_dt_Invalid							  	<> 0 or
																								ar_due_dt_Invalid									  	<> 0 or																								
																								ar_filed_dt_Invalid							  		<> 0 or
																								ar_delinquent_dt_Invalid							<> 0
																							 );

		AR_GoodRecords			 := AR_N.ExpandedInFile(
																								corp_key_Invalid							  			= 0 and
																								corp_vendor_Invalid							  		= 0 and
																								corp_state_origin_Invalid							= 0 and
																								corp_process_date_Invalid							= 0 and
																								corp_sos_charter_nbr_Invalid					= 0 and
																								ar_mailed_dt_Invalid							  	= 0 and
																								ar_due_dt_Invalid									  	= 0 and
																								ar_filed_dt_Invalid							  		= 0 and
																								ar_delinquent_dt_Invalid							= 0
																								);

		AR_FailBuild					 := if(count(AR_GoodRecords) = 0,true,false);

		AR_ApprovedRecords		 := project(AR_GoodRecords,transform(Corp2_Mapping.LayoutsCommon.AR,self := left;));


		AR_ALL								 := sequential(IF(count(AR_BadRecords) <> 0
																								 ,IF (poverwrite
																										 ,OUTPUT(AR_BadRecords,,Corp2_Mapping._Dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::ar_lp_'+state_origin,overwrite,__compressed__)
																										 ,OUTPUT(AR_BadRecords,,Corp2_Mapping._Dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::ar_lp_'+state_origin,__compressed__)
																										 )
																								 )
																						  ,output(AR_ScrubsWithExamples, all, named('CorpARLPILScrubsReportWithExamples'+filedate))
																							//Send Alerts if Scrubs exceeds thresholds
																							,IF(COUNT(AR_ScrubsAlert) > 0, AR_MailFile, OUTPUT('CORP2_MAPPING.IL_LP - No "AR" Corp Scrubs Alerts'))
																							,AR_ErrorSummary
																							,AR_ScrubErrorReport
																							,AR_SomeErrorValues
																							,AR_SubmitStats
																					);

		//********************************************************************
		// SCRUB MAIN
		//********************************************************************	
		Main_F := MapMain;
		Main_S := Scrubs_Corp2_Mapping_IL_LP_Main.Scrubs;			// Scrubs module
		Main_N := Main_S.FromNone(Main_F); 											// Generate the error flags
		Main_T := Main_S.FromBits(Main_N.BitmapInfile);     		// Use the FromBits module; makes my bitmap datafile easier to get to
		Main_U := Main_S.FromExpanded(Main_N.ExpandedInFile); 	// Pass the expanded error flags into the Expanded module
		
		//Outputs reports
		Main_ErrorSummary					:= output(Main_U.SummaryStats, named('Main_ErrorSummary_LP_IL'+filedate));
		Main_ScrubErrorReport 		:= output(choosen(Main_U.AllErrors, 1000), named('Main_ScrubErrorReport_LP_IL'+filedate));
		Main_SomeErrorValues			:= output(choosen(Main_U.BadValues, 1000), named('Main_SomeErrorValues_LP_IL'+filedate));
		Main_IsScrubErrors		 		:= IF(count(Main_U.AllErrors)<> 0,true,false);

		// Orbit Stats
		Main_OrbitStats						:= Main_U.OrbitStats();

		//Outputs files
		Main_CreateBitMaps				:= output(Main_N.BitmapInfile,,'~thor_data::corp_LP_IL_main_scrubs_bits',overwrite,compressed);	//long term storage
		Main_TranslateBitMap			:= output(Main_T);

		//Submits Profile's stats to Orbit
		Main_SubmitStats 			    := Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_IL_LP_Main','ScrubsAlerts', Main_OrbitStats, version,'Corp_IL_LP_Main').SubmitStats;
		Main_ScrubsWithExamples   := Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_IL_LP_Main','ScrubsAlerts', Main_OrbitStats, version,'Corp_IL_LP_Main').CompareToProfile_with_Examples;

		Main_ScrubsAlert					:= Main_ScrubsWithExamples(RejectWarning = 'Y');
		Main_ScrubsAttachment			:= Scrubs.fn_email_attachment(Main_ScrubsAlert);
		Main_MailFile							:= FileServices.SendEmailAttachData(corp2.Email_Notification_Lists.AttachedList
																																 ,'Scrubs CorpMain_LP_IL Report' //subject
																																 ,'Scrubs CorpMain_LP_IL Report' //body
																																 ,(data)Main_ScrubsAttachment
																																 ,'text/csv'
																																 ,'CorpLPILMainScrubsReport.csv'
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
																											 corp_address1_type_cd_Invalid 					<> 0 or
																											 corp_address1_type_desc_Invalid 				<> 0 or
																											 corp_address1_line3_Invalid						<> 0 or
																											 corp_filing_date_Invalid								<> 0 or
																											 corp_filing_cd_Invalid									<> 0 or
																											 corp_filing_desc_Invalid								<> 0 or
																											 corp_status_cd_Invalid									<> 0 or
																											 corp_status_desc_Invalid								<> 0 or
																											 corp_status_date_Invalid								<> 0 or
																											 corp_inc_state_Invalid 								<> 0 or
																											 corp_inc_county_Invalid 								<> 0 or
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
																											 corp_orig_bus_type_cd_Invalid 					<> 0 or
																											 corp_ra_effective_date_Invalid 				<> 0 or
																											 corp_ra_address_type_cd_Invalid			  <> 0 or
																											 corp_ra_address_type_desc_Invalid			<> 0 or
																											 corp_ra_address_line3_Invalid					<> 0 or
																											 cont_effective_date_Invalid						<> 0 or
																											 cont_address_type_cd_Invalid						<> 0 or
																											 cont_address_type_desc_Invalid			  	<> 0 or
																											 corp_agent_county_Invalid					  	<> 0 or
																											 corp_country_of_formation_Invalid			<> 0 or
																											 corp_merger_date_Invalid			  				<> 0 or
																											 corp_name_effective_date_Invalid			  <> 0 or
																											 corp_name_status_date_Invalid			  	<> 0 or
																											 recordorigin_Invalid					 					<> 0
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
																											 corp_address1_type_cd_Invalid 					= 0 and
																											 corp_address1_type_desc_Invalid 				= 0 and
																											 corp_address1_line3_Invalid						= 0 and
																											 corp_filing_date_Invalid								= 0 and
																											 corp_filing_cd_Invalid									= 0 and
																											 corp_filing_desc_Invalid								= 0 and
																											 corp_status_cd_Invalid									= 0 and
																											 corp_status_desc_Invalid								= 0 and																										 
																											 corp_status_date_Invalid								= 0 and
																											 corp_inc_state_Invalid 								= 0 and
																											 corp_inc_county_Invalid								= 0 and
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
																											 corp_orig_bus_type_cd_Invalid 					= 0 and
																											 corp_ra_effective_date_Invalid 				= 0 and
																											 corp_ra_address_type_cd_Invalid			  = 0 and
																											 corp_ra_address_type_desc_Invalid			= 0 and
																											 corp_ra_address_line3_Invalid					= 0 and
																											 cont_effective_date_Invalid						= 0 and
																											 cont_address_type_cd_Invalid			  		= 0 and
																											 cont_address_type_desc_Invalid			  	= 0 and
																											 corp_agent_county_Invalid					  	= 0 and
																											 corp_country_of_formation_Invalid			= 0 and
																											 corp_merger_date_Invalid			  				= 0 and
																											 corp_name_effective_date_Invalid			  = 0 and
																											 corp_name_status_date_Invalid			  	= 0 and
																											 recordorigin_Invalid					 					= 0																									 
																								  );

		Main_FailBuild					:= map( corp2_mapping.fCalcPercent(count(Main_N.ExpandedInFile(corp_key_invalid<>0)),count(Main_N.ExpandedInFile),false) 										> Scrubs_Corp2_Mapping_IL_LP_Main.Threshold_Percent.CORP_KEY										 => true,
																		corp2_mapping.fCalcPercent(count(Main_N.ExpandedInFile(corp_orig_sos_charter_nbr_invalid<>0)),count(Main_N.ExpandedInFile),false) 	> Scrubs_Corp2_Mapping_IL_LP_Main.Threshold_Percent.CORP_ORIG_SOS_CHARTER_NBR 	 => true,
																		corp2_mapping.fCalcPercent(count(Main_N.ExpandedInFile(corp_legal_name_invalid<>0)),count(Main_N.ExpandedInFile),false) 						> Scrubs_Corp2_Mapping_IL_LP_Main.Threshold_Percent.CORP_LEGAL_NAME 						 => true,
																		corp2_mapping.fCalcPercent(count(Main_N.ExpandedInFile(corp_inc_date_invalid<>0)),count(Main_N.ExpandedInFile),false) 							> Scrubs_Corp2_Mapping_IL_LP_Main.Threshold_Percent.CORP_INC_DATE 						 	 => true,
																	  count(Main_GoodRecords) = 0																																																																																											 => true,																		
																		false
																	);

		Main_ApprovedRecords		:= project(Main_GoodRecords,transform(Corp2_Mapping.LayoutsCommon.Main,self := left));


		Main_ALL		 			:= sequential( IF(count(Main_BadRecords) <> 0
																							,IF (poverwrite
																									,OUTPUT(Main_BadRecords,,Corp2_Mapping._Dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::main_lp_'+state_origin,overwrite,__compressed__)
																									,OUTPUT(Main_BadRecords,,Corp2_Mapping._Dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::main_lp_'+state_origin,__compressed__)
																									)
																							)
																					,output(Main_ScrubsWithExamples, all, named('CorpMainLPILScrubsReportWithExamples'+filedate))
																					//Send Alerts if Scrubs exceeds thresholds
																					,IF(COUNT(Main_ScrubsAlert) > 0, Main_MailFile, OUTPUT('CORP2_MAPPING.IL_LP - No "MAIN" Corp Scrubs Alerts'))
																					,Main_ErrorSummary
																					,Main_ScrubErrorReport
																					,Main_SomeErrorValues		
																					,Main_SubmitStats
																			);
																			
		//********************************************************************
		// UPDATE
		//********************************************************************
		Fail_Build						:= IF(AR_FailBuild = true or Main_FailBuild = true,true,false);
		IsScrubErrors					:= IF(AR_IsScrubErrors = true or Main_IsScrubErrors = true,true,false);

		VersionControl.macBuildNewLogicalFile(Corp2_Mapping._dataset().thor_cluster_Files + 'in::corp2::' 	+ version + '::ar_lp_' + state_origin, AR_ApprovedRecords	 , write_ar,,,pOverwrite);
		VersionControl.macBuildNewLogicalFile(Corp2_Mapping._dataset().thor_cluster_Files + 'in::corp2::' 	+ version + '::main_lp_' + state_origin, Main_ApprovedRecords , write_main,,,pOverwrite);

		VersionControl.macBuildNewLogicalFile(Corp2_Mapping._dataset().thor_cluster_Files + 'fail::corp2::' + version + '::ar_lp_' + state_origin, AR_F, write_fail_ar,,,pOverwrite);
		VersionControl.macBuildNewLogicalFile(Corp2_Mapping._dataset().thor_cluster_Files + 'fail::corp2::' + version + '::main_lp_' + state_origin, Main_F, write_fail_main,,,pOverwrite);

		mapIL_LP 	:= sequential (if(pshouldspray = true,Corp2_mapping.fSprayFiles(state_origin+'_LP',version,pOverwrite := pOverwrite))
															// ,Corp2_Raw_IL.Build_Bases_LP(filedate,version,puseprod).All  // Determined build bases is not needed
															,AR_All
															,Main_All
															,if(Fail_Build <> true	 
																 ,sequential (write_ar
																						 ,write_main
																						 ,fileservices.addsuperfile(Corp2_Mapping._Dataset().thor_cluster_Files + 'in::'+Corp2_Mapping._Dataset().NameMapped +'::sprayed::ar'		,Corp2_Mapping._Dataset().thor_cluster_Files + 'in::corp2::'+version+'::ar_lp_'		+ state_origin)
																						 ,fileservices.addsuperfile(Corp2_Mapping._Dataset().thor_cluster_Files + 'in::'+Corp2_Mapping._Dataset().NameMapped +'::sprayed::main'	,Corp2_Mapping._Dataset().thor_cluster_Files + 'in::corp2::'+version+'::main_lp_'	+ state_origin)																		 
																						 ,if (count(Main_BadRecords) <> 0 or count(AR_BadRecords) <> 0
																								 ,Corp2_Mapping.Send_Email(state_origin+'_LP',version,count(Main_BadRecords)<>0,count(AR_BadRecords)<>0,,,count(Main_BadRecords),count(AR_BadRecords),,,count(Main_ApprovedRecords),count(AR_ApprovedRecords)).RecordsRejected																				 
																								 ,Corp2_Mapping.Send_Email(state_origin+'_LP',version,count(Main_BadRecords)<>0,count(AR_BadRecords)<>0,,,count(Main_BadRecords),count(AR_BadRecords),,,count(Main_ApprovedRecords),count(AR_ApprovedRecords)).MappingSuccess
																								 )
																						 ,if (IsScrubErrors
																								 ,Corp2_Mapping.Send_Email(state_origin+'_LP',version,Main_IsScrubErrors,AR_IsScrubErrors).FieldsInvalidPerScrubs
																								 )
																						 ) //if Fail_Build <> true																			
																 ,sequential (write_fail_ar
																						 ,write_fail_main
																						 ,Corp2_Mapping.Send_Email(state_origin+'_LP',version).MappingFailed
																						 ) //if Fail_Build = true
																 )
														);
			
		isFileDateValid := if((string)std.date.today() between ut.date_math(filedate,-30) and ut.date_math(filedate,30),true,false);
		
		return sequential (	 if (isFileDateValid
														,mapIL_LP
														,sequential (Corp2_Mapping.Send_Email(state_origin+'_LP',filedate).InvalidFileDateParm
																				,FAIL('Corp2_Mapping.'+state_origin+'_LP failed.  An invalid filedate was passed in as a parameter.')
																				)
														)
											);
										
	end;	// end of Update function
 	
end; //end IL_LP