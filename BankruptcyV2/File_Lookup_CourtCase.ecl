export File_Lookup_CourtCase 
		:= dataset('~thor_data400::lookup::bankruptcyv2::courtcase'
				    , {string12 court_code_case_number, string1 lf}, flat)(court_code_case_number[1..5]!='AL001');