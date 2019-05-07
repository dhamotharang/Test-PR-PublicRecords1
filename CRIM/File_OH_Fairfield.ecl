IMPORT crim;
import  data_services;
EXPORT File_OH_Fairfield := MODULE

	EXPORT	raw					:=	dataset(data_services.foreign_prod+'thor_data400::in::crim_court::oh_Fairfield',crim.layout_OH_fairfield.raw_in, CSV);

	crim.layout_OH_fairfield.disposition	tDisposition(raw	pInput)	:=	TRANSFORM
		SELF.case_number		:=	pInput.line[1..20];
		SELF.rec_type				:=	pInput.line[21];
		SELF.file_date			:=	pInput.line[22..29];
		SELF.case_term_desc	:=	pInput.line[30..54];
		SELF.case_term_date	:=	pInput.line[55..62];
	END;
	EXPORT	DISPOSITION :=	PROJECT(raw(line[21]='1'),tDisposition(LEFT));

	crim.layout_OH_fairfield.person	tPerson(raw	pInput)	:=	TRANSFORM
		SELF.case_number		:=	pInput.line[1..20];
		SELF.rec_type				:=	pInput.line[21];
		SELF.lname		:=	pInput.line[22..46];
		SELF.fname		:=	pInput.line[47..71];
		SELF.mname		:=	pInput.line[72..96];
		SELF.suffix		:=	pInput.line[97..121];
		SELF.dob		:=	pInput.line[122..129];
		SELF.alias_cnt		:=	pInput.line[130..132];
		SELF.charge_cnt		:=	pInput.line[133..135];
	END;
	EXPORT	PERSON			:=	PROJECT(raw(line[21]='2'),tPerson(LEFT));

	crim.layout_OH_fairfield.charge	tCharge(raw	pInput)	:=	TRANSFORM
		SELF.case_number		:=	pInput.line[1..20];
		SELF.rec_type				:=	pInput.line[21];
		SELF.charge_code		:=	pInput.line[22..31];
		SELF.charge_desc		:=	pInput.line[32..81];
		SELF.charge_disp_desc		:=	pInput.line[82..106];
		SELF.charge_disp_date		:=	pInput.line[107..114];
		SELF.sent_days_jail		:=	pInput.line[115..118];
		SELF.sent_days_jail_susp		:=	pInput.line[119..122];
		SELF.sent_days_jail_prob		:=	pInput.line[123..126];
		SELF.charge_degree_off		:=	pInput.line[127..176];
	END;
	EXPORT	CHARGE			:=	PROJECT(raw(line[21]='3'),tCharge(LEFT));

	crim.layout_OH_fairfield.Alias	tAlias(raw	pInput)	:=	TRANSFORM
		SELF.case_number		:=	pInput.line[1..20];
		SELF.rec_type				:=	pInput.line[21];
		SELF.lname		:=	pInput.line[22..46];
		SELF.fname		:=	pInput.line[47..71];
		SELF.mname		:=	pInput.line[72..96];
		SELF.suffix		:=	pInput.line[97..121];
	END;
	EXPORT	ALIAS				:=	PROJECT(raw(line[21]='4'),tAlias(LEFT));
	
END;