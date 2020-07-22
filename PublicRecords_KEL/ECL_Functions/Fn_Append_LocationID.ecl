IMPORT LocationID_xLink;
EXPORT Fn_Append_LocationID(STRING10 PrimRange, STRING6 Predir, STRING28 PrimName, STRING6 Suffix, STRING6 Postdir, STRING8 SecRange, STRING25 City, STRING6 State, STRING6 ZIP) := FUNCTION
    inputDataset := DATASET([{1,PrimRange, Predir, PrimName, Suffix, Postdir, SecRange, City, State, ZIp}], {UNSIGNED1 ID,STRING10 PrimRange, STRING6 Predir, STRING28 PrimName, STRING6 Suffix, STRING6 Postdir, STRING8 SecRange, STRING25 City, STRING6 State, STRING6 ZIP});   
		// Append the Location ID by calling the Linking Function
    // LocationID_xLink.Append(inputDataset, PrimRange, Predir, PrimName, Suffix, Postdir, SecRange, City, State, ZIP, Res);
    // Return the LocID Field value
    // RETURN Res[1].LocID;
		RETURN 0;
END;