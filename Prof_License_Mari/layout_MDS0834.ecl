﻿// MDS0834 / Maryland Commission of Real Estate App & Home Insp / Real Estate Appraisers //

EXPORT LAYOUT_MDS0834 := MODULE
 EXPORT RAW := RECORD
	STRING     LIC_TYPE;   //CAT 
	STRING     SLNUM;      //REG#		
  // STRING 	   FIRST_NAME;
	// STRING     LAST_NAME;  
	STRING     NAME_FULL;
	// STRING     EMAIL;
	STRING     ADDRESS1_1;
	STRING     ADDRESS2_1;
	STRING     CITY_1;
	STRING     STATE_1;
	STRING     ZIP;
	STRING     EXPDT;
	END;
	
 EXPORT RAW_2 := RECORD
	STRING     LIC_TYPE;   //CAT 
	STRING     SLNUM;      //REG#		
  STRING 	   FIRST_NAME;
	STRING     LAST_NAME;  
	// STRING     NAME_FULL;
	STRING     EMAIL;
	STRING     ADDRESS1_1;
	STRING     ADDRESS2_1;
	STRING     CITY_1;
	STRING     STATE_1;
	STRING     ZIP;
	STRING     EXPDT;
	END;
	
 EXPORT COMMON := RECORD
 STRING     LIC_TYPE;
	STRING     SLNUM;
	STRING     FIRST_NAME;
	STRING     LAST_NAME;
	STRING     NAME_FULL;
	STRING     ADDRESS1_1;
	STRING     ADDRESS2_1;
	STRING     CITY_1;
	STRING     STATE_1;
	STRING     ZIP;
	STRING     EXPDT;
	STRING     EMAIL;
END;
	
END;