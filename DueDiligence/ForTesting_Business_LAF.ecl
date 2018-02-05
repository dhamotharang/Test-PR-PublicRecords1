import SALT28, DueDiligence, Riskwise, ut;

EXPORT ForTesting_Business_LAF   := MODULE
	
//====================================================== 
//===  Use this MODULE to create the test cases      ===
//===                                                ===
//======================================================	

 EXPORT MockUpCriminalData(DATASET(DueDiligence.Layouts.CriminalOffenseLayout_by_DIDOffense) input) := FUNCTION
 
   BuildSomeTestCases  := PROJECT(input, TRANSFORM(DueDiligence.Layouts.CriminalOffenseLayout_by_DIDOffense,
                             SELF.did                         := LEFT.did, 
									 		       SELF.earliestOffenseDate         := IF(LEFT.seq = 96,'20170712', LEFT.earliestOffenseDate),
												     SELF.charge                      := IF(TRIM(LEFT.offender_key, ALL) = 'TB3888374338224690650'
																			                           AND LEFT.offensescore           = 'U', '  FELONY IN CHARGE  ', 	LEFT.charge),
																																						 
														 SELF.courtDispDesc1              := IF(TRIM(LEFT.offender_key, ALL) = 'TB3888374338224690650'
																			                           AND LEFT.offensescore           = '',  '  FELONY IN DESC1  ',  LEFT.courtDispDesc1),
																																						 
														 SELF.arr_off_lev_mapped          := IF(TRIM(LEFT.offender_key, ALL) = 'TB3888374338224690650' 
																			                           AND LEFT.criminalOffenderLevel  = '4', ' LA RE DUCED TO MISDEMEANOR', LEFT.arr_off_lev_mapped),
																			
														 SELF.court_off_lev_mapped        := IF(TRIM(LEFT.offender_key, ALL) = 'TB3888374338224690650'
																			                           AND LEFT.criminalOffenderLevel  = '4', ' FELONY IN COURT_OFF_LEV_MAPPED  ',  LEFT.court_off_lev_mapped),
																																						 
														 SELF.courtOffenseLevel           := IF(TRIM(LEFT.offender_key, ALL) = 'RV4804130573207206077C-1-CR-83-22866819830824', 'F3   ', LEFT.courtOffenseLevel),
																	 
														 SELF.courtDispDesc2              := IF(TRIM(LEFT.offender_key, ALL) = 'RV8706443000156919170C-1-CR-81-20053219810430', ' FELONY', LEFT.courtDispDesc2),
														 SELF.criminaloffenderlevel       := IF(TRIM(LEFT.offender_key, ALL) = 'RV8706443000156919170C-1-CR-81-20053219810430', '4', LEFT.criminaloffenderlevel),
														 SELF                             := LEFT;));
																			
	 Return BuildSomeTestCases;
	 
 END;  // end of FUNCTION
	

shared type_id 			:= unsigned6;
shared type_score		:= unsigned2;	//1-100.  measure of how unique a match is (requires a minimal level of strength in the match)
shared type_weight	:= unsigned2; //range no fixed.  SALT generated.  measure of combined specificities of matching fields and concepts.  measure of strength of match.  (regardless of uniqueness)

// this is the layout returned by the external linking process

export l_xlink_ids := record

	type_id 		DotID			:= 0;
	type_score	DotScore	:= 0;
	type_weight	DotWeight	:= 0;
   
	// in BIP2.0, these will always be 0
	type_id 		EmpID			:= 0;
	type_score	EmpScore	:= 0;
	type_weight	EmpWeight	:= 0;
	
	// in BIP2.0, these will always be 0
	type_id 		POWID			:= 0;
	type_score	POWScore	:= 0;
	type_weight	POWWeight	:= 0;
	
	type_id 		ProxID		:= 0;
	type_score	ProxScore	:= 0;
	type_weight	ProxWeight:= 0;
	
	type_id 		SELEID		:= 0;
	type_score	SELEScore	:= 0;
	type_weight	SELEWeight:= 0;	
	
	type_id 		OrgID			:= 0;
	type_score	OrgScore	:= 0;
	type_weight	OrgWeight	:= 0;
	
	type_id 		UltID			:= 0;
	type_score	UltScore	:= 0;
	type_weight	UltWeight	:= 0;	

end;

export l_xlink_ids2 := record(l_xlink_ids)
	type_id			UniqueID := 0;
end; 


EXPORT TARGET_BUSKEY :=  DATASET([{0, 0, 0, 0, 0, 0, 168967357, 0, 0, 168967357, 0, 0, 40615728, 0, 0, 87524, 0, 0,
                                   87524, 0, 0, 5,}], l_xlink_ids2);   //corporation
																	 
EXPORT TARGET_BUSKEY_PREV :=  DATASET([{0, 0, 0, 0, 0, 0, 168967357, 0, 0, 168967357, 0, 0, 40615728, 0, 0, 	2667352, 0, 0,
                                   	2667352, 0, 0, 5,}], l_xlink_ids2);   //corporation
																		
EXPORT TARGET_BUSKEY_TEST :=  DATASET([{0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 40615728, 0, 0, 	0, 0, 0,
                                   	0, 0, 0, 5,}], l_xlink_ids2);   //corporation

// EXPORT TARGET_BUSKEY :=  DATASET([{0, 0, 0, 0, 0, 0, 168967357, 0, 0, 168967357, 0, 0, 40615728, 0, 0, 87524, 0, 0,
                                   // 87524, 0, 0, 5,}], l_xlink_ids2);   //corporation


EXPORT CompanyTestLayout := RECORD
	UNSIGNED seq;
	STRING accountNumber;
	INTEGER	HistoryDateYYYYMM;
	STRING companyName;
	STRING altCompanyName;
	STRING companyPhone;
	STRING companyFEIN;
	STRING streetAddress1;
	STRING streetAddress2;
	STRING city;
	STRING state;
	STRING zip;
END;	



EXPORT AMMATAC :=  DATASET([{1, 'LN_TestRecord_1', 20090525, '', 'AMMATAC CORPORATION', '3202246062', '845211146',
											'1300 ROLLINGS ROAD', '', 'BURLINGAME', 'CA', '94010'}], CompanyTestLayout);		

EXPORT DOC_BROWN_PIZZA :=  DATASET([{2, 'LN_TestRecord_2', 20151001, 'DOC BROWN PIZZA LLC', '', '', '',
											'37 COUNTY RD 140', '', 'OXFORD', 'MS', '38655'}], CompanyTestLayout);	

EXPORT CRESTVIEW :=  DATASET([{3, 'LN_TestRecord_3', 20150101, 'CRESTVIEW LLC', '', '', '',
											'712 GILES RD', '', 'BLACKSBURG', 'VA', '24060'}], CompanyTestLayout);	
	
EXPORT FAKE :=  DATASET([{4, 'LN_TestRecord_4', 0, 'My Cool New Company', '', '', '',
											'123 Main St', '', 'some city', 'MN', '56347'}], CompanyTestLayout);		
	
EXPORT TARGET_CORP :=  DATASET([{5, 'LN_TestRecord_5', 0, 'TARGET CORPORATION', '', '', '',
											'1000 nicollet mall', '', 'MINNEAPOLIS', 'MN', '55403'}], CompanyTestLayout);   //corporation
											
EXPORT TARGET_STORE :=  DATASET([{6, 'LN_TestRecord_6', 0, 'TARGET', '', '', '',
											'4201 w division st', '', 'st cloud', 'MN', '56301'}], CompanyTestLayout);   //store											

EXPORT UNITED_METHODIST :=  DATASET([{7, 'LN_TestRecord_7', 0, 'first united methodist church', '', '', '',
											'302 5th Ave S', '', 'st cloud', 'MN', ''}], CompanyTestLayout);   										
											
EXPORT MASTERS_DESIGN :=  DATASET([{8, 'LN_TestRecord_8', 0, 'THE MASTER\'S DESIGNS, INC.', '', '', '',
											'445 SALEM VALLEY RD', '', 'RINGGOLD', 'GA', '30736'}], CompanyTestLayout);  

EXPORT SCHEELS :=  DATASET([{9, 'LN_TestRecord_9', 0, 'Scheels', '', '', '',
											'40 Waite Ave N', '', 'Waite Park', 'MN', ''}], CompanyTestLayout); 

EXPORT REED_ELSEVEIR :=  DATASET([{10, 'LN_TestRecord_10', 0, 'Reed Elsevier', '', '2129895800', '',
											'1000 Alderman Dr', '', 'Alpharetta', 'GA', ''}], CompanyTestLayout); 

EXPORT CITIBANK :=  DATASET([{11, 'LN_TestRecord_11', 0, 'CITIBANK', '', '', '',
											'270 AVE MUNOZ RIVERA STE 600', '', 'SAN JUAN', 'PR', '00918'}], CompanyTestLayout); 	
											
EXPORT LEXISNEXIS :=  DATASET([{12, 'LN_TestRecord_12', 0, 'LexisNexis', '', '', '',
											'3051 2nd St S #100', '', 'St Cloud', 'MN', ''}], CompanyTestLayout); 
											
EXPORT NUGENT_SAND :=  DATASET([{13, 'LN_TestRecord_13', 20171025, 'NUGENT SAND COMPANY', 'NUGENT SAND CO', '', '',
											'1833 RIVER ROAD', '', 'LOUISVILLE', 'KY', '40206'}], CompanyTestLayout); 			//has lots of watercraft								

EXPORT JIMMY_JOHNS :=  DATASET([{14, 'LN_TestRecord_14', 0, 'Jimmy Johns', '', '', '',
											'101 County Road 120 #700', '', 'ST CLOUD', 'MN', ''}], CompanyTestLayout); 		
											
EXPORT WALT_DISNEY :=  DATASET([{15, 'LN_TestRecord_15', 0, 'WALT DISNEY', '', '', '',
											'7814 W Irlo Bronson Memoria', '', 'ORLANDO', 'FL', ''}], CompanyTestLayout); 				
											
EXPORT GRACE_BIBLE_CHURCH :=  DATASET([{16, 'LN_TestRecord_16', 0, 'Grace Bible Church', '', '', '',
											'3625 S 19th Ave', '', 'Bozeman', 'MT', ''}], CompanyTestLayout); 			//has a linked business

EXPORT FORUM_TOWNHOMES :=  DATASET([{17, 'LN_TestRecord_17', 0, 'FORUM TOWNHOMES', '', '', '',
											'1090 GEORGIA ST VANCOUVER BC V6E W', '', 'CANADA', 'CA', ''}], CompanyTestLayout); 			

EXPORT GREAT_CLIPS :=  DATASET([{18, 'LN_TestRecord_18', 0, 'GREAT CLIPS', '', '', '',
											'101 County Road 120 #700', '', 'ST CLOUD', 'MN', ''}], CompanyTestLayout); 	

EXPORT RAINBOW_ART_FOUNDATION := DATASET([{19, 'LN_TestRecord_19', 0, 'RAINBOW ART FOUNDATION', '', '', '',
											'31 EDGEWOOD ST', '', 'SPRINGFIELD', 'MA', '01109'}], CompanyTestLayout);

EXPORT AGAWAM := DATASET([{20, 'LN_TestRecord_20', 0, 'AGAWAM US TAE KWON DO', '', '', '',
											'67 SPRINGFIELD ST', '', 'AGAWAM', 'MA', '01001'}], CompanyTestLayout);  //has vacant property
											
EXPORT COOKS        :=  DATASET([{21, 'LN_TestRecord_21', 0, 'COOKS PROPERTY', '', '', '',
											'1741 5TH AVE SE', '', 'DECATUR', 'AL', ''}], CompanyTestLayout); 
											
											
EXPORT MARTIN        :=  DATASET([{22, 'LN_TestRecord_22', 0, 'MARTIN MARIETTA MATERIALS', '', '', '',
											'2710 WYCLIFF RD', '', 'RALEIGH', 'NC', ''}], CompanyTestLayout); 
											
EXPORT VILLA        :=  DATASET([{23, 'LN_TestRecord_23', 0, 'Pierz Villa', '', '', '',
											'119 Faust Street', '', 'Pierz', 'MN', ''}], CompanyTestLayout); 
											
EXPORT ST_JOSEPH        :=  DATASET([{24, 'LN_TestRecord_24', 0, 'St. Josephs Church', '', '', '',
											'68 Main St N', '', 'Pierz', 'MN', ''}], CompanyTestLayout); 

EXPORT AIRCRAFT_WHOLESALE_LLC :=  DATASET([{25, 'LN_TestRecord_25', 20120801, 'AIRCRAFT WHOLESALE LLC', '', '', '',
											'3127 MAROON CREEK RD 3', '', 'ASPEN', 'CO', '81611'}], CompanyTestLayout); 
											
EXPORT SKATE_TO_WIN :=  DATASET([{26, 'LN_TestRecord_26', 0, 'SKATE TO WIN LABBETT HOCKEY LLC', '', '', '',
											'2343 SO COLUMBINE ST', '', 'DENVER', 'CO', ''}], CompanyTestLayout);   //multiple corp records

EXPORT PERSONAL_TOUCH_REALTY :=  DATASET([{27, 'LN_TestRecord_27', 0, 'A PERSONAL TOUCH REALTY LLC', '', '', '',
											'234 JUSTICE RIDGE RD', '', 'CANDLER', 'NC', '28715'}], CompanyTestLayout);   //dissolved corp records											

EXPORT BUNKERFUELS :=  DATASET([{28, 'LN_TestRecord_28', 0, 'BUNKERFUELS CORPORATION', '', '', '',
											'9800 NW 41ST', '', 'MIAMI', 'FL', '33178'}], CompanyTestLayout);   //corp_forgn_state_cd populated		
											
EXPORT AT_CROSS_CO :=  DATASET([{29, 'LN_TestRecord_29', 20040101, 'A.T. CROSS COMPANY', '', '', '',
											'ONE ALBION RD', '', 'LINCOLN', 'RI', ''}], CompanyTestLayout);   //corp record seleid = 0
											
EXPORT GLACIER_NATIONAL_PARK :=  DATASET([{30, 'LN_TestRecord_30', 0, 'GLACIER NATIONAL PARK CONSERVANCY', '', '', '',
											'PO BOX 2749', '402 9TH ST W', 'COLUMBIA FALLS', 'MT', '59912'}], CompanyTestLayout);   //current registered bus										

EXPORT CEASARS :=  DATASET([{31, 'LN_TestRecord_31', 0, 'CAESARS ENTERTAINMENT OPERATING CO INC', '', '', '',
											'5240 HAVEN ST HNGR 8 ', '', 'LAS VEGAS ', 'NV', ' 89119 '}], CompanyTestLayout);        // aircraft found			
											
EXPORT OSCEOLA_ROAD_COUNTY :=  DATASET([{32, 'LN_TestRecord_32', 0, 'OSCEOLA ROAD COUNTY', '', '', '',
											'301 W UPTON AVE', '', 'REED CITY', 'MI', '49677'}], CompanyTestLayout);   //current registered bus	
											
EXPORT FOODS :=  DATASET([{33, 'LN_TestRecord_33', 0, 'FOODS FOR FRIENDS', '', '', '',
											'105 E 4TH ST', '', 'CINCINNATI', 'OH', '45202'}], CompanyTestLayout);   //To Test the Watercraft Bug 

EXPORT ROCK_CHURCH :=  DATASET([{34, 'LN_TestRecord_34', 0, 'ROCK CHURCH', '', '', '',
											'PO BOX 37', '', 'VERO BEACH', 'FL', '32961'}], CompanyTestLayout);   //SOS PO Box address	
											
EXPORT BRUCE_NEWLON :=  DATASET([{35, 'LN_TestRecord_35', 0, 'BRUCE NEWLON', '', '', '',
											'258 WITHROW RD', '', 'ELLIJAY', 'GA', ''}], CompanyTestLayout); 
											
EXPORT AUTOMATIC_SPRINKLER_CORP :=  DATASET([{36, 'LN_TestRecord_36', 0, 'AUTOMATIC SPRINKLER CORPORATION OF AMERICA', '', '', '',
											'55 PUBLIC SQUARE', '', 'CLEVELAND', 'OH', ''}], CompanyTestLayout);  											

EXPORT VIKING_COCA_COLA :=  DATASET([{37, 'LN_TestRecord_37', 0, 'VIKING COCA COLA BOTTLING', '', '', '',
											'4610 RUSAN ST', '', 'SAINT CLOUD', 'MN', ''}], CompanyTestLayout);    
											
EXPORT INTERMODAL_FREIGHT :=  DATASET([{38, 'LN_TestRecord_38', 0, 'INTERMODAL L FREIGHT', '', '', '',
											'316 DRAYTON ST', '', 'SAVANNAH', 'GA', ''}], CompanyTestLayout); 

EXPORT RYAN_PHOTOS :=  DATASET([{39, 'LN_TestRecord_39', 0, 'RYAN NELSON PHOTOGRAPHY', '', '', '',
											'1419 E PECAN RD', '', 'PHOENIX', 'AZ', ''}], CompanyTestLayout); 			
											
EXPORT TRUCK_DEPOT :=  DATASET([{40, 'LN_TestRecord_40', 0, 'THE TRUCK DEPOT', '', '', '',     //To Test Vehicle Data
											'4000 BEE RIDGE RD', '', 'SARASOTA', 'FL', ''}], CompanyTestLayout); 		
											
											
EXPORT PAMIDA :=  DATASET([{41, 'LN_TestRecord_41', 0, 'PAMIDA, INC.', '', '', '',     //To Test Vehicle Data
											'8800 F STREET', '', 'OMAHA', 'NE', ''}], CompanyTestLayout); 			
											
																						
EXPORT GOLDEN_KEYS :=  DATASET([{42, 'LN_TestRecord_42', 0, 'GOLDEN KEYS INVESTMENTS', '', '', '',              //To Access to Funds Property (testing level 1)
											'246 SOUTHWEST PKWY E', '', 'COLLEGE STATION', 'TX', ''}], CompanyTestLayout); 		
											   
EXPORT DRJ :=  DATASET([{43, 'LN_TestRecord_43', 0, 'DRJ DBA R D TRIM INVESTMENTS GEN', '', '', '',       //To Access to Funds Property (testing level 1 and 2)
											'1515 W MAGNOLIA AVE', '', 'FORT WORTH', 'TX', ''}], CompanyTestLayout); 			
											
EXPORT GOGEBIC :=  DATASET([{44, 'LN_TestRecord_44', 20171025, 'GOGEBIC COMMUNITY COLLEGE', '', '', '',         //To Aircraft testing archive mode 
											'E4946 JACKSON RD', '', 'IRONWOOD', 'MI', ''}], CompanyTestLayout); 			
											
EXPORT FINGER_TOWING :=  DATASET([{96, 'LN_TestRecord_96', 20171025, 'FINGER TOWING SERVICE', '', '', '',         //To Liens and Legal Events  
											'907 MCPHAUL ST', '', 'AUSTIN', 'TX', '78758'}], CompanyTestLayout); 		
											
EXPORT GREENWOOD_BUILDER :=  DATASET([{98, 'LN_TestRecord_98', 20170822, 'GREENWOOD HOME BUILDER', '', '', '',         //Business not FOUND
											'52', '', 'GREENWOOD', 'MO', '64034'}], CompanyTestLayout); 		
											
EXPORT TRENDZ :=  DATASET([{99, 'LN_TestRecord_99', 0, 'TRENDZ SALON', '', '', '',                                  //Criminal offensed  
											'1010 E NORTH AVE', '', 'TONKAWA', 'OK', '74653'}], CompanyTestLayout); 
											
EXPORT BIKE_FITTERS := DATASET([{100, 'LN_TestRecord_100', 0, 'BIKE FITTERS INC', '', '', '',                      // Operating locations           
											'3936 AIA SOUTH', '',  'ST AUGUSTINE', 'FL', '32080'}], CompanyTestLayout);    



 
//=========================================================================
//=== For Creating Test Data in the format of the criminal offenses     ===
//=========================================================================
 EXPORT MyFavorite_CONVICTED_FELONY_4F_NYR := DATASET([TRANSFORM(DueDiligence.Layouts.CriminalOffenseLayout_by_DIDOffense,
                                                       SELF.seq                 := 96;
                                                       SELF.DID                 := 741130149;
																											                            SELF.offender_key        := 'CONVICTED OF FELONY IN LAST 3 YEARS';
														                                         SELF.historydate         := 20171220;
																					                                  SELF.ToDaysDate          := 20171220;
																																						                 SELF.DateToUse           := 20171220;
																									                              SELF.earliestOffenseDate := '20141220';
																																								               SELF.untouchedearliestOffenseDate := '20141220'; 
																																															        SELF.dataType            := '2';
																																																			    SELF.convictionFlag      := 'N';
																																																					  SELF.trafficFlag         := 'N'; 
																																																						 SELF.untouchedOffenseScore := ' ';
																																																						 SELF.offenseScore        := 'F';        //**values are 'U' or null = UNKOWN, 'M'= Misdemeanor, 'F'= Felony, 'T' = TRAFFIC, 'I'=Infraction.
																																																						 SELF.criminalOffenderLevel := '4';      //**values are 4 = NON-TRAFFIC/CONVICTED, 3 = NON-TRAFFIC/NOT-CONVICTED, 2 = TRAFFIC/CONVICTED, 1 = TRAFFIC/NOT-CONVICTED
																																																						 SELF.caseNum             := 'CASE ONE'; 
                                                       SELF                    := [];          // All other fields will be empty 
														                                                                    )])[1];      // Create 1 row in the DataSet 

//=========================================================================
//=== For Creating Test Data in the format of the criminal offenses     ===
//=========================================================================
 // EXPORT MyFavorite_CONVICTED_FELONY_4F_NYR := dataset(
 // [		
  // {                                /*Test Case #1*/  
	 // 96,                             /*seq */
  // 741130149,                      /*did*/
	 // 'CONVICTED OF FELONY IN LAST 3 YEARS', /*offender_key*/
	 // 0,                               /*origdid*/
	 // 20171220,                       /*history date*/
	 // 20171220,                       /*todays date */
	 // 20171220,                       /*date to Use */
  // 0,                              /*# of days ago*/               //***1095 is exactly 3 years ago
	 // '',                             /* file date */
	 // '20141220',                     /* earliest offense date */     //***20141220 is exactly 3 years ago from 20171221 ***
	 // '20141220',                     /* untouched earliest date */
	 // '2',                            /* dataType*/
	 // 'N',                            /* conviction flag */
	 // 'N',                            /* traffic flag */
	 // ' ',                            /* untouched offense score*/
	 // 'F',                            /* offense score */             //**values are 'U' or null = UNKOWN, 'M'= Misdemeanor, 'F'= Felony, 'T' = TRAFFIC, 'I'=Infraction.
	 // '4',                             /* criminal Offender Level */   //**values are 4 = NON-TRAFFIC/CONVICTED, 3 = NON-TRAFFIC/NOT-CONVICTED, 2 = TRAFFIC/CONVICTED, 1 = TRAFFIC/NOT-CONVICTED
	 // '',                           /* courtOffenseLevel  */
	 // '',                           /* courtStatute */
	 // '',                           /* courtStatuteDesc    */
	 // 'CASE ONE',                   /* caseNum     */
	 // '',                           /* caseCourt   */
	 // '',                           /* caseTypeDesc  */
	 // '',                           /* courtType   */
	 // 'CHARGED WITH FELONY',        /* charge      */
	 // 'DESC1         ',             /* courtDispDesc1 */
	 // 'DESC2         ',             /* courtDispDesc2  */
	 // '',                           /* offenseDate  */
	 // '',                           /* arrestDate  */
	 // '',                           /* courtDispDate */
	 // '',                           /* sentenceDate */
	 // '',                           /* appealDate  */
	 // '',                           /* countyOfOrigin   */
	 // 'TX',                         /* origState  */
	 // '',                           /* stc_desc_2   */
	 // 'FELONY',                     /* arr_off_lev_mapped   */
	 // '',                           /* court_off_lev_mapped */
	 // 'I',                          /* punishment_type */
	 // '',                           /* Curr_incarc_offenders */
	 // '',                           /* Curr_incarc_offenses */
	 // '',                           /* Curr_incarc_punishments */
	 // '',                           /* Ever_incarc_offenders*/
	 // '',                           /* Ever_incarc_offenses*/
	 // '',                           /* Ever_incarc_punishments */
	 // '',                           /* curr_parole_flag */
	 // '',                           /* curr_parole_punishments */
	 // ''                            /* curr_stat_inm */
       
		    // }                        /* END OF THE LAST RECORD*/  
				
 // ], DueDiligence.Layouts.CriminalOffenseLayout_by_DIDOffense);	


//=========================================================================
//=== For Creating Test Case 2 in the format of the criminal offenses   ===
//=========================================================================
 // EXPORT MyFavorite_CONVICTED_FELONY_4F_OVRNY := dataset(
 // [		
 				// {                              /*Test Case #2*/  
	 // 96,                             /*seq */
  // 741130149,                      /*did*/
	 // 'CONVICTED OF FELONY OVER 3 YEARS', /*offender_key*/
	 // 0,                               /*origdid*/
	 // 20171220,                       /*history date*/
	 // 20171220,                       /*todays date */
	 // 20171220,                       /*date to Use */
  // 0,                              /*# of days ago*/               //***1095 is exactly 3 years ago
	 // '',                             /* file date */
	 // '20141221',                     /* earliest offense date */
	 // '20141221',                     /* untouched earliest date */
	 // '2',                            /* dataType*/
	 // 'N',                            /* conviction flag */
	 // 'N',                            /* traffic flag */
	 // ' ',                            /* untouched offense score*/
	 // 'F',                            /* offense score */             //**values are 'U' or null = UNKOWN, 'M'= Misdemeanor, 'F'= Felony, 'T' = TRAFFIC, 'I'=Infraction.
	 // '4',                             /* criminal Offender Level */   //**values are 4 = NON-TRAFFIC/CONVICTED, 3 = NON-TRAFFIC/NOT-CONVICTED, 2 = TRAFFIC/CONVICTED, 1 = TRAFFIC/NOT-CONVICTED
	 // '',                           /* courtOffenseLevel  */
	 // '',                           /* courtStatute */
	 // '',                           /* courtStatuteDesc    */
	 // 'CASE TWO',                   /* caseNum     */
	 // '',                           /* caseCourt   */
	 // '',                           /* caseTypeDesc  */
	 // '',                           /* courtType   */
	 // 'CHARGED WITH FELON',         /* charge      */
	 // 'DESC1         ',             /* courtDispDesc1 */
	 // 'DESC2         ',             /* courtDispDesc2  */
	 // '',                           /* offenseDate  */
	 // '',                           /* arrestDate  */
	 // '',                           /* courtDispDate */
	 // '',                           /* sentenceDate */
	 // '',                           /* appealDate  */
	 // '',                           /* countyOfOrigin   */
	 // 'TX',                         /* origState  */
	 // '',                           /* stc_desc_2   */
	 // 'FELON',                     /* arr_off_lev_mapped   */
	 // '',                           /* court_off_lev_mapped */
	 // 'I',                          /* punishment_type */
	 // '',                           /* Curr_incarc_offenders */
	 // '',                           /* Curr_incarc_offenses */
	 // '',                           /* Curr_incarc_punishments */
	 // '',                           /* Ever_incarc_offenders*/
	 // '',                           /* Ever_incarc_offenses*/
	 // '',                           /* Ever_incarc_punishments */
	 // '',                           /* curr_parole_flag */
	 // '',                           /* curr_parole_punishments */
	 // ''                            /* curr_stat_inm */
 	    // }                        /* END OF THE LAST RECORD*/  
				
 // ], DueDiligence.Layouts.CriminalOffenseLayout_by_DIDOffense);	

 
		
//=========================================================================
//=== For Creating Test Case 3 in the format of the criminal offenses   ===
//=========================================================================
 // EXPORT MyFavorite_CONVICTED_UNKNOWN_4U_NYR := dataset(
 // [		
				
			// {                              /*Test Case #3*/  
	 // 96,                             /*seq */
  // 741130149,                      /*did*/
	 // 'CONVICTED OF UNKNOW IN PAST 3 YEARS', /*offender_key*/
	 // 0,                               /*origdid*/
	 // 20171220,                       /*history date*/
	 // 20171220,                       /*todays date */
	 // 20171220,                       /*date to Use */
  // 0,                              /*# of days ago*/               //***1095 is exactly 3 years ago
	 // '',                             /* file date */
	 // '20141220',                     /* earliest offense date */    //***20141220 is 3 years ago from 20171221 ***
	 // '20141220',                     /* untouched earliest date */
	 // '2',                            /* dataType*/
	 // 'N',                            /* conviction flag */
	 // 'N',                            /* traffic flag */
	 // ' ',                            /* untouched offense score*/
	 // 'U',                            /* offense score */             //**values are 'U' or null = UNKOWN, 'M'= Misdemeanor, 'F'= Felony, 'T' = TRAFFIC, 'I'=Infraction.
	 // '4',                             /* criminal Offender Level */   //**values are 4 = NON-TRAFFIC/CONVICTED, 3 = NON-TRAFFIC/NOT-CONVICTED, 2 = TRAFFIC/CONVICTED, 1 = TRAFFIC/NOT-CONVICTED
	 // '',                           /* courtOffenseLevel  */
	 // '',                           /* courtStatute */
	 // '',                           /* courtStatuteDesc    */
	 // 'CASE THREE',                 /* caseNum     */
	 // '',                           /* caseCourt   */
	 // '',                           /* caseTypeDesc  */
	 // '',                           /* courtType   */
	 // 'CHARGED WITH FELON',        /* charge      */
	 // 'DESC1         ',             /* courtDispDesc1 */
	 // 'DESC2         ',             /* courtDispDesc2  */
	 // '',                           /* offenseDate  */
	 // '',                           /* arrestDate  */
	 // '',                           /* courtDispDate */
	 // '',                           /* sentenceDate */
	 // '',                           /* appealDate  */
	 // '',                           /* countyOfOrigin   */
	 // 'TX',                         /* origState  */
	 // '',                           /* stc_desc_2   */
	 // 'FELON',                     /* arr_off_lev_mapped   */
	 // '',                           /* court_off_lev_mapped */
	 // 'I',                          /* punishment_type */
	 // '',                           /* Curr_incarc_offenders */
	 // '',                           /* Curr_incarc_offenses */
	 // '',                           /* Curr_incarc_punishments */
	 // '',                           /* Ever_incarc_offenders*/
	 // '',                           /* Ever_incarc_offenses*/
	 // '',                           /* Ever_incarc_punishments */
	 // '',                           /* curr_parole_flag */
	 // '',                           /* curr_parole_punishments */
	 // ''                            /* curr_stat_inm */   
		    // }                        /* end of record three*/ 
		// ], DueDiligence.Layouts.CriminalOffenseLayout_by_DIDOffense);	
		
//=========================================================================
//=== For Creating Test Data in the format of the criminal offenses     ===
//=========================================================================
 // EXPORT MyFavorite_CONVICTED_UNKNOWN_4U_OVNYR := dataset(
 // [						
	// {                              /*Test Case #4*/  
	 // 96,                             /*seq */
  // 741130149,                      /*did*/
	 // 'CONVICTED OF UNKNOW OVER 3 YEARS', /*offender_key*/
	 // 0,                               /*origdid*/
	 // 20171220,                       /*history date*/
	 // 20171220,                       /*todays date */
	 // 20171220,                       /*date to Use */
  // 0,                              /*# of days ago*/               //***1095 is exactly 3 years ago
	 // '',                             /* file date */
	 // '20141221',                     /* earliest offense date */
	 // '20141221',                     /* untouched earliest date */
	 // '2',                            /* dataType*/
	 // 'N',                            /* conviction flag */
	 // 'N',                            /* traffic flag */
	 // ' ',                            /* untouched offense score*/
	 // 'U',                            /* offense score */             //**values are 'U' or null = UNKOWN, 'M'= Misdemeanor, 'F'= Felony, 'T' = TRAFFIC, 'I'=Infraction.
	 // '4',                             /* criminal Offender Level */   //**values are 4 = NON-TRAFFIC/CONVICTED, 3 = NON-TRAFFIC/NOT-CONVICTED, 2 = TRAFFIC/CONVICTED, 1 = TRAFFIC/NOT-CONVICTED
	 // '',                           /* courtOffenseLevel  */
	 // '',                           /* courtStatute */
	 // '',                           /* courtStatuteDesc    */
	 // 'CASE FOUR',                  /* caseNum     */
	 // '',                           /* caseCourt   */
	 // '',                           /* caseTypeDesc  */
	 // '',                           /* courtType   */
	 // 'CHARGED WITH FELON',        /* charge      */
	 // 'DESC1         ',             /* courtDispDesc1 */
	 // 'DESC2         ',             /* courtDispDesc2  */
	 // '',                           /* offenseDate  */
	 // '',                           /* arrestDate  */
	 // '',                           /* courtDispDate */
	 // '',                           /* sentenceDate */
	 // '',                           /* appealDate  */
	 // '',                           /* countyOfOrigin   */
	 // 'TX',                         /* origState  */
	 // '',                           /* stc_desc_2   */
	 // 'FELON',                     /* arr_off_lev_mapped   */
	 // '',                           /* court_off_lev_mapped */
	 // 'I',                          /* punishment_type */
	 // '',                           /* Curr_incarc_offenders */
	 // '',                           /* Curr_incarc_offenses */
	 // '',                           /* Curr_incarc_punishments */
	 // '',                           /* Ever_incarc_offenders*/
	 // '',                           /* Ever_incarc_offenses*/
	 // '',                           /* Ever_incarc_punishments */
	 // '',                           /* curr_parole_flag */
	 // '',                           /* curr_parole_punishments */
	 // ''                            /* curr_stat_inm */
       
		    // }                        /* end of 4th record */
		// ], DueDiligence.Layouts.CriminalOffenseLayout_by_DIDOffense);	

//=========================================================================
//=== For Creating Test Case #5 in the format of the criminal offenses  ===
//=========================================================================
 // EXPORT MyFavorite_CONVICTED_MISDEM_4M_NYR := dataset(
 // [										
					// {                              /*Test Case #5*/  
	 // 96,                             /*seq */
  // 741130149,                      /*did*/
	 // 'CONVICTED OF MISD IN PAST 3 YEARS', /*offender_key*/
	 // 0,                               /*origdid*/
	 // 20171220,                       /*history date*/
	 // 20171220,                       /*todays date */
	 // 20171220,                       /*date to Use */
  // 1095,                           /*# of days ago*/               //***1095 is exactly 3 years ago
	 // '',                             /* file date */
	 // '20141220',                     /* earliest offense date */
	 // '20141220',                     /* untouched earliest date */
	 // '2',                            /* dataType*/
	 // 'N',                            /* conviction flag */
	 // 'N',                            /* traffic flag */
	 // ' ',                            /* untouched offense score*/
	 // 'M',                            /* offense score */             //**values are 'U' or null = UNKOWN, 'M'= Misdemeanor, 'F'= Felony, 'T' = TRAFFIC, 'I'=Infraction.
	 // '4',                             /* criminal Offender Level */   //**values are 4 = NON-TRAFFIC/CONVICTED, 3 = NON-TRAFFIC/NOT-CONVICTED, 2 = TRAFFIC/CONVICTED, 1 = TRAFFIC/NOT-CONVICTED
	 // '',                           /* courtOffenseLevel  */
	 // '',                           /* courtStatute */
	 // '',                           /* courtStatuteDesc    */
	 // 'CASE FIVE',                  /* caseNum     */
	 // '',                           /* caseCourt   */
	 // '',                           /* caseTypeDesc  */
	 // '',                           /* courtType   */
	 // 'CHARGED WITH FELONY',        /* charge      */
	 // 'DESC1         ',             /* courtDispDesc1 */
	 // 'DESC2         ',             /* courtDispDesc2  */
	 // '',                           /* offenseDate  */
	 // '',                           /* arrestDate  */
	 // '',                           /* courtDispDate */
	 // '',                           /* sentenceDate */
	 // '',                           /* appealDate  */
	 // '',                           /* countyOfOrigin   */
	 // 'TX',                         /* origState  */
	 // '',                           /* stc_desc_2   */
	 // 'FELONY',                     /* arr_off_lev_mapped   */
	 // '',                           /* court_off_lev_mapped */
	 // 'I',                          /* punishment_type */
	 // '',                           /* Curr_incarc_offenders */
	 // '',                           /* Curr_incarc_offenses */
	 // '',                           /* Curr_incarc_punishments */
	 // '',                           /* Ever_incarc_offenders*/
	 // '',                           /* Ever_incarc_offenses*/
	 // '',                           /* Ever_incarc_punishments */
	 // '',                           /* curr_parole_flag */
	 // '',                           /* curr_parole_punishments */
	 // ''                            /* curr_stat_inm */
       
		    // }                        /* end of record #5 */
		// ], DueDiligence.Layouts.CriminalOffenseLayout_by_DIDOffense);	

//=========================================================================
//=== For Creating Test Case #6 in the format of the criminal offenses  ===
//=========================================================================
 // EXPORT MyFavorite_CONVICTED_MISDEM_4M_OVNYR := dataset(
 // [						
								// {                              /*Test Case #6*/  
	 // 96,                             /*seq */
  // 741130149,                      /*did*/
	 // 'CONVICTED OF MISD OVER 3 YEARS AGO', /*offender_key*/
	 // 0,                               /*origdid*/
	 // 20171220,                       /*history date*/
	 // 20171220,                       /*todays date */
	 // 20171220,                       /*date to Use */
  // 0,                             /*# of days ago*/               //***1095 is exactly 3 years ago
	 // '',                             /* file date */
	 // '20141221',                     /* earliest offense date */
	 // '20141221',                     /* untouched earliest date */
	 // '2',                            /* dataType*/
	 // 'N',                            /* conviction flag */
	 // 'N',                            /* traffic flag */
	 // ' ',                            /* untouched offense score*/
	 // 'M',                            /* offense score */             //**values are 'U' or null = UNKOWN, 'M'= Misdemeanor, 'F'= Felony, 'T' = TRAFFIC, 'I'=Infraction.
	 // '4',                             /* criminal Offender Level */   //**values are 4 = NON-TRAFFIC/CONVICTED, 3 = NON-TRAFFIC/NOT-CONVICTED, 2 = TRAFFIC/CONVICTED, 1 = TRAFFIC/NOT-CONVICTED
	 // '',                           /* courtOffenseLevel  */
	 // '',                           /* courtStatute */
	 // '',                           /* courtStatuteDesc    */
	 // 'CASE SIX',                   /* caseNum     */
	 // '',                           /* caseCourt   */
	 // '',                           /* caseTypeDesc  */
	 // '',                           /* courtType   */
	 // 'CHARGED WITH FELONY',        /* charge      */
	 // 'DESC1         ',             /* courtDispDesc1 */
	 // 'DESC2         ',             /* courtDispDesc2  */
	 // '',                           /* offenseDate  */
	 // '',                           /* arrestDate  */
	 // '',                           /* courtDispDate */
	 // '',                           /* sentenceDate */
	 // '',                           /* appealDate  */
	 // '',                           /* countyOfOrigin   */
	 // 'TX',                         /* origState  */
	 // '',                           /* stc_desc_2   */
	 // 'FELONY',                     /* arr_off_lev_mapped   */
	 // '',                           /* court_off_lev_mapped */
	 // 'I',                          /* punishment_type */
	 // '',                           /* Curr_incarc_offenders */
	 // '',                           /* Curr_incarc_offenses */
	 // '',                           /* Curr_incarc_punishments */
	 // '',                           /* Ever_incarc_offenders*/
	 // '',                           /* Ever_incarc_offenses*/
	 // '',                           /* Ever_incarc_punishments */
	 // '',                           /* curr_parole_flag */
	 // '',                           /* curr_parole_punishments */
	 // ''                            /* curr_stat_inm */
       
		    // }                        /* end of 6th record */
		// ], DueDiligence.Layouts.CriminalOffenseLayout_by_DIDOffense);	

//=========================================================================
//=== For Creating Test Data in the format of the criminal offenses     ===
//=========================================================================
 // EXPORT MyFavorite_NONCONV_FELONY_3F_NYR := dataset(
 // [		
				// {                              /*Test Case #7*/  
	 // 96,                             /*seq */
  // 741130149,                      /*did*/
	 // 'NON CONVICTED FELONY IN PAST 3 YEARS', /*offender_key*/
	 // 0,                               /*origdid*/
	 // 20171220,                       /*history date*/
	 // 20171220,                       /*todays date */
	 // 20171220,                       /*date to Use */
  // 0,                              /*# of days ago*/               //***1095 is exactly 3 years ago
	 // '',                             /* file date */
	 // '20141220',                     /* earliest offense date */
	 // '20141220',                     /* untouched earliest date */
	 // '2',                            /* dataType*/
	 // 'N',                            /* conviction flag */
	 // 'N',                            /* traffic flag */
	 // ' ',                            /* untouched offense score*/
	 // 'F',                            /* offense score */             //**values are 'U' or null = UNKOWN, 'M'= Misdemeanor, 'F'= Felony, 'T' = TRAFFIC, 'I'=Infraction.
	 // '3',                             /* criminal Offender Level */   //**values are 4 = NON-TRAFFIC/CONVICTED, 3 = NON-TRAFFIC/NOT-CONVICTED, 2 = TRAFFIC/CONVICTED, 1 = TRAFFIC/NOT-CONVICTED
	 // '',                           /* courtOffenseLevel  */
	 // '',                           /* courtStatute */
	 // '',                           /* courtStatuteDesc    */
	 // 'CASE SEVEN',                  /* caseNum     */
	 // '',                           /* caseCourt   */
	 // '',                           /* caseTypeDesc  */
	 // '',                           /* courtType   */
	 // 'CHARGED WITH FELONY',        /* charge      */
	 // 'DESC1         ',             /* courtDispDesc1 */
	 // 'DESC2         ',             /* courtDispDesc2  */
	 // '',                           /* offenseDate  */
	 // '',                           /* arrestDate  */
	 // '',                           /* courtDispDate */
	 // '',                           /* sentenceDate */
	 // '',                           /* appealDate  */
	 // '',                           /* countyOfOrigin   */
	 // 'TX',                         /* origState  */
	 // '',                           /* stc_desc_2   */
	 // 'FELONY',                     /* arr_off_lev_mapped   */
	 // '',                           /* court_off_lev_mapped */
	 // 'I',                          /* punishment_type */
	 // '',                           /* Curr_incarc_offenders */
	 // '',                           /* Curr_incarc_offenses */
	 // '',                           /* Curr_incarc_punishments */
	 // '',                           /* Ever_incarc_offenders*/
	 // '',                           /* Ever_incarc_offenses*/
	 // '',                           /* Ever_incarc_punishments */
	 // '',                           /* curr_parole_flag */
	 // '',                           /* curr_parole_punishments */
	 // ''                            /* curr_stat_inm */
       
		    // }                       /* end of 7th record*/
		// ], DueDiligence.Layouts.CriminalOffenseLayout_by_DIDOffense);	

//=========================================================================
//=== For Creating Test Data in the format of the criminal offenses     ===
//=========================================================================
 // EXPORT MyFavorite_NONCONV_FELONY_3F_OVNYR := dataset(
 // [					
			// {                               /*TEST CASE #8*/  
	 // 96,                             /*seq */
  // 741130149,                      /*did*/
	 // 'NON CONVICTED FELONY OVER 3 YEARS AGO', /*offender_key*/
	 // 0,                               /*origdid*/
	 // 20171220,                       /*history date*/
	 // 20171220,                       /*todays date */
	 // 20171220,                       /*date to Use */
  // 0,                              /*# of days ago*/               //***1095 is exactly 3 years ago
	 // '',                             /* file date */
	 // '20141221',                     /* earliest offense date */
	 // '20141221',                     /* untouched earliest date */
	 // '2',                            /* dataType*/
	 // 'N',                            /* conviction flag */
	 // 'N',                            /* traffic flag */
	 // ' ',                            /* untouched offense score*/
	 // 'F',                            /* offense score */             //**values are 'U' or null = UNKOWN, 'M'= Misdemeanor, 'F'= Felony, 'T' = TRAFFIC, 'I'=Infraction.
	 // '3',                            /* criminal Offender Level */   //**values are 4 = NON-TRAFFIC/CONVICTED, 3 = NON-TRAFFIC/NOT-CONVICTED, 2 = TRAFFIC/CONVICTED, 1 = TRAFFIC/NOT-CONVICTED
	 // '',                           /* courtOffenseLevel  */
	 // '',                           /* courtStatute */
	 // '',                           /* courtStatuteDesc    */
	 // 'CASE EIGHT',                  /* caseNum     */
	 // '',                           /* caseCourt   */
	 // '',                           /* caseTypeDesc  */
	 // '',                           /* courtType   */
	 // 'CHARGED WITH FELONY',        /* charge      */
	 // 'DESC1         ',             /* courtDispDesc1 */
	 // 'DESC2         ',             /* courtDispDesc2  */
	 // '',                           /* offenseDate  */
	 // '',                           /* arrestDate  */
	 // '',                           /* courtDispDate */
	 // '',                           /* sentenceDate */
	 // '',                           /* appealDate  */
	 // '',                           /* countyOfOrigin   */
	 // 'TX',                         /* origState  */
	 // '',                           /* stc_desc_2   */
	 // 'FELONY',                     /* arr_off_lev_mapped   */
	 // '',                           /* court_off_lev_mapped */
	 // 'I',                          /* punishment_type */
	 // '',                           /* Curr_incarc_offenders */
	 // '',                           /* Curr_incarc_offenses */
	 // '',                           /* Curr_incarc_punishments */
	 // '',                           /* Ever_incarc_offenders*/
	 // '',                           /* Ever_incarc_offenses*/
	 // '',                           /* Ever_incarc_punishments */
	 // '',                           /* curr_parole_flag */
	 // '',                           /* curr_parole_punishments */
	 // ''                            /* curr_stat_inm */
       
		    // }                        /* END OF THE 8th RECORD*/
 // ], DueDiligence.Layouts.CriminalOffenseLayout_by_DIDOffense);	
				
//=========================================================================
//=== For Creating Test Data in the format of the criminal offenses     ===
//=========================================================================
 // EXPORT MyFavorite_NONCONV_UNKNOWN_3U_NYR := dataset(
 // [					
 		// {                             /*TEST CASE #9*/  
	 // 96,                             /*seq */
  // 741130149,                      /*did*/
	 // 'NON CONVICTED UNKNOWN IN PAST 3 YEARS', /*offender_key*/
	 // 0,                               /*origdid*/
	 // 20171220,                       /*history date*/
	 // 20171220,                       /*todays date */
	 // 20171220,                       /*date to Use */
  // 0,                              /*# of days ago*/               //***1095 is exactly 3 years ago
	 // '',                             /* file date */
	 // '20141220',                     /* earliest offense date */
	 // '20141220',                     /* untouched earliest date */
	 // '2',                            /* dataType*/
	 // 'N',                            /* conviction flag */
	 // 'N',                            /* traffic flag */
	 // ' ',                            /* untouched offense score*/
	 // 'U',                            /* offense score */             //**values are 'U' or null = UNKOWN, 'M'= Misdemeanor, 'F'= Felony, 'T' = TRAFFIC, 'I'=Infraction.
	 // '3',                             /* criminal Offender Level */   //**values are 4 = NON-TRAFFIC/CONVICTED, 3 = NON-TRAFFIC/NOT-CONVICTED, 2 = TRAFFIC/CONVICTED, 1 = TRAFFIC/NOT-CONVICTED
	 // '',                           /* courtOffenseLevel  */
	 // '',                           /* courtStatute */
	 // '',                           /* courtStatuteDesc    */
	 // 'CASE NINE',                  /* caseNum     */
	 // '',                           /* caseCourt   */
	 // '',                           /* caseTypeDesc  */
	 // '',                           /* courtType   */
	 // 'UNKNOWN',                     /* charge      */
	 // 'DESC1         ',             /* courtDispDesc1 */
	 // 'DESC2         ',             /* courtDispDesc2  */
	 // '',                           /* offenseDate  */
	 // '',                           /* arrestDate  */
	 // '',                           /* courtDispDate */
	 // '',                           /* sentenceDate */
	 // '',                           /* appealDate  */
	 // '',                           /* countyOfOrigin   */
	 // 'TX',                         /* origState  */
	 // '',                           /* stc_desc_2   */
	 // 'FELON',                     /* arr_off_lev_mapped   */
	 // '',                           /* court_off_lev_mapped */
	 // 'I',                          /* punishment_type */
	 // '',                           /* Curr_incarc_offenders */
	 // '',                           /* Curr_incarc_offenses */
	 // '',                           /* Curr_incarc_punishments */
	 // '',                           /* Ever_incarc_offenders*/
	 // '',                           /* Ever_incarc_offenses*/
	 // '',                           /* Ever_incarc_punishments */
	 // '',                           /* curr_parole_flag */
	 // '',                           /* curr_parole_punishments */
	 // ''                            /* curr_stat_inm */
       
		    // }                        /* END OF THE 9th RECORD*/ 
		// ], DueDiligence.Layouts.CriminalOffenseLayout_by_DIDOffense);	
		
//=========================================================================
//=== For Creating Test Data in the format of the criminal offenses     ===
//=========================================================================
 // EXPORT MyFavorite_NONCONV_UNKNOWN_3U_OVNYR := dataset(
 // [			
			// {                             /*TEST CASE #10*/  
	 // 96,                             /*seq */
  // 741130149,                      /*did*/
	 // 'NON CONVICTED UNKNOWN OVER 3 YEARS AGO', /*offender_key*/
	 // 0,                               /*origdid*/
	 // 20171220,                       /*history date*/
	 // 20171220,                       /*todays date */
	 // 20171220,                       /*date to Use */
  // 0,                              /*# of days ago*/               //***1095 is exactly 3 years ago
	 // '',                             /* file date */
	 // '20141221',                     /* earliest offense date */
	 // '20141221',                     /* untouched earliest date */
	 // '2',                            /* dataType*/
	 // 'N',                            /* conviction flag */
	 // 'N',                            /* traffic flag */
	 // ' ',                            /* untouched offense score*/
	 // 'U',                            /* offense score */             //**values are 'U' or null = UNKOWN, 'M'= Misdemeanor, 'F'= Felony, 'T' = TRAFFIC, 'I'=Infraction.
	 // '3',                             /* criminal Offender Level */   //**values are 4 = NON-TRAFFIC/CONVICTED, 3 = NON-TRAFFIC/NOT-CONVICTED, 2 = TRAFFIC/CONVICTED, 1 = TRAFFIC/NOT-CONVICTED
	 // '',                           /* courtOffenseLevel  */
	 // '',                           /* courtStatute */
	 // '',                           /* courtStatuteDesc    */
	 // 'CASE TEN',                  /* caseNum     */
	 // '',                           /* caseCourt   */
	 // '',                           /* caseTypeDesc  */
	 // '',                           /* courtType   */
	 // 'CHARGED WITH UNKNOWN',        /* charge      */
	 // 'DESC1         ',             /* courtDispDesc1 */
	 // 'DESC2         ',             /* courtDispDesc2  */
	 // '',                           /* offenseDate  */
	 // '',                           /* arrestDate  */
	 // '',                           /* courtDispDate */
	 // '',                           /* sentenceDate */
	 // '',                           /* appealDate  */
	 // '',                           /* countyOfOrigin   */
	 // 'TX',                         /* origState  */
	 // '',                           /* stc_desc_2   */
	 // 'FELON',                     /* arr_off_lev_mapped   */
	 // '',                           /* court_off_lev_mapped */
	 // 'I',                          /* punishment_type */
	 // '',                           /* Curr_incarc_offenders */
	 // '',                           /* Curr_incarc_offenses */
	 // '',                           /* Curr_incarc_punishments */
	 // '',                           /* Ever_incarc_offenders*/
	 // '',                           /* Ever_incarc_offenses*/
	 // '',                           /* Ever_incarc_punishments */
	 // '',                           /* curr_parole_flag */
	 // '',                           /* curr_parole_punishments */
	 // ''                            /* curr_stat_inm */
       
		    // }                        /* END OF THE 10th RECORD*/
	// ], DueDiligence.Layouts.CriminalOffenseLayout_by_DIDOffense);	

//=========================================================================
//=== For Creating Test Data in the format of the criminal offenses     ===
//=========================================================================
 // EXPORT MyFavorite_NONCONV_MISDEM_3M_NYR := dataset(
 // [					
				// {                            /*TEST CASE #11*/  
	 // 96,                             /*seq */
  // 741130149,                      /*did*/
	 // 'NON CONVICTED MISDE IN PAST 3 YEARS', /*offender_key*/
	 // 0,                               /*origdid*/
	 // 20171220,                       /*history date*/
	 // 20171220,                       /*todays date */
	 // 20171220,                       /*date to Use */
  // 0,                           /*# of days ago*/               //***1095 is exactly 3 years ago
	 // '',                             /* file date */
	 // '20141220',                     /* earliest offense date */
	 // '20141220',                     /* untouched earliest date */
	 // '2',                            /* dataType*/
	 // 'N',                            /* conviction flag */
	 // 'N',                            /* traffic flag */
	 // ' ',                            /* untouched offense score*/
	 // 'M',                            /* offense score */             //**values are 'U' or null = UNKOWN, 'M'= Misdemeanor, 'F'= Felony, 'T' = TRAFFIC, 'I'=Infraction.
	 // '3',                             /* criminal Offender Level */   //**values are 4 = NON-TRAFFIC/CONVICTED, 3 = NON-TRAFFIC/NOT-CONVICTED, 2 = TRAFFIC/CONVICTED, 1 = TRAFFIC/NOT-CONVICTED
	 // '',                           /* courtOffenseLevel  */
	 // '',                           /* courtStatute */
	 // '',                           /* courtStatuteDesc    */
	 // 'CASE ELEVEN',                  /* caseNum     */
	 // '',                           /* caseCourt   */
	 // '',                           /* caseTypeDesc  */
	 // '',                           /* courtType   */
	 // 'CHARGED WITH FELONY',        /* charge      */
	 // 'DESC1         ',             /* courtDispDesc1 */
	 // 'DESC2         ',             /* courtDispDesc2  */
	 // '',                           /* offenseDate  */
	 // '',                           /* arrestDate  */
	 // '',                           /* courtDispDate */
	 // '',                           /* sentenceDate */
	 // '',                           /* appealDate  */
	 // '',                           /* countyOfOrigin   */
	 // 'TX',                         /* origState  */
	 // '',                           /* stc_desc_2   */
	 // 'FELONY',                     /* arr_off_lev_mapped   */
	 // '',                           /* court_off_lev_mapped */
	 // 'I',                          /* punishment_type */
	 // '',                           /* Curr_incarc_offenders */
	 // '',                           /* Curr_incarc_offenses */
	 // '',                           /* Curr_incarc_punishments */
	 // '',                           /* Ever_incarc_offenders*/
	 // '',                           /* Ever_incarc_offenses*/
	 // '',                           /* Ever_incarc_punishments */
	 // '',                           /* curr_parole_flag */
	 // '',                           /* curr_parole_punishments */
	 // ''                            /* curr_stat_inm */
       
		    // }                        /* END OF THE 11th RECORD*/
	// ], DueDiligence.Layouts.CriminalOffenseLayout_by_DIDOffense);	

//=========================================================================
//=== For Creating Test Data in the format of the criminal offenses     ===
//=========================================================================
 // EXPORT MyFavorite_NONCONV_MISDEM_3M_OVNYR := dataset(
 // [					
												// {                      /*TEST CASE #12*/  
	 // 96,                             /*seq */
  // 741130149,                      /*did*/
	 // 'NON CONVICTED MISDE OVER 3 YEARS AGO', /*offender_key*/
	 // 0,                               /*origdid*/
	 // 20171220,                       /*history date*/
	 // 20171220,                       /*todays date */
	 // 20171220,                       /*date to Use */
  // 0,                           /*# of days ago*/               //***1095 is exactly 3 years ago
	 // '',                             /* file date */
	 // '20141221',                     /* earliest offense date */
	 // '20141221',                     /* untouched earliest date */
	 // '2',                            /* dataType*/
	 // 'N',                            /* conviction flag */
	 // 'N',                            /* traffic flag */
	 // ' ',                            /* untouched offense score*/
	 // 'M',                            /* offense score */             //**values are 'U' or null = UNKOWN, 'M'= Misdemeanor, 'F'= Felony, 'T' = TRAFFIC, 'I'=Infraction.
	 // '3',                             /* criminal Offender Level */   //**values are 4 = NON-TRAFFIC/CONVICTED, 3 = NON-TRAFFIC/NOT-CONVICTED, 2 = TRAFFIC/CONVICTED, 1 = TRAFFIC/NOT-CONVICTED
	 // '',                           /* courtOffenseLevel  */
	 // '',                           /* courtStatute */
	 // '',                           /* courtStatuteDesc    */
	 // 'CASE TWELVE',                  /* caseNum     */
	 // '',                           /* caseCourt   */
	 // '',                           /* caseTypeDesc  */
	 // '',                           /* courtType   */
	 // 'CHARGED WITH MISD',          /* charge      */
	 // 'DESC1         ',             /* courtDispDesc1 */
	 // 'DESC2         ',             /* courtDispDesc2  */
	 // '',                           /* offenseDate  */
	 // '',                           /* arrestDate  */
	 // '',                           /* courtDispDate */
	 // '',                           /* sentenceDate */
	 // '',                           /* appealDate  */
	 // '',                           /* countyOfOrigin   */
	 // 'TX',                         /* origState  */
	 // '',                           /* stc_desc_2   */
	 // 'FELONY',                     /* arr_off_lev_mapped   */
	 // '',                           /* court_off_lev_mapped */
	 // 'I',                          /* punishment_type */
	 // '',                           /* Curr_incarc_offenders */
	 // '',                           /* Curr_incarc_offenses */
	 // '',                           /* Curr_incarc_punishments */
	 // '',                           /* Ever_incarc_offenders*/
	 // '',                           /* Ever_incarc_offenses*/
	 // '',                           /* Ever_incarc_punishments */
	 // '',                           /* curr_parole_flag */
	 // '',                           /* curr_parole_punishments */
	 // ''                            /* curr_stat_inm */
       
		    // }                        /* END OF THE 12th RECORD*/ 
	// ], DueDiligence.Layouts.CriminalOffenseLayout_by_DIDOffense);	

//=========================================================================
//=== For Creating Test Data in the format of the criminal offenses     ===
//=========================================================================
 // EXPORT MyFavorite_CONVICTED_TRAFFIC_2T_NYR := dataset(
 // [			
			// {                             /*TEST CASE #13*/  
	 // 96,                             /*seq */
  // 741130149,                      /*did*/
	 // 'CONVICTED TRAFFIC IN PAST 3 YEARS', /*offender_key*/
	 // 0,                               /*origdid*/
	 // 20171220,                       /*history date*/
	 // 20171220,                       /*todays date */
	 // 20171220,                       /*date to Use */
  // 0,                           /*# of days ago*/               //***1095 is exactly 3 years ago
	 // '',                             /* file date */
	 // '20141220',                     /* earliest offense date */
	 // '20141220',                     /* untouched earliest date */
	 // '2',                            /* dataType*/
	 // 'N',                            /* conviction flag */
	 // 'N',                            /* traffic flag */
	 // ' ',                            /* untouched offense score*/
	 // 'T',                            /* offense score */             //**values are 'U' or null = UNKOWN, 'M'= Misdemeanor, 'F'= Felony, 'T' = TRAFFIC, 'I'=Infraction.
	 // '2',                             /* criminal Offender Level */   //**values are 4 = NON-TRAFFIC/CONVICTED, 3 = NON-TRAFFIC/NOT-CONVICTED, 2 = TRAFFIC/CONVICTED, 1 = TRAFFIC/NOT-CONVICTED
	 // '',                           /* courtOffenseLevel  */
	 // '',                           /* courtStatute */
	 // '',                           /* courtStatuteDesc    */
	 // 'CASE THIRTEEN',                  /* caseNum     */
	 // '',                           /* caseCourt   */
	 // '',                           /* caseTypeDesc  */
	 // '',                           /* courtType   */
	 // 'CHARGED WITH FELONY',        /* charge      */
	 // 'DESC1         ',             /* courtDispDesc1 */
	 // 'DESC2         ',             /* courtDispDesc2  */
	 // '',                           /* offenseDate  */
	 // '',                           /* arrestDate  */
	 // '',                           /* courtDispDate */
	 // '',                           /* sentenceDate */
	 // '',                           /* appealDate  */
	 // '',                           /* countyOfOrigin   */
	 // 'TX',                         /* origState  */
	 // '',                           /* stc_desc_2   */
	 // 'FELONY',                     /* arr_off_lev_mapped   */
	 // '',                           /* court_off_lev_mapped */
	 // 'I',                          /* punishment_type */
	 // '',                           /* Curr_incarc_offenders */
	 // '',                           /* Curr_incarc_offenses */
	 // '',                           /* Curr_incarc_punishments */
	 // '',                           /* Ever_incarc_offenders*/
	 // '',                           /* Ever_incarc_offenses*/
	 // '',                           /* Ever_incarc_punishments */
	 // '',                           /* curr_parole_flag */
	 // '',                           /* curr_parole_punishments */
	 // ''                            /* curr_stat_inm */
       
		    // }                        /* END OF THE 13th RECORD*/
	// ], DueDiligence.Layouts.CriminalOffenseLayout_by_DIDOffense);	

//=========================================================================
//=== For Creating Test Data in the format of the criminal offenses     ===
//=========================================================================
 // EXPORT MyFavorite_CONVICTED_TRAFFIC_2T_OVNYR := dataset(
 // [					
			// {                               /*TEST CASE #14*/  
	 // 96,                             /*seq */
  // 741130149,                      /*did*/
	 // 'CONVICTED TRAFFIC OVER 3 YEARS AGO', /*offender_key*/
	 // 0,                               /*origdid*/
	 // 20171220,                       /*history date*/
	 // 20171220,                       /*todays date */
	 // 20171220,                       /*date to Use */
  // 0,                           /*# of days ago*/               //***1095 is exactly 3 years ago
	 // '',                             /* file date */
	 // '20141221',                     /* earliest offense date */
	 // '20141221',                     /* untouched earliest date */
	 // '2',                            /* dataType*/
	 // 'N',                            /* conviction flag */
	 // 'N',                            /* traffic flag */
	 // ' ',                            /* untouched offense score*/
	 // 'T',                            /* offense score */              //**values are 'U' or null = UNKOWN, 'M'= Misdemeanor, 'F'= Felony, 'T' = TRAFFIC, 'I'=Infraction.
	 // '2',                             /* criminal Offender Level */   //**values are 4 = NON-TRAFFIC/CONVICTED, 3 = NON-TRAFFIC/NOT-CONVICTED, 2 = TRAFFIC/CONVICTED, 1 = TRAFFIC/NOT-CONVICTED
	 // '',                           /* courtOffenseLevel  */
	 // '',                           /* courtStatute */
	 // '',                           /* courtStatuteDesc    */
	 // 'CASE EIGHT',                  /* caseNum     */
	 // '',                           /* caseCourt   */
	 // '',                           /* caseTypeDesc  */
	 // '',                           /* courtType   */
	 // 'CHARGED WITH FELONY',        /* charge      */
	 // 'DESC1         ',             /* courtDispDesc1 */
	 // 'DESC2         ',             /* courtDispDesc2  */
	 // '',                           /* offenseDate  */
	 // '',                           /* arrestDate  */
	 // '',                           /* courtDispDate */
	 // '',                           /* sentenceDate */
	 // '',                           /* appealDate  */
	 // '',                           /* countyOfOrigin   */
	 // 'TX',                         /* origState  */
	 // '',                           /* stc_desc_2   */
	 // 'FELONY',                     /* arr_off_lev_mapped   */
	 // '',                           /* court_off_lev_mapped */
	 // 'I',                          /* punishment_type */
	 // '',                           /* Curr_incarc_offenders */
	 // '',                           /* Curr_incarc_offenses */
	 // '',                           /* Curr_incarc_punishments */
	 // '',                           /* Ever_incarc_offenders*/
	 // '',                           /* Ever_incarc_offenses*/
	 // '',                           /* Ever_incarc_punishments */
	 // '',                           /* curr_parole_flag */
	 // '',                           /* curr_parole_punishments */
	 // ''                            /* curr_stat_inm */
       
		    // }                        /* END OF THE 14th RECORD*/ 
				
		// ], DueDiligence.Layouts.CriminalOffenseLayout_by_DIDOffense);	

//=========================================================================
//=== For Creating Test Data in the format of the criminal offenses     ===
//=========================================================================
 // EXPORT MyFavorite_CONVICTED_INFRACTION_2I_NYR := dataset(
 // [				
												// {                      /*TEST CASE #15*/  
	 // 96,                             /*seq */
  // 741130149,                      /*did*/
	 // 'CONVICTED INFRACTION IN PAST 3 YEARS', /*offender_key*/
	 // 0,                               /*origdid*/
	 // 20171220,                       /*history date*/
	 // 20171220,                       /*todays date */
	 // 20171220,                       /*date to Use */
  // 0,                           /*# of days ago*/               //***1095 is exactly 3 years ago
	 // '',                             /* file date */
	 // '20141220',                     /* earliest offense date */
	 // '20141220',                     /* untouched earliest date */
	 // '2',                            /* dataType*/
	 // 'N',                            /* conviction flag */
	 // 'N',                            /* traffic flag */
	 // ' ',                            /* untouched offense score*/
	 // 'I',                            /* offense score */             //**values are 'U' or null = UNKOWN, 'M'= Misdemeanor, 'F'= Felony, 'T' = TRAFFIC, 'I'=Infraction.
	 // '2',                             /* criminal Offender Level */   //**values are 4 = NON-TRAFFIC/CONVICTED, 3 = NON-TRAFFIC/NOT-CONVICTED, 2 = TRAFFIC/CONVICTED, 1 = TRAFFIC/NOT-CONVICTED
	 // '',                           /* courtOffenseLevel  */
	 // '',                           /* courtStatute */
	 // '',                           /* courtStatuteDesc    */
	 // 'CASE FIFTEEN',                  /* caseNum     */
	 // '',                           /* caseCourt   */
	 // '',                           /* caseTypeDesc  */
	 // '',                           /* courtType   */
	 // 'CHARGED WITH FELONY',        /* charge      */
	 // 'DESC1         ',             /* courtDispDesc1 */
	 // 'DESC2         ',             /* courtDispDesc2  */
	 // '',                           /* offenseDate  */
	 // '',                           /* arrestDate  */
	 // '',                           /* courtDispDate */
	 // '',                           /* sentenceDate */
	 // '',                           /* appealDate  */
	 // '',                           /* countyOfOrigin   */
	 // 'TX',                         /* origState  */
	 // '',                           /* stc_desc_2   */
	 // 'FELONY',                     /* arr_off_lev_mapped   */
	 // '',                           /* court_off_lev_mapped */
	 // 'I',                          /* punishment_type */
	 // '',                           /* Curr_incarc_offenders */
	 // '',                           /* Curr_incarc_offenses */
	 // '',                           /* Curr_incarc_punishments */
	 // '',                           /* Ever_incarc_offenders*/
	 // '',                           /* Ever_incarc_offenses*/
	 // '',                           /* Ever_incarc_punishments */
	 // '',                           /* curr_parole_flag */
	 // '',                           /* curr_parole_punishments */
	 // ''                            /* curr_stat_inm */
       
		    // }                        /* END OF THE 15th RECORD*/ 
				
		// ], DueDiligence.Layouts.CriminalOffenseLayout_by_DIDOffense);	

//=========================================================================
//=== For Creating Test Data in the format of the criminal offenses     ===
//=========================================================================
 // EXPORT MyFavorite_CONVICTED_INFRACTION_2I_OVNYR := dataset(
 // [					
												// {                      /*TEST CASE #16*/  
	 // 96,                             /*seq */
  // 741130149,                      /*did*/
	 // 'CONVICTED INFRACTION OVER 3 YEARS AGO', /*offender_key*/
	 // 0,                               /*origdid*/
	 // 20171220,                       /*history date*/
	 // 20171220,                       /*todays date */
	 // 20171220,                       /*date to Use */
  // 0,                           /*# of days ago*/               //***1095 is exactly 3 years ago
	 // '',                             /* file date */
	 // '20141221',                     /* earliest offense date */
	 // '20141221',                     /* untouched earliest date */
	 // '2',                            /* dataType*/
	 // 'N',                            /* conviction flag */
	 // 'N',                            /* traffic flag */
	 // ' ',                            /* untouched offense score*/
	 // 'I',                            /* offense score */             //**values are 'U' or null = UNKOWN, 'M'= Misdemeanor, 'F'= Felony, 'T' = TRAFFIC, 'I'=Infraction.
	 // '2',                             /* criminal Offender Level */   //**values are 4 = NON-TRAFFIC/CONVICTED, 3 = NON-TRAFFIC/NOT-CONVICTED, 2 = TRAFFIC/CONVICTED, 1 = TRAFFIC/NOT-CONVICTED
	 // '',                           /* courtOffenseLevel  */
	 // '',                           /* courtStatute */
	 // '',                           /* courtStatuteDesc    */
	 // 'CASE SIXTEEN',                  /* caseNum     */
	 // '',                           /* caseCourt   */
	 // '',                           /* caseTypeDesc  */
	 // '',                           /* courtType   */
	 // 'CHARGED WITH INFRACTION',        /* charge      */
	 // 'DESC1         ',             /* courtDispDesc1 */
	 // 'DESC2         ',             /* courtDispDesc2  */
	 // '',                           /* offenseDate  */
	 // '',                           /* arrestDate  */
	 // '',                           /* courtDispDate */
	 // '',                           /* sentenceDate */
	 // '',                           /* appealDate  */
	 // '',                           /* countyOfOrigin   */
	 // 'TX',                         /* origState  */
	 // '',                           /* stc_desc_2   */
	 // 'FELONY',                     /* arr_off_lev_mapped   */
	 // '',                           /* court_off_lev_mapped */
	 // 'I',                          /* punishment_type */
	 // '',                           /* Curr_incarc_offenders */
	 // '',                           /* Curr_incarc_offenses */
	 // '',                           /* Curr_incarc_punishments */
	 // '',                           /* Ever_incarc_offenders*/
	 // '',                           /* Ever_incarc_offenses*/
	 // '',                           /* Ever_incarc_punishments */
	 // '',                           /* curr_parole_flag */
	 // '',                           /* curr_parole_punishments */
	 // ''                            /* curr_stat_inm */					
		    // }                        /* END OF THE LAST RECORD*/  
				
 // ], DueDiligence.Layouts.CriminalOffenseLayout_by_DIDOffense);	
 

											
END;                   // end of the MODULE
	





/*
//For testing you'd just concat the compan(y/ies) you want to test in your script and then Project into a DueDiligence.Layout.Input (see below)

companiesUnderTest := DueDiligence.ForTesting_Business_LAF.AMMATAC + DueDiligence.ForTesting_Business_LAF.DOC_BROWN_PIZZA + DueDiligence.ForTesting_Business_LAF.CRESTVIEW + 
											DueDiligence.ForTesting_Business_LAF.FAKE + DueDiligence.ForTesting_Business_LAF.TARGET_CORP + DueDiligence.ForTesting_Business_LAF.TARGET_STORE


input := PROJECT(companiesUnderTest, TRANSFORM(DueDiligence.Layouts.Input,						 
													SELF.Seq := LEFT.seq;
													SELF.historyDateYYYYMMDD := IF(LEFT.HistoryDateYYYYMM = 0, DueDiligence.Constants.date8Nines, LEFT.HistoryDateYYYYMM);
													SELF.business := DATASET([TRANSFORM(DueDiligence.Layouts.Busn_Input,
																																SELF.companyName := LEFT.companyName;
																																SELF.phone := LEFT.companyPhone;
																																SELF.fein := LEFT.companyFEIN;
																																SELF.accountNumber := LEFT.accountNumber;
																																SELF.address := DATASET([TRANSFORM(DueDiligence.Layouts.Address,
																																																		SELF.streetAddress1 := LEFT.streetAddress1;
																																																		SELF.streetAddress2 := LEFT.streetAddress2;
																																																		SELF.city := LEFT.city;
																																																		SELF.state := LEFT.state;
																																																		SELF.zip5 := LEFT.zip;
																																																		SELF := [];)])[1];
																																SELF := [];)])[1];
													SELF := [];
												)
										);
			

*/