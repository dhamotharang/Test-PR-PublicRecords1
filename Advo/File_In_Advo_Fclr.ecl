rec := record
     string   _key_vac_uid ;  
	 string     VAC_BEGDT;
     string     VAC_ENDDT;
     string     MONTHS_VAC_CURR;
     string     MONTHS_VAC_MAX;                
     string     VAC_COUNT;
	 string		ZIP_5							;
     string		Route_Num						;
     string		ZIP_4   						;
     string		WALK_Sequence					;
     string 	    STREET_NUM						;
     string		STREET_PRE_DIRectional			;
     string	    STREET_NAME						;
     string		STREET_POST_DIRectional			;
     string		STREET_SUFFIX					;
     string		Secondary_Unit_Designator		;
     string		Secondary_Unit_Number			;
     string		Address_Vacancy_Indicator		;
     string		Throw_Back_Indicator			;
     string		Seasonal_Delivery_Indicator		;
     string		Seasonal_Start_Suppression_Date	;
     string		Seasonal_End_Suppression_Date	;
     string		DND_Indicator					;
     string		College_Indicator				;
     string		College_Start_Suppression_Date	;
     string		College_End_Suppression_Date	;
     string  	Address_Style_Flag				;
     string		Simplify_Address_Count			;
     string		Drop_Indicator					;
     string		Residential_or_Business_Ind		;
     string		DPBC_Digit						;
     string		DPBC_Check_Digit				;
     string		Update_Date						;
     string		File_Release_Date				;
     string		Override_file_release_date		;
     string		County_Num						;
     string		County_Name					    ;
     string		City_Name						;
     string		State_Code						;
     string		State_Num						;
     string		Congressional_District_Number	;
     string		OWGM_Indicator					;
     string		Record_Type_Code				;
     string 		ADVO_Key						;
     string		Address_Type					;
     string		Mixed_Address_Usage				;
	 string		Filler							;
	 
  end;


File_In_Advo_final := dataset('~thor_data400::in::cds_hist',rec,csv(heading(1), separator(','), terminator(['\n','\r\n']), quote('')));

export File_In_Advo_fclr := distribute(File_In_Advo_final,HASH32(_key_vac_uid));