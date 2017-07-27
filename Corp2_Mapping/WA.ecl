import Corp2,ut, lib_stringlib, _validate, Address, _control, versioncontrol;
export WA := MODULE;

// WA has only one vendor layout.And record length is 467


export Layouts_Raw_Input := MODULE;
	
  export Wa_Vendor_Data := record
	
   string8  	CORP_NUMBER;
   string1  	CORP_TYPE;
   string1  	RECORD_STATUS;
   string3  	CATEGORY;
   string3  	CORP_TENURE;
   string2  	STATE_OF_INC;
   string8  	EXP_DATE;
   string8  	DATE_OF_INC;
   string60 	CORP_NAME_1;
   string60 	CORP_NAME_2;
   string60 	REG_AGENT_NAME;
   string30 	REG_ADDR_1;
   string30 	REG_ADDR_2;
   string30 	REG_ADDR_3;
   string20 	REG_CITY;
   string2  	REG_STATE;
   string9  	REG_ZIP;
   string30 	ALT_ADDR_1;
   string30 	ALT_ADDR_2;
   string30 	ALT_ADDR_3;
   string20 	ALT_ADDR_CITY;
   string2  	ALT_ADDR_STATE;
   string9  	ALT_ADDR_ZIP;
   string9  	UB_IDENTIFIER;
   string2  	lf;
 end;
  
end; 

// end of Layouts_Raw_Input module.  

	export Files_Raw_Input := MODULE;
	
		export Wavendordata (string fileDate)  := dataset('~thor_data400::in::corp2::'+fileDate+'::Wa_Vendor_Data::wa',
														     layouts_Raw_Input.Wa_Vendor_Data,flat);
	end;	
		
		
	export Files_PreCleaned := MODULE;
	
		export corpPre                     := dataset('~thor_data400::in::corp2::uncleaned::corp_wa', corp2_mapping.Layout_CorpPreClean,flat);
		
    end;
	

  export Update(string fileDate, string version, boolean pShouldSpray = _Dataset().bShouldSpray,boolean pOverwrite = false) := function
  //filename is sos_20070611.d00
  //filedate is 20070611
  
	//StateCode type layout
		
		ForgnStateDescLayout := record,MAXLENGTH(100)
               string code;
               string desc;

        end; 
    
       ForgnStateTable := dataset(_dataset().foreign_prod + 'thor_data400::lookup::corp2::corpstateprovince_table', ForgnStateDescLayout, CSV(SEPARATOR([',']), TERMINATOR(['\r\n', '\n'])));
	
	
	
	corp2_mapping.Layout_CorpPreClean wa_corpTransform(layouts_raw_input.Wa_Vendor_Data input):=transform
	        self.dt_first_seen					  :=fileDate;
			self.dt_last_seen					  :=fileDate;
			self.dt_vendor_first_reported		  :=fileDate;     
			self.dt_vendor_last_reported		  :=fileDate;
			self.corp_ra_dt_first_seen			  :=fileDate;
			self.corp_ra_dt_last_seen			  :=fileDate;
			self.corp_key					      :='53-'+trim(input.UB_IDENTIFIER,left, right);
			self.corp_vendor					  :='53';
		    self.corp_state_origin                :='WA';
			self.corp_process_date				  := fileDate;    
     	    self.corp_orig_sos_charter_nbr        :=trim(input.UB_IDENTIFIER, left, right);
			CORP_NAME1                            :=if(trim(input.CORP_NAME_1,left,right)<>'',trim(stringlib.StringtoUpperCase(input.CORP_NAME_1),left,right)+' ','');
			CORP_NAME2                            :=if(trim(input.CORP_NAME_2,left,right)<>'',trim(stringlib.StringtoUpperCase(input.CORP_NAME_2),left,right),'');
			concatFields						  := trim(CORP_NAME1+
															trim(CORP_NAME2,left,right),left,right
			                                                
														  );
			
			self.corp_legal_name                  :=concatFields;
			self.corp_internal_nbr                :=trim(input.CORP_NUMBER,left, right);
			self.corp_for_profit_ind              :=map(	
														trim(stringlib.StringtoUpperCase(input.CORP_TYPE),left,right)=  'P'  => 'Y',
														trim(stringlib.StringtoUpperCase(input.CORP_TYPE),left,right)=  'N'  => 'N',
														''
			                                           );
			self.corp_orig_bus_type_cd            :=trim(stringlib.StringtoUpperCase(input.CATEGORY),left,right);
            self.corp_orig_bus_type_desc          :=map(	
														trim(stringlib.StringtoUpperCase(input.CATEGORY),left,right)=  'SOL'=>'CORPORATION SOLE',
														trim(stringlib.StringtoUpperCase(input.CATEGORY),left,right)=  'COP'=>'COOPERATIVE ASSOCIATIONS',
														trim(stringlib.StringtoUpperCase(input.CATEGORY),left,right)=  'CRU'=>'CREDIT UNION',
														trim(stringlib.StringtoUpperCase(input.CATEGORY),left,right)=  'FBS'=>'FRATERNAL BUILDING SOCIETY',
														trim(stringlib.StringtoUpperCase(input.CATEGORY),left,right)=  'FMA'=>'FISH MARKETING ACT',
														trim(stringlib.StringtoUpperCase(input.CATEGORY),left,right)=  'FRA'=>'FRATERNAL SOCIETIES',
														trim(stringlib.StringtoUpperCase(input.CATEGORY),left,right)=  'GRG'=>'GRANGES',
							  							trim(stringlib.StringtoUpperCase(input.CATEGORY),left,right)=  'INS'=>'INSURANCE COMPANIES',
														trim(stringlib.StringtoUpperCase(input.CATEGORY),left,right)=  'LTD'=>'LIMITED PARTNERSHIPS',
														trim(stringlib.StringtoUpperCase(input.CATEGORY),left,right)=  'MAS'=>'MASSACHUSETTS TRUST',
														trim(stringlib.StringtoUpperCase(input.CATEGORY),left,right)=  'MMC'=>'MISCELLANEOUS & MUTUAL',
														trim(stringlib.StringtoUpperCase(input.CATEGORY),left,right)=  'REG'=>'REGULAR',
														trim(stringlib.StringtoUpperCase(input.CATEGORY),left,right)=  'PBC'=>'PUBLIC BENEFIT',
														trim(stringlib.StringtoUpperCase(input.CATEGORY),left,right)=  'PRO'=>'PROFESSIONAL SERVICE',
														trim(stringlib.StringtoUpperCase(input.CATEGORY),left,right)=  'PUB'=>'PUBLIC UTILITIES',
									                    trim(stringlib.StringtoUpperCase(input.CATEGORY),left,right)=  'LLP'=>'LIMITED LIABILITY PARTNERSHIP',
														trim(stringlib.StringtoUpperCase(input.CATEGORY),left,right)=  'LLC'=>'LIMITED LIABILITY COMPANY',
									                    trim(stringlib.StringtoUpperCase(input.CATEGORY),left,right)=  'BNK'=>'BANK', 
														trim(stringlib.StringtoUpperCase(input.CATEGORY),left,right)=  'MIL'=>'MILITARY',
									                    trim(stringlib.StringtoUpperCase(input.CATEGORY),left,right)=  'SAL'=>'SAVINGS AND LOAN', 
														trim(stringlib.StringtoUpperCase(input.CATEGORY),left,right)=  'PLC'=>'PROFESSIONAL LIMITED LIABILITY COMPANY',
									                        ''
									                    ); 	
			self.corp_status_cd                   :=trim(stringlib.StringtoUpperCase(input.RECORD_STATUS),left,right);
            self.corp_status_desc                 :=map(	
														trim(stringlib.StringtoUpperCase(input.RECORD_STATUS),left,right)=  'A'=>'ACTIVE',
	                   									trim(stringlib.StringtoUpperCase(input.RECORD_STATUS),left,right)=  'T'=>'INACTIVE',
																																
														''
									                    );
														
			self.corp_ln_name_type_cd             :='01';
			self.corp_ln_name_type_desc           :='LEGAL';
											
			self.corp_forgn_state_cd              :=if(trim(stringlib.StringtoUpperCase(input.STATE_OF_INC),left,right)<>'WA'
			                                            ,trim(input.STATE_OF_INC,left,right),'');
            self.corp_inc_state                   :=if(trim(stringlib.StringtoUpperCase(input.STATE_OF_INC),left,right)='WA'
			                                            ,trim(stringlib.StringtoUpperCase(input.STATE_OF_INC),left,right),'');										
			
			CORPTENURE							  :=regexreplace('[0]{1,}',trim(input.CORP_TENURE,left,right),' ') ; 
			CORPTENURE1                           :=if(regexreplace('[0]{1,}',trim(input.CORP_TENURE,left,right),' ')<>'',CORPTENURE,'');
			
		    self.corp_term_exist_cd               :=if(trim(stringlib.StringtoUpperCase(input.CORP_TENURE),left,right)<>'UNS'and
			                                           trim(stringlib.StringtoUpperCase(input.CORP_TENURE),left,right)='PER','P',
													   if(ut.isNumeric(input.CORP_TENURE) and trim(input.CORP_TENURE,left,right)<>'','N','') );
													   
			self.corp_term_exist_exp              :=if(trim(input.CORP_TENURE,left,right)<>''and ut.isNumeric(input.CORP_TENURE) and trim(stringlib.StringtoUpperCase(input.CORP_TENURE),left,right)<>'UNS' ,
													  CORPTENURE1 ,'');
			self.corp_term_exist_desc             :=if(trim(stringlib.StringtoUpperCase(input.CORP_TENURE),left,right)<>'UNS'and
			                                           trim(stringlib.StringtoUpperCase(input.CORP_TENURE),left,right)='PER','PERPETUAL','');
			
													   
			self.corp_inc_date                    :=if(	trim(input.DATE_OF_INC,left,right) <> '' and  _validate.date.fIsValid(input.DATE_OF_INC) and 
														_validate.date.fIsValid(input.DATE_OF_INC,_validate.date.rules.DateInPast) and 
														trim(stringlib.StringToUpperCase(input.STATE_OF_INC),left,right) = 'WA'AND 
																lib_stringlib.stringlib.stringfilterout(trim(Input.DATE_OF_INC,left,right),'9') <> '' AND
																(string)((integer)trim(input.DATE_OF_INC,left,right)) <> '0',
														trim(input.DATE_OF_INC,left,right),
														''
													  );
													  
            self.corp_forgn_date                  :=if(	trim(input.DATE_OF_INC,left,right) <> '' and  _validate.date.fIsValid(input.DATE_OF_INC) and 
														_validate.date.fIsValid(input.DATE_OF_INC,_validate.date.rules.DateInPast) and 
														trim(stringlib.StringToUpperCase(input.STATE_OF_INC),left,right) <>'WA'AND 
																lib_stringlib.stringlib.stringfilterout(trim(Input.DATE_OF_INC,left,right),'9') <> '' AND
																(string)((integer)trim(input.DATE_OF_INC,left,right)) <> '0',
														trim(input.DATE_OF_INC,left,right),
														''
													  );
													  
         	self.corp_address1_type_cd            :=if(trim(input.ALT_ADDR_1,left,right)<>''or trim(input.ALT_ADDR_2,left,right)<>'' or
			                                           trim(input.ALT_ADDR_3,left,right)<>'' or trim(input.ALT_ADDR_CITY,left,right)<>'' or
												       trim(input.ALT_ADDR_STATE,left,right)<>''or trim(input.ALT_ADDR_ZIP,left,right)<>'','M','');
													   
			self.corp_address1_type_desc          :=if(trim(input.ALT_ADDR_1,left,right)<>''or trim(input.ALT_ADDR_2,left,right)<>'' or
			                                           trim(input.ALT_ADDR_3,left,right)<>'' or trim(input.ALT_ADDR_CITY,left,right)<>'' or
												       trim(input.ALT_ADDR_STATE,left,right)<>''or trim(input.ALT_ADDR_ZIP,left,right)<>'','MAILING','');
			self.corp_address1_line1              :=if(trim(input.ALT_ADDR_1,left,right) <>'',trim(stringlib.StringtoUpperCase(input.ALT_ADDR_1),left,right),'');
			self.corp_address1_line2              :=if(trim(input.ALT_ADDR_2, left,right)<>'',trim(stringlib.StringtoUpperCase(input.ALT_ADDR_2), left,right),'');
			self.corp_address1_line3              :=if(trim(input.ALT_ADDR_3,left,right)<>'',trim(stringlib.StringtoUpperCase(input.ALT_ADDR_3),left,right),'');
			self.corp_address1_line4              :=if(trim(input.ALT_ADDR_CITY,left,right)<>'',trim(stringlib.StringtoUpperCase(input.ALT_ADDR_CITY),left,right) ,'');
			self.corp_address1_line5              :=if(trim(input.ALT_ADDR_STATE,left,right)<>'',trim(stringlib.StringtoUpperCase(input.ALT_ADDR_STATE),left,right),'');
			self.corp_address1_line6              :=if((string)((integer)trim(input.ALT_ADDR_ZIP,left,right)) <> '0' and trim(input.ALT_ADDR_ZIP,left,right)<>'',trim(input.ALT_ADDR_ZIP,left,right),'');
			
		    self.corp_ra_name                     :=if(trim(input.REG_AGENT_NAME,left,right)<>'',trim(stringlib.StringtoUpperCase(input.REG_AGENT_NAME),left,right),'');
		    self.corp_ra_address_line1            :=if(trim(input.REG_ADDR_1,left,right)<>'',trim(stringlib.StringtoUpperCase(input.REG_ADDR_1),left,right),'');
			self.corp_ra_address_line2            :=if(trim(input.REG_ADDR_2,left,right)<>'',trim(stringlib.StringtoUpperCase(input.REG_ADDR_2),left,right),''); 
			self.corp_ra_address_line3            :=if(trim(input.REG_ADDR_3,left,right)<>'',trim(stringlib.StringtoUpperCase(input.REG_ADDR_3),left,right),''); 
			self.corp_ra_address_line4            :=if(trim(input.REG_CITY,left,right)<>'',trim(stringlib.StringtoUpperCase(input.REG_CITY),left,right),'');
			self.corp_ra_address_line5            :=if(trim(stringlib.StringtoUpperCase(input.REG_STATE),left,right)<>'',trim(stringlib.StringtoUpperCase(input.REG_STATE),left,right),'');
			self.corp_ra_address_line6            :=if((string)((integer)trim(input.REG_ZIP,left,right)) <> '0' and trim(input.REG_ZIP,left,right)<>'',trim(input.REG_ZIP,left,right),'');
			 
			
		    self                                  := [];
			
				
  end; // end corp  transform.

	// AR_TRANSFORM M.R.
		Corp2.Layout_Corporate_Direct_AR_In WA_arTransform(layouts_raw_input.Wa_Vendor_Data input):=transform
			self.corp_key					      := '53-' +trim(input.UB_IDENTIFIER, left, right);
			self.corp_vendor				      := '53';
			self.corp_state_origin			      := 'WA';
			self.corp_process_date			      := fileDate;
			self.corp_sos_charter_nbr		      := trim(input.UB_IDENTIFIER, left, right);
			self.ar_due_dt                        :=if(trim(input.EXP_DATE,left,right)<>'' and lib_stringlib.stringlib.stringfilterout(trim(input.EXP_DATE,left,right),'9') <> '' AND
																(string)((integer)trim(input.EXP_DATE,left,right)) <> '0'and _validate.date.fIsValid(trim(input.EXP_DATE,left,right)) ,
			                                         trim(input.EXP_DATE,left,right) ,''); 										   
        	self                                  := [];
			
			

		end; // end of wa_AR_transform M.R.
		
		
		
			
		
		 //---------------------------- Clean corp Name and Addresses ---------------------//

		
		corp2.layout_corporate_direct_corp_in CleanCorpNameAddr(corp2_mapping.Layout_CorpPreClean input) := transform
			string73 tempname 					:= if (input.corp_ra_name = '', '',Address.CleanPersonFML73(input.corp_ra_name));
			pname 								:= Address.CleanNameFields(tempName);
			cname 								:= DataLib.companyclean(input.corp_ra_name);
			keepPerson 							:= corp2.Rewrite_Common.IsPerson(input.corp_ra_name);
			keepBusiness 						:= corp2.Rewrite_Common.IsCompany(input.corp_ra_name);
			
			self.corp_ra_title1					:= if(keepPerson, pname.title, '');
			self.corp_ra_fname1 				:= if(keepPerson, pname.fname, '');
			self.corp_ra_mname1 				:= if(keepPerson, pname.mname, '');
			self.corp_ra_lname1 				:= if(keepPerson, pname.lname, '');
			self.corp_ra_name_suffix1 			:= if(keepPerson, pname.name_suffix,'');
			self.corp_ra_score1 				:= if(keepPerson, pname.name_score, '');
		
			self.corp_ra_cname1 				:= if(keepBusiness, cname[1..70],'');
			self.corp_ra_cname1_score 			:= if(keepBusiness, pname.name_score,'');	
	

			
			string182 clean_address1 			:= Address.CleanAddress182(trim(trim(input.corp_address1_line1,left,right) + ' ' + 														                        
												trim(input.corp_address1_line2,left,right),left,right),														                   
												trim(trim(input.corp_address1_line3,left,right) + ', ' +
												trim(input.corp_address1_line4,left,right) + ' ' +
												trim(input.corp_address1_line5,left,right) +
												trim(input.corp_address1_line6,left,right),left,right));

			self.corp_addr1_prim_range    		:= clean_address1[1..10];
			self.corp_addr1_predir 	      		:= clean_address1[11..12];
			self.corp_addr1_prim_name 	  		:= clean_address1[13..40];
			self.corp_addr1_addr_suffix   		:= clean_address1[41..44];
			self.corp_addr1_postdir 	    	:= clean_address1[45..46];
			self.corp_addr1_unit_desig 	  		:= clean_address1[47..56];
			self.corp_addr1_sec_range 	  		:= clean_address1[57..64];
			self.corp_addr1_p_city_name	  		:= clean_address1[65..89];
			self.corp_addr1_v_city_name	  		:= clean_address1[90..114];
			self.corp_addr1_state 				:= clean_address1[115..116];
			self.corp_addr1_zip5 		    	:= clean_address1[117..121];
			self.corp_addr1_zip4 		    	:= clean_address1[122..125];
			self.corp_addr1_cart 		    	:= clean_address1[126..129];
			self.corp_addr1_cr_sort_sz 	 		:= clean_address1[130];
			self.corp_addr1_lot 		      	:= clean_address1[131..134];
			self.corp_addr1_lot_order 	  		:= clean_address1[135];
			self.corp_addr1_dpbc 		    	:= clean_address1[136..137];
			self.corp_addr1_chk_digit 	  		:= clean_address1[138];
			self.corp_addr1_rec_type		  	:= clean_address1[139..140];
			self.corp_addr1_ace_fips_st	  		:= clean_address1[141..142];
			self.corp_addr1_county 	  			:= clean_address1[143..145];
			self.corp_addr1_geo_lat 	    	:= clean_address1[146..155];
			self.corp_addr1_geo_long 	    	:= clean_address1[156..166];
			self.corp_addr1_msa 		      	:= clean_address1[167..170];
			self.corp_addr1_geo_blk				:= clean_address1[171..177];
			self.corp_addr1_geo_match 	  		:= clean_address1[178];
			self.corp_addr1_err_stat 	    	:= clean_address1[179..182];
			
			
			
			
						
			string182 clean_address 			:= Address.CleanAddress182(trim(trim(input.corp_ra_address_line1,left,right) + ' ' + 														                        
												trim(input.corp_ra_address_line2,left,right),left,right),														                   
												trim(trim(input.corp_ra_address_line3,left,right) + ', ' +
												trim(input.corp_ra_address_line4,left,right) + ' ' +
												trim(input.corp_ra_address_line5,left,right) +
												trim(input.corp_ra_address_line6,left,right),left,right));

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
			self								:= [];
		end;
		
		
		     //********cleaned corp routine ends********
			 
			 

		

		 MapCorp                        := project(Files_Raw_Input.Wavendordata(fileDate) , wa_corpTransform(left)) ;
 				
		 MapAR 						    := project(Files_Raw_Input.Wavendordata(fileDate) , wa_arTransform(left));		
               
             
				
		
		corp2_mapping.Layout_CorpPreClean findState(corp2_mapping.Layout_CorpPreClean input, ForgnStateDescLayout r ) := transform
			self.corp_forgn_state_desc  := r.desc;
			self         			    := input;
			self                        := [];
		end; 
		
		// end transform
		
			
		//StatusCode join
		
		joinStateType := 	join(	MapCorp,ForgnStateTable,
									trim(left.corp_forgn_state_cd,left,right) =  trim(right.code,left,right),
									findState(left,right),
									left outer, lookup
								);
								

								

								
		
		cleanCorps                     := project(joinStateType,CleanCorpNameAddr(left));
		
	VersionControl.macBuildNewLogicalFile('~thor_data400::in::corp2::'+version+'::corp_wa',cleanCorps	,corp_out	,,,pOverwrite);		
	VersionControl.macBuildNewLogicalFile('~thor_data400::in::corp2::'+version+'::ar_wa'	,MapAR			,ar_out		,,,pOverwrite);
		 
		 mappedwa_Filing := parallel(                                                                                                                            
			 corp_out	
			,ar_out		                            
    );        
	 
		result := 
		sequential(
			 if(pshouldspray = true,fSprayFiles('wa',filedate,pOverwrite := pOverwrite))
			,mappedwa_Filing
			,parallel(
				 fileservices.addsuperfile('~thor_data400::in::corp2::sprayed::corp','~thor_data400::in::corp2::'+version+'::corp_wa')			  
				,fileservices.addsuperfile('~thor_data400::in::corp2::sprayed::ar'	,'~thor_data400::in::corp2::'+version+'::ar_wa')
			)
		);      
							
		return result;
		
	end;					 
	
end; // end of wa module
