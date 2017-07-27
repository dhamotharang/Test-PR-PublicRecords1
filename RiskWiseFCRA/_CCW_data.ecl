IMPORT doxie, CCW_Services, FCRA,FFD;

// vendor: eMerges
// CCW records are linked by "rid" which is nothing more than a sequence number (not persistent).
// ovewrites are ensured by persistent_unique_id in payload files


boolean IsFCRA := true;

// returns UCC party and main data by DID
export _CCW_data (dataset (doxie.layout_references) in_dids, 
                  dataset (fcra.Layout_override_flag) flag_file) := MODULE

  // implementation: a simplified version of CCW_services.SearchService_Records.val

  // get internal IDs (overrides are not necessary
  ids := CCW_Services.raw.byDIDs (project (in_dids, CCW_services.Layouts.search_did), isFCRA);

  // get raw records; overrides are applied inside 
  recs := CCW_Services.raw.byRids (ids, isFCRA, flag_file);

  EXPORT ccw := project(recs, {ccw_services.Layouts.rawrec - FFD.Layouts.CommonRawRecordElements});;

END;
