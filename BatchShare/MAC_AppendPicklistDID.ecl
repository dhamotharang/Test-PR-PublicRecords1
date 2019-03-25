// Appends a single DID to each record.
//    only if single unique DID was found;
//    in case of no DID was found or more than one DID matches input, sets corresponding error code.
//    keeps all payload from the input dataset;
//    It is responsibility of a caller to verify the input (a record has enough data, doesn't already have DID, 
//       input dataset doesn't have "duplicates", etc.).

// Min input layout required:
		// BatchShare.Layouts.ShareAcct.acctno;
		// BatchShare.Layouts.ShareName;
		// BatchShare.Layouts.ShareAddress;
		// BatchShare.Layouts.SharePII;

// in_params -- module containing general batch settings
// IsFCRA -- so far specifies only whether Rhode Islan restrictions should be checked
EXPORT MAC_AppendPicklistDID (inf, outf, in_params, IsFCRA = false) := MACRO

import doxie, iesp, suppress;

  #uniquename (gateway_cfg);
	%gateway_cfg% := in_params.gateways;
    
    //TODO: include errors
    
  #uniquename (rec_in);
  #uniquename (rec_picklist);
  %rec_in% := recordof (inf);
  %rec_picklist% := record (%rec_in%)
    dataset (iesp.person_picklist.t_PersonPickListRequest) request;
  end; 

  // "user" data (restrictions, etc.) are common for each input record
  #uniquename (SetUser);
  #uniquename (shared_user);
  iesp.share.t_User %SetUser% () := transform
    Self.GLBPurpose := (string) in_params.glb;
    Self.DLPurpose := (string) in_params.dppa;
    // Self.User.IndustryClass := gm.industryclass;
    Self.SSNMask := in_params.ssn_mask;
    // need a reverse translation here -- from actual value to the caller's input representation
    Self.DOBMask := Suppress.date_mask_math.MaskValue (in_params.dob_mask);
    Self.DLMask := in_params.dl_mask = 1;
    Self.DataRestrictionMask := in_params.DataRestrictionMask;
    Self.DataPermissionMask := in_params.DataPermissionMask;
    Self.ApplicationType := in_params.application_type;
    Self := []; // EndUser.*, TestDataEnabled, MaxWaitSeconds, etc.
  end;
  %shared_user% := row (%SetUser% ());

  // create an ESDL-Picklist struct for each input row (at the moment search is per every row)
  #uniquename (FormatBatchRequest);
  #uniquename (SetESDLBarchRequest);
  #uniquename (batch_request);
  iesp.person_picklist.t_PersonPickListRequest %FormatBatchRequest% (%rec_in% L) := transform
    Self.User := %shared_user%;
    // options
    Self.Options.ReturnUniqueIdsOnly := true; // no payload, just DIDs
    Self.Options.SkipFCRARestriction_RhodeIsland := ~IsFCRA;
    // should be hardcoded: StrictMatch, MaxResults, ReturnCount, StartingRecord
    // may be configurable: UsePhonetics, CheckNameVariants,UseNicknames
    Self.Options := []; //Blind, Encrypt, ReturnTokens, 
    // search by
    Self.SearchBy.UniqueID := if (L.did != 0, (string) L.did, ''); 
      // this is necessary to avoid sending zeros in the SOAP
      // strictly speaking, such records should be filtered out outside
    Self.SearchBy.SSN := L.ssn;  
    Self.SearchBy.Name := iesp.ECL2ESP.SetName (L.name_first, L.name_middle, L.name_last, L.name_suffix, '', '');
    Self.SearchBy.Address := iesp.ECL2ESP.SetAddress (L.prim_name, L.prim_range, L.predir, L.postdir, L.addr_suffix, '', L.sec_range,
                                                      L.p_city_name, L.st, L.z5, '', '', '', L.addr, '', '');
    Self.SearchBy.DOB := iesp.ECL2ESP.toDate ((integer) L.dob);
    Self.SearchBy := []; //SSNLast4, SSNFirst5, Phone10, Radius

    Self.RemoteLocations := [];
    Self.ServiceLocations := [];
  end;  

  // Note, this is an ESDL input having un-translated values; translation is a responsibility of a PickList service
  %rec_picklist% %SetESDLBarchRequest% (%rec_in% L) := transform
    Self.acctno := L.acctno;
    Self.request := dataset ([%FormatBatchRequest% (L)]);
    Self := L;
  end;
  %batch_request% := project (inf, %SetESDLBarchRequest% (Left));

  // execute SOAP call for each row: this is a probable bottle neck, but so far we don't have anything better available    
  #uniquename (MakePicklistCall);
  %rec_in% %MakePicklistCall% (%rec_picklist% L) := transform
    // the SOAP call
    search_results := doxie.get_remote_picklist (L.request, %gateway_cfg%);

    // picklist throws doxie-style errors; transform into "standard" form
    err_code := BatchShare.Functions.GetPicklistErrors (search_results[1]);

    // take results only if unambiguous DID exists:      
    Self.did := if (search_results[1].SubjectTotalCount = 1, (integer) search_results.Records[1].UniqueId, 0);
    Self.err_search := err_code;
    Self := L; 
  end;
  outf := project (%batch_request%, %MakePicklistCall% (Left));
ENDMACRO;
