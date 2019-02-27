IMPORT iesp, Inquiry_AccLogs, Risk_Indicators, RiskWise, Inquiry_Deltabase;

EXPORT Layouts := MODULE
	// Deltabase Input Layouts
	EXPORT Deltabase_Value := RECORD
		STRING100 Value {XPATH('Value')};
	END;
	EXPORT Deltabase_Parameters := RECORD
		DATASET(Deltabase_Value) Parameter {XPATH('Parameter')}; 
	END;
	EXPORT Deltabase_Input := RECORD
		STRING Select {XPATH('Select')};
		DATASET(Deltabase_Parameters) Parameters {XPATH('Parameters')};
	END;
	
	// Deltabase Output Layouts
	EXPORT Deltabase_Record := RECORD
		STRING20 Seq {XPATH('Seq')};
		STRING50 Transaction_ID {XPATH('Transaction_ID')};
		STRING22 DateTime {XPATH('DateTime')};
		STRING30 Industry {XPATH('Industry')};
		STRING25 Vertical {XPATH('Vertical')};
		STRING30 Sub_Market {XPATH('Sub_Market')};
		STRING10 Use {XPATH('Use')};
		STRING100 Function_Description {XPATH('Function_Description')};
		STRING3 Product_Code {XPATH('Product_Code')};
		STRING2 GLB_Purpose {XPATH('GLB_Purpose')};
		STRING2 DPPA_Purpose {XPATH('DPPA_Purpose')};
		STRING5 Transaction_Type {XPATH('Transaction_Type')};
		STRING20 FName {XPATH('FName')};
		STRING20 MName {XPATH('MName')};
		STRING20 LName {XPATH('LName')};
		STRING5 SName {XPATH('SName')};
		STRING120 Address {XPATH('Address')};
		STRING25 City {XPATH('City')};
		STRING2 State {XPATH('State')};
		STRING9 Zip {XPATH('Zip')};
		STRING10 Phone10 {XPATH('Phone10')};
		STRING10 Work_Phone {XPATH('Work_Phone')};
		STRING8 DOB {XPATH('DOB')};
		STRING15 DL {XPATH('DL')};
		STRING2 DL_State {XPATH('DL_State')};
		STRING100 EMail {XPATH('EMail')};
		STRING9 SSN {XPATH('SSN')};
		STRING20 Response_LexID {XPATH('Response_LexID')};
		STRING30 IPAddr {XPATH('IPAddr')};
		STRING10 Clean_Prim_Range {XPATH('Clean_Prim_Range')};
		STRING2 Clean_Predir {XPATH('Clean_Predir')};
		STRING28 Clean_Prim_Name {XPATH('Clean_Prim_Name')};
		STRING4 Clean_Addr_Suffix {XPATH('Clean_Addr_Suffix')};
		STRING2 Clean_PostDir {XPATH('Clean_PostDir')};
		STRING10 Clean_Unit_Desig {XPATH('Clean_Unit_Desig')};
		STRING8 Clean_Sec_Range {XPATH('Clean_Sec_Range')};
		STRING25 Clean_V_City_Name {XPATH('Clean_V_City_Name')};
		STRING2 Clean_St {XPATH('Clean_St')};
		STRING5 Clean_Zip5 {XPATH('Clean_Zip5')};
		STRING4 Clean_Zip4 {XPATH('Clean_Zip4')};
		STRING1 Clean_Addr_Rec_Type {XPATH('Clean_Addr_Rec_Type')};
		STRING2 Clean_FIPS_State {XPATH('Clean_FIPS_State')};
		STRING5 Clean_FIPS_County {XPATH('Clean_FIPS_County')};
		STRING10 Clean_Geo_Lat {XPATH('Clean_Geo_Lat')};
		STRING11 Clean_Geo_Long {XPATH('Clean_Geo_Long')};
		STRING5 Clean_CBSA {XPATH('Clean_CBSA')};
		STRING7 Clean_Geo_Blk {XPATH('Clean_Geo_Blk')};
		STRING1 Clean_Geo_Match {XPATH('Clean_Geo_Match')};
		STRING4 Clean_Err_Stat {XPATH('Clean_Err_Stat')};
    STRING1 Search_Type {XPATH('Search_Type')};
	END;
	EXPORT Deltabase_Response := RECORD
		DATASET(Deltabase_Record) Response {XPATH('Records/Rec')};
		STRING5 RecordsReturned {XPATH('RecsReturned')};
		STRING10 ResponseLatency {XPATH('Latency')};
		STRING200 ExceptionMessage {XPATH('Exceptions/Exception/Message')};	
	END;
	
	// Inquiry Key Layouts
	EXPORT Inquiry_Address := RECORD
		RECORDOF(Inquiry_AccLogs.Key_Inquiry_Address);
	END;
	EXPORT Inquiry_DID := RECORD
		RECORDOF(Inquiry_AccLogs.Key_Inquiry_DID);
	END;
	EXPORT Inquiry_Email := RECORD
		RECORDOF(Inquiry_AccLogs.Key_Inquiry_Email);
	END;
	EXPORT Inquiry_IPAddr := RECORD
		RECORDOF(Inquiry_AccLogs.Key_Inquiry_IPAddr);
	END;
	EXPORT Inquiry_Name := RECORD
		RECORDOF(Inquiry_AccLogs.Key_Inquiry_Name);
	END;
	EXPORT Inquiry_Phone := RECORD
		RECORDOF(Inquiry_AccLogs.Key_Inquiry_Phone);
	END;
	EXPORT Inquiry_SSN := RECORD
		RECORDOF(Inquiry_AccLogs.Key_Inquiry_SSN);
	END;
	EXPORT Inquiry_Transaction_ID := RECORD
		RECORDOF(Inquiry_AccLogs.Key_Inquiry_Transaction_ID);
	END;	
  EXPORT Inquiry_All := RECORD
    RECORDOF(Inquiry_AccLogs.Key_Inquiry_Address);
    RECORDOF(Inquiry_AccLogs.Key_Inquiry_DID);
    RECORDOF(Inquiry_AccLogs.Key_Inquiry_Email);
    RECORDOF(Inquiry_AccLogs.Key_Inquiry_IPAddr);
    RECORDOF(Inquiry_AccLogs.Key_Inquiry_Name);
    RECORDOF(Inquiry_AccLogs.Key_Inquiry_Phone);
    RECORDOF(Inquiry_AccLogs.Key_Inquiry_SSN);
    RECORDOF(Inquiry_AccLogs.Key_Inquiry_Transaction_ID);
    STRING1 Search_Type;
  END;
	// Deltabase Function Inputs
	EXPORT Input_Deltabase_Address := RECORD
		UNSIGNED8 Seq := 0;
		STRING10 Prim_Range := '';
		STRING28 Prim_Name := '';
		STRING8 Sec_Range := '';
		STRING5 Zip5 := '';
	END;
	EXPORT Input_Deltabase_DID := RECORD
		UNSIGNED8 Seq := 0;
		UNSIGNED8 DID := 0;
	END;
	EXPORT Input_Deltabase_Email := RECORD
		UNSIGNED8 Seq := 0;
		STRING100 Email := '';
	END;
	EXPORT Input_Deltabase_IPAddr := RECORD
		UNSIGNED8 Seq := 0;
		STRING100 IPAddress := '';
	END;
	EXPORT Input_Deltabase_Name := RECORD
		UNSIGNED8 Seq := 0;
		STRING20 FirstName := '';
		STRING20 MiddleName := '';
		STRING20 LastName := '';
	END;
	EXPORT Input_Deltabase_Phone := RECORD
		UNSIGNED8 Seq := 0;
		STRING10 Phone10 := '';
	END;
	EXPORT Input_Deltabase_SSN := RECORD
		UNSIGNED8 Seq := 0;
		STRING9 SSN := '';
	END;
	EXPORT Input_Deltabase_Transaction_ID := RECORD
		UNSIGNED8 Seq := 0;
		STRING50 Transaction_ID := '';
	END;
	EXPORT Input_Deltabase_All := RECORD
		UNSIGNED8 Seq := 0;
		STRING10 Prim_Range := '';
		STRING28 Prim_Name := '';
		STRING8 Sec_Range := '';
		STRING5 Zip5 := '';
		UNSIGNED8 DID := 0;
		STRING100 Email := '';
		STRING100 IPAddress := '';
		STRING20 FirstName := '';
		STRING20 MiddleName := '';
		STRING20 LastName := '';
		STRING10 Phone10 := '';
		STRING9 SSN := '';
		STRING50 Transaction_ID := '';
	END;
	EXPORT Function_Descriptions := RECORD
		STRING100 FunctionName := '';
	END;
END;