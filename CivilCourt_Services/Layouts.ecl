IMPORT civil_court, civilCourt_services;
EXPORT Layouts := MODULE;
  EXPORT caseIDLayout := RECORD
    STRING60 case_key;
  END;
  EXPORT caseActivityLayoutPlus := RECORD
    RECORDOF (civil_court.Layout_Roxie_Case_Activity);
    BOOLEAN isDeepDive := FALSE;
    UNSIGNED2 penalt := 0;
  END;
  EXPORT MatterLayoutPlus := RECORD
  RECORDOF (civil_court.Layout_Roxie_matter);
    BOOLEAN isDeepDive := FALSE;
    UNSIGNED2 penalt := 0;
  END;
  EXPORT PartyLayoutPlus := RECORD
    RECORDOF(civil_court.Layout_Roxie_Party);
    BOOLEAN isDeepDive := FALSE;
    UNSIGNED2 penalt := 0;
    STRING60 countyname := '';
  END;
  EXPORT Layout_roxie_partySlim := RECORD // reducing this layouts footprint by removing unneeded fields
    STRING8 dt_first_reported;
    STRING8 dt_last_reported;
    Civil_Court.Layout_In_Party - [
      e1_pname1_score, e1_pname2_score, e1_pname3_score, e1_pname4_score, e1_pname5_score,
      e2_pname1_score, e2_pname2_score, e2_pname3_score, e2_pname4_score, e2_pname5_score,
      v1_pname1_score, v1_pname2_score, v1_pname3_score, v1_pname4_score, v1_pname5_score, 
      v2_pname1_score, v2_pname2_score, v2_pname3_score, v2_pname4_score, v2_pname5_score, 
      geo_lat1, geo_long1, geo_lat2, geo_long2, ace_fips_county2
    ];
  END;
  EXPORT PartyLayoutPlusSlim := RECORD
    Layout_Roxie_PartySlim;
    BOOLEAN isDeepDive := FALSE;
    UNSIGNED2 penalt := 0;
    STRING60 countyname := '';
  END;
END;
