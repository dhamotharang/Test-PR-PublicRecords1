IMPORT Gateway, Inquiry_Deltabase, Suspicious_Fraud_LN, std;

EXPORT Inquiry_Deltabase.Layouts.Inquiry_Transaction_ID Search_Transaction_ID (DATASET(Inquiry_Deltabase.Layouts.Input_Deltabase_Transaction_ID) SearchInput,
																																SET OF STRING100 FunctionDescriptions, // Example: Inquiry_AccLogs.shell_constants.set_valid_nonfcra_functions
																																STRING4 SQLSelectLimit = '10', // Total number of records the Deltabase will return for a MAX
																																DATASET(Gateway.Layouts.Config) Gateways = Gateway.Constants.void_gateway, 
																																INTEGER gatewayTimeout = 2, // The Deltabase has a 2 second timeout
																																INTEGER gatewayRetries = 0):= FUNCTION
	
	SelectLimit := TRIM(SQLSelectLimit, ALL);
	deltabase_cfg := gateways(servicename = Gateway.Constants.ServiceName.DeltaInquiry)[1];
	
	// We need to convert the Function Description SET into a DATASET so we can utilize the convertDelimited Function to get a giant string of Function Descriptions
	FunctionDescriptionDataset := DATASET(FunctionDescriptions, Inquiry_Deltabase.Layouts.Function_Descriptions);
	
	// Create the Function_Description IN ('', '', ...) SQL syntax
	FunctionDescriptionInSQL := '(\'' + Suspicious_Fraud_LN.Common.convertDelimited(FunctionDescriptionDataset, FunctionName, '\',\'') + '\')';

	// Generate the Deltabase SELECT statement
	Inquiry_Deltabase.Layouts.Deltabase_Input generateSelects(Inquiry_Deltabase.Layouts.Input_Deltabase_Transaction_ID le) := TRANSFORM
		self.transactionID := deltabase_cfg.transactionid;	
		Transaction_ID := le.Transaction_ID;
		
		SQLSelect := IF((INTEGER)SelectLimit <= 0, '10', SelectLimit); // Make sure that a valid Limit was set
		
		Valid_Query := Transaction_ID != ''; // Make sure we are only calling the Deltabase for plausible searches
		
		GeneratedSelect := 'SELECT \'' + (STRING)le.Seq + '\' AS Seq, ' + // Force Seq into the response for each SELECT statement, this allows for us to use this in batch
									// Generate the Response Layout.  NOTE: If you alter anything in this section you MUST update Inquiry_Deltabase.Layouts.Deltabase_Record
									'i.Transaction_ID, i.Date_Added AS DateTime, i.Industry, i.Vertical, i.Function_Description, i.Sub_Market, ' +
									'i.Product_ID AS Product_Code, i.Use, i.GLB_Purpose, i.DPPA_Purpose, i.Transaction_Type, i.First_Name AS FName, i.Middle_Name AS MName, i.Last_Name AS LName, ' +
									'i.Suffix_Name AS SName, i.Address, i.City, i.State, i.Zip, i.Phone AS Phone10, i.Work_Phone, i.DOB, i.DL, i.DL_State, i.EMail, i.SSN, i.Response_LexID, ' + 
									'i.IPAddr, i.Clean_Predir, i.Clean_Prim_Range, i.Clean_Prim_Name, i.Clean_Addr_Suffix, i.Clean_PostDir, i.Clean_Unit_Desig, i.Clean_Sec_Range, i.Clean_V_City_Name, i.Clean_St, ' + 
									'i.Clean_Zip5, i.Clean_Zip4, i.Clean_Addr_Rec_Type, i.Clean_FIPS_State, i.Clean_FIPS_County, i.Clean_Geo_Lat, i.Clean_Geo_Long, i.Clean_CBSA, i.Clean_Geo_Blk, ' +
									'i.Clean_Geo_Match, i.Clean_Err_Stat ' + 
									// Select the Deltabase Table
									'FROM delta_shell.inquiry_nonfcra i ' +
									// Done Generating the Response Layout, now pick out the right address
									'WHERE i.Transaction_ID = \'' + (STRING50)Transaction_ID + '\' ' +
									// Now limit it to only the Function Descriptions that are allowed for this product
									'AND i.Function_Description IN ' + FunctionDescriptionInSQL + ' ' +
									// And make sure to LIMIT the response so the SQL server isn't overloaded
									'LIMIT ' + SQLSelect;
		
		SELF.Select := IF(Valid_Query, GeneratedSelect, '');
		
		SELF := [];
	END;
	SelectStatements := PROJECT(SearchInput, generateSelects(LEFT)) (Select <> ''); // Generate the SELECTs, only keep valid searches
	
	// Call the Deltabase!
	DeltabaseResponse := Inquiry_Deltabase.SoapCall_Deltabase(SelectStatements, Gateways, gatewayTimeout, gatewayRetries);
	
	// Now transform the Deltabase Response into the Inquiry Key layout to make integrating the Deltabase as seemless as possible
	Inquiry_Deltabase.Layouts.Inquiry_Transaction_ID intoKeyLayout(Inquiry_Deltabase.Layouts.Deltabase_Record le) := TRANSFORM
		// Index Fields
		SELF.Transaction_ID := le.Transaction_ID;
		// Inquiry Key Payload
		SELF.Industry := le.Industry;
		SELF.Vertical := le.Vertical;
		SELF.Sub_Market := le.Sub_Market;
		SELF.Use := le.Use;
		SELF.Appended_ADL := (INTEGER)le.Response_LexID;
		// Need to reformat DateTime, as the Deltabase returns YYYY-MM-DD HH:MM:SS but the Inquiries Key is YYYYMMDD HHMMSSmm
		CleanedDateTime := std.str.Filter(le.DateTime, '0123456789');
		SELF.DateTime := IF(CleanedDateTime = '', '', CleanedDateTime[1..8] + ' ' + CleanedDateTime[9..14] + '01');
		SELF.Sequence_Number := le.Seq;
		SELF.Product_Code := le.Product_Code;
		SELF.Function_Description := le.Function_Description;
		
		SELF := le;
		SELF := [];
	END;
	DeltabaseResults := PROJECT(DeltabaseResponse.Response, intoKeyLayout(LEFT)) (Transaction_ID <> ''); // Only return valid Transaction_IDs (In case Deltabase Errors)
	
	RETURN(DeltabaseResults);
END;