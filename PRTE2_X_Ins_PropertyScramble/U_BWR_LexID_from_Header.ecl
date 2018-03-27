// PRTE2_X_Ins_PropertyScramble.U_BWR_LexID_from_Header
// After running the first time, there were still a number that the addresses didn't quite match
// so if SSN blank try copying it from the JOIN with just name.

IMPORT ut, RoxieKeyBuild, PRTE2_Header_Ins;

fileVersion := ut.GetDate+'';

DS1 := PRTE2_X_Ins_PropertyScramble.Files.XRef_Enhanced_SF_DS;
DS2 := PRTE2_Header_Ins.Files.HDR_BASE_ALPHA_DS;

outLayout := PRTE2_X_Ins_PropertyScramble.Layouts.Layout_Base_XRef_Enhanced_V2;
outLayout XFER(DS1 L, ds2 R) := TRANSFORM
	SELF.LexID := R.DID;
	SELF := L;
END;

DS3 := JOIN(DS1, DS2,
						left.fname = right.fname AND
						left.mname = right.mname AND
						left.lname = right.lname AND
						left.prim_range = right.prim_range AND
						left.prim_name = right.prim_name AND
						left.p_city_name = right.p_city_name
				,XFER( left, right )
				,left outer
				);
				
OUTPUT(COUNT(DS1));
OUTPUT(COUNT(DS3));
DS4a := SORT(DS3,recnum);
DS4 := DEDUP(DS4a,recnum);
OUTPUT(COUNT(DS4));
OUTPUT(COUNT(CHOOSEN(DS3,1000)));
OUTPUT(COUNT(CHOOSEN(DS4,1000)));

RoxieKeyBuild.Mac_SF_BuildProcess_V2(DS4,
																		 PRTE2_X_Ins_PropertyScramble.Files.BASE_PREFIX_NAME_ENXRef, 
																		 PRTE2_X_Ins_PropertyScramble.Files.ENHANCED_NAME_BASE,
																		 fileVersion, buildXRefEnhanced, 3,
																		 false,true);

SEQUENTIAL(buildXRefEnhanced);