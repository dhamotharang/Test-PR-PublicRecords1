
import std;

EXPORT get_decr := MODULE 

//33	Time Zone	1	Hawaii=2, Alaska=3, Pacific=4, Mountain=5, Central=6, Eastern=7, Atlantic=8
	EXPORT TimeZone(STRING1 TimeZone) := FUNCTION
		RETURN CASE (STD.Str.ToUpperCase(STD.Str.CleanSpaces(TimeZone)), 
										'2'  =>	'HAWAII',
										'3' =>	'ALASKA',
										'4' =>	'PACIFIC',
										'5' =>	'MOUNTAIN',
										'6' =>	'CENTRAL',
										'7' =>	'EASTERN',
										'8' =>	'ATLANTIC',
										'');
	END;


	
// 44	Homeowner/Renter	1	H = Homeowner	R = Renter
	EXPORT Homeowner_Renter(STRING1 Homeowner_Renter) := FUNCTION
	  RETURN CASE (STD.Str.ToUpperCase(STD.Str.CleanSpaces(Homeowner_Renter)), 
										'H'  =>	'Homeowner',
										'R'  =>	'Renter', 
										 '');
	END;	


// 49	Estimated Income	1	A = Less than $20,000
			// B = $20,000 - $29,999
			// C = $30,000 - $39,999
			// D = $40,000 - $49,999
			// E = $50,000 - $74,999
			// F = $75,000 - $99,999
			// G = $100,000 - $124,999
			// H = $125,000 or More
	EXPORT EstimatedIncome(STRING1 EstimatedIncome) := FUNCTION
	  RETURN CASE (STD.Str.ToUpperCase(STD.Str.CleanSpaces(EstimatedIncome)), 
										'A'  =>	'Less than $20,000',
										'B'  =>	'$20,000 - $29,999', 
										'C'  =>	'$30,000 - $39,999',
										'D'  =>	'$40,000 - $49,999',
										'E'  =>	'$50,000 - $74,999',
										'F'  =>	'$75,000 - $99,999',
										'G'  =>	'$100,000 - $124,999',
										'H'  =>	'$125,000 or More',
										'');
	END;		
	
	
// 50	Marital Status	1	M= Married
			// S= Single
			// A = Inferred Married
			// B = Inferred Single	
	EXPORT MaritalStatus(STRING1 MaritalStatus) := FUNCTION
	  RETURN CASE (STD.Str.ToUpperCase(STD.Str.CleanSpaces(MaritalStatus)), 
										'M'  =>	'Married',
										'S'  =>	'Single', 
										'A'  =>	'Inferred Married',
										'B'  =>	'Inferred Single',
										'');
	END;			
	
	// 54	Wealth Score - Estimated Net worth	1	Model based on income, homeownership, other assets owned 
			// A - Estimated Net less than $5000
			// B - Estimated Net $5K - $19k
			// C - Estimated Net $20k-$49k
			// D - Estimated Net $50k-$80k
			// E - Estimated Net  $81k-$99k
			// F - Estimated Net $100k-$249k
			// G - Estimated Net $250k - $499K
			// H - Estimated Net -over $500k
	EXPORT WealthScore(STRING1 WealthScore) := FUNCTION
	  RETURN CASE (STD.Str.ToUpperCase(STD.Str.CleanSpaces(WealthScore)), 
										'A'  =>	'Estimated Net less than $5000',
										'B'  =>	'Estimated Net $5K - $19k',
										'C'  =>	'Estimated Net $20k-$49k',
										'D'  =>	'Estimated Net $50k-$80k',
										'E'  =>	'Estimated Net  $81k-$99k',
										'F'  =>	'Estimated Net $100k-$249k',
										'G'  =>	'Estimated Net $250k - $499K',
										'H'  =>	'Estimated Net -over $500k',
										'');
	END;	
	
//56	Dwelling Type	1	S - SFDU; "M" - MFDU
		EXPORT DwellingType(STRING1 DwellingType) := FUNCTION
	  RETURN CASE (STD.Str.ToUpperCase(STD.Str.CleanSpaces(DwellingType)), 
										'S'  =>	'SFDU',
										'M'  =>	'MFDU',
										'');
	END;			
			

// 57	Home Market Value	1	Estimated market value - model based information
			// A = $1,000 - $24,999
			// B = $25,000 - $49,999
			// C = $50,000 - $74,999
			// D = $75,000 - $99,999
			// E = $100,000 - $124,999
			// F = $125,000 - $149,999
			// G = $150,000 - $174,999
			// H = $175,000 - $199,999
			// I = $200,000 - $224,999
			// J = $225,000 - $249,999
			// K = $250,000 - $274,999
			// L = $275,000 - $299,999
			// M = $300,000 - $349,999
			// N = $350,000 - $399,999
			// O = $400,000 - $449,999
			// P = $450,000 - $499,999
			// Q = $500,000 - $749,999
			// R = $750,000 - $999,999
			// S = $1,000,000 Plus

	EXPORT HomeMarketValue(STRING1 HomeMarketValue) := FUNCTION
	  RETURN CASE (STD.Str.ToUpperCase(STD.Str.CleanSpaces(HomeMarketValue)), 
									'A'  =>	'$1,000 - $24,999',
									'B'  =>	'$25,000 - $49,999',
									'C'  =>	'$50,000 - $74,999',
									'D'  =>	'$75,000 - $99,999',
									'E'  =>	'$100,000 - $124,999',
									'F'  =>	'$125,000 - $149,999',
									'G'  =>	'$150,000 - $174,999',
									'H'  =>	'$175,000 - $199,999',
									'I'  =>	'$200,000 - $224,999',
									'J'  =>	'$225,000 - $249,999',
									'K'  =>	'$250,000 - $274,999',
									'L'  =>	'$275,000 - $299,999',
									'M'  =>	'$300,000 - $349,999',
									'N'  =>	'$350,000 - $399,999',
									'O'  =>	'$400,000 - $449,999',
									'P'  =>	'$450,000 - $499,999',
									'Q'  =>	'$500,000 - $749,999',
									'R'  =>	'$750,000 - $999,999',
									'S'  =>	'$1,000,000 Plus',	
									'');
	END;			
	
	
// 58	Education 	1	A= Completed High School
			// B= Completed College
			// C= Completed Graduate School
			// D= Attended Vocational/Technical
	EXPORT Education(STRING1 Education) := FUNCTION
	  RETURN CASE (STD.Str.ToUpperCase(STD.Str.CleanSpaces(Education)), 
									'A'  =>	'Completed High School',
									'B'  =>	'Completed College',
									'C'  =>	'Completed Graduate School',
									'D'  =>	'Attended Vocational/Technical',
									'');
	END;			
	
	
// 59	ETHNICITY	1	Hispanic = Ethnic code Y
			// African American = Ethnic code F
			// Asian = Ethnic code A
	EXPORT ETHNICITY(STRING1 ETHNICITY) := FUNCTION
	  RETURN CASE (STD.Str.ToUpperCase(STD.Str.CleanSpaces(ETHNICITY)), 
									'Y'  =>	'Hispanic',
									'F'  =>	'African American',
									'A'  =>	'Asian',
									'');
	END;		
	
	// 61	Child Age Ranges	1	A = Presence of Children under 6
			// B = Presence of Children aged 6 - 10
			// C = presence of Children Age 11 - 15
			// D = Presence of Children Age 16-17
	EXPORT ChildAgeRanges(STRING1 ChildAgeRanges) := FUNCTION
	  RETURN CASE (STD.Str.ToUpperCase(STD.Str.CleanSpaces(ChildAgeRanges)), 
								'A'  =>	'Presence of Children under 6',
								'B'  =>	'Presence of Children aged 6 - 10',
								'C'  =>	'presence of Children Age 11 - 15',
								'D'  =>	'Presence of Children Age 16-17',   
									'');
	END;	
	
	// 62	Number of Children in HH	1	A = no children
			// B = less than 3
			// C = 3 - 5
	EXPORT NumberOfChildrenInHH(STRING1 NumberOfChildrenInHH) := FUNCTION
	  RETURN CASE (STD.Str.ToUpperCase(STD.Str.CleanSpaces(NumberOfChildrenInHH)), 
									'A'  =>	'no children',
									'B'  =>	'less than 3',
									'C'  =>	'3 to 5',  
									'');
	END;	
	
	// 67	Women's Apparel Purchasing Indicator	1	A = Purchased Women's Apparel
			// B = Purchased Plus size Women's Apparel
	EXPORT WomensApparelPurchasingIndicator(STRING1 WomensApparelPurchasingIndicator) := FUNCTION
	  RETURN CASE (STD.Str.ToUpperCase(STD.Str.CleanSpaces(WomensApparelPurchasingIndicator)), 
									'A'  =>	'Purchased Women\'s Apparel',
									'B'  =>	'Purchased Plus size Women\'s Apparel',
									'');
	END;	
	
	// 68	Men's Apparel Purchasing Indcator	1	A = Purchased Men's Apparel
			// B = Purchased Big and Tall Men's Apparel
	EXPORT MensApparelPurchasingIndcator(STRING1 MensApparelPurchasingIndcator) := FUNCTION
	  RETURN CASE (STD.Str.ToUpperCase(STD.Str.CleanSpaces(MensApparelPurchasingIndcator)), 
									'A'  =>	'Purchased Men\'s Apparel',
									'B'  =>	'Purchased Big and Tall Men\'s Apparel',
									'');
	END;	
	

	// 70	Pet Lover's or owners	1	A = has Pets
			// B= Equestrian
			// C= Cat owner
			// D= Dog owner
	EXPORT PetLoversOrOwners(STRING1 PetLoversOrOwners) := FUNCTION
	  RETURN CASE (STD.Str.ToUpperCase(STD.Str.CleanSpaces(PetLoversOrOwners)), 
											'A'  =>	'has Pets',
											'B'  =>	'Equestrian',
											'C'  =>	'Cat owner',
											'D'  =>	'Dog owner',
									     '');
	END;	
	

	// 74	Arts Bundle	1	A = Interest in Arts
			// B = Avid Music Listener
			// C = Interest in Antiques
			// D = Interest in Performing Arts

	EXPORT ArtsBundle(STRING1 ArtsBundle) := FUNCTION
	  RETURN CASE (STD.Str.ToUpperCase(STD.Str.CleanSpaces(ArtsBundle)), 
									'A'  =>	'Interest in Arts',
									'B'  =>	'Avid Music Listener',
									'C'  =>	'Interest in Antiques',
									'D'  =>	'Interest in Performing Arts',
									'');
	END;	
	
	
	// 75	Collectibles Bundle	1	A = General Interest in Collectibles
			// B = Interest in Antique Collectibles
			// C = Interest in Sports Collectibles
	EXPORT CollectiblesBundle(STRING1 CollectiblesBundle) := FUNCTION
	  RETURN CASE (STD.Str.ToUpperCase(STD.Str.CleanSpaces(CollectiblesBundle)), 
									'A'  =>	'General Interest in Collectibles',
									'B'  =>	'Interest in Antique Collectibles',
									'C'  =>	'Interest in Sports Collectibles',
									'');
	END;	
	
	// 76	Hobbies, Home and Garden Bundle	1	A = Interest in Sewing and Knitting
			// B = Interest in Woodworking
			// C = Interest in Photography
			// D = Home and Garden
	EXPORT HobbiesHomeAndGardenBundle(STRING1 HobbiesHomeAndGardenBundle) := FUNCTION
	  RETURN CASE (STD.Str.ToUpperCase(STD.Str.CleanSpaces(HobbiesHomeAndGardenBundle)), 
											'A'  =>	'Interest in Sewing and Knitting',
											'B'  =>	'Interest in Woodworking',
											'C'  =>	'Interest in Photography',
											'D'  =>	'Home and Garden',
									    '');
	END;	
	
	// 77	Home Improvement	1	A – Home Improvement Interest
			// B – Home Improvement DIY
	EXPORT HomeImprovement(STRING1 HomeImprovement) := FUNCTION
	  RETURN CASE (STD.Str.ToUpperCase(STD.Str.CleanSpaces(HomeImprovement)), 
											'A'  =>	'Home Improvement Interest',
											'B'  =>	'Home Improvement DIY',
									    '');
	END;	
	
// 78	Cooking and Wine	1	A = Gourmet Food and Wine
			// B = Cooking
			// C = Natural Foods
	EXPORT CookingAndWine(STRING1 CookingAndWine) := FUNCTION
	  RETURN CASE (STD.Str.ToUpperCase(STD.Str.CleanSpaces(CookingAndWine)), 
											'A'  =>	'Gourmet Food and Wine',
											'B'  =>	'Cooking',
											'C'  =>	'Natural Foods',
									    '');
	END;	

// 80	Travel Enthusiasts	1	A = Travel
			// B = Domestic
			// C = International
			// D = Cruise
	EXPORT TravelEnthusiasts(STRING1 TravelEnthusiasts) := FUNCTION
	  RETURN CASE (STD.Str.ToUpperCase(STD.Str.CleanSpaces(TravelEnthusiasts)), 
											'A'  =>	'Travel',
											'B'  =>	'Domestic',
											'C'  =>	'International',
											'D'  =>	'Cruise',
									    '');
	END;	


// 81	Physical Fitness 	1	A = Interest in Health Exercise
			// B = Running
			// C = Walking
			// D = Aerobics
	EXPORT PhysicalFitness(STRING1 PhysicalFitness) := FUNCTION
	  RETURN CASE (STD.Str.ToUpperCase(STD.Str.CleanSpaces(PhysicalFitness)), 
											'A' => 'Interest in Health Exercise',
											'B' => 'Running',
											'C' => 'Walking',
											'D' => 'Aerobics',
									    '');
	END;	


// 82	Self Improvement	1	Health, medical, dieting weight loss, self-improvement
			// A- Health & Medical
			// B- Dieting Weight loss
			// C- Self Improvement
	EXPORT SelfImprovement(STRING1 SelfImprovement) := FUNCTION
	  RETURN CASE (STD.Str.ToUpperCase(STD.Str.CleanSpaces(SelfImprovement)), 
											'A' => 'Health & Medical',
											'B' => 'Dieting Weight loss',
											'C' => 'Self Improvement',
									    '');
	END;	
	
	
// 84	Spectator Sports Interest 	1	A = Interst in Sports, General
			// B = Interest in Footbal
			// C - Interest in Baseball
			// D = Interest in Golf
			// E = Interest in Tennis
			// F - Interest in Auto and Motorcycle racing	
	
	EXPORT SpectatorSportsInterest(STRING1 SpectatorSportsInterest) := FUNCTION
	  RETURN CASE (STD.Str.ToUpperCase(STD.Str.CleanSpaces(SpectatorSportsInterest)), 
											'A' => 'Interst in Sports, General',
											'B' => 'Interest in Footbal',
											'C' => 'Interest in Baseball',
											'D' => 'Interest in Golf',
											'E' => 'Interest in Tennis',
											'F' => 'Interest in Auto and Motorcycle racing',
									    '');
	END;
	

// 85	Outdoors	1	A = Interest in Outdoor  - General
			// B = Interest in Snow Sports
			// C = interest in Water Sports
			// D = Interst in Hunting and Fishing
	EXPORT Outdoors(STRING1 Outdoors) := FUNCTION
	  RETURN CASE (STD.Str.ToUpperCase(STD.Str.CleanSpaces(Outdoors)), 
											'A' => 'Interest in Outdoor  - General',
											'B' => 'Interest in Snow Sports',
											'C' => 'interest in Water Sports',
											'D' => 'Interst in Hunting and Fishing',
									    '');
	END;


// 98	MHV	1	Median House Value Code
			// A - Less than $50,000
			// B = $50,000 - $99,999
			// C = $100,000 - $149,999
			// D = $150,000 - $249,999
			// E = $250,000 - $349,999
			// F = $350,000 - $499,999
			// G = $500,000 - $749,999
			// H = $750,000 - $999,999
			// I = $1,000,000 or More

	EXPORT MHV(STRING1 MHV) := FUNCTION
	  RETURN CASE (STD.Str.ToUpperCase(STD.Str.CleanSpaces(MHV)), 
											'A' => 'Less than $50,000',
											'B' => '$50,000 - $99,999',
											'C' => '$100,000 - $149,999',
											'D' => '$150,000 - $249,999',
											'E' => '$250,000 - $349,999',
											'F' => '$350,000 - $499,999',
											'G' => '$500,000 - $749,999',
											'H' => '$750,000 - $999,999',
											'I' => '$1,000,000 or More',
									    '');
	END;



// 99	MOR	1	Penetration Range Mail Order Respondent - See Below
// 100	CAR	1	Penetration Range Automobile owner - See Below
// 102	Penetration Range White Collar - See Below	1	Penetration Range - See Below
// 103	Penetration Range Blue Collar - See Below	1	Penetration Range - See Below
// 104	Penetration Range Other Occupation - See Below	1	Penetration Range - See Below

// Penetration Percentage Ranges	
// Greater than 95	A
// 95 thru 91	B
// 90 thru 86	C
// 85 thru 81	D
// 80 thru 76	E
// 75 thru 71	F
// 70 thru 66	G
// 65 thru 61	H
// 60 thru 56	I
// 55 thru 51	J
// 50 thru 46	K
// 45 thru 41	L
// 40 thru 36	M
// 35 thru 31	N
// 30 thru 26	O
// 25 thru 21	P
// 20 thru 16	Q
// 15 thru 11	R
// 10 thru 6	S
// Less than 6	T

	EXPORT PenetrationPercentageRanges(STRING1 PenetrationPercentageRanges) := FUNCTION
	  RETURN CASE (STD.Str.ToUpperCase(STD.Str.CleanSpaces(PenetrationPercentageRanges)), 
											'A' => 'Greater than 95',
											'B' => '95 thru 91',
											'C' => '90 thru 86',
											'D' => '85 thru 81',
											'E' => '80 thru 76',
											'F' => '75 thru 71',
											'G' => '70 thru 66',
											'H' => '65 thru 61',
											'I' => '60 thru 56',
											'J' => '55 thru 51',
											'K' => '50 thru 46',
											'L' => '45 thru 41',
											'M' => '40 thru 36',
											'N' => '35 thru 31',
											'O' => '30 thru 26',
											'P' => '25 thru 21',
											'Q' => '20 thru 16',
											'R' => '15 thru 11',
											'S' => '10 thru 6',
											'T' => 'Less than 6',			
									    '');
	END;


//105	DEMOLEVEL	1	Demo Append: Level 1 = Zip9 (Zip,Zip+4);  Level 2 = Zip7 (Zip,Zip+2); Level 3 = Zip5 
	EXPORT DEMOLEVEL(STRING1 DEMOLEVEL) := FUNCTION
	  RETURN CASE (STD.Str.ToUpperCase(STD.Str.CleanSpaces(DEMOLEVEL)), 
											'1' => 'Zip9 (Zip,Zip+4)',		
											'2' => 'Zip7 (Zip,Zip+2)',		
											'3' => 'Zip5', 
									    '');
	END;

	
end;

