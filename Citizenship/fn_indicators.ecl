IMPORT DueDiligence, Risk_Indicators, std, Models, MDR, header;

EXPORT fn_indicators(DATASET(DueDiligence.Layouts.CleanedData) cleanedInput, DATASET(Risk_Indicators.Layout_Boca_Shell) clam) := FUNCTION

  
  NULL      := -999999999;
  NEG1      := -1;
  MAX_SCORE := 999;
  COMMA     := '  ,';
  MODIFIER  := 'ie';
  isFCRA    := false;
  
//========================================================================================

  indicators := JOIN(cleanedInput, clam, 
                      LEFT.inputEcho.seq = RIGHT.seq, 
                      TRANSFORM({Citizenship.Layouts.IndicatorLayout, unsigned8 shell_dob_SAS;}, 
                                SELF.seq      := LEFT.inputEcho.seq;
                                SELF.inputSeq := IF(LEFT.inputEcho.inputSeq = DueDiligence.Constants.NUMERIC_ZERO, LEFT.inputEcho.seq, LEFT.inputEcho.inputSeq);
                                SELF.acctNo   := LEFT.inputEcho.individual.accountNumber;
                                SELF.lexID    := RIGHT.did;
                                sysdate       := Models.common.sas_date(if(RIGHT.historydate=999999, (STRING)std.date.today(), (STRING6)RIGHT.historydate+'01'));
                           
                           //*** identityAge (capped at 110 years)***
                                verificationAge_temp := MAP(NOT RIGHT.truedid               => NEG1,
                                                            RIGHT.name_verification.age = 0 => 0,
                                                                                               RIGHT.name_verification.age); 
                                identityAge_temp := if(verificationAge_temp > Citizenship.Constants.AGE_CAP, 
                                                       Citizenship.Constants.AGE_CAP, 
                                                       verificationAge_temp);
                                                       
                                SELF.identityAge :=  identityAge_temp;                                                          
                          
                          //*** extract the dates needed from the Ver Source Sections of Boca Shell
                                ver_sources_information   := Citizenship.Ver_source_Function(RIGHT.seq,
                                                                                           RIGHT.header_summary.ver_sources, 
                                                                                           RIGHT.header_summary.ver_sources_first_seen_date,
                                                                                           RIGHT.header_summary.ver_sources_last_seen_date);
                           //*** emergenceAgeHeader (capped at 110 years)***
                                earliest_header_date_SAS := ver_sources_information[1..10];                                                           
                                earliest_header_date     := (integer)earliest_header_date_SAS;  
                                earliest_header_yrs      := if(min(sysdate, earliest_header_date) = NULL, NULL, 
                                                              if((sysdate - earliest_header_date) / 365.25 >= 0, 
                                                                 roundup((sysdate - earliest_header_date) / 365.25), 
                                                                 truncate((sysdate - earliest_header_date) / 365.25)));
                                in_dob                  := RIGHT.shell_input.dob;
                                _in_dob                 := Models.common.sas_date((STRING)(in_dob));
                                SELF.shell_dob_SAS      := _in_dob;                      //***save for the next step 
                                calc_dob                := if(_in_dob = NULL or sysdate = NULL, NULL, if ((sysdate - _in_dob) / 365.25 >= 0, 
                                                               roundup((sysdate - _in_dob) / 365.25), 
                                                               truncate((sysdate - _in_dob) / 365.25)));
                                inferred_age            := RIGHT.inferred_age;
                                iv_header_emergence_age_temp := map(
                                                               not(RIGHT.truedid)          => NULL,
                                                               earliest_header_yrs = NULL  => NULL,    
                                                               not(_in_dob = NULL)         => calc_dob - earliest_header_yrs,
                                                               inferred_age = 0            => NULL,
                                                                                              inferred_age - earliest_header_yrs);
                                                                                              
                                iv_header_emergence_age     := if(iv_header_emergence_age_temp > Citizenship.Constants.AGE_CAP, 
                                                                     Citizenship.Constants.AGE_CAP, 
                                                                     iv_header_emergence_age_temp);
                                                                     
                                SELF.emergenceAgeHeader    := IF(iv_header_emergence_age = NULL, NEG1, iv_header_emergence_age);     
                                
                           //*** emergenceAgeBureau   (capped at 110 years)
                                earliest_bureau_date_SAS   := ver_sources_information[12..21];
                                earliest_bureau_date       := (integer)earliest_bureau_date_SAS;  
                                                                                                                                              
                                earliest_bureau_yrs        := if(earliest_bureau_date = NULL or sysdate = NULL, NULL, 
                                                                 if((sysdate - earliest_bureau_date) / 365.25 >= 0, 
                                                                    roundup((sysdate - earliest_bureau_date) / 365.25), 
                                                                    truncate((sysdate - earliest_bureau_date) / 365.25)));                                                        
                                iv_bureau_emergence_age_temp    := map(
                                                                   not(RIGHT.truedid) or earliest_bureau_yrs = NULL => NULL,
                                                                   not(calc_dob = NULL)                             => calc_dob - earliest_bureau_yrs,
                                                                   inferred_age = 0                                 => NULL,
                                                                                                                       inferred_age - earliest_bureau_yrs);
                               
                               iv_bureau_emergence_age    := if(iv_bureau_emergence_age_temp > Citizenship.Constants.AGE_CAP, 
                                                                     Citizenship.Constants.AGE_CAP, 
                                                                     iv_bureau_emergence_age_temp);
                                                                     
                               SELF.emergenceAgeBureau    := IF(iv_bureau_emergence_age = NULL, NEG1, iv_bureau_emergence_age);    
                           
                           //*** ssnIssuanceAge (capped at 110 years)
                                ssnlength                  := RIGHT.input_validation.ssn_length;
                                rc_ssnlowissue             := (unsigned)RIGHT.iid.socllowissue;
                                _rc_ssnlowissue            := Models.common.sas_date((STRING)(rc_ssnlowissue));
                                ssn_years                  := if(_rc_ssnlowissue = NULL or sysdate = NULL, NULL, 
                                                                 if((sysdate - _rc_ssnlowissue) / 365.25 >= 0, 
                                                                     roundup((sysdate - _rc_ssnlowissue) / 365.25), 
                                                                     truncate((sysdate - _rc_ssnlowissue) / 365.25)));
                                nf_age_at_ssn_issuance_temp := map(
                                                                    not(RIGHT.truedid and (ssnlength in ['4', '9'])) or 
                                                                    sysdate = NULL or ssn_years = NULL                            => NULL,
                                                                    rc_ssnlowissue = Citizenship.Constants.RANDOMIZATION_STARTED  => NULL,
                                                                    not(calc_dob = NULL)                                          => calc_dob - ssn_years,
                                                                    inferred_age = 0                                              => NULL,
                                                                                                                                     inferred_age - ssn_years);
                               nf_age_at_ssn_issuance     := if(nf_age_at_ssn_issuance_temp > Citizenship.Constants.AGE_CAP, 
                                                                     Citizenship.Constants.AGE_CAP, 
                                                                     nf_age_at_ssn_issuance_temp);
                                                                     
                               SELF.ssnIssuanceAge        := IF(nf_age_at_ssn_issuance = NULL, NEG1, nf_age_at_ssn_issuance);
                          
                          //*** ssnIssuanceYears (capped at 110 years)
                                ssn_years_capped          := IF(ssn_years > Citizenship.Constants.AGE_CAP,
                                                                 Citizenship.Constants.AGE_CAP,
                                                                 ssn_years);  
                                
                                SELF.ssnIssuanceYears      := IF(ssn_years_capped = NULL, NEG1, ssn_years_capped);
                           
                           //*** relativeCount
                                SELF.relativeCount         := IF(NOT RIGHT.truedid, NEG1, MIN(RIGHT.relatives.relative_count, MAX_SCORE));
                           
                           //*** ver_voterRecords (should be treated like a boolean)
                                ver_dob_sources            := RIGHT.header_summary.ver_dob_sources;
                                ver_dob_src_vo_pos         := Models.Common.findw_cpp(ver_dob_sources, MDR.SourceTools.src_Voters_v2 , COMMA, MODIFIER);
                                ver_dob_src_vo             := ver_dob_src_vo_pos > 0;
                                SELF.ver_voterRecords      := (integer)ver_dob_src_vo;
                          
                          //*** ver_insuranceRecords
                             	  phone_ver_insurance        := RIGHT.insurance_phones_summary.Insurance_Phone_Verification;
                                nf_phone_ver_insurance     := if(not(RIGHT.truedid), NULL, (integer)phone_ver_insurance);
                                SELF.ver_insuranceRecords  := IF(nf_phone_ver_insurance = NULL, NEG1, nf_phone_ver_insurance);
                           
                           //*** ver_StudentFile  
                                ver_src_sl_pos             := Models.Common.findw_cpp(RIGHT.header_summary.ver_sources, MDR.SourceTools.src_American_Students_List , COMMA, MODIFIER);
                                ver_src_nas_sl             := if(ver_src_sl_pos > 0, (real)Models.Common.getw(RIGHT.header_summary.ver_sources_nas, ver_src_sl_pos), 0);
                                SELF.ver_studentFile       := ver_src_nas_sl;
                           
                           //*** firstSeenAddr10
                             	  add_curr_pop               := RIGHT.addrPop2;
                                addrs_10yr                 := RIGHT.other_address_info.addrs_last_10years;
                                rv_c14_addrs_10yr          := map(
                                                                not(RIGHT.truedid)             => NULL,
                                                               (integer)add_curr_pop = 0       => NULL,
                                                                                                  min(if(addrs_10yr = NULL, -NULL, addrs_10yr), 999));
                                SELF.firstSeenAddr10       := IF(rv_c14_addrs_10yr = NULL, NEG1, rv_c14_addrs_10yr);
                           
                           //*** reportedCurAddressYears
                                add_curr_lres              := RIGHT.lres2;
                                rv_c13_curr_addr_lres      := if(not(RIGHT.truedid and add_curr_pop), NULL, 
                                                               min(if(add_curr_lres = NULL, -NULL, add_curr_lres), 999));
                                SELF.reportedCurAddressYears := IF(rv_c13_curr_addr_lres = NULL, NEG1, rv_c13_curr_addr_lres);
                           
                           //*** addressFirstReportedAge   - calculated after picking more information from the address hierarchy key   
                                SELF.addressFirstReportedAge := -1;                   //*** 
                           
                                num_of_cred_sources          := ver_sources_information[34..36];
                                last_seen_credentialed_SAS   := ver_sources_information[23..32];
                                last_seen_by_cred_source     := (integer)last_seen_credentialed_SAS;
                                
                                YRSinceLastReportedCredential := map(
                                                                     not(RIGHT.truedid)                       => NULL,
                                                                     last_seen_by_cred_source = NULL          => NULL,
                                                                     (integer)num_of_cred_sources > 0         => truncate((sysdate - last_seen_by_cred_source) / 365.25),
                                                                                                                 NULL);
                           //*** timeSinceLastReportedNonBureau *** ATTENTION - SHOULD the name of this indicator needs to be changed to TimeSinceLastReportedCredentialed
                                SELF.timeSinceLastReportedNonBureau := IF(YRSinceLastReportedCredential = NULL, NEG1, YRSinceLastReportedCredential);            //***  
                         
                           //*** Using the Boca Shell and Risk_Indicators.rcSet.isCode__ to set a true of false value for each ***  
                           //*** Use RS Reason code logic
                                SELF.inputSSNRandomlyIssued      := IF(Risk_Indicators.rcSet.isCodeRS(RIGHT.shell_input.ssn, RIGHT.iid.socsvalflag, RIGHT.iid.socllowissue, RIGHT.iid.socsRCISflag), 1, 0);
                          
                          //*** Use IS Reason code logic
                                SELF.inputSSNRandomIssuedInvalid := IF(Risk_Indicators.rcSet.isCodeIS(RIGHT.shell_input.ssn, RIGHT.iid.socsvalflag, RIGHT.iid.socllowissue, RIGHT.iid.socsRCISflag), 1, 0);
                          
                          //*** Use 85 Reason Code logic 
                                SELF.inputSSNIssuedToNonUS       := IF(Risk_Indicators.rcSet.isCode85(RIGHT.shell_input.ssn, RIGHT.iid.socllowissue), 1, 0);
                          
                          //*** Use IT Reason Code logic
                                SELF.inputSSNITIN                := IF(Risk_Indicators.rcSet.isCodeIT(RIGHT.shell_input.ssn), 1, 0);                                                                         
                          
                          //*** inputSSNInvalid 
                            	  rc_ssnvalflag             := RIGHT.iid.socsvalflag;
	                              rc_pwssnvalflag           := RIGHT.iid.pwsocsvalflag;
                                inputssncharflag          := RIGHT.ssn_verification.validation.inputsocscharflag;
                                rv_s65_ssn_invalid        := map(
                                                                 not(ssnlength > '0')                                                                                 => NULL,
                                                                 rc_ssnvalflag = '1' or (rc_pwssnvalflag in ['1', '2', '3']) or (inputssncharflag in ['1', '2', '3']) => 1,
                                                                 rc_ssnvalflag = '0' or (rc_pwssnvalflag in ['0', '4', '5']) or (inputssncharflag in ['0', '4', '5']) => 0,
                                                                                                                                                                         NULL);
                                SELF.inputSSNInvalid     := IF(rv_s65_ssn_invalid = NULL, NEG1, rv_s65_ssn_invalid);
                           
                           //*** inputSSNIssuedPriorDOB
                           	     dobpop                  := RIGHT.input_validation.dateofbirth;
                                 rc_pwssndobflag         := RIGHT.iid.pwsocsdobflag;
                                 rc_ssndobflag           := RIGHT.iid.socsdobflag;
                                 rv_s65_ssn_prior_dob    := map(
                                                             not(ssnlength > '0' and dobpop)              => NULL,
                                                             rc_ssndobflag = '1' or rc_pwssndobflag = '1' => 1,
                                                             rc_ssndobflag = '0' or rc_pwssndobflag = '0' => 0,
                                                                                                             NULL);
                                SELF.inputSSNIssuedPriorDOB := IF(rv_s65_ssn_prior_dob = NULL, NEG1, rv_s65_ssn_prior_dob);
                          
                          //*** Use MI Reason code logic     
                                SELF.inputSSNAssociatedMultLexIDs := IF(Risk_Indicators.rcSet.isCodeMI(RIGHT.velocity_counters.adls_per_ssn_seen_18months), 1, 0);
                          
                          //*** Use O2 Reason code logic
                                SELF.inputSSNReportedDeceased     := IF(Risk_Indicators.rcSet.isCode02(RIGHT.iid.decsflag), 1, 0); 
                         
                         //*** Use CL Reason code logic
                                SELF.inputSSNNotPrimaryLexID      := IF(Risk_Indicators.rcSet.isCodeCL(RIGHT.shell_input.ssn, RIGHT.iid.bestssn, RIGHT.iid.socsverlevel, RIGHT.iid.combo_ssn), 1, 0);
                          
                          //*** Use DI Reason code
                                SELF.lexIDReportedDeceased        := IF(Risk_Indicators.rcSet.isCodeDI(RIGHT.iid.DIDdeceased), 1, 0);                                          
                                
                                
                          //*** lexIDBestSSNInvalid 
                                best_ssn_valid           := RIGHT.best_flags.best_ssn_valid;
                                iv_best_ssn_invalid      := map(
                                                              best_ssn_valid = '6' or best_ssn_valid = '7' or not(RIGHT.truedid)      => NULL,
                                                             (best_ssn_valid in ['1', '2', '3'])                                      => 1,
                                                             (best_ssn_valid in ['0', '4', '5'])                                      => 0,
                                                                                                                                      NULL);
                                SELF.lexIDBestSSNInvalid := IF(iv_best_ssn_invalid = NULL, NEG1, iv_best_ssn_invalid);
                                
                          //*** lexIDMultipleSSN
                                invalid_ssns_per_adl   := RIGHT.velocity_counters.invalid_ssns_per_adl;
                                rv_c16_inv_ssn_per_adl := if(not(RIGHT.truedid), NULL, min(if(invalid_ssns_per_adl = NULL, -NULL, invalid_ssns_per_adl), 999));
                                SELF.lexIDMultipleSSNs := IF(rv_c16_inv_ssn_per_adl = NULL, NEG1, rv_c16_inv_ssn_per_adl);
                                 
                          //*** inputComponentDivRisk
                            	  fp_divrisktype        := RIGHT.fdattributesv2.divrisklevel;
                                nf_fp_divrisktype     := if(not(RIGHT.truedid), NULL, (integer)fp_divrisktype);
                                SELF.inputComponentDivRisk := IF(nf_fp_divrisktype = NULL, NEG1, nf_fp_divrisktype);
                          //*** anything else is left empty
                                SELF := [];));
                                
  //***Select only records that match.
  Temp_addr_hist := JOIN(Indicators, header.key_addr_hist(isFCRA),      
                           KEYED(LEFT.lexID = RIGHT.s_did), 
                           TRANSFORM({unsigned4 seq, unsigned6 LexID_temp, unsigned8 dob_temp, unsigned8 address_first_seen_date, unsigned3 address_history_seq, unsigned3 age;},
                                    SELF.seq                  := LEFT.seq;
                                    SELF.LexID_temp           := RIGHT.s_did;
                                    SELF.dob_temp             := LEFT.shell_dob_SAS;     //***Carry the date of birth forward so we can calc the age at when the address first reported
                                    SELF.address_history_seq  := RIGHT.address_history_seq;
                                    SELF.address_first_seen_date := RIGHT.date_first_seen;
                                    SELF.age                  := 0;
                                    SELF                      := LEFT;),
                            ATMOST(DueDiligence.Constants.MAX_ATMOST_500), 
                            KEEP(DueDiligence.Constants.MAX_KEEP));
                            
   Sort_addr_hist := SORT(Temp_addr_hist, seq, LexID_temp, address_history_seq); 
                                     
  //***We know have the address first reported date and dob for each did.                                      
   Roll_addr_hist := ROLLUP(Sort_addr_hist,
                            LEFT.seq        = RIGHT.seq  AND
                            LEFT.LexID_temp = RIGHT.LexID_temp,
                          TRANSFORM (RECORDOF(LEFT),
                            SELF.seq                      := LEFT.seq;
                            SELF.LexID_temp               := LEFT.LexID_temp;
                            SELF.dob_temp                 := LEFT.dob_temp;
                            SELF.address_first_seen_date  := MIN(LEFT.address_first_seen_date, RIGHT.address_first_seen_date);
                            SELF.address_history_seq      := RIGHT.address_history_seq;   //***how many address did the person have
                            SELF                          := LEFT;));
                                    
   
   Final_Indicators := JOIN(Indicators, Roll_addr_hist,      
                           LEFT.seq        = RIGHT.seq  AND
                           LEFT.lexID      = RIGHT.LexID_temp,
                         TRANSFORM (Citizenship.Layouts.IndicatorLayout,
                            SELF.seq                      := LEFT.seq;
                            SELF.lexID                    := LEFT.lexID;
                            dob_temp                      := RIGHT.dob_temp;
                            
                            address_first_seen_temp      := (unsigned)RIGHT.address_first_seen_date;
                            address_first_seen_SAS       := Models.common.sas_date((STRING)(address_first_seen_temp));
                            calcAgeAtThisTime_temp       := if(dob_temp = NULL or address_first_seen_SAS = NULL, NULL, 
                                                                    truncate((address_first_seen_SAS - dob_temp) / 365.25)); 
                                                                    
                            calcAgeAtThisTime            := if(calcAgeAtThisTime_temp > Citizenship.Constants.AGE_CAP, 
                                                                Citizenship.Constants.AGE_CAP, 
                                                                calcAgeAtThisTime_temp);
                       //*** addressFirstReportedAge (capped at 110 years)  
                            SELF.addressFirstReportedAge := IF(calcAgeAtThisTime = NULL, NEG1, calcAgeAtThisTime);           //***this is the final answer
                            SELF                         := LEFT;),
                            //***write the left even if there was a no match on the right.
                         LEFT OUTER);
                            
                            
                            
   // output(CHOOSEN(temp_addr_hist, 50), NAMED('temp_addr_hist')); 
   // output(CHOOSEN(Sort_addr_hist, 50), NAMED('Sort_addr_hist')); 
   // output(CHOOSEN(Roll_addr_hist, 50), NAMED('Roll_addr_hist'));                                  
                                    
                                        
  RETURN Final_Indicators;
  
 
END;