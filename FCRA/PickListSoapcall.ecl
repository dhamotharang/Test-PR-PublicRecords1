import iesp, Gateway, doxie, AutoStandardI;

export PickListSoapcall := MODULE

  // TODO: decide whether to fail here or return an error in the output structure
  shared make_soapcall (dataset (Gateway.layouts.config) gateways, 
                        dataset (iesp.person_picklist.t_PersonPickListRequest) request,
                        boolean unique_only, 
                        boolean call_gateway
  ) := function

    res := if (call_gateway, doxie.get_remote_picklist (request , gateways));

    // Errors handling: errors can be stored as 'Exceptions' (fatal) or 'Messages' (non-fatal).
    //   See Standard/errors and error hadlers in BatchShare/Functions/GetPicklistErrors.
    
	  exc := res[1]._Header.Exceptions; // exceptions
		msg := res[1].Messages; // messages
    cnt := res[1].SubjectTotalCount;  // if I won't be able to rely on the subject's counts, actual records can be counted

    // in order of importance (those are legacy -- not systemized -- error codes):
    err := map (exists (exc (code = 305)) => 305,
								exists (msg (code = '305')) => 305,
                unique_only and (cnt >1) => 203,
                unique_only and (cnt =0) => 10,
                0);
    if (call_gateway and err != 0, FAIL (err,  'picklist: ' + doxie.ErrorCodes(err)));
		
    return if (call_gateway and err = 0, res);
  end;


  export esdl (dataset (Gateway.layouts.config) gateways, 
               dataset (iesp.person_picklist.t_PersonPickListRequest) request,
               boolean unique_only = true, // fail if too many or none DIDs found
               boolean call_gateway = true // a workaround to prevent inadvertent gateway
  ) := function

    return make_soapcall (gateways, request, unique_only, call_gateway);
  end;


  // this call should be generally avoided: only for non-esdl services
  export non_esdl (dataset (Gateway.layouts.config) gateways,
                   boolean unique_only = true, // fail if too many or none DIDs found
                   boolean call_gateway = true // a workaround to prevent inadvertent gateway
  ) := function

    gm := AutoStandardI.GlobalModule ();

    // Note, this is an ESDL input having un-translated values; translation is a responsibility of a PickList service
    iesp.person_picklist.t_PersonPickListRequest SetLegacyRequest () := transform
      // user
      Self.User.GLBPurpose := (string) gm.GLBPurpose;
      Self.User.DLPurpose := (string) gm.DPPAPurpose;
      Self.User.IndustryClass := gm.industryclass;
      Self.User.SSNMask := gm.ssnmask;
      Self.User.DOBMask := gm.dobmask;
      Self.User.DLMask := gm.dlmask;
      Self.User.DataRestrictionMask := gm.DataRestrictionMask;
      Self.User.DataPermissionMask := gm.DataPermissionMask;
      Self.User.ApplicationType := gm.ApplicationType;
      Self.User := []; // EndUser.*, TestDataEnabled, MaxWaitSeconds, etc.

      // options
      Self.Options.StrictMatch := gm.StrictMatch or gm.exactonly; //?
      Self.Options.MaxResults := gm.maxresults;
      Self.Options.ReturnCount := gm.maxresultsthistime;
      Self.Options.StartingRecord := gm.skiprecords;
      Self.Options.UsePhonetics := gm.phoneticmatch;
      Self.Options.CheckNameVariants := gm.checknamevariants;
      Self.Options.UseNicknames := gm.allownicknames;
      //TODO:  Self.Options.UsePartialSSNMatch := gm.
      Self.Options.ReturnUniqueIdsOnly := gm.didonly;
      Self.Options := []; //Blind, Encrypt, ReturnTokens, 

      // search by
      Self.SearchBy.SSN := gm.ssn;  
      Self.SearchBy.SSNLast4 := '';  
      Self.SearchBy.SSNFirst5 := '';  
      Self.SearchBy.Phone10 := gm.phone;  
      Self.SearchBy.UniqueId := gm.did;  
      Self.SearchBy.Name := iesp.ECL2ESP.SetName (gm.firstname, gm.middlename, gm.lastname, gm.namesuffix, '', gm.unparsedfullname);
      Self.SearchBy.Address := iesp.ECL2ESP.SetAddress (gm.prim_name, gm.prim_range, gm.predir, gm.postdir, gm.suffix, '', gm.sec_range,
                                                        gm.city, gm.state, gm.zip, '', '', '', gm.addr, '', gm.statecityzip);
      Self.SearchBy.Radius := gm.zipradius;  
      Self.SearchBy.DOB := iesp.ECL2ESP.toDate (gm.dob);

      Self.RemoteLocations := [];
      Self.ServiceLocations := [];
    end;
    //TODO: create request from the flat SOAP input
    request := dataset ([SetLegacyRequest ()]);
    return make_soapcall (gateways, request, unique_only, call_gateway);
  end;
  
END;
