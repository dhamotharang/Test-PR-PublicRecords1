IMPORT ut;

american_student_in := RECORD
	STRING50	COLLEGE_NAME;
	STRING50	LN_COLLEGE_NAME;	
END;

Input
	:=
		DATASET(
			[{'ELLIS HOSPITAL SCH OF NURSING', 'ELLIS HOSPITAL SCHOOL OF NURSING'}
			,{'PALAU COMMUNITY COLLEGE', 'PALAU COMMUNITY COLLEGE'}
			,{'INDIANA BUSINESS COLLEGE', 'INDIANA BUSINESS COLLEGE'}
			,{'CHARTER OAK STATE COLLEGE', 'CHARTER OAK STATE COLLEGE'}
			,{'KANSAS ST UNI-SALINA,COL OF TECH & AVI', 'KANSAS STATE UNIVERSITY'}
			,{'EVANGELICAL THEOLOGICAL SEMINARY', 'EVANGELICAL THEOLOGICAL SEMINARY'}
			,{'JOHN M PATTERSON STATE TECH C', 'JOHN M PATTERSON STATE TECHNICAL COLLEGE'}
			]
			,american_student_in);


American_Student_List.layout_american_student_ln_college_lkp tReLayout(american_student_in pInput) := TRANSFORM
	self.DATE_ADDED				:=	thorlib.wuid()[2..9];
	self									:=	pInput;
END;

new_lkp_file := American_Student_List.file_american_student_ln_college_lkp + PROJECT(Input, tReLayout(LEFT));

ut.MAC_SF_BuildProcess(new_lkp_file, American_student_list.thor_cluster + 'lookup::american_student_list::college_name', update_lkp);

update_lkp;