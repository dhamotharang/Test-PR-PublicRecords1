//Clean_In_LSSI is the record format of the cleaned LSSI file
EXPORT Layout_Clean_LSSI := RECORD
       Lssi.Layout_In;                       //layout of the raw data
       STRING10        prim_range;           //fields prime_range to err_stat are parsed 
       STRING2         predir;               //from field clean 
       STRING28        prim_name;            
       STRING4         addr_suffix;          
       STRING2         postdir;              
       STRING10        unit_desig;           
       STRING8         sec_range;            
       STRING25        p_city_name;          
       STRING25        v_city_name;          
       STRING2         st;                   
       STRING5         zipcode;              
       STRING4         zip4;                 
       STRING4         cart;
       STRING1         cr_sort_sz;
       STRING4         lot;
       STRING1         lot_order;
       STRING2         dbpc;
       STRING1         chk_digit;
       STRING2         rec_type;
       STRING5         countyname;
       STRING10        geo_lat_val;
       STRING11        geo_long_val;
       STRING4         msa;
       STRING7         geo_blk;
       STRING1         geo_match;
       STRING4         err_stat;
       STRING10        clean_phone;
	  STRING5         title;               //fields title to name_error are parsed 
       STRING20        fname;               //from clean_name
       STRING20        mname;               //
       STRING20        lname;               //
       STRING5         name_suffix;         //
       STRING3         name_error;          //
	  STRING120       clean_compname;      //cleaned non-residential names (split <> 1)
END;