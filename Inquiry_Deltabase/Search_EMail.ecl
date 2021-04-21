IMPORT Gateway, Inquiry_Deltabase, Suspicious_Fraud_LN, std;

EXPORT Inquiry_Deltabase.Layouts.Inquiry_Email Search_EMail (DATASET(Inquiry_Deltabase.Layouts.Input_Deltabase_Email) SearchInput,
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
	Inquiry_Deltabase.Layouts.Deltabase_Input generateSelects(Inquiry_Deltabase.Layouts.Input_Deltabase_Email le) := TRANSFORM
		self.transactionID := deltabase_cfg.transactionid;	
		Email := TRIM(le.Email, LEFT, RIGHT);
		
		SQLSelect := IF((INTEGER)SelectLimit <= 0, '10', SelectLimit); // Make sure that a valid Limit was set
		
		Valid_Query := Email <> ''; // Make sure we are only calling the Deltabase for plausible searches
		
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
									'WHERE i.Email = \'' + Email + '\' ' +
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
	Inquiry_Deltabase.Layouts.Inquiry_Email intoKeyLayout(Inquiry_Deltabase.Layouts.Deltabase_Record le) := TRANSFORM
		// Index Fields
		SELF.Email_Address := le.Email;
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
		// Need to reformat DateTime, as the Deltabase returns YYYY-MM-DD HH:MM:SS but the Inquiries Key is YYYYMMDD HHMMSSmm
		CleanedDateTime := std.str.Filter(le.DateTime, '0123456789');
		SELF.Search_Info.DateTime := IF(CleanedDateTime = '', '', CleanedDateTime[1..8] + ' ' + CleanedDateTime[9..14] + '01');
		SELF.Search_Info.Transaction_ID := le.Transaction_ID;
		SELF.Search_Info.Transaction_Type := le.Transaction_Type;
		SELF.Search_Info.Sequence_Number := le.Seq;
		SELF.Search_Info.Product_Code := le.Product_Code;
		SELF.Search_Info.Function_Description := le.Function_Description;
		
		SELF := le;
		SELF := [];
	END;
	DeltabaseResults := PROJECT(DeltabaseResponse.Response, intoKeyLayout(LEFT)) (Email_Address <> ''); // Only return valid Emails (In case Deltabase Errors)
	
	RETURN(DeltabaseResults);
END;