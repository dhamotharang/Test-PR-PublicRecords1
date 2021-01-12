Import _control, corp2, corp2_raw_ar, scrubs, scrubs_corp2_mapping_ar_main, tools, ut, versioncontrol, std;

//NOTE: The ARKANSAS module cannot be abbreviated to "AR" because of a compiler issue that causes a conflict with
//			corp2_mapping.LayoutsCommon.AR.

Export ARKANSAS	:= Module

	export Update( string fileDate,string version, boolean pShouldSpray = _Dataset().bShouldSpray, boolean pOverwrite = false,pUseProd = Tools._Constants.IsDataland) :=Function

		state_origin		 :='AR';
		state_fips	 		 :='05';	
		state_desc	 		 :='ARKANSAS';	
		
		ds_CorpData   	 :=dedup(sort(distribute(corp2_raw_ar.Files(filedate,pUseProd).input.CorpData.logical,hash(filing_number)),record,local),record,local) : independent;
		ds_CorpNames     :=dedup(sort(distribute(corp2_raw_ar.Files(filedate,pUseProd).input.CorpNames.Logical,hash(filing_number)),record,local),record,local) : independent;
		ds_CorpOfficer   :=dedup(sort(distribute(corp2_raw_ar.Files(filedate,pUseProd).input.CorpOfficer.Logical,hash(filing_number)),record,local),record,local): independent; 
				
		domestic_List    :=['1','2','3','4','5','6','7','8','9','10','11','23','24','25','26','27','29','30','32','135','320','330','360','370','401','501'];
		foreign_List     :=['13','14','15','16','17','18','19','20','21','22','31'];
		
		invalid_fho_address 	:= corp2.t2u(ds_CorpData.fho_address1) not in ['X',''] and
														 corp2.t2u(ds_CorpData.fho_address2) 		 in ['X',''] and 
														 corp2.t2u(ds_CorpData.fho_city) 		 		 in ['X',''] and 
														 corp2.t2u(ds_CorpData.fho_state) 	 		 in ['X',''] and 
														 corp2.t2u(ds_CorpData.fho_zip) 		 		 in ['X',''];
												 
		FixFHOAddress		 			:= ds_CorpData(invalid_fho_address);
		FHOAddresses			 		:= ds_CorpData(not(invalid_fho_address)):independent;
		
		FHOCommaDelimited 		:= FixFHOAddress(stringlib.stringfind(fho_address1,',',1)<>0);
		FHONotCommaDelimited  := FixFHOAddress(stringlib.stringfind(fho_address1,',',1) =0);

		//FIX FHO ADDRESSES
		//This transform's goal is to fix those fho addresses that are "not comma delimited" and the entire address exists in fho_address1
		corp2_raw_ar.Layouts.CorpDataLayoutIn	 Fix1FHOAddressTransform(corp2_raw_ar.Layouts.CorpDataLayoutIn  input):= transform	
			self.fho_zip					 						:= corp2_raw_ar.Functions.FixZip(input.fho_zip,input.fho_address1);
			self.fho_state										:= corp2_raw_ar.Functions.FixState(input.fho_zip,self.fho_zip,input.fho_state,input.fho_address1);
			temp_address1											:= corp2_raw_ar.Functions.FixAddr1(input.fho_zip,self.fho_zip,input.fho_state,self.fho_state,input.fho_address1);
			self.fho_address1									:= stringlib.splitwords(temp_address1,'|',false)[1];
			temp_city													:= corp2_raw_ar.Functions.FixCity(input.fho_city,input.fho_address1);
			self.fho_city											:= if(temp_city='',stringlib.splitwords(temp_address1,'|',false)[2],temp_city);
			self															:= input;
		end;
		
		FHOFixedNotCommaDelimited		:= project(FHONotCommaDelimited,Fix1FHOAddressTransform(left)):independent;
		
		//This transform's goal is to fix those fho addresses that are "comma delimited" and the entire address exists in fho_address1
		corp2_raw_ar.Layouts.CorpDataLayoutIn	 Fix2FHOAddressTransform(corp2_raw_ar.Layouts.CorpDataLayoutIn  input):= transform	
			temp_address											:= corp2_raw_ar.Functions.FixAddress(input.fho_address1);
			self.fho_address1									:= if(stringlib.splitwords(temp_address,'|',false)[1]<>'NONE',stringlib.splitwords(temp_address,'|',false)[1],'');
			self.fho_city											:= if(stringlib.splitwords(temp_address,'|',false)[2]<>'NONE',stringlib.splitwords(temp_address,'|',false)[2],'');
			self.fho_state										:= if(stringlib.splitwords(temp_address,'|',false)[3]<>'NONE',stringlib.splitwords(temp_address,'|',false)[3],'');
			self.fho_zip					 						:= if(stringlib.splitwords(temp_address,'|',false)[4]<>'NONE',stringlib.splitwords(temp_address,'|',false)[4],'');
			self															:= input;
		end;
		
		FHOFixedCommaDelimited	:= project(FHOCommaDelimited,Fix2FHOAddressTransform(left)):independent;

		FHOFixedAddress					:= FHOFixedCommaDelimited + FHOFixedNotCommaDelimited + FHOAddresses:independent;

		//FIX AGENT ADDRESSES	
		invalid_agent_address 	:= corp2.t2u(FHOFixedAddress.agent_address1) not in ['X',''] and
															 corp2.t2u(FHOFixedAddress.agent_address2) 		 in ['X',''] and 
															 corp2.t2u(FHOFixedAddress.agent_city) 		 		 in ['X',''] and 
															 corp2.t2u(FHOFixedAddress.agent_state) 	 		 in ['X',''] and 
															 corp2.t2u(FHOFixedAddress.agent_zip) 		 		 in ['X',''];
											 
		AgentFixAddress	 				:= FHOFixedAddress(invalid_agent_address);
		AgentAddresses		 			:= FHOFixedAddress(not(invalid_agent_address)):independent;
		
		AgentCommaDelimited 		:= AgentFixAddress(stringlib.stringfind(agent_address1,',',1)<>0);
		AgentNotCommaDelimited 	:= AgentFixAddress(stringlib.stringfind(agent_address1,',',1) =0);
	
		//This transform's goal is to fix those agent addresses that are "not comma delimited" and the entire address exists in agent_address1
		corp2_raw_ar.Layouts.CorpDataLayoutIn	 Fix1AgentAddressTransform(corp2_raw_ar.Layouts.CorpDataLayoutIn  input):= transform	
			self.agent_zip					 					:= corp2_raw_ar.Functions.FixZip(input.agent_zip,input.agent_address1);
			self.agent_state									:= corp2_raw_ar.Functions.FixState(input.agent_zip,self.agent_zip,input.agent_state,input.agent_address1);
			temp_address1											:= corp2_raw_ar.Functions.FixAddr1(input.agent_zip,self.agent_zip,input.agent_state,self.agent_state,input.agent_address1);
			self.agent_address1								:= stringlib.splitwords(temp_address1,'|',false)[1];
			temp_city													:= corp2_raw_ar.Functions.FixCity(input.agent_city,input.agent_address1);
			self.agent_city										:= if(temp_city='',stringlib.splitwords(temp_address1,'|',false)[2],temp_city);
			self															:= input;
		end;
		
		AgentFixedNotCommaDelimited	:= project(AgentNotCommaDelimited,Fix1AgentAddressTransform(left)):independent;
		
		//This transform's goal is to fix those agent addresses that are "comma delimited" and the entire address exists in fho_address1
		corp2_raw_ar.Layouts.CorpDataLayoutIn	 Fix2AgentAddressTransform(corp2_raw_ar.Layouts.CorpDataLayoutIn  input):= transform	
			temp_address											:= corp2_raw_ar.Functions.FixAddress(input.fho_address1);
			self.fho_address1									:= if(stringlib.splitwords(temp_address,'|',false)[1]<>'NONE',stringlib.splitwords(temp_address,'|',false)[1],'');
			self.fho_city											:= if(stringlib.splitwords(temp_address,'|',false)[2]<>'NONE',stringlib.splitwords(temp_address,'|',false)[2],'');
			self.fho_state										:= if(stringlib.splitwords(temp_address,'|',false)[3]<>'NONE',stringlib.splitwords(temp_address,'|',false)[3],'');
			self.fho_zip					 						:= if(stringlib.splitwords(temp_address,'|',false)[4]<>'NONE',stringlib.splitwords(temp_address,'|',false)[4],'');
			self															:= input;
		end;
		
		AgentFixedCommaDelimited			:= project(AgentCommaDelimited,Fix2AgentAddressTransform(left)):independent;

		FixedAddress									:= AgentFixedCommaDelimited + AgentFixedNotCommaDelimited + AgentAddresses:independent;	
	
		corp2_mapping.LayoutsCommon.Main 	corpDataMainTransform(corp2_raw_ar.Layouts.CorpDataLayoutIn  input):= transform

			self.dt_vendor_first_reported			:= (integer)fileDate;
			self.dt_vendor_last_reported			:= (integer)fileDate;
			self.dt_first_seen								:= (integer)fileDate;
			self.dt_last_seen									:= (integer)fileDate;
			self.corp_ra_dt_first_seen				:= (integer)fileDate;
			self.corp_ra_dt_last_seen					:= (integer)fileDate;
			self.corp_process_date						:= fileDate;
			self.corp_key											:= state_fips+'-'+corp2.t2u(input.filing_number);		
			self.corp_vendor									:= state_fips;		
			self.corp_state_origin						:= state_origin;
			self.corp_inc_state 							:= state_origin; 
			self.corp_orig_sos_charter_nbr		:= corp2.t2u(input.filing_number);
			self.corp_legal_name							:= corp2_mapping.fCleanBusinessName(state_origin,state_desc,input.Corporation_Name).BusinessName;
			self.corp_ln_name_type_cd					:= map( corp2.t2u(input.corp_type_id)in['26','29']=>'07',
																								corp2.t2u(input.corp_type_id)='27'				=>'09',
																								corp2.t2u(input.corp_type_id)='32'				=>'03',
																								'01');
			self.corp_ln_name_type_desc				:= map( corp2.t2u(input.corp_type_id)in['26','29']=>'RESERVED',
																								corp2.t2u(input.corp_type_id)='27'				=>'REGISTRATION',
																								corp2.t2u(input.corp_type_id)='32'				=>'TRADEMARK',
																								'LEGAL');		
			self.corp_orig_org_structure_cd		:= if(trim(input.corp_type_id,left,right) not in['26','27','29','32','135','360','370','501'],trim(input.corp_type_id,left,right), '') ;	//new codes will be caught through scrubs																	
			self.corp_orig_org_structure_desc	:= corp2_raw_ar.Functions.OrgStrucDesc(self.corp_orig_org_structure_cd);
			self.corp_status_cd								:= corp2.t2u(input.Corp_Status);//new codes will be caught through scrubs
			self.corp_status_desc							:= corp2_raw_ar.Functions.StatusDesc(input.Corp_Status);
			self.corp_standing						  	:= if(trim(input.Corp_Status,left,right)='1' ,'Y','');
			self.corp_filing_date							:= corp2_mapping.fValidateDate(input.Date_Filed).PastDate;																			
			self.corp_foreign_domestic_ind  	:= map(trim(input.corp_type_id,left,right)in domestic_List=>'D', 
																							 trim(input.corp_type_id,left,right)in foreign_List =>'F',
																							'');																		
			self.corp_inc_date								:= if(trim(self.corp_foreign_domestic_ind)='D',corp2_mapping.fValidateDate(input.Date_Incorporated).PastDate,'');
			self.corp_forgn_date							:= if(trim(self.corp_foreign_domestic_ind)='F',corp2_mapping.fValidateDate(input.Date_Incorporated).PastDate,'');
			self.corp_forgn_state_cd					:= if(corp2.t2u(input.State_of_Organization) not in ['','ARKANSAS','AR'] ,corp2_raw_ar.Functions.StateCode(input.State_of_Organization),''); 
			self.corp_forgn_state_desc				:= corp2_raw_ar.Functions.StateDesc(self.corp_forgn_state_cd);//we have 2&3 Character codes in the raw data
			self.Corp_country_of_formation		:= corp2_raw_ar.Functions.GetCountryDesc(input.Foreign_Country);
			temp_ra_fname											:= corp2_mapping.fCleanPersonName(state_origin,state_desc,input.Agent_First_Name,input.Agent_Middle_Name,input.Agent_Last_Name).FirstName;		
			temp_ra_mname											:= corp2_mapping.fCleanPersonName(state_origin,state_desc,input.Agent_First_Name,input.Agent_Middle_Name,input.Agent_Last_Name).MiddleName;
			temp_ra_lname											:= corp2_mapping.fCleanPersonName(state_origin,state_desc,input.Agent_First_Name,input.Agent_Middle_Name,input.Agent_Last_Name).LastName;
			temp_ra_suffix                  	:= corp2_raw_ar.Functions.SuffixDesc(input.Agent_suffix_id);
			self.corp_ra_full_name						:= if(Corp2.t2u(input.Registered_Agent)not in['SEE FILE','SEEFILE','SAME','X','N/A','','<NONE>','NONE','NO AGENT NAME','AGENT RESIGNED' ]  ,
																							corp2_mapping.fCleanBusinessName(state_origin,state_desc,regexreplace('\\x80',input.Registered_Agent,' ')).BusinessName,// Replaces Ã¢â€šÂ¬ characters with blanks !
																							corp2_mapping.fCleanBusinessName(state_origin,state_desc,corp2.t2u(temp_ra_fname + ' ' + temp_ra_mname + ' ' +temp_ra_lname + ' ' +temp_ra_suffix)).BusinessName
																							);		
			self.corp_ra_address_line1      	:= corp2_mapping.fCleanAddress(state_origin,state_desc,input.Agent_Address1,input.Agent_Address2,input.Agent_city,input.Agent_State,input.Agent_zip).AddressLine1;
			self.corp_ra_address_line2				:= corp2_mapping.fCleanAddress(state_origin,state_desc,input.Agent_Address1,input.Agent_Address2,input.Agent_city,input.Agent_State,input.Agent_zip).AddressLine2;
			self.corp_ra_address_line3				:= corp2_mapping.fCleanAddress(state_origin,state_desc,input.Agent_Address1,input.Agent_Address2,input.Agent_city,input.Agent_State,input.Agent_zip).AddressLine3;;
			self.ra_prep_addr_line1						:= corp2_mapping.fCleanAddress(state_origin,state_desc,input.Agent_Address1,input.Agent_Address2,input.Agent_city,input.Agent_State,input.Agent_zip).PrepAddrLine1;
			self.ra_prep_addr_last_line				:= corp2_mapping.fCleanAddress(state_origin,state_desc,input.Agent_Address1,input.Agent_Address2,input.Agent_city,input.Agent_State,input.Agent_zip).PrepAddrLastLine;
			self.corp_ra_address_type_cd			:= if(corp2_mapping.fAddressExists(state_origin,state_desc,input.Agent_Address1,input.Agent_Address2,input.Agent_city,input.Agent_State,input.Agent_zip).ifAddressExists ,'R','');
			self.corp_ra_address_type_desc		:= if(corp2_mapping.fAddressExists(state_origin,state_desc,input.Agent_Address1,input.Agent_Address2,input.Agent_city,input.Agent_State,input.Agent_zip).ifAddressExists ,'REGISTERED OFFICE','');								 
			self.Corp_Agent_Country						:= corp2_raw_ar.Functions.GetCountryDesc(input.Agent_Country);
			self.corp_for_profit_ind  				:= map(trim(input.corp_type_id,left,right)in ['1','2','13']=>'Y',
																							 trim(input.corp_type_id,left,right)in ['3','4','14','23']=>'N',
																							'');
			self.corp_term_exist_cd						:= if(corp2_mapping.fValidateDate(input.Duration_of_Existence).GeneralDate<>'','D','P');
			self.corp_term_exist_desc					:= if(corp2_mapping.fValidateDate(input.Duration_of_Existence).GeneralDate<>'','EXPIRATION DATE','PERPETUAL');
			self.corp_term_exist_exp					:= corp2_mapping.fValidateDate(input.Duration_of_Existence).GeneralDate;
			self.corp_tax_program_cd					:= if((integer)input.Tax_Type_ID  in [0,255,9999] ,'' ,trim(input.Tax_Type_ID,left,right)); //PER CI:Vendor confirmed that '255' was an error.
			self.corp_tax_program_desc				:= corp2_raw_ar.Functions.GetTaxPrgdesc(self.corp_tax_program_cd);
			self.corp_home_state_name					:= if(corp2.t2u(input.fho_Name) <> '','FOREIGN NAME: '+corp2.t2u(input.fho_Name),'');
			self.corp_name_comment 						:= if(corp2.t2u(input.fho_Name) <> '','FOREIGN NAME',''); //overload
			self.corp_address1_line1					:= corp2_mapping.fCleanAddress(state_origin,state_desc,input.fho_address1,input.fho_address2,input.fho_city,input.fho_state,input.fho_zip).AddressLine1;
			self.corp_address1_line2					:= corp2_mapping.fCleanAddress(state_origin,state_desc,input.fho_address1,input.fho_address2,input.fho_city,input.fho_state,input.fho_zip).AddressLine2;
			self.corp_address1_line3					:= corp2_mapping.fCleanAddress(state_origin,state_desc,input.fho_address1,input.fho_address2,input.fho_city,input.fho_state,input.fho_zip).AddressLine3;
			self.corp_prep_addr1_line1				:= corp2_mapping.fCleanAddress(state_origin,state_desc,input.fho_address1,input.fho_address2,input.fho_city,input.fho_state,input.fho_zip).PrepAddrLine1;
			self.corp_prep_addr1_last_line		:= corp2_mapping.fCleanAddress(state_origin,state_desc,input.fho_address1,input.fho_address2,input.fho_city,input.fho_state,input.fho_zip).PrepAddrLastLine;
			self.corp_address1_type_cd      	:= if(corp2_mapping.fAddressExists(state_origin,state_desc,input.fho_address1,input.fho_address2,input.fho_city,input.fho_state,input.fho_zip).ifAddressExists,
																							'B','');
			self.corp_address1_type_desc    	:= if(corp2_mapping.fAddressExists(state_origin,state_desc,input.fho_address1,input.fho_address2,input.fho_city,input.fho_state,input.fho_zip).ifAddressExists,
																							'BUSINESS','');
			self.corp_Acts										:= if(trim(input.act,left,right) not in['','N/A',';',':','.','255','1402','1501','2901','13501','370001','401001','501001','1100000','1100100'],corp2_raw_ar.Functions.CorpActDesc(input.act),'');
			//Added for scrubbing purposes; new vendor 'corp_type_id' values will be captured!,'corp_type_id' values are crucial for dates & indicator fields!
			self.internalfield1								:= if(trim(input.corp_type_id,left,right)not in[domestic_List, foreign_List,''],'**'+ trim(input.corp_type_id,left,right),'');
			self.recordorigin									:= 'C';	
			self															:= [];

		end;

		MapMainCorp := project(FixedAddress, corpDataMainTransform(left)):independent;

    //Fictitious Businesses mapping
		JCorpNames 	:=join(ds_CorpData,ds_CorpNames,
											 corp2.t2u(left.filing_number)=corp2.t2u(right.filing_number),
											 transform(corp2_raw_ar.Layouts.CorpNames_TempLay,
											           self.corp_type_id      := left.corp_type_id;
																 self.Date_Incorporated := left.Date_Incorporated;
																 self := left;
																 self := right;),
											 inner,local);											 
		
		corp2_mapping.LayoutsCommon.Main 	corpNamesMainTransform(corp2_raw_ar.Layouts.CorpNames_TempLay  input):= transform, 
		skip(trim(input.Fictitious_Name,left,right) = '' or corp2.t2u(input.filing_number)='')

			self.dt_vendor_first_reported		:= (integer)fileDate;
			self.dt_vendor_last_reported		:= (integer)fileDate;
			self.dt_first_seen							:= (integer)fileDate;
			self.dt_last_seen								:= (integer)fileDate;
			self.corp_ra_dt_first_seen			:= (integer)fileDate;
			self.corp_ra_dt_last_seen				:= (integer)fileDate;
			self.corp_process_date					:= fileDate;
			self.corp_key										:= state_fips+'-' +corp2.t2u(input.filing_number);		
			self.corp_vendor								:= state_fips;		
			self.corp_state_origin					:= state_origin;
			self.corp_inc_state 						:= state_origin; 
			self.corp_orig_sos_charter_nbr	:= corp2.t2u(input.filing_number);
			self.corp_legal_name						:= corp2_mapping.fCleanBusinessName(state_origin,state_desc,input.Fictitious_Name).BusinessName;
			self.corp_ln_name_type_cd				:= 'F';
			self.corp_ln_name_type_desc			:= 'FBN';
			//Only Agent_City,Agent_State are in "Names"  vendorfile!
			self.corp_ra_address_line2			:= corp2_mapping.fCleanAddress(state_origin,state_desc,'','',input.Agent_City,input.Agent_State).AddressLine2;
		  self.ra_prep_addr_last_line			:= corp2_mapping.fCleanAddress(state_origin,state_desc,'','',input.Agent_City,input.Agent_State).PrepAddrLastLine;
			self.corp_ra_address_type_cd		:= if(corp2_mapping.fAddressExists(state_origin,state_desc,'','',input.Agent_City,input.Agent_State).ifAddressExists ,'R','');
			self.corp_ra_address_type_desc	:= if(corp2_mapping.fAddressExists(state_origin,state_desc,'','',input.Agent_City,input.Agent_State).ifAddressExists ,'REGISTERED OFFICE','');								 
			self.corp_inc_date							:= if(corp2.t2u(input.corp_type_id) in domestic_List,corp2_mapping.fValidateDate(input.Date_Incorporated).PastDate,'');
			self.corp_forgn_date						:= if(corp2.t2u(input.corp_type_id) in foreign_List, corp2_mapping.fValidateDate(input.Date_Incorporated).PastDate,'');
			self.recordorigin								:= 'C';	
			self														:= [];

		end;

		MapCorpNames 		:= project(JCorpNames, corpNamesMainTransform(left)):independent;
		
		//Contact file mapping
		joinCorpOfficer	:= join(ds_CorpData,ds_CorpOfficer,
														corp2.t2u(left.filing_number)= corp2.t2u(right.filing_number),
														transform(corp2_raw_ar.Layouts.CorpDataWithOfficerTiles,
																			self.title_id	:= corp2_raw_ar.Functions.TitleDesc(right.title_id);
																			self 					:= left;
																			self					:= right;),
														left outer,local);
														
								
		corp2_mapping.LayoutsCommon.Main AR_contTransform(corp2_raw_ar.Layouts.CorpDataWithOfficerTiles input,integer ctr):= transform,
		skip(corp2.t2u(input.filing_number)='' or 
		     (corp2_mapping.fCleanBusinessName(state_origin,state_desc,input.First_Name + ' ' + input.Middle_Name + ' ' + input.Last_Name).BusinessName='' and
				  corp2_mapping.fCleanBusinessName(state_origin,state_desc,input.Business_Name).BusinessName='')
				 ) 
				 
			self.dt_vendor_first_reported		:= (integer)fileDate;
			self.dt_vendor_last_reported		:= (integer)fileDate;
			self.dt_first_seen							:= (integer)fileDate;
			self.dt_last_seen								:= (integer)fileDate;
			self.corp_ra_dt_first_seen			:= (integer)fileDate;
			self.corp_ra_dt_last_seen				:= (integer)fileDate;			
			self.corp_process_date					:= fileDate;
			self.corp_key										:= state_fips + '-' +corp2.t2u(input.filing_number);		
			self.corp_vendor								:= state_fips;		
			self.corp_state_origin					:= state_origin;
			self.corp_inc_state 						:= state_origin; 
			self.corp_orig_sos_charter_nbr	:= corp2.t2u(input.filing_number);
			self.corp_legal_name 						:= corp2_mapping.fCleanBusinessName(state_origin,state_desc,input.corporation_name).BusinessName ;		
			self.Cont_suffix								:= corp2_raw_ar.Functions.SuffixDesc(input.suffix_id);
			self.cont_full_name							:= choose(ctr,corp2_mapping.fCleanBusinessName(state_origin,state_desc,input.First_Name + ' ' + input.Middle_Name + ' ' + input.Last_Name+ ' ' +self.Cont_suffix).BusinessName,
																										corp2_mapping.fCleanBusinessName(state_origin,state_desc,input.Business_Name).BusinessName);	
			self.cont_title1_desc           := if(corp2.t2u(input.officer_title) not in['','UNKNOWN'] ,corp2.t2u(input.officer_title) ,input.title_id); 
			self.recordorigin								:= 'T';	
			self														:= [];
																																																								
		end;	

		MapCont			:= Normalize(joinCorpOfficer,if(corp2.t2u(left.Business_Name)not in ['','SAME','SEE FILE','SEE'],2,1), 
														 AR_contTransform(left, counter)):independent;

		MapMain     := dedup(sort(distribute(MapMainCorp+MapCorpNames+MapCont,hash(corp_key)),record,local),record,local):independent;
		//***********MainFile Scrub	Logic												 		

		Main_F := MapMain;
		Main_S := Scrubs_corp2_mapping_AR_Main.Scrubs;					  // Scrubs module
		Main_N := Main_S.FromNone(Main_F); 										   // Generate the error flags
		Main_T := Main_S.FromBits(Main_N.BitmapInfile);     		// Use the FromBits module; makes my bitmap datafile easier to get to
		Main_U := Main_S.FromExpanded(Main_N.ExpandedInFile);  // Pass the expanded error flags into the Expanded module

		//Outputs reports
		Main_ErrorSummary					:= output(Main_U.SummaryStats, named('Main_ErrorSummary_AR'+filedate));
		Main_ScrubErrorReport 		:= output(choosen(Main_U.AllErrors, 1000), named('Main_ScrubErrorReport_AR'+filedate));
		Main_SomeErrorValues			:= output(choosen(Main_U.BadValues, 1000), named('Main_SomeErrorValues_AR'+filedate));
		Main_IsScrubErrors		 		:= IF(count(Main_U.AllErrors)<> 0,true,false);

		// Orbit Stats
		Main_OrbitStats						:= Main_U.OrbitStats();

		//Outputs files
		Main_CreateBitMaps				:= output(Main_N.BitmapInfile,,'~thor_data::corpARmain_scrubs_bits',overwrite,compressed);	//long term storage
		Main_TranslateBitMap			:= output(Main_T);
		//Creates Profile's alert template for Orbit - can be copied and imported into Orbit; Only required if rules in Orbit change
		Main_AlertsCSVTemplate		:= Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_'+state_origin+'_Main','ScrubsAlerts', Main_OrbitStats, version,'Corp2_'+state_origin+'_Main').ProfileAlertsTemplate;
		//Submits Profile's stats to Orbit
		Main_SubmitStats 			  	:= Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_'+state_origin+'_Main','ScrubsAlerts', Main_OrbitStats, version,'Corp2_'+state_origin+'_Main').SubmitStats;
		Main_ScrubsWithExamples		:= Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_'+state_origin+'_Main','ScrubsAlerts', Main_OrbitStats, version,'Corp2_'+state_origin+'_Main').CompareToProfile_with_Examples;
	
		Main_ScrubsAlert					:= Main_ScrubsWithExamples(RejectWarning = 'Y');
		Main_ScrubsAttachment			:= Scrubs.fn_email_attachment(Main_ScrubsAlert);
		Main_SendEmailFile				:= FileServices.SendEmailAttachData( corp2.Email_Notification_Lists.AttachedList
																																	 ,'Scrubs CorpMain_AR Report' 	//Subject
																																	 ,'Scrubs CorpMain_AR Report' //Body
																																	 ,(data)Main_ScrubsAttachment
																																	 ,'text/csv'
																																	 ,'CorpARMainScrubsReport.csv'
																																	);

		Main_BadRecords		  := Main_N.ExpandedInFile(  dt_vendor_first_reported_Invalid	 <> 0 or
																									 dt_vendor_last_reported_Invalid	 <> 0 or
																									 dt_first_seen_Invalid						 <> 0 or
																									 dt_last_seen_Invalid							 <> 0 or
																									 corp_ra_dt_first_seen_Invalid		 <> 0 or
																									 corp_ra_dt_last_seen_Invalid			 <> 0 or
																									 corp_key_Invalid									 <> 0 or
																									 corp_vendor_Invalid							 <> 0 or
																									 corp_state_origin_Invalid				 <> 0 or
																									 corp_process_date_Invalid				 <> 0 or
																									 corp_orig_sos_charter_nbr_Invalid <> 0 or
																									 corp_legal_name_Invalid					 <> 0 or
																									 corp_ln_name_type_cd_Invalid			 <> 0 or
																									 corp_status_cd_Invalid						 <> 0 or
																									 corp_status_desc_Invalid					 <> 0 or
																									 corp_inc_state_Invalid						 <> 0 or
																									 corp_inc_date_Invalid						 <> 0 or
																									 corp_foreign_domestic_ind_Invalid <> 0 or
																									 corp_forgn_state_desc_Invalid		 <> 0 or
																									 corp_forgn_date_Invalid					 <> 0 or
																									 corp_orig_org_structure_cd_Invalid<> 0 or
																									 corp_for_profit_ind_Invalid			 <> 0 or
																									 corp_acts_Invalid								 <> 0 or
																									 corp_tax_program_cd_Invalid			 <> 0 or
																									 corp_agent_country_Invalid				 <> 0 or
																									 corp_country_of_formation_Invalid <> 0 or
																									 internalfield1_Invalid						 <> 0 or
																									 recordorigin_Invalid							 <> 0 
																							);
																																				
		Main_GoodRecords		:=Main_N.ExpandedInFile( dt_vendor_first_reported_Invalid	 = 0 and
																								 dt_vendor_last_reported_Invalid	 = 0 and
																								 dt_first_seen_Invalid						 = 0 and
																								 dt_last_seen_Invalid							 = 0 and
																								 corp_ra_dt_first_seen_Invalid		 = 0 and
																								 corp_ra_dt_last_seen_Invalid			 = 0 and
																								 corp_key_Invalid									 = 0 and
																								 corp_vendor_Invalid							 = 0 and
																								 corp_state_origin_Invalid				 = 0 and
																								 corp_process_date_Invalid				 = 0 and
																								 corp_orig_sos_charter_nbr_Invalid = 0 and
																								 corp_legal_name_Invalid					 = 0 and
																								 corp_ln_name_type_cd_Invalid			 = 0 and
																								 corp_status_cd_Invalid						 = 0 and
																								 corp_status_desc_Invalid					 = 0 and
																								 corp_inc_state_Invalid						 = 0 and
																								 corp_inc_date_Invalid						 = 0 and
																								 corp_foreign_domestic_ind_Invalid = 0 and
																								 corp_forgn_state_desc_Invalid		 = 0 and
																								 corp_forgn_date_Invalid					 = 0 and
																								 corp_orig_org_structure_cd_Invalid= 0 and
																								 corp_for_profit_ind_Invalid			 = 0 and
																								 corp_acts_Invalid								 = 0 and
																								 corp_tax_program_cd_Invalid			 = 0 and
																								 corp_agent_country_Invalid				 = 0 and
																								 corp_country_of_formation_Invalid = 0 and
																								 internalfield1_Invalid						 = 0 and
																								 recordorigin_Invalid							 = 0 
																							);

		Main_FailBuild	:= map( corp2_mapping.fCalcPercent(count(Main_N.ExpandedInFile(corp_key_invalid<>0)),count(Main_N.ExpandedInFile),false) 										> Scrubs_corp2_mapping_AR_Main.Threshold_Percent.CORP_KEY										   => true,
														corp2_mapping.fCalcPercent(count(Main_N.ExpandedInFile(corp_orig_sos_charter_nbr_invalid<>0)),count(Main_N.ExpandedInFile),false) 	> Scrubs_corp2_mapping_AR_Main.Threshold_Percent.CORP_ORIG_SOS_CHARTER_NBR 	   => true,
														corp2_mapping.fCalcPercent(count(Main_N.ExpandedInFile(corp_legal_name_invalid<>0)),count(Main_N.ExpandedInFile),false) 						> Scrubs_corp2_mapping_AR_Main.Threshold_Percent.CORP_LEGAL_NAME 						   => true,
														count(Main_GoodRecords) = 0																																																																																												 => true,																		
														false
												 );

		Main_ApprovedRecords := project(Main_GoodRecords,transform(corp2_mapping.LayoutsCommon.Main,self := left));

		//==========================================VERSION CONTROL====================================================
		VersionControl.macBuildNewLogicalFile('~thor_data400::in::corp2::'+version+'::main_AR',Main_ApprovedRecords,main_out,,,pOverwrite);
		VersionControl.macBuildNewLogicalFile(corp2_mapping._dataset().thor_cluster_Files + 'fail::corp2::'+version+'::Main_'+ state_origin	,Main_F	 ,write_fail_main  ,,,pOverwrite); 

		Main_RejFile_Exists		:=IF(FileServices.FileExists(corp2_mapping._dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::main_' + state_origin),true,false);			

		run_Main := 	sequential( IF( pshouldspray = TRUE,corp2_mapping.fSprayFiles(state_origin,version,pOverwrite := pOverwrite))
																  // ,corp2_raw_ar.Build_Bases(filedate,version,pUseProd).All  // Determined building of bases is not needed
																	,main_out
																	,IF( Main_FailBuild <> true
																				,sequential(fileservices.addsuperfile(corp2_mapping._Dataset().thor_cluster_Files + 'in::'+corp2_mapping._Dataset().NameMapped+'::sprayed::main',corp2_mapping._Dataset().thor_cluster_Files + 'in::corp2::'+version+'::main_AR')
																										,IF  (count(Main_BadRecords) <> 0
																													,corp2_mapping.Send_Email('ARKANSAS',version,count(Main_BadRecords)<>0,,,,count(Main_BadRecords),,,,count(Main_ApprovedRecords)).RecordsRejected																				 
																													,corp2_mapping.Send_Email('ARKANSAS',version,count(Main_BadRecords)<>0,,,,count(Main_BadRecords),,,,count(Main_ApprovedRecords)).MappingSuccess		
																													)
																										)   

																				,sequential(write_fail_main
																										,corp2_mapping.Send_Email('ARKANSAS',version).MappingFailed
																									 )
																		 )
																	,sequential(IF(count(Main_BadRecords) <> 0
																									,IF (poverwrite
																												,OUTPUT(Main_BadRecords,,corp2_mapping._Dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::main_AR',overwrite,__compressed__,named('Sample_Rejected_MainRecs_AR'+filedate))
																												,sequential (IF(Main_RejFile_Exists,fileservices.deletelogicalfile(corp2_mapping._dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::main_'+ state_origin)),
																																		 OUTPUT(Main_BadRecords,,corp2_mapping._Dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::main_'+ state_origin,__compressed__,named('Sample_Rejected_MainRecs_AR'+filedate))
																																		 )
																											)
																									)
																							)
																 ,IF(Main_IsScrubErrors
																		 ,corp2_mapping.Send_Email('ARKANSAS',version,Main_IsScrubErrors,false,false,false).FieldsInvalidPerScrubs																				 
																		 )	
																	,IF(COUNT(Main_ScrubsAlert) > 0, 	Main_SendEmailFile, OUTPUT('corp2_mapping.ARKANSAS - No Corp Scrubs Alerts'))		
																	,output(Main_ScrubsWithExamples, ALL, NAMED('CorpMainARScrubsReportWithExamples'+filedate)) //Send Alerts if Scrubs exceeds thresholds
																	,Main_ErrorSummary
																	,Main_ScrubErrorReport																					
																	,Main_SomeErrorValues
																	//,Main_AlertsCSVTemplate
																	,Main_SubmitStats				
														);
						 
		//Validating that filedate entered is within 30 days										 
		isFileDateValid := if((string)Std.Date.Today() between ut.date_math(filedate,-45) and ut.date_math(filedate,45),true,false);										 
		result		 			:= if (isFileDateValid
													 ,run_Main 
													 ,sequential (corp2_mapping.Send_Email('ARKANSAS',filedate).InvalidFileDateParm
																				,FAIL('corp2_mapping.ARKANSAS failed.	An invalid filedate was passed in as a parameter.')
																			 )
													);

		return result;

	end;

end;