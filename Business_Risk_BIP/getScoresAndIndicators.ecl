EXPORT getScoresAndIndicators( DATASET(Business_Risk_BIP.Layouts.Shell) Shell, 
                               Business_Risk_BIP.LIB_Business_Shell_LIBIN Options) := 
  FUNCTION

    useSBFE := Options.DataPermissionMask[12] NOT IN Business_Risk_BIP.Constants.RESTRICTED_SET;

    // Make sure that something is populated, even if we don't get a hit on the key, and verify that the attribute is included in the version we are running
    checkBlank(STRING field, STRING default_val, UNSIGNED minVersion=2) := 
      MAP(Options.BusShellVersion < minVersion => '',
          field = '' 												              => default_val, 
          field );


    Business_Risk_BIP.Layouts.Shell xfm_AddScoresAndIndicators( Business_Risk_BIP.Layouts.Shell le ) :=
      TRANSFORM
        bus_verification  := Business_Risk_BIP.mod_CalculateBVI( le, useSBFE );
        risk_indicators   := Business_Risk_BIP.mod_CalculateRiskIndicators( le, bus_verification.bvi, bus_verification.bvi_desc_key, useSBFE ).rw_Risk_Indicators;
        bus2exec_index    := Business_Risk_BIP.mod_CalculateBusiness2Exec( le, useSBFE ).rw_business_to_exec_indices;
        resid_bus_info    := Business_Risk_BIP.mod_CalculateResidentialBusiness( le, useSBFE ).rw_ResidentialBusiness;
        verif_summaries   := Business_Risk_BIP.mod_CalculateVerificationSummaries( le, useSBFE ).rw_verification_summaries;
                
        // BVI (Business Verification Index)
        SELF.Verification.BVI                := checkBlank(bus_verification.bvi, '00');
        SELF.Verification.BVIDescriptionCode := bus_verification.bvi_desc_key;
        SELF.Verification.BVIDescriptionText := bus_verification.bvi_desc;
                
        // Residential Business
        SELF.Residential_Business.ResidentialBusIndicator   := checkBlank(resid_bus_info.residential_bus_indicator, '-1');
        SELF.Residential_Business.ResidentialBusDescription := resid_bus_info.residential_bus_desc;
        
        // Risk Indicators
        SELF.Risk_Indicator.BusRiskIndicator1     := risk_indicators.bus_ri_1;
        SELF.Risk_Indicator.BusRiskIndicatorDesc1 := risk_indicators.bus_ri_desc_1;
        SELF.Risk_Indicator.BusRiskIndicator2     := risk_indicators.bus_ri_2;
        SELF.Risk_Indicator.BusRiskIndicatorDesc2 := risk_indicators.bus_ri_desc_2;
        SELF.Risk_Indicator.BusRiskIndicator3     := risk_indicators.bus_ri_3;
        SELF.Risk_Indicator.BusRiskIndicatorDesc3 := risk_indicators.bus_ri_desc_3;
        SELF.Risk_Indicator.BusRiskIndicator4     := risk_indicators.bus_ri_4;
        SELF.Risk_Indicator.BusRiskIndicatorDesc4 := risk_indicators.bus_ri_desc_4;
        SELF.Risk_Indicator.BusRiskIndicator5     := risk_indicators.bus_ri_5;
        SELF.Risk_Indicator.BusRiskIndicatorDesc5 := risk_indicators.bus_ri_desc_5;
        SELF.Risk_Indicator.BusRiskIndicator6     := risk_indicators.bus_ri_6;
        SELF.Risk_Indicator.BusRiskIndicatorDesc6 := risk_indicators.bus_ri_desc_6;
        SELF.Risk_Indicator.BusRiskIndicator7     := risk_indicators.bus_ri_7;
        SELF.Risk_Indicator.BusRiskIndicatorDesc7 := risk_indicators.bus_ri_desc_7;
        SELF.Risk_Indicator.BusRiskIndicator8     := risk_indicators.bus_ri_8;
        SELF.Risk_Indicator.BusRiskIndicatorDesc8 := risk_indicators.bus_ri_desc_8;
        
        // Verification Summaries
        SELF.Verification_Summary.PhoneSourceVerifIndex              := checkBlank((STRING)verif_summaries.ver_phone_src_index, '0');
        SELF.Verification_Summary.PhoneSourceVerifDescription        := verif_summaries.ver_phone_desc;
        SELF.Verification_Summary.BureauSourceVerifIndex             := checkBlank((STRING)verif_summaries.ver_bureau_src_index, '0');
        SELF.Verification_Summary.BureauSourceVerifDescription       := verif_summaries.ver_bureau_desc;
        SELF.Verification_Summary.GovtSourceVerifIndex               := checkBlank((STRING)verif_summaries.ver_govt_reg_src_index, '0');
        SELF.Verification_Summary.GovtSourceVerifDescription         := verif_summaries.ver_govt_reg_desc;
        SELF.Verification_Summary.PubRecSourceVerifIndex             := checkBlank((STRING)verif_summaries.ver_pubrec_filing_src_index, '0');
        SELF.Verification_Summary.PubRecSourceVerifDescription       := verif_summaries.ver_pubrec_filing_desc;
        SELF.Verification_Summary.BusDirectorySourceVerifIndex       := checkBlank((STRING)verif_summaries.ver_bus_directories_src_index, '0');
        SELF.Verification_Summary.BusDirectorySourceVerifDescription := verif_summaries.ver_bus_directories_desc;
        
        // Business-to-Executive Indexes
        SELF.Business_To_Executive_Link.BusExecLinkAuthRepIndex      := checkBlank(bus2exec_index.bus2exec_index_rep1, '00');
        SELF.Business_To_Executive_Link.BusExecLinkAuthRepIndexDesc  := bus2exec_index.bus2exec_desc_rep1;
        SELF.Business_To_Executive_Link.BusExecLinkAuthRep2Index     := checkBlank(bus2exec_index.bus2exec_index_rep2, '00');
        SELF.Business_To_Executive_Link.BusExecLinkAuthRep2IndexDesc := bus2exec_index.bus2exec_desc_rep2;
        SELF.Business_To_Executive_Link.BusExecLinkAuthRep3Index     := checkBlank(bus2exec_index.bus2exec_index_rep3, '00');
        SELF.Business_To_Executive_Link.BusExecLinkAuthRep3IndexDesc := bus2exec_index.bus2exec_desc_rep3;
        SELF.Business_To_Executive_Link.BusExecLinkAuthRep4Index     := checkBlank(bus2exec_index.bus2exec_index_rep4, '00');
        SELF.Business_To_Executive_Link.BusExecLinkAuthRep4IndexDesc := bus2exec_index.bus2exec_desc_rep4;
        SELF.Business_To_Executive_Link.BusExecLinkAuthRep5Index     := checkBlank(bus2exec_index.bus2exec_index_rep5, '00');
        SELF.Business_To_Executive_Link.BusExecLinkAuthRep5IndexDesc := bus2exec_index.bus2exec_desc_rep5;
        
        SELF := le;
        SELF := [];
      END;
     
     ds_withScoresAndIndicators := PROJECT( Shell, xfm_AddScoresAndIndicators(LEFT) );
     
     RETURN ds_withScoresAndIndicators;
  END;