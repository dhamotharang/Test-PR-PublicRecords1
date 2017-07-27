/*2008-04-28T17:32:56Z (Paul V. Smith)
changed temporary override of lookups files on edata10 from /data_build_15 back to /data_build_4
*/
import Corp2,ut, lib_stringlib, _validate, Address, _control, versioncontrol; 
 export ms:= MODULE;  // ms module has Five vendor layouts 

    export Layouts_Raw_Input := MODULE;
       
     export  Address:= record
		string6     AddressID;
		string6 	Add_CorporationID;
		string2 	AddressTypeID;
		string70 	Address1;
		string70 	Address2;
		string70 	Address3;
		string40 	City;
		string50	State;
		string50 	Zip;
		string50 	County;
		string50 	Country;
		string1  	Add_lf;
	 end; 
	  
	export Corporation:= record
		string6 	Corp_CorporationID;
		string7 	EntityID;
		string2 	CorporationTypeID;
		string2 	CorporationStatusID;
		string15	CorporationNumber;
		string1 	Citizenship;
        string23 	DateFormed;
        string23 	DissolveDate;
        string50 	Duration;
		string50 	CountyOfIncorporation;
		string2 	StateOfIncorporation;
		string50	 CountryOfIncorporation;
		string255 	Purpose;
		string80 	Profession;
		string255	RegisteredAgenmsame;
		string1 	lf;
    end;
	
	
	
	export CorporationName := record
        string6 	CorporationNameID;
		string6 	Name_CorporationID;
		string255 	Name;
		string2 	NameTypeID;
		string100 	Title;
		string50 	Salutation;
		string30	Prefix;
		string40 	Lasmsame;
		string40 	MiddleName;
		string40 	Firsmsame;
		string20 	Suffix;
		string1 	Name_lf;	

    end;
	export Corp_Name:= record
	
			Corporation;
			CorporationName;
		
	end; 
	
	export Corp_Name_Add:= record
			Corp_Name;
			Address;
	end;
		  

	
	export Filing := record
       	string7 	FilingID;
		string6 	Filing_CorporationID;
		string15 	DocumentID;
		string3 	DocumentTypeID;
		string23 	FilingDate;
		string23 	EffectiveDate;
		string1 	Filing_lf;
    end;
	
   export Filing_Corp:= record
	    Filing;
       Corporation;
    end;
	
	export Merger := record
        string6 	MergerID;
		string6 	SurvivorCorp_CorporationID;
		string6 	Merged_CorporationID;
		string23 	MergerDate;
		string1 	lf;
    end;
	export Officer := record
		string7 	OfficerID;
		string6 	Offi_CorporationID;
		string50 	Offi_Title;
		string20 	Offi_Salutation;
		string300 	Offi_Name;
		string70 	Offi_Address1;
		string70 	Offi_Address2;
		string70 	Offi_Address3;
		string50 	Offi_City;
		string2 	Offi_State;
		string10 	Offi_Zip;
		string50	Offi_County;
		string50 	Offi_CountryName;
		string6 	OwnerPercentage;
		string6 	TransferRealEstate;
		string6 	ForeignAddress;
		string1 	Offi_lf;
    end;
	export OfficerPartyType := record
		string7 	OfficerPartyTypeID;
		string7 	Party_OfficerID;
		string4 	PartyTypeID;
		string1 	Party_lf;
    end;
	export CorpNameOfficer := record
			CorporationName;
			Officer;
		
	end;
	
	export CorpNameOfficerParty := record
			CorporationName;
			Officer;
			OfficerPartyType;
	end;
	
	export CorpNameOfficerPartyNum := record
			CorporationName;
			Officer;
			OfficerPartyType;
			Corporation;
	end;


	export StockFile := record
		string6	 	StockID;
		string6 	Stock_CorporationID;
		string2 	StockClassID;
		string30 	AuthorizedShares;
		string30 	IssuedShares;
		string100 	Series;
		string1 	NPVFlag;
		string30 	ParValue;
		string1 	Stock_lf;   
	end; 
	
	export StockFile_Corp := record
	     StockFile;
         Corporation;
	end; 
	
   end; // end of Layouts_Raw_Input module
 
   	export Files_Raw_Input := MODULE;
	
		export ADDRESS (string fileDate)             := dataset('~thor_data400::in::corp2::'+fileDate+'::Address::ms',
														        layouts_Raw_Input.Address,CSV(SEPARATOR([',']), quote('"'),TERMINATOR(['\r\n', '\n'])));
																			 
		export CORPORATION(string fileDate)          := dataset('~thor_data400::in::corp2::'+fileDate+'::Corporation::ms',
														        layouts_Raw_Input.Corporation,CSV(SEPARATOR([',']), quote('"'),TERMINATOR(['\r\n', '\n'])));
															 
		export CORPORATIONNAME (string fileDate)     := dataset('~thor_data400::in::corp2::'+fileDate+'::CorporationName::ms',
														        layouts_Raw_Input.CorporationName,CSV(SEPARATOR([',']), quote('"'),TERMINATOR(['\r\n', '\n'])));
														
		export FILING (string fileDate)              := dataset('~thor_data400::in::corp2::'+fileDate+'::Filing::ms',
		                                                        layouts_Raw_Input.Filing,CSV(SEPARATOR([',']), quote('"'),TERMINATOR(['\r\n', '\n'])));
		export MERGER (string fileDate)              := dataset('~thor_data400::in::corp2::'+fileDate+'::Merger::ms',
		                                                        layouts_Raw_Input.Merger,CSV(SEPARATOR([',']), quote('"'),TERMINATOR(['\r\n', '\n'])));											 
		export OFFICER (string fileDate)             := dataset('~thor_data400::in::corp2::'+fileDate+'::Officer::ms',
		                                                        layouts_Raw_Input.Officer,CSV(SEPARATOR([',']), quote('"'),TERMINATOR(['\r\n', '\n'])));
		export OFFICERPARTYTYPE (string fileDate)    := dataset('~thor_data400::in::corp2::'+fileDate+'::OfficerPartyType::ms',
		                                                        layouts_Raw_Input.OfficerPartyType,CSV(SEPARATOR([',']), quote('"'),TERMINATOR(['\r\n', '\n'])));
    export STOCKFILE (string fileDate)           := dataset('~thor_data400::in::corp2::'+filedate+'::STOCK_FILE::ms',
		                                                        layouts_Raw_Input.StockFile,CSV(SEPARATOR([',']), quote('"'),TERMINATOR(['\r\n', '\n'])));												 
	
	end;	

   export Update(string fileDate, string version, boolean pShouldSpray = _Dataset().bShouldSpray, boolean pOverwrite = false) := function
   
        Remove(string s) := function
			return regexreplace('["]{1,}',s,'');
		end;
		
        reformatDate(string rDate) := function
			
			string2 outMM := if(rDate[2] = '/',
								'0'+ rDate[1],
								rDate[1..2]);
			string2 outDD := if(rDate[length(rDate)-6] = '/',
								'0'+ rDate[length(rDate)-5],
								rDate[length(rDate)-6..length(rDate)-5]);
			string8 newDate := rDate[length(rDate)-3..]+outMM+outDD;	
			return  newDate;	
		end;
   
        ForgnStateDescLayout := record,MAXLENGTH(100)
               string code;
               string desc;

        end; 

       ForgnStateTable:= dataset(_dataset().foreign_prod + 'thor_data400::lookup::corp2::corpstateprovince_table', ForgnStateDescLayout, CSV(SEPARATOR([',']), TERMINATOR(['\r\n', '\n'])));
	   
	    DocumentTypeLayout := record,MAXLENGTH(500)
               string Docid;
               string Docdesc;

        end; 

        DocumentTypeTable :=dataset(_dataset().foreign_prod + 'thor_data400::lookup::corp2::'+ filedate +'::DocumentType::ms', DocumentTypeLayout, CSV(SEPARATOR([',']), TERMINATOR(['\r\n', '\n'])));
		 // corp1 Transform

	    corp2_mapping.Layout_CorpPreClean corpLegalRATransform(layouts_raw_input.Corp_Name_Add input):=transform,skip(trim(input.AddressTypeID,left,right)<>'10' and
																																																										trim(input.AddressTypeID,left,right)<>'11' and
																																																										trim(input.AddressTypeID,left,right)<>'14'
																																																										)
     	    self.dt_first_seen					  :=fileDate;
			self.dt_last_seen					  :=fileDate;
			self.dt_vendor_first_reported		  :=fileDate;
			self.dt_vendor_last_reported		  :=fileDate;
			self.corp_ra_dt_first_seen			  :=fileDate;
			self.corp_ra_dt_last_seen			  :=fileDate;
			self.corp_key					      :='28-'+Remove(trim(input.CorporationNumber,left, right));
			self.corp_vendor					  :='28';
		    self.corp_state_origin                :='MS';
			self.corp_process_date				  := fileDate;    
     	    self.corp_orig_sos_charter_nbr        :=Remove(trim(input.CorporationNumber,left, right));
			
			string name                           :=regexreplace('["]{1,}',input.Name,'');											
		    self.corp_legal_name                  :=if(trim(name,left,right)<>'',trim(stringlib.StringtoUpperCase(name),left,right),'');											
			self.corp_internal_nbr                :='';

	        self.corp_ln_name_type_cd             :=map(trim(input.NameTypeID,left,right)='2'=>'02',
			                                            trim(input.NameTypeID,left,right)='20'=>'N',
														trim(input.NameTypeID,left,right)='13'=>'01',
			                                            trim(input.NameTypeID,left,right)='5'=>'01',
														trim(input.NameTypeID,left,right)='1'=>'01',
			                                            trim(input.NameTypeID,left,right)='15'=>'P',
														trim(input.NameTypeID,left,right)='3'=>'P',
			                                            trim(input.NameTypeID,left,right)='19'=>'P',
														trim(input.NameTypeID,left,right)='18'=>'02',
			                                            trim(input.NameTypeID,left,right)='14'=>'07',
														trim(input.NameTypeID,left,right)='10'=>'01',
			                                            ''
														);    
			self.corp_ln_name_type_desc           :=map(trim(input.NameTypeID,left,right)='2'=>'DBA',
			                                            trim(input.NameTypeID,left,right)='20'=>'FBN',
														trim(input.NameTypeID,left,right)='13'=>'LEGAL',
			                                            trim(input.NameTypeID,left,right)='5'=>'LEGAL',
														trim(input.NameTypeID,left,right)='1'=>'LEGAL',
			                                            trim(input.NameTypeID,left,right)='15'=>'PRIOR',
														trim(input.NameTypeID,left,right)='3'=>'PRIOR',
			                                            trim(input.NameTypeID,left,right)='19'=>'PRIOR',
														trim(input.NameTypeID,left,right)='18'=>'DBA',
			                                            trim(input.NameTypeID,left,right)='14'=>'RESERVED',
														trim(input.NameTypeID,left,right)='10'=>'LEGAL',
			                                            ''
														); 

		    self.corp_status_cd                   :=if(trim(input.CorporationStatusID,left,right)<>'',trim(input.CorporationStatusID,left,right),'');
            self.corp_status_desc                 :=map(trim(input.CorporationStatusID,left,right)= '1'=>'RESERVED NAME' ,
														trim(input.CorporationStatusID,left,right)= '2'=>'ACTIVE' ,
														trim(input.CorporationStatusID,left,right)= '3'=>'GOOD STANDING' ,
														trim(input.CorporationStatusID,left,right)= '4'=>'INACTIVE' ,
														trim(input.CorporationStatusID,left,right)= '5'=>'IN PROCESS' ,
														trim(input.CorporationStatusID,left,right)= '7'=>'FORFEITED' ,
														trim(input.CorporationStatusID,left,right)= '8'=>'DISSOLVED' ,
														trim(input.CorporationStatusID,left,right)= '9'=>'CONVERTED' ,
														trim(input.CorporationStatusID,left,right)= '11'=>'WITHDRAWN BY MERGER' ,
														trim(input.CorporationStatusID,left,right)= '24'=>'MERGED' ,
														trim(input.CorporationStatusID,left,right)= '25'=>'NON-QUALIFIED' ,
														trim(input.CorporationStatusID,left,right)= '26'=>'ACCEPTANCE INACTIVE' ,
														trim(input.CorporationStatusID,left,right)= '27'=>'CONSOLIDATED INACTIVE' ,
														trim(input.CorporationStatusID,left,right)= '28'=>'WITHDRAWN' ,
														trim(input.CorporationStatusID,left,right)= '29'=>'INTENT TO DISSOLVE - TAX ' ,
														trim(input.CorporationStatusID,left,right)= '30'=>'INTENT TO DISSOLVE - AR' ,
														trim(input.CorporationStatusID,left,right)= '31'=>'INTENT TO DISSOLVE - RA' ,
														trim(input.CorporationStatusID,left,right)= '32'=>'INTENT TO DISSOLVE: RA/T' ,
														trim(input.CorporationStatusID,left,right)= '33'=>'INTENT TO DISSOLVE: RA/AR' ,
														trim(input.CorporationStatusID,left,right)= '34'=>'INTENT TO DISSOLVE: AR/T' ,
														trim(input.CorporationStatusID,left,right)= '35'=>'INTENT DISSOLVE:RA/T/AR' ,
														trim(input.CorporationStatusID,left,right)= '36'=>'VOID - AFF/VOID' ,
														trim(input.CorporationStatusID,left,right)= '37'=>'VOID - CHAR/VOID/FEE' ,
														trim(input.CorporationStatusID,left,right)= '38'=>'VOID - FAILURE TO FILE ' ,
														trim(input.CorporationStatusID,left,right)= '39'=>'VOID - FALSIFIED DOCUMENT' ,
														trim(input.CorporationStatusID,left,right)= '40'=>'CANCELLED' ,
														trim(input.CorporationStatusID,left,right)= '41'=>'REVOKED' ,
														trim(input.CorporationStatusID,left,right)= '42'=>'NAME CHANGE' ,
														trim(input.CorporationStatusID,left,right)= '43'=>'EXPIRED NAME' ,'');
		    self.corp_status_date                 :=if(_validate.date.fIsValid(StringLib.StringFilterOut(input. DissolveDate,'-')[1..8]) and 
			                                         _validate.date.fIsValid(StringLib.StringFilterOut(input. DissolveDate,'-')[1..8],_validate.date.rules.DateInPast) and
													 	(string)((integer)StringLib.StringFilterOut(input. DissolveDate,'-')[1..8]) <> '0',
														StringLib.StringFilterOut(input. DissolveDate,'-')[1..8],
														''
													  );
			string date                           :=trim(regexreplace('["]{1,}',input.Duration,''),left,right);										  
		    string DurationDate                   :=reformatDate(date);													  
			self.corp_term_exist_cd               :=if(_validate.date.fIsValid(trim(DurationDate ,left,right)),'D',
													  if(trim(stringlib.StringtoUpperCase(input.Duration),left,right) ='PERPETUAL' , 'P',''));										 
		    self.corp_term_exist_desc             :=if(_validate.date.fIsValid(trim(DurationDate,left,right)),'EXPIRATION DATE',
													  if(trim(stringlib.StringtoUpperCase(input.Duration),left,right) ='PERPETUAL', 'PERPETUAL',''));	
			self.corp_term_exist_exp              :=if(_validate.date.fIsValid(trim(DurationDate,left,right)),trim(DurationDate,left,right),'');
			
			self.corp_inc_date                    :=if(trim(stringlib.StringtoUpperCase(input.StateOfIncorporation),left,right) = 'MS' and _validate.date.fIsValid(StringLib.StringFilterOut(input.DateFormed,'-')[1..8]) and 
			                                         _validate.date.fIsValid(StringLib.StringFilterOut(input.DateFormed,'-')[1..8],_validate.date.rules.DateInPast) and
													 (string)((integer)StringLib.StringFilterOut(input.DateFormed,'-')[1..8]) <> '0',
												     StringLib.StringFilterOut(input.DateFormed,'-')[1..8],
													 '');
            self.corp_forgn_date                  :=if(trim(stringlib.StringtoUpperCase(input.StateOfIncorporation),left,right) <> 'MS' and _validate.date.fIsValid(StringLib.StringFilterOut(input.DateFormed,'-')[1..8]) and 
			                                         _validate.date.fIsValid(StringLib.StringFilterOut(input.DateFormed,'-')[1..8],_validate.date.rules.DateInPast) and
													 (string)((integer)StringLib.StringFilterOut(input.DateFormed,'-')[1..8]) <> '0',
													StringLib.StringFilterOut(input.DateFormed,'-')[1..8],
													'');
  		    self.corp_inc_state                   :=if(trim(stringlib.StringtoUpperCase(input.StateOfIncorporation),left,right) = 'MS','MS','');
            self.corp_forgn_state_cd              :=if(trim(stringlib.StringtoUpperCase(input.StateOfIncorporation),left,right) <> 'MS',regexreplace('["]{1,}',trim(stringlib.StringtoUpperCase(input.StateOfIncorporation),left,right),''),'');
			
            CountyOfIncorporation1                :=regexreplace('["]{1,}',trim(stringlib.StringtoUpperCase(input.CountyOfIncorporation),left,right),'');											
			self.corp_inc_county                  := if(trim(CountyOfIncorporation1,left,right)<>'',CountyOfIncorporation1,'');
			
		    self.corp_orig_org_structure_cd            :=if(trim(input.CorporationTypeID,left,right)<>'',trim(stringlib.StringtoUpperCase(input.CorporationTypeID),left,right),'');
            self.corp_orig_org_structure_desc          :=map(trim(input.CorporationTypeID,left,right)= '10'=>'LIMITED PARTNERSHIPS',
														trim(input.CorporationTypeID,left,right)= '12'=>'BANK',
														trim(input.CorporationTypeID,left,right)= '13'=>'AGRICULTURAL CREDIT ASSOCIATION',
														trim(input.CorporationTypeID,left,right)= '14'=>'BURIAL INSURANCE COMPANY',
														trim(input.CorporationTypeID,left,right)= '16'=>'BUSINESS CORPORATION',
														trim(input.CorporationTypeID,left,right)= '17'=>'AQUATIC AUTHORITY',
														trim(input.CorporationTypeID,left,right)= '18'=>'COOPERATIVE AAL',
														trim(input.CorporationTypeID,left,right)= '19'=>'LIMITED LIABILITY COMPANY',
														trim(input.CorporationTypeID,left,right)= '20'=>'LIMITED LIABILITY PARTNERSHIP',
														trim(input.CorporationTypeID,left,right)= '21'=>'FOREIGN BUSINESS TRUST',
														trim(input.CorporationTypeID,left,right)= '22'=>'FRESH & SALT WATER ASSOCIATION',
														trim(input.CorporationTypeID,left,right)= '23'=>'ELECTRIC POWER ASSOCIATION',
														trim(input.CorporationTypeID,left,right)= '24'=>'FARM CREDIT ASSOCIATION',
														trim(input.CorporationTypeID,left,right)= '25'=>'NON-PROFIT CORPORATION',
														trim(input.CorporationTypeID,left,right)= '26'=>'PROFESSIONAL CORPORATION',
														trim(input.CorporationTypeID,left,right)= '27'=>'INVESTMENT TRUST',
														trim(input.CorporationTypeID,left,right)= '28'=>'SAVINGS & LOAN ',
														trim(input.CorporationTypeID,left,right)= '29'=>'JOINT MUNICIPAL & ELECTRIC POWER & ENERGY',
														trim(input.CorporationTypeID,left,right)= '31'=>'RAILROAD AUTHORITY',
														trim(input.CorporationTypeID,left,right)= '32'=>'PROFESSIONAL LIMITED LIABILITY COMPANY',
														trim(input.CorporationTypeID,left,right)= '33'=>'OTHER BUSINESS ENTITY',
														trim(input.CorporationTypeID,left,right)= '35'=>'HOSPITAL SERVICES ASSOCIATION',
														trim(input.CorporationTypeID,left,right)= '44'=>'BUSINESS DEVELOPMENT CORPORATION',
														trim(input.CorporationTypeID,left,right)= '46'=>'CREDIT UNION',
														trim(input.CorporationTypeID,left,right)= '47'=>'HOSPITAL',
														trim(input.CorporationTypeID,left,right)= '48'=>'LIFE INSURANCE COMPANY',
														trim(input.CorporationTypeID,left,right)= '49'=>'MARKETING ASSOCIATION',
														trim(input.CorporationTypeID,left,right)= '50'=>'MOTOR AUTO ASSOCIATION',
														trim(input.CorporationTypeID,left,right)= '51'=>'PROFESSIONAL LIMITED LIABILITY PARTNERSHIP',
														trim(input.CorporationTypeID,left,right)= '52'=>'REGISTERED NAME',
														trim(input.CorporationTypeID,left,right)= '53'=>'RESERVED NAME',
														trim(input.CorporationTypeID,left,right)= '54'=>'SERVICEMARK/TRADEMARK',
														trim(input.CorporationTypeID,left,right)= '55'=>'SOIL CONSERVATION ASSOCIATION',
														trim(input.CorporationTypeID,left,right)= '56'=>'SOLID WASTE AUTHORITY',
														trim(input.CorporationTypeID,left,right)= '58'=>'OTHER REGISTRATIONS',
														trim(input.CorporationTypeID,left,right)= '59'=>'OIL & GAS',
														trim(input.CorporationTypeID,left,right)= '61'=>'MUNICIPAL CORPORATION','');
			Purpose1                              :=regexreplace('["]{1,}',trim(stringlib.StringtoUpperCase(input.Purpose),left,right),'');											
			self.corp_orig_bus_type_desc          := if(trim(Purpose1,left,right)<>'','Purpose:'+Purpose1,'');                                  
			string corpforeigndomesticind         :=regexreplace('["]{1,}',trim(input.Citizenship,left,right),'');
			self.corp_foreign_domestic_ind        :=if(trim(corpforeigndomesticind,left,right)<>'',trim(stringlib.StringtoUpperCase(corpforeigndomesticind),left,right),'');                                  
			RegisteredAgetname                    :=regexreplace('["]{1,}',trim(input.RegisteredAgenmsame,left,right),'');
			RegisteredAgetSuffix                  :=regexreplace('["]{1,}',trim(input.Suffix,left,right),'');
		    self.corp_ra_name                     :=stringlib.StringtoUpperCase(RegisteredAgetname )+stringlib.StringtoUpperCase(RegisteredAgetSuffix);		
			self.corp_ra_address_type_cd		  := '10';
											  
		    self.corp_ra_address_type_desc	      := 'REGISTERED ADDRESS';
											
			
            self.corp_ra_address_line1            :=if(trim(input.Address1,left,right)<>'',regexreplace('["]{1,}',trim(stringlib.StringtoUpperCase(input.Address1),left,right),''),'');
			self.corp_ra_address_line2            :=if(trim(input.Address2,left,right)<>'',regexreplace('["]{1,}',trim(stringlib.StringtoUpperCase(input.Address2),left,right),''),'');
			self.corp_ra_address_line3            :=if(trim(input.Address3,left,right)<>'',regexreplace('["]{1,}',trim(stringlib.StringtoUpperCase(input.Address3),left,right),''),'');
			self.corp_ra_address_line4            :=if(regexreplace('["]{1,}',trim(input.City,left,right),'')<>'',regexreplace('["]{1,}',trim(stringlib.StringtoUpperCase(input.City),left,right),'')+',','')+regexreplace('["]{1,}',trim(stringlib.StringtoUpperCase(input.State),left,right),'')+' '+
			                                        regexreplace('["]{1,}',trim(stringlib.StringtoUpperCase(input.Zip),left,right),'');
			self.corp_ra_address_line5            :=if(trim(input.County,left,right)<>'',regexreplace('["]{1,}',trim(stringlib.StringtoUpperCase(input.County),left,right),''),'');
			self.corp_ra_address_line6            :=if(not lib_stringlib.StringLib.StringFind(trim(stringlib.StringtoUpperCase(input.Country),left,right),'UNITED STATES',1) <>0 and
                                                       not lib_stringlib.StringLib.StringFind(trim(stringlib.StringtoUpperCase(input.Country),left,right),'USA',1) <>0 and
	                                                   not lib_stringlib.StringLib.StringFind(trim(stringlib.StringtoUpperCase(input.Country),left,right),'US',1) <>0 ,
                                                       regexreplace('["]{1,}',trim(stringlib.StringtoUpperCase(input.Country),left,right),''),'');  
			self                                  := [];
			
			
		   
		
        end; //End of corp1 transform.
		
		
			
		
		corp2_mapping.Layout_CorpPreClean corpLegalNonRATransform1(corp2_mapping.Layout_CorpPreClean input, layouts_raw_input.Corp_Name_Add r) := transform,skip(trim(r.AddressTypeID,left,right) = '10' or trim(r.AddressTypeID,left,right) = '11' or	trim(r.AddressTypeID,left,right) = '14' or	trim(r.AddressTypeID,left,right) = '')																																																																																										
																																																				
																																																			
            self.corp_address1_line1              :=if(trim(r.Address1,left,right)<>'',regexreplace('["]{1,}',trim(stringlib.StringtoUpperCase(r.Address1),left,right),''),'');
			self.corp_address1_line2              :=if(trim(r.Address2,left,right)<>'',regexreplace('["]{1,}',trim(stringlib.StringtoUpperCase(r.Address2),left,right),''),'');
			self.corp_address1_line3              :=if(trim(r.Address3,left,right)<>'',regexreplace('["]{1,}',trim(stringlib.StringtoUpperCase(r.Address3),left,right),''),'');
		
			self.corp_address1_line4              :=if(regexreplace('["]{1,}',trim(r.City,left,right),'')<>'',regexreplace('["]{1,}',trim(stringlib.StringtoUpperCase(r.City),left,right),'')+',','')+regexreplace('["]{1,}',trim(stringlib.StringtoUpperCase(r.State),left,right),'')+' '+
			                                        regexreplace('["]{1,}',trim(stringlib.StringtoUpperCase(r.Zip),left,right),'');
			self.corp_address1_line5              :=if(trim(r.County,left,right)<>'',regexreplace('["]{1,}',trim(stringlib.StringtoUpperCase(r.County),left,right),''),'');
			self.corp_address1_line6              :=if(not lib_stringlib.StringLib.StringFind(trim(stringlib.StringtoUpperCase(r.Country),left,right),'UNITED STATES',1) <>0 and
                                                       not lib_stringlib.StringLib.StringFind(trim(stringlib.StringtoUpperCase(r.Country),left,right),'USA',1) <>0 and
	                                                   not lib_stringlib.StringLib.StringFind(trim(stringlib.StringtoUpperCase(r.Country),left,right),'US',1) <>0 ,
                                                       regexreplace('["]{1,}',trim(stringlib.StringtoUpperCase(r.Country),left,right),''),'');
         	self.corp_address1_type_cd            :=map(trim(r.AddressTypeID,left,right)='1'=>'M',
			                               		        trim(r.AddressTypeID,left,right)='7'=>'F',
			                                            trim(r.AddressTypeID,left,right)='8'=>'B',
                                   			           														
			                                            ''
														);
			self.corp_address1_type_desc          :=map(trim(r.AddressTypeID,left,right)='1'=>'MAILING',
			                                            trim(r.AddressTypeID,left,right)='6'=>'PREVIOUS MAILING',
														trim(r.AddressTypeID,left,right)='7'=>'FILING',
			                                            trim(r.AddressTypeID,left,right)='8'=>'BUSINESS',
                                                        trim(r.AddressTypeID,left,right)='9'=>'PREVIOUS BUSINESS',
			                                            trim(r.AddressTypeID,left,right)='15'=>'OTHER',
			                                            ''
														)
														
														;
			self								  := input;
		end; 		
		
		
		corp2_mapping.Layout_CorpPreClean corpLegalNonRATransform2(layouts_raw_input.Corp_Name_Add input) := transform,skip(	trim(input.addressTypeID,left,right) = '10' or
																																trim(input.addressTypeID,left,right) = '11' or
																																trim(input.addressTypeID,left,right) = '14' or
																																trim(input.addressTypeID,left,right) = '24' or
																																trim(input.address1,left,right) = ''
																															)																																																																																										
																																																				
			self.dt_first_seen					  :=fileDate;
			self.dt_last_seen					  :=fileDate;
			self.dt_vendor_first_reported		  :=fileDate;
			self.dt_vendor_last_reported		  :=fileDate;
			self.corp_ra_dt_first_seen			  :=fileDate;
			self.corp_ra_dt_last_seen			  :=fileDate;
			self.corp_key					      :='28-'+Remove(trim(input.CorporationNumber,left, right));
			self.corp_vendor					  :='28';
		    self.corp_state_origin                :='MS';
			self.corp_process_date				  := fileDate;    
     	    self.corp_orig_sos_charter_nbr        :=Remove(trim(input.CorporationNumber,left, right));
			
			string name                           :=regexreplace('["]{1,}',input.Name,'');											
		    self.corp_legal_name                  :=if(trim(name,left,right)<>'',trim(stringlib.StringtoUpperCase(name),left,right),'');											
			self.corp_internal_nbr                :='';

	        self.corp_ln_name_type_cd             :=map(trim(input.NameTypeID,left,right)='2'=>'02',
			                                            trim(input.NameTypeID,left,right)='20'=>'N',
														trim(input.NameTypeID,left,right)='13'=>'01',
			                                            trim(input.NameTypeID,left,right)='5'=>'01',
														trim(input.NameTypeID,left,right)='1'=>'01',
			                                            trim(input.NameTypeID,left,right)='15'=>'P',
														trim(input.NameTypeID,left,right)='3'=>'P',
			                                            trim(input.NameTypeID,left,right)='19'=>'P',
														trim(input.NameTypeID,left,right)='18'=>'02',
			                                            trim(input.NameTypeID,left,right)='14'=>'07',
														trim(input.NameTypeID,left,right)='10'=>'01',
			                                            ''
														);    
			self.corp_ln_name_type_desc           :=map(trim(input.NameTypeID,left,right)='2'=>'DBA',
			                                            trim(input.NameTypeID,left,right)='20'=>'FBN',
														trim(input.NameTypeID,left,right)='13'=>'LEGAL',
			                                            trim(input.NameTypeID,left,right)='5'=>'LEGAL',
														trim(input.NameTypeID,left,right)='1'=>'LEGAL',
			                                            trim(input.NameTypeID,left,right)='15'=>'PRIOR',
														trim(input.NameTypeID,left,right)='3'=>'PRIOR',
			                                            trim(input.NameTypeID,left,right)='19'=>'PRIOR',
														trim(input.NameTypeID,left,right)='18'=>'DBA',
			                                            trim(input.NameTypeID,left,right)='14'=>'RESERVED',
														trim(input.NameTypeID,left,right)='10'=>'LEGAL',
			                                            ''
														); 

		    self.corp_status_cd                   :=if(trim(input.CorporationStatusID,left,right)<>'',trim(input.CorporationStatusID,left,right),'');
            self.corp_status_desc                 :=map(trim(input.CorporationStatusID,left,right)= '1'=>'RESERVED NAME' ,
														trim(input.CorporationStatusID,left,right)= '2'=>'ACTIVE' ,
														trim(input.CorporationStatusID,left,right)= '3'=>'GOOD STANDING' ,
														trim(input.CorporationStatusID,left,right)= '4'=>'INACTIVE' ,
														trim(input.CorporationStatusID,left,right)= '5'=>'IN PROCESS' ,
														trim(input.CorporationStatusID,left,right)= '7'=>'FORFEITED' ,
														trim(input.CorporationStatusID,left,right)= '8'=>'DISSOLVED' ,
														trim(input.CorporationStatusID,left,right)= '9'=>'CONVERTED' ,
														trim(input.CorporationStatusID,left,right)= '11'=>'WITHDRAWN BY MERGER' ,
														trim(input.CorporationStatusID,left,right)= '24'=>'MERGED' ,
														trim(input.CorporationStatusID,left,right)= '25'=>'NON-QUALIFIED' ,
														trim(input.CorporationStatusID,left,right)= '26'=>'ACCEPTANCE INACTIVE' ,
														trim(input.CorporationStatusID,left,right)= '27'=>'CONSOLIDATED INACTIVE' ,
														trim(input.CorporationStatusID,left,right)= '28'=>'WITHDRAWN' ,
														trim(input.CorporationStatusID,left,right)= '29'=>'INTENT TO DISSOLVE - TAX ' ,
														trim(input.CorporationStatusID,left,right)= '30'=>'INTENT TO DISSOLVE - AR' ,
														trim(input.CorporationStatusID,left,right)= '31'=>'INTENT TO DISSOLVE - RA' ,
														trim(input.CorporationStatusID,left,right)= '32'=>'INTENT TO DISSOLVE: RA/T' ,
														trim(input.CorporationStatusID,left,right)= '33'=>'INTENT TO DISSOLVE: RA/AR' ,
														trim(input.CorporationStatusID,left,right)= '34'=>'INTENT TO DISSOLVE: AR/T' ,
														trim(input.CorporationStatusID,left,right)= '35'=>'INTENT DISSOLVE:RA/T/AR' ,
														trim(input.CorporationStatusID,left,right)= '36'=>'VOID - AFF/VOID' ,
														trim(input.CorporationStatusID,left,right)= '37'=>'VOID - CHAR/VOID/FEE' ,
														trim(input.CorporationStatusID,left,right)= '38'=>'VOID - FAILURE TO FILE ' ,
														trim(input.CorporationStatusID,left,right)= '39'=>'VOID - FALSIFIED DOCUMENT' ,
														trim(input.CorporationStatusID,left,right)= '40'=>'CANCELLED' ,
														trim(input.CorporationStatusID,left,right)= '41'=>'REVOKED' ,
														trim(input.CorporationStatusID,left,right)= '42'=>'NAME CHANGE' ,
														trim(input.CorporationStatusID,left,right)= '43'=>'EXPIRED NAME' ,'');
		    self.corp_status_date                 :=if(_validate.date.fIsValid(StringLib.StringFilterOut(input. DissolveDate,'-')[1..8]) and 
			                                         _validate.date.fIsValid(StringLib.StringFilterOut(input. DissolveDate,'-')[1..8],_validate.date.rules.DateInPast) and
													 	(string)((integer)StringLib.StringFilterOut(input. DissolveDate,'-')[1..8]) <> '0',
														StringLib.StringFilterOut(input. DissolveDate,'-')[1..8],
														''
													  );
			string date                           :=trim(regexreplace('["]{1,}',input.Duration,''),left,right);										  
		    string DurationDate                   :=reformatDate(date);													  
			self.corp_term_exist_cd               :=if(_validate.date.fIsValid(trim(DurationDate ,left,right)),'D',
													  if(trim(stringlib.StringtoUpperCase(input.Duration),left,right) ='PERPETUAL' , 'P',''));										 
		    self.corp_term_exist_desc             :=if(_validate.date.fIsValid(trim(DurationDate,left,right)),'EXPIRATION DATE',
													  if(trim(stringlib.StringtoUpperCase(input.Duration),left,right) ='PERPETUAL', 'PERPETUAL',''));	
			self.corp_term_exist_exp              :=if(_validate.date.fIsValid(trim(DurationDate,left,right)),trim(DurationDate,left,right),'');
			
			self.corp_inc_date                    :=if(trim(stringlib.StringtoUpperCase(input.StateOfIncorporation),left,right) = 'MS' and _validate.date.fIsValid(StringLib.StringFilterOut(input.DateFormed,'-')[1..8]) and 
			                                         _validate.date.fIsValid(StringLib.StringFilterOut(input.DateFormed,'-')[1..8],_validate.date.rules.DateInPast) and
													 (string)((integer)StringLib.StringFilterOut(input.DateFormed,'-')[1..8]) <> '0',
												     StringLib.StringFilterOut(input.DateFormed,'-')[1..8],
													 '');
            self.corp_forgn_date                  :=if(trim(stringlib.StringtoUpperCase(input.StateOfIncorporation),left,right) <> 'MS' and _validate.date.fIsValid(StringLib.StringFilterOut(input.DateFormed,'-')[1..8]) and 
			                                         _validate.date.fIsValid(StringLib.StringFilterOut(input.DateFormed,'-')[1..8],_validate.date.rules.DateInPast) and
													 (string)((integer)StringLib.StringFilterOut(input.DateFormed,'-')[1..8]) <> '0',
													StringLib.StringFilterOut(input.DateFormed,'-')[1..8],
													'');
  		    self.corp_inc_state                   :=if(trim(stringlib.StringtoUpperCase(input.StateOfIncorporation),left,right) = 'MS','MS','');
            self.corp_forgn_state_cd              :=if(trim(stringlib.StringtoUpperCase(input.StateOfIncorporation),left,right) <> 'MS',regexreplace('["]{1,}',trim(stringlib.StringtoUpperCase(input.StateOfIncorporation),left,right),''),'');
			
            CountyOfIncorporation1                :=regexreplace('["]{1,}',trim(stringlib.StringtoUpperCase(input.CountyOfIncorporation),left,right),'');											
			self.corp_inc_county                  := if(trim(CountyOfIncorporation1,left,right)<>'',CountyOfIncorporation1,'');
			
		    self.corp_orig_org_structure_cd            :=if(trim(input.CorporationTypeID,left,right)<>'',trim(stringlib.StringtoUpperCase(input.CorporationTypeID),left,right),'');
            self.corp_orig_org_structure_desc          :=map(trim(input.CorporationTypeID,left,right)= '10'=>'LIMITED PARTNERSHIPS',
														trim(input.CorporationTypeID,left,right)= '12'=>'BANK',
														trim(input.CorporationTypeID,left,right)= '13'=>'AGRICULTURAL CREDIT ASSOCIATION',
														trim(input.CorporationTypeID,left,right)= '14'=>'BURIAL INSURANCE COMPANY',
														trim(input.CorporationTypeID,left,right)= '16'=>'BUSINESS CORPORATION',
														trim(input.CorporationTypeID,left,right)= '17'=>'AQUATIC AUTHORITY',
														trim(input.CorporationTypeID,left,right)= '18'=>'COOPERATIVE AAL',
														trim(input.CorporationTypeID,left,right)= '19'=>'LIMITED LIABILITY COMPANY',
														trim(input.CorporationTypeID,left,right)= '20'=>'LIMITED LIABILITY PARTNERSHIP',
														trim(input.CorporationTypeID,left,right)= '21'=>'FOREIGN BUSINESS TRUST',
														trim(input.CorporationTypeID,left,right)= '22'=>'FRESH & SALT WATER ASSOCIATION',
														trim(input.CorporationTypeID,left,right)= '23'=>'ELECTRIC POWER ASSOCIATION',
														trim(input.CorporationTypeID,left,right)= '24'=>'FARM CREDIT ASSOCIATION',
														trim(input.CorporationTypeID,left,right)= '25'=>'NON-PROFIT CORPORATION',
														trim(input.CorporationTypeID,left,right)= '26'=>'PROFESSIONAL CORPORATION',
														trim(input.CorporationTypeID,left,right)= '27'=>'INVESTMENT TRUST',
														trim(input.CorporationTypeID,left,right)= '28'=>'SAVINGS & LOAN ',
														trim(input.CorporationTypeID,left,right)= '29'=>'JOINT MUNICIPAL & ELECTRIC POWER & ENERGY',
														trim(input.CorporationTypeID,left,right)= '31'=>'RAILROAD AUTHORITY',
														trim(input.CorporationTypeID,left,right)= '32'=>'PROFESSIONAL LIMITED LIABILITY COMPANY',
														trim(input.CorporationTypeID,left,right)= '33'=>'OTHER BUSINESS ENTITY',
														trim(input.CorporationTypeID,left,right)= '35'=>'HOSPITAL SERVICES ASSOCIATION',
														trim(input.CorporationTypeID,left,right)= '44'=>'BUSINESS DEVELOPMENT CORPORATION',
														trim(input.CorporationTypeID,left,right)= '46'=>'CREDIT UNION',
														trim(input.CorporationTypeID,left,right)= '47'=>'HOSPITAL',
														trim(input.CorporationTypeID,left,right)= '48'=>'LIFE INSURANCE COMPANY',
														trim(input.CorporationTypeID,left,right)= '49'=>'MARKETING ASSOCIATION',
														trim(input.CorporationTypeID,left,right)= '50'=>'MOTOR AUTO ASSOCIATION',
														trim(input.CorporationTypeID,left,right)= '51'=>'PROFESSIONAL LIMITED LIABILITY PARTNERSHIP',
														trim(input.CorporationTypeID,left,right)= '52'=>'REGISTERED NAME',
														trim(input.CorporationTypeID,left,right)= '53'=>'RESERVED NAME',
														trim(input.CorporationTypeID,left,right)= '54'=>'SERVICEMARK/TRADEMARK',
														trim(input.CorporationTypeID,left,right)= '55'=>'SOIL CONSERVATION ASSOCIATION',
														trim(input.CorporationTypeID,left,right)= '56'=>'SOLID WASTE AUTHORITY',
														trim(input.CorporationTypeID,left,right)= '58'=>'OTHER REGISTRATIONS',
														trim(input.CorporationTypeID,left,right)= '59'=>'OIL & GAS',
														trim(input.CorporationTypeID,left,right)= '61'=>'MUNICIPAL CORPORATION','');
			Purpose1                              :=regexreplace('["]{1,}',trim(stringlib.StringtoUpperCase(input.Purpose),left,right),'');											
			self.corp_orig_bus_type_desc          := if(trim(Purpose1,left,right)<>'','Purpose:'+Purpose1,'');                                  
			string corpforeigndomesticind         :=regexreplace('["]{1,}',trim(input.Citizenship,left,right),'');
			self.corp_foreign_domestic_ind        :=if(trim(corpforeigndomesticind,left,right)<>'',trim(stringlib.StringtoUpperCase(corpforeigndomesticind),left,right),'');                                  																																																
            self.corp_address1_line1              :=if(trim(input.Address1,left,right)<>'',regexreplace('["]{1,}',trim(stringlib.StringtoUpperCase(input.Address1),left,right),''),'');
			self.corp_address1_line2              :=if(trim(input.Address2,left,right)<>'',regexreplace('["]{1,}',trim(stringlib.StringtoUpperCase(input.Address2),left,right),''),'');
			self.corp_address1_line3              :=if(trim(input.Address3,left,right)<>'',regexreplace('["]{1,}',trim(stringlib.StringtoUpperCase(input.Address3),left,right),''),'');
		
			self.corp_address1_line4              :=if(regexreplace('["]{1,}',trim(input.City,left,right),'')<>'',regexreplace('["]{1,}',trim(stringlib.StringtoUpperCase(input.City),left,right),'')+',','')+regexreplace('["]{1,}',trim(stringlib.StringtoUpperCase(input.State),left,right),'')+' '+
			                                        regexreplace('["]{1,}',trim(stringlib.StringtoUpperCase(input.Zip),left,right),'');
			self.corp_address1_line5              :=if(trim(input.County,left,right)<>'',regexreplace('["]{1,}',trim(stringlib.StringtoUpperCase(input.County),left,right),''),'');
			self.corp_address1_line6              :=if(not lib_stringlib.StringLib.StringFind(trim(stringlib.StringtoUpperCase(input.Country),left,right),'UNITED STATES',1) <>0 and
                                                       not lib_stringlib.StringLib.StringFind(trim(stringlib.StringtoUpperCase(input.Country),left,right),'USA',1) <>0 and
	                                                   not lib_stringlib.StringLib.StringFind(trim(stringlib.StringtoUpperCase(input.Country),left,right),'US',1) <>0 ,
                                                       regexreplace('["]{1,}',trim(stringlib.StringtoUpperCase(input.Country),left,right),''),'');
         	self.corp_address1_type_cd            :=map(trim(input.AddressTypeID,left,right)='1'=>'M',
			                               		        trim(input.AddressTypeID,left,right)='7'=>'F',
			                                            trim(input.AddressTypeID,left,right)='8'=>'B',
                                   			           														
			                                            ''
														);
			self.corp_address1_type_desc          :=map(trim(input.AddressTypeID,left,right)='1'=>'MAILING',
			                                            trim(input.AddressTypeID,left,right)='6'=>'PREVIOUS MAILING',
														trim(input.AddressTypeID,left,right)='7'=>'FILING',
			                                            trim(input.AddressTypeID,left,right)='8'=>'BUSINESS',
                                                        trim(input.AddressTypeID,left,right)='9'=>'PREVIOUS BUSINESS',
			                                            trim(input.AddressTypeID,left,right)='15'=>'OTHER',
			                                            ''
														)
														
														;
			self								  := [];
		end;
		
		  // corp2Transform
		 corp2_mapping.Layout_CorpPreClean corpNonLegalTransform(Layouts_Raw_Input.Corp_Name_Add input):=transform
     	    self.dt_first_seen					  :=fileDate;
			self.dt_last_seen					  :=fileDate;
			self.dt_vendor_first_reported		  :=fileDate;
			self.dt_vendor_last_reported		  :=fileDate;
			self.corp_ra_dt_first_seen			  :=fileDate;
			self.corp_ra_dt_last_seen			  :=fileDate;
			self.corp_key					      :='28-'+Remove(trim(input.CorporationNumber,left, right));
			self.corp_vendor					  :='28';
		    self.corp_state_origin                :='MS';
			self.corp_process_date				  := fileDate;    
     	    self.corp_orig_sos_charter_nbr        :=Remove(trim(input.CorporationNumber,left, right));
			string name                           :=regexreplace('["]{1,}',input.Name,'');											
		    self.corp_legal_name                  :=if(trim(name,left,right)<>'',trim(stringlib.StringtoUpperCase(name),left,right),'');
			self.corp_ln_name_type_cd             :=map(trim(input.NameTypeID,left,right)='2'=>'02',
			                                            trim(input.NameTypeID,left,right)='20'=>'N',
														trim(input.NameTypeID,left,right)='13'=>'01',
			                                            trim(input.NameTypeID,left,right)='5'=>'01',
														trim(input.NameTypeID,left,right)='1'=>'01',
			                                            trim(input.NameTypeID,left,right)='15'=>'P',
														trim(input.NameTypeID,left,right)='3'=>'P',
			                                            trim(input.NameTypeID,left,right)='19'=>'P',
														trim(input.NameTypeID,left,right)='18'=>'02',
			                                            trim(input.NameTypeID,left,right)='14'=>'07',
														trim(input.NameTypeID,left,right)='10'=>'01',
			                                            ''
														);
			self.corp_ln_name_type_desc           :=map(trim(input.NameTypeID,left,right)='2'=>'DBA',
			                                            trim(input.NameTypeID,left,right)='20'=>'FBN',
														trim(input.NameTypeID,left,right)='13'=>'LEGAL',
			                                            trim(input.NameTypeID,left,right)='5'=>'LEGAL',
														trim(input.NameTypeID,left,right)='1'=>'LEGAL',
			                                            trim(input.NameTypeID,left,right)='15'=>'PRIOR',
														trim(input.NameTypeID,left,right)='3'=>'PRIOR',
			                                            trim(input.NameTypeID,left,right)='19'=>'PRIOR',
														trim(input.NameTypeID,left,right)='18'=>'DBA',
			                                            trim(input.NameTypeID,left,right)='14'=>'RESERVED',
														trim(input.NameTypeID,left,right)='10'=>'LEGAL',
			                                            ''
														); 
			string date                           :=trim(regexreplace('["]{1,}',input.Duration,''),left,right);										  
		    string DurationDate                   :=reformatDate(date);													  
			self.corp_term_exist_cd               :=if(_validate.date.fIsValid(trim(DurationDate ,left,right)),'D',
													  if(trim(stringlib.StringtoUpperCase(input.Duration),left,right) ='PERPETUAL' , 'P',''));										 
		    self.corp_term_exist_desc             :=if(_validate.date.fIsValid(trim(DurationDate,left,right)),'EXPIRATION DATE',
													  if(trim(stringlib.StringtoUpperCase(input.Duration),left,right) ='PERPETUAL', 'PERPETUAL',''));	
			self.corp_term_exist_exp              :=if(_validate.date.fIsValid(trim(DurationDate,left,right)),trim(DurationDate,left,right),'');
			self                                  := [];
		
         end; //End of corp2 transform.

	     // AR_TRANSFORM 
	     Corp2.Layout_Corporate_Direct_AR_In ms_arTransform(layouts_raw_input.Filing_Corp  input):=transform,skip(trim(input.DocumentTypeID,left,right)<>'597' and  trim(input.DocumentTypeID,left,right)<>'600' and trim(input.DocumentTypeID,left,right)<>'607' )
		   
			self.corp_key					    := '28-' +Remove(trim(input.CorporationNumber,left, right));
			self.corp_vendor				    := '28';
			self.corp_state_origin			    := 'MS';
			self.corp_process_date			    := fileDate;
			self.corp_sos_charter_nbr		    := Remove(trim(input.CorporationNumber,left, right));
			
            self.ar_filed_dt                    :=if( _validate.date.fIsValid(StringLib.StringFilterOut(input.FilingDate,'-')[1..8]) and 
			                                         _validate.date.fIsValid(StringLib.StringFilterOut(input.FilingDate,'-')[1..8],_validate.date.rules.DateInPast) and
													 	(string)((integer)StringLib.StringFilterOut(input.FilingDate,'-')[1..8]) <> '0',
														StringLib.StringFilterOut(input.FilingDate,'-')[1..8],
														''
													  ); 
			
		    doc1_no                        	    :=['597','600','607'];									  
            self.ar_comment                     :=IF(trim(input.DocumentTypeID, left, right) in doc1_no,map(trim(input.DocumentTypeID,left,right)= '597'=>'ANNUAL REPORT',
														trim(input.DocumentTypeID,left,right)= '600'=>'AMENDED ANNUAL REPORT',
														trim(input.DocumentTypeID,left,right)= '607'=>'ANNUAL REPORT(NOTICE GIVEN)',
														''),'');
														
			self                                := [];

	     end; // end of ms_AR_transform M.R.
		
			
		 // Stock_TRANSFORM M.R.
	     Corp2.Layout_Corporate_Direct_Stock_In ms_stockTransform(layouts_raw_input.StockFile_Corp input):=transform,skip(trim(input.CorporationNumber,left, right)<>'' and trim(input.StockClassID,left,right)='' and  trim(input.Series,left,right)='' and  trim(input.AuthorizedShares,left,right)='' and  trim(input.ParValue,left,right)='' )
			self.corp_key					      := '28-' +Remove(trim(input.CorporationNumber,left, right));
			self.corp_vendor				      := '28';
			self.corp_state_origin			      := 'MS';
			self.corp_process_date			      := fileDate;
			self.corp_sos_charter_nbr		      :=Remove(trim(input.CorporationNumber,left, right));
			self.stock_class                      :=map(trim(input.StockClassID,left,right)= '1'=>'99 SEE CERT',
														trim(input.StockClassID,left,right)= '2'=>'COMMON',
														trim(input.StockClassID,left,right)= '3'=>'COMMON CLASS A NON VOTING',
														trim(input.StockClassID,left,right)= '4'=>'COMMON CLASS A VOTING',
														trim(input.StockClassID,left,right)= '5'=>'COMMON CLASS B NON VOTING',
														trim(input.StockClassID,left,right)= '6'=>'COMMON CLASS B VOTING',
														trim(input.StockClassID,left,right)= '7'=>'COMMON CLASS C',
														trim(input.StockClassID,left,right)= '8'=>'COMMON CLASS C VOTING',
														trim(input.StockClassID,left,right)= '9'=>'COMMON NON VOTING',
														trim(input.StockClassID,left,right)= '10'=>'COMMON VOTING',
														trim(input.StockClassID,left,right)= '11'=>'PREFERRED',
														'');
														
			stockaddlinfo                   :=if(trim(input.Series,left,right)<>'','SERIES:'+trim(stringlib.StringtoUpperCase(regexreplace('["]{1,}',input.Series,'')),left,right),'');
			self.stock_addl_info            :=if(trim(stockaddlinfo ,left,right)<>'0',  trim(stockaddlinfo ,left,right) ,'');    
			stockauthorizednbr              :=if(trim(input.AuthorizedShares,left,right)<>'',trim(input.AuthorizedShares,left,right),'');
			self.stock_authorized_nbr       :=if(trim(stockauthorizednbr ,left,right)<>'0',  trim(stockauthorizednbr ,left,right) ,''); 

			self.stock_par_value            :=if(trim(input.ParValue,left,right)<>''and trim(input.ParValue,left,right)<>'0',trim(input.ParValue,left,right),'');
        	self                                  := [];
			
			
		 end; // end of ms_Stock_transform M.R.
		
		 // Event_TRANSFORM M.R.
		 Corp2.Layout_Corporate_Direct_Event_In ms_eventTransform(layouts_raw_input.Filing_Corp input):=transform,skip(trim(input.DocumentTypeID,left,right)='597' or trim(input.DocumentTypeID,left,right)='600' or trim(input.DocumentTypeID,left,right)='607' )
		    doc_no                        	    :=['597','600','607'];
			self.corp_key					    := '28-' +Remove(trim(input.CorporationNumber,left, right));
			self.corp_vendor				    := '28';
			self.corp_state_origin			    := 'MS';
			self.corp_process_date			    := fileDate;
			self.corp_sos_charter_nbr		    :=Remove(trim(input.CorporationNumber,left, right));
												  
		 		
			self.event_filing_date              :=if(trim(input.DocumentTypeID, left, right) ~in doc_no and _validate.date.fIsValid(StringLib.StringFilterOut(input.FilingDate,'-')[1..8]) and 
			                                         _validate.date.fIsValid(StringLib.StringFilterOut(input.FilingDate,'-')[1..8],_validate.date.rules.DateInPast) and
													 	(string)((integer)StringLib.StringFilterOut(input.FilingDate,'-')[1..8]) <> '0',
														StringLib.StringFilterOut(input.FilingDate,'-')[1..8],
														''
													  );
			
            self.event_date_type_cd             :=if(trim(input.DocumentTypeID, left, right) ~in doc_no and _validate.date.fIsValid(StringLib.StringFilterOut(input.FilingDate,'-')[1..8]) and 
			                                         _validate.date.fIsValid(StringLib.StringFilterOut(input.FilingDate,'-')[1..8],_validate.date.rules.DateInPast) and
													 	(string)((integer)StringLib.StringFilterOut(input.FilingDate,'-')[1..8]) <> '0','FIL','');
													 
            self.event_date_type_desc           :=if(trim(input.DocumentTypeID, left, right) ~in doc_no and _validate.date.fIsValid(StringLib.StringFilterOut(input.FilingDate,'-')[1..8]) and 
			                                         _validate.date.fIsValid(StringLib.StringFilterOut(input.FilingDate,'-')[1..8],_validate.date.rules.DateInPast) and
													 	(string)((integer)StringLib.StringFilterOut(input.FilingDate,'-')[1..8]) <> '0','FILING','');
														
			
			self.event_desc                :=IF(trim(input.DocumentTypeID, left, right) ~in doc_no,trim(input.DocumentTypeID, left, right),'');										 

            self                                := [];
		
			
			
		 end; // end of ms_Event_transform M.R.
		 
		 	//layouts join for cont
		
		FinalOfficerFile := record
		string7 	OfficerID;
		string6 	Offi_CorporationID;
		string50 	Offi_Title;
		string20 	Offi_Salutation;
		string300 	Offi_Name;
		string70 	Offi_Address1;
		string70 	Offi_Address2;
		string70 	Offi_Address3;
		string50 	Offi_City;
		string2 	Offi_State;
		string10 	Offi_Zip;
		string50	Offi_County;
		string50 	Offi_CountryName;
		string6 	OwnerPercentage;
		string6 	TransferRealEstate;
		string6 	ForeignAddress;
		string1 	Offi_lf;
		
		string7 	OfficerPartyTypeID;
		string7 	Party_OfficerID;
		string4 	PartyTypeID;
		string1 	Party_lf;
		
		string6 	CorporationNameID;
		string6 	Name_CorporationID;
		string255 	Name;
		string2 	NameTypeID;
		string100 	Title;
		string50 	Salutation;
		string30	Prefix;
		string40 	Lasmsame;
		string40 	MiddleName;
		string40 	Firsmsame;
		string20 	Suffix;
		string1 	Name_lf;
		
		string6 	Corp_CorporationID;
		string7 	EntityID;
		string2 	CorporationTypeID;
		string2 	CorporationStatusID;
		string15	CorporationNumber;
		string1 	Citizenship;
        string23 	DateFormed;
        string23 	DissolveDate;
        string50 	Duration;
		string50 	CountyOfIncorporation;
		string2 	StateOfIncorporation;
		string50	 CountryOfIncorporation;
		string255 	Purpose;
		string80 	Profession;
		string255	RegisteredAgenmsame;
		string1 	lf;
		string      Title1;
		string      Title2;
		string      Title3;
		string      Title4;
		string      Title5;

		end;
		//------- join Officer with CorpName to get corporation name for corp_legal_name ------------------
		
		Layouts_Raw_Input.CorpNameOfficer MergeCont(Layouts_Raw_Input.CorporationName l, Layouts_Raw_Input.Officer r ) := transform
			self 					:= l;
			self					:= r;
			self                    := [];
			
		end; // end transform
		
		joinCorpNameOfficers := join(Files_Raw_Input.CORPORATIONNAME(fileDate), Files_Raw_Input.OFFICER(fileDate),
								trim(left.NAME_CorporationID,left,right) = trim(right.Offi_CorporationID,left,right),
								MergeCont(left,right),
								left outer
							);
		//------- join result of above with OfficerPartyType Table ------------------					
		Layouts_Raw_Input.CorpNameOfficerParty MergeContParty(Layouts_Raw_Input.CorpNameOfficer l, Layouts_Raw_Input.OfficerPartyType r ) := transform
			self 					:= l;
			self					:= r;
			self                    := [];
			
		end; // end transform
		
		joinCorpNameOfficerParty := join(joinCorpNameOfficers, Files_Raw_Input.OFFICERPARTYTYPE(fileDate),
								trim(left.OfficerID,left,right) = trim(right.Party_OfficerID,left,right),
								MergeContParty(left,right),
								left outer
							);
							
		//------- join result of above with Corporation for corp_sos_number								
	  Layouts_Raw_Input.CorpNameOfficerPartyNum MergeContPartyNum(Layouts_Raw_Input.CorpNameOfficerParty l, Layouts_Raw_Input.Corporation r ) := transform
			self 					:= l;
			self					:= r;
			self                    := [];
			
		end; // end transform
		
		joinCorpNameOfficerPartyNum := join(joinCorpNameOfficerParty, Files_Raw_Input.CORPORATION(fileDate),
								trim(left.NAME_CorporationID,left,right) = trim(right.Corp_CorporationID,left,right),
								MergeContPartyNum(left,right),
								left outer
							);
							
							
       //------- Denormalize above result to get all titles in one record ------------------
	   
	   sortOffFile		:= sort(joinCorpNameOfficerPartyNum, Corp_CorporationID,Offi_Name,Offi_Address1,Offi_Address2,Offi_Address3,Offi_city,Offi_state,Offi_zip);
	   
		distofficers 	:= distribute(sortOffFile,hash64(Corp_CorporationID,Offi_Name,Offi_Address1,Offi_Address2,Offi_Address3,Offi_city,Offi_state,Offi_zip));
		FinalOfficerFile	newTransform(joinCorpNameOfficerPartyNum l) := transform
			self			:=l;
			self			:=[];
		end;
		newOfficerFile		:= project(distOfficers, newTransform(left));
		
		
	  FinalOfficerFile DenormOfficers(FinalOfficerFile L, FinalOfficerFile R, INTEGER C) := TRANSFORM
		
			self.Title1 		:= IF (C=1, R.PartyTypeID,L.TITLE1);                  
			self.title2		  := IF (C=2, R.PartyTypeID,L.TITLE2);
			self.title3		  := IF (C=3, R.PartyTypeID,L.TITLE3); 
			self.title4		  := IF (C=4, R.PartyTypeID,L.TITLE4); 
			self.title5		  := IF (C=5, R.PartyTypeID,L.TITLE5); 
			self 						:= L;
		END;
		dedupNewOfficerFile := dedup(sort(newOfficerFile, Corp_CorporationID,Offi_Name,Offi_Address1,Offi_Address2,Offi_Address3,Offi_city,Offi_state,Offi_zip, PartyTypeID), Corp_CorporationID,Offi_Name,Offi_Address1,Offi_Address2,Offi_Address3,Offi_city,Offi_state,Offi_zip, PartyTypeID) ;


		DenormalizedFile := sort(denormalize(dedupNewOfficerFile, dedupNewOfficerFile,
											trim(left.Corp_CorporationID,left,right) = trim(right.Corp_CorporationID,left,right) and
											trim(left.Offi_name,left,right) = trim(right.Offi_name,left,right) and
											trim(left.Offi_Address1,left,right) = trim(right.Offi_Address1,left,right) and
											trim(left.Offi_Address2,left,right) = trim(right.Offi_Address2,left,right) and
											trim(left.Offi_Address3,left,right) = trim(right.Offi_Address3,left,right) and
											trim(left.Offi_city,left,right) = trim(right.Offi_city,left,right) and
											trim(left.Offi_state,left,right) = trim(right.Offi_state,left,right) and
											trim(left.Offi_zip,left,right) = trim(right.Offi_zip,left,right),
											DenormOfficers(left,right,COUNTER)),Corp_CorporationID,Offi_Name,Offi_Address1,Offi_Address2,Offi_Address3,Offi_city,Offi_state,Offi_zip, PartyTypeID);
											
											
		
		DedupDenormalized := dedup(DenormalizedFile, RECORD, EXCEPT Name, OfficerID, PartyTypeID);
		 
		 
		
		 // contact_TRANSFORM
		corp2_mapping.Layout_ContPreClean ms_contactTransform(FinalOfficerFile input):=transform
				self.dt_first_seen			      :=fileDate;
				self.dt_last_seen			      	:=fileDate;
				self.corp_key					 				:= '28-' +Remove(trim(input.CorporationNumber,left, right));
				self.corp_vendor				  		:= '28';
				self.corp_state_origin			  := 'MS';
				self.corp_process_date			  := fileDate;
				self.corp_orig_sos_charter_nbr    :=Remove(trim(input.CorporationNumber,left, right));
				string name                       :=regexreplace('["]{1,}',input.Name,'');											
				self.corp_legal_name              :=if(trim(name,left,right)<>'',trim(stringlib.StringtoUpperCase(name),left,right),'');	
				
				title1												:= map(	trim(input.Title1,left,right)= '1000'=>'ASSISTANTSECRETARY',
																							trim(input.Title1,left,right)= '1001'=>'ASSISTANT TREASURER',
																							trim(input.Title1,left,right)= '1007'=>'DIRECTOR',
																							trim(input.Title1,left,right)= '1022'=>'PRESIDENT',
																							trim(input.Title1,left,right)= '1023'=>'SECRETARY',
																							trim(input.Title1,left,right)= '1024'=>'TREASURER',
																							trim(input.Title1,left,right)= '1025'=>'VICE PRESIDENT',
																							trim(input.Title1,left,right)= '1027'=>'OTHER',
																							trim(input.Title1,left,right)= '1030'=>'REGISTERED AGENT WITH POWER OF ATTORNEY',
																							trim(input.Title1,left,right)= '2000'=>'MEMBER',
																							trim(input.Title1,left,right)= '2002'=>'INCORPORATOR',
																							trim(input.Title1,left,right)= '2003'=>'PARTNER',
																							trim(input.Title1,left,right)= '2004'=>'MANAGER',
																							trim(input.Title1,left,right)= '2007'=>'CHAIRMAN',
																							trim(input.Title1,left,right)= '2008'=>'ORGANIZER',
																							trim(input.Title1,left,right)= '2009'=>'TRUSTEE',
																							trim(input.Title1,left,right)= '2010'=>'GENERAL PARTNER',
																							trim(input.Title1,left,right)= '3000'=>'TRUSTEE',
																							'');
																						
			title2						             	:=map(	trim(input.Title2,left,right)= '1000'=>'ASSISTANTSECRETARY',
																							trim(input.Title2,left,right)= '1001'=>'ASSISTANT TREASURER',
																							trim(input.Title2,left,right)= '1007'=>'DIRECTOR',
																							trim(input.Title2,left,right)= '1022'=>'PRESIDENT',
																							trim(input.Title2,left,right)= '1023'=>'SECRETARY',
																							trim(input.Title2,left,right)= '1024'=>'TREASURER',
																							trim(input.Title2,left,right)= '1025'=>'VICE PRESIDENT',
																							trim(input.Title2,left,right)= '1027'=>'OTHER',
																							trim(input.Title2,left,right)= '1030'=>'REGISTERED AGENT WITH POWER OF ATTORNEY',
																							trim(input.Title2,left,right)= '2000'=>'MEMBER',
																							trim(input.Title2,left,right)= '2002'=>'INCORPORATOR',
																							trim(input.Title2,left,right)= '2003'=>'PARTNER',
																							trim(input.Title2,left,right)= '2004'=>'MANAGER',
																							trim(input.Title2,left,right)= '2007'=>'CHAIRMAN',
																							trim(input.Title2,left,right)= '2008'=>'ORGANIZER',
																							trim(input.Title2,left,right)= '2009'=>'TRUSTEE',
																							trim(input.Title2,left,right)= '2010'=>'GENERAL PARTNER',
																							trim(input.Title2,left,right)= '3000'=>'TRUSTEE',
																							'');
			
			title3						             	:=map(trim(input.Title3,left,right)= '1000'=>'ASSISTANTSECRETARY',
																						trim(input.Title3,left,right)= '1001'=>'ASSISTANT TREASURER',
																						trim(input.Title3,left,right)= '1007'=>'DIRECTOR',
																						trim(input.Title3,left,right)= '1022'=>'PRESIDENT',
																						trim(input.Title3,left,right)= '1023'=>'SECRETARY',
																						trim(input.Title3,left,right)= '1024'=>'TREASURER',
																						trim(input.Title3,left,right)= '1025'=>'VICE PRESIDENT',
																						trim(input.Title3,left,right)= '1027'=>'OTHER',
																						trim(input.Title3,left,right)= '1030'=>'REGISTERED AGENT WITH POWER OF ATTORNEY',
																						trim(input.Title3,left,right)= '2000'=>'MEMBER',
																						trim(input.Title3,left,right)= '2002'=>'INCORPORATOR',
																						trim(input.Title3,left,right)= '2003'=>'PARTNER',
																						trim(input.Title3,left,right)= '2004'=>'MANAGER',
																						trim(input.Title3,left,right)= '2007'=>'CHAIRMAN',
																						trim(input.Title3,left,right)= '2008'=>'ORGANIZER',
																						trim(input.Title3,left,right)= '2009'=>'TRUSTEE',
																						trim(input.Title3,left,right)= '2010'=>'GENERAL PARTNER',
																						trim(input.Title3,left,right)= '3000'=>'TRUSTEE',
																						'');
														
			title4				            			:=map(trim(input.Title4,left,right)= '1000'=>'ASSISTANTSECRETARY',
																						trim(input.Title4,left,right)= '1001'=>'ASSISTANT TREASURER',
																						trim(input.Title4,left,right)= '1007'=>'DIRECTOR',
																						trim(input.Title4,left,right)= '1022'=>'PRESIDENT',
																						trim(input.Title4,left,right)= '1023'=>'SECRETARY',
																						trim(input.Title4,left,right)= '1024'=>'TREASURER',
																						trim(input.Title4,left,right)= '1025'=>'VICE PRESIDENT',
																						trim(input.Title4,left,right)= '1027'=>'OTHER',
																						trim(input.Title4,left,right)= '1030'=>'REGISTERED AGENT WITH POWER OF ATTORNEY',
																						trim(input.Title4,left,right)= '2000'=>'MEMBER',
																						trim(input.Title4,left,right)= '2002'=>'INCORPORATOR',
																						trim(input.Title4,left,right)= '2003'=>'PARTNER',
																						trim(input.Title4,left,right)= '2004'=>'MANAGER',
																						trim(input.Title4,left,right)= '2007'=>'CHAIRMAN',
																						trim(input.Title4,left,right)= '2008'=>'ORGANIZER',
																						trim(input.Title4,left,right)= '2009'=>'TRUSTEE',
																						trim(input.Title4,left,right)= '2010'=>'GENERAL PARTNER',
																						trim(input.Title4,left,right)= '3000'=>'TRUSTEE',
																						'');
														
			title5								          :=map(trim(input.Title5,left,right)= '1000'=>'ASSISTANTSECRETARY',
																						trim(input.Title5,left,right)= '1001'=>'ASSISTANT TREASURER',
																						trim(input.Title5,left,right)= '1007'=>'DIRECTOR',
																						trim(input.Title5,left,right)= '1022'=>'PRESIDENT',
																						trim(input.Title5,left,right)= '1023'=>'SECRETARY',
																						trim(input.Title5,left,right)= '1024'=>'TREASURER',
																						trim(input.Title5,left,right)= '1025'=>'VICE PRESIDENT',
																						trim(input.Title5,left,right)= '1027'=>'OTHER',
																						trim(input.Title5,left,right)= '1030'=>'REGISTERED AGENT WITH POWER OF ATTORNEY',
																						trim(input.Title5,left,right)= '2000'=>'MEMBER',
																						trim(input.Title5,left,right)= '2002'=>'INCORPORATOR',
																						trim(input.Title5,left,right)= '2003'=>'PARTNER',
																						trim(input.Title5,left,right)= '2004'=>'MANAGER',
																						trim(input.Title5,left,right)= '2007'=>'CHAIRMAN',
																						trim(input.Title5,left,right)= '2008'=>'ORGANIZER',
																						trim(input.Title5,left,right)= '2009'=>'TRUSTEE',
																						trim(input.Title5,left,right)= '2010'=>'GENERAL PARTNER',
																						trim(input.Title5,left,right)= '3000'=>'TRUSTEE',
																						'');																						
				
				concatFields									:= 	trim(Title1,left,right) + ';' + 
																					trim(Title2,left,right) + ';' +  
																					trim(Title3,left,right) + ';' + 
																					trim(Title4,left,right) + ';' + 
																					trim(Title5,left,right);
				
			tempExp													:= regexreplace('[;]*$',concatFields,'',NOCASE);
			tempExp2												:= regexreplace('^[;]*',tempExp,'',NOCASE);
			self.cont_title1_desc         	:= regexreplace('[;]+',tempExp2,';',NOCASE);  
													

														
			string name1                    :=regexreplace('["]{1,}',input.Offi_Name ,'');	
      self.cont_name                    :=if(trim(name1,left,right)<>'',trim(stringlib.StringtoUpperCase(name1),left,right),'');
			self.cont_type_cd                 :='F';
      self.cont_type_desc               :='OFFICER';
      self.cont_address_line1            :=if(trim(input.Offi_Address1,left,right)<>'',regexreplace('["]{1,}',trim(stringlib.StringtoUpperCase(input.Offi_Address1),left,right),''),'');
			self.cont_address_line2            :=if(trim(input.Offi_Address2,left,right)<>'',regexreplace('["]{1,}',trim(stringlib.StringtoUpperCase(input.Offi_Address2),left,right),''),'');
			self.cont_address_line3            :=if(trim(input.Offi_Address3,left,right)<>'',regexreplace('["]{1,}',trim(stringlib.StringtoUpperCase(input.Offi_Address3),left,right),''),'');
			self.cont_address_line4            :=if(regexreplace('["]{1,}',trim(input.Offi_City,left,right),'')<>'',regexreplace('["]{1,}',trim(stringlib.StringtoUpperCase(input.Offi_City),left,right),'')+',','')+regexreplace('["]{1,}',trim(stringlib.StringtoUpperCase(input.Offi_State),left,right),'')+' '+
			                                    regexreplace('["]{1,}',trim(stringlib.StringtoUpperCase(input.Offi_Zip),left,right),'');
			self.cont_address_line5            :=if(trim(input.Offi_County,left,right)<>'',regexreplace('["]{1,}',trim(stringlib.StringtoUpperCase(input.Offi_County),left,right),''),'');
			self.cont_address_line6            :=if(not lib_stringlib.StringLib.StringFind(trim(stringlib.StringtoUpperCase(input.Offi_CountryName),left,right),'UNITED STATES',1) <>0 and
                                                   not lib_stringlib.StringLib.StringFind(trim(stringlib.StringtoUpperCase(input.Offi_CountryName),left,right),'USA',1) <>0 and
	                                               not lib_stringlib.StringLib.StringFind(trim(stringlib.StringtoUpperCase(input.Offi_CountryName),left,right),'US',1) <>0 ,
                                                   regexreplace('["]{1,}',trim(stringlib.StringtoUpperCase(input.Offi_CountryName),left,right),''),'');
													  		   
            self                              := [];
			
		 end; // end of ms_contact_transform     
		
		
		
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
			self.corp_addr1_unit_desig 	  		:= clean_address1[28..56];
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
			self.corp_ra_unit_desig 	  		:= clean_address[28..56];
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
		 end; //*********************cleaned corp routine ends********
		
		
		     
			 
			 
			 
		//******************Cont Cleaning starts.****************
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
			self.cont_unit_desig 	  		:= clean_address[28..56];
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
		end;  //************************Cont cleaning ends*****************
		
		//---------------------------layouts join for corp-----------------------//
		Layouts_Raw_Input.Corp_Name MergeCorp_Name(  Layouts_Raw_Input.Corporation  l ,Layouts_Raw_Input.CorporationName  r ) := transform
		    self 					:= l;
		    self					:= r;
		    self                    := [];
			
		end; // end transform 
		
		joinCorp_Name := join(	Files_Raw_Input.CORPORATION(fileDate),Files_Raw_Input.CORPORATIONNAME(fileDate), 
								trim(left.Corp_CorporationID,left,right) = trim(right.Name_CorporationID,left,right),
								MergeCorp_Name(left,right),
								left outer
							);
							
		LegalNamesOnly 	:= joinCorp_Name(	trim(NameTypeId,left,right) = '1' or 
																			trim(NameTypeId,left,right) = '5' or 
																			trim(NameTypeID,left,right) = '10' or
																			trim(NameTypeID,left,right) = '13');
		NonLegalNames	:= joinCorp_Name(	trim(NameTypeId,left,right) <> '1' and
																		trim(NameTypeid,left,right) <> '5' and
																		trim(NameTypeid,left,right) <> '10' and
																		trim(NameTypeid,left,right) <> '13');
								
		Layouts_Raw_Input.Corp_Name_Add MergeAll(Layouts_Raw_Input.Corp_Name l, Layouts_Raw_Input.Address r ) := transform
			self 	:= r;
			self	:= l;			
		end; 	
		
		Layouts_Raw_Input.Corp_Name_Add addBlankAddr(Layouts_Raw_Input.Corp_Name l) := transform
			self 	:= l;
			self	:= [];			
		end; 		
		
		joinLegal := join(	LegalNamesOnly, Files_Raw_Input.Address(fileDate),
							trim(left.Corp_CorporationID,left,right) = trim(right.Add_CorporationID,left,right),
							MergeAll(left,right),
							left outer
						  );
							  
		JoinLegalNonRA := joinLegal(trim(AddressTypeID,left,right)<>'10' and
									trim(AddressTypeID,left,right)<>'11' and
									trim(AddressTypeID,left,right)<>'14');
						  
		joinNonLegal := project(NonLegalNames,addBlankAddr(left));							
							
				
	
		
				
		
		//layouts join for AR	

			
		Layouts_Raw_Input.Filing_Corp  MergeFilingCorp(Layouts_Raw_Input.Filing l, Layouts_Raw_Input.Corporation r ) := transform
			self 					:= l;
			self					:= r;
			self                    := [];
			
		end; // end transform
		
		joinFilingCorp := join(Files_Raw_Input.FILING(fileDate), Files_Raw_Input.CORPORATION(fileDate),
								trim(left.Filing_CorporationID,left,right) = trim(right.Corp_CorporationID,left,right),
								MergeFilingCorp(left,right),
								left outer
							);	
							
		//layouts join for stock***********************************	
		Layouts_Raw_Input.StockFile_Corp  MergeStockFileCorp(Layouts_Raw_Input.StockFile l, Layouts_Raw_Input.Corporation r ) := transform
			self 					:= l;
			self					:= r;
			self                    := [];
			
		end; // end transform
		
		joinStockFileCorp := join(Files_Raw_Input.STOCKFILE(fileDate), Files_Raw_Input.CORPORATION(fileDate),
								trim(left.Stock_CorporationID,left,right) = trim(right.Corp_CorporationID,left,right),
								MergeStockFileCorp(left,right),
								left outer
							);
							
							
							
			MapContacts 			:= project(DedupDenormalized, ms_contactTransform(left));
		 //*********************ExplosionTable lookupjoin**********
					
		
		 corp2_mapping.Layout_CorpPreClean findState(corp2_mapping.Layout_CorpPreClean input, ForgnStateDescLayout r ) := transform
			self.corp_forgn_state_desc  := r.desc;
			self         			    := input;
			self                        := [];
		end; // end transform
		
		MapCorpLegal  := project(joinLegal, corpLegalRATransform(left)) ;
		
		//StatusCode join
		joinStateType := join( 	MapCorpLegal,ForgnStateTable,
														trim(left.corp_forgn_state_cd,left,right) = trim(right.code,left,right),
														findState(left,right),
														left outer, lookup
													);
								
		 MapEvent 							:= project(joinFilingCorp, ms_eventTransform(left));					
		           //For event 
		 Corp2.Layout_Corporate_Direct_Event_In FindDocumentTypeid(Corp2.Layout_Corporate_Direct_Event_In input,  DocumentTypeLayout r ) := transform
			      self.event_desc    := trim(stringlib.StringtoUpperCase(regexreplace('["]{1,}',r.Docdesc,'')),left,right);
			      self         			    := input;
			      self                      := [];
		 end; // end transform
		
		
		 joinDocumentTypeid :=join(MapEvent,DocumentTypeTable,
									trim(left.event_desc,left,right) = trim(right.Docid,left,right),
									FindDocumentTypeid(left,right),
									left outer, lookup
								);
		        
   		MapCorpNonRA1  	:= join(joinStateType, JoinLegalNonRA,
								trim(left.corp_key,left,right)[4..] = trim(right.corp_CorporationID,left,right),
								corpLegalNonRATransform1(left,right),
								left outer
								);
								
        MapCorpNonRA2  	:= join(joinStateType, JoinLegalNonRA,
								trim(left.corp_key,left,right)[4..] = trim(right.corp_CorporationID,left,right),
								corpLegalNonRATransform2(right),
								right only
								);
													
		MapNonLegal   	:= project(joinNonLegal, corpNonLegalTransform(left)) ;
		DistCorps      	:= distribute((joinStateType + MapNonLegal + MapCorpNonRA1 + MapCorpNonRA2), hash32(corp_key));
		MapCorp       	:= sort(DistCorps,corp_key,LOCAL);
		
		corp2_mapping.Layout_CorpPreClean  rollupXform(corp2_mapping.Layout_CorpPreClean l, corp2_mapping.Layout_CorpPreClean r) := transform
				self.corp_address1_type_cd   	:= if(r.corp_address1_type_cd <> '', r.corp_address1_type_cd, l.corp_address1_type_cd);
				self.corp_address1_type_desc	:= if(r.corp_address1_type_desc <> '', r.corp_address1_type_desc, l.corp_address1_type_desc);
				self.corp_address1_line1			:= if(r.corp_address1_line1 <> '', r.corp_address1_line1, l.corp_address1_line1);
				self.corp_address1_line2 			:= if(r.corp_address1_line2 <> '', r.corp_address1_line2, l.corp_address1_line2);
				self.corp_address1_line3 			:= if(r.corp_address1_line3 <> '', r.corp_address1_line3, l.corp_address1_line3);
				self.corp_address1_line4		  := if(r.corp_address1_line4 <> '', r.corp_address1_line4, l.corp_address1_line4);
				self.corp_address1_line5			:= if(r.corp_address1_line5 <> '', r.corp_address1_line5, l.corp_address1_line5);
				self.corp_address1_line6 			:= if(r.corp_address1_line6 <> '', r.corp_address1_line6, l.corp_address1_line6);
				self := r;
			end;

		CombineRecs := rollup(	MapCorp,rollupXform(LEFT,RIGHT),RECORD,
														EXCEPT 	corp_address1_type_cd, corp_address1_type_desc,corp_address1_line1, 
																		corp_address1_line2, corp_address1_line3, corp_address1_line4,
																		corp_address1_line5, corp_address1_line6);
																					
		cleanCorps  := project(CombineRecs,CleanCorpNameAddr(left));	
		                
    MapAR 			:= project(joinFilingCorp, ms_arTransform(left));
		MapStock 		:= project(joinStockFileCorp, ms_stockTransform(left));
			
		cleanCont 	:= project(MapContacts, CleanContNameAddr(left));
				
	VersionControl.macBuildNewLogicalFile('~thor_data400::in::corp2::'+version+'::corp_ms'	,cleanCorps					,corp_out		,,,pOverwrite);		
	VersionControl.macBuildNewLogicalFile('~thor_data400::in::corp2::'+version+'::event_ms'	,joinDocumentTypeid ,event_out	,,,pOverwrite);
	VersionControl.macBuildNewLogicalFile('~thor_data400::in::corp2::'+version+'::ar_ms'		,MapAR							,ar_out			,,,pOverwrite);
	VersionControl.macBuildNewLogicalFile('~thor_data400::in::corp2::'+version+'::cont_ms'	,cleanCont					,cont_out		,,,pOverwrite);
	VersionControl.macBuildNewLogicalFile('~thor_data400::in::corp2::'+version+'::stock_ms'	,MapStock						,stock_out	,,,pOverwrite);
		
		mappedms_Filing := parallel(                                                                                                                             
				 corp_out	
				,event_out
				,ar_out		
				,cont_out	
				,stock_out
	  );        

		result := 
		sequential(
			 if(pshouldspray = true,fSprayFiles('ms',filedate,pOverwrite := pOverwrite))
			,mappedms_Filing
			,parallel(
				 fileservices.addsuperfile('~thor_data400::in::corp2::sprayed::corp'	,'~thor_data400::in::corp2::'+version+'::corp_ms')				  
				,fileservices.addsuperfile('~thor_data400::in::corp2::sprayed::cont'	,'~thor_data400::in::corp2::'+version+'::cont_ms')						  
				,fileservices.addsuperfile('~thor_data400::in::corp2::sprayed::ar'		,'~thor_data400::in::corp2::'+version+'::ar_ms')
				,fileservices.addsuperfile('~thor_data400::in::corp2::sprayed::event'	,'~thor_data400::in::corp2::'+version+'::event_ms')
				,fileservices.addsuperfile('~thor_data400::in::corp2::sprayed::stock'	,'~thor_data400::in::corp2::'+version+'::stock_ms')
			)
		);
		 
		

	    return result;
   end;//Function end					 

   
 end;  // end of ms module	