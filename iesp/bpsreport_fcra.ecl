﻿/*** Not to be hand edited (changes will be lost on re-generation) ***/
/*** ECL Interface generated by esdl2ecl version 1.0 from bpsreport_fcra.xml. ***/
/*===================================================*/

import iesp;

export bpsreport_fcra := MODULE
			
export t_FcraBpsReportBy := record (iesp.share_fcra.t_FcraReportBy)
end;
		
export t_FcraBaseBpsReportOption := record (iesp.share_fcra.t_FcraReportOption)
	boolean IncludeProperties {xpath('IncludeProperties')};
	boolean IncludePriorProperties {xpath('IncludePriorProperties')};
	boolean IncludeCurrentProperties {xpath('IncludeCurrentProperties')};
	boolean IncludeBankruptcies {xpath('IncludeBankruptcies')};
	boolean SuppressWithdrawnBankruptcy {xpath('SuppressWithdrawnBankruptcy')};
	boolean IncludeLiensJudgments {xpath('IncludeLiensJudgments')};
	boolean IncludeCriminalRecords {xpath('IncludeCriminalRecords')};
	boolean IncludeWaterCrafts {xpath('IncludeWaterCrafts')};
	boolean IncludeHuntingFishingLicenses {xpath('IncludeHuntingFishingLicenses')};
	boolean IncludeFirearmExplosives {xpath('IncludeFirearmExplosives')};
	boolean IncludeWeaponPermits {xpath('IncludeWeaponPermits')};
	boolean IncludeSexualOffenses {xpath('IncludeSexualOffenses')};
	boolean IncludeFAAAircrafts {xpath('IncludeFAAAircrafts')};
	boolean IncludeFAACertificates {xpath('IncludeFAACertificates')};
end;
		
export t_FcraBpsReportOption := record (t_FcraBaseBpsReportOption)
end;
		
export t_FcraFAACertificate := record (iesp.bpsreport.t_FAACertificate)
	boolean IsDisputed {xpath('IsDisputed')};
	dataset(iesp.share_fcra.t_StatementIdRec) StatementIds {xpath('StatementIdRecs/StatementIdRec'), MAXCOUNT(iesp.Constants.MaxConsumerStatementIds)};
end;
		
export t_FcraBpsFAACertification := record (iesp.bpsreport.t_BaseBpsFAACertification)
	dataset(t_FcraFAACertificate) Certificates {xpath('Certificates/Certificate'), MAXCOUNT(iesp.Constants.MAX_COUNT_PILOT_CERTIFICATES)};
	boolean IsDisputed {xpath('IsDisputed')};
	dataset(iesp.share_fcra.t_StatementIdRec) StatementIds {xpath('StatementIdRecs/StatementIdRec'), MAXCOUNT(iesp.Constants.MaxConsumerStatementIds)};
end;
		
export t_FcraBpsReportProperty := record (iesp.bpsreport.t_BpsReportProperty)
	boolean IsDisputed {xpath('IsDisputed')};
	dataset(iesp.share_fcra.t_StatementIdRec) StatementIds {xpath('StatementIdRecs/StatementIdRec'), MAXCOUNT(iesp.Constants.MaxConsumerStatementIds)};
end;
		
export t_FcraBpsReportIndividual := record
	string12 UniqueId {xpath('UniqueId')};
	string3 Probability {xpath('Probability')};
	boolean HasBankruptcy {xpath('HasBankruptcy')};
	boolean HasProperty {xpath('HasProperty')};
	boolean HasCriminalConviction {xpath('HasCriminalConviction')};
	boolean IsSexualOffender {xpath('IsSexualOffender')};
	boolean HasConcealedWeapon {xpath('HasConcealedWeapon')};
	dataset(iesp.sexualoffender_fcra.t_FcraSexOffReportRecord) SexualOffenses {xpath('SexualOffenses/SexualOffense'), MAXCOUNT(iesp.Constants.BR.MaxSexualOffenses)};
	dataset(iesp.faaaircraft_fcra.t_FcraAircraftReportRecord) Aircrafts {xpath('Aircrafts/Aircraft'), MAXCOUNT(iesp.Constants.BR.MaxAircrafts)};
	dataset(iesp.criminal_fcra.t_FcraCrimReportRecord) CriminalRecords {xpath('CriminalRecords/Criminal'), MAXCOUNT(iesp.Constants.BR.MaxCrimRecords)};
	dataset(iesp.bankruptcy_fcra.t_FcraBankruptcyReport3Record) Bankruptcies {xpath('Bankruptcies/Bankruptcy'), MAXCOUNT(iesp.Constants.BR.MaxBankruptcies)};
	dataset(iesp.lienjudgement_fcra.t_FcraLienJudgmentReportRecord) LiensJudgments {xpath('LiensJudgments/LienJudgment'), MAXCOUNT(iesp.Constants.BR.MaxLiensJudgments)};
	dataset(iesp.huntingfishing_fcra.t_FcraHuntFishRecord) HuntingFishingLicenses {xpath('HuntingFishingLicenses/HuntingFishingLicense'), MAXCOUNT(iesp.Constants.BR.MaxHFLicenses)};
	dataset(iesp.watercraft_fcra.t_FcraWaterCraftReport2Record) WaterCrafts {xpath('WaterCrafts/WaterCraft'), MAXCOUNT(iesp.Constants.BR.MaxWatercrafts)};
	dataset(iesp.concealedweapon_fcra.t_FcraWeaponRecord) WeaponPermits {xpath('WeaponPermits/WeaponPermit'), MAXCOUNT(iesp.Constants.BR.MaxWeaponPermits)};
	dataset(iesp.firearm_fcra.t_FcraFirearmRecord) FirearmExplosives {xpath('FirearmExplosives/FirearmExplosive'), MAXCOUNT(iesp.Constants.BR.MaxFirearmsExplosives)};
	dataset(t_FcraBpsReportProperty) Properties {xpath('Properties/Property'), MAXCOUNT(iesp.Constants.BR.UNKNOWN)};
	dataset(iesp.share.t_StringArrayItem) SuperiorLiens {xpath('SuperiorLiens/SuperiorLien'), MAXCOUNT(iesp.Constants.BR.MaxSuperiorLiens)};
	dataset(t_FcraBpsFAACertification) FAACertifications {xpath('FAACertifications/Certification'), MAXCOUNT(iesp.Constants.BR.MaxFaaCertificates)};
	boolean IsDisputed {xpath('IsDisputed')};
	dataset(iesp.share_fcra.t_StatementIdRec) StatementIds {xpath('StatementIdRecs/StatementIdRec'), MAXCOUNT(iesp.Constants.MaxConsumerStatementIds)};
end;
		
export t_FcraBpsReportResponse := record
	iesp.share.t_ResponseHeader _Header {xpath('Header')};
	t_FcraBpsReportIndividual Individual {xpath('Individual')};
	dataset(iesp.share_fcra.t_ConsumerStatement) ConsumerStatements {xpath('ConsumerStatements/ConsumerStatement'), MAXCOUNT(iesp.Constants.MaxConsumerStatements)};
	dataset(iesp.share_fcra.t_ConsumerAlert) ConsumerAlerts {xpath('ConsumerAlerts/ConsumerAlert'), MAXCOUNT(iesp.Constants.MaxConsumerAlerts)};
end;
		
export t_FcraBpsReportRequest := record (iesp.share.t_BaseRequest)
	t_FcraBpsReportOption Options {xpath('Options')};
	t_FcraBpsReportBy ReportBy {xpath('ReportBy')};
end;
		
export t_FcraBpsReportResponseEx := record
	t_FcraBpsReportResponse response {xpath('response')};
end;
		

end;

/*** Not to be hand edited (changes will be lost on re-generation) ***/
/*** ECL Interface generated by esdl2ecl version 1.0 from bpsreport_fcra.xml. ***/
/*===================================================*/

