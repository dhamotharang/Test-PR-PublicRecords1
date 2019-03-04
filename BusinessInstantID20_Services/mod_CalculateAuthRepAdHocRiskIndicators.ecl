IMPORT BusinessInstantID20_Services, Business_Risk_BIP, Risk_Indicators;
EXPORT mod_CalculateAuthRepAdHocRiskIndicators( BusinessInstantID20_Services.iOptions Options,
                        DATASET(Risk_Indicators.Layouts.layout_watchlists_plus_seq) watchlist_table_authrep1,
                        DATASET(Risk_Indicators.Layouts.layout_watchlists_plus_seq) watchlist_table_authrep2,
                        DATASET(Risk_Indicators.Layouts.layout_watchlists_plus_seq) watchlist_table_authrep3,
                        DATASET(Risk_Indicators.Layouts.layout_watchlists_plus_seq) watchlist_table_authrep4,
                        DATASET(Risk_Indicators.Layouts.layout_watchlists_plus_seq) watchlist_table_authrep5,
                        INTEGER cnt,
                        STRING1 Rep_Whichone,
                        DATASET(risk_indicators.layouts.layout_desc_plus_seq) ri,
                        DATASET(risk_indicators.Layout_Desc) fua
                        ) := 
		MODULE
      SHARED isAuthRep1Code32 := Risk_Indicators.rcSet.isCode32(watchlist_table_authrep1[1].watchlist_table, watchlist_table_authrep1[1].watchlist_record_number) OR
                                 Risk_Indicators.rcSet.isCode32(watchlist_table_authrep1[2].watchlist_table, watchlist_table_authrep1[2].watchlist_record_number) OR
                                 Risk_Indicators.rcSet.isCode32(watchlist_table_authrep1[3].watchlist_table, watchlist_table_authrep1[3].watchlist_record_number) OR
                                 Risk_Indicators.rcSet.isCode32(watchlist_table_authrep1[4].watchlist_table, watchlist_table_authrep1[4].watchlist_record_number) OR
                                 Risk_Indicators.rcSet.isCode32(watchlist_table_authrep1[5].watchlist_table, watchlist_table_authrep1[5].watchlist_record_number) OR
                                 Risk_Indicators.rcSet.isCode32(watchlist_table_authrep1[6].watchlist_table, watchlist_table_authrep1[6].watchlist_record_number) OR
                                 Risk_Indicators.rcSet.isCode32(watchlist_table_authrep1[7].watchlist_table, watchlist_table_authrep1[7].watchlist_record_number);
      SHARED isAuthRep2Code32 := Risk_Indicators.rcSet.isCode32(watchlist_table_authrep2[1].watchlist_table, watchlist_table_authrep2[1].watchlist_record_number) OR
                                 Risk_Indicators.rcSet.isCode32(watchlist_table_authrep2[2].watchlist_table, watchlist_table_authrep2[2].watchlist_record_number) OR
                                 Risk_Indicators.rcSet.isCode32(watchlist_table_authrep2[3].watchlist_table, watchlist_table_authrep2[3].watchlist_record_number) OR
                                 Risk_Indicators.rcSet.isCode32(watchlist_table_authrep2[4].watchlist_table, watchlist_table_authrep2[4].watchlist_record_number) OR
                                 Risk_Indicators.rcSet.isCode32(watchlist_table_authrep2[5].watchlist_table, watchlist_table_authrep2[5].watchlist_record_number) OR
                                 Risk_Indicators.rcSet.isCode32(watchlist_table_authrep2[6].watchlist_table, watchlist_table_authrep2[6].watchlist_record_number) OR
                                 Risk_Indicators.rcSet.isCode32(watchlist_table_authrep2[7].watchlist_table, watchlist_table_authrep2[7].watchlist_record_number);
      SHARED isAuthRep3Code32 := Risk_Indicators.rcSet.isCode32(watchlist_table_authrep3[1].watchlist_table, watchlist_table_authrep3[1].watchlist_record_number) OR
                                 Risk_Indicators.rcSet.isCode32(watchlist_table_authrep3[2].watchlist_table, watchlist_table_authrep3[2].watchlist_record_number) OR
                                 Risk_Indicators.rcSet.isCode32(watchlist_table_authrep3[3].watchlist_table, watchlist_table_authrep3[3].watchlist_record_number) OR
                                 Risk_Indicators.rcSet.isCode32(watchlist_table_authrep3[4].watchlist_table, watchlist_table_authrep3[4].watchlist_record_number) OR
                                 Risk_Indicators.rcSet.isCode32(watchlist_table_authrep3[5].watchlist_table, watchlist_table_authrep3[5].watchlist_record_number) OR
                                 Risk_Indicators.rcSet.isCode32(watchlist_table_authrep3[6].watchlist_table, watchlist_table_authrep3[6].watchlist_record_number) OR
                                 Risk_Indicators.rcSet.isCode32(watchlist_table_authrep3[7].watchlist_table, watchlist_table_authrep3[7].watchlist_record_number);
      SHARED isAuthRep4Code32 := Risk_Indicators.rcSet.isCode32(watchlist_table_authrep4[1].watchlist_table, watchlist_table_authrep4[1].watchlist_record_number) OR
                                 Risk_Indicators.rcSet.isCode32(watchlist_table_authrep4[2].watchlist_table, watchlist_table_authrep4[2].watchlist_record_number) OR
                                 Risk_Indicators.rcSet.isCode32(watchlist_table_authrep4[3].watchlist_table, watchlist_table_authrep4[3].watchlist_record_number) OR
                                 Risk_Indicators.rcSet.isCode32(watchlist_table_authrep4[4].watchlist_table, watchlist_table_authrep4[4].watchlist_record_number) OR
                                 Risk_Indicators.rcSet.isCode32(watchlist_table_authrep4[5].watchlist_table, watchlist_table_authrep4[5].watchlist_record_number) OR
                                 Risk_Indicators.rcSet.isCode32(watchlist_table_authrep4[6].watchlist_table, watchlist_table_authrep4[6].watchlist_record_number) OR
                                 Risk_Indicators.rcSet.isCode32(watchlist_table_authrep4[7].watchlist_table, watchlist_table_authrep4[7].watchlist_record_number);
      SHARED isAuthRep5Code32 := Risk_Indicators.rcSet.isCode32(watchlist_table_authrep5[1].watchlist_table, watchlist_table_authrep5[1].watchlist_record_number) OR
                                 Risk_Indicators.rcSet.isCode32(watchlist_table_authrep5[2].watchlist_table, watchlist_table_authrep5[2].watchlist_record_number) OR
                                 Risk_Indicators.rcSet.isCode32(watchlist_table_authrep5[3].watchlist_table, watchlist_table_authrep5[3].watchlist_record_number) OR
                                 Risk_Indicators.rcSet.isCode32(watchlist_table_authrep5[4].watchlist_table, watchlist_table_authrep5[4].watchlist_record_number) OR
                                 Risk_Indicators.rcSet.isCode32(watchlist_table_authrep5[5].watchlist_table, watchlist_table_authrep5[5].watchlist_record_number) OR
                                 Risk_Indicators.rcSet.isCode32(watchlist_table_authrep5[6].watchlist_table, watchlist_table_authrep5[6].watchlist_record_number) OR
                                 Risk_Indicators.rcSet.isCode32(watchlist_table_authrep5[7].watchlist_table, watchlist_table_authrep5[7].watchlist_record_number);
      SHARED riAuthRep1pre := DEDUP(
          IF(Risk_Indicators.rcSet.isCode32(watchlist_table_authrep1[1].watchlist_table, watchlist_table_authrep1[1].watchlist_record_number),DATASET([{1,'32',Risk_Indicators.getHRIDesc('32')}],Risk_Indicators.layouts.layout_desc_plus_seq)) &
          IF(Risk_Indicators.rcSet.isCode32(watchlist_table_authrep1[2].watchlist_table, watchlist_table_authrep1[2].watchlist_record_number),DATASET([{1,'32',Risk_Indicators.getHRIDesc('32')}],Risk_Indicators.layouts.layout_desc_plus_seq)) &
          IF(Risk_Indicators.rcSet.isCode32(watchlist_table_authrep1[3].watchlist_table, watchlist_table_authrep1[3].watchlist_record_number),DATASET([{1,'32',Risk_Indicators.getHRIDesc('32')}],Risk_Indicators.layouts.layout_desc_plus_seq)) &
          IF(Risk_Indicators.rcSet.isCode32(watchlist_table_authrep1[4].watchlist_table, watchlist_table_authrep1[4].watchlist_record_number),DATASET([{1,'32',Risk_Indicators.getHRIDesc('32')}],Risk_Indicators.layouts.layout_desc_plus_seq)) &
          IF(Risk_Indicators.rcSet.isCode32(watchlist_table_authrep1[5].watchlist_table, watchlist_table_authrep1[5].watchlist_record_number),DATASET([{1,'32',Risk_Indicators.getHRIDesc('32')}],Risk_Indicators.layouts.layout_desc_plus_seq)) &
          IF(Risk_Indicators.rcSet.isCode32(watchlist_table_authrep1[6].watchlist_table, watchlist_table_authrep1[6].watchlist_record_number),DATASET([{1,'32',Risk_Indicators.getHRIDesc('32')}],Risk_Indicators.layouts.layout_desc_plus_seq)) &
          IF(Risk_Indicators.rcSet.isCode32(watchlist_table_authrep1[7].watchlist_table, watchlist_table_authrep1[7].watchlist_record_number),DATASET([{1,'32',Risk_Indicators.getHRIDesc('32')}],Risk_Indicators.layouts.layout_desc_plus_seq)) &
          IF(Risk_Indicators.rcSet.isCodeWL(watchlist_table_authrep1[1].watchlist_table, watchlist_table_authrep1[1].watchlist_record_number) AND NOT isAuthRep1Code32,DATASET([{1,'WL',Risk_Indicators.getHRIDesc('WL')}],Risk_Indicators.layouts.layout_desc_plus_seq)) &	
          IF(Risk_Indicators.rcSet.isCodeWL(watchlist_table_authrep1[2].watchlist_table, watchlist_table_authrep1[2].watchlist_record_number) AND NOT isAuthRep1Code32,DATASET([{1,'WL',Risk_Indicators.getHRIDesc('WL')}],Risk_Indicators.layouts.layout_desc_plus_seq)) &	
          IF(Risk_Indicators.rcSet.isCodeWL(watchlist_table_authrep1[3].watchlist_table, watchlist_table_authrep1[3].watchlist_record_number) AND NOT isAuthRep1Code32,DATASET([{1,'WL',Risk_Indicators.getHRIDesc('WL')}],Risk_Indicators.layouts.layout_desc_plus_seq)) &	
          IF(Risk_Indicators.rcSet.isCodeWL(watchlist_table_authrep1[4].watchlist_table, watchlist_table_authrep1[4].watchlist_record_number) AND NOT isAuthRep1Code32,DATASET([{1,'WL',Risk_Indicators.getHRIDesc('WL')}],Risk_Indicators.layouts.layout_desc_plus_seq)) &	
          IF(Risk_Indicators.rcSet.isCodeWL(watchlist_table_authrep1[5].watchlist_table, watchlist_table_authrep1[5].watchlist_record_number) AND NOT isAuthRep1Code32,DATASET([{1,'WL',Risk_Indicators.getHRIDesc('WL')}],Risk_Indicators.layouts.layout_desc_plus_seq)) &	
          IF(Risk_Indicators.rcSet.isCodeWL(watchlist_table_authrep1[6].watchlist_table, watchlist_table_authrep1[6].watchlist_record_number) AND NOT isAuthRep1Code32,DATASET([{1,'WL',Risk_Indicators.getHRIDesc('WL')}],Risk_Indicators.layouts.layout_desc_plus_seq)) &	
          IF(Risk_Indicators.rcSet.isCodeWL(watchlist_table_authrep1[7].watchlist_table, watchlist_table_authrep1[7].watchlist_record_number) AND NOT isAuthRep1Code32,DATASET([{1,'WL',Risk_Indicators.getHRIDesc('WL')}],Risk_Indicators.layouts.layout_desc_plus_seq)) ,	
        hri);
      SHARED riAuthRep2pre := DEDUP(
          IF(Risk_Indicators.rcSet.isCode32(watchlist_table_authrep2[1].watchlist_table, watchlist_table_authrep2[1].watchlist_record_number),DATASET([{1,'32',Risk_Indicators.getHRIDesc('32')}],Risk_Indicators.layouts.layout_desc_plus_seq)) &
          IF(Risk_Indicators.rcSet.isCode32(watchlist_table_authrep2[2].watchlist_table, watchlist_table_authrep2[2].watchlist_record_number),DATASET([{1,'32',Risk_Indicators.getHRIDesc('32')}],Risk_Indicators.layouts.layout_desc_plus_seq)) &
          IF(Risk_Indicators.rcSet.isCode32(watchlist_table_authrep2[3].watchlist_table, watchlist_table_authrep2[3].watchlist_record_number),DATASET([{1,'32',Risk_Indicators.getHRIDesc('32')}],Risk_Indicators.layouts.layout_desc_plus_seq)) &
          IF(Risk_Indicators.rcSet.isCode32(watchlist_table_authrep2[4].watchlist_table, watchlist_table_authrep2[4].watchlist_record_number),DATASET([{1,'32',Risk_Indicators.getHRIDesc('32')}],Risk_Indicators.layouts.layout_desc_plus_seq)) &
          IF(Risk_Indicators.rcSet.isCode32(watchlist_table_authrep2[5].watchlist_table, watchlist_table_authrep2[5].watchlist_record_number),DATASET([{1,'32',Risk_Indicators.getHRIDesc('32')}],Risk_Indicators.layouts.layout_desc_plus_seq)) &
          IF(Risk_Indicators.rcSet.isCode32(watchlist_table_authrep2[6].watchlist_table, watchlist_table_authrep2[6].watchlist_record_number),DATASET([{1,'32',Risk_Indicators.getHRIDesc('32')}],Risk_Indicators.layouts.layout_desc_plus_seq)) &
          IF(Risk_Indicators.rcSet.isCode32(watchlist_table_authrep2[7].watchlist_table, watchlist_table_authrep2[7].watchlist_record_number),DATASET([{1,'32',Risk_Indicators.getHRIDesc('32')}],Risk_Indicators.layouts.layout_desc_plus_seq)) &
          IF(Risk_Indicators.rcSet.isCodeWL(watchlist_table_authrep2[1].watchlist_table, watchlist_table_authrep2[1].watchlist_record_number) AND NOT isAuthRep2Code32,DATASET([{1,'WL',Risk_Indicators.getHRIDesc('WL')}],Risk_Indicators.layouts.layout_desc_plus_seq)) &	
          IF(Risk_Indicators.rcSet.isCodeWL(watchlist_table_authrep2[2].watchlist_table, watchlist_table_authrep2[2].watchlist_record_number) AND NOT isAuthRep2Code32,DATASET([{1,'WL',Risk_Indicators.getHRIDesc('WL')}],Risk_Indicators.layouts.layout_desc_plus_seq)) &	
          IF(Risk_Indicators.rcSet.isCodeWL(watchlist_table_authrep2[3].watchlist_table, watchlist_table_authrep2[3].watchlist_record_number) AND NOT isAuthRep2Code32,DATASET([{1,'WL',Risk_Indicators.getHRIDesc('WL')}],Risk_Indicators.layouts.layout_desc_plus_seq)) &	
          IF(Risk_Indicators.rcSet.isCodeWL(watchlist_table_authrep2[4].watchlist_table, watchlist_table_authrep2[4].watchlist_record_number) AND NOT isAuthRep2Code32,DATASET([{1,'WL',Risk_Indicators.getHRIDesc('WL')}],Risk_Indicators.layouts.layout_desc_plus_seq)) &	
          IF(Risk_Indicators.rcSet.isCodeWL(watchlist_table_authrep2[5].watchlist_table, watchlist_table_authrep2[5].watchlist_record_number) AND NOT isAuthRep2Code32,DATASET([{1,'WL',Risk_Indicators.getHRIDesc('WL')}],Risk_Indicators.layouts.layout_desc_plus_seq)) &	
          IF(Risk_Indicators.rcSet.isCodeWL(watchlist_table_authrep2[6].watchlist_table, watchlist_table_authrep2[6].watchlist_record_number) AND NOT isAuthRep2Code32,DATASET([{1,'WL',Risk_Indicators.getHRIDesc('WL')}],Risk_Indicators.layouts.layout_desc_plus_seq)) &	
          IF(Risk_Indicators.rcSet.isCodeWL(watchlist_table_authrep2[7].watchlist_table, watchlist_table_authrep2[7].watchlist_record_number) AND NOT isAuthRep2Code32,DATASET([{1,'WL',Risk_Indicators.getHRIDesc('WL')}],Risk_Indicators.layouts.layout_desc_plus_seq)) ,	
        hri);
      SHARED riAuthRep3pre := DEDUP(
          IF(Risk_Indicators.rcSet.isCode32(watchlist_table_authrep3[1].watchlist_table, watchlist_table_authrep3[1].watchlist_record_number),DATASET([{1,'32',Risk_Indicators.getHRIDesc('32')}],Risk_Indicators.layouts.layout_desc_plus_seq)) &
          IF(Risk_Indicators.rcSet.isCode32(watchlist_table_authrep3[2].watchlist_table, watchlist_table_authrep3[2].watchlist_record_number),DATASET([{1,'32',Risk_Indicators.getHRIDesc('32')}],Risk_Indicators.layouts.layout_desc_plus_seq)) &
          IF(Risk_Indicators.rcSet.isCode32(watchlist_table_authrep3[3].watchlist_table, watchlist_table_authrep3[3].watchlist_record_number),DATASET([{1,'32',Risk_Indicators.getHRIDesc('32')}],Risk_Indicators.layouts.layout_desc_plus_seq)) &
          IF(Risk_Indicators.rcSet.isCode32(watchlist_table_authrep3[4].watchlist_table, watchlist_table_authrep3[4].watchlist_record_number),DATASET([{1,'32',Risk_Indicators.getHRIDesc('32')}],Risk_Indicators.layouts.layout_desc_plus_seq)) &
          IF(Risk_Indicators.rcSet.isCode32(watchlist_table_authrep3[5].watchlist_table, watchlist_table_authrep3[5].watchlist_record_number),DATASET([{1,'32',Risk_Indicators.getHRIDesc('32')}],Risk_Indicators.layouts.layout_desc_plus_seq)) &
          IF(Risk_Indicators.rcSet.isCode32(watchlist_table_authrep3[6].watchlist_table, watchlist_table_authrep3[6].watchlist_record_number),DATASET([{1,'32',Risk_Indicators.getHRIDesc('32')}],Risk_Indicators.layouts.layout_desc_plus_seq)) &
          IF(Risk_Indicators.rcSet.isCode32(watchlist_table_authrep3[7].watchlist_table, watchlist_table_authrep3[7].watchlist_record_number),DATASET([{1,'32',Risk_Indicators.getHRIDesc('32')}],Risk_Indicators.layouts.layout_desc_plus_seq)) &
          IF(Risk_Indicators.rcSet.isCodeWL(watchlist_table_authrep3[1].watchlist_table, watchlist_table_authrep3[1].watchlist_record_number) AND NOT isAuthRep3Code32,DATASET([{1,'WL',Risk_Indicators.getHRIDesc('WL')}],Risk_Indicators.layouts.layout_desc_plus_seq)) &	
          IF(Risk_Indicators.rcSet.isCodeWL(watchlist_table_authrep3[2].watchlist_table, watchlist_table_authrep3[2].watchlist_record_number) AND NOT isAuthRep3Code32,DATASET([{1,'WL',Risk_Indicators.getHRIDesc('WL')}],Risk_Indicators.layouts.layout_desc_plus_seq)) &	
          IF(Risk_Indicators.rcSet.isCodeWL(watchlist_table_authrep3[3].watchlist_table, watchlist_table_authrep3[3].watchlist_record_number) AND NOT isAuthRep3Code32,DATASET([{1,'WL',Risk_Indicators.getHRIDesc('WL')}],Risk_Indicators.layouts.layout_desc_plus_seq)) &	
          IF(Risk_Indicators.rcSet.isCodeWL(watchlist_table_authrep3[4].watchlist_table, watchlist_table_authrep3[4].watchlist_record_number) AND NOT isAuthRep3Code32,DATASET([{1,'WL',Risk_Indicators.getHRIDesc('WL')}],Risk_Indicators.layouts.layout_desc_plus_seq)) &	
          IF(Risk_Indicators.rcSet.isCodeWL(watchlist_table_authrep3[5].watchlist_table, watchlist_table_authrep3[5].watchlist_record_number) AND NOT isAuthRep3Code32,DATASET([{1,'WL',Risk_Indicators.getHRIDesc('WL')}],Risk_Indicators.layouts.layout_desc_plus_seq)) &	
          IF(Risk_Indicators.rcSet.isCodeWL(watchlist_table_authrep3[6].watchlist_table, watchlist_table_authrep3[6].watchlist_record_number) AND NOT isAuthRep3Code32,DATASET([{1,'WL',Risk_Indicators.getHRIDesc('WL')}],Risk_Indicators.layouts.layout_desc_plus_seq)) &	
          IF(Risk_Indicators.rcSet.isCodeWL(watchlist_table_authrep3[7].watchlist_table, watchlist_table_authrep3[7].watchlist_record_number) AND NOT isAuthRep3Code32,DATASET([{1,'WL',Risk_Indicators.getHRIDesc('WL')}],Risk_Indicators.layouts.layout_desc_plus_seq)) ,	
        hri);
      SHARED riAuthRep4pre := DEDUP(
          IF(Risk_Indicators.rcSet.isCode32(watchlist_table_authrep4[1].watchlist_table, watchlist_table_authrep4[1].watchlist_record_number),DATASET([{1,'32',Risk_Indicators.getHRIDesc('32')}],Risk_Indicators.layouts.layout_desc_plus_seq)) &
          IF(Risk_Indicators.rcSet.isCode32(watchlist_table_authrep4[2].watchlist_table, watchlist_table_authrep4[2].watchlist_record_number),DATASET([{1,'32',Risk_Indicators.getHRIDesc('32')}],Risk_Indicators.layouts.layout_desc_plus_seq)) &
          IF(Risk_Indicators.rcSet.isCode32(watchlist_table_authrep4[3].watchlist_table, watchlist_table_authrep4[3].watchlist_record_number),DATASET([{1,'32',Risk_Indicators.getHRIDesc('32')}],Risk_Indicators.layouts.layout_desc_plus_seq)) &
          IF(Risk_Indicators.rcSet.isCode32(watchlist_table_authrep4[4].watchlist_table, watchlist_table_authrep4[4].watchlist_record_number),DATASET([{1,'32',Risk_Indicators.getHRIDesc('32')}],Risk_Indicators.layouts.layout_desc_plus_seq)) &
          IF(Risk_Indicators.rcSet.isCode32(watchlist_table_authrep4[5].watchlist_table, watchlist_table_authrep4[5].watchlist_record_number),DATASET([{1,'32',Risk_Indicators.getHRIDesc('32')}],Risk_Indicators.layouts.layout_desc_plus_seq)) &
          IF(Risk_Indicators.rcSet.isCode32(watchlist_table_authrep4[6].watchlist_table, watchlist_table_authrep4[6].watchlist_record_number),DATASET([{1,'32',Risk_Indicators.getHRIDesc('32')}],Risk_Indicators.layouts.layout_desc_plus_seq)) &
          IF(Risk_Indicators.rcSet.isCode32(watchlist_table_authrep4[7].watchlist_table, watchlist_table_authrep4[7].watchlist_record_number),DATASET([{1,'32',Risk_Indicators.getHRIDesc('32')}],Risk_Indicators.layouts.layout_desc_plus_seq)) &
          IF(Risk_Indicators.rcSet.isCodeWL(watchlist_table_authrep4[1].watchlist_table, watchlist_table_authrep4[1].watchlist_record_number) AND NOT isAuthRep4Code32,DATASET([{1,'WL',Risk_Indicators.getHRIDesc('WL')}],Risk_Indicators.layouts.layout_desc_plus_seq)) &	
          IF(Risk_Indicators.rcSet.isCodeWL(watchlist_table_authrep4[2].watchlist_table, watchlist_table_authrep4[2].watchlist_record_number) AND NOT isAuthRep4Code32,DATASET([{1,'WL',Risk_Indicators.getHRIDesc('WL')}],Risk_Indicators.layouts.layout_desc_plus_seq)) &	
          IF(Risk_Indicators.rcSet.isCodeWL(watchlist_table_authrep4[3].watchlist_table, watchlist_table_authrep4[3].watchlist_record_number) AND NOT isAuthRep4Code32,DATASET([{1,'WL',Risk_Indicators.getHRIDesc('WL')}],Risk_Indicators.layouts.layout_desc_plus_seq)) &	
          IF(Risk_Indicators.rcSet.isCodeWL(watchlist_table_authrep4[4].watchlist_table, watchlist_table_authrep4[4].watchlist_record_number) AND NOT isAuthRep4Code32,DATASET([{1,'WL',Risk_Indicators.getHRIDesc('WL')}],Risk_Indicators.layouts.layout_desc_plus_seq)) &	
          IF(Risk_Indicators.rcSet.isCodeWL(watchlist_table_authrep4[5].watchlist_table, watchlist_table_authrep4[5].watchlist_record_number) AND NOT isAuthRep4Code32,DATASET([{1,'WL',Risk_Indicators.getHRIDesc('WL')}],Risk_Indicators.layouts.layout_desc_plus_seq)) &	
          IF(Risk_Indicators.rcSet.isCodeWL(watchlist_table_authrep4[6].watchlist_table, watchlist_table_authrep4[6].watchlist_record_number) AND NOT isAuthRep4Code32,DATASET([{1,'WL',Risk_Indicators.getHRIDesc('WL')}],Risk_Indicators.layouts.layout_desc_plus_seq)) &	
          IF(Risk_Indicators.rcSet.isCodeWL(watchlist_table_authrep4[7].watchlist_table, watchlist_table_authrep4[7].watchlist_record_number) AND NOT isAuthRep4Code32,DATASET([{1,'WL',Risk_Indicators.getHRIDesc('WL')}],Risk_Indicators.layouts.layout_desc_plus_seq)) ,	
        hri);
      SHARED riAuthRep5pre := DEDUP(
          IF(Risk_Indicators.rcSet.isCode32(watchlist_table_authrep5[1].watchlist_table, watchlist_table_authrep5[1].watchlist_record_number),DATASET([{1,'32',Risk_Indicators.getHRIDesc('32')}],Risk_Indicators.layouts.layout_desc_plus_seq)) &
          IF(Risk_Indicators.rcSet.isCode32(watchlist_table_authrep5[2].watchlist_table, watchlist_table_authrep5[2].watchlist_record_number),DATASET([{1,'32',Risk_Indicators.getHRIDesc('32')}],Risk_Indicators.layouts.layout_desc_plus_seq)) &
          IF(Risk_Indicators.rcSet.isCode32(watchlist_table_authrep5[3].watchlist_table, watchlist_table_authrep5[3].watchlist_record_number),DATASET([{1,'32',Risk_Indicators.getHRIDesc('32')}],Risk_Indicators.layouts.layout_desc_plus_seq)) &
          IF(Risk_Indicators.rcSet.isCode32(watchlist_table_authrep5[4].watchlist_table, watchlist_table_authrep5[4].watchlist_record_number),DATASET([{1,'32',Risk_Indicators.getHRIDesc('32')}],Risk_Indicators.layouts.layout_desc_plus_seq)) &
          IF(Risk_Indicators.rcSet.isCode32(watchlist_table_authrep5[5].watchlist_table, watchlist_table_authrep5[5].watchlist_record_number),DATASET([{1,'32',Risk_Indicators.getHRIDesc('32')}],Risk_Indicators.layouts.layout_desc_plus_seq)) &
          IF(Risk_Indicators.rcSet.isCode32(watchlist_table_authrep5[6].watchlist_table, watchlist_table_authrep5[6].watchlist_record_number),DATASET([{1,'32',Risk_Indicators.getHRIDesc('32')}],Risk_Indicators.layouts.layout_desc_plus_seq)) &
          IF(Risk_Indicators.rcSet.isCode32(watchlist_table_authrep5[7].watchlist_table, watchlist_table_authrep5[7].watchlist_record_number),DATASET([{1,'32',Risk_Indicators.getHRIDesc('32')}],Risk_Indicators.layouts.layout_desc_plus_seq)) &
          IF(Risk_Indicators.rcSet.isCodeWL(watchlist_table_authrep5[1].watchlist_table, watchlist_table_authrep5[1].watchlist_record_number) AND NOT isAuthRep5Code32,DATASET([{1,'WL',Risk_Indicators.getHRIDesc('WL')}],Risk_Indicators.layouts.layout_desc_plus_seq)) &	
          IF(Risk_Indicators.rcSet.isCodeWL(watchlist_table_authrep5[2].watchlist_table, watchlist_table_authrep5[2].watchlist_record_number) AND NOT isAuthRep5Code32,DATASET([{1,'WL',Risk_Indicators.getHRIDesc('WL')}],Risk_Indicators.layouts.layout_desc_plus_seq)) &	
          IF(Risk_Indicators.rcSet.isCodeWL(watchlist_table_authrep5[3].watchlist_table, watchlist_table_authrep5[3].watchlist_record_number) AND NOT isAuthRep5Code32,DATASET([{1,'WL',Risk_Indicators.getHRIDesc('WL')}],Risk_Indicators.layouts.layout_desc_plus_seq)) &	
          IF(Risk_Indicators.rcSet.isCodeWL(watchlist_table_authrep5[4].watchlist_table, watchlist_table_authrep5[4].watchlist_record_number) AND NOT isAuthRep5Code32,DATASET([{1,'WL',Risk_Indicators.getHRIDesc('WL')}],Risk_Indicators.layouts.layout_desc_plus_seq)) &	
          IF(Risk_Indicators.rcSet.isCodeWL(watchlist_table_authrep5[5].watchlist_table, watchlist_table_authrep5[5].watchlist_record_number) AND NOT isAuthRep5Code32,DATASET([{1,'WL',Risk_Indicators.getHRIDesc('WL')}],Risk_Indicators.layouts.layout_desc_plus_seq)) &	
          IF(Risk_Indicators.rcSet.isCodeWL(watchlist_table_authrep5[6].watchlist_table, watchlist_table_authrep5[6].watchlist_record_number) AND NOT isAuthRep5Code32,DATASET([{1,'WL',Risk_Indicators.getHRIDesc('WL')}],Risk_Indicators.layouts.layout_desc_plus_seq)) &	
          IF(Risk_Indicators.rcSet.isCodeWL(watchlist_table_authrep5[7].watchlist_table, watchlist_table_authrep5[7].watchlist_record_number) AND NOT isAuthRep5Code32,DATASET([{1,'WL',Risk_Indicators.getHRIDesc('WL')}],Risk_Indicators.layouts.layout_desc_plus_seq)) ,	
        hri);
			SHARED rcOrderLayout := RECORD
        INTEGER rcOrder, 
        STRING2 hri
      END;
      // Order copied from Risk_Indicators.reasonCodes
      SHARED rcOrder := DATASET([
                    {1,'32'},{2,'PO'},{3,'DI'},{4,'02'},{5,'03'},{6,'PO'},{7,'CA'},{8,'PA'},{9,'50'},{10,'06'},
                    {11,'IS'},{12,'EI'},{13,'IT'},{14,'WL'},{15,'19'},{16,'51'},{17,'66'},{18,'71'},{19,'72'},{20,'04'},
                    {21,'MI'},{22,'MS'},{23,'CL'},{24,'38'},{25,'37'},{26,'25'},{27,'26'},{28,'29'},{29,'27'},{30,'ZI'},
                    {31,'DV'},{32,'77'},{33,'79'},{34,'31'},{35,'78'},{36,'SR'},{37,'CZ'},{38,'SD'},{39,'48'},{40,'28'},
                    {41,'NB'},{42,'52'},{43,'07'},{44,'08'},{45,'11'},{46,'41'},{47,'12'},{48,'14'},{49,'VA'},{50,'15'},
                    {51,'75'},{52,'09'},{53,'10'},{54,'16'},{55,'40'},{56,'CO'},{57,'MO'},{58,'82'},{59,'DD'},{60,'64'},
                    {61,'81'},{62,'RS'},{63,'39'},{64,'85'},{65,'89'},{66,'90'},{67,'NF'},{68,'49'},{69,'53'},{70,'44'},
                    {71,'55'},{72,'56'},{73,'57'},{74,'46'},{75,'76'},{76,'30'},{77,'80'},{78,'83'},{79,'DM'},{80,'DF'}
                    ], rcOrderLayout);	        
        
      SHARED riAuthRep1combined := JOIN(
        (ri+riAuthRep1pre), rcOrder,
        LEFT.hri = RIGHT.hri,
        TRANSFORM( risk_indicators.layouts.layout_desc_plus_seq,
          SELF.seq := RIGHT.rcOrder,
          SELF := LEFT,
          SELF := []
        ),
        INNER, KEEP(1), ATMOST(100), PARALLEL, FEW);
      SHARED riAuthRep2combined := JOIN(
        (ri+riAuthRep2pre), rcOrder,
        LEFT.hri = RIGHT.hri,
        TRANSFORM( risk_indicators.layouts.layout_desc_plus_seq,
          SELF.seq := RIGHT.rcOrder,
          SELF := LEFT,
          SELF := []
        ),
        INNER, KEEP(1), ATMOST(100), PARALLEL, FEW);
      SHARED riAuthRep3combined := JOIN(
        (ri+riAuthRep3pre), rcOrder,
        LEFT.hri = RIGHT.hri,
        TRANSFORM( risk_indicators.layouts.layout_desc_plus_seq,
          SELF.seq := RIGHT.rcOrder,
          SELF := LEFT,
          SELF := []
        ),
        INNER, KEEP(1), ATMOST(100), PARALLEL, FEW);
      SHARED riAuthRep4combined := JOIN(
        (ri+riAuthRep4pre), rcOrder,
        LEFT.hri = RIGHT.hri,
        TRANSFORM( risk_indicators.layouts.layout_desc_plus_seq,
          SELF.seq := RIGHT.rcOrder,
          SELF := LEFT,
          SELF := []
        ),
        INNER, KEEP(1), ATMOST(100), PARALLEL, FEW);
      SHARED riAuthRep5combined := JOIN(
        (ri+riAuthRep5pre), rcOrder,
        LEFT.hri = RIGHT.hri,
        TRANSFORM( risk_indicators.layouts.layout_desc_plus_seq,
          SELF.seq := RIGHT.rcOrder,
          SELF := LEFT,
          SELF := []
        ),
        INNER, KEEP(1), ATMOST(100), PARALLEL, FEW);  
      
      SHARED riAuthRep1sorted := PROJECT(DEDUP(SORT(riAuthRep1combined, (integer)seq),seq,hri,desc),TRANSFORM(risk_indicators.layout_desc, SELF := LEFT));
      risk_indicators.mac_add_sequence(riAuthRep1sorted, riAuthRep1seq);
      SHARED riAuthRep1 := CHOOSEN(DEDUP(riAuthRep1seq,seq,hri,desc),cnt);
      SHARED riAuthRep2sorted := PROJECT(DEDUP(SORT(riAuthRep2combined, (integer)seq),seq,hri,desc),TRANSFORM(risk_indicators.layout_desc, SELF := LEFT));
      risk_indicators.mac_add_sequence(riAuthRep2sorted, riAuthRep2seq);
      SHARED riAuthRep2 := CHOOSEN(DEDUP(riAuthRep2seq,seq,hri,desc),cnt);
      SHARED riAuthRep3sorted := PROJECT(DEDUP(SORT(riAuthRep3combined, (integer)seq),seq,hri,desc),TRANSFORM(risk_indicators.layout_desc, SELF := LEFT));
      risk_indicators.mac_add_sequence(riAuthRep3sorted, riAuthRep3seq);
      SHARED riAuthRep3 := CHOOSEN(DEDUP(riAuthRep3seq,seq,hri,desc),cnt);
      SHARED riAuthRep4sorted := PROJECT(DEDUP(SORT(riAuthRep4combined, (integer)seq),seq,hri,desc),TRANSFORM(risk_indicators.layout_desc, SELF := LEFT));
      risk_indicators.mac_add_sequence(riAuthRep4sorted, riAuthRep4seq);
      SHARED riAuthRep4 := CHOOSEN(DEDUP(riAuthRep4seq,seq,hri,desc),cnt);
      SHARED riAuthRep5sorted := PROJECT(DEDUP(SORT(riAuthRep5combined, (integer)seq),seq,hri,desc),TRANSFORM(risk_indicators.layout_desc, SELF := LEFT));
      risk_indicators.mac_add_sequence(riAuthRep5sorted, riAuthRep5seq);
      SHARED riAuthRep5 := CHOOSEN(DEDUP(riAuthRep5seq,seq,hri,desc),cnt);
      
      EXPORT riAuthRep  := CASE(Rep_Whichone,
                               '1' => riAuthRep1,
                               '2' => riAuthRep2,
                               '3' => riAuthRep3,
                               '4' => riAuthRep4,
                               '5' => riAuthRep5,
                                      DATASET([],Risk_Indicators.layouts.layout_desc_plus_seq));
      SHARED fuaAuthRep1 := CHOOSEN(DEDUP(SORT(IF(Options.include_ofac AND EXISTS(riAuthRep1(hri='32')),
                                      DATASET([{'A',risk_indicators.getFUADesc('A')}],risk_indicators.Layout_Desc)) &
                                    IF(Options.include_additional_watchlists AND EXISTS(riAuthRep1(hri='WL')),
                                      DATASET([{'E',risk_indicators.getFUADesc('E')}],risk_indicators.Layout_Desc)) & fua,hri,desc),hri),cnt);
      SHARED fuaAuthRep2 := CHOOSEN(DEDUP(SORT(IF(Options.include_ofac AND EXISTS(riAuthRep2(hri='32')),
                                      DATASET([{'A',risk_indicators.getFUADesc('A')}],risk_indicators.Layout_Desc)) &
                                    IF(Options.include_additional_watchlists AND EXISTS(riAuthRep2(hri='WL')),
                                      DATASET([{'E',risk_indicators.getFUADesc('E')}],risk_indicators.Layout_Desc))& fua,hri,desc),hri),cnt);
      SHARED fuaAuthRep3 := CHOOSEN(DEDUP(SORT(IF(Options.include_ofac AND EXISTS(riAuthRep3(hri='32')),
                                      DATASET([{'A',risk_indicators.getFUADesc('A')}],risk_indicators.Layout_Desc)) &
                                    IF(Options.include_additional_watchlists AND EXISTS(riAuthRep3(hri='WL')),
                                      DATASET([{'E',risk_indicators.getFUADesc('E')}],risk_indicators.Layout_Desc))& fua,hri,desc),hri),cnt);
      SHARED fuaAuthRep4 := CHOOSEN(DEDUP(SORT(IF(Options.include_ofac AND EXISTS(riAuthRep4(hri='32')),
                                      DATASET([{'A',risk_indicators.getFUADesc('A')}],risk_indicators.Layout_Desc)) &
                                    IF(Options.include_additional_watchlists AND EXISTS(riAuthRep4(hri='WL')),
                                      DATASET([{'E',risk_indicators.getFUADesc('E')}],risk_indicators.Layout_Desc))& fua,hri,desc),hri),cnt);
      SHARED fuaAuthRep5 := CHOOSEN(DEDUP(SORT(IF(Options.include_ofac AND EXISTS(riAuthRep5(hri='32')),
                                      DATASET([{'A',risk_indicators.getFUADesc('A')}],risk_indicators.Layout_Desc)) &
                                    IF(Options.include_additional_watchlists AND EXISTS(riAuthRep5(hri='WL')),
                                      DATASET([{'E',risk_indicators.getFUADesc('E')}],risk_indicators.Layout_Desc))& fua,hri,desc),hri),cnt);   
      EXPORT fuaAuthRep  := CASE(Rep_Whichone,
                               '1' => fuaAuthRep1,
                               '2' => fuaAuthRep2,
                               '3' => fuaAuthRep3,
                               '4' => fuaAuthRep4,
                               '5' => fuaAuthRep5,
                                      DATASET([],risk_indicators.Layout_Desc));
    END;