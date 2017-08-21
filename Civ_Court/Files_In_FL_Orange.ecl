IMPORT Civ_Court, ut, Data_Services;

EXPORT Files_In_FL_Orange := MODULE

	EXPORT raw := dataset(Data_Services.foreign_prod +'thor_data400::in::civil::fl_orange', Civ_Court.Layouts_In_FL_Orange.Raw_In, csv(heading(0), separator(':')));

	EXPORT new_raw := dataset(Data_Services.foreign_prod +'thor_data400::in::civil::fl_orange_weekly', Civ_Court.Layouts_In_FL_Orange.Raw_Weekly, csv(heading(0), separator('|')));
	
	//Rec_type = 1 Layout
	Civ_Court.Layouts_In_FL_Orange.Raw_In_1 xfrmRec1(raw pInput)	:= TRANSFORM
		self.name							:= REGEXREPLACE('NULL(.*)',ut.CleanSpacesAndUpper(pInput.field1),'');
		self.case_type				:= REGEXREPLACE('NULL(.*)',ut.CleanSpacesAndUpper(pInput.field2),'');
		self.party_number			:= REGEXREPLACE('NULL(.*)',ut.CleanSpacesAndUpper(pInput.field3),'');
		self.party_type				:= REGEXREPLACE('NULL(.*)',ut.CleanSpacesAndUpper(pInput.field4),'');
		self.count_no					:= REGEXREPLACE('NULL(.*)',ut.CleanSpacesAndUpper(pInput.field5),'');
		self.judge_name				:= REGEXREPLACE('NULL(.*)',ut.CleanSpacesAndUpper(pInput.field6),'');
		self.filing_date			:= REGEXREPLACE('NULL(.*)',ut.CleanSpacesAndUpper(pInput.field7),'');
		self.case_type_desc		:= REGEXREPLACE('NULL(.*)',ut.CleanSpacesAndUpper(pInput.field8),'');
		self.case_status_desc	:= REGEXREPLACE('NULL(.*)',ut.CleanSpacesAndUpper(pInput.field9),'');
		self.case_status_date	:= REGEXREPLACE('NULL(.*)',ut.CleanSpacesAndUpper(pInput.field10),'');
		self.disposition_desc	:= REGEXREPLACE('NULL(.*)',ut.CleanSpacesAndUpper(pInput.field11),'');
		self.disposition_date	:= REGEXREPLACE('NULL(.*)',ut.CleanSpacesAndUpper(pInput.field12),'');
		self	:= pInput;
	END;
	
	EXPORT Raw_RecType_1	:= project(raw(trim(rec_type,all) = '1'),xfrmRec1(left));

	//Rec_type = 3 Layout -- Rec_type = 2 is not used
	Civ_Court.Layouts_In_FL_Orange.Raw_In_3 xfrmRec3(raw pInput)	:= TRANSFORM
		self.event_date					:= REGEXREPLACE('NULL(.*)',ut.CleanSpacesAndUpper(pInput.field1),'');
		self.event_code					:= REGEXREPLACE('NULL(.*)',ut.CleanSpacesAndUpper(pInput.field2),'');
		self.event_code_desc		:= REGEXREPLACE('NULL(.*)',ut.CleanSpacesAndUpper(pInput.field3),'');
		self.event_action				:= REGEXREPLACE('NULL(.*)',ut.CleanSpacesAndUpper(pInput.field4),'');
		self.event_action_date	:= REGEXREPLACE('NULL(.*)',ut.CleanSpacesAndUpper(pInput.field5),'');
		self.event_duration			:= REGEXREPLACE('NULL(.*)',ut.CleanSpacesAndUpper(pInput.field6),'');
		self := pInput;
	END;

	EXPORT Raw_RecType_3	:= project(raw(trim(rec_type,all) = '3'),xfrmRec3(left));
											
END;