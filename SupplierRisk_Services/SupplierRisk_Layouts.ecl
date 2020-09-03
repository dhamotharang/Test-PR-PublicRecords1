IMPORT iesp, BIPV2, TopBusiness_Services;

EXPORT SupplierRisk_Layouts := MODULE

  EXPORT Report_options := RECORD
    iesp.SupplierRiskReport.t_SRRReportOption;
    STRING32 ApplicationType;
    BOOLEAN internal_testing;
    BOOLEAN LnBranded;
  END;

  EXPORT section_options := RECORD
    STRING32 ApplicationType;
    BOOLEAN internal_testing;
    BOOLEAN LnBranded;
    STRING1 ReportFetchLevel;
  END;
  
  // common report input ids dataset layout for use by all the sections
  EXPORT rec_input_ids := RECORD
    STRING25 acctno;
    BIPV2.IDlayouts.l_header_ids;
  END;
  
  EXPORT div_cert_layout := RECORD
    STRING25 acctno;
    iesp.diversitycertification.t_DiversityCertificationSection;
  END;
  
  EXPORT natural_disaster_layout := RECORD
    STRING25 acctno;
    iesp.naturaldisaster.t_NaturalDisasterRecordSection;
  END;
  
  EXPORT risk_metrics_layout := RECORD
    STRING25 acctno;
    iesp.riskmetrics.t_RiskMetricsRecordSection;
  END;
  
  EXPORT lnca_layout := RECORD
    STRING25 acctno;
    iesp.lncafirmographics.t_LNCASection;
  END;
  
  EXPORT oshair_layout := RECORD
    STRING25 acctno;
    iesp.osha.t_OshaSection;
  END;
  
  EXPORT laborActionWHD_layout := RECORD
    STRING25 acctno;
    iesp.laboraction_whd.t_LaborActionWHDSection;
  END;
  
  EXPORT Equifax_layout := RECORD
    STRING25 acctno;
    iesp.gateway_inviewreport.t_InviewReportResponse;
  END;
  
  EXPORT Final := RECORD
    TopBusiness_Services.BranchReport_Layouts.Final; // Bip report sections
    div_cert_layout DiversityCertificationSection;
    natural_disaster_layout NaturalDisasterReadySection;
    risk_metrics_layout RiskMetricSection;
    lnca_layout LNCAFirmographicsSection;
    Equifax_layout EQFXGatewaySection;
    oshair_layout OshairSection;
    laborActionWHD_layout LaborActionWorkSection;
  END;
  
END;
