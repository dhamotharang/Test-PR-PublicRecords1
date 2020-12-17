IMPORT AutoStandardI, doxie_cbrs, Foreclosure_Services, iesp;

// defaults to Foreclosure records, pass true for Notice of Defaults records
EXPORT foreclosure_records(DATASET(doxie_cbrs.layout_references) bdids, BOOLEAN isNodSearch=FALSE) := MODULE

  gmod := AutoStandardI.GlobalModule();
  nMod := MODULE(Foreclosure_Services.Raw.params);
    EXPORT STRING5 industry_class := gmod.IndustryClass;
    EXPORT STRING32 application_type := gmod.ApplicationType;
    EXPORT STRING ssn_mask := gmod.ssnmask;
  END;

  for := Foreclosure_Services.Raw.report_view.by_bdid(bdids,nMod,FALSE);
  nod := Foreclosure_Services.Raw.report_view.by_bdid(bdids,nMod,TRUE);
  fids := SET(for,ForeclosureId);

  doxie_cbrs.layouts.foreclosure_record assignFlg(iesp.foreclosure.t_ForeclosureReportRecord l) := TRANSFORM
    SELF := l;
    SELF.foreclosed := IF(isNodSearch,SELF.ForeclosureId IN fids,TRUE)
  END;

  EXPORT records := IF(isNodSearch,PROJECT(nod,assignFlg(LEFT)),PROJECT(for,assignFlg(LEFT)));

  EXPORT records_count := COUNT(records);

END;
