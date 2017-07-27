#option('skipFileFormatCrcCheck', 1);

import ut, lib_stringlib, _validate, Address, corp2, _control, versioncontrol;

export NH := MODULE;

	export Layouts_Raw_Input := MODULE;


		export Corporation := record
			string CorporationID;
			string EntityID;
			string CorporationTypeID;
			string CorporationStatusID;
			string CorporationNumber;
			string Citizenship;
			string DateFormed;
			string DissolveDate;
			string Duration;
			string CountyOfIncorporation;
			string StateOfIncorporation;
			string CountryOfIncorporation;
			string Purpose;
			string Profession;
			string RegisteredAgentName;
			string lf;
		end;

		
		export Address := record
			string AddressID;
			string CorporationID;
			string AddressTypeID;
			string Address1;
			string Address2;
			string Address3;
			string City;
			string State;
			string Zip;
			string County;
			string Country;
			string lf;
		end;

		
		export Filing := record
			string FilingID;
			string CorporationID;
			string DocumentID;
			string DocumentTypeID;
			string FilingDate;
			string EffectiveDate;
			string lf;
		end;


		export Merger := record
			string MergerID;
			string SurvivorCorporationID;
			string MergedCorporationID;
			string MergerDate;
			string lf;
		end;

			
		export CorporationName := record
			string CorporationNameID;
			string CorporationID;
			string CorpName;
			string NameTypeId;
			string Title;
			string Salutation;
			string Prefix;
			string LastName;
			string MiddleName;
			string FirstName;
			string Suffix;
			string lf;
		end;
		
		export Officer := record
			string OfficerID;
			string CorporationID;
			string Title;
			string Salutation;
			string Name;
			string Address1;
			string Address2;
			string Address3;
			string City;
			string State;
			string Zip;
			string CountryName;
			string OwnerPercentage;
			string TransferRealEstate;
			string ForeignAddress;
			string lf;
		end;
		
		export Stock := record
			string StockID;
			string CorporationID;
			string StockClassID;
			string AuthorizedShares;
			string IssuedShares;
			string Series;
			string NPVFlag;
			string ParValue;
			string lf;
		end;

	end; 	
	
	export Files_Raw_Input := MODULE;
	
		export corporation (string fileDate):= dataset('~thor_data400::in::corp2::'+fileDate+'::corporation::nh',
														layouts_Raw_Input.corporation,CSV(SEPARATOR([',']), quote('"'),TERMINATOR(['\r\n', '\n'])));
		
		export address (string fileDate)    := dataset('~thor_data400::in::corp2::'+fileDate+'::address::nh',
														layouts_Raw_Input.address,CSV(SEPARATOR([',']), quote('"'), TERMINATOR(['\r\n', '\n'])));
														
		export filing (string fileDate)     := dataset('~thor_data400::in::corp2::'+fileDate+'::filing::nh',
		                                                layouts_Raw_Input.filing,CSV(SEPARATOR([',']), quote('"'), TERMINATOR(['\r\n', '\n'])));
														
		export merger (string fileDate)     := dataset('~thor_data400::in::corp2::'+fileDate+'::merger::nh',
		                                                layouts_Raw_Input.merger,CSV(SEPARATOR([',']), quote('"'), TERMINATOR(['\r\n', '\n'])));
														
		export corporationName (string fileDate)       := dataset('~thor_data400::in::corp2::'+fileDate+'::name::nh',
														layouts_Raw_Input.CorporationName,CSV(SEPARATOR([',']), quote('"'), TERMINATOR(['\r\n', '\n'])));												
														
		export officer (string fileDate)    := dataset('~thor_data400::in::corp2::'+fileDate+'::officer::nh',
														layouts_Raw_Input.officer,CSV(SEPARATOR([',']), quote('"'), TERMINATOR(['\r\n', '\n'])));	
														
		export stock (string fileDate)     	:= dataset('~thor_data400::in::corp2::'+fileDate+'::stock::nh',
														layouts_Raw_Input.stock,CSV(SEPARATOR([',']), quote('"'), TERMINATOR(['\r\n', '\n'])));															
	end;

	export Update(string fileDate, string version, boolean pShouldSpray = _Dataset().bShouldSpray, boolean pOverwrite = false) := function
	
		reformatDate(string inDate) := function
			string clean_inDate := trim(regexreplace('00:00:00',inDate,''),left,right);
			string8 newDate := trim(regexreplace('-',clean_inDate,''),left,right);	
			return newDate;	
		end;
		
		reformatDate2(string inDate) := function
			string8 clean_inDate := trim(regexreplace('/',inDate,''),left,right);
			string8 newDate := clean_inDate[5..8] + clean_inDate[1..2] + clean_inDate[3..4];
			return newDate;	
		end;		
		
		trimUpper(string s) := function
			return trim(stringlib.StringToUppercase(s),left,right);
		end;
		

		//--------------------  Document ID code explosion ------------------	
		
		FilingLookups := record
			string FilingID;
			string CorporationID;
			string DocumentID;
			string DocumentTypeID;
			string FilingDate;
			string EffectiveDate;
			string DocumentTypeIDDesc;
		end;	
		
		FilingWithCorp := record
			string FilingID;
			string CorporationID;
			string DocumentID;
			string DocumentTypeID;
			string FilingDate;
			string EffectiveDate;
			string DocumentTypeIDDesc;
			string CorporationNumber;
		end;		
		
		DocumentIDCodeLayout := record
			string DocIDCode;
			string DocIDDesc;
		end;
		
		DocumentIDTable := dataset(_dataset().foreign_prod + 'thor_data400::lookup::corp2::'+ filedate +'::DocumentTypeID_Table::nh', DocumentIDCodeLayout, CSV(SEPARATOR([',']), quote('"'), TERMINATOR(['\r\n', '\n'])));
		
		FilingLookups findDocumentIDCode(layouts_raw_input.Filing input, DocumentIDCodeLayout r ) := transform
			self.DocumentTypeIDDesc 	:= r.DocIDDesc;
			self         		  					:= input;
			self                  					:= [];
		end; // end transform
	
		PopFilingLookups := join(	Files_Raw_Input.Filing(fileDate), DocumentIDTable,
											trim(left.DocumentTypeID,left,right) = right.DocIDCode,
											findDocumentIDCode(left,right),
											left outer, lookup
										 );	
								 
		FilingWithCorp MergeFiling2Corp(FilingLookups l, layouts_raw_input.corporation r ) := transform
			self 	:= r;
			self	:= l;			
		end; 
		
		joinFilingWithCorp := join(	PopFilingLookups, files_raw_input.corporation(fileDate),
											trim(left.CorporationID,left,right) = trim(right.CorporationID,left,right),
											MergeFiling2Corp(left,right),
											left outer
										  );								 
								 

		//--------------------  Stock Class code explosion ------------------
		
		StockLookups := record
			string StockID;
			string CorporationID;
			string StockClassID;
			string AuthorizedShares;
			string IssuedShares;
			string Series;
			string NPVFlag;
			string ParValue;
			string StockClassDesc;
		end;	
		
		StockWithCorp := record
			string StockID;
			string CorporationID;
			string StockClassID;
			string AuthorizedShares;
			string IssuedShares;
			string Series;
			string NPVFlag;
			string ParValue;
			string StockClassDesc;
			string CorporationNumber;
		end;	
		
		StockClassCodeLayout := record
			string StockClassCode;
			string StockClassDesc;
		end;
		
		StockClassTable := dataset(_dataset().foreign_prod + 'thor_data400::lookup::corp2::'+ filedate +'::StockClass_Table::nh', StockClassCodeLayout, CSV(SEPARATOR([',']), quote('"'), TERMINATOR(['\r\n', '\n'])));
		
		StockLookups findStockClassCode(layouts_raw_input.Stock input, StockClassCodeLayout r ) := transform
			self.StockClassDesc 	:= r.StockClassDesc;
			self         				:= input;
			self                		:= [];
		end; // end transform
	
		PopStockLookups := join(	Files_Raw_Input.Stock(fileDate), StockClassTable,
												trim(left.StockClassID,left,right) = right.StockClassCode,
												findStockClassCode(left,right),
												left outer, lookup
										   );	
								 
		StockWithCorp MergeStock2Corp(StockLookups l, layouts_raw_input.corporation r ) := transform
			self 	:= r;
			self	:= l;			
		end; 
		
		joinStockWithCorp := join(	PopStockLookups, files_raw_input.corporation(fileDate),
												trim(left.CorporationID,left,right) = trim(right.CorporationID,left,right),
												MergeStock2Corp(left,right),
												left outer
											);								 
								 
		//------------------------ corp file manipulations -------------------------
	
		CorpWithCorpName := record
			string CorporationID;
			string EntityID;
			string CorporationTypeID;
			string CorporationTypeDesc;
			string CorporationStatusID;
			string CorporationStatusDesc;			
			string CorporationNumber;
			string Citizenship;
			string DateFormed;
			string DissolveDate;
			string Duration;
			string CountyOfIncorporation;
			string StateOfIncorporation;
			string CountryOfIncorporation;
			string Purpose;
			string Profession;
			string RegisteredAgentName;		
			string CorpName;
			string NameTypeId;
			string NameTypeDesc;
		end;

		MergedFilesCorp := record
			string CorporationID;
			string EntityID;
			string CorporationTypeID;
			string CorporationTypeDesc;
			string CorporationStatusID;
			string CorporationStatusDesc;			
			string CorporationNumber;
			string Citizenship;
			string DateFormed;
			string DissolveDate;
			string Duration;
			string CountyOfIncorporation;
			string StateOfIncorporation;
			string CountryOfIncorporation;
			string Purpose;
			string Profession;
			string RegisteredAgentName;		
			string CorpName;
			string NameTypeId;
			string NameTypeDesc;
			string AddressTypeID;
			string Address1;
			string Address2;
			string Address3;
			string City;
			string State;
			string Zip;
			string County;
			string Country;
		end;
		
				
		PopCorpLookups := record
			string CorporationID;
			string EntityID;
			string CorporationTypeID;
			string CorporationTypeDesc;
			string CorporationStatusID;
			string CorporationStatusDesc;			
			string CorporationNumber;
			string Citizenship;
			string DateFormed;
			string DissolveDate;
			string Duration;
			string CountyOfIncorporation;
			string StateOfIncorporation;
			string CountryOfIncorporation;
			string Purpose;
			string Profession;
			string RegisteredAgentName;		
		end;	
		
		PopNameLookups := record
			string CorporationNameID;
			string CorporationID;
			string CorpName;
			string NameTypeId;
			string NameTypeDesc;			
			string Title;
			string Salutation;
			string Prefix;
			string LastName;
			string MiddleName;
			string FirstName;
			string Suffix;
		end;		
		
		//----------------------------------------------------------------
		
		//--------------------  Corp Type code explosion -----------------		

		CorpTypeLayout := record
			string CorpTypeCode;
			string CorpTypeDesc;
		end;
		
		CorpTypeTable := dataset(_dataset().foreign_prod + 'thor_data400::lookup::corp2::'+ filedate +'::CorpType_Table::nh', CorpTypeLayout, CSV(SEPARATOR([',']), quote('"'), TERMINATOR(['\r\n', '\n'])));
		
		PopCorpLookups findCorpTypeCode(layouts_raw_input.corporation input, CorpTypeLayout r ) := transform
			self.CorporationTypeDesc	:= r.CorpTypeDesc;
			self         		  				:= input;
			self                  				:= [];
		end; // end transform
	
		PopCorpType := join(	Files_Raw_Input.Corporation(fileDate), CorpTypeTable,
										trim(left.CorporationTypeID,left,right) = right.CorpTypeCode,
										findCorpTypeCode(left,right),
										left outer, lookup
									);
							
		//----------------------------------------------------------------
		
		//--------------------  Status code explosion --------------------
		
		StatusCodeLayout := record
			string StatusCode;
			string StatusDesc;
		end;
		
		StatusTable := dataset(_dataset().foreign_prod + 'thor_data400::lookup::corp2::'+ filedate +'::StatusCode_Table::nh', StatusCodeLayout, CSV(SEPARATOR([',']), quote('"'), TERMINATOR(['\r\n', '\n'])));
		
		PopCorpLookups findStatusCode(PopCorpLookups input, StatusCodeLayout r ) := transform
			self.CorporationStatusDesc   := r.StatusDesc;
			self         		 		 			:= input;
		end;
	
		PopStatusDesc := join(	PopCorpType, StatusTable,
											trim(left.CorporationStatusID,left,right) = trim(right.StatusCode,left,right),
											findStatusCode(left,right),
											left outer, lookup
										);
							  
		//----------------------------------------------------------------
		
		//--------------------  Name Type code explosion -----------------	
		
		NameTypeLayout := record
			string NameTypeCode;
			string NameTypeDesc;
		end;
		
		NameTypeTable := dataset(_dataset().foreign_prod + 'thor_data400::lookup::corp2::'+ filedate +'::NameType_Table::nh', NameTypeLayout, CSV(SEPARATOR([',']), quote('"'), TERMINATOR(['\r\n', '\n'])));
		
		PopNameLookups findNameTypeCode(layouts_raw_input.corporationName input, NameTypeLayout r ) := transform
			self.NameTypeDesc	:= r.NameTypeDesc;
			self         				:= input;
			self            			:= [];
		end; // end transform
	
		PopNameType := join(	Files_Raw_Input.CorporationName(fileDate), NameTypeTable,
										trim(left.NameTypeID,left,right) = right.NameTypeCode,
										findNameTypeCode(left,right),
										left outer, lookup
									  );
						   
        //---------------------- Merge Corporation & Name files --------------------						   
		
		CorpWithCorpName MergeCorp2Name(PopCorpLookups l, PopNameLookups r ) := transform
			self 	:= r;
			self	:= l;			
		end; 
		
		joinCorpWithName := join(	PopStatusDesc, PopNameType,
												trim(left.CorporationID,left,right) = trim(right.CorporationID,left,right),
												MergeCorp2Name(left,right),
												left outer
											);
								
		LegalNamesOnly 	:= joinCorpWithName(trim(NameTypeId,left,right) = '1');
		NonLegalNames	:= joinCorpWithName(trim(NameTypeId,left,right) <> '1');
								
		MergedFilesCorp MergeAll(CorpWithCorpName l, Layouts_Raw_Input.Address r ) := transform
			self 	:= r;
			self	:= l;			
		end; 	
		
		MergedFilesCorp addBlankAddr(CorpWithCorpName l) := transform
			self 	:= l;
			self	:= [];			
		end; 		
		
		joinLegal := join(	LegalNamesOnly, Files_Raw_Input.Address(fileDate),
								trim(left.CorporationID,left,right) = trim(right.CorporationID,left,right),
								MergeAll(left,right),
								left outer
							  );
							  
		JoinLegalNonRA := joinLegal(trim(AddressTypeID,left,right)<>'10' and
												trim(AddressTypeID,left,right)<>'11' and
												trim(AddressTypeID,left,right)<>'14');
						  
		joinNonLegal := project(NonLegalNames,addBlankAddr(left));
		
		//----------------------- Contact file manipulations ---------------------
		
		OfficerWithCorpName	:= record,MAXLENGTH(1000)
			string CorpName;
			string CorporationNumber;
			string OfficerID;
			string CorporationID;
			string Title;
			string Salutation;
			string Name;
			string Address1;
			string Address2;
			string Address3;
			string City;
			string State;
			string Zip;
			string CountryName;
			string OwnerPercentage;
			string TransferRealEstate;
			string ForeignAddress;	
		end;
	
		OfficerWithPartyID	:= record,MAXLENGTH(1000)
			string CorpName;
			string CorporationNumber;			
			string OfficerID;
			string CorporationID;
			string Title;
			string Salutation;
			string Name;
			string Address1;
			string Address2;
			string Address3;
			string City;
			string State;
			string Zip;
			string CountryName;
			string OwnerPercentage;
			string TransferRealEstate;
			string ForeignAddress;
			string PartyTypeID;
		end;
		
		OfficerWithPartyDesc := record,MAXLENGTH(1000)
			string CorpName;
			string CorporationNumber;			
			string OfficerID;
			string CorporationID;
			string Title;
			string Salutation;
			string Name;
			string Address1;
			string Address2;
			string Address3;
			string City;
			string State;
			string Zip;
			string CountryName;
			string OwnerPercentage;
			string TransferRealEstate;
			string ForeignAddress;
			string PartyTypeID;
			string PartyTypeDesc;
		end;
		
		FinalOfficerFile := record,MAXLENGTH(1000)
			string CorpName;
			string CorporationNumber;			
			string OfficerID;
			string CorporationID;
			string Title;
			string Salutation;
			string Name;
			string Address1;
			string Address2;
			string Address3;
			string City;
			string State;
			string Zip;
			string CountryName;
			string OwnerPercentage;
			string TransferRealEstate;
			string ForeignAddress;
			string PartyTypeID;	
			string PartyTypeDesc;
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
		
		//------- join Officer with CorpName to get corporation name for corp_legal_name ------------------
		
		LegalNames := dedup(LegalNamesOnly,corporationID);
		
		OfficerWithCorpName MergeOfficerWithCorpName(Layouts_Raw_Input.Officer l, CorpWithCorpName r ) := transform
			self 	:= r;
			self	:= l;			
		end; 
	
		joinOfficer2CorpName	:= join(	Files_Raw_Input.Officer(fileDate),LegalNames,
													trim(left.CorporationID, left, right) = trim(right.CorporationID,left,right),
													MergeOfficerWithCorpName(left,right),
													left outer
												  );
										
		//------- join result of above with OfficerPartyType Table ------------------
		
		OffPartyTypeLayout := record
			string OffPartyTypeID;
			string OffID;
			string PartyTypeID;
		end;
		
		OffPartyTypeTable := dataset(_dataset().foreign_prod + 'thor_data400::lookup::corp2::'+ filedate +'::OffPartyType_Table::nh', OffPartyTypeLayout, CSV(SEPARATOR([',']), quote('"'), TERMINATOR(['\r\n', '\n'])));
								
		OfficerWithPartyID MergeOfficerWithOffPartyType(OfficerWithCorpName l, OffPartyTypeLayout r ) := transform
			self 	:= l;
			self	:= r;
			self	:= [];
		end; 
	
		joinOfficer2OffPartyType	:= join(	joinOfficer2CorpName, OffPartyTypeTable,
														trim(left.OfficerID, left, right) = trim(right.OffID,left,right),
														MergeOfficerWithOffPartyType(left,right),
														left outer,lookup
													  );
											
											
		//------- join result of above with PartyType Table ------------------	
		
		PartyTypeLayout := record
			string PartyTypeID;
			string PartyTypeDesc;
		end;
		
		PartyTypeTable := dataset(_dataset().foreign_prod + 'thor_data400::lookup::corp2::'+ filedate +'::PartyType_Table::nh', PartyTypeLayout, CSV(SEPARATOR([',']), quote('"'), TERMINATOR(['\r\n', '\n'])));
										
										
		OfficerWithPartyDesc MergeOfficerWithPartyType(OfficerWithPartyID l, PartyTypeLayout r ) := transform
			self 	:= l;
			self	:= r;
			self	:= [];
		end; 
	
		joinOfficer2PartyType	:= join(	joinOfficer2OffPartyType, PartyTypeTable,
													trim(left.PartyTypeID, left, right) = trim(right.PartyTypeID,left,right),
													MergeOfficerWithPartyType(left,right),
													left outer,lookup
												  );	
										
		//------- Denormalize above result to get all titles in one record ------------------	
		
		sortOffFile		:= sort(joinOfficer2PartyType, corporationID,name,Address1,Address2,Address3,city,state,zip);		

		distofficers 	:= distribute(sortOffFile,hash64(corporationID,name,Address1,Address2,Address3,city,state,zip));

		FinalOfficerFile	newTransform(OfficerWithPartyDesc l) := transform
			self			:=l;
			self			:=[];
		end;
	
		newOfficerFile		:= project(distOfficers, newTransform(left));

		FinalOfficerFile DenormOfficers(FinalOfficerFile L, FinalOfficerFile R, INTEGER C) := TRANSFORM
		
			self.Title1 		:= IF (C=1, R.partyTypeDesc,L.TITLE1);                  
			self.title2		:= IF (C=2, R.partyTypeDesc,L.TITLE2);
			self.title3		:= IF (C=3, R.partyTypeDesc,L.TITLE3); 
			self.title4		:= IF (C=4, R.partyTypeDesc,L.TITLE4); 
			self.title5		:= IF (C=5, R.partyTypeDesc,L.TITLE5); 
			self.title6		:= IF (C=6, R.partyTypeDesc,L.TITLE6); 
			self.title7		:= IF (C=7, R.partyTypeDesc,L.TITLE7); 
			self.title8		:= IF (C=8, R.partyTypeDesc,L.TITLE8); 
			self.title9		:= IF (C=9, R.partyTypeDesc,L.TITLE9); 
			self.title10		:= IF (C=10,R.partyTypeDesc,L.TITLE10); 			
			self 				:= L;
		END;

	
		dedupNewOfficerFile := dedup(sort(newOfficerFile, corporationID,name,Address1,Address2,Address3,city,state,zip, PartyTypeID), corporationID,name,Address1,Address2,Address3,city,state,zip, PartyTypeID);
	
				
		DenormalizedFile := sort(denormalize(dedupNewOfficerFile, dedupNewOfficerFile,
											trim(left.corporationID,left,right) = trim(right.corporationID,left,right) and
											trim(left.name,left,right) = trim(right.name,left,right) and
											trim(left.Address1,left,right) = trim(right.Address1,left,right) and
											trim(left.Address2,left,right) = trim(right.Address2,left,right) and
											trim(left.Address3,left,right) = trim(right.Address3,left,right) and
											trim(left.city,left,right) = trim(right.city,left,right) and
											trim(left.state,left,right) = trim(right.state,left,right) and
											trim(left.zip,left,right) = trim(right.zip,left,right),
											DenormOfficers(left,right,COUNTER)),corporationID,name,Address1,Address2,Address3,city,state,zip, PartyTypeID);
		
		DedupDenormalized := dedup(DenormalizedFile, RECORD, EXCEPT corpName, OfficerID, PartyTypeID, PartyTypeDesc);
				

		
		corp2_mapping.Layout_CorpPreClean corpLegalRATransform(MergedFilesCorp input) := transform,skip(trimUpper(input.addressTypeID) <> '10')

			self.dt_first_seen						:= fileDate;
			self.dt_last_seen							:= fileDate;
			self.dt_vendor_first_reported		:= fileDate;
			self.dt_vendor_last_reported		:= fileDate;
			self.corp_ra_dt_first_seen			:= fileDate;
			self.corp_ra_dt_last_seen				:= fileDate;			
			self.corp_key								:= '33-' + trimUpper(input.corporationID);
			self.corp_vendor							:= '33';
			self.corp_state_origin					:= 'NH';
			self.corp_process_date				:= fileDate;
			self.corp_orig_sos_charter_nbr		:= trimUpper(input.corporationNumber);
			self.corp_src_type						:= 'SOS';	
			
			self.corp_orig_org_structure_cd	:= if (trim(input.corporationTypeDesc,left,right)<>'',
																		trimUpper(input.corporationTypeID),
																		''
																	);
			self.corp_orig_org_structure_desc	:= trimUpper(input.corporationTypeDesc);
			
			self.corp_status_cd						:= if (trim(input.CorporationStatusDesc,left,right)<>'',
																		trimUpper(input.CorporationStatusID),
																		''
																	);
			self.corp_status_desc					:= trimUpper(input.CorporationStatusDesc);	
			
			
			StatusDate									:= reformatDate(input.DissolveDate);

		
			self.corp_status_date					:= if(	_validate.date.fIsValid(statusDate) and
																	_validate.date.fIsValid(statusDate,_validate.date.rules.DateInPast),
																		statusDate,
																		''
																	);  
													  
			self.corp_foreign_domestic_ind		:= trimUpper(input.citizenship);
			
			FilingDate									:= reformatDate(input.DateFormed);
			
			self.corp_inc_date					:= if(	_validate.date.fIsValid(filingDate) and
																	_validate.date.fIsValid(filingDate,_validate.date.rules.DateInPast),
																		filingDate,
																		''
																	); 
													  
			self.corp_filing_cd						:= if(	_validate.date.fIsValid(filingDate) and
																	_validate.date.fIsValid(filingDate,_validate.date.rules.DateInPast),
																		'C',
																		''
																	);
													  
			self.corp_filing_desc						:= if(	_validate.date.fIsValid(filingDate) and
																	_validate.date.fIsValid(filingDate,_validate.date.rules.DateInPast),
																		'CREATION',
																		''
																	);
													  
			DurationDate								:= reformatDate2(input.duration);
													  
			self.corp_term_exist_cd				:= if (trimUpper(input.duration) = 'PERPETUAL',
																		'P',
																		if(	_validate.date.fIsValid(DurationDate),
																			'D',
																			''
																		  )
																	);
													
			self.corp_term_exist_desc			:= if (trimUpper(input.duration) = 'PERPETUAL',
																		'PERPETUAL',
																		if(	_validate.date.fIsValid(DurationDate),
																			'DATE OF EXPIRATION',
																			''
																		  )
																	);
													   
			self.corp_term_exist_exp				:= if(	_validate.date.fIsValid(DurationDate),
																		DurationDate,
																		''
																  );
													  
			CleanState									:= trimUpper(input.stateOfIncorporation);
													  
			self.corp_inc_state						:= if (CleanState = '' or CleanState = 'NH',
																		'NH',
																		''
																	);
													  
			self.corp_inc_county					:= trimUpper(input.CountyOfIncorporation);
			
			self.corp_forgn_state_cd				:= if (CleanState <> '' and CleanState <> 'NH',
																		CleanState,
																		''
																	);
			            								
			self.corp_forgn_state_desc			:= map(	cleanState = 'AL' => 'ALABAMA',
																		cleanState = 'AK' => 'ALASKA',
																		cleanState = 'AZ' => 'ARIZONA',
																		cleanState = 'AR' => 'ARKANSAS',
																		cleanState = 'CA' => 'CALIFORNIA',
																		cleanState = 'CO' => 'COLORADO',
																		cleanState = 'CT' => 'CONNECTICUT',
																		cleanState = 'DE' => 'DELAWARE',
																		cleanState = 'DC' => 'DISTRICT OF COLUMBIA',
																		cleanState = 'FL' => 'FLORIDA',
																		cleanState = 'GA' => 'GEORGIA',
																		cleanState = 'HI' => 'HAWAII',
																		cleanState = 'ID' => 'IDAHO',
																		cleanState = 'IL' => 'ILLINOIS',
																		cleanState = 'IA' => 'IOWA',
																		cleanState = 'KS' => 'KANSAS',
																		cleanState = 'KY' => 'KENTUCKY',
																		cleanState = 'LA' => 'LOUISIANA',
																		cleanState = 'ME' => 'MAINE',
																		cleanState = 'MD' => 'MARYLAND',
																		cleanState = 'MA' => 'MASSACHUSETTS',
																		cleanState = 'MI' => 'MICHIGAN',
																		cleanState = 'MN' => 'MINNESOTA',
																		cleanState = 'MS' => 'MISSISSIPPI',
																		cleanState = 'MO' => 'MISSOURI',
																		cleanState = 'MT' => 'MONTANA',
																		cleanState = 'NE' => 'NEBRASKA',
																		cleanState = 'NV' => 'NEVADA',
																		cleanState = 'NJ' => 'NEW JERSEY',
																		cleanState = 'NM' => 'NEW MEXICO',
																		cleanState = 'NY' => 'NEW YORK',
																		cleanState = 'NC' => 'NORTH CAROLINA',
																		cleanState = 'ND' => 'NORTH DAKOTA',
																		cleanState = 'OH' => 'OHIO',
																		cleanState = 'OK' => 'OKLAHOMA',
																		cleanState = 'OR' => 'OREGON',
																		cleanState = 'PA' => 'PENNSYLVANIA',
																		cleanState = 'RI' => 'RHODE ISLAND',
																		cleanState = 'SC' => 'SOUTH CAROLINA',
																		cleanState = 'SD' => 'SOUTH DAKOTA',
																		cleanState = 'TN' => 'TENNESSEE',
																		cleanState = 'TX' => 'TEXAS',
																		cleanState = 'UT' => 'UTAH',
																		cleanState = 'VT' => 'VERMONT',
																		cleanState = 'VA' => 'VIRGINIA',
																		cleanState = 'WA' => 'WASHINGTON',
																		cleanState = 'WV' => 'WEST VIRGINIA',
																		cleanState = 'WI' => 'WISCONSIN',
																		cleanState = 'WY' => 'WYOMING',
																		trimUpper(input.countryOfIncorporation)
																);
														
			self.corp_entity_desc					:= if(trim(StringLib.StringFilterOut(input.purpose, '0123456789'),left,right)<>'',
															trimUpper(input.purpose),
															'');
															
			
			self.corp_legal_name					:= trimUpper(input.CorpName); 														
			self.corp_ln_name_type_cd			:= if (trim(input.NameTypeDesc,left,right) <> '',
																		trimUpper(input.NameTypeId),
																		''
																	);
			self.corp_ln_name_type_desc		:= trimUpper(input.NameTypeDesc);

  
			self.corp_ra_name						:= trimUpper(input.RegisteredAgentName);
			
			concatAddrFields							:= if ((string)(integer) input.Address2 <> '0',
																		if ((string)(integer) input.Address3 <> '0',
																				trimUpper(input.Address1 + ' ' + input.Address2 + ' ' + input.Address3),
																				trimUpper(input.Address1 + ' ' + input.Address2)
																			),
																		if ((string)(integer) input.Address3 <> '0',
																				trimUpper(input.Address1 + ' ' + input.Address3),
																				trimUpper(input.Address1)
																			)
																	);
												
			self.corp_ra_address_line1 			:= trimUpper(concatAddrFields),

			self.corp_ra_address_line2			:= trimUpper(input.City);
														
			self.corp_ra_address_line3			:= if (trimUpper(input.State) <> 'XX' and not ut.isNumeric(trim(input.state,left,right)),
																		trimUpper(input.state),
																		''
																	);
														
			self.corp_ra_address_line4			:= trimUpper(input.Zip);
			
			self.corp_ra_address_line5			:= if (trimUpper(input.County) <> '' ,
																		trimUpper(input.County) + ' COUNTY',
																		''
																	);			
																											  
			self.corp_ra_address_line6			:= if (trimUpper(input.Country) <> 'UNITED STATES' and 
																	trimUpper(input.Country) <> 'US' and
																	trimUpper(input.Country) <> 'USA',
																		trimUpper(input.Country),
																		''
																	);
			
			self.corp_ra_address_type_cd		:= '10';
											  
		    self.corp_ra_address_type_desc	:= 'REGISTERED OFFICE';
			
			self 											:= [];
						
		end; 
		
		corp2_mapping.Layout_CorpPreClean corpNonLegalTransform(MergedFilesCorp input) := transform

			self.dt_first_seen						:= fileDate;
			self.dt_last_seen							:= fileDate;
			self.dt_vendor_first_reported		:= fileDate;
			self.dt_vendor_last_reported		:= fileDate;
			self.corp_ra_dt_first_seen			:= fileDate;
			self.corp_ra_dt_last_seen				:= fileDate;			
			self.corp_key								:= '33-' + trimUpper(input.corporationID);
			self.corp_vendor							:= '33';
			self.corp_state_origin					:= 'NH';
			self.corp_process_date				:= fileDate;
			self.corp_orig_sos_charter_nbr		:= trimUpper(input.corporationNumber);
			self.corp_src_type						:= 'SOS';	
			self.corp_legal_name					:= trimUpper(input.CorpName); 														
			self.corp_ln_name_type_cd			:= if (trim(input.NameTypeDesc,left,right) <> '',
																		trimUpper(input.NameTypeId),
																		''
																	);
			self.corp_ln_name_type_desc		:= trimUpper(input.NameTypeDesc);			
			self 											:= [];
		end; 			
		
		corp2_mapping.Layout_CorpPreClean corpLegalNonRATransform1(corp2_mapping.Layout_CorpPreClean input, MergedFilesCorp r) := transform,skip(	trim(r.addressTypeID,left,right) = '10' or
																																																				trim(r.addressTypeID,left,right) = '11' or
																																																				trim(r.addressTypeID,left,right) = '14' or
																																																				trim(r.address1,left,right) = ''
																																																			 )
            concatAddrFields							:= if ((string)(integer) r.Address2 <> '0',
																		if ((string)(integer) r.Address3 <> '0',
																				trimUpper(r.Address1 + ' ' + r.Address2 + ' ' + r.Address3),
																				trimUpper(r.Address1 + ' ' + r.Address2)
																			),
																		if ((string)(integer) r.Address3 <> '0',
																				trimUpper(r.Address1 + ' ' + r.Address3),
																				trimUpper(r.Address1)
																			)
																	);
												
			self.corp_address1_line1 				:= trimUpper(concatAddrFields),

			self.corp_address1_line2				:= trimUpper(r.City);
														
			self.corp_address1_line3				:= if (trimUpper(r.State) <> 'XX' and not ut.isNumeric(trim(r.state,left,right)),
																		trimUpper(r.state),
																		''
																	);
														
			self.corp_address1_line4				:= trimUpper(r.Zip);
			
			self.corp_address1_line5				:= if (trimUpper(r.County) <> '' ,
																		trimUpper(r.County) + ' COUNTY',
																		''
																	);			
																											  
			self.corp_address1_line6				:= if (trimUpper(r.Country) <> 'UNITED STATES' and 
																	trimUpper(r.Country) <> 'US' and
																	trimUpper(r.Country) <> 'USA',
																		trimUpper(r.Country),
																		''
																	);
			cleanAddrType							:= trim(r.addressTypeID,left,right);
			
			self.corp_address1_type_cd			:= map (	cleanAddrType = '1' or
																			cleanAddrType = '6' or
																			cleanAddrType = '7' or
																			cleanAddrType = '15' or
																			cleanAddrType = '16' or
																			cleanAddrType = '17' or
																			cleanAddrType = '18' or
																			cleanAddrType = '19' or
																			cleanAddrType = '24' => 'M',
																			cleanAddrType = '8' or
																			cleanAddrType = '9' => 'B',
																			''
																		);
											  
		    self.corp_address1_type_desc		:= map (	cleanAddrType = '1' or
																			cleanAddrType = '6' or
																			cleanAddrType = '7' or
																			cleanAddrType = '15' or
																			cleanAddrType = '16' or
																			cleanAddrType = '17' or
																			cleanAddrType = '18' or
																			cleanAddrType = '19' or
																			cleanAddrType = '24' => 'MAILING',
																			cleanAddrType = '8' or
																			cleanAddrType = '9' => 'BUSINESS',
																			''
																		);
			self											:= input;
		end; 		
			
		corp2_mapping.Layout_CorpPreClean corpLegalNonRATransform2(MergedFilesCorp input) := transform,skip(	trim(input.addressTypeID,left,right) = '10' or
																												trim(input.addressTypeID,left,right) = '11' or
																												trim(input.addressTypeID,left,right) = '14' or
																												trim(input.addressTypeID,left,right) = '24' or
																												trim(input.address1,left,right) = ''
																											)
			self.dt_first_seen						:= fileDate;
			self.dt_last_seen							:= fileDate;
			self.dt_vendor_first_reported		:= fileDate;
			self.dt_vendor_last_reported		:= fileDate;
			self.corp_ra_dt_first_seen			:= fileDate;
			self.corp_ra_dt_last_seen				:= fileDate;			
			self.corp_key								:= '33-' + trimUpper(input.corporationID);
			self.corp_vendor							:= '33';
			self.corp_state_origin					:= 'NH';
			self.corp_process_date				:= fileDate;
			self.corp_orig_sos_charter_nbr		:= trimUpper(input.corporationNumber);
			self.corp_src_type						:= 'SOS';	
			
			self.corp_orig_org_structure_cd	:= if (trim(input.corporationTypeDesc,left,right)<>'',
																		trimUpper(input.corporationTypeID),
																		''
																	);
			self.corp_orig_org_structure_desc	:= trimUpper(input.corporationTypeDesc);
			
			self.corp_status_cd						:= if (trim(input.CorporationStatusDesc,left,right)<>'',
																		trimUpper(input.CorporationStatusID),
																		''
																	);
			self.corp_status_desc					:= trimUpper(input.CorporationStatusDesc);	
			
			
			StatusDate									:= reformatDate(input.DissolveDate);

		
			self.corp_status_date					:= if(	_validate.date.fIsValid(statusDate) and
																	_validate.date.fIsValid(statusDate,_validate.date.rules.DateInPast),
																		statusDate,
																		''
																	);  
													  
			self.corp_foreign_domestic_ind		:= trimUpper(input.citizenship);
			
			FilingDate									:= reformatDate(input.DateFormed);
			
			self.corp_inc_date						:= if(	_validate.date.fIsValid(filingDate) and
																	_validate.date.fIsValid(filingDate,_validate.date.rules.DateInPast),
																		filingDate,
																		''
																	); 
													  
			self.corp_filing_cd						:= if(	_validate.date.fIsValid(filingDate) and
																	_validate.date.fIsValid(filingDate,_validate.date.rules.DateInPast),
																		'C',
																		''
																	);
													  
			self.corp_filing_desc						:= if(	_validate.date.fIsValid(filingDate) and
																	_validate.date.fIsValid(filingDate,_validate.date.rules.DateInPast),
																		'CREATION',
																		''
																	);
													  
			DurationDate								:= reformatDate2(input.duration);
													  
			self.corp_term_exist_cd				:= if (trimUpper(input.duration) = 'PERPETUAL',
																		'P',
																		if(	_validate.date.fIsValid(DurationDate),
																			'D',
																			''
																		  )
																	);
													
			self.corp_term_exist_desc			:= if (trimUpper(input.duration) = 'PERPETUAL',
																		'PERPETUAL',
																		if(	_validate.date.fIsValid(DurationDate),
																			'DATE OF EXPIRATION',
																			''
																		  )
																	);
													   
			self.corp_term_exist_exp				:= if(	_validate.date.fIsValid(DurationDate),
																		DurationDate,
																		''
																  );
													  
			CleanState									:= trimUpper(input.stateOfIncorporation);
													  
			self.corp_inc_state						:= if (CleanState = '' or CleanState = 'NH',
																		'NH',
																		''
																	);
													  
			self.corp_inc_county					:= trimUpper(input.CountyOfIncorporation);
			
			self.corp_forgn_state_cd				:= if (CleanState <> '' and CleanState <> 'NH',
																		CleanState,
																		''
																	);
			            								
			self.corp_forgn_state_desc			:= map(	cleanState = 'AL' => 'ALABAMA',
																		cleanState = 'AK' => 'ALASKA',
																		cleanState = 'AZ' => 'ARIZONA',
																		cleanState = 'AR' => 'ARKANSAS',
																		cleanState = 'CA' => 'CALIFORNIA',
																		cleanState = 'CO' => 'COLORADO',
																		cleanState = 'CT' => 'CONNECTICUT',
																		cleanState = 'DE' => 'DELAWARE',
																		cleanState = 'DC' => 'DISTRICT OF COLUMBIA',
																		cleanState = 'FL' => 'FLORIDA',
																		cleanState = 'GA' => 'GEORGIA',
																		cleanState = 'HI' => 'HAWAII',
																		cleanState = 'ID' => 'IDAHO',
																		cleanState = 'IL' => 'ILLINOIS',
																		cleanState = 'IA' => 'IOWA',
																		cleanState = 'KS' => 'KANSAS',
																		cleanState = 'KY' => 'KENTUCKY',
																		cleanState = 'LA' => 'LOUISIANA',
																		cleanState = 'ME' => 'MAINE',
																		cleanState = 'MD' => 'MARYLAND',
																		cleanState = 'MA' => 'MASSACHUSETTS',
																		cleanState = 'MI' => 'MICHIGAN',
																		cleanState = 'MN' => 'MINNESOTA',
																		cleanState = 'MS' => 'MISSISSIPPI',
																		cleanState = 'MO' => 'MISSOURI',
																		cleanState = 'MT' => 'MONTANA',
																		cleanState = 'NE' => 'NEBRASKA',
																		cleanState = 'NV' => 'NEVADA',
																		cleanState = 'NJ' => 'NEW JERSEY',
																		cleanState = 'NM' => 'NEW MEXICO',
																		cleanState = 'NY' => 'NEW YORK',
																		cleanState = 'NC' => 'NORTH CAROLINA',
																		cleanState = 'ND' => 'NORTH DAKOTA',
																		cleanState = 'OH' => 'OHIO',
																		cleanState = 'OK' => 'OKLAHOMA',
																		cleanState = 'OR' => 'OREGON',
																		cleanState = 'PA' => 'PENNSYLVANIA',
																		cleanState = 'RI' => 'RHODE ISLAND',
																		cleanState = 'SC' => 'SOUTH CAROLINA',
																		cleanState = 'SD' => 'SOUTH DAKOTA',
																		cleanState = 'TN' => 'TENNESSEE',
																		cleanState = 'TX' => 'TEXAS',
																		cleanState = 'UT' => 'UTAH',
																		cleanState = 'VT' => 'VERMONT',
																		cleanState = 'VA' => 'VIRGINIA',
																		cleanState = 'WA' => 'WASHINGTON',
																		cleanState = 'WV' => 'WEST VIRGINIA',
																		cleanState = 'WI' => 'WISCONSIN',
																		cleanState = 'WY' => 'WYOMING',
																		trimUpper(input.countryOfIncorporation)
																);
														
			self.corp_entity_desc					:= if(trim(StringLib.StringFilterOut(input.purpose, '0123456789'),left,right)<>'',
															trimUpper(input.purpose),
															'');
																		
			self.corp_legal_name					:= trimUpper(input.CorpName); 														
			self.corp_ln_name_type_cd			:= if (trim(input.NameTypeDesc,left,right) <> '',
																		trimUpper(input.NameTypeId),
																		''
																	);
			self.corp_ln_name_type_desc		:= trimUpper(input.NameTypeDesc);																																																 
            concatAddrFields							:= if ((string)(integer) input.Address2 <> '0',
																		if ((string)(integer) input.Address3 <> '0',
																				trimUpper(input.Address1 + ' ' + input.Address2 + ' ' + input.Address3),
																				trimUpper(input.Address1 + ' ' + input.Address2)
																			),
																		if ((string)(integer) input.Address3 <> '0',
																				trimUpper(input.Address1 + ' ' + input.Address3),
																				trimUpper(input.Address1)
																			)
																	);
												
			self.corp_address1_line1 				:= trimUpper(concatAddrFields),

			self.corp_address1_line2				:= trimUpper(input.City);
														
			self.corp_address1_line3				:= if (trimUpper(input.State) <> 'XX' and not ut.isNumeric(trim(input.state,left,right)),
																		trimUpper(input.state),
																		''
																	);
														
			self.corp_address1_line4				:= trimUpper(input.Zip);
			
			self.corp_address1_line5				:= if (trimUpper(input.County) <> '' ,
																		trimUpper(input.County) + ' COUNTY',
																		''
																	);			
																											  
			self.corp_address1_line6				:= if (trimUpper(input.Country) <> 'UNITED STATES' and 
																	trimUpper(input.Country) <> 'US' and
																	trimUpper(input.Country) <> 'USA',
																		trimUpper(input.Country),
																		''
																	);
			cleanAddrType							:= trim(input.addressTypeID,left,right);
			
			self.corp_address1_type_cd			:= map (	cleanAddrType = '1' or
																			cleanAddrType = '6' or
																			cleanAddrType = '7' or
																			cleanAddrType = '15' or
																			cleanAddrType = '16' or
																			cleanAddrType = '17' or
																			cleanAddrType = '18' or
																			cleanAddrType = '19' or
																			cleanAddrType = '24' => 'M',
																			cleanAddrType = '8' or
																			cleanAddrType = '9' => 'B',
																			''
																		);
											  
		    self.corp_address1_type_desc		:= map (	cleanAddrType = '1' or
																			cleanAddrType = '6' or
																			cleanAddrType = '7' or
																			cleanAddrType = '15' or
																			cleanAddrType = '16' or
																			cleanAddrType = '17' or
																			cleanAddrType = '18' or
																			cleanAddrType = '19' or
																			cleanAddrType = '24' => 'MAILING',
																			cleanAddrType = '8' or
																			cleanAddrType = '9' => 'BUSINESS',
																			''
																		);
			self								:= [];
		end; 	
	
	
		corp2_mapping.Layout_ContPreClean contactTransform(FinalOfficerFile input) := transform,skip(trim(input.corpName,left,right)='')

			self.dt_first_seen						:=fileDate;
			self.dt_last_seen							:=fileDate;

			self.corp_key								:= '33-' + trimUpper(input.corporationID);	
			self.corp_vendor							:= '33';
			self.corp_state_origin					:= 'NH';
			self.corp_process_date				:= fileDate;
			self.corp_orig_sos_charter_nbr		:= trimUpper(input.corporationNumber);	
			
			self.corp_legal_name					:= trimUpper(input.CorpName);
			
			concatFields								:= 	trim(input.Title1,left,right) + ';' + 
																	trim(input.Title2,left,right) + ';' +  
																	trim(input.Title3,left,right) + ';' + 
																	trim(input.Title4,left,right) + ';' + 
																	trim(input.Title5,left,right) + ';' + 
																	trim(input.Title6,left,right) + ';' + 
																	trim(input.Title7,left,right) + ';' + 
																	trim(input.Title8,left,right) + ';' + 
																	trim(input.Title9,left,right) + ';' + 
																	trim(input.Title10,left,right);
																		
				
			tempExp									:= regexreplace('[;]*$',concatFields,'',NOCASE);
			tempExp2									:= regexreplace('^[;]*',tempExp,'',NOCASE);
			self.cont_title1_desc               	:= regexreplace('[;]+',tempExp2,';',NOCASE);  
									  
			self.cont_name							:= trimUpper(input.name);
			
			concatAddrFields							:= if ((string)(integer) input.Address2 <> '0',
																		if ((string)(integer) input.Address3 <> '0',
																				trimUpper(input.Address1 + ' ' + input.Address2 + ' ' + input.Address3),
																				trimUpper(input.Address1 + ' ' + input.Address2)
																			),
																		if ((string)(integer) input.Address3 <> '0',
																				trimUpper(input.Address1 + ' ' + input.Address3),
																				trimUpper(input.Address1)
																			)
																	);
												
			self.cont_address_line1 				:= trimUpper(concatAddrFields),

			self.cont_address_line2				:= trimUpper(input.City);
														
			self.cont_address_line3				:= if (trimUpper(input.State) <> 'XX' and not ut.isNumeric(trim(input.state,left,right)),
																		trimUpper(input.state),
																		''
																	);
														
			self.cont_address_line4				:= trimUpper(input.Zip);
																											  
			self.cont_address_line5				:= if (trimUpper(input.CountryName) <> 'UNITED STATES' and 
																	trimUpper(input.CountryName) <> 'US' and
																	trimUpper(input.CountryName) <> 'USA',
																		trimUpper(input.CountryName),
																		''
																	);
			
			self.cont_address_type_cd			:= if(	trim(concatAddrFields,left,right) <> '' or 
																	trim(input.city,left,right) <> '' or
																	trim(input.state,left,right) <>'' or 
																	trim(input.zip,left,right) <> '' or 
																	trim(input.CountryName,left,right) <> '',
																		'T',
																		''
																  );
													  
		    self.cont_address_type_desc		:= if(	trim(concatAddrFields,left,right) <> '' or 
																	trim(input.city,left,right) <> '' or
																	trim(input.state,left,right) <>'' or 
																	trim(input.zip,left,right) <> '' or 
																	trim(input.CountryName,left,right) <> '',
																		'CONTACT',
																		''
																	);
													
			self 											:= [];	
			
		end;							  
								 
		Corp2.Layout_Corporate_Direct_Stock_In StockTransform(StockWithCorp input):=transform																							
																								
			self.corp_key								:= '33-' + trimUpper(input.corporationID);	
			self.corp_vendor							:= '33';		
		
			self.corp_state_origin					:= 'NH';
			self.corp_process_date				:= fileDate;

			self.corp_sos_charter_nbr				:= trimUpper(input.corporationNumber);
			
			self.stock_class							:= trimUpper(input.StockClassDesc);
			
			self.stock_authorized_nbr				:= if ((string)(integer)input.AuthorizedShares <> '0', 
																		input.AuthorizedShares,
																		''
																	);
													
		    self.stock_par_value					:= if ((string)(integer)input.ParValue <> '0', 
																		input.ParValue,
																		''
																	);
			
			self											:=[];

		end;								 
								 
						
		Corp2.Layout_Corporate_Direct_Event_In EventFilingTransform(FilingWithCorp input):=transform,
										skip((trim(input.DocumentTypeID,left,right)='113') 
											  or
											 (trim(input.DocumentID,left,right)='' and
											  trim(input.DocumentTypeID,left,right)='' and
											  trim(input.DocumentTypeIDDesc,left,right)=''))
											  																																													
			self.corp_key						:= '33-' + trimUpper(input.corporationID);	
			self.corp_vendor					:= '33';				
			self.corp_state_origin				:= 'NH';
			self.corp_process_date				:= fileDate;
			self.corp_sos_charter_nbr			:= trimUpper(input.corporationNumber);			
			self.event_filing_reference_nbr 	:= trimUpper(input.DocumentID);			
			self.event_filing_cd				:= if( trimUpper(input.DocumentTypeIDDesc) <>'',
													   trimUpper(input.DocumentTypeID),
													   '');												
			self.event_filing_desc				:= trimUpper(input.DocumentTypeIDDesc);			
			eventFilingDate						:= reformatDate(input.FilingDate);		
			self.event_filing_date				:= if ( eventFilingDate <> '' and
														_validate.date.fIsValid(eventFilingDate) and
														_validate.date.fIsValid(eventFilingDate,_validate.date.rules.DateInPast),
															eventFilingDate,
															''
														);  
														
			self.event_date_type_cd				:= if (	eventFilingDate <> '' and
														_validate.date.fIsValid(eventFilingDate) and
														_validate.date.fIsValid(eventFilingDate,_validate.date.rules.DateInPast),
															'FIL',
															''
														);
			
			self.event_date_type_desc			:= if (	eventFilingDate <> '' and
														_validate.date.fIsValid(eventFilingDate) and
														_validate.date.fIsValid(eventFilingDate,_validate.date.rules.DateInPast),
															'FILING',
															''
														);
			
			self								:=[];

		end;
		
		Corp2.Layout_Corporate_Direct_AR_In ARTransform(FilingWithCorp input):=transform,skip(trim(input.DocumentTypeID,left,right)<>'113')																						
																								
			self.corp_key							:= '33-' + trimUpper(input.corporationID);	
			self.corp_vendor					:= '33';		
		
			self.corp_state_origin		:= 'NH';
			self.corp_process_date		:= fileDate;

			self.corp_sos_charter_nbr	:= trimUpper(input.corporationNumber);
			
			self.ar_report_nbr				:= trimUpper(input.DocumentID);
			
			eventFilingDate						:= reformatDate(input.FilingDate);
			self.ar_report_dt					:= if ( eventFilingDate <> '' and
																					_validate.date.fIsValid(eventFilingDate) and
																					_validate.date.fIsValid(eventFilingDate,_validate.date.rules.DateInPast),
																					eventFilingDate,
																					''
																					);  
			self 											:= [];
			
		end;
					
		
		Corp2.Layout_Corporate_Direct_Corp_In CleanCorpAddrName(corp2_mapping.Layout_CorpPreClean input) := transform		
			string73 tempname 			:= if(input.corp_ra_name = '', '', Address.CleanPersonFML73(input.corp_ra_name));
			pname 								:= Address.CleanNameFields(tempName);
			cname 								:= DataLib.companyclean(input.corp_ra_name);
			keepPerson 						:= corp2.Rewrite_Common.IsPerson(input.corp_ra_name);
			keepBusiness 						:= corp2.Rewrite_Common.IsCompany(input.corp_ra_name);
			
			self.corp_ra_title1				:= if(keepPerson, pname.title, '');
			self.corp_ra_fname1 			:= if(keepPerson, pname.fname, '');
			self.corp_ra_mname1 			:= if(keepPerson, pname.mname, '');
			self.corp_ra_lname1 			:= if(keepPerson, pname.lname, '');
			self.corp_ra_name_suffix1 	:= if(keepPerson, pname.name_suffix, '');
			self.corp_ra_score1 			:= if(keepPerson, pname.name_score, '');
		
			self.corp_ra_cname1 			:= if(keepBusiness, cname[1..70],'');
			self.corp_ra_cname1_score 	:= if(keepBusiness, pname.name_score, '');
			
			string182 clean_address 		:= Address.CleanAddress182(trim(input.corp_address1_line1,left,right),
																							trim(	trim(input.corp_address1_line2,left,right) + ', ' +
																									trim(input.corp_address1_line3,left,right) + ' ' +
																									trim(input.corp_address1_line4,left,right),
																									left,right
																								  )
																							);			
			
			string182 clean_ra_address 	:= Address.CleanAddress182(trim(input.corp_ra_address_line1,left,right), 
																							trim(	trim(input.corp_ra_address_line2,left,right) + ', ' +
																									trim(input.corp_ra_address_line3,left,right) + ' ' +
																									trim(input.corp_ra_address_line4,left,right),
																									left,right
																								  )
																							);	
																				
			self.corp_ra_prim_range    	:= clean_ra_address[1..10];
			self.corp_ra_predir 	      		:= clean_ra_address[11..12];
			self.corp_ra_prim_name 	  	:= clean_ra_address[13..40];
			self.corp_ra_addr_suffix   		:= clean_ra_address[41..44];
			self.corp_ra_postdir 	    	:= clean_ra_address[45..46];
			self.corp_ra_unit_desig 	  	:= clean_ra_address[47..56];
			self.corp_ra_sec_range 	  	:= clean_ra_address[57..64];
			self.corp_ra_p_city_name	  	:= clean_ra_address[65..89];
			self.corp_ra_v_city_name	  	:= clean_ra_address[90..114];
			self.corp_ra_state 			    := clean_ra_address[115..116];
			self.corp_ra_zip5 		      	:= clean_ra_address[117..121];
			self.corp_ra_zip4 		      	:= clean_ra_address[122..125];
			self.corp_ra_cart 		      	:= clean_ra_address[126..129];
			self.corp_ra_cr_sort_sz 	 	:= clean_ra_address[130];
			self.corp_ra_lot 		      		:= clean_ra_address[131..134];
			self.corp_ra_lot_order 	  		:= clean_ra_address[135];
			self.corp_ra_dpbc 		      	:= clean_ra_address[136..137];
			self.corp_ra_chk_digit 	  		:= clean_ra_address[138];
			self.corp_ra_rec_type		  	:= clean_ra_address[139..140];
			self.corp_ra_ace_fips_st	  	:= clean_ra_address[141..142];
			self.corp_ra_county 	  		:= clean_ra_address[143..145];
			self.corp_ra_geo_lat 	    	:= clean_ra_address[146..155];
			self.corp_ra_geo_long 	    	:= clean_ra_address[156..166];
			self.corp_ra_msa 		      	:= clean_ra_address[167..170];
			self.corp_ra_geo_blk			:= clean_ra_address[171..177];
			self.corp_ra_geo_match 	  	:= clean_ra_address[178];
			self.corp_ra_err_stat 	    	:= clean_ra_address[179..182];
													
			self.corp_addr1_prim_range  	:= clean_address[1..10];
			self.corp_addr1_predir 	    	:= clean_address[11..12];
			self.corp_addr1_prim_name 		:= clean_address[13..40];
			self.corp_addr1_addr_suffix   	:= clean_address[41..44];
			self.corp_addr1_postdir 	   		:= clean_address[45..46];
			self.corp_addr1_unit_desig 		:= clean_address[47..56];
			self.corp_addr1_sec_range 		:= clean_address[57..64];
			self.corp_addr1_p_city_name	:= clean_address[65..89];
			self.corp_addr1_v_city_name	:= clean_address[90..114];
			self.corp_addr1_state 			    := clean_address[115..116];
			self.corp_addr1_zip5 		      	:= clean_address[117..121];
			self.corp_addr1_zip4 		      	:= clean_address[122..125];
			self.corp_addr1_cart 		     	:= clean_address[126..129];
			self.corp_addr1_cr_sort_sz 	 	:= clean_address[130];
			self.corp_addr1_lot 		      		:= clean_address[131..134];
			self.corp_addr1_lot_order 		:= clean_address[135];
			self.corp_addr1_dpbc 		     	:= clean_address[136..137];
			self.corp_addr1_chk_digit 		:= clean_address[138];
			self.corp_addr1_rec_type		  	:= clean_address[139..140];
			self.corp_addr1_ace_fips_st		:= clean_address[141..142];
			self.corp_addr1_county 	  		:= clean_address[143..145];
			self.corp_addr1_geo_lat 	    	:= clean_address[146..155];
			self.corp_addr1_geo_long 	    := clean_address[156..166];
			self.corp_addr1_msa 		      	:= clean_address[167..170];
			self.corp_addr1_geo_blk			:= clean_address[171..177];
			self.corp_addr1_geo_match 	  	:= clean_address[178];
			self.corp_addr1_err_stat 	    	:= clean_address[179..182];
			self										:= input;
			self 										:= [];
		end;						
	
		Corp2.Layout_Corporate_Direct_Cont_In CleanContAddrName(corp2_mapping.Layout_ContPreClean input) := transform		
			string73 tempname 				:= if(input.cont_name = '', '', Address.CleanPersonFML73(input.cont_name));
			pname 									:= Address.CleanNameFields(tempName);
			cname 									:= DataLib.companyclean(input.cont_name);
			keepPerson 							:= corp2.Rewrite_Common.IsPerson(input.cont_name);
			keepBusiness 							:= corp2.Rewrite_Common.IsCompany(input.cont_name);
			
			self.cont_title1						:= if(keepPerson, pname.title, '');
			self.cont_fname1 					:= if(keepPerson, pname.fname, '');
			self.cont_mname1 					:= if(keepPerson, pname.mname, '');
			self.cont_lname1 					:= if(keepPerson, pname.lname, '');
			self.cont_name_suffix1 			:= if(keepPerson, pname.name_suffix, '');
			self.cont_score1 					:= if(keepPerson, pname.name_score, '');
		
			self.cont_cname1 					:= if(keepBusiness, cname[1..70],'');
			self.cont_cname1_score 			:= if(keepBusiness, pname.name_score, '');
			
		
			string182 clean_address 			:= Address.CleanAddress182(trim(input.cont_address_line1,left,right),
																								trim(	trim(input.cont_address_line2,left,right) + ', ' +
																										trim(input.cont_address_line3,left,right) + ' ' +
																										trim(input.cont_address_line4,left,right),
																										left,right
																									  )
																								);	
																				
			self.cont_prim_range    			:= clean_address[1..10];
			self.cont_predir 	      				:= clean_address[11..12];
			self.cont_prim_name 	  			:= clean_address[13..40];
			self.cont_addr_suffix   				:= clean_address[41..44];
			self.cont_postdir 	  		  		:= clean_address[45..46];
			self.cont_unit_desig 	  			:= clean_address[47..56];
			self.cont_sec_range 	  			:= clean_address[57..64];
			self.cont_p_city_name	  			:= clean_address[65..89];
			self.cont_v_city_name	 			:= clean_address[90..114];
			self.cont_state 			      		:= clean_address[115..116];
			self.cont_zip5 		      			:= clean_address[117..121];
			self.cont_zip4 		 	     		:= clean_address[122..125];
			self.cont_cart 		    	  		:= clean_address[126..129];
			self.cont_cr_sort_sz 	 			:= clean_address[130];
			self.cont_lot 		      				:= clean_address[131..134];
			self.cont_lot_order 	  				:= clean_address[135];
			self.cont_dpbc 		   		   		:= clean_address[136..137];
			self.cont_chk_digit 	  				:= clean_address[138];
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
			
						
		MapCorpLegal			:= project(joinLegal, corpLegalRATransform(left));
		
		MapCorpNonRA1	 	:= join(	MapCorpLegal, JoinLegalNonRA,
												trim(left.corp_key,left,right)[4..] = trim(right.CorporationID,left,right),
												corpLegalNonRATransform1(left,right),
												left outer
											  );
											  
        MapCorpNonRA2	 	:= join(	MapCorpLegal, JoinLegalNonRA,
												trim(left.corp_key,left,right)[4..] = trim(right.CorporationID,left,right),
												corpLegalNonRATransform2(right),
												right only
											  );
		
		MapNonLegal			:= project(joinNonLegal, corpNonLegalTransform(left));
		
		AllCorps				:= distribute((MapCorpLegal + MapCorpNonRA1 + MapCorpNonRA2 + MapNonLegal)((trim(corp_ln_name_type_cd,left,right) = '1' and trim(corp_address1_type_cd,left,right)<>'') or trim(corp_ln_name_type_cd,left,right) <> '1'), hash32(corp_key));

		MapCorp 				:= sort(AllCorps,corp_key,LOCAL);
			
		MapContacts 		:= project(DedupDenormalized, contactTransform(left));
			
		cleanCorp 			:= project(MapCorp, CleanCorpAddrName(left));			  
		cleanCont 			:= project(MapContacts, CleanContAddrName(left));
		mapStock				:= project(JoinStockWithCorp, stockTransform(left));
		
		mapEvent				:= project(JoinFilingwithCorp, EventFilingTransform(left));
		
		mapAR						:= project(JoinFilingwithCorp, ARTransform(left));
				
		
		
	VersionControl.macBuildNewLogicalFile('~thor_data400::in::corp2::'+version+'::corp_nh'	,cleanCorp,corp_out		,,,pOverwrite);		
	VersionControl.macBuildNewLogicalFile('~thor_data400::in::corp2::'+version+'::cont_nh'	,cleanCont,cont_out		,,,pOverwrite);
	VersionControl.macBuildNewLogicalFile('~thor_data400::in::corp2::'+version+'::stock_nh'	,MapStock	,stock_out	,,,pOverwrite);
	VersionControl.macBuildNewLogicalFile('~thor_data400::in::corp2::'+version+'::ar_nh'		,MapAR		,ar_out			,,,pOverwrite);
	VersionControl.macBuildNewLogicalFile('~thor_data400::in::corp2::'+version+'::event_nh'	,MapEvent	,event_out	,,,pOverwrite);
                                                                                                                                                          
		mapNHFiling := parallel(
			 corp_out	
			,cont_out	
			,stock_out
			,ar_out		
			,event_out
								 );	
	
		result := 
		sequential(
			 if(pshouldspray = true,fSprayFiles('nh',filedate,pOverwrite := pOverwrite))
			,mapNHFiling
			,parallel(
				 fileservices.addsuperfile('~thor_data400::in::corp2::sprayed::corp'	,'~thor_data400::in::corp2::'+version+'::corp_nh')
				,fileservices.addsuperfile('~thor_data400::in::corp2::sprayed::cont'	,'~thor_data400::in::corp2::'+version+'::cont_nh')
				,fileservices.addsuperfile('~thor_data400::in::corp2::sprayed::stock'	,'~thor_data400::in::corp2::'+version+'::stock_nh')
				,fileservices.addsuperfile('~thor_data400::in::corp2::sprayed::ar'		,'~thor_data400::in::corp2::'+version+'::ar_nh')																
				,fileservices.addsuperfile('~thor_data400::in::corp2::sprayed::event'	,'~thor_data400::in::corp2::'+version+'::event_nh')
			)
		);

		return result;
	end;					 
	
end; // end of NH module