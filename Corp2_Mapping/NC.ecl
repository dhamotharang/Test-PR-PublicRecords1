import Corp2,ut, lib_stringlib, _validate, Address, _control, versioncontrol; 
 export NC:= MODULE;  // NC module has Nine vendor layouts 

	export Layouts_Raw_Input := MODULE;
       
     export  Names:= record
   	     string7 	EnameID;
   		 string7 	Name_EntityID;
   		 string255	Ename;
   		 string2    NtypeID;
   		 string30	Prefix;
   		 string30	MiddleName;
   		 string30	LastName;
   		 string30	FirstName;
   		 string30	Suffix;
   		 string1 	Name_lf;
	 end;
     export  Addresses:= record
   	     string10 	AddressID;
   		 string7 	Address_EntityID;
   		 string2	AtypeID;
   		 string56   Addr1;
   		 string69	Addr2;
   		 string50	Addr3;
   		 string30	City;
   		 string2	State;
   		 string10 	Zip;
   		 string50	CountyName;
   		 string50	Country;
   		 string1 	Address_lf;
	 end;
	 
	 export  Corporations:= record
		 string7 	Corp_PitemID;	
		 string7	Corp_EntityID;	
		 string10	OfficeAddrID;
		 string10	OfficeMailID;  
		 string7	AgentEntityID;
		 string4	CorpType;
		 string9	CorpNum;
		 string2	Status;
		 string1	Citzenship;	
		 string19	DateFormed;	
		 string19	DissolveDate;
		 string50	Duration;  
		 string25	CountyOfInc;
		 string15	CountryFileNum;
		 string2	StateOfInc;
		 string30	CountryOfInc;
	     string255	Purpose;	
		 string50	Profession;	
		 string1	Managed;
		 string1	Members;  
		 string1	Directors;
		 string1	MemberManaged;
		 string2	FiscalMonth;
		 string19	AnnualRptDueDate;
		 string2	OldStatus;	
		 string1	Corp_lf;
	 end;
	 
	 export  Filings:= record
		 string8	EventLogID;	
		 string7	Filings_PitemID;	
		 string15	DocumentID;
		 string4	DocumentType;  
		 string10	FilingDate;
		 string10	EffectiveDate;
		 string1	lf;
	 end;
	 
	 export  Stock:= record
		 
		 string7	StockID;
		 string7	Stock_PitemID;	
		 string29	Created;	
		 string40	Class;
		 string18	Shares;  
		 string1	NoParValue;
		 string21	ParValue;
		 string1	lf;
	 end;
	 
	 export  NameReservations:= record
		 string7	EntityID;
		 string12	DocmentID;
		 string4	DocmentType;
		 string19	FilingDate;	 
		 string19	ExpirationDate;
		 string2	NameRes_StateOfInc;
		 string20	NameRes_CountryOfInc;	 
		 string1	NameRes_lf;
	 end;	
	 
	 export  Officers:= record
		 string7	Offi_PitemID;
		 string7	Offi_EntityID;
		 string8	Offi_Tittle;
		 string1	Offi_lf;
		 
	 end;
	 
	 export  Partners:= record
		 string7	Part_PitemID;
		 string7	Part_EntityID; 
		 string8	Part_Tittle;
		 string1	Part_lf;
		 
	 end;
	 
	 export  Directors:= record
		 	
		 string7	Direc_PitemID;
		 string7	Direc_EntityID ;
		 string8	Direc_Tittle;
		 string1	Direc_lf;
		
	 end;
	 

	 
    end;// end of Layouts_Raw_Input module
	
	
	  	   	export Files_Raw_Input := MODULE;
	
		 export ADDRESSES(string fileDate)          := 	distribute(dataset(ut.foreign_prod+'thor_data400::in::corp2::'+fileDate+'::Addresses::nc',
														        layouts_Raw_Input.Addresses,CSV(HEADING(1),SEPARATOR(['\t']), TERMINATOR(['\r\n', '\n']))),hash32(Address_EntityID,AtypeID));
		 export NAMES(string fileDate)          	:=  distribute(dataset(ut.foreign_prod+'thor_data400::in::corp2::'+fileDate+'::Names::nc',
														        layouts_Raw_Input.Names,CSV(HEADING(1),SEPARATOR(['\t']), TERMINATOR(['\r\n', '\n']))),hash64(Name_EntityID,NtypeID));
		 export CORPORATIONS(string fileDate)     	:=  distribute(dataset(ut.foreign_prod+'thor_data400::in::corp2::'+fileDate+'::Corporations::nc',
														        layouts_Raw_Input.Corporations,CSV(HEADING(1),SEPARATOR(['\t']), TERMINATOR(['\r\n', '\n']))),hash64(Corp_EntityID,AgentEntityID,Corp_PitemID));
														
		 export FILINGS(string fileDate)            := 	distribute(dataset(ut.foreign_prod+'thor_data400::in::corp2::'+fileDate+'::Filings::nc',
		                                                        layouts_Raw_Input.Filings,CSV(HEADING(1),SEPARATOR(['\t']), TERMINATOR(['\r\n', '\n']))),hash32(Filings_PitemID));
		 export STOCK (string fileDate)             :=  distribute(dataset(ut.foreign_prod+'thor_data400::in::corp2::'+fileDate+'::Stock::nc',
   		                                                        layouts_Raw_Input.Stock,CSV(HEADING(1),SEPARATOR(['\t']), TERMINATOR(['\r\n', '\n']))),hash32(Stock_PitemID));
		 export NAMERESERVATIONS(string fileDate)   := 	distribute(dataset(ut.foreign_prod+'thor_data400::in::corp2::'+fileDate+'::NameReservations::nc',
		                                                        layouts_Raw_Input.NameReservations,CSV(HEADING(1),SEPARATOR(['\t']), TERMINATOR(['\r\n', '\n']))),hash32(EntityID));
																
		 export OFFICERS(string fileDate)    		:= 	distribute( dataset(ut.foreign_prod+'thor_data400::in::corp2::'+fileDate+'::Officers::nc',
		                                                        layouts_Raw_Input.Officers,CSV(HEADING(1),SEPARATOR(['\t']), TERMINATOR(['\r\n', '\n']))),hash32(Offi_EntityID));
																
         export PARTNERS (string fileDate)          :=  distribute(dataset(ut.foreign_prod+'thor_data400::in::corp2::'+fileDate+'::Partners::nc',
		                                                        layouts_Raw_Input.Partners,CSV(HEADING(1),SEPARATOR(['\t']), TERMINATOR(['\r\n', '\n']))),hash32(Part_EntityID));
																																
	     export DIRECTORS(string fileDate)          :=  distribute(dataset(ut.foreign_prod+'thor_data400::in::corp2::'+fileDate+'::Directors::nc',
		                                                        layouts_Raw_Input.Directors,CSV(HEADING(1)	,SEPARATOR(['\t']), TERMINATOR(['\r\n', '\n']))),hash32(Direc_EntityID));
	end;
	
	
    NameRes_Name:= record
		 string7	EntityID;
		 string12	DocmentID;
		 string4	DocmentType;
		 string19	FilingDate;	 
		 string19	ExpirationDate;
		 string2	NameRes_StateOfInc;
		 string20	NameRes_CountryOfInc;	 
		 string1	NameRes_lf;
		 
	     string7 	EnameID;
   		 string7 	Name_EntityID;
   		 string255	Ename;
   		 string2    NtypeID;
   		 string30	Prefix;
   		 string30	MiddleName;
   		 string30	LastName;
   		 string30	FirstName;
   		 string30	Suffix;
   		 string1 	Name_lf;

		 

	 end;
	 

		
		
	   Corp_Name:= record
		 string7 	Corp_PitemID;	
		 string7	Corp_EntityID;	
		 string10	OfficeAddrID;
		 string10	OfficeMailID;  
		 string7	AgentEntityID;
		 string4	CorpType;
		 string9	CorpNum;
		 string2	Status;
		 string1	Citzenship;	
		 string19	DateFormed;	
		 string19	DissolveDate;
		 string50	Duration;  
		 string25	CountyOfInc;
		 string15	CountryFileNum;
		 string2	StateOfInc;
		 string30	CountryOfInc;
	     string255	Purpose;	
		 string50	Profession;	
		 string1	Managed;
		 string1	Members;  
		 string1	Directors;
		 string1	MemberManaged;
		 string2	FiscalMonth;
		 string19	AnnualRptDueDate;
		 string2	OldStatus;	
		 string1	Corp_lf;
		
   	     string7 	EnameID;
   		 string7 	Name_EntityID;
   		 string255	Ename;
   		 string2    NtypeID;
   		 string30	Prefix;
   		 string30	MiddleName;
   		 string30	LastName;
   		 string30	FirstName;
   		 string30	Suffix;
   		 string1 	Name_lf;

		 

	 end;
	 
	Corp_Name_Add:= record
		 Corp_Name;
		 
   	     string10 	AddressID;
   		 string7 	Address_EntityID;
   		 string2	AtypeID;
   		 string56   Addr1;
   		 string69	Addr2;
   		 string50	Addr3;
   		 string30	City;
   		 string2	State;
   		 string10 	Zip;
   		 string50	CountyName;
   		 string50	Country;
   		 string1 	Address_lf;
		 

    end;
	
	
	
	Corp_StockFile := record
	     string7	StockID;
		 string7	Stock_PitemID;	
		 string29	Created;	
		 string40	Class;
		 string18	Shares;  
		 string1	NoParValue;
		 string21	ParValue;
		 string1	Stock_lf;
		 
		 
         string7 	Corp_PitemID;	
		 string7	Corp_EntityID;	
		 string10	OfficeAddrID;
		 string10	OfficeMailID;  
		 string7	AgentEntityID;
		 string4	CorpType;
		 string9	CorpNum;
		 string2	Status;
		 string1	Citzenship;	
		 string19	DateFormed;	
		 string19	DissolveDate;
		 string50	Duration;  
		 string25	CountyOfInc;
		 string15	CountryFileNum;
		 string2	StateOfInc;
		 string30	CountryOfInc;
	     string255	Purpose;	
		 string50	Profession;	
		 string1	Managed;
		 string1	Members;  
		 string1	Directors;
		 string1	MemberManaged;
		 string2	FiscalMonth;
		 string19	AnnualRptDueDate;
		 string2	OldStatus;	
		 string1	Corp_lf;
	end; 
	
		 Corp_Filings := record
		 string8	EventLogID;	
		 string7	Filings_PitemID;	
		 string15	DocumentID;
		 string4	DocumentType;  
		 string10	FilingDate;
		 string10	EffectiveDate;
		 string1	lf;
		 
		 string7 	Corp_PitemID;	
		 string7	Corp_EntityID;	
		 string10	OfficeAddrID;
		 string10	OfficeMailID;  
		 string7	AgentEntityID;
		 string4	CorpType;
		 string9	CorpNum;
		 string2	Status;
		 string1	Citzenship;	
		 string19	DateFormed;	
		 string19	DissolveDate;
		 string50	Duration;  
		 string25	CountyOfInc;
		 string15	CountryFileNum;
		 string2	StateOfInc;
		 string30	CountryOfInc;
	     string255	Purpose;	
		 string50	Profession;	
		 string1	Managed;
		 string1	Members;  
		 string1	Directors;
		 string1	MemberManaged;
		 string2	FiscalMonth;
		 string19	AnnualRptDueDate;
		 string2	OldStatus;	
		 string1	Corp_lf;
		 
	 end;
	 
     Off_Part_Direc:= record
	     string7	Offi_PitemID;
		 string7	Offi_EntityID;
		 string8	Offi_Tittle;
		 string1	Offi_lf;
		
		
		 string7	Part_PitemID;
		 string7	Part_EntityID; 
		 string8	Part_Tittle;
		 string1	Part_lf;
	
		 string7	Direc_PitemID;
		 string7	Direc_EntityID ;
		 string8	Direc_Tittle;
		 string1	Direc_lf;
	end;
	 
	 Off_Part_Direc_Name:= record
	  
		 Off_Part_Direc;
		 
         string7 	EnameID;
   		 string7 	Name_EntityID;
   		 string255	Ename;
   		 string2    NtypeID;
   		 string30	Prefix;
   		 string30	MiddleName;
   		 string30	LastName;
   		 string30	FirstName;
   		 string30	Suffix;
   		 string1 	Name_lf;

		

     end;
	 
	Off_Part_Direc_Name_Corp:= record
	   Off_Part_Direc_Name;
	   
	   	string7 	Corp_PitemID;	
		 string7	Corp_EntityID;	
		 string10	OfficeAddrID;
		 string10	OfficeMailID;  
		 string7	AgentEntityID;
		 string4	CorpType;
		 string9	CorpNum;
		 string2	Status;
		 string1	Citzenship;	
		 string19	DateFormed;	
		 string19	DissolveDate;
		 string50	Duration;  
		 string25	CountyOfInc;
		 string15	CountryFileNum;
		 string2	StateOfInc;
		 string30	CountryOfInc;
	     string255	Purpose;	
		 string50	Profession;	
		 string1	Managed;
		 string1	Members;  
		 string1	Directors;
		 string1	MemberManaged;
		 string2	FiscalMonth;
		 string19	AnnualRptDueDate;
		 string2	OldStatus;	
		 string1	Corp_lf;
	   

     end;
	
		reformatDate(string rDate) := function
   	       return StringLib.StringFindReplace(StringLib.StringFilterOut(rDate[1..10],'-'),'-','');
   			
   		end;
		reformatDate12(string rDate) := function
			
			string2 outMM := if(rDate[2] = '/',
								'0'+ rDate[1],
								rDate[1..2]);
			string2 outDD := if(rDate[length(rDate)-6] = '/',
								'0'+ rDate[length(rDate)-5],
								rDate[length(rDate)-6..length(rDate)-5]);
			string8 newDate := rDate[length(rDate)-3..]+outMM+outDD;
			
			return  if(newDate[7]='',newDate[1..6]+'0'+newDate[8..],newDate);
		end;

        trimUpper(string s) := function
			return trim(stringlib.StringToUppercase(s),left,right);
		end;
				
	    ForgnStateDescLayout := record,MAXLENGTH(100)
			string code;
			string desc;
		end; 
	
		ForgnStateTable := dataset(_dataset().foreign_prod + 'thor_data400::lookup::corp2::corpstateprovince_table', ForgnStateDescLayout, CSV(SEPARATOR([',']), TERMINATOR(['\r\n', '\n'])));
		
		DocumentTypeLayout := record,MAXLENGTH(500)
               string Doctype;
               string Docdesc;

        end; 

        DocumentTypeTable := dataset(_dataset().foreign_prod + 'thor_data400::lookup::corp2::DocumentType::nc', DocumentTypeLayout, CSV(SEPARATOR([',']), TERMINATOR(['\r\n', '\n'])));
		
		
		
  export Update(string fileDate, string version, boolean pShouldSpray = _Dataset().bShouldSpray, boolean pOverwrite = false) := function
  


		

	    corp2_mapping.Layout_CorpPreClean corpLegalRATransform(Corp_Name_Add input, Corp_Name r):=transform,skip((trim(input.AtypeID,left,right)='1' or trim(input.AtypeID,left,right)='8' ) and 
		                                                                                                                (string)(integer)input.CorpNum= '0')
		                                                                                                                
		                                                                                                   
     	    self.dt_first_seen					  :=fileDate;
			self.dt_last_seen					  :=fileDate;
			self.dt_vendor_first_reported		  :=fileDate;
			self.dt_vendor_last_reported		  :=fileDate;
			self.corp_ra_dt_first_seen			  :=fileDate;
			self.corp_ra_dt_last_seen			  :=fileDate;
			self.corp_key					      :='37-'+trim(input.CorpNum, left, right);  
			self.corp_vendor				      :='37';
			self.corp_state_origin			      :='NC';
			self.corp_process_date				  :=fileDate;    
     	    self.corp_orig_sos_charter_nbr        :=trim(input.CorpNum, left, right);
			
			self.corp_ln_name_type_cd             :=map(trim(input.NtypeID,left,right)='3'=>'P',
			                                            trim(input.NtypeID,left,right)='13'=>'O',
														trim(input.NtypeID,left,right)='15'=>'P',
			                                            '01');
														
			self.corp_ln_name_type_desc           :=map(trim(input.NtypeID,left,right)='3'=>'PRIOR',
			                                            trim(input.NtypeID,left,right)='13'=>'OTHER',
														trim(input.NtypeID,left,right)='15'=>'PRIOR',
			                                            'LEGAL');
															
												

			self.corp_src_type                    :='SOS';
		   self.corp_legal_name                  :=if(r.Ename<>'',trimUpper(r.Ename),'');
			

			self.corp_status_date                 :=if(input.DissolveDate<>'' and _validate.date.fIsValid(reformatDate(input.DissolveDate)) and 
			                                         _validate.date.fIsValid(reformatDate(input.DissolveDate),_validate.date.rules.DateInPast) and
													 (string)(integer)reformatDate(input.DissolveDate) <> '0',
												      reformatDate(input.DissolveDate),'');
													  
   		    self.corp_status_cd                   :=if(input.Status<>'',trim(input.Status,left,right),'');
            self.corp_status_desc                 :=map(trim(input.Status,left,right)='1'=>'RESERVED NAME',
														trim(input.Status,left,right)='2'=>'CURRENT-ACTIVE',
														trim(input.Status,left,right)='3'=>'CANCELLED',
														trim(input.Status,left,right)='5'=>'AUTO DISSOLVE',
														trim(input.Status,left,right)='8'=>'ADMINISTRATIVELY DISSOLVED',
														trim(input.Status,left,right)='9'=>'CONVERTED',
														trim(input.Status,left,right)='10'=>'SUSPENDED',
														trim(input.Status,left,right)='11'=>'WITHDRAWN BY MERGER',
														trim(input.Status,left,right)='12'=>'WITHDRAWN',
														trim(input.Status,left,right)='13'=>'REVOKED',
														trim(input.Status,left,right)='14'=>'DISSOLVED',
														trim(input.Status,left,right)='15'=>'VOL SURRENDER',
														trim(input.Status,left,right)='16'=>'COURT ORDERED DISSOLUTION',
														trim(input.Status,left,right)='17'=>'TO FED BANK',
														trim(input.Status,left,right)='18'=>'TO FOREIGN INS',
														trim(input.Status,left,right)='19'=>'JUDICIAL DISSOLUTION',
														trim(input.Status,left,right)='20'=>'EXPIRED',
														trim(input.Status,left,right)='21'=>'CONSOLIDATED',
														trim(input.Status,left,right)='22'=>'MULTIPLE',
														trim(input.Status,left,right)='23'=>'APPLIED TO WITHDRAW',
														trim(input.Status,left,right)='24'=>'MERGED','');														
		   
			corp_Duration                         :=if (lib_stringlib.StringLib.StringFind(trim(input.Duration,left,right),'/',1) <>0,reformatDate12(trim(input.Duration,left,right)),
		                                               if(lib_stringlib.StringLib.StringFind(trimUpper(input.Duration),'PERPETUAL',1) <>0,'PERPETUAL',
                                                        map(trimUpper(input.Duration[1..3])='DEC'=>reformatDate12('12'+'/'+input.Duration[5..6]+'/'+input.Duration[8..11]),   
														trimUpper(input.Duration[1..3])='NOV'=>reformatDate12('11'+'/'+input.Duration[5..6]+'/'+input.Duration[8..11]),   
														trimUpper(input.Duration[1..3])='OCT'=>reformatDate12('10'+'/'+input.Duration[5..6]+'/'+input.Duration[8..11]),    
														trimUpper(input.Duration[1..3])='SEP'=>reformatDate12('09'+'/'+input.Duration[5..6]+'/'+input.Duration[8..11]),      
														trimUpper(input.Duration[1..3])='AUG'=>reformatDate12('08'+'/'+input.Duration[5..6]+'/'+input.Duration[8..11]),     
														trimUpper(input.Duration[1..3])='JUL'=>reformatDate12('07'+'/'+input.Duration[5..6]+'/'+input.Duration[8..11]),    
														trimUpper(input.Duration[1..3])='JUN'=>reformatDate12('06'+'/'+input.Duration[5..6]+'/'+input.Duration[8..11]),  
														trimUpper(input.Duration[1..3])='MAY'=>reformatDate12('05'+'/'+input.Duration[5..6]+'/'+input.Duration[8..11]),
														trimUpper(input.Duration[1..3])='APR'=>reformatDate12('04'+'/'+input.Duration[5..6]+'/'+input.Duration[8..11]),  
														trimUpper(input.Duration[1..3])='MAR'=>reformatDate12('03'+'/'+input.Duration[5..6]+'/'+input.Duration[8..11]), 
														trimUpper(input.Duration[1..3])='FEB'=>reformatDate12('02'+'/'+input.Duration[5..6]+'/'+input.Duration[8..11]),
														trimUpper(input.Duration[1..3])='JAN'=>reformatDate12('01'+'/'+input.Duration[5..6]+'/'+input.Duration[8..11]),
														if(lib_stringlib.StringLib.StringFind(trim(input.Duration,left,right),'-',1) <>0,reformatDate(trim(input.Duration,left,right)),''))));

		    Corp_Duration1                        :=if(ut.isNumeric(input.Duration),input.Duration,'');									
		    self.corp_term_exist_cd               :=if (Corp_Duration='PERPETUAL','P',if(ut.isNumeric(Corp_Duration1),'N',if((string)(integer)corp_Duration <> '0'and _validate.date.fIsValid(corp_Duration),'D','')));
			self.corp_term_exist_exp              :=if (ut.isNumeric(Corp_Duration1),Corp_Duration1,if((string)(integer)corp_Duration <> '0'and _validate.date.fIsValid(corp_Duration),corp_Duration,''));  
			self.corp_term_exist_desc             :=if (Corp_Duration='PERPETUAL','PERPETUAL',if(ut.isNumeric(Corp_Duration1),'NUMBER OF YEARS',if((string)(integer)corp_Duration <> '0'and _validate.date.fIsValid(corp_Duration),'EXPIRATION DATE','')));
			 
			

			self.corp_orig_bus_type_desc          :=if(input.Purpose<>'',trimUpper(input.Purpose),''); 
			self.corp_entity_desc				  :=if(input.Profession<>'',trimUpper(input.Profession),'');
			self.corp_inc_county                  :=if(input.CountyOfInc<>'' and trimUpper(input.CountyOfInc)<>'UNKNOWN',trimUpper(input.CountyOfInc),'');
			
			self.corp_inc_date                    :=if(trimUpper(input.StateOfInc) = 'NC' or (input.StateOfInc)='' and  _validate.date.fIsValid(reformatDate(input.DateFormed)) and 
			                                         _validate.date.fIsValid(reformatDate(input.DateFormed),_validate.date.rules.DateInPast) and
													 (string)(integer)reformatDate(input.DateFormed) <> '0',
												      reformatDate(input.DateFormed),'');
													  
            self.corp_forgn_date                  :=if(trimUpper(input.StateOfInc) <> 'NC' and (input.StateOfInc)<>'' and  _validate.date.fIsValid(reformatDate(input.DateFormed)) and 
			                                         _validate.date.fIsValid(reformatDate(input.DateFormed),_validate.date.rules.DateInPast) and
													 (string)(integer)reformatDate(input.DateFormed) <> '0',
												     reformatDate(input.DateFormed),'');
													 
		    self.corp_anniversary_month			  :=map(trim(input.FiscalMonth,left,right)='1'=>'JANUARY',  
														trim(input.FiscalMonth,left,right)='2'=>'FEBRUARY', 
														trim(input.FiscalMonth,left,right)='3'=>'MARCH',    
														trim(input.FiscalMonth,left,right)='4'=>'APRIL',    
														trim(input.FiscalMonth,left,right)='5'=>'MAY',      
														trim(input.FiscalMonth,left,right)='6'=>'JUNE',     
														trim(input.FiscalMonth,left,right)='7'=>'JULY',    
														trim(input.FiscalMonth,left,right)='8'=>'AUGUST',  
														trim(input.FiscalMonth,left,right)='9'=>'SEPTEMBER',
														trim(input.FiscalMonth,left,right)='10'=>'OCTOBER',  
														trim(input.FiscalMonth,left,right)='11'=>'NOVEMBER', 
														trim(input.FiscalMonth,left,right)='12'=>'DECEMBER', '');
														
  		    self.corp_inc_state                        :=if(trimUpper(input.StateOfInc) = 'NC' or (input.StateOfInc)='','NC','');
            self.corp_forgn_state_cd                   :=if(trimUpper(input.StateOfInc) <>'NC'and (input.StateOfInc)<>''and (input.StateOfInc)<>'XX',trimUpper(input.StateOfInc) ,'');
			
			self.corp_foreign_domestic_ind             :=map(trimUpper(input.Citzenship)='D'=>'D',
														    trimUpper(input.Citzenship)='F'=>'F','');
															
            self.corp_orig_org_structure_cd            :=if(input.CorpType<>'',trimUpper(input.CorpType),'');
            self.corp_orig_org_structure_desc          :=map(trimUpper(input.CorpType)='BK'=>'BANK',
															trimUpper(input.CorpType)='BUS'=>'BUSINESS CORPORATION',
															trimUpper(input.CorpType)='COOP'=>'AGRICUTURAL MARKETING ASSOCIATION',
															trimUpper(input.CorpType)='DS'=>'DENTAL SERVICE CORPORATION',
															trimUpper(input.CorpType)='EMC'=>'ELECTRIC MEMBERSHIP COOPERATIVE',
															trimUpper(input.CorpType)='FAIR'=>'COUNTY AGRICULTURAL FAIR',
															trimUpper(input.CorpType)='INS'=>'INSURANCE COMPANY',
															trimUpper(input.CorpType)='LLC'=>'LIMITED LIABILITY COMPANY',
															trimUpper(input.CorpType)='LLP'=>'LIMITED LIABILITY PARTNERSHIP',
															trimUpper(input.CorpType)='LP'=>'LIMITED PARTNERSHIP',
															trimUpper(input.CorpType)='MBA'=>'MUTUAL BURIAL ASSOCIATION',
															trimUpper(input.CorpType)='MUN'=>'MUNICIPAL',
															trimUpper(input.CorpType)='MUT'=>'MUTUAL ASSOCIATION',
															trimUpper(input.CorpType)='NATB'=>'NATIONAL BANKING ASSOCIATION',
															trimUpper(input.CorpType)='NP'=>'NON-PROFIT CORPORATION',
															trimUpper(input.CorpType)='OTH'=>'OTHER',
															trimUpper(input.CorpType)='PA'=>'PROFESSIONAL CORPORATION',
															trimUpper(input.CorpType)='PLLC'=>'PROFESSIONAL LIMITED LIABILITY COMPANY',
															trimUpper(input.CorpType)='PTA'=>'PUBLIC TRANSPORTATION AUTHORITY',
															trimUpper(input.CorpType)='RR'=>'RAILROAD',
															trimUpper(input.CorpType)='S&L'=>'SAVINGS & LOAN ASSOCIATION',
															trimUpper(input.CorpType)='SSB'=>'STATE SAVINGS BANK','');
			self.corp_for_profit_ind                  :=if(trimUpper(input.CorpType)='NP','N','');											
		  
			
		  				
		    self.corp_ra_name                         :=if( (trim(input.AtypeID,left,right)='10' or trim(input.AtypeID,left,right)='13' ),if(input.Ename<>'',trimUpper(input.Ename),''),''); 
			self.corp_ra_title_desc                   :=if( (trim(input.AtypeID,left,right)='10' or trim(input.AtypeID,left,right)='13' ),if(input.Ename<>'','REGISTERED AGENT',''),'');
			
            concatAddrFields						  := if( (trim(input.AtypeID,left,right)='10' or trim(input.AtypeID,left,right)='13' ),
			                                                         if ((string)(integer) input.Addr2 <> '0',
																		if ((string)(integer) input.Addr3 <> '0',
																				trimUpper(input.Addr1 + ' ' + input.Addr2 + ' ' + input.Addr3),
																				trimUpper(input.Addr1 + ' ' + input.Addr2)
																			),
																		if ((string)(integer) input.Addr3 <> '0',
																				trimUpper(input.Addr1 + ' ' + input.Addr3),
																				trimUpper(input.Addr1)
																			)
																	),'');
												
			self.corp_ra_address_line1 			  := if( (trim(input.AtypeID,left,right)='10' or trim(input.AtypeID,left,right)='13' ),trimUpper(concatAddrFields), '');

			self.corp_ra_address_line2			  := if( (trim(input.AtypeID,left,right)='10' or trim(input.AtypeID,left,right)='13' ),trimUpper(input.City),'');
														
			self.corp_ra_address_line3			  := if( (trim(input.AtypeID,left,right)='10' or trim(input.AtypeID,left,right)='13' ),if (trimUpper(input.State) <> 'XX' and not ut.isNumeric(trim(input.State,left,right)),
																		trimUpper(input.State),''
																	),'');
												
			self.corp_ra_address_line4			  := if( (trim(input.AtypeID,left,right)='10' or trim(input.AtypeID,left,right)='13' ),if(input.Zip<>'' and (string)(integer)trim(input.Zip,left,right) <> '0',trim(input.Zip,left,right),''),'');
			
			self.corp_ra_address_line5			  := if( (trim(input.AtypeID,left,right)='10' or trim(input.AtypeID,left,right)='13' ),if (trimUpper(input.CountyName) <> '' and trimUpper(input.CountyName)<>'OUT OF STATE' and trimUpper(input.CountyName)<>'OUT OF STATE COUNTY',
																		trimUpper(input.CountyName) + ' COUNTY',
																		''
																	),'');			
																											  
			self.corp_ra_address_line6			  := if( (trim(input.AtypeID,left,right)='10' or trim(input.AtypeID,left,right)='13' ),if (trimUpper(input.Country) <> 'UNITED STATES' and trimUpper(input.Country) <> 'UNITEDSTATES' and                                                          
																	trimUpper(input.Country) <> 'US' and
																	trimUpper(input.Country) <> 'USA',
																		trimUpper(input.Country),
																		''
																	),'');
			
			
		
			self.corp_ra_address_type_cd          := if( (trim(input.AtypeID,left,right)='10' or trim(input.AtypeID,left,right)='13' ),
			                                         if(input.AtypeID<>'',trim(input.AtypeID,left,right),''),'');
													 
			self.corp_ra_address_type_desc        :=if( (trim(input.AtypeID,left,right)='10' or trim(input.AtypeID,left,right)='13' ),
			                                         if(input.AtypeID<>'' and (string)(integer)trim(input.AtypeID,left,right)='10','REGISTERED OFFICE','REGISTERED MAILING'),'');
			
			Title1                                :=if(input.Managed<>'0'and input.Managed='1','MANAGED','');
			Title2                                :=if(input.Members<>'0'and input.Members='1','MEMBERS','');
			Title3                                :=if(input.Directors<>'0'and input.Directors='1','DIRECTORS','');
			Title4                                :=if(input.MemberManaged<>'0'and input.MemberManaged='1','MEMBER MANAGED','');
			concatFields						  :=trim(Title1,left,right) + ';' + 
																					trim(Title2,left,right) + ';' +  
																					trim(Title3,left,right) + ';' + 
																			trim(Title4,left,right)  ;
				
			tempExp								  := regexreplace('[;]*$',concatFields,'',NOCASE);
			tempExp2							  := regexreplace('^[;]*',tempExp,'',NOCASE);
			
			self.corp_addl_info                   := regexreplace('[;]+',tempExp2,';',NOCASE);
			
			  self                                  := [];
		
        end; // end transform.			
		
		corp2_mapping.Layout_CorpPreClean corpLegalNonRATransform(corp2_mapping.Layout_CorpPreClean input ,Corp_Name_Add r) := transform,skip((trim(r.AtypeID,left,right) = '10' or trim(r.AtypeID,left,right) = '13' or	trim(r.AtypeID,left,right) = ''))
			
			concatAddrFields1						  := if((trim(r.AtypeID,left,right)='1' or trim(r.AtypeID,left,right)='8' ),
					                                               if ((string)(integer) r.Addr2 <> '0',
																		if ((string)(integer) r.Addr3 <> '0',
																				trimUpper(r.Addr1 + ' ' + r.Addr2 + ' ' + r.Addr3),
																				trimUpper(r.Addr1 + ' ' + r.Addr2)
																			),
																		if ((string)(integer) r.Addr3 <> '0',
																				trimUpper(r.Addr1 + ' ' + r.Addr3),
																				trimUpper(r.Addr1)
																			)
																	),'');
												
			self.corp_address1_line1 				:= if((trim(r.AtypeID,left,right)='1' or trim(r.AtypeID,left,right)='8' ),trimUpper(concatAddrFields1),'');

			self.corp_address1_line2				:= if((trim(r.AtypeID,left,right)='1' or trim(r.AtypeID,left,right)='8' ),trimUpper(r.City),'');
														
			self.corp_address1_line3				:= if((trim(r.AtypeID,left,right)='1' or trim(r.AtypeID,left,right)='8' ),if (trimUpper(r.State) <> 'XX' and not ut.isNumeric(trim(r.state,left,right)),
																		trimUpper(r.state),
																		''
																	),'');
														
			self.corp_address1_line4				:=if((trim(r.AtypeID,left,right)='1' or trim(r.AtypeID,left,right)='8' ),if(r.Zip<>'' and (string)(integer)trim(r.Zip,left,right) <> '0',trim(r.Zip,left,right),''),'');
			
			self.corp_address1_line5				:= if((trim(r.AtypeID,left,right)='1' or trim(r.AtypeID,left,right)='8' ),if (trimUpper(r.CountyName) <> ''  and trimUpper(r.CountyName)<>'OUT OF STATE'and trimUpper(r.CountyName)<>'OUT OF STATE COUNTY',
																		trimUpper(r.CountyName) + ' COUNTY',
																		''
																	),'');			
																											  
			self.corp_address1_line6				:= if((trim(r.AtypeID,left,right)='1' or trim(r.AtypeID,left,right)='8' ),if (trimUpper(r.Country) <> 'UNITED STATES' and  trimUpper(r.Country) <> 'UNITEDSTATES'and
																	trimUpper(r.Country) <> 'US' and
																	trimUpper(r.Country) <> 'USA',
																		trimUpper(r.Country),
																		''
																	),'');
																	
																	
   			self.corp_address1_type_cd            :=if((trim(r.AtypeID,left,right)='1' or trim(r.AtypeID,left,right)='8' ),
			                                           map(trim(r.AtypeID,left,right)='1'=>'M',
														trim(r.AtypeID,left,right)='8'=>'P',
														''),'');
		   self.corp_address1_type_desc          :=if((trim(r.AtypeID,left,right)='1' or trim(r.AtypeID,left,right)='8' ),
		                                              map(trim(r.AtypeID,left,right)='1'=>'PRINCIPAL MAILING',
														trim(r.AtypeID,left,right)='8'=>'PRINCIPAL OFFICE',
														''),'');
			
		      self								 := input;
		end; 

		
  		
       corp2_mapping.Layout_CorpPreClean corpNonLegalTransform(Corp_Name_Add input):=transform
        	self.dt_first_seen					  :=fileDate;
   			self.dt_last_seen					  :=fileDate;
   			self.dt_vendor_first_reported		  :=fileDate;
   			self.dt_vendor_last_reported		  :=fileDate;
   			self.corp_ra_dt_first_seen			  :=fileDate;
   			self.corp_ra_dt_last_seen			  :=fileDate;
   			self.corp_key					      :='37-'+trim(input.CorpNum, left, right);  
   			self.corp_vendor				      := '37';
   			self.corp_state_origin			      := 'NC';
   			self.corp_process_date				  := fileDate;    
            self.corp_orig_sos_charter_nbr        :=trim(input.CorpNum, left, right);
   		    self.corp_src_type                    :='SOS';
		    self.corp_legal_name                  :=trimUpper(input.Ename);
   			self.corp_ln_name_type_cd             :=map(trim(input.NtypeID,left,right)='3'=>'P',
														trim(input.NtypeID,left,right)='13'=>'O',
			                                            trim(input.NtypeID,left,right)='15'=>'P','');
														
			self.corp_ln_name_type_desc           :=map(trim(input.NtypeID,left,right)='3'=>'PRIOR',
															trim(input.NtypeID,left,right)='13'=>'OTHER',
															trim(input.NtypeID,left,right)='15'=>'PRIOR',''); 
															
			self.corp_inc_state                        :=if(trimUpper(input.StateOfInc) = 'NC' or (input.StateOfInc)='','NC','');												
   			self                                  := [];
   		
        end; //End of corp2 transform.
			
	corp2_mapping.Layout_CorpPreClean corpTransform(NameRes_Name input):=transform
        	self.dt_first_seen					  :=fileDate;
   			self.dt_last_seen					  :=fileDate;
   			self.dt_vendor_first_reported		  :=fileDate;
   			self.dt_vendor_last_reported		  :=fileDate;
   			self.corp_ra_dt_first_seen			  :=fileDate;
   			self.corp_ra_dt_last_seen			  :=fileDate;
   			self.corp_key					      :='37-'+if(input.DocmentID<>'',trim(input.DocmentID, left, right),'');  
   			self.corp_vendor				      := '37';
   			self.corp_state_origin			      := 'NC';
   			self.corp_process_date				  := fileDate;    
            self.corp_orig_sos_charter_nbr        :=if(input.DocmentID<>'',trim(input.DocmentID, left, right),'');
   		    self.corp_src_type                    :='SOS';
		    self.corp_ln_name_type_cd             :='07';
														
			self.corp_ln_name_type_desc           :='RESERVED';
			self.corp_legal_name                  :=trimUpper(input.Ename);
			self.corp_filing_reference_nbr        :=if(input.DocmentID<>'',trim(input.DocmentID, left, right),'');
            self.corp_filing_date                 :=if(_validate.date.fIsValid(reformatDate(input.FilingDate)) and 
			                                         _validate.date.fIsValid(reformatDate(input.FilingDate),_validate.date.rules.DateInPast) and
													 (string)(integer)reformatDate(input.FilingDate) <> '0',
												      reformatDate(input.FilingDate),'');
			self.corp_filing_cd                   :=if(input.DocmentType<>'',trim(input.DocmentType, left, right),'');
			self.corp_filing_desc                 :=map(trimUpper(input.DocmentType)='REG'=>'APPLICATION TO REGISTER A CORPORATE NAME',
			                                            trimUpper(input.DocmentType)='RESR'=> 'APPLICATION TO RESERVE A CORPORATE NAME',
			                                            trimUpper(input.DocmentType)='RREG'=>'RENEW REGISTERED CORPORATE NAME',
			                                            trimUpper(input.DocmentType)='RSLP'=> 'APPLICATION FOR RESERVATION OF LIMITED PARTNERSHIP',
			                                     		trimUpper(input.DocmentType)='TRAN'=> 'TRANSFER OF RESERVED CORPORATE NAME',
														'');
														
			self.corp_term_exist_cd               :=if(_validate.date.fIsValid(reformatDate(input.ExpirationDate))  and
													 (string)(integer)reformatDate(input.ExpirationDate) <> '0',
												     'D','');
			self.corp_term_exist_exp              :=if(_validate.date.fIsValid(reformatDate(input.ExpirationDate))  and
													 (string)(integer)reformatDate(input.ExpirationDate) <> '0',
												      reformatDate(input.ExpirationDate),'');  
			self.corp_term_exist_desc             :=if(_validate.date.fIsValid(reformatDate(input.ExpirationDate))  and
													 (string)(integer)reformatDate(input.ExpirationDate) <> '0',
												      'EXPIRATION DATE','');
			self.corp_inc_state                   :=if(trimUpper(input.NameRes_StateOfInc) = 'NC' or (input.NameRes_StateOfInc)='','NC','');										  
			self.corp_forgn_state_cd              :=if(trimUpper(input.NameRes_StateOfInc) <>'NC'and (input.NameRes_StateOfInc)<>''and (input.NameRes_StateOfInc)<>'XX',trimUpper(input.NameRes_StateOfInc) ,'');										  
													  
   			self                                  := [];
   		
            end; //End of corp2 transform.

	 
            		 // Stock_TRANSFORM M.R.
   	     Corp2.Layout_Corporate_Direct_Stock_In nc_stockTransform(Corp_StockFile input):=transform,skip(input.CorpNum='' or (input.Class='' and input.Shares='' and input.NoParValue='' and input.ParValue='' ) )
   			self.corp_key					      := '37-'+trim(input.CorpNum, left, right);  
   			self.corp_vendor				      := '37';
   			self.corp_state_origin			      := 'NC';
   			self.corp_process_date			      := fileDate;
   			self.corp_sos_charter_nbr		      := trim(input.CorpNum, left, right);
			self.stock_class				      :=if(input.Class<>'',trimUpper(input.Class),'');
			self.stock_shares_issued			  :=if(input.Shares<>''and (string)(integer)input.Shares<>'0',trim(input.Shares,left,right),'');
			self.stock_par_value                  := if(input.NoParValue<>'' and (string)(integer)input.NoParValue = '1', '',
														if (input.ParValue<>'' and (string)(integer)input.ParValue <> '0', 
														trim(input.ParValue,left,right),'')
														 );
																	
   			self.stock_addl_info                  := if((string)( integer)input.NoParValue = '1' and (string)(integer)input.ParValue = '0' , 'NO PAR VALUE','');
            self                                  := [];
   			
   			
   		 end; // end of nc_Stock_transform M.R.
		 

		  Corp2.Layout_Corporate_Direct_AR_In nc_ar1Transform( Corp2.Layout_Corporate_Direct_AR_In  input):=transform,skip(input.ar_due_dt='' and input.ar_filed_dt='' and input.ar_comment='' and input.ar_report_nbr='')
				self                                  :=input;
				self                                  := [];
			
			
	       end; // end of 
 	     // AR_TRANSFORM M.R.
   	     Corp2.Layout_Corporate_Direct_AR_In nc_arTransform(Corp_Filings input):=transform,skip(trimUpper(input.DocumentType)<>'AART' and  trimUpper(input.DocumentType)<>'AN98' 
		                                                                                  and trimUpper(input.DocumentType)<>'ANRL' and trimUpper(input.DocumentType)<>'ANRC'
                                                                                           and trimUpper(input.DocumentType)<>'ANRN' and trimUpper(input.DocumentType)<>'ANLP' 
																						  and trimUpper(input.DocumentType)<>'ANRT'  
																						  and input.CorpNum='' )
   			self.corp_key					      := '37-'+trim(input.CorpNum, left, right);  
   			self.corp_vendor				      := '37';
   			self.corp_state_origin			      := 'NC';
   			self.corp_process_date			      := fileDate;
   			self.corp_sos_charter_nbr		      := trim(input.CorpNum, left, right);
			doc_Type                       	      :=['AART','AN98','ANRC','ANRL','ANRN','ANLP','ANRT'];	
			
   			self.ar_due_dt                        := if(input.AnnualRptDueDate<>'' and _validate.date.fIsValid(reformatDate(input.AnnualRptDueDate)) and 
			                                         _validate.date.fIsValid(reformatDate(input.AnnualRptDueDate),_validate.date.rules.DateInPast) and
													 (string)(integer)reformatDate(input.AnnualRptDueDate) <> '0'and trimUpper(input.DocumentType) in doc_Type,
												      reformatDate(input.AnnualRptDueDate),'');
													  
													  
            self.ar_filed_dt                      := if(input.FilingDate<>'' and _validate.date.fIsValid(reformatDate(input.FilingDate)) and 
			                                         _validate.date.fIsValid(reformatDate(input.FilingDate),_validate.date.rules.DateInPast) and
													 (string)(integer)reformatDate(input.FilingDate) <> '0'and trimUpper(input.DocumentType) in doc_Type,
												      reformatDate(input.FilingDate),'');
			
			
			self.ar_report_nbr                    :=if(input.DocumentID<>'' and trimUpper(input.DocumentType) in doc_Type ,trim(input.DocumentID,left, right),'');
			
			self.ar_comment                       := if(trim(input.DocumentType, left, right) in doc_Type ,
			                                        map(trimUpper(input.DocumentType)='AART'=>'AMENDED ANNUAL REPORT',
			                                            trimUpper(input.DocumentType)='AN98'=> 'ANNUAL REPORT PRE98',
			                                            trimUpper(input.DocumentType)='ANRL'=>'ANNUAL REPORT LLP',
			                                            trimUpper(input.DocumentType)='ANRC'=> 'ANNUAL REPORT LLC',
			                                     		trimUpper(input.DocumentType)='ANLP'=> 'ANNUAL REPORT RLLP',
														''),'');
													  
			 										  
			 																							  
   			 self                                  := [];
   
   	     end; // end of nc_AR_transform M.R.
   		
   			

		 	Corp2.Layout_Corporate_Direct_Event_In nc_eventTransform(Corp2.Layout_Corporate_Direct_Event_In  input):=transform,skip(input.event_filing_date='' and input.event_filing_reference_nbr='' and input.event_date_type_cd ='' and input.event_desc='')
				self                                  :=input;
				self                                  := [];
			
			
	       end; // end of Stock_transform M.R.
   		
		 
	Corp2.Layout_Corporate_Direct_Event_In nc_event1Transform(Corp_Filings input):=transform,skip(trimUpper(input.DocumentType)='AART' or  trimUpper(input.DocumentType)='AN98' 
		                                                                                   or trimUpper(input.DocumentType)='ANRL' or trimUpper(input.DocumentType)='ANRC'
                                                                                           or trimUpper(input.DocumentType)='ANRN' or trimUpper(input.DocumentType)='ANLP' 
																						   or trimUpper(input.DocumentType)='ANRT' 
																						    or input.CorpNum ='' )
																						   
			doc_Type2                       	  :=['AART','AN98','ANRC','ANRL','ANRN','ANLP','ANRT'];																			   
   			self.corp_key					      := '37-'+trim(input.CorpNum, left, right);  
   			self.corp_vendor				      := '37';
   			self.corp_state_origin			      := 'NC';
   			self.corp_process_date			      := fileDate;
   			self.corp_sos_charter_nbr		      := trim(input.CorpNum, left, right);
			
   			self.event_filing_date                :=if(input.FilingDate<>'' and _validate.date.fIsValid(reformatDate(input.FilingDate)) and 
			                                         _validate.date.fIsValid(reformatDate(input.FilingDate),_validate.date.rules.DateInPast) and
													 (string)(integer)reformatDate(input.FilingDate) <> '0' and  trimUpper(input.DocumentType) ~in doc_Type2,
												      reformatDate(input.FilingDate),'');
													  
			self.event_filing_reference_nbr       :=if((input.DocumentID)<>''and  trimUpper(input.DocumentType) ~in doc_Type2 ,trimUpper(input.DocumentID),'');
			
			self.event_date_type_cd               :=if(input.FilingDate<>'' and _validate.date.fIsValid(reformatDate(input.FilingDate)) and 
			                                         _validate.date.fIsValid(reformatDate(input.FilingDate),_validate.date.rules.DateInPast) and
													 (string)(integer)reformatDate(input.FilingDate) <> '0'
													 and  trimUpper(input.DocumentType) ~in doc_Type2,
												      'FIL','');
													  
            self.event_date_type_desc             :=if(input.FilingDate<>'' and _validate.date.fIsValid(reformatDate(input.FilingDate)) and 
			                                         _validate.date.fIsValid(reformatDate(input.FilingDate),_validate.date.rules.DateInPast) and
													 (string)(integer)reformatDate(input.FilingDate) <> '0'and  trimUpper(input.DocumentType) ~in doc_Type2,
												      'FILING','');
													  
			self.event_filing_cd                  :=if(input.DocumentType<>'' and trimUpper(input.DocumentType)<>'SSID' 
			                                          and trimUpper(input.DocumentType)<>'NULL' and  trimUpper(input.DocumentType) ~in doc_Type2,trimUpper(input.DocumentType),'');
            
            filing_dt                             :=if(input.FilingDate<>'' and _validate.date.fIsValid(reformatDate(input.FilingDate)) and 
			                                         _validate.date.fIsValid(reformatDate(input.FilingDate),_validate.date.rules.DateInPast) and
													 (string)(integer)reformatDate(input.FilingDate) <> '0',
												      reformatDate(input.FilingDate),'');
													  
			Effective_dt                          :=if(input.EffectiveDate<>'' and _validate.date.fIsValid(reformatDate(input.EffectiveDate)) and 
			                                         _validate.date.fIsValid(reformatDate(input.EffectiveDate),_validate.date.rules.DateInPast) and
													 (string)(integer)reformatDate(input.EffectiveDate) <> '0',
												      reformatDate(input.EffectiveDate),'');
													  
			self.event_desc                       :=if(Effective_dt<>filing_dt and Effective_dt<>''and  trimUpper(input.DocumentType) ~in doc_Type2,'EFFECTIVE DATE: '+Effective_dt,'');										  
            self                                  := [];
			 
	end; // end of nc_Event_transform M.R.
	
	
       	Corp2.Layout_Corporate_Direct_Event_In nc_event3Transform(Corp2.Layout_Corporate_Direct_Event_In  input):=transform,skip(input.event_filing_date='' and input.event_filing_reference_nbr='' and input.event_date_type_cd ='' )
				self                                  :=input;
				self                                  := [];
			
			
	       end; // end of Stock_transform M.R
	
		Corp2.Layout_Corporate_Direct_Event_In nc_event2Transform(Corp_Filings input):=transform,skip(trimUpper(input.DocumentType)='AART' or  trimUpper(input.DocumentType)='AN98' 
		                                                                                   or trimUpper(input.DocumentType)='ANRL' or trimUpper(input.DocumentType)='ANRC'
                                                                                           or trimUpper(input.DocumentType)='ANRN' or trimUpper(input.DocumentType)='ANLP' 
																						   or trimUpper(input.DocumentType)='ANRT' 
																						    or input.CorpNum ='' )
																						   
			doc_Type2                       	  :=['AART','AN98','ANRC','ANRL','ANRN','ANLP','ANRT'];																			   
   			self.corp_key					      := '37-'+trim(input.CorpNum, left, right);  
   			self.corp_vendor				      := '37';
   			self.corp_state_origin			      := 'NC';
   			self.corp_process_date			      := fileDate;
   			self.corp_sos_charter_nbr		      := trim(input.CorpNum, left, right);
			
   			self.event_filing_date                :=if(input.DissolveDate<>'' and  trimUpper(input.DocumentType) ~in doc_Type2
			                                           and _validate.date.fIsValid(reformatDate(input.DissolveDate)) and 
			                                         _validate.date.fIsValid(reformatDate(input.DissolveDate),_validate.date.rules.DateInPast) and
													 (string)(integer)reformatDate(input.DissolveDate) <> '0' ,
												      reformatDate(input.DissolveDate),'');
													  
						
			self.event_date_type_cd               :=if(input.DissolveDate<>'' and  trimUpper(input.DocumentType) ~in doc_Type2 and _validate.date.fIsValid(reformatDate(input.DissolveDate)) and 
			                                         _validate.date.fIsValid(reformatDate(input.DissolveDate),_validate.date.rules.DateInPast) and
													 (string)(integer)reformatDate(input.DissolveDate) <> '0' ,
												     'DIS','');
													 
            self.event_date_type_desc             :=if(input.DissolveDate<>'' and  trimUpper(input.DocumentType) ~in doc_Type2 and _validate.date.fIsValid(reformatDate(input.DissolveDate)) and 
			                                         _validate.date.fIsValid(reformatDate(input.DissolveDate),_validate.date.rules.DateInPast) and
													 (string)(integer)reformatDate(input.DissolveDate) <> '0' ,
												     'DISSOLUTION','');									  
            								  
            self                                  := [];
			 
			 
	end; // end of nc_Event_transform M.R.
	
	

		   
  		corp2_mapping.Layout_ContPreClean nc_contact1Transform(corp2_mapping.Layout_ContPreClean input):=transform,skip(input.cont_title1_desc='' and input.cont_name ='' )
				self                                  :=input;
				self                                  := [];
			
			
	       end; // end 
		   
    		 // contact_TRANSFORM
        corp2_mapping.Layout_ContPreClean nc_contactTransform(Off_Part_Direc_Name_Corp input,Corp_Name r):=transform,skip(input.CorpNum='' or (string)(integer)trim(input.CorpNum, left, right) = '0')
            self.dt_first_seen					  :=fileDate;
   			self.dt_last_seen					  :=fileDate;
   			self.corp_key					      := '37-'+trim(input.CorpNum, left, right);  
   			self.corp_vendor				      := '37';
   			self.corp_state_origin			      := 'NC';
   			self.corp_process_date			      := fileDate;
   			self.corp_orig_sos_charter_nbr		  := trim(input.CorpNum, left, right);
   			self.corp_legal_name                  :=if(r.Ename<>'',trimUpper(r.Ename),'');
            self.cont_name                        :=if(input.Ename<>'',trimUpper(input.Ename),'');
			self.cont_title1_desc         	      :=if(input.Offi_Tittle<>'' and  self.cont_name<>'',trimUpper(input.Offi_Tittle),'');
            self                                  := [];
         			
        end; // end of nc_contact_transform   
   		


		 //---------------------------- Clean corp Name and Addresses ---------------------//
		Corp2.Layout_Corporate_Direct_Corp_In CleanCorpAddrName(corp2_mapping.Layout_CorpPreClean input) := transform		
			string73 tempname 			    := if(input.corp_ra_name = '', '', Address.CleanPersonFML73(input.corp_ra_name));
			pname 							:= Address.CleanNameFields(tempName);
			cname 							:= DataLib.companyclean(input.corp_ra_name);
			keepPerson 						:= corp2.Rewrite_Common.IsPerson(input.corp_ra_name);
			keepBusiness 					:= corp2.Rewrite_Common.IsCompany(input.corp_ra_name);
			
			self.corp_ra_title1				:= if(keepPerson, pname.title, '');
			self.corp_ra_fname1 			:= if(keepPerson, pname.fname, '');
			self.corp_ra_mname1 			:= if(keepPerson, pname.mname, '');
			self.corp_ra_lname1 			:= if(keepPerson, pname.lname, '');
			self.corp_ra_name_suffix1 		:= if(keepPerson, pname.name_suffix, '');
			self.corp_ra_score1 			:= if(keepPerson, pname.name_score, '');
		
			self.corp_ra_cname1 			:= if(keepBusiness, cname[1..70],'');
			self.corp_ra_cname1_score 		:= if(keepBusiness, pname.name_score, '');
			
			string182 clean_address 		:= Address.CleanAddress182(trim(input.corp_address1_line1,left,right),
																							trim(	trim(input.corp_address1_line2,left,right) + ', ' +
																									trim(input.corp_address1_line3,left,right) + ' ' +
																									trim(input.corp_address1_line4,left,right),
																									left,right
																								  )
																							);			
			
			string182 clean_ra_address 		:= Address.CleanAddress182(trim(input.corp_ra_address_line1,left,right), 
																							trim(	trim(input.corp_ra_address_line2,left,right) + ', ' +
																									trim(input.corp_ra_address_line3,left,right) + ' ' +
																									trim(input.corp_ra_address_line4,left,right),
																									left,right
																								  )
																							);	
																				
			self.corp_ra_prim_range    			:= clean_ra_address[1..10];
			self.corp_ra_predir 	      		:= clean_ra_address[11..12];
			self.corp_ra_prim_name 	  			:= clean_ra_address[13..40];
			self.corp_ra_addr_suffix   			:= clean_ra_address[41..44];
			self.corp_ra_postdir 	    		:= clean_ra_address[45..46];
			self.corp_ra_unit_desig 	  		:= clean_ra_address[47..56];
			self.corp_ra_sec_range 	  			:= clean_ra_address[57..64];
			self.corp_ra_p_city_name	  		:= clean_ra_address[65..89];
			self.corp_ra_v_city_name	  		:= clean_ra_address[90..114];
			self.corp_ra_state 			    	:= clean_ra_address[115..116];
			self.corp_ra_zip5 		      		:= clean_ra_address[117..121];
			self.corp_ra_zip4 		      		:= clean_ra_address[122..125];
			self.corp_ra_cart 		      		:= clean_ra_address[126..129];
			self.corp_ra_cr_sort_sz 	 		:= clean_ra_address[130];
			self.corp_ra_lot 		      		:= clean_ra_address[131..134];
			self.corp_ra_lot_order 	  			:= clean_ra_address[135];
			self.corp_ra_dpbc 		      		:= clean_ra_address[136..137];
			self.corp_ra_chk_digit 	  			:= clean_ra_address[138];
			self.corp_ra_rec_type		  		:= clean_ra_address[139..140];
			self.corp_ra_ace_fips_st	  		:= clean_ra_address[141..142];
			self.corp_ra_county 	  			:= clean_ra_address[143..145];
			self.corp_ra_geo_lat 	    		:= clean_ra_address[146..155];
			self.corp_ra_geo_long 	    		:= clean_ra_address[156..166];
			self.corp_ra_msa 		      		:= clean_ra_address[167..170];
			self.corp_ra_geo_blk				:= clean_ra_address[171..177];
			self.corp_ra_geo_match 	  			:= clean_ra_address[178];
			self.corp_ra_err_stat 	    		:= clean_ra_address[179..182];
													
			self.corp_addr1_prim_range  		:= clean_address[1..10];
			self.corp_addr1_predir 	    		:= clean_address[11..12];
			self.corp_addr1_prim_name 			:= clean_address[13..40];
			self.corp_addr1_addr_suffix   		:= clean_address[41..44];
			self.corp_addr1_postdir 	   		:= clean_address[45..46];
			self.corp_addr1_unit_desig 			:= clean_address[47..56];
			self.corp_addr1_sec_range 			:= clean_address[57..64];
			self.corp_addr1_p_city_name			:= clean_address[65..89];
			self.corp_addr1_v_city_name			:= clean_address[90..114];
			self.corp_addr1_state 			    := clean_address[115..116];
			self.corp_addr1_zip5 		      	:= clean_address[117..121];
			self.corp_addr1_zip4 		      	:= clean_address[122..125];
			self.corp_addr1_cart 		     	:= clean_address[126..129];
			self.corp_addr1_cr_sort_sz 	 		:= clean_address[130];
			self.corp_addr1_lot 		      	:= clean_address[131..134];
			self.corp_addr1_lot_order 			:= clean_address[135];
			self.corp_addr1_dpbc 		     	:= clean_address[136..137];
			self.corp_addr1_chk_digit 			:= clean_address[138];
			self.corp_addr1_rec_type		  	:= clean_address[139..140];
			self.corp_addr1_ace_fips_st			:= clean_address[141..142];
			self.corp_addr1_county 	  			:= clean_address[143..145];
			self.corp_addr1_geo_lat 	    	:= clean_address[146..155];
			self.corp_addr1_geo_long 	    	:= clean_address[156..166];
			self.corp_addr1_msa 		      	:= clean_address[167..170];
			self.corp_addr1_geo_blk				:= clean_address[171..177];
			self.corp_addr1_geo_match 	  		:= clean_address[178];
			self.corp_addr1_err_stat 	    	:= clean_address[179..182];
			self								:= input;
			self 								:= [];
		end; 
		
		
		//*********************cleaned corp routine ends********
 		
   					//******************Cont Cleaning starts.****************
      		Corp2.Layout_Corporate_Direct_Cont_In CleanContNameAddr(corp2_mapping.Layout_ContPreClean input) := transform		
   			string73 tempname 				    := if(input.cont_name = '', '', Address.CleanPersonFML73(input.cont_name));
   			pname 								:= Address.CleanNameFields(tempName);
   			cname 								:= DataLib.companyclean(input.cont_name);
   			keepPerson 							:= corp2.Rewrite_Common.IsPerson(input.cont_name);
   			keepBusiness 						:= corp2.Rewrite_Common.IsCompany(input.cont_name);
   			
   			self.cont_title1					:= if(keepPerson, pname.title, '');
   			self.cont_fname1 					:= if(keepPerson, pname.fname, '');
   			self.cont_mname1 					:= if(keepPerson, pname.mname, '');
   			self.cont_lname1 					:= if(keepPerson, pname.lname, '');
   			self.cont_name_suffix1 				:= if(keepPerson, pname.name_suffix, '');
   			self.cont_score1 					:= if(keepPerson, pname.name_score, '');
   		
   			self.cont_cname1 					:= if(keepBusiness, cname[1..70],'');
   			self.cont_cname1_score 				:= if(keepBusiness, pname.name_score, '');
   			
   		
   			string182 clean_address 			:= Address.CleanAddress182(trim(input.cont_address_line1,left,right),
   																								trim(	trim(input.cont_address_line2,left,right) + ', ' +
   																										trim(input.cont_address_line3,left,right) + ' ' +
   																										trim(input.cont_address_line4,left,right),
   																										left,right
   																									  )
   																								);	
   																				
   			self.cont_prim_range    			:= clean_address[1..10];
   			self.cont_predir 	      			:= clean_address[11..12];
   			self.cont_prim_name 	  			:= clean_address[13..40];
   			self.cont_addr_suffix   			:= clean_address[41..44];
   			self.cont_postdir 	  		  		:= clean_address[45..46];
   			self.cont_unit_desig 	  			:= clean_address[47..56];
   			self.cont_sec_range 	  			:= clean_address[57..64];
   			self.cont_p_city_name	  			:= clean_address[65..89];
   			self.cont_v_city_name	 			:= clean_address[90..114];
   			self.cont_state 			      	:= clean_address[115..116];
   			self.cont_zip5 		      			:= clean_address[117..121];
   			self.cont_zip4 		 	     		:= clean_address[122..125];
   			self.cont_cart 		    	  		:= clean_address[126..129];
   			self.cont_cr_sort_sz 	 			:= clean_address[130];
   			self.cont_lot 		      			:= clean_address[131..134];
   			self.cont_lot_order 	  			:= clean_address[135];
   			self.cont_dpbc 		   		   		:= clean_address[136..137];
   			self.cont_chk_digit 	  			:= clean_address[138];
   			self.cont_rec_type		  			:= clean_address[139..140];
   			self.cont_ace_fips_st	  			:= clean_address[141..142];
   			self.cont_county 	 	 			:= clean_address[143..145];
   			self.cont_geo_lat 	    			:= clean_address[146..155];
   			self.cont_geo_long 	    			:= clean_address[156..166];
   			self.cont_msa 		      			:= clean_address[167..170];
   			self.cont_geo_blk					:= clean_address[171..177];
   			self.cont_geo_match 	  			:= clean_address[178];
   			self.cont_err_stat 	    			:= clean_address[179..182];
   
   			self										:= input;
   			self 										:= [];
   		end;		
      		//************************Cont cleaning ends*************************************

         //************************Cont ********************  		
		layouts_Raw_Input.Officers OfficersTransform(layouts_Raw_Input.Officers input):=transform
	
	      self.Offi_Tittle:='OFFICER';
	       self:=input;
	    end;
   
        NewOfficer:= project( Files_Raw_Input.OFFICERS(fileDate),OfficersTransform(left));
		
		layouts_Raw_Input.Partners PartnersTransform(layouts_Raw_Input.Partners input):=transform
	
	      self.Part_Tittle:='PARTNER';
	       self:=input;
	    end;
   
        NewPartners:= project( Files_Raw_Input.PARTNERS(fileDate),PartnersTransform(left));
		
	  layouts_Raw_Input.Directors DirectorsTransform(layouts_Raw_Input.Directors input):=transform
	
	      self.Direc_Tittle:='DIRECTOR';
	       self:=input;
	    end;
   
        NewDirectors:= project(Files_Raw_Input.DIRECTORS(fileDate),DirectorsTransform(left));														
																
																
		OffPartDirec:=NewOfficer+NewDirectors+NewPartners;
			
			//------- join Officer  Name to get corporation name for corp_legal_name ------------------
		
			
		Off_Part_Direc_Name MergeCont(OffPartDirec l, Layouts_Raw_Input.NAMES r ) := transform
			self 					:= l;
			self					:= r;
			self                    := [];
			
		end; // end transform
		
		joinNamewithOffPartDirec := join(OffPartDirec, Files_Raw_Input.NAMES(fileDate),
								trim(left.Offi_EntityID,left,right) = trim(right.Name_EntityID,left,right),
								MergeCont(left,right),
								left outer,local
							);
							
			
			//------- join Officer  Name to get corporation name for corp_legal_name ------------------
		Off_Part_Direc_Name_Corp MergeCont1( Layouts_Raw_Input.Corporations l, Off_Part_Direc_Name r  ) := transform
			self 					:= l;
			self					:= r;
			self                    := [];
			
		end; // end transform
		
		joinCorpNamewithOffPartDirec := join(Files_Raw_Input.CORPORATIONS(fileDate),joinNamewithOffPartDirec, 
								trim(left.AgentEntityID,left,right)=trim(right.Offi_EntityID,left,right),
								MergeCont1(left,right),
								left outer,local
							);
		
			

	
		
			//layouts join for AR------------------------------------	

			
		Corp_Filings  MergeFilingCorp(Layouts_Raw_Input.Corporations l ,Layouts_Raw_Input.Filings r ) := transform
			self 					:= l;
			self					:= r;
			self                    := [];
			
		end; // end transform
		
		joinFilingCorp := join( Files_Raw_Input.CORPORATIONS(fileDate),Files_Raw_Input.FILINGS(fileDate),
								 trim(left.Corp_PitemID,left,right)=trim(right.Filings_PitemID,left,right),
								MergeFilingCorp(left,right),
								left outer,local
							);
							
		//layouts join for stock***********************************	
		Corp_StockFile  MergeStockFileCorp(Layouts_Raw_Input.Corporations l ,Layouts_Raw_Input.Stock r ) := transform
			self 					:= l;
			self					:= r;
			self                    := [];
			
		end; // end transform
		
		joinStockFileCorp :=join(Files_Raw_Input.CORPORATIONS(fileDate),Files_Raw_Input.STOCK(fileDate), 
								 trim(left.Corp_PitemID,left,right)=trim(right.Stock_PitemID,left,right),
								MergeStockFileCorp(left,right),
								left outer,local
							);
							

	//---------------------------layouts join for corp-----------------------//
	
	
	    NameRes_Name MergeNameRes_Name(  Layouts_Raw_Input.NameReservations  l ,Layouts_Raw_Input.Names  r ) := transform
		    self 					:= l;
		    self					:= r;
		    self                    := [];
			
		end; // end transform 
		
		joinNameRes_Name := join(Files_Raw_Input.NAMERESERVATIONS(fileDate),Files_Raw_Input.NAMES(fileDate), 
								trim(left.EntityID,left,right) = trim(right.Name_EntityID,left,right),
								MergeNameRes_Name(left,right),
								left outer,local
							);
							
					
							
		//---------------------------layouts join for corp-----------------------//
		Corp_Name MergeCorp_Name(  Layouts_Raw_Input.Corporations  l ,Layouts_Raw_Input.Names  r ) := transform
		    self 					:= l;
		    self					:= r;
		    self                    := [];
			
		end; // end transform 
		
		joinCorp_Name := join(Files_Raw_Input.CORPORATIONS(fileDate),Files_Raw_Input.NAMES(fileDate), 
								trim(left.AgentEntityID,left,right) = trim(right.Name_EntityID,left,right),
								MergeCorp_Name(left,right),
								left outer,local
							);
							
		LegalNameswithAgent 	:= joinCorp_Name(trim(NtypeID,left,right) = '1' );
	  
				
		
	 Corp_Name MergeCorp_Name1(  Layouts_Raw_Input.Corporations  l ,Layouts_Raw_Input.Names  r ) := transform
		    self 					:= l;
		    self					:= r;
		    self                    := [];
			
		end; // end transform 
		
		joinCorp_Name1 := join(Files_Raw_Input.CORPORATIONS(fileDate),Files_Raw_Input.NAMES(fileDate), 
								trim(left.Corp_EntityID,left,right) = trim(right.Name_EntityID,left,right),
								MergeCorp_Name1(left,right),
								left outer,local
							);
							
		LegalNameswithEntityID 	:= joinCorp_Name1(trim(NtypeID,left,right) = '1' );
		NonLegalNames	:= joinCorp_Name1(trim(NtypeID,left,right) <> '1' );																
								
		Corp_Name_Add MergeAll(Corp_Name l, Layouts_Raw_Input.Addresses r ) := transform
			self 	:= r;
			self	:= l;
				
		end; 	
		

		
		joinLegalRA         := join(LegalNameswithAgent, Files_Raw_Input.ADDRESSES(fileDate),
							trim(left.Corp_EntityID,left,right) = trim(right.Address_EntityID,left,right),
							MergeAll(left,right),
							left outer,local
						  );
						  
		Corp_Name_Add MergeAll1(Corp_Name l, Layouts_Raw_Input.Addresses r ) := transform
			self 	:= r;
			self	:= l;
				
		end; 				  
						  
 		joinNonRa         := join(LegalNameswithEntityID, Files_Raw_Input.ADDRESSES(fileDate),
   							trim(left.Corp_EntityID,left,right) = trim(right.Address_EntityID,left,right),
   							MergeAll1(left,right),
   							left outer,local
   						  );
		
		Corp_Name_Add addBlankAddr(Corp_Name l) := transform
			self 	:= l;
			self	:= [];			
		end; 		
								

		joinNonLegal     := project(NonLegalNames,addBlankAddr(left));							
		
		MapEvent1 		:= project(joinFilingCorp, nc_event1Transform(left));
		MapEvent 		:= project(MapEvent1, nc_eventTransform(left));
		
        MapEvent2		:= project(joinFilingCorp, nc_event2Transform(left));
		MapEvent3		:= project( MapEvent2, nc_event3Transform(left));
		
		AllEvent 		:= sort(MapEvent+MapEvent3,corp_key);
		

	
		 //*********************ExplosionTable lookupjoin**********
					
			//For event 
		 Corp2.Layout_Corporate_Direct_Event_In FindDocumentType(Corp2.Layout_Corporate_Direct_Event_In input,  DocumentTypeLayout r ) := transform
			      self.event_filing_desc    := trimUpper(r.Docdesc);
			      self         			    := input;
			      self                      := [];
		 end; // end transform
		
		
		 joinDocumentTypeid :=join(AllEvent,DocumentTypeTable,
									trim(left.event_filing_cd,left,right) = trim(right.Doctype,left,right),
									FindDocumentType(left,right),
									left outer, lookup
								);
								

                 		
       			MapCorpLegalRa := join(JoinLegalRA,LegalNameswithEntityID,
									trim(left.corpNum,left,right)  = trim(right.corpNum,left,right),
									corpLegalRATransform(left,right),
									left outer,local);
									
				
									
									
	  corp2_mapping.Layout_CorpPreClean findState(corp2_mapping.Layout_CorpPreClean input, ForgnStateDescLayout r) := transform
			self.corp_forgn_state_desc  := r.desc;
			self         			    := input;
		
		end; // end transform
		//StatusCode join
		joinStateType := join(MapCorpLegalRa,ForgnStateTable,
														trim(left.corp_forgn_state_cd,left,right) = trim(right.code,left,right),
														findState(left,right),
														left outer,lookup
													);
								
								
	    MapCorpLegalNonRa := join(joinStateType,joinNonRa,
									trim(left.corp_key[4..],left,right)  = trim(right.corpNum,left,right),
									corpLegalNonRATransform(left,right),
									left outer,local);
									
									
		MapNonLegal   	:= project(joinNonLegal, corpNonLegalTransform(left)) ;
		MapNameReg   	:= project(joinNameRes_Name, corpTransform(left)) ;
		
		
		 corp2_mapping.Layout_CorpPreClean findState1(corp2_mapping.Layout_CorpPreClean input, ForgnStateDescLayout r) := transform
			self.corp_forgn_state_desc  := r.desc;
			self         			    := input;
		
		end; // end transform
		//StatusCode join
		joinStateType1 := join(MapNameReg,ForgnStateTable,
														trim(left.corp_forgn_state_cd,left,right) = trim(right.code,left,right),
														findState1(left,right),
														left outer, lookup
													);
		
		
		DistCorps   := (joinStateType+ MapCorpLegalNonRa+ MapNonLegal+joinStateType1);
		
			
																					
		cleanCorp := project(DistCorps,CleanCorpAddrName(left));
			
				
				
                    MapAR    			:= project(joinFilingCorp, nc_arTransform(left));
					
					MapAR1    			:= project( MapAR  , nc_ar1Transform(left));
					
					
					
   				    MapStock  			:= project(joinStockFileCorp, nc_stockTransform(left));
					
				   
					
					MapCont := 	join(joinCorpNamewithOffPartDirec,joinCorp_Name1,
									trim(left.CorpNum,left,right)  = trim(right.CorpNum,left,right),
									nc_contactTransform(left,right),
									left outer,local);
					
    				//MapCont   := project(joinCorpNamewithOffPartDirec, nc_contactTransform(left));
					MapCont1   := project(MapCont, nc_contact1Transform(left));
					
      			    cleanCont := project(MapCont1 , CleanContNameAddr(left));


	VersionControl.macBuildNewLogicalFile('~thor_data400::in::corp2::'+version+'::corp_nc'	,dedup(sort(cleanCorp,record),record)								,corp_out		,,,pOverwrite);		
	VersionControl.macBuildNewLogicalFile('~thor_data400::in::corp2::'+version+'::event_nc'	,joinDocumentTypeid													,event_out	,,,pOverwrite);
	VersionControl.macBuildNewLogicalFile('~thor_data400::in::corp2::'+version+'::ar_nc'		,MapAR1																			,ar_out			,,,pOverwrite);
	VersionControl.macBuildNewLogicalFile('~thor_data400::in::corp2::'+version+'::cont_nc'	,dedup(sort(cleanCont,record),record)	,cont_out		,,,pOverwrite);
	VersionControl.macBuildNewLogicalFile('~thor_data400::in::corp2::'+version+'::stock_nc'	,MapStock																		,stock_out	,,,pOverwrite);
		                                                                                                                                                       
		 mappednc_Filing := parallel(
			 corp_out		
			,event_out	
			,ar_out			
			,cont_out		
			,stock_out	
		);

		result := 
		sequential(
			 if(pshouldspray = true,fSprayFiles('nc',filedate,pOverwrite := pOverwrite))
			,mappednc_Filing
			,parallel(
				 fileservices.addsuperfile('~thor_data400::in::corp2::sprayed::corp'	,'~thor_data400::in::corp2::'+version+'::corp_nc')				  
				,fileservices.addsuperfile('~thor_data400::in::corp2::sprayed::cont'	,'~thor_data400::in::corp2::'+version+'::cont_nc')
				,fileservices.addsuperfile('~thor_data400::in::corp2::sprayed::ar'		,'~thor_data400::in::corp2::'+version+'::ar_nc')
				,fileservices.addsuperfile('~thor_data400::in::corp2::sprayed::event','~thor_data400::in::corp2::'+version+'::event_nc')
				,fileservices.addsuperfile('~thor_data400::in::corp2::sprayed::stock','~thor_data400::in::corp2::'+version+'::stock_nc')
			)
		);

    return result;
   end;//Function end					 

   
		
 end; // end of NC module	