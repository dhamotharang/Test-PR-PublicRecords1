// PRTE2_X_Ins_PropertyScramble.U_Fix_SSN_etc_from_Header
// After running the first time, there were still a number that the addresses didn't quite match
// so if SSN blank try copying it from the JOIN with just name.
// PRTE2_X_Ins_PropertyScramble.U_BWR_LexID_from_Header

IMPORT ut, RoxieKeyBuild, PRTE2_Header_Ins, Address;

fileVersion := ut.GetDate+'';

DS1 := PRTE2_X_Ins_PropertyScramble.Files.XRef_Enhanced_SF_DS;
DS2 := PRTE2_Header_Ins.Files.HDR_BASE_ALPHA_DS;

outLayout := PRTE2_X_Ins_PropertyScramble.Layouts.Layout_Base_XRef_Enhanced;

outLayout XFER(DS1 L, ds2 R) := TRANSFORM
		SELF.prim_range := R.prim_range;
		SELF.predir := R.predir;
		SELF.prim_name := R.prim_name;
		SELF.addr_suffix := R.addr_suffix;
		SELF.postdir := R.postdir;
		SELF.unit_desig := R.unit_desig;
		SELF.sec_range := R.sec_range;
		SELF.p_city_name := R.p_city_name;
		SELF.v_city_name := R.v_city_name;
		SELF.st := R.st;
		SELF.zip5 := R.zip;
		SELF.zip4 := R.zip4;
		SELF.Clean_streetaddr1 := Address.Addr1FromComponents(R.prim_range, R.predir, R.prim_name,
																													 R.addr_suffix, R.postdir, R.unit_desig, R.sec_range);
		SELF.Clean_CityStZip := Address.Addr2FromComponentsWithZip4(R.v_city_name, R.st, R.zip, R.zip4);
		SELF.SSN := IF(R.SSN='', L.SSN, R.SSN);
		SELF.dob := IF(R.dob=0, L.dob, (STRING)R.dob);

		SELF := L;
END;

DS3 := JOIN(DS1, DS2,
						left.LexID = right.did 
				,XFER( left, right )
				,left outer
				);
				
OUTPUT(COUNT(DS1));
OUTPUT(COUNT(DS3));
DS4a := SORT(DS3,recnum);
DS4 := DEDUP(DS4a,recnum);
OUTPUT(COUNT(DS4));			// just to confirm dedup didn't find any dups
OUTPUT(CHOOSEN(SORT(DS1,SSN),1000));
OUTPUT(CHOOSEN(SORT(DS2,SSN),1000));
OUTPUT(CHOOSEN(SORT(DS3,SSN),1000));
OUTPUT(COUNT(DS1(ssn='')));		// how many blanks did we begin with
OUTPUT(COUNT(DS2(ssn='')));		// how many blanks does the BHDR file have
OUTPUT(COUNT(DS3(ssn='')));		// how many blanks did we end up with (Join failed)

RoxieKeyBuild.Mac_SF_BuildProcess_V2(DS3,
																		 PRTE2_X_Ins_PropertyScramble.Files.BASE_PREFIX_NAME_ENXRef, 
																		 PRTE2_X_Ins_PropertyScramble.Files.ENHANCED_NAME_BASE,
																		 fileVersion, buildXRefEnhanced, 3,
																		 false,true);
DSAfter := PRTE2_X_Ins_PropertyScramble.Files.XRef_Enhanced_SF_DS;
SEQUENTIAL(buildXRefEnhanced, OUTPUT(CHOOSEN(DSAfter,1000)));