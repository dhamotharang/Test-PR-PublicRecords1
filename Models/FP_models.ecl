Import Models, Risk_indicators, STD;

EXPORT FP_models := MODULE

  EXPORT Check_Valid_Attributes(DATASET(Models.Layouts.Layout_Attributes_In) Attr_Request, Set of String AttributeGroup) := Function
  
    Attr_check := EXISTS(Attr_Request(STD.STR.ToLowerCase(name) in [AttributeGroup]));
    Return Attr_check;
  END;

  EXPORT FP31604_0_check(model_requests, input_model, cm_param) := FunctionMacro
    
    r := record
      string value;
    end;
    
    cmIn := model_requests(STD.STR.ToLowerCase(TRIM(ModelName)) = 'customfa_service');
    
    //check up to 3 models for the model and custom param
    modelname1 := STD.STR.ToLowerCase(TRIM(cmIn[1].ModelOptions(STD.STR.ToLowerCase(TRIM(OptionName)) = 'custom')[1].OptionValue));
    modelname2 := STD.STR.ToLowerCase(TRIM(cmIn[2].ModelOptions(STD.STR.ToLowerCase(TRIM(OptionName)) = 'custom')[1].OptionValue));
    modelname3 := STD.STR.ToLowerCase(TRIM(cmIn[3].ModelOptions(STD.STR.ToLowerCase(TRIM(OptionName)) = 'custom')[1].OptionValue));
    modelname_list := [modelname1,modelname2,modelname3];
    
    custom_field1 := STD.STR.ToUpperCase(TRIM(cmIn[1].ModelOptions(STD.STR.ToLowerCase(TRIM(OptionName)) = cm_param)[1].OptionValue));
    custom_field2 := STD.STR.ToUpperCase(TRIM(cmIn[2].ModelOptions(STD.STR.ToLowerCase(TRIM(OptionName)) = cm_param)[1].OptionValue));
    custom_field3 := STD.STR.ToUpperCase(TRIM(cmIn[3].ModelOptions(STD.STR.ToLowerCase(TRIM(OptionName)) = cm_param)[1].OptionValue));
    custom_field_value_list := DATASET([{custom_field1},{custom_field2},{custom_field3}], r);
    
    //sort the value list to see if any of them are populated and grab the first one.
    sorted_field_list := sort(custom_field_value_list, -value);
    custom_field_value := sorted_field_list[1].value;
    
    FP31604_input_check := (input_model in modelname_list) and ((unsigned)custom_field_value > 0);
    
    Return FP31604_input_check;
  ENDMacro;

  //Function macro to take in a dataset and the model requests to assign a field a value from one of the models custom parameters if needed.
  EXPORT custom_field_replacement(Input_ds, model_requests, input_model, input_ds_field, cm_param, cm_param_type) := FunctionMacro
    
    r := record
      string value;
    end;
    
    cmIn := model_requests(STD.STR.ToLowerCase(TRIM(ModelName)) = 'customfa_service');
    
    //check up to 3 models for the model and custom param
    modelname1 := STD.STR.ToLowerCase(TRIM(cmIn[1].ModelOptions(STD.STR.ToLowerCase(TRIM(OptionName)) = 'custom')[1].OptionValue));
    modelname2 := STD.STR.ToLowerCase(TRIM(cmIn[2].ModelOptions(STD.STR.ToLowerCase(TRIM(OptionName)) = 'custom')[1].OptionValue));
    modelname3 := STD.STR.ToLowerCase(TRIM(cmIn[3].ModelOptions(STD.STR.ToLowerCase(TRIM(OptionName)) = 'custom')[1].OptionValue));
    modelname_list := [modelname1,modelname2,modelname3];
    
    custom_field1 := STD.STR.ToUpperCase(TRIM(cmIn[1].ModelOptions(STD.STR.ToLowerCase(TRIM(OptionName)) = cm_param)[1].OptionValue));
    custom_field2 := STD.STR.ToUpperCase(TRIM(cmIn[2].ModelOptions(STD.STR.ToLowerCase(TRIM(OptionName)) = cm_param)[1].OptionValue));
    custom_field3 := STD.STR.ToUpperCase(TRIM(cmIn[3].ModelOptions(STD.STR.ToLowerCase(TRIM(OptionName)) = cm_param)[1].OptionValue));
    custom_field_value_list := DATASET([{custom_field1},{custom_field2},{custom_field3}], r);
    
    //sort the value list to see if any of them are populated and grab the first one.
    sorted_field_list := sort(custom_field_value_list, -value);
    custom_field_value := sorted_field_list[1].value;
    
    model_found := input_model = '' or input_model in modelname_list;
    
    //check if the model provided is in the list and that the custom parameter is present and it's value is populated
    replace_value := model_found and custom_field_value != '';
    
    output_ds := project(Input_ds, Transform(recordof(Input_ds),
                                   self.#EXPAND(input_ds_field) := IF(replace_value, (#EXPAND(cm_param_type))custom_field_value, left.#EXPAND(input_ds_field)),
                                   self := left));
    
    return output_ds;
  ENDMacro;

  EXPORT Valid_request(Models.Layouts.Layout_Model_Request_In ModelRequest,
                      DATASET(Models.Layouts.Layout_Attributes_In) attributesIn,
                      string45 ip_value = '',
                      boolean includeriskindices = false,
                      unsigned1 RedFlag_version = 0,
                      boolean glb_ok = false) := Function
    
    cmModelName       := STD.STR.ToLowerCase(TRIM(ModelRequest.ModelName));
    
    //This section checks for the model name and any custom parameters that could be associated with them.
    //If any new model needs to check if it needs a new custom parameter or the transaction will fail,
    //that logic needs to be added here.
    
    cmName            := ModelRequest.ModelOptions(STD.STR.ToLowerCase(TRIM(OptionName)) = 'custom');
    cmNameValue       := STD.STR.ToLowerCase(TRIM(cmName[1].OptionValue));
    cmGrade           := ModelRequest.ModelOptions(STD.STR.ToLowerCase(TRIM(OptionName)) = 'grade');
    cmGradeValue      := STD.STR.ToUpperCase(TRIM(cmGrade[1].OptionValue));
    cmRetailZip       := ModelRequest.ModelOptions(STD.STR.ToLowerCase(TRIM(OptionName)) = 'retailzip');
    cmRetailZipValue  := STD.STR.ToUpperCase(TRIM(cmRetailZip[1].OptionValue));
    cmLoadAmount      := ModelRequest.ModelOptions(STD.STR.ToLowerCase(TRIM(OptionName)) = 'loadamount');
    cmLoadAmountValue := STD.STR.ToUpperCase(TRIM(cmLoadAmount[1].OptionValue));
    cmSegment         := ModelRequest.ModelOptions(STD.STR.ToLowerCase(TRIM(OptionName)) = 'segment');
    cmSegmentValue    := STD.STR.ToUpperCase(TRIM(cmSegment[1].OptionValue));
    cmLexID           := ModelRequest.ModelOptions(STD.STR.ToLowerCase(TRIM(OptionName)) = 'lexid');
    cmLexIDValue      := STD.STR.ToUpperCase(TRIM(cmLexID[1].OptionValue));
    
    isWFS34 := (cmNameValue = 'ain801_1');

    invalidCustomRequest := (((cmModelName = 'customfa_service' AND ~isWFS34) AND
                            (cmModelName = 'customfa_service' AND cmNameValue NOT IN Models.FraudAdvisor_Constants.XML_custom_models)) OR
                            (cmModelName <> 'customfa_service'));
                            
    InvalidGreenDotRequest := (((cmNameValue IN ['fp31310_2', 'fp1509_2']) AND (cmRetailZipValue = '') AND (ip_value = ''))
                  OR ((cmNameValue in ['fp31310_2', 'fp1509_2']) AND (cmLoadAmountValue = '')));
                            
    model_lc := cmNameValue;

    model_name1 := IF( (model_lc='' or model_lc in Models.FraudAdvisor_Constants.XML_custom_models OR isWFS34) AND invalidCustomRequest=false,
                       IF(isWFS34, 'ain801_1', model_lc), ERROR('Invalid fraud version/model input combination'));


    InvalidFP_GLBRequest := model_name1 in Models.FraudAdvisor_Constants.GLB_models and ~glb_ok; 

    // Bureau Fraud Flags Models needs to be requested on it's own with no other scores/attributes.
    InvalidFraudFlagsRequest := model_lc = 'fp1712_0' AND 
                                (EXISTS(attributesIn(STD.STR.ToLowerCase(name)<>'')) OR
                                includeriskindices = TRUE OR
                                redflag_version > 0);
                                
    model_name := MAP(InvalidGreenDotRequest   = TRUE => ERROR('Invalid parameter input combination for fp31310_2 or fp1509_2'),
                      InvalidFP_GLBRequest     = TRUE => ERROR('Valid Gramm-Leach-Bliley Act (GLBA) purpose required'),
                      InvalidFraudFlagsRequest = TRUE => ERROR('invalid product option combination'),
                                                         model_name1 );
    
    //IF model_name gets populated then we didn't receive an invalid request, so return the input model request
    Valid_model_request := IF(model_name != '', ModelRequest, DATASET([],Models.Layouts.Layout_Model_Request_In)[1]);
    
    RETURN Valid_model_request;
  END;
  
  EXPORT Model_Check(DATASET(Models.Layouts.Layout_Model_Request_In) ModelOptions_In, Set of String model_list) := Function

    //pull out up to 3 models (for now)
    cmName1      := ModelOptions_In[1].ModelOptions(STD.STR.ToLowerCase(TRIM(OptionName)) = 'custom');
    modelname1 := STD.STR.ToLowerCase(TRIM(cmName1[1].OptionValue));
    cmName2      := ModelOptions_In[2].ModelOptions(STD.STR.ToLowerCase(TRIM(OptionName)) = 'custom');
    modelname2 := STD.STR.ToLowerCase(TRIM(cmName2[1].OptionValue));
    cmName3      := ModelOptions_In[3].ModelOptions(STD.STR.ToLowerCase(TRIM(OptionName)) = 'custom');
    modelname3 := STD.STR.ToLowerCase(TRIM(cmName3[1].OptionValue));

    //check each model name against the list
    check1 := (Integer)(modelname1 in model_list); 
    check2 := (Integer)(modelname2 in model_list); 
    check3 := (Integer)(modelname3 in model_list); 

    //add them up and see if any of them were true
    check_sum := (check1 + check2 + check3) > 0;
    
    return check_sum;
  END;
  
  EXPORT Set_BSOptions(DATASET(Models.Layouts.Layout_Model_Request_In) ModelRequest,
                       DATASET(Models.Layouts.Layout_Attributes_In) Attr_Request,
                       BOOLEAN inputok = FALSE,
                       BOOLEAN doInquiries = FALSE, boolean UseIngestDate=false) := Function
    
    attributesV2set := [Models.FraudAdvisor_Constants.attrV2,
                        Models.FraudAdvisor_Constants.attrV201,
                        Models.FraudAdvisor_Constants.attrV202];

    doAttributesVersion1 := Check_Valid_Attributes(Attr_Request, [Models.FraudAdvisor_Constants.attrV1]);
    doIDAttributes := Check_Valid_Attributes(Attr_Request, [Models.FraudAdvisor_Constants.IDattr]);
    doAttributesVersion2 := Check_Valid_Attributes(Attr_Request, attributesV2set) and inputok;
    doAttributesVersion201 := Check_Valid_Attributes(Attr_Request, [Models.FraudAdvisor_Constants.attrV201]) and inputok;
    doAttributesVersion202 := (Check_Valid_Attributes(Attr_Request, [Models.FraudAdvisor_Constants.attrV202]) or Model_Check(ModelRequest, ['fp1908_1'])) and inputok;
    doParoAttributes := Check_Valid_Attributes(Attr_Request, [Models.FraudAdvisor_Constants.attrvparo]) and inputok;
    doTMXAttributes := Check_Valid_Attributes(Attr_Request, [Models.FraudAdvisor_Constants.attrvTMX]) and inputok;
    doIDA_Attributes := Check_Valid_Attributes(Attr_Request, [Models.FraudAdvisor_Constants.attrIDA]) and inputok;
    

    turn_on_RetainInputDID       := Model_Check(ModelRequest, ['fp31604_0']) and inputok;
    
    turn_on_IncludeDoNotMail     := (Model_Check(ModelRequest, ['fp31604_0'])and inputok) or doAttributesVersion2 or
                                    Model_Check(ModelRequest, Models.FraudAdvisor_Constants.ThisSet_for_BSOPTIONS);
                                    
    turn_on_IncludeFraudVelocity := (Model_Check(ModelRequest, ['fp31604_0'])and inputok) or doAttributesVersion2 or
                                    Model_Check(ModelRequest, [Models.FraudAdvisor_Constants.ThisSet_for_BSOPTIONS,'fp1403_2','fp1510_2']);
    turn_on_IncludeHHIDSummary   := (Model_Check(ModelRequest, ['fp31604_0'])and inputok) or doAttributesVersion2 or
                                    Model_Check(ModelRequest, [Models.FraudAdvisor_Constants.ThisSet_for_BSOPTIONS,'fp1403_2','fp1510_2']);
                                    
    turn_on_AllowInsuranceDLInfo := doAttributesVersion201 OR doAttributesVersion202 OR doTMXAttributes;
    turn_on_AlwaysCheckInsurance := doAttributesVersion201 OR doAttributesVersion202 OR doTMXAttributes;
    turn_on_IncludeInquiries     := Model_Check(ModelRequest, ['fp1403_2','fp1510_2']) and doInquiries;
    turn_on_IncludeInsNAP        := Model_Check(ModelRequest, ['fp1403_2','fp1510_2']);// and ~DisallowInsurancePhoneHeaderGateway;
    turn_on_ThreatMetrix         := (Model_Check(ModelRequest, ['di31906_0']) or doTMXAttributes) and inputok;
    
    unsigned8 BSOptions := IF(turn_on_RetainInputDID, Risk_indicators.iid_constants.BSOptions.RetainInputDID, 0) +
                           IF(turn_on_IncludeDoNotMail, Risk_indicators.iid_constants.BSOptions.IncludeDoNotMail, 0) +
                           IF(turn_on_IncludeFraudVelocity, Risk_indicators.iid_constants.BSOptions.IncludeFraudVelocity, 0) +
                           IF(turn_on_IncludeHHIDSummary, Risk_indicators.iid_constants.BSOptions.IncludeHHIDSummary, 0) +
                           IF(turn_on_AllowInsuranceDLInfo, Risk_indicators.iid_constants.BSOptions.AllowInsuranceDLInfo, 0) +
                           IF(turn_on_AlwaysCheckInsurance, Risk_indicators.iid_constants.BSOptions.AlwaysCheckInsurance, 0) +
                           IF(turn_on_IncludeInquiries, Risk_indicators.iid_constants.BSOptions.IncludeInquiries, 0) +
                           IF(turn_on_IncludeInsNAP, Risk_indicators.iid_constants.BSOptions.IncludeInsNAP, 0)+
                           IF(turn_on_ThreatMetrix, Risk_indicators.iid_constants.BSOptions.RunThreatMetrix, 0) +
													 if(UseIngestDate, risk_indicators.iid_constants.BSOptions.UseIngestDate, 0);
    
    Return BSOptions;
  END;

  EXPORT Execute_model(models.FraudAdvisor_Constants.FP_model_params FP_mod) := Function
  
    cmName      := FP_mod.ModelOptions(STD.STR.ToLowerCase(TRIM(OptionName)) = 'custom');
    model_name  := STD.STR.ToLowerCase(TRIM(cmName[1].OptionValue));

    cmGrade            := FP_mod.ModelOptions(STD.STR.ToLowerCase(TRIM(OptionName)) = 'grade');
    cm_GradeValue      := STD.STR.ToLowerCase(TRIM(cmGrade[1].OptionValue));
    cmRetailZip        := FP_mod.ModelOptions(STD.STR.ToLowerCase(TRIM(OptionName)) = 'retailzip');
    cm_RetailZipValue  := STD.STR.ToLowerCase(TRIM(cmRetailZip[1].OptionValue));
    cmLoadAmount       := FP_mod.ModelOptions(STD.STR.ToLowerCase(TRIM(OptionName)) = 'loadamount');
    cm_LoadAmountValue := STD.STR.ToLowerCase(TRIM(cmLoadAmount[1].OptionValue));
    cmSegment          := FP_mod.ModelOptions(STD.STR.ToLowerCase(TRIM(OptionName)) = 'segment');
    cm_SegmentValue    := STD.STR.ToLowerCase(TRIM(cmSegment[1].OptionValue));
    cmLexID            := FP_mod.ModelOptions(STD.STR.ToLowerCase(TRIM(OptionName)) = 'lexid');
    cm_LexIDValue      := STD.STR.ToLowerCase(TRIM(cmLexID[1].OptionValue));

    //These models use Layout Model out, so project them into layout_fp1109 right away
    model_fp3710_0  := Project(Models.FP3710_0_0( FP_mod._clam_ip, 6, false), transform(models.layouts.layout_fp1109, self := left, self := []));
    model_fp3710_9  := Project(Models.FP3710_0_0( FP_mod._clam_ip, 6, true), transform(models.layouts.layout_fp1109, self := left, self := [])); // FP3710_9 is simply FP3710_0 with criminal risk codes returned
    model_fp3904_1  := Project(Models.FP3904_1_0( ungroup(FP_mod._clam) ), transform(models.layouts.layout_fp1109, self := left, self := []));
    model_fp3905_1  := Project(Models.FP3905_1_0( ungroup(FP_mod._clam) ), transform(models.layouts.layout_fp1109, self := left, self := []));
    model_fd5609_2  := Project(Models.FD5609_2_0( FP_mod._clam, true ), transform(models.layouts.layout_fp1109, self := left, self := []));
    model_ain801_1  := Project(Models.AIN801_1_0(FP_mod._clam, true, cm_GradeValue), transform(models.layouts.layout_fp1109, self := left, self := []));
    model_fp31203_1 := Project(Models.FP31203_1_0(FP_mod._clam_ip, cm_GradeValue), transform(models.layouts.layout_fp1109, self := left, self := []));
    model_fp31105_1 := Project(Models.FP31105_1_0(FP_mod._clam_ip), transform(models.layouts.layout_fp1109, self := left, self := []));
    model_fp1310_1  := Project(Models.FP1310_1_0( ungroup(FP_mod._clam), 6), transform(models.layouts.layout_fp1109, self := left, self := []));
    model_fp1401_1  := Project(Models.FP1401_1_0( ungroup(FP_mod._clam), 6), transform(models.layouts.layout_fp1109, self := left, self := []));
    model_fp1406_1  := Project(Models.FP1406_1_0( ungroup(FP_mod._clam), 6), transform(models.layouts.layout_fp1109, self := left, self := []));
    model_fp1403_2  := Project(Models.FP1403_2_0( ungroup(FP_mod._clam), 6), transform(models.layouts.layout_fp1109, self := left, self := []));
    model_fp1409_2  := Project(Models.FP1409_2_0( ungroup(FP_mod._clam_BtSt)), transform(models.layouts.layout_fp1109, self := left, self := []));
    model_fp1506_1  := Project(Models.FP1506_1_0( ungroup(FP_mod._clam), 6), transform(models.layouts.layout_fp1109, self := left, self := []));
    model_fp1509_1  := Project(Models.FP1509_1_0( ungroup(FP_mod._clam), 6), transform(models.layouts.layout_fp1109, self := left, self := []));
    model_fp1510_2  := Project(Models.FP1510_2_0( ungroup(FP_mod._clam), 6), transform(models.layouts.layout_fp1109, self := left, self := []));
    model_fp1511_1  := Project(Models.FP1511_1_0( ungroup(FP_mod._clam), 6), transform(models.layouts.layout_fp1109, self := left, self := []));
    model_msn1803_1 := Project(Models.MSN1803_1_0( ungroup(FP_mod._clam) ), transform(models.layouts.layout_fp1109, self := left, self := []));
    model_rsn804_1  := Project(Models.RSN804_1_0( FP_mod._clam, FP_mod._skiptrace, FP_mod._easicensus ), transform(models.layouts.layout_fp1109, self := left, self := []));

    // These models are already in layout fp1109 so they can continue doing what they were doing.
    model_fp1109_0   := Models.FP1109_0_0( FP_mod._clam_ip, 6, false);
    model_fp1109_9   := Models.FP1109_0_0( FP_mod._clam_ip, 6, true); // FP1109_9 is simply FP1109_0 with criminal risk codes returned
    model_fp31505_0    := Models.FP31505_0_Base( FP_mod._clam_ip, 6, false); 
    model_fp3fdn1505_0 := Models.FP3FDN1505_0_Base( FP_mod._clam_ip, 6, false); 
    model_fp31505_9    := Models.FP31505_0_Base( FP_mod._clam_ip, 6, true); //_9 is the "criminal" version of the flagship model
    model_fp3fdn1505_9 := Models.FP3FDN1505_0_Base( FP_mod._clam_ip, 6, true); //_9 is the "criminal" version of the flagship model
    
    model_fp1610_1 := Models.FP1610_1_0( ungroup(FP_mod._clam), 6);
    model_fp1610_2 := Models.FP1610_2_0( ungroup(FP_mod._clam), 6);
    model_fp1609_1 := Models.FP1609_1_0( ungroup(FP_mod._clam), 6);
    model_fp1611_1 := Models.FP1611_1_0( ungroup(FP_mod._clam), 6);
    model_fp1606_1 := Models.FP1606_1_0( ungroup(FP_mod._clam), 6);
    model_fp1702_2 := Models.FP1702_2_0( ungroup(FP_mod._clam), 6);
    model_fp1702_1 := Models.FP1702_1_0( ungroup(FP_mod._clam), 6);
    model_fp1706_1 := Models.FP1706_1_0( ungroup(FP_mod._clam), 6);
    model_fp1609_2 := Models.FP1609_2_0( ungroup(FP_mod._clam), 6);
    model_fp1607_1 := Models.FP1607_1_0( ungroup(FP_mod._clam), 6);
    model_fp1712_0 := Models.FP1712_0_0( ungroup(FP_mod._clam), 1); // Fraud flags model -- only one risk indicator is returned.
    model_fp1508_1 := Models.FP1508_1_0( ungroup(FP_mod._clam), 6); 
    model_fp1802_1 := Models.FP1802_1_0( ungroup(FP_mod._clam), 6); 
    model_fp1705_1 := Models.FP1705_1_0( ungroup(FP_mod._clam), 6); 
    model_fp1801_1 := Models.FP1801_1_0( ungroup(FP_mod._clam), 6);
    model_fp1806_1 := Models.FP1806_1_0( ungroup(FP_mod._clam), 6);
    model_fp1710_1 := Models.FP1710_1_0( ungroup(FP_mod._clam), 6);
    model_fp1803_1 := Models.FP1803_1_0( ungroup(FP_mod._clam), 6);
    model_fp1902_1 := Models.FP1902_1_0( FP_mod._clam_ip, 6);
    model_fp1908_1 := Models.fp1908_1_0( FP_mod._clam, 6, FP_mod._FDattributes);		
    model_fp1909_1 := Models.fp1909_1_0( FP_mod._clam, 6, FP_mod._FDattributes);		
    model_fp1909_2 := Models.FP1909_2_0( FP_mod._clam, 6, FP_mod._FDattributes);    
    model_di31906_0 := Models.DI31906_0_0( ungroup(FP_mod.IID_ret)); 
    model_fp1907_1 := Models.FP1907_1_0( ungroup(FP_mod._clam_ip), 6);
    model_fp1907_2 := Models.FP1907_2_0( ungroup(FP_mod._clam), 6);
    
    //These models use the RiskIndicies from fp1109 so they are assigned to temp variables for the joins below
    model_fp1303_1_temp := Models.FP1303_1_0( ungroup(FP_mod._clam), 6, false);
    model_fp1404_1_temp := Models.FP1404_1_0( ungroup(FP_mod._clam), 6);
    model_fp1407_1_temp := Models.FP1407_1_0( ungroup(FP_mod._clam), 6, cm_SegmentValue);
    model_fp1407_2_temp := Models.FP1407_2_0( ungroup(FP_mod._clam), 6, cm_SegmentValue);
    model_fp1307_2_temp   := Models.FP1307_2_0( FP_mod._clam_ip, 6, false);
    model_fp1307_1_temp   := Models.FP1307_1_0( ungroup(FP_mod._clam), 6);
    model_fp31310_2_temp  := Models.FP31310_2_0( ungroup(FP_mod._clam_ip), 6, cm_RetailZipValue, cm_LoadAmountValue);
    model_fp1509_2_temp   := Models.FP1509_2_0( ungroup(FP_mod._clam_BtSt), cm_LoadAmountValue);
    model_fp1512_1_temp   := Models.FP1512_1_0( ungroup(FP_mod._clam), 6 );
    model_fp31604_0_temp  := Models.FP31604_0_0( ungroup(FP_mod._clam), 6 );
    model_fp1704_1_temp := Models.FP1704_1_0( ungroup(FP_mod._clam), 6 );

    model_fp1307_2 := join(model_fp1109_0, model_fp1307_2_temp, //fp1307_2 returns the indice info WITH the fp1109_0 score, etc.
                        left.seq = right.seq,
                          transform(models.layouts.layout_fp1109, 
                            self.StolenIdentityIndex := right.StolenIdentityIndex,
                            self.SyntheticIdentityIndex := right.SyntheticIdentityIndex,
                            self.ManipulatedIdentityIndex := right.ManipulatedIdentityIndex,
                            self.VulnerableVictimIndex := right.VulnerableVictimIndex,
                            self.FriendlyFraudIndex := right.FriendlyFraudIndex,
                            self.SuspiciousActivityIndex := right.SuspiciousActivityIndex,
                            self := left));
    model_fp1307_1 := join(model_fp1307_1_temp, model_fp1109_0, //fp1307_1 returns the indice from fp1109_0 score
                        left.seq = right.seq,
                          transform(models.layouts.layout_fp1109, 
                            self.StolenIdentityIndex := right.StolenIdentityIndex,
                            self.SyntheticIdentityIndex := right.SyntheticIdentityIndex,
                            self.ManipulatedIdentityIndex := right.ManipulatedIdentityIndex,
                            self.VulnerableVictimIndex := right.VulnerableVictimIndex,
                            self.FriendlyFraudIndex := right.FriendlyFraudIndex,
                            self.SuspiciousActivityIndex := right.SuspiciousActivityIndex,
                            self := left));	
    model_fp31310_2 := join(model_fp31310_2_temp, model_fp1109_0, //fp31310_2 returns the indice from fp1109_0 score
                        left.seq = right.seq,
                          transform(models.layouts.layout_fp1109, 
                            self.StolenIdentityIndex := right.StolenIdentityIndex,
                            self.SyntheticIdentityIndex := right.SyntheticIdentityIndex,
                            self.ManipulatedIdentityIndex := right.ManipulatedIdentityIndex,
                            self.VulnerableVictimIndex := right.VulnerableVictimIndex,
                            self.FriendlyFraudIndex := right.FriendlyFraudIndex,
                            self.SuspiciousActivityIndex := right.SuspiciousActivityIndex,
                            self := left));
    model_fp1509_2 := join(model_fp1509_2_temp, model_fp1109_0, //fp1509_2 returns the indices from fp1109_0 score
                        left.seq = right.seq,
                          transform(models.layouts.layout_fp1109, 
                            self.StolenIdentityIndex := right.StolenIdentityIndex,
                            self.SyntheticIdentityIndex := right.SyntheticIdentityIndex,
                            self.ManipulatedIdentityIndex := right.ManipulatedIdentityIndex,
                            self.VulnerableVictimIndex := right.VulnerableVictimIndex,
                            self.FriendlyFraudIndex := right.FriendlyFraudIndex,
                            self.SuspiciousActivityIndex := right.SuspiciousActivityIndex,
                            self := left));			
    model_fp1512_1 := join(model_fp1512_1_temp, model_fp1109_0, //fp1512_1 returns the indices from fp1109_0 score
                        left.seq = right.seq,
                          transform(models.layouts.layout_fp1109, 
                            self.StolenIdentityIndex := right.StolenIdentityIndex,
                            self.SyntheticIdentityIndex := right.SyntheticIdentityIndex,
                            self.ManipulatedIdentityIndex := right.ManipulatedIdentityIndex,
                            self.VulnerableVictimIndex := right.VulnerableVictimIndex,
                            self.FriendlyFraudIndex := right.FriendlyFraudIndex,
                            self.SuspiciousActivityIndex := right.SuspiciousActivityIndex,
                            self := left));
    model_fp31604_0 := join(model_fp31604_0_temp, model_fp1109_0, //fp31604_0 returns the indices from fp1109_0 score
                        left.seq = right.seq,
                          transform(models.layouts.layout_fp1109, 
                            self.StolenIdentityIndex := [],
                            self.SyntheticIdentityIndex := [],
                            self.ManipulatedIdentityIndex := [],
                            self.VulnerableVictimIndex := right.VulnerableVictimIndex,
                            self.FriendlyFraudIndex := right.FriendlyFraudIndex,
                            self.SuspiciousActivityIndex := right.SuspiciousActivityIndex,
                            self := left));	
    model_fp1303_1 := join(model_fp1303_1_temp, model_fp1109_0, //fp31604_0 returns the indices from fp1109_0 score
                      left.seq = right.seq,
                        transform(models.layouts.layout_fp1109, 
                          self.StolenIdentityIndex := right.StolenIdentityIndex,
                          self.SyntheticIdentityIndex := right.SyntheticIdentityIndex,
                          self.ManipulatedIdentityIndex := right.ManipulatedIdentityIndex,
                          self.VulnerableVictimIndex := right.VulnerableVictimIndex,
                          self.FriendlyFraudIndex := right.FriendlyFraudIndex,
                          self.SuspiciousActivityIndex := right.SuspiciousActivityIndex,
                          self := left));	
    model_fp1404_1 := join(model_fp1404_1_temp, model_fp1109_0, //fp31604_0 returns the indices from fp1109_0 score
                      left.seq = right.seq,
                        transform(models.layouts.layout_fp1109, 
                          self.StolenIdentityIndex := right.StolenIdentityIndex,
                          self.SyntheticIdentityIndex := right.SyntheticIdentityIndex,
                          self.ManipulatedIdentityIndex := right.ManipulatedIdentityIndex,
                          self.VulnerableVictimIndex := right.VulnerableVictimIndex,
                          self.FriendlyFraudIndex := right.FriendlyFraudIndex,
                          self.SuspiciousActivityIndex := right.SuspiciousActivityIndex,
                          self := left));	
    model_fp1407_1 := join(model_fp1407_1_temp, model_fp1109_0, //fp31604_0 returns the indices from fp1109_0 score
                      left.seq = right.seq,
                        transform(models.layouts.layout_fp1109, 
                          self.StolenIdentityIndex := right.StolenIdentityIndex,
                          self.SyntheticIdentityIndex := right.SyntheticIdentityIndex,
                          self.ManipulatedIdentityIndex := right.ManipulatedIdentityIndex,
                          self.VulnerableVictimIndex := right.VulnerableVictimIndex,
                          self.FriendlyFraudIndex := right.FriendlyFraudIndex,
                          self.SuspiciousActivityIndex := right.SuspiciousActivityIndex,
                          self := left));	
    model_fp1407_2 := join(model_fp1407_2_temp, model_fp1109_0, //fp31604_0 returns the indices from fp1109_0 score
                      left.seq = right.seq,
                        transform(models.layouts.layout_fp1109, 
                          self.StolenIdentityIndex := right.StolenIdentityIndex,
                          self.SyntheticIdentityIndex := right.SyntheticIdentityIndex,
                          self.ManipulatedIdentityIndex := right.ManipulatedIdentityIndex,
                          self.VulnerableVictimIndex := right.VulnerableVictimIndex,
                          self.FriendlyFraudIndex := right.FriendlyFraudIndex,
                          self.SuspiciousActivityIndex := right.SuspiciousActivityIndex,
                          self := left));
    model_fp1704_1 := join(model_fp1704_1_temp, model_fp31505_0, //fp31505_0 returns the indices from fp1109_0 score
                      left.seq = right.seq,
                        transform(models.layouts.layout_fp1109, 
                          self.StolenIdentityIndex := right.StolenIdentityIndex,
                          self.SyntheticIdentityIndex := left.SyntheticIdentityIndex,// comming fromleft 
                          self.ManipulatedIdentityIndex := right.ManipulatedIdentityIndex,// comming from left 
                          self.VulnerableVictimIndex := right.VulnerableVictimIndex,
                          self.FriendlyFraudIndex := right.FriendlyFraudIndex,
                          self.SuspiciousActivityIndex := left.SuspiciousActivityIndex,
                           self.ri := right.ri;
                          self.score := right.score;
                          self := right));

    //call wrappers for Combined IDA models
    model_fibn12010_0 := Models.getLuciModel(FP_mod).FIBN12010_0;
    model_fiwn12103_0 := Models.getLuciModel(FP_mod).FIWN12103_0;

#if(Models.FraudAdvisor_Constants.VALIDATION_MODE)
		model_info := model_fp1908_1; 

#ELSE

    model_info := CASE(model_name,
                        'fp3710_0' => model_fp3710_0,
                        'fp3710_9' => model_fp3710_9,
                        'fp3904_1' => model_fp3904_1,
                        'fp3905_1' => model_fp3905_1,
                        'fd5609_2' => model_fd5609_2,
                        'ain801_1' => model_ain801_1,
                        'fp1109_0' => model_fp1109_0,
                        'fp1109_9' => model_fp1109_9,
                        'fp31105_1' => model_fp31105_1,
                        'fp31203_1' => model_fp31203_1,
                        'fp3fdn1505_0' => model_fp3fdn1505_0,
                        'fp3fdn1505_9' => model_fp3fdn1505_9,
                        'fp1303_1' => model_fp1303_1,
                        'fp1307_1' => model_fp1307_1,
                        'fp1307_2' => model_fp1307_2,
                        'fp1310_1' => model_fp1310_1,
                        'fp31310_2' => model_fp31310_2,
                        'fp1401_1' => model_fp1401_1,
                        'fp1403_2' => model_fp1403_2,
                        'fp1404_1' => model_fp1404_1,
                        'fp1406_1' => model_fp1406_1,
                        'fp1407_1' => model_fp1407_1,
                        'fp1407_2' => model_fp1407_2,
                        'fp1409_2' => model_fp1409_2,
                        'fp31505_0' => model_fp31505_0,
                        'fp31505_9' => model_fp31505_9,
                        'fp1506_1' => model_fp1506_1,
                        'fp1508_1' => model_fp1508_1,
                        'fp1509_1' => model_fp1509_1,
                        'fp1509_2' => model_fp1509_2,
                        'fp1510_2' => model_fp1510_2,
                        'fp1511_1' => model_fp1511_1,
                        'fp1512_1' => model_fp1512_1,
                        'fp31604_0' => model_fp31604_0,
                        'fp1606_1' => model_fp1606_1,
                        'fp1607_1' => model_fp1607_1,
                        'fp1609_1' => model_fp1609_1,
                        'fp1609_2' => model_fp1609_2,
                        'fp1610_1' => model_fp1610_1,
                        'fp1610_2' => model_fp1610_2,
                        'fp1611_1' => model_fp1611_1,
                        'fp1702_1' => model_fp1702_1,
                        'fp1702_2' => model_fp1702_2,
                        'fp1704_1' => model_fp1704_1,
                        'fp1705_1' => model_fp1705_1,
                        'fp1706_1' => model_fp1706_1,
                        'fp1710_1' => model_fp1710_1,
                        'fp1712_0' => model_fp1712_0,
                        'fp1801_1' => model_fp1801_1,
                        'fp1802_1' => model_fp1802_1,
                        'fp1803_1' => model_fp1803_1,
                        'fp1806_1' => model_fp1806_1,
                        'fp1902_1' => model_fp1902_1,

                        'fp1908_1' => model_fp1908_1,
                        'fp1909_1' => model_fp1909_1,
                        'fp1909_2' => model_fp1909_2,
                        'di31906_0' => model_di31906_0,
                        'msn1803_1' => model_msn1803_1,
                        'rsn804_1'  => model_rsn804_1,
                        'fp1907_1'  => model_fp1907_1,
                        'fp1907_2'  => model_fp1907_2,
                        'fibn12010_0'  => model_fibn12010_0,
                        'fiwn12103_0'  => model_fiwn12103_0,
                                       DATASET([], models.layouts.layout_fp1109) // Return blank dataset if unknown model
                       );
   #END                  
    return model_info[1];

  END;

END;
