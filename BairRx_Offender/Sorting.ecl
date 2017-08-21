import BairRx_Common;

EXPORT Sorting := MODULE
	
	SHARED STYPE_NUM := 0;	
	SHARED STYPE_STR := 1;	
	
	EXPORT tvalue(unsigned2 fID) := CHOOSE(fID,
		STYPE_STR,  //  0    R.NAME_TYPE
		STYPE_STR,  //  1    R.LAST_NAME
		STYPE_STR,  //  2    R.FIRST_NAME
		STYPE_STR,  //  3    R.MIDDLE_NAME
		STYPE_STR,  //  4    R.MONIKER
		STYPE_STR,  //  5    R.ADDRESS
		STYPE_STR,  //  6    R.RACE
		STYPE_STR,  //  7    R.SEX
		STYPE_STR,  //  8    R.HAIR
		STYPE_STR,  //  9    R.HAIR_LENGTH
		STYPE_STR,  //  10   R.EYES
		STYPE_STR,  //  11   R.HAND_USE
		STYPE_STR,  //  12   R.SPEECH
		STYPE_STR,  //  13   R.TEETH
		STYPE_STR,  //  14   R.PHYSICAL_CONDITION
		STYPE_STR,  //  15   R.BUILD
		STYPE_STR,  //  16   R.COMPLEXION
		STYPE_STR,  //  17   R.FACIAL_HAIR
		STYPE_STR,  //  18   R.HAT
		STYPE_STR,  //  19   R.MASK
		STYPE_STR,  //  20   R.GLASSES
		STYPE_STR,  //  21   R.APPEARANCE
		STYPE_STR,  //  22   R.SHIRT
		STYPE_STR,  //  23   R.PANTS
		STYPE_STR,  //  24   R.SHOES
		STYPE_STR,  //  25   R.JACKET
		STYPE_NUM,  //  26   R.WEIGHT_1
		STYPE_NUM,  //  27   R.WEIGHT_2
		STYPE_NUM,  //  28   R.HEIGHT_1
		STYPE_NUM,  //  29   R.HEIGHT_2
		STYPE_NUM,  //  30   R.AGE_1
		STYPE_NUM,  //  31   R.AGE_2
		STYPE_STR,  //  32   R.DL_NUMBER
		STYPE_STR,  //  33   R.DL_STATE
		STYPE_STR,  //  34   R.FBI_NUMBER
		STYPE_NUM,  //  35   R.EDIT_DATE
		STYPE_STR,  //  36   R.QUARANTINED
		STYPE_STR,  //  37   R.ADMIN_STATE
		STYPE_STR,  //  38   R.AGENCY_NAME
		STYPE_STR,  //  39   R.AGENCY_CATEGORY
		STYPE_STR,  //  40   R.AGENCY_LEVEL
		STYPE_STR,  //  41   R.CASE_REFERENCE_NUMBER
		STYPE_STR,  //  42   R.CHARGE_OFFENSE
		STYPE_STR,  //  43   R.PROBATION_TYPE
		STYPE_STR,  //  44   R.PROBATION_OFFICER
		STYPE_STR,  //  45   R.WARRANT_TYPE
		STYPE_STR,  //  46   R.WARRANT_NUMBER
		STYPE_STR,  //  47   R.GANG_NAME
		STYPE_STR,  //  48   R.GANG_ROLE
		STYPE_NUM,  //  49   R.X_COORDINATE
		STYPE_NUM,  //  50   R.Y_COORDINATE
		STYPE_STR,  //  51   R.CLASSIFICATION_DATE
		STYPE_STR,  //  52   R.DATA_PROVIDER_NAME
		STYPE_STR,  //  53   R.OFFENDERS_SID
		STYPE_NUM,  //  54   R.BAIR_SCORE
		STYPE_NUM,  //  55   R.EXPIRATION_DATE
		STYPE_STR,  //  56   R.DISTANCE
		0);
	
	EXPORT svalue(fID, R) := FUNCTIONMACRO 
		RETURN CHOOSE(fID, 
			R.NAME_TYPE,           //  0    
			R.LAST_NAME,           //  1    
			R.FIRST_NAME,          //  2    
			R.MIDDLE_NAME,         //  3    
			R.MONIKER,             //  4    
			R.ADDRESS,             //  5    
			R.RACE,                //  6    
			R.SEX,                 //  7    
			R.HAIR,                //  8    
			R.HAIR_LENGTH,         //  9    
			R.EYES,                //  10   
			R.HAND_USE,            //  11   
			R.SPEECH,              //  12   
			R.TEETH,               //  13   
			R.PHYSICAL_CONDITION,  //  14   
			R.BUILD,               //  15   
			R.COMPLEXION,          //  16   
			R.FACIAL_HAIR,         //  17   
			R.HAT,                 //  18   
			R.MASK,                //  19   
			R.GLASSES,             //  20   
			R.APPEARANCE,          //  21   
			R.SHIRT,               //  22   
			R.PANTS,               //  23   
			R.SHOES,               //  24   
			R.JACKET,              //  25   
			'',                    //  26   R.WEIGHT_1
			'',                    //  27   R.WEIGHT_2
			'',                    //  28   R.HEIGHT_1
			'',                    //  29   R.HEIGHT_2
			'',                    //  30   R.AGE_1
			'',                    //  31   R.AGE_2
			R.DL_NUMBER,           //  32   
			R.DL_STATE,            //  33   
			R.FBI_NUMBER,          //  34   
			'',                    //  35   R.EDIT_DATE, TRUE}
			R.QUARANTINED,         //  36   
			R.ADMIN_STATE,         //  37   
			R.AGENCY_NAME,         //  38   
			R.AGENCY_CATEGORY,     //  39   
			R.AGENCY_LEVEL,        //  40   
			R.CASE_REFERENCE_NUMBER,  //  41   
			R.CHARGE_OFFENSE,      //  42   
			R.PROBATION_TYPE,      //  43   
			R.PROBATION_OFFICER,   //  44   
			R.WARRANT_TYPE,        //  45   
			R.WARRANT_NUMBER,      //  46   
			R.GANG_NAME,           //  47   
			R.GANG_ROLE,           //  48   
			'',                    //  49 R.X_COORDINATE
			'',                    //  50 R.Y_COORDINATE
			R.CLASSIFICATION_DATE, //  51   
			R.DATA_PROVIDER_NAME,  //  52   
			R.OFFENDERS_SID,       //  53   
			'',                    //  54   R.BAIR_SCORE
			R.EXPIRATION_DATE,     //  55   
			'',                    //  56   
			'');
	ENDMACRO;
		
	EXPORT nvalue(fID, R, dist) := FUNCTIONMACRO 
		RETURN CHOOSE(fID, 
			0,             //  0    R.NAME_TYPE
			0,             //  1    R.LAST_NAME
			0,             //  2    R.FIRST_NAME
			0,             //  3    R.MIDDLE_NAME
			0,             //  4    R.MONIKER
			0,             //  5    R.ADDRESS
			0,             //  6    R.RACE
			0,             //  7    R.SEX
			0,             //  8    R.HAIR
			0,             //  9    R.HAIR_LENGTH
			0,             //  10   R.EYES
			0,             //  11   R.HAND_USE
			0,             //  12   R.SPEECH
			0,             //  13   R.TEETH
			0,             //  14   R.PHYSICAL_CONDITION
			0,             //  15   R.BUILD
			0,             //  16   R.COMPLEXION
			0,             //  17   R.FACIAL_HAIR
			0,             //  18   R.HAT
			0,             //  19   R.MASK
			0,             //  20   R.GLASSES
			0,             //  21   R.APPEARANCE
			0,             //  22   R.SHIRT
			0,             //  23   R.PANTS
			0,             //  24   R.SHOES
			0,             //  25   R.JACKET
			R.WEIGHT_1,    //  26   
			R.WEIGHT_2,    //  27   
			R.HEIGHT_1,    //  28   
			R.HEIGHT_2,    //  29   
			R.AGE_1,       //  30   
			R.AGE_2,       //  31   
			0,             //  32   R.DL_NUMBER
			0,             //  33   R.DL_STATE
			0,             //  34   R.FBI_NUMBER
			(UNSIGNED8)REGEXREPLACE('[^0-9]',R.EDIT_DATE,''),   //  35   
			0,             //  36   R.QUARANTINED
			0,             //  37   R.ADMIN_STATE
			0,             //  38   R.AGENCY_NAME
			0,             //  39   R.AGENCY_CATEGORY
			0,             //  40   R.AGENCY_LEVEL
			0,             //  41   R.CASE_REFERENCE_NUMBER
			0,             //  42   R.CHARGE_OFFENSE
			0,             //  43   R.PROBATION_TYPE
			0,             //  44   R.PROBATION_OFFICER
			0,             //  45   R.WARRANT_TYPE
			0,             //  46   R.WARRANT_NUMBER
			0,             //  47   R.GANG_NAME
			0,             //  48   R.GANG_ROLE
			R.X_COORDINATE*BairRx_Common.Constants.REAL_TO_INT_SCALE, // 49 
			R.Y_COORDINATE*BairRx_Common.Constants.REAL_TO_INT_SCALE, // 50
			0,             //  51   R.CLASSIFICATION_DATE
			0,             //  52   R.DATA_PROVIDER_NAME
			0,             //  53   R.OFFENDERS_SID
			R.BAIR_SCORE,  //  54   
			(UNSIGNED8)REGEXREPLACE('[^0-9]',R.EXPIRATION_DATE,''),    //  55   R.EXPIRATION_DATE
			dist,          //  56   R.DISTANCE
			0);
	ENDMACRO;

END;

/*
(BAIR.Types.t_FieldStr)LEFT.name_type,
(BAIR.Types.t_FieldStr)LEFT.last_name,
(BAIR.Types.t_FieldStr)LEFT.first_name,
(BAIR.Types.t_FieldStr)LEFT.middle_name,
(BAIR.Types.t_FieldStr)LEFT.moniker,
(BAIR.Types.t_FieldStr)LEFT.address,
(BAIR.Types.t_FieldStr)LEFT.race,
(BAIR.Types.t_FieldStr)LEFT.sex,
(BAIR.Types.t_FieldStr)LEFT.hair,
(BAIR.Types.t_FieldStr)LEFT.hair_length,
(BAIR.Types.t_FieldStr)LEFT.eyes,
(BAIR.Types.t_FieldStr)LEFT.hand_use,
(BAIR.Types.t_FieldStr)LEFT.speech,
(BAIR.Types.t_FieldStr)LEFT.teeth,
(BAIR.Types.t_FieldStr)LEFT.physical_condition,
(BAIR.Types.t_FieldStr)LEFT.build,
(BAIR.Types.t_FieldStr)LEFT.complexion,
(BAIR.Types.t_FieldStr)LEFT.facial_hair,
(BAIR.Types.t_FieldStr)LEFT.hat,
(BAIR.Types.t_FieldStr)LEFT.mask,
(BAIR.Types.t_FieldStr)LEFT.glasses,
(BAIR.Types.t_FieldStr)LEFT.appearance,
(BAIR.Types.t_FieldStr)LEFT.shirt,
(BAIR.Types.t_FieldStr)LEFT.pants,
(BAIR.Types.t_FieldStr)LEFT.shoes,
(BAIR.Types.t_FieldStr)LEFT.jacket,
(BAIR.Types.t_FieldStr)LEFT.weight_1,
(BAIR.Types.t_FieldStr)LEFT.weight_2,
(BAIR.Types.t_FieldStr)LEFT.height_1,
(BAIR.Types.t_FieldStr)LEFT.height_2,
(BAIR.Types.t_FieldStr)LEFT.age_1,
(BAIR.Types.t_FieldStr)LEFT.age_2,
(BAIR.Types.t_FieldStr)LEFT.dl_number,
(BAIR.Types.t_FieldStr)LEFT.dl_state,
(BAIR.Types.t_FieldStr)LEFT.fbi_number,
(BAIR.Types.t_FieldStr)LEFT.edit_date,
(BAIR.Types.t_FieldStr)LEFT.quarantined,
(BAIR.Types.t_FieldStr)LEFT.admin_state,
(BAIR.Types.t_FieldStr)LEFT.agency_name,
(BAIR.Types.t_FieldStr)LEFT.agency_category,
(BAIR.Types.t_FieldStr)LEFT.agency_level,
(BAIR.Types.t_FieldStr)LEFT.case_reference_number,
(BAIR.Types.t_FieldStr)LEFT.charge_offense,
(BAIR.Types.t_FieldStr)LEFT.probation_type,
(BAIR.Types.t_FieldStr)LEFT.probation_officer,
(BAIR.Types.t_FieldStr)LEFT.warrant_type,
(BAIR.Types.t_FieldStr)LEFT.warrant_number,
(BAIR.Types.t_FieldStr)LEFT.gang_name,
(BAIR.Types.t_FieldStr)LEFT.gang_role,
(BAIR.Types.t_FieldStr)LEFT.str_longitude,
(BAIR.Types.t_FieldStr)LEFT.str_latitude,
(BAIR.Types.t_FieldStr)LEFT.str_classification_date,
(BAIR.Types.t_FieldStr)LEFT.str_agency,
(BAIR.Types.t_FieldStr)LEFT.str_sid,
(BAIR.Types.t_FieldStr)LEFT.str_bair_score,
(BAIR.Types.t_FieldStr)LEFT.str_expired'
*/