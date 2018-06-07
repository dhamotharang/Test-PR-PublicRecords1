IMPORT NAC_V2,iesp;

EXPORT GetCannedRecords(iesp.nac2_search.t_NAC2SearchRequest in_req) := FUNCTION 


    hash_value := hash32(in_req.Options.IncludeEligibilityHistory,
						  in_req.Options.IncludeInterstateAllPrograms,
						  in_req.SearchBy.Identity.LastName,
						  in_req.SearchBy.Identity.FirstName,
						  in_req.SearchBy.Identity.MiddleName,
						  in_req.SearchBy.Identity.SuffixName,
						  in_req.SearchBy.Identity.FullName,
						  in_req.SearchBy.Identity.Address1.StreetAddress1,
						  in_req.SearchBy.Identity.Address1.StreetAddress2,
						  in_req.SearchBy.Identity.Address1.City,
						  in_req.SearchBy.Identity.Address1.State,
						  in_req.SearchBy.Identity.Address1.Zip,
						  in_req.SearchBy.Identity.Address2.StreetAddress1,
						  in_req.SearchBy.Identity.Address2.StreetAddress2,
						  in_req.SearchBy.Identity.Address2.City,
						  in_req.SearchBy.Identity.Address2.State,
						  in_req.SearchBy.Identity.Address2.Zip,
						  in_req.SearchBy.Identity.SSN,
						  in_req.SearchBy.Identity.DOB,
						  in_req.SearchBy.Identity.ProgramCode,
						  in_req.SearchBy.Identity.EligibilityRangeType,
						  in_req.SearchBy.Identity.EligibilityStart,
						  in_req.SearchBy.Identity.EligibilityEnd,
						  in_req.SearchBy.Identity.CaseIdentifier,
						  in_req.SearchBy.Identity.ClientIdentifier
						  );

    in_testdatatablename := in_req.user.testdatatablename;

    key_testdata:= NAC_V2.Key_test_data;
    
    canned_recs := CHOOSEN(Key_testdata((keyed(requesthash = hash_value ) and keyed(testdatatablename = in_testdatatablename )
												)),NAC_V2_Services.Constants.MAX_RECORDS_PER_ACCTNO);
                        

    default_recs := key_testdata(keyed(requesthash = 0) );

    recs := if(~exists(canned_recs),default_recs,canned_recs);

    out_recs := project(recs,iesp.nac2_search.t_NAC2SearchResponse);
				
    return out_recs;

END;