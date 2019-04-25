EXPORT NonFCRA_Inquiry_Report(Par1):=FUNCTIONMACRO
import Inquiry_AccLogs, ut;

BuildVersion:=Par1;
eyeball:=all;
bsversion := 50;
isfcra := FALSE;


key := Inquiry_AccLogs.Key_Inquiry_DID;

temprec := record
	recordof(key.person_q) person_q;
	string industry;
	string vertical;
	string func;
	string logdate;
	
	boolean Total_Inq;
	boolean Inquiry;
	boolean Collection;
	boolean Auto;
	boolean Banking;
	boolean Mortgage;
	boolean HighRiskCredit;
	boolean Retail;
	boolean Communications;
	boolean PrepaidCards; 
	boolean RetailPayments; 
	boolean Utilities; 
	boolean QuizProvider; 
	boolean StudentLoan;	
	boolean Other;
	string fcra_purpose;
	
	string	Transaction_ID := '';
	string	Sequence_Number := '';
	
	// string industry;
	// string vertical;
	// string logdate;
		
	// boolean Collection;
	// boolean Auto;
	// boolean Banking;
	// boolean Mortgage;
	// boolean HighRiskCredit;
	// boolean Retail;
	// boolean Communications;
	// boolean QuizProvider; 
	// boolean Utilities; 
	// boolean StudentLoan;
	boolean Blank;
	// boolean Other;
	boolean Invalid;
	boolean Unknown;
	
	boolean VerticalNull;
	boolean VerticalCorpMarkets;
	boolean VerticalCorpMarketsCore;
	boolean VerticalCorpMartketsEnterprise;
	boolean VerticalFinancialServices;
	boolean VerticalPendingAssignment;
	boolean VerticalReceivablesManagement;
	boolean VerticalOther;
	
	// string	Transaction_ID := '';
	// string	Sequence_Number := '';
	
end;


temprec transform_raw(Inquiry_AccLogs.Key_Inquiry_DID rt) := transform
	self.fcra_purpose := trim(rt.permissions.fcra_purpose);
	
	industry := trim(StringLib.StringToUpperCase(rt.bus_intel.industry));
	vertical := trim(StringLib.StringToUpperCase(rt.bus_intel.vertical));
	self.industry := industry;
	self.vertical := vertical;
	
		logdate := rt.search_info.datetime[1..8];
		
	self.logdate  := logdate;
	self.person_q := rt.person_q;

	sub_market := trim(StringLib.StringToUpperCase(rt.bus_intel.sub_market));
	use := trim(StringLib.StringToUpperCase(rt.bus_intel.use));
	func := trim(StringLib.StringToUpperCase(rt.search_info.function_description));

	product_code := trim(rt.search_info.product_code);
	purpose := trim(rt.permissions.fcra_purpose);
  method := trim(StringLib.StringToUpperCase(rt.search_info.method));																							
																							
/* NEW 5.0 LOGIC */ 
is_banko_inquiry := func in Inquiry_AccLogs.shell_constants.banko_functions or (stringlib.stringfind(func, 'MONITORING', 1) > 0 AND product_code='5'); // monitoring transactions with product code=5 are also banko_batch

	function_is_ok := if(isfcra, 
			func in Inquiry_AccLogs.shell_constants.set_valid_fcra_functions(bsversion), // exclude batch functions
			func in Inquiry_AccLogs.shell_constants.set_valid_nonfcra_functions(bsversion));

inquiry_hit :=  /*Inquiry_AccLogs.shell_constants.inquiry_is_ok(le.historydate, logdate, isFCRA_temp) and*/
								 function_is_ok and
								 not is_banko_inquiry and
								 trim(rt.bus_intel.use)='' and
								 product_code in Inquiry_AccLogs.shell_constants.valid_product_codes;

  boolean isBlank          := industry in ['BLANK'];
	boolean isNullIndustry   := industry = '';
	boolean isInvalid        := industry in ['INTERNAL','TEST ACCOUNT','GOVERNMENT','HEALTHCARE','INSURANCE'];
	boolean batch_method := method in ['BATCH','MONITORING']; 
	boolean isCollection := inquiry_hit and 
			// (~isFCRA or trim(rt.permissions.fcra_purpose) = '164') and
			(vertical in ['COLLECTIONS','RECEIVABLES MANAGEMENT'] or industry IN Inquiry_AccLogs.shell_constants.collection_industry or
				StringLib.StringFind(StringLib.StringToUpperCase(sub_market),'FIRST PARTY', 1) > 0);	
	
	boolean isAuto           := not isCollection and not batch_method and inquiry_hit and industry in Inquiry_AccLogs.shell_constants.auto_industry;
	boolean isBanking        := not isCollection and not batch_method and inquiry_hit and industry in 
		if(bsversion>=50, Inquiry_AccLogs.shell_constants.banking_industry5, Inquiry_AccLogs.shell_constants.banking_industry4);
	boolean isMortgage       := not isCollection and not batch_method and inquiry_hit and industry in Inquiry_AccLogs.shell_constants.Mortgage_industry;	
	boolean isHighRiskCredit := not isCollection and not batch_method and inquiry_hit and industry in 
		if(bsversion>=50, Inquiry_AccLogs.shell_constants.HighRiskCredit_industry5, Inquiry_AccLogs.shell_constants.HighRiskCredit_industry4);
	boolean isRetail         := not isCollection and not batch_method and inquiry_hit and industry in Inquiry_AccLogs.shell_constants.Retail_industry;
	boolean isCommunications := not isCollection and not batch_method and inquiry_hit and industry in 
		if(bsversion>=50, Inquiry_AccLogs.shell_constants.communications_industry5, Inquiry_AccLogs.shell_constants.communications_industry4);
	boolean isFraudSearch := inquiry_hit and func in Inquiry_AccLogs.shell_constants.fraud_search_functions;
	
	boolean isPrepaidCards := not isCollection and not batch_method and inquiry_hit and industry in Inquiry_AccLogs.shell_constants.PrepaidCards_industry;
	boolean isRetailPayments := not isCollection and not batch_method and inquiry_hit and industry in Inquiry_AccLogs.shell_constants.RetailPayments_industry and
													func in Inquiry_AccLogs.shell_constants.RetailPayments_functions;
	boolean isUtilities := not isCollection and not batch_method and inquiry_hit and industry in Inquiry_AccLogs.shell_constants.Utilities_industry;
	boolean isQuizProvider := not isCollection and not batch_method and inquiry_hit and industry in Inquiry_AccLogs.shell_constants.QuizProvider_industry;
	boolean isStudentLoan := not isCollection and not batch_method and inquiry_hit and industry in Inquiry_AccLogs.shell_constants.StudentLoans_industry;

	boolean isOther_v4 := inquiry_hit and not batch_method and 
										not isCollection and 
										not isAuto and 
										not isBanking and 
										not isMortgage and
										not isHighRiskCredit and
										not isRetail and
										not isCommunications;
										
	boolean isOther_v5 := inquiry_hit and not batch_method and 
										not isCollection and 
										not isAuto and 
										not isBanking and 
										not isMortgage and
										not isHighRiskCredit and
										not isRetail and
										not isCommunications and
										not isPrepaidCards and
										not isRetailPayments and
										not isUtilities and
										not isQuizProvider and
										not isStudentLoan;
										
	boolean isOther := if(bsversion >=50, isOther_v5, isOther_v4);
	
	boolean isUnknown := not isCollection and 
											 not isAuto and 
											 not isBanking and 
											 not isMortgage and 
											 not isHighRiskCredit and 
											 not isRetail and
											 not isCommunications and 
											 not isUtilities and 
											 not isQuizProvider and 
											 not isStudentLoan and
											 not isBlank and 
											 not isNullIndustry and 
											 not isOther and 
											 not isInvalid;
  
	
	// for the totals bucket in version 5.0, don't include collections or highriskcredit
	inquiry_total_hit := isAuto or isBanking or isCollection or isMOrtgage or isHighRiskCredit or isRetail or
				isCommunications or isOther or isUtilities or isQuizProvider or isStudentLoan or isPrepaidCards or 
				isRetailPayments;
	
	// self.industry := industry;
	// self.vertical := vertical;
	self.func := func;
	// self.logdate := if(inquiry_hit, logdate, skip);
			
	self.Total_Inq := inquiry_total_hit;
	self.Inquiry := inquiry_hit;	
	self.Collection := isCollection;
	self.Auto := isAuto;
	self.Banking := isBanking;
	self.Mortgage := isMortgage;
	self.HighRiskCredit := isHighRiskCredit;
	self.Retail := isRetail;
	self.Communications := isCommunications;
	self.PrepaidCards := isPrepaidCards; 
	self.RetailPayments := isRetailPayments; 
	self.Utilities := isUtilities; 
	self.QuizProvider := isQuizProvider; 
	self.StudentLoan := isStudentLoan; 
	self.Other := isOther;
	self.Blank          := isBlank;
	self.Invalid        := isInvalid;
	self.Unknown        := isUnknown;

	boolean isNullVertical                   := vertical = '';
	boolean isCorpMarketsVertical            := vertical = 'CORPORATE MARKETS';
	boolean isCorpMarketsCoreVertical        := vertical = 'CORPORATE MARKETS - CORE';
	boolean isCorpMartketsEnterpriseVertical := vertical = 'CORPORATE MARKETS - ENTERPRISE';
	boolean isFinancialServicesVertical      := vertical = 'FINANCIAL SERVICES';
	boolean isPendingAssignmentVertical      := vertical = 'PENDING ASSIGNMENT';
	boolean isReceivablesManagementVertical  := vertical = 'RECEIVABLES MANAGEMENT';
	boolean isOtherVertical := not isNullVertical and 
														 not isCorpMarketsVertical and 
													   not isCorpMarketsCoreVertical and 
													   not isCorpMartketsEnterpriseVertical and 
													   not isFinancialServicesVertical and 
													   not isPendingAssignmentVertical and
													   not isReceivablesManagementVertical;
	
	self.VerticalNull                   := isNullVertical;
	self.VerticalCorpMarkets            := isCorpMarketsVertical;
	self.VerticalCorpMarketsCore        := isCorpMarketsCoreVertical;
	self.VerticalCorpMartketsEnterprise := isCorpMartketsEnterpriseVertical;
	self.VerticalFinancialServices      := isFinancialServicesVertical;
	self.VerticalPendingAssignment      := isPendingAssignmentVertical;
	self.VerticalReceivablesManagement  := isReceivablesManagementVertical;
	self.VerticalOther                  := isOtherVertical;
	
	self.Transaction_ID := rt.search_info.Transaction_ID;
	self.Sequence_Number := rt.search_info.Sequence_Number;
	
end;
	
nonfcra_inquiries :=project(Inquiry_AccLogs.Key_Inquiry_DID, transform_raw(left));
nonfcra_inquiries_update := project(Inquiry_AccLogs.Key_Inquiry_DID_Update, transform_raw(left));

nonfcra_inquiries_all := nonfcra_inquiries + nonfcra_inquiries_update;

deduped_inquiries := dedup(sort(nonfcra_inquiries_all, person_q.Appended_ADL, transaction_id, sequence_number ), 
														person_q.Appended_ADL, transaction_id, sequence_number);

InqADLs := table(deduped_inquiries, {
														adl := person_q.appended_ADL,
														total := count(group),
														
														auto_inquiries           := count(group, Auto),
														banking_inquiries        := count(group, Banking),
														collection_inquiries     := count(group, Collection),
														communications_inquiries := count(group, Communications),
														HighRiskCredit_inquiries := count(group, HighRiskCredit),
														Mortgage_inquiries       := count(group, Mortgage),
														Retail_inquiries         := count(group, Retail),
														utility_inquiries        := count(group, Utilities),
														StudentLoan_inquiries    := count(group, StudentLoan),
														Other_inquiries          := count(group, Other),
														Blank_inquiries          := count(group, Blank),
														Invalid_inquiries        := count(group, Invalid),
														Unknown_inquiries        := count(group, Unknown),
														
														null_verticals                     := count(group,VerticalNull),
														corp_markets_verticals             := count(group,VerticalCorpMarkets),
														corp_markets_core_verticals        := count(group,VerticalCorpMarketsCore),
														corp_martkets_enterprise_verticals := count(group,VerticalCorpMartketsEnterprise),
														financial_services_verticals       := count(group,VerticalFinancialServices),
														pending_assignment_verticals       := count(group,VerticalPendingAssignment),
														receivables_management_verticals   := count(group,VerticalReceivablesManagement),
														other_verticals                    := count(group,VerticalOther)
														
														}, person_q.appended_ADL ):INDEPENDENT;

InqByUniqueADL := table(InqADLs, {
														unique_adls := count(group),
														
														auto           := count(group, auto_inquiries>0),
														banking        := count(group, Banking_inquiries>0),
														collection     := count(group, Collection_inquiries>0),
														communications := count(group, Communications_inquiries>0),
														HighRiskCredit := count(group, HighRiskCredit_inquiries>0),
														Mortgage       := count(group, Mortgage_inquiries>0),
														Retail         := count(group, Retail_inquiries>0),
														Utility        := count(group, utility_inquiries>0),
														StudentLoan    := count(group, StudentLoan_inquiries>0),
														Other          := count(group, Other_inquiries>0),
														Blank          := count(group, Blank_inquiries>0),
														Invalid        := count(group, Invalid_inquiries>0),
														Unknown        := count(group, Unknown_inquiries>0),
														
														unique_adls_verts             := count(group),
														null_verts                    := count(group,null_verticals>0),
														corp_markets_verts            := count(group,corp_markets_verticals>0),
														corp_markets_core_verts       := count(group,corp_markets_core_verticals>0),
														corp_markets_enterprise_verts := count(group,corp_martkets_enterprise_verticals>0),
														financial_services_verts      := count(group,financial_services_verticals>0),
														pending_assignment_verts      := count(group,pending_assignment_verticals>0),
														receivables_management_verts  := count(group,receivables_management_verticals>0),
														other_verts                   := count(group,other_verticals>0)
														});

OutRec := RECORD
	string build_version;
	string grouping;
	string group_value;
	unsigned6 group_count;
	string source_file;
END;

OutRec NormAdls(recordof(InqByUniqueADL) L, integer C) := TRANSFORM
	self.build_version := (string)BuildVersion;
	self.grouping := if(C <= 14, 'Industry ADLs', 'Vertical ADLs');

	self.group_value := choose(C, 
													'Total', 'Auto', 'Banking', 'Collection', 'Communications', 'High Risk Credit', 'Mortgage', 'Retail', 'Utility', 'Student Loan', 'Other', 'Blank','Invalid', 'Unknown',
													'Total', 'Null', 'Corporate Markets', 'Corporate Markets - Core', 'Corporate Markets - Enterprise', 'Financial Services', 'Pending Assignment', 'Receivables Management', 'Invalid');
	self.group_count := choose(C, 
													L.unique_adls, L.auto, L.banking, L.collection, L.communications, L.HighRiskCredit, L.Mortgage, L.Retail, L.Utility, L.StudentLoan, L.Other, L.Blank, L.Invalid, L.Unknown,
													L.unique_adls_verts, L.null_verts, L.corp_markets_verts, L.corp_markets_core_verts, L.corp_markets_enterprise_verts, L.financial_services_verts, L.pending_assignment_verts, L.receivables_management_verts, L.other_verts);

	self.source_file := 'InquirytableKeys';
END;

InqByUniqueADL_Norm := NORMALIZE(InqByUniqueADL, 23, NormAdls(LEFT, COUNTER)):INDEPENDENT;
output(InqByUniqueADL_Norm, named('InqByUniqueADL'));

InqTotals := table(InqADLs, {
														total_records  := sum(group, total),
														auto           := sum(group, auto_inquiries),
														banking        := sum(group, Banking_inquiries),
														collection     := sum(group, Collection_inquiries),
														communications := sum(group, Communications_inquiries),
														HighRiskCredit := sum(group, HighRiskCredit_inquiries),
														Mortgage       := sum(group, Mortgage_inquiries),
														Retail         := sum(group, Retail_inquiries),
														Utility        := sum(group, utility_inquiries),
														StudentLoan    := sum(group, StudentLoan_inquiries),
														Other          := sum(group, Other_inquiries),
														Blank          := sum(group, Blank_inquiries),
														Invalid        := sum(group, Invalid_inquiries),
														Unknown        := sum(group, Unknown_inquiries),
														
														total_records_verts           := sum(group, total),
														null_verts                    := sum(group,null_verticals),
														corp_markets_verts            := sum(group,corp_markets_verticals),
														corp_markets_core_verts       := sum(group,corp_markets_core_verticals),
														corp_markets_enterprise_verts := sum(group,corp_martkets_enterprise_verticals),
														financial_services_verts      := sum(group,financial_services_verticals),
														pending_assignment_verts      := sum(group,pending_assignment_verticals),
														receivables_management_verts  := sum(group,receivables_management_verticals),
														other_verts                   := sum(group,other_verticals)
														});

OutRec NormInqs(recordof(InqTotals) L, integer C) := TRANSFORM
	self.build_version := (string)BuildVersion;
	self.grouping := if(C <= 14, 'Industry', 'Vertical');

	self.group_value := choose(C, 
													'Total', 'Auto', 'Banking', 'Collection', 'Communications', 'High Risk Credit', 'Mortgage', 'Retail', 'Utility', 'Student Loan', 'Other', 'Blank', 'Invalid', 'Unknown',
													'Total', 'Null', 'Corporate Markets', 'Corporate Markets - Core', 'Corporate Markets - Enterprise', 'Financial Services', 'Pending Assignment', 'Receivables Management', 'Invalid');
													
	self.group_count := choose(C, 
													L.total_records, L.auto, L.banking, L.collection, L.communications, L.HighRiskCredit, L.Mortgage, L.Retail, L.Utility, L.StudentLoan, L.Other, L.Blank, L.Invalid, L.Unknown,
													L.total_records_verts, L.null_verts, L.corp_markets_verts, L.corp_markets_core_verts, L.corp_markets_enterprise_verts, L.financial_services_verts, L.pending_assignment_verts, L.receivables_management_verts, L.other_verts);
	
	self.source_file := 'InquirytableKeys';
END;

InqTotals_Norm := NORMALIZE(InqTotals, 23, NormInqs(LEFT, COUNTER)):INDEPENDENT;

InquiryTotal := InqTotals_Norm + InqByUniqueADL_Norm;
output(InquiryTotal, ,'~inquirycounttracking::nonfcra' + BuildVersion,thor,overwrite);


RETURN 0;
ENDMACRO;