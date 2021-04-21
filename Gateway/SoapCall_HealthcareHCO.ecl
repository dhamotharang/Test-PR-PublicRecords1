IMPORT Gateway, iesp;

EXPORT SoapCall_HealthcareHCO(DATASET(iesp.healthcare_orgaccurint.t_HealthCareAccurintHCOSearchRequestEx) batch_in,
															string40 servicename = Gateway.Constants.ServiceName.IsHCHCO) := FUNCTION

  queryName := 'healthcare_accurint.searchservicehco';
	out_rec := iesp.healthcare_orgaccurint.t_HealthCareAccurintHCOSearchResponse;
  dGWCfg := Gateway.Configuration.Get();
  dHCPGWCfg := dGWCfg(Gateway.Configuration.IsHCHCO(servicename));
	INTEGER waittime := Gateway.Constants.Defaults.WAIT_TIMEOUT;
	INTEGER retries := Gateway.Constants.Defaults.RETRIES;
  serviceURL := dHCPGWCfg[1].url;

  // Save fatal SOAP errors
  out_rec SetError (batch_in inn) := TRANSFORM
    Self._Header.Exceptions := dataset ([transform (iesp.share.t_WsException, 
                                                    Self.Source := 'SearchServiceHCO',
                                                    Self.Code := FAILCODE,
                                                    Self.Location := '',
                                                    Self.Message := FAILMESSAGE)]);
    self := [];
  END;

  // execute soapcall or create results from input
  sc_results := map(count(batch_in)>0 and serviceURL <>'' => SOAPCALL (batch_in, 
																																				serviceURL,
																																				queryName, 
																																				{batch_in},
																																				dataset (out_rec), 
																																				XPATH('healthcare_accurint.searchservicehcoResponse/Results/Result/Dataset[@name=\'Results\']/Row'),
																																				onFail (SetError (Left)), TIMEOUT(waittime),RETRY(retries),TRIM,LOG),
										dataset([],out_rec));

	// output (dHCPGWCfg, named ('dHCPGWCfg'));  
	// output (serviceURL, named ('serviceHCOURL'));  
	// output (batch_in, named ('batch_in'));  
  return sc_results;
END;
