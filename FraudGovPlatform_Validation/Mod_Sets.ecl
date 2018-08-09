EXPORT Mod_Sets := Module

EXPORT threshld:=0.05;

EXPORT validDelimiter := '~|~';
EXPORT validTerminators := '~<EOL>~';

EXPORT validDelimiterDeltabase := '|\t|';
EXPORT validTerminatorsDeltabase := '|\n';

EXPORT IdentityData_numberOfColumns := 58;
EXPORT KnownFraud_numberOfColumns	:= 117;
EXPORT Deltabase_numberOfColumns	:=50;
EXPORT VelocityRules_numberOfColumns	:=15;

EXPORT CriticalFieldError_IdentityData	:= [
															'Customer_Name'
															,'Customer_Account_Number'
															,'Customer_State'
															,'Customer_County'
															,'Customer_Agency'
															,'Customer_Agency_Vertical_Type'
															,'Customer_Program'
															,'Customer_Job_ID'
															,'Batch_Record_ID'
															,'Reason_for_Transaction_Activity'
															,'Date_of_Transaction'
															,'First_name'
															,'Last_Name'
														];
EXPORT CriticalFieldError_KnownFraud	:= [
															'Customer_Name'
															,'Customer_Account_Number'
															,'Customer_Job_ID'
															,'Customer_State'														
															,'Customer_County'
															,'Customer_Agency'
															,'Customer_Agency_Vertical_Type'
															,'Customer_Job_ID'
															,'customer_event_id'
															,'reported_date'
															,'reported_time'
															,'reported_by'
														];	
														
EXPORT CriticalFieldError_Deltabase	:= [
															'Customer_Account_Number'
															,'Customer_program'								
															,'Customer_County'
															,'Customer_State'											
															,'Customer_Agency_Vertical_Type'
															,'reported_date'
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