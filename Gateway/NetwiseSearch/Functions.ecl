IMPORT iesp;

EXPORT Functions := MODULE

  //Check multiple individual fields and child datasets on <Results> record for a non-blank or non-empty condition.
  fn_CheckResultsRec(iesp.net_wise_share.t_NetWiseResult L) := FUNCTION

    BOOLEAN HasData := L.LinkedInProfileUrl       != '' or
                       L.LinkedInProfileImageUrl  != '' or
                       Exists(L.PersonalContactInfo.EmailRecords)   or
                       Exists(L.PersonalContactInfo.PhoneRecords)   or
                       Exists(L.PersonalContactInfo.AddressRecords) or
                       Exists(L.WorkRecords)      or
                       Exists(L.EducationRecords) or
                       L.Bio.Gender != '' or
                       L.Bio.Age    != '' or
                       Exists(L.NameRecords)  or
                       L.Name.Text  != '' or
                       Exists(L.ImageRecords) or
                       Exists(L.PlaceRecords);

    RETURN HasData;

  END;


  // Return a count of the number of query response <Results> records with some non-blank/non-empty data 
  // (besides just the echoed back input email), on them.
  EXPORT fn_CountResultsRecs(DATASET(iesp.net_wise_share.t_NetWiseResult) ds_response_results) := FUNCTION

    // Cannot just check for a completely non-empty 'Results' record because even if input search by email gets
    // no gateway hit or the gateway response data results in a Lexid that is opted out,
    // the input email is still echoed back in the Results.Email field.
    ds_rec_count := IF(fn_CheckResultsRec(ds_response_results[1]), 1, 0) + 
                    IF(fn_CheckResultsRec(ds_response_results[2]), 1, 0) + 
                    IF(fn_CheckResultsRec(ds_response_results[3]), 1, 0) + 
                    IF(fn_CheckResultsRec(ds_response_results[4]), 1, 0) + 
                    IF(fn_CheckResultsRec(ds_response_results[5]), 1, 0);

    RETURN ds_rec_count;

  END;

END;
