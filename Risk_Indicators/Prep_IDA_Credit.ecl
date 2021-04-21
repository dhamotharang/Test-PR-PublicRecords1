IMPORT Risk_Indicators, Gateway, STD, _control, iesp;

EXPORT Prep_IDA_Credit( DATASET(Risk_Indicators.layouts.layout_IDA_in) indata, 
                        DATASET(Gateway.Layouts.Config) gateways,
                        BOOLEAN IsInnovis = FALSE,
                        STRING IntendedPurpose = '',
                        BOOLEAN isCalifornia_in_person = FALSE,
                        UNSIGNED1 Timeout_sec = 3,
                        UNSIGNED1 Retries = 0
                      ) := FUNCTION

  //Check to see how we should be running the IDA call
  // 0 means production mode
  // 1 means dev testing mode
  // 2 means retro testing mode
  // 3 = fallthrough condition, this shouldn't happen but if it does, I think we shouldn't call the gateway
  Gateway_mode := MAP( EXISTS(gateways(STD.STR.ToLowerCase(TRIM(servicename)) = Risk_Indicators.iid_constants.idareport))      => 0,
                       EXISTS(gateways(STD.STR.ToLowerCase(TRIM(servicename)) = Risk_Indicators.iid_constants.idareportUAT))   => 1,
                       EXISTS(gateways(STD.STR.ToLowerCase(TRIM(servicename)) = Risk_Indicators.iid_constants.idareportRetro)) => 2,
                                                                                                                                  3);
 
  //Put the IDA test service names back to the correct name if present
  Gateway.Layouts.Config gw_prep(Gateway.Layouts.Config le) := TRANSFORM  
    SELF.servicename := MAP(STD.STR.ToLowerCase(TRIM(le.servicename)) = Risk_Indicators.iid_constants.idareportUAT   => Risk_Indicators.iid_constants.idareport,
                            STD.STR.ToLowerCase(TRIM(le.servicename)) = Risk_Indicators.iid_constants.idareportRetro => Risk_Indicators.iid_constants.idareport,
                                                                                                                        le.servicename);
    SELF := le;
  END;

  gateways_prep := PROJECT(gateways, gw_prep(LEFT));
    
  //----------------------------------------------------------------------------
  // These settings are just for the IDA gateway call for credit right now
  // IF changes are needed in the future, may need to add additional logic here
  //----------------------------------------------------------------------------
    
  //populate IDA input based on what's requested and how
  IDA_input := PROJECT(indata, TRANSFORM(Risk_Indicators.layouts.layout_IDA_in,
      intended_purpose := trim(STD.Str.ToUpperCase(IntendedPurpose));

      SELF.App_ID := LEFT.App_ID;
      SELF.Solution := Risk_Indicators.iid_constants.idaStandardSolution;
      SELF.CARetailFlag := if(isCalifornia_in_person and intended_purpose='APPLICATION', Risk_Indicators.iid_constants.idaCA_Retail, Risk_Indicators.iid_constants.idaNotCA_Retail); 
      SELF.Client := TRIM((Risk_Indicators.iid_constants.idaCreditClienPrefix + TRIM(LEFT.CompanyID) + intended_purpose), ALL);  
      SELF.ProductName := Risk_Indicators.iid_constants.idaCreditProductName; //Will need to make this configurable once Innovis models are ready
      SELF.ProductID := Risk_Indicators.iid_constants.idaCreditProductID;     //Will need to make this configurable once Innovis models are ready
      //Real transactions should never go over 16 characters and IDA breaks if it goes over 17, so limit what can be passed to IDA
      SELF.ESPTransactionId := IF(LENGTH(TRIM(LEFT.ESPTransactionId)) > 16, LEFT.ESPTransactionId[1..16], TRIM(LEFT.ESPTransactionId));
      SELF.Affiliate := LEFT.Affiliate[1..100]; //Truncate Affiliate to 100 chars cause thats all IDA supports
      SELF := LEFT
			));
  
  FromIDA := Risk_Indicators.getIDA_attributes(IDA_input, gateways_prep, Gateway_mode, Timeout_sec, Retries);

  //Don't want IDA gateway running in batch yet
  #IF(_control.Environment.OnThor)
    final := DATASET([], iesp.ida_report_response.t_IDAReportResponseEx);
  #ELSE

  //Need the full response for credit since we need to know about consumer statements
  Final := FromIDA;

  #END
  
  // output(gateways, named('gateways_raw'));
  // output(gateways_prep, named('Prep_gateways'));
  // output(IDA_input, named('Prep_IDA_input'));
  // output(FromIDA, named('FromIDA'));
  
  RETURN Final;

END;