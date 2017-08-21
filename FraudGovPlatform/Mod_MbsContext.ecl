import FraudShared;
EXPORT Mod_MbsContext := MODULE

	  shared Mbs_ds                                 				:= FraudShared.Files().Input.MBS.sprayed(status = 1);
		shared Mbs_ds_IdentityData                     				:= Mbs_ds(fdn_file_code='IDDT')[1];
		shared Mbs_ds_KnownFraud                     					:= Mbs_ds(fdn_file_code='KNFD')[1];

		export IdentityDataExpdays                     				:= Mbs_ds_IdentityData.expiration_days;
		export KnownFraudExpdays                     					:= Mbs_ds_KnownFraud.expiration_days;
		
		//file_type
		export IdentityDataFileType                    				:= FraudShared.MBS_CVD(column_name = 'FILE_TYPE', status = Mbs_ds_IdentityData.status,   				desc_value = Mbs_ds_IdentityData.file_type )[1].description;
		export KnownFraudFileType                    					:= FraudShared.MBS_CVD(column_name = 'FILE_TYPE', status = Mbs_ds_KnownFraud.status,   					desc_value = Mbs_ds_KnownFraud.file_type )[1].description;


		//primary_source_entity
		export IdentityDataPrimarySrcEntity            				:= FraudShared.MBS_CVD(column_name = 'PRIMARY_SOURCE_ENTITY', status = Mbs_ds_IdentityData.status,   			desc_value = Mbs_ds_IdentityData.primary_source_entity )[1].description;
		export KnownFraudPrimarySrcEntity            					:= FraudShared.MBS_CVD(column_name = 'PRIMARY_SOURCE_ENTITY', status = Mbs_ds_KnownFraud.status,   				desc_value = Mbs_ds_KnownFraud.primary_source_entity )[1].description;

		//Expectation_of_Victim_Entities
		export IdentityDataExpOfVicEntities            				:= FraudShared.MBS_CVD(column_name = 'VICTIM_ENTITIES', status = Mbs_ds_IdentityData.status,   			desc_value = Mbs_ds_IdentityData.Expectation_of_Victim_Entities )[1].description;
		export KnownFraudExpOfVicEntities            					:= FraudShared.MBS_CVD(column_name = 'VICTIM_ENTITIES', status = Mbs_ds_KnownFraud.status,   				desc_value = Mbs_ds_KnownFraud.Expectation_of_Victim_Entities )[1].description;

		//suspected_discrepancy
		export IdentityDataSuspDiscrepancy             				:= FraudShared.MBS_CVD(column_name = 'SUSPECTED_DISCREPANCY', status = Mbs_ds_IdentityData.status,   			desc_value = Mbs_ds_IdentityData.suspected_discrepancy )[1].description;
		export KnownFraudSuspDiscrepancy             					:= FraudShared.MBS_CVD(column_name = 'SUSPECTED_DISCREPANCY', status = Mbs_ds_KnownFraud.status,   				desc_value = Mbs_ds_KnownFraud.suspected_discrepancy )[1].description;

		//confidence_that_activity_was_deceitful
		export IdentityDataConfActivityDeceitful       				:= FraudShared.MBS_CVD(column_name = 'DECEITFUL_ACTIVITY', status = Mbs_ds_IdentityData.status,   		desc_value = Mbs_ds_IdentityData.confidence_that_activity_was_deceitful )[1].description;
		export KnownFraudConfActivityDeceitful       					:= FraudShared.MBS_CVD(column_name = 'DECEITFUL_ACTIVITY', status = Mbs_ds_KnownFraud.status,   			desc_value = Mbs_ds_KnownFraud.confidence_that_activity_was_deceitful )[1].description;
		
		//workflow_stage_committed
		export IdentityDataWrkFlowStgComtd             				:= FraudShared.MBS_CVD(column_name = 'WORKFLOW_COMMITTED', status = Mbs_ds_IdentityData.status,   			desc_value = Mbs_ds_IdentityData.workflow_stage_committed )[1].description;
		export KnownFraudWrkFlowStgComtd             					:= FraudShared.MBS_CVD(column_name = 'WORKFLOW_COMMITTED', status = Mbs_ds_KnownFraud.status,   			 	desc_value = Mbs_ds_KnownFraud.workflow_stage_committed )[1].description;

		//workflow_stage_detected
		export IdentityDataWrkFlowStgDetected          				:= FraudShared.MBS_CVD(column_name = 'WORKFLOW_DETECTED', status = Mbs_ds_IdentityData.status,   				desc_value = Mbs_ds_IdentityData.workflow_stage_detected )[1].description;		
		export KnownFraudWrkFlowStgDetected          					:= FraudShared.MBS_CVD(column_name = 'WORKFLOW_DETECTED', status = Mbs_ds_KnownFraud.status,   				desc_value = Mbs_ds_KnownFraud.workflow_stage_detected )[1].description;		
	
		//channels
		export IdentityDataChannels                    				:= FraudShared.MBS_CVD(column_name = 'CHANNEL', status = Mbs_ds_IdentityData.status,   			desc_value = Mbs_ds_IdentityData.channels )[1].description;
		export KnownFraudChannels                    					:= FraudShared.MBS_CVD(column_name = 'CHANNEL', status = Mbs_ds_KnownFraud.status,   				desc_value = Mbs_ds_KnownFraud.channels )[1].description;

		//Threat
		export IdentityDataThreat                      				:= FraudShared.MBS_CVD(column_name = 'THREAT', status = Mbs_ds_IdentityData.status,   		desc_value = Mbs_ds_IdentityData.threat )[1].description;
		export KnownFraudThreat                      					:= FraudShared.MBS_CVD(column_name = 'THREAT', status = Mbs_ds_KnownFraud.status,   			desc_value = Mbs_ds_KnownFraud.threat )[1].description;
		
		//Alert_level
		export IdentityDataAlertLevel                  				:= FraudShared.MBS_CVD(column_name = 'ALERT_LEVEL', status = Mbs_ds_IdentityData.status,   			desc_value = Mbs_ds_IdentityData.alert_level )[1].description;
		export KnownFraudAlertLevel                  					:= FraudShared.MBS_CVD(column_name = 'ALERT_LEVEL', status = Mbs_ds_KnownFraud.status,   				desc_value = Mbs_ds_KnownFraud.alert_level )[1].description;
 
		//entity_type
		export IdentityDataEntityType                  				:= FraudShared.MBS_CVD(column_name = 'ENTITY_TYPE', status = Mbs_ds_IdentityData.status,   			desc_value = Mbs_ds_IdentityData.entity_type )[1].description;
		export KnownFraudEntityType                  					:= FraudShared.MBS_CVD(column_name = 'ENTITY_TYPE', status = Mbs_ds_KnownFraud.status,   				desc_value = Mbs_ds_KnownFraud.entity_type )[1].description;
		
  	//entity_sub_type
		export IdentityDataEntitySubType               				:= FraudShared.MBS_CVD(column_name = 'ENTITY_SUB_TYPE', status = Mbs_ds_IdentityData.status,   			desc_value = Mbs_ds_IdentityData.entity_sub_type )[1].description;
		export KnownFraudEntitySubType               					:= FraudShared.MBS_CVD(column_name = 'ENTITY_SUB_TYPE', status = Mbs_ds_KnownFraud.status,   				desc_value = Mbs_ds_KnownFraud.entity_sub_type )[1].description;

		//role
		export IdentityDataRole                       				:= FraudShared.MBS_CVD(column_name = 'ROLE', status = Mbs_ds_IdentityData.status,   		desc_value = Mbs_ds_IdentityData.role )[1].description;
		export KnownFraudRole                       					:= FraudShared.MBS_CVD(column_name = 'ROLE', status = Mbs_ds_KnownFraud.status,   			desc_value = Mbs_ds_KnownFraud.role )[1].description;
		
		//evidence
		export IdentityDataEvidence                    				:= FraudShared.MBS_CVD(column_name = 'EVIDENCE', status = Mbs_ds_IdentityData.status,   		desc_value = Mbs_ds_IdentityData.evidence )[1].description;
		export KnownFraudEvidence                    					:= FraudShared.MBS_CVD(column_name = 'EVIDENCE', status = Mbs_ds_KnownFraud.status,   			desc_value = Mbs_ds_KnownFraud.evidence )[1].description;
		
END;		
