IMPORT Gateway, iesp;

EXPORT SoapCall_HealthcareHCPBatch(DATASET(iesp.healthcare_prvaccurint.t_HealthCareAccurintHCPBatchRequestEx) batch_in,
															string40 servicename = Gateway.Constants.ServiceName.IsHCHCPBatch) := FUNCTION

  queryName := 'healthcare_accurint.searchservicehcpbatch';
	out_rec := iesp.healthcare_prvaccurint.t_HealthCareAccurintHCPSearchResponse;
  dGWCfg := Gateway.Configuration.Get();
  dHCPGWCfg := dGWCfg(Gateway.Configuration.IsHCHCPBatch(servicename));
	INTEGER waittime := Gateway.Constants.Defaults.WAIT_TIMEOUT;
	INTEGER retries := Gateway.Constants.Defaults.RETRIES;
	serviceURL := dHCPGWCfg[1].url;

  // Save fatal SOAP errors
  out_rec SetError (batch_in inn) := TRANSFORM
    Self._Header.Exceptions := dataset ([transform (iesp.share.t_WsException, 
                                                    Self.Source := 'SearchServiceHCPBatch',
                                                    Self.Code := FAILCODE,
                                                    Self.Location := '',
                                                    Self.Message := FAILMESSAGE+' ServiceURL is '+serviceURL)]);
    self := [];
  END;

  // execute soapcall or create results from input
  sc_results := map(count(batch_in)>0 and serviceURL <>'' => SOAPCALL (batch_in, 
																																			serviceURL,
																																			queryName, 
																																			{batch_in},
																																			dataset (out_rec), 
																																			XPATH('healthcare_accurint.searchservicehcpbatchResponse/Results/Result/Dataset[@name=\'Results\']/Row'),
																																			onFail (SetError (Left)), TIMEOUT(waittime),RETRY(retries),TRIM,LOG),
										dataset([],out_rec));

	// output (dHCPGWCfg, named ('dHCPGWCfg'));  
	// output (serviceURL, named ('serviceHCPURL'));  
	// output (batch_in, named ('batch_in'));  
	// output (sc_results, named ('sc_results'));  
  return sc_results;
END;
