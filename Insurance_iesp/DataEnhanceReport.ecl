/*** Not to be hand edited (changes will be lost on re-generation) ***/
/*** ECL Interface generated by esdl2ecl version 1.0 from DataEnhanceReport.xml. ***/
/*===================================================*/

export DataEnhanceReport := MODULE
			
export t_ReportIdSection := record
	EDITSReport.t_ReportRequestIdRecordReport ReportRequestId {xpath('ReportRequestId')};
	EDITSReport.t_ReportIdSupplementARecordReport InquiryIdSupplementA {xpath('InquiryIdSupplementA')};
	EDITSReport.t_RequestorProducerRecordReport Requestor {xpath('Requestor')};
end;
		
export t_RecapProcessingSection := record
	EDITSReport.t_RecapProcessingRecordReport RecapProcessing {xpath('RecapProcessing')};
end;
		
export t_SearchInfoSection := record
	EDITSReport.t_ReportSectionHeaderRecordReport ReportSectionHeader {xpath('ReportSectionHeader')};
	EDITSReport.t_PersonRecordReport Subject {xpath('Subject')};
	EDITSReport.t_DriverLicenseRecordReport CurrentLicense {xpath('CurrentLicense')};
	EDITSReport.t_AddressRecordReport CurrentAddress {xpath('CurrentAddress')};
	dataset(EDITSReport.t_AddressRecordReport) PriorAddresses {xpath('PriorAddresses/PriorAddress'), MAXCOUNT(3)};
end;
		
export t_AddressIdResultsSubset := record
	EDITSReport.t_AddressRecordReport CurrentAddress {xpath('CurrentAddress')};
	dataset(EDITSReport.t_AddressRecordReport) PriorAddresses {xpath('PriorAddresses/PriorAddress'), MAXCOUNT(3)};
end;
		
export t_PersonalIdResultsSubset := record
	EDITSReport.t_PersonRecordReport Subject {xpath('Subject')};
	EDITSReport.t_DriverLicenseRecordReport License {xpath('License')};
end;
		
export t_IdSetDataEnhance := record
	EDITSReport.t_RecapProcessingRecordReport RecapProcessing {xpath('RecapProcessing')};
	dataset(t_PersonalIdResultsSubset) PersonalIdResultsSets {xpath('PersonalIdResultsSets/PersonalIdResultSet'), MAXCOUNT(20)};
	dataset(t_AddressIdResultsSubset) AddressIdResultsSets {xpath('AddressIdResultsSets/AddressIdResultsSet'), MAXCOUNT(4)};
end;
		
export t_DataEnhancementResultsSection := record
	EDITSReport.t_ReportSectionHeaderRecordReport ReportSectionHeader {xpath('ReportSectionHeader')};
	t_IdSetDataEnhance IdSet {xpath('IdSet')};
end;
		
export t_DataEnhanceResponse := record
	t_ReportIdSection ReportIdSection {xpath('ReportIdSection')};
	t_RecapProcessingSection RecapProcessingSection {xpath('RecapProcessingSection')};
	t_SearchInfoSection SearchInfoSection {xpath('SearchInfoSection')};
	t_DataEnhancementResultsSection DataEnhancementResults {xpath('DataEnhancementResults')};
end;

export t_Response := Record
	t_DataEnhanceResponse Results {xpath('Results')};
end;

end;

/*** Not to be hand edited (changes will be lost on re-generation) ***/
/*** ECL Interface generated by esdl2ecl version 1.0 from DataEnhanceReport.xml. ***/
/*===================================================*/

