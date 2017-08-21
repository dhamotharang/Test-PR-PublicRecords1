export CodeTranslations := MODULE
	EXPORT STRING raceDescription(String raceCode) :=
		MAP(raceCode = 'W' => 'White', 
			raceCode = 'H' => 'Hispanic',
			raceCode = 'U' => '',			
			raceCode = 'B' => 'Black',
			raceCode = 'A' => 'Asian/Pacific Islander',
			raceCode = 'I' => 'American Indian/Native Alaskan',
			raceCode = 'XXX'=> 'Unknown',
			'');
			
/*	A  B  BH BL BLK F  H  I  L  N  O  U  W  WH WHI XXX */

	EXPORT STRING genderDescription(String genderCode) :=
		MAP(genderCode = 'M' => 'Male', 
			genderCode = 'F' => 'Female',
			'');
			
	EXPORT STRING genderCode(String genderDesc) := 
		MAP(stringlib.stringtouppercase(genderDesc) = 'MALE' => 'M',
			stringlib.stringtouppercase(genderDesc) = 'FEMALE' => 'F',
			stringlib.stringtouppercase(genderDesc) in ['F', 'M'] => 
																	stringlib.stringtouppercase(genderDesc),
			'');
	
	EXPORT STRING hairColorDescription(String hairColorCode) :=
		MAP(hairColorCode = 'BLK'=> 'Black', 
			hairColorCode = 'BLN'=> 'Blond or Strawberry',
			hairColorCode = 'BLU'=> 'Blue',
			hairColorCode = 'BRO'=> 'Brown',
			hairColorCode = 'GRY'=> 'Gray or Partially Gray',
			hairColorCode = 'GRN'=> 'Green',
			hairColorCode = 'ONG'=> 'Orange',
			hairColorCode = 'PNK'=> 'Pink',
			hairColorCode = 'PLE'=> 'Purple',
			hairColorCode = 'RED'=> 'Red or Aubun', 
			hairColorCode = 'SDY'=> 'Sandy',
			hairColorCode = 'BAL'=> 'Unknown or Completely Bald',
			hairColorCode = 'WHI'=> 'White',
			hairColorCode = 'XXX'=> 'Unknown',
			'');
			
/*			AUB  BAL  BEO  BL   BLD  BLK  BLN  BLO  BLU  BRN  BRO  DBR  GRAY GRN  
GRY  HAZ  HAZEL LBR  MUL  ONG  PLE  PNK  RED  SDY  U    UUU  WHI  WHT  XXX  */

	EXPORT STRING eyeColorDescription(String eyeColorCode) :=
		MAP(eyeColorCode = 'BLK' => 'Black',
			eyeColorCode = 'BRO' => 'Brown',
			eyeColorCode = 'GRN' => 'Green', 
			eyeColorCode = 'MAR' => 'Maroon', 
			eyeColorCode = 'PNK' => 'Pink',
			eyeColorCode = 'BLU' => 'Blue',
			eyeColorCode = 'GRY' => 'Gray',
			eyeColorCode = 'HAZ' => 'Hazel',
			eyeColorCode = 'MUL' => 'Multi-Colored',			
			'');
			
		/*AUB  BLK  BLN  BLU  BLUE BRN  BRO  BU   GRE  GRN  GRY  HAL  HAZ  HZL  MAR  
	MUL  OLV  PNK  RED  RN   SDY  XXX  */


END;