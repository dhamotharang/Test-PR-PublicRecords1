EXPORT cfpb_race_proxy_layouts := module

export clean_lname_layout := RECORD
    unsigned AccountNumber;
    STRING FirstName;
    // STRING MiddleName;
		STRING LastName;
		// string LastName1;		
		// string LastName2;		
		// string LastName3;		
		// string LastName4;		
    // STRING cfpb_Clean_LastName;
		// string cfpb_clean_lname_sp;		
		// string cfpb_clean_lname_1; 		
		// string cfpb_clean_lname_2; 		
	  string ln_clean_name;			
	  string ln_clean_lname;			
	  string ln_clean_lname_sp;	
	  string ln_clean_lname_1;
	  string ln_clean_lname_2;
    STRING StreetAddress;
    STRING City;
    STRING State;
    STRING Zip;
    // STRING HomePhone;
    // STRING SSN;
    // STRING DateOfBirth;
    // STRING WorkPhone;
    // STRING income;  
    // string DLNumber;
    // string DLState;													
    // string BALANCE; 
    // string CHARGEOFFD;  
    // string FormerName;
    // string EMAIL;  
    // string employername;
    // string HistoryDateYYYYMM;
    STRING Tract;
    STRING BlkGrp;
    STRING Zip5;
    STRING geo_code_precision;		
END;

export blkgrp_layout := record
	string seqno;
	string BlkGrp;
	string State_FIPS10;
	string County_FIPS10;
	string Tract_FIPS10;
	string BlkGrp_FIPS10;
	integer Total_Pop;
	integer Hispanic_Total;
	integer Non_Hispanic_Total;
	integer NH_White_alone;
	integer NH_Black_alone;
	integer NH_AIAN_alone;
	integer NH_API_alone;
	integer NH_Other_alone;
	integer NH_Mult_Total;
	integer NH_White_Other;
	integer NH_Black_Other;
	integer NH_AIAN_Other;
	integer NH_Asian_HPI;
	integer NH_API_Other;
	integer NH_Asian_HPI_Other;
end; 

export tract_layout := record
	string seqno;
	string Tract;
	string State_FIPS10;
	string County_FIPS10;
	string Tract_FIPS10;
	integer Total_Pop;
	integer Hispanic_Total;
	integer Non_Hispanic_Total;
	integer NH_White_alone;
	integer NH_Black_alone;
	integer NH_AIAN_alone;
	integer NH_API_alone;
	integer NH_Other_alone;
	integer NH_Mult_Total;
	integer NH_White_Other;
	integer NH_Black_Other;
	integer NH_AIAN_Other;
	integer NH_Asian_HPI;
	integer NH_API_Other;
	integer NH_Asian_HPI_Other;
end; 

export zip_layout := RECORD
	STRING seqno;
	STRING State_FIPS10;
	STRING County_FIPS10;
	STRING zip5;
	integer Total_Pop;
	integer Hispanic_Total;
	integer Non_Hispanic_Total;
	integer NH_White_alone;
	integer NH_Black_alone;
	integer NH_AIAN_alone;
	integer NH_API_alone;
	integer NH_Other_alone;
	integer NH_Mult_Total;
	integer NH_White_Other;
	integer NH_Black_Other;
	integer NH_AIAN_Other;
	integer NH_Asian_HPI;
	integer NH_API_Other;
	integer NH_Asian_HPI_Other;
END;

export attr_over18_layout := RECORD
	string		GeoInd;
	real  geo_pr_white;
	real geo_pr_black;
	real geo_pr_aian;
	real geo_pr_api;
	real geo_pr_mult_other;
	real geo_pr_hispanic;
	real here;
	real here_given_white;
	real here_given_black;
	real here_given_aian;
	real here_given_api;
	real here_given_mult_other;
	real here_given_hispanic;
END;

export surnames_layout := RECORD
STRING name;
UNSIGNED _rank;
UNSIGNED _count;
real prop100k;
real cum_prop100k;
real pctwhite;
real pctblack;
real pctapi;
real pctaian;
real pct2prace;
real pcthispanic;
real countmiss;
real remaining;
END; 

END;