﻿IMPORT BatchShare, CriminalRecords_BatchService, DeathV2_Services,FraudShared, FraudShared_Services, patriot, risk_indicators, riskwise;

EXPORT Layouts := MODULE

	EXPORT Velocities := RECORD
			BatchShare.Layouts.ShareAcct;
			INTEGER foundCnt;
			STRING description;
			DATASET(FraudShared.Layouts_Key.Main) ds_payload;
	END;

	EXPORT KnownFrauds_rec := RECORD
			BatchShare.Layouts.ShareAcct;
			DATASET(FraudShared_Services.Layouts.Raw_Payload_rec) payload;
	END;

	EXPORT BatchOut_risk := RECORD
			unsigned2 risk_score := 0;	// 0 - 100
			string6   risk_level := '';	// High, Medium, Low
			string1   identity_resolved := '';	// Y or N
			unsigned6 LexID := 0;
	END;

	EXPORT combined_layouts := RECORD
			UNSIGNED seq;
			riskwise.layouts.red_flags_online_layout;
			riskwise.layouts.red_flags_batch_layout;
	END;	

	EXPORT BatchOut_rec := RECORD // This is Final Batch Output. 
			UNSIGNED4 seq; 
			BatchShare.Layouts.ShareAcct;              
			BatchOut_risk;
			UNSIGNED4 identity_activities_cnt := 0;
			UNSIGNED2 velocity_exceeded_cnt := 0;
			STRING100 velocity_exceeded_reason1;
			STRING100 velocity_exceeded_reason2;
			STRING100 velocity_exceeded_reason3;

			UNSIGNED4 known_risks_cnt := 0;            
			STRING100 known_risk_reason1 := '';
			STRING100 known_risk_reason2 := '';
			STRING100 known_risk_reason3 := '';
			STRING100 Known_risk_reason4 := '';
			STRING100 Known_risk_reason5 := '';				
	END;

	SHARED Batch_out_pre_rec := RECORD
			BatchOut_risk;    
			BatchShare.Layouts.ShareAcct;
			FraudShared_Services.Layouts.BatchIn_rec batchin_rec;
			DATASET(DeathV2_Services.layouts.BatchOut) childRecs_Death;
			DATASET(CriminalRecords_BatchService.Layouts.batch_out) childRecs_Criminal;
			DATASET(combined_layouts) childRecs_RedFlag;
			DATASET(FraudShared_Services.Layouts.Raw_Payload_rec) childRecs_fdn;
			DATASET(Patriot.layout_batch_out) childRecs_Patriot;
			DATASET(Velocities) childRecs_Velocities;
	END;

	EXPORT Batch_out_pre_w_raw := RECORD
			Batch_out_pre_rec;
			DATASET(KnownFrauds_rec) childRecs_KnownFrauds_raw;
	END;

	EXPORT red_flag_in := RECORD
			risk_indicators.Layout_Batch_In;
			STRING20 HistoryDateTimeStamp := '';
			STRING6 Gender := '';
			STRING44 PassportUpperLine := '';
			STRING44 PassportLowerLine := '';
			// fields below requested by Deni/Mike to be added for fraudpoint 2.0, even though we do nothing with them
			STRING5 Grade := '';
			STRING16 Channel := '';
			STRING8 Income := '';
			STRING16 OwnOrRent := '';
			STRING16 LocationIdentifier := '';
			STRING16 OtherApplicationIdentifier := '';
			STRING16 OtherApplicationIdentifier2 := '';
			STRING16 OtherApplicationIdentifier3 := '';
			STRING8 DateofApplication := '';
			STRING8 TimeofApplication := '';
			STRING50 email := '';
			STRING64 custom_input1 := '';
			STRING64 custom_input2 := '';
			STRING64 custom_input3 := '';
			STRING64 custom_input4 := '';
			STRING64 custom_input5 := '';
			STRING64 custom_input6 := '';
			STRING64 custom_input7 := '';
			STRING64 custom_input8 := '';
			STRING64 custom_input9 := '';
			STRING64 custom_input10 := '';
			STRING64 custom_input11 := '';
			STRING64 custom_input12 := '';
			STRING64 custom_input13 := '';
			STRING64 custom_input14 := '';
			STRING64 custom_input15 := '';
			STRING64 custom_input16 := '';
			STRING64 custom_input17 := '';
			STRING64 custom_input18 := '';
			STRING64 custom_input19 := '';
			STRING64 custom_input20 := '';
			STRING64 custom_input21 := '';
			STRING64 custom_input22 := '';
			STRING64 custom_input23 := '';
			STRING64 custom_input24 := '';
			STRING64 custom_input25 := '';
			STRING120 UnparsedFullName2;
			STRING30  Name_First2;
			STRING30  Name_Middle2;
			STRING30  Name_Last2;
			STRING5   Name_Suffix2;
			STRING65  Street_Addr2;
			STRING10  Prim_Range2;
			STRING2   Predir2;
			STRING28  Prim_Name2;
			STRING4   Suffix2;
			STRING2   Postdir2;
			STRING10  Unit_Desig2;
			STRING8   Sec_Range2;
			STRING25  p_City_name2;
			STRING2   St2;
			STRING5   Z52;
			STRING10  Home_Phone2;	
	END;

	EXPORT red_flag_desc := RECORD
			STRING5 hri;
			STRING desc;
			INTEGER hri_weight;
	END;

	EXPORT red_flag_desc_w_details := RECORD
			UNSIGNED seq := 0;
			INTEGER category_weight;
			DATASET(red_flag_desc) hri_details;
	END;

	EXPORT red_flag_desc_w_cat_weight := RECORD
			UNSIGNED seq := 0;
			red_flag_desc;
			INTEGER category_weight;
	END;
END;