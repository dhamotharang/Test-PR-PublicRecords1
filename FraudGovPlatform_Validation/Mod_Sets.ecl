EXPORT Mod_Sets := Module

EXPORT threshld:=0.05;

EXPORT validDelimiter := '~|~';
EXPORT validTerminators := '~<EOL>~';

EXPORT validDelimiterDeltabase := '|\\t|';
EXPORT validTerminatorsDeltabase := '|\\n';

EXPORT IdentityData_numberOfColumns := 51;
EXPORT KnownFraud_numberOfColumns	:= 111;
EXPORT SafeList_numberOfColumns	:= 111;
EXPORT Deltabase_numberOfColumns	:=56;
EXPORT VelocityRules_numberOfColumns	:=15;

EXPORT CriticalFieldError_IdentityData	:= [
		 'field1'
		,'field2'
		,'field3'
		,'field4'
		,'field5'
	];
EXPORT CriticalFieldError_KnownFraud	:= [
		 'field1'
		,'field2'
		,'field3'
		,'field4'
	];	

EXPORT CriticalFieldError_Deltabase	:= [
		 'field1'
		,'field2'
		,'field3'
	];			

EXPORT CriticalFieldError_SafeList := [
		 'field1'
		,'field2'
		,'field3'
		,'field4'
	];			
EXPORT Agency_Vertical_Type 
		:= 
			[
			// Verticals
			'T'		// Tax
			,'H'	// Health
			,'S'	// Social Services
			,'L'	// Labor
			];		

EXPORT IES_Benefit_Type
		:=
			[
			// IES Programs
			'D'				// DSNAP
			,'S'			// SNAP
			,'T'			// TANF
			,'M'			// Medicaid
			,'P'			// CHIP
			,'C'			// Child Care
			,'I'			// Woman, Infant, Children
			,'N'			// Child Nutrition
			,'U'			// Unemployment
			];
			
EXPORT Benefit_Type :=
			IES_Benefit_Type +
			[
			// HHS Programs
			'H'				// Public Housing
			,'U'			// Unemployment Insurance
			,'W'			// Workers Compensation
			,'V'			// Drivers License
			]
			;

EXPORT Gender
		:=
			[
			'F'
			,'M'
			,'U'
			]
			;

EXPORT Race
		:=
			[
			'A'				// Asian
			,'B'			// Black
			,'H'			// Hispanic/Latino
			,'I'			// North American Indian/Native American
			,'O'			// Other
			,'P'			// Pacific Islander/Native Hawaiian
			,'U'			// Unknown
			,'W'			// White
			]
			;

EXPORT Ethnicity
		:=
			[
			'H'					// Hispanic
			,'N'				// non-hispanic
			,'U'				// unknown
			]
			;

			
EXPORT Relationship_Type :=
	[
		'H',		// Head of Household
		'P',		// Parent
		'M',		// Mother
		'F',		// Father
		'G',		// Guardian
		'T',		// Grandparent
		'A',		// Aunt
		'U',		// Uncle
		'C',		// Cousin
		'D', 		// Child
		'O'			// Other (etc versus Y/N)			
	];
	
EXPORT Address_Type
		:=
			[
			'HOME'
			,'APARTMENT'
			,'CONDO'
			,'BUSINESS'
			]
			;



EXPORT Exception_Reasons
		:=
			[
			'A'			// Confirmed Multiple birth sibling
			,'B'		// LexID Overlinking
];

EXPORT	States
		:=
			[
			 'AK' 
			 ,'AL' 
			 ,'AR' 
			 ,'AZ' 
			 ,'CA' 
			 ,'CO' 
			 ,'CT' 
			 ,'DC' 
			 ,'DE' 
			 ,'FL' 
			 ,'GA'
			 ,'GU'
			 ,'HI' 
			 ,'IA' 
			 ,'ID' 
			 ,'IL' 
			 ,'IN' 
			 ,'KS' 
			 ,'KY' 
			 ,'LA' 
			 ,'MA' 
			 ,'MD' 
			 ,'ME' 
			 ,'MI' 
			 ,'MN' 
			 ,'MO' 
			 ,'MS' 
			 ,'MT' 
			 ,'NC' 
			 ,'ND' 
			 ,'NE' 
			 ,'NH' 
			 ,'NJ' 
			 ,'NM' 
			 ,'NV' 
			 ,'NY' 
			 ,'OH' 
			 ,'OK' 
			 ,'OR' 
			 ,'PA'
			 ,'PR'
			 ,'RI' 
			 ,'SC' 
			 ,'SD' 
			 ,'TN' 
			 ,'TX' 
			 ,'UT' 
			 ,'VA'
			 ,'VI'
			 ,'VT' 
			 ,'WA' 
			 ,'WI' 
			 ,'WV' 
			 ,'WY' 
			]
	;

EXPORT RegexBadAddress
		:=
			 '(.*)('
			+'.SAME.'
			+'|.GENERAL.DELIVERY.'
			+'|.GENERALDELIVERY.'
			+'|.HOMELESS.'
			+'|DONALD.LEE.HOLLOWELL'
			+')(.*)';

EXPORT SetBadAddress
    :=
			[
			'SAME'
			,'GENERAL DELIVERY'
			,'GENERALDELIVERY'
			,'HOMELESS'
			,'DONALD LEE HOLLOWELL'
			]
	;

END;