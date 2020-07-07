IMPORT DueDiligence, Risk_Indicators, STD, ut;

EXPORT getInd(DATASET(DueDiligence.LayoutsInternal.SharedInput) sharedInput) := FUNCTION

    //convert the incoming data to the DueDiligence.Layouts.Indv_Internal used
    //for processing an individual - will be dropping the boca shell and risk indicators
    inquiredInd := PROJECT(sharedInput, TRANSFORM(DueDiligence.Layouts.Indv_Internal,
    
                                                  historyDate := IF(LEFT.cleanedinput.historyDateYYYYMMDD = DueDiligence.Constants.date8Nines, STD.Date.Today(), LEFT.cleanedinput.historyDateYYYYMMDD);
                                                  
                                                  SELF.seq := LEFT.cleanedInput.seq;
                                                  SELF.indvRawInput.lexID := LEFT.inputEcho.individual.lexID ;
                                                  SELF.indvRawInput.accountNumber := LEFT.inputEcho.individual.accountNumber ;
                                                  SELF.indvRawInput.address := LEFT.inputEcho.individual.address ;
                                                  SELF.indvRawInput.phone := LEFT.inputEcho.individual.phone ;
                                                  SELF.indvRawInput.inputSeq := LEFT.inputEcho.individual.inputSeq ;
                                                  SELF.indvRawInput.nameInputOrder := LEFT.inputEcho.individual.nameInputOrder ;
                                                  SELF.indvRawInput.name := LEFT.inputEcho.individual.name ;
                                                  SELF.indvRawInput.ssn := LEFT.inputEcho.individual.ssn ;
                                                  SELF.indvRawInput.dob := LEFT.inputEcho.individual.dob ;
                                                  SELF.indvRawInput.cleanAddress := LEFT.cleanedInput.individual.address;

                                                  SELF.historyDateRaw := LEFT.cleanedinput.historyDateYYYYMMDD;
                                                  SELF.historyDate := historyDate;
                                                  SELF.indvType := DueDiligence.Constants.INQUIRED_INDIVIDUAL;
                                                  
                                                  SELF.inquiredDID := LEFT.dataToUse.did;
                                                  SELF.individual.did := LEFT.dataToUse.did;
                                                  SELF.individual.score := LEFT.dataToUse.lexIDScore;
                                                  SELF.individual.ssn := LEFT.dataToUse.ssn;
                                                  SELF.individual.dob := (UNSIGNED4)LEFT.dataToUse.dob;
                                                  SELF.individual.phone := LEFT.dataToUse.phone;
                                                  
                                                  SELF.individual := LEFT.dataToUse.name;
                                                  SELF.individual := LEFT.dataToUse.address;
                                                  
                                                  SELF.inputaddressprovided := LEFT.cleanedInput.addressProvided;
                                                  SELF.fullinputaddressprovided := LEFT.cleanedInput.fullCleanAddressExists;
                                                  
                                                  SELF.bestSSN := LEFT.dataToUse.ssn;
                                                  SELF.bestPhone := LEFT.dataToUse.phone;
                                                  SELF.bestDOB := (UNSIGNED4)LEFT.dataToUse.dob;
                                                  
                                                  SELF.bestName := LEFT.dataToUse.name;
                                                  SELF.bestAddress := LEFT.dataToUse.bestAddress;
                                                  
                                                  
                                                  validDOB := DueDiligence.CommonDate.IsValidDate((UNSIGNED4)LEFT.dataToUse.dob);
                                                  validHistDate := STD.Date.IsValidDate(historyDate);
                                                  
                                                  SELF.estimatedAge := IF(validDOB AND validHistDate, ut.Age((UNSIGNED4)LEFT.dataToUse.dob, historyDate), 0);
                                                  
                                                  //pull any necessary fields needed for processing from the boca shell
                                                  SELF.bs_bestSSNDecsFlag := LEFT.bs.best_flags.best_ssn_decsflag;
                                                  SELF.bs_bestSSNValid := LEFT.bs.best_flags.best_ssn_valid;
                                                  SELF.bs_lexIDDeceased := LEFT.bs.iid.diddeceased;
                                                  SELF.bs_bestSSNSSNDOBFlag := LEFT.bs.best_flags.best_ssn_ssndobflag;
                                                  SELF.bs_adlsPerSSN := LEFT.bs.velocity_counters.adls_per_ssn_seen_18months;
                                                  SELF.bs_adlPerBestSSN := LEFT.bs.best_flags.adls_per_bestssn;
                                                  SELF.bs_bestSSN := LEFT.bs.best_flags.ssn;
                                                  SELF.bs_iidSocsValFlag := LEFT.bs.iid.socsvalflag;
                                                  SELF.bs_iidPwSocsValFlag := LEFT.bs.iid.pwsocsvalflag;
                                                  SELF.bs_inputSocsCharFlag := LEFT.bs.ssn_verification.validation.inputsocscharflag;  
                                                  
                                                  
                                                  //fields for the Identity Report
                                                  SELF.inputSSNDetails.ssn := LEFT.inputEcho.individual.ssn;
                                                  SELF.inputSSNDetails.issuedLowDate := LEFT.bs.SSN_Verification.Validation.low_issue_date;
                                                  SELF.inputSSNDetails.issuedHighDate := LEFT.bs.SSN_Verification.Validation.high_issue_date;
                                                  SELF.inputSSNDetails.issuedState := LEFT.bs.SSN_Verification.Validation.issue_state;
                                                  SELF.inputSSNDetails.randomized := Risk_Indicators.rcSet.isCodeRS(LEFT.inputEcho.individual.ssn, LEFT.bs.iid.socsvalflag, LEFT.bs.iid.socllowissue, LEFT.bs.iid.socsrcisflag);
                                                  
                                                  ssnOnFile := DueDiligence.Common.GetStringListAsDataset(LEFT.bs.header_summary.ssns_on_file);
                                                  SELF.ssnOnFile := PROJECT(ssnOnFile(info <> DueDiligence.Constants.EMPTY), TRANSFORM({STRING9 ssn}, SELF.ssn := LEFT.info;));
                                                  
                                                  SELF.bestSSNDetails.ssn := LEFT.dataToUse.ssn;
                                                  
                                                  dobOnFile := DueDiligence.Common.GetStringListAsDataset(LEFT.bs.header_summary.dobs_on_file);
                                                  SELF.dobOnFile := PROJECT(dobOnFile(info <> DueDiligence.Constants.EMPTY), TRANSFORM({STRING8 dob}, SELF.dob := LEFT.info;));
                                                                                                 
                                               
                                                  
                                                  //pull any necessary fields needed for processing from the Citizenship risk indicators
                                                  SELF.cit_inputSSNReportedDeceased := LEFT.riskIndicators.inputssnreporteddeceased;
                                                  SELF.cit_inputSSNInvalid := LEFT.riskIndicators.inputssninvalid;
                                                  SELF.cit_inputSSNIssuePriorToDOB := LEFT.riskIndicators.inputssnissuedpriordob;
                                                  SELF.cit_inputSSNRandomIssuedInvalid := LEFT.riskIndicators.inputssnrandomissuedinvalid;
                                                  SELF.cit_lexIDMultipleSSNs := LEFT.riskIndicators.lexidmultiplessns;
                                                  SELF.cit_lexIDBestSSNInvalid := LEFT.riskIndicators.lexidbestssninvalid;
                                                  SELF.cit_lexIDReportedDeceased := LEFT.riskIndicators.lexidreporteddeceased;
                                                  SELF.cit_lastReportedByAnySource := LEFT.riskIndicators.lastReportedByAnySource;
                                                  SELF.cit_inputSSNITIN := LEFT.riskIndicators.inputSSNITIN;
                                                  SELF.cit_lexID := LEFT.riskIndicators.lexID;

                                                  SELF := [];));
                                                  
    RETURN inquiredInd;

END;