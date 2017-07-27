import Corp2, _validate, Address, _control, versioncontrol;

export DC := MODULE;
	
	export Layouts_Raw_Input := MODULE;

		// DC only has one vendor layout.
		export corporations := record,MAXLENGTH(13000)
			string 	 FILE_NO;
			string	 AGENT_NAME;
			string   CORP_NAME;
			string 	 AGENT_ADDRESS;
			string 	 AGENT_ZIP;
			string 	 STATUS;  
			string 	 TYPE_CODE;
			string   INC_DATE;      //     M/D/CCYY
			string   INC_STATE;									 			
		end;
		
	end; // end of Layouts_Raw_Input module
	
	export Files_Raw_Input := MODULE;
	    
		// vendor file definition
		export corporations(string filedate) := dataset('~thor_data400::in::corp2::'+filedate+'::corporations::dc',	
		layouts_Raw_Input.corporations,CSV(HEADING(1),MAXLENGTH(13000),SEPARATOR([',']),TERMINATOR(['\n','\r\n','\n\r'])));
									 
	end;
	
	export Update(string fileDate, string version, boolean pShouldSpray = _Dataset().bShouldSpray, boolean pOverwrite = false) := function
	
		trimUpper(string s) := function
			return trim(stringlib.StringToUppercase(s),left,right);
		end;
		
		reformatDate(string inDate) := function
			string clean_inDate := trim(regexreplace('0:00',inDate,''),left,right);
			string2 outMM := if(clean_inDate[2] = '/',
								'0'+ clean_inDate[1],
								clean_inDate[1..2]);
			string2 outDD := if(clean_inDate[length(clean_inDate)-6] = '/',
								'0'+ clean_inDate[length(clean_inDate)-5],
								clean_inDate[length(clean_inDate)-6..length(clean_inDate)-5]);
			string8 newDate := clean_inDate[length(clean_inDate)-3..]+outMM+outDD;	
			return newDate;	
		end;	

		ForgnStateDescLayout := record,MAXLENGTH(100)
			string code;
			string desc;
		end; 
	
		ForgnStateTable := dataset(_dataset().foreign_prod + 'thor_data400::lookup::corp2::corpstateprovince_table', ForgnStateDescLayout, CSV(SEPARATOR([',']), TERMINATOR(['\r\n', '\n'])));
		
		corp2_mapping.Layout_CorpPreClean corpTransform(Layouts_Raw_Input.corporations input, ForgnStateDescLayout r ) := transform

			self.dt_first_seen					:= fileDate;
			self.dt_last_seen					:= fileDate;
			self.dt_vendor_first_reported		:= fileDate;
			self.dt_vendor_last_reported		:= fileDate;
			self.corp_ra_dt_first_seen			:= fileDate;
			self.corp_ra_dt_last_seen			:= fileDate;			
			self.corp_key						:= '11-' + trim(input.file_no,left,right);
			self.corp_vendor					:= '11';
			self.corp_state_origin				:= 'DC';
			self.corp_process_date				:= fileDate;
			self.corp_orig_sos_charter_nbr		:= trim(input.file_no,left,right);
			self.corp_src_type					:= 'SOS';						
			self.corp_legal_name				:= trimUpper(input.corp_name); 														
			self.corp_ln_name_type_cd			:= '01';													   
			self.corp_ln_name_type_desc			:= 'LEGAL';																							
			self.corp_status_cd					:= trimUpper(input.status);
			self.corp_status_desc				:= map(	
														trimUpper(input.status) = 'AC'  => 'ACTIVE',
														trimUpper(input.status) = 'CAN' => 'CANCELLED',
														trimUpper(input.status) = 'CO'  => 'CONSOLIDATED',
														trimUpper(input.status) = 'DS'  => 'DISSOLVED',														
														trimUpper(input.status) = 'EXP' => 'EXPIRED',
														trimUpper(input.status) = 'MG'  => 'MERGED',
														trimUpper(input.status) = 'OA'  => 'OLD ACT',
														trimUpper(input.status) = 'OK'  => 'APPROVED',
														trimUpper(input.status) = 'PD'  => 'PENDING',
														trimUpper(input.status) = 'RJ'  => 'REJECTED',
														trimUpper(input.status) = 'RV'  => 'REVOKED',
														trimUpper(input.status) = 'UK'  => 'UNKNOWN',
														trimUpper(input.status) = 'WD'  => 'WITHDRAWAL',
														''
													   );						
			self.corp_inc_state					:= if(trimUpper(input.inc_state) = 'DC',
			                                          'DC',
													  ''
												   );												   
			self.corp_forgn_state_cd            := if(trimUpper(input.inc_state) <> 'DC',
			                                          trimUpper(input.inc_state),
													  ''
												   );
			self.corp_forgn_state_desc          := if(trimUpper(input.inc_state) <> 'DC',
			                                          trimUpper(r.desc),
													  ''
												   );
			self.corp_ra_name					:= trimUpper(input.agent_name);						
			self.corp_ra_address_line1			:= trimUpper(input.agent_address);
			self.corp_ra_address_line2			:= input.agent_zip;			
			self.corp_inc_date                  := if(trimUpper(input.inc_state) = 'DC' and 
													  trim(input.inc_date,left,right) <> '' and 
													  _validate.date.fIsValid(reformatDate(input.inc_date)) and 
													  _validate.date.fIsValid(reformatDate(input.inc_date),_validate.date.rules.DateInPast),
											          reformatDate(input.inc_date),
													  ''
												    );														
			self.corp_forgn_date 				:= if(trimUpper(input.inc_state) <> 'DC' and 
													  trim(input.inc_date,left,right) <> '' and 
													  _validate.date.fIsValid(reformatDate(input.inc_date)) and 
													  _validate.date.fIsValid(reformatDate(input.inc_date),_validate.date.rules.DateInPast),
											          reformatDate(input.inc_date),
													  ''
												    );													
			self.corp_orig_org_structure_cd     := TrimUpper(input.type_code);
			self.corp_orig_org_structure_desc   := map(	
														trimUpper(input.type_code) = 'DBU' => 'DOMESTIC BUSINESS',
														trimUpper(input.type_code) = 'DCO' => 'DOMESTIC COOPERATIVE',
														trimUpper(input.type_code) = 'DLC' => 'DOMESTIC LIABILITY COMPANY',
														trimUpper(input.type_code) = 'DLP' => 'DOMESTIC LIABILITY PROFESSIONAL COMPANY',														
														trimUpper(input.type_code) = 'DNP' => 'DOMESTIC NON PROFIT',
														trimUpper(input.type_code) = 'DPL' => 'DOMESTIC LIABILITY PROFESSIONAL COMPANY',
														trimUpper(input.type_code) = 'DPR' => 'DOMESTIC PROFESSIONAL',
														trimUpper(input.type_code) = 'FBU' => 'FOREIGN BUSINESS',
														trimUpper(input.type_code) = 'FCO' => 'FOREIGN COOPERATIVE',
														trimUpper(input.type_code) = 'FLC' => 'FOREIGN LIABILITY COMPANY',
														trimUpper(input.type_code) = 'FLP' => 'FOREIGN LIABILITY PROFESSIONAL COMPANY',
														trimUpper(input.type_code) = 'FNP' => 'FOREIGN NON PROFIT',
														trimUpper(input.type_code) = 'FPR' => 'FOREIGN PROFESSIONAL',																												
														''
													   );														   			
			self := [];
						
		end; // end Corp Transform
				
		
		Corp2.Layout_Corporate_Direct_Corp_In CleanAddrName(corp2_mapping.Layout_CorpPreClean input) := transform		
			string73 tempname 					:= if(input.corp_ra_name = '', '', Address.CleanPersonFML73(input.corp_ra_name));
			pname 								:= Address.CleanNameFields(tempName);
			cname 								:= DataLib.companyclean(input.corp_ra_name);
			keepPerson 							:= corp2.Rewrite_Common.IsPerson(input.corp_ra_name);
			keepBusiness 						:= corp2.Rewrite_Common.IsCompany(input.corp_ra_name);
			
			self.corp_ra_title1					:= if(keepPerson, pname.title, '');
			self.corp_ra_fname1 				:= if(keepPerson, pname.fname, '');
			self.corp_ra_mname1 				:= if(keepPerson, pname.mname, '');
			self.corp_ra_lname1 				:= if(keepPerson, pname.lname, '');
			self.corp_ra_name_suffix1 			:= if(keepPerson, pname.name_suffix, '');
			self.corp_ra_score1 				:= if(keepPerson, pname.name_score, '');
		
			self.corp_ra_cname1 				:= if(keepBusiness, cname[1..70],'');
			self.corp_ra_cname1_score 			:= if(keepBusiness, pname.name_score, '');	
			
			string182 clean_address 			:= Address.CleanAddress182(trim(input.corp_ra_address_line1,left,right), 
														                   trim(input.corp_ra_address_line2,left,right)																																					
														                   );	
			self.corp_ra_prim_range    			:= clean_address[1..10];
			self.corp_ra_predir 	      		:= clean_address[11..12];
			self.corp_ra_prim_name 	  			:= clean_address[13..40];
			self.corp_ra_addr_suffix   			:= clean_address[41..44];
			self.corp_ra_postdir 	    		:= clean_address[45..46];
			self.corp_ra_unit_desig 	  		:= clean_address[47..56];
			self.corp_ra_sec_range 	  			:= clean_address[57..64];
			self.corp_ra_p_city_name	  		:= clean_address[65..89];
			self.corp_ra_v_city_name	  		:= clean_address[90..114];
			self.corp_ra_state 			      	:= clean_address[115..116];
			self.corp_ra_zip5 		      		:= clean_address[117..121];
			self.corp_ra_zip4 		      		:= clean_address[122..125];
			self.corp_ra_cart 		      		:= clean_address[126..129];
			self.corp_ra_cr_sort_sz 	 		:= clean_address[130];
			self.corp_ra_lot 		      		:= clean_address[131..134];
			self.corp_ra_lot_order 	  			:= clean_address[135];
			self.corp_ra_dpbc 		      		:= clean_address[136..137];
			self.corp_ra_chk_digit 	  			:= clean_address[138];
			self.corp_ra_rec_type		  		:= clean_address[139..140];
			self.corp_ra_ace_fips_st	  		:= clean_address[141..142];
			self.corp_ra_county 	  			:= clean_address[143..145];
			self.corp_ra_geo_lat 	    		:= clean_address[146..155];
			self.corp_ra_geo_long 	    		:= clean_address[156..166];
			self.corp_ra_msa 		      		:= clean_address[167..170];
			self.corp_ra_geo_blk				:= clean_address[171..177];
			self.corp_ra_geo_match 	  			:= clean_address[178];
			self.corp_ra_err_stat 	    		:= clean_address[179..182];
			self								:= input;
			self 								:= [];
		end;						
		
		corps1 := join(Files_Raw_Input.corporations(filedate), ForgnStateTable,
							trimUpper(left.inc_state) = right.code,
							corpTransform(left,right),
							left outer, lookup);
		
		cleanCorps := project(corps1, CleanAddrName(left));

	versionControl.macBuildNewLogicalFile('~thor_data400::in::corp2::'+version+'::corp_dc' ,cleanCorps	,corp_out		,,,pOverwrite);		
	
		                                                                                                                                                       
	result := 
		sequential(
			 if(pshouldspray = true,fSprayFiles('dc',filedate,pOverwrite := pOverwrite))
			,corp_out
			,fileservices.addsuperfile('~thor_data400::in::corp2::sprayed::corp','~thor_data400::in::corp2::'+version+'::corp_dc')
		);

		return result;
	end;
	
	
end; // end of DC module