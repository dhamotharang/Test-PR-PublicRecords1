
EXPORT Soap_Csv_Address := MODULE
	// ROXIE IP Address
	// SHARED IPAddr := 'http://10.173.202.2:9876/'; // 1-way Roxie
	// SHARED IPAddr := 'http://10.173.219.200:9876/'; // DEV Roxie32 - 219 100-way Roxie
	// SHARED IPAddr := 'http://roxiedevvip32.sc.seisint.com:9876/'; // DEV Roxie32 - 219 100-way Roxie
	SHARED IPAddr := 'http://roxiedevvip.sc.seisint.com:9876/'; // DEV Roxie64 - 190 100-way Roxie
	
	// Service to invoke
	SHARED Serv := 'CompID_Services.Service_Address_Enhancement';
	// SHARED Serv := 'CompID_Services.Service_SSN';
	// SHARED Serv := 'CompID_Services.Service_DLN';
	
	// Logical file that contains the inquiries
	SHARED Logical_File := '~COMPID::MT::IN::Orders_0428_NoHits';
	// SHARED Logical_File := '~COMPID::MT::IN::Orders_10';
	
	// General Input and Output Layouts
	SHARED Layout_Order 			:= CompId_Services.Layouts_Soap.Layout_Order;
	SHARED Layout_Result_Soap := CompId_Services.Layouts_Soap.Layout_Result_Soap;
	SHARED Layout_Result 		  := CompId_Services.Layouts_Soap.Layout_Result;
	
	// SSN Layout
	SHARED Layout_Order_SSN	:= CompId_Services.Layouts_Soap.Layout_Order_SSN;
	
	// DLN Layout
	SHARED Layout_Order_DLN	:= CompId_Services.Layouts_Soap.Layout_Order_DLN;
	
	/* Read the inquiries from the sprayed file */
	SHARED DATASET(Layout_Order) readInquiries := FUNCTION
		inquiries := DATASET(Logical_File, Layout_Order, CSV);
		OUTPUT(inquiries, NAMED('inquiries'));
		RETURN inquiries;
	END;
	
	/* Make SOAP request for all the inquiries in the dataset */
	SHARED DATASET(Layout_Result_Soap) batchSoapRequests(DATASET(Layout_Order) InDataSet) := FUNCTION
		
		Layout_Order XformDOB(Layout_Order L) := TRANSFORM
			// Pad zeroes
			STRING8 Date_MMDDYYYY := INTFORMAT((INTEGER)L.DateOfBirth, 8, 1);
			SELF.DateOfBirth			:= Date_MMDDYYYY[5..8] + Date_MMDDYYYY[1..2] + Date_MMDDYYYY[3..4];
			SELF.SSN 							:= INTFORMAT((INTEGER)L.SSN, 9, 1);
			SELF.Zip 							:= INTFORMAT((INTEGER)L.Zip, 5, 1);
			SELF.CurrZip4 				:= INTFORMAT((INTEGER)L.CurrZip4, 4, 1);
			
			// if SecRange in the Inquiry is 0, then blank it out
			SELF.SecRange 				:= IF (L.SecRange = '0', '', L.SecRange);
			SELF 									:= L;
		END;
		
		// Make SOAP call for the inquiries
		Result_RecSet := SOAPCALL(InDataSet, 
															IPAddr, 
															Serv, 
															Layout_Order, 
															XformDOB(LEFT), 
															DATASET(Layout_Result_Soap), 
															PARALLEL(15));
		
		OUTPUT(Result_RecSet, NAMED('Result_RecSet'));
		RETURN Result_RecSet;
	END;
	
	/* Format the SOAP result into CSV output */
	SHARED DATASET(Layout_Result) formatResult(DATASET(Layout_Result_Soap) Result_RecSet) := FUNCTION
		// Sort results by Seq Number
		SortedResults := SORT(Result_RecSet, Seq);
		
		// Update output - Add C to Seq Number, Pad '0's to Date of Birth
		Layout_Result XformResult(Result_RecSet L) := TRANSFORM
			SELF.Score 						:= INTFORMAT((INTEGER)L.Score, 3,1);
			SELF.Output_Type 			:= 'LNREST';
			SELF.Seq 							:= INTFORMAT((INTEGER)L.Seq, 5, 1) + 'C'; 
			SELF.DOB 							:= INTFORMAT((INTEGER)L.DOB, 8, 1);
			SELF.DOD 							:= INTFORMAT((INTEGER)L.DOD, 8, 1);
			SELF.LicenceIssueDate := INTFORMAT((INTEGER)L.LicenceIssueDate, 8, 1);
			SELF.LicenceExpDate 	:= INTFORMAT((INTEGER)L.LicenceExpDate, 8, 1);
			SELF 									:= L;
		END;
		
		OUTPUT(SortedResults, NAMED('SortedResults'));
		// Project the record set from webservice to create comma separated output
		RETURN PROJECT(SortedResults, XformResult(LEFT));
	END;
	
	/* Make SOAP request for all the inquiries in the dataset */
	SHARED DATASET(Layout_Result_Soap) batchSSNSoapRequests(DATASET(Layout_Order) InDataSet) := FUNCTION
		
		Layout_Order_SSN XformDOB(Layout_Order_SSN L) := TRANSFORM
			// Pad zeroes
			SELF.SSN := INTFORMAT((INTEGER)L.SSN, 9, 1);
			SELF 		 := L;
		END;
		
		// Get only SSN-related data from the original dataset
		SSNDataSet := PROJECT(InDataSet, TRANSFORM(Layout_Order_SSN, SELF := LEFT));
		
		// Make SOAP call with the SSN dataset
		Result_RecSet := SOAPCALL(SSNDataSet, 
															IPAddr, 
															Serv, 
															Layout_Order_SSN, 
															XformDOB(LEFT),
															DATASET(Layout_Result_Soap), 
															PARALLEL(15));
		RETURN Result_RecSet;
	END;
	
	/* Make SOAP request for all the inquiries in the dataset */
	SHARED DATASET(Layout_Result_Soap) batchDLNSoapRequests(DATASET(Layout_Order) InDataSet) := FUNCTION
		
		// Get only DLN-related data from the original dataset
		DLNDataSet := PROJECT(InDataSet, TRANSFORM(Layout_Order_DLN, SELF.DLN := LEFT.DLNumber, SELF.DLNState := LEFT.DLState, SELF := LEFT));
		
		// Make SOAP call with the DLN dataset
		Result_RecSet := SOAPCALL(DLNDataSet, 
															IPAddr, 
															Serv, 
															Layout_Order_DLN, 
															TRANSFORM(Layout_Order_DLN, SELF := LEFT),
															DATASET(Layout_Result_Soap), 
															PARALLEL(15));
		RETURN Result_RecSet;
	END;
	
	/* Generic Inquiries */
	EXPORT Generic := FUNCTION
		// Read inquiries & make SOAP calls
		InDataSet := readInquiries;
		Result_RecSet := batchSoapRequests(InDataSet);
		
		RETURN formatResult(Result_RecSet);
	END;
	
	/* SSN Inquiries (Will consider only SSN-related data in the inquiry even if other elements are present) */
	EXPORT SSN := FUNCTION
		// Read inquiries & make SOAP calls
		InDataSet := readInquiries;
		Result_RecSet := batchSSNSoapRequests(InDataSet);
		
		RETURN formatResult(Result_RecSet);
	END;
	
	/* DLN Inquiries (Will consider only DLN-related data in the inquiry even if other elements are present) */
	EXPORT DLN := FUNCTION
		// Read inquiries & make SOAP calls
		InDataSet := readInquiries;
		Result_RecSet := batchDLNSoapRequests(InDataSet);
		
		RETURN formatResult(Result_RecSet);
	END;
	
END;

/**
Run this Attribute from the Builder Window using the one of the following commands:
OUTPUT(CompID_Services.Soap_Csv_Address.Generic, , 
			 '~webdev02::MT::OUT::AE_0427Hits.txt', 
			 OVERWRITE);

OUTPUT(CompID_Services.Soap_Csv_Address.SSN, , 
			 '~webdev02::MT::OUT::AE_SSN_0415.txt', 
			 OVERWRITE);

OUTPUT(CompID_Services.Soap_Csv_Address.DLN, , 
			 '~webdev02::MT::OUT::AE_DL_0505.txt', 
			 OVERWRITE);
*/
