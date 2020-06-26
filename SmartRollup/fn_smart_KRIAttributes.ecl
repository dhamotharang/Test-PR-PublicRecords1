IMPORT iesp, Risk_Indicators, PersonReports, Gateway, AML, doxie;

/* Function that will retrieve and assign the Key Risk Indicator values based on the passed did and
   will set the appropriate caution indicator flags using the passed bestinfo, akas and relative records.
*/
EXPORT fn_smart_KRIAttributes(PersonReports.IParam._smartlinxreport inParam,
                              unsigned6 subjectDID,
                              iesp.smartlinxreport.t_SLRBestInfo inBest = ROW([],iesp.smartlinxreport.t_SLRBestInfo),
                              DATASET(iesp.smartlinxreport.t_SLRProfLicenseAndSanctionAndProvider) inProfs = DATASET ([],iesp.smartlinxreport.t_SLRProfLicenseAndSanctionAndProvider),
                              DATASET(iesp.bps_share.t_BpsReportIdentity) inAkas = DATASET ([],iesp.bps_share.t_BpsReportIdentity),
                              DATASET(iesp.smartlinxreport.t_SLRRelative) inRels = DATASET ([],iesp.smartlinxreport.t_SLRRelative),
                              boolean useXG5Gate = false
                              ) := FUNCTION


  Risk_Indicators.Layout_Input prep_iid() := TRANSFORM
      SELF.DID   := subjectDID;
      SELF.historydate := 999999;  // Set to realtime
      SELF := [];
  END;
  iid := DATASET ([prep_iid()]);

  outLayout := RECORD
    iesp.smartlinxreport.t_SLRKeyRiskIndInfo;
    DATASET(iesp.WsSearchCore.t_ResultMatch) WorldCompRecs;
  END;

  // '0' - do not call XG5
  // '1' - full XG5 response will be returned for AML report
  // '2' - Call Bridger XG5 for KRIs but not full response
  // '3' - Call Bridger XG4 for KRIs but not full response
  // Currently if useXG5Gate is true set to 1, otherwise 3.
  XGParam := IF(useXG5Gate,'1','0');

  // Call aml attribute to get Key Risk Indicator values, passing useXg5 param to turn on/off if
  // gateway is used to calculate news profile indicators. As of now, the news profile indicators
  // are only being calculated for when the xg5 data is used (primary individual) and not for relatives
  // and associates.
  mod_aml := MODULE(PROJECT(inParam, AML.IParam.IAml, OPT))
    EXPORT unsigned1 bs_version := 50; //used to be a default value for getAMLattributesV2
  END;
  kris := AML.getAMLattributesV2(iid, mod_aml, DATASET ([],Gateway.Layouts.Config), XGParam, useXG5Gate);

  /* Transform to iesp layout and set the caution flag */
  outLayout xfm_keyrisk(AML.Layouts.LayoutAMLShellV2 l) := TRANSFORM
      SELF.AddressCautionFlag := IF(inBest.AddressCDS.AddressVacancyIndicator = 'Y',1,0);
      SELF.CrimeIndexCautionFlag := IF(l.hidta or l.hifca,1,0);
      SELF.ProfLicenseCautionFlag := IF((COUNT(inProfs(status='REVOKED')) > 0) OR
                                          (INTEGER)l.IndProfessionalRisk >= 3,1,0);
      SELF.FelonyCautionFlag := IF((COUNT(inAkas(HasCriminalConviction)) > 0 OR
                                    COUNT(inAkas(IsSexualOffender)) > 0 OR
                                    COUNT(inRels.Akas(HasCriminalConviction)) > 0 OR
                                    COUNT(inRels.Akas(IsSexualOffender)) > 0),1,0);
      SELF.SSNCautionFlag := IF((COUNT(inBest.ssn.HighRiskIndicators(RiskCode IN SmartRollup.Constants.SSN_KRI_SET)) > 0),1,0);
      SELF.WorldCompRecs := PROJECT(l.xg5return.SearchResult.EntityRecords.Matches,
                                      TRANSFORM(iesp.WsSearchCore.t_ResultMatch,SELF := LEFT, SELF := []));
      SELF := l;
  END;


  kris_iesp := PROJECT(kris(did!=0),xfm_keyrisk(LEFT));

  RETURN(kris_iesp);
END;
