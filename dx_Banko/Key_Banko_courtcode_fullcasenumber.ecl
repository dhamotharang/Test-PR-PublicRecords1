IMPORT $, Data_Services;

rec := $.Layouts.i_Layout_Key_Banko_CourtCode_FullCaseNumber;

Keyfields := RECORD
rec.court_code;
rec.BKCaseNumber;
rec.CaseID;
END;

EXPORT Key_Banko_courtcode_fullcasenumber (UNSIGNED1 data_env = Data_Services.data_env.iNonFCRA) :=
                                       INDEX(Keyfields, rec - Keyfields, $.names(data_env).i_FullcaseNum);
