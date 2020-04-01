IMPORT ut, std, prte2;

EXPORT fSpray := FUNCTION
		
	Return Parallel(
  	prte2.SprayFiles.Spray_Raw_Data('american_student_list','student_list','american_student_list'),
	  prte2.SprayFiles.Spray_Raw_Data('americanIns_student_list','student_list_Ins','american_student_list')
	 );
	 
	 END;
