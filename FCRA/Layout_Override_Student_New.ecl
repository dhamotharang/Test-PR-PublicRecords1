import American_student_list;

export Layout_Override_Student_New := RECORD
	// American_student_list.layout_american_student_base_v2;
	American_student_list.layout_american_student_base_v2 - [global_sid, record_sid];   //CCPA-7 exclude CCPA fields
	string20 flag_file_id;
end;
