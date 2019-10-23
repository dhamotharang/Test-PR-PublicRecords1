import Scrubs_EBR, EBR;
	
	EXPORT Base_5610_Layout_EBR := RECORD
   
	 EBR.Layout_5610_Demographic_Data_Base	 -clean_officer_name;
	 string5  clean_officer_name_title;
	 string20 clean_officer_name_fname;
	 string20 clean_officer_name_mname;
	 string20 clean_officer_name_lname;
	 string5  clean_officer_name_name_suffix;
	 string3  clean_officer_name_name_score;
	 
 END;