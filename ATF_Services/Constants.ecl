export Constants := MODULE

// export MAX_COUNT_SEARCH_RESPONSE_RECORDS := 2000;
// export MAX_COUNT_REPORT_RESPONSE_RECORDS := 2000;
  export max_recs_on_join := 10000;
  export MAX_RECS_PER_ATF_ID := 10;//max is 4 as of Sept 2012 W20120914-132902
  export max_recs_on_did_join := 10000;
  export MAX_ATF_IDS_PER_DID := 200; //max is 150 as of Sept 2012 W20120914-150317
  export max_recs_on_bdid_join := 10000;
  export MAX_ATF_IDS_PER_BDID := 10000;////max is 7500 as of Sept 2012 W20120914-150735
  export max_recs_on_LicNumber_join := 1000;
  export MAX_ATF_IDS_PER_LNUM := 10;//max is 9 as of Sept 2012 W20120914-151502
  export codesv3_file_name := 'ATF_FIREARMS_EXPLOSIVES';
  export codesv3_field_name := 'IRS_REGION';
  export license1_set := [1, 2, 3, 4];
  // export license2_set := [5, 6, 7, 8];
END;
