export FLCRASH5_PASSENGER :=
MODULE
     export VARSTRING FIRST_PASSENGER_SAFE(string code) := MAP(
			code='0'=>'',  
			code='1'=>'Not in Use',  
			code='2'=>'Seat Belt / Shoulder Harness',  
			code='3'=>'Child Restraint',  
			code='4'=>'Air Bag',  
			code='5'=>'Safety Helmet',  
			code='6'=>'Eye Protection',  
			'');

     export VARSTRING PASSENGER_EJECT_CODE(string code) := MAP(
			code='0'=>'',  
			code='1'=>'No',  
			code='2'=>'Yes',  
			code='3'=>'Partial',  
			'');

     export VARSTRING PASSENGER_INJURY_SEV(string code) := MAP(
			code='1'=>'None',  
			code='2'=>'Possible',  
			code='3'=>'Non-Incapacitating',  
			code='4'=>'Incapacitating',  
			code='5'=>'Fatal (Within 90 Days)',  
			code='6'=>'Non-Traffic Fatality',  
			'');

     export VARSTRING PASSENGER_LOCATION(string code) := MAP(
			code='0'=>'Unknown',  
			code='1'=>'Front Left',  
			code='2'=>'Front Center',  
			code='3'=>'Front Right',  
			code='4'=>'Rear Left',  
			code='5'=>'Rear Center',  
			code='6'=>'Rear Right',  
			code='7'=>'In Body of Truck',  
			code='8'=>'Bus Passenger',  
			code='9'=>'',  
			'');

     export VARSTRING SECOND_PASSENGER_SAFE(string code) := MAP(
			code='0'=>'',  
			code='1'=>'Not in Use',  
			code='2'=>'Seat Belt / Shoulder Harness',  
			code='3'=>'Child Restraint',  
			code='4'=>'Air Bag',  
			code='5'=>'Safety Helmet',  
			code='6'=>'Eye Protection',  
			'');

	export checkChanges :=
	FUNCTION
		
	codes.Layout_Codes_V3 trans(codes.File_Codes_V3_in le) :=
		TRANSFORM
			translation := 
				MAP(le.field_name = 'FIRST_PASSENGER_SAFE'	=>	FIRST_PASSENGER_SAFE(le.code),
				    le.field_name = 'PASSENGER_EJECT_CODE'	=>	PASSENGER_EJECT_CODE(le.code),
		              le.field_name = 'PASSENGER_INJURY_SEV'	=>	PASSENGER_INJURY_SEV(le.code),
				    le.field_name = 'PASSENGER_LOCATION'	=>	PASSENGER_LOCATION(le.code),
				    le.field_name = 'SECOND_PASSENGER_SAFE'	=>	SECOND_PASSENGER_SAFE(le.code),
                        '');
				  
			SELF.code := IF(le.long_desc=translation,SKIP,le.code);
			SELF := le;
		END;
	
	p := PROJECT(codes.File_Codes_V3_in(file_name='FLCRASH5_PASSENGER'),trans(LEFT));
	RETURN p;
		
	END;

END;