IMPORT DueDiligence, Risk_Indicators, std, Models, MDR, dx_header;

EXPORT getRiskIndicators(DATASET(DueDiligence.Layouts.CleanedData) cleanedInput, DATASET(Risk_Indicators.Layout_Boca_Shell) clam) := FUNCTION


  NULL       := Models.common.NULL;
  NEG1       := -1;
  MAX_SCORE  := 999;
  COMMA      := '  ,';
  MODIFIER   := 'ie';
  DAYSINYEAR := 365.25;
  MOSINYEAR  := 12;  
  
//========================================================================================

  indicators := JOIN(cleanedInput, clam, 
                      LEFT.inputEcho.seq = RIGHT.seq, 
                      TRANSFORM({DueDiligence.Citizenship.Layouts.IndicatorLayout, UNSIGNED8 shell_dob_SAS;}, 
                                SELF.seq := LEFT.inputEcho.seq;
                                SELF.inputSeq := IF(LEFT.inputEcho.inputSeq = DueDiligence.Constants.NUMERIC_ZERO, LEFT.inputEcho.seq, LEFT.inputEcho.inputSeq);
                                SELF.acctNo := LEFT.inputEcho.individual.accountNumber;
                                SELF.lexID := RIGHT.did;
                                SELF.lexIDScore := RIGHT.Name_Verification.adl_score;
                                
                                
                                shellInputDOB := RIGHT.shell_input.dob;
                                shellInputSSN := RIGHT.shell_input.ssn;
                                inferredAge := RIGHT.inferred_age;
                                ssnlength := RIGHT.input_validation.ssn_length;
                                
                                notTrueDID := NOT(RIGHT.TrueDID);


                                sysdate := Models.common.sas_date(IF(RIGHT.historydate=999999, (STRING)std.date.today(), (STRING6)RIGHT.historydate+'01'));

                                //extract the dates needed from the Ver Source Sections of Boca Shell
                                ver_sources_information := DueDiligence.Citizenship.Ver_source_Function(RIGHT.header_summary.ver_sources, 
                                                                                                        RIGHT.header_summary.ver_sources_first_seen_date,
                                                                                                        RIGHT.header_summary.ver_sources_last_seen_date);




                                //identityAge (capped at 110 years)
                                verificationAge := MAP(notTrueDID => NEG1,
                                                            RIGHT.name_verification.age = 0 => 0,
                                                            RIGHT.name_verification.age); 
                                                            
                                identityAge := MIN(verificationAge, DueDiligence.Citizenship.Constants.AGE_CAP);
                                SELF.identityAge := IF(identityAge <= 0, NEG1, identityAge);  
                                
                                


                                //emergenceAgeHeader (capped at 110 years)                                                   
                                earliestHeaderDate := (INTEGER)ver_sources_information[1..10];  
                                earliestHeaderYrs := IF(earliestHeaderDate = NULL OR sysdate = NULL, NULL, TRUNCATE((sysdate - earliestHeaderDate) / DAYSINYEAR));
                                
                                sasShellDOB := Models.common.sas_date((STRING)(shellInputDOB));
                                SELF.shell_dob_SAS := sasShellDOB;  //save for the next step 
                                
                                
                                calc_dob := IF(sasShellDOB = NULL OR sysdate = NULL, NULL, TRUNCATE((sysdate - sasShellDOB) / DAYSINYEAR));
                                headerEmergenceAge := MAP(notTrueDID OR earliestHeaderYrs = NULL => NULL,    
                                                          NOT(sasShellDOB = NULL) => calc_dob - earliestHeaderYrs,
                                                          inferredAge = 0 => NULL,
                                                          inferredAge - earliestHeaderYrs);
                                                                                    
                                minHeaderEmergenceAge := MIN(headerEmergenceAge, DueDiligence.Citizenship.Constants.AGE_CAP);                                                           
                                SELF.emergenceAgeHeader := IF(minHeaderEmergenceAge = NULL OR minHeaderEmergenceAge < 0, NEG1, minHeaderEmergenceAge);  
                                
                                


                                //emergenceAgeBureau   (capped at 110 years)
                                earliestBureauDate := (INTEGER)ver_sources_information[12..21];  //-99999999 will be returned if there no bureau sources  
                                                                                                                                    
                                earliestBureauYrs := IF(earliestBureauDate = NULL OR sysdate = NULL, NULL, TRUNCATE((sysdate - earliestBureauDate) / DAYSINYEAR));                                                        
                                bureauEmergenceAage := MAP(notTrueDID OR earliestBureauYrs = NULL => NULL,
                                                            NOT(calc_dob = NULL) => calc_dob - earliestBureauYrs,
                                                            inferredAge = 0 => NULL,
                                                            inferredAge - earliestBureauYrs);

                                minBureauEmergenceAge := MIN(bureauEmergenceAage, DueDiligence.Citizenship.Constants.AGE_CAP);                                                           
                                SELF.emergenceAgeBureau := IF(minBureauEmergenceAge = NULL OR minBureauEmergenceAge < 0, NEG1, minBureauEmergenceAge);   
                                
                                


                                //ssnIssuanceAge (capped at 110 years)
                                rc_ssnlowissue := (UNSIGNED)RIGHT.iid.socllowissue;
                                sasSSNLowIssue := Models.common.sas_date((STRING)(rc_ssnlowissue));
                                ssn_years := IF(sasSSNLowIssue = NULL OR sysdate = NULL, NULL, TRUNCATE((sysdate - sasSSNLowIssue) / DAYSINYEAR));
                                nf_age_at_ssn_issuance_temp := MAP(NOT(RIGHT.truedid AND (ssnlength IN ['4', '9'])) OR 
                                                                   sysdate = NULL OR ssn_years = NULL => NULL,
                                                                   rc_ssnlowissue = DueDiligence.Citizenship.Constants.RANDOMIZATION_STARTED => NULL,
                                                                   NOT(calc_dob = NULL) => calc_dob - ssn_years,
                                                                   inferredAge = 0  => NULL,
                                                                   inferredAge - ssn_years);
                                                                   
                                nf_age_at_ssn_issuance := MIN(nf_age_at_ssn_issuance_temp, DueDiligence.Citizenship.Constants.AGE_CAP);                                                           
                                SELF.ssnIssuanceAge := IF(nf_age_at_ssn_issuance = NULL OR nf_age_at_ssn_issuance < 0,  NEG1, nf_age_at_ssn_issuance);  
                                
                                


                                //ssnIssuanceYears (capped at 110 years)
                                ssn_years_capped := MIN(ssn_years, DueDiligence.Citizenship.Constants.AGE_CAP);
                                SELF.ssnIssuanceYears := IF(ssn_years_capped = NULL OR ssn_years_capped < 0, NEG1, ssn_years_capped);  
                                
                                
                                //relativeCount
                                SELF.relativeCount := IF(notTrueDID, NEG1, MIN(RIGHT.relatives.relative_count, MAX_SCORE));  
                                
                                


                                //ver_voterRecords
                                ver_dob_sources := RIGHT.header_summary.ver_dob_sources;
                                ver_dob_src_vo_pos := Models.Common.findw_cpp(ver_dob_sources, MDR.SourceTools.src_Voters_v2 , COMMA, MODIFIER);
                                ver_dob_src_vo := ver_dob_src_vo_pos > 0;
                                SELF.ver_voterRecords := IF(shellInputDOB = DueDiligence.Constants.EMPTY OR (UNSIGNED)shellInputDOB = 0, NEG1, (INTEGER)ver_dob_src_vo);  
                                
                                


                                //ver_insuranceRecords
                                phone_ver_insurance := RIGHT.insurance_phones_summary.Insurance_Phone_Verification;
                                nf_phone_ver_insurance := IF(notTrueDID, NULL, (INTEGER)phone_ver_insurance);
                                SELF.ver_insuranceRecords := IF(nf_phone_ver_insurance = NULL, NEG1, nf_phone_ver_insurance);  
                                
                                


                                //ver_StudentFile  
                                ver_src_sl_pos := Models.Common.findw_cpp(RIGHT.header_summary.ver_sources, MDR.SourceTools.src_American_Students_List , COMMA, MODIFIER);
                                ver_src_nas_sl := IF(ver_src_sl_pos > 0, (REAL)Models.Common.getw(RIGHT.header_summary.ver_sources_nas, ver_src_sl_pos), 0);
                                SELF.ver_studentFile := IF(shellInputSSN = DueDiligence.Constants.EMPTY AND
                                                           RIGHT.shell_input.fname = DueDiligence.Constants.EMPTY AND
                                                           RIGHT.shell_input.lname = DueDiligence.Constants.EMPTY AND
                                                           RIGHT.shell_input.in_streetAddress = DueDiligence.Constants.EMPTY AND
                                                           RIGHT.shell_input.in_city = DueDiligence.Constants.EMPTY AND
                                                           RIGHT.shell_input.in_state = DueDiligence.Constants.EMPTY AND
                                                           RIGHT.shell_input.in_zipCode = DueDiligence.Constants.EMPTY, NEG1, ver_src_nas_sl);  
                                
                                


                                //firstSeenAddr10
                                add_curr_pop := RIGHT.addrPop2;
                                addrs_10yr := RIGHT.other_address_info.addrs_last_10years;
                                rv_c14_addrs_10yr := MAP(notTrueDID => NULL,
                                                         (INTEGER)add_curr_pop = 0 => NULL,
                                                         MIN(IF(addrs_10yr = NULL, -NULL, addrs_10yr), 999));
                                                         
                                SELF.firstSeenAddr10 := IF(rv_c14_addrs_10yr = NULL, NEG1, rv_c14_addrs_10yr);  
                                
                                


                                //reportedCurAddressYears
                                add_curr_lres := TRUNCATE(RIGHT.lres2/ MOSINYEAR);  //start with the number of months listed on the boca shell convert to years
                                yr_c13_curr_addr_lres := IF(NOT(RIGHT.truedid AND add_curr_pop), NULL, MIN(IF(add_curr_lres = NULL, -NULL, add_curr_lres), 999));
                                SELF.reportedCurAddressYears := IF(yr_c13_curr_addr_lres = NULL, NEG1, yr_c13_curr_addr_lres);  
                                
                                


                                //addressFirstReportedAge - calculated after picking more information from the address hierarchy key   
                                SELF.addressFirstReportedAge := -1;

                                num_of_cred_sources := ver_sources_information[34..36];
                                last_seen_credentialed_SAS := ver_sources_information[23..32];
                                last_seen_by_cred_source := (INTEGER)last_seen_credentialed_SAS;

                                YRSinceLastReportedCredential := MAP(notTrueDID => NULL,
                                                                     last_seen_by_cred_source = NULL => NULL,
                                                                     (INTEGER)num_of_cred_sources > 0 => TRUNCATE((sysdate - last_seen_by_cred_source) / DAYSINYEAR),
                                                                     NULL);  
                                
                                


                                //timeSinceLastReportedNonBureau 
                                //ATTENTION - SHOULD the name of this indicator needs to be changed to TimeSinceLastReportedCredentialed
                                SELF.timeSinceLastReportedNonBureau := IF(YRSinceLastReportedCredential = NULL, NEG1, YRSinceLastReportedCredential);  
                                
                                
                                //Using the Boca Shell and Risk_Indicators.rcSet.isCode__ to set a true of false value for each
                                //Use RS Reason code logic
                                SELF.inputSSNRandomlyIssued := IF(shellInputSSN = DueDiligence.Constants.EMPTY, NEG1, IF(Risk_Indicators.rcSet.isCodeRS(shellInputSSN, RIGHT.iid.socsvalflag, RIGHT.iid.socllowissue, RIGHT.iid.socsRCISflag), 1, 0));  
                                
                                
                                //Use IS Reason code logic
                                SELF.inputSSNRandomIssuedInvalid := IF(shellInputSSN = DueDiligence.Constants.EMPTY, NEG1, IF(Risk_Indicators.rcSet.isCodeIS(shellInputSSN, RIGHT.iid.socsvalflag, RIGHT.iid.socllowissue, RIGHT.iid.socsRCISflag), 1, 0));  
                                
                                
                                //Use 85 Reason Code logic 
                                SELF.inputSSNIssuedToNonUS := IF(shellInputSSN = DueDiligence.Constants.EMPTY, NEG1, IF(Risk_Indicators.rcSet.isCode85(shellInputSSN, RIGHT.iid.socllowissue), 1, 0));  
                                
                                
                                //Use IT Reason Code logic
                                SELF.inputSSNITIN := IF(shellInputSSN = DueDiligence.Constants.EMPTY, NEG1, IF(Risk_Indicators.rcSet.isCodeIT(shellInputSSN), 1, 0));   
                                
                                


                                //inputSSNInvalid 
                                rc_ssnvalflag := RIGHT.iid.socsvalflag;
                                rc_pwssnvalflag := RIGHT.iid.pwsocsvalflag;
                                inputssncharflag := RIGHT.ssn_verification.validation.inputsocscharflag;
                                rv_s65_ssn_invalid := MAP(NOT(ssnlength > '0') => NULL,
                                                          rc_ssnvalflag = '1' OR (rc_pwssnvalflag IN ['1', '2', '3']) OR (inputssncharflag IN ['1', '2', '3']) => 1,
                                                          rc_ssnvalflag = '0' OR (rc_pwssnvalflag IN ['0', '4', '5']) OR (inputssncharflag IN ['0', '4', '5']) => 0,
                                                          NULL);
                                                          
                                SELF.inputSSNInvalid := IF(rv_s65_ssn_invalid = NULL, NEG1, rv_s65_ssn_invalid);  
                                
                                


                                //inputSSNIssuedPriorDOB
                                dobpop := RIGHT.input_validation.dateofbirth;
                                rc_pwssndobflag := RIGHT.iid.pwsocsdobflag;
                                rc_ssndobflag := RIGHT.iid.socsdobflag;
                                rv_s65_ssn_prior_dob := MAP(NOT(ssnlength > '0' AND dobpop) => NULL,
                                                            rc_ssndobflag = '1' OR rc_pwssndobflag = '1' => 1,
                                                            rc_ssndobflag = '0' OR rc_pwssndobflag = '0' => 0,
                                                            NULL);
                                                            
                                SELF.inputSSNIssuedPriorDOB := IF(rv_s65_ssn_prior_dob = NULL, NEG1, rv_s65_ssn_prior_dob);  
                                
                                


                                //Use MI Reason code logic     
                                SELF.inputSSNAssociatedMultLexIDs := IF(shellInputSSN = DueDiligence.Constants.EMPTY, NEG1, IF(Risk_Indicators.rcSet.isCodeMI(RIGHT.velocity_counters.adls_per_ssn_seen_18months), 1, 0));  
                                
                                
                                //Use O2 Reason code logic
                                SELF.inputSSNReportedDeceased:= IF(shellInputSSN = DueDiligence.Constants.EMPTY, NEG1, IF(Risk_Indicators.rcSet.isCode02(RIGHT.iid.decsflag), 1, 0));   
                                
                                
                                //Use CL Reason code logic
                                SELF.inputSSNNotPrimaryLexID := IF(shellInputSSN = DueDiligence.Constants.EMPTY, NEG1, IF(Risk_Indicators.rcSet.isCodeCL(shellInputSSN, RIGHT.iid.bestssn, RIGHT.iid.socsverlevel, RIGHT.iid.combo_ssn), 1, 0));  
                                
                                
                                //Use DI Reason code
                                SELF.lexIDReportedDeceased := IF(STD.Str.CountWords(TRIM(RIGHT.iid.sources, ALL), ',' ) = 0, NEG1, IF(Risk_Indicators.rcSet.isCodeDI(RIGHT.iid.DIDdeceased), 1, 0));  
                                
                                
                                //lexIDBestSSNInvalid 
                                best_ssn_valid := RIGHT.best_flags.best_ssn_valid;
                                iv_best_ssn_invalid := MAP(best_ssn_valid = '6' OR best_ssn_valid = '7' OR notTrueDID => NULL,
                                                           (best_ssn_valid IN ['1', '2', '3']) => 1,
                                                           (best_ssn_valid IN ['0', '4', '5']) => 0,
                                                           NULL);
                                                           
                                SELF.lexIDBestSSNInvalid := IF(iv_best_ssn_invalid = NULL, NEG1, iv_best_ssn_invalid);  
                                
                                
                                //lexIDMultipleSSN
                                invalid_ssns_per_adl := RIGHT.velocity_counters.invalid_ssns_per_adl;
                                rv_c16_inv_ssn_per_adl := IF(notTrueDID, NULL, MIN(IF(invalid_ssns_per_adl = NULL, -NULL, invalid_ssns_per_adl), 999));
                                SELF.lexIDMultipleSSNs := IF(rv_c16_inv_ssn_per_adl = NULL, NEG1, rv_c16_inv_ssn_per_adl);  
                                
                                
                                //inputComponentDivRisk
                                fp_divrisktype := RIGHT.fdattributesv2.divrisklevel;
                                nf_fp_divrisktype := IF(notTrueDID, NULL, (INTEGER)fp_divrisktype);
                                SELF.inputComponentDivRisk := IF(nf_fp_divrisktype = NULL, NEG1, nf_fp_divrisktype);



                                SELF.lastReportedByAnySource := (UNSIGNED4)ver_sources_information[50..57];
                                SELF.lastReportedByBureauSource := (UNSIGNED4)ver_sources_information[59..66];
                                SELF.nonBureauSourceCount := (INTEGER2)ver_sources_information[46..48];
                                SELF.bureauSourceCount := (INTEGER2)ver_sources_information[38..40];


                                //anything else is left empty
                                SELF := [];));
                                
  //Select only records that match.
  Temp_addr_hist := JOIN(Indicators, dx_header.key_addr_hist(),      
                         KEYED(LEFT.lexID = RIGHT.s_did), 
                         TRANSFORM({UNSIGNED4 seq, UNSIGNED6 LexID_temp, UNSIGNED8 dob_temp, UNSIGNED8 address_first_seen_date, UNSIGNED3 address_history_seq, UNSIGNED3 age;},
                                    SELF.seq := LEFT.seq;
                                    SELF.LexID_temp := RIGHT.s_did;
                                    SELF.dob_temp := LEFT.shell_dob_SAS;     //Carry the date of birth forward so we can calc the age at when the address first reported
                                    SELF.address_history_seq := RIGHT.address_history_seq;
                                    SELF.address_first_seen_date := RIGHT.date_first_seen;
                                    SELF.age := 0;
                                    SELF := LEFT;),
                         ATMOST(DueDiligence.Constants.MAX_ATMOST_500), 
                         KEEP(DueDiligence.Constants.MAX_KEEP));
                            
   Sort_addr_hist := SORT(Temp_addr_hist, seq, LexID_temp, address_history_seq); 
                                     
   //We know have the address first reported date and dob for each did.                                      
   Roll_addr_hist := ROLLUP(Sort_addr_hist,
                            LEFT.seq = RIGHT.seq  AND
                            LEFT.LexID_temp = RIGHT.LexID_temp,
                            TRANSFORM(RECORDOF(LEFT),
                                      SELF.seq := LEFT.seq;
                                      SELF.LexID_temp := LEFT.LexID_temp;
                                      SELF.dob_temp := LEFT.dob_temp;
                                      SELF.address_first_seen_date := MIN(LEFT.address_first_seen_date, RIGHT.address_first_seen_date);
                                      SELF.address_history_seq := RIGHT.address_history_seq;   //how many address did the person have
                                      SELF := LEFT;));
                                    
   
   Final_Indicators := JOIN(Indicators, Roll_addr_hist,      
                             LEFT.seq = RIGHT.seq  AND
                             LEFT.lexID = RIGHT.LexID_temp,
                             TRANSFORM(DueDiligence.Citizenship.Layouts.IndicatorLayout,
                                        SELF.seq := LEFT.seq;
                                        SELF.lexID := LEFT.lexID;
                                        dob_temp := RIGHT.dob_temp;
                                        
                                        address_first_seen_temp := (UNSIGNED)RIGHT.address_first_seen_date;
                                        address_first_seen_SAS := Models.common.sas_date((STRING)(address_first_seen_temp));
                                        calcAgeAtThisTime_temp := IF(dob_temp = NULL OR address_first_seen_SAS = NULL, NULL, TRUNCATE((address_first_seen_SAS - dob_temp) / DAYSINYEAR)); 
                                                                                
                                        calcAgeAtThisTime := MIN(calcAgeAtThisTime_temp, DueDiligence.Citizenship.Constants.AGE_CAP);
                                        //addressFirstReportedAge (capped at 110 years)  
                                        SELF.addressFirstReportedAge := IF(calcAgeAtThisTime = NULL OR calcAgeAtThisTime < 0, NEG1, calcAgeAtThisTime);  //this is the final answer
                                        SELF := LEFT;),
                           //write the left even if there was a no match on the right.
                           LEFT OUTER);
                            
                            
                            
   // output(CHOOSEN(temp_addr_hist, 50), NAMED('temp_addr_hist')); 
   // output(CHOOSEN(Sort_addr_hist, 50), NAMED('Sort_addr_hist')); 
   // output(CHOOSEN(Roll_addr_hist, 50), NAMED('Roll_addr_hist'));                                  
                                    
                                        
  RETURN Final_Indicators;
  
 
END;