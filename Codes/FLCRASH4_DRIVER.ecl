export FLCRASH4_DRIVER :=
MODULE
     export VARSTRING DL_NBR_GOOD_BAD(string code) := MAP(
			code='G'=>'Good',  
			code='B'=>'Bad',  
				                       '');

	export VARSTRING DRIVER_ALCO_DRUG_CODE(string code) := MAP(
			code='0'=>'',  
			code='1'=>'Not Drinking or Using Drugs',  
			code='2'=>'Alcohol - Under Influence',  
			code='3'=>'Drugs - Under Influence',  
			code='4'=>'Alcohol & Drugs - Under Influence',  
			code='5'=>'Had Been Drinking',  
			code='6'=>'Pending BAC Test Result',  
		     '');

	export VARSTRING DRIVER_BAC_TEST_TYPE(string code) := MAP(
			code='1'=>'Blood',  
			code='2'=>'Breath',  
			code='3'=>'Urine',  
			code='4'=>'Refused',  
			code='5'=>'None',
               '');

	export VARSTRING DRIVER_EJECT_CODE(string code) := MAP(
			code='0'=>'',  
			code='1'=>'No',  
			code='2'=>'Yes',  
			code='3'=>'Partial', 
               '');

     export VARSTRING DRIVER_INJURY_SEVERITY(string code) := MAP(
			code='1'=>'None',  
			code='2'=>'Possible',  
			code='3'=>'Non-Incapacitating',  
			code='4'=>'Incapacitating',  
			code='5'=>'Fatal (Within 90 Days)',  
			code='6'=>'Non-Traffic Fatality',  
		     '');

	export VARSTRING DRIVER_LIC_TYPE(string code) := MAP(
			code='0'=>'',  
			code='1'=>'A',  
			code='2'=>'B',  
			code='3'=>'C',  
			code='4'=>'D / Chauffeur',  
			code='5'=>'E / Operator',  
			code='6'=>'E / Operator - Restricted',  
			code='7'=>'None',  
		     '');

	export VARSTRING DRIVER_PHYSICAL_DEFECTS(string code) := MAP(
			code='0'=>'',  
			code='1'=>'No Defects Known',  
			code='2'=>'Eyesight Defect',  
			code='3'=>'Fatigue / Asleep',  
			code='4'=>'Hearing Defect',  
			code='5'=>'Illness',  
			code='6'=>'Seizure',  
			code='7'=>'Other Physical Defect',  
		     '');

	export VARSTRING DRIVER_RACE(string code) := MAP(
			code='1'=>'White',  
			code='2'=>'Black',  
			code='3'=>'Hispanic',  
			code='4'=>'Other',  
			'');

     export VARSTRING DRIVER_RESIDENCE(string code) := MAP(
			code='0'=>'',  
			code='1'=>'County of Crash',  
			code='2'=>'Elsewhere in State',  
			code='3'=>'Non-Resident of State',  
			code='4'=>'Foreign',  
			code='5'=>'Unknown',  
	          '');

	export VARSTRING DRIVER_SEX(string code) := MAP(
			code='1'=>'Male',  
			code='2'=>'Female',  
		     '');

	export VARSTRING FIRST_CONTRIB_CAUSE(string code) := MAP(
			code='01'=>'No Improper Driving / Action',  
			code='02'=>'Careless Driving',  
			code='03'=>'Failed to Yield Right-Of-Way',  
			code='04'=>'Improper Backing',  
			code='05'=>'Improper Lane Change',  
			code='06'=>'Improper Turn',  
			code='07'=>'Alcohol - Under Influence',  
			code='08'=>'Drugs - Under Influence',  
			code='09'=>'Alcohol & Drugs - Under Influence',  
			code='10'=>'Followed Too Closely',  
			code='11'=>'Disregarded Traffic Signal',  
			code='12'=>'Exceeded Safe Speed Limit',  
			code='13'=>'Disregarded Stop Sign',  
			code='14'=>'Failed to Maintain Equip / Vehicle',  
			code='15'=>'Improper Passing',  
			code='16'=>'Drove Left of Center',  
			code='17'=>'Exceeded Stated Speed Limit',  
			code='18'=>'Obstructing Traffic',  
			code='19'=>'Improper Load',  
			code='20'=>'Disregarded Other Traffic Control',  
			code='21'=>'Driving Wrong Side / Way',  
			code='22'=>'Fleeing Police',  
			code='23'=>'Vehicle Modified',  
			code='77'=>'',  
			code='88'=>'',  
		     '');

	export VARSTRING FIRST_DRIVER_SAFETY(string code) := MAP(
			code='0'=>'',  
			code='1'=>'Not in Use',  
			code='2'=>'Seat Belt / Shoulder Harness',  
			code='3'=>'Child Restraint',  
			code='4'=>'Air Bag',  
			code='5'=>'Safety Helmet',  
			code='6'=>'Eye Protection',  
		     '');

	export VARSTRING RECOMMAND_REEXAM(string code) := MAP(
			code='0'=>'',  
			code='1'=>'Driver Ability Questionable',  
			code='2'=>'Driver Ability Not Questionable',  
		     '');

	export VARSTRING REQ_ENDORSEMENT(string code) := MAP(
			code='1'=>'Yes',  
			code='2'=>'No',  
               '');

	export VARSTRING SECOND_CONTRIB_CAUSE(string code) := MAP(
			code='01'=>'No Improper Driving / Action',  
			code='02'=>'Careless Driving',  
			code='03'=>'Failed to Yield Right-Of-Way',  
			code='04'=>'Improper Backing',  
			code='05'=>'Improper Lane Change',  
			code='06'=>'Improper Turn',  
			code='07'=>'Alcohol - Under Influence',  
			code='08'=>'Drugs - Under Influence',  
			code='09'=>'Alcohol & Drugs - Under Influence',  
			code='10'=>'Followed Too Closely',  
			code='11'=>'Disregarded Traffic Signal',  
			code='12'=>'Exceeded Safe Speed Limit',  
			code='13'=>'Disregarded Stop Sign',  
			code='14'=>'Failed to Maintain Equip / Vehicle',  
			code='15'=>'Improper Passing',  
			code='16'=>'Drove Left of Center',  
			code='17'=>'Exceeded Stated Speed Limit',  
			code='18'=>'Obstructing Traffic',  
			code='19'=>'Improper Load',  
			code='20'=>'Disregarded Other Traffic Control',  
			code='21'=>'Driving Wrong Side / Way',  
			code='22'=>'Fleeing Police',  
			code='23'=>'Vehicle Modified',  
			code='77'=>'',  
			code='88'=>'',  
		     '');

	export VARSTRING SECOND_DRIVER_SAFETY(string code) := MAP(
			code='0'=>'',  
			code='1'=>'Not in Use',  
			code='2'=>'Seat Belt / Shoulder Harness',  
			code='3'=>'Child Restraint',  
			code='4'=>'Air Bag',  
			code='5'=>'Safety Helmet',  
			code='6'=>'Eye Protection',  
		     '');

	export VARSTRING THIRD_CONTRIB_CAUSE(string code) := MAP(
			code='01'=>'No Improper Driving / Action',  
			code='02'=>'Careless Driving',  
			code='03'=>'Failed to Yield Right-Of-Way',  
			code='04'=>'Improper Backing',  
			code='05'=>'Improper Lane Change',  
			code='06'=>'Improper Turn',  
			code='07'=>'Alcohol - Under Influence',  
			code='08'=>'Drugs - Under Influence',  
			code='09'=>'Alcohol & Drugs - Under Influence',  
			code='10'=>'Followed Too Closely',  
			code='11'=>'Disregarded Traffic Signal',  
			code='12'=>'Exceeded Safe Speed Limit',  
			code='13'=>'Disregarded Stop Sign',  
			code='14'=>'Failed to Maintain Equip / Vehicle',  
			code='15'=>'Improper Passing',  
			code='16'=>'Drove Left of Center',  
			code='17'=>'Exceeded Stated Speed Limit',  
			code='18'=>'Obstructing Traffic',  
			code='19'=>'Improper Load',  
			code='20'=>'Disregarded Other Traffic Control',  
			code='21'=>'Driving Wrong Side / Way',  
			code='22'=>'Fleeing Police',  
			code='23'=>'Vehicle Modified',  
			code='77'=>'',  
			code='88'=>'',  
		     '');

	export checkChanges :=
	FUNCTION
		
	codes.Layout_Codes_V3 trans(codes.File_Codes_V3_in le) :=
		TRANSFORM
			translation := 
				MAP(le.field_name = 'DL_NBR_GOOD_BAD'	=>	DL_NBR_GOOD_BAD(le.code),
				    le.field_name = 'DRIVER_ALCO_DRUG_CODE'	=>	DRIVER_ALCO_DRUG_CODE(le.code),
				    le.field_name = 'DRIVER_BAC_TEST_TYPE'	=>	DRIVER_BAC_TEST_TYPE(le.code),
				    le.field_name = 'DRIVER_EJECT_CODE'	=>	DRIVER_EJECT_CODE(le.code),
				    le.field_name = 'DRIVER_INJURY_SEVERITY'	=>	DRIVER_INJURY_SEVERITY(le.code),
				    le.field_name = 'DRIVER_LIC_TYPE'	=>	DRIVER_LIC_TYPE(le.code),
				    le.field_name = 'DRIVER_PHYSICAL_DEFECTS'	=>	DRIVER_PHYSICAL_DEFECTS(le.code),
				    le.field_name = 'DRIVER_RACE'	=>	DRIVER_RACE(le.code),
				    le.field_name = 'DRIVER_RESIDENCE'	=>	DRIVER_RESIDENCE(le.code),
				    le.field_name = 'DRIVER_SEX'	=>	DRIVER_SEX(le.code),
				    le.field_name = 'FIRST_CONTRIB_CAUSE'	=>	FIRST_CONTRIB_CAUSE(le.code),
				    le.field_name = 'FIRST_DRIVER_SAFETY'	=>	FIRST_DRIVER_SAFETY(le.code),
				    le.field_name = 'RECOMMAND_REEXAM'	=>	RECOMMAND_REEXAM(le.code),
				    le.field_name = 'REQ_ENDORSEMENT'	=>	REQ_ENDORSEMENT(le.code),
				    le.field_name = 'SECOND_CONTRIB_CAUSE'	=>	SECOND_CONTRIB_CAUSE(le.code),
				    le.field_name = 'SECOND_DRIVER_SAFETY'	=>	SECOND_DRIVER_SAFETY(le.code),                        
				    le.field_name = 'THIRD_CONTRIB_CAUSE'	=>	THIRD_CONTRIB_CAUSE(le.code),                        
                        '');
				  
			SELF.code := IF(le.long_desc=translation,SKIP,le.code);
			SELF := le;
		END;
	
	p := PROJECT(codes.File_Codes_V3_in(file_name='FLCRASH4_DRIVER'),trans(LEFT));
	RETURN p;
		
	END;

END;