#option('skipFileFormatCrcCheck', 1);

import ut, lib_stringlib, _validate, Address, corp2, _control, versioncontrol;

export GA := MODULE;

	export Layouts_Raw_Input := MODULE;


		export Corporation := record,MAXLENGTH(1000)
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
			string RegAgentName;
			string RegAgentID;
			string ArpDate;			
			string lf;
			end;

		
		export Address := record,MAXLENGTH(1000)
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

		
		export Filing := record,MAXLENGTH(1000)
			string FilingID;
			string CorporationID;
			string DocumentID;
			string DocumentTypeID;
			string FilingDate;
			string EffectiveDate;
			string lf;
			end;


		export Merger := record,MAXLENGTH(1000)
			string MergerID;
			string SurvivorCorporationID;
			string MergedCorporationID;
			string MergerDate;
			string lf;
			end;

			
		export CorporationName := record,MAXLENGTH(1000)
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
		
		export Officer := record,MAXLENGTH(1000)
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
		
		export Stock := record,MAXLENGTH(1000)
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
		
		export RAgent := record,MAXLENGTH(1000)
			string RegAgentID;
			string RegAgentName;
			string RegAgentAddr;
			string RegAgentCity;
			string RegAgentState;
			string RegAgentZip;
			string RegAgentCounty;
			string RegAgentCountry;
			string lf;
			end;		
		
	end; 	
	
	export Files_Raw_Input := MODULE;			
		
		export address (string fileDate)    			:= dataset('~thor_data400::in::corp2::'+fileDate+'::address::ga',
																									layouts_Raw_Input.address,CSV(SEPARATOR([',']), quote('"'), TERMINATOR(['\r\n'])));
																									
		export corporation (string fileDate)			:= dataset('~thor_data400::in::corp2::'+fileDate+'::corporation::ga',
																									layouts_Raw_Input.corporation,CSV(SEPARATOR([',']), quote('"'),TERMINATOR(['\r\n'])));
																									
		export corporationName (string fileDate)  		:= dataset('~thor_data400::in::corp2::'+fileDate+'::name::ga',
																									layouts_Raw_Input.CorporationName,CSV(SEPARATOR([',']), quote('"'), TERMINATOR(['\r\n'])));
														
		export filing (string fileDate)     			:= dataset('~thor_data400::in::corp2::'+fileDate+'::filing::ga',
																									layouts_Raw_Input.filing,CSV(SEPARATOR([',']), quote('"'), TERMINATOR(['\r\n'])));
														
		export merger (string fileDate)     			:= dataset('~thor_data400::in::corp2::'+fileDate+'::merger::ga',
																									layouts_Raw_Input.merger,CSV(SEPARATOR([',']), quote('"'), TERMINATOR(['\r\n'])));																												
														
		export officer (string fileDate)    			:= dataset('~thor_data400::in::corp2::'+fileDate+'::officer::ga',
																									layouts_Raw_Input.officer,CSV(SEPARATOR([',']), quote('"'), TERMINATOR(['\r\n'])));	
																									
		export ragent (string fileDate)    				:= dataset('~thor_data400::in::corp2::'+fileDate+'::ragent::ga',
																									layouts_Raw_Input.ragent,CSV(SEPARATOR([',']), quote('"'), TERMINATOR(['\r\n'])));
														
		export stock (string fileDate)     				:= dataset('~thor_data400::in::corp2::'+fileDate+'::stock::ga',
																									layouts_Raw_Input.stock,CSV(SEPARATOR([',']), quote('"'), TERMINATOR(['\r\n'])));															
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
		
		reformatDate3(string inDate) := function
			return trim(regexreplace('00:00:00',inDate,''),left,right);						
		end;
		
		trimUpper(string s) := function
			return trim(stringlib.StringToUppercase(s),left,right);
		end;
		

		//--------------------  Document ID code explosion ------------------	
		
		RAgentDupes := record,MAXLENGTH(1000)
			string RegAgentID;
			string RegAgentName;
			string RegAgentAddr;
			string RegAgentCity;
			string RegAgentState;
			string RegAgentZip;
			string RegAgentCounty;
			string RegAgentCountry;
			string1 DupeFlag;
			end;
		
		FilingLookups := record,MAXLENGTH(1000)
			string FilingID;
			string CorporationID;
			string DocumentID;
			string DocumentTypeID;
			string FilingDate;
			string EffectiveDate;
			string DocumentTypeIDDesc;
			end;	
		
		FilingWithCorp := record,MAXLENGTH(1000)
			string FilingID;
			string CorporationID;
			string DocumentID;
			string DocumentTypeID;
			string FilingDate;
			string EffectiveDate;
			string DocumentTypeIDDesc;
			string CorporationNumber;
			end;		
		
		DocumentIDCodeLayout := record,MAXLENGTH(1000)
			string	DocIDCode;
			string	DocIDDesc;
			end;
		
		DocumentIDTable := dataset('~thor_data400::lookup::corp2::' + fileDate + '::DocumentTypeID_Table::ga', DocumentIDCodeLayout, CSV(SEPARATOR([',']), quote('"'), TERMINATOR(['\r\n'])));
		
		FilingLookups findDocumentIDCode(layouts_raw_input.Filing input, DocumentIDCodeLayout r ) := transform
			self.DocumentTypeIDDesc 	:= r.DocIDDesc;
			self         		  		:= input;
			self                  		:= [];
			end; 
	
		PopFilingLookups := join(Files_Raw_Input.Filing(fileDate), DocumentIDTable,
								 trim(left.DocumentTypeID,left,right) = right.DocIDCode,
								 findDocumentIDCode(left,right),
								 left outer, lookup);												
								 
		FilingWithCorp MergeFiling2Corp(FilingLookups l, layouts_raw_input.corporation r ) := transform
			self 	:= r;
			self	:= l;			
			end; 
		
		joinFilingWithCorp := join(PopFilingLookups, files_raw_input.corporation(fileDate),
								   trim(left.CorporationID,left,right) = trim(right.CorporationID,left,right),
								   MergeFiling2Corp(left,right),
								  left outer);																					 								 

		//--------------------  Stock Class code explosion ------------------
		
		StockLookups := record,MAXLENGTH(1000)
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
		
		StockWithCorp := record,MAXLENGTH(1000)
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
		
		StockClassCodeLayout := record,MAXLENGTH(1000)
			string StockClassCode;
			string StockClassDesc;
			end;
		
		StockClassTable := dataset('~thor_data400::lookup::corp2::' + fileDate + '::StockClass_Table::ga', StockClassCodeLayout, CSV(SEPARATOR([',']), quote('"'), TERMINATOR(['\r\n'])));
		
		StockLookups findStockClassCode(layouts_raw_input.Stock input, StockClassCodeLayout r ) := transform
			self.StockClassDesc 	:= r.StockClassDesc;
			self         			:= input;
			self                	:= [];
			end; 
	
		PopStockLookups := join(Files_Raw_Input.Stock(fileDate), StockClassTable,
								trim(left.StockClassID,left,right) = right.StockClassCode,
								findStockClassCode(left,right),
								left outer, lookup);													
								 
		StockWithCorp MergeStock2Corp(StockLookups l, layouts_raw_input.corporation r ) := transform
			self 	:= r;
			self	:= l;			
			end; 
		
		joinStockWithCorp := join(PopStockLookups, files_raw_input.corporation(fileDate),
								  trim(left.CorporationID,left,right) = trim(right.CorporationID,left,right),
								  MergeStock2Corp(left,right),
								 left outer);																				 
								 
		//------------------------ corp file manipulations -------------------------
	
		CorpWithCorpName := record,MAXLENGTH(1000)
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
			string RegAgentName;
			string RegAgentId;
			string CorpName;
			string NameTypeId;
			string NameTypeDesc;
			end;

		MergedFilesCorpRA := record,MAXLENGTH(1000)
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
			string RegAgentName;	
			string RegAgentId;
			string CorpName;
			string NameTypeId;
			string NameTypeDesc;
			string RegAgentAddr;
			string RegAgentCity;
			string RegAgentState;
			string RegAgentZip;
			string RegAgentCounty;
			string RegAgentCountry;
			end;
		
		MergedCorpAddrsRA := record,MAXLENGTH(1300)
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
			string RegAgentName;	
			string RegAgentId;
			string CorpName;
			string NameTypeId;
			string NameTypeDesc;			
			string RegAgentAddr;
			string RegAgentCity;
			string RegAgentState;
			string RegAgentZip;
			string RegAgentCounty;
			string RegAgentCountry;
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

		MergedCorpAddrsRAForgn := record,MAXLENGTH(1300)
			MergedCorpAddrsRA;
			string ForgnState;			
			end;
			
		MergedFilesCorp := record,MAXLENGTH(1000)
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
			string RegAgentName;		
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
		
				
		PopCorpLookups := record,MAXLENGTH(1000)
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
			string RegAgentName;		
			string RegAgentID;
			end;	
		
		PopNameLookups := record,MAXLENGTH(1000)
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

		CorpTypeLayout := record,MAXLENGTH(1000)
			string CorpTypeCode;
			string CorpTypeDesc;
			end;
		
		CorpTypeTable := dataset('~thor_data400::lookup::corp2::' + fileDate + '::CorpType_Table::ga', CorpTypeLayout, CSV(SEPARATOR([',']), quote('"'), TERMINATOR(['\r\n'])));
		
		PopCorpLookups findCorpTypeCode(layouts_raw_input.corporation input, CorpTypeLayout r ) := transform
			self.CorporationTypeDesc	:= r.CorpTypeDesc;
			self         		  		:= input;
			self                  		:= [];
			end; 
	
		PopCorpType := join(Files_Raw_Input.Corporation(fileDate), CorpTypeTable,
							trim(left.CorporationTypeID,left,right) = right.CorpTypeCode,
							findCorpTypeCode(left,right),
							left outer, lookup);												
							
		//----------------------------------------------------------------
		
		//--------------------  Status code explosion --------------------
		
		StatusCodeLayout := record,MAXLENGTH(1000)
			string StatusCode;
			string StatusDesc;
			end;
		
		StatusTable := dataset('~thor_data400::lookup::corp2::' + fileDate + '::StatusCode_Table::ga', StatusCodeLayout, CSV(SEPARATOR([',']), quote('"'), TERMINATOR(['\r\n'])));
		
		PopCorpLookups findStatusCode(PopCorpLookups input, StatusCodeLayout r ) := transform
			self.CorporationStatusDesc   	:= r.StatusDesc;
			self         		 		 					:= input;
			end;
	
		PopStatusDesc := join(PopCorpType, StatusTable,
							  trim(left.CorporationStatusID,left,right) = trim(right.StatusCode,left,right),
							  findStatusCode(left,right),
							  left outer, lookup);												
							  
		//----------------------------------------------------------------
		
		//--------------------  Name Type code explosion -----------------	
		
		NameTypeLayout := record,MAXLENGTH(1000)
			string NameTypeCode;
			string NameTypeDesc;
			end;
		
		NameTypeTable := dataset('~thor_data400::lookup::corp2::' + fileDate + '::NameType_Table::ga', NameTypeLayout, CSV(SEPARATOR([',']), quote('"'), TERMINATOR(['\r\n'])));
		
		PopNameLookups findNameTypeCode(layouts_raw_input.corporationName input, NameTypeLayout r ) := transform
			self.NameTypeDesc		:= r.NameTypeDesc;
			self         			:= input;
			self            		:= [];
			end; 
	
		PopNameType := join(Files_Raw_Input.CorporationName(fileDate), NameTypeTable,
							trim(left.NameTypeID,left,right) = right.NameTypeCode,
							findNameTypeCode(left,right),
							left outer, lookup);											
						   
        //---------------------- Merge Corporation & Name files --------------------						   
		
		CorpWithCorpName MergeCorp2Name(PopCorpLookups l, PopNameLookups r ) := transform
			self 	:= r;
			self	:= l;			
			end; 
		
		joinCorpWithName := join(PopStatusDesc, PopNameType,
								 trim(left.CorporationID,left,right) = trim(right.CorporationID,left,right),
								 MergeCorp2Name(left,right),
								 left outer);											
								
		// LegalNamesOnly 	:= joinCorpWithName(trim(NameTypeId,left,right) = '1' and trim(CorporationID,left,right)<>'');
		// NonLegalNames		:= joinCorpWithName(trim(NameTypeId,left,right) <> '1'  and trim(CorporationID,left,right)<>'');
		GoodCorpIDs := joinCorpWithName(trim(CorporationID,left,right)<>'');
		
		// MissingNames := GoodCorpIDs(CorpName='');
		
		MergedFilesCorpRA MergeRA(CorpWithCorpName l, Layouts_Raw_Input.Ragent r ) := transform
			self.RegAgentName := r.RegAgentName;
			self 			  := r;
			self			  := l;			
			end;
		
		MergedFilesCorp MergeAll(CorpWithCorpName l, Layouts_Raw_Input.Address r ) := transform
			self 	:= r;
			self	:= l;			
			end; 	
		
		MergedCorpAddrsRA MergeAddrs(MergedFilesCorpRA l, Layouts_Raw_Input.Address r ) := transform
			self 	:= r;
			self	:= l;			
			end;
					
		
		MergedFilesCorp addBlankAddr(CorpWithCorpName l) := transform
			self 	:= l;
			self	:= [];			
		end; 		
		
		// joinLegalRA := join(LegalNamesOnly, Files_Raw_Input.Ragent(fileDate),
												// trim(left.regAgentID,left,right) = trim(right.regAgentID,left,right),
												// MergeRA(left,right),
												// left outer
											// );
											
		// joinNonLegalRA := join(NonLegalNames, Files_Raw_Input.Ragent(fileDate),
												// trim(left.regAgentID,left,right) = trim(right.regAgentID,left,right),
												// MergeRA(left,right),
												// left outer
											// );
													
											
		// noAddrsRA := join(LegalNamesOnly, Files_Raw_Input.Ragent(fileDate),
						// trim(left.regAgentID,left,right) = trim(right.regAgentID,left,right),
						// MergeRA(left,right),
						// left only
						 // );
						 
		// RAgentDupes remap_Ragent(Layouts_Raw_Input.RAgent l) := transform 
			// self.dupeFlag := '';
			// self := l;
            // end;
			
		// RAgentDupes iterate_Ragent(RAgentDupes l, RAgentDupes r) := transform 
			// self.dupeFlag := if(r.regagentid = l.regagentid,
								// 'D',
								// '');
			// self 		  := r;
            // end;	
			
		// remapRagent := project(Files_Raw_Input.Ragent(fileDate),remap_Ragent(left));
		// sortedRagentTemp := sort(remapRagent,RegAGentID);
		sortedRagent := sort(Files_Raw_Input.Ragent(fileDate),RegAGentID);
		dedupedRagent := dedup(sortedRagent,RegAGentID);
		// diffRagent := iterate(sortedRagentTemp,iterate_Ragent(left,right));
		// diffRecs := diffRagent(dupeFlag='D');
		
		// setOfDupes := set(diffRecs,RegAGentID);
		
		// allDupeRecs := sortedRagentTemp(RegAGentID in setOfDupes);
							
		allAddrs   := Files_Raw_Input.Address(fileDate);
		
		goodAddrs  := allAddrs(trim(AddressTypeID,left,right) not in 
							   ['10','14','17','17','18','19']);
							   
		sortGoodAddrs := sort(goodAddrs,CorporationID,AddressTypeID,Address1,
								Address2,Address3,City,State,Zip);
								
		dedupGoodAddrs := dedup(sortGoodAddrs,CorporationID,AddressTypeID,Address1,
								Address2,Address3,City,State,Zip);
							   
		// joinLegal := join(LegalNamesOnly, Files_Raw_Input.Address(fileDate),
												// trim(left.CorporationID,left,right) = trim(right.CorporationID,left,right),
												// MergeAll(left,right),
												// left outer
											// );
											
		// countAddrs := Files_Raw_Input.Address(fileDate);
							  
		// JoinLegalNonRA := joinLegal(trim(AddressTypeID,left,right)<>'10' and
																// trim(AddressTypeID,left,right)<>'11' and
																// trim(AddressTypeID,left,right)<>'14');
						  
		// joinNonLegal := project(NonLegalNames,addBlankAddr(left));
		
		joinAllCorpsRA := join(goodCorpIDs, dedupedRagent,
							   trim(left.regAgentID,left,right) = trim(right.regAgentID,left,right),
							   MergeRA(left,right),
							   left outer);
									
		// TempCorpsRA := joinAllCorpsRA(trim(RegAgentAddr,left,right)<>'');
		
		joinCorpAddrsRA := join(joinAllCorpsRA, dedupGoodAddrs,
								trim(left.CorporationID,left,right) = trim(right.CorporationID,left,right),
								MergeAddrs(left,right),
								left outer);
		//-----------------  Foreign State / Country code explosion -----------------	
		
		ForgnStateLayout := record,MAXLENGTH(100)
			string ForgnStateCode;
			string ForgnStateDesc;
			end;
		
		ForgnStateTable := dataset('~thor_data400::lookup::corp2::ForgnStateCountry_Table::ga', ForgnStateLayout, CSV(SEPARATOR([',']), TERMINATOR(['\r\n','\n'])));
		
		MergedCorpAddrsRAForgn findForgnStateCode(MergedCorpAddrsRA l, ForgnStateLayout r ) := transform
			self.ForgnState			:= r.ForgnStateDesc;
			self         			:= l;
			end; 
	
		joinCorpAddrsRAForgn := join(joinCorpAddrsRA, ForgnStateTable,
							trimUpper(left.stateOfIncorporation) = trimUpper(right.ForgnStateCode),
							findForgnStateCode(left,right),
							left outer,lookup);	
			
		
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
		
		// LegalNames := dedup(LegalNamesOnly,corporationID);
		
		goodNames := dedup(goodCorpIDs,corporationID);
		
		OfficerWithCorpName MergeOfficerWithCorpName(Layouts_Raw_Input.Officer l, CorpWithCorpName r ) := transform
			self 	:= r;
			self	:= l;			
			end; 
	
		joinOfficer2CorpName	:= join(Files_Raw_Input.Officer(fileDate),goodNames,
										trim(left.CorporationID, left, right) = trim(right.CorporationID,left,right),
										MergeOfficerWithCorpName(left,right),
										left outer);															
										
		//------- join result of above with OfficerPartyType Table ------------------
		
		OffPartyTypeLayout := record,MAXLENGTH(1000)
			string OffPartyTypeID;
			string OffID;
			string PartyTypeID;
			end;
		
		OffPartyTypeTable := dataset('~thor_data400::lookup::corp2::' + fileDate + '::OffPartyType_Table::ga', OffPartyTypeLayout, CSV(SEPARATOR([',']), quote('"'), TERMINATOR(['\r\n'])));
								
		OfficerWithPartyID MergeOfficerWithOffPartyType(OfficerWithCorpName l, OffPartyTypeLayout r ) := transform
			self 	:= l;
			self	:= r;
			self	:= [];
			end; 
	
		joinOfficer2OffPartyType	:= join(joinOfficer2CorpName, OffPartyTypeTable,
											trim(left.OfficerID, left, right) = trim(right.OffID,left,right),
											MergeOfficerWithOffPartyType(left,right),
											left outer);																									
											
		//------- join result of above with PartyType Table ------------------	
		
		PartyTypeLayout := record,MAXLENGTH(1000)
			string PartyTypeID;
			string PartyTypeDesc;
			end;
		
		PartyTypeTable := dataset('~thor_data400::lookup::corp2::' + fileDate + '::PartyType_Table::ga', PartyTypeLayout, CSV(SEPARATOR([',']), quote('"'), TERMINATOR(['\r\n'])));
										
										
		OfficerWithPartyDesc MergeOfficerWithPartyType(OfficerWithPartyID l, PartyTypeLayout r ) := transform
			self 	:= l;
			self	:= r;
			self	:= [];
			end; 
	
		joinOfficer2PartyType	:= join(joinOfficer2OffPartyType, PartyTypeTable,
										trim(left.PartyTypeID, left, right) = trim(right.PartyTypeID,left,right),
										MergeOfficerWithPartyType(left,right),
										left outer);													
										
		//------- Denormalize above result to get all titles in one record ------------------	
		
		sortOffFile		:= sort(joinOfficer2PartyType, corporationID,name,Address1,Address2,Address3,city,state,zip);		

		distofficers 	:= distribute(sortOffFile,hash64(corporationID,name,Address1,Address2,Address3,city,state,zip));

		FinalOfficerFile	newTransform(OfficerWithPartyDesc l) := transform
			self			:=l;
			self			:=[];
			end;
	
		newOfficerFile		:= project(distOfficers, newTransform(left));

		FinalOfficerFile DenormOfficers(FinalOfficerFile L, FinalOfficerFile R, INTEGER C) := TRANSFORM
		
			self.Title1 	:= IF (C=1, R.partyTypeDesc,L.TITLE1);                  
			self.title2		:= IF (C=2, R.partyTypeDesc,L.TITLE2);
			self.title3		:= IF (C=3, R.partyTypeDesc,L.TITLE3); 
			self.title4		:= IF (C=4, R.partyTypeDesc,L.TITLE4); 
			self.title5		:= IF (C=5, R.partyTypeDesc,L.TITLE5); 
			self.title6		:= IF (C=6, R.partyTypeDesc,L.TITLE6); 
			self.title7		:= IF (C=7, R.partyTypeDesc,L.TITLE7); 
			self.title8		:= IF (C=8, R.partyTypeDesc,L.TITLE8); 
			self.title9		:= IF (C=9, R.partyTypeDesc,L.TITLE9); 
			self.title10	:= IF (C=10,R.partyTypeDesc,L.TITLE10); 			
			self 			:= L;
		    end;

	
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
				
corp2_mapping.Layout_CorpPreClean corpTransform(MergedCorpAddrsRAForgn input) := transform

			self.dt_first_seen								:= fileDate;
			self.dt_last_seen								:= fileDate;
			self.dt_vendor_first_reported					:= fileDate;
			self.dt_vendor_last_reported					:= fileDate;
			self.corp_ra_dt_first_seen						:= fileDate;
			self.corp_ra_dt_last_seen						:= fileDate;			
			self.corp_key									:= '13-' + trimUpper(input.corporationID);
			self.corp_vendor								:= '13';
			self.corp_state_origin							:= 'GA';
			self.corp_process_date							:= fileDate;
			self.corp_orig_sos_charter_nbr					:= trimUpper(input.corporationNumber);
			self.corp_src_type								:= 'SOS';				
			self.corp_legal_name							:= trimUpper(input.CorpName); 
		    cleanType										:= trim(input.NameTypeId,left,right);									
			self.corp_ln_name_type_cd						:= map(cleanType='1'=>'01',
														           cleanType='2'or 
																   cleanType='20'=>'F',
																   cleanType='3'=>'P',
																   cleanType='14'=>'07',																   
																   '');
			self.corp_ln_name_type_desc						:= map(cleanType='1'=>'LEGAL',
														           cleanType='2'or
																   cleanType='20'=>'FBN',
																   cleanType='3'=>'PRIOR',
																   cleanType='14'=>'RESERVED',																   
																   '');
			dissolvedDate									:= reformatDate3(input.DissolveDate);		
			self.corp_addl_info                             := if(trim(dissolvedDate,left,right)<>'',
															      'DISSOLVED DATE: ' + dissolvedDate,
																  ''
																 );  			
			self.corp_status_cd								:= if(trim(input.CorporationStatusDesc,left,right)<>'',
																	trimUpper(input.CorporationStatusID),
																	''
																 );
			self.corp_status_desc						:= trimUpper(input.CorporationStatusDesc);																																			  
			CleanState									:= trimUpper(input.stateOfIncorporation);													  
			self.corp_inc_state							:= if(CleanState = 'GA',															 
																'GA',
																''
															 );													  
			self.corp_forgn_state_cd				    := if(CleanState <> 'GA', 																																														
																CleanState,
																'');	            								
			self.corp_forgn_state_desc					:= if(CleanState <> 'GA',
															    input.forgnState,
																'');
																     																					 			
			self.corp_inc_county						:= if(trimUpper(input.CountyOfIncorporation) <> 'UNKNOWN',
																trimUpper(input.CountyOfIncorporation),
																''
															 );														  
			DateFormed									:= reformatDate(input.DateFormed);			
			self.corp_inc_date							:= if(trimUpper(input.stateOfIncorporation)='GA',
															  if(_validate.date.fIsValid(DateFormed) and
															     _validate.date.fIsValid(DateFormed,_validate.date.rules.DateInPast),
																   DateFormed,
																   ''),
															  ''
															 );															 
			self.corp_forgn_date						:= if(trimUpper(input.stateOfIncorporation)<>'GA',
															  if(_validate.date.fIsValid(DateFormed) and
															     _validate.date.fIsValid(DateFormed,_validate.date.rules.DateInPast),
																   DateFormed,
																   ''),
															  ''
															 );														  
			DurationDate								:= reformatDate2(input.duration);													  
			self.corp_term_exist_cd					:= if (trimUpper(input.duration) = 'PERPETUAL',
															'P',
															if(	_validate.date.fIsValid(DurationDate),
															   'D',
															   '')																
														   );														   
			self.corp_term_exist_desc				:= if (trimUpper(input.duration) = 'PERPETUAL',
															'PERPETUAL',
															if(_validate.date.fIsValid(DurationDate),
																'DATE OF EXPIRATION',
																'')																								
														   );													   
			self.corp_term_exist_exp				:= if(_validate.date.fIsValid(DurationDate),
														  DurationDate,
														  ''
														 );															  
			self.corp_foreign_domestic_ind	:= trimUpper(input.citizenship);							
			self.corp_orig_org_structure_cd	:= if(trim(input.corporationTypeDesc,left,right)<>'',
													trimUpper(input.corporationTypeID),
													''
												 );												 
			self.corp_orig_org_structure_desc	:= trimUpper(input.corporationTypeDesc);	
			
			self.corp_ra_name					:= trimUpper(input.RegAgentName);
																		
			self.corp_ra_address_line1 			:= trimUpper(input.regAgentAddr),

			self.corp_ra_address_line2			:= trimUpper(input.regAgentCity);
														
			self.corp_ra_address_line3			:= trimUpper(input.regAgentState);
														
			self.corp_ra_address_line4			:= trim(StringLib.StringFilterOut(input.regAgentZip,'-'),left,right);						
																											  
			self.corp_ra_address_line5			:= if(trimUpper(input.regAgentCountry) in ['UNITED STATES','USA','GA'], 
														'',
														trimUpper(input.regAgentCountry));
			self.corp_ra_address_line6			:= '';
		
		    self.corp_ra_addl_info				:= if(trimUpper(input.regAgentCounty) <> '',
														'AGENT COUNTY: ' + trimUpper(input.regAgentCounty),
														'');
															
		    self.corp_ra_address_type_desc	:=  if(trim(input.regAgentAddr    +
														input.regAgentCity    +
														input.regAgentState   + 
														input.regAgentZip     + 
														input.regAgentCountry +
														input.regAgentCounty,left,right)<>'',
															'REGISTERED OFFICE',
															'');
															
			self.corp_address1_line1			:= trimUpper(input.address1);
			self.corp_address1_line2			:= trimUpper(input.address2);
			self.corp_address1_line3			:= trimUpper(input.address3);
			self.corp_address1_line4			:= trimUpper(input.city) + ' ' +
			                                       trimUpper(input.state) + ' ' + 
												   trim(StringLib.StringFilterOut(input.zip,'-'),left,right);
			self.corp_address1_line5			:= if(trimUpper(input.country) in 
														['UNITED STATES','USA','GA',
														 'GWINNETT','CHEROKEE','MUSCOGEE',
														 'DEKALB','BEN HILL'], 
														'',
														trimUpper(input.country));
			addrCode							:= trim(input.addressTypeID,left,right);
			self.corp_address1_type_cd			:= case(addrCode,'1'=>'M','7'=>'F',
																 '8'=>'B','24'=>'B','');																 
			self.corp_address1_type_desc		:= case(addrCode,'1'=>'MAILING','6'=>'PREVIOUS MAILING',
																 '7'=>'FILING','8'=>'BUSINESS',
																 '9'=>'PREVIOUS BUSINESS',
																 '11'=>'PREVIOUS REGISTERED OFFICE',
																 '24'=>'BUSINESS','');
														  
			self 								:= [];						
			end; 										
			
			
		corp2_mapping.Layout_ContPreClean contactTransform(FinalOfficerFile input) := transform,skip(trim(input.corpName,left,right)='')

			self.dt_first_seen							:=fileDate;
			self.dt_last_seen							:=fileDate;
			self.corp_key								:= '13-' + trimUpper(input.corporationID);	
			self.corp_vendor							:= '13';
			self.corp_state_origin						:= 'GA';
			self.corp_process_date						:= fileDate;
			self.corp_orig_sos_charter_nbr				:= trimUpper(input.corporationNumber);				
			self.corp_legal_name						:= trimUpper(input.CorpName);
			
			allTitles									:= 	trimUpper(input.Title1) + ';' + 
															trimUpper(input.Title2) + ';' +  
															trimUpper(input.Title3) + ';' + 
															trimUpper(input.Title4) + ';' + 
															trimUpper(input.Title5) + ';' + 
															trimUpper(input.Title6) + ';' + 
															trimUpper(input.Title7) + ';' + 
															trimUpper(input.Title8) + ';' + 
															trimUpper(input.Title9) + ';' + 
															trimUpper(input.Title10);
																		
				
			cleanTitles1								:= regexreplace('[;]*$',allTitles,'');
			cleanTitles2								:= regexreplace('^[;]*',cleanTitles1,'');
			self.cont_title1_desc           			:= regexreplace('[;]+',cleanTitles2,';');  
									  
			self.cont_name								:= trimUpper(input.name);
			
			
												
			
																							
            self.cont_address_line1						:= trimUpper(input.address1);
			
			self.cont_address_line2						:= trimUpper(input.address2);
			
			self.cont_address_line3						:= trimUpper(input.address3);
			
			self.cont_address_line4						:= trimUpper(input.city) + ' ' +
														   trimUpper(input.state) + ' ' + 
														   trim(StringLib.StringFilterOut(input.zip,'-'),left,right);
														   
			cleanedLine5                           	    := if(trimUpper(input.countryName) in 
																['UNITED STATES','USA','GA',
																 'GWINNETT','CHEROKEE','MUSCOGEE',
																 'DEKALB','BEN HILL'], 
														         '',
														         trimUpper(input.countryName));	 
																 
			self.cont_address_line5						:= cleanedLine5;																											
			
			self.cont_address_type_cd					:= if(trim(input.address1,left,right) <> '' or 
															  trim(input.address2,left,right) <> '' or
															  trim(input.address3,left,right) <> '' or
															  trim(input.city,left,right) <> ''     or
													          trim(input.state,left,right) <>''     or 
													          trim(input.zip,left,right) <> ''      or 
													          trim(cleanedLine5,left,right) <> '',
														    	  'T',
															      '');
																										  
		    self.cont_address_type_desc					:= if(trim(input.address1,left,right) <> '' or 
															  trim(input.address2,left,right) <> '' or
															  trim(input.address3,left,right) <> '' or
															  trim(input.city,left,right) <> ''     or
															  trim(input.state,left,right) <>''     or 
															  trim(input.zip,left,right) <> ''      or 
															  trim(cleanedLine5,left,right) <> '',
																'CONTACT',
																'');
													
			self.cont_type_cd							:= 'F';
			self.cont_type_desc							:= 'OFFICER';
			self 										:= [];				
			end;							  
	
		// corp2_mapping.Layout_ContPreClean contactTransform(FinalOfficerFile input) := transform,skip(trim(input.corpName,left,right)='')

			// self.dt_first_seen							:=fileDate;
			// self.dt_last_seen								:=fileDate;

			// self.corp_key										:= '13-' + trimUpper(input.corporationID);	
			// self.corp_vendor								:= '13';
			// self.corp_state_origin					:= 'GA';
			// self.corp_process_date					:= fileDate;
			// self.corp_orig_sos_charter_nbr	:= trimUpper(input.corporationNumber);	
			
			// self.corp_legal_name						:= trimUpper(input.CorpName);
			
			// concatFields										:= 	trimUpper(input.Title1) + ';' + 
																					// trimUpper(input.Title2) + ';' +  
																					// trimUpper(input.Title3) + ';' + 
																					// trimUpper(input.Title4) + ';' + 
																					// trimUpper(input.Title5) + ';' + 
																					// trimUpper(input.Title6) + ';' + 
																					// trimUpper(input.Title7) + ';' + 
																					// trimUpper(input.Title8) + ';' + 
																					// trimUpper(input.Title9) + ';' + 
																					// trimUpper(input.Title10);
																		
				
			// tempExp													:= regexreplace('[;]*$',concatFields,'',NOCASE);
			// tempExp2												:= regexreplace('^[;]*',tempExp,'',NOCASE);
			// self.cont_title1_desc           := regexreplace('[;]+',tempExp2,';',NOCASE);  
									  
			// self.cont_name									:= trimUpper(input.name);
			
			// concatAddrFields								:= if ((string)(integer) input.Address2 <> '0',
																							// if ((string)(integer) input.Address3 <> '0',
																										// trimUpper(input.Address1 + ' ' + input.Address2 + ' ' + input.Address3),
																										// trimUpper(input.Address1 + ' ' + input.Address2)
																									// ),
																							// if ((string)(integer) input.Address3 <> '0',
																										// trimUpper(input.Address1 + ' ' + input.Address3),
																										// trimUpper(input.Address1)
																									// )
																						// );
														
			// self.cont_addl_info							:= if ((string)(integer)input.ownerPercentage <> '0' and
																							// trim(input.ownerPercentage,left,right)<>'',
																									// if((string)(integer)input.TransferRealEstate <> '0' and
																											// trim(input.TransferRealEstate,left,right)<>'',
																												// 'OWNER PERCENTAGE: ' + trim(input.ownerPercentage,left,right) + '; REAL ESTATE TRANSFER: ' + trim(input.TransferRealEstate,left,right),
																												// 'OWNER PERCENTAGE: ' + trim(input.ownerPercentage,left,right)
																											// ),
																									// if((string)(integer)input.TransferRealEstate <> '0' and
																											// trim(input.TransferRealEstate,left,right)<>'',
																												// 'REAL ESTATE TRANSFER: ' + trim(input.TransferRealEstate,left,right),
																												// ''
																										// )
																							// );
												
			// self.cont_address_line1 				:= trimUpper(concatAddrFields),

			// self.cont_address_line2					:= trimUpper(input.City);
														
			// self.cont_address_line3					:= if (trimUpper(input.State) <> 'XX' and not ut.isNumeric(trim(input.state,left,right)),
																								// trimUpper(input.state),
																								// ''
																						// );
														
			// self.cont_address_line4					:= trimUpper(input.Zip);
																											  
			// self.cont_address_line5					:= if (	trimUpper(input.CountryName) <> 'UNITED STATES' and 
																							// trimUpper(input.CountryName) <> 'US' and
																							// trimUpper(input.CountryName) <> 'USA' and
																							// trimUpper(input.CountryName) <> 'ALBANIA',
																								// trimUpper(input.CountryName),
																								// ''
																							// );
			
			// self.cont_address_type_cd				:= if(	trim(concatAddrFields,left,right) <> '' or 
																							// trim(input.city,left,right) <> '' or
																							// trim(input.state,left,right) <>'' or 
																							// trim(input.zip,left,right) <> '' or 
																							// trim(input.CountryName,left,right) <> '',
																								// 'T',
																								// ''
																						// );
													  
		    // self.cont_address_type_desc		:= if(	trim(concatAddrFields,left,right) <> '' or 
																							// trim(input.city,left,right) <> '' or
																							// trim(input.state,left,right) <>'' or 
																							// trim(input.zip,left,right) <> '' or 
																							// trim(input.CountryName,left,right) <> '',
																								// 'CONTACT',
																								// ''
																						// );
													
			// self 														:= [];	
			
		// end;							  
								 
		Corp2.Layout_Corporate_Direct_Stock_In StockTransform(StockWithCorp input):=transform																							
																								
			self.corp_key							:= '13-' + trimUpper(input.corporationID);	
			self.corp_vendor						:= '13';				
			self.corp_state_origin					:= 'GA';
			self.corp_process_date					:= fileDate;

			self.corp_sos_charter_nbr				:= trimUpper(input.corporationNumber);
			
			self.stock_class						:= if(trimUpper(input.StockClassDesc)='NONE',
															'',
															trimUpper(input.StockClassDesc));
			
			self.stock_authorized_nbr				:= if((integer) trim(input.AuthorizedShares,left,right) <> 0, 
															input.AuthorizedShares,
															'');
															
			self.stock_shares_issued				:= if((integer) trim(input.issuedShares,left,right) <> 0, 
															input.issuedShares,
															'');
														 
													
		    self.stock_par_value					:= if((integer) trim(input.ParValue,left,right) <> 0, 
															input.ParValue,
															'');
																							
													   
			self.stock_addl_info					:= if((integer) trim(input.Series,left,right) = 0 or
																         trim(input.Series,left,right) = '',
																		 '',
																		 'STOCK SERIES: ' + trim(input.Series,left,right));
																																																		
			self									:=[];

		end;								 
								 
						
		Corp2.Layout_Corporate_Direct_Event_In EventFilingTransform(FilingWithCorp input):=transform,
								skip(trim(input.DocumentTypeID,left,right) in ['1','66','67','68','69','70','71','72','73','105'])
																																																							
			self.corp_key							:= '13-' + trimUpper(input.corporationID);	
			self.corp_vendor						:= '13';				
			self.corp_state_origin					:= 'GA';
			self.corp_process_date					:= fileDate;
			self.corp_sos_charter_nbr				:= trimUpper(input.corporationNumber);			
			self.event_filing_cd					:= if(trimUpper(input.DocumentTypeIDDesc)<>'',
														    trimUpper(input.DocumentTypeID),
															'');																		
			self.event_filing_desc					:= trimUpper(input.DocumentTypeIDDesc);			
			eventFilingDate							:= reformatDate(input.FilingDate);
			self.event_filing_date					:= if(eventFilingDate <> '' and
														  _validate.date.fIsValid(eventFilingDate) and
														  _validate.date.fIsValid(eventFilingDate,_validate.date.rules.DateInPast),
															 eventFilingDate,
															 '');																												
			self.event_date_type_cd					:= if(eventFilingDate <> '' and
														  _validate.date.fIsValid(eventFilingDate) and
														  _validate.date.fIsValid(eventFilingDate,_validate.date.rules.DateInPast),
															 'FIL',
															 '');																									
			self.event_date_type_desc				:= if(eventFilingDate <> '' and
														  _validate.date.fIsValid(eventFilingDate) and
														  _validate.date.fIsValid(eventFilingDate,_validate.date.rules.DateInPast),
															 'FILING',
															 '');																								
			self									:=[];

		end;
		
		Corp2.Layout_Corporate_Direct_AR_In ARTransform(FilingWithCorp input):=transform,
							skip(trim(input.DocumentTypeID,left,right) not in ['1','66','67','68','69','70','71','72','73','105'])
							
			self.corp_key							:= '13-' + trimUpper(input.corporationID);	
			self.corp_vendor						:= '13';				
			self.corp_state_origin					:= 'GA';
			self.corp_process_date					:= fileDate;
			self.corp_sos_charter_nbr				:= trimUpper(input.corporationNumber);			
			self.ar_comment							:= trimUpper(input.DocumentTypeIDDesc);			
			FilingDate								:= reformatDate(input.FilingDate);
			self.ar_filed_dt						:= if(FilingDate <> '' and
														  _validate.date.fIsValid(FilingDate) and
														  _validate.date.fIsValid(FilingDate,_validate.date.rules.DateInPast),
															  FilingDate,
															  '');																																	
			self									:=[];
		end;
	
		
		Corp2.Layout_Corporate_Direct_Corp_In CleanCorpAddrName(corp2_mapping.Layout_CorpPreClean input) := transform
		
			keepBusiness 					:= ut.IsCompany(input.corp_ra_name);

			ra_name							:=if(input.corp_ra_name <> '' and not keepBusiness, input.corp_ra_name,'');
			Order 							:=if(regexfind(',',ra_name),'L','F');
			c								:=Address.Clean_n_Validate_Name(ra_name,Order);   
            self.corp_ra_title1	    		:= c.title;
			self.corp_ra_fname1 			:= c.fname;
			self.corp_ra_mname1				:= c.mname;
			self.corp_ra_lname1				:= c.lname;
			self.corp_ra_name_suffix1 		:= c.name_suffix;
			self.corp_ra_score1 			:= c.name_score;
		     
		    string73 tempname 				:= if(input.corp_ra_name <> '' and keepBusiness, Address.CleanPerson73(input.corp_ra_name),'');
			pname 							:= Address.CleanNameFields(tempName);
			cname 							:= DataLib.companyclean(input.corp_ra_name);
			
			self.corp_ra_cname1				:=if(keepBusiness,cname[1..70],'');
			self.corp_ra_cname1_score 		:= if( keepBusiness,pname.name_score,'');
			
			string182 clean_address 				:= Address.CleanAddress182(	trim(input.corp_address1_line1,left,right),
																																	trim(	trim(input.corp_address1_line2,left,right) + ', ' +
																																				trim(input.corp_address1_line3,left,right) + ' ' +
																																				trim(input.corp_address1_line4,left,right),
																																				left,right
																																			)
																																);			
			
			string182 clean_ra_address 			:= Address.CleanAddress182(	trim(input.corp_ra_address_line1,left,right), 
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
			self.corp_addr1_addr_suffix  	 	:= clean_address[41..44];
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
			self.corp_addr1_geo_long 	   		:= clean_address[156..166];
			self.corp_addr1_msa 		      	:= clean_address[167..170];
			self.corp_addr1_geo_blk					:= clean_address[171..177];
			self.corp_addr1_geo_match 	  	:= clean_address[178];
			self.corp_addr1_err_stat 	    	:= clean_address[179..182];
			self														:= input;
			self 														:= [];
		end;	
		
		
	
		Corp2.Layout_Corporate_Direct_Cont_In CleanContAddrName(corp2_mapping.Layout_ContPreClean input) := transform		
			string73 tempname 							:= if(input.cont_name = '', '', Address.CleanPerson73(input.cont_name));
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
		
			string182 clean_address 				:= Address.CleanAddress182(	trim(input.cont_address_line1,left,right),
																																	trim(	trim(input.cont_address_line2,left,right) + ', ' +
																																				trim(input.cont_address_line3,left,right) + ' ' +
																																				trim(input.cont_address_line4,left,right),
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
			
		// All Legal Name Types being built with RA addresses
		MapCorp	:= project(joinCorpAddrsRAForgn, corpTransform(left));
		
		// All Legal Name Types being built with Addresses other than RA
		// MapCorpNonRA	:= join(MapCorpLegal, JoinLegalNonRA,
													// trim(left.corp_key,left,right)[4..] = trim(right.CorporationID,left,right),
													// corpLegalNonRATransform(left,right),
													// left outer
													// );

		// All Non-Legal Name Types being built without any Addresses 
		// MapNonLegal		:= project(joinNonLegal, corpNonLegalTransform(left));
		
		// AllCorps			:= distribute((MapCorpLegal + MapCorpNonRA + MapNonLegal)((trim(corp_ln_name_type_cd,left,right) = '1' and trim(corp_address1_type_cd,left,right)<>'') or trim(corp_ln_name_type_cd,left,right) <> '1'), hash32(corp_key));

		// SortCorp 			:= sort(AllCorps,corp_key,LOCAL);
		
		// MapCorp				:= dedup(SortCorp,Record);
			
		MapContacts 	:= project(DedupDenormalized, contactTransform(left));
			
		cleanCorp 		:= project(MapCorp, CleanCorpAddrName(left));			  
		cleanCont 		:= project(MapContacts, CleanContAddrName(left));
		mapStock			:= project(JoinStockWithCorp, stockTransform(left));
		
		mapEvent			:= project(JoinFilingwithCorp, EventFilingTransform(left));
		mapAR					:= project(JoinFilingwithCorp, ARTransform(left));
				
		
		// mapGAFiling 		:= parallel( 
											// output(count(countAddrs)),
											// output(count(countAddrs))
											// output(count(JoinLegalNonRA)),
											// output(count(joinNonLegal))
											// output(joinCorpAddrsRA)
											// output(count(sortGoodAddrs)),
											// output(count(mapCorpLegal)),
											// output(mapCorpLegal,,'~thor_data400::in::corp2::'+version+'::corp_ga',__COMPRESSED__),
											// output(MapContacts,,'~thor_data400::in::corp2::'+version+'::cont_ga',__COMPRESSED__)
											// output(MapAR,,'~thor_data400::in::corp2::'+version+'::ar_ga',__COMPRESSED__),
											// output(MapStock,,'~thor_data400::in::corp2::'+version+'::stock_ga',__COMPRESSED__),
											// output(MapEvent,,'~thor_data400::in::corp2::'+version+'::event_ga',__COMPRESSED__)
											// output(count(MissingNames))
											// output(joinCorpWithName)
											// output(diffRecs),
											// output(allDupeRecs)
															//);	
	VersionControl.macBuildNewLogicalFile('~thor_data400::in::corp2::'+version+'::corp_ga'	,cleanCorp,corp_out	,,,pOverwrite);		
	VersionControl.macBuildNewLogicalFile('~thor_data400::in::corp2::'+version+'::cont_ga'	,cleanCont,cont_out	,,,pOverwrite);
	VersionControl.macBuildNewLogicalFile('~thor_data400::in::corp2::'+version+'::ar_ga'		,MapAR		,ar_out		,,,pOverwrite);
	VersionControl.macBuildNewLogicalFile('~thor_data400::in::corp2::'+version+'::stock_ga'	,MapStock	,stock_out,,,pOverwrite);
	VersionControl.macBuildNewLogicalFile('~thor_data400::in::corp2::'+version+'::event_ga'	,MapEvent	,event_out,,,pOverwrite);
                                                                                                                                                         
		mapGAFiling 		:= 
		parallel(
			 corp_out	
			,cont_out	
			,ar_out		
			,stock_out
			,event_out
		);	

		result := 
		sequential(
			 if(pshouldspray = true,fSprayFiles('ga',filedate,pOverwrite := pOverwrite))
			,mapGAFiling
			,parallel(
				 fileservices.addsuperfile('~thor_data400::in::corp2::sprayed::corp'	,'~thor_data400::in::corp2::'+version+'::corp_ga')
				,fileservices.addsuperfile('~thor_data400::in::corp2::sprayed::cont'	,'~thor_data400::in::corp2::'+version+'::cont_ga')
				,fileservices.addsuperfile('~thor_data400::in::corp2::sprayed::stock','~thor_data400::in::corp2::'+version+'::stock_ga')
				,fileservices.addsuperfile('~thor_data400::in::corp2::sprayed::ar'		,'~thor_data400::in::corp2::'+version+'::ar_ga')
				,fileservices.addsuperfile('~thor_data400::in::corp2::sprayed::event','~thor_data400::in::corp2::'+version+'::event_ga')
			)							
		);
	
		return result;
	end;					 
	
end; // end of GA module