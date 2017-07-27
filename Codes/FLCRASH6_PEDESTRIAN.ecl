export FLCRASH6_PEDESTRIAN :=
MODULE
     export VARSTRING PD_RESIDENCE(string code) := MAP(
			code='0'=>'',  
			code='1'=>'County of Crash',  
			code='2'=>'Elsewhere in State',  
			code='3'=>'Non-Resident of State',  
			code='4'=>'Foreign',  
			code='5'=>'Unknown',  
               '');

     export VARSTRING PED_ACTION(string code) := MAP(
			code='01'=>'Crossing Not At Intersection',  
			code='02'=>'Crossing at Mid-block Crosswalk',  
			code='03'=>'Crossing At Intersection',  
			code='04'=>'Walking Along Road With Traffic',  
			code='05'=>'Walking Along Road Against Traffic',  
			code='06'=>'Working on Vehicle in Road',  
			code='07'=>'Other Working in Road',  
			code='08'=>'Standing / Playing in Road',  
			code='09'=>'Standing in Pedestrian Island',  
			code='77'=>'',  
			code='88'=>'',  
               '');

     export VARSTRING PED_ALCO_DRUGS(string code) := MAP(
			code='0'=>'',  
			code='1'=>'Not Drinking or Using Drugs',  
			code='2'=>'Alcohol - Under Influence',  
			code='3'=>'Drugs - Under Influence',  
			code='4'=>'Alcohol & Drugs - Under Influence',  
			code='5'=>'Had Been Drinking',  
			code='6'=>'Pending BAC Test Result',  
               '');

     export VARSTRING PED_BAC_TEST_TYPE(string code) := MAP(
			code='1'=>'Blood',  
			code='2'=>'Breath',  
			code='3'=>'Urine',  
			code='4'=>'Refused',  
			code='5'=>'None',  
               '');

     export VARSTRING PED_FIRST_CONTRIB_CAUSE(string code) := MAP(
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

     export VARSTRING PED_INJURY_SEV(string code) := MAP(
			code='1'=>'None',  
			code='2'=>'Possible',  
			code='3'=>'Non-Incapacitating',  
			code='4'=>'Incapacitating',  
			code='5'=>'Fatal (Within 90 Days)',  
			code='6'=>'Non-Traffic Fatality',  
               '');

     export VARSTRING PED_PHYSICAL_DEFECT(string code) := MAP(
			code='0'=>'',  
			code='1'=>'No Defects Known',  
			code='2'=>'Eyesight Defect',  
			code='3'=>'Fatigue / Asleep',  
			code='4'=>'Hearing Defect',  
			code='5'=>'Illness',  
			code='6'=>'Seizure',  
			code='7'=>'Other Physical Defect',  
               '');

     export VARSTRING PED_RACE(string code) := MAP(
			code='1'=>'White',  
			code='2'=>'Black',  
			code='3'=>'Hispanic',  
			code='4'=>'Other',  
               '');

     export VARSTRING PED_SECOND_CONTRIB_CAUSE(string code) := MAP(
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

     export VARSTRING PED_SEX(string code) := MAP(
			code='1'=>'Male',  
			code='2'=>'Female',  
               '');

     export VARSTRING PED_THIRD_CONTRIB_CAUSE(string code) := MAP(
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
				MAP(le.field_name = 'PD_RESIDENCE'	=>	PD_RESIDENCE(le.code),
				    le.field_name = 'PED_ACTION'	=>	PED_ACTION(le.code),
				    le.field_name = 'PED_ALCO_DRUGS'	=>	PED_ALCO_DRUGS(le.code),
				    le.field_name = 'PED_BAC_TEST_TYPE'	=>	PED_BAC_TEST_TYPE(le.code),
			         le.field_name = 'PED_FIRST_CONTRIB_CAUSE'	=>	PED_FIRST_CONTRIB_CAUSE(le.code),
				    le.field_name = 'PED_INJURY_SEV'	=>	PED_INJURY_SEV(le.code),
				    le.field_name = 'PED_PHYSICAL_DEFECT'	=>	PED_PHYSICAL_DEFECT(le.code),
				    le.field_name = 'PED_RACE'	=>	PED_RACE(le.code),
                        le.field_name = 'PED_SECOND_CONTRIB_CAUSE'	=>	PED_SECOND_CONTRIB_CAUSE(le.code),
				    le.field_name = 'PED_SEX'	=>	PED_SEX(le.code),
				    le.field_name = 'PED_THIRD_CONTRIB_CAUSE'	=>	PED_THIRD_CONTRIB_CAUSE(le.code),
                        '');
				  
			SELF.code := IF(le.long_desc=translation,SKIP,le.code);
			SELF := le;
		END;
	
	p := PROJECT(codes.File_Codes_V3_in(file_name='FLCRASH6_PEDESTRIAN'),trans(LEFT));
	RETURN p;
		
	END;

END;