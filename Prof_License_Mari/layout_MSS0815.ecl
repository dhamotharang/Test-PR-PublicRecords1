﻿﻿// MSS0815 / Mississippi Real Estate Commission / Multiple Professions //
EXPORT layout_MSS0815 := MODULE
//mab electronic list_lexisnexis
	EXPORT apr := RECORD
		STRING50		LIC_TYPE;
		STRING20		LIC_NBR;				
	  STRING150		NAME_FULL;	
		// STRING100		COMPANY;
		// STRING10		EFF_DATE;   	//EFFECTIVE DATE	
		// STRING10		EXP_DATE;   	//NEXT RENEW DATE
		// STRING30		FIRST_LIC_DATE;		
		STRING30		LIC_STATUS;
		STRING100		ADDRESS1;
		STRING100		ADDRESS2;
		STRING50		CITY;
		STRING10		STATE;
		STRING20		ZIP;
		STRING30		PHONE;		
		STRING10    PHONE_TYPE;
		STRING30    PHONE_2;
		STRING10    PHONE_2_TYPE;
		// STRING30    FAX;	
		STRING50    EMAIL;	
		STRING50   	COUNTY;    		
		// STRING10   RENEW_DATE;  	//NEW
		// STRING50   DBA;					// NOT POPULATED
    // STRING30   PHONE_3; 			// TOLL FREE PHONE-- NOT POPULATED
		// STRING50		DEPARTMENT;
		// STRING50		NAME_FIRST;
		// STRING50		NAME_MID;
		// STRING50		NAME_LAST;
	END;
	
// mrec_electronic_list_lexisnexis.csv
	EXPORT re := RECORD
	  STRING50 		COUNTY;	
		STRING50		LIC_TYPE;
		STRING50		NAME_LAST;
		STRING50		NAME_FIRST;
		STRING50		NAME_MID;
		STRING150		NAME_FULL;
		STRING100		ADDRESS1;
		STRING100		ADDRESS2;
		STRING50		CITY;
		STRING10		STATE;
		STRING20		ZIP;
		STRING20		LIC_NBR;
		STRING30		LIC_STATUS;		
		STRING30		FIRST_LIC_DATE;
		STRING30		EXP_DATE;   //NEXT RENEW DATE
		STRING150		BROKER_NAME;   	
		STRING100		COMPANY;
		STRING30		RENEW_DATE; // INACTIVE DATE		
		STRING30		PHONE;
		// STRING30    WORK_PHONE;
		END;
		

 	EXPORT COMMON := RECORD
	  STRING50		LIC_TYPE;
		STRING100		COMPANY;
		STRING20		LIC_NBR;
		STRING30		LIC_STATUS;
		STRING100		ADDRESS1;
		STRING100		ADDRESS2;
		STRING50		CITY;
		STRING10		STATE;
		STRING50 		COUNTY;		
		STRING20		ZIP;	
		STRING50		NAME_FIRST;
		STRING50		NAME_MID;
		STRING50		NAME_LAST;
		STRING150		NAME_FULL;
		STRING150		BROKER_NAME;   		
		STRING30		PHONE;
		STRING10    PHONE_TYPE;
		STRING30    PHONE_2;
		STRING10    PHONE_2_TYPE;	
		STRING10		EFF_DATE;
		STRING10    EXP_DATE;   
		STRING30		FIRST_LIC_DATE;		
	  STRING30		RENEW_DATE; // INACTIVE DATE		
		STRING50    DBA;
		STRING30    PHONE_3;
		STRING30    FAX;		
    STRING50    EMAIL;		
	END; 

END;
