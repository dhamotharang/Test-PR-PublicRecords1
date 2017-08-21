export Layouts := module

	export Fein_Extract_out:=record
	
		string9  	TAX_ID_NO 		;         
		string9	 	SRC_DUN_NBR 	;         
		string50  	NAME_BUS  		;    
		string30  	ADR_ADDRESS 	;      
		string20  	ADR_CITY 		;    
		string2  	ADR_STATE  		;         
		string5  	ADR_ZIP    		;      
		string50  	REF_NAME_SRC  	;  
		string8  	DATE_INPUT    	;        
		string12  	DATE_CL_IMP  	;     
		string9  	CASE_DUN_NBR   	;        
		string9  	PAR_DUN_NBR    	;         
		string9  	HDQ_DUN_NBR   	;         
		string10  	PHONE_NO     	;       
		string50  	NAME_EXEC  		;        
		string30  	NAME_COMPANY 	;        
		string30  	TRADE_STYLE 	;        
		string8	 	SIC_CODE     	;         
		string10  	TMP_HOUSENO  	;  
		string2     LF              ;


  end;
  	export Fein_LN_IN:=record
	
  
		string9     Tax_ID_Number	;
		string9     Source_Duns_Number	;
		string50    Business_Name	;
		string30    Address	;
		string20    City	;
		string2     State	;
		string5     Zip;
		string50    Reference_Name_Source	;
		string8     Date_of_Input_data	;
		string9     Case_Duns_Number	;
		string2     Confidence_Code	;
		string7     Filler1	;
		string1     Indirect_Direct_Source_Ind	;
		string1     Best_FEIN_Indicator	;
		string135   Filler2	;
		string120   Company_Name	;
		string120   Tradestyle	;
		string8     SIC_Code;
		string16    Telephone_Number;
		string60    Top_Contact_Name;
		string60    Top_Contact_Title;
		string9     Headquarter_Paren_Duns_Nbr;
		string1   	Filler3	;

  end;
  
  export Fein_LN_Clean_raw:=record
  
		string9     Tax_ID_Number	;
		string9     Source_Duns_Number	;
		string50    Business_Name	;
		string30    Address	;
		string20    City	;
		string2     State	;
		string5     Zip;
		string50    Reference_Name_Source	;
		string8     Date_of_Input_data	;
		string9     Case_Duns_Number	;
		string2     Confidence_Code	;
		string1     Indirect_Direct_Source_Ind	;
		string1     Best_FEIN_Indicator	;
		string120   Company_Name	;
		string120   Tradestyle	;
		string8     SIC_Code;
		string16    Telephone_Number;
		string60    Top_Contact_Name;
		string60    Top_Contact_Title;
		string9     Headquarter_Paren_Duns_Nbr;
	    string10 	Bus_prim_range					;      
        string2   	Bus_predir						;
        string28 	Bus_prim_name					;
        string4   	Bus_addr_suffix					;
        string2   	Bus_postdir						;
        string10 	Bus_unit_desig					;
        string8   	Bus_sec_range					;
        string25 	Bus_p_city_name					;
        string25 	Bus_v_city_name					;
        string2   	Bus_st							;
        string5   	Bus_zip5						;
        string4   	Bus_zip4						;
/* 		string4   	Bus_cart						;
   		string1   	Bus_cr_sort_sz					;
   		string4   	Bus_lot							;
   		string1   	Bus_lot_order					;
   		string2   	Bus_dpbc						;
   		string1   	Bus_chk_digit					;
   		string2   	Bus_addr_rec_type				;
   		string2   	Bus_fips_state					;
   		string3   	Bus_fips_county					;
   		string10 	Bus_geo_lat						;
   		string11 	Bus_geo_long					;
   		string4   	Bus_cbsa						;
   		string7   	Bus_geo_blk						;
   		string1   	Bus_geo_match					;
   		string4   	Bus_err_stat					;
*/
		
      end											; 
  

  
end;
