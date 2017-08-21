import American_student_list;

export Layout_Override_Student_New := RECORD
	American_student_list.layout_american_student_base_v2 - [CollegeID,CollegeUpdate];		//DF-19691
	string20 flag_file_id;
end;