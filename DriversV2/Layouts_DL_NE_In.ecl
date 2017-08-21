export Layouts_DL_NE_In := module

	export  Layout_NE_Update := record  			
	
		   string9    DLN ;                      	
		   string35   NAME;                    		
		   string10   DOB ;                    	   
		   string30   ADDRESS_STREET;  				
		   string18   ADDRESS_CITY;            	  
		   string2    ADDRESS_STATE;           	    
		   string5    ADDRESS_ZIP5 ;   			  
		   string4    ADDRESS_ZIP4 ;   			   
		   string1    GENDER ;                	   
		   string3    HEIGHT ;                 	   
		   string3    WEIGHT ;                 	   
		   string3    EYE_COLOR ;              	   
		   string3    HAIR_COLOR ;             	   
		   string4    LICENSE_TYPE;
      end;
	  

	export Layout_NE_With_ProcessDte := record
		string8 process_date;
		Layout_NE_Update;
	end;
	
    export Layout_NE_With_Clean := record
	
				Layout_NE_With_ProcessDte;
		string5         title;
		string20        fname;
		string20        mname;
		string20        lname;
		string5         name_suffix;
		string3         cleaning_score;
		string10        prim_range;
		string2         predir;
		string28        prim_name;
		string4         suffix;
		string2         postdir;
		string10        unit_desig;
		string8         sec_range;
		string25        p_city_name;
		string25        v_city_name;
		string2         state;
		string5         zip;
		string4         zip4;
		string4         cart;
		string1         cr_sort_sz;
		string4         lot;
		string1         lot_order;
		string2         dpbc;
		string1         chk_digit;
		string2         rec_type;
		string2         ace_fips_st;
		string3         county;
		string10        geo_lat;
		string11        geo_long;
		string4         msa;
		string7         geo_blk;
		string1         geo_match;
		string4         err_stat;
	end;
	
end;

