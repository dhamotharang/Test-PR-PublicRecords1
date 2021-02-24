IMPORT $, BatchServices, doxie, dx_BestRecords, iesp;

EXPORT ContactRiskSearchRecords(iesp.contactrisksearch.t_ContactRiskSearchBy search_by, $.IParams.ContactRiskSearch search_params) := FUNCTION

  ds_did_in := DATASET([{search_by.UniqueId}], doxie.layout_references);
  perm_type := dx_BestRecords.Functions.get_perm_type_idata(PROJECT(search_params, doxie.IDataAccess), useMarketing := search_params.isDirectMarketing());
  ds_best := dx_BestRecords.get(ds_did_in, did, perm_type)[1];
  isLexIdSearch := (unsigned) search_by.UniqueId > 0;

  $.Layouts.batch_input xInput() := TRANSFORM
    SELF.acctno               := '1';
    SELF.name_first           := IF(isLexIdSearch, ds_best.fname, search_by.Name.First);
    SELF.name_middle          := IF(isLexIdSearch, ds_best.mname, search_by.Name.Middle);
    SELF.name_last            := IF(isLexIdSearch, ds_best.lname, search_by.Name.Last);
    SELF.CourtJurisdiction    := IF(isLexIdSearch, ds_best.st, search_by.CourtJurisdiction);
    SELF.CaseTypeSearch_FDCPA := search_params.CaseTypeSearchFDCPA;
    SELF.CaseTypeSearch_FCRA  := search_params.CaseTypeSearchFCRA;
    SELF.CaseTypeSearch_TCPA  := search_params.CaseTypeSearchTCPA;
    SELF := [];
  END;

  ds_in_common := DATASET([xInput()]);

  ds_courtlink := $.GetCourtLinkRecords(ds_in_common);

  iesp.contactrisksearch.t_ContactRiskSearchRecord xCourtLink($.Layouts.results_raw_count L) := TRANSFORM
    SELF.AdditionalPartyAttorneys := L.AdditionalAttorneyName;
    SELF.Cause                    := L.Cause;
    SELF.CauseCode                := L.causecode;
    SELF.DefendantsAttorney       := L.DAttorneyname;
    SELF.Defendants               := L.Defendant;
    SELF.Demand                   := IF(L.DemandAmount <> '', BatchServices.Functions.convert_to_currency(L.DemandAmount), L.DemandAmount);
    SELF.DocketCaseNumber         := L.DocketNumber;
    SELF.FilingDate               := iesp.ECL2ESP.toDatestring8(L.DateFiled);
    SELF.FilingType               := L.ClassCode;
    SELF.Judge                    := L.JudgeName;
    SELF.Jurisdiction             := L.Jurisdiction;
    SELF.JuryDemand               := L.JuryDemand;
    SELF.LeadDocketCaseNumber     := L.LeadDocketNumber;
    SELF.NatureOfSuit             := L.SuitNatureCode + ' ' + L.suitNatureDesc;
    SELF.OtherDocketCaseNumber    := L.OtherDocketNumber;
    SELF.PlaintiffsAttorney       := L.PAttorneyname;
    SELF.Plaintiffs               := L.plaintiff;
    SELF.CourtRefferedTo          := L.referredTojudgeTitle + ' ' + L.referredToJudge;
    SELF.CaseStatus               := IF(L.caseclosed = $.Constants.FLAG_TRUE, $.Constants.CASE_CLOSED, '');
    SELF.DateCourtLastUpdated     := iesp.ECL2ESP.toDatestring8(L.asOfDate);
    SELF.CourtOfFiling            := IF(L.CourtName <> '', L.CourtName + '; (' + L.officeName + ')', '');
    SELF.CaseTitle                := L.CaseCaption;
  END;

  ds_contactrisk := PROJECT(ds_courtlink, xCourtLink(LEFT));

  iesp.contactrisksearch.t_ContactRiskSearchResponse xResults() := TRANSFORM
    SELF._Header         := iesp.ECL2ESP.GetHeaderRow();
    SELF.ContactRiskFlag := EXISTS(ds_contactrisk);
    SELF.RecordCount     := COUNT(ds_contactrisk);
    SELF.Records         := ds_contactrisk;
  END;

  ds_results := DATASET([xResults()]);

  RETURN ds_results;

END;
