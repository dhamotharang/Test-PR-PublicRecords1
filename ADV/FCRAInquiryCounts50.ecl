import std;
import Inquiry_AccLogs; 
import ADV;

#workunit('name', 'FCRA Inquiry Cnts');

BuildVersion := ADV.InquiryFWeekly.BuildVersion;

key := Inquiry_AccLogs.Key_FCRA_DID;

temprec := record
	recordof(key.person_q) person_q;
	string industry;
	string vertical;
	string logdate;
		
	boolean Collection;
	boolean Auto;
	boolean Banking;
	boolean Mortgage;
	boolean HighRiskCredit;
	boolean Retail;
	boolean Communications;
	boolean QuizProvider; 
	boolean Utilities; 
	boolean StudentLoan;
	boolean Blank;
	boolean Other;
	boolean Invalid;
	boolean Unknown;
	
	boolean VerticalNull;
	boolean VerticalCorpMarkets;
	boolean VerticalFinancialServices;
	boolean VerticalPendingAssignment;
	boolean VerticalReceivablesManagement;
	boolean VerticalOther;
	
	string	Transaction_ID := '';
	string	Sequence_Number := '';
end;


temprec transform_raw(Inquiry_AccLogs.Key_FCRA_DID rt) := transform
	self.person_q := rt.person_q;
	industry := trim(StringLib.StringToUpperCase(rt.bus_intel.industry));
	vertical := trim(StringLib.StringToUpperCase(rt.bus_intel.vertical));

	logdate := rt.search_info.datetime[1..8];

	boolean isCollection     := industry in adv.InquiryGroupings.Collection;
	boolean isAuto           := industry in adv.InquiryGroupings.Auto;
	boolean isBanking        := industry in adv.InquiryGroupings.Banking;
	boolean isMortgage       := industry in adv.InquiryGroupings.Mortgage;
	boolean isHighRiskCredit := industry in adv.InquiryGroupings.HighRiskCredit;
	boolean isRetail         := industry in adv.InquiryGroupings.Retail;
	boolean isCommunications := industry in adv.InquiryGroupings.Communications;
	boolean isUtilities      := industry in adv.InquiryGroupings.Utilities;
	boolean isQuizProvider   := industry in adv.InquiryGroupings.QuizProvider;
	boolean isStudentLoan    := industry in adv.InquiryGroupings.StudentLoans;
	boolean isOther          := industry in adv.InquiryGroupings.Other;
	boolean isBlank          := industry in adv.InquiryGroupings.Blank;
	boolean isNullIndustry   := industry = '';
	boolean isInvalid        := industry in adv.InquiryGroupings.Invalid;
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
	
	self.industry := industry;
	self.vertical := vertical;
	self.logdate  := logdate;

	self.Collection     := isCollection;
	self.Auto           := isAuto;
	self.Banking        := isBanking;
	self.Mortgage       := isMortgage;
	self.HighRiskCredit := isHighRiskCredit;
	self.Retail         := isRetail;
	self.Communications := isCommunications;
	self.Utilities      := isUtilities; 
	self.QuizProvider   := isQuizProvider; 
	self.StudentLoan    := isStudentLoan; 
	self.Other          := isOther;	
	self.Blank          := isBlank;
	self.Invalid        := isInvalid;
	self.Unknown        := isUnknown;

	boolean isNullVertical                   := vertical = '';
	boolean isCorpMarketsVertical            := vertical = 'CORPORATE MARKETS';
	boolean isFinancialServicesVertical      := vertical = 'FINANCIAL SERVICES';
	boolean isPendingAssignmentVertical      := vertical = 'PENDING ASSIGNMENT';
	boolean isReceivablesManagementVertical  := vertical = 'RECEIVABLES MANAGEMENT';
	boolean isOtherVertical := not isNullVertical and 
													   not isCorpMarketsVertical and 
													   not isFinancialServicesVertical and 
													   not isPendingAssignmentVertical and
													   not isReceivablesManagementVertical;
	
	self.VerticalNull                   := isNullVertical;
	self.VerticalCorpMarkets            := isCorpMarketsVertical;
	self.VerticalFinancialServices      := isFinancialServicesVertical;
	self.VerticalPendingAssignment      := isPendingAssignmentVertical;
	self.VerticalReceivablesManagement  := isReceivablesManagementVertical;
	self.VerticalOther                  := isOtherVertical;
	
	self.Transaction_ID  := rt.search_info.Transaction_ID;
	self.Sequence_Number := rt.search_info.Sequence_Number;
	
end;
	

fcra_inquiries := project(Key((unsigned)search_info.datetime[1..4]>=2008), transform_raw(left));
deduped_inquiries := dedup(sort(fcra_inquiries, person_q.Appended_ADL, transaction_id, sequence_number, logdate), 
														person_q.Appended_ADL, transaction_id, sequence_number, logdate);

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
														
														null_verticals                   := count(group,VerticalNull),
														corp_markets_verticals           := count(group,VerticalCorpMarkets),
														financial_services_verticals     := count(group,VerticalFinancialServices),
														pending_assignment_verticals     := count(group,VerticalPendingAssignment),
														receivables_management_verticals := count(group,VerticalReceivablesManagement),
														other_verticals                  := count(group,VerticalOther)
														
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
														
														unique_adls_verts            := count(group),
														null_verts                   := count(group,null_verticals>0),
														corp_markets_verts           := count(group,corp_markets_verticals>0),
														financial_services_verts     := count(group,financial_services_verticals>0),
														pending_assignment_verts     := count(group,pending_assignment_verticals>0),
														receivables_management_verts := count(group,receivables_management_verticals>0),
														other_verts                  := count(group,other_verticals>0)
														});

OutRec := RECORD
	string build_version;
	string grouping;
	string group_value;
	unsigned6 group_count;
	string source_file;
END;

OutRec NormAdls(recordof(InqByUniqueADL) L, integer C) := TRANSFORM
	self.build_version := BuildVersion;
	self.grouping := if(C <= 14, 'Industry ADLs', 'Vertical ADLs');

	self.group_value := choose(C, 
													'Total', 'Auto', 'Banking', 'Collection', 'Communications', 'High Risk Credit', 'Mortgage', 'Retail', 'Utility', 'Student Loan', 'Other', 'Blank','Invalid', 'Unknown',
													'Total', 'Null', 'Corporate Markets', 'Financial Services', 'Pending Assignment', 'Receivables Management', 'Invalid');
	self.group_count := choose(C, 
													L.unique_adls, L.auto, L.banking, L.collection, L.communications, L.HighRiskCredit, L.Mortgage, L.Retail, L.Utility, L.StudentLoan, L.Other, L.Blank, L.Invalid, L.Unknown,
													L.unique_adls_verts, L.null_verts, L.corp_markets_verts, L.financial_services_verts, L.pending_assignment_verts, L.receivables_management_verts, L.other_verts);

	self.source_file := 'FCRA_InquirytableKeys';
END;

InqByUniqueADL_Norm := NORMALIZE(InqByUniqueADL, 21, NormAdls(LEFT, COUNTER)):INDEPENDENT;
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
														
														total_records_verts          := sum(group, total),
														null_verts                   := sum(group,null_verticals),
														corp_markets_verts           := sum(group,corp_markets_verticals),
														financial_services_verts     := sum(group,financial_services_verticals),
														pending_assignment_verts     := sum(group,pending_assignment_verticals),
														receivables_management_verts := sum(group,receivables_management_verticals),
														other_verts                  := sum(group,other_verticals)
														});

OutRec NormInqs(recordof(InqTotals) L, integer C) := TRANSFORM
	self.build_version := BuildVersion;
	self.grouping := if(C <= 14, 'Industry', 'Vertical');

	self.group_value := choose(C, 
													'Total', 'Auto', 'Banking', 'Collection', 'Communications', 'High Risk Credit', 'Mortgage', 'Retail', 'Utility', 'Student Loan', 'Other', 'Blank', 'Invalid', 'Unknown',
													'Total', 'Null', 'Corporate Markets', 'Financial Services', 'Pending Assignment', 'Receivables Management', 'Invalid');
													
	self.group_count := choose(C, 
													L.total_records, L.auto, L.banking, L.collection, L.communications, L.HighRiskCredit, L.Mortgage, L.Retail, L.Utility, L.StudentLoan, L.Other, L.Blank, L.Invalid, L.Unknown,
													L.total_records_verts, L.null_verts, L.corp_markets_verts, L.financial_services_verts, L.pending_assignment_verts, L.receivables_management_verts, L.other_verts);
	
	self.source_file := 'FCRA_InquirytableKeys';
END;

InqTotals_Norm := NORMALIZE(InqTotals, 21, NormInqs(LEFT, COUNTER)):INDEPENDENT;
output(InqTotals_Norm, named('InqTotals'));

DesprayLogicalFileName   := '~qc::bsw::adv::inquiryfweekly::counts::vertical::despray';

FCRAInquiryCounts :=  InqTotals_Norm + InqByUniqueADL_Norm;
CreateDesprayFile    := output(choosen(FCRAInquiryCounts,all), ,DesprayLogicalFileName, CSV(heading(single), quote('"')), overwrite, expire(30) );
Despray              := std.file.despray(DesprayLogicalFileName, '10.48.72.34', 'C:\\adv\\public_records\\fcraInquiry\\results\\FCRAInquiryCounts.csv',,,,true);

go := sequential(CreateDesprayFile, Despray);
go:FAILURE(FileServices.SendEmail('brandon.walker@lexisnexis.com','ERROR: NonFCRA Inquiry Counts Failed','The failed workunit is: ' + workunit + ' ' + FailMessage));
