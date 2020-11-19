/*** Not to be hand edited (changes will be lost on re-generation) ***/
/*** ECL Interface generated by esdl2ecl version 1.0 from identityriskreport.xml. ***/
/*===================================================*/

import iesp;

export identityriskreport := MODULE
			
export t_RINIdentityRiskReportBy := record (iesp.identityreport.t_RINIdentityReportBy)
end;
		
export t_RINIdentityRiskReportOption := record (iesp.identityreport.t_RINIdentityReportOption)
	string InquiryReason {xpath('InquiryReason')}; //values['Application','Change of non-address contact information','Change of address information','Change of bank account information','Change of beneficiary information','Change of information (other)','Change of information (unknown)','Recertification','Current beneficiary','Termination','Transaction log','Additional benefits','']
end;
		
export t_RINApiRiskAttribute := record
	string20 RiskAttributeCode {xpath('RiskAttributeCode')};
	string200 RiskAttributeReason {xpath('RiskAttributeReason')};
end;
		
export t_RINKnownRisk := record
	string60 ElementType {xpath('ElementType')};//hidden[internal]
	string20 KnownRiskCode {xpath('KnownRiskCode')};//hidden[internal]
	string200 KnownRiskReason {xpath('KnownRiskReason')};
	string100 KnownRiskAgency {xpath('KnownRiskAgency')};
end;
		
export t_RINIdentityRiskReportRecord := record
	string10 RiskLevel {xpath('RiskLevel')};
	string1 IdentityResolved {xpath('IdentityResolved')};
	string12 UniqueId {xpath('UniqueId')};
	iesp.share.t_Date MostRecentActivityDate {xpath('MostRecentActivityDate')};
	unsigned2 TotalNumberIdentityActivities {xpath('TotalNumberIdentityActivities')};
	unsigned2 RiskAttributeCount {xpath('RiskAttributeCount')};
	dataset(t_RINApiRiskAttribute) RiskAttributes {xpath('RiskAttributes/RiskAttribute'), MAXCOUNT(iesp.Constants.RIN.MAX_COUNT_INDICATOR_ATTRIBUTE)};
	unsigned2 KnownRiskCount {xpath('KnownRiskCount')};
	dataset(t_RINKnownRisk) KnownRisks {xpath('KnownRisks/KnownRisk'), MAXCOUNT(iesp.Constants.RIN.MAX_COUNT_INDICATOR_ATTRIBUTE)};
end;
		
export t_IdentityRiskReportResponse := record
	iesp.share.t_ResponseHeader _Header {xpath('Header')};
	t_RINIdentityRiskReportBy InputEcho {xpath('InputEcho')};
	unsigned2 RecordCount {xpath('RecordCount')};
	dataset(t_RINIdentityRiskReportRecord) Records {xpath('Records/Record'), MAXCOUNT(1)};
end;
		
export t_IdentityRiskReportRequest := record (iesp.rin_share.t_RINBaseRequest)
	t_RINIdentityRiskReportBy ReportBy {xpath('ReportBy')};
	t_RINIdentityRiskReportOption Options {xpath('Options')};
end;
		
export t_IdentityRiskReportResponseEx := record
	t_IdentityRiskReportResponse response {xpath('response')};
end;
		

end;

/*** Not to be hand edited (changes will be lost on re-generation) ***/
/*** ECL Interface generated by esdl2ecl version 1.0 from identityriskreport.xml. ***/
/*===================================================*/

