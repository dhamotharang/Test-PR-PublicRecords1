import American_Student_list, prte2;

EXPORT Layouts := module

  export incoming := record
     American_Student_List.layout_american_student_base_v2 and not [global_sid, record_sid];
     string10  cust_name;
     string10  bug_num;
     string8   link_dob;
     string9   link_ssn;
  end;
  
  export base  := record
     American_Student_List.layout_american_student_base_v2;
     string10  cust_name;
     string10  bug_num;
     string8   link_dob;
     string9   link_ssn;
  end;

  export ASL_Key_Layout	:=RECORD
			American_student_list.layout_american_student_base and not [HISTORICAL_FLAG,source];
		END;

  export american_student_base_v2  :=  American_student_list.layout_american_student_base_v2;
  export american_student_list_address_matches  := American_student_list.layout_american_student_list_address_matches;
  
  export ASL_Autokey := RECORD
    American_student_list.layout_american_student_base_v2;
    unsigned1 zero := 0;
    string1		blank	:=	'';
    end;

end;