IMPORT Address, Business_Header, DueDiligence, iesp, STD;

EXPORT Common := MODULE

  EXPORT ValidateInput(DATASET(DueDiligence.Layouts.Input) input, UNSIGNED1 glbPurpose, UNSIGNED1 dppaPurpose, STRING15 modelName):= FUNCTION
  
        BOOLEAN ValidGLB := DueDiligence.CitDDShared.isValidGLBA(glbPurpose);
				BOOLEAN ValidDPPA := DueDiligence.CitDDShared.isValidDPPA(dppaPurpose);
        
        BOOLEAN validModel := STD.Str.ToUpperCase(modelName) IN Citizenship.Constants.VALID_MODEL_NAMES;

				validatedRequests := PROJECT(input, TRANSFORM(DueDiligence.Layouts.Input,
																											//Validate the request
																											ValidIndividual := DueDiligence.CitDDShared.validateIndividual(LEFT.individual);
                                                      
                                                      STRING OhNoMessage := MAP(validModel = FALSE => Citizenship.Constants.VALIDATION_INVALID_MODEL_NAME,
                                                                                ValidIndividual = FALSE => Citizenship.Constants.VALIDATION_INVALID_INDIVIDUAL,
                                                                                ValidGLB = FALSE => DueDiligence.CitDDShared.VALIDATION_INVALID_GLB,
                                                                                ValidDPPA = FALSE => DueDiligence.CitDDShared.VALIDATION_INVALID_DPPA,
                                                                                DueDiligence.Constants.EMPTY);
                                                      
																											

																											
																											SELF.validRequest := OhNoMessage = DueDiligence.Constants.EMPTY;
																											SELF.errorMessage := OhNoMessage;
                                                      
                                                      SELF := LEFT;));
                                                      
        RETURN validatedRequests;
  END;
  
  
  EXPORT CleanData(DATASET(DueDiligence.Layouts.Input) input) := FUNCTION
      
      cleanData := PROJECT(input, TRANSFORM(DueDiligence.Layouts.CleanedData,  
                                            //Clean Address
                                            addressClean := DueDiligence.CitDDShared.cleanAddress(LEFT.individual.address);
                                            
                                            //Remove any non-numeric fiends from phone, taxID, and lexID fields
                                            phoneToClean := DueDiligence.CitDDShared.stripNonNumericValues(LEFT.individual.phone);
                                            phone2ToClean := DueDiligence.CitDDShared.stripNonNumericValues(LEFT.phone2);
                                            
                                            validSSN := DueDiligence.CitDDShared.stripNonNumericValues(LEFT.individual.ssn);
                                            
                                            validDate := DueDiligence.Common.checkInvalidDate((STRING)LEFT.historyDateYYYYMMDD, (STRING)DueDiligence.Constants.date8Nines);
                                            
                                            indClean := DATASET([TRANSFORM(DueDiligence.Layouts.Indv_Input,
                                                                            SELF.name := DATASET([TRANSFORM(DueDiligence.Layouts.Name,
                                                                                                            DueDiligence.CitDDShared.mapFullName();																														
                                                                                                            SELF := [];)])[1];
                                                                            SELF.address := addressClean;
                                                                            SELF.phone := phoneToClean;
                                                                            SELF.ssn := validSSN;
                                                                            SELF := LEFT.individual;
                                                                            SELF := [];)]);

																					  inputClean := DATASET([TRANSFORM(DueDiligence.Layouts.Input,
                                                                              SELF.individual := indClean[1];
                                                                              SELF.historyDateYYYYMMDD := (UNSIGNED)validDate;
                                                                              SELF.phone2 := phone2ToClean;
                                                                              SELF.dlNumber := LEFT.dlNumber;
                                                                              SELF.dlState := LEFT.dlState;
                                                                              SELF := LEFT;
                                                                              SELF := [];)])[1];
																							
																							
																						SELF.cleanedInput := inputClean;
                                            SELF.inputEcho := LEFT;
                                            SELF := []));
      
      RETURN cleanData;
  END;
  
  
  EXPORT createNVPair(STRING name, INTEGER val) := FUNCTION
			
			iesp.share.t_NameValuePair createPair(STRING n, INTEGER v) := TRANSFORM
				SELF.Name := n;
				SELF.Value := (STRING)v;
			END;
			
			RETURN ROW(createPair(name, val));			
	END;

END;