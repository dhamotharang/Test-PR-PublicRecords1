import corp2, corp2_mapping, corp2_raw_mi, scrubs, scrubs_corp2_mapping_mi_ar,
			 scrubs_corp2_mapping_mi_event, scrubs_corp2_mapping_mi_main, scrubs_corp2_mapping_mi_stock,
			 std, tools, ut, versioncontrol;
			 
export MI := module 

	export Update(string fileDate, string version, boolean pShouldSpray = _Dataset().bShouldSpray, boolean pOverwrite = false, boolean pUseProd = Tools._Constants.IsDataland) := function

		state_origin			 					:= 'MI';
		state_fips	 				 				:= '26';
		state_desc	 			 					:= 'MICHIGAN';

		Master											:= Corp2_Raw_MI.Files(fileDate, puseprod).Input.Master.Logical;
		FileAssumedNameFile      		:= dedup(sort(distribute(Corp2_Raw_MI.FileAssumedNameFile(Master),hash(corp_no_80)),record,local),record,local) : independent;
		FileGeneralPartnerFile   		:= dedup(sort(distribute(Corp2_Raw_MI.FileGeneralPartnerFile(Master),hash(gp_no_90)),record,local),record,local) : independent;
		FileHistoryFile	    	 			:= dedup(sort(distribute(Corp2_Raw_MI.FileHistoryFile(Master),hash(corp_no_70)),record,local),record,local) : independent;		
		FileLLC3AFile      					:= dedup(sort(distribute(Corp2_Raw_MI.FileLLC3AFile(Master),hash(corp_3a)),record,local),record,local) : independent;
		FileLLC3BFile     					:= dedup(sort(distribute(Corp2_Raw_MI.FileLLC3BFile(Master),hash(corp_3b)),record,local),record,local) : independent;
		FileLP2AFile      					:= dedup(sort(distribute(Corp2_Raw_MI.FileLP2AFile(Master),hash(l_corp_no_2a)),record,local),record,local) : independent;
		FileLP2BFile      					:= dedup(sort(distribute(Corp2_Raw_MI.FileLP2BFile(Master),hash(l_corp_no_2b)),record,local),record,local) : independent;
		FileCorpMaster1AFile     		:= dedup(sort(distribute(Corp2_Raw_MI.FileCorpMaster1AFile(Master),hash(c_no_1a)),record,local),record,local) : independent;
		FileCorpMaster1BFile     		:= dedup(sort(distribute(Corp2_Raw_MI.FileCorpMaster1BFile(Master),hash(c_no_1b)),record,local),record,local) : independent;	
		FileNameRegistrationFile 		:= dedup(sort(distribute(Corp2_Raw_MI.FileNameRegistrationFile(Master),hash(r_no_30)),record,local),record,local) : independent;	
		FileMailingFile 						:= dedup(sort(distribute(Corp2_Raw_MI.FileMailingFile(Master),hash(corp_no_50)),record,local),record,local) : independent;	

		history_ar_codes 						:= ['18', '82', '85'];		
		history_stock_codes 				:= ['09', '23'];
		history_event_codes					:= ['01','02','03','04','05','06','14','17','27','31','37','40','41'];

		//********************************************************************
		//The state sends the following files with addresses in them:
		//â€¢	Only contains agent addresses:  
		//			1A â€“ Corporation Master File
		//			1B â€“ Corporation Master File
		//			3A â€“ Limited Liability Company Master File
		//			3B - Limited Liability Company Master File
		//â€¢	Only contains business addresses:
		//			30 â€“ Name Registration Master File
		//â€¢	Both business and agent addresses:
		//			2A â€“ Limited Partnership Master File
		//			2B â€“ Limited Partnership Master File
		//â€¢	Only contains contact addresses:
		//			90 â€“ General Partner Master File
		//â€¢	Contains mailing addresses
		//			50 â€“ Mailing Record File 
		//
		//Contains no addresses:
		//â€¢	80 â€“ Assumed Name Record 
		//â€¢	00 - Delete File	
		//â€¢	70 - History File
		//â€¢	60 â€“ Pending File
		//********************************************************************


		//********************************************************************
		//The raw FileMailingFile has records with bad po box information. Some
		//records have PO BOX in the addr1_50 field without a po box number.
		//Some records have PO BOX verbage in the pob_50 field which is suppose
		//to contain the po box number.  There are additional issues with bad
		//characters in pob_50.  This transform attempts to clean up the raw data
		//before a join is made with all the corporation records (see AllMain)
		//to map the mailing address fields.
		//********************************************************************		
		Corp2_Raw_MI.Layouts.MailingLayoutIn FixRawMailingFileTransform(Corp2_Raw_MI.Layouts.MailingLayoutIn l) := transform
				self.addr1_50															:= if(Corp2_Raw_MI.Functions.MailingAddr(l.addr1_50)='PO BOX:',l.addr1_50+' '+l.pob_50,Corp2_Raw_MI.Functions.MailingAddr(l.addr1_50));
				self.addr2_50															:= if(Corp2_Raw_MI.Functions.MailingAddr(l.addr2_50)='PO BOX:',l.addr2_50+' '+l.pob_50,Corp2_Raw_MI.Functions.MailingAddr(l.addr2_50));
				self.city_50															:= l.city_50;
				self.st_50																:= l.st_50;
				self.zip_50																:= map(regexfind(state_origin,l.zip_50)															 				 => '',
																												 stringlib.stringfilter(l.zip_50,' 0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ')
																												);
				self.pob_50																:= map(corp2.t2u(l.pob_50) = state_origin																		 => '',
																												 regexfind('P(\\.)*O(\\.)*( )*B( )*O( )*X( )*',l.pob_50)				       => '',
																												 stringlib.stringfilter(l.pob_50,' 0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ')
																												);
				self																			:= l;
		end;

		HasPOBox 							:= regexfind('P(\\.)*O(\\.)*( )*B( )*O( )*X( )*',FileMailingFile.addr1_50);

		FixedMailingFile 			:= project(FileMailingFile(HasPOBox),FixRawMailingFileTransform(left));
		AllMailing	 					:= FileMailingFile(not(HasPOBox)) + FixedMailingFile;
		MailingFile						:= dedup(sort(distribute(AllMailing,hash(corp_no_50)),record,local),record,local) : independent;

		//********************************************************************
		// PROCESS CORPORATE MASTER (CORP) DATA
		//********************************************************************
		CorpMaster						 	:= join(FileCorpMaster1AFile, FileCorpMaster1BFile, 
																		left.trans_code_1a   = right.trans_code_1b and
																		left.c_no_1a  			 = right.c_no_1b,
																		transform(Corp2_Raw_MI.Layouts.Temp_CorpMaster,
																							self 				:= left;
																							self 				:= right;
																						 ),
																		left outer,
																		local
																	 ) : independent;																 
	 
		Corp2_Mapping.LayoutsCommon.Main CorpCorpMasterTransform(Corp2_Raw_MI.Layouts.Temp_CorpMaster l):= transform
				self.dt_vendor_first_reported							:= (integer)fileDate;
				self.dt_vendor_last_reported							:= (integer)fileDate;
				self.dt_first_seen												:= (integer)fileDate;
				self.dt_last_seen													:= (integer)fileDate;
				self.corp_ra_dt_first_seen								:= (integer)fileDate;
				self.corp_ra_dt_last_seen									:= (integer)fileDate;			
				self.corp_key															:= state_fips + '-' + corp2.t2u(l.c_no_1a);
				self.corp_vendor													:= state_fips;
				self.corp_state_origin										:= state_origin;			
				self.corp_process_date										:= fileDate;		
				self.corp_orig_sos_charter_nbr        		:= corp2.t2u(l.c_no_1a);
				self.corp_legal_name                  		:= Corp2_Mapping.fCleanBusinessName(state_origin,state_desc,l.c_name_1a).BusinessName;				
				self.corp_ln_name_type_cd   							:= '01';
				self.corp_ln_name_type_desc 							:= 'LEGAL';
				self.corp_status_cd 											:= corp2.t2u(l.out_fl_1b);
				self.corp_status_desc 										:= map(corp2.t2u(l.out_fl_1b) in ['0','00'] => 'ACTIVE',
																												 corp2.t2u(l.out_fl_1b) in ['1']			=> 'INACTIVE',
																												 ''
																												);
				self.corp_status_comment									:= Corp2_Raw_MI.Functions.CorpStatusComment(l.reason_out_1b);
				self.corp_inc_state 											:= state_origin;
				self.corp_inc_date 												:= if(corp2.t2u(l.inc_st_1b) in [state_origin,''],Corp2_Mapping.fValidateDate(l.c_date_inc_1a,'CCYYMMDD').PastDate,'');
				self.corp_term_exist_cd 									:= map(Corp2_Mapping.fValidateDate(l.c_date_end_1a,'CCYYMMDD').GeneralDate <> '' => 'D',
																												 corp2.t2u(l.c_term_1a) = '1'																			         => 'P',
																												 ''
																												);
				self.corp_term_exist_exp 									:= Corp2_Mapping.fValidateDate(l.c_date_end_1a,'CCYYMMDD').GeneralDate;
				self.corp_term_exist_desc 								:= map(self.corp_term_exist_cd = 'D' => 'EXPIRATION DATE',
																												 self.corp_term_exist_cd = 'P' => 'PERPETUAL',
																												 ''
																												);				
				self.corp_foreign_domestic_ind						:= map(corp2.t2u(l.inc_st_1b) in 		 [state_origin,''] => 'D',
																												 corp2.t2u(l.inc_st_1b) not in [state_origin,''] => 'F',
																												 ''
																												);				
				self.corp_forgn_state_cd 									:= if(corp2.t2u(l.inc_st_1b) not in [state_origin,''],Corp2_Raw_MI.Functions.CorpForgnStateCD(l.inc_st_1b),'');
				self.corp_forgn_state_desc 								:= if(corp2.t2u(l.inc_st_1b) not in [state_origin,''],Corp2_Raw_MI.Functions.CorpForgnStateDesc(l.inc_st_1b),'');
				self.corp_forgn_date 											:= if(corp2.t2u(l.inc_st_1b) in [state_origin,''],'',Corp2_Mapping.fValidateDate(l.c_date_inc_1a,'CCYYMMDD').PastDate);
				self.corp_orig_org_structure_desc					:= map(corp2.t2u(l.c_no_1a) between '000001' and '54999Z' => 'DOMESTIC PROFIT CORPORATION',
																												 corp2.t2u(l.c_no_1a) between '600000' and '69999Z' => 'FOREIGN PROFIT CORPORATION',
																												 corp2.t2u(l.c_no_1a) between '700000' and '89999Z' => 'DOMESTIC NONPROFIT CORPORATION',
																												 corp2.t2u(l.c_no_1a) between '900000' and '94999Z' => 'FOREIGN NONPROFIT CORPORATION',
																												 l.c_no_1a //being scrubbed 
																												);
				self.corp_for_profit_ind									:= map(corp2.t2u(l.c_no_1a) between '000001' and '54999Z' => 'Y',
																												 corp2.t2u(l.c_no_1a) between '600000' and '69999Z' => 'Y',
																												 corp2.t2u(l.c_no_1a) between '700000' and '89999Z' => 'N',
																												 corp2.t2u(l.c_no_1a) between '900000' and '94999Z' => 'N',																												 
																												 ''
																												);
				//This is an overloaded field.
				self.corp_orig_bus_type_desc							:= Corp2_Raw_MI.Functions.CorpPurpose(l.purpose_1b);
			  //corp_acts is an overloaded field. The fields: c_act2_1a and c_act3_1a must be kept until corp_acts2 & corp_acts3 
				//are customer facing.
				self.corp_acts 														:= Corp2_Raw_MI.Functions.CorpActs(l.c_act1_1a,l.c_act2_1a,l.c_act3_1a);
				self.corp_ra_full_name 										:= Corp2_Mapping.fCleanBusinessName(state_origin,state_desc,l.c_reg_agent_1a).BusinessName;																										 
				self.corp_ra_address_line1								:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.c_agent_adr_1a,l.a_adr_1b,l.a_city_1b,l.a_state_1b,l.a_zip_1b).AddressLine1;
				self.corp_ra_address_line2								:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.c_agent_adr_1a,l.a_adr_1b,l.a_city_1b,l.a_state_1b,l.a_zip_1b).AddressLine2;
				self.corp_ra_address_line3								:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.c_agent_adr_1a,l.a_adr_1b,l.a_city_1b,l.a_state_1b,l.a_zip_1b).AddressLine3;
				self.corp_ra_address_type_cd							:= if(Corp2_Mapping.fAddressExists(state_origin,state_desc,l.c_agent_adr_1a,l.a_adr_1b,l.a_city_1b,l.a_state_1b,l.a_zip_1b).ifAddressExists,'R','');
				self.corp_ra_address_type_desc 						:= if(Corp2_Mapping.fAddressExists(state_origin,state_desc,l.c_agent_adr_1a,l.a_adr_1b,l.a_city_1b,l.a_state_1b,l.a_zip_1b).ifAddressExists,'REGISTERED OFFICE','');		
				self.ra_prep_addr_line1        						:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.c_agent_adr_1a,l.a_adr_1b,l.a_city_1b,l.a_state_1b,l.a_zip_1b).PrepAddrLine1;
				self.ra_prep_addr_last_line    						:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.c_agent_adr_1a,l.a_adr_1b,l.a_city_1b,l.a_state_1b,l.a_zip_1b).PrepAddrLastLine;
				self.corp_acts2														:= corp2.t2u(l.c_act2_1a);
				self.corp_acts3														:= corp2.t2u(l.c_act3_1a);
				self.corp_dissolved_date									:= Corp2_Mapping.fValidateDate(l.date_out_1b,'CCYYMMDD').PastDate;
				self.corp_purpose													:= Corp2_Raw_MI.Functions.CorpPurpose(l.purpose_1b);
				self.recordorigin													:= 'C';
				self 																			:= [];
		end;

		MapCorpMaster := project(CorpMaster, CorpCorpMasterTransform(LEFT)) : independent;

		//********************************************************************
		// PROCESS LP DATA
		//********************************************************************
		LP 						:= join(FileLP2AFile, FileLP2BFile, 
													left.trans_code_2a 		= right.trans_code_2b 
													and left.l_corp_no_2a = right.l_corp_no_2b,
													transform(Corp2_Raw_MI.Layouts.Temp_LP,
																		self := left;
																		self := right;
																		),
													left outer,
													local
												 );
		
		Corp2_Mapping.LayoutsCommon.Main CorpLPTransform(Corp2_Raw_MI.Layouts.Temp_LP l) := transform
				self.dt_vendor_first_reported							:= (integer)fileDate;
				self.dt_vendor_last_reported							:= (integer)fileDate;
				self.dt_first_seen												:= (integer)fileDate;
				self.dt_last_seen													:= (integer)fileDate;
				self.corp_ra_dt_first_seen								:= (integer)fileDate;
				self.corp_ra_dt_last_seen									:= (integer)fileDate;			
				self.corp_key															:= state_fips + '-' + corp2.t2u(l.l_corp_no_2a);
				self.corp_vendor													:= state_fips;
				self.corp_state_origin										:= state_origin;			
				self.corp_process_date										:= fileDate;		
				self.corp_orig_sos_charter_nbr        		:= corp2.t2u(l.l_corp_no_2a);
				self.corp_legal_name                  		:= Corp2_Mapping.fCleanBusinessName(state_origin,state_desc,l.l_name_2a).BusinessName;				
				self.corp_ln_name_type_cd 								:= '01';
				self.corp_ln_name_type_desc								:= 'LEGAL';
				self.corp_address1_type_cd 								:= if(Corp2_Mapping.fAddressExists(state_origin,state_desc,l.l_addr1_2a,l.l_addr2_2a,l.l_city_2a,l.l_state_2a,l.l_zip_2a).ifAddressExists,'B','');
				self.corp_address1_type_desc 							:= if(Corp2_Mapping.fAddressExists(state_origin,state_desc,l.l_addr1_2a,l.l_addr2_2a,l.l_city_2a,l.l_state_2a,l.l_zip_2a).ifAddressExists,'BUSINESS','');
				self.corp_address1_line1					  			:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.l_addr1_2a,l.l_addr2_2a,l.l_city_2a,l.l_state_2a,l.l_zip_2a).AddressLine1;
				self.corp_address1_line2									:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.l_addr1_2a,l.l_addr2_2a,l.l_city_2a,l.l_state_2a,l.l_zip_2a).AddressLine2;
				self.corp_address1_line3									:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.l_addr1_2a,l.l_addr2_2a,l.l_city_2a,l.l_state_2a,l.l_zip_2a).AddressLine3;
				self.corp_prep_addr1_line1								:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.l_addr1_2a,l.l_addr2_2a,l.l_city_2a,l.l_state_2a,l.l_zip_2a).PrepAddrLine1;
				self.corp_prep_addr1_last_line						:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.l_addr1_2a,l.l_addr2_2a,l.l_city_2a,l.l_state_2a,l.l_zip_2a).PrepAddrLastLine;
				self.corp_status_cd 											:= corp2.t2u(l.l_out_flag_2b);
				self.corp_status_desc 										:= map(corp2.t2u(l.l_out_flag_2b) in ['0','00','A'] => 'ACTIVE',
																												 corp2.t2u(l.l_out_flag_2b) in ['1','O'] 			=> 'INACTIVE',
																												 ''
																												);
				self.corp_status_date 										:= Corp2_Mapping.fValidateDate(l.l_out_date_2b,'CCYYMMDD').PastDate;
				self.corp_status_comment 									:= Corp2_Raw_MI.Functions.CorpStatusComment(l.l_out_why_2b);
				self.corp_inc_state 											:= state_origin;
				self.corp_inc_county 											:= Corp2_Raw_MI.Functions.CorpAgentCounty(l.l_county_code_2b);
				self.corp_inc_date											 	:= if(corp2.t2u(l.l_form_state_2b) in [state_origin,''],Corp2_Mapping.fValidateDate(l.l_formed_date_2b,'CCYYMMDD').PastDate,'');
				self.corp_term_exist_exp 									:= Corp2_Mapping.fValidateDate(l.l_term_date_2b,'CCYYMMDD').GeneralDate;
				self.corp_term_exist_cd 									:= map(self.corp_term_exist_exp <> '' 		=> 'D',
																												 corp2.t2u(l.l_term_flag_2b) = '1' 	=> 'P',
																												 ''
																												);				
				self.corp_term_exist_desc 								:= map(self.corp_term_exist_cd = 'D'	=> 'EXPIRATION DATE',
																												 self.corp_term_exist_cd = 'P'	=> 'PERPETUAL',
																												 ''
																												);	
				self.corp_foreign_domestic_ind						:= map(corp2.t2u(l.l_form_state_2b) in 		 [state_origin,'']	=> 'D',
																												 corp2.t2u(l.l_form_state_2b) not in [state_origin,'']	=> 'F',
																												 ''
																												);			
				self.corp_forgn_state_cd 									:= if(corp2.t2u(l.l_form_state_2b) in [state_origin,''],'',Corp2_Raw_MI.Functions.CorpForgnStateCD(l.l_form_state_2b));	
				self.corp_forgn_state_desc 								:= if(corp2.t2u(l.l_form_state_2b) in [state_origin,''],'',Corp2_Raw_MI.Functions.CorpForgnStateDesc(l.l_form_state_2b));	
				self.corp_forgn_date										 	:= if(corp2.t2u(l.l_form_state_2b) in [state_origin,''],'',Corp2_Mapping.fValidateDate(l.l_formed_date_2b,'CCYYMMDD').PastDate);
				self.corp_orig_org_structure_desc					:= map(corp2.t2u(l.l_corp_no_2a) between 'L00001' and 'L8999Z' => 'DOMESTIC LIMITED PARTNERSHIP', 
																												 corp2.t2u(l.l_corp_no_2a) between 'L90000' and 'L9799Z' => 'FOREIGN LIMITED PARTNERSHIP',	
																												 ''
																												);				
				self.corp_ra_full_name 										:= Corp2_Mapping.fCleanBusinessName(state_origin,state_desc,l.l_agent_2b).BusinessName;
				self.corp_ra_address_type_cd	 						:= if(Corp2_Mapping.fAddressExists(state_origin,state_desc,l.l_agent_addr1_2b,l.l_agent_addr2_2b,l.l_agent_city_2b,l.l_agent_state_2b,l.l_agent_zip_2b).ifAddressExists,'R','');
				self.corp_ra_address_type_desc 						:= if(Corp2_Mapping.fAddressExists(state_origin,state_desc,l.l_agent_addr1_2b,l.l_agent_addr2_2b,l.l_agent_city_2b,l.l_agent_state_2b,l.l_agent_zip_2b).ifAddressExists,'REGISTERED OFFICE','');
				self.corp_ra_address_line1								:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.l_agent_addr1_2b,l.l_agent_addr2_2b,l.l_agent_city_2b,l.l_agent_state_2b,l.l_agent_zip_2b).AddressLine1;
				self.corp_ra_address_line2								:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.l_agent_addr1_2b,l.l_agent_addr2_2b,l.l_agent_city_2b,l.l_agent_state_2b,l.l_agent_zip_2b).AddressLine2;
				self.corp_ra_address_line3								:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.l_agent_addr1_2b,l.l_agent_addr2_2b,l.l_agent_city_2b,l.l_agent_state_2b,l.l_agent_zip_2b).AddressLine3;
				self.ra_prep_addr_line1        						:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.l_agent_addr1_2b,l.l_agent_addr2_2b,l.l_agent_city_2b,l.l_agent_state_2b,l.l_agent_zip_2b).PrepAddrLine1;
				self.ra_prep_addr_last_line    						:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.l_agent_addr1_2b,l.l_agent_addr2_2b,l.l_agent_city_2b,l.l_agent_state_2b,l.l_agent_zip_2b).PrepAddrLastLine;				
				//l_num_part_2b is a right justified (left zero filled) variable (e.g. 002 or 004 or 000); using integer to remove leading zeroes
				self.corp_nbr_of_partners									:= if((integer)l.l_num_part_2b = 0,'',(string)(integer)l.l_num_part_2b);
				self.recordorigin													:= 'C';				
				self 																			:= [];
		end;
		
		MapLP := project(LP,CorpLPTransform(LEFT)) : independent;
		
		//********************************************************************
		// PROCESS LLC DATA
		//********************************************************************
		LLC 										:= join(FileLLC3AFile, FileLLC3BFile, 
																	  left.trans_code_3a  = right.trans_code_3b and
																	  left.corp_3a 				= right.corp_3b,
																	  transform(Corp2_Raw_MI.Layouts.Temp_LLC,
																						  self := left;
																						  self := right;
																						 ),
																	  left outer,
																	  local
																	 );								
				
		Corp2_Mapping.LayoutsCommon.Main CorpLLCTransform(Corp2_Raw_MI.Layouts.Temp_LLC l) := transform
				self.dt_vendor_first_reported							:= (integer)fileDate;
				self.dt_vendor_last_reported							:= (integer)fileDate;
				self.dt_first_seen												:= (integer)fileDate;
				self.dt_last_seen													:= (integer)fileDate;
				self.corp_ra_dt_first_seen								:= (integer)fileDate;
				self.corp_ra_dt_last_seen									:= (integer)fileDate;			
				self.corp_key															:= state_fips + '-' + corp2.t2u(l.corp_3a);
				self.corp_vendor													:= state_fips;
				self.corp_state_origin										:= state_origin;			
				self.corp_process_date										:= fileDate;		
				self.corp_orig_sos_charter_nbr        		:= corp2.t2u(l.corp_3a);
				self.corp_legal_name                  		:= Corp2_Mapping.fCleanBusinessName(state_origin,state_desc,l.corp_name_3a).BusinessName;				
				self.corp_ln_name_type_cd 								:= '01';
				self.corp_ln_name_type_desc 							:= 'LEGAL';
				self.corp_status_cd	 											:= if (corp2.t2u(l.out_fl_3b) = '', '0', corp2.t2u(l.out_fl_3b));
				self.corp_status_desc		 									:= map( self.corp_status_cd <> '0' => 'INACTIVE',
																												 'ACTIVE'
																												);
				self.corp_status_comment 									:= Corp2_Raw_MI.Functions.CorpStatusComment(l.out_fl_3b);
				self.corp_inc_state 											:= state_origin;
				self.corp_foreign_domestic_ind						:= Corp2_Raw_MI.Functions.LLCForeignDomesticInd(l.corp_3a);
				self.corp_inc_date 												:= if(self.corp_foreign_domestic_ind <> 'F',Corp2_Mapping.fValidateDate(l.incorp_date_3a,'CCYYMMDD').PastDate,'');
				self.corp_term_exist_exp 									:= Corp2_Mapping.fValidateDate(l.end_date_3a,'CCYYMMDD').GeneralDate;
				self.corp_term_exist_cd 									:= map(self.corp_term_exist_exp <> '' 	=> 'D',
																												 corp2.t2u(l.term_code_3a) = '1' 	=> 'P',
																												 ''
																												);				
				self.corp_term_exist_desc 								:= map(self.corp_term_exist_exp <> '' 	=> 'EXPIRATION DATE',
																												 corp2.t2u(l.term_code_3a) = '1'	=> 'PERPETUAL',
																												 ''
																												);
				//No foreign state indicator exists for LLC data therefore all incorporation dates are mapped to corp_inc_date and none to corp_forgn_state_cd				
				self.corp_forgn_state_cd 									:= '';
				//No foreign state indicator exists for LLC data therefore all incorporation dates are mapped to corp_inc_date and none to corp_forgn_state_desc								
				self.corp_forgn_state_desc 								:= '';
				self.corp_forgn_date 											:= if(self.corp_foreign_domestic_ind =  'F',Corp2_Mapping.fValidateDate(l.incorp_date_3a,'CCYYMMDD').PastDate,'');
				self.corp_orig_org_structure_desc					:= map(Corp2_Raw_MI.Functions.LLCForeignDomesticInd(l.corp_3a) = 'D' => 'DOMESTIC LIMITED LIABILITY COMPANY',
																												 Corp2_Raw_MI.Functions.LLCForeignDomesticInd(l.corp_3a) = 'F' => 'FOREIGN LIMITED LIABILITY COMPANY',
																												 ''
																												);
				//This is an overloaded field.
				self.corp_orig_bus_type_desc							:= Corp2_Raw_MI.Functions.CorpPurpose(l.purpose_3b);																												
			  //corp_acts is an overloaded field. The fields: act2_3a and act3_3a must be kept until corp_acts2 & corp_acts3 
				//are customer facing.																												
				self.corp_acts 														:= Corp2_Raw_MI.Functions.CorpActs(l.act1_3a,l.act2_3a,l.act3_3a);				
				self.corp_ra_full_name 										:= if(regexfind('^NONE',corp2.t2u(l.r_agent_3a)),'',Corp2_Mapping.fCleanBusinessName(state_origin,state_desc,l.r_agent_3a).BusinessName);
				self.corp_ra_address_type_cd							:= if(Corp2_Mapping.fAddressExists(state_origin,state_desc,l.agent_addr_3a,l.agent_addr_3b,l.agent_city_3b,l.agent_state_3b,l.agent_zip_3b).ifAddressExists,'R','');
				self.corp_ra_address_type_desc 						:= if(Corp2_Mapping.fAddressExists(state_origin,state_desc,l.agent_addr_3a,l.agent_addr_3b,l.agent_city_3b,l.agent_state_3b,l.agent_zip_3b).ifAddressExists,'REGISTERED OFFICE','');
				self.corp_ra_address_line1								:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.agent_addr_3a,l.agent_addr_3b,l.agent_city_3b,l.agent_state_3b,l.agent_zip_3b).AddressLine1;
				self.corp_ra_address_line2								:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.agent_addr_3a,l.agent_addr_3b,l.agent_city_3b,l.agent_state_3b,l.agent_zip_3b).AddressLine2;
				self.corp_ra_address_line3								:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.agent_addr_3a,l.agent_addr_3b,l.agent_city_3b,l.agent_state_3b,l.agent_zip_3b).AddressLine3;
				self.ra_prep_addr_line1        						:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.agent_addr_3a,l.agent_addr_3b,l.agent_city_3b,l.agent_state_3b,l.agent_zip_3b).PrepAddrLine1;
				self.ra_prep_addr_last_line    						:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.agent_addr_3a,l.agent_addr_3b,l.agent_city_3b,l.agent_state_3b,l.agent_zip_3b).PrepAddrLastLine;
				self.corp_acts2														:= corp2.t2u(l.act2_3a);
				self.corp_acts3														:= corp2.t2u(l.act3_3a);
				self.corp_dissolved_date									:= Corp2_Mapping.fValidateDate(l.end_date_3b,'CCYYMMDD').PastDate;
				self.corp_management_desc									:= corp2.t2u(l.managed_by_3b);
				self.corp_purpose													:= Corp2_Raw_MI.Functions.CorpPurpose(l.purpose_3b);
				self.recordorigin													:= 'C';				
				self := [];
		end; 
		
		MapLLC	 						:= project(LLC,CorpLLCTransform(LEFT)) : independent;

		//********************************************************************
		// PROCESS NAMEREGISTRATION DATA
		//********************************************************************
		Corp2_Mapping.LayoutsCommon.Main NameRegistrationTransform(Corp2_Raw_MI.Layouts.NameRegistrationLayoutIn l):= transform
				self.dt_vendor_first_reported							:= (integer)fileDate;
				self.dt_vendor_last_reported							:= (integer)fileDate;
				self.dt_first_seen												:= (integer)fileDate;
				self.dt_last_seen													:= (integer)fileDate;
				self.corp_ra_dt_first_seen								:= (integer)fileDate;
				self.corp_ra_dt_last_seen									:= (integer)fileDate;			
				self.corp_key															:= state_fips + '-' + corp2.t2u(l.r_no_30);
				self.corp_vendor													:= state_fips;
				self.corp_state_origin										:= state_origin;
				self.corp_process_date										:= fileDate;		
				self.corp_orig_sos_charter_nbr        		:= corp2.t2u(l.r_no_30);
				self.corp_legal_name                  		:= Corp2_Mapping.fCleanBusinessName(state_origin,state_desc,l.name_30).BusinessName;				
				self.corp_ln_name_type_cd 								:= '09';
				self.corp_ln_name_type_desc 							:= 'REGISTRATION';
				self.corp_address1_type_cd				  			:= if(Corp2_Mapping.fAddressExists(state_origin,state_desc,l.addr1_30,l.addr2_30,l.city_30,l.st_30,l.zip_30).ifAddressExists,'M','');
				self.corp_address1_type_desc			  			:= if(Corp2_Mapping.fAddressExists(state_origin,state_desc,l.addr1_30,l.addr2_30,l.city_30,l.st_30,l.zip_30).ifAddressExists,'MAILING','');
				self.corp_address1_line1					  			:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.addr1_30,l.addr2_30,l.city_30,l.st_30,l.zip_30).AddressLine1;
				self.corp_address1_line2									:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.addr1_30,l.addr2_30,l.city_30,l.st_30,l.zip_30).AddressLine2;
				self.corp_address1_line3									:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.addr1_30,l.addr2_30,l.city_30,l.st_30,l.zip_30).AddressLine3;			
				self.corp_prep_addr1_line1								:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.addr1_30,l.addr2_30,l.city_30,l.st_30,l.zip_30).PrepAddrLine1;
				self.corp_prep_addr1_last_line						:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.addr1_30,l.addr2_30,l.city_30,l.st_30,l.zip_30).PrepAddrLastLine;				
				//The following are overloaded fields: corp_status_cd,corp_status_desc 				
				self.corp_status_cd 											:= corp2.t2u(l.out_fl_30);
				self.corp_status_desc 										:= map(corp2.t2u(l.out_fl_30) = 'A' => 'ACTIVE',
																												 corp2.t2u(l.out_fl_30) = 'O' => 'INACTIVE',
																												 ''
																												);
				self.corp_inc_state 											:= state_origin;
				self.corp_inc_date 												:= if(corp2.t2u(l.corp_st_30) in [state_origin,''],Corp2_Mapping.fValidateDate(l.corp_date_30,'CCYYMMDD').PastDate,'');
				//The following are overloaded fields: corp_term_exist_cd,corp_term_exist_exp,corp_term_exist_desc 
				self.corp_term_exist_cd 									:= if(Corp2_Mapping.fValidateDate(l.exp_date_30,'CCYYMMDD').GeneralDate <> '','D','');
				self.corp_term_exist_exp 									:= Corp2_Mapping.fValidateDate(l.exp_date_30,'CCYYMMDD').GeneralDate;
				self.corp_term_exist_desc 								:= if(Corp2_Mapping.fValidateDate(l.exp_date_30,'CCYYMMDD').GeneralDate <> '','EXPIRATION DATE','');		
				self.corp_foreign_domestic_ind						:= map(corp2.t2u(l.corp_st_30) in 		[state_origin,''] => 'D',
																												 corp2.t2u(l.corp_st_30) not in [state_origin,'']	=> 'F',
																												 ''
																												);					
				self.corp_forgn_state_cd 									:= if(corp2.t2u(l.corp_st_30) in [state_origin,''],'',Corp2_Raw_MI.Functions.CorpForgnStateCD(l.corp_st_30));
				self.corp_forgn_state_desc 								:= if(corp2.t2u(l.corp_st_30) in [state_origin,''],'',Corp2_Raw_MI.Functions.CorpForgnStateDesc(l.corp_st_30));
				self.corp_forgn_date 											:= if(corp2.t2u(l.corp_st_30) in [state_origin,''],'',Corp2_Mapping.fValidateDate(l.corp_date_30,'CCYYMMDD').PastDate);
				self.corp_name_reservation_date						:= Corp2_Mapping.fValidateDate(l.reg_date_30,'CCYYMMDD').PastDate;
				self.corp_name_reservation_expiration_date:= Corp2_Mapping.fValidateDate(l.exp_date_30,'CCYYMMDD').GeneralDate;
				self.corp_name_status_desc								:= map(corp2.t2u(l.out_fl_30) = 'A' => 'ACTIVE',
																												 corp2.t2u(l.out_fl_30) = 'O' => 'INACTIVE',
																												 ''
																												);
				self.recordorigin													:= 'C';
				self 																			:= [];
		end;
		
		MapNameRegistration	:= project(FileNameRegistrationFile,NameRegistrationTransform(LEFT));

		//********************************************************************
		// PROCESS ASSUMEDNAME DATA
		//********************************************************************
		
		CorpAssumedName		:= join(CorpMaster, FileAssumedNameFile,
															corp2.t2u(left.c_no_1a)  = corp2.t2u(right.corp_no_80),
															transform(Corp2_Raw_MI.Layouts.Temp_CorpAssumedName,
																				self.corp_inc_date		:= 	if(corp2.t2u(left.inc_st_1b) in [state_origin,''],Corp2_Mapping.fValidateDate(left.c_date_inc_1a,'CCYYMMDD').PastDate,'');
																				self.corp_forgn_date	:=	if(corp2.t2u(left.inc_st_1b) in [state_origin,''],'',Corp2_Mapping.fValidateDate(left.c_date_inc_1a,'CCYYMMDD').PastDate);	
																				self									:= 	right;
																			 ),
															right outer,
															local
															);		
		
		
		Corp2_Mapping.LayoutsCommon.Main CorpAssumedNameTransform(Corp2_Raw_MI.Layouts.Temp_CorpAssumedName l,integer c) := transform
				self.dt_vendor_first_reported							:= (integer)fileDate;
				self.dt_vendor_last_reported							:= (integer)fileDate;
				self.dt_first_seen												:= (integer)fileDate;
				self.dt_last_seen													:= (integer)fileDate;
				self.corp_ra_dt_first_seen								:= (integer)fileDate;
				self.corp_ra_dt_last_seen									:= (integer)fileDate;			
				self.corp_key															:= state_fips + '-' + corp2.t2u(l.corp_no_80);
				self.corp_vendor													:= state_fips;
				self.corp_state_origin										:= state_origin;			
				self.corp_process_date										:= fileDate;		
				self.corp_orig_sos_charter_nbr        		:= corp2.t2u(l.corp_no_80);
				self.corp_legal_name                  		:= Corp2_Mapping.fCleanBusinessName(state_origin,state_desc,l.name_80).BusinessName;
				self.corp_ln_name_type_cd 								:= '06';
				self.corp_ln_name_type_desc 							:= 'ASSUMED';
				self.corp_inc_state 											:= state_origin;				
				//The following are overloaded fields: corp_term_exist_cd,corp_term_exist_exp,corp_term_exist_desc 
				self.corp_term_exist_cd										:= if(Corp2_Mapping.fValidateDate(l.exp_date_80,'CCYYMMDD').GeneralDate <> '','D','');
				self.corp_term_exist_exp								 	:= Corp2_Mapping.fValidateDate(l.exp_date_80,'CCYYMMDD').GeneralDate;
				self.corp_term_exist_desc 								:= if(Corp2_Mapping.fValidateDate(l.exp_date_80,'CCYYMMDD').GeneralDate <> '','EXPIRATION DATE','');
				self.corp_name_effective_date							:= Corp2_Mapping.fValidateDate(l.file_date_80,'CCYYMMDD').GeneralDate;
				self.corp_name_status_date								:= choose(c,Corp2_Mapping.fValidateDate(l.exp_date_80,'CCYYMMDD').GeneralDate,
																															Corp2_Mapping.fValidateDate(l.renw_date_80,'CCYYMMDD').GeneralDate
																													 );
				self.corp_name_status_desc								:= choose(c,if(Corp2_Mapping.fValidateDate(l.exp_date_80,'CCYYMMDD').GeneralDate <> '','EXPIRATION DATE',''),
																															if(Corp2_Mapping.fValidateDate(l.renw_date_80,'CCYYMMDD').GeneralDate <> '','RENEWAL DATE','')
																													 );
				self.recordorigin													:= 'C';
				
				// populated from join to corpmaster
				self.corp_inc_date												:= l.corp_inc_date;
				self.corp_forgn_date											:= l.corp_forgn_date;
				
				self																			:= [];
		end;
		
		MapAssumedName 		:= normalize(CorpAssumedName, if(Corp2_Mapping.fValidateDate(left.renw_date_80,'CCYYMMDD').GeneralDate<>'',2,1),CorpAssumedNameTransform(left,counter));

		//********************************************************************
		// PROCESS CORPORATE CONTACT (CONT) DATA
		//*******************************************************************
		AllCorporation				:= MapCorpMaster + MapLLC + MapLP + MapNameRegistration : independent;
		Corporation						:= distribute(AllCorporation,hash(corp_orig_sos_charter_nbr));

		//The following join is done to pick up the corp_legal_name that doesn't
		//exist in the GeneralPartnerFile.
		//Note: MapAssumedName is not to be used to extract the legal name.
		CorpGeneralPartner		:= join(Corporation, FileGeneralPartnerFile,
																	corp2.t2u(left.corp_orig_sos_charter_nbr)  = corp2.t2u(right.gp_no_90),
																	transform(Corp2_Raw_MI.Layouts.Temp_CorpGeneralPartner,
																						self.corp_legal_name 					:= left.corp_legal_name;
																						self								 					:= right;
																					 ),
																	right outer,
																	local
																 );
	
		Corp2_Mapping.LayoutsCommon.Main GeneralPartnerTransform(Corp2_Raw_MI.Layouts.Temp_CorpGeneralPartner L) := transform,
		skip(Corp2_Mapping.fCleanBusinessName(state_origin,state_desc,l.gp_name_90).BusinessName = '')
				self.dt_vendor_first_reported							:= (integer)fileDate;
				self.dt_vendor_last_reported							:= (integer)fileDate;
				self.dt_first_seen												:= (integer)fileDate;
				self.dt_last_seen													:= (integer)fileDate;
				self.corp_ra_dt_first_seen								:= (integer)fileDate;
				self.corp_ra_dt_last_seen									:= (integer)fileDate;			
				self.corp_key															:= state_fips + '-' + corp2.t2u(l.gp_no_90);
				self.corp_vendor													:= state_fips;
				self.corp_state_origin										:= state_origin;
				self.corp_process_date										:= fileDate;
				self.corp_orig_sos_charter_nbr        		:= corp2.t2u(l.gp_no_90);
				self.corp_legal_name                  		:= corp2.t2u(l.corp_legal_name);
				self.corp_inc_state 											:= state_origin;				
				self.cont_full_name                  			:= Corp2_Mapping.fCleanBusinessName(state_origin,state_desc,l.gp_name_90).BusinessName;
			  self.cont_title1_desc											:= 'GENERAL PARTNER';
			  self.cont_address_type_cd             		:= if(Corp2_Mapping.fAddressExists(state_origin,state_desc,l.gp_addr1_90,l.gp_addr2_90,l.gp_city_90,l.gp_state_90,l.gp_zip_90,).ifAddressExists,'T','');
        self.cont_address_type_desc           		:= if(Corp2_Mapping.fAddressExists(state_origin,state_desc,l.gp_addr1_90,l.gp_addr2_90,l.gp_city_90,l.gp_state_90,l.gp_zip_90,).ifAddressExists,'CONTACT','');
			  self.cont_address_line1										:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.gp_addr1_90,l.gp_addr2_90,l.gp_city_90,l.gp_state_90,l.gp_zip_90,).AddressLine1;
			  self.cont_address_line2										:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.gp_addr1_90,l.gp_addr2_90,l.gp_city_90,l.gp_state_90,l.gp_zip_90,).AddressLine2;
			  self.cont_address_line3										:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.gp_addr1_90,l.gp_addr2_90,l.gp_city_90,l.gp_state_90,l.gp_zip_90,).AddressLine3;
			  self.cont_prep_addr_line1									:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.gp_addr1_90,l.gp_addr2_90,l.gp_city_90,l.gp_state_90,l.gp_zip_90,).PrepAddrLine1;
			  self.cont_prep_addr_last_line							:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.gp_addr1_90,l.gp_addr2_90,l.gp_city_90,l.gp_state_90,l.gp_zip_90,).PrepAddrLastLine;
				self.recordorigin													:= 'T';																													 
			  self 																			:= [];
		end;

		MapGeneralPartner 		:= project(CorpGeneralPartner,GeneralPartnerTransform(LEFT));

		Main									:= dedup(sort(distribute(AllCorporation + MapAssumedName + MapGeneralPartner,hash(corp_orig_sos_charter_nbr)),record,local),record,local) : independent;

		Corp2_Mapping.LayoutsCommon.Main AddressTransform(Corp2_Mapping.LayoutsCommon.Main l, Corp2_Raw_MI.Layouts.MailingLayoutIn r):= transform
				temp_address_type_cd											:= if(Corp2_Mapping.fAddressExists(state_origin,state_desc,r.addr1_50,r.addr2_50,r.city_50,r.st_50,r.zip_50).ifAddressExists,'M','');
				temp_address_type_desc										:= if(temp_address_type_cd='M','MAILING','');
				//Make sure that there is an address in address1 (indicated here by checking if corp_address1_type_cd not blank) before mapping.  
				self.corp_address1_type_cd 								:= if(l.corp_address1_type_cd<>'',l.corp_address1_type_cd,temp_address_type_cd);
				self.corp_address1_type_desc 							:= if(l.corp_address1_type_cd<>'',l.corp_address1_type_desc,temp_address_type_desc);
				self.corp_address1_line1									:= if(l.corp_address1_type_cd<>'',l.corp_address1_line1,Corp2_Mapping.fCleanAddress(state_origin,state_desc,r.addr1_50,r.addr2_50,r.city_50,r.st_50,r.zip_50).AddressLine1);
				self.corp_address1_line2									:= if(l.corp_address1_type_cd<>'',l.corp_address1_line2,Corp2_Mapping.fCleanAddress(state_origin,state_desc,r.addr1_50,r.addr2_50,r.city_50,r.st_50,r.zip_50).AddressLine2);
				self.corp_address1_line3									:= if(l.corp_address1_type_cd<>'',l.corp_address1_line3,Corp2_Mapping.fCleanAddress(state_origin,state_desc,r.addr1_50,r.addr2_50,r.city_50,r.st_50,r.zip_50).AddressLine3);
			  self.corp_prep_addr1_line1								:= if(l.corp_prep_addr1_last_line<>'',l.corp_prep_addr1_line1,Corp2_Mapping.fCleanAddress(state_origin,state_desc,r.addr1_50,r.addr2_50,r.city_50,r.st_50,r.zip_50,).PrepAddrLine1);
			  self.corp_prep_addr1_last_line						:= if(l.corp_prep_addr1_last_line<>'',l.corp_prep_addr1_last_line,Corp2_Mapping.fCleanAddress(state_origin,state_desc,r.addr1_50,r.addr2_50,r.city_50,r.st_50,r.zip_50,).PrepAddrLastLine);
				self.corp_address2_type_cd 								:= if(l.corp_address1_type_cd<>'',temp_address_type_cd,'');
				self.corp_address2_type_desc 							:= if(l.corp_address1_type_cd<>'',temp_address_type_desc,'');
				self.corp_address2_line1									:= if(l.corp_address1_type_cd<>'',Corp2_Mapping.fCleanAddress(state_origin,state_desc,r.addr1_50,r.addr2_50,r.city_50,r.st_50,r.zip_50).AddressLine1,'');
				self.corp_address2_line2									:= if(l.corp_address1_type_cd<>'',Corp2_Mapping.fCleanAddress(state_origin,state_desc,r.addr1_50,r.addr2_50,r.city_50,r.st_50,r.zip_50).AddressLine2,'');
				self.corp_address2_line3									:= if(l.corp_address1_type_cd<>'',Corp2_Mapping.fCleanAddress(state_origin,state_desc,r.addr1_50,r.addr2_50,r.city_50,r.st_50,r.zip_50).AddressLine3,'');
			  self.corp_prep_addr2_line1								:= if(l.corp_prep_addr1_last_line<>'',Corp2_Mapping.fCleanAddress(state_origin,state_desc,r.addr1_50,r.addr2_50,r.city_50,r.st_50,r.zip_50,).PrepAddrLine1,'');
			  self.corp_prep_addr2_last_line						:= if(l.corp_prep_addr1_last_line<>'',Corp2_Mapping.fCleanAddress(state_origin,state_desc,r.addr1_50,r.addr2_50,r.city_50,r.st_50,r.zip_50,).PrepAddrLastLine,'');				
			  self 																			:= l;
		end;
		
		MainMailingAddr		:= join(Main, MailingFile,
															left.corp_orig_sos_charter_nbr  = right.corp_no_50,
															AddressTransform(left,right),
															left outer,
															local
														 );		
		
		MapMain						:= dedup(sort(distribute(MainMailingAddr,hash(corp_key)),record,local),record,local) : independent;

		//UniqueMain's purpose is to ensure that every AR record, Event record and Stock record has a corresponding
		//"main" record.
		UniqueMain				:= dedup(sort(distribute(MapMain,hash(corp_key)),corp_key,local),corp_key,local) : independent;
		
		//********************************************************************	
		//	PROCESS CORP AR DATA
		//********************************************************************
		Corp2_Mapping.LayoutsCommon.AR CorpMasterARTransform(Corp2_Raw_MI.Layouts.Temp_CorpMaster L) := transform
				self.corp_key															:= state_fips + '-' + corp2.t2u(l.c_no_1a);
				self.corp_vendor													:= state_fips;
				self.corp_state_origin										:= state_origin;			
				self.corp_process_date										:= fileDate;		
				self.corp_sos_charter_nbr        					:= corp2.t2u(l.c_no_1a);
			  self.ar_year 															:= if(corp2.t2u(l.rpt_fy_1b)[3..4] in ['00',''],'',corp2.t2u(l.rpt_fy_1b)[3..4]);
			  self.ar_roll 															:= if(corp2.t2u(l.rpt_roll_1b) in ['0','00','000','0000',''],'',corp2.t2u(l.rpt_roll_1b));
			  self.ar_frame 														:= if(corp2.t2u(l.rpt_frame_1b) in ['0','00','000','0000',''],'',corp2.t2u(l.rpt_frame_1b));
			  self.ar_extension													:= if(corp2.t2u(l.rpt_ext_1b) = '0','',corp2.t2u(l.rpt_ext_1b));
			  self 																			:= [];
		end;
		
		AR_Corp						:= project(CorpMaster,CorpMasterARTransform(LEFT));
		AR_CorpMaster			:= AR_Corp(ar_year+ar_roll+ar_frame+ar_extension<>'');

		Corp2_Mapping.LayoutsCommon.AR HistoryARTransform(Corp2_Raw_MI.Layouts.HistoryLayoutIn L) := transform,
		skip(corp2.t2u(l.rec_typ_70) not in [history_ar_codes])		
				self.corp_key															:= state_fips + '-' + corp2.t2u(l.corp_no_70);
				self.corp_vendor													:= state_fips;
				self.corp_state_origin										:= state_origin;			
				self.corp_process_date										:= fileDate;		
				self.corp_sos_charter_nbr        					:= corp2.t2u(l.corp_no_70);
			  self.ar_filed_dt 													:= Corp2_Mapping.fValidateDate(l.h_date_70,'CCYYMMDD').PastDate;
				//integer is intentionally being used to remove invalid characters that 
				//belong to info2_70 and not roll_70.
			  self.ar_roll 															:= if((integer)l.roll_70 = 0,'',corp2.t2u(l.roll_70));
				//integer is intentionally being used to remove invalid characters that 
				//belong to info2_70 and not frame_70.
			  self.ar_frame 														:= if((integer)l.frame_70 = 0,'',corp2.t2u(l.frame_70));
			  self.ar_comment 													:= Corp2_Raw_MI.Functions.EventFilingDesc(l.rec_typ_70);
			  self 																			:= [];
		end;

		AR_HistoryFile		:= project(FileHistoryFile,HistoryARTransform(LEFT));
		AR_History				:= AR_HistoryFile(ar_filed_dt+ar_roll+ar_frame+ar_comment<>'');
		
		All_AR	 					:= AR_History + AR_CorpMaster;	

		ARDedup						:= dedup(sort(distribute(All_AR,hash(corp_key)),record,local),record,local) : independent;

		MapAR							:= join(UniqueMain, ARDedup,
															left.corp_key  = right.corp_key,
															transform(Corp2_Mapping.LayoutsCommon.AR,
																				self := right;
																			 ),
															inner,
															local
														 ) : independent;
											 
		//********************************************************************
		// PROCESS CORPORATE EVENT DATA
		//******************************************************************
		Corp2_Mapping.LayoutsCommon.Events HistoryEventTransform(Corp2_Raw_MI.Layouts.HistoryLayoutIn L) := transform,
		skip(corp2.t2u(l.rec_typ_70) not in [history_event_codes])
				self.corp_key															:= state_fips + '-' + corp2.t2u(l.corp_no_70);
				self.corp_vendor													:= state_fips;
				self.corp_state_origin										:= state_origin;			
				self.corp_process_date										:= fileDate;		
				self.corp_sos_charter_nbr        					:= corp2.t2u(l.corp_no_70);
			  self.event_filing_date 										:= Corp2_Mapping.fValidateDate(l.h_date_70,'CCYYMMDD').PastDate;
			  self.event_date_type_cd 									:= 'FIL';
			  self.event_date_type_desc 								:= 'FILING';
			  self.event_filing_cd 											:= corp2.t2u(l.rec_typ_70);
			  self.event_filing_desc 										:= Corp2_Raw_MI.Functions.EventFilingDesc(l.rec_typ_70);
				//Note: roll_70 & frame_70 are parameters into "InfoString" because in some cases these fields contains part of
				//      info2_70   (e.g. roll_70 = 'HOUG' frame_70 = HTON & info2_70 = MI, etc.) -> corp_no_70 = '10762D'
			  self.event_desc 													:= Corp2_Raw_MI.Functions.InfoString(l.info_70,l.roll_70,l.frame_70,l.info2_70,l.info3_70,l.info4_70,l.info5_70);
			  self 																			:= [];
		end;

		MapHistory				:= project(FileHistoryFile,HistoryEventTransform(LEFT));

		EventDedup				:= dedup(sort(distribute(MapHistory,hash(corp_key)),record,local),record,local) : independent;

		MapEvent					:= join(UniqueMain, EventDedup,
															left.corp_key  = right.corp_key,
															transform(Corp2_Mapping.LayoutsCommon.Events,
																				self := right;
																			 ),
															inner,
															local
														 ) : independent;
														 
		//********************************************************************
		// PROCESS CORP STOCK DATA
		//********************************************************************
		Corp2_Mapping.LayoutsCommon.Stock StockCorpMasterTransform(Corp2_Raw_MI.Layouts.Temp_CorpMaster L) := transform
				self.corp_key															:= state_fips + '-' + corp2.t2u(l.c_no_1a);
				self.corp_vendor													:= state_fips;
				self.corp_state_origin										:= state_origin;			
				self.corp_process_date										:= fileDate;		
				self.corp_sos_charter_nbr        					:= corp2.t2u(l.c_no_1a);
				//Integer is intentionally being used to eliminate the leading zeroes of total_shares_1b
				//which is a fixed length of 15 characters (contains only numeric data).  e.g. 000000000010000)
			  self.stock_authorized_nbr 								:= (string)(integer)l.total_shares_1b;
				self.stock_change_ind 										:= if(corp2.t2u(l.stock_his_1b) = 'Y',corp2.t2u(l.stock_his_1b),'');
			  self 																			:= [];
		end;

		StockCorpMaster			:= project(CorpMaster, StockCorpMasterTransform(LEFT));	

		Corp2_Mapping.LayoutsCommon.Stock StockHistoryTransform(Corp2_Raw_MI.Layouts.HistoryLayoutIn L) := transform,
		skip(corp2.t2u(l.rec_typ_70) not in [history_stock_codes])
				self.corp_key															:= state_fips + '-' + corp2.t2u(l.corp_no_70);
				self.corp_vendor													:= state_fips;
				self.corp_state_origin										:= state_origin;			
				self.corp_process_date										:= fileDate;		
				self.corp_sos_charter_nbr        					:= corp2.t2u(l.corp_no_70);
			  self.stock_change_date 										:= Corp2_Mapping.fValidateDate(l.h_date_70,'CCYYMMDD').PastDate;
				//Note: roll_70 & frame_70 are parameters into "InfoString" because in some cases these fields contains part of
				//      info2_70   (e.g. roll_70 = 'HOUG' frame_70 = HTON & info2_70 = MI, etc.) -> corp_no_70 = '10762D'
			  self.stock_addl_info 											:= if(l.rec_typ_70 in ['23'],Corp2_Raw_MI.Functions.InfoString(l.info_70,l.roll_70,l.frame_70,l.info2_70,l.info3_70,l.info4_70,l.info5_70),'');
			  self.stock_stock_description							:= if(l.rec_typ_70 in ['09'],corp2.t2u(l.info_70),'');
			  self 																			:= [];
		end;

		StockHistory 			:= project(FileHistoryFile, StockHistoryTransform(LEFT));	

		All_Stock		  		:= StockCorpMaster + StockHistory;
		StockDedup				:= dedup(sort(distribute(All_Stock,hash(corp_key)),record,local),record,local) : independent;

		MapStock					:= join(UniqueMain, StockDedup,
															left.corp_key  = right.corp_key,
															transform(Corp2_Mapping.LayoutsCommon.Stock,
																				self := right;
																			 ),
															inner,
															local
														 );
														 
	//********************************************************************
  // SCRUB AR 
  //********************************************************************	
		AR_F := MapAR;
		AR_S := Scrubs_Corp2_Mapping_MI_AR.Scrubs;				// Scrubs module
		AR_N := AR_S.FromNone(AR_F); 											// Generate the error flags
		AR_T := AR_S.FromBits(AR_N.BitmapInfile);     		// Use the FromBits module; makes my bitmap datafile easier to get to
		AR_U := AR_S.FromExpanded(AR_N.ExpandedInFile); 	// Pass the expanded error flags into the Expanded module

		//Outputs reports
		AR_ErrorSummary			 	 := output(AR_U.SummaryStats, named('AR_ErrorSummary_MI'+filedate));
		AR_ScrubErrorReport 	 := output(choosen(AR_U.AllErrors, 1000), named('AR_ScrubErrorReport_MI'+filedate));
		AR_SomeErrorValues		 := output(choosen(AR_U.BadValues, 1000), named('AR_SomeErrorValues_MI'+filedate));
		AR_IsScrubErrors		 	 := IF(count(AR_U.AllErrors)<> 0,true,false);

		// Orbit Stats
		AR_OrbitStats				 	 := AR_U.OrbitStats();
		
		//Outputs files
		AR_CreateBitMaps			 := output(AR_N.BitmapInfile,,'~thor_data::corp_mi_ar_scrubs_bits',overwrite,compressed);	//long term storage
		AR_TranslateBitMap		 := output(AR_T);

		//Submits Profile's stats to Orbit
		AR_SubmitStats 			   := Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_MI_AR','ScrubsAlerts', AR_OrbitStats, version,'Corp_MI_AR').SubmitStats;
		AR_ScrubsWithExamples  := Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_MI_AR','ScrubsAlerts', AR_OrbitStats, version,'Corp_MI_AR').CompareToProfile_with_Examples;

		AR_ScrubsAlert				 := AR_ScrubsWithExamples(RejectWarning = 'Y');
		AR_ScrubsAttachment	   := Scrubs.fn_email_attachment(AR_ScrubsAlert);
		AR_MailFile					   := FileServices.SendEmailAttachData(corp2.Email_Notification_Lists.spray
																															,'Scrubs CorpAR_MI Report' //subject
																															,'Scrubs CorpAR_MI Report' //body
																															,(data)AR_ScrubsAttachment
																															,'text/csv'
																															,'CorpMIARScrubsReport.csv'
																															,
																															,
																															,corp2.Email_Notification_Lists.spray);

		AR_BadRecords				 := AR_N.ExpandedInFile(	
																								corp_key_Invalid							  			<> 0 or
																								corp_vendor_Invalid							  		<> 0 or
																								corp_state_origin_Invalid							<> 0 or
																								corp_process_date_Invalid							<> 0 or
																								corp_sos_charter_nbr_Invalid					<> 0 or
																								ar_year_Invalid							  				<> 0 or
																								ar_due_dt_Invalid							  			<> 0 or
																								ar_filed_dt_Invalid							  		<> 0 or
																								ar_roll_Invalid							  				<> 0 or
																								ar_frame_Invalid							  			<> 0 or
																								ar_extension_Invalid 									<> 0																								
																							 );

		AR_GoodRecords			 := AR_N.ExpandedInFile(
																								corp_key_Invalid							  			= 0 and
																								corp_vendor_Invalid							  		= 0 and
																								corp_state_origin_Invalid							= 0 and
																								corp_process_date_Invalid							= 0 and
																								corp_sos_charter_nbr_Invalid					= 0 and
																								ar_year_Invalid							  				= 0 and
																								ar_due_dt_Invalid							  			= 0 and
																								ar_filed_dt_Invalid							  		= 0 and
																								ar_roll_Invalid							  				= 0 and
																								ar_frame_Invalid							  			= 0 and
																								ar_extension_Invalid 									= 0																									
																								);

		AR_FailBuild					 := if(count(AR_GoodRecords) = 0,true,false);

		AR_ApprovedRecords		 := project(AR_GoodRecords,transform(Corp2_Mapping.LayoutsCommon.AR,self := left;));


		AR_ALL								 := sequential(IF(count(AR_BadRecords) <> 0
																								 ,IF (poverwrite
																										 ,OUTPUT(AR_BadRecords,,Corp2_Mapping._Dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::ar_'+state_origin,overwrite,__compressed__)
																										 ,OUTPUT(AR_BadRecords,,Corp2_Mapping._Dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::ar_'+state_origin,__compressed__)
																										 )
																								 )
																						  ,output(AR_ScrubsWithExamples, ALL, NAMED('CorpARMIScrubsReportWithExamples'+filedate))
																							//Send Alerts if Scrubs exceeds thresholds
																							,IF(COUNT(AR_ScrubsAlert) > 0, AR_MailFile, OUTPUT('CORP2_MAPPING.MI - No "AR" Corp Scrubs Alerts'))
																							,AR_ErrorSummary
																							,AR_ScrubErrorReport
																							,AR_SomeErrorValues			
																							,AR_SubmitStats
																					);

	//********************************************************************
  // SCRUB EVENT
  //********************************************************************	
		Event_F := MapEvent;
		Event_S := Scrubs_Corp2_Mapping_MI_Event.Scrubs;						// Scrubs module
		Event_N := Event_S.FromNone(Event_F); 											// Generate the error flags
		Event_T := Event_S.FromBits(Event_N.BitmapInfile);     			// Use the FromBits module; makes my bitmap datafile easier to get to
		Event_U := Event_S.FromExpanded(Event_N.ExpandedInFile); 		// Pass the expanded error flags into the Expanded module
		
		//Outputs reports
		Event_ErrorSummary				:= output(Event_U.SummaryStats, named('Event_ErrorSummary_MI'+filedate));
		Event_ScrubErrorReport 		:= output(choosen(Event_U.AllErrors, 1000), named('Event_ScrubErrorReport_MI'+filedate));
		Event_SomeErrorValues			:= output(choosen(Event_U.BadValues, 1000), named('Event_SomeErrorValues_MI'+filedate));
		Event_IsScrubErrors		 		:= IF(count(Event_U.AllErrors)<> 0,true,false);

		// Orbit Stats
		Event_OrbitStats					:= Event_U.OrbitStats();
		
		//Outputs files
		Event_CreateBitMaps				:= output(Event_N.BitmapInfile,,'~thor_data::corp_mi_event_scrubs_bits',overwrite,compressed);	//long term storage
		Event_TranslateBitMap			:= output(Event_T);

		//Submits Profile's stats to Orbit
		Event_SubmitStats 			  := Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_MI_Event','ScrubsAlerts', Event_OrbitStats, version,'Corp_MI_Event').SubmitStats;
		Event_ScrubsWithExamples  := Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_MI_Event','ScrubsAlerts', Event_OrbitStats, version,'Corp_MI_Event').CompareToProfile_with_Examples;

		Event_ScrubsAlert					:= Event_ScrubsWithExamples(RejectWarning = 'Y');
		Event_ScrubsAttachment		:= Scrubs.fn_email_attachment(Event_ScrubsAlert);
		Event_MailFile						:= FileServices.SendEmailAttachData(corp2.Email_Notification_Lists.spray
																																 ,'Scrubs CorpEvent_MI Report' //subject
																																 ,'Scrubs CorpEvent_MI Report' //body
																																 ,(data)Event_ScrubsAttachment
																																 ,'text/csv'
																																 ,'CorpMIEventScrubsReport.csv'
																																 ,
																																 ,
																																 ,corp2.Email_Notification_Lists.spray);

		Event_BadRecords				 	:= Event_N.ExpandedInFile(	
																												corp_key_Invalid							  			<> 0 or
																												corp_vendor_Invalid							  		<> 0 or
																												corp_state_origin_Invalid							<> 0 or
																												corp_process_date_Invalid							<> 0 or
																												corp_sos_charter_nbr_Invalid					<> 0 or
																												event_filing_date_Invalid							<> 0 or
																												event_date_type_cd_Invalid						<> 0 or
																												event_date_type_desc_Invalid					<> 0
																											 );
																										 																	
		Event_GoodRecords					:= Event_N.ExpandedInFile(	
																												corp_key_Invalid							  			= 0 and
																												corp_vendor_Invalid							  		= 0 and
																												corp_state_origin_Invalid							= 0 and
																												corp_process_date_Invalid							= 0 and
																												corp_sos_charter_nbr_Invalid					= 0 and
																												event_filing_date_Invalid							= 0 and
																												event_date_type_cd_Invalid						= 0 and
																												event_date_type_desc_Invalid					= 0																												
																											);

		Event_FailBuild					  := if(count(Event_GoodRecords) = 0,true,false);

		Event_ApprovedRecords			:= project(Event_GoodRecords,transform(Corp2_Mapping.LayoutsCommon.Events,self := left));
		

		Event_ALL									:= sequential(IF(count(Event_BadRecords) <> 0
																											,IF (poverwrite
																													,OUTPUT(Event_BadRecords,,Corp2_Mapping._Dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::event_'+state_origin,overwrite,__compressed__)
																													,OUTPUT(Event_BadRecords,,Corp2_Mapping._Dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::event_'+state_origin,__compressed__)
																													)
																											)
																									 ,output(Event_ScrubsWithExamples, ALL, NAMED('CorpEventMIScrubsReportWithExamples'+filedate))
																									 //Send Alerts if Scrubs exceeds thresholds
																									 ,IF(COUNT(Event_ScrubsAlert) > 0, Event_MailFile, OUTPUT('CORP2_MAPPING.MI - No "EVENT" Corp Scrubs Alerts'))
																									 ,Event_ErrorSummary
																									 ,Event_ScrubErrorReport
																									 ,Event_SomeErrorValues		
																									 ,Event_SubmitStats
																								);

	//********************************************************************
  // SCRUB MAIN
  //********************************************************************	
		Main_F := MapMain;
		Main_S := Scrubs_Corp2_Mapping_MI_Main.Scrubs;					// Scrubs module
		Main_N := Main_S.FromNone(Main_F); 											// Generate the error flags
		Main_T := Main_S.FromBits(Main_N.BitmapInfile);     		// Use the FromBits module; makes my bitmap datafile easier to get to
		Main_U := Main_S.FromExpanded(Main_N.ExpandedInFile); 	// Pass the expanded error flags into the Expanded module

		//Outputs reports
		Main_ErrorSummary					:= output(Main_U.SummaryStats, named('Main_ErrorSummary_MI'+filedate));
		Main_ScrubErrorReport 		:= output(choosen(Main_U.AllErrors, 1000), named('Main_ScrubErrorReport_MI'+filedate));
		Main_SomeErrorValues			:= output(choosen(Main_U.BadValues, 1000), named('Main_SomeErrorValues_MI'+filedate));
		Main_IsScrubErrors		 		:= IF(count(Main_U.AllErrors)<> 0,true,false);

		// Orbit Stats
		Main_OrbitStats						:= Main_U.OrbitStats();
		
		//Outputs files
		Main_CreateBitMaps				:= output(Main_N.BitmapInfile,,'~thor_data::corp_mi_main_scrubs_bits',overwrite,compressed);	//long term storage
		Main_TranslateBitMap			:= output(Main_T);

		//Submits Profile's stats to Orbit
		Main_SubmitStats 			    := Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_MI_Main','ScrubsAlerts', Main_OrbitStats, version,'Corp_MI_Main').SubmitStats;
		Main_ScrubsWithExamples   := Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_MI_Main','ScrubsAlerts', Main_OrbitStats, version,'Corp_MI_Main').CompareToProfile_with_Examples;

		Main_ScrubsAlert					:= Main_ScrubsWithExamples(RejectWarning = 'Y');
		Main_ScrubsAttachment			:= Scrubs.fn_email_attachment(Main_ScrubsAlert);
		Main_MailFile							:= FileServices.SendEmailAttachData(corp2.Email_Notification_Lists.spray
																																 ,'Scrubs CorpMain_MI Report' //subject
																																 ,'Scrubs CorpMain_MI Report' //body
																																 ,(data)Main_ScrubsAttachment
																																 ,'text/csv'
																																 ,'CorpMIMainScrubsReport.csv'
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
																											 corp_state_origin_Invalid 							<> 0 or
																											 corp_process_date_Invalid 							<> 0 or
																											 corp_orig_sos_charter_nbr_Invalid 			<> 0 or
																											 corp_legal_name_Invalid 								<> 0 or
																											 corp_ln_name_type_cd_Invalid 					<> 0 or
																											 corp_ln_name_type_desc_invalid 				<> 0 or																											 
																											 corp_address1_line3_Invalid 						<> 0 or
																											 corp_status_comment_Invalid 						<> 0 or
																											 corp_inc_state_Invalid 								<> 0 or
																											 corp_inc_date_Invalid 									<> 0 or
																											 corp_forgn_state_cd_Invalid 						<> 0 or
																											 corp_forgn_state_desc_Invalid 					<> 0 or
																											 corp_forgn_date_Invalid 								<> 0 or
																											 corp_orig_org_structure_desc_Invalid 	<> 0 or
																											 cont_address_line3_Invalid 						<> 0 or
																											 corp_dissolved_date_Invalid 						<> 0 or
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
																											 corp_ln_name_type_desc_invalid					= 0 and																											 
																											 corp_address1_line3_Invalid 						= 0 and
																											 corp_status_comment_Invalid 						= 0 and
																											 corp_inc_state_Invalid 								= 0 and
																											 corp_inc_date_Invalid 									= 0 and
																											 corp_forgn_state_cd_Invalid 						= 0 and
																											 corp_forgn_state_desc_Invalid 					= 0 and
																											 corp_forgn_date_Invalid 								= 0 and
																											 corp_orig_org_structure_desc_Invalid 	= 0 and
																											 cont_address_line3_Invalid 						= 0 and
																											 corp_dissolved_date_Invalid 						= 0 and
																											 recordorigin_Invalid					 					= 0																										 
																								  );

		Main_FailBuild					:= map( corp2_mapping.fCalcPercent(count(Main_N.ExpandedInFile(corp_key_invalid<>0)),count(Main_N.ExpandedInFile),false) 										> Scrubs_Corp2_Mapping_MI_Main.Threshold_Percent.CORP_KEY										 => true,
																		corp2_mapping.fCalcPercent(count(Main_N.ExpandedInFile(corp_orig_sos_charter_nbr_invalid<>0)),count(Main_N.ExpandedInFile),false) 	> Scrubs_Corp2_Mapping_MI_Main.Threshold_Percent.CORP_ORIG_SOS_CHARTER_NBR 	 => true,
																		corp2_mapping.fCalcPercent(count(Main_N.ExpandedInFile(corp_legal_name_invalid<>0)),count(Main_N.ExpandedInFile),false) 						> Scrubs_Corp2_Mapping_MI_Main.Threshold_Percent.CORP_LEGAL_NAME 						 => true,
																		corp2_mapping.fCalcPercent(count(Main_N.ExpandedInFile(corp_ln_name_type_cd_invalid<>0)),count(Main_N.ExpandedInFile),false) 				> Scrubs_Corp2_Mapping_MI_Main.Threshold_Percent.CORP_LN_NAME_TYPE_CD		  	 => true,
																		corp2_mapping.fCalcPercent(count(Main_N.ExpandedInFile(corp_inc_date_invalid<>0)),count(Main_N.ExpandedInFile),false) 							> Scrubs_Corp2_Mapping_MI_Main.Threshold_Percent.CORP_INC_DATE 						 	 => true,
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
																					,output(Main_ScrubsWithExamples, ALL, NAMED('CorpMainMIScrubsReportWithExamples'+filedate))
																					//Send Alerts if Scrubs exceeds thresholds
																					,IF(COUNT(Main_ScrubsAlert) > 0, Main_MailFile, OUTPUT('CORP2_MAPPING.MI - No "MAIN" Corp Scrubs Alerts'))
																					,Main_ErrorSummary
																					,Main_ScrubErrorReport
																					,Main_SomeErrorValues	
																					,Main_SubmitStats
																			);

	//********************************************************************
  // SCRUB STOCK
  //********************************************************************	
		Stock_F := MapStock;
		Stock_S := Scrubs_Corp2_Mapping_MI_Stock.Scrubs;						// Scrubs module
		Stock_N := Stock_S.FromNone(Stock_F); 											// Generate the error flags
		Stock_T := Stock_S.FromBits(Stock_N.BitmapInfile);     			// Use the FromBits module; makes my bitmap datafile easier to get to
		Stock_U := Stock_S.FromExpanded(Stock_N.ExpandedInFile); 		// Pass the expanded error flags into the Expanded module

		//Outputs reports
		Stock_ErrorSummary			 	:= output(Stock_U.SummaryStats, named('Stock_ErrorSummary_MI'+filedate));
		Stock_ScrubErrorReport 	 	:= output(choosen(Stock_U.AllErrors, 1000), named('Stock_ScrubErrorReport_MI'+filedate));
		Stock_SomeErrorValues		 	:= output(choosen(Stock_U.BadValues, 1000), named('Stock_SomeErrorValues_MI'+filedate));
		Stock_IsScrubErrors		 	 	:= IF(count(Stock_U.AllErrors)<> 0,true,false);

		// Orbit Stats
		Stock_OrbitStats				 	:= Stock_U.OrbitStats();
		
		//Outputs files
		Stock_CreateBitMaps				:= output(Stock_N.BitmapInfile,,'~thor_data::corp_mi_scrubs_bits',overwrite,compressed);	//long term storage
		Stock_TranslateBitMap			:= output(Stock_T);

		//Submits Profile's stats to Orbit
		Stock_SubmitStats 			  := Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_MI_Stock','ScrubsAlerts', Stock_OrbitStats, version,'Corp_MI_Stock').SubmitStats;
		Stock_ScrubsWithExamples  := Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_MI_Stock','ScrubsAlerts', Stock_OrbitStats, version,'Corp_MI_Stock').CompareToProfile_with_Examples;

		Stock_ScrubsAlert					:= Stock_ScrubsWithExamples(RejectWarning = 'Y');
		Stock_ScrubsAttachment		:= Scrubs.fn_email_attachment(Stock_ScrubsAlert);
		Stock_MailFile						:= FileServices.SendEmailAttachData(corp2.Email_Notification_Lists.spray
																																 ,'Scrubs CorpStock_MI Report' //subject
																																 ,'Scrubs CorpStock_MI Report' //body
																																 ,(data)Stock_ScrubsAttachment
																																 ,'text/csv'
																																 ,'CorpMIEventScrubsReport.csv'
																																 ,
																																 ,
																																 ,corp2.Email_Notification_Lists.spray);

		Stock_BadRecords					:= Stock_N.ExpandedInFile(	
																												corp_key_Invalid							  			<> 0 or
																												corp_vendor_Invalid 									<> 0 or
																												corp_state_origin_Invalid 					 	<> 0 or
																												corp_process_date_Invalid						  <> 0 or
																												corp_sos_charter_nbr_Invalid					<> 0 or
																												stock_authorized_nbr_Invalid	 				<> 0 or
																												stock_change_date_Invalid	 						<> 0 																												
																											 );
																																														
		Stock_GoodRecords					:= Stock_N.ExpandedInFile(	
																												corp_key_Invalid							  			= 0 and
																												corp_vendor_Invalid 									= 0 and
																												corp_state_origin_Invalid 					 	= 0 and
																												corp_process_date_Invalid						  = 0 and
																												corp_sos_charter_nbr_Invalid					= 0 and
																												stock_authorized_nbr_Invalid	 				= 0 and
																												stock_change_date_Invalid	 						= 0 																												
																											 );
																														
		Stock_FailBuild						:= if(count(Stock_GoodRecords) = 0,true,false);

		Stock_ApprovedRecords			:= project(Stock_GoodRecords,transform(Corp2_Mapping.LayoutsCommon.Stock,self := left));

		Stock_ALL									:= sequential( IF(count(Stock_BadRecords) <> 0
																							,IF (poverwrite
																									,OUTPUT(Stock_BadRecords,,Corp2_Mapping._Dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::stock_'+state_origin,overwrite,__compressed__)
																									,OUTPUT(Stock_BadRecords,,Corp2_Mapping._Dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::stock_'+state_origin,__compressed__)
																									)
																							)
																					,output(Stock_ScrubsWithExamples, ALL, NAMED('CorpStockMIScrubsReportWithExamples'+filedate))
																					//Send Alerts if Scrubs exceeds thresholds
																					,IF(COUNT(Stock_ScrubsAlert) > 0, Stock_MailFile, OUTPUT('CORP2_MAPPING.MI - No "Stock" Corp Scrubs Alerts'))
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

	VersionControl.macBuildNewLogicalFile(Corp2_Mapping._dataset().thor_cluster_Files + 'in::corp2::' 	+ version + '::AR_' 		+ state_origin, AR_ApprovedRecords	 , write_ar,,,pOverwrite);
	VersionControl.macBuildNewLogicalFile(Corp2_Mapping._dataset().thor_cluster_Files + 'in::corp2::' 	+ version + '::Event_' 	+ state_origin, Event_ApprovedRecords, write_event,,,pOverwrite);
	VersionControl.macBuildNewLogicalFile(Corp2_Mapping._dataset().thor_cluster_Files + 'in::corp2::' 	+ version + '::Main_' 	+ state_origin, Main_ApprovedRecords , write_main,,,pOverwrite);
	VersionControl.macBuildNewLogicalFile(Corp2_Mapping._dataset().thor_cluster_Files + 'in::corp2::' 	+ version + '::Stock_' 	+ state_origin, Stock_ApprovedRecords, write_stock,,,pOverwrite);

	VersionControl.macBuildNewLogicalFile(Corp2_Mapping._dataset().thor_cluster_Files + 'fail::corp2::' + version + '::AR_' 		+ state_origin, AR_F		, write_fail_ar,,,pOverwrite);
	VersionControl.macBuildNewLogicalFile(Corp2_Mapping._dataset().thor_cluster_Files + 'fail::corp2::' + version + '::Event_' 	+ state_origin, Event_F	, write_fail_event,,,pOverwrite);
	VersionControl.macBuildNewLogicalFile(Corp2_Mapping._dataset().thor_cluster_Files + 'fail::corp2::' + version + '::Main_' 	+ state_origin, Main_F	, write_fail_main,,,pOverwrite);
	VersionControl.macBuildNewLogicalFile(Corp2_Mapping._dataset().thor_cluster_Files + 'fail::corp2::' + version + '::Stock_' 	+ state_origin, Stock_F	, write_fail_stock,,,pOverwrite);

	MapMI := sequential (if(pshouldspray = true,Corp2_mapping.fSprayFiles(state_origin,version,pOverwrite := pOverwrite))
											// ,Corp2_Raw_MI.Build_Bases(filedate,version,puseprod).All											
											,AR_All
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
																		 ,if (count(Main_BadRecords) <> 0 or count(AR_BadRecords) <> 0 or count(Event_BadRecords) <> 0 or count(Stock_BadRecords)<>0
																				 ,Corp2_Mapping.Send_Email(state_origin,version,count(Main_BadRecords)<>0,count(AR_BadRecords)<>0,count(Event_BadRecords)<>0,count(Stock_BadRecords)<>0,count(Main_BadRecords),count(AR_BadRecords),count(Event_BadRecords),count(Stock_BadRecords),count(Main_ApprovedRecords),count(AR_ApprovedRecords),count(Event_ApprovedRecords),count(Stock_ApprovedRecords)).RecordsRejected																				 
																				 ,Corp2_Mapping.Send_Email(state_origin,version,count(Main_BadRecords)<>0,count(AR_BadRecords)<>0,count(Event_BadRecords)<>0,count(Stock_BadRecords)<>0,count(Main_BadRecords),count(AR_BadRecords),count(Event_BadRecords),count(Stock_BadRecords),count(Main_ApprovedRecords),count(AR_ApprovedRecords),count(Event_ApprovedRecords),count(Stock_ApprovedRecords)).MappingSuccess																				 
																				 )
																		 ,if (IsScrubErrors
																				 ,Corp2_Mapping.Send_Email(state_origin,version,Main_IsScrubErrors,AR_IsScrubErrors,Event_IsScrubErrors,Stock_IsScrubErrors).FieldsInvalidPerScrubs
																				 )
																		 ) //if Fail_Build <> true																			
												 ,sequential (write_fail_ar
																		 ,write_fail_event
																		 ,write_fail_main
																		 ,write_fail_stock												 
																		 ,Corp2_Mapping.Send_Email(state_origin,version).MappingFailed
																		 ) //if Fail_Build = true
												 )
										);
										
		isFileDateValid := if((string)std.date.today() between ut.date_math(filedate,-30) and ut.date_math(filedate,30),true,false);

		return sequential (if(isFileDateValid
												 ,MapMI
												 ,sequential(Corp2_Mapping.Send_Email(state_origin,filedate).InvalidFileDateParm
																		,FAIL('Corp2_Mapping.'+state_origin+' failed.  An invalid filedate was passed in as a parameter.')
																		)
												 )
											);

	end;	// end of Update function
	
end; //end MI module