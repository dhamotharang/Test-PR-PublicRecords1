IMPORT $,BIPV2,Business_Credit,Business_Credit_Scoring,BusinessCredit_Services;

EXPORT Batch_Functions := MODULE

  // Function to get tradeline (payment history info)
	EXPORT getTradelineInfo(DATASET(RECORDOF(Business_Credit.Key_LinkIds().kFetch2(dataset([],BIPV2.IDlayouts.l_xlink_ids2)))) inAcctRecs,
                          BusinessCredit_Services.Iparam.BatchParams inMod) := FUNCTION
				
    // See JIRA RR-19879 - SBFE changed the definition of their seven Past Due Aging Amount Buckets from days past due to payments past due
    // the following conversion will be moved to the data layer and this can be pulled back out.
    // Had to add an extra join here because the original join combined buckets 5-7 and the following conversion must
    // happen before that transform.
    TradeRecs_Raw := 
      JOIN(inAcctRecs,Business_Credit.key_tradeline(), 
           BusinessCredit_Services.Macros.mac_JoinBusAccounts(),
           TRANSFORM(BusinessCredit_Services.Batch_layouts.TradelineInfo,
             mod := $.ConvertPastDueAmounts();
				     needConversion := mod.checkConversionNeeded(RIGHT, $.Constants.SBFE_V5_LAYOUT_CHANGE_DATE);
             SELF.UltID := LEFT.UltID,
             SELF.OrgID := IF(inmod.BIPFetchLevel IN BIPV2.IDconstants.Set_Fetch_Level_OrgID_And_Down,  LEFT.OrgID, 0),
             SELF.SeleID := IF(inmod.BIPFetchLevel IN BIPV2.IDconstants.Set_Fetch_Level_SELEID_And_Down, LEFT.SeleID, 0),
             SELF.ProxID := IF(inmod.BIPFetchLevel IN BIPV2.IDconstants.Set_Fetch_Level_ProxID_And_Down, LEFT.ProxID, 0),
             SELF.EmpID := 0,  // Not used/needed
             SELF.POWID := 0,  // Not used/needed
             SELF.Account_Closure_Basis := BusinessCredit_Services.Functions.fn_AccountClosureReason(RIGHT.Account_Closure_Basis);
             SELF.Past_Due_Amount_01to30 := (STRING) (100 * (INTEGER) (IF(needConversion,
				                                                                  mod.convertBucket1(RIGHT), 
																									                        RIGHT.Past_Due_Aging_Amount_Bucket_1)));
             SELF.Past_Due_Amount_31to60 := (STRING) (100 * (INTEGER) (IF(needConversion,
				                                                                  mod.convertBucket2(RIGHT), 
																									                        RIGHT.Past_Due_Aging_Amount_Bucket_2)));
             SELF.Past_Due_Amount_61to90 := (STRING) (100 * (INTEGER) (IF(needConversion,
				                                                                  mod.convertBucket3(RIGHT), 
																									                        RIGHT.Past_Due_Aging_Amount_Bucket_3)));
             SELF.Past_Due_Amount_91to120 := (STRING) (100 * (INTEGER) (IF(needConversion,
				                                                                   mod.convertBucket4(RIGHT), 
																									                         RIGHT.Past_Due_Aging_Amount_Bucket_4)));
             SELF.Past_Due_Amount_120Plus := (STRING) ((100 * (INTEGER) (IF(needConversion,
				                                                                    mod.convertBucket5(RIGHT), 
																									                          RIGHT.Past_Due_Aging_Amount_Bucket_5))) +
                                                     + (100 * (INTEGER) (IF(needConversion,
				                                                                    mod.convertBucket6(RIGHT), 
																									                          RIGHT.Past_Due_Aging_Amount_Bucket_6))) +
                                                     + (100 * (INTEGER) (IF(needConversion,
				                                                                    mod.convertBucket7(RIGHT), 
																									                          RIGHT.Past_Due_Aging_Amount_Bucket_7))));
             SELF := RIGHT,
             SELF := []),
           LIMIT(BusinessCredit_Services.Constants.KFETCH_MAX_LIMIT, SKIP));
				
				// Dedup and keep lastest trade record
				TradeRecs_dedup := DEDUP(SORT(TradeRecs_Raw,#EXPAND(BusinessCredit_Services.Macros.mac_ListBusAccounts()),-cycle_end_date,RECORD),#EXPAND(BusinessCredit_Services.Macros.mac_ListBusAccounts()));
	     
				RETURN(TradeRecs_dedup);
		END;
		
		// Function to return the last 5 historical crecit scores
		EXPORT getCreditScore(DATASET(BIPV2.IDlayouts.l_xlink_ids2) inBusRecs,
																BusinessCredit_Services.Iparam.BatchParams inMod) := FUNCTION
				
    ScoringRecs := Business_Credit_Scoring.Key_ScoringIndex().kFetch2(inBusRecs,inmod.BIPFetchLevel,,inmod.DataPermissionMask,BusinessCredit_Services.Constants.JOIN_LIMIT);
					
    ScoreRecLayout := RECORDOF(ScoringRecs);
				
    ScoringRecsMask := 
      PROJECT(ScoringRecs,
        TRANSFORM(ScoreRecLayout,
          SELF.UltID := LEFT.UltID,
          SELF.OrgID := IF(inmod.BIPFetchLevel IN BIPV2.IDconstants.Set_Fetch_Level_OrgID_And_Down,  LEFT.OrgID, 0),
          SELF.SeleID := IF(inmod.BIPFetchLevel IN BIPV2.IDconstants.Set_Fetch_Level_SELEID_And_Down, LEFT.SeleID, 0),
          SELF.ProxID := IF(inmod.BIPFetchLevel IN BIPV2.IDconstants.Set_Fetch_Level_ProxID_And_Down, LEFT.ProxID, 0),
          SELF.EmpID := 0,  // Not used/needed
          SELF.POWID := 0,  // Not used/needed
          SELF := LEFT));
																			
    ScoringRecsSorted := GROUP(SORT(ScoringRecsMask,#EXPAND(BIPV2.IDmacros.mac_ListAllLinkids()),-date_scored,RECORD),#EXPAND(BIPV2.IDmacros.mac_ListAllLinkids()));
			
    // Function to flatten scores into one record per linkids
    BusinessCredit_Services.Batch_layouts.CreditScoreInfoLinkid roll_scores(ScoreRecLayout l, DATASET(ScoreRecLayout) allRows) := TRANSFORM
      SELF.score1_date_scored := l.date_scored;
      SELF.score1_Score := l.scores[1].score;
      SELF.score1_1_reasoncode := l.scores[1].scorereasons[1].reasoncode;
      SELF.score1_1_description := l.scores[1].scorereasons[1].description;
      SELF.score1_2_reasoncode := l.scores[1].scorereasons[2].reasoncode;
      SELF.score1_2_description := l.scores[1].scorereasons[2].description;
      SELF.score1_3_reasoncode := l.scores[1].scorereasons[3].reasoncode;
      SELF.score1_3_description := l.scores[1].scorereasons[3].description;
      SELF.score1_4_reasoncode := l.scores[1].scorereasons[4].reasoncode;
      SELF.score1_4_description := l.scores[1].scorereasons[4].description;
      SELF.score1_5_reasoncode := l.scores[1].scorereasons[5].reasoncode;
      SELF.score1_5_description := l.scores[1].scorereasons[5].description;
      SELF.score1_6_reasoncode := l.scores[1].scorereasons[6].reasoncode;
      SELF.score1_6_description := l.scores[1].scorereasons[6].description;
      SELF.score2_date_scored := allRows[2].date_scored;
      SELF.score2_Score := allRows[2].scores[1].score;
      SELF.score2_1_reasoncode := allRows[2].scores[1].scorereasons[1].reasoncode;
      SELF.score2_1_description := allRows[2].scores[1].scorereasons[1].description;
      SELF.score2_2_reasoncode := allRows[2].scores[1].scorereasons[2].reasoncode;
      SELF.score2_2_description := allRows[2].scores[1].scorereasons[2].description;
      SELF.score2_3_reasoncode := allRows[2].scores[1].scorereasons[3].reasoncode;
      SELF.score2_3_description := allRows[2].scores[1].scorereasons[3].description;
      SELF.score2_4_reasoncode := allRows[2].scores[1].scorereasons[4].reasoncode;
      SELF.score2_4_description := allRows[2].scores[1].scorereasons[4].description;
      SELF.score2_5_reasoncode := allRows[2].scores[1].scorereasons[5].reasoncode;
      SELF.score2_5_description := allRows[2].scores[1].scorereasons[5].description;
      SELF.score2_6_reasoncode := allRows[2].scores[1].scorereasons[6].reasoncode;
      SELF.score2_6_description := allRows[2].scores[1].scorereasons[6].description;
      SELF.score3_date_scored := allRows[3].date_scored;
      SELF.score3_Score := allRows[3].scores[1].score;
      SELF.score3_1_reasoncode := allRows[3].scores[1].scorereasons[1].reasoncode;
      SELF.score3_1_description := allRows[3].scores[1].scorereasons[1].description;
      SELF.score3_2_reasoncode := allRows[3].scores[1].scorereasons[2].reasoncode;
      SELF.score3_2_description := allRows[3].scores[1].scorereasons[2].description;
      SELF.score3_3_reasoncode := allRows[3].scores[1].scorereasons[3].reasoncode;
      SELF.score3_3_description := allRows[3].scores[1].scorereasons[3].description;
      SELF.score3_4_reasoncode := allRows[3].scores[1].scorereasons[4].reasoncode;
      SELF.score3_4_description := allRows[3].scores[1].scorereasons[4].description;
      SELF.score3_5_reasoncode := allRows[3].scores[1].scorereasons[5].reasoncode;
      SELF.score3_5_description := allRows[3].scores[1].scorereasons[5].description;
      SELF.score3_6_reasoncode := allRows[3].scores[1].scorereasons[6].reasoncode;
      SELF.score3_6_description := allRows[3].scores[1].scorereasons[6].description;
      SELF.score4_date_scored := allRows[4].date_scored;
      SELF.score4_Score := allRows[4].scores[1].score;
      SELF.score4_1_reasoncode := allRows[4].scores[1].scorereasons[1].reasoncode;
      SELF.score4_1_description := allRows[4].scores[1].scorereasons[1].description;
      SELF.score4_2_reasoncode := allRows[4].scores[1].scorereasons[2].reasoncode;
      SELF.score4_2_description := allRows[4].scores[1].scorereasons[2].description;
      SELF.score4_3_reasoncode := allRows[4].scores[1].scorereasons[3].reasoncode;
      SELF.score4_3_description := allRows[4].scores[1].scorereasons[3].description;
      SELF.score4_4_reasoncode := allRows[4].scores[1].scorereasons[4].reasoncode;
      SELF.score4_4_description := allRows[4].scores[1].scorereasons[4].description;
      SELF.score4_5_reasoncode := allRows[4].scores[1].scorereasons[5].reasoncode;
      SELF.score4_5_description := allRows[4].scores[1].scorereasons[5].description;
      SELF.score4_6_reasoncode := allRows[4].scores[1].scorereasons[6].reasoncode;
      SELF.score4_6_description := allRows[4].scores[1].scorereasons[6].description;
      SELF.score5_date_scored := allRows[5].date_scored;
      SELF.score5_Score := allRows[5].scores[1].score;
      SELF.score5_1_reasoncode := allRows[5].scores[1].scorereasons[1].reasoncode;
      SELF.score5_1_description := allRows[5].scores[1].scorereasons[1].description;
      SELF.score5_2_reasoncode := allRows[5].scores[1].scorereasons[2].reasoncode;
      SELF.score5_2_description := allRows[5].scores[1].scorereasons[2].description;
      SELF.score5_3_reasoncode := allRows[5].scores[1].scorereasons[3].reasoncode;
      SELF.score5_3_description := allRows[5].scores[1].scorereasons[3].description;
      SELF.score5_4_reasoncode := allRows[5].scores[1].scorereasons[4].reasoncode;
      SELF.score5_4_description := allRows[5].scores[1].scorereasons[4].description;
      SELF.score5_5_reasoncode := allRows[5].scores[1].scorereasons[5].reasoncode;
      SELF.score5_5_description := allRows[5].scores[1].scorereasons[5].description;
      SELF.score5_6_reasoncode := allRows[5].scores[1].scorereasons[6].reasoncode;
      SELF.score5_6_description := allRows[5].scores[1].scorereasons[6].description;
      SELF := l;
    END;
				
    ScoringRecsRolled := ROLLUP(ScoringRecsSorted,GROUP,roll_scores(LEFT,ROWS(LEFT)));
				
    RETURN(ScoringRecsRolled);
  END;
		
END;