IMPORT PRTE2_X_Ins_PropertyScramble, ut, RoxieKeyBuild;
// PRTE2_X_Ins_PropertyScramble.U_BWR_SSN_From_Orig50k
fileVersion := ut.GetDate+'e';

DS1 := PRTE2_X_Ins_PropertyScramble.Files.XRef_Enhanced_SF_DS;
DS2 := PRTE2_X_Ins_PropertyScramble.Files.BASE_50k_DS;

outLayout := PRTE2_X_Ins_PropertyScramble.Layouts.Layout_Base_XRef_Enhanced;
outLayout XFER(ds1 L, ds2 R) := TRANSFORM
	SELF.SSN := R.SSN;
	SELF.clean_streetaddr1 := TRIM(L.clean_streetaddr1 , LEFT, RIGHT );
	SELF := L;
END;
appendIF(STRING s1, STRING s2) := IF(s1<>'',s1+' '+s2,s2);
append3(STRING s1, STRING s2, STRING s3) := appendIF(appendIF(s1,s2),s3);
DS3 := JOIN(DS1, DS2,
						left.fname = right.fname AND
						left.mname = right.mname AND
						(left.lname = right.lname OR left.lname = right.lname+' '+right.lname2 )AND
						left.zip5=right.zip[1..5] AND
						(left.prim_range=right.housenumber AND left.prim_name=right.street_name 
								OR left.prim_name=right.housenumber
								OR left.street = append3(right.housenumber,right.street_Name,right.str_suffix) 
								) // this is where they put the PO Box type addresses.
				,XFER( left, right )
				,left outer
				);
				
OUTPUT(COUNT(DS1));
OUTPUT(COUNT(DS2));
OUTPUT(COUNT(CHOOSEN(DS3,1000)));
DS4 := SORT(DS3,recnum);
OUTPUT(COUNT(DS4));
OUTPUT(DS1);
OUTPUT(DS4);

RoxieKeyBuild.Mac_SF_BuildProcess_V2(DS4,
																		 PRTE2_X_Ins_PropertyScramble.Files.BASE_PREFIX_NAME_ENXRef, 
																		 PRTE2_X_Ins_PropertyScramble.Files.ENHANCED_NAME_BASE,
																		 fileVersion, buildXRefEnhanced, 3,
																		 false,true);

SEQUENTIAL(buildXRefEnhanced);