import ut, lib_stringlib, _validate, Address, corp2, _control,versioncontrol;

export AR := MODULE;

	export Layouts_Raw_Input := MODULE;
		
	export CorpData := record,MAXLENGTH(1000)
	
		string Filing_Number;                
		string Corp_Type_ID ;                  	
		string Corp_Status  ;                  	
		string Date_Filed     ;                		
		string Date_Incorporated ;             	
		string Corporation_Name ;              	
		string Registered_Agent   ;            	
		string Agent_First_Name   ; 	      	
		string Agent_Middle_Name ;	           	
		string Agent_Last_Name 	;           	
		string Agent_Suffix_ID        ;       	                         
		string Agent_Address1    ;             		
		string Agent_Address2  ;               		
		string Agent_City     ;                			
		string Agent_State  ;                  		
		string Agent_Zip  ;                    			
		string Agent_Zip_Extension;            			
		string Agent_Country  ; 	           			                 
		string State_of_Organization;          	
		string Foreign_Country	;	      				            
		string Name_of_Organization    ;       		
		string FHO_Name                   ;     			
		string FHO_Address1         ;          		
		string FHO_Address2     ;              		
		string FHO_City           ;            			
		string FHO_State       ;               	
		string FHO_Zip          ;              			
		string FHO_Zip_Extension;              		
		string FHO_Country        ;            	
		string Act                      ;      		                         
		string Duration_of_Existence;          	
		string Tax_Type_ID             ;       	


	end; 
	
	export CorpNames := record,MAXLENGTH(1000)
		string 	Filing_Number;                  	
		string	Fictitious_Name;						
		string 	Real_Name;						
		string 	Agent_City;						
		string 	Agent_State;						
	end; 

	export CorpOfficer	:= record,MAXLENGTH(1000)
		string	Filing_Number;                  	
		string	Officer_ID	;		
		string	Address_ID	;		
		string	Officer_Title	;					
		string	Business_Name	;					
		string	Date_Created	;		
		string	Date_Inactivated	;	
		string	Last_Name	;					
		string	First_Name	;					
		string	Middle_Name	;					
		string	Suffix_ID	;		
		string	Date_Last_Modified	;	
		string	Normalized_Name	;				
		string	Title_ID			;	

	end;

	export CorpWithOfficer	:= record,MAXLENGTH(1000)
	
		string  Corporation_Name ;
		string	Filing_Number;                  	
		string	Officer_ID	;		
		string	Address_ID	;		
		string	Officer_Title	;					
		string	Business_Name	;					
		string	Date_Created	;		
		string	Date_Inactivated	;	
		string	Last_Name	;					
		string	First_Name	;					
		string	Middle_Name	;					
		string	Suffix_ID	;		
		string	Date_Last_Modified	;	
		string	Normalized_Name	;				
		string	Title_ID			;	
	end;
	
	export NewCorpOfficer	:= record,MAXLENGTH(1000)
		
		string	Filing_Number;                  	
		string	Officer_ID	;		
		string	Address_ID	;		
		string	Officer_Title	;					
		string	Business_Name	;					
		string	Date_Created	;		
		string	Date_Inactivated	;	
		string	Last_Name	;					
		string	First_Name	;					
		string	Middle_Name	;					
		string	Suffix_ID	;		
		string	Date_Last_Modified	;	
		string	Normalized_Name	;				
		string	Title_ID			;	
		string	Title1;
		string	Title2;
		string	Title3;
		string	Title4;
		string	Title5;
		string	Title6;
		string	Title7;
		string	Title8;
		string	Title9;
		string	Title10;
		string	Corporation_Name;

	end;

end;

export PrecleanedCommonLayouts := module;
	export corpPre := record 
		corp2_mapping.Layout_CorpPreClean;
		string 		corp_agent_suffix_id ;
	end; 
		
	export Contpre := record
		corp2_mapping.Layout_ContPreClean;
		string		cont_suffix_id;
	end;


end; 

export Files_Raw_Input := MODULE;
	
		export CorpData (string fileDate)        := dataset('~thor_data400::in::corp2::'+fileDate+'::CorpData::AR',
														     layouts_Raw_Input.CorpData,CSV(SEPARATOR(['\t']), TERMINATOR(['\r\n', '\n'])));
															 
																		 
		export CorpNames(string fileDate)        := dataset('~thor_data400::in::corp2::'+fileDate+'::CorpNames::AR',
														     layouts_Raw_Input.CorpNames,CSV(SEPARATOR(['\t']), TERMINATOR(['\r\n', '\n'])));
															 
		export CorpOfficer (string fileDate)     := dataset('~thor_data400::in::corp2::'+fileDate+'::CorpOfficer::AR',
														     layouts_Raw_Input.CorpOfficer,CSV(SEPARATOR(['\t']), TERMINATOR(['\r\n', '\n'])));
		
		
end;	


export Update(string fileDate, string version, boolean pShouldSpray = _Dataset().bShouldSpray, boolean pOverwrite = false) := function

	TitleIdTableLayout := record

			string code;
			string desc;
	end; 
	
	TitleIdTable := dataset(_dataset().foreign_prod + 'thor_data400::lookup::corp2::officerid::ar', TitleIdTableLayout, CSV(SEPARATOR(['\t']), TERMINATOR(['\r\n', '\n'])));			
	
	layouts_Raw_Input.NewCorpOfficer MergeCorpDataWithNewCorpOfficer(Layouts_Raw_Input.CorpData l, layouts_Raw_Input.CorpOfficer r ) := transform

			self 	:= l;
			self	:= r;
			self	:= [];
		end; 
	
	joinCorp2Officer	:= join(Files_Raw_Input.CorpData(fileDate),Files_Raw_Input.CorpOfficer(fileDate),
								trim(left.Filing_Number, left, right) = trim(right.Filing_Number,left,right),
								MergeCorpDataWithNewCorpOfficer(left,right),
								inner);	
	
	sortOfficers	:= sort(joinCorp2Officer, filing_number,business_name,last_name,first_name,middle_name,title_ID,-date_last_modified);		

	distofficers	:= distribute(sortOfficers,hash64(Filing_number,business_name,last_name,first_name,middle_name,title_id));

	layouts_Raw_Input.NewCorpOfficer rollupofficers(layouts_Raw_Input.NewCorpOfficer l, layouts_Raw_Input.NewCorpOfficer r) := transform
		
		self.date_last_modified := if (l.date_last_modified[7..10] + l.date_last_modified[1..2] + l.date_last_modified[4..5] > r.date_last_modified [7..10] + l.date_last_modified[1..2] + l.date_last_modified[4..5], 
											l.date_last_modified, 
											r.date_last_modified
									   );

		self := l;
	end;

	layouts_Raw_Input.NewCorpOfficer	newTransform(layouts_Raw_Input.NewCorpOfficer l, TitleIdTableLayout r) := transform
		self.title_ID	:= stringlib.StringtoUpperCase(r.desc);
		self			:=l;
		self			:=[];
	end;
	


	

	newOfficerFile			:= join(distOfficers, TitleIdTable,
															trim(left.Title_ID,left,right) = trim(right.code,left,right),
															newTransform(left,right),
															left outer, lookup);

	


	layouts_Raw_Input.NewCorpOfficer DenormOfficers(layouts_Raw_Input.NewCorpOfficer L, layouts_Raw_Input.NewCorpOfficer R, INTEGER C) := TRANSFORM
		
			self.Title1 	:= IF (C=1, R.Title_ID,L.TITLE1);                  
			self.title2		:= IF (C=2, R.Title_ID,L.TITLE2);
			self.title3		:= IF (C=3, R.Title_ID,L.TITLE3); 
			self.title4		:= IF (C=4, R.Title_ID,L.TITLE4); 
			self.title5		:= IF (C=5, R.Title_ID,L.TITLE5); 
			self.title6		:= IF (C=6, R.Title_ID,L.TITLE6); 
			self.title7		:= IF (C=7, R.Title_ID,L.TITLE7); 
			self.title8		:= IF (C=8, R.Title_ID,L.TITLE8); 
			self.title9		:= IF (C=9, R.Title_ID,L.TITLE9); 
			self.title10	:= IF (C=10,R.Title_ID,L.TITLE10); 			
			self 			:= L;
	END;

	
	dedupNewOfficerFile := dedup(sort(newOfficerFile, filing_number, business_name, Last_Name, First_Name, Middle_Name, Title_ID, -date_last_modified), filing_number, business_name, Last_Name, First_Name, Middle_Name, Title_ID);
	
				
	DenormalizedFile := sort(denormalize(dedupNewOfficerFile, dedupNewOfficerFile,
									trim(left.filing_number,left,right) = trim(right.filing_number,left,right) and
									trim(left.business_name,left,right) = trim(right.business_name,left,right) and
									trim(left.Last_Name,left,right) = trim(right.Last_Name,left,right) and
									trim(left.First_Name,left,right) = trim(right.First_Name,left,right) and
									trim(left.Middle_Name,left,right) = trim(right.Middle_Name,left,right), 
									DenormOfficers(left,right,COUNTER)),filing_number, business_name, Last_Name, First_Name, Middle_Name, Title_ID, -Date_last_modified);
									
	dedupedOfficers	:= rollup(	DenormalizedFile,
								rollupOfficers(left,right), 
								filing_number, business_name, Last_Name, First_Name, Middle_Name,
								local
							  );	

	
	
	CorpTypeLayout := record
			string2  corpTypeId;
			string48 corpTypeDesc;
			//string1  cr;
	end; 
	
	CorpTypeTable := dataset(_dataset().foreign_prod + 'thor_data400::lookup::corp2::newcorpTypeId::ar', CorpTypeLayout, flat);

	
	
	CorpStatusLayout := record,MAXLENGTH(29)

			string2 corpStatusCode;
			string27 corpStatusDesc;
	end; 
	
	CorpStatusTable := dataset(_dataset().foreign_prod + 'thor_data400::lookup::corp2::corpstatuscode::ar', CorpStatusLayout , flat);


	
	CorpFilingActLayout := record,MAXLENGTH(54)

			string2 corpFilingActCode;
			string52 corpFilingActDesc;
	end; 
	
	CorpFilingActTable := dataset(_dataset().foreign_prod + 'thor_data400::lookup::corp2::filingact::ar', CorpFilingActLayout , flat);


	
	CorpTaxTypeLayout := record,MAXLENGTH(36)

			string2 corpTaxTypeID;
			string34 corpTaxTypeDesc;
	end; 
	
	CorpTaxTypeTable := dataset(_dataset().foreign_prod + 'thor_data400::lookup::corp2::taxtype::ar', CorpTaxTypeLayout , flat);


	
	StateTableLayout := record,MAXLENGTH(77)

			string12 code;
			string65 desc;
	end; 
	
	StateTable := dataset(_dataset().foreign_prod + 'thor_data400::lookup::corp2::statetable::ar', StateTableLayout, flat);

	
	CountryTableLayout := record,MAXLENGTH(38)

			string2 code;
			string36 desc;
	end; 
	
	CountryTable := dataset(_dataset().foreign_prod + 'thor_data400::lookup::corp2::countrytable::ar', CountryTableLayout, flat);

	
	SuffixTableLayout := record,MAXLENGTH(14)

			string10 code;
			string4 desc;
	end; 
	
	SuffixTable := dataset(_dataset().foreign_prod + 'thor_data400::lookup::corp2::suffixIDtable::ar', SuffixTableLayout, flat);
	

		PreCleanedCommonLayouts.corpPre AR_corpDataMainTransform(layouts_raw_input.CorpData  input):= transform

		self.dt_vendor_first_reported		:= fileDate;
		self.dt_vendor_last_reported		:= fileDate;
		self.dt_first_seen					:= fileDate;
		self.dt_last_seen					:= fileDate;
		self.corp_ra_dt_first_seen			:= fileDate;
		self.corp_ra_dt_last_seen			:= fileDate;
		self.corp_key						:= '05-' +trim(input.Filing_Number, left, right);
		
		self.corp_vendor					:= '05';
		
		self.corp_state_origin				:= 'AR';
		self.corp_process_date				:= fileDate;

		self.corp_orig_sos_charter_nbr		:=  input.Filing_Number;

		self.corp_src_type					:= 'SOS';
		
		self.corp_legal_name				:= if (trim(input.Corporation_Name,left,right)<>'',trim(stringlib.StringtoUpperCase(input.Corporation_Name),left,right),'');

		self.corp_ln_name_type_cd			:= '01';		

		self.corp_ln_name_type_desc			:= 'LEGAL';
		
	
	
		
	

		self.corp_ra_name					:= if ( trim(input.Registered_Agent,left,right)<>'',
											trim(stringlib.StringtoUpperCase(input.Registered_Agent),left,right),
													trim(trim(stringlib.StringtoUpperCase(input.Agent_First_Name),left,right) + ' ' +
													trim(stringlib.StringtoUpperCase(input.Agent_Middle_Name),left,right) + ' ' +
													trim(stringlib.StringtoUpperCase(input.Agent_Last_Name),left,right),left,right));




		 

	
																																																						
		
		filingDateOrg						:= if ( trim( input.Date_Filed,left,right) <> '',
															input.Date_Filed[7..10] +
															input.Date_Filed[1..2] +
															input.Date_Filed[4..5],'');
															
		 

		filingDateOrgInc					:= if ( filingDateOrg <> '' and (string)((integer)filingDateOrg) <>'0' and
													_validate.date.fIsValid(filingDateOrg) and 
													filingDateOrg <> '18000101'
													 ,filingDateOrg,'');  




	
		self.corp_filing_date				:= if( trim(filingDateOrgInc,left,right) <> '', filingDateOrgInc,''); 


		self.corp_status_cd					:= trim(stringlib.StringtoUpperCase(input.Corp_Status),left,right);


		self.corp_forgn_state_cd			:= if ( trim(input.State_of_Organization,left,right) <> '' and 
													trim(Stringlib.stringToUpperCase(input.State_of_Organization),left,right) <> 'AR' and
													trim(Stringlib.stringToUpperCase(input.Foreign_Country),left,right) <> trim(Stringlib.stringToUpperCase(input.State_of_Organization),left,right),
													trim(Stringlib.stringToUpperCase(input.State_of_Organization),left,right),if( trim(input.Foreign_Country,left,right) <> '' ,
													trim(Stringlib.stringToUpperCase(input.Foreign_Country),left,right),'')); 
	
		self.corp_inc_state					:= if ( trim(input.State_of_Organization,left,right) = '' or
													trim(Stringlib.stringToUpperCase(input.State_of_Organization),left,right) = 'AR','AR','');

		dateIncorporated					:= if ( trim( input.Date_Incorporated,left,right) <> '',
															input.Date_Incorporated[7..10] +
															input.Date_Incorporated[1..2] +
															input.Date_Incorporated[4..5],'');

		dateIncorporatedInc					:= if ( dateIncorporated <> '' and (string)((integer)dateIncorporated) <> '0' and
													_validate.date.fIsValid(dateIncorporated) and
													_validate.date.fIsValid(dateIncorporated,_validate.date.rules.DateInPast),dateIncorporated,'');  





		
		self.corp_inc_date					:= if( trim(dateIncorporatedInc,left,right) <> '', dateIncorporatedInc,'');
		
		corpTermExp							:= if ( trim( input.Duration_of_Existence,left,right) <> '',
														input.Duration_of_Existence[7..10] +
														input.Duration_of_Existence[1..2] +
														input.Duration_of_Existence[4..5],'');

		corpTermExpOrg						:= if ( corpTermExp <> '' and (string)((integer)corpTermExp) <> '0' and
													_validate.date.fIsValid(corpTermExp),corpTermExp,'');  

							
		self.corp_term_exist_cd				:= if ( trim(corpTermExpOrg,left,right) <> '','D','');
																											
																											
		self.corp_term_exist_desc			:= if ( trim(corpTermExpOrg,left,right) <> '','DATE OF EXPIRATION','');

																												 
											
		self.corp_term_exist_exp			:= if ( trim(corpTermExpOrg,left,right) <> '',corpTermExpOrg,''); 
		

		

		self.corp_orig_org_structure_cd			:= trim(stringlib.StringtoUpperCase(input.Corp_Type_ID),left,right);

		

		self.CORP_ACTS						:= if ( trim(input.Act,left,right) <>'' 
											and (string)((integer)input.Act) <> '0', trim(input.Act,left,right),'') ; 

		

		self.CORP_TAX_PROGRAM_CD			:= if ( trim(input.Tax_Type_ID,left,right) <> '' and
													(string)((integer)input.Tax_Type_ID) <> '0', trim(input.Tax_Type_ID,left,right),'');
	


		self.corp_address1_type_cd			:= if (trim(input.FHO_Address1,left,right) <> '' or
													trim(input.FHO_Address2,left,right) <> '' or
													trim(input.FHO_City,left,right) <> '' or
													trim(input.FHO_State,left,right) <> '' or 
													trim(input.FHO_ZIP,left,right) <> '' or
													trim(input.FHO_ZIP_Extension,left,right) <> '' ,'B','');

		self.corp_address1_type_desc		:= if (trim(input.FHO_Address1,left,right) <> '' or
													trim(input.FHO_Address2,left,right) <> '' or
													trim(input.FHO_City,left,right) <> '' or
													trim(input.FHO_State,left,right) <> '' or  
													trim(input.FHO_ZIP,left,right) <> '' or
													trim(input.FHO_ZIP_Extension,left,right) <> '' ,'BUSINESS','');
											
		self.corp_address1_line1			:= if ( trim(input.FHO_Address1,left,right) <> '' and 
													trim(stringlib.StringtoUpperCase(input.FHO_Address1),left,right) <> 'X',stringlib.StringtoUpperCase(input.FHO_Address1),'');

		self.corp_address1_line2			:= if ( trim(input.FHO_Address2,left,right) <> '' and 
													trim(stringlib.StringtoUpperCase(input.FHO_Address2),left,right) <> 'X',stringlib.StringtoUpperCase(input.FHO_Address2),'');

		self.corp_address1_line3			:= if ( trim(input.FHO_City,left,right) <> '' and 
													trim(stringlib.StringtoUpperCase(input.FHO_City),left,right) <> 'X',stringlib.StringtoUpperCase(input.FHO_City),'');

		self.corp_address1_line4			:= if ( trim(input.FHO_State,left,right) <> '' and 
													trim(stringlib.StringtoUpperCase(input.FHO_State),left,right) <> 'X',stringlib.StringtoUpperCase(input.FHO_State),'');

		zipcode1							:= if ( trim(input.FHO_ZIP,left,right) <> '' and
													(string)((integer)trim(input.FHO_ZIP,left,right)) <> '0' ,trim(input.FHO_ZIP,left,right),'');

		zipcodeExt							:= if ( trim(input.FHO_ZIP_Extension,left,right) <> '' and
													(string)((integer)trim(input.FHO_ZIP_Extension,left,right)) <> '0',trim(input.FHO_ZIP_Extension,left,right),'');

		zipcode								:= zipcode1 + zipcodeExt;

		self.corp_address1_line5			:= if ( trim(zipcode,left,right) <> '',zipcode,'');

		self.corp_address1_line6			:= if ( trim(input.FHO_Country,left,right) <> '' and 
													trim(stringlib.StringtoUpperCase(input.FHO_Country),left,right) <> 'X',input.FHO_Country,''); // need to look up country from lookup table										
		

		

		

	
		self.corp_agent_suffix_id 			:= if ( trim(input.Registered_Agent,left,right)='',trim(input.Agent_Suffix_ID,left,right),'');	

		
		self.corp_ra_address_line1			:= if ( trim(input.Agent_Address1,left,right) <> '' and 
													trim(stringlib.StringtoUpperCase(input.Agent_Address1),left,right) <> 'X',trim(stringlib.StringtoUpperCase(input.Agent_Address1),left,right),'');

		self.corp_ra_address_line2			:= if ( trim(input.Agent_Address2,left,right) <> '' and 
													trim(stringlib.StringtoUpperCase(input.Agent_Address2),left,right) <> 'X',trim(stringlib.StringtoUpperCase(input.Agent_Address2),left,right),'');

		self.corp_ra_address_line3			:= if ( trim(input.Agent_City,left,right) <> '' and 
													trim(stringlib.StringtoUpperCase(input.Agent_City),left,right) <> 'X',trim(stringlib.StringtoUpperCase(input.Agent_City),left,right),'');


		self.corp_ra_address_line4			:= if ( trim(input.Agent_State,left,right) <> '' and 
													trim(stringlib.StringtoUpperCase(input.Agent_State),left,right) <> 'X',trim(stringlib.StringtoUpperCase(input.Agent_State),left,right),''); // agent state code need to get it from lookup table

	
		zipcode_ra1							:= if ( trim(input.Agent_ZIP,left,right) <> '' and
													(string)((integer)trim(input.Agent_ZIP,left,right)) <> '0' ,trim(input.Agent_ZIP,left,right),'');

		zipcode_raExt						:= if ( trim(input.Agent_ZIP_Extension,left,right) <> '' and
													(string)((integer)trim(input.Agent_ZIP_Extension,left,right)) <> '0',trim(input.Agent_ZIP_Extension,left,right),'');

		zipcode_ra							:= zipcode_ra1 + zipcode_raExt;

		self.corp_ra_address_line5			:= if ( trim( zipcode_ra,left,right) <> '' ,zipcode_ra,'');

		
		self								:=[];

	end;

	

	PreCleanedCommonLayouts.corpPre AR_corpNamesMainTransform(layouts_raw_input.CorpNames  input):= transform, skip(trim(input.Fictitious_Name,left,right) = '')
		
		self.dt_vendor_first_reported		:= fileDate;
		self.dt_vendor_last_reported		:= fileDate;
		self.dt_first_seen					:= fileDate;
		self.dt_last_seen					:= fileDate;
		self.corp_ra_dt_first_seen			:= fileDate;
		self.corp_ra_dt_last_seen			:= fileDate;
		self.corp_key						:= '05-' +trim(input.Filing_Number, left, right);
		
		self.corp_vendor					:= '05';
		
		self.corp_state_origin				:= 'AR';
		self.corp_process_date				:= fileDate;

		self.corp_orig_sos_charter_nbr		:= input.Filing_Number;


		self.corp_src_type					:= 'SOS';
					
		self.corp_legal_name				:= if (trim(input.Fictitious_Name,left,right)<>'',trim(stringlib.StringtoUpperCase(input.Fictitious_Name),left,right),'');

		self.corp_ln_name_type_cd			:= if (trim(input.Fictitious_Name,left,right)<>'','F','');

		self.corp_ln_name_type_desc			:= if (trim(input.Fictitious_Name,left,right)<>'','FBN','');

		self								:=[];

	end;



	PreCleanedCommonLayouts.contPre AR_contTransform(layouts_raw_input.NewCorpOfficer input):= transform
			
		self.dt_first_seen					:= fileDate;
		self.dt_last_seen					:= fileDate;
		
		self.corp_key						:= '05-' +trim(input.Filing_Number, left, right);
		self.corp_vendor					:= '05';
		self.corp_state_origin				:= 'AR';
		self.corp_process_date				:= fileDate;
		self.corp_orig_sos_charter_nbr		:= input.Filing_Number;                                                                                            

		
		self.corp_legal_name 				:= trim(stringlib.StringtoUpperCase(input.corporation_name),left,right);
		
		self.cont_name						:= if(trim(input.Business_Name,left,right)<>'' and trim(stringlib.StringtoUpperCase(input.Business_Name),left,right)<>'SEE FILE' and 
		                                          trim(stringlib.StringtoUpperCase(input.Business_Name),left,right)<>'SAME',
													trim(stringlib.StringtoUpperCase(input.Business_Name),left,right),
													trim(trim(stringlib.StringtoUpperCase(input.First_Name),left,right) + ' ' +
														 trim(stringlib.StringtoUpperCase(input.Middle_Name),left,right) + ' ' +
														 trim(stringlib.StringtoUpperCase(input.Last_Name),left,right),
													left,right)
												  );
		
		self.cont_suffix_id					:= trim(input.Suffix_ID,left,right);
		
		
		contEffectiveDate					:= if (trim(input.Date_Last_Modified ,left,right) <> '',
															input.Date_Last_Modified[7..10] +
															input.Date_Last_Modified[1..2] +
															input.Date_Last_Modified[4..5],
															''
												   );

		contEffectiveDateOrg				:= if ( contEffectiveDate <> '' and
													_validate.date.fIsValid(contEffectiveDate) and
													_validate.date.fIsValid(contEffectiveDate,_validate.date.rules.DateInPast),
														contEffectiveDate,
														''
												   );  

		self.cont_effective_date			:= if (trim(contEffectiveDateOrg,left,right) <> '',
														contEffectiveDateOrg,
														''
												   );

												
		concatFields						:= 	trim(input.Title1,left,right) + ';' + 
												trim(input.Title2,left,right) + ';' +  
												trim(input.Title3,left,right) + ';' + 
												trim(input.Title4,left,right) + ';' + 
												trim(input.Title5,left,right) + ';' + 
												trim(input.Title6,left,right) + ';' + 
												trim(input.Title7,left,right) + ';' + 
												trim(input.Title8,left,right) + ';' + 
												trim(input.Title9,left,right) + ';' + 
												trim(input.Title10,left,right);
																		
				
		tempExp								:= regexreplace('[;]*$',concatFields,'',NOCASE);
		tempExp2							:= regexreplace('^[;]*',tempExp,'',NOCASE);
		self.cont_title1_desc               := regexreplace('[;]+',tempExp2,';',NOCASE);  				
	
		self								:=[];
                                                                                                                            
	end;

	PreCleanedCommonLayouts.corpPre AR_corpFHOTransform(layouts_raw_input.CorpData  input):= transform, skip(trim(input.FHO_Name,left,right) = '')

		self.dt_vendor_first_reported		:= fileDate;
		self.dt_vendor_last_reported		:= fileDate;
		self.dt_first_seen					:= fileDate;
		self.dt_last_seen					:= fileDate;
		self.corp_ra_dt_first_seen			:= fileDate;
		self.corp_ra_dt_last_seen			:= fileDate;
		self.corp_key						:= '05-' +trim(input.Filing_Number, left, right);
		
		self.corp_vendor					:= '05';
		
		self.corp_state_origin				:= 'AR';
		self.corp_process_date				:= fileDate;

		self.corp_orig_sos_charter_nbr		:= input.Filing_Number;


		self.corp_src_type					:= 'SOS';

		self.corp_legal_name				:= if (trim(input.FHO_Name,left,right)<>'',trim(stringlib.StringtoUpperCase(input.FHO_Name),left,right),'');

	
		self.corp_name_comment				:= if ( trim(input.FHO_Name,left,right) <> '',
													'FOREIGN NAME','');
		
		self.corp_address1_type_cd			:= if (trim(input.FHO_Address1,left,right) <> '' or
													trim(input.FHO_Address2,left,right) <> '' or
													trim(input.FHO_City,left,right) <> '' or
													trim(input.FHO_State,left,right) <> '' or 
													trim(input.FHO_ZIP,left,right) <> '' or
													trim(input.FHO_ZIP_Extension,left,right) <> '' ,'B','');

		self.corp_address1_type_desc		:= if (trim(input.FHO_Address1,left,right) <> '' or
													trim(input.FHO_Address2,left,right) <> '' or
													trim(input.FHO_City,left,right) <> '' or
													trim(input.FHO_State,left,right) <> '' or  
													trim(input.FHO_ZIP,left,right) <> '' or
													trim(input.FHO_ZIP_Extension,left,right) <> '' ,'BUSINESS','');
											
		self.corp_address1_line1			:= if ( trim(input.FHO_Address1,left,right) <> '' and 
													trim(stringlib.StringtoUpperCase(input.FHO_Address1),left,right) <> 'X',stringlib.StringtoUpperCase(input.FHO_Address1),'');

		self.corp_address1_line2			:= if ( trim(input.FHO_Address2,left,right) <> '' and 
													trim(stringlib.StringtoUpperCase(input.FHO_Address2),left,right) <> 'X',stringlib.StringtoUpperCase(input.FHO_Address2),'');

		self.corp_address1_line3			:= if ( trim(input.FHO_City,left,right) <> '' and 
													trim(stringlib.StringtoUpperCase(input.FHO_City),left,right) <> 'X',stringlib.StringtoUpperCase(input.FHO_City),'');

		self.corp_address1_line4			:= if ( trim(input.FHO_State,left,right) <> '' and 
													trim(stringlib.StringtoUpperCase(input.FHO_State),left,right) <> 'X',stringlib.StringtoUpperCase(input.FHO_State),'');

		zipcode1							:= if ( trim(input.FHO_ZIP,left,right) <> '' and
													(string)((integer)trim(input.FHO_ZIP,left,right)) <> '0' ,trim(input.FHO_ZIP,left,right),'');

		zipcodeExt							:= if ( trim(input.FHO_ZIP_Extension,left,right) <> '' and
													(string)((integer)trim(input.FHO_ZIP_Extension,left,right)) <> '0',trim(input.FHO_ZIP_Extension,left,right),'');

		zipcode								:= zipcode1 + zipcodeExt;

		self.corp_address1_line5			:= if ( trim(zipcode,left,right) <> '',zipcode,'');

		self.corp_address1_line6			:= if ( trim(input.FHO_Country,left,right) <> '' and 
													trim(stringlib.StringtoUpperCase(input.FHO_Country),left,right) <> 'X',input.FHO_Country,''); // need to look up country from lookup table										
		

		self								:= [];

	end;

	Corp2.Layout_Corporate_Direct_Cont_In CleanContNameAddr(PrecleanedCommonLayouts.contPre input) := transform
		string73 tempname 					:= if (input.cont_name = '', '',Address.CleanPersonFML73(input.cont_name));
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
																		trim(input.cont_address_line2,left,right) + ' ' +	
																		trim(input.cont_address_line3,left,right),left,right), 
																		trim(input.cont_address_line4,left,right) + ', ' +
																		trim(input.cont_address_line5,left,right) + ' ' +
																		trim(input.cont_address_line6,left,right));
										

										

		self.cont_prim_range    			:= clean_address[1..10];
		self.cont_predir 	      			:= clean_address[11..12];
		self.cont_prim_name 	  			:= clean_address[13..40];
		self.cont_addr_suffix   			:= clean_address[41..44];
		self.cont_postdir 	    			:= clean_address[45..46];
		self.cont_unit_desig 	  			:= clean_address[47..56];
		self.cont_sec_range 	  			:= clean_address[57..64];
		self.cont_p_city_name	  			:= clean_address[65..89];
		self.cont_v_city_name	  			:= clean_address[90..114];
		self.cont_state 			 		:= clean_address[115..116];
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
		self								:= [];
	end; 

	
	corp2.layout_corporate_direct_corp_in CleanCorpNameAddr(PrecleanedCommonLayouts.corpPre input) := transform
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
						

					
		string182 clean_address				:= Address.CleanAddress182(trim(trim(input.corp_ra_address_line1,left,right) + ' ' +													                        
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
		
	PreCleanedCommonLayouts.corpPre findCorpType(PreCleanedCommonLayouts.corpPre input, corpTypeLayout r ) := transform
			
	
		


		self.corp_orig_org_structure_desc	:= stringlib.StringtoUpperCase(r.corpTypeDesc);

	
	
	
		self 								:= input;
		self								:= [];
	end; 
		
	
	PreCleanedCommonLayouts.corpPre findCorpStatusCode(PreCleanedCommonLayouts.corpPre input, CorpStatusLayout r ) := transform
		
		self.CORP_STATUS_DESC				:= stringlib.StringtoUpperCase(r.corpStatusDesc);
		self 								:= input;
		self								:= [];
	end; 

		
	PreCleanedCommonLayouts.corpPre findFilingActDesc(PreCleanedCommonLayouts.corpPre input, CorpFilingActLayout r ) := transform
			
		self.corp_acts						:= stringlib.StringtoUpperCase(r.corpFilingActDesc);
		self 								:= input;
		self								:= [];
	end; 

	PreCleanedCommonLayouts.corpPre findTaxTypeDesc(PreCleanedCommonLayouts.corpPre input, CorpTaxTypeLayout r ) := transform
			
		self.CORP_TAX_PROGRAM_DESC			:= stringlib.StringtoUpperCase(r.corpTaxTypeDesc);
		self 								:= input;
		self								:= [];
	end; 
		
	PreCleanedCommonLayouts.corpPre findStateCodeDesc(PreCleanedCommonLayouts.corpPre input, StateTableLayout r ) := transform
					
		self.CORP_RA_ADDRESS_LINE4			:= stringlib.StringtoUpperCase(r.desc);
		self 								:= input;
		self								:= [];
	end; 

	PreCleanedCommonLayouts.corpPre findForgnStateCodeDesc(PreCleanedCommonLayouts.corpPre input, StateTableLayout r ) := transform
			
		self.corp_forgn_state_desc			:= stringlib.StringtoUpperCase(r.desc);
		self 								:= input;
		self								:= [];

	end; 

	PreCleanedCommonLayouts.corpPre findForgnCountryCodeDesc1(PreCleanedCommonLayouts.corpPre input, CountryTableLayout r ) := transform
			
		self.corp_address1_line6			:= stringlib.StringtoUpperCase(r.desc);
		self 								:= input;
		self								:= [];

	end; 
	
	PreCleanedCommonLayouts.corpPre findSuffixCodeDesc(PreCleanedCommonLayouts.corpPre input, SuffixTableLayout r ) := transform
		agentName							:= input.corp_ra_name + ' ' + trim(stringlib.StringtoUpperCase(r.desc),left,right);

		self.corp_ra_name					:= if ( trim(agentName,left,right)<> '',trim(stringlib.StringtoUpperCase(agentName),left,right),'');
		self 								:= input;
		self								:= [];

	end; 
	

	PreCleanedCommonLayouts.contPre findSuffixContCodeDesc(PreCleanedCommonLayouts.contPre input, SuffixTableLayout r ) := transform
		name 								:= input.cont_name + ' ' + trim(stringlib.StringtoUpperCase(r.desc),left,right);
		self.cont_name						:= if ( trim(name,left,right) <> '',stringlib.StringtoUpperCase(name),'')  ;
		self 								:= input;
		self								:= [];

	end;

	MapMainCorp 					:= project(Files_Raw_Input.CorpData(fileDate), AR_corpDataMainTransform(left));
		
	joinSuffixCodeDesc  			:= join(MapMainCorp , SuffixTable,
											trim(left.corp_agent_suffix_id,left,right) = trim(right.code,left,right),
											findSuffixCodeDesc(left,right),
											left outer, lookup);

	

	joinCorpType 					:= join(joinSuffixCodeDesc, corpTypeTable,
											trim(left.corp_orig_org_structure_cd,left,right) = trim(right.corpTypeId,left,right),
											findCorpType(left,right),
											left outer, lookup);


	


	joinCorpStatusType 				:= join(joinCorpType, CorpStatusTable,
											trim(left.corp_status_cd,left,right) = trim(right.corpStatusCode,left,right),
											findCorpStatusCode(left,right),
											left outer, lookup);

	
	joinCorpTaxType 				:= join(joinCorpStatusType , CorpTaxTypeTable,
											trim(left.CORP_TAX_PROGRAM_CD,left,right) = trim(right.corpTaxTypeID,left,right),
											findTaxTypeDesc(left,right),
											left outer, lookup);

		
	joinForgnStateCodeDesc  		:= join(joinCorpTaxType, StateTable,
											trim(left.corp_forgn_state_cd,left,right) = trim(right.code,left,right),
											findForgnStateCodeDesc(left,right),
											left outer, lookup);

							
	joinCorpFilingAct 				:= join(joinForgnStateCodeDesc, CorpFilingActTable,
											trim(left.corp_acts,left,right) = trim(right.corpFilingActCode,left,right),
											findFilingActDesc(left,right),
											left outer, lookup);
					

	joinStateCodeDesc  				:= join(joinCorpFilingAct, StateTable,
											trim(left.CORP_RA_ADDRESS_LINE4,left,right) = trim(right.code,left,right),
											findStateCodeDesc(left,right),
											left outer, lookup);

	joinForgnCountryCodeDesc1  		:= join(joinStateCodeDesc, CountryTable,
											trim(left.corp_address1_line6,left,right) = trim(right.code,left,right),
											findForgnCountryCodeDesc1(left,right),
											left outer, lookup);


	MapCorpNames 					:= project(Files_Raw_Input.CorpNames(fileDate), AR_corpNamesMainTransform(left));
										
	MapCorpFHO	 					:= project(Files_Raw_Input.CorpData(fileDate), AR_corpFHOTransform(left));
		
    allCorp                			:= distribute(joinForgnCountryCodeDesc1 + MapCorpNames + MapCorpFHO,hash64(corp_orig_sos_charter_nbr));
                        
    MapCorp                 		:= sort(AllCorp,corp_orig_sos_charter_nbr,corp_inc_date,local);

	MapCont							:= project(dedupedOfficers, AR_contTransform(left));

	joinSuffixContNameDesc  		:= join(MapCont, SuffixTable,
											trim(left.cont_suffix_id,left,right) = trim(right.code,left,right),
											findSuffixContCodeDesc(left,right),
											left outer, lookup);

	cleanCont 						:= project(joinSuffixContNameDesc, CleanContNameAddr(left));
		
		
	cleanCorp 						:= project(MapCorp , CleanCorpNameAddr(left));

	VersionControl.macBuildNewLogicalFile('~thor_data400::in::corp2::'+version+'::corp_ar'	,cleanCorp	,corp_out		,,,pOverwrite);		
	VersionControl.macBuildNewLogicalFile('~thor_data400::in::corp2::'+version+'::cont_ar'	,cleanCont	,cont_out		,,,pOverwrite);
		                                                                                                                                                       
	mappedAR_Filing 				:= 
	parallel(
		 corp_out
		,cont_out
	);

	result := 
		sequential(
			 if(pshouldspray = true,fSprayFiles('ar',filedate,pOverwrite := pOverwrite))
			,mappedAR_Filing
			,parallel(
				 fileservices.addsuperfile( 	'~thor_data400::in::corp2::sprayed::corp','~thor_data400::in::corp2::'+version+'::corp_ar')
				,fileservices.addsuperfile(	'~thor_data400::in::corp2::sprayed::cont','~thor_data400::in::corp2::'+version+'::cont_ar')					  
			)							
		);

	return result;

  end;    

end;//Oct17A
 

		
