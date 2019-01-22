import Suppress, ut, AutoHeaderV2;

EXPORT get_dids (dataset(AutoHeaderV2.layouts.unprocessed_input) ds_search_in, integer s_code=0,
								 boolean forceLocal = true, boolean ShowMessages = false) := function
	// Not a true "batch" at the moment
  _row := ds_search_in[1];

  // enable wildcard search and other specific search features
  search_code := s_code + 
                 if (_row.allow_wildcard, AutoHeaderV2.Constants.SearchCode.ALLOW_WILDCARD, 0) +
                 if (_row.currentResidentsOnly, AutoHeaderV2.Constants.SearchCode.CURRENT_RESIDENTS, 0);

  // pre-processing, transforming to a real library interface
  unsigned1 saltLeadThresholdOverwrite := AutoHeaderV2.Constants.SaltLeadThreshold : STORED('SaltLeadThreshold');
  AutoHeaderV2.layouts.lib_search Preprocess (AutoHeaderV2.layouts.unprocessed_input L) := transform
    Self.ssn := AutoHeaderV2.translate.GetCleanedSSN (L.ssn, L.ApplicationType);
    Self.saltLeadThreshold := saltLeadThresholdOverwrite;
    Self := L;
  end;
	ds_search := project(ds_search_in, Preprocess (Left));

	// read here from stored
	integer libVersion := AutoHeaderV2.Constants.LibVersion.LEGACY : STORED('SearchLibraryVersion');
	lib_local := LIBCALL_header (ds_search, search_code, libVersion);

	// remote search (note: no checking for temp_adl_service_ip='')
  lib_remote := AutoHeaderV2.functions.GetDIDsRemote (ds_search, search_code, _row.seisintadlservice);

  dids_fetched := if (forceLocal, lib_local.results, lib_remote[1].results);

  // post-processing
  Suppress.MAC_Suppress(dids_fetched,resfil_pulled,_row.ApplicationType,Suppress.Constants.LinkTypes.DID,did,,,false,_row.DemoCustomerName);
			
  dids := resfil_pulled;

// commenting it out due to the platform issue: HPCC-12378
/*
  messages := if (forceLocal, lib_local.messages, lib_remote[1].messages);
  // the only message which is currently of interest for the customers
  messages_spec := messages (status = Constants.Status._MNAME);
  messages_out := project (messages_spec, 
                           transform (ut.LayoutMessage, Self.code := ut.constants_MessageCodes.REMOVE_MNAME, Self.msg := ''));
  if (ShowMessages and exists (messages_spec), output (messages_out, NAMED('MessageCodes'), extend));
*/
  return dids;
end;