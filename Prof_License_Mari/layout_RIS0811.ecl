// RIS0811 / State of Rhode Island Dept of Business Regulation	/ Multiple Professions //

export layout_RIS0811 := MODULE
 
 
 	EXPORT rAppraiser := RECORD
		STRING 	FULL_NAME,
		STRING	LIC_TYPE,
		STRING 	LIC_NUM,
		STRING	LIC_STATUS,
		STRING  ADDRESS_1,
		STRING  ADDRESS_2,
		STRING  CITY_1,					
		STRING  STATE_1,
		STRING	ZIP_1,
		STRING	BUS_PHONE
	END;
	
	EXPORT rBroker_sl := RECORD
		STRING 	FULL_NAME,
		STRING	LIC_TYPE,
		STRING 	LIC_NUM,
		STRING	LIC_STATUS,
		STRING	OFFICENAME;
		STRING  ADDRESS_1,
		STRING  ADDRESS_2,
		STRING  CITY_1,					
		STRING  STATE_1,
		STRING	ZIP_1		
	END;

END;

	/*export rAppraiser := 
		RECORD
			string  LIC_STATE,
			string	LAST_UPDT,			//fmt MM/DD/YYYY
			string  LIC_TYPE,
			string  ORG_NAME,
			string  OFFICENAME,
			string  ADDRESS_1,		
			string  CITYSTZIP,			
			string  EXP_DATE			//fmt MM/DD/YYYY
		END;
		
	
 	export rBroker_sl := 
   		RECORD
   			//string  LIC_STATE,			//Removed 20130430
   			//string	LAST_UPDT,			//Removed 20130430
   			string  LIC_NUM,
   			string  LAST_NAME,
   			string  FIRST_NAME,
   			string  OFFICENAME,
   			string  ADDRESS_1,
   			string  CITY_1,					
   			string  STATE_1,
   			string	ZIP_1
   		END;

	
END;	*/


// export layout_RIS0811 := RECORD
	// string30   LIC_NUMR;
	// string30   LAST_NAME;
	// string30   FIRST_NAME;
	// string100  BUS_NAME;
	// string100  BUS_ADDRESS;
	// string30   CITY_TOWN;
	// string2    STATE;
	// string10   ZIP;
	// string30   EXP_DATE;
	// string100  FULL_NAME;
	// string50   CITYSTZIP;
// END;