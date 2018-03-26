IMPORT PRTE2_Header_Ins, ut, PRTE2_Common, prte_csv, PRTE2_X_DataCleanse, STD;

Alpha_Base_DS         := PRTE2_Header_Ins.Files.HDR_BASE_ALPHA_DS; //52560 
Alpha_Base_DS_Dedup		:= DEDUP(SORT(Alpha_Base_DS,DID),DID);   //52560 No Duplicates by DID


Alpha_Base_DS_Dedup_ssn		:= DEDUP(SORT(Alpha_Base_DS(ssn<>'' and ssn<>'000000000' ),ssn),ssn);   //52560 No Duplicates by SSN
// count(Alpha_Base_DS(ssn='')); //73
// count(alpha_base_ds(ssn='000000000')); //487
Alpha_Base_SSN_Empty  := Alpha_Base_DS_Dedup(ssn ='');  //73 records SSN=''
ExperianSSN           := PRTE2_X_Ins_DataCleanse.Files.Experian_SSN_Cross_Reference; //50544

/* ************************************************************************
***********************  Part I: Duplicates SSNs in Experian ************** 
************************************************************************* */

Alpha := project(Alpha_Base_DS_Dedup, {unsigned s_did, unsigned did, string fname, string mname, string lname, string ssn, STRING ST, STRING ZIP});
// Alpha;
// ExperianSSN;
ExperianSSN_DEDUP_oldssn := dedup(sort(ExperianSSN, old_ssn), old_ssn); // 50348
// COUNT(ExperianSSN_DEDUP_oldssn);

ExperianSSN_DEDUP_newssn := dedup(sort(ExperianSSN, new_ssn), new_ssn); // 50336
// COUNT(ExperianSSN_DEDUP_newssn);

ExperianSSN_oldSSN_check := TABLE(ExperianSSN, {old_ssn, unsigned cnt := count(group)}, old_ssn);
OLD_SSN_Dup_List         := SET(ExperianSSN_oldSSN_check(cnt<>1), OLD_SSN);
oldDupResult             := CHOOSEN(ExperianSSN(old_ssn in OLD_SSN_Dup_List), ALL); //391
// oldDupResult;

Alpha_oldDupResult       := CHOOSEN(Alpha(SSN in OLD_SSN_Dup_List), ALL); //375
// Alpha_oldDupResult;


ExperianSSN_newSSN_check :=  TABLE(ExperianSSN, {new_ssn, unsigned cnt := count(group)}, new_ssn);
// ExperianSSN_newSSN_check(cnt<>1);
New_SSN_Dup_List         :=  SET(ExperianSSN_newSSN_check(cnt<>1), new_ssn);
newDupResult             :=  CHOOSEN(ExperianSSN(new_ssn in New_SSN_Dup_List), ALL); //415
// newDupResult;
Alpha_newDupResult       :=  CHOOSEN(Alpha(SSN in New_SSN_Dup_List), ALL); //18
// Alpha_newDupResult;

Alpha_PartI_DS := Alpha_newDupResult + Alpha_oldDupResult;//393
// count(Alpha_PartI_DS); 
Alpha_PartI_List   := SET(Alpha_newDupResult + Alpha_oldDupResult, DID);
Alpha_afterPartI_DS := Alpha(DID not in Alpha_PartI_List);//52167
// Count(Alpha(DID not in Alpha_ExperianDup_List)); 
// Alpha_Check := Alpha(SSN not in New_SSN_Dup_List AND SSN not in OLD_SSN_Dup_List)	;		
// count(Alpha_Check); //52167

/*----------------------------------------------------
  Define the result data layout and transform process
------------------------------------------------------*/
OUT_LAYOUT := RECORD
	recordof(Alpha);
	string9  A_SSN;
  string9  NEW_SSN;
  string9  E_SSN;
	string  E_fname;
	string  E_mname;
	string  E_lname;
	string  E_ST;
	string  E_ZIP;
END;

OUT_LAYOUT xGetFixSSN(Alpha L,  ExperianSSN R) :=TRANSFORM
  // SELF.NEW_SSN := (string)R.NEW_SSN;
	SELF := L;
  SELF.NEW_SSN := R.NEW_SSN;
  SELF.E_SSN   := R.OLD_SSN;
	// STD.STr.SplitWords(R.lname, '');
  SELF.E_fname   := R.fname;
  SELF.E_mname   := R.mname;
	Elname :=STD.STr.SplitWords(R.lname, ' ');
  SELF.E_lname   := Elname[1];
  SELF.E_ST      := R.STATE[1..5];
  SELF.E_ZIP     := R.ZIP;
	SELF.A_SSN     := L.SSN;
END;

OUT_LAYOUT xGetFixSSN1(Alpha L,  ExperianSSN R) :=TRANSFORM
  // SELF.NEW_SSN := (string)R.NEW_SSN;
	SELF := L;
  SELF.NEW_SSN := R.NEW_SSN;
  SELF.E_SSN   := R.OLD_SSN;
  SELF.E_fname   := R.fname;
  SELF.E_mname   := R.mname;
  SELF.E_lname   := R.lname;
  SELF.E_ST      := R.STATE[1..5];
  SELF.E_ZIP     := R.ZIP;
	SELF.A_SSN     := L.SSN;
END;	

//-------------------------------------------------------------

//I_1. Check Part I Alpha Data 
COMMON_PartI_OldSSN := JOIN(Alpha_oldDupResult, oldDupResult, 
                  LEFT.SSN = RIGHT.OLD_SSN
									AND LEFT.FNAME = RIGHT.FNAME
									AND LEFT.MNAME = RIGHT.MNAME
									AND LEFT.LNAME = STD.STr.SplitWords(RIGHT.lname, ' ')[1]
									// AND LEFT.ST = RIGHT.STATE,
									// AND LEFT.ZIP = RIGHT.ZIP,
									,xGetFixSSN(LEFT, RIGHT),
									inner); //375
									// full only); //16
// COMMON_PartI_OldSSN; 
// COUNT(COMMON_PartI_OldSSN); 
COMMON_PartI_OldSSN_RS :=	CHOOSEN(COMMON_PartI_OldSSN, ALL);
COMMON_PartI_OldSSN_RS;
								

COMMON_PartI_NewSSN := JOIN(Alpha_newDupResult, newDupResult, 
                  LEFT.SSN = RIGHT.NEW_SSN
									AND LEFT.FNAME = RIGHT.FNAME
									AND LEFT.MNAME = RIGHT.MNAME
									AND LEFT.LNAME = STD.STr.SplitWords(RIGHT.lname, ' ')[1]
									// AND LEFT.ST = RIGHT.STATE,
									// AND LEFT.ZIP = RIGHT.ZIP,
									,xGetFixSSN(LEFT, RIGHT),
									inner); //17
									// full only); //399
// COMMON_PartI_NewSSN; 
// COUNT(COMMON_PartI_NewSSN); 
COMMON_PartI_NewSSN_RS :=	CHOOSEN(COMMON_PartI_NewSSN, ALL);
COMMON_PartI_NewSSN_RS;
									

/* *****************************************************************************************************
*********************** Part II: Common SSNs Check by Transform fun:xGetFixSSN *************************
******************************************************************************************************** */
COMMON_partII_OLDSSN := JOIN(Alpha_afterPartI_DS, ExperianSSN, //47911
                  LEFT.SSN = RIGHT.OLD_SSN
									AND LEFT.FNAME = RIGHT.FNAME
									AND LEFT.MNAME = RIGHT.MNAME
									AND LEFT.LNAME = STD.STr.SplitWords(RIGHT.lname, ' ')[1]
									// AND LEFT.ST = RIGHT.STATE,
									// AND LEFT.ZIP = RIGHT.ZIP,
									,xGetFixSSN(LEFT, RIGHT));	
COMMON_partII_OLDSSN_RS := CHOOSEN(COMMON_partII_OLDSSN, ALL);; //47911
COMMON_partII_OLDSSN_RS;
// COUNT(COMMON_partII_OLDSSN);
// */

COMMON_partII_NEWSSN := JOIN(Alpha_afterPartI_DS, ExperianSSN, //1963
                  LEFT.SSN = RIGHT.New_SSN
									AND LEFT.FNAME = RIGHT.FNAME
									AND LEFT.MNAME = RIGHT.MNAME
									AND LEFT.LNAME = STD.STr.SplitWords(RIGHT.lname, ' ')[1]
									// AND LEFT.ST = RIGHT.STATE,
									// AND LEFT.ZIP = RIGHT.ZIP,
									,xGetFixSSN(LEFT, RIGHT));	
// COMMON_partII_NEWSSN; 
COMMON_partII_NEWSSN_RS := CHOOSEN(COMMON_partII_NEWSSN, ALL);; //1963
COMMON_partII_NEWSSN_RS;
// COUNT(COMMON_partII_NEWSSN);

COMMON_PartII_DS  := COMMON_partII_OLDSSN + COMMON_partII_NEWSSN; // 49874 = 47911 + 1963
Alpha_PartII_List := SET(COMMON_PartII_DS, DID);
/*
Alpha_afterPartII_DS := Alpha(DID not in Alpha_PartII_List);

COUNT(Alpha_afterPartII_DS); //2687
Alpha_afterPartII_DS; 
COUNT(Alpha(DID  in Alpha_PartII_List)); //49874
*/
Alpha_afterPartII_DS := CHOOSEN(Alpha_afterPartI_DS(DID not in Alpha_PartII_List), ALL); //2293
Alpha_afterPartII_DS;

COUNT(Alpha_afterPartII_DS); //2294
// COUNT(Alpha_afterPartI_DS(DID in Alpha_PartII_List)); // 49874 
// COUNT(Alpha(DID in Alpha_PartII_List)); //49873
// COUNT(Alpha(DID not in Alpha_PartII_List AND SSN not in New_SSN_Dup_List AND SSN not in OLD_SSN_Dup_List)); //2293 



/* ************************************************************************
************** Part III: Common PPL Check by name+state *******************
************************************************************************* */
/*
COMMON_PartIII_PPL := JOIN(Alpha_afterPartII_DS, ExperianSSN, // 59
// COMMON_LastCheck := JOIN(Alpha(DID not in COMMON_outofLIST AND SSN not in New_SSN_Dup_List AND SSN not in OLD_SSN_Dup_List), ExperianSSN, // 
                  // LEFT.SSN = RIGHT.NEW_SSN
									LEFT.FNAME = RIGHT.FNAME
									AND LEFT.MNAME = RIGHT.MNAME
									AND LEFT.LNAME = STD.STr.SplitWords(RIGHT.lname, ' ')[1]
									AND LEFT.ST = RIGHT.STATE
									// AND LEFT.ZIP = RIGHT.ZIP[1..5]
									,xGetFixSSN(LEFT, RIGHT)
									// ,LEFT OUTER // Left outer by Fname + Mname+ Lname + ST
									);	// Default 59 by Fname + Mname+ Lname + ST
			
COMMON_PartIII_PPL_RS := CHOOSEN(COMMON_PartIII_PPL ,ALL); //59
COUNT(COMMON_PartIII_PPL_RS); //59
COMMON_PartIII_PPL_RS;

Alpha_PartIII_LIST := SET(COMMON_PartIII_PPL_RS, DID);
Alpha_afterPartIII_DS    := CHOOSEN(Alpha_afterPartII_DS(DID not in Alpha_PartIII_LIST), ALL); //2237
// COUNT(Alpha_afterPartIII_DS); //2237
Alpha_afterPartIII_DS;

*/

/* *************************************************************************************
************** Part III: Common SSNs Check by Transform fun:xGetFixSSN1 ****************
**************************************************************************************** */
COMMON_partIII_OLDSSN := JOIN(Alpha_afterPartII_DS(ssn <> '' and ssn <>'000000000'), ExperianSSN, // 168 --All of them are good. Just substitute SSN with New_SSN
                  LEFT.SSN = RIGHT.OLD_SSN
								  // AND LEFT.FNAME = RIGHT.FNAME
									// AND LEFT.MNAME = RIGHT.MNAME
									// AND LEFT.LNAME = STD.STr.SplitWords(RIGHT.lname, ' ')[1]
									// AND LEFT.ST = RIGHT.STATE
									// AND LEFT.ZIP = RIGHT.ZIP[1..5]
									,xGetFixSSN(LEFT, RIGHT)
									// ,LEFT OUTER // Left outer by Fname + Mname+ Lname + ST
									);	
									
COMMON_partIII_OLDSSN_RS := CHOOSEN(COMMON_partIII_OLDSSN, ALL); // 168
COMMON_partIII_OLDSSN_RS;// 168
// COUNT(COMMON_partIII_OLDSSN_RS); // 168


COMMON_partIII_NewSSN := JOIN(Alpha_afterPartII_DS(ssn <> '' and ssn <>'000000000'), ExperianSSN, // 359 --All of them are good. Do not need to change anything.
                  LEFT.SSN = RIGHT.NEW_SSN
								  // AND LEFT.FNAME = RIGHT.FNAME
									// AND LEFT.MNAME = RIGHT.MNAME
									// AND LEFT.LNAME = STD.STr.SplitWords(RIGHT.lname, ' ')[1]
									// AND LEFT.ST = RIGHT.STATE
									// AND LEFT.ZIP = RIGHT.ZIP[1..5]
									,xGetFixSSN(LEFT, RIGHT)
									// ,LEFT OUTER // Left outer by Fname + Mname+ Lname + ST
									);	
									
COMMON_partIII_NewSSN_RS := CHOOSEN(COMMON_partIII_NewSSN, ALL); // 359
COMMON_partIII_NewSSN_RS; // 359
// COUNT(COMMON_partIII_NewSSN_RS); // 359

COMMON_partIII_DS     := COMMON_partIII_OLDSSN + COMMON_partIII_NewSSN ; 
Alpha_partIII_LIST    := SET(COMMON_partIII_DS, DID);
Alpha_afterPartIII_DS := CHOOSEN(Alpha_afterPartII_DS(DID not in Alpha_partIII_LIST), ALL); //1767 = 2294- 168 - 359
Alpha_afterPartIII_DS; 

// count(Alpha_afterPartII_DS(DID in Alpha_partIII_LIST)); //527

/* *************************************************************************************
************** Part IV: Common SSNs Fianl Check by Transform fun:xGetFixSSN1 ****************
**************************************************************************************** */
Alpha_partIV_unemptyDS := CHOOSEN(Alpha_afterPartIII_DS(ssn <> '' and ssn <>'000000000'), ALL); //1208
Alpha_partIV_unemptyDS;

COMMON_partIV_NewSSN := JOIN(Alpha_afterPartIII_DS(ssn <> '' and ssn <>'000000000'), ExperianSSN, 
                  LEFT.SSN = RIGHT.NEW_SSN
								  // AND LEFT.FNAME = RIGHT.FNAME
									// AND LEFT.MNAME = RIGHT.MNAME
									// AND LEFT.LNAME = STD.STr.SplitWords(RIGHT.lname, ' ')[1]
									// AND LEFT.ST = RIGHT.STATE
									// AND LEFT.ZIP = RIGHT.ZIP[1..5]
									,xGetFixSSN(LEFT, RIGHT)
									// ,LEFT OUTER // Left outer by Fname + Mname+ Lname + ST
									);	//0
COMMON_partIV_NewSSN_DS := CHOOSEN(COMMON_partIV_NewSSN , ALL);
COMMON_partIV_NewSSN_DS;


COMMON_partIV_OLDSSN := JOIN(Alpha_afterPartIII_DS(ssn <> '' and ssn <>'000000000'), ExperianSSN, 
                  LEFT.SSN = RIGHT.NEW_SSN
								  // AND LEFT.FNAME = RIGHT.FNAME
									// AND LEFT.MNAME = RIGHT.MNAME
									// AND LEFT.LNAME = STD.STr.SplitWords(RIGHT.lname, ' ')[1]
									// AND LEFT.ST = RIGHT.STATE
									// AND LEFT.ZIP = RIGHT.ZIP[1..5]
									,xGetFixSSN(LEFT, RIGHT) //0
									// ,LEFT OUTER // Left outer by Fname + Mname+ Lname + ST
									);	
COMMON_partIV_OLDSSN_DS := CHOOSEN(COMMON_partIV_OLDSSN , ALL);									
COMMON_partIV_OLDSSN_DS;
//OR
ExperianSSN_NewSSN_LIST := SET(ExperianSSN, NEW_SSN);
ExperianSSN_OldSSN_LIST := SET(ExperianSSN, OLD_SSN);

// COUNT(Alpha_afterPartIII_DS_Empty);
// COUNT(Alpha_afterPartIII_DS(ssn ='000000000')); //487
// COUNT(Alpha_afterPartIII_DS(ssn ='')); //72
// COUNT(Alpha_afterPartIII_DS(ssn = '' OR ssn ='000000000')); //559

Alpha_partIV_unemptyDS(SSN in ExperianSSN_NewSSN_LIST OR SSN in ExperianSSN_OldSSN_LIST); //0

/* *******************************************************************
************** Part V: Check PPL and Assign the Possible SSNs ****************
********************************************************************* */
COMMON_partV_PPL := JOIN(Alpha_afterPartIII_DS(ssn = '' OR ssn ='000000000'), ExperianSSN, 
                  // LEFT.SSN = RIGHT.OLD_SSN
								  LEFT.FNAME = RIGHT.FNAME									
									AND LEFT.MNAME = RIGHT.MNAME
									AND LEFT.LNAME = STD.STr.SplitWords(RIGHT.lname, ' ')[1]
									AND LEFT.ST = RIGHT.STATE
									// AND LEFT.ZIP = RIGHT.ZIP[1..5]
									,xGetFixSSN(LEFT, RIGHT)
									// ,LEFT OUTER // Left outer by Fname + Mname+ Lname + ST
									);	
									
COMMON_partV_PPL_DS := CHOOSEN(COMMON_partV_PPL, ALL);
COMMON_partV_PPL_DS;


/* *******************************************************************
More Research => THere is no necessary to think about the SSN whichi is empty and 000000000 
********************************************************************* */
/*
DS := CHOOSEN(Alpha(SSN not in ExperianSSN_NewSSN_LIST AND SSN not in ExperianSSN_OldSSN_LIST), ALL); //1695 = 1208 +487
DS;

Alpha_SSN_LIST := SET(Alpha, SSN);
DS1 := CHOOSEN(ExperianSSN(OLD_SSN not in Alpha_SSN_LIST and New_SSN not in Alpha_SSN_LIST), ALL); //123
DS1;

COMMON_partV_PPL1 := JOIN(Alpha_afterPartIII_DS(ssn = '' OR ssn ='000000000'), DS1, 
                  // LEFT.SSN = RIGHT.OLD_SSN
								  LEFT.FNAME = RIGHT.FNAME									
									AND LEFT.MNAME = RIGHT.MNAME
									AND LEFT.LNAME = STD.STr.SplitWords(RIGHT.lname, ' ')[1]
									AND LEFT.ST = RIGHT.STATE
									// AND LEFT.ZIP = RIGHT.ZIP[1..5]
									,xGetFixSSN(LEFT, RIGHT)
									// ,LEFT OUTER // Left outer by Fname + Mname+ Lname + ST
									);	
									
COMMON_partV_PPL_DS1 := CHOOSEN(COMMON_partV_PPL1, ALL);
COMMON_partV_PPL_DS1;
*/

/* **************************************************************************
******************Part VI Output All the SSNs Need to Fix  ******************
*************************************************************************** */

SSN_needFix := COMMON_PartI_OldSSN + COMMON_partII_OLDSSN + COMMON_partIII_OLDSSN;
COUNT(SSN_needFix); //48454
OUTPUT(SSN_needFix,, '~prct::BASE::ct::alpharetta::PeopleHeader_Base_NeedFix::20150903');