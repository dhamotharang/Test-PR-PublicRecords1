IMPORT DueDiligence, Risk_Indicators, std, Models, MDR;

EXPORT fn_indicators(DATASET(DueDiligence.Layouts.CleanedData) cleanedInput, DATASET(Risk_Indicators.Layout_Boca_Shell) clam) := FUNCTION

  
  NULL      := -999999999;
  NEG1      := -1;
  MAX_SCORE := 999;
  COMMA     := '  ,';
  MODIFIER  := 'ie';
  
//========================================================================================

  indicators := JOIN(cleanedInput, clam, 
                      LEFT.inputEcho.seq = RIGHT.seq, 
                      TRANSFORM(Citizenship.Layouts.IndicatorLayout,  
                                SELF.seq      := LEFT.inputEcho.seq;
                                SELF.inputSeq := IF(LEFT.inputEcho.inputSeq = DueDiligence.Constants.NUMERIC_ZERO, LEFT.inputEcho.seq, LEFT.inputEcho.inputSeq);
                                SELF.acctNo   := LEFT.inputEcho.individual.accountNumber;
                                SELF.lexID    := RIGHT.did;
                                sysdate       := Models.common.sas_date(if(RIGHT.historydate=999999, (STRING)std.date.today(), (STRING6)RIGHT.historydate+'01'));
                           
                           //*** identityAge ***
                                SELF.identityAge := MAP(NOT RIGHT.truedid               => NEG1,
                                                        RIGHT.name_verification.age = 0 => 0,
                                                                                           RIGHT.name_verification.age);                       
                          
                          //*** emergenceAgeHeader ***
                                earliest_header_date    := Citizenship.Ver_source_Function(False,
                                                                                           RIGHT.header_summary.ver_sources, 
                                                                                           RIGHT.header_summary.ver_sources_first_seen_date); 
                                earliest_header_yrs     := if(min(sysdate, earliest_header_date) = NULL, NULL, 
                                                              if((sysdate - earliest_header_date) / 365.25 >= 0, 
                                                                 roundup((sysdate - earliest_header_date) / 365.25), 
                                                                 truncate((sysdate - earliest_header_date) / 365.25)));
                                in_dob                  := RIGHT.shell_input.dob;
                                _in_dob                 := Models.common.sas_date((STRING)(in_dob));
                                calc_dob                := if(_in_dob = NULL or sysdate = NULL, NULL, if ((sysdate - _in_dob) / 365.25 >= 0, 
                                                               roundup((sysdate - _in_dob) / 365.25), 
                                                               truncate((sysdate - _in_dob) / 365.25)));
                                inferred_age            := RIGHT.inferred_age;
                                iv_header_emergence_age := map(
                                                               not(RIGHT.truedid)          => NEG1,
                                                               earliest_header_yrs = NULL  => NEG1,    
                                                               not(_in_dob = NULL)         => calc_dob - earliest_header_yrs,
                                                               inferred_age = 0            => NEG1,
                                                                                              inferred_age - earliest_header_yrs);
                                SELF.emergenceAgeHeader    := iv_header_emergence_age;     
                                
                           //*** emergenceAgeBureau 
                                earliest_bureau_date       := Citizenship.Ver_source_Function(True,
                                                                                        RIGHT.header_summary.ver_sources, 
                                                                                        RIGHT.header_summary.ver_sources_first_seen_date); 
                                                                                                                                              
                                earliest_bureau_yrs        := if(earliest_bureau_date = NULL or sysdate = NULL, NULL, 
                                                                 if((sysdate - earliest_bureau_date) / 365.25 >= 0, 
                                                                    roundup((sysdate - earliest_bureau_date) / 365.25), 
                                                                    truncate((sysdate - earliest_bureau_date) / 365.25)));                                                        
                                iv_bureau_emergence_age    := map(
                                                                not(RIGHT.truedid) or earliest_bureau_yrs = NULL => NEG1,
                                                                not(calc_dob = NULL)                             => calc_dob - earliest_bureau_yrs,
                                                                inferred_age = 0                                 => NEG1,
                                                                                                                    inferred_age - earliest_bureau_yrs);
                                SELF.emergenceAgeBureau    :=  iv_bureau_emergence_age;    
                           
                           //*** ssnIssuanceAge
                                ssnlength                  := RIGHT.input_validation.ssn_length;
                                rc_ssnlowissue             := (unsigned)RIGHT.iid.socllowissue;
                                _rc_ssnlowissue            := Models.common.sas_date((STRING)(rc_ssnlowissue));
                                ssn_years                  := if(_rc_ssnlowissue = NULL or sysdate = NULL, NULL, 
                                                                 if((sysdate - _rc_ssnlowissue) / 365.25 >= 0, 
                                                                     roundup((sysdate - _rc_ssnlowissue) / 365.25), 
                                                                     truncate((sysdate - _rc_ssnlowissue) / 365.25)));
                                nf_age_at_ssn_issuance     := map(
                                                              not(RIGHT.truedid and (ssnlength in ['4', '9'])) or 
                                                              sysdate = NULL or ssn_years = NULL                            => NULL,
                                                              rc_ssnlowissue = Citizenship.Constants.RANDOMIZATION_STARTED  => NULL,
                                                              not(calc_dob = NULL)                                          => calc_dob - ssn_years,
                                                              inferred_age = 0                                              => NULL,
                                                                                                                               inferred_age - ssn_years);
                                SELF.ssnIssuanceAge        := IF(nf_age_at_ssn_issuance = NULL, NEG1, nf_age_at_ssn_issuance);
                          
                          //*** ssnIssuanceYears
                                SELF.ssnIssuanceYears      := IF(ssn_years = NULL, NEG1, ssn_years);
                           
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
                           
                           //*** addressFirstReportedAge       
                                SELF.addressFirstReportedAge := 0;                   //*** 
                           
                           //*** timeSinceLastReportedNonBureau 
                                SELF.timeSinceLastReportedNonBureau := 0;            //***  
                         
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
                                        
  RETURN indicators;
END;