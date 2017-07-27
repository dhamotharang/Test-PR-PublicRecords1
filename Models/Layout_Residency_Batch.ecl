IMPORT Residency_Services, BatchServices, Batchshare;


EXPORT Layout_Residency_Batch := module;
 

   EXPORT Layout_Debug := RECORD
			  /* Model Input Variables */	
		    Residency_Services.Layouts.Model_In_Layout;
				/* Model Intermediate Variables */ 
				STRING15    model_name;
			  INTEGER     sysdate;
				INTEGER     obsnum;
			  INTEGER     proflic_pts; 
				INTEGER     huntfish_pts;
				INTEGER     utility_pts;
				INTEGER     property_pts;
				INTEGER     aircraft_pts;             
				INTEGER     bankruptcy_pts;
				INTEGER     lienjudg_pts;
				INTEGER     foreclosure_pts;
				INTEGER     paw_pts; 
				INTEGER     business_pts;
				INTEGER     phone_pts;
				INTEGER     veh_pts; 
				INTEGER     watercraft_pts; 
				INTEGER     dl_pts;
				INTEGER     voter_pts;
				INTEGER     homestead_pts;
				INTEGER     isaddress_pts;		
				INTEGER     addrrptscridx_pts;	
				INTEGER     addrrpthstidx_pts;  
				INTEGER     addrsrchhstidx_pts;  
				INTEGER     addrutlhstidx_pts;  
				INTEGER     addrownhstidx_pts;   
				INTEGER     addrownmlidx_pts;  
				INTEGER     InfrOwnTypIdx_pts;
				INTEGER     highriskind1_pts;   
				INTEGER     highriskind3_pts;   
				INTEGER     highriskind_pts;   
				INTEGER     voo_pts;
				INTEGER     high_pts;
				INTEGER     medium_pts;
				INTEGER     low_pts;
				//INTEGER     total_pts; 
				DECIMAL5_2    total_pts; 
				
				BOOLEAN     rtns_flag; 
				BOOLEAN     rtnc_flag;  
				BOOLEAN     num_match;
				BOOLEAN     addrstnme_match;
				BOOLEAN     county_match;  
				BOOLEAN     state_match;
				BOOLEAN     zip_match;
				BOOLEAN     zip_match_int;                      //used to match zip code as an integer - if leading zero is dropped it could match the last for digits
				              
				INTEGER     min_length_prim_range;              //used for prim range in the tie breaker logic  
				INTEGER     num_compare_c9;                     //used for prim range in the tie breaker logic - the best case scenario will result in a 0
				INTEGER   	num_compare;                        //used for prim range - best case will result in a 0
				INTEGER     risk_ind_address_score;             //answer back from Risk_Indicators.AddrScore  
				INTEGER     min_length_prim_name;               //used for prim name in the tie breaker logic 
        INTEGER   	addrstnme_compare;
        INTEGER   	county_compare;
        INTEGER   	state_compare;
        INTEGER   	zip_compare;
     
        STRING1	    Addrmatch;
        STRING1   	CtyStmatch;
        UNSIGNED1   useaddrindex;
				UNSIGNED3   RB_score;  
				UNSIGNED1   index_final;   
	 END; 
			 
 END;
