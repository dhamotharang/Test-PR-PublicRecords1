export osha := MODULE
			
export t_OshaSectionViolation := record
	string ViolationType {xpath('ViolationType')};
	string HealthSafetyIssue {xpath('HealthSafetyIssue')};
	string ViolationTypeDesc {xpath('ViolationTypeDesc')};
	string CitationNumber {xpath('CitationNumber')};
	real4 CurrentPenalty {xpath('CurrentPenalty')};
	string AbatementComplete {xpath('AbatementComplete')};
end;      
      
export t_OshaSectionRecord := record
	integer ActivityNumber {xpath('ActivityNumber')};
	share.t_Date InspectionOpeningDate {xpath('InspectionOpeningDate')};
	share.t_Date InspectionCloseDate {xpath('InspectionCloseDate')};
	string InspectionType {xpath('InspectionType')};
	string InspectionTypeDesc {xpath('InspectionTypeDesc')};
	string InspectionScope {xpath('InspectionScope')};
	string InspectionScopeDesc {xpath('InspectionScopeDesc')};
	integer TotalNumberViolations {xpath('TotalNumberViolations')};
	dataset(t_OshaSectionViolation) Violations {xpath('Violations/Violation'), MAXCOUNT(iesp.constants.Oshair.MaxCountViolationRecords)};
end;      
      
export t_OshaSection := record
	dataset(t_OshaSectionRecord) OshaSectionRecords {xpath('OshaSectionRecords/OshaSectionRecord'), MAXCOUNT(iesp.constants.Oshair.MaxCountSuppRiskRecords)};
	integer OshaSectionCount {xpath('OshaSectionCount')};
	integer TotalOshaSectionCount {xpath('TotalOshaSectionCount')};
	dataset(topbusiness_share.t_TopBusinessSourceDocInfo) SourceDocs {xpath('SourceDocs/SourceDoc'), MAXCOUNT(iesp.constants.TOPBUSINESS.MAX_COUNT_BIZRPT_SRCDOC_RECORDS)};
end;		      
      
export t_OSHASearchBy := record (share.t_BaseSearchBy)
	string InspectedSiteName {xpath('InspectedSiteName')};
	share.t_Address InspectedSiteAddress {xpath('InspectedSiteAddress')};
end;
		
export t_OSHASearchOption := record (share.t_BaseSearchOption)
	integer ReturnCount {xpath('ReturnCount')};
	integer StartingRecord {xpath('StartingRecord')};
	boolean UsePhonetics {xpath('UsePhonetics')};
	boolean UseNicknames {xpath('UseNicknames')};
	boolean IncludeAlsoFound {xpath('IncludeAlsoFound')};
end;
		
export t_OSHASearchRecord := record
	boolean AlsoFound {xpath('AlsoFound')};
	string ActivityNumber {xpath('ActivityNumber')};
	string BusinessId {xpath('BusinessId')};
	string SiteName {xpath('SiteName')};
	share.t_Address InspectedSiteAddress {xpath('InspectedSiteAddress')};
end;
		
export t_OSHASearchResponse := record
	share.t_ResponseHeader _Header {xpath('Header')};
	integer RecordCount {xpath('RecordCount')};
	dataset(t_OSHASearchRecord) Records {xpath('Records/Record'), MAXCOUNT(1)};
end;
		
export t_OSHAReportBy := record
	string BusinessId {xpath('BusinessId')};
	string ActivityNumber {xpath('ActivityNumber')};
end;
		
export t_OSHAReportOption := record (share.t_BaseReportOption)
end;
		
export t_ComplianceOfficer := record
	string Id {xpath('Id')};
	string JobTitle {xpath('JobTitle')};
	string JobTitleDesc {xpath('JobTitleDesc')};
end;
		
export t_OSHAReportBaseRecord := record
	integer ActivityNumber {xpath('ActivityNumber')};
	share.t_Date LastActivityDate {xpath('LastActivityDate')};
	string PreviousActivityType {xpath('PreviousActivityType')};
	string PrevActivityTypeDesc {xpath('PrevActivityTypeDesc')};
	integer PreviousActivityNumber {xpath('PreviousActivityNumber')};
	string27 InspectionTypeDesc {xpath('InspectionTypeDesc')};
	string13 InspectionScopeDesc {xpath('InspectionScopeDesc')};
	string AdvanceNoticeDesc {xpath('AdvanceNoticeDesc')};  
	string ReportId {xpath('ReportId')};
	t_ComplianceOfficer ComplianceOfficer {xpath('ComplianceOfficer')};
	share.t_Address InspectedSiteAddress {xpath('InspectedSiteAddress')};
	string HostEstablishmentKey {xpath('HostEstablishmentKey')};
  string InspectedSite {xpath('InspectedSite')};
	string OwnerType {xpath('OwnerType')};
	string OwnTypeDesc {xpath('OwnTypeDesc')};
	integer OwnerCode {xpath('OwnerCode')};
	string AdvanceNoticeFlag {xpath('AdvanceNoticeFlag')};
	share.t_Date InspectionOpeningDate {xpath('InspectionOpeningDate')};
	share.t_Date InspectionCloseDate {xpath('InspectionCloseDate')};
	string SafetyHealthFlag {xpath('SafetyHealthFlag')};
	string SafetyHealthDesc {xpath('SafetyHealthDesc')};
	integer NumberInEstablishment {xpath('NumberInEstablishment')};
	integer NumberCovered {xpath('NumberCovered')};
	integer NumberTotalEmployees {xpath('NumberTotalEmployees')};
	string WalkAroundDesc {xpath('WalkAroundDesc')};
	string EmployeesInterviewedDesc {xpath('EmployeesInterviewedDesc')};
	string UnionFlag {xpath('UnionFlag')};
	string ClosedCaseFlag {xpath('ClosedCaseFlag')};
	string WhyNoInspDesc {xpath('WhyNoInspDesc')};
	share.t_Date CloseCaseDate {xpath('CloseCaseDate')};
	string AnticServed {xpath('AnticServed')};
	share.t_Date FirstDenialDate {xpath('FirstDenialDate')};
	share.t_Date LastReenterDate {xpath('LastReenterDate')};
	real8 BLSLossWorkdayInjuryRate {xpath('BLSLossWorkdayInjuryRate')};
end;
		
export t_CodeDescription := record
	string Name {xpath('Name')};
	string Code {xpath('Code')};
	string Description {xpath('Description')};
end;
		
export t_IndustryCode := record
	string DUNSNumber {xpath('DUNSNumber')};
	integer SICCode {xpath('SICCode')};
	integer SecondarySIC {xpath('SecondarySIC')};
	dataset(t_CodeDescription) NAICSCodeDescs {xpath('NAICSCodeDescs/NAICSCodeDesc'), MAXCOUNT(iesp.Constants.OSHAIR.MaxNaics)};
	string SicCodeDesc {xpath('SicCodeDesc')};
	string SecondarySicCodeDesc {xpath('SecondarySicCodeDesc')};  
end;
		
export t_HoursOfInspection := record
	string Category {xpath('Category')};
	integer Hours {xpath('Hours')};
end;
		
export t_Violation := record
	string DeleteFlag {xpath('DeleteFlag')};
	share.t_Date IssuanceDate {xpath('IssuanceDate')};
	string CitationNumber {xpath('CitationNumber')};
	string ItemNumber {xpath('ItemNumber')};
	real8 CurrentPenalty {xpath('CurrentPenalty')};
	real8 InitialPenalty {xpath('InitialPenalty')};
	string ViolationType {xpath('ViolationType')};
	string InitialViolationType {xpath('InitialViolationType')};
	string FedStateStandard {xpath('FedStateStandard')};
	share.t_Date AbatementDate {xpath('AbatementDate')};
	string AbatementComplete {xpath('AbatementComplete')};
	string ViolationContest {xpath('ViolationContest')};
	share.t_Date FinalOrderDate {xpath('FinalOrderDate')};
	string DispositionEvent {xpath('DispositionEvent')};
	real8 FailureToAbatePenalty {xpath('FailureToAbatePenalty')};
	share.t_Date FailureToAbateIssuanceDate {xpath('FailureToAbateIssuanceDate')};
	share.t_Date AbatementVerifyDate {xpath('AbatementVerifyDate')};
	string ViolationDesc {xpath('ViolationDesc')};
	string RelatedEventDesc {xpath('RelatedEventDesc')};
	string AbatementCompDesc {xpath('AbatementCompDesc')};
	string DispositionEventDesc {xpath('DispositionEventDesc')};
	string FailureToAbateDispositionEventDesc {xpath('FailureToAbateDispositionEventDesc')};
  string IdNumber {xpath('IdNumber')};
end;
		
export t_HazardSubstance := record
	string CitationNumber {xpath('CitationNumber')};
	string ItemNumber {xpath('ItemNumber')};
	string ItemGroup {xpath('ItemGroup')};
	dataset(t_CodeDescription) CodeDescriptions {xpath('CodeDescriptions/CodeDescription'), MAXCOUNT(iesp.Constants.OSHAIR.MaxHazardCodes)};
end;
		
export t_Victim := record
	share.t_Name VictimName {xpath('VictimName')};
	string NameScore {xpath('NameScore')};
end;
		
export t_Accident := record
	string Name {xpath('Name')};
	integer RelatedInspectionNumber {xpath('RelatedInspectionNumber')};
	string Sex {xpath('Sex')};
	integer Age {xpath('Age')};
	string DegreeOfInjury {xpath('DegreeOfInjury')};
	string NatureOfInjury {xpath('NatureOfInjury')};
	string PartOfBody {xpath('PartOfBody')};
	string SourceOfInjury {xpath('SourceOfInjury')};
	string EventType {xpath('EventType')};
	string EnvironmentalFactor {xpath('EnvironmentalFactor')};
	string HumanFactor {xpath('HumanFactor')};
	string TaskAssigned {xpath('TaskAssigned')};
	string HazardousSubstance {xpath('HazardousSubstance')};
	string OccupationCode {xpath('OccupationCode')};
	string DegOfInjuryDesc {xpath('DegOfInjuryDesc')};
	string NatOfInjDesc {xpath('NatOfInjDesc')};
	string PartOfBodyDesc {xpath('PartOfBodyDesc')};
	string SrcOfInjDesc {xpath('SrcOfInjDesc')};
	string EventDesc {xpath('EventDesc')};
	string EnvironmentalFactorDesc {xpath('EnvironmentalFactorDesc')};
	string HumanFactorDesc {xpath('HumanFactorDesc')};
	string ReportTaskDesc {xpath('ReportTaskDesc')};
	string HazardousSubDesc {xpath('HazardousSubDesc')};
	string OccupationDesc {xpath('OccupationDesc')};
	t_Victim Victim {xpath('Victim')};
end;
		
export t_OSHAReportRecord := record (t_OSHAReportBaseRecord)
	share.t_BusinessIdentity BusinessIds {xpath('BusinessIds')};
	string100 IdValue {xpath('IdValue')};
	t_IndustryCode IndustryCodes {xpath('IndustryCodes')};
	dataset(share.t_StringArrayItem) Classification {xpath('Classification/Description'), MAXCOUNT(iesp.Constants.OSHAIR.MaxClassifications)};
	dataset(t_HoursOfInspection) HoursOfInspections {xpath('HoursOfInspections/HoursOfInspection'), MAXCOUNT(iesp.Constants.OSHAIR.MaxHoursInspection)};
	dataset(t_Violation) Violations {xpath('Violations/Violation'), MAXCOUNT(iesp.Constants.OSHAIR.MaxViolations)};
	dataset(t_HazardSubstance) HazardSubstances {xpath('HazardSubstances/HazardSubstance'), MAXCOUNT(iesp.Constants.OSHAIR.MaxHazardSubstances)};
	dataset(t_Accident) Accidents {xpath('Accidents/Accident'), MAXCOUNT(iesp.Constants.OSHAIR.MaxAccidents)};
end;
		
export t_OSHAReportResponse := record
	share.t_ResponseHeader _Header {xpath('Header')};
	dataset(t_OSHAReportRecord) OSHAReportRecords {xpath('OSHAReportRecords/OSHAReportRecord'), MAXCOUNT(1)};
end;
		
export t_OSHASearchRequest := record (share.t_BaseRequest)
	t_OSHASearchBy SearchBy {xpath('SearchBy')};
	t_OSHASearchOption Options {xpath('Options')};
end;
		
export t_OSHAReportRequest := record (share.t_BaseRequest)
	t_OSHAReportBy ReportBy {xpath('ReportBy')};
	t_OSHAReportOption Options {xpath('Options')};
end;
		
export t_OSHASearchResponseEx := record
	t_OSHASearchResponse response {xpath('response')};
end;
		
export t_OSHAReportResponseEx := record
	t_OSHAReportResponse response {xpath('response')};
end;

end;

