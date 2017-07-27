EXPORT Layouts_NonFCRA := MODULE

EXPORT Input := record
	string transaction_id;
	string customer_id;
	string inputxml;
	string outputxml;
	string input_recordtype;
	string output_recordtype;
	string datetime;
end;

EXPORT Base_Layout := record
	STRING2 source;
	STRING30 transaction_id;
	STRING17 datetime;
	STRING10 customer_id;
	STRING1 product_code;
	STRING30 product;
	STRING inputxml {MAXLENGTH(3072)};
	DATASET(Score_Logs.Layouts_InputXML.rform1) inputxml_parsed {XPATH('Info'), MAXLENGTH(3072)}; // 3 kb
	STRING outputxml {MAXLENGTH(30720)};
	DATASET(Score_Logs.Layouts_OutputXML.rform1) outputxml_parsed {XPATH('OutResults'), MAXLENGTH(30720)}; // 30 kb
END;

END;