// =====================================================================
// ROXIE QUERY
// -----------
// For the complete list of input parameters please check published WU.
// Look at the history of this attribute for the old SOAP info.
// =====================================================================
/*--INFO-- This service searches the LiensV2 files.
           Please Note: The *Filing Jurisdiction*
					 field is not used in the standalone liens searches which originate from accurint.com
				   but is used in the find a person/business statewide searches from lexis.com.
					 Therefore the field : *Filing Jurisdiction* below should be left blank
					 when running a liens only roxie search using the fields below */
export LiensSearchService() := macro
  #CONSTANT ('SearchLibraryVersion', AutoheaderV2.Constants.LibVersion.SALT);
  #CONSTANT ('SaltLeadThreshold', 15); // lead threshold set here according to Linking Team's recommendation.
  #constant('getBdidsbyExecutive',FALSE);
  #constant('SearchGoodSSNOnly',true);
  #constant('SearchIgnoresAddressOnly',true);
  #stored('ScoreThreshold',10);
  #stored('PenaltThreshold',10);
  #constant('DisplayMatchedParty',true);

  boolean evictions_only := false : stored('EvictionsOnly');
  boolean include_criminalIndicators := false : stored('IncludeCriminalIndicators');

  doxie.MAC_Header_Field_Declare();
  gm := AutoStandardI.GlobalModule();

  liens_params := module(project(gm, LiensV2_Services.IParam.search_params, opt))
    export unsigned2 pt := 10       : stored('PenaltThreshold');
    export string CertificateNumber := '' : stored('CertificateNumber');
    export unsigned8 maxresults := maxresults_val;
    export string1 partyType := party_type;
    export string50 liencasenumber := liencasenumber_value;
    export string50 filingnumber := filingnumber_value;
    export string20 filingjurisdiction := filingjurisdiction_value;
    export string25 irsserialnumber := irsserialnumber_value;
    export string6 ssn_mask := ssn_mask_value;
    export string32 ApplicationType := application_type_value;
    export string101 rmsid := rmsid_value;
    export string50 tmsid := tmsid_value;
    export boolean includeCriminalIndicators := include_criminalIndicators;
  END;

  recs := LiensV2_Services.LiensSearchService_records(liens_params).records;


  orec := record
     RECORDOF(recs);
     Text_Search.Layout_ExternalKey;
  END;
  orec addExt ( recs l) := transform
    self := l;
    self.ExternalKey := l.TMSID;
  end;
  recs2 := project(recs, addext(left));

  eviction_recs := recs2(eviction = 'Y');
  out_recs := if(evictions_only, eviction_recs, recs2);

  out_recs2 := if(party_type = '', out_recs, out_recs(matched_party.party_type = party_type));

  doxie.MAC_Marshall_Results(out_recs2, recs_marshalled);

  OUTPUT(recs_marshalled, NAMED('Results'));

endmacro;
