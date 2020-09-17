IMPORT topBusiness_services, iesp, AutoStandardI, BIPV2;

EXPORT SupplierRisk_records(
    DATASET(SupplierRisk_Services.SupplierRisk_Layouts.rec_input_ids) ds_Supinput_data,
    SupplierRisk_Services.SupplierRisk_Layouts.Report_options in_options,
    AutoStandardI.DataRestrictionI.params in_mod
    ) := FUNCTION

  // set the FETCH LEVEL for join to main bus header key
  FETCH_LEVEL := in_options.ReportFetchLevel;
  
  ds_in_unique_ids_only := PROJECT(ds_Supinput_data,
    TRANSFORM(BIPV2.IDlayouts.l_xlink_ids,
      SELF.dotid := 0;
      SELF.powid := 0;
      SELF.empid := 0;
      SELF.proxweight := 0;
      SELF.proxscore := 0;
      SELF.seleweight := 0;
      SELF.selescore := 0;
      SELF.ultscore := 0;
      SELF.ultweight := 0;
      SELF.dotscore := 0;
      SELF.dotweight := 0;
      SELF.orgscore := 0;
      SELF.orgweight := 0;
      SELF.powscore := 0;
      SELF.powweight := 0;
      SELF.empscore := 0;
      SELF.empweight := 0;
      SELF := LEFT;
    ));
  
  // Supplier Risk report is the BIP report plus some additional sections. The first thing is to get the
  // bip report and then begin adding the Supp Risk sections.
  bip_in_options := PROJECT(in_options, TRANSFORM(TopBusiness_Services.BusinessReportComprehensive_Layouts,
    SELF.BusinessReportFetchLevel := LEFT.ReportFetchLevel,
    SELF:=LEFT,
    SELF := []));
  bip_input_data := PROJECT(ds_Supinput_data, TRANSFORM(TopBusiness_Services.Layouts.rec_input_ids,
    SELF:=LEFT; SELF := []));
   
  // Get BIP report
  bipReport := TopBusiness_Services.Guts.getReport(bip_input_data,bip_in_options,in_mod);
  bestInfo := PROJECT(bipReport,TRANSFORM(TopBusiness_Services.BestSection_Layouts.final, 
    SELF := LEFT.bestsection; SELF := []));
  section_options := PROJECT(in_options, TRANSFORM(SupplierRisk_Services.SupplierRisk_Layouts.section_options,
    SELF:=LEFT; SELF := []));
  
  
  DiversityCertificationSection := IF (in_options.IncludeDiversityCert,
    SupplierRisk_Services.DiversityCertSection.fn_fullView(ds_Supinput_data,section_options)
    );
  
  NaturalDisasterReadySection := IF (in_options.IncludeNatDisReady,
    SupplierRisk_Services.NaturalDisasterSection.fn_fullView(ds_Supinput_data,section_options)
    );
  
 RiskMetricSection := IF(in_options.IncludeRiskMetrics,
    SupplierRisk_Services.RiskMetricsSection.fn_fullView(ds_Supinput_data,section_options)
    );
    
  
  LNCAFirmographicsSection := IF(in_options.IncludeLNCA,
    SupplierRisk_Services.LNCASection.fn_fullView(ds_Supinput_data,section_options)
    );
  
 OsHairSection := IF(in_options.IncludeOSHAIR,
    SupplierRisk_Services.OSHASection.fn_fullView(ds_Supinput_data,section_options)
    );
  

  LaborActionWorkSection := IF (in_options.IncludeLaborActWHD,
    SupplierRisk_Services.LaborActionWHDSection.fn_fullView(ds_Supinput_data,section_options)
    );
    
  get_equifax := in_options.IncludeBusinessCreditRisk 
    OR in_options.IncludeBusinessFailureRiskLevel
    OR in_options.IncludeCustomBCIR;
  
  EQFXGatewaySection := IF (get_equifax,
    SupplierRisk_Services.EquifaxBusinessSection.fn_fullView(bestinfo,ds_Supinput_data,get_equifax,in_options,in_mod)
    );
  
  SectionReport := PROJECT(bipReport,
    TRANSFORM(SupplierRisk_Services.SupplierRisk_Layouts.Final,
      SELF.DiversityCertificationSection := DiversityCertificationSection[1];
      SELF.NaturalDisasterReadySection := NaturalDisasterReadySection[1];
      SELF.RiskMetricSection := RiskMetricSection[1];
      SELF.LNCAFirmographicsSection := LNCAFirmographicsSection[1];
      SELF.OsHairSection := OsHairSection[1];
      SELF.LaborActionWorkSection := LaborActionWorkSection[1];
      SELF.EQFXGatewaySection := EQFXGatewaySection[1];
      SELF := LEFT));
  RETURN sectionReport;

END;
