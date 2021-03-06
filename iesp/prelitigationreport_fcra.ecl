/*** Not to be hand edited (changes will be lost on re-generation) ***/
/*** ECL Interface generated by esdl2ecl version 1.0 from prelitigationreport_fcra.xml. ***/
/*===================================================*/

import iesp;

export prelitigationreport_fcra := MODULE
			
export t_FcraPreLitigationReportBy := record (iesp.share_fcra.t_FcraReportBy)
end;
		
export t_FcraPreLitigationReportOption := record (iesp.share_fcra.t_FcraReportOption)
	boolean SuppressWithdrawnBankruptcy {xpath('SuppressWithdrawnBankruptcy')};
end;
		
export t_FcraPreLitigationReportIndividual := record, MAXLENGTH (300000001)
	string12 UniqueId {xpath('UniqueId')};
	string3 Probability {xpath('Probability')};
	boolean HasBankruptcy {xpath('HasBankruptcy')};
	boolean HasProperty {xpath('HasProperty')};
	boolean HasCorporateAffiliation {xpath('HasCorporateAffiliation')};//hidden[ecl_only]
	dataset(iesp.watercraft_fcra.t_FcraWaterCraftReportRecord) WaterCrafts {xpath('WaterCrafts/WaterCraft'), MAXCOUNT(iesp.constants.BR.MaxWatercrafts)};
	dataset(iesp.propassess_fcra.t_FcraAssessReportRecord) AssessRecords {xpath('AssessRecords/AssessRecord'), MAXCOUNT(iesp.constants.BR.MaxAssessments)};
	dataset(iesp.propdeed_fcra.t_FcraDeedReportRecord) DeedRecords {xpath('DeedRecords/DeedRecord'), MAXCOUNT(iesp.constants.BR.MaxDeeds)};
	dataset(iesp.lienjudgement_fcra.t_FcraLienJudgmentReportRecord) LiensJudgments2 {xpath('LiensJudgments2/LienJudgment'), MAXCOUNT(iesp.constants.BR.MaxLiensJudgments)};
	dataset(iesp.bankruptcy_fcra.t_FcraBankruptcy3BpsRecord) Bankruptcies3 {xpath('Bankruptcies3/Bankruptcy'), MAXCOUNT(iesp.constants.BR.MaxBankruptcies)};
	dataset(iesp.share_fcra.t_FcraIdentity) AKAs {xpath('AKAs/Identity'), MAXCOUNT(iesp.constants.BR.MaxAKA)};
end;
		
export t_FcraPreLitigationReportResponse := record
	iesp.share.t_ResponseHeader _Header {xpath('Header')};
	t_FcraPreLitigationReportIndividual Individual {xpath('Individual')};
	dataset(iesp.share_fcra.t_ConsumerStatement) ConsumerStatements {xpath('ConsumerStatements/ConsumerStatement'), MAXCOUNT(iesp.Constants.MaxConsumerStatements)};
	dataset(iesp.share_fcra.t_ConsumerAlert) ConsumerAlerts {xpath('ConsumerAlerts/ConsumerAlert'), MAXCOUNT(iesp.Constants.MaxConsumerAlerts)};
	iesp.share_fcra.t_FcraConsumer Consumer {xpath('Consumer')};
end;
		
export t_FcraPreLitigationReportRequest := record (iesp.share.t_BaseRequest)
	t_FcraPreLitigationReportOption Options {xpath('Options')};
	t_FcraPreLitigationReportBy ReportBy {xpath('ReportBy')};
end;
		
export t_FcraPreLitigationReportResponseEx := record
	t_FcraPreLitigationReportResponse response {xpath('response')};
end;
		

end;

/*** Not to be hand edited (changes will be lost on re-generation) ***/
/*** ECL Interface generated by esdl2ecl version 1.0 from prelitigationreport_fcra.xml. ***/
/*===================================================*/

