IMPORT BatchShare, BIPV2, BIPV2_Best_SBFE;

EXPORT Batch_layouts := MODULE
		EXPORT Batch_Input := RECORD
				BatchShare.Layouts.ShareAcct;
				BIPV2.IDlayouts.l_key_ids_bare;
				STRING120 comp_name;
				BatchShare.Layouts.ShareAddress - [addr];
				STRING3   mileradius;
				STRING16  workphone;
				STRING9   fein;	
		END;
		
		EXPORT Batch_Input_Processed := RECORD(Batch_Input)
				STRING20 orig_acctno := '';
				Batchshare.Layouts.ShareErrors;	
		END;
		
		EXPORT LinkIdsWithAcctNo :=	RECORD
			BatchShare.Layouts.ShareAcct;
			BIPV2.IDlayouts.l_header_ids;
		END;
		
		// Common layout for SBFE best and Bus header best, SBFE best contains all bus header best fields.
		EXPORT BestKeyComb := RECORD(RECORDOF(BIPV2_Best_SBFE.Key_LinkIds().kFetch2(DATASET([],BIPV2.IDlayouts.l_xlink_ids2))))
      UNSIGNED1	source;
    END;
		
		EXPORT BestCompInfo := RECORD
			INTEGER2  weight;
			STRING120 best_company_name;
			STRING10  best_prim_range;
			STRING2   best_predir;
			STRING28  best_prim_name;
			STRING4   best_addr_suffix;
			STRING2   best_postdir;
			STRING10  best_unit_desig;
			STRING8   best_sec_range;
			STRING25  best_city;
			STRING2   best_state;
			STRING5   best_zip;
			STRING4   best_zip4;
			STRING20  best_County;
			UNSIGNED4 best_dt_first_seen;
			UNSIGNED4 best_dt_last_seen;
			STRING10  best_phone;		
			STRING9   best_fein;
			STRING8   best_sic_code;
			STRING80  best_SIC_Description;
			STRING10  best_naics_code;
			STRING120 best_NAICS_DESCRIPTION;
			STRING50  url;
			STRING50  email;
		END;
		
		EXPORT CreditScoreInfo := RECORD
				BIPV2.IDlayouts.l_key_ids_bare;
				STRING8		score1_date_scored;
				UNSIGNED2	score1_Score;
				STRING5		score1_1_reasoncode;
				STRING150	score1_1_description;
				STRING5		score1_2_reasoncode;
				STRING150	score1_2_description;
				STRING5		score1_3_reasoncode;
				STRING150	score1_3_description;
				STRING5		score1_4_reasoncode;
				STRING150	score1_4_description;
				STRING5		score1_5_reasoncode;
				STRING150	score1_5_description;
				STRING5		score1_6_reasoncode;
				STRING150	score1_6_description;
				STRING8		score2_date_scored;
				UNSIGNED2	score2_Score;
				STRING5		score2_1_reasoncode;
				STRING150	score2_1_description;
				STRING5		score2_2_reasoncode;
				STRING150	score2_2_description;
				STRING5		score2_3_reasoncode;
				STRING150	score2_3_description;
				STRING5		score2_4_reasoncode;
				STRING150	score2_4_description;
				STRING5		score2_5_reasoncode;
				STRING150	score2_5_description;
				STRING5		score2_6_reasoncode;
				STRING150	score2_6_description;
				STRING8		score3_date_scored;
				UNSIGNED2	score3_Score;
				STRING5		score3_1_reasoncode;
				STRING150	score3_1_description;
				STRING5		score3_2_reasoncode;
				STRING150	score3_2_description;
				STRING5		score3_3_reasoncode;
				STRING150	score3_3_description;
				STRING5		score3_4_reasoncode;
				STRING150	score3_4_description;
				STRING5		score3_5_reasoncode;
				STRING150	score3_5_description;
				STRING5		score3_6_reasoncode;
				STRING150	score3_6_description;
				STRING8		score4_date_scored;
				UNSIGNED2	score4_Score;
				STRING5		score4_1_reasoncode;
				STRING150	score4_1_description;
				STRING5		score4_2_reasoncode;
				STRING150	score4_2_description;
				STRING5		score4_3_reasoncode;
				STRING150	score4_3_description;
				STRING5		score4_4_reasoncode;
				STRING150	score4_4_description;
				STRING5		score4_5_reasoncode;
				STRING150	score4_5_description;
				STRING5		score4_6_reasoncode;
				STRING150	score4_6_description;
				STRING8		score5_date_scored;
				UNSIGNED2	score5_Score;
				STRING5		score5_1_reasoncode;
				STRING150	score5_1_description;
				STRING5		score5_2_reasoncode;
				STRING150	score5_2_description;
				STRING5		score5_3_reasoncode;
				STRING150	score5_3_description;
				STRING5		score5_4_reasoncode;
				STRING150	score5_4_description;
				STRING5		score5_5_reasoncode;
				STRING150	score5_5_description;
				STRING5		score5_6_reasoncode;
				STRING150	score5_6_description;
		END;
		
		EXPORT CreditScoreInfoLinkid := RECORD
				BIPV2.IDlayouts.l_key_ids_bare;
				CreditScoreInfo;
		END;
		
		EXPORT TradelineInfo := RECORD
				BIPV2.IDlayouts.l_key_ids_bare;
				STRING30  Sbfe_Contributor_Number;
				STRING50  Contract_Account_Number;
				STRING3   Account_Type_Reported;
				STRING12  Current_Credit_Limit;
				STRING12  Remaining_Balance;
				STRING8   Date_Account_Opened;
				STRING8   Date_Account_Closed;
				STRING3   Account_Status_1;
				STRING3   Account_Status_2;
				STRING12  Amount_Charged_Off_By_Creditor;
				STRING8   Date_Account_Was_Charged_Off;
				STRING75  Account_Closure_Basis;  
				STRING15  Past_Due_Amount_01to30;
				STRING15  Past_Due_Amount_31to60;
				STRING15  Past_Due_Amount_61to90;
				STRING15  Past_Due_Amount_91to120;
				STRING15  Past_Due_Amount_120Plus;
				STRING8   Cycle_End_Date;
		END;
		
		EXPORT 	BipSlim_layout := RECORD
				STRING20  acctno;
				BIPV2.IDlayouts.l_xlink_ids;
				STRING120 company_name;
				UNSIGNED2 company_name_data_permits;
				UNSIGNED1 company_name_method;
				UNSIGNED4 dt_first_seen;
				UNSIGNED4 dt_last_seen;
				INTEGER2 weight;
				BOOLEAN DNBDMIRecordOnly;
		end;
	
		EXPORT Batch_Output := RECORD
				STRING20  acctno;
				BIPV2.IDlayouts.l_key_ids_bare;
				BestCompInfo;
				TradelineInfo;
				CreditScoreInfo;
				UNSIGNED6 orig_ultid;
				UNSIGNED6 orig_orgid;
				UNSIGNED6 orig_seleid;
				UNSIGNED6 orig_proxid;
        UNSIGNED1	source;
		END;
		
		EXPORT Batch_Output_Final := RECORD
				Batch_Output - [orig_ultid, orig_orgid, orig_seleid, orig_proxid, source];
				Batchshare.Layouts.ShareErrors;
		END;
END;