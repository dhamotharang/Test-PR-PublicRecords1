IMPORT Risk_Indicators, RiskView, Models;

EXPORT getCreditLuciModels(GROUPED DATASET(risk_indicators.Layout_Boca_Shell) clam,
                           GROUPED DATASET(riskview.layouts.attributes_internal_layout_noscore) RV_attributes, 
                           DATASET(Risk_Indicators.layouts.layout_IDA_out) IDAattributes
                           ) := MODULE
  
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
    //Step2: Call LUCI model
    RVG2005_0 := Models.RVG2005_0_1.AsResults(RVG2005_input).Base();
    
    //Step3: Tranform back into normal model layout
    RVG2005_0_final := PROJECT(RVG2005_0, TRANSFORM(Models.Layout_ModelOut,
                                                          SELF.seq := (INTEGER)LEFT.TransactionId,
                                                          SELF.score := LEFT.score;
                                                          //grab the 5 reason codes and populate the reason code descriptions
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
    RVG2005_0_final := Models.RVG2005_0_1.AsResults(RVG2005_input).ValidationF;
    
    #END
    // RETURN RVG2005_0_final;

    RETURN RVG2005_0_final;
    
  END;
  
  
  //Export the LUCI model results
  
  EXPORT RVG2005_0 := get_RVG2005_0(RV_attributes, IDAattributes);

END;