IMPORT Risk_Indicators, RiskView, Models;

EXPORT getCreditLuciModels(GROUPED DATASET(risk_indicators.Layout_Boca_Shell) clam = GROUP( DATASET([], risk_indicators.Layout_Boca_Shell), seq),
                           GROUPED DATASET(riskview.layouts.attributes_internal_layout_noscore) RV_attributes = GROUP( DATASET([], riskview.layouts.attributes_internal_layout_noscore), seq), 
                           DATASET(Risk_Indicators.layouts.layout_IDA_out) IDAattributes = DATASET([], Risk_Indicators.layouts.layout_IDA_out),
													 DATASET(RiskView.Layouts.Layout_Custom_Inputs) custom_inputs = DATASET([], RiskView.Layouts.Layout_Custom_Inputs))
                            := MODULE

  //check if IDA attributes are present or had a gateway error
  SHARED IDA_attr_present := Exists(IDAattributes.Indicators);
  SHARED has_IDA_error := Exists(IDAattributes(trim(exception_code) != ''));

  //Declare the shared get_MODEL functions
  SHARED get_RVG2005_0(GROUPED DATASET(riskview.layouts.attributes_internal_layout_noscore) RV_attrs,
                       DATASET(Risk_Indicators.layouts.layout_IDA_out) IDA_attrs
                      ) := FUNCTION
    
    //Step1: Join the inputs together and transform them into the model validation layout
    RVG2005_input := JOIN(RV_attrs, IDA_attrs, 
                                  LEFT.seq = RIGHT.seq,
                                  RiskView.Transforms.xfm_RVG2005_RVAttrs_and_IDAattrs(LEFT, RIGHT), 
                                  ATMOST(Models.FraudAdvisor_Constants.LUCI_atmost));
    
    #IF(~Riskview.Constants.TurnOnValidation)
    // Step2: Call LUCI model
    RVG2005_0 := Models.RVG2005_0_1.AsResults(RVG2005_input).Base();
    
    //Step3: Tranform back into normal model layout
    RVG2005_0_result := PROJECT(RVG2005_0, TRANSFORM(Models.Layout_ModelOut,
                                                          SELF.seq := (INTEGER)LEFT.TransactionId,
                                                          SELF.score := LEFT.score;
                                                          // grab the 5 reason codes and populate the reason code descriptions
                                                          RC1 := DATASET([{LEFT.Messages[1].Code,Risk_Indicators.getHRIDesc(LEFT.Messages[1].Code, TRUE)}],Risk_Indicators.Layout_Desc);
                                                          RC2 := DATASET([{LEFT.Messages[2].Code,Risk_Indicators.getHRIDesc(LEFT.Messages[2].Code, TRUE)}],Risk_Indicators.Layout_Desc);
                                                          RC3 := DATASET([{LEFT.Messages[3].Code,Risk_Indicators.getHRIDesc(LEFT.Messages[3].Code, TRUE)}],Risk_Indicators.Layout_Desc);
                                                          RC4 := DATASET([{LEFT.Messages[4].Code,Risk_Indicators.getHRIDesc(LEFT.Messages[4].Code, TRUE)}],Risk_Indicators.Layout_Desc);
                                                          RC5 := DATASET([{LEFT.Messages[5].Code,Risk_Indicators.getHRIDesc(LEFT.Messages[5].Code, TRUE)}],Risk_Indicators.Layout_Desc);
                                                          
                                                          SELF.ri := RC1+RC2+RC3+RC4+RC5;
                                                          SELF := []; 
                                                          ));
    #ELSE
    
    //Use this to get the "debug" layout of the LUCI model it has all of the intermediate variables
    //it can be used to easily transform the results back into the validation file (model input) layout 
    //which is found in Models.MODELNAME.z_layouts_Input
    RVG2005_0_result := Models.RVG2005_0_1.AsResults(RVG2005_input).ValidationF;
    
    #END
    
    RVG2005_0_final := IF(~IDA_attr_present OR has_IDA_error, 
                        PROJECT(RVG2005_0, TRANSFORM(Models.Layout_ModelOut,SELF.seq := (INTEGER)LEFT.TransactionId, SELF := [])),
                        RVG2005_0_result);

    RETURN RVG2005_0_final;
    
  END;
	
  SHARED get_RVA2008_1(GROUPED DATASET(riskview.layouts.attributes_internal_layout_noscore) RV_attrs
                      ) := FUNCTION
		
		// Step1: Project the attributes and transform them into the layout the model needs
		RVA2008_input := PROJECT(UNGROUP (RV_attrs), RiskView.Transforms.xfm_RVA2008_RVAttrs(LEFT));
    
    #IF(~Riskview.Constants.TurnOnValidation)
		
		// Step2: Call LUCI model
    RVA2008_1 := Models.RVA2008_1_0.AsResults(RVA2008_input).Base();
    
		// Step3: Tranform back into normal model layout
    RVA2008_1_final := PROJECT(RVA2008_1, TRANSFORM(Models.Layout_ModelOut,
                                                          SELF.seq := (INTEGER)LEFT.TransactionId,
                                                          SELF.score := LEFT.score;
                                                          //grab the 5 reason codes and populate the reason code descriptions
                                                          RC1 := DATASET([{LEFT.Messages[1].Code,Risk_Indicators.getHRIDesc(LEFT.Messages[1].Code)}],Risk_Indicators.Layout_Desc);
                                                          RC2 := DATASET([{LEFT.Messages[2].Code,Risk_Indicators.getHRIDesc(LEFT.Messages[2].Code)}],Risk_Indicators.Layout_Desc);
                                                          RC3 := DATASET([{LEFT.Messages[3].Code,Risk_Indicators.getHRIDesc(LEFT.Messages[3].Code)}],Risk_Indicators.Layout_Desc);
                                                          RC4 := DATASET([{LEFT.Messages[4].Code,Risk_Indicators.getHRIDesc(LEFT.Messages[4].Code)}],Risk_Indicators.Layout_Desc);
                                                          RC5 := DATASET([{LEFT.Messages[5].Code,Risk_Indicators.getHRIDesc(LEFT.Messages[5].Code)}],Risk_Indicators.Layout_Desc);
                                                          
                                                          SELF.ri := if(LEFT.score = '900', DATASET([], Risk_Indicators.Layout_Desc), RC1+RC2+RC3+RC4+RC5);
                                                          SELF := []; 
                                                          ));
    #ELSE
    
    //Use this to get the "debug" layout of the LUCI model it has all of the intermediate variables
    //it can be used to easily transform the results back into the validation file (model input) layout 
    //which is found in Models.MODELNAME.z_layouts_Input
    RVA2008_1_final := Models.RVA2008_1_0.AsResults(RVA2008_input).ValidationF;
    
    #END

    RETURN RVA2008_1_final;
    
  END;
	
	  SHARED get_RVT2004_1(GROUPED DATASET(riskview.layouts.attributes_internal_layout_noscore) RV_attrs
                      ) := FUNCTION
		
		// Step1: Project the attributes and transform them into the layout the model needs
		RVT2004_1_input := PROJECT(UNGROUP (RV_attrs), RiskView.Transforms.xfm_RVT2004_1_RVAttrs(LEFT));
    
    #IF(~Riskview.Constants.TurnOnValidation)
		
		// Step2: Call LUCI model
    RVT2004_1 := Models.RVT2004_1_0.AsResults(RVT2004_1_input).Base();
    
		// Step3: Tranform back into normal model layout
    RVT2004_1_final := PROJECT(RVT2004_1, TRANSFORM(Models.Layout_ModelOut,
                                                          SELF.seq := (INTEGER)LEFT.TransactionId,
                                                          SELF.score := LEFT.score;
                                                          // grab the 5 reason codes and populate the reason code descriptions
                                                          RC1 := DATASET([{LEFT.Messages[1].Code,Risk_Indicators.getHRIDesc(LEFT.Messages[1].Code)}],Risk_Indicators.Layout_Desc);
                                                          RC2 := DATASET([{LEFT.Messages[2].Code,Risk_Indicators.getHRIDesc(LEFT.Messages[2].Code)}],Risk_Indicators.Layout_Desc);
                                                          RC3 := DATASET([{LEFT.Messages[3].Code,Risk_Indicators.getHRIDesc(LEFT.Messages[3].Code)}],Risk_Indicators.Layout_Desc);
                                                          RC4 := DATASET([{LEFT.Messages[4].Code,Risk_Indicators.getHRIDesc(LEFT.Messages[4].Code)}],Risk_Indicators.Layout_Desc);
                                                          RC5 := DATASET([{LEFT.Messages[5].Code,Risk_Indicators.getHRIDesc(LEFT.Messages[5].Code)}],Risk_Indicators.Layout_Desc);
                                                          
                                                          SELF.ri := if(LEFT.score = '900', DATASET([], Risk_Indicators.Layout_Desc), RC1+RC2+RC3+RC4+RC5);
                                                          SELF := []; 
                                                          ));
    #ELSE
    
    //Use this to get the "debug" layout of the LUCI model it has all of the intermediate variables
    //it can be used to easily transform the results back into the validation file (model input) layout 
    //which is found in Models.MODELNAME.z_layouts_Input
    RVT2004_1_final := Models.RVT2004_1_0.AsResults(RVT2004_1_input).ValidationF;
    
    #END

    RETURN RVT2004_1_final;
    
  END;
  
		SHARED get_RVT2004_2(GROUPED DATASET(riskview.layouts.attributes_internal_layout_noscore) RV_attrs
                      ) := FUNCTION
		
		// Step1: Project the attributes and transform them into the layout the model needs
		RVT2004_2_input := PROJECT(UNGROUP (RV_attrs), RiskView.Transforms.xfm_RVT2004_2_RVAttrs(LEFT));
    
    #IF(~Riskview.Constants.TurnOnValidation)
		
		// Step2: Call LUCI model
    RVT2004_2 := Models.RVT2004_2_0.AsResults(RVT2004_2_input).Base();
    
		// Step3: Tranform back into normal model layout
    RVT2004_2_final := PROJECT(RVT2004_2, TRANSFORM(Models.Layout_ModelOut,
                                                          SELF.seq := (INTEGER)LEFT.TransactionId,
                                                          SELF.score := LEFT.score;
                                                          // grab the 5 reason codes and populate the reason code descriptions
                                                          RC1 := DATASET([{LEFT.Messages[1].Code,Risk_Indicators.getHRIDesc(LEFT.Messages[1].Code)}],Risk_Indicators.Layout_Desc);
                                                          RC2 := DATASET([{LEFT.Messages[2].Code,Risk_Indicators.getHRIDesc(LEFT.Messages[2].Code)}],Risk_Indicators.Layout_Desc);
                                                          RC3 := DATASET([{LEFT.Messages[3].Code,Risk_Indicators.getHRIDesc(LEFT.Messages[3].Code)}],Risk_Indicators.Layout_Desc);
                                                          RC4 := DATASET([{LEFT.Messages[4].Code,Risk_Indicators.getHRIDesc(LEFT.Messages[4].Code)}],Risk_Indicators.Layout_Desc);
                                                          RC5 := DATASET([{LEFT.Messages[5].Code,Risk_Indicators.getHRIDesc(LEFT.Messages[5].Code)}],Risk_Indicators.Layout_Desc);
                                                          
                                                          SELF.ri := if(LEFT.score = '900', DATASET([], Risk_Indicators.Layout_Desc), RC1+RC2+RC3+RC4+RC5);
                                                          SELF := []; 
                                                          ));
    #ELSE
    
    //Use this to get the "debug" layout of the LUCI model it has all of the intermediate variables
    //it can be used to easily transform the results back into the validation file (model input) layout 
    //which is found in Models.MODELNAME.z_layouts_Input
    RVT2004_2_final := Models.RVT2004_2_0.AsResults(RVT2004_2_input).ValidationF;
    
    #END

    RETURN RVT2004_2_final;
    
    END;
    
  SHARED get_RVS2005_0(GROUPED DATASET(riskview.layouts.attributes_internal_layout_noscore) RV_attrs,
                       DATASET(Risk_Indicators.layouts.layout_IDA_out) IDA_attrs) := FUNCTION
  
    //Step1: Join the inputs together and transform them into the model validation layout
    RVS2005_input := JOIN(RV_attrs, IDA_attrs, 
                                  LEFT.seq = RIGHT.seq,
                                  RiskView.Transforms.xfm_RVS2005_RVAttrs_and_IDAattrs(LEFT, RIGHT), 
                                  ATMOST(Models.FraudAdvisor_Constants.LUCI_atmost));
    
    #IF(~Riskview.Constants.TurnOnValidation)
    // Step2: Call LUCI model
    RVS2005_0 := Models.RVS2005_0_1.AsResults(RVS2005_input).Base();
    
    //Step3: Tranform back into normal model layout
    RVS2005_0_result := PROJECT(RVS2005_0, TRANSFORM(Models.Layout_ModelOut,
                                                          SELF.seq := (INTEGER)LEFT.TransactionId,
                                                          SELF.score := LEFT.score;
                                                          // grab the 5 reason codes and populate the reason code descriptions
                                                          RC1 := DATASET([{LEFT.Messages[1].Code,Risk_Indicators.getHRIDesc(LEFT.Messages[1].Code, TRUE)}],Risk_Indicators.Layout_Desc);
                                                          RC2 := DATASET([{LEFT.Messages[2].Code,Risk_Indicators.getHRIDesc(LEFT.Messages[2].Code, TRUE)}],Risk_Indicators.Layout_Desc);
                                                          RC3 := DATASET([{LEFT.Messages[3].Code,Risk_Indicators.getHRIDesc(LEFT.Messages[3].Code, TRUE)}],Risk_Indicators.Layout_Desc);
                                                          RC4 := DATASET([{LEFT.Messages[4].Code,Risk_Indicators.getHRIDesc(LEFT.Messages[4].Code, TRUE)}],Risk_Indicators.Layout_Desc);
                                                          RC5 := DATASET([{LEFT.Messages[5].Code,Risk_Indicators.getHRIDesc(LEFT.Messages[5].Code, TRUE)}],Risk_Indicators.Layout_Desc);
                                                          
                                                          SELF.ri := RC1+RC2+RC3+RC4+RC5;
                                                          SELF := []; 
                                                          ));
    #ELSE
    //Use this to get the "debug" layout of the LUCI model it has all of the intermediate variables
    //it can be used to easily transform the results back into the validation file (model input) layout 
    //which is found in Models.MODELNAME.z_layouts_Input
    RVS2005_0_result := Models.RVS2005_0_1.AsResults(RVS2005_input).ValidationF;
    #END
    
    RVS2005_0_final := IF(~IDA_attr_present OR has_IDA_error, 
                            PROJECT(RVS2005_0, TRANSFORM(Models.Layout_ModelOut,SELF.seq := (INTEGER)LEFT.TransactionId, SELF := [])),
                            RVS2005_0_result);
    
    RETURN RVS2005_0_final;
  
  END;

  SHARED get_RVC2004_1(GROUPED DATASET(riskview.layouts.attributes_internal_layout_noscore) RV_attrs,
                       dataset(riskview.layouts.Layout_Custom_Inputs) custom_inputs
                      ) := FUNCTION

    // Step1: Project the attributes and transform them into the layout the model needs
       RVC2004_1_input := JOIN(RV_attrs, custom_inputs, 
                               LEFT.seq = RIGHT.seq,
                               RiskView.Transforms.xfm_RVC2004_1_RVAttrs_and_Custom_Inputs(LEFT, RIGHT), 
                               ATMOST(Models.FraudAdvisor_Constants.LUCI_atmost));
    
    #IF(~Riskview.Constants.TurnOnValidation)

    // Step2: Call LUCI model
    RVC2004_1 := Models.RVC2004_1_0.AsResults(RVC2004_1_input).Base();


    
    // Step3: Tranform back into normal model layout
    RVC2004_1_final := PROJECT(RVC2004_1, TRANSFORM(Models.Layout_ModelOut,
                                                          SELF.seq := (INTEGER)LEFT.TransactionId,
                                                          SELF.score := LEFT.score;
                                                          // grab the 5 reason codes and populate the reason code descriptions
                                                          RC1 := DATASET([{LEFT.Messages[1].Code,Risk_Indicators.getHRIDesc(LEFT.Messages[1].Code)}],Risk_Indicators.Layout_Desc);
                                                          RC2 := DATASET([{LEFT.Messages[2].Code,Risk_Indicators.getHRIDesc(LEFT.Messages[2].Code)}],Risk_Indicators.Layout_Desc);
                                                          RC3 := DATASET([{LEFT.Messages[3].Code,Risk_Indicators.getHRIDesc(LEFT.Messages[3].Code)}],Risk_Indicators.Layout_Desc);
                                                          RC4 := DATASET([{LEFT.Messages[4].Code,Risk_Indicators.getHRIDesc(LEFT.Messages[4].Code)}],Risk_Indicators.Layout_Desc);
                                                          RC5 := DATASET([{LEFT.Messages[5].Code,Risk_Indicators.getHRIDesc(LEFT.Messages[5].Code)}],Risk_Indicators.Layout_Desc);
                                                          
                                                          SELF.ri := if(LEFT.score = '900', DATASET([], Risk_Indicators.Layout_Desc), RC1+RC2+RC3+RC4+RC5);
                                                          SELF := []; 
                                                          ));
    #ELSE
    
    //Use this to get the "debug" layout of the LUCI model it has all of the intermediate variables
    //it can be used to easily transform the results back into the validation file (model input) layout 
    //which is found in Models.MODELNAME.z_layouts_Input
    RVC2004_1_final := Models.RVC2004_1_0.AsResults(RVC2004_1_input).ValidationF;
    
    #END

    RETURN RVC2004_1_final;

  END;
    
  SHARED get_RVC2004_2(GROUPED DATASET(riskview.layouts.attributes_internal_layout_noscore) RV_attrs,
                       dataset(riskview.layouts.Layout_Custom_Inputs) custom_inputs
                      ) := FUNCTION

    // Step1: Project the attributes and transform them into the layout the model needs
          RVC2004_2_input := JOIN(RV_attrs, custom_inputs, 
                                  LEFT.seq = RIGHT.seq,
                                  RiskView.Transforms.xfm_RVC2004_2_RVAttrs_and_Custom_Inputs(LEFT, RIGHT), 
                                  ATMOST(Models.FraudAdvisor_Constants.LUCI_atmost));
    
    #IF(~Riskview.Constants.TurnOnValidation)

    // Step2: Call LUCI model
    RVC2004_2 := Models.RVC2004_2_0.AsResults(RVC2004_2_input).Base();


    
    // Step3: Tranform back into normal model layout
    RVC2004_2_final := PROJECT(RVC2004_2, TRANSFORM(Models.Layout_ModelOut,
                                                          SELF.seq := (INTEGER)LEFT.TransactionId,
                                                          SELF.score := LEFT.score;
                                                          // grab the 5 reason codes and populate the reason code descriptions
                                                          RC1 := DATASET([{LEFT.Messages[1].Code,Risk_Indicators.getHRIDesc(LEFT.Messages[1].Code)}],Risk_Indicators.Layout_Desc);
                                                          RC2 := DATASET([{LEFT.Messages[2].Code,Risk_Indicators.getHRIDesc(LEFT.Messages[2].Code)}],Risk_Indicators.Layout_Desc);
                                                          RC3 := DATASET([{LEFT.Messages[3].Code,Risk_Indicators.getHRIDesc(LEFT.Messages[3].Code)}],Risk_Indicators.Layout_Desc);
                                                          RC4 := DATASET([{LEFT.Messages[4].Code,Risk_Indicators.getHRIDesc(LEFT.Messages[4].Code)}],Risk_Indicators.Layout_Desc);
                                                          RC5 := DATASET([{LEFT.Messages[5].Code,Risk_Indicators.getHRIDesc(LEFT.Messages[5].Code)}],Risk_Indicators.Layout_Desc);
                                                          
                                                          SELF.ri := if(LEFT.score = '900', DATASET([], Risk_Indicators.Layout_Desc), RC1+RC2+RC3+RC4+RC5);
                                                          SELF := []; 
                                                          ));
    #ELSE
    
    //Use this to get the "debug" layout of the LUCI model it has all of the intermediate variables
    //it can be used to easily transform the results back into the validation file (model input) layout 
    //which is found in Models.MODELNAME.z_layouts_Input
    RVC2004_2_final := Models.RVC2004_2_0.AsResults(RVC2004_2_input).ValidationF;
    
    #END

    RETURN RVC2004_2_final;
    
  END;

  SHARED get_RVC2004_3(GROUPED DATASET(riskview.layouts.attributes_internal_layout_noscore) RV_attrs,
                       DATASET(riskview.layouts.Layout_Custom_Inputs) custom_inputs
                      ) := FUNCTION

    // Step1: Project the attributes and transform them into the layout the model needs
        RVC2004_3_input := JOIN(RV_attrs, custom_inputs, 
                                LEFT.seq = RIGHT.seq,
                                RiskView.Transforms.xfm_RVC2004_3_RVAttrs_and_Custom_Inputs(LEFT, RIGHT), 
                                ATMOST(Models.FraudAdvisor_Constants.LUCI_atmost));

    #IF(~Riskview.Constants.TurnOnValidation)

    // Step2: Call LUCI model
    RVC2004_3 := Models.RVC2004_3_0.AsResults(RVC2004_3_input).Base();

		// Step3: Tranform back into normal model layout
    RVC2004_3_final := PROJECT(RVC2004_3, TRANSFORM(Models.Layout_ModelOut,
                                                          SELF.seq := (INTEGER)LEFT.TransactionId,
                                                          SELF.score := LEFT.score;
                                                          // grab the 5 reason codes and populate the reason code descriptions
                                                          RC1 := DATASET([{LEFT.Messages[1].Code,Risk_Indicators.getHRIDesc(LEFT.Messages[1].Code)}],Risk_Indicators.Layout_Desc);
                                                          RC2 := DATASET([{LEFT.Messages[2].Code,Risk_Indicators.getHRIDesc(LEFT.Messages[2].Code)}],Risk_Indicators.Layout_Desc);
                                                          RC3 := DATASET([{LEFT.Messages[3].Code,Risk_Indicators.getHRIDesc(LEFT.Messages[3].Code)}],Risk_Indicators.Layout_Desc);
                                                          RC4 := DATASET([{LEFT.Messages[4].Code,Risk_Indicators.getHRIDesc(LEFT.Messages[4].Code)}],Risk_Indicators.Layout_Desc);
                                                          RC5 := DATASET([{LEFT.Messages[5].Code,Risk_Indicators.getHRIDesc(LEFT.Messages[5].Code)}],Risk_Indicators.Layout_Desc);
                                                          
                                                          SELF.ri := if(LEFT.score = '900', DATASET([], Risk_Indicators.Layout_Desc), RC1+RC2+RC3+RC4+RC5);
                                                          SELF := []; 
                                                          ));
    #ELSE
    
    //Use this to get the "debug" layout of the LUCI model it has all of the intermediate variables
    //it can be used to easily transform the results back into the validation file (model input) layout 
    //which is found in Models.MODELNAME.z_layouts_Input
    RVC2004_3_final := Models.RVC2004_3_0.AsResults(RVC2004_3_input).ValidationF;
    
    #END

    RETURN RVC2004_3_final;
    
  END; 
  
  //Export the LUCI model results

  EXPORT RVG2005_0 := get_RVG2005_0(RV_attributes, IDAattributes);
  EXPORT RVS2005_0 := get_RVS2005_0(RV_attributes, IDAattributes);
  EXPORT RVA2008_1 := get_RVA2008_1(RV_attributes);
  EXPORT RVT2004_1 := get_RVT2004_1(RV_attributes);
  EXPORT RVT2004_2 := get_RVT2004_2(RV_attributes);
  EXPORT RVC2004_1 := get_RVC2004_1(RV_attributes, custom_inputs);
  EXPORT RVC2004_2 := get_RVC2004_2(RV_attributes, custom_inputs);
  EXPORT RVC2004_3 := get_RVC2004_3(RV_attributes, custom_inputs);
  
END;