EXPORT Mod_MbsContext(unsigned6 p_GcId,string100 p_FileCode) := MODULE

	  shared Mbs_ds						:= FraudGovPlatform.Files().Input.MBS.sprayed(status = 1 and fdn_file_code = p_FileCode)[1];
		export Expdays					:= Mbs_ds.expiration_days;
		export FileType					:= FraudGovPlatform.MBS_CVD(column_name = 'FILE_TYPE' , status = Mbs_ds.status, desc_value = Mbs_ds.file_type )[1].description;
		export PrimarySrcEntity			:= FraudGovPlatform.MBS_CVD(column_name = 'PRIMARY_SOURCE_ENTITY' , status = Mbs_ds.status, desc_value = Mbs_ds.primary_source_entity )[1].description;
		export ExpOfVicEntities			:= FraudGovPlatform.MBS_CVD(column_name = 'VICTIM_ENTITIES' , status = Mbs_ds.status, desc_value = Mbs_ds.Expectation_of_Victim_Entities )[1].description;
		export SuspDiscrepancy			:= FraudGovPlatform.MBS_CVD(column_name = 'SUSPECTED_DISCREPANCY' , status = Mbs_ds.status, desc_value = Mbs_ds.suspected_discrepancy )[1].description;		
		export ConfActivityDeceitful	:= FraudGovPlatform.MBS_CVD(column_name = 'DECEITFUL_ACTIVITY' , status = Mbs_ds.status, desc_value = Mbs_ds.confidence_that_activity_was_deceitful )[1].description;
		export WrkFlowStgComtd			:= FraudGovPlatform.MBS_CVD(column_name = 'WORKFLOW_COMMITTED' , status = Mbs_ds.status, desc_value = Mbs_ds.workflow_stage_committed )[1].description;
		export WrkFlowStgDetected		:= FraudGovPlatform.MBS_CVD(column_name = 'WORKFLOW_DETECTED' , status = Mbs_ds.status, desc_value = Mbs_ds.workflow_stage_detected )[1].description;		
		export Channels					:= FraudGovPlatform.MBS_CVD(column_name = 'CHANNEL' , status = Mbs_ds.status, desc_value = Mbs_ds.channels )[1].description;
		export Threat					:= FraudGovPlatform.MBS_CVD(column_name = 'THREAT' , status = Mbs_ds.status, desc_value = Mbs_ds.threat )[1].description;
		export AlertLevel				:= FraudGovPlatform.MBS_CVD(column_name = 'ALERT_LEVEL' , status = Mbs_ds.status, desc_value = Mbs_ds.alert_level )[1].description; 
		export EntityType				:= FraudGovPlatform.MBS_CVD(column_name = 'ENTITY_TYPE' , status = Mbs_ds.status, desc_value = Mbs_ds.entity_type )[1].description;
		export EntitySubType			:= FraudGovPlatform.MBS_CVD(column_name = 'ENTITY_SUB_TYPE' , status = Mbs_ds.status, desc_value = Mbs_ds.entity_sub_type )[1].description;
		export Role						:= FraudGovPlatform.MBS_CVD(column_name = 'ROLE' , status = Mbs_ds.status, desc_value = Mbs_ds.role )[1].description;
		export Evidence					:= FraudGovPlatform.MBS_CVD(column_name = 'EVIDENCE' , status = Mbs_ds.status, desc_value = Mbs_ds.evidence )[1].description;
		export CustomerState			:= Mbs_ds.Customer_State;
		export CustomerCounty			:= Mbs_ds.Customer_County;
		export CustomerVertical			:= Mbs_ds.Customer_Vertical;
		
END;

		
