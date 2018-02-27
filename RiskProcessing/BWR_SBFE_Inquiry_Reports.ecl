
import std, Inquiry_AccLogs, Score_Logs, ut;

// 0. Set job parameters.
STRING6 month_closed := ut.Month_Math(std.date.DateToString(std.Date.today(),'%Y%m'),-1);
STRING inquiry_type := 'ALL'; // Valid values: 'BATCH', 'NON-BATCH', 'ALL'

SET OF STRING set_products := 
	[
		'SMALL BUSINESS BLENDED CREDIT SCORE WITH SBFE DATA',
		'SMALL BUSINESS BLENDED CREDIT SCORE + ATTRIBUTES WITH SBFE DATA',
		'SMALL BUSINESS ATTRIBUTES WITH SBFE DATA',
		'SMALL BUSINESS CREDIT RISK SCORE WITH SBFE DATA',
		'SMALL BUSINESS ATTRIBUTES & CREDIT RISK SCORE WITH SBFE DATA',
		'SMALL BUSINESS ATTRIBUTES WITH SBFE DATA & CREDIT RISK SCORE WITH SBFE DATA',
		'SMBUS ATTRIBUTES & CREDIT RISK SCORE WITH SBFE & BLENDED CREDIT RISK SCORE WITH SBFE'
	];

// 1. Define the final report layout.
layout_Date := RECORD
	STRING year;
	STRING month;
	STRING day;
END;

layout_Address := RECORD
	// STRING StreetAddress1;
	// STRING StreetAddress2;
	STRING StreetNumber;
	STRING StreetPreDirection;
	STRING StreetName;
	STRING StreetSuffix;
	STRING UnitDesignation;
	STRING UnitNumber;
	STRING City;
	STRING State;
	STRING Zip;
END;

layout_BusinessInquiry := RECORD
	STRING CompanyName;
	STRING AltCompanyName;
	layout_Address Address;
	STRING Phone;
	STRING FaxNumber;
	STRING FEIN;
	STRING SICCode;
	STRING NAICCode;
	STRING BusinessStructure;
	STRING YearsInBusiness;
	layout_Date BusinessStartDate;
	STRING YearlyRevenue;
END;

layout_SBFEInquiryReport := RECORD
	// STRING Transaction_ID;
	STRING Inquiry_DateTime;
	STRING Company_ID;
	STRING Global_Company_ID;
	STRING Customer_Name_Line_of_Business;
 	STRING Inquiry_Type;
	STRING Product_Inquiried;
	layout_BusinessInquiry Inquiry;
END;

// 2. Distribute all Inquiry AccLogs... 
AccLogs := Inquiry_AccLogs.File_Inquiry_MBS;
AccLogs_dist    := DISTRIBUTE( AccLogs, HASH32(Search_Info.transaction_id) ); 

// ...and Score_Logs records.
ScoreLogs_dist  := DISTRIBUTE( Score_Logs.Key_ScoreLogs_XMLTransactionID, HASH32(transaction_id) ); 
ScoreLogs_dist_filt := ScoreLogs_dist(datetime[1..6] = month_closed);

// ... mbs data
mbs_file := Inquiry_AccLogs.File_MBS.File;

// 3. Obtain all records that fall in the specific month, and have matching function_descriptions.
AccLogs_raw := 
	AccLogs_dist( 
			(Search_Info.DateTime[1..6] = month_closed) AND 
			Search_Info.function_description IN set_products
	);

AccLogs_filt := 
	MAP(
		inquiry_type = 'BATCH'     => AccLogs_raw(StringLib.StringToUpperCase(Search_Info.method)  = 'BATCH'),
		inquiry_type = 'NON-BATCH' => AccLogs_raw(StringLib.StringToUpperCase(Search_Info.method) != 'BATCH'),
		AccLogs_raw // default or inquiry_type = 'ALL'
	);

// 4. Join to ScoreLogs_dist_filt to pick up all of the remaining data and then build Report1.
fn_getTagValue(STRING tagName = '', STRING originalXML = '', STRING UCaseXML = '') := FUNCTION
	UCaseTagName             := StringLib.StringToUpperCase(tagName);
	opening_TagName_startPos := StringLib.StringFind(UCaseXML, UCaseTagName, 1);
	closing_TagName_startPos := StringLib.StringFind(UCaseXML, UCaseTagName, 2);
	
	value_startPos := opening_TagName_startPos + LENGTH(UCaseTagName) + 1;
	value_endPos   := closing_TagName_startPos - 3;
	
	RETURN originalXML[value_startPos..value_endPos];
END;

layout_BusinessInquiry xfm_loadCompanyData(AccLogs_raw le, ScoreLogs_dist_filt ri) :=
	TRANSFORM
		inputXMLUCase := StringLib.StringToUpperCase(ri.inputXML);
		subtree_BusinessStartDate := fn_getTagValue('businessstartdate',ri.inputXML,inputXMLUCase);
		subtree_BusinessStartDateUCase := StringLib.StringToUpperCase(subtree_BusinessStartDate);

		SELF.CompanyName                := le.Bus_Q.cname;
		SELF.AltCompanyName             := fn_getTagValue('alternatecompanyname',ri.inputXML,inputXMLUCase);
		// SELF.Address.StreetAddress1     := '';
		// SELF.Address.StreetAddress2     := '';
		SELF.Address.StreetNumber       := le.Bus_Q.prim_range;
		SELF.Address.StreetPreDirection := le.Bus_Q.predir;
		SELF.Address.StreetName         := le.Bus_Q.prim_name;
		SELF.Address.StreetSuffix       := le.Bus_Q.addr_suffix;
		SELF.Address.UnitDesignation    := le.Bus_Q.unit_desig;
		SELF.Address.UnitNumber         := le.Bus_Q.sec_range;
		SELF.Address.City               := le.Bus_Q.city;
		SELF.Address.State              := le.Bus_Q.state;
		SELF.Address.Zip                := le.Bus_Q.zip5;	
		SELF.Phone                      := le.Bus_Q.Company_Phone;
		SELF.FaxNumber                  := fn_getTagValue('faxnumber',ri.inputXML,inputXMLUCase); 
		SELF.FEIN                       := fn_getTagValue('fein',ri.inputXML,inputXMLUCase); 
		SELF.SICCode                    := fn_getTagValue('siccode',ri.inputXML,inputXMLUCase); 
		SELF.NAICCode                   := fn_getTagValue('naiccode',ri.inputXML,inputXMLUCase); 
		SELF.BusinessStructure          := fn_getTagValue('businessstructure',ri.inputXML,inputXMLUCase); 
		SELF.YearsInBusiness            := fn_getTagValue('yearsinbusiness',ri.inputXML,inputXMLUCase); 
		SELF.BusinessStartDate.year     := fn_getTagValue('year',subtree_BusinessStartDate,subtree_BusinessStartDateUCase); 
		SELF.BusinessStartDate.month    := fn_getTagValue('month',subtree_BusinessStartDate,subtree_BusinessStartDateUCase); 
		SELF.BusinessStartDate.day      := fn_getTagValue('day',subtree_BusinessStartDate,subtree_BusinessStartDateUCase); 
		SELF.YearlyRevenue              := fn_getTagValue('yearlyrevenue',ri.inputXML,inputXMLUCase);	
		SELF := le;
		SELF := [];
	END;
	
layout_SBFEInquiryReport xfm_buildReport1(AccLogs_filt le, ScoreLogs_dist_filt ri) := 
	TRANSFORM
		// SELF.Transaction_ID                 := le.Search_Info.transaction_id;
		SELF.Inquiry_DateTime               := le.Search_Info.DateTime;
		SELF.Company_ID                      := le.MBS.Company_ID;
		SELF.Global_Company_ID							:= le.MBS.global_company_id;
		SELF.Customer_Name_Line_of_Business := '';
		SELF.Inquiry_Type                   := le.search_info.method;
		SELF.Product_Inquiried              := le.search_info.function_description;
		SELF.Inquiry                        := ROW(xfm_loadCompanyData(le,ri));		
	END;
	
Inquiry_Report_pre :=
	JOIN(
		AccLogs_filt, ScoreLogs_dist_filt, // unique identifier for a transaction is really transaction_id + sequence_number
		LEFT.Search_Info.transaction_id = RIGHT.transaction_id, // In Batch, there are many instances of the same transaction_id.
		xfm_buildReport1(LEFT,RIGHT),
		LEFT OUTER,
		LOCAL
	);

mbs_file_sd := dedup(sort(mbs_file(company_id<>''),company_id,gc_id,mbs_company_name),company_id,gc_id,mbs_company_name);
	
Inquiry_Report_pre2 :=	JOIN(Inquiry_Report_pre,
				mbs_file_sd,
				left.Company_ID<>'' and 
				left.Company_ID=right.company_id and 
				left.global_company_id=right.gc_id,
				transform(layout_SBFEInquiryReport,self.Customer_Name_Line_of_Business:=right.mbs_company_name,
				self:=left),
				left outer
				);

Inquiry_Report := PROJECT(Inquiry_Report_pre2,transform(recordof(Inquiry_Report_pre2) - global_company_id,self := left));
	
layout_SBFEUsageReport := RECORD
	Inquiry_Date := Inquiry_Report.Inquiry_DateTime[1..8];
	Company_ID := Inquiry_Report.Company_ID;
	Customer_Name_Line_of_Business := Inquiry_Report.Customer_Name_Line_of_Business;
	Product_Inquiried := Inquiry_Report.Product_Inquiried;
	Inquiry_Method := Inquiry_Report.Inquiry_Type;
	USAGE := count(group);
END;
	
Usage_Report := table(Inquiry_Report,layout_SBFEUsageReport,
									Inquiry_DateTime[1..8],Company_ID,Customer_Name_Line_of_Business,Product_Inquiried,Inquiry_Type);

FileName_InquiryReport := 'SBFE::Reports::InquiryReport_' +month_closed + WORKUNIT;
FileName_UsageReport := 'SBFE::Reports::UsageReport_' + month_closed + WORKUNIT;

OUTPUT(Inquiry_Report,, FileName_InquiryReport, CSV(HEADING(single), QUOTE('"')), OVERWRITE);
OUTPUT(Usage_Report,, FileName_UsageReport, CSV(HEADING(single), QUOTE('"')), OVERWRITE);
