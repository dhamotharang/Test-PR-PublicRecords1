IMPORT $, Data_Services;

// ---------------------------------------------------------------
// For delta rollup logic (dx_common.mac_incremental_rollup) use:
//  $.Key_Banko_Delta_rid
// ---------------------------------------------------------------

rec := $.Layouts.i_Layout_Key_Banko_CourtCode_CaseNumber;

Keyfields := RECORD
rec.court_code;
rec.casekey;
rec.CaseID;
END;

EXPORT Key_Banko_courtcode_casenumber (UNSIGNED1 data_env = Data_Services.data_env.iNonFCRA) := 
                                       INDEX(Keyfields, rec - Keyfields, $.names(data_env).i_caseNum);