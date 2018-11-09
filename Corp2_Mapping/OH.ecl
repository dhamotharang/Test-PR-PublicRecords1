 import std, corp2, ut, versioncontrol, scrubs, corp2_raw_oh, scrubs_corp2_mapping_oh_main, scrubs_corp2_mapping_oh_event, tools;
 
 Export OH 	:= Module
 
  Export Update(string fileDate, string version, boolean pShouldSpray = _Dataset().bShouldSpray,boolean pOverwrite = false,pUseProd = Tools._Constants.IsDataland) :=Function

	 state_origin						:='OH';
	 state_fips	 						:='39';	
	 state_desc	 						:='OHIO';
	 
	 ds_Business  					:=dedup(sort(distribute(corp2_raw_oh.Files(filedate,pUseProd).Input.Business.Logical,hash(Charter_Num)),record,local),record,local):independent;
	 ds_Business_Address 		:=dedup(sort(distribute(corp2_raw_oh.Files(filedate,pUseProd).Input.Business_Address.Logical,hash(Charter_Num)),record,local),record,local):independent;
	 ds_Agent_Contact    		:=dedup(sort(distribute(corp2_raw_oh.Files(filedate,pUseProd).Input.Agent_Contact.Logical,hash(Charter_Num)),record,local),record,local):independent;
	 ds_Business_Associate 	:=dedup(sort(distribute(corp2_raw_oh.Files(filedate,pUseProd).Input.Business_Associate.Logical,hash(Charter_Num)),record,local),record,local):independent;
	 ds_Explanation  				:=dedup(sort(distribute(corp2_raw_oh.Files(filedate,pUseProd).Input.Explanation.Logical,hash(Charter_Num)),record,local),record,local):independent;
	 ds_Old_Name   			 		:=dedup(sort(distribute(corp2_raw_oh.Files(filedate,pUseProd).Input.Old_Name.Logical,hash(Charter_Num)),record,local),record,local):independent;
	 ds_Authorized_Share   	:=dedup(sort(distribute(corp2_raw_oh.Files(filedate,pUseProd).Input.Authorized_Share.Logical,hash(Charter_Num)),record,local),record,local):independent;
	 ds_Document_Transaction:=dedup(sort(distribute(corp2_raw_oh.Files(filedate,pUseProd).Input.Document_Transaction.Logical,hash(Charter_Num)),record,local),record,local):independent;
	 ds_Text_Information  	:=dedup(sort(distribute(corp2_raw_oh.Files(filedate,pUseProd).Input.Text_Information.Logical,hash(Charter_Num)),record,local),record,local):independent;
	 
	 CountyCodeTable				:=corp2_raw_oh.Files(filedate,pUseProd).input.CountyCodeTable;
	 ShareTypeTable  				:=corp2_raw_oh.Files(filedate,pUseProd).input.ShareTypeTable;
	 StateCodeTable         :=corp2_raw_oh.Files(filedate,pUseProd).input.StateCodeTable;
	 TranCodeTable          :=corp2_raw_oh.Files(filedate,pUseProd).input.TranCodeTable;

	//*******Corp Rec's Mappings
	 joinBusAddr 			:= join(ds_Business,ds_Business_Address,
													  corp2.t2u(left.Charter_Num) = corp2.t2u(right.Charter_Num),
													  transform(corp2_raw_oh.Layouts.Temp_BusinessAdd,
																		  self:=left; 
																		  self:=right;),
													  left outer,local);
											 
		joinBusAddrCont := join(joinBusAddr,ds_Agent_Contact,
														corp2.t2u(left.Charter_Num) = corp2.t2u(right.Charter_Num),
														transform(corp2_raw_oh.Layouts.Temp_BusinessAddCont,
																		  self:=left; 
																		  self:=right;),
														left outer,local);
														
		//Get the CountyDesc from lookup table
		 joinContCounty := join( joinBusAddrCont,CountyCodeTable,
														 corp2.t2u(left.contact_cnty) = corp2.t2u(right.CountyCode),
														 transform(corp2_raw_oh.Layouts.Temp_BusinessAddCont,
																			 self.contact_cnty   := if(corp2.t2u(right.CountyDesc) not in ['CONVERT','CONVERSION'],corp2.t2u(right.CountyDesc),'');			
																			 self:=left;),
														 left outer, lookup);
														 
		joinBusCounty := 	join( joinContCounty,CountyCodeTable,
														corp2.t2u(left.bus_business_cnty) = corp2.t2u(right.CountyCode),
														transform(corp2_raw_oh.Layouts.Temp_BusinessAddCont,
																			self.bus_business_cnty := if(corp2.t2u(right.CountyDesc) not in ['CONVERT','CONVERSION'],corp2.t2u(right.CountyDesc),'');
																			self:=left;),
														left outer, lookup);
														
		foreign_list	:= ['CF', 'FP', 'LF', 'RC'];
		domestic_list	:= ['BT', 'CH', 'CN', 'CP', 'GL', 'LL', 'LP', 'PR', 'RT','UN'];													
														 
		corp2_mapping.LayoutsCommon.Main OH_corpTrans(corp2_raw_oh.Layouts.Temp_BusinessAddCont input):=transform
		
			self.dt_vendor_first_reported		 	  			:=(integer)fileDate;
			self.dt_vendor_last_reported		 	  			:=(integer)fileDate;
			self.dt_first_seen							 	  			:=(integer)fileDate;
			self.dt_last_seen								 	  			:=(integer)fileDate;
			self.corp_ra_dt_first_seen			 	  			:=(integer)fileDate;
			self.corp_ra_dt_last_seen				 	  			:=(integer)fileDate;
			self.corp_process_date										:= fileDate;    	
			self.corp_key					    			    			:= state_fips + '-' + corp2.t2u(input.charter_num);
			self.corp_orig_sos_charter_nbr      			:= corp2.t2u(input.charter_num);
			self.corp_vendor								    			:= state_fips;
			self.corp_state_origin				  					:= state_origin;
			self.corp_internal_nbr              			:= corp2.t2u(input.processing_id);
			//Per CI: Droping all ending ellipses 
			self.corp_legal_name                			:= corp2_mapping.fCleanBusinessName(state_origin,state_desc,regexreplace('[.]*$',input.Business_Name,'',NOCASE)).BusinessName;
			self.corp_ln_name_type_cd									:= corp2_raw_oh.functions.fGetName_Type_Cd(input.Business_Type);
			self.corp_ln_name_type_desc 							:= map(self.corp_ln_name_type_cd='01'=>'LEGAL',
																											 self.corp_ln_name_type_cd='03'=>'TRADEMARK',
																											 self.corp_ln_name_type_cd='04'=>'TRADENAME',
																											 self.corp_ln_name_type_cd='05'=>'SERVICEMARK',
																											 self.corp_ln_name_type_cd='07'=>'RESERVATION',
																											 self.corp_ln_name_type_cd='09'=>'REGISTRATION',
																											 self.corp_ln_name_type_cd='F'=>'FICTITIOUS BUSINESS NAME',
			                                                 '');
			self.corp_orig_org_structure_cd  	  				:= if(corp2.t2u(input.Business_Type) not in ['FN','MO','NR','RN','SM','TM'] ,corp2.t2u(input.Business_Type),'');
			self.corp_orig_org_structure_desc  					:= corp2_raw_oh.functions.org_structure_desc(self.corp_orig_org_structure_cd);
			self.Corp_for_profit_ind           				  := map(corp2.t2u(input.Business_Type) in ['CN','UN']=>'N',
																												 corp2.t2u(input.Business_Type)='CP'=>'Y',
																												 '');																												 
			self.corp_inc_state													:=state_origin;
			self.corp_organizational_comments						:=map(corp2.t2u(input.Business_Type) ='CV'=>'CONVERSION DEFAULT',
																												corp2.t2u(input.Business_Type) ='FN'=>'FICTITIOUS NAMES',
																												corp2.t2u(input.Business_Type) ='MO'=>'MARKS OF OWNERSHIP',
																												corp2.t2u(input.Business_Type) ='NR'=>'NAME RESERVATIONS',
																												corp2.t2u(input.Business_Type) ='RN'=>'REGISTERED TRADE NAME',
																												corp2.t2u(input.Business_Type) ='SM'=>'SERVICEMARK',
																												corp2.t2u(input.Business_Type) ='TM'=>'TRADEMARK',
																												corp2_raw_oh.functions.org_structure_desc(input.Business_Type)
																												);
			self.corp_foreign_domestic_ind							:= map(corp2.t2u(input.Business_Type) in foreign_list =>'F',
																												 corp2.t2u(input.Business_Type) in domestic_list=>'D',
																												 '');
			valid_date                          				:=corp2_mapping.fValidateDate(input.Bus_Effective_Date_Time,'CCYYMMDD').PastDate;	
			self.corp_inc_date													:= map(corp2.t2u(input.Bus_Business_State)in[ state_origin,''] and corp2.t2u(input.Business_Type)  in domestic_list  =>valid_Date,
																												 corp2.t2u(input.Business_Type) not in foreign_list								 																						 =>valid_Date,
																												 '');
			self.corp_forgn_date												:= map(corp2.t2u(input.Bus_Business_State)not in[ state_origin,''] and corp2.t2u(input.Business_Type) in foreign_list=>valid_Date,
																												 corp2.t2u(input.Bus_Business_State)='' and corp2.t2u(input.Business_Type) in foreign_list										 =>valid_Date,
																												 corp2.t2u(input.Business_Type) in foreign_list																																 =>valid_Date,
																												 '');	
			self.corp_trademark_class_desc1         		:= corp2_raw_oh.functions.fGetTrademarkDesc(input.Business_Class); 
			self.corp_status_cd													:= map(corp2.t2u(input.Business_Status)[1..8] in ['20050920','20150518']=>'',//These are vendor errors!
																												 corp2.t2u(input.Business_Status)
																												 );
			self.corp_status_desc												:= map( self.corp_status_cd='A'=>'ACTIVE',
																													self.corp_status_cd='C'=>'CANCELED BUT NAME NOT RESERVED',
																													self.corp_status_cd='D'=>'DEAD',
																													self.corp_status_cd='H'=>'CANCELED BUT NAME RESERVED',
																													'');
			self.corp_status_date												:= corp2_mapping.fValidateDate(input.Last_Update_Date_Time,'CCYYMMDD').PastDate;		
			self.corp_license_type											:= map(corp2.t2u(input.License_Type)='P'=>'PERMANENT',
																												 corp2.t2u(input.License_Type)='T'=>'TEMPORARY',
																												 corp2.t2u(input.License_Type)
																												 );
			self.corp_consent_flag_for_protected_name		:= map(corp2.t2u(input.Consent_Flag)='Y'=>'Y',
																												 corp2.t2u(input.Consent_Flag)='N'=>'N',
																												 corp2.t2u(input.Consent_Flag) //scrubbing 
																												 );
			self.corp_inc_county												:= corp2.t2u(input.bus_business_cnty);
			//overload fields are (License_Type,Consent_Flag,Business_Class)
			self.corp_addl_info													:= corp2_raw_oh.Functions.GetAddlInfo(input.License_Type,input.Consent_Flag,input.Business_Location_Name,input.Business_Class);       
			self.corp_forgn_state_cd										:= map(corp2.t2u(input.Bus_Business_State)='TOLEDO'=>'OH', //noticed in the data
																												 corp2.t2u(input.Bus_Business_State) not in [state_origin,'']=>corp2.t2u(input.Bus_Business_State),
																												 '');
			self.corp_term_exist_exp										:= corp2_mapping.fValidateDate(input.business_expiry_date,'CCYYMMDD').GeneralDate;
			self.corp_term_exist_desc										:= if(self.corp_term_exist_exp<>'','EXPIRATION DATE','');
			self.corp_term_exist_cd											:= if(self.corp_term_exist_exp<>'','D','');
			self.Corp_Agent_Id													:= if(corp2.t2u(input.contact_doc_id)<>'AGNTUPDT',corp2.t2u(input.contact_doc_id),'');
			self.corp_ra_full_name											:= corp2_mapping.fCleanBusinessName(state_origin,state_desc,input.Contact_name).BusinessName;
			self.corp_ra_address_type_cd		  					:= if(corp2_mapping.faddressexists(state_origin,state_desc,input.contact_addr1,input.contact_addr2,input.contact_city,input.contact_state,input.contact_zip9).ifaddressexists,'R','');
			self.corp_ra_address_type_desc		  				:= if(corp2_mapping.faddressexists(state_origin,state_desc,input.contact_addr1,input.contact_addr2,input.contact_city,input.contact_state,input.contact_zip9).ifaddressexists,'REGISTERED OFFICE','');
			self.corp_ra_address_line1			 	  				:= corp2_mapping.fcleanaddress(state_origin,state_desc,input.contact_addr1,input.contact_addr2,input.contact_city,input.contact_state,input.contact_zip9).addressline1;
			self.corp_ra_address_line2			 	  				:= corp2_mapping.fcleanaddress(state_origin,state_desc,input.contact_addr1,input.contact_addr2,input.contact_city,input.contact_state,input.contact_zip9).addressline2;
			self.corp_ra_address_line3				  				:= corp2_mapping.fcleanaddress(state_origin,state_desc,input.contact_addr1,input.contact_addr2,input.contact_city,input.contact_state,input.contact_zip9).addressline3;
			self.ra_prep_addr_line1						  				:= corp2_mapping.fcleanaddress(state_origin,state_desc,input.contact_addr1,input.contact_addr2,input.contact_city,input.contact_state,input.contact_zip9).prepaddrline1;
			self.ra_prep_addr_last_line				  				:= corp2_mapping.fcleanaddress(state_origin,state_desc,input.contact_addr1,input.contact_addr2,input.contact_city,input.contact_state,input.contact_zip9).prepaddrlastline;
			self.corp_agent_county											:= corp2.t2u(input.contact_cnty);
			self.corp_ra_effective_date									:= corp2_mapping.fvalidatedate(input.cont_effective_date_time,'CCYYMMDD').GeneralDate;
			self.corp_agent_status_cd										:= map( corp2.t2u(input.contact_status)[1..5] in ['20090','20160','20151','20150']=>'',//These are vendor errors!
																													corp2.t2u(input.contact_status)//scrubbing 
																												);
			self.corp_agent_status_desc									:= map(corp2.t2u(input.contact_status)='A'=>'ACTIVE',	
																												 corp2.t2u(input.contact_status)='I'=>'INACTIVE',
																												 '');
			self.corp_name_effective_date								:= corp2_mapping.fValidateDate(input.Bus_Effective_Date_Time,'CCYYMMDD').GeneralDate;
			self.corp_address1_line1										:= corp2_mapping.fcleanaddress(state_origin,state_desc,input.business_addr1,input.business_addr2,input.add_business_city,input.add_business_state,input.business_zip9).addressline1;
			self.corp_address1_line2				 						:= corp2_mapping.fcleanaddress(state_origin,state_desc,input.business_addr1,input.business_addr2,input.add_business_city,input.add_business_state,input.business_zip9).addressline2;
			self.corp_address1_line3				 						:= corp2_mapping.fcleanaddress(state_origin,state_desc,input.business_addr1,input.business_addr2,input.add_business_city,input.add_business_state,input.business_zip9).addressline3;
			self.corp_prep_addr1_line1									:= corp2_mapping.fcleanaddress(state_origin,state_desc,input.business_addr1,input.business_addr2,input.add_business_city,input.add_business_state,input.business_zip9).prepaddrline1;
			self.corp_prep_addr1_last_line							:= corp2_mapping.fcleanaddress(state_origin,state_desc,input.business_addr1,input.business_addr2,input.add_business_city,input.add_business_state,input.business_zip9).prepaddrlastline;
			self.corp_address1_type_cd									:= if(corp2_mapping.faddressexists(state_origin,state_desc,input.business_addr1,input.business_addr2,input.add_business_city,input.add_business_state,input.business_zip9).ifaddressexists,
																												map( corp2.t2u(input.Address_Type)='P'=>'B',
																														 corp2.t2u(input.Address_Type)='T'=>'T',
																														 corp2.t2u(input.Address_Type)='A'=>'F',
																														 corp2.t2u(input.Address_Type)='S'=>'P',
																														''),
																												'');
			self.corp_address1_type_desc								:= if(corp2_mapping.fAddressExists(state_origin,state_desc,input.business_addr1,input.business_addr2,input.Add_Business_City,input.Add_Business_State,input.business_zip9).ifAddressExists,
																												map( corp2.t2u(input.Address_Type)='P'=>'BUSINESS',
																														 corp2.t2u(input.Address_Type)='T'=>'CONTACT',
																														 corp2.t2u(input.Address_Type)='A'=>'FILING',
																														 corp2.t2u(input.Address_Type)='S'=>'PROCESS',
																														 ''),
																												'');
			//overload																			
   	  self.corp_ra_addl_info              			 := if(trim(self.corp_agent_status_desc)<>'' and trim(self.Corp_Agent_Id) <>'' ,
																											 'STATUS: '+trim(self.corp_agent_status_desc,left,right)+'; '+'AGENT ID: '+trim(self.Corp_Agent_Id,left,right),													   
																												if(trim(self.corp_agent_status_desc,left,right)<>'', 'STATUS: '+trim(self.corp_agent_status_desc,left,right),
																													 if(trim(self.Corp_Agent_Id,left,right)<>'', 'AGENT ID: '+trim(self.Corp_Agent_Id,left,right),'') 
																													 )
																											);
			self.recordorigin													 := 'C';
			self          														 := [];	

		end;

		MapCorpBus 	 := project(joinBusCounty, OH_corpTrans(left)):independent ;
		
	  MapCorp      := join( MapCorpBus,StateCodeTable,
													corp2.t2u(left.corp_forgn_state_cd) =corp2.t2u(right.StateCode),
													transform(corp2_mapping.LayoutsCommon.Main,
																		self.corp_forgn_state_desc  := map(corp2.t2u(right.StateDesc)<>''=>corp2.t2u(right.StateDesc),
																																			 trim(left.corp_forgn_state_cd)=''=>'',
																																			 '**|'+left.corp_forgn_state_cd					//scrubs will catch codes those not have descriptions in the table;
																																			 );
																		self         			    			:= left;),
													left outer, lookup
											   );
														
		//*******Prior Rec's Mappings
		joinBus_OldName := join( ds_Old_Name,ds_Business,
														 corp2.t2u(left.Charter_Num) = corp2.t2u(right.Charter_Num),
														 transform(corp2_raw_oh.Layouts.Temp_Bus_Old_Name ,
																			 self:=left; 
																			 self:=right;),
														 inner,local);														 

		corp2_mapping.LayoutsCommon.Main Trans_PriorBusiness(corp2_raw_oh.Layouts.Temp_Bus_Old_Name input):=transform,
		skip(trim(input.charter_num)='' or corp2_mapping.fCleanBusinessName(state_origin,state_desc,input.Old_Name).BusinessName='')
		
			self.dt_vendor_first_reported		 	  		:=(integer)fileDate;
			self.dt_vendor_last_reported		 	  		:=(integer)fileDate;
			self.dt_first_seen							 	  		:=(integer)fileDate;
			self.dt_last_seen								 	  		:=(integer)fileDate;
			self.corp_ra_dt_first_seen			 	  		:=(integer)fileDate;
			self.corp_ra_dt_last_seen				 	  		:=(integer)fileDate;
			self.corp_process_date									:= fileDate;    	
			self.corp_key					    			    		:= state_fips + '-' + corp2.t2u(input.charter_num);
			self.corp_orig_sos_charter_nbr      		:= corp2.t2u(input.charter_num);
			self.corp_vendor								    		:= state_fips;
			self.corp_state_origin				  				:= state_origin;
			self.corp_inc_state											:= state_origin;
			self.corp_legal_name                  	:= corp2_mapping.fCleanBusinessName(state_origin,state_desc,input.Old_Name).BusinessName;
			self.corp_ln_name_type_cd             	:= if(self.corp_legal_name<>'','P','');
			self.corp_ln_name_type_desc           	:= if(self.corp_legal_name<>'','PRIOR','');
			self.corp_name_effective_date						:= corp2_mapping.fValidateDate(input.Old_Effective_Date_Time,'CCYYMMDD').GeneralDate;
			valid_date                          		:=corp2_mapping.fValidateDate(input.Bus_Effective_Date_Time,'CCYYMMDD').PastDate;	
			self.corp_inc_date											:= map(corp2.t2u(input.Bus_Business_State)in[ state_origin,''] and corp2.t2u(input.Business_Type)  in domestic_list  =>valid_Date,
																										 corp2.t2u(input.Business_Type) not in foreign_list								 																						 =>valid_Date,
																										 '');
			self.corp_forgn_date										:= map(corp2.t2u(input.Bus_Business_State)not in[ state_origin,''] and corp2.t2u(input.Business_Type) in foreign_list=>valid_Date,
																										 corp2.t2u(input.Bus_Business_State)='' and corp2.t2u(input.Business_Type) in foreign_list										 =>valid_Date,
																										 corp2.t2u(input.Business_Type) in foreign_list																																 =>valid_Date,
																										 '');	
			self.recordorigin												:= 'C';
			self                                  	:= [];

		end; 

		MapCorpPrior   	 := project(joinBus_OldName,Trans_PriorBusiness(left));
		
		//*******Contact Rec's Mappings
		joinCorpOfficers := join(ds_Business,ds_Business_Associate,
														 corp2.t2u(left.Charter_Num)= corp2.t2u(right.Charter_Num) ,
														 transform(corp2_raw_oh.Layouts.Temp_Bus_Association,
																			 self := left;
																			 self := right;
																			 ),
														 inner,local);

		corp2_mapping.LayoutsCommon.Main in_contactTransform(corp2_raw_oh.Layouts.Temp_Bus_Association  input):=transform,
		skip(trim(input.charter_num)='' or 
				 corp2.t2u(input.business_assoc_name) in['JR','INC','LTD','NONE LISTED'] or
				 corp2_mapping.fCleanBusinessName(state_origin,state_desc,input.business_assoc_name).BusinessName='')

			self.dt_vendor_first_reported		 	  		:=(integer)fileDate;
			self.dt_vendor_last_reported		 	  		:=(integer)fileDate;
			self.dt_first_seen							 	  		:=(integer)fileDate;
			self.dt_last_seen								 	  		:=(integer)fileDate;
			self.corp_ra_dt_first_seen			 	  		:=(integer)fileDate;
			self.corp_ra_dt_last_seen				 	  		:=(integer)fileDate;
			self.corp_process_date									:= fileDate;    	
			self.corp_key					    			    		:= state_fips + '-' + corp2.t2u(input.charter_num);
			self.corp_orig_sos_charter_nbr      		:= corp2.t2u(input.charter_num);
			self.corp_vendor								    		:= state_fips;
			self.corp_state_origin				  				:= state_origin;
			self.corp_inc_state											:= state_origin;
			self.corp_legal_name                		:= corp2_mapping.fCleanBusinessName(state_origin,state_desc,input.Business_Name).BusinessName;
			self.cont_full_name                     := map(corp2.t2u(input.business_assoc_name) in['JR','INC','LTD','NONE LISTED']=>'',
																										 corp2_mapping.fCleanBusinessName(state_origin,state_desc,input.business_assoc_name).BusinessName
																										 );
			self.cont_type_cd												:= map( corp2.t2u(input.Original_Business_Type)in ['FL','FP','GL','LP','LL']=>'M',
																										  corp2.t2u(input.Business_Type)in ['CF','CP','CN','CH','FN','MO','NR',
																																												'RC','RN','RT','SM','TM','BT','00',
																																												'01','02','03','04','05','06','07',
																																												'08','09','10','11','12','13','14',
																																												'15','16','17','18','19','20','21',
																																												'22','23']=>'02',
																											''); 			
			self.cont_type_desc											:= map( self.cont_type_cd	='M' =>'MEMBER/MANAGER/PARTNER',
																											self.cont_type_cd	='02'=>'REGISTRANT',
																											'');
			self.recordorigin												:= 'T';
			self                              			:= [];

		end; 

		MapCont 		    := project(joinCorpOfficers, in_contactTransform(left))(corp2.t2u(cont_full_name)<>'' or corp2.t2u(cont_effective_date)<>'' or corp2.t2u(cont_address_type_cd)<>'');

		AllCorps 		    := dedup(sort(distribute( MapCorp + 
																							MapCorpPrior +
																							MapCont,hash(corp_key)),
																	record,local),record,local):independent;
																	
		//*******AR File Mappings
													
		corp2_mapping.LayoutsCommon.AR OH_ARTrans(corp2_raw_oh.Layouts.Document_TransactionLayoutIn input) := transform,
		skip(corp2.t2u(input.tran_code) not in corp2_raw_oh.functions.Set_Of_Ar_FilingCodes or 
				 trim(input.charter_num)='' or 
				 (corp2_mapping.fValidateDate(input.tran_effective_date_time,'CCYYMMDD').PastDate='' and
				 trim(input.Tran_Code,left,right)='' and
				 trim(input.Doc_Id,left,right)='')
				)				

				self.corp_key					    			:= state_fips + '-'  + corp2.t2u(input.charter_num);
				self.corp_sos_charter_nbr       := corp2.t2u(input.charter_num);
				self.corp_vendor								:= state_fips;
				self.corp_state_origin					:= state_origin;
				self.corp_process_date					:= fileDate;
				self.ar_report_dt								:= corp2_mapping.fValidateDate(input.tran_effective_date_time,'CCYYMMDD').PastDate;
				self.ar_type										:= corp2.t2u(input.Tran_Code);
				self.ar_report_nbr		  				:= corp2.t2u(input.Doc_Id);
				self          									:= [];

		 end;
    
		 OH_AR 				:=  project(ds_Document_Transaction, OH_ARTrans(left));
		
		 join_ar_type := 	join( OH_AR,TranCodeTable,
														corp2.t2u(left.ar_type) = corp2.t2u(right.TranCode),
														transform(corp2_mapping.LayoutsCommon.AR,
																			self.ar_type  := corp2.t2u(right.TranDesc);
																			self					:= left;),
														left outer, lookup
														);
		  MapAR 			:= dedup(sort(distribute(join_ar_type,hash(corp_key)),record,local),record,local):independent ;
			
			//*******Event File Mappings
			corp2_mapping.LayoutsCommon.events OH_EventTrans1(corp2_raw_oh.Layouts.Document_TransactionLayoutIn input) := transform,
			skip(trim(input.charter_num)='' or corp2.t2u(input.Doc_Id + input.Tran_Code + input.tran_effective_date_time)='')

				self.corp_key					    			    := if(corp2.t2u(input.tran_code) not in corp2_raw_oh.functions.Set_Of_Ar_FilingCodes,state_fips + '-'  + corp2.t2u(input.charter_num) ,'');
				self.corp_sos_charter_nbr           := if(corp2.t2u(input.tran_code) not in corp2_raw_oh.functions.Set_Of_Ar_FilingCodes,corp2.t2u(input.charter_num) ,'');
				self.corp_vendor									  := state_fips;
				self.corp_state_origin							:= state_origin;
				self.corp_process_date							:= fileDate;
				self.event_filing_date 							:= if(corp2.t2u(input.tran_code) not in corp2_raw_oh.functions.Set_Of_Ar_FilingCodes,corp2_mapping.fValidateDate(input.tran_effective_date_time,'CCYYMMDD').PastDate ,'');
				self.event_date_type_cd							:= if(self.event_filing_date<>'','FIL','');
				self.event_date_type_desc						:= if(self.event_filing_date<>'','FILING','');
				self.event_filing_reference_nbr		  := corp2.t2u(input.Doc_Id);
				self.event_filing_cd								:= if(corp2.t2u(input.tran_code) not in corp2_raw_oh.functions.Set_Of_Ar_FilingCodes,corp2.t2u(input.Tran_Code),'');
				/* scrubs will catch codes those not have descriptions in the loolup table. 
					 will get a chance to evaluate code whether it belongs to AR file or Event file */
				self.InternalField1                 := if(corp2.t2u(input.Tran_Code) not in [corp2_raw_oh.functions.Set_Of_Ar_FilingCodes,corp2_raw_oh.functions.Set_Of_Event_FilingCodes,''],
																									'**|'+corp2.t2u(input.Tran_Code),''); 
				self          											:= [];

			end;

			MapEvent_DocuTran		:= project(ds_Document_Transaction,OH_EventTrans1(left))(trim(corp_key,left,right)<>'');// filtering AR records ,those have blank corp keys through event transform 
			
		  joinTranCode 				:= 	join( MapEvent_DocuTran,TranCodeTable,
																		corp2.t2u(left.event_filing_cd) =corp2.t2u(right.TranCode),
																		transform(corp2_mapping.LayoutsCommon.events,
																							self.event_filing_desc  := corp2.t2u(right.TranDesc);
																							self										:= left;),
																		left outer, lookup
																		);

			joinBus_Explanation := join( ds_Business,ds_Explanation ,
																	 corp2.t2u(left.Charter_Num)= corp2.t2u(right.Charter_Num),
																	 transform(corp2_raw_oh.Layouts.Temp_Bus_Explanation,
																						 self := right;
																						 self := left;
																						 ),
																	 left outer,local 
																	);
											
	  corp2_mapping.LayoutsCommon.events OH_EventTrans2(corp2_raw_oh.Layouts.Temp_Bus_Explanation input) := transform,
		skip(trim(input.charter_num)='' or corp2.t2u(input.Explanation_Code +input.Create_Date_Time)='' )
		
				self.corp_key					    			    := if(corp2.t2u(input.Explanation_Code) not in corp2_raw_oh.functions.Set_Of_Ar_FilingCodes,state_fips + '-'  + corp2.t2u(input.charter_num),'');
				self.corp_sos_charter_nbr      			:= if(corp2.t2u(input.Explanation_Code) not in corp2_raw_oh.functions.Set_Of_Ar_FilingCodes,corp2.t2u(input.charter_num),'');
				self.corp_vendor										:= state_fips;
				self.corp_state_origin							:= state_origin;
				self.corp_process_date							:= fileDate;
				self.event_filing_date 							:= if(corp2.t2u(input.Explanation_Code) not in corp2_raw_oh.functions.Set_Of_Ar_FilingCodes,corp2_mapping.fValidateDate(input.Create_Date_Time,'CCYYMMDD').PastDate,'');
				self.event_date_type_cd							:= if(self.event_filing_date<>'','FIL','');
				self.event_date_type_desc						:= if(self.event_filing_date<>'','FILING','');
				self.event_filing_cd								:= if(corp2.t2u(input.Explanation_Code) not in corp2_raw_oh.functions.Set_Of_Ar_FilingCodes, corp2.t2u(input.Explanation_Code),'');
				self.event_filing_desc  					  := corp2_raw_oh.functions.fGetFilingDesc(self.event_filing_cd);
				/* scrubs will catch codes those not have descriptions in the loolup table. 
					 will get a chance to evaluate code whether it belongs to AR file or Event file */
				self.InternalField2                 := if(corp2.t2u(input.Explanation_Code) not in [corp2_raw_oh.functions.Set_Of_Ar_FilingCodes,corp2_raw_oh.functions.Set_Of_Event_FilingCodes,''],
																									'**|'+corp2.t2u(input.Explanation_Code),'');
				self          											:= [];

		end;

		MapEvent_Explanation	:= project(joinBus_Explanation,OH_EventTrans2(left))(trim(event_filing_cd,left,right)<>'') ;// filtering AR records those have blank filing codes through event transform 

		MapEvents		  				:= dedup(sort(distribute(joinTranCode +  
																									 MapEvent_Explanation ,hash(corp_key)),
																				record,local),record,local):independent;
																				
		//*******Stock File Mappings
		joinBus_AuthShare 		:= join(ds_Business,ds_Authorized_Share,
																	corp2.t2u(left.charter_num) = corp2.t2u(right.charter_num),
																	transform(corp2_raw_oh.Layouts.Temp_Bus_Authorized_Share,
																						self:=left;
																						self:=right;),
																	left outer,local);

		joinShareType 			  := join(joinBus_AuthShare,ShareTypeTable,
																	corp2.t2u(left.share_code) = corp2.t2u(right.typeCode),
																	Transform(corp2_raw_oh.Layouts.Temp_Bus_Authorized_Share,
																						self.share_code	        := corp2.t2u(right.typeDesc);
																						self         			 			:= left;
																						),
																	left outer, lookup);

		corp2_mapping.LayoutsCommon.stock OH_StockTrans(corp2_raw_oh.Layouts.Temp_Bus_Authorized_Share input):=transform,
		skip(trim(input.charter_num)='' or 
				 corp2.t2u(input.share_tot + input.share_code + input.par_value_amt )='' and  (integer)input.share_credits =0 and  (integer)input.share_proportion_amt =0 
				 )

			self.corp_key					    			    												:= state_fips + '-'  + corp2.t2u(input.charter_num);
			self.corp_sos_charter_nbr      															:= corp2.t2u(input.charter_num);
			self.corp_vendor																						:= state_fips;
			self.corp_state_origin																			:= state_origin;
			self.corp_process_date																			:= fileDate;
			self.stock_shares_issued																		:= corp2.t2u(input.share_tot);
			self.stock_share_credits																		:= (integer)input.share_credits;
			self.stock_stock_description 																:= input.share_code;
			self.stock_par_value			  																:= corp2.t2u(input.par_value_amt);			
			self.stock_shares_proportion_to_ohio_for_foreign_license		:= (integer)input.share_proportion_amt;
			self          																							:= [];

		end;

		MapStock	:= dedup(sort(distribute(project(joinShareType, OH_StockTrans(left)),hash(corp_key)),record,local),record,local);  	

		//--------------------------------------------------------------------	
		//@@@@@@@@@@@@@@	Scrubs for MAIN
		//--------------------------------------------------------------------
		Main_F 										:= AllCorps;
		Main_S 										:= Scrubs_corp2_mapping_OH_Main.Scrubs; 				     // Scrubs module
		Main_N 										:= Main_S.FromNone(Main_F); 											  // Generate the error flags
		Main_T 										:= Main_S.FromBits(Main_N.BitmapInfile);     		 	 // Use the FromBits module; makes my bitmap datafile easier to get to
		Main_U 										:= Main_S.FromExpanded(Main_N.ExpandedInFile); 		// Pass the expanded error flags into the Expanded module

		//Outputs reports
		Main_ErrorSummary					:= output(Main_U.SummaryStats, named('Main_ErrorSummary_OH'+filedate));
		Main_ScrubErrorReport 		:= output(choosen(Main_U.AllErrors, 1000), named('Main_ScrubErrorReport_OH'+filedate));
		Main_SomeErrorValues			:= output(choosen(Main_U.BadValues, 1000), named('Main_SomeErrorValues_OH'+filedate));
		Main_IsScrubErrors		 		:= IF(count(Main_U.AllErrors)<> 0,true,false);

		// Orbit Stats
		Main_OrbitStats						:= Main_U.OrbitStats();
		//Outputs files
		Main_CreateBitMaps				:= output(Main_N.BitmapInfile,,'~thor_data::corp_OH_main_scrubs_bits',overwrite,compressed);	//long term storage
		Main_TranslateBitMap			:= output(Main_T);
		//Creates Profile's alert template for Orbit - can be copied and imported into Orbit; Only required if rules in Orbit change
		Main_AlertsCSVTemplate		:= Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_'+state_origin+'_Main','ScrubsAlerts', Main_OrbitStats, version,'Corp2_'+state_origin+'_Main').ProfileAlertsTemplate;
		//Submits Profile's stats to Orbit
		Main_SubmitStats 			  	:= Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_'+state_origin+'_Main','ScrubsAlerts', Main_OrbitStats, version,'Corp2_'+state_origin+'_Main').SubmitStats;
		Main_ScrubsWithExamples		:= Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_'+state_origin+'_Main','ScrubsAlerts', Main_OrbitStats, version,'Corp2_'+state_origin+'_Main').CompareToProfile_with_Examples;
		
		Main_ScrubsAlert					:= Main_ScrubsWithExamples(RejectWarning = 'Y');
		Main_ScrubsAttachment			:= Scrubs.fn_email_attachment(Main_ScrubsAlert);
		Main_SendEmailFile				:= FileServices.SendEmailAttachData( corp2.Email_Notification_Lists.spray
																																	 ,'Scrubs CorpMain_OH Report' //subject
																																	 ,'Scrubs CorpMain_OH Report' //body
																																	 ,(data)Main_ScrubsAttachment
																																	 ,'text/csv'
																																	 ,'CorpOHMainScrubsReport.csv'
																																	 ,
																																	 ,
																																	 ,corp2.Email_Notification_Lists.spray
																																 );
																									 
		 Main_BadRecords		  := Main_N.ExpandedInFile(  dt_vendor_first_reported_Invalid 							<> 0 or
																										 dt_vendor_last_reported_Invalid 								<> 0 or
																										 dt_first_seen_Invalid 													<> 0 or
																										 dt_last_seen_Invalid 													<> 0 or
																										 corp_ra_dt_first_seen_Invalid 									<> 0 or
																										 corp_ra_dt_last_seen_Invalid 									<> 0 or
																										 corp_key_Invalid 															<> 0 or
																										 corp_vendor_Invalid 														<> 0 or
																										 corp_state_origin_Invalid 											<> 0 or
																										 corp_process_date_Invalid 											<> 0 or
																										 corp_orig_sos_charter_nbr_Invalid 							<> 0 or
																										 corp_legal_name_Invalid 												<> 0 or
																										 corp_ln_name_type_cd_Invalid 									<> 0 or
																										 corp_trademark_class_desc1_Invalid 						<> 0 or
																										 corp_status_cd_Invalid 												<> 0 or
																										 corp_status_date_Invalid 											<> 0 or
																										 corp_inc_state_Invalid 												<> 0 or
																										 corp_inc_date_Invalid 													<> 0 or
																										 corp_term_exist_exp_Invalid 										<> 0 or
																										 corp_term_exist_desc_Invalid 									<> 0 or
																										 corp_foreign_domestic_ind_Invalid 							<> 0 or
																										 corp_forgn_state_cd_Invalid 										<> 0 or
																										 corp_forgn_state_desc_Invalid 									<> 0 or
																										 corp_forgn_date_Invalid 												<> 0 or
																										 corp_orig_org_structure_cd_Invalid 						<> 0 or
																										 corp_for_profit_ind_Invalid 										<> 0 or
																										 corp_ra_effective_date_Invalid 								<> 0 or
																										 corp_agent_status_cd_Invalid 								  <> 0 or
																						         corp_consent_flag_for_protected_name_Invalid   <> 0 or
																						         corp_license_type_Invalid 										  <> 0 or
																										 recordorigin_Invalid 													<> 0 
																									);
																																							
		 Main_GoodRecords		:= Main_N.ExpandedInFile(dt_vendor_first_reported_Invalid 							= 0 and
																								 dt_vendor_last_reported_Invalid 								= 0 and
																								 dt_first_seen_Invalid 													= 0 and
																								 dt_last_seen_Invalid 													= 0 and
																								 corp_ra_dt_first_seen_Invalid 									= 0 and
																								 corp_ra_dt_last_seen_Invalid 									= 0 and
																								 corp_key_Invalid 															= 0 and
																								 corp_vendor_Invalid 														= 0 and
																								 corp_state_origin_Invalid 											= 0 and
																								 corp_process_date_Invalid 											= 0 and
																								 corp_orig_sos_charter_nbr_Invalid 							= 0 and
																								 corp_legal_name_Invalid 												= 0 and
																								 corp_ln_name_type_cd_Invalid 									= 0 and
																								 corp_trademark_class_desc1_Invalid 						= 0 and
																								 corp_status_cd_Invalid 												= 0 and
																								 corp_status_date_Invalid 											= 0 and
																								 corp_inc_state_Invalid 												= 0 and
																								 corp_inc_date_Invalid 													= 0 and
																								 corp_term_exist_exp_Invalid 										= 0 and
																								 corp_term_exist_desc_Invalid 									= 0 and
																								 corp_foreign_domestic_ind_Invalid 							= 0 and
																								 corp_forgn_state_cd_Invalid 										= 0 and
																								 corp_forgn_state_desc_Invalid 									= 0 and
																								 corp_forgn_date_Invalid 												= 0 and
																								 corp_orig_org_structure_cd_Invalid 						= 0 and
																								 corp_for_profit_ind_Invalid 										= 0 and
																								 corp_ra_effective_date_Invalid 								= 0 and
																								 corp_agent_status_cd_Invalid 								  = 0 and
																						     corp_consent_flag_for_protected_name_Invalid   = 0 and
																						     corp_license_type_Invalid 										  = 0 and
																								 recordorigin_Invalid 													= 0 
																					    );


		 Main_FailBuild	:= map( corp2_mapping.fCalcPercent(count(Main_N.ExpandedInFile(corp_key_invalid<>0)),count(Main_N.ExpandedInFile),false) 										> Scrubs_corp2_mapping_OH_Main.Threshold_Percent.CORP_KEY										   => true,
														corp2_mapping.fCalcPercent(count(Main_N.ExpandedInFile(corp_orig_sos_charter_nbr_invalid<>0)),count(Main_N.ExpandedInFile),false) 	> Scrubs_corp2_mapping_OH_Main.Threshold_Percent.CORP_ORIG_SOS_CHARTER_NBR 	   => true,
														corp2_mapping.fCalcPercent(count(Main_N.ExpandedInFile(corp_legal_name_invalid<>0)),count(Main_N.ExpandedInFile),false) 						> Scrubs_corp2_mapping_OH_Main.Threshold_Percent.CORP_LEGAL_NAME 						   => true,
														count(Main_GoodRecords) = 0																																																																																											 	 => true,																		
														false
   												);
												
		 Main_ApprovedRecords 	:= project(Main_GoodRecords,transform(corp2_mapping.LayoutsCommon.Main,self := left));

		//==========================================VERSION CONTROL====================================================

		 Main_ALL		 			:= sequential(IF(count(Main_BadRecords) <> 0
																				,IF (poverwrite
																						,OUTPUT(Main_BadRecords,,corp2_mapping._Dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::main_' 	+ state_origin,overwrite,__compressed__)
																						,OUTPUT(Main_BadRecords,,corp2_mapping._Dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::main_' 	+ state_origin,__compressed__)
																						)
																	     )
																		,output(Main_ScrubsWithExamples, ALL, NAMED('CorpMainScrubsReportWithExamples_OH'+filedate))																		
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
		Event_S := Scrubs_corp2_mapping_oh_Event.Scrubs;						// Scrubs module
		Event_N := Event_S.FromNone(Event_F); 											// Generate the error flags
		Event_T := Event_S.FromBits(Event_N.BitmapInfile);     			// Use the FromBits module; makes my bitmap datafile easier to get to
		Event_U := Event_S.FromExpanded(Event_N.ExpandedInFile); 		// Pass the expanded error flags into the Expanded module

		//Outputs reports
		Event_ErrorSummary				:= output(Event_U.SummaryStats, named('Event_ErrorSummary_OH'+filedate));
		Event_ScrubErrorReport 		:= output(choosen(Event_U.AllErrors, 1000), named('Event_ScrubErrorReport_OH'+filedate));
		Event_SomeErrorValues			:= output(choosen(Event_U.BadValues, 1000), named('Event_SomeErrorValues_OH'+filedate));
		Event_IsScrubErrors		 		:= IF(count(Event_U.AllErrors)<> 0,true,false);

		// Orbit Stats
		Event_OrbitStats					:= Event_U.OrbitStats();

		//Outputs files
		Event_CreateBitMaps				:= output(Event_N.BitmapInfile,,'~thor_data::corp_oh_event_scrubs_bits',overwrite,compressed);	//long term storage
		Event_TranslateBitMap			:= output(Event_T);
		//Creates Profile's alert template for Orbit - Can be copied & imported into Orbit; Only required first time & if scrub rules change
		Event_AlertsCSVTemplate	  := Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_'+ state_origin+'_Event','ScrubsAlerts', Event_OrbitStats, version,'Corp2_'+ state_origin+'_Event').ProfileAlertsTemplate;
		//Submits Profile's stats to Orbit
		Event_SubmitStats 				:= Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_'+ state_origin+'_Event','ScrubsAlerts', Event_OrbitStats, version,'Corp2_'+ state_origin+'_Event').SubmitStats;
		Event_ScrubsWithExamples	:= Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_'+ state_origin+'_Event','ScrubsAlerts', Event_OrbitStats, version,'Corp2_'+ state_origin+'_Event').CompareToProfile_with_Examples;
		
		Event_ScrubsAlert					:= Event_ScrubsWithExamples(RejectWarning = 'Y');
		Event_ScrubsAttachment		:= Scrubs.fn_email_attachment(Event_ScrubsAlert);
		Event_MailFile						:= FileServices.SendEmailAttachData( corp2.Email_Notification_Lists.spray
																																	 ,'Scrubs CorpEvent_oh Report' //subject
																																	 ,'Scrubs CorpEvent_oh Report' //body
																																	 ,(data)Event_ScrubsAttachment
																																	 ,'text/csv'
																																	 ,'CorpOHEventScrubsReport.csv'
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
																									InternalField1_Invalid          <> 0 or
																									InternalField2_Invalid          <> 0
																									);
																																						
		Event_GoodRecords	  := event_N.ExpandedInFile(corp_key_Invalid 								= 0 and
																									corp_vendor_Invalid 						= 0 and
																									corp_state_origin_Invalid 			= 0 and
																									corp_process_date_Invalid				= 0 and
																									corp_sos_charter_nbr_Invalid 		= 0 and
																									event_filing_cd_Invalid 				= 0 and 
																									InternalField1_Invalid          = 0	and
																									InternalField2_Invalid          = 0
																									);
   
		Event_ApprovedRecords	:= project(Event_GoodRecords,transform(corp2_mapping.LayoutsCommon.Events,self := left));

		Event_ALL							:= sequential(IF(count(Event_BadRecords)<> 0
																					 ,if(poverwrite
																					 ,OUTPUT(Event_BadRecords,,corp2_mapping._Dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::event_' 	+ state_origin,overwrite,__compressed__)
																									 ,OUTPUT(Event_BadRecords,,corp2_mapping._Dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::event_' 	+ state_origin,__compressed__)
																									 )
																						)
																					 ,output(Event_ScrubsWithExamples, ALL, NAMED('CorpEventScrubsReportWithExamples_OH'+filedate))
																					 //Send Alerts if Scrubs exceeds thresholds
																					 ,IF(COUNT(Event_ScrubsAlert) > 0, Event_MailFile, OUTPUT('corp2_mapping.'+state_origin+' - No "EVENT" Corp Scrubs Alerts'))
																					 ,Event_ErrorSummary
																					 ,Event_ScrubErrorReport
																					 ,Event_SomeErrorValues
																				 //,Event_AlertsCSVTemplate
																					 ,Event_SubmitStats
																	       );


		//==========================================VERSION CONTROL====================================================
		VersionControl.macBuildNewLogicalFile(corp2_mapping._dataset().thor_cluster_Files + 'in::corp2::' + version + '::Main_' 	+ state_origin, Main_ApprovedRecords , main_out,,,pOverwrite);
		VersionControl.macBuildNewLogicalFile(corp2_mapping._dataset().thor_cluster_Files + 'in::corp2::' + version + '::AR_' 		+ state_origin, mapAR	 , AR_out,,,pOverwrite);
		VersionControl.macBuildNewLogicalFile(corp2_mapping._dataset().thor_cluster_Files + 'in::corp2::' + version + '::Event_' 	+ state_origin, Event_ApprovedRecords, event_out,,,pOverwrite);
		VersionControl.macBuildNewLogicalFile(corp2_mapping._dataset().thor_cluster_Files + 'in::corp2::' + version + '::Stock_' 	+ state_origin, mapStock, stock_out,,,pOverwrite);

		VersionControl.macBuildNewLogicalFile(corp2_mapping._dataset().thor_cluster_Files + 'fail::corp2::'+version+'::Main_' 	+ state_origin	,Main_F	 ,write_fail_main  ,,,pOverwrite); 
		VersionControl.macBuildNewLogicalFile(corp2_mapping._dataset().thor_cluster_Files + 'fail::corp2::'+version+'::event_' 	+ state_origin	,Event_F ,write_fail_event ,,,pOverwrite);

		mapOH:= sequential( if(pshouldspray = true,corp2_mapping.fSprayFiles(state_origin,version,pOverwrite := pOverwrite))
											  // ,corp2_raw_oh.Build_Bases(filedate,version,pUseProd).All  // Determined building of bases is not needed
												,main_out
												,event_out
												,ar_out
												,stock_out										
												,IF(Main_FailBuild <> true OR count(Event_GoodRecords) <> 0	
														,sequential( fileservices.addsuperfile(corp2_mapping._Dataset().thor_cluster_Files + 'in::'+corp2_mapping._Dataset().NameMapped+'::sprayed::ar'		,corp2_mapping._Dataset().thor_cluster_Files + 'in::corp2::'+version+'::ar_' 	+ state_origin)
																				,fileservices.addsuperfile(corp2_mapping._Dataset().thor_cluster_Files + 'in::'+corp2_mapping._Dataset().NameMapped+'::sprayed::event'	,corp2_mapping._Dataset().thor_cluster_Files + 'in::corp2::'+version+'::event_' 	+ state_origin)
																				,fileservices.addsuperfile(corp2_mapping._Dataset().thor_cluster_Files + 'in::'+corp2_mapping._Dataset().NameMapped+'::sprayed::main'	,corp2_mapping._Dataset().thor_cluster_Files + 'in::corp2::'+version+'::main_' 	+ state_origin)																		 
																				,fileservices.addsuperfile(corp2_mapping._Dataset().thor_cluster_Files + 'in::'+corp2_mapping._Dataset().NameMapped+'::sprayed::stock'	,corp2_mapping._Dataset().thor_cluster_Files + 'in::corp2::'+version+'::stock_' 	+ state_origin)
																				,if (count(Main_BadRecords) <> 0 or  count(Event_BadRecords) <> 0 
																						 ,corp2_mapping.Send_Email(state_origin,version,count(Main_BadRecords)<>0,,count(Event_BadRecords)<>0,,count(Main_BadRecords),,count(Event_BadRecords),,count(Main_ApprovedRecords),count(mapAR),count(Event_ApprovedRecords),count(mapStock)).RecordsRejected																				 
																						 ,corp2_mapping.Send_Email(state_origin,version,count(Main_BadRecords)<>0,,count(Event_BadRecords)<>0,,count(Main_BadRecords),,count(Event_BadRecords),,count(Main_ApprovedRecords),count(mapAR),count(Event_ApprovedRecords),count(mapStock)).MappingSuccess																				 
																						 )
																						 
																				,IF(Main_IsScrubErrors
																						,corp2_mapping.Send_Email(state_origin,version,Main_IsScrubErrors,false,Event_IsScrubErrors,false).FieldsInvalidPerScrubs
																						)	
																			  )
														 ,sequential( write_fail_main  //if it fails on main file threshold ,still writing mapped files!
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
													 ,mapOH
													 ,sequential (corp2_mapping.Send_Email(state_origin,filedate).InvalidFileDateParm
																				,FAIL('corp2_mapping.'+state_origin+' failed. An invalid filedate was passed in as a parameter.')
																			 )
												 );
		return result;

	end;	// end of Update function

end;  // end of OH module