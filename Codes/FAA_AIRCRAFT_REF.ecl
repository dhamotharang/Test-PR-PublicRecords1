export FAA_AIRCRAFT_REF := 
MODULE

export VARSTRING  TYPE_ENGINE(string code) := map(
	code = '0' => 'None',
	code = '1' => 'Reciprocating',                                                                                                                                                                                                                                                                                                                             
	code = '2' => 'Turbo-prop',                                                                                                                                                                                                                                                                                                                                
	code = '3' => 'Turbo-shaft',                                                                                                                                                                                                                                                                                                                               
	code = '4' => 'Turbo jet',                                                                                                                                                                                                                                                                                                                                 
	code = '5' => 'Turbine air generator',                                                                                                                                                                                                                                                                                                                     
	code = '6' => 'Ramjet',                                                                                                                                                                                                                                                                                                                                    
	code = '9' => 'Unknown',                                                                                                                                                                                                                                                                                                                                   
	'');
	
export VARSTRING  TYPE_AIRCRAFT(string code) := map(
	code = '1' => 'Glider',                                                                                                                                                                                                                                                                                                                                    
	code = '2' => 'Balloon',                                                                                                                                                                                                                                                                                                                                   
	code = '3' => 'Blimp/Dirigible',                                                                                                                                                                                                                                                                                                                           
	code = '4' => 'Fixed wing single engine',                                                                                                                                                                                                                                                                                                                 
	code = '5' => 'Fixed wing multi engine',                                                                                                                                                                                                                                                                                                                   
	code = '6' => 'Rotorcraft',    
	'');

export VARSTRING  AIRCRAFT_CATEGORY_CODE(string code) := map(
	code = '1' => 'Land',                                                                                                                                                                                                                                                                                                                                      
	code = '2' => 'Sea',                                                                                                                                                                                                                                                                                                                                       
	code = '3' => 'Amphibian',  
	'');

export VARSTRING  AMATEUR_CERTIFICATION_CODE(string code) := map(
	code = '0' => 'Not Amateur',                                                                                                                                                                                                                                                                                                                               
	code = '1' => 'Amateur Certification',   
 	'');

export VARSTRING  AIRCRAFT_WEIGHT(string code) := map(
	code = 'CLASS 1' => 'Up to 12',                                                                                                                                                                                                                                                                                                                                  
	code = 'CLASS 2' => '12',                                                                                                                                                                                                                                                                                                                                        
	code = 'CLASS 3' => '20 ',   
	'');

	
export checkChanges := 
	FUNCTION
		
	codes.Layout_Codes_V3 trans(codes.File_Codes_V3_in le) :=
		TRANSFORM
			translation := MAP(
				le.field_name = 'TYPE_ENGINE'	=>	TYPE_ENGINE(le.code),
				le.field_name = 'TYPE_AIRCRAFT'	=>	TYPE_AIRCRAFT(le.code),
				le.field_name = 'AIRCRAFT_CATEGORY_CODE'	=>	AIRCRAFT_CATEGORY_CODE(le.code),
				le.field_name = 'AMATEUR_CERTIFICATION_CODE'	=>	AMATEUR_CERTIFICATION_CODE(le.code),
				le.field_name = 'AIRCRAFT_WEIGHT'	=>	AIRCRAFT_WEIGHT(le.code),
						'');
			
			SELF.code := IF(le.long_desc=translation,SKIP,le.code);
			SELF := le;
		END;
	
	p := PROJECT(codes.File_Codes_V3_in(file_name='FAA_AIRCRAFT_REF'),trans(LEFT));
	RETURN p;
		
	END;

END;