IMPORT doxie, hunting_fishing_services, FCRA, emerges;

// vendor: eMerges
// Hunting and fishing records are linked by "rid" which is nothing more than a sequence number (not persistent).
// ovewrites are ensured by persistent_unique_id in payload files


boolean IsFCRA := true;

// returns UCC party and main data by DID
export _HuntingFishing_data (dataset (doxie.layout_references) in_dids, 
                             dataset (fcra.Layout_override_flag) flag_file) := MODULE

  // implementation: a simplified version of hunting_fishing_services.SearchService_Records.val

  // get internal IDs (overrides are not necessary
  ids := hunting_fishing_services.raw.byDIDs (project (in_dids, hunting_fishing_services.Layouts.search_did), isFCRA);

  // get raw records; overrides are applied inside 
  recs := hunting_fishing_services.raw.byRids (ids, isFCRA, flag_file);

  EXPORT hunting_fishing := project (recs, emerges.layout_hunters_out);

END;
