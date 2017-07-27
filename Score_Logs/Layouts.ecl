/*2013-06-07T18:24:26Z (cguyton_prod)
C:\Users\guytoncn\AppData\Roaming\HPCC Systems\eclide\cguyton_prod\proxy_prod\Score_Logs\Layouts\2013-06-07T18_24_26Z.ecl
*/
EXPORT Layouts := MODULE

EXPORT Input := record
	string transaction_id;
	string customer_id;
	string inputxml {MAXLENGTH(35000)};
	string outputxml {MAXLENGTH(35000)};
	string input_recordtype;
	string output_recordtype;
	string datetime;
end;

EXPORT Input_Intermediate := record
	string transaction_id;
	string product_id;
	string datetime;
	string process_type;
	string processing_time;
	string source_code;
	string content_type;
	string version;
	string unknown;
	string outputxml {MAXLENGTH(162000)};
end;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

EXPORT Base_AccTransaction_Layout := RECORD
	STRING source;
	STRING transaction_id;
	STRING billing_code;
	STRING login_id;
	STRING customer_id;
	STRING product_code;
	STRING datetime;
	STRING function_name;
	STRING transaction_type;
END;

EXPORT Base_Transaction_Layout := record
	STRING transaction_id;
	STRING customer_id;
	STRING input_recordtype;
	STRING output_recordtype;
	STRING datetime;
	STRING30 product;
	STRING inputxml {MAXLENGTH(3072)};
	DATASET(Score_Logs.Layouts_InputXML.rform1) inputxml_parsed {XPATH('Info'), MAXLENGTH(3072)}; // 3 kb
	STRING outputxml {MAXLENGTH(30720)};
	DATASET(Score_Logs.Layouts_OutputXML.rform1) outputxml_parsed {XPATH('OutResults'), MAXLENGTH(30720)}; // 30 kb
END;

EXPORT Base_Intermediate_Layout := record
	STRING2 source;
	STRING30 transaction_id;
	STRING17 datetime;
	STRING1 product_code;
	// STRING outputxml {MAXLENGTH(100000)};
	// DATASET(Score_Logs.Layouts_OutputXML_Intermediate.rform1) outputxml_parsed {XPATH('OutResults'), MAXLENGTH(100000)};
	STRING outputxml {MAXLENGTH(162000)};
	DATASET(Score_Logs.Layouts_OutputXML_Intermediate.rform1) outputxml_parsed {XPATH('OutResults'), MAXLENGTH(162000)};

END;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

EXPORT Base_Transaction_Key_Layout := record
	STRING30 transaction_id;
	STRING17 datetime;
	STRING10 customer_id;
	STRING20 login_id;
	STRING20 billing_code;
	STRING1 product_code;
	STRING30 product;
	STRING inputxml {BLOB,MAXLENGTH(3072)};
	STRING outputxml {BLOB,MAXLENGTH(29500)}; //key length limit of 32767 
END;

EXPORT Base_Intermediate_Key_Layout := record
	STRING2 source;
	STRING30 transaction_id;
	STRING17 datetime;
	STRING10 customer_id;
	STRING20 login_id;
	STRING20 billing_code;
	STRING1 product_code;
	STRING outputxml {BLOB,MAXLENGTH(18000)};
	// DATA outputxml {BLOB, MAXLENGTH(100000)}; //key length limit of 32767 unless blob which cannot be displayed on thor
END;

EXPORT Base_Intermediate_Key_Layout_full := record
	STRING2 source;
	STRING30 transaction_id;
	STRING17 datetime;
	STRING10 customer_id;
	STRING20 login_id;
	STRING20 billing_code;
	STRING1 product_code;
	STRING outputxml {MAXLENGTH(162000)};
END;

END;