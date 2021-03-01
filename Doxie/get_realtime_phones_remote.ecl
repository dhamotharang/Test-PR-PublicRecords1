IMPORT gateway;
EXPORT get_realtime_phones_remote (doxie.realTimePhonesParams.searchParams in_mod) := FUNCTION
  serviceURL := in_mod.Gateways(Gateway.Configuration.IsNeutralRoxie(servicename))[1].URL;
  serviceName := 'doxie.phone_noreconn_search';

  Doxie.layout_realTimePhones.finalRec soapFailure() := TRANSFORM 
    SELF := [];
  END;

  doxie.layout_realTimePhones.rtp_in_layout prepare_rtp_input() := TRANSFORM
    SELF.DPPAPurpose :=  in_mod.DPPAPurpose;
    SELF.GLBPurpose := in_mod.GLBPurpose;
    SELF.SSN := in_mod.SSN;
    SELF.LastName := in_mod.lastname;
    SELF.GetSSNBest := TRUE;
    SELF.SuppressBlankNameAddress := TRUE;
    SELF.IncludeRealTimePhones := TRUE;
    SELF.IncludeFullPhonesPlus := TRUE;
    SELF.IncludeHRI := TRUE;
    SELF.IncludeLastResort := TRUE;
    SELF.useQSentV2 := if(in_mod.isFCRA_val, FALSE, TRUE);
    SELF.DataPermissionMask := in_mod.DataPermissionMask;
    SELF.DataRestrictionMask := in_mod.DataRestrictionMask;
    SELF.ApplicationType := in_mod.ApplicationType;
    SELF.IndustryClass := in_mod.IndustryClass;
    SELF.SSNMask := in_mod.SSNMask;
    SELF.DOBMask := in_mod.DOBMask;
    SELF.Gateways := PROJECT(in_mod.Gateways,
                       TRANSFORM(Gateway.Layouts.Config,
                         SELF.ServiceName := IF(LEFT.ServiceName IN ['qsent', 'qsentv2', 'neutralroxie'], LEFT.ServiceName, SKIP),
                         SELF := LEFT));
    SELF := [];
  END;	

  soap_input := DATASET ([prepare_rtp_input()]);
	
  // Retrieve the Results dataset and the Royalty dataset.  
  // At the time the code was written it does not work in a 
  // builder window but does work when deployed.
  soapResponse := IF(serviceURL!='', soapcall(soap_input, 
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