import ut;
EXPORT Mod_Sets := Module

EXPORT threshld:=0.05;

EXPORT Consortium
		:=
			[
			'AL'
			,'FL'
			,'GA'
			,'LA'
			,'MS'
			,'MO'
			]
			;

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
			];
			
EXPORT Benefit_Type :=
			IES_Benefit_Type +
			[
			// HHS Programs
			'H'			// Public Housing
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
			,'N'			// Negro
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

EXPORT SSN_Type
		:=
			[
			'A'					// Actual
			,'P'				// Pseudo
			,'D'				// Default
			]
			;

EXPORT Actual_Type := 'A';
EXPORT Pseudo_Type := 'P';
EXPORT Default_Type := 'D';

EXPORT DOB_Type
		:=
			[
			'A'
			,'P'
			,'D'
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
	
EXPORT ABAWD_Type
		:= ['Y', 'N', 'U']; // YES NO UNAVAILABLE

	
EXPORT Address_Type
		:=
			[
			'P',		//Physical
			'M',		//Mailing
			'B' 		//Both
			]
			;
EXPORT Address_Category
		:=
			[
			'O'			//Other(Rehab, shelter, etc.)
			,'T'		// Temporary
			,'H'		// Homeless
			,'U'		//Unknown (reserved for future use)
			]
			;
EXPORT Eligible_Status
		:=
			[
			'D'			// Disqualified
			,'E'		// Eligible
			,'I'		// Ineligible Alien
			,'N'		// Not Eligible
			,'A'		// Applicant
			]
			;

EXPORT Period_Type
		:=
			[
			'D'			// Date
			,'M'		// Month
];

EXPORT Exception_Reasons
		:=
			[
			'A'			// Confirmed Multiple birth sibling
			,'B'		// LexID Overlinking
];

EXPORT	States := ut.Set_State_Abbrev;

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