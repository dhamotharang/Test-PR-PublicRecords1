/*2007-10-31T14:21:51Z (Julie Franzer)
Fixed corp_term_exist_cd,dec,exp field issues
*/
import ut, lib_stringlib, _validate, Address, corp2, _control, versioncontrol;

export NE := MODULE;

	export Layouts_Raw_Input := MODULE
	
// vendor data consists of four data files and six tables containing codes and explosion values	
		
		// VENDOR DATA START
		
		export CorpEntity	:= record	
			string AcctNumber;               
			string AssociatedAcctNumber;      
			string ForgnCorpName;
			string ForgnModifiedName;
			string ForgnModifiedNameSdx;
			string CorpStateName;            
			string CorpModifiedName;
			string CorpModifiedNameSdx;
			string CorpModifiedNameFlag;				 
			string RegAgentID;
			string RegAgentContact;
			string CorpType;	
			string Status;     
			string UpdateNeeded;
			string Classification;       
			string FarmExemptionCategory;    
			string DateIncorp;      
			string QualifyingState;
			string Duration;
			string ExpirationDate;         
			string Name;     
			string Contact;    
			string Address1;     
			string Address2;    
			string City;
			string State;                    
			string ZipCode;
			string CountyCode;
			string CntryCode;
			string PhoneNumber;
			string FaxNumber;
			string EmailAddr;
			string NatureOfBusiness;        
			string Field33;
			string UserField2;
			string FilingDateTime;          
			string Internal;										
			end;
	
		export CorpOfficers	:= record
			string RecID;
			string AcctNumber;              
			string YearInReported;        
			string YearOutReported;
			string PositionTitle;            
			string FirstName;            
			string MiddleInitial;         
			string LastName;          
			string LastNameSdx;			
			string OfcrAddress1;
			string OfcrAddress2;                   
			string OfcrCity;          
			string OfcrState;         
			string cntryCode;              
			string OfcrZipCode;          		    
			string FilingDateTime;           
			string Internal;
			end;

		export NewCorpOfficers	:= record
			string RecID;
			string AcctNumber;              
			string YearInReported;        
			string YearOutReported;
			string PositionTitle;            
			string FirstName;            
			string MiddleInitial;         
			string LastName;          
			string LastNameSdx;			
			string OfcrAddress1;
			string OfcrAddress2;                   
			string OfcrCity;          
			string OfcrState;         
			string cntryCode;              
			string OfcrZipCode;        			  
			string FilingDateTime;           
			string Internal;
			string Title1;
			string Title2;
			string Title3;
			string Title4;
			string Title5;
			string Title6;
			string Title7;
			string Title8;
			string Title9;
			string Title10;
			end;

		export CorpEntityNewCorpOfficers	:= record			
			string AcctNumber;               
			string AssociatedAcctNumber;      
			string ForgnCorpName;
			string ForgnModifiedName;
			string ForgnModifiedNameSdx;
			string CorpStateName;            
			string CorpModifiedName;
			string CorpModifiedNameSdx;
			string CorpModifiedNameFlag;				 
			string RegAgentID;
			string RegAgentContact;
			string CorpType;	
			string Status;
			string UpdateNeeded;
			string Classification;       
			string FarmExemptionCategory;    
			string DateIncorp;      
			string QualifyingState;
			string Duration;
			string ExpirationDate;         
			string Name;     
			string Contact;    
			string Address1;     
			string Address2;    
			string City;
			string State;                    
			string ZipCode;
			string CountyCode;
			string CntryCode;
			string PhoneNumber;
			string FaxNumber;
			string EmailAddr;
			string NatureOfBusiness;        
			string Field33;
			string UserField2;
			string FilingDateTime;          
			string Internal;
			string RecID;			             
			string YearInReported;        
			string YearOutReported;
			string PositionTitle;            
			string FirstName;            
			string MiddleInitial;         
			string LastName;          
			string LastNameSdx; 						
			string OfcrAddress1;
			string OfcrAddress2;                   
			string OfcrCity;          
			string OfcrState;                      
			string OfcrZipCode; 						
			string Title1;
			string Title2;
			string Title3;
			string Title4;
			string Title5;
			string Title6;
			string Title7;
			string Title8;
			string Title9;
			string Title10;
			string countryDesc;
			end;
			
		export RegisterAgent	:= record
			string RegAgentID;
			string AcctNumber;
			string CorporationRepresented;
			string PickListFlag;
			string RegAgentName;            
			string RegAgentNameSdx;
			string RegAgentAddr1;     
			string RegAgentAddr2;    
			string RegAgentCity;
			string RegAgentState; 
			string RegAgentZip;
			string RegAgentCnty;
			string RegAgentPhone;
			string RegAgentFax;
			string RegAgentEmail;
			string RegAgentContact;
			string RegAgtLastUpdatedBy;
			string RegAgtDateTimeStamp;
			string RegAgtInternal;	
			end;

		export CorpEntityRegisterAgent	:= record
			string AcctNumber; 
			string AssociatedAcctNumber;      
			string ForgnCorpName;
			string ForgnModifiedName;
			string ForgnModifiedNameSdx;
			string CorpStateName;
			string CorpModifiedName;
			string CorpModifiedNameSdx;
			string CorpModifiedNameFlag	;				 
			string RegAgentID;
			string RegAgentContact;
			string CorpType;	
			string Status;     
			string UpdateNeeded;
			string Classification;       
			string FarmExemptionCategory;    
			string DateIncorp;
			string QualifyingState;  
			string Duration;
			string ExpirationDate;          
			string Name;      
			string Contact;     
			string Address1;      
			string Address2;     
			string City;
			string State;                    
			string ZipCode;
			string CountyCode;
			string CntryCode;
			string PhoneNumber;
			string FaxNumber;
			string EmailAddr;
			string NatureOfBusiness;        
			string Field33;
			string UserField2;
			string FilingDateTime;          
			string Internal;					
			string CorporationRepresented;
			string PickListFlag;
			string RegAgentName;            
			string RegAgentNameSdx;
			string RegAgentAddr1;     
			string RegAgentAddr2;    
			string RegAgentCity;
			string RegAgentState; 
			string RegAgentZip;
			string RegAgentCnty;
			string RegAgentPhone;
			string RegAgentFax;
			string RegAgentEmail;		
			string RegAgtLastUpdatedBy;
			string RegAgtDateTimeStamp;
			string RegAgtInternal;
			end;
				
		export CorpRegJoined := record
			CorpEntityRegisterAgent;
			string corpTypeDesc;
			string corpTypeDesc3;
			end;
				
		export CorpAction := record 
			string ActionNumber;
			string AcctNumber;           
			string DateTimeFiled;           
			string DateTimeEntered;      
			string DateTimeEffective;     
			string FilerClientName;
			string ServiceTypeCode;       
			string DocNumber;
			string NumPages;
			string TaxPayment;
			string TaxReceiptDate;           
			string TaxReportNumber;       
			string InternalField;
			end;
			
	    export CorpActionDesc := record
		    CorpAction;
			string Description;
			end;
	
	    export CorpJoin1Layout := record
			CorpEntity;			
			string CorporationRepresented;
			string PickListFlag;
			string RegAgentName;            
			string RegAgentNameSdx;
			string RegAgentAddr1;     
			string RegAgentAddr2;    
			string RegAgentCity;
			string RegAgentState; 
			string RegAgentZip;
			string RegAgentCnty;
			string RegAgentPhone;
			string RegAgentFax;
			string RegAgentEmail;
			string RegAgtLastUpdatedBy;
			string RegAgtDateTimeStamp;
			string RegAgtInternal;	
			end;
			
		export CorpJoin2Layout := record
			CorpJoin1Layout;
			string forgnStateDesc;
			end;
			
		export CorpJoin3Layout := record
			CorpJoin2Layout;
			string countryDesc;
			end;
			
		export CorpJoin4Layout := record
			CorpJoin3Layout;
			string typeDesc;
			string durationDesc;
			end;
		
	end;
	
				
	export Files_Raw_Input := MODULE;
				
		export CorpEntity(string fileDate)          := dataset('~thor_data400::in::corp2::'+fileDate+'::CorpEntity::ne',
														     layouts_Raw_Input.CorpEntity,CSV(SEPARATOR(['\t']), TERMINATOR(['\r\n', '\n'])));
																			 
		export CorpOfficers(string fileDate)        := dataset('~thor_data400::in::corp2::'+fileDate+'::CorpOfficers::ne',
														     layouts_Raw_Input.CorpOfficers,CSV(SEPARATOR(['\t']), TERMINATOR(['\r\n', '\n'])));
															 
		export RegisterAgent(string fileDate)       := dataset('~thor_data400::in::corp2::'+fileDate+'::RegisterAgent::ne',
														     layouts_Raw_Input.RegisterAgent,CSV(SEPARATOR(['\t']), TERMINATOR(['\r\n', '\n'])));
														
		export CorpAction (string fileDate)        	:= dataset('~thor_data400::in::corp2::'+fileDate+'::CorpAction::ne',
		                                                     					layouts_Raw_Input.CorpAction,CSV(SEPARATOR(['\t']), TERMINATOR(['\r\n', '\n'])));																							
		end;	


//---------------------------- update function-------------------------------------------------------------------------//

	export Update(string fileDate, string version, boolean pShouldSpray = _Dataset().bShouldSpray, boolean pOverwrite = false) := function
	
	    trimUpper(string s) := function
			return trim(stringlib.StringToUppercase(s),left,right);
		end;

		setCorpTypeCodes					:= ['A','AA','B','BK','D','DF','DFPC',
												'DLPC','DPC','F','FLPC','FPC','FS',
												'G','H','HA','IC','J','JPA','K','L',
												'N','NDF','NF','NS','NT','P','RAD',
												'SID','M','PN','RN','S','T','VN'];
												
		setCorpCodes1						:= ['A','AA','B','BK','D','DF','DFPC',
												'DLPC','DPC','F','FLPC','FPC','FS',
												'G','H','HA','IC','J','JPA','K','L',
												'N','NDF','NF','NS','NT','P','PN',
												'RAD','SID'];
												
        setTMCorps							:= ['M','P','PN','RN','S','T','VN'];
					 
	    setValidStates						:= ['AL','AK','AZ','AR','CA','CO','CT',
												'DE','DC','FL','GA','HI','ID','IL',
												'IA','KS','KY','LA','ME','MD','MA',
												'MI','MN','MS','MO','MT','NE','NV',
												'NH','NJ','NM','NY','NC','ND','OH',
												'OK','OR','PA','RI','SC','SD','TN',
												'TX','UT','VT','VA','WA','WV','WI','WY'];

	 			
		CorpTypeCodeLayout := record
			string corpCode;
			string corpDesc;
			string corpDesc2;
			string corpDesc3;
			end;
		
		CorpCodeTable := dataset('~thor_data400::lookup::corp2::'+ filedate +'::CorporationType::ne',CorpTypeCodeLayout, CSV(SEPARATOR(['\t']), TERMINATOR(['\r\n', '\n'])));
	 			
		StateTypeCodeLayout := record
			string stateCode;
			string stateDesc;			
			end;		
		  
		StateCodeTable := dataset('~thor_data400::lookup::corp2::'+ filedate +'::ListOfStates::ne',StateTypeCodeLayout,CSV(SEPARATOR(['\t']), TERMINATOR(['\r\n', '\n'])));
		 		
		CntryTypeCodeLayout := record			
			string cntryDesc;
			string cntryCode1;
			string cntryCode2;			
			end;	
		  
		CntryCodeTable := dataset('~thor_data400::lookup::corp2::'+ filedate +'::NECountryCodes::ne',CntryTypeCodeLayout, CSV(SEPARATOR(['\t']), TERMINATOR(['\r\n', '\n'])));
	 			
		TitleTypeCodeLayout := record			
			string titleCode;  
			string titleDesc;			
		    end;	
		  
		TitleCodeTable := dataset('~thor_data400::lookup::corp2::'+ filedate +'::PositionHeld::ne',TitleTypeCodeLayout, CSV(SEPARATOR(['\t']), TERMINATOR(['\r\n', '\n'])));
						
		FilingTypeCodeLayout := record			
			string filingCode;
			string filingDesc;						
			string filingDesc2;						
			end;	
		  
		FilingCodeTable := dataset('~thor_data400::lookup::corp2::'+ filedate +'::ServiceType::ne',FilingTypeCodeLayout, CSV(SEPARATOR(['\t']), TERMINATOR(['\r\n', '\n'])));


//---------------------------- Dedupe/Merge Officer Records -------------------------------		

	sortOfficers		:= sort(Files_Raw_Input.CorpOfficers(filedate),AcctNumber,Firstname,MiddleInitial,lastname,PositionTitle,-FilingDateTime);			

	distofficers		:= distribute(sortOfficers,hash64(AcctNumber,Firstname,MiddleInitial,lastname,PositionTitle));

    layouts_Raw_Input.NewCorpOfficers newTransform(layouts_Raw_Input.CorpOfficers l, TitleTypeCodeLayout r) := transform		
			self.PositionTitle	:= stringlib.StringtoUpperCase(r.titleDesc);			
			self				:=l;
			self				:=[];			
			end;

    newOfficerFile		:= join(distOfficers, TitleCodeTable ,
									trim(left.PositionTitle,left,right) = trim(right.titleCode,left,right),
									newTransform(left,right),
									left outer, lookup); 
    
    dedupNewOfficerFile := dedup(sort(newOfficerFile,AcctNumber,Firstname,
									  MiddleInitial,lastname,PositionTitle,
									  -FilingDateTime),AcctNumber,Firstname,
									  MiddleInitial,lastname,PositionTitle);

    layouts_Raw_Input.NewCorpOfficers DenormOfficers(layouts_Raw_Input.NewCorpOfficers L,layouts_Raw_Input.NewCorpOfficers R,integer C) := transform		
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
			self 			:= L;						
			end;

    DenormalizedFile 	:= sort(denormalize(dedupNewOfficerFile,dedupNewOfficerFile,
									trim(left.AcctNumber,left,right) = trim(right.AcctNumber,left,right) and
									trim(left.FirstName,left,right) = trim(right.FirstName,left,right) and
									trim(left.MiddleInitial,left,right) = trim(right.MiddleInitial,left,right) and
									trim(left.lastname,left,right) = trim(right.lastname,left,right) , 
									DenormOfficers(left,right,COUNTER)),
									AcctNumber, Firstname,MiddleInitial,lastname,PositionTitle,-FilingDateTime);    
     
    layouts_Raw_Input.NewCorpOfficers rollupofficers(layouts_Raw_Input.NewCorpOfficers l,layouts_Raw_Input.NewCorpOfficers r) := transform				
			self.FilingDateTime := if(l.FilingDateTime[1..4] +
									  l.FilingDateTime[6..7] + 
									  l.FilingDateTime[9..10] > 
									  r.FilingDateTime[1..4] + 
									  r.FilingDateTime[6..7] + 
									  r.FilingDateTime[9..10], 
										l.FilingDateTime, 
										r.FilingDateTime);									  																	
			self 				:= l;			
			end;

    dedupedOfficers		:= rollup(DenormalizedFile,
								  rollupOfficers(left,right), 
								  AcctNumber,Firstname,MiddleInitial,lastname) 
;
//------------------------------------ Main Corp Transform -----------------------------------------------------------------//
	
	Corp2_Mapping.Layout_CorpPreClean   corpMainTransform(Layouts_Raw_Input.CorpJoin4Layout input):= transform, 
														  skip(trimUpper(input.CorpStateName) = '')
														  
		self.dt_vendor_first_reported		:= fileDate;
		self.dt_vendor_last_reported		:= fileDate;
		self.dt_first_seen					:= fileDate;
		self.dt_last_seen					:= fileDate;
		self.corp_ra_dt_first_seen			:= fileDate;
		self.corp_ra_dt_last_seen			:= fileDate;
		self.corp_key						:= '31-' + trim(input.AcctNumber,left,right);		
		self.corp_vendor					:= '31';		
		self.corp_state_origin				:= 'NE';
		self.corp_process_date				:= fileDate;
		self.corp_src_type					:= 'SOS';
		self.corp_orig_sos_charter_nbr		:= trim(input.AcctNumber,left,right);				
		self.corp_legal_name				:= trimUpper(input.CorpStateName);
		self.corp_ln_name_type_cd			:= map(trimUpper(input.corpType) = 'M' => '03',
												   trimUpper(input.corpType) = 'S' => '05',	
												   trimUpper(input.corpType) = 'T' => '04',
												   '01');						
		self.corp_ln_name_type_desc			:= map(trimUpper(input.corpType) = 'M' => 'TRADEMARK',
												   trimUpper(input.corpType) = 'S' => 'SERVICEMARK',	
												   trimUpper(input.corpType) = 'T' => 'TRADENAME',
												   'LEGAL');
		self.corp_orig_org_structure_cd		:= trimUpper(input.CorpType);															
		self.corp_orig_org_structure_desc	:= trimUpper(input.typeDesc);
		self.corp_status_cd					:= if(trimUpper(input.Status) in ['A','I','S'],
												  trimUpper(input.Status),
												  '');	
      	self.corp_status_desc				:= case(trimUpper(input.Status),
													'A'=>'ACTIVE',
													'I'=>'INACTIVE',
													'S'=>'SUSPENDED',
													'');																 																
		newDateInc1							:= if(trim(input.DateIncorp,left,right) <> '',
													input.DateIncorp[1..4] +
													input.DateIncorp[6..7] +
													input.DateIncorp[9..10],
													'');
		newDateInc2							:= if(_validate.date.fIsValid(newDateInc1) and											
													_validate.date.fIsValid(newDateInc1,_validate.date.rules.DateInPast),
													newDateInc1,
													'');													 														
		self.corp_inc_date					:= if(trimUpper(input.CorpType) in setCorpCodes1,
													newDateInc2,
													'');												 			
        self.corp_filing_date				:= if(newDateInc2 <> '' and
													trimUpper(input.CorpType) in setTMCorps,
													newDateInc2,
													'');	
		self.corp_inc_state					:= if(trimUpper(input.QualifyingState) in ['','NE'],
													'NE',
													'');		
		self.corp_forgn_state_cd			:= if(trimUpper(input.QualifyingState) <> 'NE' and
													input.forgnStateDesc <> '',
													trimUpper(input.QualifyingState),											
													'');												 											 
		self.corp_forgn_state_desc			:= if(trimUpper(input.QualifyingState) <> 'NE' and
													input.forgnStateDesc = '' and 
													not ut.isNumeric(trimUpper(input.QualifyingState)),
													trimUpper(input.QualifyingState),											
													'');	
		cType								:= trimUpper(input.corpType);
		self.corp_address1_line1			:= if(cType in setCorpTypeCodes,
													trimUpper(input.address1),
													'');
		self.corp_address1_line2			:= if(cType in setCorpTypeCodes,
													trimUpper(input.address2),
													'');
		self.corp_address1_line3			:= if(cType in setCorpTypeCodes,
													trimUpper(input.city),
													'');
		self.corp_address1_line4			:= if(cType in setCorpTypeCodes and 
													trimUpper(input.state) not in ['X','XX'] and
													not ut.isNumeric(trimUpper(input.state)) and											
													trimUpper(input.state)<>'NO STATE ENTERED',
												  trimUpper(input.state),
												  '');
		zip5								:= if(regexfind('^[0 ]*$',input.zipCode[1..5]),
													'',
													input.zipCode[1..5]);											
		zip4								:= if(length(input.zipCode) = 9 and
												  regexfind('^[0 ]*$',input.zipCode[6..9]),
												  '',
												 input.zipCode[6..9]);												 
		self.corp_address1_line5			:= if(cType in setCorpTypeCodes,
													zip5 + zip4,
													'');
		self.corp_address1_line6			:= if(cType in setCorpTypeCodes and 
													trimUpper(input.cntryCode)<>'USA',
													trimUpper(input.countryDesc),
													'');
		self.corp_address1_type_cd			:= if(self.corp_address1_line1 +
												  self.corp_address1_line2 +
												  self.corp_address1_line3 +
												  self.corp_address1_line4 +
												  self.corp_address1_line5 +
												  self.corp_address1_line6 <> '',
												  'B',
												  '');
		self.corp_address1_type_desc		:= if(self.corp_address1_line1 +
												  self.corp_address1_line2 +
												  self.corp_address1_line3 +
												  self.corp_address1_line4 +
												  self.corp_address1_line5 +
												  self.corp_address1_line6 <> '',
												  'BUSINESS',
												  '');		
		self.corp_entity_desc				:= if(not ut.isNumeric(trimUpper(input.NatureOfBusiness)),
												  trimUpper(input.NatureOfBusiness),
												  '');
		durationVal							:= if(trimUpper(input.duration) ='PERPETUAL',
												 'P',												 
												  if(regexfind('^[0-9]*[ ]*YEARS?$',trimUpper(input.duration))=TRUE,
												    regexfind('^[0-9]*',trimUpper(input.duration),0),
													'')
													);													
        durationDescVal						:= if(trimUpper(input.durationDesc) ='PERPETUAL',
												 'P',												 
												  trimUpper(input.durationDesc)
												  );																										
        newDate								:= if(trim(input.ExpirationDate,left,right)<> '',														
												  input.ExpirationDate[1..4] + input.ExpirationDate[6..7] + input.ExpirationDate[9..10],
												  '');																										
		expirationDate						:= if(_validate.date.fIsValid(newDate) ,
												  newDate,
												  '');												  																 					
		self.corp_term_exist_cd             := map(durationVal = 'P' => 'P',	
												   durationDescVal = 'P' => 'P',
												   expirationDate <> '' => 'D',
												   ut.isNumeric(durationVal) => 'N',
												   durationDescVal[1] in ['Y','M'] => 'N',
												   '');														  																		 
		self.corp_term_exist_desc			:= map(durationVal = 'P' => 'PERPETUAL',
												   durationDescVal = 'P' => 'PERPETUAL',
												   expirationDate <> '' => 'EXPIRATION DATE',
												   ut.isNumeric(durationVal) => 'NUMBER OF YEARS',
												   durationDescVal[1] = 'Y' => 'NUMBER OF YEARS',
												   durationDescVal[1] = 'M' => 'NUMBER OF MONTHS',
												   durationDescVal);											       															        		
		self.corp_term_exist_exp			:= map(expirationDate <> '' => expirationDate,
												   ut.isNumeric(durationVal) => durationVal,
												   durationDescVal[1] in ['Y','M'] => durationDescVal[2..],
												  '');											
		self.corp_ra_name					:= trimUpper(input.regAgentName);
		self.corp_ra_address_line1			:= trimUpper(input.regAgentAddr1);																					 
		self.corp_ra_address_line2			:= trimUpper(input.RegAgentAddr2);	
        self.corp_ra_address_line3			:= if(ut.isNumeric(input.RegAgentCity),												
												 '',
												 trimUpper(input.RegAgentCity));		
		self.corp_ra_address_line4			:= if(trimUpper(input.RegAgentState) in setValidStates,
													trimUpper(input.RegAgentState),
													'');																					
		raZip5								:= if(regexfind('^[0 ]*$',input.zipCode[1..5]),
													'',
													input.zipCode[1..5]);							
		raZip4								:= if(length(input.zipCode) = 9 and
												  regexfind('^[0 ]*$',input.zipCode[6..9]),
												  '',
												 input.zipCode[6..9]);												
		self.corp_ra_address_line5			:= if(cType in setCorpTypeCodes,
													raZip5 + raZip4,
													'');															
		self.corp_ra_address_type_desc		:= if(self.corp_ra_address_line1 +
												  self.corp_ra_address_line2 +
												  self.corp_ra_address_line3 +
												  self.corp_ra_address_line4 +
												  self.corp_ra_address_line5 <> '',
												  'REGISTERED OFFICE',
												  '');																			 
		self								:= [];
		end;

//------------------------------------ Foreign Name Corp Transform -----------------------------------------------------------------//

	Corp2_Mapping.Layout_CorpPreClean corpForgnNameTransform(Layouts_Raw_Input.CorpJoin4Layout input):= transform, 
											skip(trimUpper(input.forgnCorpName) = '')

		self.dt_vendor_first_reported		:= fileDate;
		self.dt_vendor_last_reported		:= fileDate;
		self.dt_first_seen					:= fileDate;
		self.dt_last_seen					:= fileDate;
		self.corp_ra_dt_first_seen			:= fileDate;
		self.corp_ra_dt_last_seen			:= fileDate;
		self.corp_key						:= '31-' + trim(input.AcctNumber,left,right);		
		self.corp_vendor					:= '31';		
		self.corp_state_origin				:= 'NE';
		self.corp_process_date				:= fileDate;
		self.corp_orig_sos_charter_nbr		:= trim(input.AcctNumber,left,right);
		self.corp_src_type					:= 'SOS';
		self.corp_legal_name				:= trimUpper(input.forgnCorpName);
		self.corp_name_comment				:= 'FOREIGN NAME';								
		self								:=[];
		end;

//------------------------------------ TradeMark Corp Transform -----------------------------------------------------------------//

	Corp2_Mapping.Layout_CorpPreClean   corpTMTransform(Layouts_Raw_Input.CorpJoin4Layout input):= transform,
						skip(trimUpper(input.corpType) not in ['M','S','T'])
		self.dt_vendor_first_reported		:= fileDate;
		self.dt_vendor_last_reported		:= fileDate;
		self.dt_first_seen					:= fileDate;
		self.dt_last_seen					:= fileDate;
		self.corp_ra_dt_first_seen			:= fileDate;
		self.corp_ra_dt_last_seen			:= fileDate;
		self.corp_key						:= '31-' + trim(input.AcctNumber,left,right);		
		self.corp_vendor					:= '31';		
		self.corp_state_origin				:= 'NE';
		self.corp_process_date				:= fileDate;
		self.corp_orig_sos_charter_nbr		:= trim(input.AcctNumber,left,right);																								 		
		self.corp_legal_name				:= trimUpper(input.name);
		self.corp_ln_name_type_cd			:= '01';
		self.corp_ln_name_type_desc			:= 'LEGAL';
		self.corp_name_comment				:= 'OWNER/APPLICANT';
		self.corp_addl_info					:= if(trimUpper(input.contact)<>'',
													'CONTACT' + 
														trimUpper(input.contact),
													'');
		self.corp_address1_line1			:= trimUpper(input.address1);
		self.corp_address1_line2			:= trimUpper(input.address2);
		self.corp_address1_line3			:= trimUpper(input.city);
		self.corp_address1_line4			:= if(trimUpper(input.state) not in ['X','XX'] and
													not ut.isNumeric(trimUpper(input.state)),												
												  trimUpper(input.state),
												  '');        													
		zip5								:= if(regexfind('^[0 ]*$',input.zipCode[1..5]),
													'',
													input.zipCode[1..5]);											
		zip4								:= if(length(input.zipCode) = 9 and
												  regexfind('^[0 ]*$',input.zipCode[6..9]),
												  '',
												 input.zipCode[6..9]);											
		self.corp_address1_line5			:= zip5 + zip4;											
		self.corp_address1_line6			:= if(trimUpper(input.cntryCode)<>'USA',
												  trimUpper(input.countryDesc),
												  '');
		self.corp_address1_type_cd			:= if(self.corp_address1_line1 +
												  self.corp_address1_line2 +
												  self.corp_address1_line3 +
												  self.corp_address1_line4 +
												  self.corp_address1_line5 +
												  self.corp_address1_line6 <> '',
												  'T',
												  '');
		self.corp_address1_type_desc		:= if(self.corp_address1_line1 +
												  self.corp_address1_line2 +
												  self.corp_address1_line3 +
												  self.corp_address1_line4 +
												  self.corp_address1_line5 +
												  self.corp_address1_line6 <> '',
												  'CONTACT',
												  '');													
		self								:= [];
		end;

//------------------------------------ Entity Cont Transform -----------------------------------------------------------------//		

	Corp2_Mapping.Layout_ContPreClean   contTransform1(Layouts_Raw_Input.CorpJoin4Layout input):= transform, 
							skip(trimUpper(input.corpType) not in ['PN','RN','VN']) 					   
				
		self.dt_first_seen					:= fileDate;
		self.dt_last_seen					:= fileDate;		
		self.corp_key						:= '31-' + trim(input.AcctNumber,left,right);
		self.corp_vendor					:= '31';
		self.corp_state_origin				:= 'NE';
		self.corp_process_date				:= fileDate;
		self.corp_orig_sos_charter_nbr		:= trim(input.AcctNumber,left,right);			
		self.cont_name						:= trimUpper(input.name);	
		self.cont_type_cd					:= 'O/I';
		self.cont_type_desc					:= 'OWNER/APPLICANT';
		self.cont_addl_info					:= if(trimUpper(input.contact)<>'',
													'CONTACT: ' +
													trimUpper(input.contact),
													'');
		self.cont_address_line1				:= trimUpper(input.address1);
		self.cont_address_line2				:= trimUpper(input.address2);
		self.cont_address_line3				:= trimUpper(input.city);
		self.cont_address_line4				:= if(trimUpper(input.state) not in ['X','XX'] and
													not ut.isNumeric(trimUpper(input.state)),												
												  trimUpper(input.state),
												  '');
        zip5								:= if(regexfind('^[0 ]*$',input.zipCode[1..5]),
													'',
													input.zipCode[1..5]);												
		zip4								:= if(length(input.zipCode) = 9 and
												  regexfind('^[0 ]*$',input.zipCode[6..9]),
												  '',
												 input.zipCode[6..9]);											
		self.cont_address_line5				:= zip5 + zip4;													  
		self.cont_address_line6				:= if(trimUpper(input.cntryCode)<>'USA',
												  trimUpper(input.countryDesc),
												  '');
        self.cont_address_type_cd			:= if(self.cont_address_line1 +
												  self.cont_address_line2 +
												  self.cont_address_line3 +
												  self.cont_address_line4 +
												  self.cont_address_line5 +
												  self.cont_address_line6 <> '',
												  'T',
												  '');
		self.cont_address_type_desc			:= if(self.cont_address_line1 +
												  self.cont_address_line2 +
												  self.cont_address_line3 +
												  self.cont_address_line4 +
												  self.cont_address_line5 +
												  self.cont_address_line6 <> '',
												  'CONTACT',
												  '');													  	
		self.corp_legal_name				:= trimUpper(input.corpStateName);				
		self								:= [];
		end;

//------------------------------------ Officers Cont Transform -----------------------------------------------------------------//		
		
	Corp2_Mapping.Layout_ContPreClean   contTransform2(layouts_raw_input.CorpEntityNewCorpOfficers input):= transform, 
					skip(trimUpper(input.firstname)     = '' and 
					     trimUpper(input.middleInitial) = '' and 
					     trimUpper(input.Lastname)      = '')
					     
				
		self.dt_first_seen				:= fileDate;
		self.dt_last_seen				:= fileDate;		
		self.corp_key					:= '31-' + trim(input.AcctNumber,left,right);
		self.corp_vendor				:= '31';
		self.corp_state_origin			:= 'NE';
		self.corp_process_date			:= fileDate;
		self.corp_orig_sos_charter_nbr	:= trim(input.AcctNumber,left,right);			
		self.cont_name					:= input.firstName + ' ' +
										   input.middleInitial + ' ' +
										   input.lastName;
		allTitles						:= 	trimUpper(input.Title1) + ',' + 
											trimUpper(input.Title2) + ',' +  
											trimUpper(input.Title3) + ',' + 
											trimUpper(input.Title4) + ',' + 
											trimUpper(input.Title5) + ',' + 
											trimUpper(input.Title6) + ',' + 
											trimUpper(input.Title7) + ',' + 
											trimUpper(input.Title8) + ',' + 
											trimUpper(input.Title9) + ',' + 
											trimUpper(input.Title10);																						
		work1							:= regexreplace('[,]*$',allTitles,'',NOCASE);
		work2							:= regexreplace('^[,]*',work1,'',NOCASE);
		self.cont_title1_desc           := regexreplace('[,]+',work2,',',NOCASE);
		self.cont_type_cd				:= map(trimUpper(input.PositionTitle)='PRESIDENT'=>'F',			                          
											   trimUpper(input.PositionTitle)='SECRETARY'=>'F',										
											   trimUpper(input.PositionTitle)='TREASURER'=>'F',
											   trimUpper(input.PositionTitle)='DIRECTOR'=>'F',			                          
											   trimUpper(input.PositionTitle)='MEMBER'=>'M',										
											   trimUpper(input.PositionTitle)='MANAGER'=>'M',											   																				  										
											   '');															
		self.cont_type_desc				:= map(trimUpper(input.PositionTitle)='PRESIDENT'=>'OFFICER',		
											   trimUpper(input.PositionTitle)='SECRETARY'=>'OFFICER',									
											   trimUpper(input.PositionTitle)='TREASURER'=>'OFFICER', 
											   trimUpper(input.PositionTitle)='DIRECTOR'=>'OFFICER',			                          
											   trimUpper(input.PositionTitle)='MEMBER'=>'MEMBER/MANAGER',											
											   trimUpper(input.PositionTitle)='MANAGER'=>'MEMBER/MANAGER',												  																						    											   
											   '');	
											   
		workDate						:= input.FilingDateTime[1..4] + 
										   input.FilingDateTime[6..7] +
										   input.FilingDateTime[9..10];
											  
		self.cont_effective_date 		:= if(_validate.date.fIsValid(workDate) ,
												workDate,
												'');	
												
        self.cont_address_line1			:= trimUpper(input.ofcrAddress1);
		self.cont_address_line2			:= trimUpper(input.ofcrAddress2);
		self.cont_address_line3			:= trimUpper(input.ofcrCity);
		self.cont_address_line4			:= if(trimUpper(input.ofcrState) not in ['X','XX'] and
												not ut.isNumeric(trimUpper(input.ofcrState)),												
												trimUpper(input.ofcrState),
												'');
        zip5							:= if(regexfind('^[0 ]*$',input.ofcrZipCode[1..5]),
												'',
												input.ofcrZipCode[1..5]);
		zip4							:= if(length(input.ofcrZipCode) = 9 and
												 regexfind('^[0 ]*$',input.ofcrZipCode[6..9]),
												 '',
												 input.ofcrZipCode[6..9]);											
		self.cont_address_line5			:= zip5 + zip4;													  
		self.cont_address_line6			:= if(trimUpper(input.cntryCode)<>'USA',
												  trimUpper(input.countryDesc),
												  '');
        self.cont_address_type_cd		:= if(self.cont_address_line1 +
											  self.cont_address_line2 +
											  self.cont_address_line3 +
											  self.cont_address_line4 +
											  self.cont_address_line5 +
											  self.cont_address_line6 <> '',
												'T',
												'');
		self.cont_address_type_desc		:= if(self.cont_address_line1 +
											  self.cont_address_line2 +
											  self.cont_address_line3 +
											  self.cont_address_line4 +
											  self.cont_address_line5 +
											  self.cont_address_line6 <> '',
												'CONTACT',
												'');													  	
		self.corp_legal_name			:= trimUpper(input.corpStateName);						 		
		self							:= [];
		end;
	
//----------------------------- Actions AR Tax Report Transform -----------------------------------------------------------------//			
	
	Corp2.Layout_Corporate_Direct_ar_In arTransform1(layouts_raw_input.CorpActionDesc input):= transform, 
									skip(trimUpper(input.ServiceTypeCode)<>'TR')
		self.corp_key					:= '31-' + trim(input.AcctNumber, left, right);
		self.corp_vendor				:= '31';
		self.corp_state_origin			:= 'NE';
		self.corp_process_date			:= fileDate;
		self.corp_sos_charter_nbr 		:= trim(input.AcctNumber,left,right);
		self.ar_tax_amount_paid			:= if(regexfind('^[0 ]*$',input.taxPayment),
												'',
												trim(input.taxPayment,left,right));											
		
		self.ar_report_nbr				:= trim(input.docNumber,left,right);
		
        taxRecDate1						:= if(trimUpper(input.taxReceiptDate) <> '',														
												  input.taxReceiptDate[1..4] + 
												  input.taxReceiptDate[6..7] + 
												  input.taxReceiptDate[9..10],
												  '');	
												  
		taxRecDate2						:= if(_validate.date.fIsValid(taxRecDate1) and											
											  _validate.date.fIsValid(taxRecDate1,_validate.date.rules.DateInPast),	
												'Tax Receipt Date: ' + 
												input.taxReceiptDate[6..7] + '/' + 
												input.taxReceiptDate[9..10] + '/' + 
												input.taxReceiptDate[1..4] + '.',
												'');
												
		taxRptNum						:= if(regexfind('^[0 ]*$',input.taxReportNumber),
												'',
												' Tax Report Number: ' + 
												trimUpper(input.taxReportNumber) + '.');
		
		self.ar_comment					:= trimUpper(taxRecDate2 + taxRptNum);
		self							:= []; 
		end;

//------------------------------------ Actions AR Main Transform ----------------------------------------------------------------//			

	Corp2.Layout_Corporate_Direct_ar_In arTransform2(layouts_raw_input.CorpActionDesc input):= transform, 
			skip(trimUpper(input.ServiceTypeCode) not in ['ANR','LLPA','BR','AB'] )

		self.corp_key					:= '31-' + trim(input.AcctNumber,left,right);
		self.corp_vendor				:= '31';
		self.corp_state_origin			:= 'NE';
		self.corp_process_date			:= fileDate;		
		self.corp_sos_charter_nbr 		:= trim(input.AcctNumber,left,right);		
		newDate							:= input.DateTimeFiled[1..4] + 
										   input.DateTimeFiled[6..7] + 
										   input.DateTimeFiled[9..10];						
		self.ar_filed_dt				:= if(_validate.date.fIsValid(newDate) and											
											  _validate.date.fIsValid(newDate,_validate.date.rules.DateInPast),
											    newDate,
												'');
		self.ar_type					:= input.description;
		// self.ar_type					:= case(trimUpper(input.ServiceTypeCode),
											   // 'ANR' =>'ANNUAL REPORT',
											   // 'LLPA'=>'LLP ANNUAL REPORT',
											   // 'BR'  =>'BIENNIAL REPORT',
											   // 'AB'  =>'AMENDMENT TO BIENNIAL REPORT',
											   // '');															
		self.ar_report_nbr				:= if(regexfind('^[0 ]*$',input.DocNumber),
											 '',
											 trimUpper(input.DocNumber));
		self							:= []; 
		end;

//------------------------------------ Actions Event Transform ----------------------------------------------------------------------//			

	Corp2.Layout_Corporate_Direct_Event_In eventTransform(layouts_raw_input.CorpActionDesc input):= transform,
						skip(trimUpper(input.ServiceTypeCode) in ['ANR','LLPA','BR','AB','TR'])

		self.corp_key					:= '31-' + trim(input.AcctNumber,left,right);
		self.corp_vendor				:= '31';
		self.corp_state_origin			:= 'NE';
		self.corp_process_date			:= fileDate;
		self.corp_sos_charter_nbr 		:= trim(input.AcctNumber,left,right);
	
		self.event_filing_reference_nbr	:= if(regexfind('^[0 ]*$',input.DocNumber),
											 '',
											 trimUpper(input.DocNumber));
											 
		dateFiled1						:= input.DateTimeFiled[1..4] + 
										   input.DateTimeFiled[6..7] + 
										   input.DateTimeFiled[9..10];
										   
		dateFiled2						:= if(_validate.date.fIsValid(dateFiled1) and											
											  _validate.date.fIsValid(dateFiled1,_validate.date.rules.DateInPast),
											    dateFiled1,
												'');
												
		dateEffect1					    := input.DateTimeEffective[1..4] + 
										   input.DateTimeEffective[6..7] + 
										   input.DateTimeEffective[9..10];
																				
		dateEffect2						:= if(_validate.date.fIsValid(dateEffect1) and											
											  _validate.date.fIsValid(dateEffect1,_validate.date.rules.DateInPast),
											    dateEffect1,
												'');

		self.event_filing_date			:= if(dateFiled2 <> '',
											  dateFiled2,
											  dateEffect2);
																			
	
		self.event_date_type_cd			:= if(dateFiled2 <> '',
											 'FIL',
												if(dateEffect2 <> '',
												  'EFF',
												   '')													 
											  );
	
		self.event_date_type_desc		:= if(dateFiled2 <> '',
											 'FILING',
												if(dateEffect2 <> '',
												  'EFFECTIVE',
												   '')													 
											  );
		
		
		self.event_filing_cd			:= if(trimUpper(input.description) <> '',
  											trimUpper(input.ServiceTypeCode),
											'');
		self.event_filing_desc			:= input.description;
		self							:= [];
		end;

//--------------------------------- Clean Corp Records -----------------------------------------------------------//
	
	corp2.layout_corporate_direct_corp_in  CleanCorps(Corp2_Mapping.Layout_CorpPreClean input) := transform

		string73 tempname 					:= if(input.corp_ra_name = '', 
												  '',
												  Address.CleanPersonFML73(input.corp_ra_name));
		pname 								:= Address.CleanNameFields(tempName);
		cname 								:= DataLib.companyclean(input.corp_ra_name);
		keepPerson 							:= Corp2.Rewrite_Common.IsPerson(input.corp_ra_name);
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
		self.corp_addr1_lot 		    	:= clean_address1[131..134];
		self.corp_addr1_lot_order 	  		:= clean_address1[135];
		self.corp_addr1_dpbc 		    	:= clean_address1[136..137];
		self.corp_addr1_chk_digit 	  		:= clean_address1[138];
		self.corp_addr1_rec_type			:= clean_address1[139..140];
		self.corp_addr1_ace_fips_st	  		:= clean_address1[141..142];
		self.corp_addr1_county 	  			:= clean_address1[143..145];
		self.corp_addr1_geo_lat 	    	:= clean_address1[146..155];
		self.corp_addr1_geo_long 	    	:= clean_address1[156..166];
		self.corp_addr1_msa 		    	:= clean_address1[167..170];
		self.corp_addr1_geo_blk				:= clean_address1[171..177];
		self.corp_addr1_geo_match 	  		:= clean_address1[178];
		self.corp_addr1_err_stat 	    	:= clean_address1[179..182];				
		string182 clean_address				:=  Address.CleanAddress182(trim(trim(input.corp_ra_address_line1,left,right) + ' ' +													                        
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
		self.corp_ra_state 			    	:= clean_address[115..116];
		self.corp_ra_zip5 		      		:= clean_address[117..121]; 
		self.corp_ra_zip4 		      		:= clean_address[122..125];
		self.corp_ra_cart 		      		:= clean_address[126..129];
		self.corp_ra_cr_sort_sz 	 		:= clean_address[130];
		self.corp_ra_lot 		      		:= clean_address[131..134];
		self.corp_ra_lot_order 	  			:= clean_address[135];
		self.corp_ra_dpbc  	      			:= clean_address[136..137];
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
	
//--------------------------------- Clean Corp Records -----------------------------------------------------------//

	corp2.Layout_Corporate_Direct_Cont_In CleanConts(Corp2_Mapping.Layout_ContPreClean   input) := transform
	
		string73 tempname 					:= if(input.cont_name = '',
												'',
												Address.CleanPersonFML73(input.cont_name));
		pname 								:= Address.CleanNameFields(tempName);
		cname 								:= DataLib.companyclean(input.cont_name);
		keepPerson 							:= Corp2.Rewrite_Common.IsPerson(input.cont_name);
		keepBusiness 						:= Corp2.Rewrite_Common.IsCompany(input.cont_name);
		
		self.cont_title1					:= if(keepPerson, pname.title, '');
		self.cont_fname1 					:= if(keepPerson, pname.fname, '');
		self.cont_mname1 					:= if(keepPerson, pname.mname, '');
		self.cont_lname1 					:= if(keepPerson, pname.lname, '');
		self.cont_name_suffix1 				:= if(keepPerson, pname.name_suffix,'');
		self.cont_score1 					:= if(keepPerson, pname.name_score, '');	
		self.cont_cname1 					:= if(keepBusiness, cname[1..70],'');
		self.cont_cname1_score 				:= if(keepBusiness, pname.name_score,'');				
		string182 clean_address 			:= Address.CleanAddress182(trim(trim(input.cont_address_line1,left,right) + ' ' + 														                        
												trim(input.cont_address_line2,left,right),left,right),														                   
												trim(trim(input.cont_address_line3,left,right) + ', ' +
												trim(input.cont_address_line4,left,right) + ' ' +
												trim(input.cont_address_line5,left,right),left,right));
		self.cont_prim_range    			:= clean_address[1..10];
		self.cont_predir 	      			:= clean_address[11..12];
		self.cont_prim_name 	  			:= clean_address[13..40];
		self.cont_addr_suffix   			:= clean_address[41..44];
		self.cont_postdir 	    			:= clean_address[45..46];
		self.cont_unit_desig 	  			:= clean_address[47..56];
		self.cont_sec_range 	  			:= clean_address[57..64];
		self.cont_p_city_name	  			:= clean_address[65..89];
		self.cont_v_city_name	  			:= clean_address[90..114];
		self.cont_state 					:= clean_address[115..116];
		self.cont_zip5 		      			:= clean_address[117..121];
		self.cont_zip4 		      			:= clean_address[122..125];
		self.cont_cart 		      			:= clean_address[126..129];
		self.cont_cr_sort_sz 	 			:= clean_address[130];
		self.cont_lot 		      			:= clean_address[131..134];
		self.cont_lot_order 	  			:= clean_address[135];
		self.cont_dpbc 		      			:= clean_address[136..137];
		self.cont_chk_digit 	  			:= clean_address[138];
		self.cont_rec_type		  			:= clean_address[139..140];
		self.cont_ace_fips_st	  			:= clean_address[141..142];
		self.cont_county 	  				:= clean_address[143..145];
		self.cont_geo_lat 	    			:= clean_address[146..155];
		self.cont_geo_long 	    			:= clean_address[156..166];
		self.cont_msa 		      			:= clean_address[167..170];
		self.cont_geo_blk					:= clean_address[171..177];
		self.cont_geo_match 	  			:= clean_address[178];
		self.cont_err_stat 	    			:= clean_address[179..182];
		self								:= input;		
		self			 					:= [];
		end;
 
//--------------------- Merge CorpEntity and RegisteredAgent ------------------------------------------
	
	Layouts_Raw_Input.CorpJoin1Layout MergeCorpAgent(Layouts_Raw_Input.CorpEntity l, Layouts_Raw_Input.RegisterAgent r ) := transform

		self 	:= l;
		self	:= r;
		end;

	corpJoin1 	:= join(Files_Raw_Input.CorpEntity(fileDate), Files_Raw_Input.RegisterAgent(fileDate),
						trim(left.RegAgentID,left,right) = trim(right.RegAgentID,left,right),
						MergeCorpAgent(left,right),
						left outer);
						
//--------------------- Merge CorpJoin1 and StateCodeTable ------------------------------------------
	
	Layouts_Raw_Input.CorpJoin2Layout   getStateName(Layouts_Raw_Input.CorpJoin1Layout input, StateTypeCodeLayout r) := transform
		    
			self.forgnStateDesc := trimUpper(r.stateDesc);																														
			self    			:= input;
			end;

	corpJoin2 := 	join(corpJoin1 ,StateCodeTable,
						trimUpper(left.qualifyingState) = trimUpper(right.stateCode),
						getStateName(left,right),
						left outer, lookup);
												
//--------------------- Merge CorpJoin2 and CntryCodeTable ------------------------------------------
	
	Layouts_Raw_Input.CorpJoin3Layout   getCountryName(Layouts_Raw_Input.CorpJoin2Layout input, CntryTypeCodeLayout r) := transform
		    
			self.countryDesc := trimUpper(r.cntryDesc);																															
			self    		 := input;
			end;

	corpJoin3 := 	join(corpJoin2 ,CntryCodeTable,
						trimUpper(left.cntryCode) = trimUpper(right.cntryCode2),
						getCountryName(left,right),
						left outer, lookup);
						
//--------------------- Merge CorpJoin3 and CorpCodeTable ------------------------------------------
	
	Layouts_Raw_Input.CorpJoin4Layout   getCorpCodes(Layouts_Raw_Input.CorpJoin3Layout input, CorpTypeCodeLayout r) := transform
		    
			self.typeDesc 		:= trimUpper(r.corpDesc);
		    self.durationDesc   := trimUpper(r.corpDesc3);
			self    		 	:= input;
			end;

	corpJoin4 := 	join(corpJoin3 ,CorpCodeTable,
						trimUpper(left.corpType) = trimUpper(right.corpCode),
						getCorpCodes(left,right),
						left outer, lookup);						
			
//--------------------- Merge Actions and FilingCodeTable ------------------------------------------			

	Layouts_Raw_Input.CorpActionDesc getEventDesc(Layouts_Raw_Input.CorpAction l, FilingTypeCodeLayout r) := transform
	self.description	  := trimUpper(r.filingDesc);
	self         		  := l;
	end; 

	

	actionsDesc 		  := join(Files_Raw_Input.CorpAction(fileDate) ,FilingCodeTable,						
										  trimUpper(left.serviceTypeCode) = trimUpper(right.filingCode),							
										  getEventDesc(left,right),
										  left outer, lookup);
//------------------------------------- Corps --------------------------------------------------------------//	

    mapCorp   		:= project(corpJoin4,corpMainTransform(left));
	
	mapCorpForgn	:= project(corpJoin4,corpForgnNameTransform(left));	
 
	mapCorpTM		:= project(corpJoin4,corpTMTransform(left));
	
	allCorps        := mapCorp + mapCorpForgn + mapCorpTM;
	
	distCorps  		:= distribute(allCorps,hash64(corp_orig_sos_charter_nbr));

	sortedCorps     := sort(distCorps,corp_orig_sos_charter_nbr,local);
   
	cleanedCorps 	:= project(sortedCorps,CleanCorps(left));
	
//------------------------------------- Conts --------------------------------------------------------------//	

	Layouts_Raw_Input.CorpEntityNewCorpOfficers MergeCorpOfficer(Layouts_Raw_Input.NewCorpOfficers r,Layouts_Raw_Input.CorpJoin3Layout l) := transform
		self 			:= l;
		self			:= r;
		end; 
	
	joinCorpOfficer		:= distribute(join(dedupedOfficers,corpJoin3,
										trim(left.AcctNumber,left,right) = trim(right.AcctNumber,left,right),
										MergeCorpOfficer(left,right),
										right outer),hash32(AcctNumber)) ;

	mapCont1			:= project(corpJoin4,contTransform1(left));
	
	mapCont2			:= project(joinCorpOfficer,contTransform2(left));
	
	allConts            := mapCont1 + mapCont2;
	
	distConts  			:= distribute(allConts,hash64(corp_orig_sos_charter_nbr));

	sortedConts     	:= sort(distConts,corp_orig_sos_charter_nbr,local);

	cleanedConts 	    := project(sortedConts,cleanConts(left));
		
//------------------------------------- ARs --------------------------------------------------------------//	
      	
    MapArRpt			:= project(actionsDesc,arTransform1(left));

	MapArMain			:= project(actionsDesc,arTransform2(left));
	
	MapAr				:= MapArRpt + MapArMain;

//------------------------------------- Events --------------------------------------------------------------//		

	mapEvent			:= project(actionsDesc,eventTransform(left));
	
//------------------------------------- Processes ----------------------------------------------------------//														

	VersionControl.macBuildNewLogicalFile('~thor_data400::in::corp2::'+version+'::ar_ne'		,MapAr				,ar_out		,,,pOverwrite);		
	VersionControl.macBuildNewLogicalFile('~thor_data400::in::corp2::'+version+'::event_ne'	,mapEvent			,event_out,,,pOverwrite);
	VersionControl.macBuildNewLogicalFile('~thor_data400::in::corp2::'+version+'::corp_ne'	,cleanedCorps ,corp_out	,,,pOverwrite);
	VersionControl.macBuildNewLogicalFile('~thor_data400::in::corp2::'+version+'::cont_ne'	,CleanedConts	,cont_out	,,,pOverwrite);
                                                                                                                                                         
	mapNE 				:= parallel(
				 ar_out		
				,event_out
				,corp_out	
				,cont_out
	);

		result := 
		sequential(
			 if(pshouldspray = true,fSprayFiles('ne',filedate,pOverwrite := pOverwrite))
			,mapNE
			,parallel(
				 fileservices.addsuperfile('~thor_data400::in::corp2::sprayed::corp'	,'~thor_data400::in::corp2::'+version+'::corp_ne')
				,fileservices.addsuperfile('~thor_data400::in::corp2::sprayed::ar'		,'~thor_data400::in::corp2::'+version+'::ar_ne')
				,fileservices.addsuperfile('~thor_data400::in::corp2::sprayed::event'	,'~thor_data400::in::corp2::'+version+'::event_ne')
				,fileservices.addsuperfile('~thor_data400::in::corp2::sprayed::cont'	,'~thor_data400::in::corp2::'+version+'::cont_ne')																															  
			)
		);
	
	return result;
	end; 
end;
