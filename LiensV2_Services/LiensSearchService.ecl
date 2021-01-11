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
EXPORT LiensSearchService() := MACRO
  #CONSTANT ('SearchLibraryVersion', AutoheaderV2.Constants.LibVersion.SALT);
  #CONSTANT ('SaltLeadThreshold', 15); // lead threshold SET here according to Linking Team's recommendation.
  #CONSTANT('getBdidsbyExecutive',FALSE);
  #CONSTANT('SearchGoodSSNOnly',TRUE);
  #CONSTANT('SearchIgnoresAddressOnly',TRUE);
  #STORED('ScoreThreshold',10);
  #STORED('PenaltThreshold',10);
  #CONSTANT('DisplayMatchedParty',TRUE);

  BOOLEAN evictions_only := FALSE : STORED('EvictionsOnly');
  BOOLEAN include_criminalIndicators := FALSE : STORED('IncludeCriminalIndicators');

  doxie.MAC_Header_Field_Declare();
  gm := AutoStandardI.GlobalModule();

  liens_params := MODULE(PROJECT(gm, LiensV2_Services.IParam.search_params, OPT))
    EXPORT UNSIGNED2 pt := 10 : STORED('PenaltThreshold');
    EXPORT STRING CertificateNumber := '' : STORED('CertificateNumber');
    EXPORT UNSIGNED8 maxresults := maxresults_val;
    EXPORT STRING1 partyType := party_type;
    EXPORT STRING50 liencasenumber := liencasenumber_value;
    EXPORT STRING50 filingnumber := filingnumber_value;
    EXPORT STRING20 filingjurisdiction := filingjurisdiction_value;
    EXPORT STRING25 irsserialnumber := irsserialnumber_value;
    EXPORT STRING6 ssn_mask := ssn_mask_value;
    EXPORT STRING32 ApplicationType := application_type_value;
    EXPORT STRING101 rmsid := rmsid_value;
    EXPORT STRING50 tmsid := tmsid_value;
    EXPORT BOOLEAN includeCriminalIndicators := include_criminalIndicators;
  END;

  recs := LiensV2_Services.LiensSearchService_records(liens_params).records;


  orec := RECORD
     RECORDOF(recs);
     Text_Search.Layout_ExternalKey;
  END;
  orec addExt ( recs l) := TRANSFORM
    SELF := l;
    SELF.ExternalKey := l.TMSID;
  END;
  recs2 := PROJECT(recs, addext(LEFT));

  eviction_recs := recs2(eviction = 'Y');
  out_recs := IF(evictions_only, eviction_recs, recs2);

  out_recs2 := IF(party_type = '', out_recs, out_recs(matched_party.party_type = party_type));

  doxie.MAC_Marshall_Results(out_recs2, recs_marshalled);

  OUTPUT(recs_marshalled, NAMED('Results'));

ENDMACRO;
