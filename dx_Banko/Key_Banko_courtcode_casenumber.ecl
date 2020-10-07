IMPORT $, Data_Services;

rec := $.Layouts.i_Layout_Key_Banko_CourtCode_CaseNumber;

Keyfields := record
rec.court_code;
rec.casekey;
rec.CaseID;
end;

EXPORT Key_Banko_courtcode_casenumber (UNSIGNED1 data_env = Data_Services.data_env.iNonFCRA) := 
                                       INDEX(Keyfields, rec - Keyfields, $.names(data_env).i_caseNum);