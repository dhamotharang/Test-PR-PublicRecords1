export Merge_FBN_TX_Harris( string mergedName, 
														string instName,
														string ownerName,
														string dbasName) := function

	FBNV2.Layout_File_TX_Harris_in.combinedSprayed mergeOwner(FBNV2.Layout_File_TX_Harris_in.InstrumentSprayed L,
																														FBNV2.Layout_File_TX_Harris_in.OwnerSprayed R) := TRANSFORM
		SELF.FILE_NUMBER := L.FILE_NUMBER;
		SELF.FILM_CODE := L.FILM_CODE;
		SELF.DATE_FILED := L.DATE_FILED;
		SELF.NUM_PAGES := L.NUM_PAGES;
		SELF.TERM := L.TERM;
		SELF.EXPIRED_TERM := L.EXPIRED_TERM;
		SELF.INCORPORATED := L.INCORPORATED;
		SELF.ASSUMED_NAME := L.ASSUMED_NAME;
		SELF.NAME2 := R.NAME2;
		SELF.STREET_ADD2 := R.STREET_ADD2;
		SELF.CITY2 := R.CITY2;
		SELF.STATE2 := R.STATE2;
		SELF.ZIP2 := R.ZIP2;
		SELF := [];
	END;

	FBNV2.Layout_File_TX_Harris_in.combinedSprayed mergeDbas(FBNV2.Layout_File_TX_Harris_in.combinedSprayed L,
																													 FBNV2.Layout_File_TX_Harris_in.DbasSprayed R) := TRANSFORM
		SELF.NAME1 := R.NAME1;
		SELF.STREET_ADD1 := R.STREET_ADD1; 
		SELF.CITY1 := R.CITY1;
		SELF.STATE1 := R.STATE1;
		SELF.ZIP1 := R.ZIP1;
		SELF := L;
	END;

	dsInst := DATASET(instName, FBNV2.Layout_File_TX_Harris_in.InstrumentSprayed, CSV(HEADING(1), SEPARATOR('|')));
	dsOwner := DATASET(ownerName, FBNV2.Layout_File_TX_Harris_in.OwnerSprayed, CSV(HEADING(1), SEPARATOR('|')));
	dsDbas := DATASET(dbasName, FBNV2.Layout_File_TX_Harris_in.DbasSprayed, CSV(HEADING(1), SEPARATOR('|')));
	dsIntermediate := JOIN(dsInst, dsOwner, LEFT.FILE_NUMBER = RIGHT.FILE_NUMBER, mergeOwner(LEFT, RIGHT), LEFT OUTER);
	dsCombined := JOIN(dsIntermediate, dsDbas, LEFT.FILE_NUMBER = RIGHT.FILE_NUMBER, mergeDbas(LEFT, RIGHT), LEFT OUTER);

	result := OUTPUT(dsCombined(), , mergedName, OVERWRITE, __COMPRESSED__);

  return result;
end;