IMPORT ut, corp2_raw_ne, tools, corp2, versioncontrol, Scrubs, scrubs_corp2_mapping_ne_main, Scrubs_corp2_mapping_ne_Event, std;

EXPORT NE  := MODULE; 

	export Update(string fileDate, string version, boolean pShouldSpray = _Dataset().bShouldSpray, boolean pOverwrite = false,pUseProd = Tools._Constants.IsDataland) :=Function

		state_origin			:= 'NE';
		state_fips	 			:= '31';
		state_desc	 			:= 'NEBRASKA';

		CorpEntity				:= dedup(sort(distribute(Corp2_Raw_NE.Files(filedate,pUseProd).input.CorpEntity.Logical,hash(AcctNumber)),record,local),record,local)   : independent;
		EntityRegAgentID	:= distribute(CorpEntity,hash(RegAgentID));
		CorpOfficers		  := dedup(sort(distribute(Corp2_Raw_NE.Files(filedate,pUseProd).input.CorpOfficers.Logical,hash(AcctNumber)),record,local),record,local) : independent;
		RegisterAgent	    := dedup(sort(distribute(Corp2_Raw_NE.Files(filedate,pUseProd).input.RegisterAgent.Logical,hash(RegAgentID)),record,local),record,local): independent;	
		CorpAction				:= dedup(sort(distribute(Corp2_Raw_NE.Files(filedate,pUseProd).input.CorpAction.Logical,hash(AcctNumber)),record,local),record,local)   : independent;

		CorpTypeTable  	  := Corp2_Raw_NE.Files(filedate,pUseProd).input.CorpTypeTable  : independent;	 	
		TitleTypeTable  	:= Corp2_Raw_NE.Files(filedate,pUseProd).input.TitleTypeTable : independent;	 		  
		FilingTypeTable 	:= Corp2_Raw_NE.Files(filedate,pUseProd).input.FilingTypeTable: independent;	 		 
		StateCodeTable 	  := Corp2_Raw_NE.Files(filedate,pUseProd).input.StateCodeTable : independent;	 
		CntryCodeTable		:= Corp2_Raw_NE.Files(filedate,pUseProd).input.CntryCodeTable : independent;	 
		
		domestic_type			:=['A','AA','BK','D','DF','DFPC','DLLC','DLPC','DPC','DPLC','FS','G','HA',
												 'IC','J','JPA','L','LCA','N','NBC','NLCA','NT','NS','RAD','SID'];
		foreign_type 			:=['B','F','FLCA','FLLC','FLPC','FPC','FPLC','H','K','NDF','NF','NFLC','P'];
    set_Of_ContTypes	:=['M','PN','RN','S','T','VN']; 
		
		//Corporation Rec's Mappings
		//--------------------- Merge  RA_Agents ------------------------------------------
		DsEntityWithRA 	:= join(EntityRegAgentID, RegisterAgent,
														corp2.t2u(left.RegAgentID) = corp2.t2u(right.RegAgentID),
														transform(Corp2_Raw_NE.Layouts.Temp_CorpEntityWithRA,
																			self 	:= left;
																			self	:= right;
																			self  :=[];
																			),
														left outer,local);

		/*--------------------- Add CorpTypeDesc ------------------------------------------
		 CorpType lookup table's "corpDesc3" field will have,number of years or months Ex:[Y10, M4,Perpetual] ,
		 noticed in the vendor look up table has '>Y' with either no valid years or months ,
     data won't be used when table has just '>Y' with no valid years or months */
		DsEntityRA_CorpTypeDesc := join(DsEntityWithRA ,CorpTypeTable,
																		corp2.t2u(left.corptype) = corp2.t2u(right.corpCode),
																		transform(Corp2_Raw_NE.Layouts.Temp_CorpEntityWithRA,
																							self.CorpTypeDesc := if(corp2.t2u(right.corpDesc3)='>Y','',corp2.t2u(right.corpDesc3)); 
																							self 							:= left;
																							self  						:=[];
																							),
																		 left outer, lookup);	
																		 
		DsEntity_Stdesc 				:= join(DsEntityWithRA ,StateCodeTable,
																		corp2.t2u(left.QualifyingState) not in ['00',''] and corp2.t2u(left.QualifyingState) = corp2.t2u(right.stateCode),
																		transform(Corp2_Raw_NE.Layouts.Temp_CorpEntityWithRA,
																							self.StDesc := corp2.t2u(right.stateDesc); 
																							self 				:= left;
																							self  			:=[];
																							),
																		left outer, lookup);	
																		 
		DsEntity_Cntrydesc 			:= join(DsEntity_Stdesc ,CntryCodeTable,
																	  corp2.t2u(left.CntryCode)not in['','VI'] and corp2.t2u(left.CntryCode) = corp2.t2u(right.cntryCode2) , // valid codes will have matching descriptions from table !! VI/VIRGIN ISLANDS (U.S.)
																	  transform(Corp2_Raw_NE.Layouts.Temp_CorpEntityWithRA,
																						  self.CntryDesc := corp2.t2u(right.cntryCode1); 
																						  self 					 := left;
																							),
																	  left outer, lookup);			
																		 
		corp2_mapping.LayoutsCommon.Main  corpMainTransform(Corp2_Raw_NE.Layouts.Temp_CorpEntityWithRA input):= transform
		
			self.dt_vendor_first_reported							:=(integer)fileDate;
			self.dt_vendor_last_reported							:=(integer)fileDate;
			self.dt_first_seen												:=(integer)fileDate;
			self.dt_last_seen													:=(integer)fileDate;
			self.corp_ra_dt_first_seen								:=(integer)fileDate;
			self.corp_ra_dt_last_seen									:=(integer)fileDate;
			self.corp_process_date										:= fileDate;    	
			self.corp_key					    		  					:= state_fips +'-'+ corp2.t2u(input.AcctNumber);		
			self.corp_vendor													:= state_fips ;		
			self.corp_state_origin										:= state_origin ;
			self.corp_inc_state 										  := state_origin ; 
			self.corp_orig_sos_charter_nbr						:= corp2.t2u(input.AcctNumber);				
			self.corp_legal_name											:= corp2_mapping.fCleanBusinessName(state_origin,state_desc,input.CorpStateName).BusinessName;
			self.corp_home_state_name									:= corp2_mapping.fCleanBusinessName(state_origin,state_desc,input.forgncorpname).BusinessName;
			self.corp_ln_name_type_cd									:= corp2_Raw_NE.Functions.NameTypeCode(input.corptype);						
			self.corp_ln_name_type_desc								:= map(self.corp_ln_name_type_cd = '01'=>'LEGAL',
																											 self.corp_ln_name_type_cd = '03'=>'TRADEMARK',	
																											 self.corp_ln_name_type_cd = '04'=>'TRADENAME',
																											 self.corp_ln_name_type_cd = '05'=>'SERVICEMARK',
																											 self.corp_ln_name_type_cd = '07'=>'RESERVED', 
																											 self.corp_ln_name_type_cd = '09'=>'REGISTRATION',
																											 self.corp_ln_name_type_cd = 'I' =>'OTHER',
																											 '');
			self.corp_orig_org_structure_cd					  := if(corp2.t2u(input.corptype)not in['M','RN','S','T','VN'] ,corp2.t2u(input.corptype),'');															
			self.corp_orig_org_structure_desc				  := Corp2_Raw_NE.Functions.Orig_desc(self.corp_orig_org_structure_cd);
			self.corp_for_profit_ind        					:= if(corp2.t2u(input.corptype)in['NDF','NF','NLCA','N','NFLC'],'N',''); 
			self.corp_status_cd												:= corp2.t2u(input.Status);	//Scrubbing
			self.corp_status_desc										 	:= case(corp2.t2u(input.Status),
																												'A'=>'ACTIVE',
																												'I'=>'INACTIVE',
																												'S'=>'SUSPENDED',
																												'');										
			self.corp_trademark_classification_nbr		:= corp2.t2u(input.classification);
			self.corp_trademark_class_desc1						:= Corp2_Raw_NE.Functions.GetCLassification(input.classification);
			self.corp_farm_exemptions									:= Corp2_Raw_NE.Functions.FarmExemptions(input.FarmExemptionCategory);	
			valid_Date                              	:= corp2_mapping.fValidateDate(input.DateIncorp[1..10],'CCYY-MM-DD').PastDate;
			self.corp_foreign_domestic_ind						:= if(corp2.t2u(input.corptype) <> 'M',
																											map(corp2.t2u(input.QualifyingState)in[ state_origin,''] and corp2.t2u(input.corptype)  in domestic_type     =>'D',
																													corp2.t2u(input.QualifyingState)not in[ state_origin,''] and corp2.t2u(input.corptype) in foreign_type	 =>'F',
																													corp2.t2u(input.QualifyingState)='' and corp2.t2u(input.corptype) in foreign_type										 		 =>'F',
																													corp2.t2u(input.corptype) in foreign_type										 		 																				 =>'F',
																													corp2.t2u(input.corptype) in domestic_type    																												   =>'D',
																													''),
																										  '');
			self.corp_inc_date												:= if(corp2.t2u(input.corptype) <> 'M',
																											map(corp2.t2u(input.QualifyingState)in[ state_origin,''] and corp2.t2u(input.corptype)  in domestic_type =>valid_Date,
																													corp2.t2u(input.QualifyingState)='' and corp2.t2u(input.corptype) not in foreign_type								 =>valid_Date,
																													corp2.t2u(input.corptype) not in foreign_type										 																		 =>valid_Date,//noticed in the data, states which are state_origin and have forein type & vice versa		
																													''),
																											'');  
			self.corp_forgn_date											:=if(corp2.t2u(input.corptype) <> 'M',
																										map(corp2.t2u(input.QualifyingState)not in[ state_origin,''] and corp2.t2u(input.corptype) in foreign_type=>valid_Date,
																												corp2.t2u(input.QualifyingState)='' and corp2.t2u(input.corptype) in foreign_type										  =>valid_Date,
																												corp2.t2u(input.corptype) in foreign_type										 																					=>valid_Date,
																												''),
																										'');													 			
			self.corp_filing_date											:= if(corp2.t2u(input.corptype) in set_Of_ContTypes,valid_Date,'');
			self.corp_trademark_filing_date						:= if(corp2.t2u(input.corptype) = 'M',valid_Date,'');
			self.corp_forgn_state_cd									:= if(corp2.t2u(input.QualifyingState) not in ['NE',''],corp2.t2u(input.QualifyingState),'')	;												 											 
			self.corp_forgn_state_desc								:= map(corp2.t2u(input.QualifyingState) not in ['NE',''] and trim(input.StDesc)<>'' =>input.StDesc,
																											 corp2.t2u(input.QualifyingState)<>''and trim(input.StDesc)=''								=>Corp2_Raw_NE.Functions.fGetStateDesc(input.QualifyingState), // Adding desc, those are not in vendor look up table!
																											 '');	
			self.corp_country_of_formation		    		:= map(trim(input.CntryDesc) <> '' 																=>input.CntryDesc,
																											 corp2.t2u(input.CntryCode)not in['','VI'] and trim(input.CntryDesc)=''=>Corp2_Raw_NE.Functions.fGetCountryDesc(input.CntryCode),// Adding Country desc , those are not in vendor look up table!
																												'');
			CntryDesc                                 := if(self.corp_country_of_formation[1..2]<>'**' ,self.corp_country_of_formation,'');																									
			self.corp_address1_line1									:= if(corp2.t2u(input.corptype )not in set_Of_ContTypes ,corp2_mapping.fCleanAddress(state_origin,state_desc,input.address1,input.address2,input.City,input.state,input.zipCode,CntryDesc).AddressLine1,'');
			self.corp_address1_line2				 					:= if(corp2.t2u(input.corptype )not in set_Of_ContTypes ,corp2_mapping.fCleanAddress(state_origin,state_desc,input.address1,input.address2,input.City,input.state,input.zipCode,CntryDesc).AddressLine2,'');
			self.corp_address1_line3				  				:= if(corp2.t2u(input.corptype )not in set_Of_ContTypes ,corp2_mapping.fCleanAddress(state_origin,state_desc,input.address1,input.address2,input.City,input.state,input.zipCode,CntryDesc).AddressLine3,'');
			self.corp_prep_addr1_line1								:= if(corp2.t2u(input.corptype )not in set_Of_ContTypes ,corp2_mapping.fCleanAddress(state_origin,state_desc,input.address1,input.address2,input.City,input.state,input.zipCode,CntryDesc).PrepAddrLine1,'');
			self.corp_prep_addr1_last_line						:= if(corp2.t2u(input.corptype )not in set_Of_ContTypes ,corp2_mapping.fCleanAddress(state_origin,state_desc,input.address1,input.address2,input.City,input.state,input.zipCode,CntryDesc).PrepAddrLastLine,'');
			self.corp_address1_type_cd         				:= if(corp2.t2u(input.corptype )not in set_Of_ContTypes  and corp2_mapping.fAddressExists(state_origin,state_desc,input.address1,input.address2,input.City,input.state,input.zipCode,CntryDesc).ifAddressExists,
																											'B','');
			self.corp_address1_type_desc         			:= if(corp2.t2u(input.corptype )not in set_Of_ContTypes  and corp2_mapping.fAddressExists(state_origin,state_desc,input.address1,input.address2,input.City,input.state,input.zipCode,CntryDesc).ifAddressExists,
																											'BUSINESS','');		
			self.corp_orig_bus_type_desc							:= if(not ut.isNumeric(corp2.t2u(input.NatureOfBusiness)),corp2.t2u(input.NatureOfBusiness),'');
			TempDurationVal														:= map(corp2.t2u(input.duration) in ['PERPETUAL','PURPETUAL','PERPTUAL','PEREPTUAL','PERPETUAL.','PERRPETUAL','PERPTETUAL','PERPEUTAL']=>'P',												 
																											 corp2.t2u(input.duration) ='CONDITIONAL'											=>'',
																											 regexfind('(.*)/(.*)/(.*)',corp2.t2u(input.duration)[1..10]) =>'D',  // Per CI: A year & date are populated together, just map the date EX: 01/01/2080 75 YEARS
																											 regexfind('^[0-9]*[ ]*YEARS?$',corp2.t2u(input.duration))		=>'N',  //  EX: 5 Years
																											 '');		
			ExpirationDate														:= corp2_mapping.fValidateDate(input.ExpirationDate[1..10],'CCYY-MM-DD').GeneralDate;								  																 						
			CorpTypeDesc															:= if(corp2.t2u(input.CorpTypeDesc) ='PERPETUAL','P',	corp2.t2u(input.CorpTypeDesc) );	//From lookup table																									
			self.corp_term_exist_cd             			:= map(TempDurationVal = 'D' 		    => 'D',
																											 TempDurationVal = 'P' 		    => 'P',																											 
																											 TempDurationVal = 'N'   			=> 'N',
																											 expirationDate  <> '' 		    => 'D',																											 
																											 CorpTypeDesc 	 = 'P' 		    => 'P',
																											 CorpTypeDesc[1] in ['Y','M'] => 'N',
																											 '');														  																		 
			self.corp_term_exist_desc									:= map(TempDurationVal 		    = 'D' => 'EXPIRATION DATE',
																											 TempDurationVal 				= 'P' => 'PERPETUAL',	
																											 TempDurationVal				= 'N' => 'NUMBER OF YEARS',
																											 expirationDate 				<> '' => 'EXPIRATION DATE',
																											 CorpTypeDesc 	        = 'P' => 'PERPETUAL',
																											 CorpTypeDesc[1] 				= 'Y' => 'NUMBER OF YEARS',
																											 CorpTypeDesc[1] 				= 'M' => 'NUMBER OF MONTHS',
																											 ''
																											);											       															        		
			self.corp_term_exist_exp								:= map(TempDurationVal 	  = 'D'       => corp2_mapping.fValidateDate(input.duration[1..10],'MM/DD/CCYY').GeneralDate,		
																										 TempDurationVal 	  = 'N'       => regexfind('^[0-9]*',corp2.t2u(input.duration),0),
																										 expirationDate 		<> ''       => expirationDate,
																										 CorpTypeDesc[1] in ['Y','M']   => CorpTypeDesc[2..],
																										 '');											
			self.corp_ra_full_name									:= corp2_mapping.fCleanBusinessName(state_origin,state_desc,input.regAgentName).BusinessName;
			self.corp_ra_address_line1            	:= corp2_mapping.fCleanAddress(state_origin,state_desc,input.regagentaddr1,input.regagentaddr2,input.regagentcity,input.regagentstate,input.regagentzip).addressline1;
			self.corp_ra_address_line2							:= corp2_mapping.fcleanaddress(state_origin,state_desc,input.regagentaddr1,input.regagentaddr2,input.regagentcity,input.regagentstate,input.regagentzip).addressline2;
			self.corp_ra_address_line3							:= corp2_mapping.fcleanaddress(state_origin,state_desc,input.regagentaddr1,input.regagentaddr2,input.regagentcity,input.regagentstate,input.regagentzip).addressline3;
			self.ra_prep_addr_line1									:= corp2_mapping.fcleanaddress(state_origin,state_desc,input.regagentaddr1,input.regagentaddr2,input.regagentcity,input.regagentstate,input.regagentzip).prepaddrline1;
			self.ra_prep_addr_last_line							:= corp2_mapping.fcleanaddress(state_origin,state_desc,input.regagentaddr1,input.regagentaddr2,input.regagentcity,input.regagentstate,input.regagentzip).prepaddrlastline;
			self.corp_ra_address_type_cd		  			:= if(corp2_mapping.fAddressExists(state_origin,state_desc,input.regagentaddr1,input.regagentaddr2,input.regagentcity,input.regagentstate,input.regagentzip).ifAddressExists , 'R', '');
			self.corp_ra_address_type_desc					:= if(corp2_mapping.fAddressExists(state_origin,state_desc,input.regagentaddr1,input.regagentaddr2,input.regagentcity,input.regagentstate,input.regagentzip).ifAddressExists , 'REGISTERED OFFICE', '');									 
			//Added for scrub purposes; new vendor corptype values will be captured!,corptype values are crucial for dates & indicator fields!
			self.internalfield1											:= if(corp2.t2u(input.corptype)not in[domestic_type ,foreign_type ,set_Of_ContTypes ,''] ,'**'+ corp2.t2u(input.corptype),'');
			self.recordOrigin												:= 'C';	
			self																		:= [];

		end;
											

		mapCorp     := project(DsEntity_Cntrydesc,corpMainTransform(left));	

		//FOREIGN NAME Rec's Mappings & Overloaded Transform
		corp2_mapping.LayoutsCommon.Main corpForgnNameTransform(Corp2_Raw_NE.Layouts.CorpEntityLayoutIn input):= transform,
		skip(corp2.t2u(input.forgnCorpName) = '')

			self.dt_vendor_first_reported		 			:= (integer)fileDate;
			self.dt_vendor_last_reported		 			:= (integer)fileDate;
			self.dt_first_seen							 			:= (integer)fileDate;
			self.dt_last_seen								 			:= (integer)fileDate;
			self.corp_ra_dt_first_seen			 			:= (integer)fileDate;
			self.corp_ra_dt_last_seen				 			:= (integer)fileDate;	
			self.corp_process_date				  			:= fileDate; 
			self.corp_key													:= state_fips +'-'+corp2.t2u(input.AcctNumber);
			self.corp_vendor											:= state_fips ;
			self.corp_state_origin								:= state_origin ;			
			self.corp_inc_state 									:= state_origin ; 
			self.corp_orig_sos_charter_nbr				:= corp2.t2u(input.AcctNumber);	
			self.corp_legal_name									:= corp2_mapping.fCleanBusinessName(state_origin,state_desc,input.forgnCorpName).BusinessName;
			self.corp_ln_name_type_cd 						:= '10';
			self.corp_ln_name_type_desc 					:= 'FOREIGN NAME';
			self.corp_name_comment							  := 'FOREIGN NAME';
			valid_Date                           	:= corp2_mapping.fValidateDate(input.DateIncorp[1..10],'CCYY-MM-DD').PastDate;
			self.corp_inc_date										:= if(corp2.t2u(input.corptype) <> 'M',
																									map(corp2.t2u(input.QualifyingState)in[ state_origin,''] and corp2.t2u(input.corptype)  in domestic_type =>valid_Date,
																											corp2.t2u(input.QualifyingState)='' and corp2.t2u(input.corptype) not in foreign_type								 =>valid_Date,
																											corp2.t2u(input.corptype) not in foreign_type										 																		 =>valid_Date,//noticed in the data, states which are state_origin and have forein type & vice versa		
																											''),
																									'');  
			self.corp_forgn_date									:=if(corp2.t2u(input.corptype) <> 'M',
																								map(corp2.t2u(input.QualifyingState)not in[ state_origin,''] and corp2.t2u(input.corptype) in foreign_type=>valid_Date,
																										corp2.t2u(input.QualifyingState)='' and corp2.t2u(input.corptype) in foreign_type										  =>valid_Date,
																										corp2.t2u(input.corptype) in foreign_type										 																					=>valid_Date,
																										''),
																								'');													 			
			self.recordOrigin											:= 'C';			
			self																	:= [];

		end;

		mapCorpForgn	:= project(CorpEntity ,corpForgnNameTransform(left));
		
		//Contact Rec's Mappings		
		corp2_mapping.LayoutsCommon.Main    contTransform1(Corp2_Raw_NE.Layouts.CorpEntityLayoutIn input) := transform,
		skip (corp2.t2u(input.corptype )not in set_Of_ContTypes or  corp2.t2u(input.AcctNumber)='' or
					corp2_mapping.fCleanBusinessName(state_origin,state_desc,input.name).BusinessName ='')

			self.dt_vendor_first_reported		 			:= (integer)fileDate;
			self.dt_vendor_last_reported		 			:= (integer)fileDate;
			self.dt_first_seen							 			:= (integer)fileDate;
			self.dt_last_seen								 			:= (integer)fileDate;
			self.corp_ra_dt_first_seen			 			:= (integer)fileDate;
			self.corp_ra_dt_last_seen				 			:= (integer)fileDate;	
			self.corp_process_date				  			:= fileDate; 
			self.corp_key													:= state_fips +'-'+corp2.t2u(input.AcctNumber);
			self.corp_vendor											:= state_fips ;
			self.corp_state_origin								:= state_origin;				
			self.corp_inc_state 									:= state_origin; 
			self.corp_orig_sos_charter_nbr				:= corp2.t2u(input.AcctNumber);		
			self.corp_legal_name									:= corp2_mapping.fCleanBusinessName(state_origin,state_desc,input.CorpStateName).BusinessName;	
			self.Cont_full_name               		:= corp2_mapping.fCleanBusinessName(state_origin,state_desc,input.name).BusinessName;	
			self.cont_type_cd											:= 'O/I';
			self.cont_type_desc										:= 'OWNER/APPLICANT';
			self.cont_address_line1								:= corp2_mapping.fCleanAddress(state_origin,state_desc,input.address1,input.address2,input.City,input.state,input.zipCode).AddressLine1;
			self.cont_address_line2				 				:= corp2_mapping.fCleanAddress(state_origin,state_desc,input.address1,input.address2,input.City,input.state,input.zipCode).AddressLine2;
			self.cont_address_line3				  			:= corp2_mapping.fCleanAddress(state_origin,state_desc,input.address1,input.address2,input.City,input.state,input.zipCode).AddressLine3;
			self.cont_prep_addr_line1							:= corp2_mapping.fCleanAddress(state_origin,state_desc,input.address1,input.address2,input.City,input.state,input.zipCode).PrepAddrLine1;
			self.cont_prep_addr_last_line					:= corp2_mapping.fCleanAddress(state_origin,state_desc,input.address1,input.address2,input.City,input.state,input.zipCode).PrepAddrLastLine;
			self.cont_Address_type_cd         		:= if(corp2_mapping.fAddressExists(state_origin,state_desc,input.address1,input.address2,input.City,input.state,input.zipCode).ifAddressExists,
																									'T','');
			self.cont_Address_type_desc         	:= if(corp2_mapping.fAddressExists(state_origin,state_desc,input.address1,input.address2,input.City,input.state,input.zipCode).ifAddressExists,
																									'CONTACT','');	
			//overloaded
			self.cont_addl_info										:= if(corp2.t2u(input.contact)<>'','CONTACT: ' +corp2.t2u(input.contact),'');
			self.recordOrigin										  := 'T';			
			self																  := [];

		end;

		mapContEntiy	:= project(CorpEntity,contTransform1(left));
		
		ds_OfficerWithTitles		:= join(corpOfficers, TitleTypeTable ,
																		corp2.t2u(left.PositionTitle) = corp2.t2u(right.titleCode),
																		transform(Corp2_Raw_NE.Layouts.Temp_OfficerWithTitles,
																							self.PositionTitle	:= corp2.t2u(right.titleDesc);	
																							self								:= left;
																							self								:= [];),
																		left outer, lookup); 

		Corp2_Raw_NE.Layouts.Temp_OfficerWithTitles DenormOfficers(Corp2_Raw_NE.Layouts.Temp_OfficerWithTitles L,Corp2_Raw_NE.Layouts.Temp_OfficerWithTitles R,integer C) := transform		

			self.Title1 	:= if(C=1, R.PositionTitle,L.TITLE1);                  
			self.title2		:= if(C=2, R.PositionTitle,L.TITLE2);
			self.title3		:= if(C=3, R.PositionTitle,L.TITLE3); 
			self.title4		:= if(C=4, R.PositionTitle,L.TITLE4); 
			self.title5		:= if(C=5, R.PositionTitle,L.TITLE5); 
			self.title6		:= if(C=6, R.PositionTitle,L.TITLE6); 
			self.title7		:= if(C=7, R.PositionTitle,L.TITLE7); 
			self.title8		:= if(C=8, R.PositionTitle,L.TITLE8); 
			self.title9		:= if(C=9, R.PositionTitle,L.TITLE9); 
			self.title10	:= if(C=10,R.PositionTitle,L.TITLE10); 			
			self 					:= L;	

		end;

		ds_DenormFile 	:= denormalize( ds_OfficerWithTitles,ds_OfficerWithTitles,
																		corp2.t2u(left.AcctNumber) 		= corp2.t2u(right.AcctNumber) and
																		corp2.t2u(left.FirstName) 		= corp2.t2u(right.FirstName) and
																		corp2.t2u(left.MiddleInitial) = corp2.t2u(right.MiddleInitial) and
																		corp2.t2u(left.lastname) 			= corp2.t2u(right.lastname) , 
																		DenormOfficers(left,right,counter)
																	);
																	
    ds_DenormCont             := distribute(ds_DenormFile,hash(AcctNumber));
		dsCorpOfficerWithEntity		:= join(corpEntity,ds_DenormCont,
																			corp2.t2u(left.AcctNumber) = corp2.t2u(right.AcctNumber),
																			transform(Corp2_Raw_NE.Layouts.Temp_EntityWithOfficerTitles,
																								self	:=left ;	
																								self	:=right;),
																			left outer,local) :independent;
												
		corp2_mapping.LayoutsCommon.Main    contTransform2(Corp2_Raw_NE.Layouts.Temp_EntityWithOfficerTitles input,integer ctr) := transform,
		skip(corp2_mapping.fCleanBusinessName(state_origin,state_desc,input.FirstName + ' ' +input.middleinitial + ' ' + input.LastName).BusinessName= '')

			self.dt_vendor_first_reported		 			:= (integer)fileDate;
			self.dt_vendor_last_reported		 			:= (integer)fileDate;
			self.dt_first_seen							 			:= (integer)fileDate;
			self.dt_last_seen								 			:= (integer)fileDate;
			self.corp_ra_dt_first_seen			 			:= (integer)fileDate;
			self.corp_ra_dt_last_seen				 			:= (integer)fileDate;	
			self.corp_process_date				  			:= fileDate; 
			self.corp_key													:= state_fips +'-'+corp2.t2u(input.AcctNumber);
			self.corp_vendor											:= state_fips ;
			self.corp_state_origin								:= state_origin ;				
			self.corp_inc_state 									:= state_origin ; 
			self.corp_orig_sos_charter_nbr				:= corp2.t2u(input.AcctNumber);	
			self.corp_legal_name									:= corp2_mapping.fCleanBusinessName(state_origin,state_desc,input.CorpStateName).BusinessName;
			self.Cont_full_name               		:= corp2_mapping.fCleanBusinessName(state_origin,state_desc,input.FirstName + ' ' +input.middleinitial + ' ' + input.LastName).BusinessName;
			self.cont_address_line1								:= corp2_mapping.fCleanAddress(State_origin,State_desc,input.OfcrAddress1,input.OfcrAddress2,input.OfcrCity,input.OfcrState,input.OfcrZipcode).AddressLine1;
			self.cont_address_line2								:= corp2_mapping.fCleanAddress(State_origin,State_desc,input.OfcrAddress1,input.OfcrAddress2,input.OfcrCity,input.OfcrState,input.OfcrZipcode).AddressLine2;
			self.cont_address_line3								:= corp2_mapping.fCleanAddress(State_origin,State_desc,input.OfcrAddress1,input.OfcrAddress2,input.OfcrCity,input.OfcrState,input.OfcrZipcode).AddressLine3;
			self.cont_prep_addr_line1							:= corp2_mapping.fCleanAddress(State_origin,State_desc,input.OfcrAddress1,input.OfcrAddress2,input.OfcrCity,input.OfcrState,input.OfcrZipcode).PrepAddrline1;
			self.cont_prep_addr_last_line					:= corp2_mapping.fCleanAddress(State_origin,State_desc,input.OfcrAddress1,input.OfcrAddress2,input.OfcrCity,input.OfcrState,input.OfcrZipcode).PrepAddrLastLine;
			self.cont_Address_type_cd          		:= if(corp2_mapping.fAddressExists(State_origin,State_desc,input.OfcrAddress1,input.OfcrAddress2,input.OfcrCity,input.OfcrState,input.OfcrZipcode).ifAddressExists ,'T','');
			self.cont_Address_type_desc        		:= if(corp2_mapping.fAddressExists(State_origin,State_desc,input.OfcrAddress1,input.OfcrAddress2,input.OfcrCity,input.OfcrState,input.OfcrZipcode).ifAddressExists ,'CONTACT','');
			allTitles															:= corp2.t2u(input.Title1) + ',' + 
																							 corp2.t2u(input.Title2) + ',' +  
																							 corp2.t2u(input.Title3) + ',' + 
																							 corp2.t2u(input.Title4) + ',' + 
																							 corp2.t2u(input.Title5) + ',' + 
																							 corp2.t2u(input.Title6) + ',' + 
																							 corp2.t2u(input.Title7) + ',' + 
																							 corp2.t2u(input.Title8) + ',' + 
																							 corp2.t2u(input.Title9) + ',' + 
																							 corp2.t2u(input.Title10);																						
			work1																 := regexreplace('[,]*$',allTitles,'',NOCASE);
			work2																 := regexreplace('^[,]*',work1,'',NOCASE);
			self.cont_title1_desc           		 := regexreplace('[,]+',work2,',',NOCASE);
			//overloaded field
			self.cont_type_cd										 := map(corp2.t2u(input.PositionTitle)='PRESIDENT'=>'F',			                          
																									corp2.t2u(input.PositionTitle)='SECRETARY'=>'F',										
																									corp2.t2u(input.PositionTitle)='TREASURER'=>'F',
																									corp2.t2u(input.PositionTitle)='DIRECTOR'=>'F',			                          
																									corp2.t2u(input.PositionTitle)='MEMBER'=>'M',										
																									corp2.t2u(input.PositionTitle)='MANAGER'=>'M',
																									'');
			//overloaded field
			self.cont_type_desc									:= map(corp2.t2u(input.PositionTitle)='PRESIDENT'=>'OFFICER',		
																								 corp2.t2u(input.PositionTitle)='SECRETARY'=>'OFFICER',									
																								 corp2.t2u(input.PositionTitle)='TREASURER'=>'OFFICER', 
																								 corp2.t2u(input.PositionTitle)='DIRECTOR'=>'OFFICER',			                          
																								 corp2.t2u(input.PositionTitle)='MEMBER'=>'MEMBER/MANAGER',											
																								 corp2.t2u(input.PositionTitle)='MANAGER'=>'MEMBER/MANAGER',												  																						    											   
																								 '');	
			self.Cont_filing_date							 	 := corp2_mapping.fValidateDate(input.FilingDateTime[1..10],'CCYY-MM-DD').PastDate;	
			self.cont_effective_date 						 := choose(ctr,input.YearInReported,input.YearOutReported);
			self.cont_effective_cd  						 := choose(ctr,if(corp2.t2u(input.YearInReported)<>'','A',''),if(corp2.t2u(input.YearOutReported)<>'','T',''));					
			self.cont_effective_desc 						 := choose(ctr,if(corp2.t2u(input.YearInReported)<>'','ASSIGNED',''),if(corp2.t2u(input.YearOutReported)<>'','TERMINATION',''));		
			self.recordOrigin										 := 'T';			
			self																 := [];

		end;

		mapContOffi		:= normalize(dsCorpOfficerWithEntity, if(corp2.t2u(left.YearOutReported)<>'',2,1),
															 contTransform2(left,counter));

		AllCorps	    := dedup(sort(distribute(mapCorp +  
																					 mapCorpForgn +  
																					 mapContEntiy	+ 
																					 mapContOffi , hash(corp_key)),
														record,local),record,local) :independent;

		ds_actionsDesc := join(CorpAction ,FilingTypeTable,						
													 corp2.t2u(left.serviceTypeCode) = corp2.t2u(right.filingCode),							
													 transform(Corp2_Raw_NE.Layouts.Temp_CorpActionDesc,
																		 self.description	  := corp2.t2u(right.filingDesc2);
																		 self								:= left;),
													 left outer, lookup):independent;
		
		//AR Rec's Mappings  							
		corp2_mapping.LayoutsCommon.AR arTransform1(Corp2_Raw_NE.Layouts.Temp_CorpActionDesc input):= transform,
		skip(corp2.t2u(input.ServiceTypeCode) not in Corp2_Raw_NE.Functions.Set_Of_AR_Codes or
				 corp2.t2u(input.AcctNumber)='' or
		     (integer)(input.taxpayment)= 0 and (integer)(input.taxreportnumber)= 0 and corp2_mapping.fValidateDate(input.taxReceiptDate[1..10],'CCYY-MM-DD').PastDate='' and
		     (integer)(input.DocNumber)= 0 and trim(input.description)= '' and corp2_mapping.fValidateDate(input.DateTimeFiled[1..10],'CCYY-MM-DD').PastDate='' 
				 )
				 
			self.corp_key								:= state_fips +'-'+corp2.t2u(input.AcctNumber);
			self.corp_vendor						:= state_fips ;
			self.corp_state_origin			:= state_origin ;
			self.corp_process_date			:= fileDate;		
			self.corp_sos_charter_nbr 	:= corp2.t2u(input.AcctNumber);	
			self.ar_filed_dt						:= corp2_mapping.fValidateDate(input.DateTimeFiled[1..10],'CCYY-MM-DD').PastDate;															
			self.ar_type								:= input.description;	
			self.ar_report_nbr				 	:= if((integer)(input.DocNumber)<> 0,corp2.t2u(input.DocNumber),'');
			self.ar_tax_amount_paid	    := if((integer)(input.taxpayment)<> 0,corp2.t2u(input.taxpayment),'');
			taxRptDate          				:= corp2_mapping.fValidateDate(input.taxReceiptDate[1..10],'CCYY-MM-DD').PastDate;	
			self.ar_paid_date           := taxRptDate;										
			taxRptNum                   := if((integer)(input.taxreportnumber)<> 0,Corp2.t2u(input.taxreportnumber),'');
			self.ar_comment             := map(trim(taxRptNum)<>'' and trim(taxRptDate)<>''=>'TAX REPORT NUMBER: '+taxRptNum+' '+'TAX RECEIPT DATE: '+taxRptDate,
																				 trim(taxRptNum)<>'' 												 =>'TAX REPORT NUMBER: '+taxRptNum ,
																				 trim(taxRptDate)<>''												 =>'TAX RECEIPT DATE: '+taxRptDate ,
																					'');  //'TAX RECEIPT DATE' overload verbiage 
			self											  := []; 

		end;

		ds_mapAr	:= project(ds_actionsDesc,arTransform1(left));
		MapAr			:= dedup(sort(distribute(ds_mapAr	,hash(corp_key)),
														record,local),record,local):independent; 
		
		//Event Rec's Mappings  
		corp2_mapping.LayoutsCommon.Events EventTransform(Corp2_Raw_NE.Layouts.Temp_CorpActionDesc input,integer ctr):= transform,
		skip(corp2.t2u(input.AcctNumber)='' or
		     (integer)(input.DocNumber)= 0 and corp2.t2u(input.description) = '' and corp2_mapping.fValidateDate(input.datetimefiled[1..10],'CCYY-MM-DD').PastDate='' and
				 corp2_mapping.fValidateDate(input.datetimeeffective[1..10],'CCYY-MM-DD').GeneralDate=''
				)

			self.corp_key										:= if(corp2.t2u(input.ServiceTypeCode) not in Corp2_Raw_NE.Functions.Set_Of_AR_Codes,	state_fips+'-' + corp2.t2u(input.AcctNumber),'');
			self.corp_vendor								:= state_fips ;
			self.corp_state_origin					:= state_origin ;
			self.corp_process_date					:= fileDate;
			self.corp_sos_charter_nbr 			:= if(corp2.t2u(input.ServiceTypeCode) not in Corp2_Raw_NE.Functions.Set_Of_AR_Codes,corp2.t2u(input.AcctNumber),'');	
			self.event_filing_reference_nbr	:= if(corp2.t2u(input.ServiceTypeCode) not in Corp2_Raw_NE.Functions.Set_Of_AR_Codes and (integer)(input.DocNumber)<> 0,corp2.t2u(input.DocNumber),'');
			CleanFilingDate                 := if(corp2.t2u(input.ServiceTypeCode) not in Corp2_Raw_NE.Functions.Set_Of_AR_Codes,corp2_mapping.fValidateDate(input.datetimefiled[1..10],'CCYY-MM-DD').PastDate,'');
			cleanEffDate 								    := if(corp2.t2u(input.ServiceTypeCode) not in Corp2_Raw_NE.Functions.Set_Of_AR_Codes,corp2_mapping.fValidateDate(input.datetimeeffective[1..10],'CCYY-MM-DD').GeneralDate,'');
			self.event_filing_date         	:= choose(ctr,CleanFilingDate,cleanEffDate);
			self.event_date_type_cd         := choose(ctr,if(trim(CleanFilingDate)<>'','FIL',''),if(trim(cleanEffDate)<>'','EFF',''));					
			self.event_date_type_desc       := choose(ctr,if(trim(CleanFilingDate)<>'','FILING',''),if(trim(cleanEffDate)<>'','EFFECTIVE',''));
			self.event_filing_cd						:= if(corp2.t2u(input.ServiceTypeCode) not in Corp2_Raw_NE.Functions.Set_Of_AR_Codes ,corp2.t2u(input.ServiceTypeCode),'');
			self.event_filing_desc					:= if(self.event_filing_cd<>'',input.description,'');
			/* scrubs will catch codes those not have descriptions in the loolup table. 
				 scrubs caught code ,will get a chance to evaluate! whether code belongs to AR file or Event file */
			self.InternalField1             := if(corp2.t2u(input.ServiceTypeCode) not in [Corp2_Raw_NE.Functions.Set_Of_AR_Codes ,Corp2_Raw_NE.Functions.Set_Of_Event_Codes],
																						'**|'+corp2.t2u(input.ServiceTypeCode),'');
			self          									:= [];

		end;

		dsEvents			:= Normalize(ds_actionsDesc, if(corp2.t2u(left.datetimeeffective)<>'',2,1), EventTransform(left, counter)) (trim(event_filing_cd)<>''):independent;
    mapEvents			:= dedup(sort(distribute(dsEvents,hash(corp_key)),
																record,local),record,local):independent;
		//--------------------------------------------------------------------	
			//	Scrubs for MAIN
		//--------------------------------------------------------------------
		Main_F 										:= AllCorps;
		Main_S 										:= Scrubs_corp2_mapping_NE_Main.Scrubs; 				     // Scrubs module
		Main_N 										:= Main_S.FromNone(Main_F); 											  // Generate the error flags
		Main_T 										:= Main_S.FromBits(Main_N.BitmapInfile);     		 	 // Use the FromBits module; makes my bitmap datafile easier to get to
		Main_U 										:= Main_S.FromExpanded(Main_N.ExpandedInFile); 		// Pass the expanded error flags into the Expanded module

		//Outputs reports
		Main_ErrorSummary					:= output(Main_U.SummaryStats, named('Main_ErrorSummary_NE_'+filedate ));
		Main_ScrubErrorReport 		:= output(choosen(Main_U.AllErrors, 1000), named('Main_ScrubErrorReport_NE_'+filedate ));
		Main_SomeErrorValues			:= output(choosen(Main_U.BadValues, 1000), named('Main_SomeErrorValues_NE_'+filedate ));
		Main_IsScrubErrors		 		:= IF(count(Main_U.AllErrors)<> 0,true,false);

		// Orbit Stats
		Main_OrbitStats						:= Main_U.OrbitStats();
		//Creates Profile's alert template for Orbit - Can be copied & imported into Orbit; Only required first time & if scrub rules change
		Main_AlertsCSVTemplate	  := Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_'+ state_origin+'_Main','ScrubsAlerts', Main_OrbitStats, version,'Corp2_'+ state_origin+'_Main').ProfileAlertsTemplate;
		//Submits Profile's stats to Orbit
		Main_SubmitStats 					:= Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_'+ state_origin+'_Main' ,'ScrubsAlerts', Main_OrbitStats, version,'Corp2_'+ state_origin+'_Main').SubmitStats;
		//Outputs files
		Main_CreateBitMaps				:= output(Main_N.BitmapInfile,,'~thor_data::corp_NE_main_scrubs_bits',overwrite,compressed);	//long term storage
		Main_TranslateBitMap			:= output(Main_T);
		Main_ScrubsWithExamples		:= Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_'+ state_origin+'_Main' ,'ScrubsAlerts', Main_OrbitStats, version,'Corp2_'+ state_origin+'_Main').CompareToProfile_with_Examples;

		Main_ScrubsAlert					:= Main_ScrubsWithExamples(RejectWarning = 'Y');
		Main_ScrubsAttachment			:= Scrubs.fn_email_attachment(Main_ScrubsAlert);
		Main_SendEmailFile				:= FileServices.SendEmailAttachData( corp2.Email_Notification_Lists.spray
																																	 ,'Scrubs CorpMain_NE Report' //subject
																																	 ,'Scrubs CorpMain_NE Report' //body
																																	 ,(data)Main_ScrubsAttachment
																																	 ,'text/csv'
																																	 ,'CorpNEMainScrubsReport.csv'
																																	 ,
																																	 ,
																																	 ,corp2.Email_Notification_Lists.spray
																																 );	
																			 
		Main_BadRecords		  := Main_N.ExpandedInFile( dt_vendor_first_reported_Invalid 								<> 0 or
																									dt_vendor_last_reported_Invalid 								<> 0 or
																									dt_first_seen_Invalid 													<> 0 or
																									dt_last_seen_Invalid 														<> 0 or
																									corp_ra_dt_first_seen_Invalid 									<> 0 or
																									corp_ra_dt_last_seen_Invalid 										<> 0 or
																									corp_key_Invalid 																<> 0 or
																									corp_vendor_Invalid 														<> 0 or
																									corp_state_origin_Invalid 											<> 0 or
																									corp_process_date_Invalid 											<> 0 or
																									corp_orig_sos_charter_nbr_Invalid 							<> 0 or
																									corp_legal_name_Invalid 												<> 0 or
																									corp_ln_name_type_cd_Invalid 										<> 0 or
																									corp_address1_effective_date_Invalid 						<> 0 or
																									corp_filing_date_Invalid 												<> 0 or
																									corp_status_cd_Invalid 													<> 0 or
																									corp_inc_state_Invalid 													<> 0 or
																									corp_inc_date_Invalid 													<> 0 or
																									corp_term_exist_exp_Invalid 										<> 0 or
																									corp_term_exist_desc_Invalid 										<> 0 or
																									corp_foreign_domestic_ind_Invalid 							<> 0 or
																									corp_forgn_state_desc_Invalid 									<> 0 or
																									corp_forgn_date_Invalid 												<> 0 or
																									corp_for_profit_ind_Invalid 										<> 0 or
																									corp_orig_org_structure_cd_Invalid 							<> 0 or
																									corp_country_of_formation_Invalid								<> 0 or
																									corp_farm_exemptions_Invalid									  <> 0 or
																									corp_trademark_class_desc1_Invalid							<> 0 or
																									internalfield1_Invalid												  <> 0 or
																									recordorigin_Invalid 														<> 0 
																						);
																																	
		Main_GoodRecords		:= Main_N.ExpandedInFile( dt_vendor_first_reported_Invalid 								= 0 and
																									dt_vendor_last_reported_Invalid 								= 0 and
																									dt_first_seen_Invalid 													= 0 and
																									dt_last_seen_Invalid 														= 0 and
																									corp_ra_dt_first_seen_Invalid 									= 0 and
																									corp_ra_dt_last_seen_Invalid 										= 0 and
																									corp_key_Invalid 																= 0 and
																									corp_vendor_Invalid 														= 0 and
																									corp_state_origin_Invalid 											= 0 and
																									corp_process_date_Invalid 											= 0 and
																									corp_orig_sos_charter_nbr_Invalid 							= 0 and
																									corp_legal_name_Invalid 												= 0 and
																									corp_ln_name_type_cd_Invalid 									  = 0 and
																									corp_address1_effective_date_Invalid 						= 0 and
																									corp_filing_date_Invalid 												= 0 and
																									corp_status_cd_Invalid 													= 0 and
																									corp_inc_state_Invalid 													= 0 and
																									corp_inc_date_Invalid 													= 0 and
																									corp_term_exist_exp_Invalid 										= 0 and
																									corp_term_exist_desc_Invalid 										= 0 and
																									corp_foreign_domestic_ind_Invalid 							= 0 and
																									corp_forgn_state_desc_Invalid 									= 0 and
																									corp_forgn_date_Invalid 												= 0 and
																									corp_for_profit_ind_Invalid 										= 0 and
																									corp_orig_org_structure_cd_Invalid 							= 0 and
																									corp_country_of_formation_Invalid								= 0 and
																									corp_farm_exemptions_Invalid									  = 0 and
																									corp_trademark_class_desc1_Invalid							= 0 and																									
																									internalfield1_Invalid												  = 0 and	
																									recordorigin_Invalid 														= 0 
																					);


		Main_FailBuild	:= map( corp2_mapping.fCalcPercent(count(Main_N.ExpandedInFile(corp_key_invalid<>0)),count(Main_N.ExpandedInFile),false) 										> Scrubs_corp2_mapping_NE_Main.Threshold_Percent.CORP_KEY										   => true,
														corp2_mapping.fCalcPercent(count(Main_N.ExpandedInFile(corp_orig_sos_charter_nbr_invalid<>0)),count(Main_N.ExpandedInFile),false) 	> Scrubs_corp2_mapping_NE_Main.Threshold_Percent.CORP_ORIG_SOS_CHARTER_NBR 	   => true,
														corp2_mapping.fCalcPercent(count(Main_N.ExpandedInFile(corp_legal_name_invalid<>0)),count(Main_N.ExpandedInFile),false) 						> Scrubs_corp2_mapping_NE_Main.Threshold_Percent.CORP_LEGAL_NAME 						   => true,
														false
													);
						
		Main_ApprovedRecords 	:= project(Main_GoodRecords,transform(corp2_mapping.LayoutsCommon.Main,self := left));
		
		Main_ALL		 					:= sequential(IF(count(Main_BadRecords) <> 0
																					,IF (poverwrite
																							,OUTPUT(Main_BadRecords,,corp2_mapping._Dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::main_' 	+ state_origin,overwrite,__compressed__)
																							,OUTPUT(Main_BadRecords,,corp2_mapping._Dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::main_' 	+ state_origin,__compressed__)
																							)
																				 )
																				,output(Main_ScrubsWithExamples, ALL, NAMED('CorpMainScrubsReportWithExamples_NE'+filedate))																		
																				//Send Alerts if Scrubs exceeds thresholds
																				,IF(COUNT(Main_ScrubsAlert) > 0, Main_SendEmailFile, OUTPUT('corp2_mapping.'+state_origin+' - No "MAIN" Corp Scrubs Alerts'))
																				,Main_ErrorSummary
																				,Main_ScrubErrorReport
																				,Main_SomeErrorValues																		 
																				//,Main_AlertsCSVTemplate
																				,Main_SubmitStats
																			);	

		//********************************************************************
			// SCRUB EVENT
		//********************************************************************	
		Event_F := mapEvents;
		Event_S := Scrubs_corp2_mapping_ne_Event.Scrubs;						// Scrubs module
		Event_N := Event_S.FromNone(Event_F); 											// Generate the error flags
		Event_T := Event_S.FromBits(Event_N.BitmapInfile);     			// Use the FromBits module; makes my bitmap datafile easier to get to
		Event_U := Event_S.FromExpanded(Event_N.ExpandedInFile); 		// Pass the expanded error flags into the Expanded module

		//Outputs reports
		Event_ErrorSummary				:= output(Event_U.SummaryStats, named('Event_ErrorSummary_NE'+filedate));
		Event_ScrubErrorReport 		:= output(choosen(Event_U.AllErrors, 1000), named('Event_ScrubErrorReport_NE'+filedate));
		Event_SomeErrorValues			:= output(choosen(Event_U.BadValues, 1000), named('Event_SomeErrorValues_NE'+filedate));
		Event_IsScrubErrors		 		:= IF(count(Event_U.AllErrors)<> 0,true,false);

		//Orbit Stats
		Event_OrbitStats					:= Event_U.OrbitStats();
			//Creates Profile's alert template for Orbit - Can be copied & imported into Orbit; Only required first time & if scrub rules change
		Event_AlertsCSVTemplate	  := Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_'+ state_origin+'_Event','ScrubsAlerts', Event_OrbitStats, version,'Corp2_'+ state_origin+'_Event').ProfileAlertsTemplate;
		//Submits Profile's stats to Orbit
		Event_SubmitStats 				:= Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_'+ state_origin+'_Event','ScrubsAlerts', Event_OrbitStats, version,'Corp2_'+ state_origin+'_Event').SubmitStats;
		//Outputs files
		Event_CreateBitMaps				:= output(Event_N.BitmapInfile,,'~thor_data::corp_ne_event_scrubs_bits',overwrite,compressed);	//long term storage
		Event_TranslateBitMap			:= output(Event_T);
		Event_ScrubsWithExamples	:= Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_'+ state_origin+'_Event','ScrubsAlerts', Event_OrbitStats, version,'Corp2_'+ state_origin+'_Event').CompareToProfile_with_Examples;
		
		Event_ScrubsAlert					:= Event_ScrubsWithExamples(RejectWarning = 'Y');
		Event_ScrubsAttachment		:= Scrubs.fn_email_attachment(Event_ScrubsAlert);
		Event_MailFile						:= FileServices.SendEmailAttachData( corp2.Email_Notification_Lists.spray
																																	 ,'Scrubs CorpEvent_NE Report' //subject
																																	 ,'Scrubs CorpEvent_NE Report' //body
																																	 ,(data)Event_ScrubsAttachment
																																	 ,'text/csv'
																																	 ,'CorpNEEventScrubsReport.csv'
																																	 ,
																																	 ,
																																	 ,corp2.Email_Notification_Lists.spray
																																 );

		Event_BadRecords		:= event_N.ExpandedInFile(corp_key_Invalid    						<> 0 or
																									corp_vendor_Invalid 					  <> 0 or
																									corp_state_origin_Invalid 		  <> 0 or
																									corp_process_date_Invalid		    <> 0 or
																									corp_sos_charter_nbr_Invalid    <> 0 or
																									event_filing_cd_Invalid 			  <> 0 or
																									InternalField1_Invalid          <> 0 
																									);
																																						
		Event_GoodRecords	  := event_N.ExpandedInFile(corp_key_Invalid 								= 0 and
																									corp_vendor_Invalid 						= 0 and
																									corp_state_origin_Invalid 			= 0 and
																									corp_process_date_Invalid				= 0 and
																									corp_sos_charter_nbr_Invalid 		= 0 and
																									event_filing_cd_Invalid 				= 0 and 
																									InternalField1_Invalid          = 0	
																									);
   
		Event_ApprovedRecords	:= project(Event_GoodRecords,transform(corp2_mapping.LayoutsCommon.Events,self := left));

		Event_ALL							:= sequential(IF(count(Event_BadRecords)<> 0
																					 ,IF(poverwrite
																					 ,OUTPUT(Event_BadRecords,,corp2_mapping._Dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::event_' 	+ state_origin,overwrite,__compressed__)
																									 ,OUTPUT(Event_BadRecords,,corp2_mapping._Dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::event_' 	+ state_origin,__compressed__)
																									 )
																						)
																					 ,output(Event_ScrubsWithExamples, ALL, NAMED('CorpEventScrubsReportWithExamples_NE'+filedate))
																					 //Send Alerts if Scrubs exceeds thresholds
																					 ,IF(COUNT(Event_ScrubsAlert) > 0, Event_MailFile, OUTPUT('corp2_mapping.'+state_origin+' - No "EVENT" Corp Scrubs Alerts'))
																					 ,Event_ErrorSummary
																					 ,Event_ScrubErrorReport
																					 ,Event_SomeErrorValues		
																					 	//,Event_AlertsCSVTemplate
																					 ,Event_SubmitStats
																	       );


		//==========================================VERSION CONTROL====================================================
		IsScrubErrors	:= if(Event_IsScrubErrors = true or Main_IsScrubErrors = true,true,false);
		VersionControl.macBuildNewLogicalFile(corp2_mapping._dataset().thor_cluster_Files + 'in::corp2::' + version + '::Main_' 	+ state_origin, Main_ApprovedRecords , main_out,,,pOverwrite);
		VersionControl.macBuildNewLogicalFile(corp2_mapping._dataset().thor_cluster_Files + 'in::corp2::' + version + '::AR_' 		+ state_origin, mapAR	 , AR_out,,,pOverwrite);
		VersionControl.macBuildNewLogicalFile(corp2_mapping._dataset().thor_cluster_Files + 'in::corp2::' + version + '::Event_' 	+ state_origin, Event_ApprovedRecords, event_out,,,pOverwrite);
		
		VersionControl.macBuildNewLogicalFile(corp2_mapping._dataset().thor_cluster_Files + 'fail::corp2::'+version+'::Main_' 	+ state_origin	,Main_F	 ,write_fail_main  ,,,pOverwrite); 
		VersionControl.macBuildNewLogicalFile(corp2_mapping._dataset().thor_cluster_Files + 'fail::corp2::'+version+'::event_' 	+ state_origin	,Event_F ,write_fail_event ,,,pOverwrite);
		
		mapNE:= sequential( if(pshouldspray = true,corp2_mapping.fSprayFiles(state_origin,version,pOverwrite := pOverwrite))
											  // ,Corp2_Raw_ne.Build_Bases(filedate,version,pUseProd).All  // Determined building of bases is not needed
												,main_out
												,event_out
												,ar_out
												,IF(Main_FailBuild <> true OR count(Event_GoodRecords) <> 0	
														,sequential( fileservices.addsuperfile(corp2_mapping._Dataset().thor_cluster_Files + 'in::'+corp2_mapping._Dataset().NameMapped+'::sprayed::ar'		,corp2_mapping._Dataset().thor_cluster_Files + 'in::corp2::'+version+'::ar_' 	+ state_origin)
																				,fileservices.addsuperfile(corp2_mapping._Dataset().thor_cluster_Files + 'in::'+corp2_mapping._Dataset().NameMapped+'::sprayed::event'	,corp2_mapping._Dataset().thor_cluster_Files + 'in::corp2::'+version+'::event_' 	+ state_origin)
																				,fileservices.addsuperfile(corp2_mapping._Dataset().thor_cluster_Files + 'in::'+corp2_mapping._Dataset().NameMapped+'::sprayed::main'	,corp2_mapping._Dataset().thor_cluster_Files + 'in::corp2::'+version+'::main_' 	+ state_origin)																		 
																					,if (count(Main_BadRecords) <> 0 or  count(Event_BadRecords) <> 0 
																							 ,corp2_mapping.Send_Email(state_origin,version,count(Main_BadRecords)<>0,,count(Event_BadRecords)<>0,,count(Main_BadRecords),,count(Event_BadRecords),,count(Main_ApprovedRecords),count(mapAR),count(Event_ApprovedRecords),).RecordsRejected																				 
																							 ,corp2_mapping.Send_Email(state_origin,version,count(Main_BadRecords)<>0,,count(Event_BadRecords)<>0,,count(Main_BadRecords),,count(Event_BadRecords),,count(Main_ApprovedRecords),count(mapAR),count(Event_ApprovedRecords),).MappingSuccess																				 
																							 )
																							 
																					,if(IsScrubErrors
																							,Corp2_Mapping.Send_Email(state_origin,version,Main_IsScrubErrors,false,Event_IsScrubErrors,false).FieldsInvalidPerScrubs
																				     )		 
																			  )
														 ,sequential( write_fail_main  //if it fails on  main file threshold ,still writing mapped files!
																				 ,write_fail_event
																				 ,corp2_mapping.Send_Email(state_origin,version).MappingFailed
																				)
													)
												,Event_All
												,Main_All	
										);
									
		//Validating the filedate entered is within 30 days		
		isFileDateValid := if((string)Std.Date.Today() between ut.date_math(filedate,-30) and ut.date_math(filedate,30),true,false);
		result		 			:= if( isFileDateValid
													 ,mapNE
													 ,sequential (corp2_mapping.Send_Email(state_origin,filedate).InvalidFileDateParm
																				,FAIL('corp2_mapping.'+state_origin+'failed. An invalid filedate was passed in as a parameter.')
																			 )
												 );
		return result;

	end;	// end of Update function

end;  // end of  module
