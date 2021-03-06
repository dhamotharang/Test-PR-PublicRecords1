/*** Not to be hand edited (changes will be lost on re-generation) ***/
/*** ECL Interface generated by esdl2ecl version 1.0 from lncafirmographics.xml. ***/
/*===================================================*/

export lncafirmographics := MODULE
/*			
export t_LncaCompany := record
	string9 UniqueID {xpath('UniqueID')};
	string Name {xpath('Name')};
	share.t_Address Address {xpath('Address')};
	dataset(t_LncaCompany) Subsidiaries {xpath('Subsidiaries/Company'), MAXCOUNT(1)};
end;
		
export t_lncaHierarchy := record
	t_LncaCompany Company {xpath('Company')};
end;
*/		
export t_lncaExecutive := record
	share.t_Name Name {xpath('Name')};
	string Title {xpath('Title')};
	string code {xpath('code')};
end;
		
export t_lncaSICCode := record
	integer Code {xpath('Code')};
	string Description {xpath('Description')};
end;
		
export t_lncaNAICSCodes := record
	integer Code {xpath('Code')};
	string Description {xpath('Description')};
end;
		
export t_LNCARecord := record, MAXLENGTH (iesp.constants.LNCA.MaxLNCARecLen)
	string200000 Hierarchy {xpath('Hierarchy')};//REAL TYPE: RECORD t_lncaHierarchy
	integer HierarchyErrorCode {xpath('HierarchyErrorCode')};
	string70 CompanyType {xpath('CompanyType')};
	string105 BusinessName {xpath('BusinessName')};
	string107 Note {xpath('Note')};
	string2 Incorp {xpath('Incorp')};
	integer PercentageOwned {xpath('PercentageOwned')};
	integer Earnings {xpath('Earnings')};
	integer Sales {xpath('Sales')};
	string15 SalesDescription {xpath('SalesDescription')};
	integer Assets {xpath('Assets')};
	integer Liabilities {xpath('Liabilities')};
	integer NetWorth {xpath('NetWorth')};
	share.t_Date FiscalYearEnd {xpath('FiscalYearEnd')};
	integer NumberOfEmployees {xpath('NumberOfEmployees')};
	string1 Imports {xpath('Imports')};
	string1 Exports {xpath('Exports')};
	string1502 BusinessDescription {xpath('BusinessDescription')};
	dataset(t_lncaSICCode) SICCodes {xpath('SICCodes/SICCode'), MAXCOUNT(iesp.constants.LNCA.MaxSICCodes)};
	dataset(t_lncaExecutive) Executives {xpath('Executives/Executive'), MAXCOUNT(iesp.constants.LNCA.MaxExecutives)};
	dataset(share.t_StringArrayItem) Exchanges {xpath('Exchanges/Exchange'), MAXCOUNT(iesp.constants.LNCA.MaxExchanges)};
	string60 CoreBasedStatisticalArea {xpath('CoreBasedStatisticalArea')};
	string5000 Competitors {xpath('Competitors')};
	dataset(t_lncaNAICSCodes) NAICSCodes {xpath('NAICSCodes/NAICSCode'), MAXCOUNT(iesp.constants.LNCA.MaxNAICSCodes)};
end;
		
export t_LNCASection := record
	dataset(t_LNCARecord) LNCARecords {xpath('LNCARecords/LNCARecord'), MAXCOUNT(iesp.constants.LNCA.MaxCountSuppRiskRecords)};
	integer LNCACount {xpath('LNCACount')};
	integer TotalLNCACount {xpath('TotalLNCACount')};
	dataset(topbusiness_share.t_TopBusinessSourceDocInfo) SourceDocs {xpath('SourceDocs/SourceDoc'), MAXCOUNT(iesp.constants.TOPBUSINESS.MAX_COUNT_BIZRPT_SRCDOC_RECORDS)};
end;

end;

/*** Not to be hand edited (changes will be lost on re-generation) ***/
/*** ECL Interface generated by esdl2ecl version 1.0 from lncafirmographics.xml. ***/
/*===================================================*/
