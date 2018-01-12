//This function map OKC Student List base file to ASL layout
IMPORT American_Student_list, ut;

EXPORT Map_To_ASL_Base := FUNCTION

	okc_student_list_base := OKC_Student_List.File_OKC_Base(telephone NOT IN ['0000000000','1111111111','9999999999']);
	
	American_Student_list.layout_american_student_base_v2 txOkcToAsl(okc_student_list_base L) := TRANSFORM
		SELF.first_name := L.FirstName;
		SELF.last_name := L.LastName;
		SELF.zip_4 := L.z4;
		SELF.birth_date := L.dob_formatted[3..];
		SELF.HISTORICAL_FLAG := IF(L.did=0,'I', L.HISTORICAL_FLAG);
		SELF := L;
		SELF := [];
	END;
	
	okc_base_asl := PROJECT(okc_student_list_base, txOkcToAsl(LEFT));

	return okc_base_asl;
		
END;	
