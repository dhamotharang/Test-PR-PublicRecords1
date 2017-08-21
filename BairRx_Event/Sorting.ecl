import BairRx_Common;

EXPORT Sorting := MODULE

	EXPORT STYPE_NUM := 0;	
	EXPORT STYPE_STR := 1;	
	EXPORT FIRST_MO_UDF_FID := 89; // R.MOUDF1 
	EXPORT FIRST_PERSON_UDF_FID := 97; // R.PERSONUDF1 
	
	EXPORT IsMOFID(unsigned fid) := (fid >= 0 and fid <= 33) OR ( fid >= 72 AND fid <= 73) OR (fid >= 80 and fid <= 86) OR (fid = 101);
	EXPORT IsPersonFID(unsigned fid) := (fid >= 34 and fid <= 62) or (fid >= 74 and fid <= 79) or (fid = 88);
	EXPORT IsVehicleFID(unsigned fid) := (fid >= 63 and fid <= 71) or (fid = 87);
	EXPORT IsUDFMOFID(unsigned fid) := (fid >= 89 and fid <= 96);
	EXPORT IsUDFPersonFID(unsigned fid) := (fid >= 97 and fid <= 100);
	
	// Note: A +1 to all FIDs to use CHOSE() because, unfortunately, all IDs start with 0...
			
	EXPORT tvalue(unsigned2 fID) := CHOOSE(fID,
			STYPE_STR, //  0: R.IR_NUMBER,                            MO
			STYPE_STR, //  1: R.CRIME,                                MO
			STYPE_STR, //  2: R.LOCATION_TYPE,                        MO
			STYPE_STR, //  3: R.OBJECT_OF_ATTACK_1,                   MO
			STYPE_STR, //  4: R.OBJECT_OF_ATTACK_2,                   MO
			STYPE_STR, //  5: R.POINT_OF_ENTRY_1,                     MO
			STYPE_STR, //  6: R.POINT_OF_ENTRY_2,                     MO
			STYPE_STR, //  7: R.SUSPECTS_ACTIONS_AGAINST_PERSON_1,    MO
			STYPE_STR, //  8: R.SUSPECTS_ACTIONS_AGAINST_PERSON_2,    MO
			STYPE_STR, //  9: R.SUSPECTS_ACTIONS_AGAINST_PERSON_3,    MO
			STYPE_STR, // 10: R.SUSPECTS_ACTIONS_AGAINST_PERSON_4,    MO
			STYPE_STR, // 11: R.SUSPECTS_ACTIONS_AGAINST_PERSON_5,    MO
			STYPE_STR, // 12: R.SUSPECTS_ACTIONS_AGAINST_PROPERTY_1,  MO
			STYPE_STR, // 13: R.SUSPECTS_ACTIONS_AGAINST_PROPERTY_2,  MO
			STYPE_STR, // 14: R.SUSPECTS_ACTIONS_AGAINST_PROPERTY_3,  MO
			STYPE_STR, // 15: R.PROPERTY_TAKEN_1,                     MO
			STYPE_STR, // 16: R.PROPERTY_TAKEN_2,                     MO
			STYPE_STR, // 17: R.PROPERTY_TAKEN_3,                     MO
			STYPE_NUM, // 18: R.PROPERTY_VALUE,                       MO
			STYPE_STR, // 19: R.METHOD_OF_DEPARTURE                   MO
			STYPE_NUM, // 20: R.FIRST_DATE_TIME                       MO
			STYPE_NUM, // 21: R.LAST_DATE_TIME                        MO
			STYPE_NUM, // 22: R.REPORT_DATE                           MO
			STYPE_STR, // 23: R.ADDRESS_OF_CRIME,                     MO
			STYPE_STR, // 24: R.BEAT,                                 MO
			STYPE_STR, // 25: R.RD,                                   MO
			STYPE_STR, // 26: R.COMPANIONS,                           MO
			STYPE_STR, // 27: R.APT,                                  MO
			STYPE_STR, // 28: R.AGENCY,                               MO
			STYPE_STR, // 29: R.ACCURACY,                             MO
			STYPE_STR, // 30: R.FIRST_DATE,                           MO
			STYPE_STR, // 31: R.LAST_DATE,                            MO
			STYPE_STR, // 32: R.WEAPON_TYPE_1,                        MO
			STYPE_STR, // 33: R.WEAPON_TYPE_2,                        MO
			STYPE_STR, // 34: R.NAME_TYPE,                            PE            
			STYPE_STR, // 35: R.FIRST_NAME,                           PE
			STYPE_STR, // 36: R.MIDDLE_NAME,                          PE
			STYPE_STR, // 37: R.LAST_NAME,                            PE
			STYPE_STR, // 38: R.MONIKER,                              PE
			STYPE_STR, // 39: R.PERSONS_ADDRESS,                      PE
			STYPE_NUM, // 40: R.DOB                                   PE
			STYPE_STR, // 41: R.RACE,                                 PE
			STYPE_STR, // 42: R.SEX,                                  PE
			STYPE_STR, // 43: R.HAIR,                                 PE
			STYPE_STR, // 44: R.HAIR_LENGTH,                          PE
			STYPE_STR, // 45: R.EYES,                                 PE
			STYPE_STR, // 46: R.HAND_USE,                             PE
			STYPE_STR, // 47: R.SPEECH,                               PE
			STYPE_STR, // 48: R.TEETH,                                PE
			STYPE_STR, // 49: R.PHYSICAL_CONDITION,                   PE
			STYPE_STR, // 50: R.BUILD,                                PE
			STYPE_STR, // 51: R.COMPLEXION,                           PE
			STYPE_STR, // 52: R.FACIAL_HAIR,                          PE
			STYPE_STR, // 53: R.HAT,                                  PE
			STYPE_STR, // 54: R.MASK,                                 PE
			STYPE_STR, // 55: R.GLASSES,                              PE
			STYPE_STR, // 56: R.APPEARANCE,                           PE
			STYPE_STR, // 57: R.SHIRT,                                PE
			STYPE_STR, // 58: R.PANTS,                                PE
			STYPE_STR, // 59: R.SHOES,                                PE
			STYPE_STR, // 60: R.JACKET,                               PE
			STYPE_STR, // 61: R.SOUNDEX,                              PE
			STYPE_STR, // 62: R.FACIAL_RECOGNITION,                   PE
			STYPE_STR, // 63: R.PLATE,                                VE
			STYPE_STR, // 64: R.MAKE,                                 VE
			STYPE_STR, // 65: R.MODEL,                                VE
			STYPE_STR, // 66: R.STYLE,                                VE
			STYPE_STR, // 67: R.COLOR,                                VE
			STYPE_STR, // 68: R.YEAR,                                 VE
			STYPE_STR, // 69: R.TYPE,                                 VE
			STYPE_STR, // 70: R.VEHICLE_STATUS,                       VE
			STYPE_STR, // 71: R.VEHICLE_ADDRESS,                      VE
			STYPE_NUM, // 72: R.X_COORDINATE,                         MO
			STYPE_NUM, // 73: R.Y_COORDINATE,                         MO
			STYPE_NUM, // 74: R.WEIGHT_1,                             PE
			STYPE_NUM, // 75: R.WEIGHT_2,                             PE
			STYPE_NUM, // 76: R.HEIGHT_1,                             PE
			STYPE_NUM, // 77: R.HEIGHT_2,                             PE
			STYPE_NUM, // 78: R.AGE_1,                                PE
			STYPE_NUM, // 79: R.AGE_2,                                PE
			STYPE_NUM, // 80: R.FIRST_TIME                            MO 
			STYPE_NUM, // 81: R.LAST_TIME                             MO
			STYPE_STR, // 82: R.METHOD_OF_ENTRY_1                     MO
			STYPE_STR, // 83: R.METHOD_OF_ENTRY_2                     MO
			STYPE_STR, // 84: R.FIRST_DAY                             MO
			STYPE_STR, // 85: R.LAST_DAY                              MO
			STYPE_STR, // 86: R.ADDRESS_NAME                          MO
			STYPE_STR, // 87: R.PLATE_STATE                           VE
			STYPE_STR, // 88: R.PERSONS_SID                           PE			
			STYPE_STR, // 89: R.MOUDF1                           			MOUDF
			STYPE_STR, // 90: R.MOUDF2                           			MOUDF
			STYPE_STR, // 91: R.MOUDF3                           			MOUDF
			STYPE_STR, // 92: R.MOUDF4                           			MOUDF
			STYPE_STR, // 93: R.MOUDF5                           			MOUDF
			STYPE_STR, // 94: R.MOUDF6                           			MOUDF
			STYPE_STR, // 95: R.MOUDF7                           			MOUDF
			STYPE_STR, // 96: R.MOUDF8                           			MOUDF
			STYPE_STR, // 97: R.PERSONUDF1                           	PEUDF
			STYPE_STR, // 98: R.PERSONUDF2                           	PEUDF
			STYPE_STR, // 99: R.PERSONUDF3                           	PEUDF
			STYPE_STR, // 100: R.PERSONUDF4                           PEUDF
			STYPE_NUM, // 101: DISTANCE																MO
			STYPE_NUM);
	
	EXPORT svalueMO(fID, R) := FUNCTIONMACRO 	
		RETURN CHOOSE(fID,
			R.IR_NUMBER,            //  0 
			R.CRIME,                //  1 
			R.LOCATION_TYPE,        //  2 
			R.OBJECT_OF_ATTACK_1,   //  3 
			R.OBJECT_OF_ATTACK_2,   //  4 
			R.POINT_OF_ENTRY_1,     //  5 
			R.POINT_OF_ENTRY_2,     //  6 
			R.SUSPECTS_ACTIONS_AGAINST_PERSON_1,   //  7 
			R.SUSPECTS_ACTIONS_AGAINST_PERSON_2,   //  8 
			R.SUSPECTS_ACTIONS_AGAINST_PERSON_3,   //  9 
			R.SUSPECTS_ACTIONS_AGAINST_PERSON_4,   // 10 
			R.SUSPECTS_ACTIONS_AGAINST_PERSON_5,   // 11 
			R.SUSPECTS_ACTIONS_AGAINST_PROPERTY_1, // 12 
			R.SUSPECTS_ACTIONS_AGAINST_PROPERTY_2, // 13 
			R.SUSPECTS_ACTIONS_AGAINST_PROPERTY_3, // 14 
			R.PROPERTY_TAKEN_1,     // 15 
			R.PROPERTY_TAKEN_2,     // 16 
			R.PROPERTY_TAKEN_3,     // 17 
			'',                     // 18  R.PROPERTY_VALUE,
			R.METHOD_OF_DEPARTURE,  // 19 
			R.FIRST_DATE_TIME,      // 20
			R.LAST_DATE_TIME,       // 21
			'',                     // 22: R.REPORT_DATE
			R.ADDRESS_OF_CRIME,     // 23: 
			R.BEAT,                 // 24: 
			R.RD,                   // 25: 
			R.COMPANIONS,           // 26: 
			R.APT,                  // 27: 
			R.AGENCY,               // 28: 
			R.ACCURACY,             // 29: 
			R.FIRST_DATE,           // 30: 
			R.LAST_DATE,            // 31: 
			R.WEAPON_TYPE_1,        // 32: 
			R.WEAPON_TYPE_2,        // 33: 
			'',                     // 34: R.NAME_TYPE,             
			'',                     // 35: R.FIRST_NAME,            
			'',                     // 36: R.MIDDLE_NAME,           
			'',                     // 37: R.LAST_NAME,             
			'',                     // 38: R.MONIKER,               
			'',                     // 39: R.PERSONS_ADDRESS,       
			'',                     // 40: R.DOB                    
			'',                     // 41: R.RACE,                  
			'',                     // 42: R.SEX,                   
			'',                     // 43: R.HAIR,                  
			'',                     // 44: R.HAIR_LENGTH,           
			'',                     // 45: R.EYES,                  
			'',                     // 46: R.HAND_USE,              
			'',                     // 47: R.SPEECH,                
			'',                     // 48: R.TEETH,                 
			'',                     // 49: R.PHYSICAL_CONDITION,    
			'',                     // 50: R.BUILD,                 
			'',                     // 51: R.COMPLEXION,            
			'',                     // 52: R.FACIAL_HAIR,           
			'',                     // 53: R.HAT,                   
			'',                     // 54: R.MASK,                  
			'',                     // 55: R.GLASSES,               
			'',                     // 56: R.APPEARANCE,            
			'',                     // 57: R.SHIRT,                 
			'',                     // 58: R.PANTS,                 
			'',                     // 59: R.SHOES,                 
			'',                     // 60: R.JACKET,                
			'',                     // 61: R.SOUNDEX,               
			'',                     // 62: R.FACIAL_RECOGNITION,    
			'',                     // 63: R.PLATE,                  
			'',                     // 64: R.MAKE,                  
			'',                     // 65: R.MODEL,                 
			'',                     // 66: R.STYLE,                 
			'',                     // 67: R.COLOR,                 
			'',                     // 68: R.YEAR,                  
			'',                     // 69: R.TYPE,                  
			'',                     // 70: R.VEHICLE_STATUS
			'',                     // 71: R.VEHICLE_ADDRESS
			'',                     // 72: R.X_COORDINATE
			'',                     // 73: R.Y_COORDINATE
			'',                     // 74: R.WEIGHT_1
			'',                     // 75: R.WEIGHT_2
			'',                     // 76: R.HEIGHT_1
			'',                     // 77: R.HEIGHT_2
			'',                     // 78: R.AGE_1
			'',                     // 79: R.AGE_2
			'',                     // 80: R.FIRST_TIME
			'',                     // 81: R.LAST_TIME
			R.METHOD_OF_ENTRY_1,    // 82: 
			R.METHOD_OF_ENTRY_2,    // 83: 
			R.FIRST_DAY,            // 84: 
			R.LAST_DAY,             // 85: 
			R.ADDRESS_NAME,         // 86
			'',                     // 87: R.PLATE_STATE    
			'',                     // 88: R.PERSONS_SID     
			'', 										// 89: R.MOUDF1                           			
			'', 										// 90: R.MOUDF2                           			
			'', 										// 91: R.MOUDF3                           			
			'', 										// 92: R.MOUDF4                           			
			'', 										// 93: R.MOUDF5                           			
			'', 										// 94: R.MOUDF6                           			
			'', 										// 95: R.MOUDF7                           			
			'', 										// 96: R.MOUDF8                           			
			'', 										// 97: R.PERSONUDF1                           	
			'', 										// 98: R.PERSONUDF2                           	
			'', 										// 99: R.PERSONUDF3                           	
			'', 										// 100: R.PERSONUDF4                        
			'',                     // 101: DISTANCE                
			'');
	ENDMACRO;
	
	EXPORT nvalueMO(fID, R, dist) := FUNCTIONMACRO 
		RETURN CHOOSE(fID,
			0, //  0: R.IR_NUMBER,                            
			0, //  1: R.CRIME,                                
			0, //  2: R.LOCATION_TYPE,                        
			0, //  3: R.OBJECT_OF_ATTACK_1,                   
			0, //  4: R.OBJECT_OF_ATTACK_2,                   
			0, //  5: R.POINT_OF_ENTRY_1,                     
			0, //  6: R.POINT_OF_ENTRY_2,                     
			0, //  7: R.SUSPECTS_ACTIONS_AGAINST_PERSON_1,    
			0, //  8: R.SUSPECTS_ACTIONS_AGAINST_PERSON_2,    
			0, //  9: R.SUSPECTS_ACTIONS_AGAINST_PERSON_3,    
			0, // 10: R.SUSPECTS_ACTIONS_AGAINST_PERSON_4,    
			0, // 11: R.SUSPECTS_ACTIONS_AGAINST_PERSON_5,    
			0, // 12: R.SUSPECTS_ACTIONS_AGAINST_PROPERTY_1,  
			0, // 13: R.SUSPECTS_ACTIONS_AGAINST_PROPERTY_2,  
			0, // 14: R.SUSPECTS_ACTIONS_AGAINST_PROPERTY_3,  
			0, // 15: R.PROPERTY_TAKEN_1,                     
			0, // 16: R.PROPERTY_TAKEN_2,                     
			0, // 17: R.PROPERTY_TAKEN_3,                     
			(integer)R.PROPERTY_VALUE,                           // 18:                                MO
			0, // 19: R.METHOD_OF_DEPARTURE      
			(UNSIGNED8)REGEXREPLACE('[^0-9]',R.FIRST_DATE_TIME,''), //20
			(UNSIGNED8)REGEXREPLACE('[^0-9]',R.LAST_DATE_TIME,''), //21
			(UNSIGNED8)REGEXREPLACE('[^0-9]',R.REPORT_DATE,''), // 22
			// (unsigned8)REGEXREPLACE('[^0-9]',R.FIRST_DATE_TIME), // 20:      
			// (unsigned8)REGEXREPLACE('[^0-9]',R.LAST_DATE_TIME),  // 21:      
			// (unsigned8)REGEXREPLACE('[^0-9]',R.REPORT_DATE),     // 22:      
			0, // 23: R.ADDRESS_OF_CRIME,                     
			0, // 24: R.BEAT,                                 
			0, // 25: R.RD,                                   
			0, // 26: R.COMPANIONS,                           
			0, // 27: R.APT,                                  
			0, // 28: R.AGENCY,                               
			0, // 29: R.ACCURACY,                             
			0, // 30: R.FIRST_DATE,                           
			0, // 31: R.LAST_DATE,                            
			0, // 32: R.WEAPON_TYPE_1,                        
			0, // 33: R.WEAPON_TYPE_2,                        
			0, // 34: R.NAME_TYPE,                                       
			0, // 35: R.FIRST_NAME,                           
			0, // 36: R.MIDDLE_NAME,                          
			0, // 37: R.LAST_NAME,                            
			0, // 38: R.MONIKER,                              
			0, // 39: R.PERSONS_ADDRESS,                      
			0, // 40: R.DOB                                   
			0, // 41: R.RACE,                                 
			0, // 42: R.SEX,                                  
			0, // 43: R.HAIR,                                 
			0, // 44: R.HAIR_LENGTH,                          
			0, // 45: R.EYES,                                 
			0, // 46: R.HAND_USE,                             
			0, // 47: R.SPEECH,                               
			0, // 48: R.TEETH,                                
			0, // 49: R.PHYSICAL_CONDITION,                   
			0, // 50: R.BUILD,                                
			0, // 51: R.COMPLEXION,                           
			0, // 52: R.FACIAL_HAIR,                          
			0, // 53: R.HAT,                                  
			0, // 54: R.MASK,                                 
			0, // 55: R.GLASSES,                              
			0, // 56: R.APPEARANCE,                           
			0, // 57: R.SHIRT,                                
			0, // 58: R.PANTS,                                
			0, // 59: R.SHOES,                                
			0, // 60: R.JACKET,                               
			0, // 61: R.SOUNDEX,                              
			0, // 62: R.FACIAL_RECOGNITION,                   
			0, // 63: R.PLATE,                                
			0, // 64: R.MAKE,                                 
			0, // 65: R.MODEL,                                
			0, // 66: R.STYLE,                                
			0, // 67: R.COLOR,                                
			0, // 68: R.YEAR,                                 
			0, // 69: R.TYPE,                                 
			0, // 70: R.VEHICLE_STATUS,                       
			0, // 71: R.VEHICLE_ADDRESS,                      
			R.X_COORDINATE*BairRx_Common.Constants.REAL_TO_INT_SCALE, // 72: 
			R.Y_COORDINATE*BairRx_Common.Constants.REAL_TO_INT_SCALE, // 73:
			0, // 74: R.WEIGHT_1,                             
			0, // 75: R.WEIGHT_2,                             
			0, // 76: R.HEIGHT_1,                             
			0, // 77: R.HEIGHT_2,                             
			0, // 78: R.AGE_1,                                
			0, // 79: R.AGE_2,                                
			R.FIRST_TIME,                   // 80:                       
			R.LAST_TIME,                    // 81:                       
			0,  // 82: R.METHOD_OF_ENTRY_1, // 82:                       
			0,  // 83: R.METHOD_OF_ENTRY_2, // 83:                       
			0,  // 84: R.FIRST_DAY,         // 84:                       
			0,  // 85: R.LAST_DAY,          // 85:  
			0,  // 86: R.ADDRESS_NAME
			0,  // 87: R.PLATE_STATE        
			0,  // 88: R.PERSONS_SID    
			0, 	// 89: R.MOUDF1                           			
			0, 	// 90: R.MOUDF2                           			
			0, 	// 91: R.MOUDF3                           			
			0, 	// 92: R.MOUDF4                           			
			0, 	// 93: R.MOUDF5                           			
			0, 	// 94: R.MOUDF6                           			
			0, 	// 95: R.MOUDF7                           			
			0, 	// 96: R.MOUDF8                           			
			0, 	// 97: R.PERSONUDF1                           	
			0, 	// 98: R.PERSONUDF2                           	
			0, 	// 99: R.PERSONUDF3                           	
			0, 	// 100: R.PERSONUDF4                        
			dist, // 101: DISTANCE                
			0);
	ENDMACRO;	
	
	EXPORT svaluePE(fID, R) := FUNCTIONMACRO 	
		RETURN CHOOSE(fID,
			'', //  0: R.IR_NUMBER,                            
			'', //  1: R.CRIME,                                
			'', //  2: R.LOCATION_TYPE,                        
			'', //  3: R.OBJECT_OF_ATTACK_1,                   
			'', //  4: R.OBJECT_OF_ATTACK_2,                   
			'', //  5: R.POINT_OF_ENTRY_1,                     
			'', //  6: R.POINT_OF_ENTRY_2,                     
			'', //  7: R.SUSPECTS_ACTIONS_AGAINST_PERSON_1,    
			'', //  8: R.SUSPECTS_ACTIONS_AGAINST_PERSON_2,    
			'', //  9: R.SUSPECTS_ACTIONS_AGAINST_PERSON_3,    
			'', // 10: R.SUSPECTS_ACTIONS_AGAINST_PERSON_4,    
			'', // 11: R.SUSPECTS_ACTIONS_AGAINST_PERSON_5,    
			'', // 12: R.SUSPECTS_ACTIONS_AGAINST_PROPERTY_1,  
			'', // 13: R.SUSPECTS_ACTIONS_AGAINST_PROPERTY_2,  
			'', // 14: R.SUSPECTS_ACTIONS_AGAINST_PROPERTY_3,  
			'', // 15: R.PROPERTY_TAKEN_1,                     
			'', // 16: R.PROPERTY_TAKEN_2,                     
			'', // 17: R.PROPERTY_TAKEN_3,                     
			'', // 18: R.PROPERTY_VALUE,                       
			'', // 19: R.METHOD_OF_DEPARTURE                   
			'', // 20: R.FIRST_DATE_TIME                       
			'', // 21: R.LAST_DATE_TIME                        
			'', // 22: R.REPORT_DATE                           
			'', // 23: R.ADDRESS_OF_CRIME,                     
			'', // 24: R.BEAT,                                 
			'', // 25: R.RD,                                   
			'', // 26: R.COMPANIONS,                           
			'', // 27: R.APT,                                  
			'', // 28: R.AGENCY,                               
			'', // 29: R.ACCURACY,                           
			'', // 30: R.FIRST_DATE,                         
			'', // 31: R.LAST_DATE,                          
			'', // 32: R.WEAPON_TYPE_1,                      
			'', // 33: R.WEAPON_TYPE_2,                      
			R.NAME_TYPE,                 // 34:                         
			R.FIRST_NAME,                // 35:              
			R.MIDDLE_NAME,               // 36:              
			R.LAST_NAME,                 // 37:              
			R.MONIKER,                   // 38:              
			R.PERSONS_ADDRESS,           // 39:              
			'',                          // 40: R.DOB        
			R.RACE,                      // 41:              
			R.SEX,                       // 42:              
			R.HAIR,                      // 43:              
			R.HAIR_LENGTH,               // 44:              
			R.EYES,                      // 45:              
			R.HAND_USE,                  // 46:              
			R.SPEECH,                    // 47:              
			R.TEETH,                     // 48:              
			R.PHYSICAL_CONDITION,        // 49:              
			R.BUILD,                     // 50:              
			R.COMPLEXION,                // 51:              
			R.FACIAL_HAIR,               // 52:              
			R.HAT,                       // 53:              
			R.MASK,                      // 54:              
			R.GLASSES,                   // 55:              
			R.APPEARANCE,                // 56:              
			R.SHIRT,                     // 57:              
			R.PANTS,                     // 58:              
			R.SHOES,                     // 59:              
			R.JACKET,                    // 60:              
			R.SOUNDEX,                   // 61:              
			R.FACIAL_RECOGNITION,        // 62:              
			'', // 63: R.PLATE,                  
			'', // 64: R.MAKE,                   
			'', // 65: R.MODEL,                  
			'', // 66: R.STYLE,                  
			'', // 67: R.COLOR,                  
			'', // 68: R.YEAR,                   
			'', // 69: R.TYPE,                   
			'', // 70: R.VEHICLE_STATUS,         
			'', // 71: R.VEHICLE_ADDRESS,        
			'', // 72: R.X_COORDINATE,           
			'', // 73: R.Y_COORDINATE,           
			'', // 74: R.WEIGHT_1,               
			'', // 75: R.WEIGHT_2,               
			'', // 76: R.HEIGHT_1,               
			'', // 77: R.HEIGHT_2,               
			'', // 78: R.AGE_1,                  
			'', // 79: R.AGE_2,                  
			'', // 80: R.FIRST_TIME              
			'', // 81: R.LAST_TIME               
			'', // 82: R.METHOD_OF_ENTRY_1       
			'', // 83: R.METHOD_OF_ENTRY_2       
			'', // 84: R.FIRST_DAY               
			'', // 85: R.LAST_DAY                
			'', // 86: R.ADDRESS_NAME 
			'', // 87: R.PLATE_STATE
			R.PERSONS_SID, // 88
			'', // 89: R.MOUDF1                           			
			'', // 90: R.MOUDF2                           			
			'', // 91: R.MOUDF3                           			
			'', // 92: R.MOUDF4                           			
			'', // 93: R.MOUDF5                           			
			'', // 94: R.MOUDF6                           			
			'', // 95: R.MOUDF7                           			
			'', // 96: R.MOUDF8                           			
			'', // 97: R.PERSONUDF1                           	
			'', // 98: R.PERSONUDF2                           	
			'', // 99: R.PERSONUDF3                           	
			'', // 100: R.PERSONUDF4                        
			'', // 101: DISTANCE    
			'');
	ENDMACRO;
	
	EXPORT nvaluePE(fID, R) := FUNCTIONMACRO 	
		RETURN CHOOSE(fID,
			0, //  0: R.IR_NUMBER,                            
			0, //  1: R.CRIME,                                
			0, //  2: R.LOCATION_TYPE,                        
			0, //  3: R.OBJECT_OF_ATTACK_1,                   
			0, //  4: R.OBJECT_OF_ATTACK_2,                   
			0, //  5: R.POINT_OF_ENTRY_1,                     
			0, //  6: R.POINT_OF_ENTRY_2,                     
			0, //  7: R.SUSPECTS_ACTIONS_AGAINST_PERSON_1,    
			0, //  8: R.SUSPECTS_ACTIONS_AGAINST_PERSON_2,    
			0, //  9: R.SUSPECTS_ACTIONS_AGAINST_PERSON_3,    
			0, // 10: R.SUSPECTS_ACTIONS_AGAINST_PERSON_4,    
			0, // 11: R.SUSPECTS_ACTIONS_AGAINST_PERSON_5,    
			0, // 12: R.SUSPECTS_ACTIONS_AGAINST_PROPERTY_1,  
			0, // 13: R.SUSPECTS_ACTIONS_AGAINST_PROPERTY_2,  
			0, // 14: R.SUSPECTS_ACTIONS_AGAINST_PROPERTY_3,  
			0, // 15: R.PROPERTY_TAKEN_1,                     
			0, // 16: R.PROPERTY_TAKEN_2,                     
			0, // 17: R.PROPERTY_TAKEN_3,                     
			0, // 18: R.PROPERTY_VALUE,                       
			0, // 19: R.METHOD_OF_DEPARTURE                   
			0, // 20: R.FIRST_DATE_TIME                       
			0, // 21: R.LAST_DATE_TIME                        
			0, // 22: R.REPORT_DATE                           
			0, // 23: R.ADDRESS_OF_CRIME,                     
			0, // 24: R.BEAT,                                 
			0, // 25: R.RD,                                   
			0, // 26: R.COMPANIONS,                           
			0, // 27: R.APT,                                  
			0, // 28: R.AGENCY,                               
			0, // 29: R.ACCURACY,                             
			0, // 30: R.FIRST_DATE,                           
			0, // 31: R.LAST_DATE,                            
			0, // 32: R.WEAPON_TYPE_1,                        
			0, // 33: R.WEAPON_TYPE_2,                        
			0, // 34: R.NAME_TYPE,                                        
			0, // 35: R.FIRST_NAME,                           
			0, // 36: R.MIDDLE_NAME,                          
			0, // 37: R.LAST_NAME,                            
			0, // 38: R.MONIKER,                              
			0, // 39: R.PERSONS_ADDRESS,                      
			(UNSIGNED8)REGEXREPLACE('[^0-9]',R.DOB,''), // 40: 
			0, // 41: R.RACE,                                
			0, // 42: R.SEX,                                 
			0, // 43: R.HAIR,                                
			0, // 44: R.HAIR_LENGTH,                         
			0, // 45: R.EYES,                                
			0, // 46: R.HAND_USE,                            
			0, // 47: R.SPEECH,                              
			0, // 48: R.TEETH,                               
			0, // 49: R.PHYSICAL_CONDITION,                  
			0, // 50: R.BUILD,                               
			0, // 51: R.COMPLEXION,                          
			0, // 52: R.FACIAL_HAIR,                         
			0, // 53: R.HAT,                                 
			0, // 54: R.MASK,                                
			0, // 55: R.GLASSES,                             
			0, // 56: R.APPEARANCE,                          
			0, // 57: R.SHIRT,                               
			0, // 58: R.PANTS,                               
			0, // 59: R.SHOES,                               
			0, // 60: R.JACKET,                              
			0, // 61: R.SOUNDEX,                             
			0, // 62: R.FACIAL_RECOGNITION,                  
			0, // 63: R.PLATE,                               
			0, // 64: R.MAKE,                                
			0, // 65: R.MODEL,                               
			0, // 66: R.STYLE,                               
			0, // 67: R.COLOR,                               
			0, // 68: R.YEAR,                                
			0, // 69: R.TYPE,                                
			0, // 70: R.VEHICLE_STATUS,                      
			0, // 71: R.VEHICLE_ADDRESS,                     
			0, // 72: R.X_COORDINATE,                        
			0, // 73: R.Y_COORDINATE,                        
			R.WEIGHT_1,  // 74:                              
			R.WEIGHT_2,  // 75:                              
			R.HEIGHT_1,  // 76:                              
			R.HEIGHT_2,  // 77:                              
			R.AGE_1,     // 78:                              
			R.AGE_2,     // 79:                              
			0, // 80: R.FIRST_TIME                           
			0, // 81: R.LAST_TIME                            
			0, // 82: R.METHOD_OF_ENTRY_1                    
			0, // 83: R.METHOD_OF_ENTRY_2                    
			0, // 84: R.FIRST_DAY                            
			0, // 85: R.LAST_DAY                             
			0, // 86: R.ADDRESS_NAME
			0, // 87: R.PLATE_STATE                          
			0, // 88: R.PERSONS_SID                          
			0, 	// 89: R.MOUDF1                           			
			0, 	// 90: R.MOUDF2                           			
			0, 	// 91: R.MOUDF3                           			
			0, 	// 92: R.MOUDF4                           			
			0, 	// 93: R.MOUDF5                           			
			0, 	// 94: R.MOUDF6                           			
			0, 	// 95: R.MOUDF7                           			
			0, 	// 96: R.MOUDF8                           			
			0, 	// 97: R.PERSONUDF1                           	
			0, 	// 98: R.PERSONUDF2                           	
			0, 	// 99: R.PERSONUDF3                           	
			0, 	// 100: R.PERSONUDF4                        
			0, // 101: DISTANCE           
			0);
	ENDMACRO;
	
	EXPORT svalueVE(fID, R) := FUNCTIONMACRO 
		RETURN CHOOSE(fID,
			'', //  0: R.IR_NUMBER,                          
			'', //  1: R.CRIME,                              
			'', //  2: R.LOCATION_TYPE,                      
			'', //  3: R.OBJECT_OF_ATTACK_1,                 
			'', //  4: R.OBJECT_OF_ATTACK_2,                 
			'', //  5: R.POINT_OF_ENTRY_1,                   
			'', //  6: R.POINT_OF_ENTRY_2,                   
			'', //  7: R.SUSPECTS_ACTIONS_AGAINST_PERSON_1,  
			'', //  8: R.SUSPECTS_ACTIONS_AGAINST_PERSON_2,  
			'', //  9: R.SUSPECTS_ACTIONS_AGAINST_PERSON_3,  
			'', // 10: R.SUSPECTS_ACTIONS_AGAINST_PERSON_4,  
			'', // 11: R.SUSPECTS_ACTIONS_AGAINST_PERSON_5,  
			'', // 12: R.SUSPECTS_ACTIONS_AGAINST_PROPERTY_1,
			'', // 13: R.SUSPECTS_ACTIONS_AGAINST_PROPERTY_2,
			'', // 14: R.SUSPECTS_ACTIONS_AGAINST_PROPERTY_3,
			'', // 15: R.PROPERTY_TAKEN_1,                   
			'', // 16: R.PROPERTY_TAKEN_2,                   
			'', // 17: R.PROPERTY_TAKEN_3,                   
			'', // 18: R.PROPERTY_VALUE,                     
			'', // 19: R.METHOD_OF_DEPARTURE                 
			'', // 20: R.FIRST_DATE_TIME                     
			'', // 21: R.LAST_DATE_TIME                      
			'', // 22: R.REPORT_DATE                         
			'', // 23: R.ADDRESS_OF_CRIME,                   
			'', // 24: R.BEAT,                               
			'', // 25: R.RD,                                 
			'', // 26: R.COMPANIONS,                         
			'', // 27: R.APT,                                
			'', // 28: R.AGENCY,                             
			'', // 29: R.ACCURACY,                           
			'', // 30: R.FIRST_DATE,                         
			'', // 31: R.LAST_DATE,                          
			'', // 32: R.WEAPON_TYPE_1,                      
			'', // 33: R.WEAPON_TYPE_2,                      
			'', // 34: R.NAME_TYPE,                                  
			'', // 35: R.FIRST_NAME,                         
			'', // 36: R.MIDDLE_NAME,                        
			'', // 37: R.LAST_NAME,                          
			'', // 38: R.MONIKER,                            
			'', // 39: R.PERSONS_ADDRESS,                    
			'', // 40: R.DOB                                 
			'', // 41: R.RACE,                               
			'', // 42: R.SEX,                                
			'', // 43: R.HAIR,                               
			'', // 44: R.HAIR_LENGTH,                        
			'', // 45: R.EYES,                               
			'', // 46: R.HAND_USE,                           
			'', // 47: R.SPEECH,                             
			'', // 48: R.TEETH,                              
			'', // 49: R.PHYSICAL_CONDITION,                 
			'', // 50: R.BUILD,                              
			'', // 51: R.COMPLEXION,                         
			'', // 52: R.FACIAL_HAIR,                        
			'', // 53: R.HAT,                                
			'', // 54: R.MASK,                               
			'', // 55: R.GLASSES,                            
			'', // 56: R.APPEARANCE,                         
			'', // 57: R.SHIRT,                              
			'', // 58: R.PANTS,                              
			'', // 59: R.SHOES,                              
			'', // 60: R.JACKET,                             
			'', // 61: R.SOUNDEX,                            
			'', // 62: R.FACIAL_RECOGNITION,                 
			R.PLATE,           // 63:                        
			R.MAKE,            // 64:                        
			R.MODEL,           // 65:                        
			R.STYLE,           // 66:                        
			R.COLOR,           // 67:                        
			R.YEAR,            // 68:
			R.TYPE,            // 69:                        
			R.VEHICLE_STATUS,  // 70:                        
			R.VEHICLE_ADDRESS, // 71:                      
			'', // 72: R.X_COORDINATE,                       
			'', // 73: R.Y_COORDINATE,                       
			'', // 74: R.WEIGHT_1,                           
			'', // 75: R.WEIGHT_2,                           
			'', // 76: R.HEIGHT_1,                           
			'', // 77: R.HEIGHT_2,                           
			'', // 78: R.AGE_1,                              
			'', // 79: R.AGE_2,                              
			'', // 80: R.FIRST_TIME                          
			'', // 81: R.LAST_TIME                           
			'', // 82: R.METHOD_OF_ENTRY_1                   
			'', // 83: R.METHOD_OF_ENTRY_2                   
			'', // 84: R.FIRST_DAY                           
			'', // 85: R.LAST_DAY
			'', // 86: R.ADDRESS_NAME
			R.PLATE_STATE,     // 87:                            
			'', // 88: R.PERSONS_SID                         
			'', // 89: R.MOUDF1                           			
			'', // 90: R.MOUDF2                           			
			'', // 91: R.MOUDF3                           			
			'', // 92: R.MOUDF4                           			
			'', // 93: R.MOUDF5                           			
			'', // 94: R.MOUDF6                           			
			'', // 95: R.MOUDF7                           			
			'', // 96: R.MOUDF8                           			
			'', // 97: R.PERSONUDF1                           	
			'', // 98: R.PERSONUDF2                           	
			'', // 99: R.PERSONUDF3                           	
			'', // 100: R.PERSONUDF4                        
			'', // 101: DISTANCE    
			'');
	ENDMACRO;

	EXPORT nvalueVE(fID, R) := FUNCTIONMACRO 
		RETURN 0;
	ENDMACRO;

	////////////////////////////////////////////////
	//// UDF Fields
	////////////////////////////////////////////////
	
	// UDF fiels have dynamic type per field per agency. Need additional logic to handle those...	
	// udf_type: 0-none, 1-string, 2-integer, 3-decimal, 4-date, 5-boolean
	EXPORT map_udf_type_to_int_str(unsigned1 udf_type) := IF(udf_type in [0, 1], STYPE_STR, STYPE_NUM);		
	
	EXPORT tvalueMOUDF(fID, R) := FUNCTIONMACRO		
		RETURN CHOOSE(fID - BairRx_Event.Sorting.FIRST_MO_UDF_FID,
			BairRx_Event.Sorting.map_udf_type_to_int_str(R.udf1_type),
			BairRx_Event.Sorting.map_udf_type_to_int_str(R.udf2_type),
			BairRx_Event.Sorting.map_udf_type_to_int_str(R.udf3_type),
			BairRx_Event.Sorting.map_udf_type_to_int_str(R.udf4_type),
			BairRx_Event.Sorting.map_udf_type_to_int_str(R.udf5_type),
			BairRx_Event.Sorting.map_udf_type_to_int_str(R.udf6_type),
			BairRx_Event.Sorting.map_udf_type_to_int_str(R.udf7_type),
			BairRx_Event.Sorting.map_udf_type_to_int_str(R.udf8_type),
			0
		);
		
	ENDMACRO;
	
	EXPORT tvaluePersonUDF(fID, R) := FUNCTIONMACRO		
		RETURN CHOOSE(fID - BairRx_Event.Sorting.FIRST_PERSON_UDF_FID,
			BairRx_Event.Sorting.map_udf_type_to_int_str(R.personudf1_type),
			BairRx_Event.Sorting.map_udf_type_to_int_str(R.personudf2_type),
			BairRx_Event.Sorting.map_udf_type_to_int_str(R.personudf3_type),
			BairRx_Event.Sorting.map_udf_type_to_int_str(R.personudf4_type),
			0
		);		
	ENDMACRO;		
	
	EXPORT svalueMOUDF(fID, fIDType, R) := FUNCTIONMACRO 	
		RETURN IF(fIDType <> BairRx_Event.Sorting.STYPE_STR, '',
			CHOOSE(fID - BairRx_Event.Sorting.FIRST_MO_UDF_FID,
				R.MOUDF1, // 89
				R.MOUDF2, // 90                           			
				R.MOUDF3, // 91                           			
				R.MOUDF4, // 92                           			
				R.MOUDF5, // 93                           			
				R.MOUDF6, // 94                           			
				R.MOUDF7, // 95                           			
				R.MOUDF8, // 96                           			
				'')
			);
	ENDMACRO;	
	
	EXPORT nvalueMOUDF(fID, fIDType, R) := FUNCTIONMACRO 	
		RETURN IF(fIDType <> BairRx_Event.Sorting.STYPE_NUM, 0,
			CHOOSE(fID - BairRx_Event.Sorting.FIRST_MO_UDF_FID,
				((UNSIGNED8)REGEXREPLACE('[^0-9]',R.MOUDF1,''))*BairRx_Common.Constants.REAL_TO_INT_SCALE, // 89
				((UNSIGNED8)REGEXREPLACE('[^0-9]',R.MOUDF2,''))*BairRx_Common.Constants.REAL_TO_INT_SCALE, // 90                           			
				((UNSIGNED8)REGEXREPLACE('[^0-9]',R.MOUDF3,''))*BairRx_Common.Constants.REAL_TO_INT_SCALE, // 91                           			
				((UNSIGNED8)REGEXREPLACE('[^0-9]',R.MOUDF4,''))*BairRx_Common.Constants.REAL_TO_INT_SCALE, // 92                           			
				((UNSIGNED8)REGEXREPLACE('[^0-9]',R.MOUDF5,''))*BairRx_Common.Constants.REAL_TO_INT_SCALE, // 93                           			
				((UNSIGNED8)REGEXREPLACE('[^0-9]',R.MOUDF6,''))*BairRx_Common.Constants.REAL_TO_INT_SCALE, // 94                           			
				((UNSIGNED8)REGEXREPLACE('[^0-9]',R.MOUDF7,''))*BairRx_Common.Constants.REAL_TO_INT_SCALE, // 95                           			
				((UNSIGNED8)REGEXREPLACE('[^0-9]',R.MOUDF8,''))*BairRx_Common.Constants.REAL_TO_INT_SCALE, // 96                           			
				0)				
			);
	ENDMACRO;

	EXPORT svaluePersonUDF(fID, fIDType, R) := FUNCTIONMACRO 	
		RETURN IF(fIDType <> BairRx_Event.Sorting.STYPE_STR, '',
			CHOOSE(fID - BairRx_Event.Sorting.FIRST_PERSON_UDF_FID,
				R.PERSONUDF1, // 97
				R.PERSONUDF2, // 98                           			
				R.PERSONUDF3, // 99
				R.PERSONUDF4, // 100                           			
				'')
			);
	ENDMACRO;	
	
	EXPORT nvaluePersonUDF(fID, fIDType, R) := FUNCTIONMACRO 	
		RETURN IF(fIDType <> BairRx_Event.Sorting.STYPE_NUM, 0,
			CHOOSE(fID - BairRx_Event.Sorting.FIRST_MO_UDF_FID,
				((UNSIGNED8)REGEXREPLACE('[^0-9]',R.PERSONUDF1,''))*BairRx_Common.Constants.REAL_TO_INT_SCALE, // 97
				((UNSIGNED8)REGEXREPLACE('[^0-9]',R.PERSONUDF2,''))*BairRx_Common.Constants.REAL_TO_INT_SCALE, // 98                           			
				((UNSIGNED8)REGEXREPLACE('[^0-9]',R.PERSONUDF3,''))*BairRx_Common.Constants.REAL_TO_INT_SCALE, // 99                           			
				((UNSIGNED8)REGEXREPLACE('[^0-9]',R.PERSONUDF4,''))*BairRx_Common.Constants.REAL_TO_INT_SCALE, // 100                           			
				0)				
			);
	ENDMACRO;

END;

