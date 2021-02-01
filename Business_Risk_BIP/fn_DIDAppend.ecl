IMPORT Business_Risk_BIP, Doxie, Gateway, Risk_Indicators;

EXPORT fn_DIDAppend(DATASET(Business_Risk_BIP.Layouts.Shell) cleanedInput,
                    Business_Risk_BIP.LIB_Business_Shell_LIBIN Options) := FUNCTION

	mod_access := PROJECT(Options, doxie.IDataAccess);

	Risk_Indicators.Layout_Input prepForDIDAppend(Business_Risk_BIP.Layouts.Shell le) := TRANSFORM
		SELF.Seq := le.Clean_Input.Seq;
		SELF.HistoryDate := le.Clean_Input.HistoryDate;
		SELF.Title := le.Clean_Input.Rep_NameTitle;
		SELF.FName := le.Clean_Input.Rep_FirstName;
		SELF.MName := le.Clean_Input.Rep_MiddleName;
		SELF.LName := le.Clean_Input.Rep_LastName;
		SELF.Suffix := le.Clean_Input.Rep_NameSuffix;
		SELF.In_StreetAddress := le.Clean_Input.Rep_StreetAddress1;
		SELF.In_City := le.Clean_Input.Rep_City;
		SELF.In_State := le.Clean_Input.Rep_State;
		SELF.In_ZipCode := le.Clean_Input.Rep_Zip;
		SELF.Prim_Range := le.Clean_Input.Rep_Prim_Range;
		SELF.Predir := le.Clean_Input.Rep_Predir;
		SELF.Prim_Name := le.Clean_Input.Rep_Prim_Name;
		SELF.Addr_Suffix := le.Clean_Input.Rep_Addr_Suffix;
		SELF.Postdir := le.Clean_Input.Rep_Postdir;
		SELF.Unit_Desig := le.Clean_Input.Rep_Unit_Desig;
		SELF.Sec_Range := le.Clean_Input.Rep_Sec_Range;
		SELF.P_City_Name := le.Clean_Input.Rep_City;
		SELF.St := le.Clean_Input.Rep_State;
		SELF.Z5 := le.Clean_Input.Rep_Zip5;
		SELF.Zip4 := le.Clean_Input.Rep_Zip4;
		SELF.Lat := le.Clean_Input.Rep_Lat;
		SELF.Long := le.Clean_Input.Rep_Long;
		SELF.County := le.Clean_Input.Rep_County;
		SELF.Geo_Blk := le.Clean_Input.Rep_Geo_Block;
		SELF.Addr_Type := le.Clean_Input.Rep_Addr_Type;
		SELF.Addr_Status := le.Clean_Input.Rep_Addr_Status;
		SELF.SSN := le.Clean_Input.Rep_SSN;
		SELF.DOB := le.Clean_Input.Rep_DateOfBirth;
		SELF.Age := le.Clean_Input.Rep_Age;
		SELF.DL_Number := le.Clean_Input.Rep_DLNumber;
		SELF.DL_State := le.Clean_Input.Rep_DLState;
		SELF.Email_Address := le.Clean_Input.Rep_Email;
		SELF.Phone10 := le.Clean_Input.Rep_Phone10;

		SELF := [];
	END;

	prepDIDAppend := PROJECT(cleanedInput, prepForDIDAppend(LEFT));

	DIDAppend := Risk_Indicators.iid_getDID_prepOutput(prepDIDAppend,
																										mod_access.dppa,
																										mod_access.glb,
																										FALSE, /*isFCRA*/
																										50, /*BSVersion*/
																										mod_access.DataRestrictionMask,
																										0, /*Append_Best*/
																										DATASET([], Gateway.Layouts.Config), /*Gateways*/
																										0 /*BSOptions*/,
																										mod_access := mod_access);

	// Pick the DID with the highest score, in the event that multiple have the same score, choose the lowest value DID to make this deterministic
	DIDKept := ROLLUP(SORT(DIDAppend, Seq, -Score, DID), LEFT.Seq = RIGHT.Seq, TRANSFORM(LEFT));

	withDID := JOIN(cleanedInput, DIDKept, LEFT.Seq = RIGHT.Seq, TRANSFORM(Business_Risk_BIP.Layouts.Shell,
                  SELF.Clean_Input.Rep_LexID := RIGHT.DID;
									SELF.Clean_Input.Rep_LexIDScore := RIGHT.Score;
									SELF := LEFT),
              LEFT OUTER, KEEP(1), ATMOST(100), PARALLEL, FEW);

	RETURN withDID;
END;
