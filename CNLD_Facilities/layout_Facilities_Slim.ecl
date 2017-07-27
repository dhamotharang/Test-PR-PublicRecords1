export layout_Facilities_Slim := RECORD
		string8  	first_seen_date;
		string8  	last_seen_date;
		string8  	process_date;
  	string10	gennum;              
		string80  org_name;            
		string10	storeno;             
		string9		deanbr;             
		string8		deanbr_exp;         
		string7		deanbr_sch;         
		// string1		addr_ind;						// Address [1,2,3] Indicator
		string55	addr_id;            // Address [1,2,3] ID
		string55	addr_addr1;         // Address [1,2,3] Line 1
		string55	addr_addr2;         // Address [1,2,3] Line 2
		string30	addr_city;          // Address [1,2,3] City
		string2 	addr_st;            // Address [1,2,3] State
		string5		addr_zip;           // Address [1,2,3] Zip
		string10	addr_phone;         // Address [1,2,3] Phone
		string10	addr_fax;           // Address [1,2,3] Fax
		string8		addr_date;          // Address [1,2,3] Date Record, fmt YYYYMMDD 
		string1		addr_status;        // Address [1,2,3] Status (A=Active)
		string1		addr_rank;          // Top Address Rank [1,2,3]
		string2		st_lic_in;          
	  string15	st_lic_num;         
    string8		st_lic_num_exp;     
    string3		st_lic_stat;        
    string10	st_lic_type;        
    string10	fednum;             
    string1		fednum_type;        
    string3		profcode;
		string40 	std_prof_desc;
    string1		profstat; 
		string40 	std_prof_stat;						
    string60	ownername;           
    string2		ownertype;           
    string10	ncpdpnbr;           
    string10	npi;                
    string2		factype;             
    string1		inhospital;          
    string1		inchain;             
    string3		aff_code;            
    string8		survey_date;        
    string1		survey_type;        
    string4		def_code;           
    string1		def_rate;           
    string1		def_status;         
    string1		def_type;           
    string8		sanction_date;      
    string2		sanction_state;     
    string30	sanction_case;      
    unsigned integer	sanction_amt;       
		string60	name_dba;												
		string50 name_contact;							
		
end;		
