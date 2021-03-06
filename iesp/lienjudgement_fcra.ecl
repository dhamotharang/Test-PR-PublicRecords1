/*** Not to be hand edited (changes will be lost on re-generation) ***/
/*** ECL Interface generated by esdl2ecl version 1.0 from lienjudgement_fcra.xml. ***/
/*===================================================*/

import iesp;

export lienjudgement_fcra := MODULE
			
export t_FcraLienJudgmentSearchBy := record (iesp.share_fcra.t_FcraPersonSearchBy)
	string CaseNumber {xpath('CaseNumber')};
end;
		
export t_FcraLienJudgmentSearchOption := record (iesp.share_fcra.t_FcraSearchOption)
end;
		
export t_FcraLienJudgmentParty := record (iesp.lienjudgement.t_LienJudgmentParty)
	boolean IsDisputed {xpath('IsDisputed')};
	dataset(iesp.share_fcra.t_StatementIdRec) StatementIds {xpath('StatementIdRecs/StatementIdRec'), MAXCOUNT(iesp.Constants.MaxConsumerStatementIds)};
end;
		
export t_FcraLienJudgmentDebtor := record (iesp.lienjudgement.t_BaseLienJudgmentDebtor)
	dataset(t_FcraLienJudgmentParty) ParsedParties {xpath('ParsedParties/Party'), MAXCOUNT(iesp.Constants.Liens.MAX_PARTIES)};
end;
		
export t_FcraLienJudgmentThirdParty := record (iesp.lienjudgement.t_BaseLienJudgmentThirdParty)
	dataset(t_FcraLienJudgmentParty) ParsedParties {xpath('ParsedParties/Party'), MAXCOUNT(iesp.Constants.Liens.MAX_PARTIES)};
end;
		
export t_FcraLienJudgmentCreditor := record (iesp.lienjudgement.t_BaseLienJudgmentCreditor)
	dataset(t_FcraLienJudgmentParty) ParsedParties {xpath('ParsedParties/Party'), MAXCOUNT(iesp.Constants.Liens.MAX_PARTIES)};
end;
		
export t_FcraLienJudgmentDebtorAttorney := record (iesp.lienjudgement.t_BaseLienJudgmentDebtorAttorney)
	dataset(t_FcraLienJudgmentParty) ParsedParties {xpath('ParsedParties/Party'), MAXCOUNT(iesp.Constants.Liens.MAX_PARTIES)};
end;
		
export t_FcraLienJudgmentFiling := record (iesp.lienjudgement.t_LienJudgmentFiling)
	boolean IsDisputed {xpath('IsDisputed')};
	dataset(iesp.share_fcra.t_StatementIdRec) StatementIds {xpath('StatementIdRecs/StatementIdRec'), MAXCOUNT(iesp.Constants.MaxConsumerStatementIds)};
end;
		
export t_FcraLienJudgmentRecordV2Base := record (iesp.lienjudgement.t_CommonLienJudgmentRecordV2Base)
	dataset(t_FcraLienJudgmentDebtor) Debtors {xpath('Debtors/Debtor'), MAXCOUNT(iesp.Constants.Liens.MAX_DEBTORS)};
	dataset(t_FcraLienJudgmentThirdParty) ThirdParties {xpath('ThirdParties/ThirdParty'), MAXCOUNT(iesp.Constants.Liens.MAX_THIRD_PARTIES)};
	dataset(t_FcraLienJudgmentCreditor) Creditors {xpath('Creditors/Creditor'), MAXCOUNT(iesp.Constants.Liens.MAX_CREDITORS)};
	dataset(t_FcraLienJudgmentDebtorAttorney) DebtorAttorneys {xpath('DebtorAttorneys/Attorney'), MAXCOUNT(iesp.Constants.Liens.MAX_ATTORNEYS)};
	dataset(t_FcraLienJudgmentFiling) Filings {xpath('Filings/Filing'), MAXCOUNT(iesp.Constants.Liens.MAX_FILINGS)};
	boolean IsDisputed {xpath('IsDisputed')};
	dataset(iesp.share_fcra.t_StatementIdRec) StatementIds {xpath('StatementIdRecs/StatementIdRec'), MAXCOUNT(iesp.Constants.MaxConsumerStatementIds)};
end;
		
export t_FcraLienJudgmentSearchRecord2 := record (t_FcraLienJudgmentRecordV2Base)
	boolean AlsoFound {xpath('AlsoFound')};
	string PersistentRecordId {xpath('PersistentRecordId')};
end;
		
export t_FcraLienJudgmentSearchResponse := record
	iesp.share.t_ResponseHeader _Header {xpath('Header')};
	integer RecordCount {xpath('RecordCount')};
	dataset(iesp.lienjudgement.t_LienJudgmentSearchRecord) Records {xpath('Records/Record'), MAXCOUNT(iesp.Constants.Liens.MAX_LIENS_JUDGEMENTS)};
	dataset(t_FcraLienJudgmentSearchRecord2) Records2 {xpath('Records/Record'), MAXCOUNT(iesp.Constants.Liens.MAX_LIENS_JUDGEMENTS)};
	dataset(iesp.share_fcra.t_ConsumerStatement) ConsumerStatements {xpath('ConsumerStatements/ConsumerStatement'), MAXCOUNT(iesp.Constants.MaxConsumerStatements)};
	dataset(iesp.share_fcra.t_ConsumerAlert) ConsumerAlerts {xpath('ConsumerAlerts/ConsumerAlert'), MAXCOUNT(iesp.Constants.MaxConsumerAlerts)};
	iesp.share_fcra.t_FcraConsumer Consumer {xpath('Consumer')};//hidden[ecl_only]
end;
		
export t_FcraLienJudgmentReportBy := record (iesp.share_fcra.t_FcraReportBy)
end;
		
export t_FcraLienJudgmentReportOption := record (iesp.share_fcra.t_FcraReportOption)
end;
		
export t_FcraLienJudgmentReportRecord := record (t_FcraLienJudgmentRecordV2Base)
	string PersistentRecordId {xpath('PersistentRecordId')};
end;
		
export t_FcraLienJudgmentReportResponse := record
	iesp.share.t_ResponseHeader _Header {xpath('Header')};
	dataset(t_FcraLienJudgmentReportRecord) LienJudgments {xpath('LienJudgments/Record'), MAXCOUNT(iesp.Constants.Liens.MAX_LIENS_JUDGEMENTS)};
	dataset(iesp.share_fcra.t_ConsumerStatement) ConsumerStatements {xpath('ConsumerStatements/ConsumerStatement'), MAXCOUNT(iesp.Constants.MaxConsumerStatements)};
	dataset(iesp.share_fcra.t_ConsumerAlert) ConsumerAlerts {xpath('ConsumerAlerts/ConsumerAlert'), MAXCOUNT(iesp.Constants.MaxConsumerAlerts)};
	iesp.share_fcra.t_FcraConsumer Consumer {xpath('Consumer')};//hidden[ecl_only]
end;
		
export t_FcraLienJudgmentSearchRequest := record (iesp.share.t_BaseRequest)
	t_FcraLienJudgmentSearchBy SearchBy {xpath('SearchBy')};
	t_FcraLienJudgmentSearchOption Options {xpath('Options')};
end;
		
export t_FcraLienJudgmentReportRequest := record (iesp.share.t_BaseRequest)
	t_FcraLienJudgmentReportOption Options {xpath('Options')};
	t_FcraLienJudgmentReportBy ReportBy {xpath('ReportBy')};
end;
		
export t_FcraLienJudgmentSearchResponseEx := record
	t_FcraLienJudgmentSearchResponse response {xpath('response')};
end;
		
export t_FcraLienJudgmentReportResponseEx := record
	t_FcraLienJudgmentReportResponse response {xpath('response')};
end;
		

end;

/*** Not to be hand edited (changes will be lost on re-generation) ***/
/*** ECL Interface generated by esdl2ecl version 1.0 from lienjudgement_fcra.xml. ***/
/*===================================================*/

