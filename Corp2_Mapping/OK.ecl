import Corp2, _validate, Address, lib_stringlib, ut, _control, versioncontrol;

export OK := MODULE;
	
	export Layouts_Raw_Input := MODULE;

		export Entity := record
			string2 	RECORD_HEADER;
			string10 	Filing_Number;
			string2 	Status_ID;
			string2 	Corp_Type_ID;
			string13 	Address_ID;
			string150 Name;
			string30 	Perpetual_Flag;
			string10 	Creation_Date;
			string10 	Expiration_Date;
			string10 	Inactive_Date;
			string10 	Formation_Date;
			string10 	Report_Due_Date;
			string16 	Tax_ID;
			string150 Fictitious_Name;
			string16 	Foreign_Fein;
			string4 	Foreign_State;
			string3 	Foreign_Country;
			string10 	Foreign_Formation_Date;
			string16 	Expiration_Type;
			string10 	Last_Report_Filed_Date;
			string25 	Telephone_Number;
			string2 	OTC_Suspension_Flag;
			string2 	Consent_Name_Flag;
			string2 	lf;
		end;

		export AddrLayout := record
			string2 	RECORD_HEADER;
			string13 	Address_ID;
			string50 	Address1;
			string50 	Address2;
			string64 	City;
			string4 	State;
			string9 	Zip_Code;
			string6 	Zip_Extension;
			string3 	Country;
			string1 	lf;
		end;

		export Agent := record
			string2 	RECORD_HEADER;
			string10 	Filing_Number;
			string13 	Address_ID;
			string150 Business_Name;
			string50 	Agent_Last_Name;
			string50 	Agent_First_Name;
			string50 	Agent_Middle_Name;
			string13 	Agent_Suffix_Id;
			string10 	Creation_Date;
			string10 	Inactive_Date;
			string150 Normalized_Name;
			string2 	SOS_RA_Flag;
			string1 	lf;
		end;

		export Officer := record
			string2 	RECORD_HEADER;
			string10 	Filing_Number;
			string6  	Officer_ID;
			string32	Officer_Title;
			string150 Business_Name;
			string50 	Officer_Last_Name;
			string50 	Officer_First_Name;
			string50 	Officer_Middle_Name;
			string6 	Officer_Suffix_ID;
			string13 	Address_ID;
			string10 	Creation_Date;
			string10 	Inactive_Date;
			string10  Last_Modified_Date;
			string150	Normalized_Name;
			string1 	lf;
		end;

		export Names := record
			string2 	RECORD_HEADER;
			string10 	Filing_Number;
			string6 	Name_ID;
			string150 Name;
			string30 	Name_Status_ID;
			string3 	Name_Type_ID;
			string10 	Creation_Date;
			string10 	Inactive_Date;
			string10 	Expire_Date;
			string10 	All_Counties_Flag;
			string12 	Consent_Filing_Number;
			string2 	Search_ID;
			string10  Transfer_To;
			string10	Received_From;
			string2 	lf;
		end;

		export AssocEntity := record
			string2 	RECORD_HEADER;
			string10 	Filing_Number;
			string13 	Document_Number;
			string6  	Associated_Entity_ID;
			string6  	Assoc_Ent_Corp_Type_ID;
			string4  	Primary_Capacity_ID;
			string4  	Capacity_ID;
			string150	Associated_Entity_Name;
			string12  Entity_Filing_Number;
			string10  Entity_Filing_Date;
			string10  Inactive_Date;
			string10  Jurisdiction_State;
			string3  	Jurisdiction_Country;
			string1 	lf;
		end;

		export StockData := record
			string2 	RECORD_HEADER;
			string13  Stock_ID;
			string13  Filing_Number;
			string13  Stock_Type_ID;
			string256 Stock_Series;
			string40  Share_Volume;
			string40  Par_Value;
			string1   lf;
		end;

		export StockInfo := record
			string2 	RECORD_HEADER;
			string13	Filing_Number;
			string1		Qualify_Flag;
			string1		Unlimited_Flag;
			string40	Actual_Amt_Invested;
			string40	Pd_On_Credit;
			string40	Tot_Auth_Capital;
			string1		lf;
		end;

		export StockType := record
			string2 	RECORD_HEADER;
			string13 	Stock_Type_ID;
			string64 	Stock_Type_Desc;
			string1 	lf;
		end;

		export FilingType := record
			string2 	RECORD_HEADER;
			string13	Filing_Type_ID;
			string96	Filing_Type;
			string1 	lf;
		end;

		export CorpStatus := record
			string2 	RECORD_HEADER;
			string13	Status_ID;
			string24	Status_Desc;
			string1 	lf;
		end;

		export CorpType := record
			string2 	RECORD_HEADER;
			string13	Corp_Type_ID;
			string80	Corp_Type_Desc;
			string1 	lf;
		end;

		export NameStatus := record
			string2 	RECORD_HEADER;
			string13	Name_Status_ID;
			string80	Name_Status;
			string1 	lf;
		end;

		export NameType := record
			string2 	RECORD_HEADER;
			string13	Name_Type_ID;
			string16	Name_Type;
			string1 	lf;
		end;

		export Capacity := record
			string2 	RECORD_HEADER;
			string13	Capacity_ID;
			string50	Description;
			string1 	lf;
		end;

		export Suffix := record
			string2 	RECORD_HEADER;
			string13	Suffix_ID;
			string50	Suffix;
			string1 	lf;
		end;

		export CorpFiling := record
			string2 	RECORD_HEADER;
			string10	Filing_Number;  
			string12	Document_Number;
			string12	Filing_Type_ID;
			string96	Filing_Type;
			string10	Entry_Date;  
			string10	Filing_Date;
			string10	Effective_Date;
			string2		Effective_Condition_Flag;
			string10	Inactive_Date;
			string1 	lf;
		end;

		export AuditLog := record
			string2 	RECORD_HEADER;
			string10	Reference_Number;  
			string10	Audit_Date;
			string4		Table_ID;
			string4		Field_ID;
			string300	Previous_Value;  
			string300	Current_Value;
			string10	Action;
			string256	Audit_Comment;
			string1 	lf;
		end;
	end;

	export Files_Raw_Input := MODULE;
	    		
		export VendorEntity(string filedate) 			:= dataset('~thor_data400::in::corp2::'+filedate+'::Entity::ok',layouts_Raw_Input.Entity,flat);
		
		export VendorAddress(string filedate) 		:= dataset('~thor_data400::in::corp2::'+filedate+'::Address::ok',layouts_Raw_Input.AddrLayout,flat);
		
		export VendorAgent(string filedate) 			:= dataset('~thor_data400::in::corp2::'+filedate+'::Agent::ok',layouts_Raw_Input.Agent,flat);
		
		export VendorOfficer(string filedate) 		:= dataset('~thor_data400::in::corp2::'+filedate+'::Officer::ok',layouts_Raw_Input.Officer,flat);
		
		export VendorNames(string filedate) 			:= dataset('~thor_data400::in::corp2::'+filedate+'::Names::ok',layouts_Raw_Input.Names,flat);
		
		export VendorAssocEntity(string filedate) := dataset('~thor_data400::in::corp2::'+filedate+'::AssocEntity::ok',layouts_Raw_Input.AssocEntity,flat);
		
		export VendorStockData(string filedate) 	:= dataset('~thor_data400::in::corp2::'+filedate+'::StockData::ok',layouts_Raw_Input.StockData,flat);
		
		export VendorStockInfo(string filedate) 	:= dataset('~thor_data400::in::corp2::'+filedate+'::StockInfo::ok',layouts_Raw_Input.StockInfo,flat);
		
		export VendorCorpFiling(string filedate) 	:= dataset('~thor_data400::in::corp2::'+filedate+'::CorpFiling::ok',layouts_Raw_Input.CorpFiling,flat);
		
		export VendorStockType(string filedate) 	:= dataset('~thor_data400::in::corp2::'+filedate+'::StockType::ok',layouts_Raw_Input.StockType,flat);
		
		export VendorFilingType(string filedate) 	:= dataset('~thor_data400::in::corp2::'+filedate+'::FilingType::ok',layouts_Raw_Input.FilingType,flat);
		
		export VendorCorpStatus(string filedate) 	:= dataset('~thor_data400::in::corp2::'+filedate+'::CorpStatus::ok',layouts_Raw_Input.CorpStatus,flat);
		
		export VendorNameStatus(string filedate) 	:= dataset('~thor_data400::in::corp2::'+filedate+'::NameStatus::ok',layouts_Raw_Input.NameStatus,flat);
		
		export VendorNameType(string filedate) 		:= dataset('~thor_data400::in::corp2::'+filedate+'::NameType::ok',layouts_Raw_Input.NameType,flat);
		
		export VendorCapacity(string filedate) 		:= dataset('~thor_data400::in::corp2::'+filedate+'::Capacity::ok',layouts_Raw_Input.Capacity,flat);
		
		export VendorSuffix(string filedate) 			:= dataset('~thor_data400::in::corp2::'+filedate+'::Suffix::ok',layouts_Raw_Input.Suffix,flat);
		
		export VendorCorpType(string filedate) 		:= dataset('~thor_data400::in::corp2::'+filedate+'::CorpType::ok',layouts_Raw_Input.CorpType,flat);
		
		export VendorAuditLog(string filedate) 		:= dataset('~thor_data400::in::corp2::'+filedate+'::AuditLog::ok',layouts_Raw_Input.AuditLog,flat);		
		
		
	end;
	
	export Update(string fileDate, string version, boolean pShouldSpray = _Dataset().bShouldSpray, boolean pOverwrite = false) := function

		EntityLookups := record
			string10 	Filing_Number;
			string2 	Status_ID;
			string24	Status_Desc;		
			string2 	Corp_Type_ID;
			string80	Corp_Type_Desc;
			string13 	Address_ID;
			string150 Name;
			string14 	Perpetual_Flag;
			string10 	Creation_Date;
			string10 	Expiration_Date;
			string10 	Inactive_Date;
			string10 	Formation_Date;
			string10 	Report_Due_Date;
			string4 	Foreign_State;
			string30	ForgnStateDesc;
			string3 	Foreign_Country;
			string44	ForgnCountryDesc;
			string10 	Foreign_Formation_Date;
			string16 	Expiration_Type;
			string10 	Last_Report_Filed_Date;
		end;
		
		AddressLookups := record
			string13 	Address_ID;
			string50 	Address1;
			string50 	Address2;
			string64 	City;
			string4 	State;
			string9 	Zip_Code;
			string6 	Zip_Extension;
			string3 	Country;
			string44	CountryDesc;
		end;
		
		AgentLookups := record
			string10 	Filing_Number;
			string13 	Address_ID;
			string150 Business_Name;
			string50 	Agent_Last_Name;
			string50 	Agent_First_Name;
			string50 	Agent_Middle_Name;
			string13 	Agent_Suffix_Id;
			string50  Agent_Suffix;
			string10 	Creation_Date;
			string10 	Inactive_Date;
		end;
		
			
		//--------------------  Status code explosion ------------------
		
		EntityLookups findStatusCode(layouts_raw_input.Entity input, layouts_raw_input.CorpStatus r ) := transform
			self.Status_Desc	:= r.Status_Desc;
			self         		  := input;
			self              := [];
		end; 
	
		PopStatus := join(	Files_Raw_Input.VendorEntity(fileDate), Files_Raw_Input.VendorCorpSTatus(fileDate),
												trim(left.status_ID,left,right) = trim(right.Status_ID,left,right),
												findStatusCode(left,right),
												left outer, lookup
											);
											
		//--------------------  Corp Type code explosion ------------------	
		
		EntityLookups findCorpTypeCode(EntityLookups input, layouts_raw_input.CorpType r ) := transform
			self.Corp_Type_Desc	:= r.Corp_Type_Desc;
			self         		  	:= input;
		end; 
	
		PopCorpType := join(	PopStatus, Files_Raw_Input.VendorCorpType(fileDate),
													trim(left.Corp_Type_ID,left,right) = trim(right.Corp_Type_ID,left,right),
													findCorpTypeCode(left,right),
													left outer, lookup
												);	
												
		//--------------------  State code explosion ---------------------
		
		StateCodeLayout := record
			string	StateCode;
			string	StateDesc;
		end;
		
		StateTable := dataset(_dataset().foreign_prod + 'thor_data400::lookup::corp2::StateCodeTable', StateCodeLayout, CSV(SEPARATOR([',']), TERMINATOR(['\r\n', '\n'])));
		
		EntityLookups findStateCode(EntityLookups input, StateCodeLayout r ) := transform
			self.forgnStateDesc   		:= r.StateDesc;
			self         		  				:= input;
		end;
	
		PopforgnStateDesc := join(	PopCorpType, StateTable,
																trim(left.Foreign_State,left,right) = right.StateCode,	
																findStateCode(left,right),
																left outer, lookup
															);	
									
		//--------------------  Country code explosion -------------------
		
		CountryCodeLayout := record
			string		CountryCode;
			string		CountryDesc;
		end;
		
		CountryTable := dataset(_dataset().foreign_prod + 'thor_data400::lookup::corp2::CountryCodeTable', CountryCodeLayout, CSV(SEPARATOR([',']), TERMINATOR(['\r\n', '\n'])));
		
		EntityLookups findCountryCode(EntityLookups input, CountryCodeLayout r ) := transform
			self.forgnCountryDesc   := r.CountryDesc;
			self         		  			:= input;
		end;
	
		PopforgnCountryDesc := join(PopforgnStateDesc, CountryTable,
																trim(left.Foreign_Country,left,right) = right.CountryCode,
																findCountryCode(left,right),
																left outer, lookup
															 );	
															 
		//------------------- populate country code in address record ----------------
															 
		AddressLookups findCtryCode(layouts_raw_input.AddrLayout input, CountryCodeLayout r ) := transform
			self.CountryDesc	:= r.CountryDesc;
			self         		  := input;
		end; 
	
		PopAddrCtry := join(Files_Raw_Input.VendorAddress(fileDate), CountryTable,
												trim(left.Country,left,right) = right.CountryCode,
												findCtryCode(left,right),
												left outer, lookup
											);	
											
		//------------------ Populate Suffix ID in Agent file									
											
		AgentLookups findSuffixCode(layouts_raw_input.Agent input, layouts_raw_input.Suffix r ) := transform
			self.Agent_Suffix	:= r.Suffix;
			self         		  := input;
		end; 
	
		PopAgentSuffix := join(Files_Raw_Input.VendorAgent(fileDate), Files_Raw_Input.VendorSuffix(fileDate),
												trim(left.Agent_Suffix_ID,left,right) = right.Suffix_ID,
												findSuffixCode(left,right),
												left outer, lookup
											);												
															 
		//----------------  Merge Entity With Agent --------------------
		
		EntityWithAgent := record
			EntityLookups;
			string13 	Agent_Address_ID;
			string150 Business_Name;
			string50 	Agent_Last_Name;
			string50 	Agent_First_Name;
			string50 	Agent_Middle_Name;
			string13 	Agent_Suffix_Id;
			string50  Agent_Suffix;
			string10 	Agent_Creation_Date;
			string10 	Agent_Inactive_Date;
		end;		

		EntityWithAgent MergeEntityAgent(EntityLookups l, AgentLookups r ) := transform
			self.Agent_Address_ID			:= r.Address_ID;
			self.Agent_Creation_Date	:= r.Creation_Date;
			self.Agent_Inactive_Date	:= r.Inactive_Date;
			self											:= l;
			self											:= r;
		end; 
		
		joinEntityAgent := join( 	PopforgnCountryDesc, PopAgentSuffix,
															trim(left.Filing_Number,left,right) = trim(right.Filing_Number,left,right),
															MergeEntityAgent(left,right),
															left outer
														);	
														

		//----------------  Merge To Get Corp Address --------------------
		
		EntityWithAddress := record
			EntityWithAgent; 
			string50 	Address1;
			string50 	Address2;
			string64 	City;
			string4 	State;
			string9 	Zip_Code;
			string6 	Zip_Extension;
			string3 	Country;
			string44  CountryDesc;
		end;

		EntityWithAddress MergeEntityAddress(EntityWithAgent l, AddressLookups r ) := transform
			self											:= l;
			self											:= r;
		end; 
		
		joinEntityAddress := join( 	joinEntityAgent, PopAddrCtry,
																trim(left.Address_ID,left,right) = trim(right.Address_ID,left,right),
																MergeEntityAddress(left,right),
																left outer
															);														

		//----------------  Merge To Get RA Address --------------------
		
		AgentWithAddress := record
			EntityWithAddress;
			string50 	Agent_Address1;
			string50 	Agent_Address2;
			string64 	Agent_City;
			string4 	Agent_State;
			string9 	Agent_Zip_Code;
			string6 	Agent_Zip_Extension;
			string3 	Agent_Country;
			string44  Agent_CountryDesc;
		end;

		AgentWithAddress MergeAgentAddress(EntityWithAddress l, AddressLookups r ) := transform
			self.Agent_Address1				:= r.Address1;
			self.Agent_Address2				:= r.Address2;
			self.Agent_City						:= r.City;
			self.Agent_State					:= r.State;
			self.Agent_Zip_Code				:= r.Zip_Code;
			self.Agent_Zip_Extension	:= r.Zip_Extension;
			self.Agent_Country				:= r.Country;
			self.Agent_CountryDesc		:= r.CountryDesc;
			self											:= l;
			self											:= r;
		end; 
		
		joinAgentAddress := join( 	joinEntityAddress, PopAddrCtry,
																trim(left.Agent_Address_ID,left,right) = trim(right.Address_ID,left,right),
																MergeAgentAddress(left,right),
																left outer
															);
															
		trimUpper(string s) := function
			return trim(stringlib.StringToUppercase(s),left,right);
		end;
			
		reformatDate2(string inDate) := function
			string8 clean_inDate := trim(regexreplace('/',inDate,''),left,right);
			string8 newDate := clean_inDate[5..8] + clean_inDate[1..2] + clean_inDate[3..4];
			return newDate;	
		end;			

		corp2_mapping.Layout_CorpPreClean corpLegalTransform(AgentWithAddress input) := transform

			self.dt_first_seen							:= fileDate;
			self.dt_last_seen								:= fileDate;
			self.dt_vendor_first_reported		:= fileDate;
			self.dt_vendor_last_reported		:= fileDate;
			self.corp_ra_dt_first_seen			:= fileDate;
			self.corp_ra_dt_last_seen				:= fileDate;			
			self.corp_key										:= '40-' + trimUpper(input.Filing_Number);
			self.corp_vendor								:= '40';
			self.corp_state_origin					:= 'OK';
			self.corp_process_date					:= fileDate;
			self.corp_orig_sos_charter_nbr	:= trimUpper(input.Filing_Number);
			self.corp_src_type							:= 'SOS';	
			
			self.corp_status_cd							:= if (input.Status_Desc <> '',
																								input.Status_ID,
																								''
																						 );
			self.corp_status_desc						:= trimUpper(input.Status_Desc);	
			
			StatusDate											:= reformatDate2(input.Inactive_Date	);

		
			self.corp_status_date						:= if(	_validate.date.fIsValid(statusDate) and
																							_validate.date.fIsValid(statusDate,_validate.date.rules.DateInPast),
																								statusDate,
																								''
																						); 
																						
			self.corp_orig_org_structure_cd	:= if (input.Corp_Type_Desc <> '',
																								input.Corp_Type_ID,
																								''
																						 );	
																						 
      self.corp_orig_org_structure_desc :=	trimUpper(input.Corp_Type_Desc);
			
			ExpirationDate									:= reformatDate2(input.Expiration_Date);	
			CleanExpireType									:= trimUpper((string)(integer)input.Expiration_Type);
			
			CleanTermExistCode							:= if (	trimUpper(input.Perpetual_Flag) = '1',
																									'P',
																									if(	_validate.date.fIsValid(ExpirationDate),
																												'D',
																												if (	CleanExpireType <> '0' and CleanExpireType <> 'P',
																																'N',
																																''
																														)
																											)
																							);
																							
			self.corp_term_exist_cd 				:= CleanTermExistCode;
			
			self.corp_term_exist_exp				:= if (CleanTermExistCode = 'D',
																								ExpirationDate,
																								''
																						 );
																						 
			self.corp_term_exist_desc				:= if (CleanTermExistCode = 'N',
																								CleanExpireType,
																								if (CleanTermExistCode = 'P',
																											'PERPETUAL',
																											''
																										)
																						 );
	
			CreationDate										:= reformatDate2(input.Creation_Date);
			FormationDate										:= reformatDate2(input.Formation_Date);
			
			self.corp_filing_date						:= if(	_validate.date.fIsValid(CreationDate) and
																							_validate.date.fIsValid(CreationDate,_validate.date.rules.DateInPast),
																								CreationDate,
																								if(	_validate.date.fIsValid(FormationDate) and
																										_validate.date.fIsValid(FormationDate,_validate.date.rules.DateInPast),
																												FormationDate,
																												''
																									)
																						);
																						
			self.corp_filing_cd							:= if(	_validate.date.fIsValid(CreationDate) and
																							_validate.date.fIsValid(CreationDate,_validate.date.rules.DateInPast),
																								'C',
																								''
																					  );
																						
			self.corp_filing_desc						:= if(	_validate.date.fIsValid(CreationDate) and
																							_validate.date.fIsValid(CreationDate,_validate.date.rules.DateInPast),
																								'CREATION',
																								if(	_validate.date.fIsValid(FormationDate) and
																										_validate.date.fIsValid(FormationDate,_validate.date.rules.DateInPast),
																												'FORMED',
																												''
																									)
																						);
								
								   
			self.corp_inc_state							:= if(trimUpper(input.Foreign_State) = 'OK' or 
																						trimUpper(input.Foreign_State) = '',
			                                          'OK',
																								''
																						);
												   
			self.corp_forgn_state_cd        := if(	trimUpper(input.Foreign_State) <> 'OK' and 
																							trimUpper(input.Foreign_State) <> '',
																								if(trim(input.forgnStateDesc,left,right) <> '',
																											trimUpper(input.Foreign_State),
																											trimUpper(input.Foreign_Country)
																									 ),
																								''
																						);
													  
			self.corp_forgn_state_desc      := if(	trimUpper(input.Foreign_State) <> 'OK' and 
																							trimUpper(input.Foreign_State) <> '',
																								if(trim(input.forgnStateDesc,left,right) <> '',
																											trimUpper(input.forgnStateDesc),
																											if (trimUpper(input.forgnCountryDesc)<>'',
																														trimUpper(input.forgnCountryDesc),
																														if(trimUpper(input.Foreign_Country) <> 'USA',
																																trimUpper(input.Foreign_Country),
																																''
																															)
																													)
																										),
																								''
																						);
																						
																						
													 
		            													   
			self.corp_legal_name						:= trimUpper(input.Name); 														
			self.corp_ln_name_type_cd				:= '01';
			self.corp_ln_name_type_desc			:= 'LEGAL';
							  
			self.corp_address1_line1 				:= trimUpper(input.Address1);
			self.corp_address1_line2				:= trimUpper(input.Address2);
			self.corp_address1_line3				:= trimUpper(input.City);
			self.corp_address1_line4				:= trimUpper(input.State);
			self.corp_address1_line5				:= if ((string)(integer) input.Zip_Code <> '0' and length(trim(input.Zip_Code,left,right)) = 5,
																								if((string)(integer) input.Zip_Extension <> '0' and length(trim(input.Zip_Extension,left,right)) = 4,
																											trim(trim(input.Zip_Code,left,right) + trim(input.Zip_Extension,left,right),left,right),
																											input.Zip_Code
																									 ),
																								''
																							);
			self.corp_address1_line6				:= trimUpper(input.CountryDesc);

													  
			self.corp_address1_type_cd			:= if(	trim(input.address1,left,right) <> '' or 
																							trim(input.address2,left,right) <> '' or
																							trim(input.city,left,right) <> '' or 
																							trim(input.state,left,right) <>'' or 
																							trim(input.zip_code,left,right) <> '' or
																							trim(input.countryDesc,left,right) <> '',
																								'M',
																								''
																						);

													  
		  self.corp_address1_type_desc	:= if(	trim(input.address1,left,right) <> '' or 
																							trim(input.address2,left,right) <> '' or
																							trim(input.city,left,right) <> '' or 
																							trim(input.state,left,right) <>'' or 
																							trim(input.zip_code,left,right) <> '' or
																							trim(input.countryDesc,left,right) <> '',
																								'MAILING',
																								''
																						);													  
			self.corp_ra_name							:= if (	trimUpper(input.Business_Name) <> '',
																							trimUpper(input.Business_Name),
																							trim((trimUpper(input.Agent_First_Name) + ' ' +
																										trimUpper(input.Agent_Middle_Name) + ' ' +
																										trimUpper(input.Agent_Last_Name) + ' ' +
																										trimUpper(input.Agent_Suffix)),
																										left,right
																									)
																					);

			RACreationDate								:= reformatDate2(input.Agent_Creation_Date);
			self.corp_ra_effective_date		:= if(	_validate.date.fIsValid(RACreationDate) and
																						_validate.date.fIsValid(RACreationDate,_validate.date.rules.DateInPast),
																							RACreationDate,
																							''
																					);
																					
			RAInactiveDate								:= reformatDate2(input.Agent_Inactive_Date);
			self.corp_ra_addl_info				:= if(	_validate.date.fIsValid(RAInactiveDate),
																							'INACTIVE DATE: ' + RAInactiveDate,
																							''
																					);
														
			self.corp_ra_address_line1 		:= trimUpper(input.Agent_Address1);
			self.corp_ra_address_line2		:= trimUpper(input.Agent_Address2);
			self.corp_ra_address_line3		:= trimUpper(input.Agent_City);
			self.corp_ra_address_line4		:= trimUpper(input.Agent_State);
			self.corp_ra_address_line5		:= if ((string)(integer) input.Agent_Zip_Code <> '0' and length(trim(input.Agent_Zip_Code,left,right)) = 5,
																						if((string)(integer) input.Agent_Zip_Extension <> '0' and length(trim(input.Agent_Zip_Extension,left,right)) = 4,
																									trim(trim(input.Agent_Zip_Code,left,right) + trim(input.Agent_Zip_Extension,left,right),left,right),
																									input.Agent_Zip_Code
																							 ),
																						''
																					);
			self.corp_ra_address_line6		:= trimUpper(input.Agent_CountryDesc);	
			self.corp_ra_address_type_cd	:= if(	trim(input.Agent_address1,left,right) <> '' or 
																						trim(input.Agent_address2,left,right) <> '' or
																						trim(input.Agent_city,left,right) <> '' or 
																						trim(input.Agent_state,left,right) <>'' or 
																						trim(input.Agent_zip_code,left,right) <> '' or
																						trim(input.Agent_countryDesc,left,right) <> '',
																							'A',
																							''
																					);

													  
		  self.corp_ra_address_type_desc:= if(	trim(input.Agent_address1,left,right) <> '' or 
																						trim(input.Agent_address2,left,right) <> '' or
																						trim(input.Agent_city,left,right) <> '' or 
																						trim(input.Agent_state,left,right) <>'' or 
																						trim(input.Agent_zip_code,left,right) <> '' or
																						trim(input.Agent_countryDesc,left,right) <> '',
																							'REGISTERED AGENT',
																							''
																					);														
									
			self 													:= [];
						
		end; 
		
		//------------------ Populate Name Status in Names file	----------------------
		
		NamesLookups := record
			string10 	Filing_Number;
			string150 Name;
			string14 	Name_Status_ID;
			string3 	Name_Type_ID;
			string80	Name_Status;
		end;
											
		NamesLookups findNameStatusCode(layouts_raw_input.Names input, layouts_raw_input.NameStatus r ) := transform
			self.Name_Status	:= r.Name_Status;
			self         		  := input;
		end; 
	
		PopNameStatus := join(Files_Raw_Input.VendorNames(fileDate), Files_Raw_Input.VendorNameStatus(fileDate),
													trim(left.Name_Status_ID,left,right) = right.Name_Status_ID,
													findNameStatusCode(left,right),
													left outer, lookup
												);			
		
	corp2_mapping.Layout_CorpPreClean corpNonLegalTransform(NamesLookups input) := transform,skip(trim(input.Name_Type_ID,left,right) = '1')

			self.dt_first_seen							:= fileDate;
			self.dt_last_seen								:= fileDate;
			self.dt_vendor_first_reported		:= fileDate;
			self.dt_vendor_last_reported		:= fileDate;
			self.corp_ra_dt_first_seen			:= fileDate;
			self.corp_ra_dt_last_seen				:= fileDate;			
			self.corp_key										:= '40-' + trimUpper(input.Filing_Number);
			self.corp_vendor								:= '40';
			self.corp_state_origin					:= 'OK';
			self.corp_process_date					:= fileDate;
			self.corp_orig_sos_charter_nbr	:= trimUpper(input.Filing_Number);
			self.corp_src_type							:= 'SOS';	
			
			self.corp_legal_name						:= trimUpper(input.Name);
			self.corp_ln_name_type_cd				:= map(	trim(input.Name_Type_ID,left,right) = '2' => 'F',
																							trim(input.Name_Type_ID,left,right) = '3' => '04',
																							trim(input.Name_Type_ID,left,right) = '4' => 'I',
																							trim(input.Name_Type_ID,left,right) = '5' => '07',
																							''
																						 );
			self.corp_ln_name_type_desc			:= map(	trim(input.Name_Type_ID,left,right) = '2' => 'FBN',
																							trim(input.Name_Type_ID,left,right) = '3' => 'TRADENAME',
																							trim(input.Name_Type_ID,left,right) = '4' => 'OTHER',
																							trim(input.Name_Type_ID,left,right) = '5' => 'RESERVED',
																							''
																						 );
																						 
      self.corp_name_comment					:= if(trim(input.Name_Status,left,right)<>'',
																							'NAME STATUS: ' + trimUpper(input.Name_Status),
																							''
																						);
																						 
			self 														:= [];
						
		end; 																						 
	
		//------------------ Populate Capacity Id in Associated Entities file	----------------------
		
		AssocEntityLookups := record
			string10 	Filing_Number;
			string4  	Primary_Capacity_ID;
			string150	Associated_Entity_Name;
			string12  Entity_Filing_Number;
			string50  CapacityDesc;
		end;
											
		AssocEntityLookups findCapacityCode(layouts_raw_input.AssocEntity input, layouts_raw_input.Capacity r ) := transform
			self.CapacityDesc	:= r.Description;
			self         		  := input;
		end; 
	
		PopCapacity 	:= join(Files_Raw_Input.VendorAssocEntity(fileDate), Files_Raw_Input.VendorCapacity(fileDate),
													trim(left.Primary_Capacity_ID,left,right) = right.Capacity_ID,
													findCapacityCode(left,right),
													left outer, lookup
													);			
		
	corp2_mapping.Layout_CorpPreClean corpAssocEntityTransform(AssocEntityLookups input) := transform

			self.dt_first_seen							:= fileDate;
			self.dt_last_seen								:= fileDate;
			self.dt_vendor_first_reported		:= fileDate;
			self.dt_vendor_last_reported		:= fileDate;
			self.corp_ra_dt_first_seen			:= fileDate;
			self.corp_ra_dt_last_seen				:= fileDate;			
			self.corp_key										:= '40-' + trimUpper(input.Filing_Number);
			self.corp_vendor								:= '40';
			self.corp_state_origin					:= 'OK';
			self.corp_process_date					:= fileDate;
			self.corp_orig_sos_charter_nbr	:= trimUpper(input.Filing_Number);
			self.corp_src_type							:= 'SOS';	
			
			self.corp_legal_name						:= trimUpper(input.Associated_Entity_Name);

			self.corp_ln_name_type_desc			:= trimUpper(input.CapacityDesc);
																																											 
      self.corp_name_comment					:= if(trim(input.Entity_Filing_Number,left,right)<>'',
																							'ASSOCIATED ENTITY FILING NUMBER: ' + trimUpper(input.Entity_Filing_Number),
																							''
																						);
																						 
			self 														:= [];
						
		end; 	
		
		//------------------ Populate Stock Type ID in Stock Data file	----------------------
		
		StockLookups := record
			string13  Filing_Number;
			string13  Stock_Type_ID;
			string256 Stock_Series;
			string40  Share_Volume;
			string40  Par_Value;
			string64	StockTypeDesc;
		end;
											
		StockLookups findStockTypeCode(layouts_raw_input.StockData input, layouts_raw_input.StockType r ) := transform
			self.StockTypeDesc	:= r.Stock_Type_Desc;
			self         		  	:= input;
		end; 
	
		PopStockType 	:= join(Files_Raw_Input.VendorStockData(fileDate), Files_Raw_Input.VendorStockType(fileDate),
													trim(left.Stock_Type_ID,left,right) = right.Stock_Type_ID,
													findStockTypeCode(left,right),
													left outer, lookup
													);
													
		Corp2.Layout_Corporate_Direct_Stock_In StockTransform(StockLookups input):=transform

			self.corp_key										:= '40-' + trimUpper(input.Filing_Number);	
			self.corp_vendor								:= '40';		
		
			self.corp_state_origin					:= 'OK';
			self.corp_process_date					:= fileDate;

			self.corp_sos_charter_nbr				:= trimUpper(input.Filing_Number);	
		
	
			self.stock_type									:= trimUpper(input.StockTypeDesc);
			self.stock_class								:= if(trimUpper(input.Stock_Series) <> 'NONE',
																							trimUpper(input.Stock_Series),
																							''
																						);
			self.stock_authorized_nbr				:= input.Share_Volume;
			
			self.stock_par_value						:= regexreplace('^[.]',input.Par_Value,'0.',NOCASE);

			self														:=[];

		end;
		
		//------------------ Populate Filing Type in Filing file	----------------------
		
		EventLookups := record
			string10	Filing_Number;  
			string12	Document_Number;
			string12	Filing_Type_ID;
			string10	Filing_Date;
			string10	Effective_Date;
			string10	Inactive_Date;
			string96  FilingTypeDesc;
		end;
											
		EventLookups findFilingTypeCode(layouts_raw_input.CorpFiling input, layouts_raw_input.FilingType r ) := transform
			self.FilingTypeDesc	:= r.Filing_Type;
			self         		  	:= input;
		end; 
	
		PopFilingType 	:= join(Files_Raw_Input.VendorCorpFiling(fileDate), Files_Raw_Input.VendorFilingType(fileDate),
														trim(left.Filing_Type_ID,left,right) = right.Filing_Type_ID,
														findFilingTypeCode(left,right),
														left outer, lookup
														);
		
		Corp2.Layout_Corporate_Direct_Event_In EventTransform(EventLookups input):=transform,skip(input.Filing_Type_ID='28040' or
																																															input.Filing_Type_ID='23040' or
																																															input.Filing_Type_ID='19040' or
																																															input.Filing_Type_ID='20040' or
																																															input.Filing_Type_ID='21040' or
																																															input.Filing_Type_ID='22040' or
																																															input.Filing_Type_ID='24040' or
																																															input.Filing_Type_ID='25040' or
																																															input.Filing_Type_ID='26040' or 
																																															input.Filing_Type_ID='27040' or
																																															input.Filing_Type_ID='30040' or 
																																															input.Filing_Type_ID='29040' or
																																															input.Filing_Type_ID='31040' or
																																															input.Filing_Type_ID='33040' or
																																															input.Filing_Type_ID='32040' or
																																															input.Filing_Type_ID='34040' or
																																															input.Filing_Type_ID='52040' )
																																												
																								
			self.corp_key										:= '40-' + trimUpper(input.Filing_Number);	
			self.corp_vendor								:= '40';		
		
			self.corp_state_origin					:= 'OK';
			self.corp_process_date					:= fileDate;

			self.corp_sos_charter_nbr				:= trimUpper(input.Filing_Number);
			
			self.event_filing_reference_nbr := trimUpper(input.Document_Number);
			
			self.event_filing_cd						:= if( trimUpper(input.FilingTypeDesc) <>'',
																							trimUpper(input.Filing_Type_ID),
																							''
																						);
			self.event_filing_desc					:= trimUpper(input.FilingTypeDesc);
			
			eventFilingDate									:= reformatDate2(input.Filing_Date);

			self.event_filing_date					:= if ( eventFilingDate <> '' and
																							_validate.date.fIsValid(eventFilingDate) and
																							_validate.date.fIsValid(eventFilingDate,_validate.date.rules.DateInPast),
																								eventFilingDate,
																								''
																						);  
														
			self.event_date_type_cd					:= if (	eventFilingDate <> '' and
																							_validate.date.fIsValid(eventFilingDate) and
																							_validate.date.fIsValid(eventFilingDate,_validate.date.rules.DateInPast),
																								'FIL',
																								''
																						 );
			
			self.event_date_type_desc				:= if (	eventFilingDate <> '' and
																							_validate.date.fIsValid(eventFilingDate) and
																							_validate.date.fIsValid(eventFilingDate,_validate.date.rules.DateInPast),
																								'FILING',
																								''
																						);
			
			self														:=[];

		end;	
		
		EntityWithStockInfo := record
			string13	Filing_Number;
			string10 	Report_Due_Date;
			string10 	Last_Report_Filed_Date;
			string40	Actual_Amt_Invested;
			string40	Tot_Auth_Capital;
		end;
		
		EntityWithStockInfo MergeEntityStockInfo(Layouts_Raw_Input.Entity l, Layouts_Raw_Input.StockInfo r ) := transform
			self					:= l;
			self					:= r;
		end; 
	
		joinEntityWithStock := join( 	Files_Raw_Input.VendorEntity(fileDate), Files_Raw_Input.VendorStockInfo(fileDate),
																	trim(left.Filing_Number,left,right) = right.Filing_Number,
																	MergeEntityStockInfo(left,right),
																	left outer
																);
																
		Corp2.Layout_Corporate_Direct_AR_In ARTransform1(EntityWithStockInfo  input):=transform
		
			self.corp_key										:= '40-' + trimUpper(input.Filing_Number);	
			self.corp_vendor								:= '40';		
		
			self.corp_state_origin					:= 'OK';
			self.corp_process_date					:= fileDate;

			self.corp_sos_charter_nbr				:= trimUpper(input.Filing_Number);

			arDueDate												:= reformatDate2(input.Report_Due_Date);

			self.ar_due_dt									:= if ( _validate.date.fIsValid(arDueDate),
																								arDueDate,
																								''
																						);
																						
			arFiledDate											:= reformatDate2(input.Last_Report_Filed_Date);
			
			self.ar_filed_dt								:= if ( _validate.date.fIsValid(arFiledDate),
																								arFiledDate,
																								''
																						);
																						
			AmtWithCommas										:= (string)ut.IntWithCommas((integer)input.Actual_Amt_Invested);
																						
			self.ar_comment									:= if (	trim(AmtWithCommas,left,right)<> '' and
																							(string)(integer)AmtWithCommas <> '0',
																								'INVESTED CAPITAL IN OKLAHOMA: $' + AmtWithCommas,
																								''
																						);
			
			self.ar_annual_report_cap				:= input.Tot_Auth_Capital;

			self														:=[];

		end;
		
		Corp2.Layout_Corporate_Direct_AR_In ARTransform2(EventLookups  input):=transform,skip(input.Filing_Type_ID='28040' or
																																													input.Filing_Type_ID='23040' or
																																													input.Filing_Type_ID='19040' or
																																													input.Filing_Type_ID='20040' or
																																													input.Filing_Type_ID='21040' or
																																													input.Filing_Type_ID='22040' or
																																													input.Filing_Type_ID='24040' or
																																													input.Filing_Type_ID='25040' or
																																													input.Filing_Type_ID='26040' or 
																																													input.Filing_Type_ID='27040' or
																																													input.Filing_Type_ID='30040' or 
																																													input.Filing_Type_ID='29040' or
																																													input.Filing_Type_ID='31040' or
																																													input.Filing_Type_ID='33040' or
																																													input.Filing_Type_ID='32040' or
																																													input.Filing_Type_ID='34040' or
																																													input.Filing_Type_ID='52040' )
																																													
			self.corp_key										:= '40-' + trimUpper(input.Filing_Number);	
			self.corp_vendor								:= '40';		
		
			self.corp_state_origin					:= 'OK';
			self.corp_process_date					:= fileDate;

			self.corp_sos_charter_nbr				:= trimUpper(input.Filing_Number);
																		
			arFiledDate											:= reformatDate2(input.Filing_date );
			
			self.ar_filed_dt								:= if ( _validate.date.fIsValid(arFiledDate),
																								arFiledDate,
																								''
																						);
																						
			self.ar_report_nbr							:= input.Document_number;

			self														:=[];

		end;																																													
		
		OfficerLookups := record
			string10 	Filing_Number;
			string32	Officer_Title;
			string150 Business_Name;
			string50 	Officer_Last_Name;
			string50 	Officer_First_Name;
			string50 	Officer_Middle_Name;
			string6 	Officer_Suffix_ID;
			string50	Officer_Suffix;
			string13 	Address_ID;
			string10 	Creation_Date;
			string10 	Inactive_Date;
		end;
		
		OfficerWithAddress := record
			OfficerLookups;
			string50 	Address1;
			string50 	Address2;
			string64 	City;
			string4 	State;
			string9 	Zip_Code;
			string6 	Zip_Extension;
			string3 	Country;
			string44	CountryDesc;			
		end;	
		
		OfficerAddrWithEntity := record
			OfficerWithAddress;
			string150 Name;
		end;			
		
		//------------------ Populate Suffix ID in Officer file									
											
		OfficerLookups findOfficerSuffixCode(layouts_raw_input.Officer input, layouts_raw_input.Suffix r ) := transform
			self.Officer_Suffix	:= r.Suffix;
			self         		  	:= input;
		end; 
	
		PopOfficerSuffix := join(	Files_Raw_Input.VendorOfficer(fileDate), Files_Raw_Input.VendorSuffix(fileDate),
															trim(left.Officer_Suffix_ID,left,right) = right.Suffix_ID,
															findOfficerSuffixCode(left,right),
															left outer, lookup
														);		
		
		OfficerWithAddress MergeOfficerAddress(OfficerLookups l, AddressLookups r ) := transform
			self											:= l;
			self											:= r;
		end; 
		
		joinOfficerWithAddress := join( PopOfficerSuffix, PopAddrCtry,
																		trim(left.Address_ID,left,right) = trim(right.Address_ID,left,right),
																		MergeOfficerAddress(left,right),
																		left outer
																	);	
																	
		OfficerAddrWithEntity MergeOfficerAddrEntity(OfficerWithAddress l, layouts_raw_input.Entity r ) := transform
			self											:= l;
			self											:= r;
		end; 
		
		joinOfficerAddrWithEntity := join( joinOfficerWithAddress, Files_Raw_Input.VendorEntity(fileDate),
																		trim(left.Filing_Number,left,right) = trim(right.Filing_Number,left,right),
																		MergeOfficerAddrEntity(left,right),
																		left outer
																	);																	
															
		corp2_mapping.Layout_ContPreClean contTransform(OfficerAddrWithEntity input) := transform

			self.dt_first_seen							:=fileDate;
			self.dt_last_seen								:=fileDate;

			self.corp_key										:= '40-' + trimUpper(input.Filing_Number);
			self.corp_vendor								:= '40';
			self.corp_state_origin					:= 'OK';
			self.corp_process_date					:= fileDate;
			self.corp_orig_sos_charter_nbr	:= trimUpper(input.Filing_Number);
		
			self.corp_legal_name						:= trimUpper(input.Name);
			self.cont_name									:= if (	trimUpper(input.Business_Name) <> '',
																								trimUpper(input.Business_Name),
																								trim((trimUpper(input.Officer_First_Name) + ' ' +
																											trimUpper(input.Officer_Middle_Name) + ' ' +
																											trimUpper(input.Officer_Last_Name) + ' ' +
																											trimUpper(input.Officer_Suffix)),
																											left,right
																										)
																						);
			self.cont_title1_desc						:= trimUpper(input.Officer_Title);
			CreationDate										:= reformatDate2(input.Creation_Date);
			
			self.cont_effective_date				:= if ( _validate.date.fIsValid(CreationDate),
																								CreationDate,
																								''
																						);
	
			self.cont_address_line1 				:= trimUpper(input.Address1),
			self.cont_address_line2					:= trimUpper(input.Address2);
			self.cont_address_line3					:= trimUpper(input.City);
			self.cont_address_line4					:= trimUpper(input.State);
			self.cont_address_line5					:= if ((string)(integer) input.Zip_Code <> '0' and length(trim(input.Zip_Code,left,right)) = 5,
																								if((string)(integer) input.Zip_Extension <> '0' and length(trim(input.Zip_Extension,left,right)) = 4,
																											trim(trim(input.Zip_Code,left,right) + trim(input.Zip_Extension,left,right),left,right),
																											input.Zip_Code
																									 ),
																								''
																							);
			self.cont_address_line6					:= trimUpper(input.CountryDesc);
	    self.cont_address_type_cd				:= if(	trim(input.address1,left,right) <> '' or 
																							trim(input.address2,left,right) <> '' or
																							trim(input.city,left,right) <> '' or 
																							trim(input.state,left,right) <>'' or 
																							trim(input.zip_code,left,right) <> '' or
																							trim(input.countryDesc,left,right) <> '',
																								'T',
																								''
																						);
		  self.cont_address_type_desc			:= if(	trim(input.address1,left,right) <> '' or 
																							trim(input.address2,left,right) <> '' or
																							trim(input.city,left,right) <> '' or 
																							trim(input.state,left,right) <>'' or 
																							trim(input.zip_code,left,right) <> '' or
																							trim(input.countryDesc,left,right) <> '',
																								'CONTACT',
																								''
																						);			
			InactiveDate										:= reformatDate2(input.Inactive_Date);
			
			self.cont_addl_info 						:= if ( _validate.date.fIsValid(InactiveDate),
																								'INACTIVE DATE: ' + InactiveDate,
																								''
																						);
																						
			self 														:= [];	
			
		end;
		
		Corp2.Layout_Corporate_Direct_Corp_In CleanCorp(corp2_mapping.Layout_CorpPreClean input) := transform		
			string73 tempname 							:= if(input.corp_ra_name = '', '', Address.CleanPersonFML73(input.corp_ra_name));
			pname 													:= Address.CleanNameFields(tempName);
			cname 													:= DataLib.companyclean(input.corp_ra_name);
			keepPerson 											:= corp2.Rewrite_Common.IsPerson(input.corp_ra_name);
			keepBusiness 										:= corp2.Rewrite_Common.IsCompany(input.corp_ra_name);
			
			self.corp_ra_title1							:= if(keepPerson, pname.title, '');
			self.corp_ra_fname1 						:= if(keepPerson, pname.fname, '');
			self.corp_ra_mname1 						:= if(keepPerson, pname.mname, '');
			self.corp_ra_lname1 						:= if(keepPerson, pname.lname, '');
			self.corp_ra_name_suffix1 			:= if(keepPerson, pname.name_suffix, '');
			self.corp_ra_score1 						:= if(keepPerson, pname.name_score, '');
		
			self.corp_ra_cname1 						:= if(keepBusiness, cname[1..70],'');
			self.corp_ra_cname1_score 			:= if(keepBusiness, pname.name_score, '');
			
			string182 clean_address 				:= Address.CleanAddress182(	trim(	trim(input.corp_address1_line1,left,right) + ' ' +
																																				trim(input.corp_address1_line2,left,right),
																																				left,right
																																			 ),
																																	trim(	trim(input.corp_address1_line3,left,right) + ', ' +
																																				trim(input.corp_address1_line4,left,right) + ' ' +
																																				trim(input.corp_address1_line5,left,right),
																																				left,right
																																			)
																																 );			
			
			string182 clean_ra_address 			:= Address.CleanAddress182(	trim(	trim(input.corp_ra_address_line1,left,right) + ' ' +
																																				trim(input.corp_ra_address_line2,left,right), 
																																				left,right
																																			 ),
																																	trim(	trim(input.corp_ra_address_line3,left,right) + ', ' +
																																				trim(input.corp_ra_address_line4,left,right) + ' ' +
																																				trim(input.corp_ra_address_line5,left,right),
																																				left,right
																																			)
																																);	
																				
			self.corp_ra_prim_range    			:= clean_ra_address[1..10];
			self.corp_ra_predir 	      		:= clean_ra_address[11..12];
			self.corp_ra_prim_name 	  			:= clean_ra_address[13..40];
			self.corp_ra_addr_suffix   			:= clean_ra_address[41..44];
			self.corp_ra_postdir 	    			:= clean_ra_address[45..46];
			self.corp_ra_unit_desig 	  		:= clean_ra_address[47..56];
			self.corp_ra_sec_range 	  			:= clean_ra_address[57..64];
			self.corp_ra_p_city_name	  		:= clean_ra_address[65..89];
			self.corp_ra_v_city_name	  		:= clean_ra_address[90..114];
			self.corp_ra_state 			    		:= clean_ra_address[115..116];
			self.corp_ra_zip5 		      		:= clean_ra_address[117..121];
			self.corp_ra_zip4 		      		:= clean_ra_address[122..125];
			self.corp_ra_cart 		      		:= clean_ra_address[126..129];
			self.corp_ra_cr_sort_sz 	 			:= clean_ra_address[130];
			self.corp_ra_lot 		      			:= clean_ra_address[131..134];
			self.corp_ra_lot_order 	  			:= clean_ra_address[135];
			self.corp_ra_dpbc 		      		:= clean_ra_address[136..137];
			self.corp_ra_chk_digit 	  			:= clean_ra_address[138];
			self.corp_ra_rec_type		  			:= clean_ra_address[139..140];
			self.corp_ra_ace_fips_st	  		:= clean_ra_address[141..142];
			self.corp_ra_county 	  				:= clean_ra_address[143..145];
			self.corp_ra_geo_lat 	    			:= clean_ra_address[146..155];
			self.corp_ra_geo_long 	    		:= clean_ra_address[156..166];
			self.corp_ra_msa 		      			:= clean_ra_address[167..170];
			self.corp_ra_geo_blk						:= clean_ra_address[171..177];
			self.corp_ra_geo_match 	  			:= clean_ra_address[178];
			self.corp_ra_err_stat 	    		:= clean_ra_address[179..182];
													
			self.corp_addr1_prim_range  		:= clean_address[1..10];
			self.corp_addr1_predir 	    		:= clean_address[11..12];
			self.corp_addr1_prim_name 			:= clean_address[13..40];
			self.corp_addr1_addr_suffix   	:= clean_address[41..44];
			self.corp_addr1_postdir 	   		:= clean_address[45..46];
			self.corp_addr1_unit_desig 			:= clean_address[47..56];
			self.corp_addr1_sec_range 			:= clean_address[57..64];
			self.corp_addr1_p_city_name			:= clean_address[65..89];
			self.corp_addr1_v_city_name			:= clean_address[90..114];
			self.corp_addr1_state 			    := clean_address[115..116];
			self.corp_addr1_zip5 		      	:= clean_address[117..121];
			self.corp_addr1_zip4 		      	:= clean_address[122..125];
			self.corp_addr1_cart 		     		:= clean_address[126..129];
			self.corp_addr1_cr_sort_sz 	 		:= clean_address[130];
			self.corp_addr1_lot 		      	:= clean_address[131..134];
			self.corp_addr1_lot_order 			:= clean_address[135];
			self.corp_addr1_dpbc 		     		:= clean_address[136..137];
			self.corp_addr1_chk_digit 			:= clean_address[138];
			self.corp_addr1_rec_type		  	:= clean_address[139..140];
			self.corp_addr1_ace_fips_st			:= clean_address[141..142];
			self.corp_addr1_county 	  			:= clean_address[143..145];
			self.corp_addr1_geo_lat 	    	:= clean_address[146..155];
			self.corp_addr1_geo_long 	    	:= clean_address[156..166];
			self.corp_addr1_msa 		      	:= clean_address[167..170];
			self.corp_addr1_geo_blk					:= clean_address[171..177];
			self.corp_addr1_geo_match 	  	:= clean_address[178];
			self.corp_addr1_err_stat 	    	:= clean_address[179..182];
			self														:= input;
			self 														:= [];
		end;						
	
		Corp2.Layout_Corporate_Direct_Cont_In CleanCont(corp2_mapping.Layout_ContPreClean input) := transform		
			string73 tempname 							:= if(input.cont_name = '', '', Address.CleanPersonFML73(input.cont_name));
			pname 													:= Address.CleanNameFields(tempName);
			cname 													:= DataLib.companyclean(input.cont_name);
			keepPerson 											:= corp2.Rewrite_Common.IsPerson(input.cont_name);
			keepBusiness 										:= corp2.Rewrite_Common.IsCompany(input.cont_name);
			
			self.cont_title1								:= if(keepPerson, pname.title, '');
			self.cont_fname1 								:= if(keepPerson, pname.fname, '');
			self.cont_mname1 								:= if(keepPerson, pname.mname, '');
			self.cont_lname1 								:= if(keepPerson, pname.lname, '');
			self.cont_name_suffix1 					:= if(keepPerson, pname.name_suffix, '');
			self.cont_score1 								:= if(keepPerson, pname.name_score, '');
		
			self.cont_cname1 								:= if(keepBusiness, cname[1..70],'');
			self.cont_cname1_score 					:= if(keepBusiness, pname.name_score, '');
			
		
			string182 clean_address 				:= Address.CleanAddress182(	trim(	trim(input.cont_address_line1,left,right) + ' ' +
																																				trim(input.cont_address_line2,left,right),
																																				left,right
																																			),
																																	trim(	trim(input.cont_address_line3,left,right) + ', ' +
																																				trim(input.cont_address_line4,left,right) + ' ' +
																																				trim(input.cont_address_line5,left,right),
																																				left,right
																																			 )
																																 );	
																				
			self.cont_prim_range    				:= clean_address[1..10];
			self.cont_predir 	      				:= clean_address[11..12];
			self.cont_prim_name 	  				:= clean_address[13..40];
			self.cont_addr_suffix   				:= clean_address[41..44];
			self.cont_postdir 	  		  		:= clean_address[45..46];
			self.cont_unit_desig 	  				:= clean_address[47..56];
			self.cont_sec_range 	  				:= clean_address[57..64];
			self.cont_p_city_name	  				:= clean_address[65..89];
			self.cont_v_city_name	 					:= clean_address[90..114];
			self.cont_state 			      		:= clean_address[115..116];
			self.cont_zip5 		      				:= clean_address[117..121];
			self.cont_zip4 		 	     				:= clean_address[122..125];
			self.cont_cart 		    	  			:= clean_address[126..129];
			self.cont_cr_sort_sz 	 					:= clean_address[130];
			self.cont_lot 		      				:= clean_address[131..134];
			self.cont_lot_order 	  				:= clean_address[135];
			self.cont_dpbc 		   		   			:= clean_address[136..137];
			self.cont_chk_digit 	  				:= clean_address[138];
			self.cont_rec_type		  				:= clean_address[139..140];
			self.cont_ace_fips_st	  				:= clean_address[141..142];
			self.cont_county 	 	 						:= clean_address[143..145];
			self.cont_geo_lat 	    				:= clean_address[146..155];
			self.cont_geo_long 	    				:= clean_address[156..166];
			self.cont_msa 		      				:= clean_address[167..170];
			self.cont_geo_blk								:= clean_address[171..177];
			self.cont_geo_match 	  				:= clean_address[178];
			self.cont_err_stat 	    				:= clean_address[179..182];

			self														:= input;
			self 														:= [];
		end;				
															
		CorpLegal				:= project(joinAgentAddress, corpLegalTransform(left));															
		CorpNonLegal		:= project(PopNameStatus,corpNonLegalTransform(left));
		CorpAssocEntity	:= project(PopCapacity,corpAssocEntityTransform(left));
		
		MapCorp					:= sort((CorpLegal + CorpNonLegal + CorpAssocEntity), corp_key);
		CleanedCorp			:= project(MapCorp, CleanCorp(left));	

		MapCont					:= project(joinOfficerAddrWithEntity, ContTransform(left));
		CleanedCont			:= project(MapCont, CleanCont(left));	
		
		MapStock				:= project(PopStockType, stockTransform(left));
		
		MapEvent				:= project(PopFilingType, EventTransform(left));
		
		ARFromStock			:= project(joinEntityWithStock, ARTransform1(left));
		ARFromFiling		:= project(PopFilingType, ARTransform2(left));		
		
		MapAR						:= sort((ARFromStock + ARFromFiling), corp_key);
		
		
	VersionControl.macBuildNewLogicalFile('~thor_data400::in::corp2::'+version+'::corp_ok'	,CleanedCorp,corp_out	,,,pOverwrite);		
	VersionControl.macBuildNewLogicalFile('~thor_data400::in::corp2::'+version+'::cont_ok'	,CleanedCont,cont_out	,,,pOverwrite);
	VersionControl.macBuildNewLogicalFile('~thor_data400::in::corp2::'+version+'::stock_ok'	,MapStock		,stock_out,,,pOverwrite);
	VersionControl.macBuildNewLogicalFile('~thor_data400::in::corp2::'+version+'::event_ok'	,MapEvent		,event_out,,,pOverwrite);
	VersionControl.macBuildNewLogicalFile('~thor_data400::in::corp2::'+version+'::ar_ok'		,MapAR			,ar_out		,,,pOverwrite);
															                                                                                                                               
		mapCorpFiling := parallel(
			 corp_out	
			,cont_out	
			,stock_out
			,event_out
			,ar_out		
	);															

		result := 
		sequential(
			 if(pshouldspray = true,fSprayFiles('ok',filedate,pOverwrite := pOverwrite))
			,mapCorpFiling
			,parallel(
				 fileservices.addsuperfile('~thor_data400::in::corp2::sprayed::corp'	,'~thor_data400::in::corp2::'+version+'::corp_ok')
				,fileservices.addsuperfile('~thor_data400::in::corp2::sprayed::cont'	,'~thor_data400::in::corp2::'+version+'::cont_ok')
				,fileservices.addsuperfile('~thor_data400::in::corp2::sprayed::stock'	,'~thor_data400::in::corp2::'+version+'::stock_ok')
				,fileservices.addsuperfile('~thor_data400::in::corp2::sprayed::ar'		,'~thor_data400::in::corp2::'+version+'::ar_ok')															  
				,fileservices.addsuperfile('~thor_data400::in::corp2::sprayed::event'	,'~thor_data400::in::corp2::'+version+'::event_ok')
			)
		);

		return result;
	end;					 	
end;