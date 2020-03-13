IMPORT Codes, PublicRecords_KEL;
EXPORT Fn_SICCodeInterpreter(INTEGER Sic4CodeInput) := FUNCTION
OutPutCode := Codes.Key_SIC4(KEYED(sic4_code = (STRING)Sic4CodeInput))[1].sic4_description;
RETURN if(OutPutCode != '', OutPutCode , PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);
END;
