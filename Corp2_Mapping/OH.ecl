import Corp2,ut, lib_stringlib, _validate, Address, _control, versioncontrol;
export OH  := MODULE;

	export Layouts_Raw_Input := MODULE;
	
 
		export Business := record
		
			string   Charter_Num;
			string   Processing_Id;                
			string   Business_Name;
			string   Business_Type; 
			string   Original_Business_Type;              
			string   Tran_Code;
			string   Bus_Effective_Date_Time;            
			string   Business_Class;     
			string   Business_Status;         
			string   License_Type;       
			string   Consent_Flag;      
			string   Share_Proportion_Amt;      
			string   Share_Credits;            
			string   Bus_Business_Cnty;         
			string   Business_Location_Name;
			string   Bus_Business_State;
			string   Business_Address_Flag;
			string   Agent_Contact_Flag;
			string   Business_Associate_Flag;
			string   Authorized_Share_Flag;
			string   Old_Name_Flag;
			string   Create_Date_Time;
			string   Create_User_Id;
			string   Last_Update_Date_Time;
			string   Last_Update_User_Id;
			string   Doc_Tran_Count;
			string   Business_Expiry_Date;
		
		end;
		export Old_Name := record
		 
			string  Charter_Num; 
			string   Old_Effective_Date_Time;                  
			string   Old_Name ;                
		     
		end;
			
		export Bus_Old_Name := record
		 
			Business;
			string   Old_Effective_Date_Time;                  
			string   Old_Name ;                
		     
		end;
		
		export Business_Address := record
		
			string  Charter_Num; 
			string  Address_Type;                 
			string  Business_Addr1; 
			string  Business_Addr2; 
			string  Add_Business_City;     //pvs  Add_Business_Cnty            
			string  Add_Business_State;
			string  Business_Zip9;
			string  Business_Cnty;                  
					     
		end;
		
		export Business_Associate := record	
			string  Charter_Num; 
			string  Business_Assoc_Line_co;                 
			string  Business_Assoc_Name;            
		end;
		
		export Authorized_Share := record
			string  Charter_Num; 
			string  Share_Code;                 
			string  Par_Value_Amt;
			string  Share_Tot;
		end;
		
		export Text_Information := record
		
			string  Charter_Num; 
			string  Doc_Count;
			string  Doc_Text;                   
			       	     
		end;
		
		export BusinessAdd:= record
		
			string   Charter_Num;
			string   Processing_Id;                
			string   Business_Name;
			string   Business_Type; 
			string   Original_Business_Type;              
			string   Tran_Code;
			string   Bus_Effective_Date_Time;            
			string   Business_Class;     
			string   Business_Status;         
			string   License_Type;       
			string   Consent_Flag;      
			string   Share_Proportion_Amt;      
			string   Share_Credits;            
			string   Bus_Business_Cnty; 
			string   Bus_Business_Cnty_Full;
			string   Business_Location_Name;
			string   Bus_Business_State;
			string   Business_Address_Flag;
			string   Agent_Contact_Flag;
			string   Business_Associate_Flag;
			string   Authorized_Share_Flag;
			string   Old_Name_Flag;
			string   Create_Date_Time;
			string   Create_User_Id;
			string   Last_Update_Date_Time;
			string   Last_Update_User_Id;
			string   Doc_Tran_Count;
			string   Business_Expiry_Date;
			
			
			
			string  Address_Type;                 
			string  Business_Addr1; 
			string  Business_Addr2; 
			string  Add_Business_City;    //pvs   Business_city               
			string  Add_Business_State;
			string  Business_Zip9;
			string  Business_Cnty; 							
			end;
			
		export BusinessAddCont:= record
		    BusinessAdd;
			
			string	Contact_Doc_Id;
			string	Contact_name;
			string	Contact_Addr1;
			string	Contact_Addr2;
			string	Contact_City;
			string	Contact_State;
			string	Contact_Cnty;
			string  Contact_Cnty_Full;
			string	Contact_Zip9;
			string	Cont_Effective_Date_Time;
			string	Contact_Status;			
		
		end;
		
		export Document_Transaction := record
						
			string	 Charter_Num;
			string	 Processing_ID;
			string	 Doc_Id;
			string	 Doc_count;
			string	 Tran_Code;
			string	 Tran_Effective_Date_Time;
			string	 Create_Date_Time;
			string	 Create_User_Id;
			string	 Explanation_Flag;
			string	 Text_Information_Flag;

		end;
		
		export Explanation := record
			string	    Charter_Num;
			string	    Doc_Count;
			string	    Explanation_Code;
		
		end; // end Explanation record

		export Agent_Contact := record
			
			string 	Charter_Num;
			string	Contact_Doc_Id;
			string	Contact_name;
			string	Contact_Addr1;
			string	Contact_Addr2;
			string	Contact_City;
			string	Contact_State;
			string	Contact_Cnty;
			string	Contact_Zip9;
			string	Cont_Effective_Date_Time;
			string	Contact_Status;			


		end;// end of agent contact
		
		// combined business and document_transaction M.R.
		export BusinessDocTransaction := record
			
			string  Charter_Num;
			string  Processing_Id;                
			string  Business_Name;
			string  Business_Type; 
			string  Original_Business_Type;              
			string  Tran_Code;
			string  Effective_Date_Time;            
			string  Business_Class;     
			string  Business_Status;         
			string  License_Type;       
			string  Consent_Flag;      
			string  Share_Proportion_Amt;      
			string  Share_Credits;            
			string  Bus_Business_Cnty;         //pvs    Business_Cnty
			string  Business_Location_Name;
			string  Bus_Business_State;
			string  Business_Address_Flag;
			string  Agent_Contact_Flag;
			string  Business_Associate_Flag;
			string  Authorized_Share_Flag;
			string  Old_Name_Flag;
			string  Create_Date_Time;
			string  Create_User_id;
			string  last_update_date_time;
			string  last_update_User_id;
			string  Doc_Tran_Count;
			string  Business_Expiry_Date;
			string  Doc_Id;
			string  Doc_count;
			string	Explanation_Flag;
			string	Text_Information_Flag;

		end;
		
		// combined business & Business_Assoc
		export Business_Association := record

			string  Charter_Num;
			string  Processing_Id;                
			string  Business_Name;
			string  Business_Type; 
			string  Original_Business_Type;              
			string  Tran_Code;
			string  Effective_Date_Time;            
			string  Business_Class;     
			string  Business_Status;         
			string  License_Type;       
			string  Consent_Flag;      
			string  Share_Proportion_Amt;      
			string  Share_Credits;            
			string  Bus_Business_Cnty;         //pvs    Business_Cnty
			string  Business_Location_Name;
			string  Bus_Business_State;
			string  Business_Address_Flag;
			string  Agent_Contact_Flag;
			string  Business_Associate_Flag;
			string  Authorized_Share_Flag;
			string  Old_Name_Flag;
			string  Create_Date_Time;
			string  Create_User_id;
			string  last_update_date_time;
			string  last_update_User_id;
			string  Doc_Tran_Count;
			string  Business_Expiry_Date;
			string  Business_Assoc_Line_co;                 
			string  Business_Assoc_Name; 

		
		end;
		
		// combined explanation and Text Information
		export ExplanationTextInformation  := record

			string	Charter_Num;
			string	Doc_Count;
			string	Explanation_Code;
			string	Doc_Text;


		end;
		
		// combined explanationTextInformation and doc_transactions
		export ExplanationTextDocTrans := record

			string	Charter_Num;
			string	Processing_ID;
			string	Doc_Id;
			string	Doc_count;
			string	Tran_Code;
			string	Effective_Date_Time;
			string	Create_Date_Time;
			string	Create_User_Id;
			string	Explanation_Flag;
			string	Text_Information_Flag;
			string	Explanation_Code;
			string	Doc_Text;


		end;
		
		// combined business and authorized share
		export BusinessAuthorized_Share := record

			string  Charter_Num;
			string  Processing_Id;                
			string  Business_Name;
			string  Business_Type; 
			string  Original_Business_Type;              
			string  Tran_Code;
			string  Effective_Date_Time;            
			string  Business_Class;     
			string  Business_Status;         
			string  License_Type;       
			string  Consent_Flag;      
			string  Share_Proportion_Amt;      
			string  Share_Credits;            
			string  Bus_Business_Cnty;         //pvs   Business_Cnty
			string  Business_Location_Name;
			string  Bus_Business_State;
			string  Business_Address_Flag;
			string  Agent_Contact_Flag;
			string  Business_Associate_Flag;
			string  Authorized_Share_Flag;
			string  Old_Name_Flag;
			string  Create_Date_Time;
			string  Create_User_id;
			string  last_update_date_time;
			string  last_update_User_id;
			string  Doc_Tran_Count;
			string  Business_Expiry_Date;
			string  Share_code;
			string  Par_Value_Amt;
			string  Share_Tot;
			string  stock_par_value;

		end;

		
    end; // end of Layouts_Raw_Input module
	
	export Files_Raw_Input := MODULE;
	
		export BusinessFile (string fileDate)             := dataset('~thor_data400::in::corp2::'+fileDate+'::Business::oh',
														     layouts_Raw_Input.Business,CSV(SEPARATOR(['|']), TERMINATOR(['\r\n', '\n'])));
																			 
		export OldName (string fileDate)                  := dataset('~thor_data400::in::corp2::'+fileDate+'::Old_Name::oh',
														     layouts_Raw_Input.Old_Name,CSV(SEPARATOR(['|']), TERMINATOR(['\r\n', '\n'])));
															 
		export BusinessAddress (string fileDate)          := dataset('~thor_data400::in::corp2::'+fileDate+'::Business_Address::oh',
														     layouts_Raw_Input.Business_Address,CSV(SEPARATOR(['|']), TERMINATOR(['\r\n', '\n'])));
														
		export BusinessAssociate (string fileDate)        := dataset('~thor_data400::in::corp2::'+fileDate+'::Business_Associate::oh',
		                                                     layouts_Raw_Input.Business_Associate,CSV(SEPARATOR(['|']), TERMINATOR(['\r\n', '\n'])));
														
		export AuthorizedShare (string fileDate)          := dataset('~thor_data400::in::corp2::'+fileDate+'::Authorized_Share::oh',
		                                                     layouts_Raw_Input.Authorized_Share,CSV(SEPARATOR(['|']), TERMINATOR(['\r\n', '\n'])));
														
		export TextInformation (string fileDate)          := dataset('~thor_data400::in::corp2::'+fileDate+'::Text_Information::oh',
														     layouts_Raw_Input.Text_Information,CSV(SEPARATOR(['|']), TERMINATOR(['\r\n', '\n'])));
															 
		export DocumentTransaction (string fileDate)      := dataset('~thor_data400::in::corp2::'+fileDate+'::Document_Transaction::oh',
														     layouts_Raw_Input.Document_transaction,CSV(SEPARATOR(['|']), TERMINATOR(['\r\n', '\n'])));
															 
		export Explanation (string fileDate)              := dataset('~thor_data400::in::corp2::'+fileDate+'::Explanation::oh',
														     layouts_Raw_Input.Explanation,CSV(SEPARATOR(['|']), TERMINATOR(['\r\n', '\n'])));
															 
		export AgentContact (string fileDate)             := dataset('~thor_data400::in::corp2::'+fileDate+'::Agent_Contact::oh',
														     layouts_Raw_Input.Agent_Contact,CSV(SEPARATOR(['|']), TERMINATOR(['\r\n', '\n'])));												

	end;	
		
	export Files_PreCleaned := MODULE;
	
		export corpPre    := dataset('~thor_data400::in::corp2::uncleaned::corp_oh', corp2_mapping.Layout_CorpPreClean, CSV(SEPARATOR(['|']), TERMINATOR(['\r\n', '\n'])));
		export contactPre := dataset('~thor_data400::in::corp2::uncleaned::cont_oh', corp2_mapping.Layout_ContPreClean, CSV(SEPARATOR(['|']), TERMINATOR(['\r\n', '\n'])));


    end;
	

	
	export Update(string fileDate, string version, boolean pShouldSpray = _Dataset().bShouldSpray,boolean pOverwrite = false) := function
		
		ValidTranCode := [	'00L', '01L', '02L', '03L', '04L', '05L', '06L', '07L', '08L', '09L', '10L',
							'70L', '71L', '72L', '73L', '74L', '75L', '76L', '77L', '78L', '79L', '80L', 
							'81L', '82L', '83L', '84L', '85L', '86L', '87L', '88L', '89L', '90L', '91L', 
							'92L', '93L', '94L', '95L', '96L', '97L', '98L', '99L', 
							'00A', '01A', '02A', '03A', '04A', '05A', '06A', '07A', '08A', '09A', '10A',
							'60A', '61A', '62A', '63A', '64A', '65A', '66A', '67A', '68A', '69A', '93A',
							'94A', '95A', '96A', '97A', '98A', '99A'];
							
		trimUpper(string s) := function
			return trim(stringlib.StringToUppercase(s),left,right);
		end;
       
		//statecode type layout
			StateCodeLayout := record
			string StateCode;
			string StateDesc;
			
		end;							
		  
		  
		StateCodeTable := dataset('~thor_data400::lookup::corp2::' + fileDate + '::StateCodeType_Table::oh',StateCodeLayout,CSV(SEPARATOR(['|']), TERMINATOR(['\r\n', '\n'])));
		//Trancode type layout
			TranCodeLayout := record
			string TranCode;
			string TranDesc;
			
		end;							
		  
		  
		TranCodeTable := dataset('~thor_data400::lookup::corp2::' + fileDate + '::TranCodeType_Table::oh',TranCodeLayout,CSV(SEPARATOR(['|']), TERMINATOR(['\r\n', '\n'])));
		
		//Countycode type layout
		CountyCodeLayout := record
			string CountyCode;
			string CountyDesc;
			
		end;							
		  
		  
		CountyCodeTable := dataset('~thor_data400::lookup::corp2::' + fileDate + '::CountyCodeType_Table::oh',CountyCodeLayout,CSV(SEPARATOR(['|']), TERMINATOR(['\r\n', '\n'])));
	
	
		
		
		  
        corp2_mapping.Layout_CorpPreClean OH_corp1Transform_Business(layouts_raw_input.BusinessAddCont input):=transform
     	    self.dt_first_seen					:= fileDate;
			self.dt_last_seen					:= fileDate;
			self.dt_vendor_first_reported		:= fileDate;
			self.dt_vendor_last_reported		:= fileDate;
			self.corp_ra_dt_first_seen			:= fileDate;
			self.corp_ra_dt_last_seen			:= fileDate;
			self.corp_key					    := '39-' +trim(input.charter_num, left, right);
			self.corp_vendor					:= '39';
			self.corp_state_origin				:= 'OH';
			self.corp_process_date				:= fileDate;    
			self.corp_orig_sos_charter_nbr      :=trim(input.charter_num, left, right);
			self.corp_internal_nbr              :=trim(input.PROCESSING_ID, left, right);
			self.corp_entity_desc               :=trim(input.Tran_Code, left, right);
            self.corp_status_cd                 :=if(trim(input.Business_Status,left,right)<>'', trim(input.Business_Status,left,right),'');
	     
	        self.corp_address1_type_desc        := map(trim(stringlib.StringtoUpperCase(input.Address_Type),left,right)='P'=>'BUSINESS',
			                                           trim(stringlib.StringtoUpperCase(input.Address_Type),left,right)='T'=>'CONTACT',
													   ''
                                                   );
			 self.corp_address2_type_desc        := map(
													   trim(stringlib.StringtoUpperCase(input.Address_Type),left,right)='A'=>'FILING',
													   trim(stringlib.StringtoUpperCase(input.Address_Type),left,right)='S'=>'PROCESS',''
                                                   );	
												   
												   
			self.corp_address1_type_cd		    :=if(trim(stringlib.StringtoUpperCase(input.Address_Type),left,right) = 'P' 
			                                            or trim(stringlib.StringtoUpperCase(input.Address_Type),left,right) = 'T' ,input.Address_Type,'');
			self.corp_address2_type_cd			:=if( trim(stringlib.StringtoUpperCase(input.Address_Type),left,right) = 'A' 
			                                            or trim(stringlib.StringtoUpperCase(input.Address_Type),left,right) = 'S',input.Address_Type,'');		
	        self.corp_address1_line1            :=if( trim(stringlib.StringtoUpperCase(input.Address_Type),left,right) = 'P' 
			                                            or trim(stringlib.StringtoUpperCase(input.Address_Type),left,right) = 'T' ,
														 if(trim(input.Business_Addr1,left,right)<>'',input.Business_Addr1,input.Business_Addr2),
														 '' );
	        self.corp_address1_line2            := if( trim(stringlib.StringtoUpperCase(input.Address_Type),left,right) = 'P' 
			                                            or trim(stringlib.StringtoUpperCase(input.Address_Type),left,right) = 'T' ,
														 if(trim(input.Business_Addr1,left,right)<>'',input.Business_Addr2,''),
														 '' );
			 self.corp_address2_line1            :=if( trim(stringlib.StringtoUpperCase(input.Address_Type),left,right) = 'A' 
			                                            or trim(stringlib.StringtoUpperCase(input.Address_Type),left,right) = 'S' ,
														 if(trim(input.Business_Addr1,left,right)<>'',input.Business_Addr1,input.Business_Addr2),
														 '' );
	        self.corp_address2_line2            := if( trim(stringlib.StringtoUpperCase(input.Address_Type),left,right) = 'A' 
			                                            or trim(stringlib.StringtoUpperCase(input.Address_Type),left,right) = 'S' ,
														 if(trim(input.Business_Addr1,left,right)<>'',input.Business_Addr2,''),
														 '' );											 
														 
	        self.corp_address1_line3            := if( trim(stringlib.StringtoUpperCase(input.Address_Type),left,right) = 'P' 
			                                            or trim(stringlib.StringtoUpperCase(input.Address_Type),left,right) = 'T' ,trim(input.Add_Business_City,left,right),'');
			 self.corp_address2_line3            := if( trim(stringlib.StringtoUpperCase(input.Address_Type),left,right) = 'A' 
			                                            or trim(stringlib.StringtoUpperCase(input.Address_Type),left,right) = 'S' ,trim(input.Add_Business_City,left,right),'');
														
			self.corp_address1_line5            := if( trim(stringlib.StringtoUpperCase(input.Address_Type),left,right) = 'P' 
			                                            or trim(stringlib.StringtoUpperCase(input.Address_Type),left,right) = 'T',
														if((string)((integer)trim(input.Business_Zip9,left,right)) <> '0',
															if((string)((integer)trim(input.Business_Zip9,left,right)[6..9]) <> '0',
																input.Business_Zip9,
																input.Business_Zip9[1..5]
															   ),
															''
														   ),
														 ''
													  );
														 
			self.corp_address2_line5            := if( trim(stringlib.StringtoUpperCase(input.Address_Type),left,right) = 'A' 
			                                            or trim(stringlib.StringtoUpperCase(input.Address_Type),left,right) = 'S' ,
														if((string)((integer)trim(input.Business_Zip9,left,right)) <> '0',
															if((string)((integer)trim(input.Business_Zip9,left,right)[6..9]) <> '0',
																input.Business_Zip9,
																input.Business_Zip9[1..5]
															   ),
															''
														   ),
														 ''
													  );
														   
			self.corp_address1_line4            := if( trim(stringlib.StringtoUpperCase(input.Address_Type),left,right) = 'P' 
			                                            or trim(stringlib.StringtoUpperCase(input.Address_Type),left,right) = 'T',
														   trim(input.Add_Business_State,left,right),'');
			self.corp_address2_line4            := if( trim(stringlib.StringtoUpperCase(input.Address_Type),left,right) = 'A' 
			                                            or trim(stringlib.StringtoUpperCase(input.Address_Type),left,right) = 'S' ,
														   trim(input.Add_Business_State,left,right),'');
			
	    	self.corp_address1_line6            := if(trim(stringlib.StringtoUpperCase(input.Address_Type),left,right) = 'P' 
			                                            or trim(stringlib.StringtoUpperCase(input.Address_Type),left,right) = 'T',
														input.Bus_Business_Cnty_Full,'');
			self.corp_address2_line6            := if(trim(stringlib.StringtoUpperCase(input.Address_Type),left,right) = 'A' 
			                                            or trim(stringlib.StringtoUpperCase(input.Address_Type),left,right) = 'S' ,
														input.Bus_Business_Cnty_Full,'');											
			
													   
													  
			BusinessType                        :=case(trimUpper(input.Business_Type),
													 '00'=>'PROFESSIONAL TYPE',
													 '01'=>'ACCOUNTANT',
			                                         '02'=>'PODIATRY',
													 '03'=>'ARCHITECT',
													 '04'=>'ARCHITECT & ENGINEER',
													 '05'=>'ARCHITECT & ENGINEER & SURVEYOR',
													 '06'=>'ATTORNEY',
													 '07'=>'ARCHITECT & SURVEYOR',
													 '08'=>'CHIROPRACTOR',
													 '09'=>'DENTIST',
													 '10'=>'PHARMACIST',
													 '11'=>'ENGINEER',
													 '12'=>'ENGINEERS & SURVEYORS',
													 '13'=>'PSYCHOLOGIST',
													 '14'=>'SURVEYOR',
													 '15'=>'MASSAGE',
													 '16'=>'MECHANOTHERAPY',
													 '17'=>'MEDICAL',
													 '18'=>'VETERINARIAN',
													 '19'=>'OSTEOPATHY',
													 '20'=>'OPTOMETRIST',
													 '21'=>'PHYSICAL THERAPISTS',
													 '22'=>'REGISTERED NURSES',
													 '23'=>'OCCUPATIONAL THERAPISTS',
													 'BT'=>'BUSINESS TRUSTS',
			                                         'CF'=>'FOREIGN CORPORATION',
													 'CH'=>'CHURCH',
													 'CN'=>'CORPORATION FOR NON-PROFIT',
													 'CP'=>'CORPORATION FOR PROFIT',
													 'CV'=>'CONVERSION DEFAULT',
													 'FN'=>'FICTITIOUS NAMES',
													 'FP'=>'FOREIGN LIMITED PARTNERSHIP',
													 'GL'=>'LIMITED LIABILITY PARTNERS',
													 'LF'=>'FOREIGN LIMITED LIABILITY COMPANY',
													 'LL'=>'DOMESTIC LIMITED LIABILITY COMPANY',
													 'LP'=>'LIMITED PARTNERSHIP',
													 'MO'=>'MARKS OF OWNERSHIP',
													 'NR'=>'NAME RESERVATIONS',
													 'RC'=>'REGISTERED FOREIGN CORPORATION',
													 'RN'=>'REGISTERED TRADE NAME',
													 'RT'=>'REAL ESTATE TRUST',
													 'SM'=>'SERVICE MARKS',
													 'TM'=>'TRADEMARKS',													
													 '');																									  
													  
			OriginalBusinessType                :=map(trim(input.Original_Business_Type,left,right)='01'=>'ACCOUNTANT',
			                                          trim(input.Original_Business_Type,left,right)='02'=>'PODIATRY',
													  trim(input.Original_Business_Type,left,right)='03'=>'ARCHITECT',
													  trim(input.Original_Business_Type,left,right)='04'=>'ARCHITECT',
													  trim(input.Original_Business_Type,left,right)='05'=>'ARCHITECT',
													  trim(input.Original_Business_Type,left,right)='06'=>'ATTORNEY',
													  trim(input.Original_Business_Type,left,right)='07'=>'ARCHITECT',
													  trim(input.Original_Business_Type,left,right)='08'=>'CHIROPRACTOR',
													  trim(input.Original_Business_Type,left,right)='09'=>'DENTIST',
													  trim(input.Original_Business_Type,left,right)='10'=>'PHARMACIST',
													  trim(input.Original_Business_Type,left,right)='11'=>'ENGINEER',
													  trim(input.Original_Business_Type,left,right)='12'=>'ENGINEER',
													  trim(input.Original_Business_Type,left,right)='13'=>'PSYCHOLOGIST',
													  trim(input.Original_Business_Type,left,right)='14'=>'SURVEYOR',
													  trim(input.Original_Business_Type,left,right)='15'=>'MASSAGE',
													  trim(input.Original_Business_Type,left,right)='16'=>'MECHANOTHERAPY',
													  trim(input.Original_Business_Type,left,right)='17'=>'MEDICAL',
													  trim(input.Original_Business_Type,left,right)='18'=>'VETERINARIAN',
													  trim(input.Original_Business_Type,left,right)='19'=>'OSTEOPATHY',
													  trim(input.Original_Business_Type,left,right)='20'=>'OPTOMETRIST',
													  trim(input.Original_Business_Type,left,right)='21'=>'PHYSICAL',
													  trim(input.Original_Business_Type,left,right)='22'=>'REGISTERED NURSES',
													  trim(input.Original_Business_Type,left,right)='23'=>'OCCUPATIONAL THERAPISTS',
													  trim(input.Original_Business_Type,left,right)='BT'=>'BUSINESS TRUSTS',
			                                          trim(input.Original_Business_Type,left,right)='CF'=>'FOREIGN CORPORATION',
													  trim(input.Original_Business_Type,left,right)='CH'=>'CHURCH',
													  trim(input.Original_Business_Type,left,right)='CN'=>'CORPORATION FOR NON-PROFIT',
													  trim(input.Original_Business_Type,left,right)='CP'=>'CORPORATION FOR PROFIT',
													  trim(input.Original_Business_Type,left,right)='CV'=>'CONVERSION DEFAULT',
													  trim(input.Original_Business_Type,left,right)='FN'=>'FICTITIOUS NAMES',
													  trim(input.Original_Business_Type,left,right)='FP'=>'FOREIGN LIMITED PARTNERSHIP',
													  trim(input.Original_Business_Type,left,right)='GL'=>'LIMITED LIABILITY PARTNERSHIPS',
													  trim(input.Original_Business_Type,left,right)='LF'=>'FOREIGN LIMITED LIABILITY COMPANY',
													  trim(input.Original_Business_Type,left,right)='LL'=>'DOMESTIC LIMITED LIABILITY COMPANY',
													  trim(input.Original_Business_Type,left,right)='LP'=>'LIMITED PARTNERSHIP',
													  trim(input.Original_Business_Type,left,right)='MO'=>'MARKS OF OWNERSHIP',
													  trim(input.Original_Business_Type,left,right)='NR'=>'NAME RESERVATIONS',
													  trim(input.Original_Business_Type,left,right)='RC'=>'REGISTERED FOREIGN CORPORATION',
													  trim(input.Original_Business_Type,left,right)='RN'=>'REGISTERED TRADE NAME',
													  trim(input.Original_Business_Type,left,right)='RT'=>'REAL ESTATE TRUST',
													  trim(input.Original_Business_Type,left,right)='SM'=>'SERVICE MARKS',
													  trim(input.Original_Business_Type,left,right)='TM'=>'TRADEMARKS',''
													  ); 
													 
				self.corp_orig_bus_type_cd		:= if(trim(input.Business_Type,left,right)=''and trim(input.Original_Business_Type,left,right)<>'', 
															trim(input.Original_Business_Type,left,right),
													        if(trim(input.Business_Type,left,right)=trim(input.Original_Business_Type,left,right),
																trim(input.Original_Business_Type,left,right),
														        if(trim(input.Business_Type,left,right)<>trim(input.Original_Business_Type,left,right), 
																	trim(input.Business_Type,left,right),
																	if(trim(input.Business_Type,left,right)<>''and trim(input.Original_Business_Type,left,right)='', 
																		trim(input.Business_Type,left,right),
																		''
																	   )
																   ) 
															   )
													     );
													  
				self.corp_orig_bus_type_desc    := if(trim(input.Business_Type,left,right)=''and trim(input.Original_Business_Type,left,right)<>'', 
															trim(OriginalBusinessType,left,right),
													        if(trim(input.Business_Type,left,right)=trim(input.Original_Business_Type,left,right),
															trim(OriginalBusinessType,left,right),
														        if(trim(input.Business_Type,left,right)<>trim(input.Original_Business_Type,left,right), 
																	trim(BusinessType,left,right)+' (originally '+trim(OriginalBusinessType,left,right)+')' ,
																	if(trim(input.Business_Type,left,right)<>''and trim(input.Original_Business_Type,left,right)='', 
																			trim(BusinessType,left,right),
																			''
																	   )
																   ) 
															   )
													     );
			
			StatusDesc							:=map(trim(stringlib.StringtoUpperCase(input.Business_Status),left,right)='A'=>'IN GOOD STANDING',
			                                          trim(stringlib.StringtoUpperCase(input.Business_Status),left,right)='D'=>'NOT IN GOOD STANDING',
													  trim(stringlib.StringtoUpperCase(input.Business_Status),left,right)='H'=>'CANCELLED BUT NAME RESERVED',
													  trim(stringlib.StringtoUpperCase(input.Business_Status),left,right)='C'=>'CANCELLED NAME NOT RESERVED',''
													  ); 
			self.corp_status_desc               := if(trim(input.Business_Status,left,right)<>'', StatusDesc,'');									  
			self. corp_status_date              :=if(_validate.date.fIsValid(StringLib.StringFilterOut(input.last_update_date_time,'-')[1..8]) and 
			                                         _validate.date.fIsValid(StringLib.StringFilterOut(input.last_update_date_time,'-')[1..8],_validate.date.rules.DateInPast)
			                                              and (StringLib.StringFilterOut(input.last_update_date_time,'-')[1..8])<>'00000101',
														StringLib.StringFilterOut(input.last_update_date_time,'-')[1..8],
														''
													  );
													  
			self.corp_term_exist_cd             :=if(trim(input.Business_Expiry_Date,left,right)<>''and _validate.date.fIsValid(StringLib.StringFilterOut(input.Business_Expiry_Date,'-')[1..8]) ,'D','');
			self.corp_term_exist_exp            :=if(trim(input.Business_Expiry_Date,left,right)<>''and _validate.date.fIsValid(StringLib.StringFilterOut(input.Business_Expiry_Date,'-')[1..8]) and 
			                                         (StringLib.StringFilterOut(input.Business_Expiry_Date,'-')[1..8])<>'00000101',
														StringLib.StringFilterOut(input.Business_Expiry_Date,'-')[1..8],
														''
													  );
			self.corp_term_exist_desc           :=if(trim(input.Business_Expiry_Date,left,right)<>''and _validate.date.fIsValid(StringLib.StringFilterOut(input.Business_Expiry_Date,'-')[1..8]) ,'EXPIRATION DATE','');										  
			self.corp_inc_state					:=if(trimUpper(input.Bus_Business_State) = 'OH',
													 'OH',
													 '');
			self.corp_forgn_state_cd			:= if(trimUpper(input.Bus_Business_State) <> 'OH',
													  trimUpper(input.Bus_Business_State),
													  '');
			self.corp_inc_county                := input.Bus_Business_Cnty_Full;
			
			self.corp_inc_date                  := if(	trim(input.Bus_Effective_Date_Time,left,right)<>'' and 
														_validate.date.fIsValid(StringLib.StringFilterOut(input.Bus_Effective_Date_Time,'-')[1..8]) and
														_validate.date.fIsValid(StringLib.StringFilterOut(input.Bus_Effective_Date_Time,'-')[1..8],_validate.date.rules.DateInPast) and 
														(StringLib.StringFilterOut(input.Bus_Effective_Date_Time,'-')[1..8])<>'00000101',
														StringLib.StringFilterOut(input.Bus_Effective_Date_Time,'-')[1..8], 
														''
													  );	
													  
			self.corp_legal_name                :=regexreplace('[.]*$',input.Business_Name,'',NOCASE);
			self.corp_ln_name_type_cd			:=trimUpper(input.Business_Type);
			self.corp_ln_name_type_desc 		:=case(trimUpper(input.Business_Type),
														'FN'=>'DBA',
														'NR'=>'RESERVED',
														'SM'=>'SERVICE MARKS',
														'TM'=>'TRADEMARKS',
														'LEGAL');
			status                              :=map(trim(input.Contact_Status,left,right)='A'=>'ACTIVE',
			                                          trim(input.Contact_Status,left,right)='I'=>'INACTIVE', '');
			                                          
			self.corp_ra_name                   := if(trim(input.Contact_name,left,right)<>'',trim(input.Contact_name,left,right),'') ;
            self.corp_ra_effective_date         := if(_validate.date.fIsValid(StringLib.StringFilterOut(input.Cont_Effective_Date_Time,'-')[1..8]) and 
			                                         _validate.date.fIsValid(StringLib.StringFilterOut(input.Cont_Effective_Date_Time,'-')[1..8],_validate.date.rules.DateInPast)
			                                              and (StringLib.StringFilterOut(input.Cont_Effective_Date_Time,'-')[1..8])<>'00000101',
														StringLib.StringFilterOut(input.Cont_Effective_Date_Time,'-')[1..8],
														''
													  );
			 					  
           self.corp_ra_addl_info              := if(trim(input.Contact_Status,left,right)<>'' and trim(input.CONTACT_DOC_ID,left,right)<>'' ,
			        			                       'STATUS: '+status+'; '+
													   'AGENT ID: '+trim(input.CONTACT_DOC_ID,left,right),
													   
													  if(trim(input.Contact_Status,left,right)='' and trim(input.CONTACT_DOC_ID,left,right)<>'' , 'AGENT ID: '+trim(input.CONTACT_DOC_ID,left,right) ,
											                 if(trim(input.Contact_Status,left,right)<>'' and trim(input.CONTACT_DOC_ID,left,right)='' ,'STATUS: '+status ,'') ) );
			
			self.corp_ra_address_line1			:= if(trim(input.Contact_Addr1,left,right)<>'',input.Contact_Addr1,input.Contact_Addr2);
														  
			self.corp_ra_address_line2			:= if(trim(input.Contact_Addr1,left,right)<>'',input.Contact_Addr2,'');
														 
			self.corp_ra_address_line3			:= trim(input.Contact_City,left,right);   
			self.corp_ra_address_line4			:= trim(input.Contact_State,left,right);
   			self.corp_ra_address_line5			:= if((string)((integer)trim(input.Contact_Zip9,left,right)) <>'0',
														if((string)((integer)trim(input.Contact_Zip9,left,right)[6..9]) <> '0',
															input.Contact_Zip9,
															input.Contact_Zip9[1..5]
														  ),
														''
													  );
																                                        
			self.corp_ra_address_line6	        := input.Contact_Cnty_Full;  
			LicenseType                         := map(trim(stringlib.StringtoUpperCase(input.License_Type),left,right) = 'T'=>'LICENSE TYPE: TEMPORARY LICENSE',
			                                          trim(stringlib.StringtoUpperCase(input.License_Type),left,right) = 'P'=>'LICENSE TYPE: PERMANTENT LICENSE',
													  ''); 
			Consent								:= map(trim(stringlib.StringtoUpperCase(input.Consent_Flag),left,right) = 'Y'=>'RECEIVED CONSENT TO USE PROTECTED NAME',
			                                          trim(stringlib.StringtoUpperCase(input.Consent_Flag),left,right) = 'N'=>'DID NOT RECEIVED CONSENT TO USE PROTECTED NAME',
													  ''); 	
            BusinessLoc                         := if(trim(input.Business_Location_Name,left,right)<>'','PRINCIPAL LOCATION IS '+trim(input.Business_Location_Name,left,right),
			                                         '');
            Purpose								:= map(trim(input.Business_Class,left,right)='00'=>'CONVERSION DEFAULT',
                                                      trim(input.Business_Class,left,right)='01'=>'CHEMICALS',
													  trim(input.Business_Class,left,right)='02'=>'PAINTS',
                                                      trim(input.Business_Class,left,right)='03'=>'COSMETICS AND CLEANING PREPARATIONS',
                                                      trim(input.Business_Class,left,right)='04'=>'LUBRICANTS AND FUELS',
                                                      trim(input.Business_Class,left,right)='05'=>'PHARMACEUTICAL',
                                                      trim(input.Business_Class,left,right)='06'=>'METAL GOODS',
                                                      trim(input.Business_Class,left,right)='07'=>'MACHINERY',
                                                      trim(input.Business_Class,left,right)='08'=>'HAND TOOLS',
                                                      trim(input.Business_Class,left,right)='09'=>'ELECTRICAL AND SCIENTIFIC APPARATUS',
                                                      trim(input.Business_Class,left,right)='10'=>'MEDICAL APPARATUS',
                                                      trim(input.Business_Class,left,right)='11'=>'ENVIRONMENTAL CONTROL APPARATUS',
                                                      trim(input.Business_Class,left,right)='12'=>'VEHICLES',
                                                      trim(input.Business_Class,left,right)='13'=>'FIREARMS',
                                                      trim(input.Business_Class,left,right)='14'=>'JEWELRY',
                                                      trim(input.Business_Class,left,right)='15'=>'MUSICAL INSTRUMENTS',
                                                      trim(input.Business_Class,left,right)='16'=>'PAPER GOODS AND PRINTED MATTER',
                                                      trim(input.Business_Class,left,right)='17'=>'RUBBER GOODS',
                                                      trim(input.Business_Class,left,right)='18'=>'LEATHER GOODS',
                                                      trim(input.Business_Class,left,right)='19'=>'NON-METALLIC BUILDING MATERIALS',
                                                      trim(input.Business_Class,left,right)='20'=>'FURNITURE AND ARTICLES NOT OTHERWISE CLASSIFIED',
                                                      trim(input.Business_Class,left,right)='21'=>'HOUSEWARES AND GLASS',
                                                      trim(input.Business_Class,left,right)='22'=>'CORDAGE AND FIBERS',
                                                      trim(input.Business_Class,left,right)='23'=>'YARNS AND THREADS',
                                                      trim(input.Business_Class,left,right)='24'=>'FABRICS',
                                                      trim(input.Business_Class,left,right)='25'=>'CLOTHING',
                                                      trim(input.Business_Class,left,right)='26'=>'FANCY GOODS',
                                                      trim(input.Business_Class,left,right)='27'=>'FLOOR COVERINGS',
                                                      trim(input.Business_Class,left,right)='28'=>'TOYS AND SPORTING GOODS',
                                                      trim(input.Business_Class,left,right)='29'=>'MEATS AND PROCESSED FOODS',
                                                      trim(input.Business_Class,left,right)='30'=>'STAPLE FOODS',
                                                      trim(input.Business_Class,left,right)='31'=>'NATURAL AGRICULTURAL PRODUCTS',
                                                      trim(input.Business_Class,left,right)='32'=>'LIGHT BEVERAGES',
                                                      trim(input.Business_Class,left,right)='33'=>'WINES AND SPIRITS',
                                                      trim(input.Business_Class,left,right)='34'=>'SMOKERS ARTICLES',
                                                      trim(input.Business_Class,left,right)='35'=>'ADVERTISING AND BUSINESS',
                                                      trim(input.Business_Class,left,right)='36'=>'INSURANCE AND FINANCIAL',
                                                      trim(input.Business_Class,left,right)='37'=>'CONSTRUCTION AND REPAIR',
                                                      trim(input.Business_Class,left,right)='38'=>'COMMUNICATION',
                                                      trim(input.Business_Class,left,right)='39'=>'TRANSPORTATION AND STORAGE',
                                                      trim(input.Business_Class,left,right)='40'=>'MATERIAL TREATMENT',
                                                      trim(input.Business_Class,left,right)='41'=>'EDUCATION AND ENTERTAINMENT',
                                                      trim(input.Business_Class,left,right)='42'=>'SCIENTIFIC AND TECHNOLOGICAL',
                                                      trim(input.Business_Class,left,right)='43'=>'PROVIDING FOOD AND DRINK',
                                                      trim(input.Business_Class,left,right)='44'=>'MEDICAL,VETERINARY,HYGIENIC,AGRICULTURE,FORESTRY',
                                                      trim(input.Business_Class,left,right)='45'=>'PERSONAL, SOCIAL AND SECURITY',''
													  );
		    TradeMark                             :=if(trim(input.Business_Class,left,right)<>'' ,'PURPOSE OF TRADEMARK OR SERVICE MARK: '+ Purpose,'');
			
			concatFields						  := trim(	trim(LicenseType,left,right) + ';' + 
															trim(Consent,left,right) + ';' + 
															trim(BusinessLoc,left,right) + ';' + 
															trim(TradeMark,left,right),left,right
														  );
			
			tempExp								  := regexreplace('[;]*$',concatFields,'',NOCASE);
			tempExp2							  := regexreplace('^[;]*',tempExp,'',NOCASE);
			
			self.corp_addl_info                   := regexreplace('[;]+',tempExp2,';',NOCASE);
	        self                                  := [];
				
	end; 
	

        corp2_mapping.Layout_CorpPreClean OH_corp2Transform_OldName(Layouts_Raw_Input.Old_Name input):=transform
		    self.dt_first_seen					:= fileDate;
			self.dt_last_seen					:= fileDate;
			self.dt_vendor_first_reported		:= fileDate;
			self.dt_vendor_last_reported		:= fileDate;
			self.corp_ra_dt_first_seen			:= fileDate;
			self.corp_ra_dt_last_seen			:= fileDate;
			self.corp_key					    := '39-' +trim(input.charter_num, left, right);
			self.corp_vendor					:= '39';
			self.corp_state_origin				:= 'OH';
			self.corp_process_date				:= fileDate;    
			self.corp_orig_sos_charter_nbr      := trim(input.charter_num, left, right);
	     
            self.corp_legal_name                := if(trim(input.Old_Name,left,right)<>'',trim(input.Old_Name,left,right),'');
			
            self.corp_inc_date                  := if(	trim(input.Old_Effective_Date_Time,left,right)<>'' and 
														_validate.date.fIsValid(StringLib.StringFilterOut(input.Old_Effective_Date_Time,'-')[1..8]) and
														_validate.date.fIsValid(StringLib.StringFilterOut(input.Old_Effective_Date_Time,'-')[1..8],_validate.date.rules.DateInPast) and 
														(StringLib.StringFilterOut(input.Old_Effective_Date_Time,'-')[1..8])<>'00000101',
														StringLib.StringFilterOut(input.Old_Effective_Date_Time,'-')[1..8], 
														''
													  );			  
		 					  
			self								:= [];
			
        end; 	
	
		Corp2.Layout_Corporate_Direct_AR_In OH_arTransform(Layouts_Raw_Input.Document_Transaction input) := transform,SKIP(input.tran_code not in validtrancode)
			
			self.corp_key					:= '39-' +trim(input.charter_num, left, right);
			self.corp_vendor				:= '39';
			self.corp_state_origin			:= 'OH';
			self.corp_process_date			:= fileDate;
			self.corp_sos_charter_nbr		:= trim(input.charter_num, left, right);
			self.ar_report_dt				:= input.tran_effective_date_time[1..8];
			self.ar_comment					:= input.Processing_Id; 
			self.ar_type					:= MAP(	trimupper(input.Tran_Code) = '70L' or
													trimupper(input.Tran_Code) = '71L' or
													trimupper(input.Tran_Code) = '72L' or
													trimupper(input.Tran_Code) = '73L' or
													trimupper(input.Tran_Code) = '74L' or
													trimupper(input.Tran_Code) = '75L' or
													trimupper(input.Tran_Code) = '76L' or
													trimupper(input.Tran_Code) = '77L' or
													trimupper(input.Tran_Code) = '78L' or
													trimupper(input.Tran_Code) = '79L' or
													trimupper(input.Tran_Code) = '80L' or
													trimupper(input.Tran_Code) = '81L' or
													trimupper(input.Tran_Code) = '82L' or 
													trimupper(input.Tran_Code) = '83L' or 
													trimupper(input.Tran_Code) = '84L' or
													trimupper(input.Tran_Code) = '85L' or
													trimupper(input.Tran_Code) = '86L' or
													trimupper(input.Tran_Code) = '87L' or
													trimupper(input.Tran_Code) = '88L' or
													trimupper(input.Tran_Code) = '89L' or
													trimupper(input.Tran_Code) = '90L' or
													trimupper(input.Tran_Code) = '91L' or
													trimupper(input.Tran_Code) = '92L' or
													trimupper(input.Tran_Code) = '93L' or
													trimupper(input.Tran_Code) = '94L' or
													trimupper(input.Tran_Code) = '95L' or
													trimupper(input.Tran_Code) = '96L' or
													trimupper(input.Tran_Code) = '97L' or
													trimupper(input.Tran_Code) = '98L' or
													trimupper(input.Tran_Code) = '99L' or
													trimupper(input.Tran_Code) = '00L' or
													trimupper(input.Tran_Code) = '01L' or
													trimupper(input.Tran_Code) = '02L' or
													trimupper(input.Tran_Code) = '03L' or
													trimupper(input.Tran_Code) = '04L' or
													trimupper(input.Tran_Code) = '05L' or
													trimupper(input.Tran_Code) = '06L' or
													trimupper(input.Tran_Code) = '07L' or
													trimupper(input.Tran_Code) = '08L' or
													trimupper(input.Tran_Code) = '09L' or
													trimupper(input.Tran_Code) = '10L' => 'ANNUAL REPORT/LIMITED LIABILITY PARTNERSHIP',
													trimupper(input.Tran_Code) = '00A' or
													trimupper(input.Tran_Code) = '01A' or
													trimupper(input.Tran_Code) = '02A' or
													trimupper(input.Tran_Code) = '03A' or
													trimupper(input.Tran_Code) = '04A' or
													trimupper(input.Tran_Code) = '05A' or
													trimupper(input.Tran_Code) = '06A' or
													trimupper(input.Tran_Code) = '07A' or
													trimupper(input.Tran_Code) = '08A' or
													trimupper(input.Tran_Code) = '09A' or
													trimupper(input.Tran_Code) = '10A' or
													trimupper(input.Tran_Code) = '60A' or 
													trimupper(input.Tran_Code) = '61A' or
													trimupper(input.Tran_Code) = '62A' or
													trimupper(input.Tran_Code) = '63A' or 
													trimupper(input.Tran_Code) = '64A' or 
													trimupper(input.Tran_Code) = '65A' or 
													trimupper(input.Tran_Code) = '66A' or 
													trimupper(input.Tran_Code) = '67A' or 
													trimupper(input.Tran_Code) = '68A' or 
													trimupper(input.Tran_Code) = '69A' or
													trimupper(input.Tran_Code) = '93A' or
													trimupper(input.Tran_Code) = '94A' or
													trimupper(input.Tran_Code) = '95A' or
													trimupper(input.Tran_Code) = '96A' or
													trimupper(input.Tran_Code) = '97A' or
													trimupper(input.Tran_Code) = '98A' or
													trimupper(input.Tran_Code) = '99A' => 'ANNUAL REPORT OF PROFESSIONAL CORP',
													'');
			self							:=[];
		end; 		
			
		Corp2.Layout_Corporate_Direct_Stock_In OH_stockTransform(Layouts_Raw_Input.BusinessAuthorized_Share input) := transform
			
			self.corp_key					:= '39-' +trim(input.charter_num, left, right);
			self.corp_vendor				:= '39';
			self.corp_state_origin			:= 'OH';
			self.corp_process_date			:= fileDate;
			self.corp_sos_charter_nbr		:= trim(input.charter_num, left, right);
			self.stock_shares_issued		:= input.SHARE_TOT;
			self.stock_authorized_nbr		:= input.Share_Proportion_Amt;
			self.stock_par_value			:= input.PAR_VALUE_AMT;
			self.stock_change_in_cap		:= input.share_credits;
			self							:=[];
			
		end; 		
	
		Corp2.Layout_Corporate_Direct_Event_In OH_eventTransform(string fileDate, Layouts_Raw_Input.ExplanationTextDocTrans input) := transform
			
			self.corp_key					:= '39-' +trim(input.charter_num, left, right);
			self.corp_vendor				:= '39';
			self.corp_process_date			:= fileDate;
			self.corp_sos_charter_nbr		:= trim(input.charter_num, left, right);
			
		    indexOfUnderScore 				:= lib_stringlib.StringLib.StringFind(input.Processing_Id,'_',1);

            processid                       :=if(ut.isNumeric(input.Processing_Id) and StringLib.StringFindReplace(StringLib.StringFilterOut(input.Processing_Id,'0'),'0','')='','',
													if(StringLib.StringFindReplace(StringLib.StringFilterOut(input.Processing_Id,'0'),'0','')<>'' ,input.Processing_Id,''));
													
		    self.event_filing_reference_nbr	:= if ( indexOfUnderScore <> 0 and (string)(integer)input.Processing_Id <> '0',
   													input.Processing_Id, 
   													if(LENGTH(input.Processing_Id)=9 and trim(input.Processing_Id[5], left, right)=''and (string)(integer)input.Processing_Id <> '0',
													trim(input.Processing_Id[1..4], left, right)+'_'+trim(input.Processing_Id[6..], left, right),
													if(LENGTH(input.Processing_Id)<>9 and(string)(integer)input.Processing_Id <> '0',input.Processing_Id,
													 processid)));
														
													
													
														
											  
			self.event_filing_date			:= input.effective_date_time[1..8]; 
			self.event_filing_cd			:= input.Tran_code; 
			
			
			TranTypeDesc					:= MAP(	trimupper(input.Tran_Code) = '83L' or 
													trimupper(input.Tran_Code) = '84L' or
													trimupper(input.Tran_Code) = '85L' or
													trimupper(input.Tran_Code) = '86L' or
													trimupper(input.Tran_Code) = '87L' or
													trimupper(input.Tran_Code) = '88L' or
													trimupper(input.Tran_Code) = '89L' or
													trimupper(input.Tran_Code) = '90L' or
													trimupper(input.Tran_Code) = '91L' or
													trimupper(input.Tran_Code) = '92L' or
													trimupper(input.Tran_Code) = '93L' or
													trimupper(input.Tran_Code) = '94L' or
													trimupper(input.Tran_Code) = '95L' or
													trimupper(input.Tran_Code) = '96L' or
													trimupper(input.Tran_Code) = '97L' or
													trimupper(input.Tran_Code) = '98L' or
													trimupper(input.Tran_Code) = '99L' or
													trimupper(input.Tran_Code) = '00L' or
													trimupper(input.Tran_Code) = '01L' or
													trimupper(input.Tran_Code) = '02L' or
													trimupper(input.Tran_Code) = '03L' or
													trimupper(input.Tran_Code) = '04L' or
													trimupper(input.Tran_Code) = '05L' or
													trimupper(input.Tran_Code) = '06L' or
													trimupper(input.Tran_Code) = '07L' or
													trimupper(input.Tran_Code) = '08L' or
													trimupper(input.Tran_Code) = '09L' or
													trimupper(input.Tran_Code) = '10L' => 'ANNUAL REPORT/LIMITED LIABILITY PARTNERSHIP',
													trimupper(input.Tran_Code) = '70N' or
													trimupper(input.Tran_Code) = '71N' or
													trimupper(input.Tran_Code) = '72N' or
													trimupper(input.Tran_Code) = '73N' or
													trimupper(input.Tran_Code) = '74N' or
													trimupper(input.Tran_Code) = '75N' or
													trimupper(input.Tran_Code) = '76N' or
													trimupper(input.Tran_Code) = '77N' or
													trimupper(input.Tran_Code) = '78N' or
													trimupper(input.Tran_Code) = '79N' or
													trimupper(input.Tran_Code) = '80N' or
													trimupper(input.Tran_Code) = '81N' or
													trimupper(input.Tran_Code) = '82N' or
													trimupper(input.Tran_Code) = '83N' or
													trimupper(input.Tran_Code) = '84N' or
													trimupper(input.Tran_Code) = '85N' or
													trimupper(input.Tran_Code) = '86N' or
													trimupper(input.Tran_Code) = '87N' or
													trimupper(input.Tran_Code) = '88N' or
													trimupper(input.Tran_Code) = '89N' or
													trimupper(input.Tran_Code) = '90N' or
													trimupper(input.Tran_Code) = '91N' or
													trimupper(input.Tran_Code) = '92N' or
													trimupper(input.Tran_Code) = '93N' or
													trimupper(input.Tran_Code) = '94N' or
													trimupper(input.Tran_Code) = '95N' or
													trimupper(input.Tran_Code) = '96N' or
													trimupper(input.Tran_Code) = '97N' or
													trimupper(input.Tran_Code) = '98N' or
													trimupper(input.Tran_Code) = '99N' => 'FORM 7 NO FEE ASSESSED',
													trimupper(input.Tran_Code) = '80L' or
													trimupper(input.Tran_Code) = '81L' or
													trimupper(input.Tran_Code) = '82L' => 'ANNUAL REPORT/LIMITED LIABILITY PARTNERSHIP',
													trimupper(input.Tran_Code) = '95A' or
													trimupper(input.Tran_Code) = '96A' or
													trimupper(input.Tran_Code) = '97A' or
													trimupper(input.Tran_Code) = '98A' or
													trimupper(input.Tran_Code) = '99A' or
													trimupper(input.Tran_Code) = '00A' or
													trimupper(input.Tran_Code) = '01A' or
													trimupper(input.Tran_Code) = '02A' or
													trimupper(input.Tran_Code) = '03A' or
													trimupper(input.Tran_Code) = '04A' or
													trimupper(input.Tran_Code) = '05A' or
													trimupper(input.Tran_Code) = '06A' or
													trimupper(input.Tran_Code) = '07A' or
													trimupper(input.Tran_Code) = '08A' or
													trimupper(input.Tran_Code) = '09A' or
													trimupper(input.Tran_Code) = '10A' => 'ANNUAL REPORT OF PROFESSIONAL CORP',
													trimupper(input.Tran_Code) = '63F' or
													trimupper(input.Tran_Code) = '70F' or
													trimupper(input.Tran_Code) = '71F' or
													trimupper(input.Tran_Code) = '72F' or
													trimupper(input.Tran_Code) = '73F' or
													trimupper(input.Tran_Code) = '74F' or
													trimupper(input.Tran_Code) = '75F' or
													trimupper(input.Tran_Code) = '76F' or
													trimupper(input.Tran_Code) = '77F' or
													trimupper(input.Tran_Code) = '78F' or
													trimupper(input.Tran_Code) = '79F' or
													trimupper(input.Tran_Code) = '80F' or
													trimupper(input.Tran_Code) = '81F' or
													trimupper(input.Tran_Code) = '82F' or
													trimupper(input.Tran_Code) = '83F' or
													trimupper(input.Tran_Code) = '84F' or
													trimupper(input.Tran_Code) = '85F' or
													trimupper(input.Tran_Code) = '86F' or
													trimupper(input.Tran_Code) = '87F' or
													trimupper(input.Tran_Code) = '88F' or
													trimupper(input.Tran_Code) = '89F' or
													trimupper(input.Tran_Code) = '90F' or
													trimupper(input.Tran_Code) = '91F' or
													trimupper(input.Tran_Code) = '92F' or
													trimupper(input.Tran_Code) = '93F' or
													trimupper(input.Tran_Code) = '94F' or
													trimupper(input.Tran_Code) = '95F' or
													trimupper(input.Tran_Code) = '96F' or
													trimupper(input.Tran_Code) = '97F' or
													trimupper(input.Tran_Code) = '98F' or
													trimupper(input.Tran_Code) = '99F' or
													trimupper(input.Tran_Code) = '00F' or
													trimupper(input.Tran_Code) = '01F' or
													trimupper(input.Tran_Code) = '02F' or
													trimupper(input.Tran_Code) = '03F' or
													trimupper(input.Tran_Code) = '04F' or
													trimupper(input.Tran_Code) = '05F' or
													trimupper(input.Tran_Code) = '06F' or
													trimupper(input.Tran_Code) = '07F' or
													trimupper(input.Tran_Code) = '08F' or
													trimupper(input.Tran_Code) = '09F' or
													trimupper(input.Tran_Code) = '10F' => 'FORM 7 NO FEE ASSESSED',
													trimupper(input.Tran_Code) = '70L' or
													trimupper(input.Tran_Code) = '71L' or
													trimupper(input.Tran_Code) = '72L' or
													trimupper(input.Tran_Code) = '73L' or
													trimupper(input.Tran_Code) = '74L' or
													trimupper(input.Tran_Code) = '75L' or
													trimupper(input.Tran_Code) = '76L' or
													trimupper(input.Tran_Code) = '77L' or
													trimupper(input.Tran_Code) = '78L' or
													trimupper(input.Tran_Code) = '79L' => 'ANNUAL REPORT/LIMITED LIABILITY PARTNERSHIP',
													trimupper(input.Tran_Code) = '93A' or
													trimupper(input.Tran_Code) = '94A' => 'ANNUAL REPORT OF PROFESSIONAL CORP',
													trimupper(input.Tran_Code) = 'RCR' => 'UNLICENSED FOR NAME RESERVATION RENEWAL',
													trimupper(input.Tran_Code) = 'RCA' => 'UNLICENSED FOREIGN NAME RESERVATION/ASSIGNMENT',
													trimupper(input.Tran_Code) = 'RCX' => 'UNLICENSED FOREIGN NAME RESERVATION/CANCELLATION',
													trimupper(input.Tran_Code) = 'RNA' => 'TRADE NAME/ASSIGNMENT',
													trimupper(input.Tran_Code) = 'RNB' => 'TRADE NAME/BUSINESS ADDRESS CHANGE',
													trimupper(input.Tran_Code) = 'RNR' => 'TRADE NAME RENEWAL',
													trimupper(input.Tran_Code) = 'RNX' => 'TRADE NAME/CANCELLATION',
													trimupper(input.Tran_Code) = 'REN' => 'DOMESTIC/REINSTATEMENT',
													trimupper(input.Tran_Code) = 'RTA' => 'REAL ESTATE TRUST AMENDMENT TO TRUST AGREEMENT',
													trimupper(input.Tran_Code) = 'RTC' => 'REAL ESTATE TRUST/AGENT ADDRESS CHANGE',
													trimupper(input.Tran_Code) = 'RTD' => 'REAL ESTATE TRUST/DISSOLUTION',
													trimupper(input.Tran_Code) = 'RTF' => 'REAL ESTATE TRUST/MERGED INTO FOREIGN CORP',
													trimupper(input.Tran_Code) = 'RTP' => 'REAL ESTATE TRUST/AMENDED REPORT',
													trimupper(input.Tran_Code) = 'RTR' => 'REAL ESTATE TRUST/AGENT RESIGNATION',
													trimupper(input.Tran_Code) = 'RTS' => 'REAL ESTATE TRUST/AGENT SUBSEQUENT APPOINTMENT',
													trimupper(input.Tran_Code) = 'RTX' => 'REAL ESTATE TRUST/CANCELLATION',
													trimupper(input.Tran_Code) = 'RXM' => 'CANCELLED IN ERROR BY SECRETARY OF STATE',
													trimupper(input.Tran_Code) = 'SMA' => 'SERVICE MARK/ASSIGNMENT',
													trimupper(input.Tran_Code) = 'SMB' => 'SERVICE MARK/BUSINESS ADDRESS CHANGE',
													trimupper(input.Tran_Code) = 'SMR' => 'SERVICE MARK RENEWAL',
													trimupper(input.Tran_Code) = 'SMX' => 'SERVICE MARK/CANCELLATION',
													trimupper(input.Tran_Code) = 'SUB' => 'CERTIFICATE OF SUBSCRIPTION BANK',
													trimupper(input.Tran_Code) = 'SUC' => 'FOREIGN/SURRENDER BY COURT ORDER',
													trimupper(input.Tran_Code) = 'SUD' => 'FOREIGN/SURRENDER BY DISSOLUTION',
													trimupper(input.Tran_Code) = 'SUM' => 'FOREIGN/SURRENDER BY MERGER S C',
													trimupper(input.Tran_Code) = 'SUR' => 'FOREIGN/SURRENDER',
													trimupper(input.Tran_Code) = 'TMA' => 'TRADE MARK/ASSIGNMENT',
													trimupper(input.Tran_Code) = 'TMB' => 'TRADE MARK/BUSINESS ADDRESS CHANGE',
													trimupper(input.Tran_Code) = 'TMR' => 'TRADE MARK RENEWAL',
													trimupper(input.Tran_Code) = 'TMX' => 'TRADE MARK/CANCELLATION',
													trimupper(input.Tran_Code) = 'XCE' => 'CANCELED/FAILURE TO FILE/STATEMENT CONT. EXISTENCE',
													trimupper(input.Tran_Code) = 'XTD' => 'CANCELLED BY TAX DEPT W/NOTIFICATION',
													trimupper(input.Tran_Code) = 'XFF' => 'CANCEL FOREIGN CORP/FAILURE TO FILE/PAY FORM 7',
													trimupper(input.Tran_Code) = 'XGA' => 'CANCELLED W/NOTICE FAIL TO FILE GL ANNUAL',
													trimupper(input.Tran_Code) = 'XOL' => 'CANCELLED BY OPERATION OF LAW',
													trimupper(input.Tran_Code) = 'XPA' => 'CANCELED W/NOTICE FAIL TO FILE PROFESSIONAL ANNUAL',
													trimupper(input.Tran_Code) = 'XSS' => 'CANCELLED BY SECRETARY OF STATE',
													trimupper(input.Tran_Code) = '70A' or
													trimupper(input.Tran_Code) = '71A' or
													trimupper(input.Tran_Code) = '72A' or
													trimupper(input.Tran_Code) = '73A' or
													trimupper(input.Tran_Code) = '74A' or
													trimupper(input.Tran_Code) = '75A' or
													trimupper(input.Tran_Code) = '76A' or
													trimupper(input.Tran_Code) = '77A' or
													trimupper(input.Tran_Code) = '78A' or
													trimupper(input.Tran_Code) = '79A' or
													trimupper(input.Tran_Code) = '80A' or
													trimupper(input.Tran_Code) = '81A' or
													trimupper(input.Tran_Code) = '82A' or
													trimupper(input.Tran_Code) = '83A' or
													trimupper(input.Tran_Code) = '84A' or
													trimupper(input.Tran_Code) = '85A' or
													trimupper(input.Tran_Code) = '86A' or
													trimupper(input.Tran_Code) = '87A' or
													trimupper(input.Tran_Code) = '88A' or
													trimupper(input.Tran_Code) = '89A' or
													trimupper(input.Tran_Code) = '90A' or
													trimupper(input.Tran_Code) = '91A' or
													trimupper(input.Tran_Code) = '92A' => 'ANNUAL REPORT OF PROFESSIONAL CORP',
													trimupper(input.Tran_Code) = 'PLT' => 'PROFESSIONAL/DELINQUENCY LETTER SERVED',
													trimupper(input.Tran_Code) = 'PLW' => 'WITHDRAWAL/LIMITED LIABILITY PARTNERSHIP',
													trimupper(input.Tran_Code) = 'FPC' => 'CANCELLATION/FOREIGN LIMITED PARTNERSHIP',
													trimupper(input.Tran_Code) = 'FPO' => 'FOREIGN/CHANGE OF PRINCIPAL OFFICE IN OHIO',
													trimupper(input.Tran_Code) = 'FRE' => 'FOREIGN/REINSTATEMENT',
													trimupper(input.Tran_Code) = 'FXA' => 'FOREIGN/CANCELLED/FAILURE TO MAINTAIN AGENT',
													trimupper(input.Tran_Code) = 'GLT' => 'GL ANNUAL DELINQUENCY LETTER SERVED',
													trimupper(input.Tran_Code) = 'LAD' => 'AGENT ADDRESS CHANGE/LIMITED/LIABILITY/PARTNERS',
													trimupper(input.Tran_Code) = 'LAG' => 'AGENT RESIGNATION/LIMITED/LIABILITY/PARTNERS',
													trimupper(input.Tran_Code) = 'LAM' => 'AMEND/ARTICLES-ORGANIZATION/DOM LIMITED LIAB. CO',
													trimupper(input.Tran_Code) = 'LDS' => 'DISSOLUTION/LIMITED LIABILITY COMPANY',
													trimupper(input.Tran_Code) = 'LFC' => 'CORRECT REGISTRATION/FOREIGN LIMITED LIABILITY CO',
													trimupper(input.Tran_Code) = 'LFS' => 'CANCELLATION/FOREIGN LIMITED LIABILITY COMPANY',
													trimupper(input.Tran_Code) = 'LPA' => 'AMENDMENT/LIMITED PARTNERSHIP',
													trimupper(input.Tran_Code) = 'LPC' => 'CANCELLATION/LIMITED PARTNERSHIP',
													trimupper(input.Tran_Code) = 'LPD' => 'DISCLAIMER OF GENERAL PARTNERSHIP STATUS',
													trimupper(input.Tran_Code) = 'LPN' => 'CANCELLATION AMENDMENT/LIMITED PARTNERSHIP',
													trimupper(input.Tran_Code) = 'LPR' => 'RESTATED/LIMITED PARTNERSHIP',
													trimupper(input.Tran_Code) = 'LRA' => 'RESTATEMENT/ARTICLES OF GENERAL PARTNERSHIP STATUS',
													trimupper(input.Tran_Code) = 'LPS' => 'CANCEL DISCLAIMER OF GENERAL PARTNERSHIP STATUS',
													trimupper(input.Tran_Code) = 'LSA' => 'SUBSEQUENT AGENT APPOINT/LIMITED/LIABILTY/PARTNERS',
													trimupper(input.Tran_Code) = 'LTR' => 'LETTER/RENEWAL NOTICE MAILED',
													trimupper(input.Tran_Code) = 'MCX' => 'REAL ESTATE TRUST/CANCELLED BY COURT ORDER',
													trimupper(input.Tran_Code) = 'MER' => 'MERGER/DOMESTIC',
													trimupper(input.Tran_Code) = 'MEX' => 'MERGED OUT OF EXISTENCE',
													trimupper(input.Tran_Code) = 'MFC' => 'MERGER OF DOMESTIC INTO FOREIGN CORP S C',
													trimupper(input.Tran_Code) = 'MIS' => 'MISCELLANEOUS FILING',
													trimupper(input.Tran_Code) = 'MOA' => 'MARK OF OWNERSHIP/ASSIGNMENT',
													trimupper(input.Tran_Code) = 'ABC' => 'ABANDONMENT OF CONSOLIDATION S C',
													trimupper(input.Tran_Code) = 'ABM' => 'ABANDONMENT OF MERGER S C',
													trimupper(input.Tran_Code) = 'ACC' => 'DOMESTIC ARTICLES COMMUNITY COLLEGE O C',
													trimupper(input.Tran_Code) = 'AHO' => 'ARTICLES FOR HOSPITALS O C',
													trimupper(input.Tran_Code) = 'AGO' => 'DOMESTIC/AGENT ORIGINAL APPOINTMENT S C',
													trimupper(input.Tran_Code) = 'ANE' => 'DOMESTIC ARTICLES/NON-PROFIT CCE EXEMPT O C',
													trimupper(input.Tran_Code) = 'ANR' => 'ANNUAL REPORTS FOR PROFESSIONAL CORPORATION S C',
													trimupper(input.Tran_Code) = 'ARD' => 'DOMESTIC ARTICLES/CONSERVATORY DISTRICT O C',
													trimupper(input.Tran_Code) = 'ARH' => 'DOMESTIC ARTICLES/HUMANE SOCIETY O C',
													trimupper(input.Tran_Code) = 'ARO' => 'DOMESTIC ARTICLES/CO-OPERATIVE O A',
													trimupper(input.Tran_Code) = 'ARR' => 'DOMESTIC ARTICLES/REDEVELOPMENT O C',
													trimupper(input.Tran_Code) = 'ART' => 'ARTICLES OF INCORPORATION O C',
													trimupper(input.Tran_Code) = 'BUA' => 'BUSINESS TRUST/AMENDMENT S C',
													trimupper(input.Tran_Code) = 'DBA' => 'DOING BUSINESS AS S C',
													trimupper(input.Tran_Code) = 'DCE' => 'DOMESTIC CONTINUED EXISTENCE S C',
													trimupper(input.Tran_Code) = 'DLT' => 'DOMESTIC CONTINUED EXISTENCE LETTER S C',
													trimupper(input.Tran_Code) = 'FGO' => 'FOREIGN/AGENT ORIGINAL APPOINTMENT S C',
													trimupper(input.Tran_Code) = 'FLB' => 'FOREIGN LICENSE CANCELLATION S C',
													trimupper(input.Tran_Code) = 'PLF' => 'FOREIGN LIMITED LIABILITY PARTNERSHIP O A',
													trimupper(input.Tran_Code) = 'MOB' => 'MARK OF OWNERSHIP/BUSINESS ADDRESS CHANGE',
													trimupper(input.Tran_Code) = 'MOR' => 'MARK OF OWNERSHIP RENEWAL',
													trimupper(input.Tran_Code) = 'MOX' => 'MARK OF OWNERSHIP/CANCELLATION',
													trimupper(input.Tran_Code) = 'MUC' => 'MERGER TO FOREIGN CORP WITH ASSUMED NAME S C',
													trimupper(input.Tran_Code) = 'MUF' => 'MERGER INTO UNQUALIFIED FOREIGN CORP S C',
													trimupper(input.Tran_Code) = 'NFA' => 'FICTITIOUS NAME/ASSIGNMENT',
													trimupper(input.Tran_Code) = 'NFB' => 'FICTITIOUS NAME/BUSINESS ADDRESS CHANGE',
													trimupper(input.Tran_Code) = 'NFR' => 'FICTITIOUS NAME RENEWAL',
													trimupper(input.Tran_Code) = 'NFX' => 'FICTITIOUS NAME/CANCELLATION',
													trimupper(input.Tran_Code) = 'NRR' => 'NAME RESERVATION RENEWAL',
													trimupper(input.Tran_Code) = 'PLR' => 'REINSTATE/LIMITED LIABILITY PARTNERSHIP',
													trimupper(input.Tran_Code) = 'FL2' => 'FOREIGN 2ND TEMPORARY LICENSE',
													trimupper(input.Tran_Code) = 'FLT' => 'FOREIGN/AGENT RESIGNATION LETTER SERVED',
													trimupper(input.Tran_Code) = 'FMR' => 'MERGER/FOREIGN',
													trimupper(input.Tran_Code) = 'ARN' => 'DOMESTIC ARTICLES/NON-PROFIT O A',
													trimupper(input.Tran_Code) = 'ARP' => 'DOMESTIC ARTICLES/PROFESSIONAL O A',
													trimupper(input.Tran_Code) = 'ARS' => 'DOMESTIC ARTICLES/SAVINGS AND LOAN O A',
													trimupper(input.Tran_Code) = 'ARU' => 'DOMESTIC ARTICLES/CREDIT UNION O A',
													trimupper(input.Tran_Code) = 'ARY' => 'DOMESTIC ARTICLES/YMCA O A',
													trimupper(input.Tran_Code) = 'BTN' => 'BUSINESS TRUST/EXCLUSIVE RIGHT TO NAME O A',
													trimupper(input.Tran_Code) = 'BTS' => 'BUSINESS TRUST/ORIGINAL FILING',
													trimupper(input.Tran_Code) = 'CLP' => 'LIMITED PARTNERSHIP',
													trimupper(input.Tran_Code) = 'CNF' => 'CONSOLIDATION/FOREIGN LIMITED LIABILITY CO.',
													trimupper(input.Tran_Code) = 'CNL' => 'CONSOLIDATION/DOMESTIC LIMITED LIABILITY CO.',
													trimupper(input.Tran_Code) = 'CNP' => 'CONSOLIDATION/DOMESTIC LIMITED PARTNERSHIP',
													trimupper(input.Tran_Code) = 'CNR' => 'CONSOLIDATION/FOREIGN LIMITED PARTNERSHIP',
													trimupper(input.Tran_Code) = 'COC' => 'CONSOLIDATION/DOMESTIC/CHURCH',
													trimupper(input.Tran_Code) = 'CVT' => 'UNDETERMINED',
													trimupper(input.Tran_Code) = 'COF' => 'CONSOLIDATION/DOMESTIC CORP/FOR PROFIT',
													trimupper(input.Tran_Code) = 'COL' => 'CONSOLIDATION/FOREIGN CORP/FOR PROFIT',
												    trimupper(input.Tran_Code) = 'CON' => 'CONSOLIDATION/DOMESTIC CORP/NON PROFIT',
													trimupper(input.Tran_Code) = 'COP' => 'CONSOLIDATION/DOMESTIC CORP/PROFESSIONAL',
													trimupper(input.Tran_Code) = 'CSV' => 'CONVERSION TO STATE BANK',
													trimupper(input.Tran_Code) = 'FAC' => 'FOREIGN LICENSE/CHURCH WITH ASSUMED NAME',
													trimupper(input.Tran_Code) = 'FAN' => 'FOREIGN LICENSE/NON-PROFIT WITH ASSUMED NAME',
													trimupper(input.Tran_Code) = 'FAP' => 'FOREIGN LICENSE/PROFESSIONAL WITH ASSUMED NAME',
													trimupper(input.Tran_Code) = 'FLA' => 'FOREIGN LICENSE/FOR-PROFIT ASSUMED NAME',
													trimupper(input.Tran_Code) = 'FLC' => 'FOREIGN LICENSE/CHURCH',
													trimupper(input.Tran_Code) = 'FLF' => 'FOREIGN LICENSE/FOR-PROFIT',
													trimupper(input.Tran_Code) = 'FLN' => 'FOREIGN LICENSE/NON-PROFIT',
												    trimupper(input.Tran_Code) = 'FLO' => 'FOREIGN LICENSE/CO-OPERATIVE',
													trimupper(input.Tran_Code) = 'FLP' => 'FOREIGN LICENSE/PROFESSIONAL',
													trimupper(input.Tran_Code) = 'FLS' => 'FOREIGN LICENSE/SECONDARY ASSUMED NAME',
													trimupper(input.Tran_Code) = 'FLU' => 'FOREIGN LICENSE/CREDIT UNION',
													trimupper(input.Tran_Code) = 'LCA' => 'ARTICLES OF ORGANIZATION/DOM. LIMITED LIABILITY CO',
													trimupper(input.Tran_Code) = 'LFA' => 'REGISTRATION OF FOREIGN LIMITED LIABILITY CO',
													trimupper(input.Tran_Code) = 'LPF' => 'REGISTRATION OF FOREIGN LIMITED PARTNERSHIP',
													trimupper(input.Tran_Code) = 'MNL' => 'MERGER/LICENSING FOREIGN CORP/NON-PROFIT',
													trimupper(input.Tran_Code) = 'MOO' => 'MARK OF OWNERSHIP/ORIGINAL FILING',
													trimupper(input.Tran_Code) = 'MUA' => 'MERGER INTO LICENSING FOREIGN CORP W/ASSUMED NAME',
												    trimupper(input.Tran_Code) = 'AGS' => 'DOMESTIC AGENT SUBSEQUENT APPOINTMENT',
													trimupper(input.Tran_Code) = 'ALT' => 'DOMESTIC/AGENT REGISTRATION LETTER SERVED',
													trimupper(input.Tran_Code) = 'AMA' => 'DOMESTIC/AMENDED RESTATED ARTICLES',
													trimupper(input.Tran_Code) = 'AMD' => 'DOMESTIC/AMENDMENT TO ARTICLES',
													trimupper(input.Tran_Code) = 'AUT' => 'CERTIFICATE OF CONTINUED EXISTENCE',
													trimupper(input.Tran_Code) = 'AXA' => 'DOMESTIC/CANCELED/FAILURE TO MAINTAIN AGENT',
													trimupper(input.Tran_Code) = 'BSA' => 'BUSINESS TRUST ASSIGNMENT',
													trimupper(input.Tran_Code) = 'BTA' => 'BUSINESS TRUST AMENDMENT',
													trimupper(input.Tran_Code) = 'BTW' => 'BUSINESS TRUST WITHDRAWAL',
													trimupper(input.Tran_Code) = 'CRT' => 'CORP UPDATE CERTIFICATE CODE',
												    trimupper(input.Tran_Code) = 'CCE' => 'CERTIFICATE OF CONTINUED EXISTENCE',
													trimupper(input.Tran_Code) = 'CEX' => 'CONSOLIDATED OUT OF EXISTENCE',
													trimupper(input.Tran_Code) = 'CNV' => 'CONVERSION TO NATIONAL BANK',
													trimupper(input.Tran_Code) = 'CUF' => 'CONSOLIDATION INTO UNQUALIFIED FOREIGN CORP',
													trimupper(input.Tran_Code) = 'DCO' => 'DOMESTIC/DISSOLUTION',
													trimupper(input.Tran_Code) = 'DIS' => 'DOMESTIC/DISSOLUTION',
													trimupper(input.Tran_Code) = 'DMR' => 'DOMESTIC/DISSOLUTION BY MERGER',
													trimupper(input.Tran_Code) = 'FAM' => 'FOREIGN/AMENDMENT',
													trimupper(input.Tran_Code) = 'FCE' => 'FOREIGN/STATEMENT OF CONTINUED EXISTENCE',
													trimupper(input.Tran_Code) = 'FCR' => 'CORRECTION/FOREIGN LIMITED PARTNERSHIP',
												    trimupper(input.Tran_Code) = 'FGA' => 'FOREIGN/AGENT CHANGE OF ADDRESS',
													trimupper(input.Tran_Code) = 'FGR' => 'FOREIGN AGENT RESIGNATION',
													trimupper(input.Tran_Code) = 'FGS' => 'FOREIGN/DESIGNATED APPOINTMENT OF AGENT',
													trimupper(input.Tran_Code) = '40N' => 'FORM 7 NO FEE ASSESSED',
													trimupper(input.Tran_Code) = '41N' => 'FORM 7 NO FEE ASSESSED',
													trimupper(input.Tran_Code) = '64P' => 'FORM 7 PENALTY ADDED TO FEE',
													trimupper(input.Tran_Code) = '65P' => 'FORM 7 PENALTY ADDED TO FEE',
													trimupper(input.Tran_Code) = '66P' => 'FORM 7 PENALTY ADDED TO FEE',
													trimupper(input.Tran_Code) = '67P' => 'FORM 7 PENALTY ADDED TO FEE',
													trimupper(input.Tran_Code) = '68P' => 'FORM 7 PENALTY ADDED TO FEE',
													trimupper(input.Tran_Code) = '69P' => 'FORM 7 PENALTY ADDED TO FEE',
													trimupper(input.Tran_Code) = '61N' => 'FORM 7 NO FEE ASSESSED',
													trimupper(input.Tran_Code) = 'MPL' => 'MERGER/LICENSING FOREIGN CORP/PROFESSIONAL',
													trimupper(input.Tran_Code) = 'MRF' => 'MERGER/REGISTERING FOREIGN LIMITED LIABILITY CO',
													trimupper(input.Tran_Code) = 'MRP' => 'MERGER/REGISTERING FOREIGN LIMITED PARTNERSHIP',
													trimupper(input.Tran_Code) = 'CLN' => 'CONSOLIDATION/FOREIGN CORP/NON-PROFIT',
													trimupper(input.Tran_Code) = 'CLF' => 'CONSOLIDATION/FOREIGN CORP/PROFESSIONAL',
													trimupper(input.Tran_Code) = 'CLC' => 'CONSOLIDATION/FOREIGN/CHURCH',
													trimupper(input.Tran_Code) = 'FNA' => 'FOREIGN NOTICE/NATIONAL BANK, ASSUMED NAME',
													trimupper(input.Tran_Code) = 'FNB' => 'FOREIGN NOTICE/NATIONAL BANK',
													trimupper(input.Tran_Code) = 'FSA' => 'FOREIGN LICENSE/STATE BANK, ASSUMED NAME',
													trimupper(input.Tran_Code) = 'FSB' => 'FOREIGN LICENSE/STATE BANK',
													trimupper(input.Tran_Code) = '31P' or 	
													trimupper(input.Tran_Code) = '32P' or	
													trimupper(input.Tran_Code) = '33P' or	
													trimupper(input.Tran_Code) = '34P' or  
													trimupper(input.Tran_Code) = '35P' or	
													trimupper(input.Tran_Code) = '36P' or	
													trimupper(input.Tran_Code) = '37P' or	
													trimupper(input.Tran_Code) = '38P' or	
													trimupper(input.Tran_Code) = '39P' or	
													trimupper(input.Tran_Code) = '40P' or	
													trimupper(input.Tran_Code) = '41P' or
													trimupper(input.Tran_Code) = '42P' or	
													trimupper(input.Tran_Code) = '43P' or	
													trimupper(input.Tran_Code) = '44P' or	
													trimupper(input.Tran_Code) = '45P' or	
													trimupper(input.Tran_Code) = '46P' or	
													trimupper(input.Tran_Code) = '47P' or	
													trimupper(input.Tran_Code) = '48P' or	
													trimupper(input.Tran_Code) = '49P' or	
													trimupper(input.Tran_Code) = '50P' or	
													trimupper(input.Tran_Code) = '51P' or	
													trimupper(input.Tran_Code) = '52P' or	
													trimupper(input.Tran_Code) = '53P' or	
													trimupper(input.Tran_Code) = '54P' or	
													trimupper(input.Tran_Code) = '55P' or	
													trimupper(input.Tran_Code) = '56P' or	
													trimupper(input.Tran_Code) = '57P' or	
													trimupper(input.Tran_Code) = '58P' or	
													trimupper(input.Tran_Code) = '59P' or	
													trimupper(input.Tran_Code) = '60P' or	
													trimupper(input.Tran_Code) = '61P' or	
													trimupper(input.Tran_Code) = '62P' or	
													trimupper(input.Tran_Code) = '63P' => 'FORM 7 PENALTY ADDED TO FEE',
													trimupper(input.Tran_Code) = '62A' or
													trimupper(input.Tran_Code) = '63A' or 
													trimupper(input.Tran_Code) = '64A' or 
													trimupper(input.Tran_Code) = '65A' or 
													trimupper(input.Tran_Code) = '66A' or 
													trimupper(input.Tran_Code) = '67A' or 
													trimupper(input.Tran_Code) = '68A' or 
													trimupper(input.Tran_Code) = '69A' => 'ANNUAL REPORT OF PROFESSIONAL CORP',
													trimupper(input.Tran_Code) = '30N' or 
													trimupper(input.Tran_Code) = '31N' or 
													trimupper(input.Tran_Code) = '32N' or 
													trimupper(input.Tran_Code) = '33N' or 
													trimupper(input.Tran_Code) = '34N' or 
													trimupper(input.Tran_Code) = '35N' or 
													trimupper(input.Tran_Code) = '36N' or 
													trimupper(input.Tran_Code) = '37N' or 
													trimupper(input.Tran_Code) = '38N' or 
													trimupper(input.Tran_Code) = '39N' or 
													trimupper(input.Tran_Code) = '40N' or 
													trimupper(input.Tran_Code) = '41N' or 
													trimupper(input.Tran_Code) = '42N' or 
													trimupper(input.Tran_Code) = '43N' or 
													trimupper(input.Tran_Code) = '44N' or 
													trimupper(input.Tran_Code) = '45N' or 
													trimupper(input.Tran_Code) = '46N' or 
													trimupper(input.Tran_Code) = '47N' or 
													trimupper(input.Tran_Code) = '48N' or 
													trimupper(input.Tran_Code) = '49N' or 
													trimupper(input.Tran_Code) = '50N' or 
													trimupper(input.Tran_Code) = '51N' or 
													trimupper(input.Tran_Code) = '52N' or 
													trimupper(input.Tran_Code) = '53N' or 
													trimupper(input.Tran_Code) = '54N' or 
													trimupper(input.Tran_Code) = '55N' or 
													trimupper(input.Tran_Code) = '56N' or 
													trimupper(input.Tran_Code) = '57N' or 
													trimupper(input.Tran_Code) = '58N' or 
													trimupper(input.Tran_Code) = '59N' or 
													trimupper(input.Tran_Code) = '60N' or 
													trimupper(input.Tran_Code) = '62N' or 
													trimupper(input.Tran_Code) = '63N' or 
													trimupper(input.Tran_Code) = '64N' or 
													trimupper(input.Tran_Code) = '65N' or 
													trimupper(input.Tran_Code) = '66N' or 
													trimupper(input.Tran_Code) = '67N' or 
													trimupper(input.Tran_Code) = '68N' or 
													trimupper(input.Tran_Code) = '69N' => 'FORM 7 NO FEE ASSESSED',
													trimupper(input.Tran_Code) = '30P' => 'FORM 7 PENALTY ADDED TO FEE',
													trimupper(input.Tran_Code) = '39F' or
													trimupper(input.Tran_Code) = '40F' or
													trimupper(input.Tran_Code) = '41F' or
													trimupper(input.Tran_Code) = '42F' or
													trimupper(input.Tran_Code) = '43F' or
													trimupper(input.Tran_Code) = '44F' or
													trimupper(input.Tran_Code) = '45F' or
													trimupper(input.Tran_Code) = '46F' or
													trimupper(input.Tran_Code) = '47F' or
													trimupper(input.Tran_Code) = '48F' or
													trimupper(input.Tran_Code) = '49F' or
													trimupper(input.Tran_Code) = '50F' or
													trimupper(input.Tran_Code) = '51F' or
													trimupper(input.Tran_Code) = '52F' or
													trimupper(input.Tran_Code) = '53F' or
													trimupper(input.Tran_Code) = '54F' or
													trimupper(input.Tran_Code) = '55F' or
													trimupper(input.Tran_Code) = '56F' or
													trimupper(input.Tran_Code) = '57F' or
													trimupper(input.Tran_Code) = '58F' or
													trimupper(input.Tran_Code) = '59F' or
													trimupper(input.Tran_Code) = '60F' or
													trimupper(input.Tran_Code) = '61F' or
													trimupper(input.Tran_Code) = '62F' or
													trimupper(input.Tran_Code) = '63F' or
													trimupper(input.Tran_Code) = '64F' or
													trimupper(input.Tran_Code) = '65F' or
													trimupper(input.Tran_Code) = '66F' or
													trimupper(input.Tran_Code) = '67F' or
													trimupper(input.Tran_Code) = '68F' or
													trimupper(input.Tran_Code) = '69F' => 'FORM 7 FEE ASSESSED',
													trimupper(input.Tran_Code) = '60A' or 
													trimupper(input.Tran_Code) = '61A' => 'ANNUAL REPORT OF PROFESSIONAL CORP',
													trimupper(input.Tran_Code) = '01N' or
													trimupper(input.Tran_Code) = '02N' or
													trimupper(input.Tran_Code) = '03N' or
													trimupper(input.Tran_Code) = '04N' or
													trimupper(input.Tran_Code) = '05N' or
													trimupper(input.Tran_Code) = '06N' or
													trimupper(input.Tran_Code) = '07N' or
													trimupper(input.Tran_Code) = '08N' or
													trimupper(input.Tran_Code) = '09N' or
													trimupper(input.Tran_Code) = '10N' => 'FORM 7 NO FEE ASSESSED',
													trimupper(input.Tran_Code) = '80P' or
													trimupper(input.Tran_Code) = '81P' or
													trimupper(input.Tran_Code) = '82P' or
													trimupper(input.Tran_Code) = '83P' or
													trimupper(input.Tran_Code) = '84P' or
													trimupper(input.Tran_Code) = '85P' or
													trimupper(input.Tran_Code) = '86P' or
													trimupper(input.Tran_Code) = '87P' or
													trimupper(input.Tran_Code) = '88P' or
													trimupper(input.Tran_Code) = '89P' or
													trimupper(input.Tran_Code) = '90P' or
													trimupper(input.Tran_Code) = '91P' or
													trimupper(input.Tran_Code) = '92P' or
													trimupper(input.Tran_Code) = '93P' or
													trimupper(input.Tran_Code) = '94P' or
													trimupper(input.Tran_Code) = '95P' or
													trimupper(input.Tran_Code) = '96P' or
													trimupper(input.Tran_Code) = '97P' or
													trimupper(input.Tran_Code) = '98P' or
													trimupper(input.Tran_Code) = '99P' or
													trimupper(input.Tran_Code) = '00P' or
													trimupper(input.Tran_Code) = '01P' or
													trimupper(input.Tran_Code) = '02P' or
													trimupper(input.Tran_Code) = '03P' or
													trimupper(input.Tran_Code) = '04P' or
													trimupper(input.Tran_Code) = '05P' or
													trimupper(input.Tran_Code) = '06P' or
													trimupper(input.Tran_Code) = '07P' or
													trimupper(input.Tran_Code) = '08P' or
													trimupper(input.Tran_Code) = '09P' or
													trimupper(input.Tran_Code) = '10P' => 'FORM 7 PENALTY ADDED TO FEE',
													trimupper(input.Tran_Code) = '7LT' => 'FORM DELINQUENCY LETTER SERVED',
													trimupper(input.Tran_Code) = 'LIC' => 'FOREIGN LICENSE',
													trimupper(input.Tran_Code) = 'N/R' => 'NAME RESERVATION',
													trimupper(input.Tran_Code) = 'SAN' => 'SANITATION',
													trimupper(input.Tran_Code) = 'MOE' => 'MARK OF OWNERSHIP/EXPIRED BY OPERATION OF LAW',
													trimupper(input.Tran_Code) = 'NFE' => 'FICTITIOUS NAME/CANCELLED BY TAX DEPARTMENT',
													trimupper(input.Tran_Code) = 'PEN' => 'FOREIGN PENALTY-DOING BUSINESS W/OUT LICENSE',
													trimupper(input.Tran_Code) = 'PER' => 'FOREIGN/PERMANENT LICENSE',
													trimupper(input.Tran_Code) = 'RCB' => 'UNLICENSED FORGN NAME RESRV/BUSINESS ADR. CHANGE',
													trimupper(input.Tran_Code) = 'RCE' => 'UNLICENSED FORGN NAME RESRV/EXPIRED-OPER. OF LAW',
													trimupper(input.Tran_Code) = 'RNE' => 'TRADE NAME/EXPIRED BY OPERATION OF LAW',
													trimupper(input.Tran_Code) = 'RNL' => 'TRADE NAME/EARLY RENEWAL FILING TO COMPLY WITH LAW',
													trimupper(input.Tran_Code) = 'SME' => 'SERVICE MARK/EXPIRED BY OPERATION OF LAW',
													trimupper(input.Tran_Code) = 'TEM' => 'FOREIGN/TEMPORARY LICENSE',
													trimupper(input.Tran_Code) = 'TME' => 'TRADE MARK/EXPIRED BY OPERATION OF LAW',
													trimupper(input.Tran_Code) = 'UNL' => 'UNLIMITED STOCK QUANTITY (CREDIT UNION)',
													trimupper(input.Tran_Code) = 'UTH' => 'CERTIFICATE OF AUTHORITY (BANK)',
													trimupper(input.Tran_Code) = 'FXT' => 'FOREIGN LICENSE/CANCELLED BY TAX DEPARTMENT',
													trimupper(input.Tran_Code) = 'NFL' => 'FICTITIOUS NAME/EARLY RENEWAL TO COMPLY WITH LAW',
													trimupper(input.Tran_Code) = 'XXX' => 'CANCELED/UNABLE TO DETERMINE/OLD-INCOMP. RECORDS CVT',
													trimupper(input.Tran_Code) = '30F' => 'FORM 7 FEE ASSESSED',
													trimupper(input.Tran_Code) = '31F' => 'FORM 7 FEE ASSESSED',
													trimupper(input.Tran_Code) = '32F' => 'FORM 7 FEE ASSESSED',
													trimupper(input.Tran_Code) = '33F' => 'FORM 7 FEE ASSESSED',
													trimupper(input.Tran_Code) = '34F' => 'FORM 7 FEE ASSESSED',
													trimupper(input.Tran_Code) = '00N' => 'FORM 7 NO FEE ASSESSED',
													trimupper(input.Tran_Code) = '35F' => 'FORM 7 FEE ASSESSED',
													trimupper(input.Tran_Code) = '36F' => 'FORM 7 FEE ASSESSED',
													trimupper(input.Tran_Code) = '37F' => 'FORM 7 FEE ASSESSED',
													trimupper(input.Tran_Code) = '38F' => 'FORM 7 FEE ASSESSED',
													trimupper(input.Tran_Code) = 'MUL' => 'MERGER/LICENSING FOREIGN CORP/FOR PROFIT',
													trimupper(input.Tran_Code) = 'NRO' => 'NAME RESERVATION',
													trimupper(input.Tran_Code) = 'NEW' => 'INCORPORATED BY ACT OF LEGISLATURE',
													trimupper(input.Tran_Code) = 'NFO' => 'FICTITIOUS NAME/ORIGINAL FILING',
													trimupper(input.Tran_Code) = 'PLL' => 'DOMESTIC LIMITED LIABILITY PARTNERSHIP',
													trimupper(input.Tran_Code) = 'RCO' => 'UNLICENSED FOREIGN NAME RESERVATION/ORIG. FILING',
													trimupper(input.Tran_Code) = 'RNO' => 'TRADE NAME/ORIGINAL FILING',
													trimupper(input.Tran_Code) = 'RTO' => 'REAL ESTATE TRUST/ORIGINAL FILING',
													trimupper(input.Tran_Code) = 'SMO' => 'SERVICE MARK/ORIGINAL FILING',
													trimupper(input.Tran_Code) = 'TMO' => 'TRADE MARK/ORIGINAL FILING',
													trimupper(input.Tran_Code) = 'AGU' => 'AGENT NAME/ADDRESS TAX UPDATE',
													trimupper(input.Tran_Code) = 'AGA' => 'DOMESTIC AGENT ADDRESS CHANGE',
													trimupper(input.Tran_Code) = 'AGR' => 'DOMESTIC/AGENT RESIGNATION',
													trimupper(input.Tran_Code) = 'AOD' => 'DOMESTIC ARTICLES/OHIO DEVELOPMENT',
													trimupper(input.Tran_Code) = 'ARA' => 'DOMESTIC ARTICLES/CEMETERY ASSOC',
													trimupper(input.Tran_Code) = 'ARB' => 'ARTICLES/BANK',
													trimupper(input.Tran_Code) = 'ARC' => 'DOMESTIC ARTICLES/CHURCH',
													trimupper(input.Tran_Code) = 'ARF' => 'DOMESTIC ARTICLES/FOR PROFIT',
													trimupper(input.Tran_Code) = 'ARI' => 'DOMESTIC ARTICLES/COMMUNITY IMPROVEMENT',
													trimupper(input.Tran_Code) = 'NRT' => 'NAME RESERVATION TRANSFER',
																																													
													
																										
													''
												);
													
													
			
			 			
			
			
						ExplanationTypeDesc := MAP( trimupper(input.Explanation_Code) = 'TIC' => 'TRANSCRIPT CHECK',
											        trimupper(input.Explanation_Code) = 'ICR' => 'SHARE INCREASE CREDIT',
													trimupper(input.Explanation_code) = 'RCN' => 'UNLIC. FOR. NAME RESERV/OWNERS NAME CHANGE',
													trimupper(input.Explanation_code) = 'CAA' => 'CHANGE RECORD ACCESS ADDRESS',
													trimupper(input.Explanation_code) = 'CBA' => 'CHANGE PRINCIPAL BUSINESS ADDRESS',
													trimupper(input.Explanation_code) = 'CDD' => 'CHANGE DOMESTIC AGENT ADDRESS',
													trimupper(input.Explanation_code) = 'CDG' => 'CHANGE DOMESTIC AGENT',
													trimupper(input.Explanation_code) = 'CFB' => 'CHANGE FROM BANK TO GENERAL CORP',
													trimupper(input.Explanation_code) = 'CFD' => 'CHANGE FOREIGN AGENT ADDRESS',
													trimupper(input.Explanation_code) = 'CFG' => 'CHANGE FOREIGN AGENT',
													trimupper(input.Explanation_code) = 'CFN' => 'DOMESTIC/CHANGE FOR PROFIT TO NON-PROFIT',
											        trimupper(input.Explanation_code) = 'CFP' => 'DOMESTIC/CHANGE FOR PROFIT TO PROFESSIONAL',
													trimupper(input.Explanation_code) = 'CHL' => 'DOMESTIC CHANGE OF LOCATION',
													trimupper(input.Explanation_code) = 'CHN' => 'CHANGE OF NAME',
													trimupper(input.Explanation_code) = 'CHP' => 'CHANGE OF PURPOSE',
													trimupper(input.Explanation_code) = 'CHS' => 'DOMESTIC CHANGE OF SHARES',
													trimupper(input.Explanation_code) = 'CHV' => 'DOMESTIC CHANGE OF STOCK VALUE',
													trimupper(input.Explanation_code) = 'CLD' => 'CHANGE LIMITED/LIABILITY/PARTNERS AGENT ADDRESS',
													trimupper(input.Explanation_code) = 'CLG' => 'CHANGE LIMITED/LIABILITY/PARTNERS AGENT',
													trimupper(input.Explanation_code) = 'CLR' => 'CHANGE-LIMITED/LIABILITY/PARTNER AGENT RESIGNATION',
													trimupper(input.Explanation_code) = 'CLT' => 'CANCELLATION NOTICE SERVED',
											        trimupper(input.Explanation_code) = 'CMA' => 'CHANGE-AMENDED ARTICLES',
													trimupper(input.Explanation_code) = 'CMD' => 'CHANGE-AMENDMENT',
													trimupper(input.Explanation_code) = 'CMP' => 'CHANGE MEMBERS/PARTNERS',
													trimupper(input.Explanation_code) = 'COA' => 'CHANGE OF PRINCIPAL OFFICE ADDRESS FOR GL',
													trimupper(input.Explanation_code) = 'CPE' => 'CHANGE PERIOD OF EXISTENCE',
													trimupper(input.Explanation_code) = 'CPF' => 'DOMESTIC/CHANGE PROFESSIONAL TO FOR PROFIT',
													trimupper(input.Explanation_code) = 'CPO' => 'CHANGE PRINCIPAL OFFICE ADDRESS FOR FP',
													trimupper(input.Explanation_code) = 'CSN' => 'DOMESTIC/CHANGE STOCK TO NON-STOCK',
													trimupper(input.Explanation_code) = 'CSS' => 'DOMESTIC/CREATION OF STOCK SERIES',
													trimupper(input.Explanation_code) = 'CVT' => 'UNDETERMINED',
											        trimupper(input.Explanation_code) = 'DEC' => 'DECREASE OF AUTHORIZED SHARES OF STOCK',
													trimupper(input.Explanation_code) = 'FPP' => 'FOREIGN/CHANGE OF PRINCIPAL OFFICE',
													trimupper(input.Explanation_code) = 'INC' => 'INCREASE OF AUTHORIZED STOCK SHARES',
													trimupper(input.Explanation_code) = 'MOC' => 'MARK OF OWNERSHIP/REGISTRANT ADDRESS CHANGE',
													trimupper(input.Explanation_code) = 'MON' => 'MARK OF OWNERSHIP/OWNERS NAME CHANGE',
													trimupper(input.Explanation_code) = 'MOP' => 'MARK OF OWNERSHIP/CHANGE OF PARTNERS',
													trimupper(input.Explanation_code) = 'NFC' => 'FICTITIOUS NAME/REGISTRANT ADDRESS CHANGE',
													trimupper(input.Explanation_code) = 'NFN' => 'FICTITIOUS NAME/OWNERS NAME CHANGE',
													trimupper(input.Explanation_code) = 'NFP' => 'FICTITIOUS NAME/CHANGE OF PARTNERS',
													trimupper(input.Explanation_code) = 'RCC' => 'UNLIC. FOR. NAME RESERV./REGISTRANT ADDRESS CHANGE',
											        trimupper(input.Explanation_code) = 'RNC' => 'TRADE NAME/REGISTRANT ADDRESS CHANGE',
													trimupper(input.Explanation_code) = 'RNN' => 'TRADE NAME/OWNERS NAME CHANGE',
													trimupper(input.Explanation_code) = 'RNP' => 'TRADE NAME/CHANGE OF PARTNERS',
													trimupper(input.Explanation_code) = 'SAA' => 'SERVICE ADDRESS ASSIGNMENT',
													trimupper(input.Explanation_code) = 'SMC' => 'SERVICE MARK/REGISTRANT ADDRESS CHANGE',
													trimupper(input.Explanation_code) = 'SMN' => 'SERVICE MARK/OWNERS NAME CHANGE',
													trimupper(input.Explanation_code) = 'SMP' => 'SERVICE MARK/CHANGE PARTNERS',
													trimupper(input.Explanation_code) = 'TMC' => 'TRADE MARK/REGISTRANT ADDRESS CHANGE',
													trimupper(input.Explanation_code) = 'TMN' => 'TRADE MARK/OWNERS NAME CHANGE',
													trimupper(input.Explanation_code) = 'TMP' => 'TRADE MARK/CHANGE OF PARTNERS',
											        trimupper(input.Explanation_code) = 'TRA' => 'DOMESTIC LIMITED PARTNERSHIP/TRUSTEE ASSIGNMENT',
													trimupper(input.Explanation_code) = 'TRC' => 'DOMESTIC LIMITED PARTNERSHIP/TRUSTEE CHANGE',
													trimupper(input.Explanation_code) = 'ADF' => 'ADDITIONAL FEE',
													trimupper(input.Explanation_code) = 'CFO' => 'CHANGE TO COOPERATIVE',
													trimupper(input.Explanation_code) = 'CHC' => 'DOMESTIC/CHANGE OF STATED CAPITAL',
													trimupper(input.Explanation_code) = 'AAL' => 'ASSETS & ASSUMPTIONS OF LIABILITES',
													trimupper(input.Explanation_code) = 'CSP' => 'CHANGE FOREIGN SHARES',
													trimupper(input.Explanation_code) = 'CFS' => 'CHANGE STATE',
													trimupper(input.Explanation_code) = 'CFA' => 'FOREIGN/ADDING ASSUME NAME',
													trimupper(input.Explanation_code) = 'CAF' => 'FOREIGN/DELETING ASSUMED NAME',
													trimupper(input.Explanation_code) = 'NRT' => 'NAME RESERVATION TRANSFER',
													trimupper(input.Explanation_code) = 'TIC' => 'TRANSCRIPT CHECK',
											
													''
												);




			self.event_filing_desc			:= if (TranTypeDesc <> '', 
														if( ExplanationTypeDesc <>'', 
																if(input.Doc_Text <> '',
																		TranTypeDesc +'; ' + ExplanationTypeDesc + '; ' + input.Doc_Text,
																		TranTypeDesc +'; ' + ExplanationTypeDesc
																   ),
																if(input.Doc_Text <> '',
																		TranTypeDesc +'; ' + input.Doc_Text,
																		TranTypeDesc
																   )
															 ),
														  if( ExplanationTypeDesc <>'', 
																if(input.Doc_Text <> '',
																		ExplanationTypeDesc + '; ' + input.Doc_Text,
																		ExplanationTypeDesc
																   ),
																if(input.Doc_Text <> '',
																		input.Doc_Text,
																		''
																   )
															 )
														);
														

 
			self							:=[];
			
			
		end; // end of OH_Event_transform M.R.
		
		// contact_TRANSFORM
		corp2_mapping.Layout_ContPreClean OH_contactTransform(Layouts_Raw_Input.Business_Association input) := transform
			
			self.dt_first_seen				:= fileDate;
			self.dt_last_seen				:= fileDate;

			self.corp_key						:= '39-' +trim(input.charter_num, left, right);
			self.corp_vendor					:= '39';
			self.corp_state_origin				:= 'OH';
			self.corp_process_date				:= fileDate;
			self.corp_orig_sos_charter_nbr		:= trim(input.charter_num, left, right);
			self.corp_legal_name				:= trimUpper(regexreplace('[.]*$',input.Business_Name,'',NOCASE));
			self.cont_type_cd					:= input.Original_Business_Type; 
			
			self.cont_type_desc					:=  map(	
														trimupper(input.Original_Business_Type)= 'A'  => 'PREVIOUS REGISTERED AGENT',
														trimUpper(input.Original_Business_Type)= 'F'  => 'OFFICER',
														trimUpper(input.Original_Business_Type)= 'G'  => 'REGISTERED AGENT',
														trimUpper(input.Original_Business_Type)= 'I'  => 'APPLICANT',
														trimUpper(input.Original_Business_Type)= 'M'  => 'MEMBER/MANAGER/PARTNER',
														trimUpper(input.Original_Business_Type)= 'O'  => 'OWNER',
														trimUpper(input.Original_Business_Type)= 'U'  => 'PERSON',
														trimUpper(input.Original_Business_Type)= 'T'  => 'CONTACT',
														trimUpper(input.Original_Business_Type)= '01' => 'RESERVER',
														trimUpper(input.Original_Business_Type)= '02' => 'REGISTRANT',
														''
														);


			self.cont_name						:= input.Business_Assoc_Name;
			self								:= [];
		end; 
		
			

		Corp2.Layout_Corporate_Direct_Cont_In CleanContNameAddr(corp2_mapping.Layout_ContPreClean input) := transform
			// cleaning name
			string73 tempname 				:= if (input.cont_name = '', '',Address.CleanPersonFML73(input.cont_name));
			pname 							:= Address.CleanNameFields(tempName);
			cname 							:= DataLib.companyclean(input.cont_name);
			keepPerson 						:= Corp2.Rewrite_Common.IsPerson(input.cont_name);
			keepBusiness 					:= Corp2.Rewrite_Common.IsCompany(input.cont_name);
			
			self.cont_title1				:= if(keepPerson, pname.title, '');
			self.cont_fname1 				:= if(keepPerson, pname.fname, '');
			self.cont_mname1 				:= if(keepPerson, pname.mname, '');
			self.cont_lname1 				:= if(keepPerson, pname.lname, '');
			self.cont_name_suffix1 			:= if(keepPerson, pname.name_suffix,'');
			self.cont_score1 				:= if(keepPerson, pname.name_score, '');
		
			self.cont_cname1 				:= if(keepBusiness, cname[1..70],'');
			self.cont_cname1_score 			:= if(keepBusiness, pname.name_score,'');	
			
			string182 clean_address 		:= Address.CleanAddress182(trim(trim(input.cont_address_line1,left,right) + ' ' + 														                        
											trim(input.cont_address_line2,left,right),left,right),														                   
											trim(trim(input.cont_address_line3,left,right) + ', ' +
											trim(input.cont_address_line4,left,right) + ' ' +
											trim(input.cont_address_line5,left,right) +
											trim(input.cont_address_line6,left,right),left,right));

			self.cont_prim_range    		:= clean_address[1..10];
			self.cont_predir 	      		:= clean_address[11..12];
			self.cont_prim_name 	  		:= clean_address[13..40];
			self.cont_addr_suffix   		:= clean_address[41..44];
			self.cont_postdir 	    		:= clean_address[45..46];
			self.cont_unit_desig 	  		:= clean_address[47..56];
			self.cont_sec_range 	  		:= clean_address[57..64];
			self.cont_p_city_name	  		:= clean_address[65..89];
			self.cont_v_city_name	  		:= clean_address[90..114];
			self.cont_state 			    := clean_address[115..116];
			self.cont_zip5 		      		:= clean_address[117..121];
			self.cont_zip4 		      		:= clean_address[122..125];
			self.cont_cart 		      		:= clean_address[126..129];
			self.cont_cr_sort_sz 	 		:= clean_address[130];
			self.cont_lot 		      		:= clean_address[131..134];
			self.cont_lot_order 	  		:= clean_address[135];
			self.cont_dpbc 		      		:= clean_address[136..137];
			self.cont_chk_digit 	  		:= clean_address[138];
			self.cont_rec_type		  		:= clean_address[139..140];
			self.cont_ace_fips_st	  		:= clean_address[141..142];
			self.cont_county 	  			:= clean_address[143..145];
			self.cont_geo_lat 	    		:= clean_address[146..155];
			self.cont_geo_long 	    		:= clean_address[156..166];
			self.cont_msa 		      		:= clean_address[167..170];
			self.cont_geo_blk				:= clean_address[171..177];
			self.cont_geo_match 	  		:= clean_address[178];
			self.cont_err_stat 	    		:= clean_address[179..182];
			self							:= input;
			self							:= [];
		end;
		//************************cleaning ends***************************************



		// finding share code desc
		//PreCleanedCommonLayouts.stockPre findShareCode(PreCleanedCommonLayouts.stockPre input, ShareTypeLayout r ) := transform

			//self.stock_class		:= r.typeDesc;
			//self 					:= input;
			//self					:= [];
		//end; // end transform

		
		// merge business and document_transaction

		Layouts_Raw_Input.BusinessDocTransaction MergeBusinessDocTrans(Layouts_Raw_Input.Business l, Layouts_Raw_Input.Document_Transaction r ) := transform
             self.Effective_Date_Time:=r.Tran_Effective_Date_Time;			
			self 					:= l;
			self					:= r;
			self					:= [];
		end; // end merging
		
		// merge business and authorized_share

		Layouts_Raw_Input.BusinessAuthorized_Share MergeBusinessAuthShare(Layouts_Raw_Input.Business l, Layouts_Raw_Input.Authorized_Share r ) := transform

			self 					:= l;
			self					:= r;
			self					:= [];
		end; // end merging
		
		// merge business and business_associate

		Layouts_Raw_Input.Business_Association MergeBusinessBusAssociate(Layouts_Raw_Input.Business l, Layouts_Raw_Input.Business_Associate r ) := transform

			self 					       := l;
			self.Effective_Date_Time       :=l.Bus_Effective_Date_Time;			
			self					       := r;
			self					:= [];
		end; // end merging
		
		Layouts_Raw_Input.ExplanationTextInformation MergeExplanationText(Layouts_Raw_Input.Explanation l, Layouts_Raw_Input.Text_Information r ) := transform

			self 					:= l;
			self					:= r;
			self					:= [];
		end; // end merging

		Layouts_Raw_Input.ExplanationTextDocTrans MergeExplanationTextDocTrans(Layouts_Raw_Input.Document_Transaction l, Layouts_Raw_Input.ExplanationTextInformation r ) := transform
            self.Effective_Date_Time:=l.Tran_Effective_Date_Time;
			self 					:= l;
			self					:= r;
			self					:= [];
		end; // end merging
		
		shareTypeLayout := record
			string typeCode;
			string typeDesc;
		end;
		
		shareTypeTable := dataset('~thor_data400::lookup::corp2::' + fileDate + '::shareType_Table::oh',shareTypeLayout,CSV(SEPARATOR(['|']), TERMINATOR(['\r\n', '\n'])));

		Layouts_Raw_Input.BusinessAuthorized_Share findshareType(Layouts_Raw_Input.BusinessAuthorized_Share input, shareTypeLayout r ) := transform
			self.stock_par_value	        := r.typeDesc;
			self         			 		:= input;
			self                           	:= [];
		end; // end transform

		

		// need to join business and doc_transaction for used in ar transform
		
		joinBusinessWithDocTrans 			:= join(Files_Raw_Input.BusinessFile(fileDate),Files_Raw_Input.DocumentTransaction(fileDate),
												trim(left.charter_num, left, right) = right.charter_num,
												MergeBusinessDocTrans(left,right),
												left outer);
										
										
		MapAR 								:= project(Files_Raw_Input.DocumentTransaction(fileDate), OH_arTransform(left));
		
		// join for stock transform

		joinBusinessWithAuthShare 			:= join(Files_Raw_Input.BusinessFile(fileDate),Files_Raw_Input.AuthorizedShare(fileDate),
												trim(left.charter_num, left, right) = right.charter_num,
												MergeBusinessAuthShare(left,right),
												left outer);
										
										
										
		
		joinShareType 						:= join(joinBusinessWithAuthShare , ShareTypeTable,
												trim(left.SHARE_CODE, left, right) = right.typeCode,
												findShareType(left,right),
												left outer, lookup);
										
										
										

		MapStock 							:= project(joinShareType, OH_stockTransform(left));
		
		
		
		

		// join explanation file with text_information file
		
		joinExplanationWithText 			:= join(Files_Raw_Input.Explanation(fileDate),Files_Raw_Input.TextInformation(fileDate),
												trim(left.charter_num, left, right) = trim(right.charter_num, left, right) AND
												left.Doc_Count = right.Doc_count,
												MergeExplanationText(left,right),
												left outer);
										
										
										
										

		
		joinExplanationTextWithDocTrans		:= join(Files_Raw_Input.DocumentTransaction(fileDate),joinExplanationWithText,
												trim(left.charter_num, left, right) = right.charter_num AND
												left.Doc_Count = right.Doc_count,
												MergeExplanationTextDocTrans(left,right),
												left outer);
											
											
											
											
											

		// dedup result of above record set to eliminate duplicate records.
			
		//removedDuplicateRecords 			:= DEDUP(joinExplanationTextWithDocTrans);
		
		
		


		// event transform
		MapEvent 							:= project(joinExplanationTextWithDocTrans, OH_eventTransform(fileDate,left));
		
		
		
		

		// joining for contact transform

		joinBusinessWithBusinessAssoc 		 := join(Files_Raw_Input.BusinessFile(fileDate),Files_Raw_Input.BusinessAssociate(fileDate),
												trim(left.charter_num, left, right) = right.charter_num,
												MergeBusinessBusAssociate(left,right),
												left outer);

		

		MapCont 							:= project(joinBusinessWithBusinessAssoc, OH_contactTransform(left));

	
		 //---------------------------- Clean Name and Addresses ---------------------//

		
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
			
			
			string182 clean_address2 			:= Address.CleanAddress182(trim(trim(input.corp_address2_line1,left,right) + ' ' + 														                        
												trim(input.corp_address2_line2,left,right),left,right),														                   
												trim(trim(input.corp_address2_line3,left,right) + ', ' +
												trim(input.corp_address2_line4,left,right) + ' ' +
												trim(input.corp_address2_line5,left,right) +
												trim(input.corp_address2_line6,left,right),left,right));

			self.corp_addr2_prim_range    		:= clean_address2[1..10];
			self.corp_addr2_predir 	      		:= clean_address2[11..12];
			self.corp_addr2_prim_name 	  		:= clean_address2[13..40];
			self.corp_addr2_addr_suffix   		:= clean_address2[41..44];
			self.corp_addr2_postdir 	    	:= clean_address2[45..46];
			self.corp_addr2_unit_desig 	  		:= clean_address2[47..56];
			self.corp_addr2_sec_range 	  		:= clean_address2[57..64];
			self.corp_addr2_p_city_name	  		:= clean_address2[65..89];
			self.corp_addr2_v_city_name	  		:= clean_address2[90..114];
			self.corp_addr2_state 				:= clean_address2[115..116];
			self.corp_addr2_zip5 		    	:= clean_address2[117..121];
			self.corp_addr2_zip4 		    	:= clean_address2[122..125];
			self.corp_addr2_cart 		    	:= clean_address2[126..129];
			self.corp_addr2_cr_sort_sz 	 		:= clean_address2[130];
			self.corp_addr2_lot 		      	:= clean_address2[131..134];
			self.corp_addr2_lot_order 	  		:= clean_address2[135];
			self.corp_addr2_dpbc 		    	:= clean_address2[136..137];
			self.corp_addr2_chk_digit 	  		:= clean_address2[138];
			self.corp_addr2_rec_type		  	:= clean_address2[139..140];
			self.corp_addr2_ace_fips_st	  		:= clean_address2[141..142];
			self.corp_addr2_county 	  			:= clean_address2[143..145];
			self.corp_addr2_geo_lat 	    	:= clean_address2[146..155];
			self.corp_addr2_geo_long 	    	:= clean_address2[156..166];
			self.corp_addr2_msa 		      	:= clean_address2[167..170];
			self.corp_addr2_geo_blk				:= clean_address2[171..177];
			self.corp_addr2_geo_match 	  		:= clean_address2[178];
			self.corp_addr2_err_stat 	    	:= clean_address2[179..182];			
	
						
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
		
		
		//*************************cleaned routine****************

		cleanCont := project(MapCont , CleanContNameAddr(left));

		//********************cleaned routine *************	


		
		Layouts_Raw_Input.BusinessAdd MergeBusAddr(Layouts_Raw_Input.Business l, Layouts_Raw_Input.Business_Address r ) := transform
			self 					:= l;
			self					:= r;
			self                    := [];			
			end; 
		
		joinBusAddr := join(Files_Raw_Input.BusinessFile(fileDate), Files_Raw_Input.BusinessAddress(fileDate),
							trim(left.Charter_Num,left,right) = trim(right.Charter_Num,left,right),
							MergeBusAddr(left,right),
							left outer);
					
					
					
       //Get the Bus_Business_Cnty full name
	   Layouts_Raw_Input.BusinessAdd getBusCounty(Layouts_Raw_Input.BusinessAdd input, CountyCodeLayout r) := transform
			self.bus_business_cnty_full  := if(trimUpper(r.CountyDesc)<>'CONVERSION',
											   trimUpper(r.CountyDesc),
											   '');																									
			self         			     := input;
			end; 
		
	   joinBusCounty := 	join(joinBusAddr,CountyCodeTable,
								 trim(left.bus_business_cnty,left,right) = trim(right.CountyCode,left,right),
								 getBusCounty(left,right),
								 left outer, lookup);
					
					
					
		Layouts_Raw_Input.BusinessAddCont MergeBusAddrCont(Layouts_Raw_Input.BusinessAdd l, Layouts_Raw_Input.Agent_Contact r) := transform
			self 				:= l;
			self				:= r;
			self                := [];
			end; 
		
		joinBusAddrCont := join(joinBusCounty, Files_Raw_Input.AgentContact(fileDate),
								trim(left.Charter_Num,left,right) = trim(right.Charter_Num,left,right),
								MergeBusAddrCont(left,right),
								left outer);
	
							
								
		//Get the Contact_Cnty full name
	   Layouts_Raw_Input.BusinessAddCont getContCounty(Layouts_Raw_Input.BusinessAddCont input, CountyCodeLayout r) := transform
			self.contact_cnty_full  := if(trimUpper(r.CountyDesc)<>'CONVERSION',
											   trimUpper(r.CountyDesc),
											   '');																							
			self         			:= input;
			end; 
		
	   joinContCounty := 	join(joinBusAddrCont,CountyCodeTable,
								 trim(left.contact_cnty,left,right) = trim(right.CountyCode,left,right),
								 getContCounty(left,right),
								 left outer, lookup);
							
			
		
        MapBus2Corp := project(joinContCounty, OH_corp1Transform_Business(left)) ;
		
		corp2_mapping.Layout_CorpPreClean findtran(corp2_mapping.Layout_CorpPreClean input, TranCodeLayout r ) := transform
			self.corp_entity_desc       := r.TranDesc;
			self         			    := input;
			self                        := [];
		end; // end transform
		
				
		//State join
		joinTranType := 	join( MapBus2Corp,TranCodeTable,
									trim(left.corp_entity_desc,left,right) = trim(right.TranCode,left,right),
									findtran(left,right),
									left outer, lookup
								);	

		
			corp2_mapping.Layout_CorpPreClean AddressType1Code(corp2_mapping.Layout_CorpPreClean input, StateCodeLayout r ) := transform
			self.corp_address1_line4    := r.StateCode;
			self         			    := input;
			self                        := [];
		end; // end transform
		
		//Address join
		joinAddress1Type := 	join(joinTranType,StateCodeTable,
									trim(left.corp_address1_line4,left,right) = trim(right.StateCode,left,right),
									AddressType1Code(left,right),
									left outer, lookup
								);
								
		
			corp2_mapping.Layout_CorpPreClean AddressType2Code(corp2_mapping.Layout_CorpPreClean input, StateCodeLayout r ) := transform
			self.corp_address2_line4    := r.StateCode;
			self         			    := input;
			self                        := [];
		end; // end transform
		
		//Address join
		joinAddress2Type := 	join(joinAddress1Type,StateCodeTable,
									trim(left.corp_address2_line4,left,right) = trim(right.StateCode,left,right),
									AddressType2Code(left,right),
									left outer, lookup
								);
			 
		corp2_mapping.Layout_CorpPreClean findState(corp2_mapping.Layout_CorpPreClean input, StateCodeLayout r ) := transform
			self.corp_forgn_state_desc  := if(trimUpper(r.StateDesc)<>'OHIO',
											  trimUpper(r.StateDesc),
											  '');
			self         			    := input;
		end; // end transform
		
		//State join
		// joinStateType := 	join(	joinAddress2Type,StateCodeTable,
									// trim(left.corp_inc_state,left,right) = trim(right.StateCode,left,right),
									// findState(left,right),
									// left outer, lookup
								// );  replaced with following - pvs
								
		joinStateType := 	join(joinAddress2Type,StateCodeTable,
								if(trimUpper(left.corp_inc_state)<>'',
									trimUpper(left.corp_inc_state),
									trimUpper(left.corp_forgn_state_cd)) =
								    trimUpper(right.StateCode),
								findState(left,right),
								left outer, lookup
								);
								
		corp2_mapping.Layout_CorpPreClean findContState(corp2_mapping.Layout_CorpPreClean input, StateCodeLayout r ) := transform
			self.corp_ra_address_line4    := r.StateCode;
			self         			    := input;
			self                        := [];
		end; // end transform
		
		//Contact join
		joinContStateType := 	join(joinStateType,StateCodeTable,
									trim(left.corp_ra_address_line4, left,right) = trim(right.StateCode,left,right),
									findContState(left,right),
									left outer, lookup
								);
														
											
								
		// corp2_mapping.Layout_CorpPreClean findCounty(corp2_mapping.Layout_CorpPreClean input, CountyCodeLayout r ) := transform
			// self.corp_ra_address_line6  :=if (trim(r.CountyDesc,left,right) <> '',
												// 'AGENT COUNTY: '+ trim(r.CountyDesc,left,right),
												// ''
											  // );
			// self         			    := input;
			// self                        := [];
		// end; // end transform
		
			
		// CountyCode join
		// joinCountyType := 	join(	joinContStateType,CountyCodeTable,
									// trim(left.corp_ra_address_line6,left,right) = trim(right.CountyCode,left,right),
									// findCounty(left,right),
									// left outer, lookup
								// );	
								
							
		Layouts_Raw_Input.Bus_Old_Name MergeOldBus(Layouts_Raw_Input.Business l, Layouts_Raw_Input.Old_Name r ) := transform
			self 					:= l;
			self					:= r;
			self                    := [];
			
		end; // end transform
		
		joinBusOld := join(	Files_Raw_Input.BusinessFile(fileDate), Files_Raw_Input.OldName(fileDate),
								trim(left.Charter_Num,left,right) = trim(right.Charter_Num,left,right),
								MergeOldBus(left,right),
								left outer
							);					
		
        MapOldName2Corp := project(Files_Raw_Input.OldName(fileDate), OH_corp2Transform_OldName(left));
        AllCorp := joinContStateType + MapOldName2Corp;
		
        MapCorp := sort(AllCorp,corp_orig_sos_charter_nbr,-corp_inc_date);
		cleanCorps := project(MapCorp, CleanCorpNameAddr(left));

	VersionControl.macBuildNewLogicalFile('~thor_data400::in::corp2::'+version+'::corp_oh'	,cleanCorps																														,corp_out		,,,pOverwrite);		
	VersionControl.macBuildNewLogicalFile('~thor_data400::in::corp2::'+version+'::event_oh'	,MapEvent 																														,event_out	,,,pOverwrite);
	VersionControl.macBuildNewLogicalFile('~thor_data400::in::corp2::'+version+'::ar_oh'		,MapAR																																,ar_out			,,,pOverwrite);
	VersionControl.macBuildNewLogicalFile('~thor_data400::in::corp2::'+version+'::cont_oh'	,cleanCont																														,cont_out		,,,pOverwrite);
	VersionControl.macBuildNewLogicalFile('~thor_data400::in::corp2::'+version+'::stock_oh'	,MapStock																															,stock_out	,,,pOverwrite);
//	VersionControl.macBuildNewLogicalFile('~thor_data400::temp::corp2::busdoc'								,joinBusinessWithDocTrans(trim(charter_num,left,right) = 'RN164843')	,busdoc_out	,pOverwrite);
                                                                                 
		mappedOH_Filing := parallel(        
			 corp_out		
			,event_out	
			,ar_out			
			,cont_out		
			,stock_out	
//			,busdoc_out	

	 );
		

        result := 
				sequential(
					 if(pshouldspray = true,fSprayFiles('oh',filedate,pOverwrite := pOverwrite))
					,mappedOH_Filing 
					,parallel(
						fileservices.addsuperfile('~thor_data400::in::corp2::sprayed::corp'	,'~thor_data400::in::corp2::'+version+'::corp_oh'),				  
						fileservices.addsuperfile('~thor_data400::in::corp2::sprayed::cont'	,'~thor_data400::in::corp2::'+version+'::cont_oh'),						  
						fileservices.addsuperfile('~thor_data400::in::corp2::sprayed::ar'		,'~thor_data400::in::corp2::'+version+'::ar_oh'),
						fileservices.addsuperfile('~thor_data400::in::corp2::sprayed::event','~thor_data400::in::corp2::'+version+'::event_oh'),
						fileservices.addsuperfile('~thor_data400::in::corp2::sprayed::stock','~thor_data400::in::corp2::'+version+'::stock_oh')
					)	
				);//end 1st sequentialend
							
		return result;
	end;					 
	
end; // end of OH module