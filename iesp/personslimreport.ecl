﻿/*** Not to be hand edited (changes will be lost on re-generation) ***/
/*** ECL Interface generated by esdl2ecl version 1.0 from personslimreport.xml. ***/
/*===================================================*/

import iesp;

export personslimreport := MODULE
			
export t_PersonSlimReportOption := record (iesp.share.t_BaseReportOption)
	boolean IncludeMinors {xpath('IncludeMinors')};
	boolean IncludeFullPhonesPlus {xpath('IncludeFullPhonesPlus')};
	boolean IncludeBlankDOD {xpath('IncludeBlankDOD')};
	boolean EnableNationalAccidents {xpath('EnableNationalAccidents')};
	boolean EnableExtraAccidents {xpath('EnableExtraAccidents')};
	boolean IncludePriorProperties {xpath('IncludePriorProperties')};
	boolean IncludeNonRegulatedWatercraftSources {xpath('IncludeNonRegulatedWatercraftSources')};
	boolean IncludeNonRegulatedVehicleSources {xpath('IncludeNonRegulatedVehicleSources')};
	boolean IncludeNonRegulatedDMVSources {xpath('IncludeNonRegulatedDMVSources')};
	string RealTimePermissibleUse {xpath('RealTimePermissibleUse')};
	boolean IncludeAddresses {xpath('IncludeAddresses')};
	boolean IncludePhones {xpath('IncludePhones')};
	boolean IncludeDeaths {xpath('IncludeDeaths')};
	boolean IncludeNames {xpath('IncludeNames')};
	boolean IncludeSSNs {xpath('IncludeSSNs')};
	boolean IncludeDOBs {xpath('IncludeDOBs')};
	boolean IncludeProfessionalLicenses {xpath('IncludeProfessionalLicenses')};
	boolean IncludePeopleAtWork {xpath('IncludePeopleAtWork')};
	boolean IncludeAircrafts {xpath('IncludeAircrafts')};
	boolean IncludePilotCerts {xpath('IncludePilotCerts')};
	boolean IncludeWatercrafts {xpath('IncludeWatercrafts')};
	boolean IncludeUccs {xpath('IncludeUccs')};
	boolean IncludeSexualOffences {xpath('IncludeSexualOffences')};
	boolean IncludeCrimRecords {xpath('IncludeCrimRecords')};
	boolean IncludeConcealedWeapons {xpath('IncludeConcealedWeapons')};
	boolean IncludeHuntingFishingPermits {xpath('IncludeHuntingFishingPermits')};
	boolean IncludeFederalFirearms {xpath('IncludeFederalFirearms')};
	boolean IncludeControlledSubstances {xpath('IncludeControlledSubstances')};
	boolean IncludeVoters {xpath('IncludeVoters')};
	boolean IncludeDriversLicenses {xpath('IncludeDriversLicenses')};
	boolean IncludeMotorVehicles {xpath('IncludeMotorVehicles')};
	boolean IncludeRealTimeVehicles {xpath('IncludeRealTimeVehicles')};
	boolean IncludeAccidents {xpath('IncludeAccidents')};
	boolean IncludeBankruptcies {xpath('IncludeBankruptcies')};
	boolean IncludeLiens {xpath('IncludeLiens')};
	boolean IncludeProperties {xpath('IncludeProperties')};
	boolean IncludeMarriageDivorces {xpath('IncludeMarriageDivorces')};
	boolean IncludeEducation {xpath('IncludeEducation')};
	boolean IncludeAKAs {xpath('IncludeAKAs')};
	boolean IncludeImposters {xpath('IncludeImposters')};
	boolean IncludeUtility {xpath('IncludeUtility')};
end;
		
export t_PersonSlimReportBy := record
	string12 UniqueId {xpath('UniqueId')};
end;
		
export t_PersonSlimReportAddress := record (iesp.share.t_Address)
end;
		
export t_PersonSlimReportName := record (iesp.share.t_Name)
end;
		
export t_PersonSlimReportDeath := record (iesp.share.t_Date)
end;
		
export t_PersonSlimReportDOB := record (iesp.share.t_Date)
end;
		
export t_PersonSlimReportSSN := record
	string9 SSN {xpath('SSN')};
end;
		
export t_PersonSlimReportPhone := record
	string10 Phone {xpath('Phone')};
end;
		
export t_PersonSlimReportUtility := record
	string1 UtilType {xpath('UtilType')};
	string20 UtilCategory {xpath('UtilCategory')};
	string20 UtilTypeDescription {xpath('UtilTypeDescription')};
	iesp.share.t_Date ConnectDate {xpath('ConnectDate')};
	iesp.share.t_Date DateFirstSeen {xpath('DateFirstSeen')};
	iesp.share.t_Date RecordDate {xpath('RecordDate')};
	iesp.share.t_Name Name {xpath('Name')};
	string9 SSN {xpath('SSN')};
	iesp.share.t_Date DOB {xpath('DOB')};
	string2 DriversLicenseStateCode {xpath('DriversLicenseStateCode')};
	string22 DriversLicense {xpath('DriversLicense')};
	string10 WorkPhone {xpath('WorkPhone')};
	string10 Phone {xpath('Phone')};
	string1 AddrDual {xpath('AddrDual')};
	dataset(iesp.share.t_Address) Addresses {xpath('Addresses/Address'), MAXCOUNT(iesp.Constants.PersonSlim.MaxAddresses)};
end;
		
export t_PersonSlimReportResponse := record
	iesp.share.t_ResponseHeader _Header {xpath('Header')};
	string12 UniqueId {xpath('UniqueId')};
	dataset(t_PersonSlimReportAddress) Addresses {xpath('Addresses/Address'), MAXCOUNT(iesp.Constants.PersonSlim.MaxAddresses)};
	dataset(t_PersonSlimReportName) Names {xpath('Names/Name'), MAXCOUNT(iesp.Constants.PersonSlim.MaxNames)};
	dataset(t_PersonSlimReportPhone) Phones {xpath('Phones/Entry'), MAXCOUNT(iesp.Constants.PersonSlim.MaxPhones)};
	dataset(t_PersonSlimReportDeath) Deaths {xpath('Deaths/Death'), MAXCOUNT(iesp.Constants.PersonSlim.MaxDeaths)};
	dataset(t_PersonSlimReportDOB) DOBs {xpath('DOBs/DOB'), MAXCOUNT(iesp.constants.PersonSlim.MaxDOBs)};
	dataset(t_PersonSlimReportSSN) SSNs {xpath('SSNs/Entry'), MAXCOUNT(iesp.constants.PersonSlim.MaxSSNs)};
	dataset(iesp.proflicense.t_ProfessionalLicenseRecord) ProfessionalLicenses {xpath('ProfessionalLicenses/ProfessionalLicense'), MAXCOUNT(iesp.Constants.PersonSlim.MaxProfLic)};
	dataset(iesp.peopleatwork.t_PeopleAtWorkRecord) PeopleAtWorks {xpath('PeopleAtWorks/PeopleAtWork'), MAXCOUNT(iesp.constants.PersonSlim.MaxPeopleAtWork)};
	dataset(iesp.faaaircraft.t_AircraftReportRecord) Aircrafts {xpath('Aircrafts/Aircraft'), MAXCOUNT(iesp.constants.PersonSlim.MaxAircrafts)};
	dataset(iesp.bpsreport.t_BpsFAACertification) FAACertifications {xpath('FAACertifications/Certification'), MAXCOUNT(iesp.constants.PersonSlim.MaxFaaCerts)};
	dataset(iesp.watercraft.t_WaterCraftReportRecord) WaterCrafts {xpath('WaterCrafts/WaterCraft'), MAXCOUNT(iesp.constants.PersonSlim.MaxWatercrafts)};
	dataset(iesp.ucc.t_UCCReport2Record) UCCFilings {xpath('UCCFilings/UCCFiling'), MAXCOUNT(iesp.Constants.PersonSlim.MaxUCCs)};
	dataset(iesp.sexualoffender.t_SexOffReportRecord) SexualOffenses {xpath('SexualOffenses/SexualOffense'), MAXCOUNT(iesp.Constants.PersonSlim.MaxSexOffenses)};
	dataset(iesp.criminal.t_CrimReportRecord) Criminals {xpath('Criminals/Criminal'), MAXCOUNT(iesp.Constants.PersonSlim.MaxCrimRecords)};
	dataset(iesp.concealedweapon.t_WeaponRecord) WeaponPermits {xpath('WeaponPermits/WeaponPermit'), MAXCOUNT(iesp.Constants.PersonSlim.MaxWeapons)};
	dataset(iesp.huntingfishing.t_HuntFishRecord) HuntingFishingLicenses {xpath('HuntingFishingLicenses/HuntingFishingLicense'), MAXCOUNT(iesp.Constants.PersonSlim.MaxHuntFish)};
	dataset(iesp.firearm.t_FirearmRecord) FirearmExplosives {xpath('FirearmExplosives/FirearmExplosive'), MAXCOUNT(iesp.Constants.PersonSlim.MaxFirearms)};
	dataset(iesp.deacontrolledsubstance.t_DEAControlledSubstanceSearch2Record) ControlledSubstances {xpath('ControlledSubstances/ControlledSubstance'), MAXCOUNT(iesp.Constants.PersonSlim.MaxDEA)};
	dataset(iesp.voter.t_VoterReport2Record) VoterRegistrations {xpath('VoterRegistrations/VoterRegistration'), MAXCOUNT(iesp.Constants.PersonSlim.MaxVoter)};
	dataset(iesp.driverlicense2.t_DLEmbeddedReport2Record) Drivers {xpath('Drivers/Driver'), MAXCOUNT(iesp.Constants.PersonSlim.MaxDLs)};
	dataset(iesp.motorvehicle.t_MotorVehicleReport2Record) Vehicles {xpath('Vehicles/Vehicle'), MAXCOUNT(iesp.Constants.PersonSlim.MaxVehicles)};
	dataset(iesp.accident.t_AccidentReportRecord) Accidents {xpath('Accidents/Accident'), MAXCOUNT(iesp.Constants.PersonSlim.MaxAccidents)};
	dataset(iesp.bankruptcy.t_BankruptcyReport2Record) Bankruptcies {xpath('Bankruptcies/Bankruptcy'), MAXCOUNT(iesp.Constants.PersonSlim.MaxBankruptcies)};
	dataset(iesp.lienjudgement.t_LienJudgmentReportRecord) LiensJudgments {xpath('LiensJudgments/LienJudgment'), MAXCOUNT(iesp.Constants.PersonSlim.MaxLiens)};
	dataset(iesp.property.t_PropertyReport2Record) Properties {xpath('Properties/Property'), MAXCOUNT(iesp.Constants.PersonSlim.MaxProperties)};
	dataset(iesp.marriagedivorce.t_MarriageSearch2Record) MarriageDivorces {xpath('MarriageDivorces/MarriageDivorce'), MAXCOUNT(iesp.Constants.PersonSlim.MaxMarriageDiv)};
	dataset(iesp.student.t_StudentRecord) Educations {xpath('Educations/Education'), MAXCOUNT(iesp.Constants.PersonSlim.MaxStudent)};
	dataset(iesp.bps_share.t_BpsReportIdentity) AKAs {xpath('AKAs/AKA'), MAXCOUNT(iesp.Constants.PersonSlim.MaxAKA)};
	dataset(iesp.bps_share.t_BpsReportIdentity) Imposters {xpath('Imposters/Imposter'), MAXCOUNT(iesp.Constants.PersonSlim.MaxImposters)};
	dataset(t_PersonSlimReportUtility) Utilities {xpath('Utilities/Utility'), MAXCOUNT(iesp.Constants.PersonSlim.MaxUtilities)};
end;
		
export t_PersonSlimReportRequest := record (iesp.share.t_BaseRequest)
	t_PersonSlimReportOption Options {xpath('Options')};
	t_PersonSlimReportBy ReportBy {xpath('ReportBy')};
end;
		
export t_PersonSlimReportResponseEx := record
	t_PersonSlimReportResponse response {xpath('response')};
end;
		

end;

/*** Not to be hand edited (changes will be lost on re-generation) ***/
/*** ECL Interface generated by esdl2ecl version 1.0 from personslimreport.xml. ***/
/*===================================================*/

