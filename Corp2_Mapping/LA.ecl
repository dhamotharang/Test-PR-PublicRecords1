import Corp2, _validate, Address, _control, versioncontrol, ut; 

export LA := MODULE;
	
	export Layouts_Raw_Input := MODULE;
	
			trimUpper(string s) := function
				return trim(stringlib.StringToUppercase(s),left,right);
				end;

			export varies := record,MAXLENGTH(500)
				string fields;
				end;

			export crpcm := record
				string9   masterID;
				string60  legalName;
				string40  searchName;
				string9   fedTaxID;
				string4   parishCode;
			    string7   internalSystem1;
				string1   activeCode;
				string1   inactiveReason;
				string1   survivorCode;
				string8   dateRegistered;
				string8   effectiveDateRegistered;
				string16  internalSystem2;
				string3   stdAgentCode;
				string1   futureUse1;
				string8   agentResignDate;
				string1   futureUse2;
				string8   officerResignDate;
				string14  internalSystem3;	
				string11  noparShares;	
				string11  totalValueShares;	
				string11  authShares;	
				string7   eachValueShares;	
				string34  internalSystem4;	
				string6   inactiveFilingDate;	
				string6   effectInactDate;	
				string6   internalSystem5;	
				string9   masterIdSurvivingEntity;	
				string18  internalSystem6;	
				string1   goodStandingStatus;	
				string1   entityType;	
				string2   crlf;
				// string6   internalSystem7;	
				end; 
	
			export crpce := record,maxlength(300)			
				string9   masterID;
				string1   extNbr;
				string    extName;			
				end;
				
			export crpca := record
			    string9   masterID;
				string1	  recordType;	
				string2	  sequence;	
				string8	  dateAppointed;	
				string7   sharesIssued;		 
				string5	  titles;
				string2	  internalSystem1;	
				string42  name; 	
				string42  addrsLine2;
				string42  addrsLine3;
				string42  addrsLine4;
				string15  internalSystem2;
				string9   zip9; 
				string2   crlf;
			    end;
				
			export crpcc := record,maxlength(1000)			
				string9   masterID;
				string1   recordType;
				string2   sequence;			
				string    mergerInfo;	
				end;
				
			export crppn := record			
				string9   masterID;
				string8   nameChangeDate;
				string1   nameChangeOrder;			
				string60  prevName;	
				string40  searchName;
				string18  internalSystem1;
				string2   crlf;
				end;		
			
			export crppe := record,maxlength(300)			
				string9   masterID;
				string8   nameChangeDate;
				string1   nameChangeOrder;			
				string1   sequence;	
				string    prevName;
				end;
				
			export crpam := record			
				string9   masterID;
				string8   amndDateFiled;
				string1   internalSystem1;			
				string8   amndCode;	
				string5   amndType;
				string10  internalSystem2;
				string2   crlf;
				end;
				
			export crptsa := record
			    string7   tmMasterID; 
				string1   trNameReg; 
				string1   trMarkReg;
				string1   svcMarkReg;
				string1   activeCode;
				string1   inactiveType;
				string240 ownerName;
				string2   stateCode;
				string30  streetAddrs1; 
				string18  city1;
				string2   state1;
				string5   zip51;
				string4   zip41;
				string4   internalSystem1;
				string300 name; 
				string120 businessDesc;
				string20  classCodes;
				string1   addlClassInd;
				string8   dateFirstUsed;
				string8   dateFirstUsedLA;
				string9   internalSystem2;
				string8   dateRegExpires;
				string8   dateRegistered;
				string1   renewalStatus;
				string6   internalSystem3;
				string60  newOwnerName;
				string30  streetAddrs2;
				string18  city2; 
				string2   state2;
				string5   zip52;
				string4   zip42;
				string8   internalSystem4;
				string40  searchName;
				string9   internalSystem5;
				string2   crlf;
			    end;
				
			export crpta := record			
				string7   tmMasterID;
				string2   internalSystem1;
				string8   amndDateFiled;			
				string1   internalSystem2;	
				string8   amndID;
				string5   amndType;
				string10  internalSystem3; 
				string2   crlf;
				end;
				
			export crprma := record			
				string9   rsrvdMasterID;
				string240 rsrvdName;
				string40  searchName;			
				string42  reserverName;	
				string42  addrsLine2;
				string42  addrsLine3;
				string42  addrsLine4;
				string5   zip5;
				string4   zip4;
				string8   rsrvdExpireDate;
				string1   rsrvdExpireCode;
				string1   internalSystem1;
				string2   rsrvdType;
				string16  internalSystem2;
				string60  salutation;
				string8   rsrvdDate;
				string2   crlf;
				end;				
					
	end; // end of Layouts_Raw_Input module


	
	
	export Files_Raw_Input := MODULE;
	    
		// vendor file definitions
		export crpcmData(string fileDate)  := distribute(DATASET('~thor_data400::in::corp2::'+fileDate+'::crpcm::la',
											Layouts_Raw_Input.crpcm,FLAT),hash32(masterID));
		// export crpce(string fileDate)  := distribute(DATASET('~thor_data400::in::corp2::'+fileDate+'::crpce::la',
											// Layouts_Raw_Input.crpce,FLAT),hash32(trimUpper(masterID));
		export crpceData(string fileDate)  := distribute(DATASET('~thor_data400::in::corp2::'+fileDate+'::crpce::la',
											Layouts_Raw_Input.varies,CSV(SEPARATOR(['^']), 
											TERMINATOR('\r\n'))),hash32(fields[1..9]));
		export crpcaData(string fileDate)  := distribute(DATASET('~thor_data400::in::corp2::'+fileDate+'::crpca::la',
											Layouts_Raw_Input.crpca,FLAT),hash32(masterID));
		export crpccData(string fileDate)  := distribute(DATASET('~thor_data400::in::corp2::'+fileDate+'::crpcc::la',
											Layouts_Raw_Input.varies,CSV(SEPARATOR(['^']), 
											TERMINATOR('\r\n'))),hash32(fields[1..9]));
		export crppnData(string fileDate)  := distribute(DATASET('~thor_data400::in::corp2::'+fileDate+'::crppn::la',
											Layouts_Raw_Input.crppn,FLAT),hash32(masterID));
		export crppeData(string fileDate)  := distribute(DATASET('~thor_data400::in::corp2::'+fileDate+'::crppe::la',
											Layouts_Raw_Input.varies,CSV(SEPARATOR(['^']), 
											TERMINATOR('\r\n'))),hash32(fields[1..9]));
		export crpamData(string fileDate)  := distribute(DATASET('~thor_data400::in::corp2::'+fileDate+'::crpam::la',
											Layouts_Raw_Input.crpam,FLAT),hash32(masterID));
		export crptsaData(string fileDate) := distribute(DATASET('~thor_data400::in::corp2::'+fileDate+'::crptsa::la',
											Layouts_Raw_Input.crptsa,FLAT),hash32(tmMasterID));
		export crptaData(string fileDate)  := distribute(DATASET('~thor_data400::in::corp2::'+fileDate+'::crpta::la',
											Layouts_Raw_Input.crpta,FLAT),hash32(tmMasterID));
		export crprmaData(string fileDate) := distribute(DATASET('~thor_data400::in::corp2::'+fileDate+'::crprma::la',
											Layouts_Raw_Input.crprma,FLAT),hash32(rsrvdMasterID));									 
	end;
	
	export Update(string fileDate, string version, boolean pShouldSpray = _Dataset().bShouldSpray, boolean pOverwrite = false) := function
	
	
		     crpcmFName := record,maxlength(1000)
				string9   masterID := '';
				string60  legalName := '';
				string40  searchName := '';
				string9   fedTaxID := '';
				string4   parishCode := '';
				string1   activeCode := '';
				string1   inactiveReason := '';
				string1   survivorCode := '';
				string8   dateRegistered := '';
				string8   effectiveDateRegistered := '';
				string3   stdAgentCode := '';
				string8   agentResignDate := '';
				string8   officerResignDate := '';	
				string11  noparShares := '';	
				string11  totalValueShares := '';	
				string11  authShares := '';	
				string7   eachValueShares := '';		
				string6   inactiveFilingDate := '';	
				string6   effectInactDate := '';		
				string9   masterIdSurvivingEntity := '';		
				string1   goodStandingStatus := '';	
				string1   entityType := '';
				string    fullName :='';	
				end; 
				
			crpcmFNameAddrs := record,maxlength(1000)
				crpcmFName;				
				string1	  recordType :='';	
				string2	  sequence :='';	
				string8	  dateAppointed :='';	
				string7   sharesIssued :='';		 
				string5	  titles :='';	
				string42  name :=''; 	
				string42  addrsLine2 :='';
				string42  addrsLine3 :='';
				string42  addrsLine4 :='';
				string9   zip9 :=''; 
				end; 
				
			 crpcaFullName := record,maxlength(1000)
				string9   masterID := '';				
				string    fullName :='';
				string1   entityType := '';
				string1	  recordType :='';	
				string2	  sequence :='';	
				string8	  dateAppointed :='';	
				string7   sharesIssued :='';		 
				string5	  titles :='';	
				string42  name :=''; 	
				string42  addrsLine2 :='';
				string42  addrsLine3 :='';
				string42  addrsLine4 :='';
				string9   zip9 :=''; 
				end; 
				
		     crppnFullPName := record,maxlength(1000)			
				string9   masterID;
				string8   nameChangeDate;
				string1   nameChangeOrder;			
				string    fullPName;	
				end;		
			
			 crptsaState := record
			    string7   tmMasterID; 
				string1   trNameReg; 
				string1   trMarkReg;
				string1   svcMarkReg;
				string1   activeCode;
				string1   inactiveType;
				string240 ownerName;
				string2   stateCode;
				string30  streetAddrs1; 
				string18  city1;
				string2   state1;
				string5   zip51;
				string4   zip41;
				string300 name; 
				string120 businessDesc;
				string20  classCodes;
				string1   addlClassInd;
				string8   dateFirstUsed;
				string8   dateFirstUsedLA;
				string8   dateRegExpires;
				string8   dateRegistered;
				string1   renewalStatus;
				string60  newOwnerName;
				string30  streetAddrs2;
				string18  city2; 
				string2   state2;
				string5   zip52;
				string4   zip42;
				string40  searchName;
				string    stateDesc;
			    end;
				
			 normalizedCrptsa := record
				Layouts_Raw_Input.crptsa;
				string  corpName;
				string 	corpStreet;
				string 	corpCity;
				string 	corpState;
				string5 corpZip5;
				string4 corpZip4;
				string1 lnFlag;
				end;
				
		
		
		omitStrings := 'NONE DESIGNATED|' + 
					   'NONE GIVEN|' +
					   'NONE APPOINTED|' +
					   'NONE LISTED|' +
					   'NONE|' +
					   'NO STREET LISTED|' +					   
					   'NO STREET ADDRESS GIVEN|' +
					   'NO STREET ADDRESS LISTED|' +
					   'NO STREET ADDRESS|' +
					   'NO STREET|' +
					   'NO ADDRESS LISTED|' +
					   'NO ADDRESS GIVEN';					
  
		// setForgnStates := ['AL','AK','AS','AZ','AR','CA','CO','CT','DE','DC','FM','FL','GA','GU','HI','ID','IL','IN','IA','KS','KY',
						   // 'LA','ME','MH','MD','MA','MI','MN','MS','MO','MT','NE','NV','NH','NJ','NM','NY','NC','ND','MP','OH','OK',
						   // 'OR','PW','PA','PR','RI','SC','SD','TN','TX','UT','VT','VI','VA','WA','WV','WI','WY','AE','AP','AA','CZ'];
						   
		setIncStates  	 := ['B','C','D','G','H','J','K','N','R','S','W','Y'];
		
		setNonIncStates  := ['A','F','L','M','P','Q','V','X','Z'];
		
		setAllEntities   := setIncStates + setNonIncStates;
		
		setIGS			 := ['D','F','G','K','M','N','Q','R','V','W','X','Z'];
		
		setContCorps	 := ['A','B','C','D','F','H','M','N','P','R','S','W','X','Z'];
		
		setContPS		 := ['J','L','Y'];
		
		setContLLC	 	 := ['G','K','Q','V'];													
	
	
		trimUpper(string s) := function
			return trim(stringlib.StringToUppercase(s),left,right);
			end;
		
		getTMText(string2 code) := function
		   textOut := map(code = '01' => 'CHEMICALS; ',
						  code = '02' => 'PAINTS; ',
						  code = '03' => 'COSMETICS & CLEANING PREPARATIONS; ',
						  code = '04' => 'LUBRICANTS & FUELS; ',
						  code = '05' => 'PHARMACEUTICALS; ',
						  code = '06' => 'METAL GOODS; ',
						  code = '07' => 'MACHINERY; ',
						  code = '08' => 'HAND TOOLS; ',
						  code = '09' => 'ELECTRICAL & SCIENTIFIC APPARATUS; ',
						  code = '10' => 'MEDICAL APPARATUS; ',
						  code = '11' => 'ENVIRONMENTAL CONTROL APPARATUS; ',
						  code = '12' => 'VEHICLES; ',
						  code = '13' => 'FIREARMS; ',
						  code = '14' => 'JEWELRY; ',
						  code = '15' => 'MUSICAL INSTRUMENTS; ',
						  code = '16' => 'PAPER GOODS & PRINTED MATTER; ',
						  code = '17' => 'RUBBER GOODS; ',
						  code = '18' => 'LEATHER GOODS; ',
						  code = '19' => 'NON-METALLIC BUILDING MATERIALS; ',
						  code = '20' => 'FURNITURE & ARTICLES NOT OTHERWISE CLASSIFIED; ',
						  code = '21' => 'HOUSEWARES & GLASS; ',
						  code = '22' => 'CORDAGE & FIBERS; ',
						  code = '23' => 'YARNS & THREADS; ',
						  code = '24' => 'FABRICS; ',
						  code = '25' => 'CLOTHING; ',
						  code = '26' => 'FANCY GOODS; ',
						  code = '27' => 'FLOOR COVERINGS; ',
						  code = '28' => 'TOYS & SPORTING GOODS; ',
						  code = '29' => 'MEATS & PROCESSED FOODS; ',
						  code = '30' => 'STAPLE FOODS; ',
						  code = '31' => 'NATURAL AGRICULTURAL PRODUCTS; ',
						  code = '32' => 'LIGHT BEVERAGES; ',
						  code = '33' => 'WINES & SPIRITS; ',
						  code = '34' => 'SMOKERS\' ARTICLES; ',
						  code = '35' => 'ADVERTISING & BUSINESS IF SERVICE MARK/MISCELLANEOUS IF TRADE MARK; ',
						  code = '36' => 'INSURANCE & FINANCIAL; ',
						  code = '37' => 'CONSTRUCTION & REPAIR; ',
						  code = '38' => 'COMMUNICATION; ',
						  code = '39' => 'TRANSPORTATION & STORAGE; ',
						  code = '40' => 'MATERIAL TREATMENT; ',
						  code = '41' => 'EDUCATION & ENTERTAINMENT; ',
						  code = '42' => 'MISCELLANEOUS; ',
								 '');
			return textOut;
			end;
			
		getContTitle(string1 typeIn, string1 codeIn) := function
		      title := map(typeIn in setContCorps=>			  
							  map(codeIn = '0' => '',  //'NONE SELECTED AT FILING', per JE
								  codeIn = '1' => 'PRESIDENT',
								  codeIn = '2' => 'EXECUTIVE VICE-PRESIDENT',
								  codeIn = '3' => 'VICE-PRESIDENT',
								  codeIn = '4' => 'SECRETARY',
								  codeIn = '5' => 'TREASURER',
								  codeIn = '6' => 'SECRETARY/TREASURER',
								  codeIn = '7' => 'COMPTROLLER',
								  codeIn = '8' => 'DIRECTOR',
								  codeIn = '9' => 'TRUSTEE',
								  codeIn = 'A' => 'OFFICER',
											 ''),
						   typeIn in setContPS=>			  
							  map(codeIn = '1' => 'GENERAL PARTNER',
								  codeIn = '2' => 'LIMITED PARTNER',
								  codeIn = '3' => 'PARTNER',
											 ''),
						   typeIn in setContLLC=>			  
							  map(codeIn = '0' => '',  //'NONE SELECTED AT FILING', per JE
								  codeIn = '1' => 'MANAGER',
								  codeIn = '2' => 'MEMBER',
								  codeIn = '3' => '',  //'NO TITLE SPECIFIED' per JE
											 ''),
							'');
			return trim(title,left,right);
			end;
			
		StateCodeLayout := record
			string Code;
			string Desc;			
			end;									  
		  
		StateCodeTable := dataset(_dataset().foreign_prod + 'thor_data400::lookup::corp2::statecodetable',StateCodeLayout,CSV(SEPARATOR(','), TERMINATOR('\r\n')));
		
//---------------------  Corps File Mapping for Regular Corporation Records  --------------------//			

		Corp2_mapping.Layout_CorpPreClean corpTransform01(crpcmFNameAddrs input) := transform
		
		    entity := trimUpper(input.entityType);
			
			self.dt_first_seen					:= fileDate;
			self.dt_last_seen					:= fileDate;
			self.dt_vendor_first_reported		:= fileDate;
			self.dt_vendor_last_reported		:= fileDate;
			self.corp_ra_dt_first_seen			:= fileDate;
			self.corp_ra_dt_last_seen			:= fileDate;			
			self.corp_key						:= '22-' + trimUpper(input.masterID);
			self.corp_vendor					:= '22';
			self.corp_state_origin				:= 'LA';
			self.corp_process_date				:= fileDate;
			self.corp_orig_sos_charter_nbr		:= trimUpper(input.masterID);
			self.corp_src_type					:= 'SOS';						
			self.corp_legal_name				:= trimUpper(input.fullName); 														
			self.corp_ln_name_type_cd			:= '01';													   
			self.corp_ln_name_type_desc			:= 'LEGAL';																																						  
			self.corp_inc_state					:= if(entity in setIncStates,
			                                          'LA',
													  '');																									   					
			isRAAddrs								:= if((trimUpper(input.recordType) = 'A') or
			                                              (trimUpper(input.recordType) = 'F' and input.sequence='02'),
														  TRUE,FALSE);
														  
			isBusAddrs								:= if((trimUpper(input.recordType) = 'D' and input.sequence='01') or 
														  (trimUpper(input.recordType) = 'F' and input.sequence in ['01','03']),
														  TRUE,FALSE);
														  
			isMailAddrs								:= if(trimUpper(input.recordType) = 'C',
														  TRUE,FALSE);										
													  
			temp_csz								:= if(trimUpper(input.addrsLine4) <> '',
														trimUpper(input.addrsLine4),
														trimUpper(input.addrsLine3));
														
			temp_street2							:= if(trimUpper(input.addrsLine4) <> '',
														trimUpper(input.addrsLine3),
														trimUpper(input.addrsLine2));
														
			temp_street1							:= if(trimUpper(input.addrsLine4) <> '',
														trimUpper(input.addrsLine2),
														'');
													
			csz										:= regexreplace(omitStrings,trimUpper(temp_csz),'');
			
			street2									:= regexreplace(omitStrings,trimUpper(temp_street2),'');
			
			street1									:= regexreplace(omitStrings,trimUpper(temp_street1),'');
			
			self.corp_address1_line1			:= if(isBusAddrs or isMailAddrs,
														trimUpper(input.name),
														'');
						
			// self.corp_address1_line2			:= if(isBusAddrs or isMailAddrs,
														// street1,
														// '');
														
            self.corp_address1_line2			:= if(isBusAddrs or isMailAddrs,
													  map(trim(street1,left,right)<>''=>street1,
													      trim(street2,left,right)<>''=>street2,
														  ''),
													  '');	
													  
			self.corp_address1_line3			:= if(isBusAddrs or isMailAddrs,
													  map(trim(street1,left,right)<>''=>street2,
														  ''),
													  '');
														
			// self.corp_address1_line3			:= if(isBusAddrs or isMailAddrs,
														// street2,
														// '');
														
			self.corp_address1_line4			:= if(isBusAddrs or isMailAddrs,
														csz,
														'');
														
			self.corp_address1_line5			:= '';
			
			self.corp_address1_line6			:= '';
									
			self.corp_address1_type_cd			:= if(isBusAddrs,
														'B',
														if(isMailAddrs,
															'M',
															''));
															
		    self.corp_address1_type_desc		:= if(isBusAddrs,
														'BUSINESS',
														if(isMailAddrs,
															'MAILING',
															''));						
			
			self.corp_ra_name					:= if(isRAAddrs,
														trimUpper(input.name),
														'');
														
			newDateAppointed					:= if(isRAAddrs,
													if(stringlib.stringfilter(input.dateAppointed,'0123456789') != input.dateAppointed or 
														length(trim(input.dateAppointed,left,right))!= 8 or
														(integer) stringlib.stringfilter(input.dateAppointed,'0123456789') = 0,
														'',			
														input.dateAppointed[5..8] + 
														input.dateAppointed[1..4]),
												     '');
													 
			self.corp_ra_effective_date			:= if(isRAAddrs,
													if(_validate.date.fIsValid(newDateAppointed) and 
													  _validate.date.fIsValid(newDateAppointed,_validate.date.rules.DateInPast),
														newDateAppointed,
														''),
													 '');
													
												   
			self.corp_ra_address_line1			:= '';
														
			self.corp_ra_address_line2			:= if(isRAAddrs,
														street1,
														'');
														
			self.corp_ra_address_line3			:= if(isRAAddrs,
														street2,
														'');
														
			self.corp_ra_address_line4			:= if(isRAAddrs,
														csz,
														'');
			self.corp_ra_address_line5			:= '';
			
			self.corp_ra_address_line6			:= '';
			
			self.corp_ra_address_type_cd		:= if(isRAAddrs,
														'A',
														'');
														
			self.corp_ra_address_type_desc		:= if(isRAAddrs,
														'REGISTERED AGENT',
														'');
													  
			self.corp_fed_tax_id				:= if((integer) trimUpper(input.fedTaxID)<>0,
													  trimUpper(input.fedTaxID),
													  '');
													  													
			self.corp_orig_org_structure_cd     := if(entity in setAllEntities,
			                                          entity,
													  '');
													  
			self.corp_orig_org_structure_desc   := if(entity in setAllEntities,														
													  map(entity = 'A' => 'NON-LOUISIANA APPOINTMENT OF AGENT',
														  entity = 'B' => 'LOUISIANA BANK ASSOCIATION',
														  entity = 'C' => 'LOUISIANA CO-OP',
														  entity = 'D' => 'LOUISIANA BUSINESS CORPORATION',
													      entity = 'F' => 'NON-LOUISIANA BUSINESS CORPORATION (FOREIGN)',
													      entity = 'G' => 'LOUISIANA NON-PROFIT LIMITED LIABILITY COMPANY',
														  entity = 'H' => 'LOUISIANA HOMESTEAD',
														  entity = 'J' => 'LOUISIANA PARTNERSHIP',
													      entity = 'K' => 'LOUISIANA LIMITED LIABILITY COMPANY',
														  entity = 'L' => 'NON-LOUISIANA PARTNERSHIP (FOREIGN)',
														  entity = 'M' => 'NON-LOUISIANA LIMITED QUALIFICATION OF CORPORATION (FOREIGN)',
														  entity = 'N' => 'LOUISIANA NON-PROFIT CORPORATION',
														  entity = 'P' => 'NON-LOUISIANA REAL ESTATE BROKER (FOREIGN)',
														  entity = 'Q' => 'NON-LOUISIANA LIMITED LIABILITY COMPANY (FOREIGN)',
														  entity = 'R' => 'LOUISIANA REAL ESTATE INVESTMENT TRUST',
														  entity = 'S' => 'LOUISIANA SAVINGS AND LOAN ASSOCIATION',
														  entity = 'V' => 'NON-LOUISIANA NON-PROFIT LIMITED LIABILITY COMPANY (FOREIGN)',
														  entity = 'W' => 'LOUISIANA CHURCH',
														  entity = 'X' => 'NON-LOUISIANA NON-PROFIT CORPORATION & CO-OP (FOREIGN)',
														  entity = 'Y' => 'LOUISIANA REGISTERED LIMITED LIABILITY PARTNERSHIP',
														  entity = 'Z' => 'NON-LOUISIANA REAL ESTATE INVESTMENT TRUST (FOREIGN)',
														  ''),
													  '');
													  
			self.corp_standing					:= if(entity in setIGS and 
													  trimUpper(input.goodStandingStatus) in ['Y','N'],
													  trimUpper(input.goodStandingStatus),
													  '');
													  
			self.corp_status_cd					:= if(trimUpper(input.activeCode) in ['A','I','P'],
													  trimUpper(input.activeCode),
													  '');
													  
			self.corp_status_desc				:= if(trimUpper(input.activeCode) in ['A','I','P'],
													  map(trimUpper(input.activeCode) = 'A' => 
														  'CURRENTLY ACTIVE IN SECRETARY OF STATE RECORDS',	
														  trimUpper(input.activeCode) = 'I' => 
														  'CURRENTLY INACTIVE IN SECRETARY OF STATE RECORDS',
														  trimUpper(input.activeCode) = 'P' => 
														  'NON-LOUISIANA CORPORATION HAS A PENDING WITHDRAWAL',
														  ''),
													  '');
			self.corp_status_date 			:= if(stringlib.stringfilter(input.inactiveFilingDate,'0123456789') != input.inactiveFilingDate or 
														length(trim(input.inactiveFilingDate,left,right))!= 6 or
														(integer) stringlib.stringfilter(input.inactiveFilingDate,'0123456789') = 0,
														'',	
														(string)ut.Date_MMDDYY_I2(input.inactiveFilingDate)); 
																												
			fmtEffectInactDate       			 := if(stringlib.stringfilter(input.effectInactDate,'0123456789') != input.effectInactDate or 
														length(trim(input.effectInactDate,left,right))!= 6 or
														(integer) stringlib.stringfilter(input.effectInactDate,'0123456789') = 0,
														'',			
														input.effectInactDate[1..2] + '/' + 
														input.effectInactDate[3..4] + '/' +
														input.effectInactDate[5..6]);
														
			reason								  := trimUpper(input.inactiveReason);
			
			reasonDesc					          := map(reason = 'A' => 'LETTER OF NON-PAYMENT OF TAXES RECEIVED FROM DEPARTMENT OF REVENUE',
														 reason = 'C' => 'CONSOLIDATED AND FORMED A NEW CORPORATION',		
													     reason = 'D' => 'DISSOLVED',
														 reason = 'E' => 'EXISTENCE CEASED',
														 reason = 'L' => 'CANCELLED CHARTER',
														 reason = 'M' => 'MERGED INTO ANOTHER ENTITY',
														 reason = 'N' => 'NOTICE OF INTENT TO DISSOLVE',
														 reason = 'R' => 'CHARTER REVOKED BY SECRETARY OF STATE',
														 reason = 'S' => 'CHARTER SUSPENDED BY SECRETARY OF STATE',
														 reason = 'T' => 'CHARTER OR REGISTRY TERMINATED',
														 reason = 'V' => 'VOID CHARTER',
														 reason = 'W' => 'NON-LOUISIANA CORPORATION WITHDREW FROM DOING BUSINESS',
														 '');
														 
			self.corp_status_comment				:= map(reasonDesc <> '' and fmtEffectInactDate <> '' =>
																		trimUpper(reasonDesc) + '. EFFECTIVE ' + fmtEffectInactDate,
														   fmtEffectInactDate <> '' => 'EFFECTIVE ' + fmtEffectInactDate,
														   reasonDesc <> '' => reasonDesc,														   
														   '');	
														   
			regDate1								:= if(stringlib.stringfilter(input.dateRegistered,'0123456789') != input.dateRegistered or 
														length(trim(input.dateRegistered,left,right))!= 8 or
														(integer) stringlib.stringfilter(input.dateRegistered,'0123456789') = 0,
														'',			
														input.dateRegistered);
														
			regDate2								:= if(_validate.date.fIsValid(regDate1) and 
														  _validate.date.fIsValid(regDate1,_validate.date.rules.DateInPast),
														     regDate1,
														 '');
														
			self.corp_filing_date					:= regDate2;
			
			self.corp_filing_desc					:= if(regDate2 <> '',
															'REGISTERED',
															'');
            self.corp_filing_cd						:= if(regDate2 <> '',
															'R',
															'');																	
															
			addl_info1								:= if(trimUpper(input.survivorCode) = 'X',
														'ENTITY SURVIVED MERGER. ',
														'');
														
			addl_info2	    						:= if(trimUpper(input.masterIdSurvivingEntity) <> '',
													   'SURVIVING ENTITY: ' + 
													    trimUpper(input.masterIdSurvivingEntity) + '. ',
														'');
														
			agntResignDate1								:= if(stringlib.stringfilter(input.agentResignDate,'0123456789') != input.agentResignDate or 
														length(trim(input.agentResignDate,left,right))!= 8 or
														(integer) stringlib.stringfilter(input.agentResignDate,'0123456789') = 0,
														'',			
														input.agentResignDate);
														
			agntResignDate2							:= if(_validate.date.fIsValid(agntResignDate1) and 
														  _validate.date.fIsValid(agntResignDate1,_validate.date.rules.DateInPast),
															agntResignDate1,
															'');
															
			addl_info3	    						:= if(agntResignDate2 <> '',
															'LAST AGENT RESIGNED: ' + 
															agntResignDate2[5..6] + '/' +
															agntResignDate2[7..8] + '/' +
															agntResignDate2[1..4] + '. ',
														'');
															
			ofcrResignDate1							:= if(stringlib.stringfilter(input.officerResignDate,'0123456789') != input.officerResignDate or 
														length(trim(input.officerResignDate,left,right))!= 8 or
														(integer) stringlib.stringfilter(input.officerResignDate,'0123456789') = 0,
														'',			
														input.officerResignDate);
														
			ofcrResignDate2							:= if(_validate.date.fIsValid(ofcrResignDate1) and 
													      _validate.date.fIsValid(ofcrResignDate1,_validate.date.rules.DateInPast),
															ofcrResignDate1,
															'');
															
			addl_info4	    						:= if(ofcrResignDate2 <> '',
															'LAST OFFICER/DIRECTOR RESIGNED: ' + 
															agntResignDate2[5..6] + '/' +
															agntResignDate2[7..8] + '/' +
															agntResignDate2[1..4] + '. ',
														'');
														
			self.corp_addl_info						:= addl_info1 + addl_info2 +
													   addl_info3 + addl_info4;	
			
			self := [];						
			end; 
		
//---------------------  Corps File Mapping for Previous Name Corporation Records  --------------------//			

	Corp2.Layout_Corporate_Direct_Corp_In corpTransform02(crppnFullPName input) := transform
	
			self.dt_first_seen					:= fileDate;
			self.dt_last_seen					:= fileDate;
			self.dt_vendor_first_reported		:= fileDate;
			self.dt_vendor_last_reported		:= fileDate;
			self.corp_ra_dt_first_seen			:= fileDate;
			self.corp_ra_dt_last_seen			:= fileDate;			
			self.corp_key						:= '22-' + trimUpper(input.masterID);
			self.corp_vendor					:= '22';
			self.corp_state_origin				:= 'LA';
			self.corp_process_date				:= fileDate;
			self.corp_orig_sos_charter_nbr		:= trimUpper(input.masterID);
			self.corp_src_type					:= 'SOS';						
			self.corp_legal_name				:= trimUpper(input.fullPName); 
			self.corp_ln_name_type_desc			:= 'PREVIOUS NAME';
			self.corp_name_comment  			:= 'DATE NAME CHANGED: ' +
													input.nameChangeDate[5..6] + '/' +
													input.nameChangeDate[7..8] + '/' +
													input.nameChangeDate[1..4];																					
			self := [];						
			end; 
			
//---------------------  Corps File Mapping for Trademark Records  --------------------//						
			
	Corp2.Layout_Corporate_Direct_Corp_In corpTransform03(crptsaState input) := transform		
			
			self.dt_first_seen					:= fileDate;
			self.dt_last_seen					:= fileDate;
			self.dt_vendor_first_reported		:= fileDate;
			self.dt_vendor_last_reported		:= fileDate;
			self.corp_ra_dt_first_seen			:= fileDate;
			self.corp_ra_dt_last_seen			:= fileDate;			
			self.corp_key						:= '22-' + trimUpper(input.tmMasterID);
			self.corp_vendor					:= '22';
			self.corp_state_origin				:= 'LA';
			self.corp_process_date				:= fileDate;
			self.corp_orig_sos_charter_nbr		:= trimUpper(input.tmMasterID);
			self.corp_src_type					:= 'SOS';	
			
			tmText								:= if(trimUpper(input.trNameReg) = 'Y',
														'TRADEMARK; ',
														'');
			tnText								:= if(trimUpper(input.trNameReg) = 'Y',
														'TRADE NAME; ',
														'');
			smText								:= if(trimUpper(input.trNameReg) = 'Y',
														'SERVICE MARK',
														'');
			allLNText								:= tmText + tnText + smText;
			
			lnCode1								:= if(trimUpper(input.trNameReg) = 'Y',
														'03; ',
														'');
			lnCode2								:= if(trimUpper(input.trNameReg) = 'Y',
														'04; ',
														'');
			lnCode3								:= if(trimUpper(input.trNameReg) = 'Y',
														'05',
														'');
														
			allLnCodes                  		:= lnCode1 + lnCode2 + lnCode3;
						
			self.corp_legal_name				:= trimUpper(input.name); 														
			self.corp_ln_name_type_cd			:= regexreplace(';$',trim(allLnCodes,left,right),'');													   
			self.corp_ln_name_type_desc			:= regexreplace(';$',trim(allLNText,left,right),'');
			self.corp_orig_org_structure_desc	:= regexreplace(';$',trim(allLNText,left,right),'');
			self.corp_inc_state					:= if(trimUpper(input.stateCode) = 'LA',
			                                          'LA',
													  '');
			self.corp_forgn_state_cd     		:= if(trimUpper(input.stateCode) <> 'LA',
													  trimUpper(input.stateCode),
													  '');
			self.corp_forgn_state_desc     		:= if(trimUpper(input.stateCode) <> 'LA',
													  if(trimUpper(input.stateDesc) <> '',
													     trimUpper(input.stateDesc),
														 trimUpper(input.stateCode)),
													   '');						   																					
													  
			self.corp_status_cd					:= if(trimUpper(input.activeCode) in ['A','I'],
													  trimUpper(input.activeCode),
													  '');
													  
			self.corp_status_desc				:= if(trimUpper(input.activeCode) in ['A','I'],
													  map(trimUpper(input.activeCode) = 'A' => 
														  'ACTIVE',	
														  trimUpper(input.activeCode) = 'I' => 
														  'INACTIVE',														  
														  ''),
													  '');																				
														
			inactReason							  := if(trimUpper(input.activeCode) = 'I',
								                        map(trimUpper(input.inactiveType) = 'E' =>
																'EXPIRED REGISTRATION',
															trimUpper(input.inactiveType) = 'C' =>
																'CANCELLED REGISTRATION',
															''),
														'');
			
			renewStatus							  := if(trimUpper(input.renewalStatus) <> '',
														map(trimUpper(input.renewalStatus) ='A' =>
																'RENEWAL LETTER RETURNED DUE TO INSUFFICIENT ADDRESS.',
															trimUpper(input.renewalStatus) ='B' =>
																'OUT OF BUSINESS.',
															''),
														'');
																
			renewSeparator                        := if(inactReason <> '' and renewStatus <> '',
														'. ',
														'');																	
														 
			self.corp_status_comment				:= inactReason + renewSeparator + renewStatus;	
														   
			regDate1								:= if(stringlib.stringfilter(input.dateRegistered,'0123456789') != input.dateRegistered or 
														length(trim(input.dateRegistered,left,right))!= 8 or
														(integer) stringlib.stringfilter(input.dateRegistered,'0123456789') = 0,
														'',			
														input.dateRegistered);
														
			regDate2								:= if(_validate.date.fIsValid(regDate1) and 
													      _validate.date.fIsValid(regDate1,_validate.date.rules.DateInPast),
														    regDate1,
														    '');
														
			self.corp_filing_date					:= regDate2;
			
			self.corp_filing_desc					:= if(regDate2 <> '',
															'REGISTERED',
															'');
			self.corp_filing_cd	   					:= if(regDate2 <> '',
															'R',
															'');
			
			self.corp_term_exist_cd				:= if( _validate.date.fIsValid(input.dateRegExpires),
													 'D',
													 '');																													   													 
			self.corp_term_exist_exp			:= if(_validate.date.fIsValid(input.dateRegExpires),													   
														input.dateRegExpires,
														''
													  );
			self.corp_term_exist_desc			:= if( _validate.date.fIsValid(input.dateRegExpires),
													 'DATE OF EXPIRATION',
													 '');
			self.corp_entity_desc				    := trimUpper(input.businessDesc);
			
			classCode1							:= input.classCodes[1..2];
			classCode2							:= input.classCodes[3..4];
			classCode3							:= input.classCodes[5..6];
			classCode4							:= input.classCodes[7..8];
			classCode5							:= input.classCodes[9..10];
			classCode6							:= input.classCodes[11..12];
			classCode7							:= input.classCodes[13..14];
			classCode8							:= input.classCodes[15..16];
			classCode9							:= input.classCodes[17..18];
			classCode10							:= input.classCodes[19..20];
			
			usedCode1							:= if((integer) classCode1 between 1 and 42,
												   classCode1 + '; ',
												   '');
			usedCode2							:= if((integer) classCode2 between 1 and 42,
												   classCode2 + '; ',
												   '');
			usedCode3							:= if((integer) classCode3 between 1 and 42,
												   classCode3 + '; ',
												   '');
			usedCode4							:= if((integer) classCode4 between 1 and 42,
												   classCode4 + '; ',
												   '');
			usedCode5							:= if((integer) classCode5 between 1 and 42,
												   classCode5 + '; ',
												   '');
			usedCode6							:= if((integer) classCode6 between 1 and 42,
												   classCode6 + '; ',
												   '');
			usedCode7							:= if((integer) classCode7 between 1 and 42,
												   classCode7 + '; ',
												   '');
			usedCode8							:= if((integer) classCode8 between 1 and 42,
												   classCode8 + '; ',
												   '');
			usedCode9							:= if((integer) classCode9 between 1 and 42,
												   classCode9 + '; ',
												   '');
			usedCode10							:= if((integer) classCode10 between 1 and 42,
												   classCode10 + '; ',
												   '');
												   
			allCodes							:= usedCode1 + usedCode2 + usedCode3 +							   
												   usedCode4 + usedCode5 + usedCode6 +
												   usedCode7 + usedCode8 + usedCode9 +
												   usedCode10;
												   
			classText1                          := getTMText(classCode1);
			classText2                          := getTMText(classCode2);
			classText3                          := getTMText(classCode3);
			classText4                          := getTMText(classCode4);
			classText5                          := getTMText(classCode5);
			classText6                          := getTMText(classCode6);
			classText7                          := getTMText(classCode7);
			classText8                          := getTMText(classCode8);
			classText9                          := getTMText(classCode9);
			classText10                         := getTMText(classCode10);
			
			allText								:= classText1 + classText2 + classText3 +
												   classText4 + classText5 + classText6 +	
												   classText7 + classText8 + classText9 +
												   classText10;
												   
			self.corp_orig_bus_type_cd			:= regexreplace(';$',trim(allCodes,left,right),''); 
												   
			self.corp_orig_bus_type_desc	 	:= regexreplace(';$',trim(allText,left,right),''); 						
														
			self.corp_addl_info					:= if(trimUpper(input.addlClassInd)='Y',
													  'ADDITIONAL CLASSES REGISTERED',	
													  '');
			
			self := [];						
		end; 

//---------------------  Corps File Mapping for Name Reservation Records  --------------------//						
		
	Corp2.Layout_Corporate_Direct_Corp_In corpTransform04(Layouts_Raw_Input.crprma input) := transform
			
			self.dt_first_seen					:= fileDate;
			self.dt_last_seen					:= fileDate;
			self.dt_vendor_first_reported		:= fileDate;
			self.dt_vendor_last_reported		:= fileDate;
			self.corp_ra_dt_first_seen			:= fileDate;
			self.corp_ra_dt_last_seen			:= fileDate;			
			self.corp_key						:= '22-' + trimUpper(input.rsrvdMasterID);
			self.corp_vendor					:= '22';
			self.corp_state_origin				:= 'LA';
			self.corp_process_date				:= fileDate;
			self.corp_orig_sos_charter_nbr		:= trimUpper(input.rsrvdMasterID);
			self.corp_src_type					:= 'SOS';							
						
			self.corp_legal_name				:= trimUpper(input.rsrvdName); 														
			self.corp_ln_name_type_cd			:= '07';													   
			self.corp_ln_name_type_desc			:= 'RESERVED';
			self.corp_name_comment				:= map(trimUpper(input.rsrvdType)='CN' =>
															'CORPORATION NAME',
													   trimUpper(input.rsrvdType)='LL' =>
															'LIMITED LIABILITY COMPANY',
													   trimUpper(input.rsrvdType)='TM' =>
															'TRADEMARK',
													   trimUpper(input.rsrvdType)='SM' =>
															'SERVICE MARK',
													   trimUpper(input.rsrvdType)='TN' =>
															'TRADE NAME',
													   '');			
														   
			rsrvdDate1								:= if(stringlib.stringfilter(input.rsrvdDate,'0123456789') != input.rsrvdDate or 
														length(trim(input.rsrvdDate,left,right))!= 8 or
														(integer) stringlib.stringfilter(input.rsrvdDate,'0123456789') = 0,
														'',			
														input.rsrvdDate[5..8] +
														input.rsrvdDate[1..4]);
														
			rsrvdDate2								:= if(_validate.date.fIsValid(rsrvdDate1) and 
													      _validate.date.fIsValid(rsrvdDate1,_validate.date.rules.DateInPast),
														     rsrvdDate1,
														     '');
														
			self.corp_filing_date					:= rsrvdDate2;
			
			self.corp_filing_desc					:= if(rsrvdDate2 <> '',
															'RESERVED',
															'');
															
			expireDate							:= if(stringlib.stringfilter(input.rsrvdExpireDate,'0123456789') != input.rsrvdExpireDate or 
														length(trim(input.rsrvdExpireDate,left,right))!= 8 or
														(integer) stringlib.stringfilter(input.rsrvdExpireDate,'0123456789') = 0,
														'',			
														input.rsrvdExpireDate[5..8] +
														input.rsrvdExpireDate[1..4]);
														
			self.corp_term_exist_cd				:= if( _validate.date.fIsValid(expireDate),
													 'D',
													 '');																													   													 
			self.corp_term_exist_exp			:= if(_validate.date.fIsValid(expireDate),													   
														expireDate,
														''
													  );
			self.corp_term_exist_desc			:= if( _validate.date.fIsValid(expireDate),
													 'DATE OF EXPIRATION',
													 '');													 			
			
			self := [];						
		end; 
		
//---------------------  Corps File Mapping for Trademark Records  --------------------//								
		
	Corp2_mapping.Layout_CorpPreClean corpTransform05(normalizedCrptsa input) := transform
	
			self.dt_first_seen					:= fileDate;
			self.dt_last_seen					:= fileDate;
			self.dt_vendor_first_reported		:= fileDate;
			self.dt_vendor_last_reported		:= fileDate;
			self.corp_ra_dt_first_seen			:= fileDate;
			self.corp_ra_dt_last_seen			:= fileDate;			
			self.corp_key						:= '22-' + trimUpper(input.tmMasterID);
			self.corp_vendor					:= '22';
			self.corp_state_origin				:= 'LA';
			self.corp_process_date				:= fileDate;
			self.corp_orig_sos_charter_nbr		:= trimUpper(input.tmMasterID);
			self.corp_src_type					:= 'SOS';
			
			self.corp_legal_name				:= trimUpper(input.corpName);									  
		
			self.corp_ln_name_type_cd			:= input.lnFlag;
		
			self.corp_ln_name_type_desc			:= if(input.lnFlag = 'L',
														'LEGAL',
														'PRIOR');
																			
			self.corp_address1_line1				:= '';
														
			self.corp_address1_line2				:= trimUpper(input.corpStreet);
														
			self.corp_address1_line3				:= trimUpper(input.corpCity);
													
			self.corp_address1_line4				:= trimUpper(input.corpState);
		
			cleanZip                            := if((integer)input.corpZip4 = 0,
													  input.corpZip5,
													  input.corpZip5 + input.corpZip4);
														
			self.corp_address1_line5				:= cleanZip;
			
			self.corp_address1_line6				:= '';																											
																										  
		    self.corp_address1_type_cd			:= if(trimUpper(input.corpStreet + input.corpCity +
													  input.corpState + cleanZip) <> '', 														
													  'B',
													  '');
													  
		    self.corp_address1_type_desc		:= if(trimUpper(input.corpStreet + input.corpCity +
													  input.corpState + cleanZip) <> '', 														
													  'BUSINESS',
													  '');																									  			
													  
			self := [];	
			
		end;		
		
		
//---------------------  Conts File Mapping for Name Reservation Records  --------------------//								
		
	corp2_mapping.Layout_ContPreClean contTransform01(Layouts_Raw_Input.crprma input) := transform
	
			self.dt_first_seen					:=fileDate;
			self.dt_last_seen					:=fileDate;
			self.corp_key						:= '22-' + trimUpper(input.rsrvdMasterID);
			self.corp_vendor					:= '22';
			self.corp_state_origin				:= 'LA';
			self.corp_process_date				:= fileDate;
			self.corp_orig_sos_charter_nbr		:= trimUpper(input.rsrvdMasterID);
			
			self.corp_legal_name				:= trimUpper(input.rsrvdName);
									  
			self.cont_name						:= trimUpper(input.reserverName);
		
			self.cont_type_cd					:= '01';
		
			self.cont_type_desc					:= 'RESERVER';
			
			csz									:= if(trimUpper(input.addrsLine4) <> '',
														trimUpper(input.addrsLine4),
														trimUpper(input.addrsLine3));
														
			street2								:= if(trimUpper(input.addrsLine4) <> '',
														trimUpper(input.addrsLine3),
														trimUpper(input.addrsLine2));
													
			street1								:= if(trimUpper(input.addrsLine4) <> '',
														trimUpper(input.addrsLine2),
														'');
																			
			self.cont_address_line1			:= '';
														
			self.cont_address_line2			:= street1;
														
			self.cont_address_line3			:= street2;																												
													
			self.cont_address_line4			:= csz;																												
														
			self.cont_address_line5			:= '';
			
			self.cont_address_line6			:= '';																											
																										  
		    self.cont_address_type_cd			:= if(street1 + street2 + csz <> '', 														
													  'T',
													  '');
													  
		    self.cont_address_type_desc			:= if(street1 + street2 + csz <> '', 														
													  'CONTACT',
													  '');																										  			
													  
			self := [];	
			
		end;
		
//---------------------  Conts File Mapping for Corporation Records  --------------------//								
		
	corp2_mapping.Layout_ContPreClean contTransform02(crpcaFullName input) := transform
	
			entity := trimUpper(input.entityType);
	 
			self.dt_first_seen					:=fileDate;
			self.dt_last_seen					:=fileDate;
			self.corp_key						:= '22-' + trimUpper(input.masterID);
			self.corp_vendor					:= '22';
			self.corp_state_origin				:= 'LA';
			self.corp_process_date				:= fileDate;
			self.corp_orig_sos_charter_nbr		:= trimUpper(input.masterID);
			
			self.corp_legal_name				:= trimUpper(input.fullName);
									  
			self.cont_name						:= trimUpper(input.name);
		
			newDateAppointed					:= if(stringlib.stringfilter(input.dateAppointed,'0123456789') != input.dateAppointed or 
														length(trim(input.dateAppointed,left,right))!= 6 or
														(integer) stringlib.stringfilter(input.dateAppointed,'0123456789') = 0,
														'',	
														input.dateAppointed[5..8] + 
														input.dateAppointed[1..4]);
														
			self.cont_effective_date			:= if(_validate.date.fIsValid(newDateAppointed) and 
													  _validate.date.fIsValid(newDateAppointed,_validate.date.rules.DateInPast),
														newDateAppointed,
														'');
															
			self.cont_type_cd					:= map(trimUpper(input.recordType) = 'I' => 
															'I',
													   trimUpper(input.recordType) = 'O' => 
															'F',
													   '');
		
			self.cont_type_desc					:= map(trimUpper(input.recordType) = 'I' => 
															'INCORPORATOR',
													   trimUpper(input.recordType) = 'O' => 
															'OFFICER',
													   '');
													  
			title1								:= input.titles[1..1];
			title2								:= input.titles[2..2];
			title3								:= input.titles[3..3];
			title4								:= input.titles[4..4];
			title5								:= input.titles[5..5];																           																
																	
			title1Txt							:= if(getContTitle(entity,title1)<>'',
													trim(getContTitle(entity,title1),left,right) + '; ',
													'');
			title2Txt							:= if(getContTitle(entity,title2)<>'',
													trim(getContTitle(entity,title2),left,right) + '; ',
													'');	
			title3Txt							:= if(getContTitle(entity,title3)<>'',
													trim(getContTitle(entity,title3),left,right) + '; ',
													'');	
			title4Txt							:= if(getContTitle(entity,title4)<>'',
													trim(getContTitle(entity,title4),left,right) + '; ',
													'');	
			title5Txt							:= if(getContTitle(entity,title5)<>'',
													trim(getContTitle(entity,title5),left,right) + '; ',
													'');	
			
			allTitleTxt							:= title1Txt + title2Txt +
												   title3Txt + title4Txt +
												   title5Txt;
																		
		 	self.cont_title1_desc				:= regexreplace(';$',trim(allTitleTxt,left,right),'');														
													  			
			temp_csz							:= if(trimUpper(input.addrsLine4) <> '',
														trimUpper(input.addrsLine4),
														trimUpper(input.addrsLine3));
														
			temp_street2						:= if(trimUpper(input.addrsLine4) <> '',
														trimUpper(input.addrsLine3),
														trimUpper(input.addrsLine2));
														
			temp_street1						:= if(trimUpper(input.addrsLine4) <> '',
														trimUpper(input.addrsLine2),
														'');
													
			csz									:= regexreplace(omitStrings,trimUpper(temp_csz),'');
			
			street2								:= regexreplace(omitStrings,trimUpper(temp_street2),'');
		
			street1								:= regexreplace(omitStrings,trimUpper(temp_street1),'');
																			
			self.cont_address_line1				:= '';			
														
			self.cont_address_line2				:= street1;
														
			self.cont_address_line3				:= street2;																												
													
			self.cont_address_line4				:= csz;																												
														
			self.cont_address_line5				:= '';
			
			self.cont_address_line6				:= '';																											
																										  
		    self.cont_address_type_cd			:= if(street1 + street2 + csz <> '', 														
													  'T',
													  '');
													  
		    self.cont_address_type_desc		:= if(street1 + street2 + csz <> '', 														
													  'CONTACT',
													  '');
													  
			self.cont_addl_info    			:= if(trimUpper(input.recordType) = 'I' and
													  (integer) input.sharesIssued > 0,
													  'SHARES ISSUED: ' +
													  (string) (integer) input.sharesIssued,
													  '');													  
													  
			self := [];	
			
		end;		
		
// -------------------  Event File Mapping for Corporate Stock Records  --------------------//			
			
		Corp2.Layout_Corporate_Direct_Stock_In StockTransform01(Layouts_Raw_Input.crpcm input):=transform,
				skip((trimUpper(input.noParShares)='' 		and
				      trimUpper(input.totalValueShares)=''  and
					  trimUpper(input.authShares)='' 		and
					  trimUpper(input.eachValueShares)='')  or
				     ((integer) stringlib.stringfilter(input.noParShares,'0123456789') = 0      and 
					  (integer) stringlib.stringfilter(input.totalValueShares,'0123456789') = 0 and 
					  (integer) stringlib.stringfilter(input.authShares,'0123456789') = 0 		and 
					  (integer) stringlib.stringfilter(input.eachValueShares,'0123456789') = 0)) 
		
			self.corp_key					:= '22-' + trimUpper(input.masterID);
			self.corp_vendor				:= '22';
			self.corp_state_origin			:= 'LA';
			self.corp_process_date			:= fileDate;
			self.corp_sos_charter_nbr		:= trimUpper(input.masterID);
		 	self.stock_nbr_par_shares		:= if(stringlib.stringfilter(input.noParShares,'0123456789') != input.noParShares or 									
													(integer) stringlib.stringfilter(input.noParShares,'0123456789') = 0,
														'',	
													(string) (integer) trim(input.noParShares,left,right));
													
			self.stock_addl_info            := if(stringlib.stringfilter(input.totalValueShares,'0123456789') != input.totalValueShares or 									
													(integer) stringlib.stringfilter(input.totalValueShares,'0123456789') = 0,
														'',	
													'TOTAL DOLLAR VALUE OF SHARES: ' +	
													(string) (integer) trim(input.totalValueShares,left,right));
													
			self.stock_authorized_nbr       := if(stringlib.stringfilter(input.authShares,'0123456789') != input.authShares or 									
													(integer) stringlib.stringfilter(input.authShares,'0123456789') = 0,
														'',	
													(string) (integer) trim(input.authShares,left,right));													  
													
            decimalPortion					:= trim(input.eachValueShares,left,right)[length(trim(input.eachValueShares,left,right)) -2..];
		
			wholePortion					:= trim(input.eachValueShares,left,right)[1..length(trim(input.eachValueShares,left,right)) -3];
			
			fmtWholePortion 				:= (string) (integer) wholePortion;
													
            self.stock_par_value	        := fmtWholePortion + '.' + decimalPortion;
			
			self							:=[];
			
		end;
		
		
// -------------------  Event File Mapping for Corporate Merger Records  --------------------//	

		Corp2.Layout_Corporate_Direct_Event_In EventTransform01(Layouts_Raw_Input.crpcc input) := transform				
		
			self.corp_process_date				:= fileDate;
			self.corp_key						:= '22-' + trimUpper(input.masterID);
			self.corp_vendor					:= '22';
			self.corp_state_origin				:= 'LA';								
			self.corp_sos_charter_nbr			:= trimUpper(input.masterID);		
			self.event_filing_cd                := 'MER';
			self.event_filing_desc         		:= 'MERGER';
			self.event_desc						:= trimUpper(input.mergerInfo);
			self 								:= [];						
			end; 	
			
// -------------------  Event File Mapping for Corporate Amendments Records  --------------------//	

		Corp2.Layout_Corporate_Direct_Event_In EventTransform02(Layouts_Raw_Input.crpam input) := transform				
		
			self.corp_process_date				:= fileDate;
			self.corp_key						:= '22-' + trimUpper(input.masterID);
			self.corp_vendor					:= '22';
			self.corp_state_origin				:= 'LA';								
			self.corp_sos_charter_nbr			:= trimUpper(input.masterID);					
			
			newDateFiled						:= if(stringlib.stringfilter(input.amndDateFiled,'0123456789') != input.amndDateFiled or 
														length(trim(input.amndDateFiled,left,right))!= 8 or
														(integer) stringlib.stringfilter(input.amndDateFiled,'0123456789') = 0,
														'',														
														input.amndDateFiled);
														
			goodDateFiled						:= if(_validate.date.fIsValid(newDateFiled) and 													
													  _validate.date.fIsValid(newDateFiled,_validate.date.rules.DateInPast),
													  newDateFiled,
												      '');
													  
			self.event_filing_date				:= goodDateFiled;
			
			self.event_date_type_cd             := if(goodDateFiled<>'',
													  'FIL',
													  '');
													  
			self.event_date_type_desc      		:= if(goodDateFiled<>'',
													  'FILING',
													  '');
													  
			self.event_filing_reference_nbr     := if(stringlib.stringfilter(input.amndCode,'0123456789') != input.amndCode or 
														(integer) stringlib.stringfilter(input.amndCode,'0123456789') = 0,
														'',														
														trim(input.amndCode,left,right));
														
		    amndType							:= trimUpper(input.amndType);
							
		    self.event_filing_cd				:= amndType;
														  													   
			self.event_filing_desc				:= map(amndType='AC867'=>'RESOLUTION OF BOARD OF DIRECTORS REGARDING TAX FILINGS',
													   amndType='AFDIS'=>'AFFIDAVIT TO DISSOLVE',
													   amndType='AGREE'=>'NON-LOUISIANA PARTNERSHIP FILES AGREEMENT',
													   amndType='AMEND'=>'AMENDMENT',
													   amndType='AMENM'=>'AMENDMENT TO A MERGER',
													   amndType='BANKR'=>'BANKRUPT',
													   amndType='C'=>'NOT VERIFIED',
													   amndType='CANCL'=>'CANCELLED',
													   amndType='CHART'=>'CHARTER',
													   amndType='CHGCH'=>'WHEN A NON-PROFIT CORPORATION CHANGES TO A BUSINESS CORPORATION',
													   amndType='CHGST'=>'CHANGE STATE OF INCORPORATION',
													   amndType='CHOFF'=>'APPOINTING, CHANGING OR RESIGNATION OF OFFICER',
													   amndType='CLEAR'=>'DEPARTMENT OF REVENUE TAX CLEARANCE',
													   amndType='CMERG'=>'COURT ORDER CANCEL MERGER',
													   amndType='CONSO'=>'CONSOLIDATION',
													   amndType='CONVT'=>'CONVERT \'J\' TO \'Y\'',
													   amndType='COURT'=>'ANY OTHER COURT ORDERED FILING',
													   amndType='CREIN'=>'CANCEL REINSTATEMENT',
													   amndType='CRTLQ'=>'COURT ORDERED LIQUIDATION',
													   amndType='DISPN'=>'INCOMPLETE DISSOLUTION PROCEEDINGS',
													   amndType='DISSO'=>'DISSOLUTION',
													   amndType='EREVO'=>'REVOKED IN ERROR',
													   amndType='EXCEA'=>'CORPORATIONS\' TERM OF EXISTENCE CEASES',
													   amndType='GENRP'=>'GENERAL REPORT',
													   amndType='LQCRT'=>'LIQUIDATORS CERTIFICATE',
													   amndType='MERGE'=>'MERGER',
													   amndType='MISC?'=>'MISCELLANEOUS CATEGORY',
													   amndType='NMCHG'=>'NAME CHANGE',
													   amndType='NOFDI'=>'NOTICE OF DISSOLUTION',
													   amndType='OWNER'=>'DISCLOSURE OF OWNERSHIP',
													   amndType='POFAT'=>'POWER OF ATTORNEY',
													   amndType='RECAN'=>'RESCINDING CANCELLATION OF CHARTER',
													   amndType='REINS'=>'REINSTATEMENT',
													   amndType='RENEW'=>'RENEW REGISTRATION FOR LLP',
													   amndType='REREV'=>'RESCINDING REVOCATION',
													   amndType='RESTA'=>'RESTATED ARTICLES',
													   amndType='REVOK'=>'REVOKED',
													   amndType='RS51C'=>'RESOLUTION REGARDING UNEQUAL SHARES OF STOCK',
													   amndType='SHEXC'=>'SHARE EXCHANGE',
													   amndType='STBID'=>'STATE BID RESOLUTION',
													   amndType='SUPIR'=>'SUPPLEMENTAL INITIAL REPORT',
													   amndType='SUPLQ'=>'SUPPLEMENTAL LIQUIDATOR CERTIFICATE',
													   amndType='SUPND'=>'SUPPLEMENTAL NOTICE OF DISSOLUTION',
													   amndType='SUPWD'=>'SUPPLEMENTAL WITHDRAWAL',
													   amndType='SUSP'=>'SUSPENDED',
													   amndType='TERMD'=>'TERMINATION OF DISSOLUTION',
													   amndType='TERMI'=>'TERMINATED',
													   amndType='TERMM'=>'TERMINATE MERGER',
													   amndType='TERMW'=>'TERMINATION OF WITHDRAWAL',
													   amndType='VOID'=>'VOID',
													   amndType='WDPND'=>'WITHDRAWAL PENDING',
													   amndType='WITHD'=>'WITHDRAWAL',
													   amndType='12104'=>'DOMICILE, AGENT CHANGE OR RESIGNATION OF AGENT FOR BUSINESS CORPORATION',
													   amndType='12236'=>'DOMICILE, AGENT CHANGE OR RESIGNATION OF AGENT FOR NON-PROFIT CORPORATION',
													   amndType='12308'=>'STATEMENT OF CHANGE OR CHANGE PRINCIPAL BUSINESS OFFICE FOR NON-LOUISIANA CORPORATION AND PARTNERSHIP',
													   amndType='1308'=>'DOMESTIC LLC CHANGE OF AGENT/DOMICILE',
													   amndType='1350'=>'FOREIGN LLC STATEMENT OF CHANGE',													   
													   '');
																   
			self 								:= [];						
			end; 	
			
// -------------------  Event File Mapping for Corporate Merger Records  --------------------//	

		Corp2.Layout_Corporate_Direct_Event_In EventTransform03(Layouts_Raw_Input.crpta input) := transform				
		
			self.corp_process_date				:= fileDate;
			self.corp_key						:= '22-' + trimUpper(input.tmMasterID);
			self.corp_vendor					:= '22';
			self.corp_state_origin				:= 'LA';								
			self.corp_sos_charter_nbr			:= trimUpper(input.tmMasterID);		
			newDateFiled						:= if(stringlib.stringfilter(input.amndDateFiled,'0123456789') != input.amndDateFiled or 
														length(trim(input.amndDateFiled,left,right))!= 8 or
														(integer) stringlib.stringfilter(input.amndDateFiled,'0123456789') = 0,
														'',														
														input.amndDateFiled);
														
			goodDateFiled						:= if(_validate.date.fIsValid(newDateFiled) and 													
													  _validate.date.fIsValid(newDateFiled,_validate.date.rules.DateInPast),
													  newDateFiled,
												      '');
													  
			self.event_filing_date				:= goodDateFiled;
			
			self.event_date_type_cd             := if(goodDateFiled<>'',
													  'FIL',
													  '');
													  
			self.event_date_type_desc      		:= if(goodDateFiled<>'',
													  'FILING',
													  '');
													  
			self.event_filing_reference_nbr     := trimUpper(input.amndID);
													  
			amndType							:= trimUpper(input.amndType);
							
		    self.event_filing_cd				:= amndType;
																							  
			self.event_filing_desc				:= map(amndType='AMEND'=>'AMENDMENT', 
													   amndType='ASSIG'=>'TRADE/SERVICE ASSIGNMENT',
													   amndType='CANCL'=>'TRADE/SERVICE CANCELLATION',
													   amndType='EXPIR'=>'TRADE/SERVICE EXPIRATION',
													   amndType='NMCHG'=>'NAME CHANGE',
													   amndType='RENEW'=>'TRADE/SERVICE RENEWAL',													   
													   '');
													   
			self 								:= [];						
			end;	
			
// -------------------  AR File Mapping from Corporate Amendments Records   --------------------//						
		Corp2.Layout_Corporate_Direct_AR_In ARTransform01(Layouts_Raw_Input.crpam input):=transform
							
			self.corp_key						:= '22-' + trimUpper(input.masterID);	
			self.corp_vendor					:= '22';				
			self.corp_state_origin				:= 'LA';
			self.corp_process_date				:= fileDate;
			self.corp_sos_charter_nbr			:= trimUpper(input.masterID);						
			newDateFiled						:= if(stringlib.stringfilter(input.amndDateFiled,'0123456789') != input.amndDateFiled or 
														length(trim(input.amndDateFiled,left,right))!= 8 or
														(integer) stringlib.stringfilter(input.amndDateFiled,'0123456789') = 0,
														'',														
														input.amndDateFiled);
														
			goodDateFiled						:= if(_validate.date.fIsValid(newDateFiled) and 													
													  _validate.date.fIsValid(newDateFiled,_validate.date.rules.DateInPast),
													  newDateFiled,
												      '');
													  
			self.ar_filed_dt					:= goodDateFiled;
			
			self.ar_report_nbr					:= if(stringlib.stringfilter(input.amndCode,'0123456789') != input.amndCode or 
														(integer) stringlib.stringfilter(input.amndCode,'0123456789') = 0,
														'',														
														trim(input.amndCode,left,right));
														
            amndType							:= trimUpper(input.amndType);
			
			self.ar_comment						:= map(regexfind('^[0-9][0-9] AR$',amndType)=TRUE=>
																'ANNUAL REPORT (' + amndType[1..2] + ')',													  
													   amndType='AR'=>'ANNUAL REPORT', 													   
													   amndType='75FAR'=>'1975-1980 DOMESTIC ANNUAL REPORTS',
													   amndType='70FAR'=>'1970-1974 DOMESTIC ANNUAL REPORTS',
													   '');
			self								:=[];
		end;		
// -------------------  Clean Name and Address for Corp Type Records  --------------------//			
		
		Corp2.Layout_Corporate_Direct_Corp_In CleanCorps(corp2_mapping.Layout_CorpPreClean input) := transform		
			string73 tempname 					:= if(input.corp_ra_name = '', '', Address.CleanPersonFML73(input.corp_ra_name));
			pname 								:= Address.CleanNameFields(tempName);
			cname 								:= DataLib.companyclean(input.corp_ra_name);
			keepPerson 							:= corp2.Rewrite_Common.IsPerson(input.corp_ra_name);
			keepBusiness 						:= corp2.Rewrite_Common.IsCompany(input.corp_ra_name);
			
			self.corp_ra_title1					:= if(keepPerson, pname.title, '');
			self.corp_ra_fname1 				:= if(keepPerson, pname.fname, '');
			self.corp_ra_mname1 				:= if(keepPerson, pname.mname, '');
			self.corp_ra_lname1 				:= if(keepPerson, pname.lname, '');
			self.corp_ra_name_suffix1 			:= if(keepPerson, pname.name_suffix, '');
			self.corp_ra_score1 				:= if(keepPerson, pname.name_score, '');
		
			self.corp_ra_cname1 				:= if(keepBusiness, cname[1..70],'');
			self.corp_ra_cname1_score 			:= if(keepBusiness, pname.name_score, '');
			
			string182 clean_a1_address 			:= Address.CleanAddress182(trim(trim(input.corp_address1_line1,left,right) + ' ' +
																				trim(input.corp_address1_line2,left,right) + ' ' +
																				trim(input.corp_address1_line3,left,right),
																				left,right
																				),
														                   trim(trim(input.corp_address1_line4,left,right) + ', ' +
																				trim(input.corp_address1_line5,left,right),
																				left,right
																				)
																		   );			
			
			string182 reClean_a1_address		:= if(clean_a1_address[179..182] = 'E420',
												   Address.CleanAddress182(trim(trim(input.corp_address1_line1,left,right) + ' ' +																			
																				trim(input.corp_address1_line3,left,right),
																				left,right
																				),
														                   trim(trim(input.corp_address1_line4,left,right) + ', ' +
																				trim(input.corp_address1_line5,left,right),
																				left,right
																				)
																		   ),
														''
													   );
			string182 common_a1_address		 	:= if(reClean_a1_address <> '',
														reClean_a1_address,
														Clean_a1_address);
														
			string182 clean_ra_address 			:= Address.CleanAddress182(trim(trim(input.corp_ra_address_line1,left,right) + ' ' +
																				trim(input.corp_ra_address_line2,left,right) + ' ' +
																				trim(input.corp_ra_address_line3,left,right),
																				left,right
																				),
														                   trim(trim(input.corp_ra_address_line4,left,right) + ', ' +																			
																				trim(input.corp_ra_address_line5,left,right),
																				left,right
																				)
																		   );	
            string182 reclean_ra_address 		:= if(clean_ra_address[179..182] = 'E420',
												   Address.CleanAddress182(trim(trim(input.corp_ra_address_line1,left,right) + ' ' +
																				trim(input.corp_ra_address_line2,left,right) + ' ' +
																				trim(input.corp_ra_address_line3,left,right),
																				left,right
																				),
														                   trim(trim(input.corp_ra_address_line4,left,right) + ', ' +																			
																				trim(input.corp_ra_address_line5,left,right),
																				left,right
																				)
																		   ),
														''
													   );
													   
			string182 common_ra_address		 	:= if(reClean_ra_address <> '',
														reClean_ra_address,
														Clean_ra_address);															   
																							
			self.corp_ra_prim_range    			:= common_ra_address[1..10];
			self.corp_ra_predir 	      		:= common_ra_address[11..12];
			self.corp_ra_prim_name 	  			:= common_ra_address[13..40];
			self.corp_ra_addr_suffix   			:= common_ra_address[41..44];
			self.corp_ra_postdir 	    		:= common_ra_address[45..46];
			self.corp_ra_unit_desig 	  		:= common_ra_address[47..56];
			self.corp_ra_sec_range 	  			:= common_ra_address[57..64];
			self.corp_ra_p_city_name	  		:= common_ra_address[65..89];
			self.corp_ra_v_city_name	  		:= common_ra_address[90..114];
			self.corp_ra_state 			      	:= common_ra_address[115..116];
			self.corp_ra_zip5 		      		:= common_ra_address[117..121];
			self.corp_ra_zip4 		      		:= common_ra_address[122..125];
			self.corp_ra_cart 		      		:= common_ra_address[126..129];
			self.corp_ra_cr_sort_sz 	 		:= common_ra_address[130];
			self.corp_ra_lot 		      		:= common_ra_address[131..134];
			self.corp_ra_lot_order 	  			:= common_ra_address[135];
			self.corp_ra_dpbc 		      		:= common_ra_address[136..137];
			self.corp_ra_chk_digit 	  			:= common_ra_address[138];
			self.corp_ra_rec_type		  		:= common_ra_address[139..140];
			self.corp_ra_ace_fips_st	  		:= common_ra_address[141..142];
			self.corp_ra_county 	  			:= common_ra_address[143..145];
			self.corp_ra_geo_lat 	    		:= common_ra_address[146..155];
			self.corp_ra_geo_long 	    		:= common_ra_address[156..166];
			self.corp_ra_msa 		      		:= common_ra_address[167..170];
			self.corp_ra_geo_blk				:= common_ra_address[171..177];
			self.corp_ra_geo_match 	  			:= common_ra_address[178];
			self.corp_ra_err_stat 	    		:= common_ra_address[179..182];
			
			self.corp_addr1_prim_range    		:= common_a1_address[1..10];
			self.corp_addr1_predir 	      		:= common_a1_address[11..12];
			self.corp_addr1_prim_name 	  		:= common_a1_address[13..40];
			self.corp_addr1_addr_suffix   		:= common_a1_address[41..44];
			self.corp_addr1_postdir 	    	:= common_a1_address[45..46];
			self.corp_addr1_unit_desig 	  		:= common_a1_address[47..56];
			self.corp_addr1_sec_range 	  		:= common_a1_address[57..64];
			self.corp_addr1_p_city_name	  		:= common_a1_address[65..89];
			self.corp_addr1_v_city_name	  		:= common_a1_address[90..114];
			self.corp_addr1_state 				:= common_a1_address[115..116];
			self.corp_addr1_zip5 		    	:= common_a1_address[117..121];
			self.corp_addr1_zip4 		    	:= common_a1_address[122..125];
			self.corp_addr1_cart 		    	:= common_a1_address[126..129];
			self.corp_addr1_cr_sort_sz 	 		:= common_a1_address[130];
			self.corp_addr1_lot 		      	:= common_a1_address[131..134];
			self.corp_addr1_lot_order 	  		:= common_a1_address[135];
			self.corp_addr1_dpbc 		    	:= common_a1_address[136..137];
			self.corp_addr1_chk_digit 	  		:= common_a1_address[138];
			self.corp_addr1_rec_type		  	:= common_a1_address[139..140];
			self.corp_addr1_ace_fips_st	  		:= common_a1_address[141..142];
			self.corp_addr1_county 	  			:= common_a1_address[143..145];
			self.corp_addr1_geo_lat 	    	:= common_a1_address[146..155];
			self.corp_addr1_geo_long 	    	:= common_a1_address[156..166];
			self.corp_addr1_msa 		      	:= common_a1_address[167..170];
			self.corp_addr1_geo_blk				:= common_a1_address[171..177];
			self.corp_addr1_geo_match 	  		:= common_a1_address[178];
			self.corp_addr1_err_stat 	    	:= common_a1_address[179..182];
			
			ra_addr1							:= map(trim(input.corp_ra_address_line2,left,right)<>'' =>
														     trim(input.corp_ra_address_line2,left,right),
													   trim(input.corp_ra_address_line3,left,right)<>'' =>
														     trim(input.corp_ra_address_line3,left,right),
															 trim(input.corp_ra_address_line4,left,right));
													         
            ra_addr2							:= map(trim(input.corp_ra_address_line2,left,right)<>'' and
															trim(input.corp_ra_address_line3,left,right)<>''=>
														     trim(input.corp_ra_address_line3,left,right),													   
															 trim(input.corp_ra_address_line4,left,right));
															 
			ra_addr3							:= map(trim(input.corp_ra_address_line2,left,right)<>'' and
															trim(input.corp_ra_address_line3,left,right)<>''=>
														     trim(input.corp_ra_address_line4,left,right),													   
															 '');
            self.corp_ra_address_line1          := ra_addr1;
			self.corp_ra_address_line2          := ra_addr2;
			self.corp_ra_address_line3          := ra_addr3;
			self.corp_ra_address_line4          := '';
			self.corp_ra_address_line5          := '';
			self.corp_ra_address_line6          := '';
						
			self								:= input;
			self 								:= [];
		end;	
		
// -------------------  Clean Name and Address for Corp Type Records  --------------------//				
		Corp2.Layout_Corporate_Direct_Cont_In CleanConts(corp2_mapping.Layout_ContPreClean input) := transform		
			string73 tempname 					:= if(input.cont_name = '', '', Address.CleanPersonFML73(input.cont_name));
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
																		   
            string182 clean_address 			:= Address.CleanAddress182(trim(trim(input.cont_address_line1,left,right) + ' ' +
																				trim(input.cont_address_line2,left,right) + ' ' +
																				trim(input.cont_address_line3,left,right),
																				left,right
																				),
														                   trim(trim(input.cont_address_line4,left,right) + ', ' +
																				trim(input.cont_address_line5,left,right),
																				left,right
																				)
																		   );																				
																		   
			string182 reClean_address		    := if(clean_address[179..182] = 'E420',
												   Address.CleanAddress182(trim(trim(input.cont_address_line1,left,right) + ' ' +																			
																				trim(input.cont_address_line3,left,right),
																				left,right
																				),
														                   trim(trim(input.cont_address_line4,left,right) + ', ' +
																				trim(input.cont_address_line5,left,right),
																				left,right
																				)
																		   ),
														''
													   );
			string182 common_address		 	:= if(reClean_address <> '',
														reClean_address,
														clean_address);
														
			self.cont_prim_range    			:= common_address[1..10];
			self.cont_predir 	      			:= common_address[11..12];
			self.cont_prim_name 	  			:= common_address[13..40];
			self.cont_addr_suffix   			:= common_address[41..44];
			self.cont_postdir 	  		  		:= common_address[45..46];
			self.cont_unit_desig 	  			:= common_address[47..56];
			self.cont_sec_range 	  			:= common_address[57..64];
			self.cont_p_city_name	  			:= common_address[65..89];
			self.cont_v_city_name	 			:= common_address[90..114];
			self.cont_state 			      	:= common_address[115..116];
			self.cont_zip5 		      			:= common_address[117..121];
			self.cont_zip4 		 	     		:= common_address[122..125];
			self.cont_cart 		    	  		:= common_address[126..129];
			self.cont_cr_sort_sz 	 			:= common_address[130];
			self.cont_lot 		      			:= common_address[131..134];
			self.cont_lot_order 	  			:= common_address[135];
			self.cont_dpbc 		   		   		:= common_address[136..137];
			self.cont_chk_digit 	  			:= common_address[138];
			self.cont_rec_type		  			:= common_address[139..140];
			self.cont_ace_fips_st	  			:= common_address[141..142];
			self.cont_county 	 	 			:= common_address[143..145];
			self.cont_geo_lat 	    			:= common_address[146..155];
			self.cont_geo_long 	    			:= common_address[156..166];
			self.cont_msa 		      			:= common_address[167..170];
			self.cont_geo_blk					:= common_address[171..177];
			self.cont_geo_match 	  			:= common_address[178];
			self.cont_err_stat 	    			:= common_address[179..182];
			
            addr1								:= map(trim(input.cont_address_line2,left,right)<>'' =>
														     trim(input.cont_address_line2,left,right),
													   trim(input.cont_address_line3,left,right)<>'' =>
														     trim(input.cont_address_line3,left,right),
															 trim(input.cont_address_line4,left,right));
													         
            addr2								:= map(trim(input.cont_address_line2,left,right)<>'' and
															trim(input.cont_address_line3,left,right)<>''=>
														     trim(input.cont_address_line3,left,right),													   
															 trim(input.cont_address_line4,left,right));
															 
			addr3								:= map(trim(input.cont_address_line2,left,right)<>'' and
															trim(input.cont_address_line3,left,right)<>''=>
														     trim(input.cont_address_line4,left,right),													   
															 '');
            self.cont_address_line1             := addr1;
			self.cont_address_line2             := addr2;
			self.cont_address_line3             := addr3;
			self.cont_address_line4             := '';
			self.cont_address_line5             := '';
			self.cont_address_line6             := '';
			
			self								:= input;
			self 								:= [];
		end;
		
		// Corp2.Layout_Corporate_Direct_Corp_In CleanCorps(PreCleanedCommonLayouts.corppre input) := transform		
			// string73 tempname 					:= if(input.corp_ra_name = '', '', Address.CleanPersonFML73(input.corp_ra_name));
			// pname 								:= Address.CleanNameFields(tempName);
			// cname 								:= DataLib.companyclean(input.corp_ra_name);
			// keepPerson 							:= corp2.Rewrite_Common.IsPerson(input.corp_ra_name);
			// keepBusiness 						:= corp2.Rewrite_Common.IsCompany(input.corp_ra_name);
			
			// self.corp_ra_title1					:= if(keepPerson, pname.title, '');
			// self.corp_ra_fname1 				:= if(keepPerson, pname.fname, '');
			// self.corp_ra_mname1 				:= if(keepPerson, pname.mname, '');
			// self.corp_ra_lname1 				:= if(keepPerson, pname.lname, '');
			// self.corp_ra_name_suffix1 			:= if(keepPerson, pname.name_suffix, '');
			// self.corp_ra_score1 				:= if(keepPerson, pname.name_score, '');
		
			// self.corp_ra_cname1 				:= if(keepBusiness, cname[1..70],'');
			// self.corp_ra_cname1_score 			:= if(keepBusiness, pname.name_score, '');	
			
			// string182 clean_address 			:= Address.CleanAddress182(trim(trim(input.corp_ra_address_line1,left,right) + ' ' + 														                        
																			// trim(input.corp_ra_address_line2,left,right),left,right),														                   
																			// trim(trim(input.corp_ra_address_line3,left,right) + ', ' +
																			// trim(input.corp_ra_address_line4,left,right) + ' ' +
																			// trim(input.corp_ra_address_line5,left,right),left,right));
			// self.corp_ra_prim_range    			:= clean_address[1..10];
			// self.corp_ra_predir 	      		:= clean_address[11..12];
			// self.corp_ra_prim_name 	  			:= clean_address[13..40];
			// self.corp_ra_addr_suffix   			:= clean_address[41..44];
			// self.corp_ra_postdir 	    		:= clean_address[45..46];
			// self.corp_ra_unit_desig 	  		:= clean_address[47..56];
			// self.corp_ra_sec_range 	  			:= clean_address[57..64];
			// self.corp_ra_p_city_name	  		:= clean_address[65..89];
			// self.corp_ra_v_city_name	  		:= clean_address[90..114];
			// self.corp_ra_state 			      	:= clean_address[115..116];
			// self.corp_ra_zip5 		      		:= clean_address[117..121];
			// self.corp_ra_zip4 		      		:= clean_address[122..125];
			// self.corp_ra_cart 		      		:= clean_address[126..129];
			// self.corp_ra_cr_sort_sz 	 		:= clean_address[130];
			// self.corp_ra_lot 		      		:= clean_address[131..134];
			// self.corp_ra_lot_order 	  			:= clean_address[135];
			// self.corp_ra_dpbc 		      		:= clean_address[136..137];
			// self.corp_ra_chk_digit 	  			:= clean_address[138];
			// self.corp_ra_rec_type		  		:= clean_address[139..140];
			// self.corp_ra_ace_fips_st	  		:= clean_address[141..142];
			// self.corp_ra_county 	  			:= clean_address[143..145];
			// self.corp_ra_geo_lat 	    		:= clean_address[146..155];
			// self.corp_ra_geo_long 	    		:= clean_address[156..166];
			// self.corp_ra_msa 		      		:= clean_address[167..170];
			// self.corp_ra_geo_blk				:= clean_address[171..177];
			// self.corp_ra_geo_match 	  			:= clean_address[178];
			// self.corp_ra_err_stat 	    		:= clean_address[179..182];
			// self								:= input;
			// self 								:= [];
		// end;						
		

		// corpsAndSummary := distribute(join(joinedLines1_2, keyedLines3,              
							// left.keyValue = right.keyValue,
							// MergePos2Pos3(left,right),
							// left outer),hash32(org_id));
		// New LA below	
		// mappedCorps01 := project(Files_Raw_Input.OldName(fileDate), OH_corp2Transform_OldName(left));
		// New LA above
		// Get rid of the summary records that have mapped out to the following org_type values				 
		// corpStatus01 := corpsAndSummary(trimUpper(org_type) not in[':','YP']);	
					  
		// corpStatus02 := corpStatus01(trim(status_code2,left,right) <> '');
 
		// corpStatus03 := corpStatus01(trim(status_code3,left,right) <> '');
		
		// Corps03      	:= corpStatus03;
		// mappedCorps03   := project(Corps03,CorpTransform03(left));
		
		// Corps02      	:= corpStatus02;
		// mappedCorps02   := project(Corps02,CorpTransform02(left));
		
		
		
		// cleanedCorps 	:= project(mappedCorps01,CleanCorps(left));
		
		// corpsDist		:= distribute(cleanedCorps + mappedCorps02 + mappedCorps03,hash32(corp_orig_sos_charter_nbr));
		
		// allCorps        := sort(corpsDist,corp_key,local);	
		
		// AR01 			:= corpStatus01(org_type = '02' and (integer)trim(paid_capitol_rep,left,right) > 0 );
		// mappedAR01   	:= project(AR01,ARTransform01(left));
		
	 	Layouts_Raw_Input.crpcc transformCRPCC(Layouts_Raw_Input.varies l) := transform
			self.masterID 		:= l.fields[1..9];
			self.recordType	 	:= l.fields[10..10];
			self.sequence	 	:= l.fields[11..12];
			self.mergerInfo	 	:= l.fields[13..];			
            end;
				
		Layouts_Raw_Input.crpcc rollup_Mergers(Layouts_Raw_Input.crpcc l, Layouts_Raw_Input.crpcc r) := transform
			self.mergerInfo := l.mergerInfo + ' ' + r.mergerInfo;
			self      	    := r;
            end;
		
		Layouts_Raw_Input.crpce transformCRPCE(Layouts_Raw_Input.varies l) := transform
			self.masterID 		:= l.fields[1..9];
			self.extNbr		 	:= l.fields[10..10];
			self.extName	 	:= l.fields[11..];			
            end;
				
		Layouts_Raw_Input.crpce rollup_NameExt(Layouts_Raw_Input.crpce l, Layouts_Raw_Input.crpce r) := transform
			self.extName := l.extName + ' ' + r.extName;
			self      	 := r;
            end;
		
		Layouts_Raw_Input.crppe transformCRPPE(Layouts_Raw_Input.varies l) := transform
			self.masterID 		 := l.fields[1..9];
			self.nameChangeDate	 := l.fields[10..17];
			self.nameChangeOrder :=	l.fields[18..18];			
			self.sequence        :=	l.fields[19..19];
			self.prevName        :=	l.fields[20..];
            end;
				
		Layouts_Raw_Input.crppe rollup_PNameExt(Layouts_Raw_Input.crppe l, Layouts_Raw_Input.crppe r) := transform
			self.prevName := l.prevName + ' ' + r.prevName;
			self      	  := r;
            end;
			
		crpcmFile        := distribute(Files_Raw_Input.crpcmData(filedate),hash32(trimUpper(masterID)));
		
		crpce_varies 	 := Files_Raw_Input.crpceData(filedate);
		mapped_crpce 	 := project(crpce_varies,transformCRPCE(left));
		dist_crpce   	 := distribute(mapped_crpce,hash32(trimUpper(masterID)));
		sortedNameExt    := sort(dist_crpce,masterID,extNbr,LOCAL);
		mergedNameExt    := rollup(sortedNameExt,rollup_NameExt(left,right),masterID,LOCAL);

		crppe_varies 	 := Files_Raw_Input.crppeData(filedate);
		mapped_crppe 	 := project(crppe_varies,transformCRPPE(left));
		dist_crppe   	 := distribute(mapped_crppe,hash32(trimUpper(masterID)));
		sortedPNameExt   := sort(dist_crppe,masterID,nameChangeDate,nameChangeOrder,
								  sequence,LOCAL);
		mergedPNameExt   := rollup(sortedPNameExt,rollup_PNameExt(left,right),
									nameChangeDate,nameChangeOrder,masterID,LOCAL);
									
		crpcc_varies 	 := Files_Raw_Input.crpccData(filedate);
		mapped_crpcc 	 := project(crpcc_varies,transformCRPCC(left));
		dist_crpcc   	 := distribute(mapped_crpcc,hash32(trimUpper(masterID)));
		sortedMergers    := sort(dist_crpcc,masterID,sequence,LOCAL);
		mergedMergers    := rollup(sortedMergers,rollup_Mergers(left,right),masterID,LOCAL);
		
		allAddrs := Files_Raw_Input.crpcaData(filedate);
		raAddrs := distribute(allAddrs((trimUpper(recordType) = 'A') or 
				   (trimUpper(recordType) = 'F' and sequence='02')),hash32(trimUpper(masterID)));
		mbAddrs := distribute(allAddrs((trimUpper(recordType) = 'D' and sequence='01') or 
				   (trimUpper(recordType) = 'F' and sequence in ['01','03']) or
				   (trimUpper(recordType) = 'C' and sequence='01')),hash32(trimUpper(masterID)));
				   
		contAddrs := distribute(allAddrs((trimUpper(recordType) = 'I') or 
						(trimUpper(recordType) = 'O')),hash32(trimUpper(masterID)));
							 
		deduped_raAddrs := dedup(sort(raAddrs,
									  trimUpper(masterID),
									  trimUpper(name),
									  dateAppointed,
									  trimUpper(titles),
									  trimUpper(addrsLine2),
									  trimUpper(addrsLine3),
									  trimUpper(addrsLine4),LOCAL),
										  trimUpper(masterID),
										  trimUpper(name),
										  dateAppointed,
									      trimUpper(titles),
										  trimUpper(addrsLine2),
										  trimUpper(addrsLine3),
										  trimUpper(addrsLine4),LOCAL);
		deduped_mbAddrs := dedup(sort(mbAddrs,
									  trimUpper(masterID),
									  trimUpper(name),									
									  trimUpper(addrsLine2),
									  trimUpper(addrsLine3),
									  trimUpper(addrsLine4),LOCAL),
										  trimUpper(masterID),
										  trimUpper(name),										  
										  trimUpper(addrsLine2),
										  trimUpper(addrsLine3),
										  trimUpper(addrsLine4),LOCAL);
										  
		goodAddrs		:= deduped_raAddrs + deduped_mbAddrs;
		
		crptsaFile := Files_Raw_Input.crptsaData(filedate);
		
		crprmaFile := Files_Raw_Input.crprmaData(filedate);				
		
		crptaFile  := Files_Raw_Input.crptaData(filedate);
		
		crpamFile  := Files_Raw_Input.crpamData(filedate);
		
		crpamEvents := crpamFile((trimUpper(amndType) not in ['70FAR','75FAR','AR']) and
								(regexfind('^[0-9][0-9] AR$',trimUpper(amndType))=FALSE));
		
		crpamARs := crpamFile(trimUpper(amndType) in ['70FAR','75FAR','AR'] or
								regexfind('^[0-9][0-9] AR$',trimUpper(amndType))=TRUE);
	
		// crpcmFullName	:= rollup(sortedNameExt,rollup_NameExt(left,right),masterID,LOCAL);
		
//////////		
		crpcmFName joinFullName(Layouts_Raw_Input.crpcm l, Layouts_Raw_Input.crpce r ) := transform
			self.fullName := trimUpper(l.legalName) + ' ' + trimUpper(r.extName);
			self	:= l;
			self	:= r;
			end; 
		
		joinedFullName := join(crpcmFile, mergedNameExt,
								trimUpper(left.masterID) = trimUpper(right.masterID),
								joinFullName(left,right),
								left outer, local
							  );
							  
//////////							  
		crpcmFNameAddrs joinNameAddrs(crpcmFName l, Layouts_Raw_Input.crpca r ) := transform
			self	:= l;
			self	:= r;
			end; 
		
		joinedNameAddrs := join(joinedFullName, goodAddrs,
								trimUpper(left.masterID) = trimUpper(right.masterID),
								joinNameAddrs(left,right),
								left outer, local
							  );
							  
//////////							  
		crpcaFullName joinFNameAddrs(Layouts_Raw_Input.crpca l, crpcmFName r) := transform
			self	:= l;
			self	:= r;
			end; 
		
		joinedFNameAddrs := join(contAddrs, joinedFullName,
								 trimUpper(left.masterID) = trimUpper(right.masterID),
								 joinFNameAddrs(left,right),
								 left outer, local
							     );							  
		
//////////		
		crppnFullPName joinFullPName(Layouts_Raw_Input.crppn l, Layouts_Raw_Input.crppe r ) := transform
			self.fullPName := trimUpper(l.prevName) + ' ' + trimUpper(r.prevName);
			self	:= l;
			self	:= r;
			self    := [];
			end; 
		
		joinedFullPName := join(Files_Raw_Input.crppnData(filedate), mergedPNameExt,
								trimUpper(left.masterID) = trimUpper(right.masterID) and
								left.nameChangeDate = right.nameChangeDate and
								left.nameChangeOrder = right.nameChangeOrder,
								joinFullPName(left,right),
								left outer, local
							  ); 

//////////	
         crptsaState JoinTMState(Layouts_Raw_Input.crptsa l, StateCodeLayout r ) := transform
			self.stateDesc    := r.Desc;
			self         	  := l;
			self              := [];
		end; // end transform
		
		 
		joinedTMState	 := 	join(Files_Raw_Input.crptsaData(filedate),StateCodeTable,
									trimUpper(left.stateCode) = trimUpper(right.code),
									JoinTMState(left,right),
									left outer, lookup);
//++++++++	
							
		normalizedCrptsa normalizeCrptsa(Layouts_Raw_Input.crptsa l, unsigned1 cnt) := transform,
			skip(cnt=2 and 
			     trim(l.newOwnerName,left,right) = '' and
				 trim(l.streetAddrs2,left,right) = '' and
				 trim(l.city2,left,right) = '' and
				 trim(l.state2,left,right) = '' and
				 (trim(l.zip52,left,right) = '' or
				  (integer) trim(l.zip52,left,right) = 0) and
				 (trim(l.zip42,left,right) = '' or 
				  (integer) trim(l.zip52,left,right) = 0))
				 
			self.corpName		:= choose(cnt,l.ownerName,l.newOwnerName);
			self.corpStreet	 	:= choose(cnt,l.streetAddrs1,l.streetAddrs2);
			self.corpCity		:= choose(cnt,l.city1,l.city2);
			self.corpState		:= choose(cnt,l.state1,l.state2);		
			self.corpZip5		:= choose(cnt,l.zip51,l.zip52);
			self.corpZip4		:= choose(cnt,l.zip41,l.zip42);
			self.lnFlag			:= if(trimUpper(l.newOwnerName + l.streetAddrs2 +
												l.city2 + l.state2) = '',
									  'L',
									  'P');
			self 				:= l;
		end;
		
		normalCrptsa		:= normalize(Files_Raw_Input.crptsaData(filedate), 2, normalizeCrptsa(left, counter));
		distNormalCrptsa    := distribute(normalCrptsa,hash32(trimUpper(tmMasterID)));
		sortNormalCrptsa	:= sort(distNormalCrptsa,tmMasterID,corpName,corpStreet,corpCity,
									corpState,corpZip5,corpZip4,LOCAL);
		dedupNormalCrptsa   := dedup(sortNormalCrptsa,tmMasterID,corpName,corpStreet,corpCity,
									corpState,corpZip5,corpZip4,LOCAL);
		
		//Corps ----------------------------------------------------
		Corps01      	 := joinedNameAddrs;
		mappedCorps01    := project(Corps01,CorpTransform01(left));
		
		Corps02      	 := joinedFullPName;
		mappedCorps02    := project(Corps02,CorpTransform02(left));
		
		Corps03      	 := joinedTMState;
		mappedCorps03    := project(Corps03,CorpTransform03(left));
		
		Corps04      	 := crprmaFile;
		mappedCorps04    := project(Corps04,CorpTransform04(left));
		
		Corps05      	 := dedupNormalCrptsa;
		mappedCorps05    := project(Corps05,CorpTransform05(left));
		 
		corpsList   	 := mappedCorps02 + mappedCorps03 + mappedCorps04;
						   
		corpsToCleanList := mappedCorps01 + mappedCorps05;
						
		cleanedCorpsList := project(corpsToCleanList,CleanCorps(left));	
		
		allCorps 		 := sort(cleanedCorpsList + corpsList,corp_key);
		
		
		//Contacts ----------------------------------------------------
		Conts01      	:= crprmaFile;
		mappedConts01   := project(Conts01,ContTransform01(left));
		
		Conts02      	:= joinedFNameAddrs;
		mappedConts02   := project(Conts02,ContTransform02(left));
		
		contsList   	:= mappedConts01 + mappedConts02;						  				
					
		allConts   	    := project(contsList,CleanConts(left));	
		
		// allConts        := sort(cleanedConts,corp_key);
		
		//Stocks ----------------------------------------------------
		Stock01      	:= crpcmFile;
		mappedStock01   := project(Stock01,StockTransform01(left));
		
		//ARs ----------------------------------------------------
		AR01      		:= crpamARs;
		mappedAR01   	:= project(AR01,ARTransform01(left));
		
		//Events ----------------------------------------------------
		Event01      	:= mergedMergers;
		mappedEvent01   := project(Event01,EventTransform01(left));
		
		Event02      	:= crpamEvents;
		mappedEvent02   := project(Event02,EventTransform02(left));	
		
		Event03      	:= crptaFile;
		mappedEvent03   := project(Event03,EventTransform03(left));
		
		eventsList   	:= mappedEvent01 + mappedEvent02 + mappedEvent03;						  				
		
		allEvents       := sort(eventsList,corp_key);	 
		
		
		
		// mapLA := parallel( 						
							// output(count(crpamARs)),
							// output(count(crpamEvents))
							// output(allconts)
							// output(joinedFullName)											
							// output(joinedFullName)
						   //);
	VersionControl.macBuildNewLogicalFile('~thor_data400::in::corp2::'+version+'::corp_la'	,allCorps			,corp_out		,,,pOverwrite);		
	VersionControl.macBuildNewLogicalFile('~thor_data400::in::corp2::'+version+'::cont_la'	,allConts			,cont_out		,,,pOverwrite);
	VersionControl.macBuildNewLogicalFile('~thor_data400::in::corp2::'+version+'::event_la'	,allEvents		,events_out	,,,pOverwrite);
	VersionControl.macBuildNewLogicalFile('~thor_data400::in::corp2::'+version+'::stock_la'	,mappedStock01,stock_out	,,,pOverwrite);
	VersionControl.macBuildNewLogicalFile('~thor_data400::in::corp2::'+version+'::ar_la'		,mappedAR01		,ar_out			,,,pOverwrite);

		mapLA := parallel(                                                                                                                                       
			 corp_out		
			,cont_out		
			,events_out	
			,stock_out	
			,ar_out			
   );

		result := 
		sequential(
			 if(pshouldspray = true,fSprayFiles('la',filedate,pOverwrite := pOverwrite))
			,mapLA
			,parallel(
				 fileservices.addsuperfile('~thor_data400::in::corp2::sprayed::corp'	,'~thor_data400::in::corp2::'+version+'::corp_la')
				,fileservices.addsuperfile('~thor_data400::in::corp2::sprayed::cont'	,'~thor_data400::in::corp2::'+version+'::cont_la')
				,fileservices.addsuperfile('~thor_data400::in::corp2::sprayed::event'	,'~thor_data400::in::corp2::'+version+'::event_la')
				,fileservices.addsuperfile('~thor_data400::in::corp2::sprayed::stock'	,'~thor_data400::in::corp2::'+version+'::stock_la')
				,fileservices.addsuperfile('~thor_data400::in::corp2::sprayed::ar'		,'~thor_data400::in::corp2::'+version+'::ar_la')
			)
		);

		return result;
	end;					 
	
end; // end of LA module