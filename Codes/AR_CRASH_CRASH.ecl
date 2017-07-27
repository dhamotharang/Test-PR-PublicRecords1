export AR_CRASH_CRASH :=
MODULE

	export VARSTRING ATINTERSECTINGSTREET(string code) := MAP(	code='1' => 'Yes',
									code='2' => 'No',
									code='9' => 'Unknown','');

	export VARSTRING ATMOSPHERECONDITIONS(string code)  := MAP(	code='0' => 'Clear',
									code='1' => 'Rain',
									code='2' => 'Sleet',
									code='3' => 'Snow',
									code='4' => 'Fog',
									code='5' => 'High Winds',
									code='6' => 'Smoke',
									code='7' => 'Smog',
									code='8' => 'Dust',
									code='9' => 'Mist',
									code='98' => 'Other',
									code='99' => 'Unknown','');
									
	export VARSTRING CONSTRUCTIONZONE(string code) := MAP(		code='1' => 'Yes',
									code='2' => 'No',
									code='9' => 'Unknown','');
									
	export VARSTRING CRASHSEVERITY(string code) := MAP(			code='1' => 'Fatality',
									code='2' => 'Incapacitating Injury',
									code='3' => 'Non-Incapacitating Injury',
									code='4' => 'Possible Injury',
									code='5' => 'Property Damage Only','');
									
	export VARSTRING FIREOCCURED(string code) := MAP(			code='0' => 'No',
									code='1' => 'Yes','');
									
	export VARSTRING FIRSTHARMFULEVENTOCCURED(string code)  := MAP(code='1' => 'On Roadway',
									code='2' => 'Shoulder',
									code='3' => 'Median',
									code='4' => 'Roadside',
									code='5' => 'Outside Trafficway',
									code='8' => 'Other',
									code='9' => 'Unknown','');
	
	export VARSTRING HITRUNCRASH(string code)  := MAP(			code='1' => 'Yes',
									code='2' => 'No',
									code='9' => 'Unknown','');
	
	export VARSTRING INCITY(string code)   := MAP(				code='1' => 'Yes',
									code='2' => 'No','');
	
	export VARSTRING INTERSECTIONTYPE(string code)  := MAP(		code='0' => 'None',
									code='1' => 'Full Crossing',
									code='2' => 'T-INtersection',
									code='3' => 'Y-Intersection',
									code='4' => 'Traffic Circle (Rotary)',
									code='5' => 'Five-Point or More',
									code='6' => 'On Ramp',
									code='7' => 'Off Ramp',
									code='98' => 'Other',
									code='99' => 'Unknown','');
	
	export VARSTRING INVESTIGATINGAGENCY(string code)  := MAP(	code='1' => 'City Police',
									code='2' => 'Arkansas State Police',
									code='3' => 'County Sherrif',
									code='4' => 'Marshall',
									code='5' => 'Campus Security','');
	
	export VARSTRING LIGHTCONDITIONS(string code)  := MAP(		code='1' => 'Daylight',
									code='2' => 'Dark',
									code='3' => 'Dawn',
									code='4' => 'Dusk',
									code='5' => 'Dark But Lighted',
									code='6' => 'Dark',
									code='99' => 'Unknown','');
	
	export VARSTRING RELATIONTOJUNCTION(string code)   := MAP(	code='0' => 'Non-Junction',
									code='1' => 'Intersection',
									code='2' => 'Intersection Related',
									code='3' => 'Driveway',
									code='4' => 'Alley',
									code='5' => 'Exit Lane',
									code='6' => 'Entrance Lane',
									code='7' => 'Railroad Crossing',
									code='8' => 'Crossover Lane',
									code='98' => 'Other',
									code='99' => 'Unknown','');
	
	export VARSTRING ROADSURFACECONDITION(string code)   := MAP(	code='1' => 'Dry',
									code='2' => 'Wet',
									code='3' => 'Ice',
									code='4' => 'Sand',
									code='5' => 'Dirt',
									code='6' => 'Oil',
									code='98' => 'Other',
									code='99' => 'Unknown','');
	
	export VARSTRING ROADSURFACETYPE(string code)   := MAP(		code='1' => 'Concrete',
									code='2' => 'Asphalt',
									code='3' => 'Gravel',
									code='4' => 'Dirt',
									code='98' => 'Other',
									code='99' => 'Unknown','');
	
	export VARSTRING ROADSYSTEM(string code)   := MAP(			code='1' => 'Interstate',
									code='2' => 'U.S. Highway',
									code='3' => 'State Highway',
									code='4' => 'Country Road',
									code='5' => 'City Street',
									code='6' => 'Frontage Road',
									code='7' => 'Ramp',
									code='98' => 'Other',
									code='99' => 'Unknown','');
	
	export VARSTRING ROADWAYALIGNMENT(string code)   := MAP(		code='1' => 'Straight',
									code='2' => 'Curve',
									code='3' => 'Unknown','');
	
	export VARSTRING ROADWAYPROFILE(string code)   := MAP(     	code='3' => 'Level',
									code='4' => 'Grade',
									code='5' => 'Hill Crest',
									code='6' => 'Sag',
									code='99' => 'Unknown','');                              

	export VARSTRING RURALURBAN(string code)   := MAP(  			code='1' => 'Rural',
									code='2' => 'Urban',
									code='99' => 'Unknown','');                                     
	
	export VARSTRING TRAFFICFLOW(string code)   := MAP(     		code='1' => 'Divided',
									code='2' => 'Not Divided',
									code='3' => 'Divided By Median',
									code='4' => 'Divided By Other Barrier',
									code='5' => 'Divided/Temporary Barrier',
									code='6' => 'One Way Traffic',
									code='99' => 'Unknown','');                                 
	
	export VARSTRING TYPEOFCOLLISION(string code)   := MAP(    	code='1' => 'Single Vehicle Crash',
									code='16' => 'Rear End',
									code='17' => 'Right Angle',
									code='18' => 'Sideswipe/Same Dir',
									code='19' => 'Sideswipe/Opp dir',
									code='24' => 'Backing',
									code='9' => 'Head On',
									code='98' => 'Other',
									code='99' => 'Unknown','');                              
	
	export VARSTRING TYPEOFTRAFFICCONTROL(string code)    := MAP(  code='0' => 'No Traffic Control',
									code='1' => 'Flashing Beacon',
									code='10' => 'Lane Markings',
									code='11' => 'Other Controls',
									code='12' => 'Unknown',
									code='13' => 'Traffic Lanes Marked',
									code='14' => 'Not Passing Sign',
									code='15' => 'Slow or Warning Sign',
									code='16' => 'Officer/Flagman',
									code='2' => 'Traffic Signal',
									code='4' => 'Yield Sign',
									code='5' => 'R R - Gate & Signal',
									code='6' => 'R R - Signal Only',
									code='7' => 'R R - Crossbuck Only',
									code='8' => 'School Zone',
									code='9' => 'Pedestrian Signal','');                      

	export checkChanges := 
	FUNCTION
		
	codes.Layout_Codes_V3 trans(codes.File_Codes_V3_in le) :=
		TRANSFORM
			translation := 
				MAP(le.field_name = 'ATINTERSECTINGSTREET'	=>	ATINTERSECTINGSTREET(le.code),
				    le.field_name = 'ATMOSPHERECONDITIONS'	=>	ATMOSPHERECONDITIONS(le.code),
				    le.field_name = 'CONSTRUCTIONZONE'		=>	CONSTRUCTIONZONE(le.code),
				    le.field_name = 'CRASHSEVERITY'		=>	CRASHSEVERITY(le.code),
				    le.field_name = 'FIREOCCURED'			=>	FIREOCCURED(le.code),
				    le.field_name = 'FIRSTHARMFULEVENTOCCURED'		=>	FIRSTHARMFULEVENTOCCURED(le.code),
				    le.field_name = 'HITRUNCRASH'			=>	HITRUNCRASH(le.code),
				    le.field_name = 'INCITY'				=>	INCITY(le.code),
				    le.field_name = 'INTERSECTION TYPE'		=>	INTERSECTIONTYPE(le.code),
				    le.field_name = 'INVESTIGATING AGENCY'	=>	INVESTIGATINGAGENCY(le.code),
				    le.field_name = 'LIGHTCONDITIONS'		=>	LIGHTCONDITIONS(le.code),
				    le.field_name = 'RELATIONTOJUNCTION'	=>	RELATIONTOJUNCTION(le.code),
				    le.field_name = 'ROADSURFACECONDITION'	=>	ROADSURFACECONDITION(le.code),
				    le.field_name = 'ROADSURFACETYPE'		=>	ROADSURFACETYPE(le.code),
				    le.field_name = 'ROADSYSTEM'			=>	ROADSYSTEM(le.code),
				    le.field_name = 'ROADWAYALIGNMENT'		=>	ROADWAYALIGNMENT(le.code),
				    le.field_name = 'ROADWAYPROFILE'		=>	ROADWAYPROFILE(le.code),
				    le.field_name = 'RURALURBAN'			=>	RURALURBAN(le.code),
				    le.field_name = 'TRAFFICFLOW'			=>	TRAFFICFLOW(le.code),
				    le.field_name = 'TYPEOFCOLLISION'		=>	TYPEOFCOLLISION(le.code),
				    le.field_name = 'TYPEOFTRAFFICCONTROL'	=>	TYPEOFTRAFFICCONTROL(le.code),'');
			
			SELF.code := IF(le.long_desc=translation,SKIP,le.code);
			SELF := le;
		END;
	
	p := PROJECT(codes.File_Codes_V3_in(file_name='AR_CRASH_CRASH'),trans(LEFT));
	RETURN p;
		
	END;

END;
