IMPORT Models, Risk_Indicators;

EXPORT getLuciModel(models.FraudAdvisor_Constants.FP_model_params FP_mod) := MODULE

  SHARED get_fib12010_0_model(DATASET(models.layouts.bs_with_ip) clam_ip,
                              DATASET(Models.Layout_FraudAttributes) FDattributes,
                              DATASET(Risk_Indicators.layouts.layout_IDA_out) IDAattributes
                             ) := FUNCTION
    
    //Step1: Join the inputs together and transform them into the model validation layout
    Luci_model_input_temp := JOIN(clam_ip, FDattributes, 
                                  LEFT.bs.seq = RIGHT.input.seq,
                                  Models.FraudAdvisor_Transforms().xfm_fib12010_shell_and_FPattrs(LEFT, RIGHT), 
                                  ATMOST(Models.FraudAdvisor_Constants.LUCI_atmost));
    
    Luci_model_input := JOIN(Luci_model_input_temp, IDAattributes, 
                             LEFT.TransactionId = (STRING)RIGHT.seq,
                             Models.FraudAdvisor_Transforms().xfm_fib12010_IDAattrs(LEFT, RIGHT), 
                             ATMOST(Models.FraudAdvisor_Constants.LUCI_atmost));
    
    #IF(~Models.FraudAdvisor_Constants.VALIDATION_MODE)
    //Step2: Call LUCI model
    FIB12010_0 := Models.fib12010_0.AsResults(Luci_model_input).Base();
    
    //Turn clam_ip back to clam so that we have a consistent layout for the override function, we don't need ip information here anyway
    clam := PROJECT(clam_ip, TRANSFORM(Risk_Indicators.Layout_Boca_Shell,
                                       SELF := LEFT.bs));
    
    //Step3: Overrides call, Will be used for all IDA Fraud Models unless otherwise specified
    FIB12010_0_RC_overrides := Models.get_FIB12010_overrides(clam, FIB12010_0);
    
    //Step4: Tranform back into normal model layout
    FIBN12010_0_final := PROJECT(FIB12010_0_RC_overrides, TRANSFORM(models.layouts.layout_fp1109,
                                                          SELF.seq := (Integer)LEFT.TransactionId,
                                                          SELF.score := LEFT.score;
                                                          //grab the 6 reason codes, we will not be returning rc descriptions for Fraud Intel models
                                                          RC1 := DATASET([{LEFT.Messages[1].Code,''}],Risk_Indicators.Layout_Desc);
                                                          RC2 := DATASET([{LEFT.Messages[2].Code,''}],Risk_Indicators.Layout_Desc);
                                                          RC3 := DATASET([{LEFT.Messages[3].Code,''}],Risk_Indicators.Layout_Desc);
                                                          RC4 := DATASET([{LEFT.Messages[4].Code,''}],Risk_Indicators.Layout_Desc);
                                                          RC5 := DATASET([{LEFT.Messages[5].Code,''}],Risk_Indicators.Layout_Desc);
                                                          RC6 := DATASET([{LEFT.Messages[6].Code,''}],Risk_Indicators.Layout_Desc);
                                                          
                                                          SELF.ri := RC1+RC2+RC3+RC4+RC5+RC6;
                                                          SELF := []; // don't need Indicies for this model
                                                          ));
    #ELSE
    
    //Use this to get the "debug" layout of the LUCI model it has all of the intermediate variables
    //it can be used to easily transform the results back into the validation file (model input) layout 
    //which is found in MODELNAME.z_layouts_Input
    FIBN12010_0_final := Models.fib12010_0.AsResults(Luci_model_input).ValidationF;

    
    #END

Return FIBN12010_0_final;

 END;
 
//Begin FIWN12103_0 
 SHARED get_fiwn12103_0_model(DATASET(models.layouts.bs_with_ip) clam_ip,
                              DATASET(Models.Layout_FraudAttributes) FDattributes,
                              DATASET(Risk_Indicators.layouts.layout_IDA_out) IDAattributes
                             ) := FUNCTION
    

    Input_With_SSN := clam_ip(clam_ip.bs.shell_input.ssn <> '');
    Input_Without_SSN := clam_ip(clam_ip.bs.shell_input.ssn = '');
   
    //Step1: Join the inputs together and transform them into the model validation layout
    Luci_model_input_temp_withssn := JOIN(Input_With_SSN, FDattributes, 
                                  LEFT.bs.seq = RIGHT.input.seq,
                                  Models.FraudAdvisor_Transforms().xfm_fiwn12103_ssn_shell_and_FPattrs(LEFT, RIGHT), 
                                  ATMOST(Models.FraudAdvisor_Constants.LUCI_atmost));
    
    Luci_model_input_withssn := JOIN(Luci_model_input_temp_withssn, IDAattributes, 
                             LEFT.TransactionId = (STRING)RIGHT.seq,
                             Models.FraudAdvisor_Transforms().xfm_fiwn12103_ssn_IDAattrs(LEFT, RIGHT), 
                             ATMOST(Models.FraudAdvisor_Constants.LUCI_atmost));
                                  

    
    #IF(~Models.FraudAdvisor_Constants.VALIDATION_MODE)
    //Step2: Call LUCI model
    FIWN12103_0_withssn := Models.fiwn12103_0_ssn.AsResults(Luci_model_input_withssn).Base();
    
    //Turn clam_ip back to clam so that we have a consistent layout for the override function, we don't need ip information here anyway
    clam1 := PROJECT(Input_With_SSN, TRANSFORM(Risk_Indicators.Layout_Boca_Shell,
                                       SELF := LEFT.bs));
    
    //Step3: Overrides call, Will be used for all IDA Fraud Models unless otherwise specified
    FIWN12103_0_RC_overrides_withssn := Models.get_FIB12010_overrides(clam1, FIWN12103_0_withssn); // all LUCI models in Fraud will use this set of overrides so no issue with name
    
    //Step4: Tranform back into normal model layout
    FIWN12103_0_final_withssn := PROJECT(FIWN12103_0_RC_overrides_withssn, TRANSFORM(models.layouts.layout_fp1109,
                                                          SELF.seq := (Integer)LEFT.TransactionId,
                                                          SELF.score := LEFT.score;
                                                          //grab the 6 reason codes, we will not be returning rc descriptions for Fraud Intel models
                                                          RC1 := DATASET([{LEFT.Messages[1].Code,''}],Risk_Indicators.Layout_Desc);
                                                          RC2 := DATASET([{LEFT.Messages[2].Code,''}],Risk_Indicators.Layout_Desc);
                                                          RC3 := DATASET([{LEFT.Messages[3].Code,''}],Risk_Indicators.Layout_Desc);
                                                          RC4 := DATASET([{LEFT.Messages[4].Code,''}],Risk_Indicators.Layout_Desc);
                                                          RC5 := DATASET([{LEFT.Messages[5].Code,''}],Risk_Indicators.Layout_Desc);
                                                          RC6 := DATASET([{LEFT.Messages[6].Code,''}],Risk_Indicators.Layout_Desc);
                                                          
                                                          SELF.ri := RC1+RC2+RC3+RC4+RC5+RC6;
                                                          SELF := []; // don't need Indicies for this model
                                                          ));
    #ELSE
    
    //Use this to get the "debug" layout of the LUCI model it has all of the intermediate variables
    //it can be used to easily transform the results back into the validation file (model input) layout 
    //which is found in MODELNAME.z_layouts_Input

    FIWN12103_0_final_withssn := Models.fiwn12103_0_ssn.AsResults(Luci_model_input_withssn).ValidationF;

    
    #END
    

    //Step1: Join the inputs together and transform them into the model validation layout
    Luci_model_input_temp_nossn := JOIN(Input_Without_SSN, FDattributes, 
                                  LEFT.bs.seq = RIGHT.input.seq,
                                  Models.FraudAdvisor_Transforms().xfm_fiwn12103_nossn_shell_and_FPattrs(LEFT, RIGHT), 
                                  ATMOST(Models.FraudAdvisor_Constants.LUCI_atmost));
    
    Luci_model_input_nossn := JOIN(Luci_model_input_temp_nossn, IDAattributes, 
                             LEFT.TransactionId = (STRING)RIGHT.seq,
                             Models.FraudAdvisor_Transforms().xfm_fiwn12103_nossn_IDAattrs(LEFT, RIGHT), 
                             ATMOST(Models.FraudAdvisor_Constants.LUCI_atmost));
                                  
    
    #IF(~Models.FraudAdvisor_Constants.VALIDATION_MODE)
    //Step2: Call LUCI model
    FIWN12103_0_nossn := Models.fiwn12103_0_nossn.AsResults(Luci_model_input_nossn).Base();
    
    //Turn clam_ip back to clam so that we have a consistent layout for the override function, we don't need ip information here anyway
    clam2 := PROJECT(Input_Without_SSN, TRANSFORM(Risk_Indicators.Layout_Boca_Shell,
                                       SELF := LEFT.bs));
    
    //Step3: Overrides call, Will be used for all IDA Fraud Models unless otherwise specified
    FIWN12103_0_RC_overrides_nossn := Models.get_FIB12010_overrides(clam2, FIWN12103_0_nossn);
    
    //Step4: Tranform back into normal model layout
    FIWN12103_0_final_nossn := PROJECT(FIWN12103_0_RC_overrides_nossn, TRANSFORM(models.layouts.layout_fp1109,
                                                          SELF.seq := (Integer)LEFT.TransactionId,
                                                          SELF.score := LEFT.score;
                                                          //grab the 6 reason codes, we will not be returning rc descriptions for Fraud Intel models
                                                          RC1 := DATASET([{LEFT.Messages[1].Code,''}],Risk_Indicators.Layout_Desc);
                                                          RC2 := DATASET([{LEFT.Messages[2].Code,''}],Risk_Indicators.Layout_Desc);
                                                          RC3 := DATASET([{LEFT.Messages[3].Code,''}],Risk_Indicators.Layout_Desc);
                                                          RC4 := DATASET([{LEFT.Messages[4].Code,''}],Risk_Indicators.Layout_Desc);
                                                          RC5 := DATASET([{LEFT.Messages[5].Code,''}],Risk_Indicators.Layout_Desc);
                                                          RC6 := DATASET([{LEFT.Messages[6].Code,''}],Risk_Indicators.Layout_Desc);
                                                          
                                                          SELF.ri := RC1+RC2+RC3+RC4+RC5+RC6;
                                                          SELF := []; // don't need Indicies for this model
                                                          ));
    #ELSE
 
    //Use this to get the "debug" layout of the LUCI model it has all of the intermediate variables
    //it can be used to easily transform the results back into the validation file (model input) layout 
    //which is found in MODELNAME.z_layouts_Input

    FIWN12103_0_final_nossn := Models.fiwn12103_0_nossn.AsResults(Luci_model_input_nossn).ValidationF; 
    #END

    FIWN12103_0_final := FIWN12103_0_final_withssn + FIWN12103_0_final_nossn;
    // FIWN12103_0_final := FIWN12103_0_final_withssn; // use for validation of withssn
    // FIWN12103_0_final := FIWN12103_0_final_nossn; // use for validation of nossn
 
 
    Return FIWN12103_0_final;
    
  END;
  
    //=========   Debugging outputs   =========
    // output(clam_ip, named('clam_ip'));
    // output(FDattributes, named('FDattributes'));
    // output(IDAattributes, named('IDAattributes'));
    // output(Luci_model_input_temp, named('Luci_model_input_temp'));
    // output(Luci_model_input, named('Luci_model_input'));
    // output(FIB12010_0, named('LUCI_model_output'));
    // output(FIWN12103_0_withssn, named('FIWN12103_0_withssn'));
    // output(FIWN12103_0_nossn, named('FIWN12103_0_withssn'));
    // output(FIB12010_0_RC_overrides, named('LUCI_model_after_overrides'));
    
  
  //Model results returned in our standard fp1109 format
  EXPORT FIBN12010_0 := get_fib12010_0_model(FP_mod._clam_ip, FP_mod._FDattributes, FP_mod.IDAattributes);
  EXPORT FIWN12103_0 := get_fiwn12103_0_model(FP_mod._clam_ip, FP_mod._FDattributes, FP_mod.IDAattributes);


END;