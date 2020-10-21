IMPORT Models, Risk_Indicators, Gateway, STD;

EXPORT Prep_IDA_fraud(DATASET(Risk_Indicators.layouts.layout_IDAFraud_in) indata, 
                      DATASET(Gateway.Layouts.Config) gateways,
                      DATASET(Models.Layouts.Layout_Model_Request_In) Model_requests,
                      BOOLEAN Testing = FALSE,
                      BOOLEAN On_thor = FALSE
                     ) := FUNCTION

  //Check to see how we should be running the IDA call
  // 0 means production mode
  // 1 means dev testing mode
  // 2 means retro testing mode
  // 3 = fallthrough condition, this shouldn't happen but if it does, I think we shouldn't call the gateway
  Gateway_mode := MAP( EXISTS(gateways(STD.STR.ToLowerCase(TRIM(servicename)) = 'idareport'))       => 0,
                       EXISTS(gateways(STD.STR.ToLowerCase(TRIM(servicename)) = 'idareport_uat'))   => 1,
                       EXISTS(gateways(STD.STR.ToLowerCase(TRIM(servicename)) = 'idareport_retro')) => 2,
                                                                                                       3);
 
  //Put the IDA test service names back to the correct name if present
  Gateway.Layouts.Config gw_prep(Gateway.Layouts.Config le) := TRANSFORM  
    SELF.servicename := MAP(STD.STR.ToLowerCase(TRIM(le.servicename)) = 'idareport_uat'   => 'idareport',
                            STD.STR.ToLowerCase(TRIM(le.servicename)) = 'idareport_retro' => 'idareport',
                                                                                              le.servicename);
    SELF := le;
  END;

  gateways_prep := PROJECT(gateways, gw_prep(LEFT));
  
  IDA_models := Models.FraudAdvisor_Constants.IDA_models_set;
  
  //----------------------------------------------------------------------------
  // These settings are just for the IDA gateway call right now
  // IF changes are needed in the future, may need to add additional logic here
  //----------------------------------------------------------------------------
  
  //how to get Product Name into this function? pass in gateway info or by itself?
  tempProductName := MAP(Testing                                                                    => 'AllAttributes',
                         Models.FP_models.Model_Check(Model_requests, ['fibn12010_0', IDA_models])  => 'LNFraudAttributes',
                         Models.FP_models.Model_Check(Model_requests, ['modeling_attribute_model']) => 'LNFraudAttributes', //This might need to change once we know what it is
                                                                                                       '' //Then IDA isn't needed
                     );
  //how to get productID into this function? pass in gateway info or as a passed parameter
  tempProductID := MAP(Testing                                                                    => 'AA3.0',
                       Models.FP_models.Model_Check(Model_requests, ['fibn12010_0'])              => 'LFB1.0',
                       Models.FP_models.Model_Check(Model_requests, IDA_models)                   => 'LFSS1.0',
                       Models.FP_models.Model_Check(Model_requests, ['modeling_attribute_model']) => 'XA1.0',  //This will need to change once we know what it is
                                                                                                     '' //Then IDA isn't needed
                     );
  
  //populate ProductName and ID based on what's requested.
  IDA_input := PROJECT(indata, TRANSFORM(Risk_Indicators.layouts.layout_IDAFraud_in,
                               SELF.ProductName := tempProductName,
                               SELF.ProductID := tempProductID,
                               SELF.ESPTransactionId := IF(Gateway_mode != 0, 'ESPTestID'+LEFT.App_ID, LEFT.ESPTransactionId),
                               SELF := LEFT
                       ));
  
  FromIDA := Risk_Indicators.getIDAFraud(IDA_input, gateways_prep, Gateway_mode);
  
  //Fail the transaction if the IDA gateway call didn't work.
  //This check is for Fraudpoint/Fraud Intelligence, if a service ends up calling
  //IDA and they don't want the transaction to fail, will need to modify this logic
  IDA_gateway_check := (FromIDA[1].response._Header.Status != 0) OR 
                       (FromIDA[1].response.ErrorRecord.Code != '' AND FromIDA[1].response.ErrorRecord.Message != '');
  IF(IDA_gateway_check and ~On_thor, FAIL('503 Service Unavailable The service was unavailable due to temporary overload or maintenance.'));
  
  //Drop everything except the seq, AppID, and attributes
  Final := JOIN(indata, FromIDA,
                LEFT.App_ID = RIGHT.response.outputrecord.AppID, //Using AppID as unique Identifier
                  TRANSFORM(Risk_Indicators.layouts.layout_IDAFraud_out,
                            SELF.Seq := LEFT.seq,
                            SELF.APP_ID := LEFT.APP_ID,
                            SELF.Indicators := RIGHT.response.outputrecord.Indicators
                            ));
  
  // output(IDA_input, named('Prep_IDA_input'));
  // output(gateways, named('gateways_raw'));
  // output(gateways_prep, named('Prep_gateways'));
  
  RETURN Final;

END;