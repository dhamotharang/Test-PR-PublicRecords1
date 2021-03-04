IMPORT Gateway, Risk_Indicators, STD, suppress;
EXPORT get_realtime_phones_remote (doxie.realTimePhonesParams.searchParams in_mod,
                                   BOOLEAN useRTP_in = FALSE) := FUNCTION
  serviceURL := in_mod.Gateways(Gateway.Configuration.IsNeutralRoxie(servicename))[1].URL;
  serviceName := 'doxie.phone_noreconn_search';

  Doxie.layout_realTimePhones.finalRec soapFailure() := TRANSFORM 
    SELF := [];
  END;

  doxie.layout_realTimePhones.rtp_in_layout prepare_rtp_input() := TRANSFORM
    SELF.DPPAPurpose :=  in_mod.dppa;
    SELF.GLBPurpose := in_mod.glb;
    SELF.SSN := in_mod.SSN;
    SELF.LastName := in_mod.lastname;
    SELF.GetSSNBest := TRUE;
    SELF.SuppressBlankNameAddress := TRUE;
    SELF.IncludeRealTimePhones := TRUE;
    SELF.IncludeFullPhonesPlus := TRUE;
    SELF.IncludeHRI := TRUE;
    SELF.IncludeLastResort := TRUE;
    SELF.useQSentV2 := TRUE;
    SELF.DataPermissionMask := in_mod.DataPermissionMask;
    SELF.DataRestrictionMask := in_mod.DataRestrictionMask;
    SELF.ApplicationType := in_mod.application_type;
    SELF.IndustryClass := in_mod.industry_class;
    SELF.SSNMask := in_mod.ssn_mask;
    SELF.DOBMask := suppress.date_mask_math.MaskValue(in_mod.dob_mask);
    SELF.Gateways := PROJECT(in_mod.Gateways,
                       TRANSFORM(Risk_Indicators.Layout_Gateways_In,
                         SELF.ServiceName := IF(STD.STR.ToLowerCase(LEFT.ServiceName) IN ['qsent', 'qsentv2', 'neutralroxie'], LEFT.ServiceName, SKIP),
                         SELF := LEFT));
    SELF._TransactionId := in_mod.Gateways[1].TransactionId;
    SELF := [];
  END;	

  soap_input := DATASET ([prepare_rtp_input()]);
	
  // Retrieve the Results dataset and the Royalty dataset.  
  // At the time the code was written it does not work in a 
  // builder window but does work when deployed.
  soapResponse := IF(serviceURL!='' AND useRTP_in, 
                    soapcall(soap_input, 
                      serviceURL,
                      serviceName,  
                      {soap_input},
                      DATASET(Doxie.layout_realTimePhones.finalRec),
                      XPATH(serviceName + 'Response/Results/Result/'),
                      ONFAIL(soapFailure()), 
                      RETRY(0),
                      TIMEOUT(3)),
                      DATASET([],Doxie.layout_realTimePhones.finalRec));		
	
  // Transform is needed to compile.
  RETURN PROJECT(soapResponse, TRANSFORM(Doxie.layout_realTimePhones.finalRec, SELF := LEFT));
END;