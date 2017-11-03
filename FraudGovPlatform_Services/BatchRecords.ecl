﻿IMPORT FraudShared_Services, FraudGovPlatform_Services;

EXPORT BatchRecords(DATASET(FraudShared_Services.Layouts.BatchIn_rec) ds_batch_in,
										FraudGovPlatform_Services.IParam.BatchParams batch_params) := FUNCTION

		//**
		//** Collect external batch services data
		//**
		ds_reportFromBatchServices := FraudGovPlatform_Services.Functions.getExternalServicesRecs(ds_batch_in, batch_params);
		
		//**
		ds_payload := FraudGovPlatform_Services.Raw_Records(ds_batch_in, batch_params.GlobalCompanyId, batch_params.IndustryType, batch_params.ProductCode);
		//**
		
		//**
		//** Known Frauds
		//**
		ds_payload_KNFD := ds_payload(classification_Permissible_use_access.file_type = FraudGovPlatform_Services.Constants.PayloadFileTypeEnum.KnownFraud); 
		ds_reportKnownFrauds := FraudGovPlatform_Services.Functions.getKnownFraudRecs(ds_batch_in, batch_params, ds_payload_KNFD);

		//**
		//** Velocities goes here
		//**
		ds_payload_IDDT := ds_payload(classification_Permissible_use_access.file_type = FraudGovPlatform_Services.Constants.PayloadFileTypeEnum.IdentityActivity);
		ds_Velocities := FraudGovPlatform_Services.Functions.getVelocityRecs(ds_batch_in, batch_params, ds_payload_IDDT);

		//**
		//** Assemble the pieces
		//**
		FraudGovPlatform_Services.Layouts.Batch_out_pre_w_raw xfm_w_knownfraud(FraudGovPlatform_Services.Layouts.Batch_out_pre_w_raw  L,
																																				  FraudGovPlatform_Services.Layouts.KnownFrauds_rec R) := TRANSFORM

			SELF.childRecs_KnownFrauds_raw := PROJECT(R, TRANSFORM(FraudGovPlatform_Services.Layouts.KnownFrauds_rec, SELF := LEFT));
			SELF := L;
			SELF := [];
		END;

		ds_w_known_frauds := JOIN(ds_reportFromBatchServices, ds_reportKnownFrauds,
														LEFT.acctno = RIGHT.acctno,
														xfm_w_knownfraud(LEFT,RIGHT),
														LEFT OUTER);
														
		FraudGovPlatform_Services.Layouts.Batch_out_pre_w_raw xfm_w_velocities(FraudGovPlatform_Services.Layouts.Batch_out_pre_w_raw L,
																																				   DATASET(FraudGovPlatform_Services.Layouts.velocities) R) := TRANSFORM
			SELF.batchin_rec := L;
			SELF.childRecs_Velocities := R;
			SELF := L; 
			SELF := [];
		END;

		ds_results_w_velocities := DENORMALIZE(ds_w_known_frauds, ds_Velocities, 
																				LEFT.acctno = RIGHT.acctno,
																				GROUP,
																				xfm_w_velocities(LEFT, ROWS(RIGHT)),
																				LEFT OUTER);		
							
		RETURN ds_results_w_velocities;
END;