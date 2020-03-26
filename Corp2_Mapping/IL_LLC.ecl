import address,corp2,corp2_raw_il,scrubs,scrubs_corp2_mapping_il_llc_ar,scrubs_corp2_mapping_il_llc_main,std,tools,ut,versioncontrol;

export IL_LLC := module 

	 export Update(string fileDate, string version, boolean pShouldSpray = _Dataset().bShouldSpray, boolean pOverwrite = false, boolean pUseProd = Tools._Constants.IsDataland) := Function

		state_origin			 				:= 'IL';
		state_fips	 				 			:= '17';
		state_desc	 			 				:= 'ILLINOIS';
		
		FileMaster								:= dedup(sort(distribute(Corp2_Raw_IL.files(fileDate,puseprod).Input.LLC.Master,hash(ll_file_nbr_42001)),record,local),record,local) : independent;
		FileAssumedNames					:= dedup(sort(distribute(Corp2_Raw_IL.files(fileDate,puseprod).Input.LLC.AssumedNames,hash(ll_file_nbr_42006)),record,local),record,local) : independent;
		FileManagerMember					:= dedup(sort(distribute(Corp2_Raw_IL.files(fileDate,puseprod).Input.LLC.ManagerMember,hash(ll_file_nbr_42008)),record,local),record,local) : independent;
		FileOldNames							:= dedup(sort(distribute(Corp2_Raw_IL.files(fileDate,puseprod).Input.LLC.OldNames,hash(ll_file_nbr_42007)),record,local),record,local) : independent;

		//********************************************************************
		// PROCESS CORPORATE (MASTER) DATA
		//********************************************************************
		Corp2_mapping.LayoutsCommon.Main MasterTransform(Corp2_Raw_IL.Layouts.LLCMasterLayoutIn l) := transform																												
				self.dt_vendor_first_reported							:= (integer)fileDate;
				self.dt_vendor_last_reported							:= (integer)fileDate;
				self.dt_first_seen												:= (integer)fileDate;
				self.dt_last_seen													:= (integer)fileDate;
				self.corp_ra_dt_first_seen								:= (integer)fileDate;
				self.corp_ra_dt_last_seen									:= (integer)fileDate;			
				self.corp_key															:= state_fips + '-LLC-' + corp2.t2u(l.ll_file_nbr_42001);
				self.corp_vendor													:= state_fips;
				self.corp_state_origin										:= state_origin;			
				self.corp_process_date										:= fileDate;
				self.corp_orig_sos_charter_nbr        		:= corp2.t2u(l.ll_file_nbr_42001);
				self.corp_legal_name                  		:= Corp2_mapping.fCleanBusinessName(state_origin,state_desc,l.ll_llc_name_42001).BusinessName;
				self.corp_ln_name_type_cd 								:= '01';
				self.corp_ln_name_type_desc 							:= 'LEGAL';
				tempCorpAddress 													:= Address.CleanAddress182(l.ll_records_off_street_42001,l.ll_records_off_zip_42001); //used to get state				
				self.corp_address1_type_cd 								:= if(Corp2_Mapping.fAddressExists(state_origin,state_desc,l.ll_records_off_street_42001,,l.ll_records_off_city_42001,tempCorpAddress[115..116],l.ll_records_off_zip_42001).ifAddressExists,'B','');
				self.corp_address1_type_desc							:= if(Corp2_Mapping.fAddressExists(state_origin,state_desc,l.ll_records_off_street_42001,,l.ll_records_off_city_42001,tempCorpAddress[115..116],l.ll_records_off_zip_42001).ifAddressExists,'BUSINESS','');				
				self.corp_address1_line1									:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.ll_records_off_street_42001,,l.ll_records_off_city_42001,tempCorpAddress[115..116],l.ll_records_off_zip_42001).AddressLine1;
				self.corp_address1_line2									:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.ll_records_off_street_42001,,l.ll_records_off_city_42001,tempCorpAddress[115..116],l.ll_records_off_zip_42001).AddressLine2;
				self.corp_address1_line3									:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.ll_records_off_street_42001,,l.ll_records_off_city_42001,tempCorpAddress[115..116],l.ll_records_off_zip_42001).AddressLine3;
				self.corp_status_cd 											:= corp2.t2u(l.ll_status_code_42001); //scrub
				self.corp_status_desc 										:= Corp2_Raw_IL.Functions_LLC.CorpStatusDesc(l.ll_status_code_42001);
				self.corp_status_date 										:= Corp2_mapping.fValidateDate(l.ll_status_date_42001,'CCYYMMDD').PastDate;
				self.corp_standing												:= map(corp2.t2u(l.ll_status_code_42001) in ['00'] => 'Y',
																												 corp2.t2u(l.ll_status_code_42001) in ['02'] => 'N',
																												 ''
																											  );
				self.corp_inc_state												:= state_origin;			
				self.corp_inc_date 												:= if(corp2.t2u(l.ll_juris_organized_42001) in ['',state_origin],Corp2_mapping.fValidateDate(l.ll_organized_date_42001,'CCYYMMDD').PastDate,'');
				self.corp_fed_tax_id											:= Corp2_Raw_IL.Functions_LLC.CorpFedTaxID(l.ll_fein_42001);
				self.corp_term_exist_cd 									:= map(corp2.t2u(l.ll_dissolution_date_42001)<>'' and Corp2_mapping.fValidateDate(l.ll_dissolution_date_42001,'CCYYMMDD').GeneralDate<>'' => 'D',
																												 corp2.t2u(l.ll_dissolution_date_42001)=''  																																											  => 'P',
																												 Corp2_mapping.fValidateDate(l.ll_dissolution_date_42001,'CCYYMMDD').GeneralDate=''				  																				=> 'P',
																												 ''
																												 );
				self.corp_term_exist_exp 									:= Corp2_mapping.fValidateDate(l.ll_dissolution_date_42001,'CCYYMMDD').GeneralDate;
				self.corp_term_exist_desc 								:= map(self.corp_term_exist_cd = 'D' => 'EXPIRATION DATE',
																												 self.corp_term_exist_cd = 'P' => 'PERPETUAL',
																												 ''
																												);
				self.corp_foreign_domestic_ind 						:= if(corp2.t2u(l.ll_juris_organized_42001) in ['',state_origin],'D','F');
				self.corp_forgn_state_cd 									:= if(corp2.t2u(l.ll_juris_organized_42001) in ['',state_origin],'',Corp2_Raw_IL.Functions_LLC.State_Foreign_Codes(l.ll_juris_organized_42001));
				self.corp_forgn_state_desc 								:= if(corp2.t2u(l.ll_juris_organized_42001) in ['',state_origin],'',Corp2_Raw_IL.Functions_LLC.CorpForgnStateDesc(l.ll_juris_organized_42001));
				self.corp_forgn_date	 										:= if(corp2.t2u(l.ll_juris_organized_42001) in ['',state_origin],'',Corp2_mapping.fValidateDate(l.ll_organized_date_42001,'CCYYMMDD').PastDate);		
				self.corp_orig_org_structure_desc 				:= 'LIMITED LIABILITY COMPANY';
				self.corp_addl_info												:= Corp2_Raw_IL.Functions_LLC.CorpAddlInfo(l.ll_provisions_ind_42001,l.ll_opt_ind_42001);																												
				self.corp_ra_full_name										:= map(regexfind('(\\*)*( )*AGENT( )*VACATED( )*(\\*)*',corp2.t2u(l.ll_agent_name_42001),0)<>'' => Corp2_mapping.fCleanBusinessName(state_origin,state_desc,regexreplace('(\\*)*( )*AGENT( )*VACATED( )*(\\*)*',corp2.t2u(l.ll_agent_name_42001),'')).BusinessName,
																												 Corp2_mapping.fCleanBusinessName(state_origin,state_desc,l.ll_agent_name_42001).BusinessName
																												);			
				tempRAAddress 														:= Address.CleanAddress182(l.ll_agent_street_42001,l.ll_agent_zip_42001); //used to get state				
				self.corp_ra_address_type_cd 							:= if(Corp2_Mapping.fAddressExists(state_origin,state_desc,l.ll_agent_street_42001,,l.ll_agent_city_42001,tempRAAddress[115..116],l.ll_agent_zip_42001).ifAddressExists,'R','');
				self.corp_ra_address_type_desc						:= if(Corp2_Mapping.fAddressExists(state_origin,state_desc,l.ll_agent_street_42001,,l.ll_agent_city_42001,tempRAAddress[115..116],l.ll_agent_zip_42001).ifAddressExists,'REGISTERED OFFICE','');
				self.corp_ra_address_line1								:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.ll_agent_street_42001,,l.ll_agent_city_42001,tempRAAddress[115..116],l.ll_agent_zip_42001).AddressLine1;
				self.corp_ra_address_line2								:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.ll_agent_street_42001,,l.ll_agent_city_42001,tempRAAddress[115..116],l.ll_agent_zip_42001).AddressLine2;
				self.corp_ra_address_line3								:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.ll_agent_street_42001,,l.ll_agent_city_42001,tempRAAddress[115..116],l.ll_agent_zip_42001).AddressLine3;
				self.corp_ra_effective_date					  		:= Corp2_mapping.fValidateDate(l.ll_agent_chg_date_42001,'CCYYMMDD').GeneralDate;
				self.corp_prep_addr1_line1      					:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.ll_records_off_street_42001,'',l.ll_records_off_city_42001,tempCorpAddress[115..116],l.ll_records_off_zip_42001).PrepAddrLine1;
				self.corp_prep_addr1_last_line 						:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.ll_records_off_street_42001,'',l.ll_records_off_city_42001,tempCorpAddress[115..116],l.ll_records_off_zip_42001).PrepAddrLastLine;
				self.ra_prep_addr_line1										:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.ll_agent_street_42001,'',l.ll_agent_city_42001,tempRAAddress[115..116],l.ll_agent_zip_42001).PrepAddrLine1;
				self.ra_prep_addr_last_line								:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.ll_agent_street_42001,'',l.ll_agent_city_42001,tempRAAddress[115..116],l.ll_agent_zip_42001).PrepAddrLastLine;
				self.corp_agent_county										:= Corp2_Raw_IL.Functions_LLC.CorpAgentCounty(l.ll_agent_cnty_code_42001);
				self.corp_country_of_formation						:= if(Corp2_Raw_IL.Functions_LLC.CorpCountryOfFormation(l.ll_juris_organized_42001)[1..2]<>'**',
																												Corp2_Mapping.fCleanCountry(state_origin,state_desc,,Corp2_Raw_IL.Functions_LLC.CorpCountryOfFormation(l.ll_juris_organized_42001)).Country,
																												''
																											 );
				self.corp_llc_managed_ind									:= corp2.t2u(l.ll_management_type_42001);
				self.corp_llc_managed_desc								:= map(corp2.t2u(l.ll_management_type_42001) = '0' => 'NO TYPE SELECTED (FOREIGN ONLY)',
																												 corp2.t2u(l.ll_management_type_42001) = '1' => 'MEMBER MANAGED',
																												 corp2.t2u(l.ll_management_type_42001) = '2' => 'MANAGER MANAGED',
																												 corp2.t2u(l.ll_management_type_42001) = '3' => 'MEMBER AND MANAGER MANAGED',
																												 ''
																												);
				self.corp_opt_in_llc_act_ind							:= if(corp2.t2u(l.ll_opt_ind_42001) in ['0','1'],corp2.t2u(l.ll_opt_ind_42001),'');		
				self.corp_opt_in_llc_act_desc							:= map(corp2.t2u(l.ll_opt_ind_42001) = '0' => 'DID NOT OPT IN TO THE NEW LLC ACT OF 1/1/1998',
																												 corp2.t2u(l.ll_opt_ind_42001) = '1' => 'OPTED IN TO THE NEW LLC ACT OF 1/1/1998',				
																												 ''
																												);
				self.recordorigin													:= 'C';																												
				self 																			:= [];
		end;
  
		MapFileMaster						:= project(FileMaster,MasterTransform(left));
		
		
		jFileAssumedNames	:= join(FileAssumedNames, FileMaster, 
															left.ll_file_nbr_42006 = right.ll_file_nbr_42001,
															transform(Corp2_Raw_IL.Layouts.LLCAssumedNames_TempLay, 
																				 self.ll_juris_organized_42001  := right.ll_juris_organized_42001;
																				 self.ll_organized_date_42001 	:= right.ll_organized_date_42001;
																				 self := left; self := right; self := [];),
															left outer,local) : independent;
											
		Corp2_mapping.LayoutsCommon.Main AssumedNamesMainTransform(Corp2_Raw_IL.Layouts.LLCAssumedNames_TempLay l) := transform
				self.dt_vendor_first_reported							:= (integer)fileDate;
				self.dt_vendor_last_reported							:= (integer)fileDate;
				self.dt_first_seen												:= (integer)fileDate;
				self.dt_last_seen													:= (integer)fileDate;
				self.corp_ra_dt_first_seen								:= (integer)fileDate;
				self.corp_ra_dt_last_seen									:= (integer)fileDate;			
				self.corp_key															:= state_fips + '-LLC-' + corp2.t2u(l.ll_file_nbr_42006);
				self.corp_vendor													:= state_fips;
				self.corp_state_origin										:= state_origin;			
				self.corp_process_date										:= fileDate;
				self.corp_orig_sos_charter_nbr        		:= corp2.t2u(l.ll_file_nbr_42006);
				self.corp_legal_name                  		:= Corp2_mapping.fCleanBusinessName(state_origin,state_desc,l.ll_llc_name_42006).BusinessName;
				self.corp_ln_name_type_cd 								:= '06';
				self.corp_ln_name_type_desc 							:= map(corp2.t2u(l.ll_assumed_ind_42006) = '0' => 'ASSUMED NAME',
																												 corp2.t2u(l.ll_assumed_ind_42006) = '1' => 'FOREIGN ASSUMED NAME',
																												 ''
																												);
				self.corp_inc_state												:= state_origin;
				//overloaded field; can be removed after corp_name_effect_date, corp_name_status_date & corp_name_status_desc is customer facing
				self.corp_name_comment										:= Corp2_Raw_IL.Functions_LLC.CorpNameComment(l.ll_assumed_can_date_42006,l.ll_assumed_can_code_42006,l.ll_assumed_adopt_date_42006,l.ll_assumed_renew_date_42006);
				self.corp_name_effective_date							:= Corp2_mapping.fValidateDate(l.ll_assumed_adopt_date_42006,'CCYYMMDD').GeneralDate;
				self.corp_name_status_date								:= Corp2_mapping.fValidateDate(l.ll_assumed_renew_date_42006,'CCYYMMDD').GeneralDate;
				self.corp_name_status_desc								:= if(self.corp_name_status_date<>'','RENEW DATE','');
				self.corp_inc_date 												:= if(corp2.t2u(l.ll_juris_organized_42001) in ['',state_origin],Corp2_mapping.fValidateDate(l.ll_organized_date_42001,'CCYYMMDD').PastDate,'');
				self.corp_forgn_date	 										:= if(corp2.t2u(l.ll_juris_organized_42001) in ['',state_origin],'',Corp2_mapping.fValidateDate(l.ll_organized_date_42001,'CCYYMMDD').PastDate);		
				self.recordorigin													:= 'C';				
				self 																			:= [];
		end;

		MapFileAssumedNames				:= project(jFileAssumedNames,AssumedNamesMainTransform(left));


		jFileOldNames	    := join(FileOldNames, FileMaster, 
															left.ll_file_nbr_42007 = right.ll_file_nbr_42001,
															transform(Corp2_Raw_IL.Layouts.LLCOldNames_TempLay, 
																				 self.ll_juris_organized_42001  := right.ll_juris_organized_42001;
																				 self.ll_organized_date_42001 	:= right.ll_organized_date_42001;
																				 self := left; self := right; self := [];),
															left outer,local) : independent;
															
		Corp2_mapping.LayoutsCommon.Main OldNamesMainTransform(Corp2_Raw_IL.Layouts.LLCOldNames_TempLay l) := transform
				self.dt_vendor_first_reported							:= (integer)fileDate;
				self.dt_vendor_last_reported							:= (integer)fileDate;
				self.dt_first_seen												:= (integer)fileDate;
				self.dt_last_seen													:= (integer)fileDate;
				self.corp_ra_dt_first_seen								:= (integer)fileDate;
				self.corp_ra_dt_last_seen									:= (integer)fileDate;			
				self.corp_key															:= state_fips + '-LLC-' + corp2.t2u(l.ll_file_nbr_42007);
				self.corp_vendor													:= state_fips;
				self.corp_state_origin										:= state_origin;			
				self.corp_process_date										:= fileDate;
				self.corp_orig_sos_charter_nbr        		:= corp2.t2u(l.ll_file_nbr_42007);	
				self.corp_legal_name                  		:= Corp2_mapping.fCleanBusinessName(state_origin,state_desc,l.ll_llc_name_42007).BusinessName;
				self.corp_ln_name_type_cd 								:= 'P';
				self.corp_ln_name_type_desc 							:= 'PRIOR';
				self.corp_inc_state												:= state_origin;
				//corp_name_comment is an overloaded field.  This can be removed after corp_name_effective_date is customer facing.
				self.corp_name_comment 										:= if(Corp2_mapping.fValidateDate(l.ll_old_date_filed_42007,'CCYYMMDD').PastDate<>'',
																												'OLD NAME FILED: '+ut.date_YYYYMMDDtoDateSlashed(l.ll_old_date_filed_42007),
																												''
																											 );
				self.corp_name_effective_date							:= Corp2_mapping.fValidateDate(l.ll_old_date_filed_42007,'CCYYMMDD').GeneralDate;
				self.corp_inc_date 												:= if(corp2.t2u(l.ll_juris_organized_42001) in ['',state_origin],Corp2_mapping.fValidateDate(l.ll_organized_date_42001,'CCYYMMDD').PastDate,'');
				self.corp_forgn_date	 										:= if(corp2.t2u(l.ll_juris_organized_42001) in ['',state_origin],'',Corp2_mapping.fValidateDate(l.ll_organized_date_42001,'CCYYMMDD').PastDate);		
				self.recordorigin													:= 'C';				
				self 																			:= [];
		end;
		
		MapFileOldNames				:= project(jFileOldNames,OldNamesMainTransform(left));

		AllCorpLLCFiles			  := MapFileAssumedNames + MapFileOldNames;

		//Only keep those "LLC" records that has an associated "FileMaster" record.
		AllCorpMasterLLC 			:= join(MapFileMaster,AllCorpLLCFiles,
																	left.corp_key = right.corp_key,
																	transform(Corp2_mapping.LayoutsCommon.Main,
																						self.corp_legal_name 					:= if(right.corp_legal_name = '',left.corp_legal_name,right.corp_legal_name);
																						self.corp_ln_name_type_cd 		:= if(right.corp_ln_name_type_cd = '',left.corp_ln_name_type_cd,right.corp_ln_name_type_cd);
																						self.corp_ln_name_type_desc 	:= if(right.corp_ln_name_type_desc = '',left.corp_ln_name_type_desc,right.corp_ln_name_type_desc);
																						self.corp_address1_type_cd 		:= if(right.corp_address1_type_cd = '',left.corp_address1_type_cd,right.corp_address1_type_cd);
																						self.corp_address1_type_desc 	:= if(right.corp_address1_type_desc = '',left.corp_address1_type_desc,right.corp_address1_type_desc);
																						self.corp_address1_line1 			:= if(right.corp_address1_line1 = '',left.corp_address1_line1,right.corp_address1_line1);
																						self.corp_address1_line2 			:= if(right.corp_address1_line2 = '',left.corp_address1_line2,right.corp_address1_line2);
																						self.corp_address1_line3 			:= if(right.corp_address1_line3 = '',left.corp_address1_line3,right.corp_address1_line3);
																						self.corp_prep_addr1_last_line:= if(right.corp_prep_addr1_last_line = '',left.corp_prep_addr1_last_line,right.corp_prep_addr1_last_line);
																						self.corp_prep_addr1_line1		:= if(right.corp_prep_addr1_line1 = '',left.corp_prep_addr1_line1,right.corp_prep_addr1_line1);
																						self 								 					:= right;
																					 ),
																	inner,
																	local
																 );

		Corp2_mapping.LayoutsCommon.Main ManagerMemberMainTransform(Corp2_Raw_IL.Layouts.LLCManagerMemberLayoutIn l) := transform,
		skip(Corp2_mapping.fCleanBusinessName(state_origin,state_desc,l.ll_mm_name_42008).BusinessName = '')
				self.dt_vendor_first_reported							:= (integer)fileDate;
				self.dt_vendor_last_reported							:= (integer)fileDate;
				self.dt_first_seen												:= (integer)fileDate;
				self.dt_last_seen													:= (integer)fileDate;
				self.corp_ra_dt_first_seen								:= (integer)fileDate;
				self.corp_ra_dt_last_seen									:= (integer)fileDate;			
				self.corp_key															:= state_fips + '-LLC-' + corp2.t2u(l.ll_file_nbr_42008);
				self.corp_vendor													:= state_fips;
				self.corp_state_origin										:= state_origin;			
				self.corp_process_date										:= fileDate;
				self.corp_orig_sos_charter_nbr        		:= corp2.t2u(l.ll_file_nbr_42008);
				self.corp_legal_name                  		:= ''; //mapped in join below
				self.corp_inc_state												:= state_origin;
				self.cont_type_cd 												:= 'M';
				self.cont_type_desc					 							:= 'MEMBER/MANAGER/PARTNER';				
				self.cont_full_name                  			:= Corp2_mapping.fCleanBusinessName(state_origin,state_desc,l.ll_mm_name_42008).BusinessName;
				self.cont_title1_desc											:= map(corp2.t2u(l.ll_mm_type_code_42008) = '1' => 'MANAGER',
																												 corp2.t2u(l.ll_mm_type_code_42008) = '2' => 'MEMBER',
																												 corp2.t2u(l.ll_mm_type_code_42008) = '3' => 'BOTH A MANAGER AND A MEMBER',
																												 ''
																												);				
				self.cont_effective_date									:= Corp2_mapping.fValidateDate(l.ll_mm_file_date_42008,'CCYYMMDD').GeneralDate;
				self.cont_effective_desc									:= if(self.cont_effective_date<>'','FILING DATE','');
				tempContactAddress												:= Address.CleanAddress182(l.ll_mm_street_42008,l.ll_mm_zip_42008); //used to get state				
				self.cont_address_type_cd 								:= if(Corp2_Mapping.fAddressExists(state_origin,state_desc,l.ll_mm_street_42008,,l.ll_mm_city_42008,tempContactAddress[115..116],l.ll_mm_zip_42008).ifAddressExists,'T','');
				self.cont_address_type_desc								:= if(Corp2_Mapping.fAddressExists(state_origin,state_desc,l.ll_mm_street_42008,,l.ll_mm_city_42008,tempContactAddress[115..116],l.ll_mm_zip_42008).ifAddressExists,'CONTACT','');
				self.cont_address_line1										:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.ll_mm_street_42008,,l.ll_mm_city_42008,tempContactAddress[115..116],l.ll_mm_zip_42008).AddressLine1;
				self.cont_address_line2										:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.ll_mm_street_42008,,l.ll_mm_city_42008,tempContactAddress[115..116],l.ll_mm_zip_42008).AddressLine2;
				self.cont_address_line3										:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.ll_mm_street_42008,,l.ll_mm_city_42008,tempContactAddress[115..116],l.ll_mm_zip_42008).AddressLine3;
				self.cont_country													:= if(Corp2_Mapping.fCleanCountry(state_origin,state_desc,,l.ll_mm_juris_42008).Country not in ['US',''],
																												Corp2_Mapping.fCleanCountry(state_origin,state_desc,,l.ll_mm_juris_42008).Country,
																												''
																											 );
				self.cont_prep_addr_line1     						:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.ll_mm_street_42008,,l.ll_mm_city_42008,tempContactAddress[115..116],l.ll_mm_zip_42008).PrepAddrLine1;
				self.cont_prep_addr_last_line 						:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.ll_mm_street_42008,,l.ll_mm_city_42008,tempContactAddress[115..116],l.ll_mm_zip_42008).PrepAddrLastLine;			
				self.recordorigin													:= 'T';				
				self 																			:= [];
		end;

		MapFileManagerMember		   	  := project(FileManagerMember,ManagerMemberMainTransform(left));

		//Only keep those "LLC" contact records that has an associated "FileMaster" record.
		AllContMasterLLC				 			:= join(MapFileMaster,MapFileManagerMember,
																					left.corp_key = right.corp_key,
																					transform(Corp2_mapping.LayoutsCommon.Main,
																										self.corp_legal_name 					:= if(right.corp_legal_name = '',left.corp_legal_name,right.corp_legal_name);
																										self 								 					:= right;
																									 ),
																					inner,
																					local
																				 );
															
		AllMain												:= MapFileMaster + AllCorpMasterLLC + AllContMasterLLC;
		MapMain												:= dedup(sort(distribute(AllMain,hash(corp_key)),record,local),record,local) : independent;

		//********************************************************************
		// PROCESS CORPORATE ANNUAL REPORT DATA
		//********************************************************************    
		Corp2_mapping.LayoutsCommon.AR  ARTransform(Corp2_Raw_IL.Layouts.LLCMasterLayoutIn l, integer c) := transform,
		skip(c = 1 and corp2.t2u(l.ll_cr_ar_mail_date_42001+l.ll_cr_ar_file_date_42001+l.ll_cr_ar_deliq_date_42001+l.ll_cr_ar_paid_amt_42001+l.ll_cr_ar_year_due_42001)='' or
				 c = 2 and corp2.t2u(l.ll_pv_ar_mail_date_42001+l.ll_pv_ar_file_date_42001+l.ll_pv_ar_deliq_date_42001+l.ll_pv_ar_paid_amt_42001+l.ll_pv_ar_year_due_42001)='')
				self.corp_key															:= state_fips + '-LLC-' + corp2.t2u(l.ll_file_nbr_42001);
				self.corp_vendor													:= state_fips;
				self.corp_state_origin										:= state_origin;			
				self.corp_process_date										:= fileDate;
				self.corp_sos_charter_nbr									:= corp2.t2u(l.ll_file_nbr_42001);
				self.ar_mailed_dt 												:= choose(c,Corp2_mapping.fValidateDate(l.ll_cr_ar_mail_date_42001,'CCYYMMDD').PastDate,
																															Corp2_mapping.fValidateDate(l.ll_pv_ar_mail_date_42001,'CCYYMMDD').PastDate
																														);
				self.ar_due_dt 														:= choose(c,if((integer)l.ll_cr_ar_year_due_42001=0,'',(string)(integer)l.ll_cr_ar_year_due_42001),
																															if((integer)l.ll_pv_ar_year_due_42001=0,'',(string)(integer)l.ll_pv_ar_year_due_42001)
																														);
				self.ar_filed_dt 													:= choose(c,Corp2_mapping.fValidateDate(l.ll_cr_ar_file_date_42001,'CCYYMMDD').PastDate,
																															Corp2_mapping.fValidateDate(l.ll_pv_ar_file_date_42001,'CCYYMMDD').PastDate
																														);
				self.ar_delinquent_dt 										:= choose(c,Corp2_mapping.fValidateDate(l.ll_cr_ar_deliq_date_42001,'CCYYMMDD').GeneralDate,
																															Corp2_mapping.fValidateDate(l.ll_pv_ar_deliq_date_42001,'CCYYMMDD').GeneralDate
																														);
				self.ar_amount_paid												:= choose(c,if((integer)l.ll_cr_ar_paid_amt_42001=0,'','$'+(string)(integer)l.ll_cr_ar_paid_amt_42001),
																															if((integer)l.ll_pv_ar_paid_amt_42001=0,'','$'+(string)(integer)l.ll_pv_ar_paid_amt_42001)
																														);
				self.ar_type 															:= choose(c,'CURRENT',
																															'PREVIOUS'
																													 );
				self 																			:= [];
	  end;

		FileLLCAnnualReport  := FileMaster(corp2.t2u(ll_cr_ar_mail_date_42001+ll_cr_ar_file_date_42001+ll_cr_ar_deliq_date_42001+ll_cr_ar_paid_amt_42001+ll_cr_ar_year_due_42001 +
																								 ll_pv_ar_mail_date_42001+ll_pv_ar_file_date_42001+ll_pv_ar_deliq_date_42001+ll_pv_ar_paid_amt_42001+ll_pv_ar_year_due_42001)<>'');

		MapLLCAR 						 := normalize(FileLLCAnnualReport,2,ARTransform(left,counter));
 		MapAR							 	 := dedup(sort(distribute(MapLLCAR,hash(corp_key)),record,local),record,local) : independent;
		
		//********************************************************************
		// SCRUB AR 
		//********************************************************************	
		AR_F := MapAR;
		AR_S := Scrubs_Corp2_Mapping_IL_LLC_AR.Scrubs;		// Scrubs module
		AR_N := AR_S.FromNone(AR_F); 											// Generate the error flags
		AR_T := AR_S.FromBits(AR_N.BitmapInfile);     		// Use the FromBits module; makes my bitmap datafile easier to get to
		AR_U := AR_S.FromExpanded(AR_N.ExpandedInFile); 	// Pass the expanded error flags into the Expanded module

		//Outputs reports
		AR_ErrorSummary			 	 := output(AR_U.SummaryStats, named('AR_ErrorSummary_LLC_IL'+filedate));
		AR_ScrubErrorReport 	 := output(choosen(AR_U.AllErrors, 1000), named('AR_ScrubErrorReport_LLC_IL'+filedate));
		AR_SomeErrorValues		 := output(choosen(AR_U.BadValues, 1000), named('AR_SomeErrorValues_LLC_IL'+filedate));
		AR_IsScrubErrors		 	 := IF(count(AR_U.AllErrors)<> 0,true,false);

		// Orbit Stats
		AR_OrbitStats				 	 := AR_U.OrbitStats();
	
		//Outputs files
		AR_CreateBitMaps			 := output(AR_N.BitmapInfile,,'~thor_data::corp_LLC_IL_ar_scrubs_bits',overwrite,compressed);	//long term storage
		AR_TranslateBitMap		 := output(AR_T);

		//Submits Profile's stats to Orbit
		AR_SubmitStats 			   := Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_IL_LLC_AR','ScrubsAlerts', AR_OrbitStats, version,'Corp_IL_LLC_AR').SubmitStats;
		AR_ScrubsWithExamples  := Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_IL_LLC_AR','ScrubsAlerts', AR_OrbitStats, version,'Corp_IL_LLC_AR').CompareToProfile_with_Examples;

		AR_ScrubsAlert				 := AR_ScrubsWithExamples(RejectWarning = 'Y');
		AR_ScrubsAttachment	   := Scrubs.fn_email_attachment(AR_ScrubsAlert);
		AR_MailFile					   := FileServices.SendEmailAttachData(corp2.Email_Notification_Lists.AttachedList
																															,'Scrubs CorpAR_LLC_IL Report' //subject
																															,'Scrubs CorpAR_LLC_IL Report' //body
																															,(data)AR_ScrubsAttachment
																															,'text/csv'
																															,'CorpLLCILARScrubsReport.csv'																															
																															);

		AR_BadRecords				 := AR_N.ExpandedInFile(	
																								corp_key_Invalid							  			<> 0 or
																								corp_vendor_Invalid							  		<> 0 or
																								corp_state_origin_Invalid							<> 0 or
																								corp_process_date_Invalid							<> 0 or
																								corp_sos_charter_nbr_Invalid					<> 0 or
																								ar_year_Invalid							  				<> 0 or
																								ar_mailed_dt_Invalid							  	<> 0 or
																								ar_due_dt_Invalid									  	<> 0 or																								
																								ar_filed_dt_Invalid							  		<> 0 or
																								ar_delinquent_dt_Invalid							<> 0 or
																								ar_tax_factor_Invalid							  	<> 0 or
																								ar_paid_date_Invalid 									<> 0 or
																								ar_amount_paid_Invalid								<> 0
																							 );

		AR_GoodRecords			 := AR_N.ExpandedInFile(
																								corp_key_Invalid							  			= 0 and
																								corp_vendor_Invalid							  		= 0 and
																								corp_state_origin_Invalid							= 0 and
																								corp_process_date_Invalid							= 0 and
																								corp_sos_charter_nbr_Invalid					= 0 and
																								ar_year_Invalid							  				= 0 and
																								ar_mailed_dt_Invalid							  	= 0 and
																								ar_due_dt_Invalid									  	= 0 and
																								ar_filed_dt_Invalid							  		= 0 and
																								ar_delinquent_dt_Invalid							= 0 and
																								ar_tax_factor_Invalid							  	= 0 and
																								ar_paid_date_Invalid 									= 0 and
																								ar_amount_paid_Invalid								= 0
																								);

		AR_FailBuild					 := if(count(AR_GoodRecords) = 0,true,false);

		AR_ApprovedRecords		 := project(AR_GoodRecords,transform(Corp2_Mapping.LayoutsCommon.AR,self := left;));


		AR_ALL								 := sequential(IF(count(AR_BadRecords) <> 0
																								 ,IF (poverwrite
																										 ,OUTPUT(AR_BadRecords,,Corp2_Mapping._Dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::ar_llc_'+state_origin,overwrite,__compressed__)
																										 ,OUTPUT(AR_BadRecords,,Corp2_Mapping._Dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::ar_llc_'+state_origin,__compressed__)
																										 )
																								 )
																						  ,output(AR_ScrubsWithExamples, all, named('CorpARLLCILScrubsReportWithExamples'+filedate))
																							//Send Alerts if Scrubs exceeds thresholds
																							,IF(COUNT(AR_ScrubsAlert) > 0, AR_MailFile, OUTPUT('CORP2_MAPPING.IL_LLC - No "AR" Corp Scrubs Alerts'))
																							,AR_ErrorSummary
																							,AR_ScrubErrorReport
																							,AR_SomeErrorValues			
																							,AR_SubmitStats
																					);

		//********************************************************************
		// SCRUB MAIN
		//********************************************************************	
		Main_F := MapMain;
		Main_S := Scrubs_Corp2_Mapping_IL_LLC_Main.Scrubs;			// Scrubs module
		Main_N := Main_S.FromNone(Main_F); 											// Generate the error flags
		Main_T := Main_S.FromBits(Main_N.BitmapInfile);     		// Use the FromBits module; makes my bitmap datafile easier to get to
		Main_U := Main_S.FromExpanded(Main_N.ExpandedInFile); 	// Pass the expanded error flags into the Expanded module
		
		//Outputs reports
		Main_ErrorSummary					:= output(Main_U.SummaryStats, named('Main_ErrorSummary_LLC_IL'+filedate));
		Main_ScrubErrorReport 		:= output(choosen(Main_U.AllErrors, 1000), named('Main_ScrubErrorReport_LLC_IL'+filedate));
		Main_SomeErrorValues			:= output(choosen(Main_U.BadValues, 1000), named('Main_SomeErrorValues_LLC_IL'+filedate));
		Main_IsScrubErrors		 		:= IF(count(Main_U.AllErrors)<> 0,true,false);

		// Orbit Stats
		Main_OrbitStats						:= Main_U.OrbitStats();

		//Outputs files
		Main_CreateBitMaps				:= output(Main_N.BitmapInfile,,'~thor_data::corp_LLC_IL_main_scrubs_bits',overwrite,compressed);	//long term storage
		Main_TranslateBitMap			:= output(Main_T);

		//Submits Profile's stats to Orbit
		Main_SubmitStats 			    := Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_IL_LLC_Main','ScrubsAlerts', Main_OrbitStats, version,'Corp_IL_LLC_Main').SubmitStats;
		Main_ScrubsWithExamples   := Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_IL_LLC_Main','ScrubsAlerts', Main_OrbitStats, version,'Corp_IL_LLC_Main').CompareToProfile_with_Examples;

		Main_ScrubsAlert					:= Main_ScrubsWithExamples(RejectWarning = 'Y');
		Main_ScrubsAttachment			:= Scrubs.fn_email_attachment(Main_ScrubsAlert);
		Main_MailFile							:= FileServices.SendEmailAttachData(corp2.Email_Notification_Lists.spray
																																 ,'Scrubs CorpMain_LLC_IL Report' //subject
																																 ,'Scrubs CorpMain_LLC_IL Report' //body
																																 ,(data)Main_ScrubsAttachment
																																 ,'text/csv'
																																 ,'CorpLLCILMainScrubsReport.csv'
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
																											 corp_status_cd_Invalid									<> 0 or
																											 corp_status_desc_Invalid								<> 0 or
																											 corp_status_date_Invalid								<> 0 or
																											 corp_inc_state_Invalid 								<> 0 or
																											 corp_inc_date_Invalid 									<> 0 or
																											 corp_fed_tax_id_Invalid 								<> 0 or
																											 corp_term_exist_cd_Invalid							<> 0 or
																											 corp_term_exist_exp_Invalid						<> 0 or
																											 corp_term_exist_desc_Invalid						<> 0 or
																											 corp_foreign_domestic_ind_Invalid			<> 0 or
																											 corp_forgn_state_cd_Invalid 						<> 0 or
																											 corp_forgn_state_desc_Invalid 					<> 0 or
																											 corp_forgn_date_Invalid 								<> 0 or
																											 corp_for_profit_ind_Invalid						<> 0 or
																											 corp_orig_bus_type_cd_Invalid 					<> 0 or
																											 corp_ra_effective_date_Invalid 				<> 0 or
																											 corp_ra_address_type_cd_Invalid			  <> 0 or
																											 corp_ra_address_type_cd_Invalid			  <> 0 or
																											 corp_ra_address_type_desc_Invalid			<> 0 or
																											 cont_address_type_cd_Invalid			  		<> 0 or
																											 cont_address_type_desc_Invalid			  	<> 0 or
																											 corp_agent_county_Invalid		  				<> 0 or
																											 corp_country_of_formation_Invalid			<> 0 or
																											 corp_llc_managed_ind_Invalid		  			<> 0 or
																											 corp_merger_date_Invalid			  				<> 0 or
																											 corp_name_effective_date_Invalid			  <> 0 or
																											 corp_name_status_date_Invalid			  	<> 0 or
																											 cont_country_Invalid			  						<> 0 or
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
																											 corp_status_cd_Invalid									= 0 and
																											 corp_status_desc_Invalid								= 0 and																										 
																											 corp_status_date_Invalid								= 0 and
																											 corp_inc_state_Invalid 								= 0 and
																											 corp_inc_date_Invalid 									= 0 and
																											 corp_fed_tax_id_Invalid 								= 0 and																											 
																											 corp_term_exist_cd_Invalid							= 0 and
																											 corp_term_exist_exp_Invalid						= 0 and
																											 corp_term_exist_desc_Invalid						= 0 and
																											 corp_foreign_domestic_ind_Invalid			= 0 and
																											 corp_forgn_state_cd_Invalid 						= 0 and
																											 corp_forgn_state_desc_Invalid 					= 0 and
																											 corp_forgn_date_Invalid 								= 0 and
																											 corp_for_profit_ind_Invalid						= 0 and
																											 corp_orig_bus_type_cd_Invalid 					= 0 and
																											 corp_ra_effective_date_Invalid 				= 0 and
																											 corp_ra_address_type_cd_Invalid			  = 0 and
																											 corp_ra_address_type_desc_Invalid			= 0 and
																											 cont_address_type_cd_Invalid			  		= 0 and
																											 cont_address_type_desc_Invalid			  	= 0 and
																											 corp_agent_county_Invalid			  			= 0 and
																											 corp_country_of_formation_Invalid			= 0 and
																											 corp_llc_managed_ind_Invalid			  		= 0 and
																											 corp_merger_date_Invalid			  				= 0 and
																											 corp_name_effective_date_Invalid			  = 0 and
																											 corp_name_status_date_Invalid			  	= 0 and
																											 cont_country_Invalid			  						= 0 and
																											 recordorigin_Invalid					 					= 0																									 
																								  );

		Main_FailBuild					:= map( corp2_mapping.fCalcPercent(count(Main_N.ExpandedInFile(corp_key_invalid<>0)),count(Main_N.ExpandedInFile),false) 										> Scrubs_Corp2_Mapping_IL_LLC_Main.Threshold_Percent.CORP_KEY										 => true,
																		corp2_mapping.fCalcPercent(count(Main_N.ExpandedInFile(corp_orig_sos_charter_nbr_invalid<>0)),count(Main_N.ExpandedInFile),false) 	> Scrubs_Corp2_Mapping_IL_LLC_Main.Threshold_Percent.CORP_ORIG_SOS_CHARTER_NBR 	 => true,
																		corp2_mapping.fCalcPercent(count(Main_N.ExpandedInFile(corp_legal_name_invalid<>0)),count(Main_N.ExpandedInFile),false) 						> Scrubs_Corp2_Mapping_IL_LLC_Main.Threshold_Percent.CORP_LEGAL_NAME 						 => true,
																		corp2_mapping.fCalcPercent(count(Main_N.ExpandedInFile(corp_inc_date_invalid<>0)),count(Main_N.ExpandedInFile),false) 							> Scrubs_Corp2_Mapping_IL_LLC_Main.Threshold_Percent.CORP_INC_DATE 						 	 => true,
																	  count(Main_GoodRecords) = 0																																																																																											 => true,																		
																		false
																	);

		Main_ApprovedRecords		:= project(Main_GoodRecords,transform(Corp2_Mapping.LayoutsCommon.Main,self := left));


		Main_ALL		 			:= sequential( IF(count(Main_BadRecords) <> 0
																							,IF (poverwrite
																									,OUTPUT(Main_BadRecords,,Corp2_Mapping._Dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::main_llc_'+state_origin,overwrite,__compressed__)
																									,OUTPUT(Main_BadRecords,,Corp2_Mapping._Dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::main_llc_'+state_origin,__compressed__)
																									)
																							)
																					,output(Main_ScrubsWithExamples, all, named('CorpMainLLCILScrubsReportWithExamples'+filedate))
																					//Send Alerts if Scrubs exceeds thresholds
																					,IF(COUNT(Main_ScrubsAlert) > 0, Main_MailFile, OUTPUT('CORP2_MAPPING.IL_LLC - No "MAIN" Corp Scrubs Alerts'))
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

		VersionControl.macBuildNewLogicalFile(Corp2_Mapping._dataset().thor_cluster_Files + 'in::corp2::' 	+ version + '::ar_llc_' + state_origin, AR_ApprovedRecords	 , write_ar,,,pOverwrite);
		VersionControl.macBuildNewLogicalFile(Corp2_Mapping._dataset().thor_cluster_Files + 'in::corp2::' 	+ version + '::main_llc_' + state_origin, Main_ApprovedRecords , write_main,,,pOverwrite);

		VersionControl.macBuildNewLogicalFile(Corp2_Mapping._dataset().thor_cluster_Files + 'fail::corp2::' + version + '::ar_llc_' + state_origin, AR_F, write_fail_ar,,,pOverwrite);
		VersionControl.macBuildNewLogicalFile(Corp2_Mapping._dataset().thor_cluster_Files + 'fail::corp2::' + version + '::main_llc_' + state_origin, Main_F, write_fail_main,,,pOverwrite);

		mapIL_LLC 	:= sequential (if(pshouldspray = true,Corp2_mapping.fSprayFiles(state_origin+'_LLC',version,pOverwrite := pOverwrite))
															// ,Corp2_Raw_IL.Build_Bases_LLC(filedate,version,puseprod).All  // Determined build bases is not needed
															,AR_All
															,Main_All
															,if(Fail_Build <> true	 
																 ,sequential (write_ar
																						 ,write_main
																						 ,fileservices.addsuperfile(Corp2_Mapping._Dataset().thor_cluster_Files + 'in::'+Corp2_Mapping._Dataset().NameMapped +'::sprayed::ar'		,Corp2_Mapping._Dataset().thor_cluster_Files + 'in::corp2::'+version+'::ar_llc_'		+ state_origin)
																						 ,fileservices.addsuperfile(Corp2_Mapping._Dataset().thor_cluster_Files + 'in::'+Corp2_Mapping._Dataset().NameMapped +'::sprayed::main'	,Corp2_Mapping._Dataset().thor_cluster_Files + 'in::corp2::'+version+'::main_llc_'	+ state_origin)																		 
																						 ,if (count(Main_BadRecords) <> 0 or count(AR_BadRecords) <> 0
																								 ,Corp2_Mapping.Send_Email(state_origin+'_LLC',version,count(Main_BadRecords)<>0,count(AR_BadRecords)<>0,,,count(Main_BadRecords),count(AR_BadRecords),,,count(Main_ApprovedRecords),count(AR_ApprovedRecords)).RecordsRejected																				 
																								 ,Corp2_Mapping.Send_Email(state_origin+'_LLC',version,count(Main_BadRecords)<>0,count(AR_BadRecords)<>0,,,count(Main_BadRecords),count(AR_BadRecords),,,count(Main_ApprovedRecords),count(AR_ApprovedRecords)).MappingSuccess
																								 )
																						 ,if (IsScrubErrors
																								 ,Corp2_Mapping.Send_Email(state_origin+'_LLC',version,Main_IsScrubErrors,AR_IsScrubErrors).FieldsInvalidPerScrubs
																								 )
																						 ) //if Fail_Build <> true																			
																 ,sequential (write_fail_ar
																						 ,write_fail_main
																						 ,Corp2_Mapping.Send_Email(state_origin+'_LLC',version).MappingFailed
																						 ) //if Fail_Build = true
																 )
														);
			
		isFileDateValid := if((string)std.date.today() between ut.date_math(filedate,-30) and ut.date_math(filedate,30),true,false);
		
		return sequential (	 if (isFileDateValid
														,mapIL_LLC
														,sequential (Corp2_Mapping.Send_Email(state_origin+'_LLC',filedate).InvalidFileDateParm
																				,FAIL('Corp2_Mapping.'+state_origin+'_LLC failed.  An invalid filedate was passed in as a parameter.')
																				)
														)
											);
										
	end;	// end of Update function
	
end; //end IL_LLC