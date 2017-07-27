// A SOAPCALL for a PickList (header-search returning simplified rollup view)
// SOAP fatal errors are saved into the output, so the caller can check them outside

import iesp, Gateway , PersonSearch_Services;

// layout of an output structure
out_rec := iesp.person_picklist.t_PersonPickListResponse;
string service_name := 'PersonSearch_Services.PickListService';

export get_remote_picklist (
  dataset (iesp.person_picklist.t_PersonPickListRequest) request,
	dataset (Gateway.layouts.config) gateway_cfg
) := FUNCTION

  gateway_check := gateway_cfg (StringLib.StringToLowerCase (servicename) = PersonSearch_Services.Constants.picklist_gateway_name)[1].url;
  picklist_ip := IF (gateway_check='', ERROR (301, doxie.ErrorCodes(301)), gateway_check);

  // wrap it so that PickList service will get a structure:
  // <PersonPickListRequest><Row><User>...</User><Options>..</Options><SearchBy>...</SearchBy></Row></PersonPickListRequest>
  // without wrapping: <Row><User>...</User><Options>..</Options><SearchBy>...</SearchBy></Row>
  gateway_rec := record 
    dataset (iesp.person_picklist.t_PersonPickListRequest) PersonPickListRequest {maxcount(1)};
		boolean _Blind := false;
  end;
  gateway_rec Format () := transform
    Self.PersonPickListRequest := request;
		SELF._Blind := Gateway.Configuration.GetBlindOption(gateway_cfg);
  end;
  ds_in := dataset ([Format()]);

  // Save fatal SOAP errors
  out_rec SetError (ds_in inn) := TRANSFORM
    Self._Header.Exceptions := dataset ([transform (iesp.share.t_WsException, 
                                                    Self.Source := 'picklist',
                                                    Self.Code := FAILCODE,
                                                    Self.Location := '',
                                                    Self.Message := FAILMESSAGE)]);
    self := [];
  END;

  // Skip a soapcall if DID is the input and just DID info was requested.
  // Note, that checking this condition outside may not prevent a soapcall due to a platform "feature"
  in_uniqueid := request[1].SearchBy.UniqueID;
  boolean skip_soapcall := ((unsigned6) in_uniqueid != 0) and (request[1].Options.ReturnUniqueIdsOnly);

  iesp.person_picklist.t_PersonPickListRecord SetRecords () := transform
    Self.UniqueId := in_uniqueid;
    Self._Penalty := 0;
    Self := []; // Names, Addresses, DOBs, SSNs
  end;

  out_rec SetFromInput () := transform
    Self._Header := [];
    Self.SubjectTotalCount := 1;
    Self.Records := dataset ([SetRecords()]);
    Self.Messages := dataset ([{'306', 'DID provided in the input'}], iesp.share.t_CodeMap);
  end;

  // execute soapcall or create results from input
  cr_results := if (~skip_soapcall,
                    SOAPCALL (ds_in, 
                              picklist_ip,
                              service_name, 
                              {ds_in},
                              dataset (out_rec),
                              //XPATH('PickListResponse'),
                              onFail (SetError (Left)), TIMEOUT(3), RETRY(1)),
                    dataset ([SetFromInput ()]));

// output (request, named ('request'));  
  return cr_results;
end;