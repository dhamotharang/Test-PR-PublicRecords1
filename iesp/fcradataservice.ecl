﻿/*** Not to be hand edited (changes will be lost on re-generation) ***/
/*** ECL Interface generated by esdl2ecl version 1.0 from fcradataservice.xml. ***/
/*===================================================*/

import iesp, Insurance_iesp;

export fcradataservice := MODULE
			
export t_FcraDataServiceDatasetSelection := record
	boolean IncludeAll {xpath('IncludeAll')};
	boolean IncludeAircraft {xpath('IncludeAircraft')};
	boolean IncludeAdvo {xpath('IncludeAdvo')};
	boolean IncludeATF {xpath('IncludeATF')};
	boolean IncludeAVM {xpath('IncludeAVM')};
	boolean IncludeBankruptcy {xpath('IncludeBankruptcy')};
	boolean IncludeCriminal {xpath('IncludeCriminal')};
	boolean IncludeDeath {xpath('IncludeDeath')};
	boolean IncludeEmail {xpath('IncludeEmail')};
	boolean IncludeGong {xpath('IncludeGong')};
	boolean IncludeHeader {xpath('IncludeHeader')};
	boolean IncludeHuntingFishing {xpath('IncludeHuntingFishing')};
	boolean IncludeLiens {xpath('IncludeLiens')};
	boolean IncludeMarriageDivorce {xpath('IncludeMarriageDivorce')};
	boolean IncludeInfutor {xpath('IncludeInfutor')};
	boolean IncludeOffenders {xpath('IncludeOffenders')};
	boolean IncludePeopleAtWork {xpath('IncludePeopleAtWork')};
	boolean IncludePhoneHistory {xpath('IncludePhoneHistory')};
	boolean IncludePilot {xpath('IncludePilot')};
	boolean IncludeProfessionalLicenses {xpath('IncludeProfessionalLicenses')};
	boolean IncludeProperties {xpath('IncludeProperties')};
	boolean IncludeStudents {xpath('IncludeStudents')};
	boolean IncludeThrive {xpath('IncludeThrive')};
	boolean IncludeUCC {xpath('IncludeUCC')};
	boolean IncludeWatercraft {xpath('IncludeWatercraft')};
end;
		
export t_FcraDataServiceOptions := record
	boolean ReturnSuppressedRecords {xpath('ReturnSuppressedRecords')};
	boolean ReturnOverwrittenRecords {xpath('ReturnOverwrittenRecords')};
	boolean ReturnDisputedRecords {xpath('ReturnDisputedRecords')};
	t_FcraDataServiceDatasetSelection DatasetSelection {xpath('DatasetSelection')};
end;
		
export t_FcraDataServicePersonContextRecord := record (Insurance_iesp.personcontext.t_PersonContextRecord)
end;
		
export t_FcraDataServiceATFData := record
	iesp.fcradataservice_common.t_FcraDataServiceMetadata Metadata {xpath('Metadata')};
	iesp.fcradataservice_raw.t_FcraDataServiceRawATF Rawdata {xpath('Rawdata')};
end;
		
export t_FcraDataServiceAlloyMediaStudentData := record
	iesp.fcradataservice_common.t_FcraDataServiceMetadata Metadata {xpath('Metadata')};
	iesp.fcradataservice_raw.t_FcraDataServiceRawAlloyMediaStudent Rawdata {xpath('Rawdata')};
end;
		
export t_FcraDataServiceAmericanStudentData := record
	iesp.fcradataservice_common.t_FcraDataServiceMetadata Metadata {xpath('Metadata')};
	iesp.fcradataservice_raw.t_FcraDataServiceRawAmericanStudent Rawdata {xpath('Rawdata')};
end;
		
export t_FcraDataServiceAircraftIdData := record
	iesp.fcradataservice_common.t_FcraDataServiceMetadata Metadata {xpath('Metadata')};
	iesp.fcradataservice_raw.t_FcraDataServiceRawAirctaftId Rawdata {xpath('Rawdata')};
end;
		
export t_FcraDataServiceAircraftDetailsData := record
	iesp.fcradataservice_common.t_FcraDataServiceMetadata Metadata {xpath('Metadata')};
	iesp.fcradataservice_raw.t_FcraDataServiceRawAircraftDetails Rawdata {xpath('Rawdata')};
end;
		
export t_FcraDataServiceAircraftEngineData := record
	iesp.fcradataservice_common.t_FcraDataServiceMetadata Metadata {xpath('Metadata')};
	iesp.fcradataservice_raw.t_FcraDataServiceRawAircraftEngine Rawdata {xpath('Rawdata')};
end;
		
export t_FcraDataServiceBKSearchData := record
	iesp.fcradataservice_common.t_FcraDataServiceMetadata Metadata {xpath('Metadata')};
	iesp.fcradataservice_raw.t_FcraDataServiceRawBKsearchbip Rawdata {xpath('Rawdata')};
	iesp.fcradataservice_raw.t_FcraDataServiceRawBKwithdraw WithdrawnStatusInfo {xpath('WithdrawnStatusInfo')};
end;
		
export t_FcraDataServiceBKMainData := record
	iesp.fcradataservice_common.t_FcraDataServiceMetadata Metadata {xpath('Metadata')};
	iesp.fcradataservice_raw.t_FcraDataServiceRawBKmain Rawdata {xpath('Rawdata')};
	iesp.fcradataservice_raw.t_FcraDataServiceRawBKcourt CourtInfo {xpath('CourtInfo')};
end;
		
export t_FcraDataServiceBankruptcyData := record
	iesp.fcradataservice_raw.t_FcraDataServiceRawBKGroupBy GroupBy {xpath('GroupBy')};
	dataset(t_FcraDataServiceBKMainData) Main {xpath('Main/Row'), MAXCOUNT(iesp.Constants.DataService.MaxBankruptcies)};
	dataset(t_FcraDataServiceBKSearchData) Search {xpath('Search/Row'), MAXCOUNT(iesp.Constants.DataService.MaxBankruptcies)};
end;
		
export t_FcraDataServiceDeathDidData := record
	iesp.fcradataservice_common.t_FcraDataServiceMetadata Metadata {xpath('Metadata')};
	iesp.fcradataservice_raw.t_FcraDataServiceRawDeathMasterDid Rawdata {xpath('Rawdata')};
end;
		
export t_FcraDataServiceGongData := record
	iesp.fcradataservice_common.t_FcraDataServiceMetadata Metadata {xpath('Metadata')};
	iesp.fcradataservice_raw.t_FcraDataServiceRawGong Rawdata {xpath('Rawdata')};
end;
		
export t_FcraDataServiceHuntFishData := record
	iesp.fcradataservice_common.t_FcraDataServiceMetadata Metadata {xpath('Metadata')};
	iesp.fcradataservice_raw.t_FcraDataServiceRawHuntingFishing Rawdata {xpath('Rawdata')};
end;
		
export t_FcraDataServicePAWData := record
	iesp.fcradataservice_common.t_FcraDataServiceMetadata Metadata {xpath('Metadata')};
	iesp.fcradataservice_raw.t_FcraDataServiceRawPAW Rawdata {xpath('Rawdata')};
end;
		
export t_FcraDataServicePilotCertificateData := record
	iesp.fcradataservice_common.t_FcraDataServiceMetadata Metadata {xpath('Metadata')};
	iesp.fcradataservice_raw.t_FcraDataServiceRawPilotCertificate Rawdata {xpath('Rawdata')};
end;
		
export t_FcraDataServicePilotRegistrationData := record
	iesp.fcradataservice_common.t_FcraDataServiceMetadata Metadata {xpath('Metadata')};
	iesp.fcradataservice_raw.t_FcraDataServiceRawPilotRegistration Rawdata {xpath('Rawdata')};
end;
		
export t_FcraDataServicePilotData := record
	iesp.fcradataservice_raw.t_FcraDataServiceRawPilotGroupBy GroupBy {xpath('GroupBy')};
	dataset(t_FcraDataServicePilotRegistrationData) Registration {xpath('Registration/Row'), MAXCOUNT(iesp.Constants.DataService.MaxPilots)};
	dataset(t_FcraDataServicePilotCertificateData) Certificate {xpath('Certificate/Row'), MAXCOUNT(iesp.Constants.DataService.MaxPilots)};
end;
		
export t_FcraDataServiceAircraftData := record
	iesp.fcradataservice_raw.t_FcraDataServiceRawAircraftGroupBy GroupBy {xpath('GroupBy')};
	dataset(t_FcraDataServiceAircraftIdData) Aircraft {xpath('Aircraft/Row'), MAXCOUNT(iesp.Constants.DataService.MaxAircrafts)};
	dataset(t_FcraDataServiceAircraftDetailsData) AircraftDetails {xpath('AircraftDetails/Row'), MAXCOUNT(iesp.Constants.DataService.MaxAircrafts)};
	dataset(t_FcraDataServiceAircraftEngineData) AircraftEngine {xpath('AircraftEngine/Row'), MAXCOUNT(iesp.Constants.DataService.MaxAircrafts)};
end;
		
export t_FcraDataServiceAVMMediansCalculatedData := record
	iesp.fcradataservice_common.t_FcraDataServiceMetadata Metadata {xpath('Metadata')};
	iesp.fcradataservice_raw.t_FcraDataServiceRawAddressWithAVMMediansCalculated CalculatedData {xpath('CalculatedData')};
end;
		
export t_FcraDataServiceAVMMediansRawData := record
	iesp.fcradataservice_common.t_FcraDataServiceMetadata Metadata {xpath('Metadata')};
	iesp.fcradataservice_raw.t_FcraDataServiceRawAVMMedians Rawdata {xpath('Rawdata')};
end;
		
export t_FcraDataServiceAVMMediansData := record
	dataset(t_FcraDataServiceAVMMediansRawData) AVMMediansHistory {xpath('AVMMediansHistory/Row'), MAXCOUNT(iesp.Constants.DataService.MaxAVM)};
	dataset(t_FcraDataServiceAVMMediansCalculatedData) AddressWithCalculatedAVMMedians {xpath('AddressWithCalculatedAVMMedians/Row'), MAXCOUNT(iesp.Constants.DataService.MaxAVM)};
	iesp.fcradataservice_raw.t_FcraDataServiceRawAVMMediansGroupBy GroupBy {xpath('GroupBy')};
end;
		
export t_FcraDataServiceAVMData := record
	iesp.fcradataservice_common.t_FcraDataServiceMetadata Metadata {xpath('Metadata')};
	iesp.fcradataservice_raw.t_FcraDataServiceRawAVMAddress Rawdata {xpath('Rawdata')};
end;
		
export t_FcraDataServiceAdvoData := record
	iesp.fcradataservice_common.t_FcraDataServiceMetadata Metadata {xpath('Metadata')};
	iesp.fcradataservice_raw.t_FcraDataServiceRawAdvo Rawdata {xpath('Rawdata')};
end;
		
export t_FcraDataServiceCriminalActivityData := record
	iesp.fcradataservice_common.t_FcraDataServiceMetadata Metadata {xpath('Metadata')};
	iesp.fcradataservice_raw.t_FcraDataServiceRawCriminalActivity Rawdata {xpath('Rawdata')};
end;
		
export t_FcraDataServiceCriminalCourtOffenseData := record
	iesp.fcradataservice_common.t_FcraDataServiceMetadata Metadata {xpath('Metadata')};
	iesp.fcradataservice_raw.t_FcraDataServiceRawCriminalCourtOffense Rawdata {xpath('Rawdata')};
end;
		
export t_FcraDataServiceCriminalOffenseData := record
	iesp.fcradataservice_common.t_FcraDataServiceMetadata Metadata {xpath('Metadata')};
	iesp.fcradataservice_raw.t_FcraDataServiceRawCriminalOffense Rawdata {xpath('Rawdata')};
end;
		
export t_FcraDataServiceCriminalPunishmentData := record
	iesp.fcradataservice_common.t_FcraDataServiceMetadata Metadata {xpath('Metadata')};
	iesp.fcradataservice_raw.t_FcraDataServiceRawCriminalPunishment Rawdata {xpath('Rawdata')};
end;
		
export t_FcraDataServiceCriminalOffenderData := record
	iesp.fcradataservice_common.t_FcraDataServiceMetadata Metadata {xpath('Metadata')};
	iesp.fcradataservice_raw.t_FcraDataServiceRawCriminalOffender Rawdata {xpath('Rawdata')};
end;
		
export t_FcraDataServiceCriminalData := record
	iesp.fcradataservice_raw.t_FcraDataServiceRawCriminalGroupBy GroupBy {xpath('GroupBy')};
	dataset(t_FcraDataServiceCriminalOffenderData) Offenders {xpath('Offenders/Row'), MAXCOUNT(iesp.Constants.DataService.MaxCrimOffenders)};
	dataset(t_FcraDataServiceCriminalOffenderData) OffendersPlus {xpath('OffendersPlus/Row'), MAXCOUNT(iesp.Constants.DataService.MaxCrimOffenders)};
	dataset(t_FcraDataServiceCriminalOffenseData) Offenses {xpath('Offenses/Row'), MAXCOUNT(iesp.Constants.DataService.MaxCrimOffenses)};
	dataset(t_FcraDataServiceCriminalCourtOffenseData) CourtOffenses {xpath('CourtOffenses/Row'), MAXCOUNT(iesp.Constants.DataService.MaxCrimCourtOffenses)};
	dataset(t_FcraDataServiceCriminalActivityData) Activity {xpath('Activity/Row'), MAXCOUNT(iesp.Constants.DataService.MaxCrimActivities)};
	dataset(t_FcraDataServiceCriminalPunishmentData) Punishment {xpath('Punishment/Row'), MAXCOUNT(iesp.Constants.DataService.MaxCrimPunishment)};
end;
		
export t_FcraDataServiceEmailData := record
	iesp.fcradataservice_common.t_FcraDataServiceMetadata Metadata {xpath('Metadata')};
	iesp.fcradataservice_raw.t_FcraDataServiceRawEmail Rawdata {xpath('Rawdata')};
end;
		
export t_FcraDataServiceHeaderData := record
	iesp.fcradataservice_common.t_FcraDataServiceMetadata Metadata {xpath('Metadata')};
	iesp.fcradataservice_raw.t_FcraDataServiceRawHeader Rawdata {xpath('Rawdata')};
end;
		
export t_FcraDataServiceInfutorData := record
	iesp.fcradataservice_common.t_FcraDataServiceMetadata Metadata {xpath('Metadata')};
	iesp.fcradataservice_raw.t_FcraDataServiceRawInfutorDid Rawdata {xpath('Rawdata')};
end;
		
export t_FcraDataServiceLiensPartyData := record
	iesp.fcradataservice_common.t_FcraDataServiceMetadata Metadata {xpath('Metadata')};
	iesp.fcradataservice_raw.t_FcraDataServiceRawLiensPartyTmsid Rawdata {xpath('Rawdata')};
end;
		
export t_FcraDataServiceLiensMainData := record
	iesp.fcradataservice_common.t_FcraDataServiceMetadata Metadata {xpath('Metadata')};
	iesp.fcradataservice_raw.t_FcraDataServiceRawLiensMainTmsid Rawdata {xpath('Rawdata')};
end;
		
export t_FcraDataServiceLiensData := record
	iesp.fcradataservice_raw.t_FcraDataServiceRawLiensGroupBy GroupBy {xpath('GroupBy')};
	dataset(t_FcraDataServiceLiensMainData) Main {xpath('Main/Row'), MAXCOUNT(iesp.Constants.DataService.MaxLiens)};
	dataset(t_FcraDataServiceLiensPartyData) Party {xpath('Party/Row'), MAXCOUNT(iesp.Constants.DataService.MaxLiens)};
end;
		
export t_FcraDataServiceMarriageDivMainData := record
	iesp.fcradataservice_common.t_FcraDataServiceMetadata Metadata {xpath('Metadata')};
	iesp.fcradataservice_raw.t_FcraDataServiceRawMarriageDivMainRid Rawdata {xpath('Rawdata')};
end;
		
export t_FcraDataServiceMarriageDivPartyData := record
	iesp.fcradataservice_common.t_FcraDataServiceMetadata Metadata {xpath('Metadata')};
	iesp.fcradataservice_raw.t_FcraDataServiceRawMarriageDivSearchRid Rawdata {xpath('Rawdata')};
end;
		
export t_FcraDataServiceMarriageDivData := record
	iesp.fcradataservice_raw.t_FcraDataServiceRawMarriageDivGroupBy GroupBy {xpath('GroupBy')};
	dataset(t_FcraDataServiceMarriageDivMainData) Main {xpath('Main/Row'), MAXCOUNT(iesp.Constants.DataService.MaxMarriageDiv)};
	dataset(t_FcraDataServiceMarriageDivPartyData) Search {xpath('Search/Row'), MAXCOUNT(iesp.Constants.DataService.MaxMarriageDiv)};
end;
		
export t_FcraDataServiceProfLicenseData := record
	iesp.fcradataservice_common.t_FcraDataServiceMetadata Metadata {xpath('Metadata')};
	iesp.fcradataservice_raw.t_FcraDataServiceRawProfLicenseDid Rawdata {xpath('Rawdata')};
end;
		
export t_FcraDataServiceProfLicenseMariData := record
	iesp.fcradataservice_common.t_FcraDataServiceMetadata Metadata {xpath('Metadata')};
	iesp.fcradataservice_raw.t_FcraDataServiceRawProfLicenseMariDid Rawdata {xpath('Rawdata')};
end;
		
export t_FcraDataServicePropertyAssessmentData := record
	iesp.fcradataservice_common.t_FcraDataServiceMetadata Metadata {xpath('Metadata')};
	iesp.fcradataservice_raw.t_FcraDataServiceRawPropertyAssessment Rawdata {xpath('Rawdata')};
end;
		
export t_FcraDataServicePropertyDeedData := record
	iesp.fcradataservice_common.t_FcraDataServiceMetadata Metadata {xpath('Metadata')};
	iesp.fcradataservice_raw.t_FcraDataServiceRawPropertyDeed Rawdata {xpath('Rawdata')};
end;
		
export t_FcraDataServicePropertySearchData := record
	iesp.fcradataservice_common.t_FcraDataServiceMetadata Metadata {xpath('Metadata')};
	iesp.fcradataservice_raw.t_FcraDataServiceRawPropertySearch Rawdata {xpath('Rawdata')};
end;
		
export t_FcraDataServicePropertyData := record
	iesp.fcradataservice_raw.t_FcraDataServiceRawPropertyGroupBy GroupBy {xpath('GroupBy')};
	dataset(t_FcraDataServicePropertyAssessmentData) Assessment {xpath('Assessment/Row'), MAXCOUNT(iesp.Constants.DataService.MaxProperties)};
	dataset(t_FcraDataServicePropertyDeedData) Deed {xpath('Deed/Row'), MAXCOUNT(iesp.Constants.DataService.MaxProperties)};
	dataset(t_FcraDataServicePropertySearchData) Search {xpath('Search/Row'), MAXCOUNT(iesp.Constants.DataService.MaxProperties)};
end;
		
export t_FcraDataServiceThriveData := record
	iesp.fcradataservice_common.t_FcraDataServiceMetadata Metadata {xpath('Metadata')};
	iesp.fcradataservice_raw.t_FcraDataServiceRawThrive Rawdata {xpath('Rawdata')};
end;
		
export t_FcraDataServiceSOffenderMainData := record
	iesp.fcradataservice_common.t_FcraDataServiceMetadata Metadata {xpath('Metadata')};
	iesp.fcradataservice_raw.t_FcraDataServiceRawSOffenderSPK Rawdata {xpath('Rawdata')};
end;
		
export t_FcraDataServiceSOffenseData := record
	iesp.fcradataservice_common.t_FcraDataServiceMetadata Metadata {xpath('Metadata')};
	iesp.fcradataservice_raw.t_FcraDataServiceRawSOffense Rawdata {xpath('Rawdata')};
end;
		
export t_FcraDataServiceSOData := record
	iesp.fcradataservice_raw.t_FcraDataServiceRawSOffenderGroupBy GroupBy {xpath('GroupBy')};
	dataset(t_FcraDataServiceSOffenderMainData) Main {xpath('Main/Row'), MAXCOUNT(iesp.Constants.DataService.MaxSOffenders)};
	dataset(t_FcraDataServiceSOffenseData) Offenses {xpath('Offenses/Row'), MAXCOUNT(iesp.Constants.DataService.MaxSOffenders)};
end;
		
export t_FcraDataServiceUCCMainData := record
	iesp.fcradataservice_common.t_FcraDataServiceMetadata Metadata {xpath('Metadata')};
	iesp.fcradataservice_raw.t_FcraDataServiceRawUCCMainRmsid Rawdata {xpath('Rawdata')};
end;
		
export t_FcraDataServiceUCCPartyData := record
	iesp.fcradataservice_common.t_FcraDataServiceMetadata Metadata {xpath('Metadata')};
	iesp.fcradataservice_raw.t_FcraDataServiceRawUCCPartyRmsid Rawdata {xpath('Rawdata')};
end;
		
export t_FcraDataServiceUCCData := record
	iesp.fcradataservice_raw.t_FcraDataServiceRawUCCGroupBy GroupBy {xpath('GroupBy')};
	dataset(t_FcraDataServiceUCCMainData) Main {xpath('Main/Row'), MAXCOUNT(iesp.Constants.DataService.MaxUCCFilings)};
	dataset(t_FcraDataServiceUCCPartyData) Party {xpath('Party/Row'), MAXCOUNT(iesp.Constants.DataService.MaxUCCFilings)};
end;
		
export t_FcraDataServiceWatercraftCoastguardData := record
	iesp.fcradataservice_common.t_FcraDataServiceMetadata Metadata {xpath('Metadata')};
	iesp.fcradataservice_raw.t_FcraDataServiceRawWatercraftCoastguard Rawdata {xpath('Rawdata')};
end;
		
export t_FcraDataServiceWatercraftInfoData := record
	iesp.fcradataservice_common.t_FcraDataServiceMetadata Metadata {xpath('Metadata')};
	iesp.fcradataservice_raw.t_FcraDataServiceRawWatercraftMain Rawdata {xpath('Rawdata')};
end;
		
export t_FcraDataServiceWatercraftOwnerData := record
	iesp.fcradataservice_common.t_FcraDataServiceMetadata Metadata {xpath('Metadata')};
	iesp.fcradataservice_raw.t_FcraDataServiceRawWatercraftOwner Rawdata {xpath('Rawdata')};
end;
		
export t_FcraDataServiceWatercraftData := record
	iesp.fcradataservice_raw.t_FcraDataServiceRawWatercraftGroupBy GroupBy {xpath('GroupBy')};
	dataset(t_FcraDataServiceWatercraftOwnerData) Owners {xpath('Owners/Row'), MAXCOUNT(iesp.Constants.DataService.MaxWatercrafts)};
	dataset(t_FcraDataServiceWatercraftInfoData) Details {xpath('Details/Row'), MAXCOUNT(iesp.Constants.DataService.MaxWatercrafts)};
	dataset(t_FcraDataServiceWatercraftCoastguardData) Coastguard {xpath('Coastguard/Row'), MAXCOUNT(iesp.Constants.DataService.MaxWatercrafts)};
end;
		
export t_FcraDataServiceReport := record
	dataset(t_FcraDataServiceAircraftData) Aircrafts {xpath('Aircrafts/Row'), MAXCOUNT(iesp.Constants.DataService.MaxAircrafts)};
	dataset(t_FcraDataServiceAlloyMediaStudentData) AlloyMediaStudent {xpath('AlloyMediaStudent/Row'), MAXCOUNT(iesp.Constants.DataService.MaxStudent)};
	dataset(t_FcraDataServiceAmericanStudentData) AmericanStudent {xpath('AmericanStudent/Row'), MAXCOUNT(iesp.Constants.DataService.MaxStudent)};
	dataset(t_FcraDataServiceAdvoData) Advo {xpath('Advo/Row'), MAXCOUNT(iesp.Constants.DataService.MaxAVM)};
	dataset(t_FcraDataServiceATFData) ATF {xpath('ATF/Row'), MAXCOUNT(iesp.Constants.DataService.MaxATF)};
	dataset(t_FcraDataServiceAVMData) AVM {xpath('AVM/Row'), MAXCOUNT(iesp.Constants.DataService.MaxAVM)};
	dataset(t_FcraDataServiceAVMMediansData) AVMMedians {xpath('AVMMedians/Row'), MAXCOUNT(iesp.Constants.DataService.MaxDefault)};
	dataset(t_FcraDataServiceBankruptcyData) Bankruptcy {xpath('Bankruptcy/Row'), MAXCOUNT(iesp.Constants.DataService.MaxBankruptcies)};
	dataset(t_FcraDataServiceCriminalData) Criminal {xpath('Criminal/Row'), MAXCOUNT(iesp.Constants.DataService.MaxCrimOffenders)};
	dataset(t_FcraDataServiceDeathDidData) DeathDid {xpath('DeathDid/Row'), MAXCOUNT(iesp.Constants.DataService.MaxDeathDid)};
	dataset(t_FcraDataServiceEmailData) Email {xpath('Email/Row'), MAXCOUNT(iesp.Constants.DataService.MaxEmail)};
	dataset(t_FcraDataServiceGongData) Gong {xpath('Gong/Row'), MAXCOUNT(iesp.Constants.DataService.MaxGong)};
	dataset(t_FcraDataServiceHeaderData) HeaderData {xpath('HeaderData/Row'), MAXCOUNT(iesp.Constants.DataService.MaxHeader)};
	dataset(t_FcraDataServiceHuntFishData) HuntingFishing {xpath('HuntingFishing/Row'), MAXCOUNT(iesp.Constants.DataService.MaxHunters)};
	dataset(t_FcraDataServiceInfutorData) Infutor {xpath('Infutor/Row'), MAXCOUNT(iesp.Constants.DataService.MaxInfutor)};
	dataset(t_FcraDataServiceMarriageDivData) Marriage {xpath('Marriage/Row'), MAXCOUNT(iesp.Constants.DataService.MaxMarriageDiv)};
	dataset(t_FcraDataServicePAWData) PeopleAtWork {xpath('PeopleAtWork/Row'), MAXCOUNT(iesp.Constants.DataService.MaxPAW)};
	dataset(t_FcraDataServicePilotData) Pilot {xpath('Pilot/Row'), MAXCOUNT(iesp.Constants.DataService.MaxPilots)};
	dataset(t_FcraDataServiceProfLicenseData) ProfessionalLicense {xpath('ProfessionalLicense/Row'), MAXCOUNT(iesp.Constants.DataService.MaxProfLicense)};
	dataset(t_FcraDataServiceProfLicenseMariData) ProfLicenseMari {xpath('ProfLicenseMari/Row'), MAXCOUNT(iesp.Constants.DataService.MaxProfLicense)};
	dataset(t_FcraDataServicePersonContextRecord) PersonContext {xpath('PersonContext/Row'), MAXCOUNT(iesp.Constants.DataService.MaxPersonContext)};
	dataset(t_FcraDataServicePropertyData) Property {xpath('Property/Row'), MAXCOUNT(iesp.Constants.DataService.MaxProperties)};
	dataset(t_FcraDataServiceSOData) SexOffenders {xpath('SexOffenders/Row'), MAXCOUNT(iesp.Constants.DataService.MaxSOffenders)};
	dataset(t_FcraDataServiceThriveData) Thrive {xpath('Thrive/Row'), MAXCOUNT(iesp.Constants.DataService.MaxThrive)};
	dataset(t_FcraDataServiceUCCData) UCC {xpath('UCC/Row'), MAXCOUNT(iesp.Constants.DataService.MaxUCCFilings)};
	dataset(t_FcraDataServiceWatercraftData) Watercraft {xpath('Watercraft/Row'), MAXCOUNT(iesp.Constants.DataService.MaxWatercrafts)};
end;
		
export t_FcraDataServiceReportResponse := record
	iesp.share.t_ResponseHeader _Header {xpath('Header')};
	string12 LexId {xpath('LexId')};
	t_FcraDataServiceReport Results {xpath('Results')};
end;
		
export t_FcraDataServiceRequest := record (iesp.share.t_BaseRequest)
	t_FcraDataServiceOptions Options {xpath('Options')};
	iesp.fcradataservice_common.t_FcraDataServiceReportBy ReportBy {xpath('ReportBy')};
end;
		
export t_FcraDataServiceReportResponseEx := record
	t_FcraDataServiceReportResponse response {xpath('response')};
end;
		

end;

/*** Not to be hand edited (changes will be lost on re-generation) ***/
/*** ECL Interface generated by esdl2ecl version 1.0 from fcradataservice.xml. ***/
/*===================================================*/

