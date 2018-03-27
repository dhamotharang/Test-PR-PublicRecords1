// PRTE2_X_Ins_PropertyScramble.U_BWR_SSN_From_Orig50k_V2
// After running the first time, there were still a number that the addresses didn't quite match
// so if SSN blank try copying it from the JOIN with just name.

IMPORT PRTE2_X_Ins_PropertyScramble, ut, RoxieKeyBuild;

fileVersion := ut.GetDate+'';

DS1 := PRTE2_X_Ins_PropertyScramble.Files.XRef_Enhanced_SF_DS;
DS1a := DS1(SSN='');
DS1b := DS1(SSN<>'');

DS2 := PRTE2_X_Ins_PropertyScramble.Files.BASE_50k_DS;

outLayout := PRTE2_X_Ins_PropertyScramble.Layouts.Layout_Base_XRef_Enhanced;
outLayout XFER(DS1a L, ds2 R) := TRANSFORM
	SELF.SSN := R.SSN;
	SELF := L;
END;

DS3 := JOIN(DS1a, DS2,
						left.fname = right.fname AND
						left.mname = right.mname AND
						(left.lname = right.lname OR left.lname = right.lname+' '+right.lname2 )
						// matching just by name if the SSN was left blank.
				,XFER( left, right )
				,left outer
				);
				
OUTPUT(COUNT(DS1b));
OUTPUT(COUNT(DS1a));
OUTPUT(COUNT(DS2));
OUTPUT(COUNT(CHOOSEN(DS3,1000)));
DS4a := DS1b+DS3;
DS4b := SORT(DS4a,recnum);
DS4 := DEDUP(DS4b,recnum);
OUTPUT(COUNT(DS4));
// OUTPUT(DS1);
OUTPUT(DS4);

RoxieKeyBuild.Mac_SF_BuildProcess_V2(DS4,
																		 PRTE2_X_Ins_PropertyScramble.Files.BASE_PREFIX_NAME_ENXRef, 
																		 PRTE2_X_Ins_PropertyScramble.Files.ENHANCED_NAME_BASE,
																		 fileVersion, buildXRefEnhanced, 3,
																		 false,true);

SEQUENTIAL(buildXRefEnhanced);