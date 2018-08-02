IMPORT Address, Business_Header, Business_Risk_BIP, DueDiligence, iesp, Risk_Indicators, STD, ut;


EXPORT CommonQuery := MODULE
		
		EXPORT mac_AddressFromRequest(reportedBy) := MACRO
				
				indBusAddr := reportedBy.address;
				address_in := DATASET([TRANSFORM(DueDiligence.Layouts.Address,
																					SELF.prim_range := TRIM(indBusAddr.streetnumber);
																					SELF.predir := TRIM(indBusAddr.streetPreDirection);
																					SELF.prim_name := TRIM(indBusAddr.streetName);
																					SELF.addr_suffix := TRIM(indBusAddr.streetSuffix);
																					SELF.postdir := TRIM(indBusAddr.streetPostDirection);
																					SELF.unit_desig := TRIM(indBusAddr.unitDesignation);
																					SELF.sec_range := TRIM(indBusAddr.unitNumber);
																					SELF.streetAddress1 := TRIM(indBusAddr.streetAddress1);
																					SELF.streetAddress2 := TRIM(indBusAddr.streetAddress2);
																					SELF.city := TRIM(indBusAddr.city);
																					SELF.state := TRIM(indBusAddr.state);
																					SELF.zip5 := TRIM(indBusAddr.zip5);
																					SELF.zip4 := TRIM(indBusAddr.zip4);
																					SELF.county := TRIM(indBusAddr.county);
																					SELF := [];)]);
		ENDMACRO;
		
		EXPORT PopulateIndividualFromRequest(reportedBy, acctNo, indvIndicator) := FUNCTIONMACRO
				
				#if(indvIndicator <> DueDiligence.Constants.BUSINESS)
						
						personInfo := reportedBy.person;
						DueDiligence.CommonQuery.mac_AddressFromRequest(personInfo);
						
						ind_in := DATASET([TRANSFORM(DueDiligence.Layouts.Indv_Input,
																					SELF.lexID := TRIM(personInfo.lexID);
																					SELF.name := DATASET([TRANSFORM(DueDiligence.Layouts.Name,
																																					SELF.fullName := TRIM(personInfo.name.full);
																																					SELF.firstName := TRIM(personInfo.name.first);
																																					SELF.middleName := TRIM(personInfo.name.middle);
																																					SELF.lastName := TRIM(personInfo.name.last);
																																					SELF.suffix := TRIM(personInfo.name.suffix);
																																					SELF := [];)])[1];
																					SELF.address := address_in[1];
																					SELF.phone := TRIM(personInfo.phone);
																					SELF.ssn := TRIM(personInfo.ssn);
																					SELF.accountNumber := TRIM(acctNo);
																					SELF := [];)]);
				#else
						ind_in := DATASET([], DueDiligence.Layouts.Indv_Input);
				#end
				
				RETURN ind_in;
		ENDMACRO;
		
		EXPORT PopulateBusinessFromRequest(reportedBy, acctNo, busIndicator) := FUNCTIONMACRO
				
				#if(busIndicator <> DueDiligence.Constants.INDIVIDUAL)
						
						businessInfo := reportedBy.business;
						DueDiligence.CommonQuery.mac_AddressFromRequest(businessInfo);
						
						bus_in := DATASET([TRANSFORM(DueDiligence.Layouts.Busn_Input,
																			SELF.lexID := TRIM(businessInfo.lexID);
																			SELF.accountNumber := TRIM(acctNo);
																			SELF.companyName := TRIM(businessInfo.companyName);
																			SELF.altCompanyName := TRIM(businessInfo.alternateCompanyName);
																			SELF.address := address_in[1];
																			SELF.fein := TRIM(businessInfo.fein);
																			SELF := [];)]);
				#else
						bus_in := DATASET([], DueDiligence.Layouts.Busn_Input);
				#end
				
				RETURN bus_in;
		ENDMACRO;
		
		EXPORT mac_CreateInputFromXML(requestType, requestStoredName, requestedReport, serviceRequested) := MACRO
				
				// Can't have duplicate definitions of Stored with different default values, 
				// so add the default to #stored to eliminate the assignment of a default value.
				#STORED('DPPAPurpose', Business_Risk_BIP.Constants.Default_DPPA);
				#STORED('GLBPurpose',  Business_Risk_BIP.Constants.Default_GLBA);
				
				
				//Get debugging indicator
				debugIndicator := FALSE : STORED('debugMode');
				intermediates := FALSE : STORED('intermediateVariables');

				// Get XML input 
				requestIn := DATASET([], requestType) : STORED(requestStoredName, FEW);

				firstRow := requestIn[1] : INDEPENDENT; // Since this is realtime AND not batch, should only have one row on input.

				optionsIn := GLOBAL(firstRow.options);
				userIn    := GLOBAL(firstRow.user);  //see the t_user layout in PublicRecords.iesp.share for details
				search    := GLOBAL(firstRow.reportBy);
				
				//get outer band data - to use if customer data is not populated
				UNSIGNED1 outerBandDPPAPurpose := Business_Risk_BIP.Constants.Default_DPPA : STORED('DPPAPurpose');
				UNSIGNED1 outerBandGLBPurpose  := Business_Risk_BIP.Constants.Default_GLBA : STORED('GLBPurpose');
				outerBandHistoryDate           := DueDiligence.Constants.NUMERIC_ZERO      : STORED('HistoryDateYYYYMMDD');
        STRING6 outerBandSSNMASK       := Business_Risk_BIP.Constants.Default_SSNMask : STORED('SSNMask');  
				
				
        //The general rule for picking these options is to look in the inner band (ie the User section) first
        //If the inner band fields are not populated look in the outer band or the Default from the Global Module 
        drm	    := IF(TRIM(userIn.DataRestrictionMask) <> DueDiligence.Constants.EMPTY, userIn.DataRestrictionMask, AutoStandardI.GlobalModule().DataRestrictionMask);
				dpm	    := IF(TRIM(userIn.DataPermissionMask) <> DueDiligence.Constants.EMPTY, userIn.DataPermissionMask, AutoStandardI.GlobalModule().DataPermissionMask);
				dppa    := IF((UNSIGNED1)userIn.DLPurpose > DueDiligence.Constants.NUMERIC_ZERO, (UNSIGNED1)userIn.DLPurpose, outerBandDPPAPurpose);
				glba    := IF((UNSIGNED1)userIn.GLBPurpose > DueDiligence.Constants.NUMERIC_ZERO, (UNSIGNED1)userIn.GLBPurpose, outerBandGLBPurpose);
        STRING6 DD_SSNMask := IF(userIn.SSNMask != DueDiligence.Constants.EMPTY, TRIM(userIn.SSNMask), TRIM(outerBandSSNMASK));    //*** EXPECTING ALL/LAST4/FIRST5 from MBS   
				
        //since the initial version can be defaulted, default options for person and business reports only; attributes need to be requested
        defaultVersion := MAP(TRIM(STD.Str.ToUpperCase(optionsIn.AttributesVersionRequest)) <> DueDiligence.Constants.EMPTY => TRIM(STD.Str.ToUpperCase(optionsIn.AttributesVersionRequest)),
                              serviceRequested = DueDiligence.Constants.BUSINESS => DueDiligence.Constants.BUS_REQ_ATTRIBUTE_V3,
                              serviceRequested = DueDiligence.Constants.INDIVIDUAL => DueDiligence.Constants.IND_REQ_ATTRIBUTE_V3,
                              DueDiligence.Constants.EMPTY);
                              
				requestedVersion := defaultVersion;
				includeReport := requestedReport;
				displayAttributeText := optionsIn.displayText;       
        
        requestedSource := MAP(STD.Str.ToUpperCase(TRIM(optionsIn.IncludeSpecialAttributes)) = 'NONE' => DueDiligence.Constants.REQUESTED_SOURCE_ENUM.NONE,
                                STD.Str.ToUpperCase(TRIM(optionsIn.IncludeSpecialAttributes)) = 'ONLINE' => DueDiligence.Constants.REQUESTED_SOURCE_ENUM.ONLINE,
                                STD.Str.ToUpperCase(TRIM(optionsIn.IncludeSpecialAttributes)) = 'BATCH' => DueDiligence.Constants.REQUESTED_SOURCE_ENUM.BATCH,
                                DueDiligence.Constants.REQUESTED_SOURCE_ENUM.EMPTY);
				
				
				
				
				wseq := PROJECT(requestIn, TRANSFORM({INTEGER4 seq, RECORDOF(requestIn)}, SELF.seq := COUNTER, SELF := LEFT));

				input := PROJECT(wseq, TRANSFORM(DueDiligence.Layouts.Input,
				
																					version := requestedVersion;
																					reportBy := LEFT.reportBy;
																					
																					populatedInd := DueDiligence.CommonQuery.PopulateIndividualFromRequest(reportBy, LEFT.user.accountNumber, serviceRequested);
																					populatedBus := DueDiligence.CommonQuery.PopulateBusinessFromRequest(reportBy, LEFT.user.accountNumber, serviceRequested);
																					
																					
																					useHistDate := (UNSIGNED4)(INTFORMAT(LEFT.options.HistoryDate.Year, 4, 1) + INTFORMAT(LEFT.options.HistoryDate.Month, 2, 1) + INTFORMAT(LEFT.options.HistoryDate.Day, 2, 1));
																					histDate := IF(useHistDate > 0, useHistDate, (UNSIGNED4)outerBandHistoryDate);
																																					
																					SELF.seq := LEFT.seq;
																					SELF.individual := populatedInd[1];
																					SELF.business := populatedBus[1];
																					SELF.historyDateYYYYMMDD := histDate;
																					SELF.requestedVersion := version;
																					SELF := [];));
		ENDMACRO;
		
		
		EXPORT ValidateRequest(DATASET(DueDiligence.Layouts.Input) input, UNSIGNED1 glbPurpose, UNSIGNED1 dppaPurpose):= FUNCTION

				validatedRequests := PROJECT(input, TRANSFORM(DueDiligence.Layouts.Input,
																											//Validate the request
																											BOOLEAN IndFNamePopulated := LEFT.individual.name.firstName <> DueDiligence.Constants.EMPTY OR LEFT.individual.name.fullName <> DueDiligence.Constants.EMPTY;
																											BOOLEAN IndLNamePopulated := LEFT.individual.name.lastName <> DueDiligence.Constants.EMPTY OR LEFT.individual.name.fullName <> DueDiligence.Constants.EMPTY;
																											BOOLEAN IndAddrPopulated := LEFT.Individual.address.streetaddress1 <> DueDiligence.Constants.EMPTY OR (LEFT.Individual.address.prim_range <> DueDiligence.Constants.EMPTY AND LEFT.Individual.address.prim_name <> DueDiligence.Constants.EMPTY);
																											BOOLEAN IndCityStatePopulated := LEFT.individual.address.city <> DueDiligence.Constants.EMPTY AND LEFT.individual.address.state <> DueDiligence.Constants.EMPTY;
																											BOOLEAN IndZipPopulated := LEFT.individual.address.zip5 <> DueDiligence.Constants.EMPTY;
																											BOOLEAN IndSSNPopulated := LEFT.individual.ssn <> DueDiligence.Constants.EMPTY;

																											BOOLEAN BusNamePopulated := LEFT.business.companyName <> DueDiligence.Constants.EMPTY OR LEFT.business.altCompanyName <> DueDiligence.Constants.EMPTY;
																											BOOLEAN BusAddrPopulated := LEFT.business.address.streetaddress1 <> DueDiligence.Constants.EMPTY OR (LEFT.business.address.prim_range <> DueDiligence.Constants.EMPTY AND LEFT.Business.address.prim_name <> DueDiligence.Constants.EMPTY);
																											BOOLEAN BusCityStatePopulated := LEFT.business.address.city <> DueDiligence.Constants.EMPTY AND LEFT.business.address.state <> DueDiligence.Constants.EMPTY;
																											BOOLEAN BusZipPopulated := LEFT.business.address.zip5 <> DueDiligence.Constants.EMPTY;
																											BOOLEAN BusTaxIDPopulated := LEFT.business.fein <> DueDiligence.Constants.EMPTY;
																											
																											BOOLEAN LexIDPopulated := LEFT.individual.lexID <> DueDiligence.Constants.EMPTY;
																											BOOLEAN SeleIDPopulated := LEFT.business.lexID <> DueDiligence.Constants.EMPTY;
																											BOOLEAN ValidGLB := (glbPurpose BETWEEN 0 AND 7) OR glbPurpose = 11 OR glbPurpose = 12;
																											BOOLEAN ValidDPPA := dppaPurpose BETWEEN 0 AND 7;
																											
																											BOOLEAN ValidIndividual := (IndFNamePopulated AND IndLNamePopulated AND
                                                                                      (IndSSNPopulated OR 
                                                                                      (IndAddrPopulated AND (IndCityStatePopulated OR IndZipPopulated)))) 
                                                                                  OR LexIDPopulated;
																											
																											BOOLEAN ValidBusiness := (BusNamePopulated AND
                                                                                    (BusTaxIDPopulated OR
                                                                                    (BusAddrPopulated AND (BusCityStatePopulated OR BusZipPopulated)))) 
                                                                                OR SeleIDPopulated;
																																								
																											BOOLEAN ValidIndVersion := LEFT.requestedVersion IN DueDiligence.Constants.VALID_IND_ATTRIBUTE_VERSIONS;
																											BOOLEAN ValidBusVersion := LEFT.requestedVersion IN DueDiligence.Constants.VALID_BUS_ATTRIBUTE_VERSIONS;
																											
																											STRING OhNoMessage := MAP(ValidIndVersion = FALSE AND ValidBusVersion = FALSE => DueDiligence.Constants.VALIDATION_INVALID_VERSION,
																																								ValidIndVersion AND ValidIndividual = FALSE => DueDiligence.Constants.VALIDATION_INVALID_INDIVIDUAL,
																																								ValidBusVersion AND ValidBusiness = FALSE => DueDiligence.Constants.VALIDATION_INVALID_BUSINESS,
																																								ValidGLB = FALSE => DueDiligence.Constants.VALIDATION_INVALID_GLB,
																																								ValidDPPA = FALSE => DueDiligence.Constants.VALIDATION_INVALID_DPPA,
																																								DueDiligence.Constants.EMPTY);

																											
																											SELF.validRequest := IF(OhNoMessage = DueDiligence.Constants.EMPTY, TRUE, FALSE);
																											SELF.errorMessage := OhNoMessage;
																											SELF := LEFT;));

				RETURN validatedRequests;
		END;
		
		
		EXPORT mac_FailOnError(invalidRequests, requestedService) := MACRO
				//update the error message if the version was incorrect
				updateVersionMessage := PROJECT(invalidRequests, TRANSFORM(DueDiligence.Layouts.Input,
        
                                                                    validVersions := MAP(requestedService = DueDiligence.Constants.BUSINESS => DueDiligence.Constants.BUS_REQ_ATTRIBUTE_V3,
                                                                                         requestedService = DueDiligence.Constants.INDIVIDUAL => DueDiligence.Constants.IND_REQ_ATTRIBUTE_V3,
                                                                                         DueDiligence.Constants.IND_REQ_ATTRIBUTE_V3 + ' OR ' + DueDiligence.Constants.BUS_REQ_ATTRIBUTE_V3);
                                                            
																																		versionReq := ': ' + validVersions;
																																		SELF.errorMessage := IF(LEFT.errorMessage = DueDiligence.Constants.VALIDATION_INVALID_VERSION, TRIM(LEFT.errorMessage) + versionReq, LEFT.errorMessage);
																																		SELF := LEFT;));

				IF(COUNT(updateVersionMessage) > 0 AND updateVersionMessage[1].validRequest = FALSE, FAIL(updateVersionMessage[1].errorMessage));
		ENDMACRO;
			
			
		EXPORT GetCleanData(DATASET(DueDiligence.Layouts.Input) input) := FUNCTION
			
				cleanData := PROJECT(input, TRANSFORM(DueDiligence.Layouts.CleanedData,
																							//Clean Address
																							addressToClean := IF(LEFT.requestedVersion IN DueDiligence.Constants.VALID_IND_ATTRIBUTE_VERSIONS, LEFT.individual.address, LEFT.business.address);
																							

																							addr := Risk_Indicators.MOD_AddressClean.street_address(addressToClean.streetAddress1 + ' ' + addressToClean.streetAddress2, addressToClean.prim_range, 
																																																			addressToClean.predir, addressToClean.prim_name, addressToClean.addr_suffix, 
																																																			addressToClean.postdir, addressToClean.unit_desig, addressToClean.sec_range);
																																																								
																							cleanAddr := Risk_Indicators.MOD_AddressClean.clean_addr(addr, addressToClean.city, addressToClean.state, addressToClean.zip5);											
																						
																							cleanedAddress := Address.CleanFields(cleanAddr);
																							
																							street1 := Risk_Indicators.MOD_AddressClean.street_address(DueDiligence.Constants.EMPTY, cleanedAddress.Prim_Range, cleanedAddress.Predir, cleanedAddress.Prim_Name, 
																																																					cleanedAddress.Addr_Suffix, cleanedAddress.Postdir, cleanedAddress.Unit_Desig, cleanedAddress.Sec_Range);
																							
																							addressClean := DATASET([TRANSFORM(DueDiligence.Layouts.Address,
																																									SELF.streetAddress1 := street1;
																																									SELF.streetAddress2 := TRIM(STD.Str.ToUpperCase(addressToClean.StreetAddress2));
																																									SELF.prim_range := cleanedAddress.prim_range;
																																									SELF.predir := cleanedAddress.predir;
																																									SELF.prim_name := cleanedAddress.prim_name;
																																									SELF.addr_suffix := cleanedAddress.addr_suffix;
																																									SELF.postdir := cleanedAddress.postdir;
																																									SELF.unit_desig := cleanedAddress.unit_desig;
																																									SELF.sec_range := cleanedAddress.sec_range;
																																									SELF.city := cleanedAddress.v_city_name;
																																									SELF.state := cleanedAddress.st;
																																									SELF.zip5 := cleanedAddress.zip;
																																									SELF.zip4 := cleanedAddress.zip4;
																																									SELF.cart := cleanedAddress.cart;
																																									SELF.cr_sort_sz := cleanedAddress.cr_sort_sz;
																																									SELF.lot := cleanedAddress.lot;
																																									SELF.lot_order := cleanedAddress.lot_order;
																																									SELF.dbpc := cleanedAddress.dbpc;
																																									SElF.chk_digit := cleanedAddress.chk_digit;
																																									SELF.rec_type := cleanedAddress.rec_type;
																																									/* Due Diligence logic is expecting only the last 3 digits of the full 5 digit FIPS Code        */   
																																									/*               When it needs the full 5 digits of the FIPS Code it will generate the 5 digits */
																																									/*               by converting the 2 character state code into the 2 digit numerice code and    */
																																									/*               concatenate the 2 digit state code with 3 digit county code to generate the    */
																																									/*               full 5 digits again.   This is consistent with other Risk Products             */  
																																									SELF.county := cleanedAddress.county[DueDiligence.Constants.FIRST_POS..DueDiligence.Constants.LAST_POS];
																																									SELF.geo_lat := cleanedAddress.geo_lat;
																																									SELF.geo_long := cleanedAddress.geo_long;
																																									SELF.msa := cleanedAddress.msa;
																																									SELF.geo_blk := cleanedAddress.geo_blk;
																																									SELF.geo_match := cleanedAddress.geo_match;
																																									SELF.err_stat := cleanedAddress.err_stat;
																																									SELF := [];)])[1];
																							
																							addrProvided := addressToClean.streetAddress1 <> DueDiligence.Constants.EMPTY OR addressToClean.streetAddress2 <> DueDiligence.Constants.EMPTY OR addressToClean.prim_range <> DueDiligence.Constants.EMPTY OR addressToClean.predir <> DueDiligence.Constants.EMPTY OR 
																															addressToClean.prim_name <> DueDiligence.Constants.EMPTY OR addressToClean.addr_suffix <> DueDiligence.Constants.EMPTY OR addressToClean.postdir <> DueDiligence.Constants.EMPTY OR addressToClean.unit_desig <> DueDiligence.Constants.EMPTY OR 
																															addressToClean.sec_range <> DueDiligence.Constants.EMPTY OR addressToClean.city <> DueDiligence.Constants.EMPTY OR addressToClean.state <> DueDiligence.Constants.EMPTY OR addressToClean.zip5 <> DueDiligence.Constants.EMPTY;	
																															
																							fullAddrProvided := (addressClean.streetAddress1 <> DueDiligence.Constants.EMPTY OR addressClean.prim_name <> DueDiligence.Constants.EMPTY) AND addressClean.city <> DueDiligence.Constants.EMPTY AND addressClean.state <> DueDiligence.Constants.EMPTY AND addressClean.zip5 <> DueDiligence.Constants.EMPTY;
																							
																							//Clean Company Name
																							busName := LEFT.business.companyName;
																							altBusName := LEFT.business.altCompanyName;
																							

																							companyName := IF(busName = DueDiligence.Constants.EMPTY, ut.CleanCompany(altBusName), ut.CleanCompany(busName)); // If the customer didn't pass in a company but passed in an alt company name use the alt as the company name
																							altCompanyName := IF(busName = DueDiligence.Constants.EMPTY, DueDiligence.Constants.EMPTY, ut.CleanCompany(altBusName)); // Blank out the cleaned AltCompanyName if CompanyName wasn't populated, as we copied Alt into the Main CompanyName field on the previous line
																							
																							//Clean Phone Number
																							phoneNumber := IF(LEFT.requestedVersion IN DueDiligence.Constants.VALID_IND_ATTRIBUTE_VERSIONS, LEFT.individual.phone, LEFT.business.phone);
																							phoneToClean := STD.Str.Filter(phoneNumber, DueDiligence.Constants.NUMERIC_VALUES);
																							validPhone := IF(Business_Risk_BIP.Common.validPhone(phoneToClean), phoneToClean, DueDiligence.Constants.EMPTY); //If we do not have a valid phone, blank it out
																							
																							//Remove any non-numeric fiends from taxID and lexID fields
																							taxID := IF(LEFT.requestedVersion IN DueDiligence.Constants.VALID_IND_ATTRIBUTE_VERSIONS, LEFT.individual.ssn, LEFT.business.fein);
																							taxIDToClean := STD.Str.Filter(taxID, DueDiligence.Constants.NUMERIC_VALUES);
																							validTaxID := IF(LEFT.requestedVersion IN DueDiligence.Constants.VALID_IND_ATTRIBUTE_VERSIONS, 
																																IF(Business_Header.IsValidSsn((UNSIGNED)taxIDToClean), taxIDToClean, DueDiligence.Constants.EMPTY), 
																																IF(Business_Header.ValidFEIN((UNSIGNED)taxIDToClean), taxIDToClean, DueDiligence.Constants.EMPTY ));
																							
																							lexID := IF(LEFT.requestedVersion IN DueDiligence.Constants.VALID_IND_ATTRIBUTE_VERSIONS, LEFT.individual.lexID, LEFT.business.lexID);
																							validLexID := STD.Str.Filter(lexID, DueDiligence.Constants.NUMERIC_VALUES);
																							
																							//Valid history date passed - if invalid should return 99999999 for current mode
																							validDate := DueDiligence.Common.checkInvalidDate((STRING)LEFT.historyDateYYYYMMDD, (STRING)DueDiligence.Constants.date8Nines);
																							
																							//Populate appropriate cleaned data	
																							busClean := IF(LEFT.requestedVersion IN DueDiligence.Constants.VALID_BUS_ATTRIBUTE_VERSIONS, 
																																							DATASET([TRANSFORM(DueDiligence.Layouts.Busn_Input,
																																																	SELF.lexID := validLexID;
																																																	SELF.companyName := companyName;
																																																	SELF.altCompanyName := altCompanyName;
																																																	SELF.address := addressClean;
																																																	SELF.phone := validPhone;
																																																	SELF.fein := validTaxID;
																																																	SELF := LEFT.business;
																																																	SELF := [];)]),
																																							DATASET([], DueDiligence.Layouts.Busn_Input));
																						
																							indClean := IF(LEFT.requestedVersion IN DueDiligence.Constants.VALID_IND_ATTRIBUTE_VERSIONS,
																																							DATASET([TRANSFORM(DueDiligence.Layouts.Indv_Input,
																																																	SELF.lexID := validLexID;
																																																	SELF.name := DATASET([TRANSFORM(DueDiligence.Layouts.Name,
																																																																	unparsedName := STD.Str.ToUpperCase(LEFT.individual.name.fullName);
																																																																	fName := STD.Str.ToUpperCase(LEFT.individual.name.firstName);
																																																																	mName := STD.Str.ToUpperCase(LEFT.individual.name.middleName);
																																																																	lName := STD.Str.ToUpperCase(LEFT.individual.name.lastName);
																																																																	sName := STD.Str.ToUpperCase(LEFT.individual.name.suffix);
																																																																	
																																																																	
																																																																	cleanedName := MAP(STD.Str.ToUpperCase(LEFT.individual.nameInputOrder) = 'FML' => Address.CleanPersonFML73(unparsedName),
																																																																										 STD.Str.ToUpperCase(LEFT.individual.nameInputOrder) = 'LFM' => Address.CleanPersonLFM73(unparsedName),
																																																																										 Address.CleanPerson73(unparsedName));	
																														
																																																																	cleanedFirst := IF(unparsedName <> DueDiligence.Constants.EMPTY, STD.Str.ToUpperCase(cleanedName[6..25]), DueDiligence.Constants.EMPTY);
																																																																	cleanedMiddle := IF(unparsedName <> DueDiligence.Constants.EMPTY, STD.Str.ToUpperCase(cleanedName[26..45]), DueDiligence.Constants.EMPTY);
																																																																	cleanedLast := IF(unparsedName <> DueDiligence.Constants.EMPTY, STD.Str.ToUpperCase(cleanedName[46..65]), DueDiligence.Constants.EMPTY);
																																																																	cleanedSuffix := IF(unparsedName <> DueDiligence.Constants.EMPTY, STD.Str.ToUpperCase(cleanedName[66..70]), DueDiligence.Constants.EMPTY);
																																																									
																																																																	SELF.fullName := unparsedName;
																																																																	SELF.firstName := IF(fName = DueDiligence.Constants.EMPTY, cleanedFirst, fName);
																																																																	SELF.middleName := IF(mName = DueDiligence.Constants.EMPTY, cleanedMiddle, mName);
																																																																	SELF.lastName := IF(lName = DueDiligence.Constants.EMPTY, cleanedLast, lName);
																																																																	SELF.suffix := IF(sName = DueDiligence.Constants.EMPTY, cleanedSuffix, sName);																															
																																																																	SELF := [];)])[1];
																																																	SELF.address := addressClean;
																																																	SELF.phone := validPhone;
																																																	SELF.ssn := validTaxID;
																																																	SELF := LEFT.individual;
																																																	SELF := [];)]),
																																							DATASET([], DueDiligence.Layouts.Indv_Input));

																							inputClean := DATASET([TRANSFORM(DueDiligence.Layouts.Input,
																																								SELF.business := busClean[1];
																																								SELF.individual := indClean[1];
																																								SELF.historyDateYYYYMMDD := (UNSIGNED)validDate;
																																								SELF.addressProvided := addrProvided;
																																								SELF.fullAddressProvided := fullAddrProvided;
																																								SELF := LEFT;
																																								SELF := [];)])[1];
																							
																							
																							SELF.cleanedInput := inputClean;
																							SELF.inputEcho := LEFT;
																							SELF := []));
			
				
				RETURN cleanData;
		END;
		
		
		EXPORT mac_GetBusinessOptionSettings(dppaIn, glbaIn, drmIn, dpmIn, industryIn) := MACRO
    
        industry := IF(TRIM(industryIn) = DueDiligence.Constants.EMPTY, Business_Risk_BIP.Constants.Default_IndustryClass, industryIn);
        
				
				busOptions := MODULE(Business_Risk_BIP.LIB_Business_Shell_LIBIN)
							// Clean up the Options and make sure that defaults are enforced
							EXPORT UNSIGNED1 DPPA_Purpose := dppaIn;
							EXPORT UNSIGNED1 GLBA_Purpose := glbaIn;
							EXPORT STRING50 DataRestrictionMask	:= TRIM(drmIn);
							EXPORT STRING50 DataPermissionMask	:= TRIM(dpmIn);
							EXPORT STRING10 IndustryClass := STD.Str.ToUpperCase(industry);
							EXPORT UNSIGNED1 LinkSearchLevel := Business_Risk_BIP.Constants.LinkSearch.SeleID;
							EXPORT UNSIGNED1 BusShellVersion := Business_Risk_BIP.Constants.Default_BusShellVersion;
							EXPORT UNSIGNED1 MarketingMode := Business_Risk_BIP.Constants.Default_MarketingMode;
							EXPORT STRING50 AllowedSources := Business_Risk_BIP.Constants.Default_AllowedSources;
							EXPORT UNSIGNED1 BIPBestAppend := Business_Risk_BIP.Constants.BIPBestAppend.OverwriteWithBest;
				END;

				busLinkingOptions := MODULE(BIPV2.mod_sources.iParams)
							EXPORT STRING DataRestrictionMask := busOptions.DataRestrictionMask; 
							EXPORT BOOLEAN ignoreFares := FALSE; // From AutoStandardI.DataRestrictionI, this is a User Configurable Input Option to Ignore FARES data - default it to FALSE to always utilize whatever the DataRestrictionMask allows
							EXPORT BOOLEAN ignoreFidelity := FALSE; // From AutoStandardI.DataRestrictionI, this is a User Configurable Input Option to Ignore Fidelity data - default it to FALSE to always utilize whatever the DataRestrictionMask allows
							EXPORT BOOLEAN AllowAll := FALSE;
							EXPORT BOOLEAN AllowGLB := Risk_Indicators.iid_constants.GLB_OK(busOptions.GLBA_Purpose, FALSE);
							EXPORT BOOLEAN AllowDPPA := Risk_Indicators.iid_constants.DPPA_OK(busOptions.DPPA_Purpose, FALSE);
							EXPORT UNSIGNED1 DPPAPurpose := busOptions.DPPA_Purpose;
							EXPORT UNSIGNED1 GLBPurpose := busOptions.GLBA_Purpose;
							EXPORT BOOLEAN IncludeMinors := TRUE; // Shouldn't really have an impact on business searches, set to TRUE for now
							EXPORT BOOLEAN LNBranded := TRUE; // Not entirely certain what effect this has
				END;		
		ENDMACRO;
		
		
		EXPORT GetIndividualAttributes(DATASET(DueDiligence.Layouts.Indv_Internal) results) := FUNCTION
				
				personAttributes := NORMALIZE(UNGROUP(results), DueDiligence.Constants.NUMBER_OF_INDIVIDUAL_ATTRIBUTES, TRANSFORM(iesp.share.t_NameValuePair,
																																	SELF := CASE(COUNTER,
																																								1  => DueDiligence.Common.createNVPair('PerAssetOwnProperty', LEFT.PerAssetOwnProperty),
																																								2  => DueDiligence.Common.createNVPair('PerAssetOwnAircraft', LEFT.PerAssetOwnAircraft),
																																								3  => DueDiligence.Common.createNVPair('PerAssetOwnWatercraft', LEFT.PerAssetOwnWatercraft),
																																								4  => DueDiligence.Common.createNVPair('PerAssetOwnVehicle', LEFT.PerAssetOwnVehicle),
																																								5  => DueDiligence.Common.createNVPair('PerAccessToFundsIncome', LEFT.PerAccessToFundsIncome),
                                                                                6  => DueDiligence.Common.createNVPair('PerAccessToFundsProperty', LEFT.PerAccessToFundsProperty),
																																								7  => DueDiligence.Common.createNVPair('PerGeographic', LEFT.PerGeographic),
																																								8  => DueDiligence.Common.createNVPair('PerMobility', LEFT.PerMobility),
																																								9  => DueDiligence.Common.createNVPair('PerLegalStateCriminal', LEFT.PerStateLegalEvent),
																																								10 => DueDiligence.Common.createNVPair('PerLegalFedCriminal', LEFT.PerFederalLegalEvent),
																																								11 => DueDiligence.Common.createNVPair('PerLegalCivil', LEFT.PerCivilLegalEvent),
																																								12 => DueDiligence.Common.createNVPair('PerLegalTypes', LEFT.PerOffenseType),
																																								13 => DueDiligence.Common.createNVPair('PerAgeRange', LEFT.PerAgeRange),
																																								14 => DueDiligence.Common.createNVPair('PerIdentityRisk', LEFT.PerIdentityRisk),
																																								15 => DueDiligence.Common.createNVPair('PerUSResidency', LEFT.PerUSResidency),
																																								16 => DueDiligence.Common.createNVPair('PerMatchLevel', LEFT.PerMatchLevel),
																																								17 => DueDiligence.Common.createNVPair('PerAssociates', LEFT.PerAssociates),
																																								18 => DueDiligence.Common.createNVPair('PerProfLicense', LEFT.PerProfLicense),
																																											DueDiligence.Common.createNVPair(DueDiligence.Constants.INVALID, DueDiligence.Constants.INVALID));));

	
	
				RETURN personAttributes;
		END;
		
		
		EXPORT GetIndividualAttributeFlags(DATASET(DueDiligence.Layouts.Indv_Internal) results) := FUNCTION
		
				personFlags := NORMALIZE(UNGROUP(results), DueDiligence.Constants.NUMBER_OF_INDIVIDUAL_ATTRIBUTES, TRANSFORM(iesp.share.t_NameValuePair,
																												SELF := CASE(COUNTER,
																																			1  => DueDiligence.Common.createNVPair('PerAssetOwnProperty_Flag', LEFT.PerAssetOwnProperty_Flag),
																																			2  => DueDiligence.Common.createNVPair('PerAssetOwnAircraft_Flag', LEFT.PerAssetOwnAircraft_Flag),
																																			3  => DueDiligence.Common.createNVPair('PerAssetOwnWatercraft_Flag', LEFT.PerAssetOwnWatercraft_Flag),
																																			4  => DueDiligence.Common.createNVPair('PerAssetOwnVehicle_Flag', LEFT.PerAssetOwnVehicle_Flag),
                                                                      5  => DueDiligence.Common.createNVPair('PerAccessToFundsIncome_Flag', LEFT.PerAccessToFundsIncome_Flag),
																																			6  => DueDiligence.Common.createNVPair('PerAccessToFundsProperty_Flag', LEFT.PerAccessToFundsProperty_Flag),
																																			7  => DueDiligence.Common.createNVPair('PerGeographic_Flag', LEFT.PerGeographic_Flag),
																																			8  => DueDiligence.Common.createNVPair('PerMobility_Flag', LEFT.PerMobility_Flag),
																																			9  => DueDiligence.Common.createNVPair('PerLegalStateCriminal_Flag', LEFT.PerStateLegalEvent_Flag),
																																			10 => DueDiligence.Common.createNVPair('PerLegalFedCriminal_Flag', LEFT.PerFederalLegalEvent_Flag),
																																			11 => DueDiligence.Common.createNVPair('PerLegalCivil_Flag', LEFT.PerCivilLegalEvent_Flag),
																																			12 => DueDiligence.Common.createNVPair('PerLegalTypes_Flag', LEFT.PerOffenseType_Flag),
																																			13 => DueDiligence.Common.createNVPair('PerAgeRange_Flag', LEFT.PerAgeRange_Flag),
																																			14 => DueDiligence.Common.createNVPair('PerIdentityRisk_Flag', LEFT.PerIdentityRisk_Flag),
																																			15 => DueDiligence.Common.createNVPair('PerUSResidency_Flag', LEFT.PerUSResidency_Flag),
																																			16 => DueDiligence.Common.createNVPair('PerMatchLevel_Flag', LEFT.PerMatchLevel_Flag),
																																			17 => DueDiligence.Common.createNVPair('PerAssociates_Flag', LEFT.PerAssociates_Flag),
																																			18 => DueDiligence.Common.createNVPair('PerProfLicense_Flag', LEFT.PerProfLicense_Flag),
																																						DueDiligence.Common.createNVPair(DueDiligence.Constants.INVALID, DueDiligence.Constants.INVALID));));
		
				RETURN personFlags;
		END;
		
		
		EXPORT GetBusinessAttributes(DATASET(DueDiligence.Layouts.Busn_Internal) results) := FUNCTION
        
        businessAttributes := NORMALIZE(UNGROUP(results), DueDiligence.Constants.NUMBER_OF_BUSINESS_ATTRIBUTES, TRANSFORM(iesp.share.t_NameValuePair,
																																			SELF := CASE(COUNTER,
																																										1  => DueDiligence.Common.createNVPair('BusAssetOwnProperty', LEFT.BusAssetOwnProperty),
																																										2  => DueDiligence.Common.createNVPair('BusAssetOwnAircraft', LEFT.BusAssetOwnAircraft),
																																										3  => DueDiligence.Common.createNVPair('BusAssetOwnWatercraft', LEFT.BusAssetOwnWatercraft),
																																										4  => DueDiligence.Common.createNVPair('BusAssetOwnVehicle', LEFT.BusAssetOwnVehicle),
																																										5  => DueDiligence.Common.createNVPair('BusAccessToFundsProperty', LEFT.BusAccessToFundsProperty),
																																										6  => DueDiligence.Common.createNVPair('BusGeographic', LEFT.BusGeographic),
																																										7  => DueDiligence.Common.createNVPair('BusValidity', LEFT.BusValidity),
																																										8  => DueDiligence.Common.createNVPair('BusStability', LEFT.BusStability),
																																										9  => DueDiligence.Common.createNVPair('BusIndustry', LEFT.BusIndustry),
																																										10 => DueDiligence.Common.createNVPair('BusStructureType', LEFT.BusStructureType),
																																										11 => DueDiligence.Common.createNVPair('BusSOSAgeRange', LEFT.BusSOSAgeRange),
																																										12 => DueDiligence.Common.createNVPair('BusPublicRecordAgeRange', LEFT.BusPublicRecordAgeRange),
																																										13 => DueDiligence.Common.createNVPair('BusShellShelf', LEFT.BusShellShelf),
																																										14 => DueDiligence.Common.createNVPair('BusMatchLevel', LEFT.BusMatchLevel),
																																										15 => DueDiligence.Common.createNVPair('BusLegalStateCriminal', LEFT.BusStateLegalEvent),
																																										16 => DueDiligence.Common.createNVPair('BusLegalFedCriminal', LEFT.BusFederalLegalEvent),
																																										17 => DueDiligence.Common.createNVPair('BusLegalCivil', LEFT.BusCivilLegalEvent),
																																										18 => DueDiligence.Common.createNVPair('BusLegalTypes', LEFT.BusOffenseType),
																																										19 => DueDiligence.Common.createNVPair('BusBEOProfLicense', LEFT.BusBEOProfLicense),
																																										20 => DueDiligence.Common.createNVPair('BusBEOUSResidency', LEFT.BusBEOUSResidency),
																																													DueDiligence.Common.createNVPair(DueDiligence.Constants.INVALID, DueDiligence.Constants.INVALID));));
																																																							
				
				RETURN businessAttributes;
		END;
		
		
		EXPORT GetBusinessAttributeFlags(DATASET(DueDiligence.Layouts.Busn_Internal) results) := FUNCTION
			
      businessFlags := NORMALIZE(UNGROUP(results), DueDiligence.Constants.NUMBER_OF_BUSINESS_ATTRIBUTES, TRANSFORM(iesp.share.t_NameValuePair,
																													SELF := CASE(COUNTER,
																																				1  => DueDiligence.Common.createNVPair('BusAssetOwnProperty_Flag', LEFT.BusAssetOwnProperty_Flag),
																																				2  => DueDiligence.Common.createNVPair('BusAssetOwnAircraft_Flag', LEFT.BusAssetOwnAircraft_Flag),
																																				3  => DueDiligence.Common.createNVPair('BusAssetOwnWatercraft_Flag', LEFT.BusAssetOwnWatercraft_Flag),
																																				4  => DueDiligence.Common.createNVPair('BusAssetOwnVehicle_Flag', LEFT.BusAssetOwnVehicle_Flag),
																																				5  => DueDiligence.Common.createNVPair('BusAccessToFundsProperty_Flag', LEFT.BusAccessToFundsProperty_Flag),
																																				6  => DueDiligence.Common.createNVPair('BusGeographic_Flag', LEFT.BusGeographic_Flag),
																																				7  => DueDiligence.Common.createNVPair('BusValidity_Flag', LEFT.BusValidity_Flag),
																																				8  => DueDiligence.Common.createNVPair('BusStability_Flag', LEFT.BusStability_Flag),
																																				9  => DueDiligence.Common.createNVPair('BusIndustry_Flag', LEFT.BusIndustry_Flag),
																																				10 => DueDiligence.Common.createNVPair('BusStructureType_Flag', LEFT.BusStructureType_Flag),
																																				11 => DueDiligence.Common.createNVPair('BusSOSAgeRange_Flag', LEFT.BusSOSAgeRange_Flag),
																																				12 => DueDiligence.Common.createNVPair('BusPublicRecordAgeRange_Flag', LEFT.BusPublicRecordAgeRange_Flag),
																																				13 => DueDiligence.Common.createNVPair('BusShellShelf_Flag', LEFT.BusShellShelf_Flag),
																																				14 => DueDiligence.Common.createNVPair('BusMatchLevel_Flag', LEFT.BusMatchLevel_Flag),
																																				15 => DueDiligence.Common.createNVPair('BusLegalStateCriminal_Flag', LEFT.BusStateLegalEvent_Flag),
																																				16 => DueDiligence.Common.createNVPair('BusLegalFedCriminal_Flag', LEFT.BusFederalLegalEvent_Flag),
																																				17 => DueDiligence.Common.createNVPair('BusLegalCivil_Flag', LEFT.BusCivilLegalEvent_Flag),
																																				18 => DueDiligence.Common.createNVPair('BusLegalTypes_Flag', LEFT.BusOffenseType_Flag),
																																				19 => DueDiligence.Common.createNVPair('BusBEOProfLicense_Flag', LEFT.BusBEOProfLicense_Flag),
																																				20 => DueDiligence.Common.createNVPair('BusBEOUSResidency_Flag', LEFT.BusBEOUSResidency_Flag),
																																							DueDiligence.Common.createNVPair(DueDiligence.Constants.INVALID, DueDiligence.Constants.INVALID));));
												
				RETURN businessFlags;
		END;


		EXPORT mac_GetESPReturnData(inputWithSeq, results, iespLayout, indvOrBus, includeReport, attrs, attrsFlags, reqVersion) := FUNCTIONMACRO
				
				returnData := JOIN(inputWithSeq, results, 
														LEFT.seq = RIGHT.seq,
														TRANSFORM({UNSIGNED seq, iespLayout},			//TEMP ADDING SEQ
																			SELF.result.inputecho := LEFT.reportBy;	
																			SELF.result.AttributeGroup.attributes :=  attrs;
																			SELF.result.AttributeGroup.AttributeLevelHits := attrsFlags;
																			SELF.result.AttributeGroup.Name := reqVersion;
																			
																			#EXPAND(IF(indvOrBus = DueDiligence.Constants.BUSINESS,
																															'SELF.result.businessID := (STRING)RIGHT.busn_info.BIP_IDs.SeleID.LinkID;',
																															DueDiligence.Constants.EMPTY))
																			#EXPAND(IF(indvOrBus = DueDiligence.Constants.BUSINESS AND includeReport = DueDiligence.Constants.STRING_TRUE,
																															'SELF.result.BusinessReport := RIGHT.BusinessReport;',
																															DueDiligence.Constants.EMPTY))
																			
																			#EXPAND(IF(indvOrBus = DueDiligence.Constants.INDIVIDUAL,
																															'SELF.result.uniqueID := (STRING)RIGHT.individual.did;',
																															DueDiligence.Constants.EMPTY))	
                                      #EXPAND(IF(indvOrBus = DueDiligence.Constants.INDIVIDUAL AND includeReport = DueDiligence.Constants.STRING_TRUE,
																															'SELF.result.PersonReport := RIGHT.personReport;',
																															DueDiligence.Constants.EMPTY))
																															
																															
																															
																															
																			SELF := LEFT;
																			SELF := [];));																																		
				
				RETURN returnData;
		ENDMACRO;
END;