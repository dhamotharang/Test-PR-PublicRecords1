xls_load := dataset(
			[{'AccidentReport','AccidentReport','I','AccidentNumber','1'},
			// {'AccidentSearch','AccidentSearch','I','AccidentNumber','1'},
			// {'AccidentSearch','AccidentSearch','I','DriverLicenseNumber','11'},
			// {'AccidentSearch','AccidentSearch','I','TagNumber','26'},
			// {'AccidentSearch','AccidentSearch','I','VIN','33'},
			{'AddressCountReport','ADDRCOUNT','I','BusinessId','3'},
			{'AddressHistoryReport','AddrHistReport','I','BusinessId','3'},
			{'AddressHistoryReport','AddrHistReport','I','UniqueId','29'},
			{'AdvancedAddrSearch','AdvancedAddrSearch','I','UniqueId','29'},
			{'AgeVerification','AgeVerification','','UniqueId','29'},
			{'AlsoFoundReport','AlsoFoundReport','I','UniqueId','29'},
			{'AssetReport','AssetReport','','UniqueId','29'},
			{'BankruptcyReport','BankruptReport','I','CaseNumber','4'},
			{'BankruptcyReport2','BankruptReport2','I','BusinessId','3'},
			{'BankruptcyReport2','BankruptReport2','I','TMSId','28'},
			{'BankruptcyReport2','BankruptReport2','I','UniqueId','29'},
			{'BankruptcyReport3','BankruptReport3','','BusinessId','3'},
			{'BankruptcyReport3','BankruptReport3','','TMSId','28'},
			{'BankruptcyReport3','BankruptReport3','','UniqueId','29'},
			{'BankruptcySearch2','BankruptSearch2','I','CaseNumber','4'},
			{'BankruptcySearch2','BankruptSearch2','I','TaxId','27'},
			{'BankruptcySearch2','BankruptSearch2','I','UniqueId','29'},
			{'BankruptcySearch3','BankruptSearch3','I','CaseNumber','4'},
			{'BankruptcySearch3','BankruptSearch3','I','TaxId','27'},
			{'BasicPlusAssocReport','BasicPlusAssoRpt','','UniqueId','29'},
			{'BatchGSAVerification','BatchGSAVerify','','SearchID','38'},
			{'BpsReport','BpsReport','','UniqueId','29'},
			{'BpsSearch','BpsReport','S','UniqueId','29'},
			{'BusinessCreditReport','BizCreditReport','I','BusinessId','3'},
			{'BusinessCreditReport','BizCreditReport','I','FileNumber','14'},
			{'BusinessProfileReport','BusProfReport','','BusinessId','3'},
			{'BusinessProfileSearch','BusProfSearch','I','FEIN','13'},
			{'BusinessReport','BusReport','Z','BusinessId','3'},
			{'BusinessSearch','BusSearch','I','FEIN','13'},
			{'CalTaxPermitHolderSearch','CaTxPrmtHldrSrch','I','BusinessId','3'},
			{'CompReport','CompReport','','UniqueId','29'},
			{'ContactCardReport','ContactCardRpt','','UniqueId','29'},
			{'CorporateFilingReport','CorpReport','I','CorporationNumber','7'},
			{'CorporateFilingReport2','CorpReportV2','I','BusinessId','3'},
			{'CorporateFilingReport2','CorpReportV2','I','CharterNumber','5'},
			{'CorporateFilingReport2','CorpReportV2','I','CorporateKey','6'},
			{'CorporateFilingSearch','CorpSearch','I','FEIN','13'},
			{'CorporateFilingSearch2','CorpSearchV2','I','CharterNumber','5'},
			{'CorporateFilingSearch2','CorpSearchV2','I','CorporateKey','6'},
			{'CorporateFilingSearch2','CorpSearchV2','I','FEIN','13'},
			{'CourtSearchAdviser','courtsearch','I','BusinessId','3'},
			{'CourtSearchAdviser','courtsearch','I','UniqueId','29'},
			{'CriminalReport','CrimReport','I','OffenderId','19'},
			{'CriminalReport','CrimReport','I','UniqueId','29'},
			{'CriminalSearch','CrimSearch','I','DOCNumber','35'},
			{'DEAControlledSubstanceSearch','DEA_Registration','I','DEARegistrationNumber','8'},
			{'DEAControlledSubstanceSearch','DEA_Registration','I','UniqueId','29'},
			{'DEAControlledSubstanceSearch2','DEACntrlSbsSrch2','I','UniqueId','29'},
			{'DeadCompanySearch','DeadCompanySrch','I','BusinessId','3'},
			{'DeathReport','DeathReport','I','StateDeathId','25'},
			{'DeathReport','DeathReport','I','UniqueId','29'},
			{'DeathSearch','DeathSearch','I','UniqueId','29'},
			{'DirectoryAssistanceWirelessSearch','DirAsstWireless','','UniqueId','29'},
			{'DriverLicenseReport2','DLReport2','','DriverLicenseNumber','11'},
			{'DriverLicenseReport2','DLReport2','','UniqueId','29'},
			{'DriverLicenseSearch','DLSearch','D','LicenseNumber','11'}, // changed from 18 - LicenseNumber
			{'DriverLicenseSearch2','DLSearch2','I','DLNumber','11'},
			{'DriverLicenseSearch2','DLSearch2','I','UniqueId','29'},
			{'DunAndBradstreetSearch','dnbsearch','I','BusinessId','3'},
			{'EAuthenticate','Eauth','Y','UniqueId','29'},
			{'EmailSearch','EmailSearch','I','UniqueId','29'},
			{'EnhancedBusinessReport','EnhancedBusRpt','I','BusinessId','3'},
			{'EnhancedBusinessSearch','EnhancedBusSrch','I','BusinessId','3'},
			{'EnhancedBusinessSearch','EnhancedBusSrch','I','FEIN','13'},
			{'EnhancedPersonSearch','','','UniqueId','29'},
			{'FAAAircraftReport','AircraftReport','I','AircraftNumber','2'},
			{'FAAAircraftSearch','AircraftSearch','I','AircraftNumber','2'},
			{'FAAPilotReport','FAAPilotReport','B','FAAPilotRecordId','12'},
			{'FCCLicenseReport','FCCLicenseRpt','I','UniqueId','29'},
			{'FEINSearch','FEINSearch','I','FEIN','13'},
			{'FEINSearch','FEINSearch','I','TMSId','28'},
			{'FictitiousBusinessSearch','FictitiousBizSrh','I','BusinessId','3'},
			{'FictitiousBusinessSearch','FictitiousBizSrh','I','FilingNumber','15'},
			{'FictitiousBusinessSearch','FictitiousBizSrh','I','TMSId','28'},
			{'FictitiousBusinessSearch','FictitiousBizSrh','I','UniqueId','29'},
			{'FirearmExplosiveSearch','FirearmSearch','I','LicenseNumber','18'},
			{'ForeclosureReport','ForecloseReport','','ForeclosureId','37'},
			{'ForeclosureReport','ForecloseReport','','UniqueId','29'},
			{'ForeclosureSearch','ForecloseSearch','I','UniqueId','29'},
			{'GetStatewideDocumentCounts','StatewideDocCnts','I','BusinessId','3'},
			{'GetStatewideDocumentCounts','StatewideDocCnts','I','UniqueId','29'},
			{'HealthCareProviderReport','ProviderReport','I','ProviderId','23'},
			{'HealthCareProviderReport','ProviderReport','I','UniqueId','29'},
			{'HealthCareProviderSearch','ProviderSearch','I','LicenseNumber','18'},
			{'HealthCareProviderSearch','ProviderSearch','I','TaxId','27'},
			{'HealthCareProviderSearch','ProviderSearch','I','UniqueId','29'},
			{'HealthCareSanctionReport','SanctionReport','I','SanctionIds','24'},
			{'HealthCareSanctionSearch','SanctionSearch','I','TaxId','27'},
			{'HealthCareSanctionSearch','SanctionSearch','I','UniqueId','29'},
			{'InternetDomainSearch','WhoIS','I','DomainName','10'},
			{'LienJudgmentReport','LienReport','I','BusinessId','3'},
			{'LienJudgmentReport','LienReport','I','TMSId','28'},
			{'LienJudgmentReport','LienReport','I','UniqueId','29'},
			{'LienJudgmentSearch','LienSearch','','CaseNumber','4'},
			{'LienJudgmentSearch','LienSearch','','FEIN','13'},
			{'LienJudgmentSearch','LienSearch','','FilingNumber','15'},
			{'LienJudgmentSearch','LienSearch','','UniqueId','29'},
			{'MarriageDivorceSearch','Marriage_Divorce','I','FilingNumber','15'},
			{'MarriageDivorceSearch2','MDSearch2','I','FilingNumber','15'},
			{'MarriageDivorceSearch2','MDSearch2','I','UniqueId','29'},
			{'MerchantVesselSearch','VesselSearch','I','HullNumber','17'},
			{'MerchantVesselSearch','VesselSearch','I','OfficialNumber','20'},
			{'MerchantVesselSearch','VesselSearch','I','VesselName','31'},
			{'MilitaryRecordSearch','MilitaryRecord','I','UniqueId','29'},
			{'MotorVehicleReport','MVReport','W','UniqueId','29'},
			{'MotorVehicleReport','MVReport','W','VehicleNumber','30'},
			{'MotorVehicleReport','MVReport','W','VID','32'},
			{'MotorVehicleReport2','MVReport2','I','BusinessId','3'},
			{'MotorVehicleReport2','MVReport2','I','UniqueId','29'},
			{'MotorVehicleReport2','MVReport2','I','VehicleNumber','30'},
			{'MotorVehicleReport2','MVReport2','I','VIN','33'},
			// {'MotorVehicleSearch','MVSearch','V','LicenseNumber','18'},
			// {'MotorVehicleSearch','MVSearch','V','TagNumber','26'},
			// {'MotorVehicleSearch','MVSearch','V','VIN','33'},
			// {'MotorVehicleSearch2','MVSearch2','I','DriverLicenseNumber','11'},
			// {'MotorVehicleSearch2','MVSearch2','I','TagNumber','26'},
			// {'MotorVehicleSearch2','MVSearch2','I','UniqueId','29'},
			// {'MotorVehicleSearch2','MVSearch2','I','VIN','33'},
			{'NationalAccidentReport','NationalAccident','I','VIN','33'},
			{'NationalSanctionSearch','NatnalSaCaTxPrmtHldrSrchnctnSearch','I','CaseNumber','4'},
			{'NeighborReport','NeighborReport','R','UniqueId','29'},
			{'NeighborSearch','NeighborSearch','I','UniqueId','29'},
			{'OSHAReport','OSHAReport','I','BusinessId','3'},
			{'PatriotActSearch','PatriotActSearch','I','VesselName','31'},
			{'PeopleAtWorkSearch','PeopleAtWork','I','FEIN','13'},
			{'PeopleAtWorkSearch2','PeopleAtWorkV2','I','FEIN','13'},
			{'PeopleAtWorkSearch2','PeopleAtWorkV2','I','UniqueId','29'},
			{'PeopleReport','PeopleReport','','UniqueId','29'},
			{'PhoneHistorySearch','PhoneHisSearch','I','UniqueId','29'},
			{'PhonesFeedbackReport','PhonesFeedbackReport','I','UniqueId','29'},
			{'PreLitigationReport','PreLitReport','','UniqueId','29'},
			{'ProfessionalLicenseReport2','ProfLicReport2','','UniqueId','29'},
			{'ProfessionalLicenseSearch','ProfLicenseSearc','I','LicenseNumber','18'},
			{'ProfessionalLicenseSearch2','ProfLicSearch2','I','LicenseNumber','18'},
			{'ProfessionalLicenseSearch2','ProfLicSearch2','I','TaxId','27'},
			{'ProfessionalLicenseSearch2','ProfLicSearch2','I','UniqueId','29'},
			{'ProgressivePhonesSearch','ProgresPhoneSrh','I','UniqueId','29'},
			{'PropertyAssessmentSearch','PropSearcha','I','ParcelId','21'},
			{'PropertyAVMReport','PropAVMReport','I','ParcelId','21'},
			{'PropertyChronologyReport','PropChronReport','I','ParcelId','21'},
			{'PropertyDeedSearch','PropSearchd','I','ParcelId','21'},
			{'PropertyReport2','PropertyReport2','','BusinessId','3'},
			{'PropertyReport2','PropertyReport2','','FaresId','36'},
			{'PropertyReport2','PropertyReport2','','ParcelId','21'},
			{'PropertyReport2','PropertyReport2','','SourcePropertyRecordId','40'},
			{'PropertyReport2','PropertyReport2','','UniqueId','29'},
			{'PropertySearch2','PropertySearch2','I','FaresId','36'},
			{'PropertySearch2','PropertySearch2','I','ParcelId','21'},
			{'PropertySearch2','PropertySearch2','I','UniqueId','29'},
			{'RateEvasionSearch','ressearch','I','DriverLicenseNumber','11'},
			{'RelativeAssociateReport','RelativeReport','I','UniqueId','29'},
			{'RelativeNeighborAssociateReport','RNASearch','I','UniqueId','29'},
			{'RightAddressSearch','RightAddress','I','UniqueId','29'},
			{'RollupBpsSearch','PersonSearch','S','UniqueId','29'},
			{'RollupBusinessReport','RollBusReport','I','BusinessId','3'},
			{'RollupBusinessSearch','RollBusSearch','I','BusinessId','3'},
			{'RollupBusinessSearch','RollBusSearch','I','FEIN','13'},
			{'RollupPersonSearch','RollPerSearch','I','UniqueId','29'},
			{'SexualOffenderReport','SexOffReport','I','PrimaryKey','22'},
			{'SexualOffenderReport','SexOffReport','I','UniqueId','29'},
			{'SexualOffenderSearch','SexOffSearch','I','UniqueId','29'},
			{'SourceDocSearch','SourceDco','','SourceDocIds','39'},
			{'SSNExpansion','SSNExpansion','','UniqueId','29'},
			{'StatewideBusinessSearch','StatewideBusSrch','I','FEIN','13'},
			{'SummaryReport','SummaryReport','I','UniqueId','29'},
			{'TaxpayerInfoSearch','TaxpayerInfoSrch','I','BusinessId','3'},
			{'TaxProfessionalSearch','TaxProSrch','I','UniqueId','29'},
			{'UCCFilingReport','UCCReport2','I','DocumentNumber','9'},
			{'UCCFilingReport','UCCReport2','I','FilingStateCode','16'},
			{'UCCFilingReport2','UCCReportV2','I','BusinessId','3'},
			{'UCCFilingReport2','UCCReportV2','I','TMSId','28'},
			{'UCCFilingReport2','UCCReportV2','I','UniqueId','29'},
			{'UCCFilingSearch2','UCCSearchV2','I','FEIN','13'},
			{'UCCFilingSearch2','UCCSearchV2','I','FilingNumber','15'},
			{'UCCFilingSearch2','UCCSearchV2','I','UniqueId','29'},
			{'USBusinessDirectorySearch','USBizDirSearch','I','BusinessId','3'},
			{'VoterRegistrationReport2','VoterReport2','I','UniqueId','29'},
			{'WaterCraftReport','WaterCraftReport','I','WaterCraftKey','34'},
			{'WaterCraftReport2','WaterCraftRpt2','I','BusinessId','3'},
			{'WaterCraftReport2','WaterCraftRpt2','I','HullNumber','17'},
			{'WaterCraftReport2','WaterCraftRpt2','I','UniqueId','29'},
			{'WaterCraftReport2','WaterCraftRpt2','I','VesselName','31'},
			{'WaterCraftReport2','WaterCraftRpt2','I','WaterCraftKey','34'},
			{'WaterCraftSearch','WaterCraftSearch','I','HullNumber','17'},
			{'WaterCraftSearch','WaterCraftSearch','I','OfficialNumber','20'},
			{'WaterCraftSearch','WaterCraftSearch','I','VesselName','31'},
			{'WaterCraftSearch2','WaterCraftSrh2','I','HullNumber','17'},
			{'WaterCraftSearch2','WaterCraftSrh2','I','UniqueId','29'},
			{'WaterCraftSearch2','WaterCraftSrh2','I','VesselName','31'}], {string function_name, string long_name, string transaction_type, string unique_id, string unique_id_code});

tbValueCnt := table(dedup(xls_load, record, all), {string function_name := stringlib.stringtouppercase(function_name), 
													string long_name := stringlib.stringtouppercase(long_name),
													string transaction_type := stringlib.stringtouppercase(transaction_type),
													ValueCnt := count(group)},
														stringlib.stringtouppercase(function_name), 
														stringlib.stringtouppercase(long_name),
														stringlib.stringtouppercase(transaction_type), few);
											
export File_UniqueID := join(xls_load, tbValueCnt, stringlib.stringtouppercase(left.function_name) = stringlib.stringtouppercase(right.function_name) and stringlib.stringtouppercase(left.transaction_type) = stringlib.stringtouppercase(right.transaction_type));
	
/*

Unique ID Code Translations

AccidentNumber	1
AircraftNumber	2
BusinessId	3
CaseNumber	4
CharterNumber	5
CorporateKey	6
CorporationNumber	7
DEARegistrationNumber	8
DocumentNumber	9 - UCC only
DomainName	10
DriverLicenseNumber	11
DLNumber	11
FAAPilotRecordId	12
FEIN	13
FileNumber	14 - business credit report only
FilingNumber	15 - marriages only
FilingStateCode	16 - UCC only
HullNumber	17
LicenseNumber	18
OffenderId	19
OfficialNumber	20
ParcelId	21
PrimaryKey	22
ProviderId	23
SanctionIds	24
StateDeathId	25
TagNumber	26
TaxId	27
TMSId	28
UniqueId	29
VehicleNumber	30
VesselName	31
VID	32
VIN	33
WaterCraftKey	34
DOCNumber	35
FaresId	36
ForeclosureId	37
SearchID	38
SourceDocIds	39
SourcePropertyRecordId	40

*/