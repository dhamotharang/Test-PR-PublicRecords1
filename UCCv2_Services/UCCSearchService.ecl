// =====================================================================
// ROXIE QUERY
// -----------
// For the complete list of input parameters please check published WU.
// Look at the history of this attribute for the old SOAP info.
// =====================================================================
EXPORT UCCSearchService() := MACRO
IMPORT Text_Search,doxie;

  #CONSTANT('SearchLibraryVersion', AutoheaderV2.Constants.LibVersion.SALT);
  #CONSTANT('getBdidsbyExecutive',FALSE);
  #CONSTANT('SearchGoodSSNOnly',TRUE);
  #CONSTANT('SearchIgnoresAddressOnly',TRUE);
  #STORED('ScoreThreshold',10);
  #STORED('PenaltThreshold',10);
  #CONSTANT('DisplayMatchedParty',TRUE);

  // output(UCCv2_Services.UCCSearchService_records, named('Results'));

  bid_params := MODULE(PROJECT(AutoStandardI.GlobalModule(), TopBusiness_Services.iParam.BIDParams,opt))
  END;

  in_bids := TopBusiness_Services.Functions.create_business_ids_dataset(bid_params);

  recs := UCCv2_Services.UCCSearchService_records(in_bids,
                                                  bid_params.BusinessIDFetchLevel).records;

  // create External Key field
  orec := RECORD
    RECORDOF(recs);
    Text_Search.Layout_ExternalKey;
  END;
  orec addExt ( recs l) := TRANSFORM
    SELF := l;
    SELF.ExternalKey := l.TMSID;
  END;
  recs2 := PROJECT(recs, addext(LEFT));

  doxie.MAC_Header_Field_Declare()
  doxie.MAC_Marshall_Results(recs2, recs_marshalled);

  OUTPUT(recs_marshalled, NAMED('Results'));

ENDMACRO;
