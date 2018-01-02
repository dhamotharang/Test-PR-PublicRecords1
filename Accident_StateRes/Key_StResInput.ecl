IMPORT Accident_Services,doxie,ut, data_services;

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

InputRequired := DATASET([
	{'INS','AZ',DOL},
	{'INS','CA',DOL},
	{'INS','HI',DOL},
	{'INS','IA',DOL},
	{'INS','KY',DOL},
	{'INS','LA',DOL},
	{'INS','MN',DOL},
	{'INS','MO',DOL},
	{'INS','MT',DOL},
	{'INS','NH',DOL},
	{'INS','NV',DOL},
	{'INS','OK',DOL},
	{'INS','PA',DOL},
	{'INS','RI',DOL},
	{'INS','TX',DOL+NAME},
	{'INS','TX',DOL+ADDR},
	{'INS','TX',NAME+ADDR},
	{'INS','UT',DOL},
	{'INS','VA',DOL},
	{'INS','WA',DOL}
],KeyInputReqRec);

EXPORT Key_StResInput := INDEX(InputRequired,
	{ApplicationType},{AccidentState,Bitmap},
	data_services.data_location.prefix() + 'thor_data400::key::accident_state_restrictions::input_' + doxie.Version_SuperKey);
	
