IMPORT Accident_Services,doxie,ut;

UNSIGNED DOL  := Accident_Services.Constants.DOL;
UNSIGNED NAME := Accident_Services.Constants.NAME;
UNSIGNED ADDR := Accident_Services.Constants.ADDR;

StResRptRec := Accident_Services.Layouts.AccidentStateRestrictionReportRecord;
StResInpRec := Accident_Services.Layouts.AccidentInputRequired;

KeyInputReqRec := RECORD
	StResRptRec.ApplicationType;
	StResRptRec.AccidentState;
	StResInpRec.Bitmap;
END;		

export File_In_Input_res := dataset('~thor_data400::in::accident_state_restrictions_input',KeyInputReqRec,thor);
												 