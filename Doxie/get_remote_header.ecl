// A SOAPCALL for remote header data; currently is used only to provide FCRA-neutral header data.

import doxie, doxie_crs, Gateway, riskwisefcra;

// SOAP errors are saved into the output, so the caller can check them outside

export get_remote_header (DATASET(Gateway.Layouts.Config) gateway_cfg, boolean IsFCRA = false) := FUNCTION

	string service_name := 'doxie.central_records_service_neutral';
  gateway_check := gateway_cfg (servicename IN riskwisefcra.Neutral_Service_Name)[1].url;
  string remote_ip := IF (gateway_check='', ERROR (301, doxie.ErrorCodes(301)), gateway_check);

  _ds_in := doxie.DistCRSDS (IsFCRA);
	
	temp_layout := record
		recordof(_ds_in);
		boolean _blind := false;
	end;
	
	ds_in := project(_ds_in , transform(temp_layout, 
																			self._Blind := Gateway.Configuration.GetBlindOption(gateway_cfg),
																			self := left));

  // Return failure messages
  fail_rec := record, maxlength(doxie_crs.maxlength_report)
    string14 did; //TODO:  what do we need it for?
    doxie.layout_central_header;
  end;
	
  fail_rec SetError (ds_in inn) := TRANSFORM
    self.did := inn.did;
    SElF.errors.code := IF(FAILCODE = 0, -1, FAILCODE);
    SELF.errors.message := FAILMESSAGE;
    self := [];
  END;
	
  // "neutral" in a sense of "being allowed to use on a customer side", for example on FCRA-side
  cr_neutral := SOAPCALL (ds_in, 
                          remote_ip,
                          service_name, 
                          {ds_in},
                          dataset (fail_rec), onFail (SetError (Left)));
  return cr_neutral;
end;