IMPORT Gateway, Inquiry_Deltabase, Inquiry_AccLogs, Risk_Indicators, RiskWise, Suspicious_Fraud_LN;

EXPORT Inquiry_Deltabase.Layouts.Inquiry_All Search_All (DATASET(Inquiry_Deltabase.Layouts.Input_Deltabase_All) SearchInput,
																																SET OF STRING100 FunctionDescriptions, // Example: Inquiry_AccLogs.shell_constants.set_valid_nonfcra_functions
																																STRING4 SQLSelectLimit = '10', // Total number of records the Deltabase will return for a MAX
																																DATASET(Gateway.Layouts.Config) Gateways = Gateway.Constants.void_gateway, 
																																INTEGER gatewayTimeout = 2, // The Deltabase has a 2 second timeout
																																INTEGER gatewayRetries = 0):= FUNCTION
	
	SelectLimit := TRIM(SQLSelectLimit, ALL);
	
	// We need to convert the Function Description SET into a DATASET so we can utilize the convertDelimited Function to get a giant string of Function Descriptions
	FunctionDescriptionDataset := DATASET(FunctionDescriptions, Inquiry_Deltabase.Layouts.Function_Descriptions);
	
	// Create the Function_Description IN ('', '', ...) SQL syntax
	FunctionDescriptionInSQL := '(\'' + Suspicious_Fraud_LN.Common.convertDelimited(FunctionDescriptionDataset, FunctionName, '\',\'') + '\')';

	// Generate the Deltabase SELECT statement
	Inquiry_Deltabase.Layouts.Deltabase_Input generateSelects(Inquiry_Deltabase.Layouts.Input_Deltabase_All le) := TRANSFORM
    //Address
    Zip5 := TRIM(le.Zip5, ALL);
		Prim_Name := StringLib.StringToUpperCase(TRIM(le.Prim_Name, LEFT, RIGHT));
		Prim_Range := StringLib.StringToUpperCase(TRIM(le.Prim_Range, LEFT, RIGHT));
		Sec_Range := StringLib.StringToUpperCase(TRIM(le.Sec_Range, LEFT, RIGHT));
		//DID
    DID := le.DID;
    //EMail
    Email := TRIM(le.Email, LEFT, RIGHT);
    //IPAddr
    IPAddr := TRIM(le.IPAddress, LEFT, RIGHT);
    //Name
    FirstName := TRIM(StringLib.StringToUpperCase(le.FirstName), LEFT, RIGHT);
		MiddleName := TRIM(StringLib.StringToUpperCase(le.MiddleName), LEFT, RIGHT);
		MiddleInitial := MiddleName[1];
		LastName := TRIM(StringLib.StringToUpperCase(le.LastName), LEFT, RIGHT);
    //Phone
    Phone10 := StringLib.StringFilter(le.Phone10, '0123456789');
    //SSN
    SSN := StringLib.StringFilter(le.SSN, '0123456789');
    //Transaction_ID
    Transaction_ID := le.Transaction_ID;
    
		SQLSelect := IF((INTEGER)SelectLimit <= 0, '10', SelectLimit); // Make sure that a valid Limit was set
		
		Valid_Query := (Prim_Name <> '' AND (INTEGER)Zip5 > 0) OR (DID > 0) OR (Email <> '') OR (IPAddr <> '') OR (FirstName <> '' AND (LastName <> '' OR MiddleInitial <> '')) OR (Phone10 <> '' AND LENGTH(Phone10) = 10) OR (SSN <> '' AND LENGTH(SSN) = 9) OR (Transaction_ID != ''); // Make sure we are only calling the Deltabase for plausible searches
		Valid_Query_Address := Prim_Name <> '' AND (INTEGER)Zip5 > 0;
    Valid_Query_DID := DID > 0;
    Valid_Query_Email := Email <> '';
    Valid_Query_IPAddr := IPAddr <> '';
    Valid_Query_Name := FirstName <> '' AND (LastName <> '' OR MiddleInitial <> '');
    Valid_Query_Phone := Phone10 <> '' AND LENGTH(Phone10) = 10;
    Valid_Query_SSN := SSN <> '' AND LENGTH(SSN) = 9;
    Valid_Query_TransactionID := Transaction_ID != '';
		SQLSelectFields := '(SELECT \'' + (STRING)le.Seq + '\' AS Seq, ' + // Force Seq into the response for each SELECT statement, this allows for us to use this in batch
                        // Generate the Response Layout.  NOTE: If you alter anything in this section you MUST update Inquiry_Deltabase.Layouts.Deltabase_Record
                        'i.Transaction_ID, i.Date_Added AS DateTime, i.Industry, i.Vertical, i.Function_Description, i.Sub_Market, ' +
                        'i.Product_ID AS Product_Code, i.Use, i.GLB_Purpose, i.DPPA_Purpose, i.Transaction_Type, i.First_Name AS FName, i.Middle_Name AS MName, i.Last_Name AS LName, ' +
                        'i.Suffix_Name AS SName, i.Address, i.City, i.State, i.Zip, i.Phone AS Phone10, i.Work_Phone, i.DOB, i.DL, i.DL_State, i.EMail, i.SSN, i.Response_LexID, ' + 
                        'i.IPAddr, i.Clean_Predir, i.Clean_Prim_Range, i.Clean_Prim_Name, i.Clean_Addr_Suffix, i.Clean_PostDir, i.Clean_Unit_Desig, i.Clean_Sec_Range, i.Clean_V_City_Name, i.Clean_St, ' + 
                        'i.Clean_Zip5, i.Clean_Zip4, i.Clean_Addr_Rec_Type, i.Clean_FIPS_State, i.Clean_FIPS_County, i.Clean_Geo_Lat, i.Clean_Geo_Long, i.Clean_CBSA, i.Clean_Geo_Blk, ' +
                        'i.Clean_Geo_Match, i.Clean_Err_Stat';
    SQLSelectFieldAddress := ', \'1\' AS Search_Type ';
    SQLSelectFieldDID := ', \'2\' AS Search_Type ';
    SQLSelectFieldEmail := ', \'3\' AS Search_Type ';
    SQLSelectFieldIPAddr := ', \'4\' AS Search_Type ';
    SQLSelectFieldName := ', \'5\' AS Search_Type ';
    SQLSelectFieldPhone := ', \'6\' AS Search_Type ';
    SQLSelectFieldSSN := ', \'7\' AS Search_Type ';
    SQLSelectFieldTransactionID := ', \'8\' AS Search_Type ';
    SQLFrom         := ' FROM delta_shell.inquiry_nonfcra i ';
    SQLWhereMain      := ' WHERE ';
    SQLWhereAddress   := IF(NOT Valid_Query_Address,'',' IFNULL(i.Clean_Zip5,\'\') = \'' + Zip5 + '\' AND IFNULL(i.Clean_Prim_Name,\'\') = \'' + Prim_Name + '\' AND IFNULL(i.Clean_Prim_Range,\'\') = \'' + Prim_Range + '\' AND IFNULL(i.Clean_Sec_Range,\'\') = \'' + Sec_Range + '\' ' );
    SQLWhereDID       := IF(NOT Valid_Query_DID,'',' i.Response_LexID = \'' + (STRING)DID + '\' ');
    SQLWhereEmail     := IF(NOT Valid_Query_Email,'',' i.Email = \'' + Email + '\' ');
    SQLWhereIPAddr    := IF(NOT Valid_Query_IPAddr,'',' i.IPAddr = \'' + IPAddr + '\' ');
    SQLWhereName      := IF(NOT Valid_Query_Name,'',' i.First_Name = \'' + FirstName + '\' AND ' + IF(LastName <> '', 'i.Last_Name = \'' + LastName + '\' ', 'i.Middle_Name LIKE \'' + MiddleInitial + '%\' '));
    SQLWherePhone     := IF(NOT Valid_Query_Phone,'',' i.Phone = \'' + Phone10 + '\' ');
    SQLWhereSSN       := IF(NOT Valid_Query_SSN,'',' i.SSN = \'' + SSN + '\' ');
    // need to create new or update KEY `ix_transaction_id` (`transaction_id`) to KEY `ix_transaction_id` (`transaction_id`,`function_description`)
    SQLWhereTransactionID := IF(NOT Valid_Query_TransactionID,'',' AND i.Transaction_ID = \'' + (STRING50)Transaction_ID + '\' ');
    SQLWhereGlobal    := ' AND i.Function_Description IN ' + FunctionDescriptionInSQL + ' ';
		// And make sure to LIMIT the response so the SQL server isn't overloaded
		SQLUnion          := ' UNION ALL ';
    SQLLimit          := ' LIMIT ' + SelectLimit + ' ) ';
    SQLAddress        := IF(Valid_Query_Address, SQLSelectFields + SQLSelectFieldAddress + SQLFrom + SQLWhereMain + SQLWhereAddress + SQLWhereGlobal,'');
    SQLDID            := IF(Valid_Query_DID, SQLSelectFields + SQLSelectFieldDID + SQLFrom + SQLWhereMain + SQLWhereDID + SQLWhereGlobal,'');
    SQLEmail          := IF(Valid_Query_Email, SQLSelectFields + SQLSelectFieldEmail + SQLFrom + SQLWhereMain + SQLWhereEmail + SQLWhereGlobal,'');
    SQLIPAddr         := IF(Valid_Query_IPAddr, SQLSelectFields + SQLSelectFieldIPAddr + SQLFrom + SQLWhereMain + SQLWhereIPAddr + SQLWhereGlobal,'');
    SQLName           := IF(Valid_Query_Name, SQLSelectFields + SQLSelectFieldName + SQLFrom + SQLWhereMain + SQLWhereName + SQLWhereGlobal,'');
    SQLPhone          := IF(Valid_Query_Phone, SQLSelectFields + SQLSelectFieldPhone + SQLFrom + SQLWhereMain + SQLWherePhone + SQLWhereGlobal ,'');
    SQLSSN            := IF(Valid_Query_SSN, SQLSelectFields + SQLSelectFieldSSN + SQLFrom + SQLWhereMain + SQLWhereSSN + SQLWhereGlobal,'');
    SQLTransactionID  := IF(Valid_Query_TransactionID, SQLSelectFields + SQLSelectFieldTransactionID + SQLFrom + SQLWhereMain + SQLWhereTransactionID + SQLWhereGlobal,'');
    GeneratedSelect := IF(Valid_Query_Address,SQLAddress + SQLLimit + SQLUnion,'')+
                       IF(Valid_Query_DID,SQLDID + SQLLimit + SQLUnion,'')+
                       IF(Valid_Query_Email,SQLEmail + SQLLimit + SQLUnion,'')+
                       IF(Valid_Query_IPAddr,SQLIPAddr + SQLLimit + SQLUnion,'')+
                       IF(Valid_Query_Name,SQLName + SQLLimit + SQLUnion,'')+
                       IF(Valid_Query_Phone,SQLPhone + SQLLimit + SQLUnion,'')+
                       IF(Valid_Query_SSN,SQLSSN + SQLLimit + SQLUnion,'')+
                       IF(Valid_Query_TransactionID,SQLTransactionID + SQLLimit + SQLUnion,'');
    ValidCounter      := (integer)Valid_Query_Address + (integer)Valid_Query_DID + (integer)Valid_Query_Email + (integer)Valid_Query_IPAddr + (integer)Valid_Query_Name + (integer)Valid_Query_Phone + (integer)Valid_Query_SSN + (integer)Valid_Query_TransactionID;
    ValidEndPos       := stringlib.stringfind(GeneratedSelect,'UNION ALL',ValidCounter)-1;
    SELF.Select := IF(Valid_Query, GeneratedSelect[1..ValidEndPos], '');
		
		SELF := [];
	END;
	SelectStatements := PROJECT(SearchInput, generateSelects(LEFT)) (Select <> ''); // Generate the SELECTs, only keep valid searches
	
	// Call the Deltabase!
	DeltabaseResponse := Inquiry_Deltabase.SoapCall_Deltabase(SelectStatements, Gateways, gatewayTimeout, gatewayRetries);
	
	// Now transform the Deltabase Response into the Inquiry Key layout to make integrating the Deltabase as seemless as possible
	Inquiry_Deltabase.Layouts.Inquiry_All intoKeyLayout(Inquiry_Deltabase.Layouts.Deltabase_Record le) := TRANSFORM
		// Index Fields
    SELF.Search_Type := le.Search_Type;
		SELF.Zip := le.Clean_Zip5;
		SELF.Prim_Name := le.Clean_Prim_Name;
		SELF.Prim_Range := le.Clean_Prim_Range;
		SELF.Sec_Range := le.Clean_Sec_Range;
    SELF.S_DID := (INTEGER)le.Response_LexID;
    SELF.Email_Address := le.Email;
    SELF.IPAddr := le.IPAddr;
    SELF.FName := le.FName;
		SELF.MName := le.MName;
		SELF.LName := le.LName;
    SELF.Phone10 := le.Phone10;
    SELF.SSN := le.SSN;
    SELF.Transaction_ID := le.Transaction_ID;
		// Inquiry Key Payload
		SELF.Bus_Intel.Industry := le.Industry;
		SELF.Bus_Intel.Vertical := le.Vertical;
		SELF.Bus_Intel.Sub_Market := le.Sub_Market;
		SELF.Bus_Intel.Use := le.Use;
		SELF.Person_Q.First_Name := le.FName;
		SELF.Person_Q.Middle_Name := le.MName;
		SELF.Person_Q.Last_Name := le.LName;
		SELF.Person_Q.FName := le.FName;
		SELF.Person_Q.MName := le.MName;
		SELF.Person_Q.LName := le.LName;
		SELF.Person_Q.Name_Suffix := le.SName;
		SELF.Person_Q.Address := le.Address;
		SELF.Person_Q.City := le.City;
		SELF.Person_Q.State := le.State;
		SELF.Person_Q.Zip := le.Zip;
		SELF.Person_Q.Prim_Range := le.Clean_Prim_Range;
		SELF.Person_Q.Predir := le.Clean_Predir;
		SELF.Person_Q.Prim_Name := le.Clean_Prim_Name;
		SELF.Person_Q.Addr_Suffix := le.Clean_Addr_Suffix;
		SELF.Person_Q.Postdir := le.Clean_PostDir;
		SELF.Person_Q.Unit_Desig := le.Clean_Unit_Desig;
		SELF.Person_Q.Sec_Range := le.Clean_Sec_Range;
		SELF.Person_Q.V_City_Name := le.Clean_V_City_Name;
		SELF.Person_Q.St := le.Clean_St;
		SELF.Person_Q.Zip5 := le.Clean_Zip5;
		SELF.Person_Q.Zip4 := le.Clean_Zip4;
		SELF.Person_Q.Addr_Rec_Type := le.Clean_Addr_Rec_Type;
		SELF.Person_Q.FIPS_State := le.Clean_FIPS_State;
		SELF.Person_Q.FIPS_County := le.Clean_FIPS_County;
		SELF.Person_Q.Geo_Lat := le.Clean_Geo_Lat;
		SELF.Person_Q.Geo_Long := le.Clean_Geo_Long;
		SELF.Person_Q.CBSA := le.Clean_CBSA;
		SELF.Person_Q.Geo_Blk := le.Clean_Geo_Blk;
		SELF.Person_Q.Geo_Match := le.Clean_Geo_Match;
		SELF.Person_Q.Err_Stat := le.Clean_Err_Stat;
		SELF.Person_Q.Personal_Phone := le.Phone10;
		SELF.Person_Q.Work_Phone := le.Work_Phone;
		SELF.Person_Q.DOB := le.DOB;
		SELF.Person_Q.DL := le.DL;
		SELF.Person_Q.DL_St := le.DL_State;
		SELF.Person_Q.Email_Address := le.EMail;
		SELF.Person_Q.SSN := le.SSN;
		SELF.Person_Q.LinkID := le.Response_LexID;
		SELF.Person_Q.IPAddr := le.IPAddr;
		SELF.Person_Q.Appended_SSN := le.SSN;
		SELF.Person_Q.Appended_ADL := (INTEGER)le.Response_LexID;
		SELF.Permissions.GLB_Purpose := le.GLB_Purpose;
		SELF.Permissions.DPPA_Purpose := le.DPPA_Purpose;
		// Need to reformat DateTime, as the Deltabase returns YYYY-MM-DD HH:MM:SS but the Inquiries Key is YYYYMMDD HHMMSSmm
		CleanedDateTime := StringLib.StringFilter(le.DateTime, '0123456789');
		SELF.Search_Info.DateTime := IF(CleanedDateTime = '', '', CleanedDateTime[1..8] + ' ' + CleanedDateTime[9..14] + '01');
		SELF.Search_Info.Transaction_ID := le.Transaction_ID;
		SELF.Search_Info.Transaction_Type := le.Transaction_Type;
		SELF.Search_Info.Sequence_Number := le.Seq;
		SELF.Search_Info.Product_Code := le.Product_Code;
		SELF.Search_Info.Function_Description := le.Function_Description;
		
		SELF := le;
		SELF := [];
	END;
  
	DeltabaseResults := PROJECT(DeltabaseResponse.Response, intoKeyLayout(LEFT));
	// OUTPUT(SelectStatements);
	RETURN(DeltabaseResults);
END;