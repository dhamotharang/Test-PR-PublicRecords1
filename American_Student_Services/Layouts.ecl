import American_student_list, doxie;

EXPORT Layouts := MODULE
	
	EXPORT payload := RECORD		
		American_student_list.layout_american_student_autokey;
	END;
	
	EXPORT Id := RECORD
		unsigned6 id;
		boolean isdid; 
		boolean isbdid;
		boolean isfake;
	END;

	EXPORT deepDids := record
		doxie.layout_references;
		boolean isdeepdive := false;
	end;
	
	EXPORT finalRecs := RECORD
		American_student_list.layout_american_student_base_v2.did;
		boolean isDeepDive := false;
		unsigned2 record_penalty := -1;
		boolean IsCurrent := false;
		American_student_list.layout_american_student_base_v2.date_vendor_first_reported;
		American_student_list.layout_american_student_base_v2.date_vendor_last_reported;
		American_student_list.layout_american_student_base_v2.LN_college_name;
		American_student_list.layout_american_student_base_v2.college_name;
		string3					COLLEGE_MAJOR;
		American_student_list.layout_american_student_base_v2.college_code_exploded;
		American_student_list.layout_american_student_base_v2.college_type_exploded;
		American_student_list.layout_american_student_base_v2.telephone;
		American_student_list.layout_american_student_base_v2.fname;
		American_student_list.layout_american_student_base_v2.mname;
		American_student_list.layout_american_student_base_v2.lname;
		American_student_list.layout_american_student_base_v2.name_suffix;
		American_student_list.layout_american_student_base_v2.title;
		American_student_list.layout_american_student_base_v2.prim_name;
		American_student_list.layout_american_student_base_v2.prim_range;
		American_student_list.layout_american_student_base_v2.predir;
		American_student_list.layout_american_student_base_v2.postdir;
		American_student_list.layout_american_student_base_v2.addr_suffix;
		American_student_list.layout_american_student_base_v2.unit_desig;
		American_student_list.layout_american_student_base_v2.sec_range;
		American_student_list.layout_american_student_base_v2.p_city_name;
		American_student_list.layout_american_student_base_v2.state;
		American_student_list.layout_american_student_base_v2.zip;
		American_student_list.layout_american_student_base_v2.zip4;
		American_student_list.layout_american_student_base_v2.class;
		American_student_list.layout_american_student_base_v2.ssn;
		American_student_list.layout_american_student_base_v2.DOB_FORMATTED;
		string2 ClassRank;
		string30 ClassRankExploded;
		string15 SchoolPeriod ;
	  string1 SchoolSizeCode ;
		string20 SchoolSizeExploded;
	  string1 TuitionCode ;
		string20 TuitionExploded;
		string50 college_major_exploded := '';
		string1 public_private_code := '';
		STRING2 src :='';
	END;
	
	EXPORT college_data := record
		unsigned6 did;
		STRING1	Attended_High_school_indicator;
		STRING2	Years_since_HS_Graduation;
		STRING1	College_indicator1;
		STRING1	College_public_private_flag1;
		STRING1	College_2yr_4yr__grad_indicator1;
		STRING2	College_Education_program_tier1;
		STRING1	College_indicator2;
		STRING1	College_public_private_flag2;
		STRING1	College_2yr_4yr__grad_indicator2;
		STRING2	College_Education_program_tier2;
	END;
	
	EXPORT full_output := RECORD
		finalRecs;
		college_data - DID;
	END;

END;