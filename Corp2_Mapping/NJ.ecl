 import ut, lib_stringlib, _validate, Address, corp2, _control, versioncontrol;

export NJ := MODULE

	export Layouts_Raw_Input := MODULE
		
	// VENDOR DATA STARTS

	export BUSINESS	:= record, MAXLENGTH(1000)

		string Business_ID;
		string Business_Name;
		string Status;
		string Filing_Date;
		string Registered_Agent;
		string Registered_Office_Address;
		string Registered_Office_Address2;
		string Registered_Office_City;
		string Registered_Office_State;
		string Registered_Office_Zip;
		string Registered_Office_Zip_Ext;
		string Main_Business_Address;
		string Main_Business_Address2;
		string Main_Business_City;
		string Main_Business_State;
		string Main_Business_Zip;
		string Main_Business_Zip_Ext;
		string Principal_Business_Address;
		string Principal_Business_Address2;
		string Principal_Business_City;
		string Principal_Business_State;
		string Principal_Business_Zip;
		string Principal_Business_Zip_Ext;
		string Last_Annual_Report_Filed;

	end;	

  end;//end of Layouts_Raw_Input module

	export Files_Raw_Input := MODULE
	
		
		export BUSINESS (string fileDate)     := dataset('~thor_data400::in::corp2::'+fileDate+'::BUSINESS::NJ',
														     layouts_Raw_Input.BUSINESS,CSV(HEADING(1),SEPARATOR([',']), TERMINATOR(['\r\n', '\n'])));																	 
				
			
	end;	
	
					   
    			

  export Update(string fileDate, string version, boolean pShouldSpray = _Dataset().bShouldSpray, boolean pOverwrite = false) := function
			


	corp2_mapping.Layout_CorpPreClean NJ_corpMainTransform(layouts_raw_input.BUSINESS  input):= transform

		self.dt_vendor_first_reported	:= fileDate;
		self.dt_vendor_last_reported	:= fileDate;
		self.dt_first_seen				:= fileDate;
		self.dt_last_seen				:= fileDate;
		self.corp_ra_dt_first_seen		:= fileDate;
		self.corp_ra_dt_last_seen		:= fileDate;
		
		self.corp_key					:= '34-' +trim(input.BUSINESS_ID, left, right);
		
		self.corp_vendor				:= '34';
		
		self.corp_state_origin			:= 'NJ';
		self.corp_process_date			:= fileDate;
		self.corp_orig_sos_charter_nbr	:=  input.BUSINESS_ID;
				
		self.corp_src_type				:= 'SOS';
	
		statusDesc						:= map(trim(stringlib.StringtoUpperCase(input.STATUS),left,right)='ACT'=>'ACTIVE',
			                                          trim(stringlib.StringtoUpperCase(input.STATUS),left,right)='CAN'=>'CANCELLED',
										trim(stringlib.StringtoUpperCase(input.STATUS),left,right)='DBB'=>'DISSOLVED BEFORE COMMENCING BUSINESS',
										trim(stringlib.StringtoUpperCase(input.STATUS),left,right)='EXP'=>'EXPUNGED',
										trim(stringlib.StringtoUpperCase(input.STATUS),left,right)='XFR'=>'EXPUNGED FOREIGN',
										trim(stringlib.StringtoUpperCase(input.STATUS),left,right)='XPG'=>'EXPUNGED',
													   '');
															



		self.corp_status_cd				:=  if ( trim(input.STATUS,left, right) <> '',trim(stringlib.StringtoUpperCase(input.STATUS),left, right),'');

		self.corp_status_desc				:= if ( trim(statusDesc,left, right)<>'',trim(stringlib.StringtoUpperCase(statusDesc),left, right),'');

		filingDate							:= if ( trim( input.filing_DATE,left,right) <> '',
											input.filing_DATE[7..10] +
											input.filing_DATE[1..2] +
											input.filing_DATE[4..5],'');

		
		self.corp_filing_date				:= if ( filingDate <> '' and
											_validate.date.fIsValid(filingDate),filingDate,'');  

		self.corp_legal_name				:= if (trim(input.Business_Name,left,right) <> '', trim(stringlib.StringtoUpperCase(input.Business_Name),left,right),'');

		self.corp_ln_name_type_cd			:= '01';

		self.corp_ln_name_type_desc			:= 'LEGAL';




		self.corp_address1_type_cd			:= if (trim(input.Main_Business_Address,left,right) <> '' or
											trim(input.Main_Business_Address2,left,right) <> '' or
											trim(input.Main_Business_CITY,left,right) <> '' or
											trim(input.Main_Business_STATE,left,right) <> '' or
											trim(input.Main_Business_Zip,left,right) <> '','B','');


		self.corp_address1_type_desc		:= if (trim(input.Main_Business_Address,left,right) <> '' or
											trim(input.Main_Business_Address2,left,right) <> '' or
											trim(input.Main_Business_CITY,left,right) <> '' or
											trim(input.Main_Business_STATE,left,right) <> '' or
											trim(input.Main_Business_Zip,left,right) <> '','BUSINESS','');

		self.corp_address1_line1			:= trim(stringlib.StringtoUpperCase(input.Main_Business_Address),left, right);
		self.corp_address1_line2			:= trim(stringlib.StringtoUpperCase(input.Main_Business_Address2),left, right);
		self.corp_address1_line3			:= trim(stringlib.StringtoUpperCase(input.Main_Business_City),left, right);
		self.corp_address1_line4			:= trim(stringlib.StringtoUpperCase(input.Main_Business_State),left, right);
		
		zipCode								:=  if ( trim(input.MAIN_BUSINESS_ZIP,left, right) <>'',trim(input.MAIN_BUSINESS_ZIP,left, right),'');

		zipCodeExt							:= if ( trim(input.MAIN_BUSINESS_ZIP_EXT,left,right) <> '', zipCode + '-' + trim(input.MAIN_BUSINESS_ZIP_EXT,left,right),'');
		
		self.corp_address1_line5			:= if ( trim(zipCodeExt,left, right) <>'',zipCodeExt,'');




	
		self.corp_ra_name					:= if (trim(input.REGISTERED_AGENT,left,right) <> '',trim(stringlib.StringtoUpperCase(input.REGISTERED_AGENT),left,right),'');

		//added
		
		self.CORP_RA_ADDRESS_TYPE_DESC      := if (trim(input.REGISTERED_OFFICE_ADDRESS,left,right) <> '' or
											trim(input.REGISTERED_OFFICE_ADDRESS2,left,right) <> '' or
											trim(input.REGISTERED_OFFICE_CITY,left,right) <> '' or
											trim(input.REGISTERED_OFFICE_STATE,left,right) <> '' or
											trim(input.REGISTERED_OFFICE_ZIP,left,right) <> '','REGISTERED OFFICE','');



		self.corp_ra_address_line1			:= trim(stringlib.StringtoUpperCase(input.REGISTERED_OFFICE_ADDRESS),left, right);
		
		self.corp_ra_address_line2			:= trim(stringlib.StringtoUpperCase(input.REGISTERED_OFFICE_ADDRESS2),left, right);
		
		self.corp_ra_address_line3			:= trim(stringlib.StringtoUpperCase(input.REGISTERED_OFFICE_CITY),left, right);
	
		self.corp_ra_address_line4			:= trim(stringlib.StringtoUpperCase(input.REGISTERED_OFFICE_STATE),left, right);
	
		zipCodeRa							:=  if ( trim(input.REGISTERED_OFFICE_ZIP,left, right) <>'',trim(input.REGISTERED_OFFICE_ZIP,left, right),'');

		zipCodeExtRa						:= if ( trim(input.REGISTERED_OFFICE_ZIP_EXT,left,right) <> '', zipCodeRa + '-' + trim(input.REGISTERED_OFFICE_ZIP_EXT,left,right),'');




		self.corp_ra_address_line5			:= if ( trim(zipCodeExtRa,left, right) <>'',zipCodeExtRa,'');




		
				
		self								:=[];

	end;//end of NJ corp transform

	


	
	
	//**************************************************************** Cleaning starts.****************
		

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
	

			
			

			string182 clean_address1 		:= Address.CleanAddress182(trim(trim(input.corp_address1_line1,left,right) + ' ' +													                        
											                          trim(input.corp_address1_line2,left,right),left,right), 
											                          trim(input.corp_address1_line3,left,right) + ', ' +
											                          trim(input.corp_address1_line4,left,right) + ' ' +
											                          trim(input.corp_address1_line5,left,right));


			

			
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
			
			
			
			
			string182 clean_address			:= Address.CleanAddress182(trim(trim(input.corp_ra_address_line1,left,right) + ' ' +													                        
											                          trim(input.corp_ra_address_line2,left,right),left,right), 
											                          trim(input.corp_ra_address_line3,left,right) + ', ' +
											                          trim(input.corp_ra_address_line4,left,right) + ' ' +
											                          trim(input.corp_ra_address_line5,left,right));
				
	
											
	
											
											
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
		

		//************************cleaning ends***************************************

	

		MapCorp				:= project(Files_Raw_Input.BUSINESS(fileDate), NJ_corpMainTransform(left));
		
		cleanCorp := project(MapCorp , CleanCorpNameAddr(left));

		
	VersionControl.macBuildNewLogicalFile('~thor_data400::in::corp2::'+version+'::corp_nj'	,cleanCorp	,corp_out		,,,pOverwrite);		
                                                                                                                                                         
		mappedNJ_Filing := corp_out;
							
		result := 
		sequential(
			 if(pshouldspray = true,fSprayFiles('nj',filedate,pOverwrite := pOverwrite))
			,mappedNJ_Filing
			,parallel(
				 fileservices.addsuperfile('~thor_data400::in::corp2::sprayed::corp','~thor_data400::in::corp2::'+version+'::corp_nj')
			)
		);

		return result;



		
  end;// end of update function     

end; // Module nj28
 
 
