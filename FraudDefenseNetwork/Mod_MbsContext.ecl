IMPORT FraudShared;
EXPORT Mod_MbsContext := MODULE

	  shared Mbs_ds                                 := FraudShared.Files().Input.MBS.sprayed(status = 1);
		shared Mbs_ds_ainspection                     := Mbs_ds(fdn_file_code='AddressInspection')[1];
		shared Mbs_ds_cfna                            := Mbs_ds(fdn_file_code='CFNA')[1];
		shared Mbs_ds_glb5                            := Mbs_ds(fdn_file_code='GLB5')[1];
		shared Mbs_ds_OIGIndividual                   := Mbs_ds(fdn_file_code='OIG_Individual')[1];
		shared Mbs_ds_OIGBusiness                     := Mbs_ds(fdn_file_code='OIG_Business')[1];
		shared Mbs_ds_SuspectIP                       := Mbs_ds(fdn_file_code='SuspectIPAddress')[1];
		shared Mbs_ds_TextMinedCrim                   := Mbs_ds(fdn_file_code='TextMinedCrim')[1];
		shared Mbs_ds_tiger                           := Mbs_ds(fdn_file_code='TIGER')[1];

		export AInspectionExpdays                     := Mbs_ds_ainspection.expiration_days;
		export CfnaExpdays                            := Mbs_ds_cfna.expiration_days;
		export Glb5Expdays                            := Mbs_ds_glb5.expiration_days;
		export OIGIndividualExpdays                   := Mbs_ds_OIGIndividual.expiration_days;
		export OIGBusinessExpdays                     := Mbs_ds_OIGBusiness.expiration_days;
		export SuspectIPExpdays                       := Mbs_ds_SuspectIP.expiration_days;
	  export TextMinedCrimExpdays                   := Mbs_ds_TextMinedCrim.expiration_days;
		export TigerExpdays                           := Mbs_ds_tiger.expiration_days;	
		
		//file_type
		export Glb5FileType                           := FraudShared.MBS_CVD(column_name = 'FILE_TYPE', status = Mbs_ds_glb5.status,          desc_value = Mbs_ds_glb5.file_type )[1].description;
		export TigerFileType                          := FraudShared.MBS_CVD(column_name = 'FILE_TYPE', status = Mbs_ds_tiger.status,         desc_value = Mbs_ds_tiger.file_type )[1].description;
		export CFNAFileType                           := FraudShared.MBS_CVD(column_name = 'FILE_TYPE', status = Mbs_ds_cfna.status,          desc_value = Mbs_ds_cfna.file_type )[1].description;
		export ainspectionFileType                    := FraudShared.MBS_CVD(column_name = 'FILE_TYPE', status = Mbs_ds_ainspection.status,   desc_value = Mbs_ds_ainspection.file_type )[1].description;
		export SuspectIPFileType                      := FraudShared.MBS_CVD(column_name = 'FILE_TYPE', status = Mbs_ds_SuspectIP.status,     desc_value = Mbs_ds_SuspectIP.file_type )[1].description;
		export TextMinedCrimFileType                  := FraudShared.MBS_CVD(column_name = 'FILE_TYPE', status = Mbs_ds_TextMinedCrim.status, desc_value = Mbs_ds_TextMinedCrim.file_type )[1].description;
		export OIGIndividualFileType                  := FraudShared.MBS_CVD(column_name = 'FILE_TYPE', status = Mbs_ds_OIGIndividual.status, desc_value = Mbs_ds_OIGIndividual.file_type )[1].description;
		export OIGBusinessFileType                    := FraudShared.MBS_CVD(column_name = 'FILE_TYPE', status = Mbs_ds_OIGBusiness.status,   desc_value = Mbs_ds_OIGBusiness.file_type )[1].description;

	//primary_source_entity
		export Glb5PrimarySrcEntity                   := FraudShared.MBS_CVD(column_name = 'PRIMARY_SOURCE_ENTITY', status = Mbs_ds_glb5.status,          desc_value = Mbs_ds_glb5.primary_source_entity )[1].description;
		export TigerPrimarySrcEntity                  := FraudShared.MBS_CVD(column_name = 'PRIMARY_SOURCE_ENTITY', status = Mbs_ds_tiger.status,         desc_value = Mbs_ds_tiger.primary_source_entity )[1].description;
		export CFNAPrimarySrcEntity                   := FraudShared.MBS_CVD(column_name = 'PRIMARY_SOURCE_ENTITY', status = Mbs_ds_cfna.status,          desc_value = Mbs_ds_cfna.primary_source_entity )[1].description;
		export ainspectionPrimarySrcEntity            := FraudShared.MBS_CVD(column_name = 'PRIMARY_SOURCE_ENTITY', status = Mbs_ds_ainspection.status,   desc_value = Mbs_ds_ainspection.primary_source_entity )[1].description;
		export SuspectIPPrimarySrcEntity              := FraudShared.MBS_CVD(column_name = 'PRIMARY_SOURCE_ENTITY', status = Mbs_ds_SuspectIP.status,     desc_value = Mbs_ds_SuspectIP.primary_source_entity )[1].description;
		export TextMinedCrimPrimarySrcEntity          := FraudShared.MBS_CVD(column_name = 'PRIMARY_SOURCE_ENTITY', status = Mbs_ds_TextMinedCrim.status, desc_value = Mbs_ds_TextMinedCrim.primary_source_entity )[1].description;
		export OIGIndividualPrimarySrcEntity          := FraudShared.MBS_CVD(column_name = 'PRIMARY_SOURCE_ENTITY', status = Mbs_ds_OIGIndividual.status, desc_value = Mbs_ds_OIGIndividual.primary_source_entity )[1].description;
		export OIGBusinessPrimarySrcEntity            := FraudShared.MBS_CVD(column_name = 'PRIMARY_SOURCE_ENTITY', status = Mbs_ds_OIGBusiness.status,   desc_value = Mbs_ds_OIGBusiness.primary_source_entity )[1].description;

		//Expectation_of_Victim_Entities
		export Glb5ExpOfVicEntities                   := FraudShared.MBS_CVD(column_name = 'VICTIM_ENTITIES', status = Mbs_ds_glb5.status,          desc_value = Mbs_ds_glb5.Expectation_of_Victim_Entities )[1].description;
		export TigerExpOfVicEntities                  := FraudShared.MBS_CVD(column_name = 'VICTIM_ENTITIES', status = Mbs_ds_tiger.status,         desc_value = Mbs_ds_tiger.Expectation_of_Victim_Entities )[1].description;
		export CFNAExpOfVicEntities                   := FraudShared.MBS_CVD(column_name = 'VICTIM_ENTITIES', status = Mbs_ds_cfna.status,          desc_value = Mbs_ds_cfna.Expectation_of_Victim_Entities )[1].description;
		export ainspectionExpOfVicEntities            := FraudShared.MBS_CVD(column_name = 'VICTIM_ENTITIES', status = Mbs_ds_ainspection.status,   desc_value = Mbs_ds_ainspection.Expectation_of_Victim_Entities )[1].description;
		export SuspectIPExpOfVicEntities              := FraudShared.MBS_CVD(column_name = 'VICTIM_ENTITIES', status = Mbs_ds_SuspectIP.status,     desc_value = Mbs_ds_SuspectIP.Expectation_of_Victim_Entities )[1].description;
		export TextMinedCrimExpOfVicEntities          := FraudShared.MBS_CVD(column_name = 'VICTIM_ENTITIES', status = Mbs_ds_TextMinedCrim.status, desc_value = Mbs_ds_TextMinedCrim.Expectation_of_Victim_Entities )[1].description;
		export OIGIndividualExpOfVicEntities          := FraudShared.MBS_CVD(column_name = 'VICTIM_ENTITIES', status = Mbs_ds_OIGIndividual.status, desc_value = Mbs_ds_OIGIndividual.Expectation_of_Victim_Entities )[1].description;
		export OIGBusinessExpOfVicEntities            := FraudShared.MBS_CVD(column_name = 'VICTIM_ENTITIES', status = Mbs_ds_OIGBusiness.status,   desc_value = Mbs_ds_OIGBusiness.Expectation_of_Victim_Entities )[1].description;

		//suspected_discrepancy
		export Glb5SuspDiscrepancy                    := FraudShared.MBS_CVD(column_name = 'SUSPECTED_DISCREPANCY', status = Mbs_ds_glb5.status,          desc_value = Mbs_ds_glb5.suspected_discrepancy )[1].description;
		export TigerSuspDiscrepancy                   := FraudShared.MBS_CVD(column_name = 'SUSPECTED_DISCREPANCY', status = Mbs_ds_tiger.status,         desc_value = Mbs_ds_tiger.suspected_discrepancy )[1].description;
		export CFNASuspDiscrepancy                    := FraudShared.MBS_CVD(column_name = 'SUSPECTED_DISCREPANCY', status = Mbs_ds_cfna.status,          desc_value = Mbs_ds_cfna.suspected_discrepancy )[1].description;
		export ainspectionSuspDiscrepancy             := FraudShared.MBS_CVD(column_name = 'SUSPECTED_DISCREPANCY', status = Mbs_ds_ainspection.status,   desc_value = Mbs_ds_ainspection.suspected_discrepancy )[1].description;
		export SuspectIPSuspDiscrepancy               := FraudShared.MBS_CVD(column_name = 'SUSPECTED_DISCREPANCY', status = Mbs_ds_SuspectIP.status,     desc_value = Mbs_ds_SuspectIP.suspected_discrepancy )[1].description;
		export TextMinedCrimSuspDiscrepancy           := FraudShared.MBS_CVD(column_name = 'SUSPECTED_DISCREPANCY', status = Mbs_ds_TextMinedCrim.status, desc_value = Mbs_ds_TextMinedCrim.suspected_discrepancy )[1].description;
		export OIGIndividualSuspDiscrepancy           := FraudShared.MBS_CVD(column_name = 'SUSPECTED_DISCREPANCY', status = Mbs_ds_OIGIndividual.status, desc_value = Mbs_ds_OIGIndividual.suspected_discrepancy )[1].description;
		export OIGBusinessSuspDiscrepancy             := FraudShared.MBS_CVD(column_name = 'SUSPECTED_DISCREPANCY', status = Mbs_ds_OIGBusiness.status,   desc_value = Mbs_ds_OIGBusiness.suspected_discrepancy )[1].description;

	//confidence_that_activity_was_deceitful
		export Glb5ConfActivityDeceitful              := FraudShared.MBS_CVD(column_name = 'DECEITFUL_ACTIVITY', status = Mbs_ds_glb5.status,          desc_value = Mbs_ds_glb5.confidence_that_activity_was_deceitful )[1].description;
		export TigerConfActivityDeceitful             := FraudShared.MBS_CVD(column_name = 'DECEITFUL_ACTIVITY', status = Mbs_ds_tiger.status,         desc_value = Mbs_ds_tiger.confidence_that_activity_was_deceitful )[1].description;
		export CFNAConfActivityDeceitful              := FraudShared.MBS_CVD(column_name = 'DECEITFUL_ACTIVITY', status = Mbs_ds_cfna.status,          desc_value = Mbs_ds_cfna.confidence_that_activity_was_deceitful )[1].description;
		export ainspectionConfActivityDeceitful       := FraudShared.MBS_CVD(column_name = 'DECEITFUL_ACTIVITY', status = Mbs_ds_ainspection.status,   desc_value = Mbs_ds_ainspection.confidence_that_activity_was_deceitful )[1].description;
		export SuspectIPConfActivityDeceitful         := FraudShared.MBS_CVD(column_name = 'DECEITFUL_ACTIVITY', status = Mbs_ds_SuspectIP.status,     desc_value = Mbs_ds_SuspectIP.confidence_that_activity_was_deceitful )[1].description;
		export TextMinedCrimConfActivityDeceitful     := FraudShared.MBS_CVD(column_name = 'DECEITFUL_ACTIVITY', status = Mbs_ds_TextMinedCrim.status, desc_value = Mbs_ds_TextMinedCrim.confidence_that_activity_was_deceitful )[1].description;
		export OIGIndividualConfActivityDeceitful     := FraudShared.MBS_CVD(column_name = 'DECEITFUL_ACTIVITY', status = Mbs_ds_OIGIndividual.status, desc_value = Mbs_ds_OIGIndividual.confidence_that_activity_was_deceitful )[1].description;
		export OIGBusinessConfActivityDeceitful       := FraudShared.MBS_CVD(column_name = 'DECEITFUL_ACTIVITY', status = Mbs_ds_OIGBusiness.status,   desc_value = Mbs_ds_OIGBusiness.confidence_that_activity_was_deceitful )[1].description;
		
		//workflow_stage_committed
		export Glb5WrkFlowStgComtd                    := FraudShared.MBS_CVD(column_name = 'WORKFLOW_COMMITTED', status = Mbs_ds_glb5.status,          desc_value = Mbs_ds_glb5.workflow_stage_committed )[1].description;
		export TigerWrkFlowStgComtd                   := FraudShared.MBS_CVD(column_name = 'WORKFLOW_COMMITTED', status = Mbs_ds_tiger.status,         desc_value = Mbs_ds_tiger.workflow_stage_committed )[1].description;
		export CFNAWrkFlowStgComtd                    := FraudShared.MBS_CVD(column_name = 'WORKFLOW_COMMITTED', status = Mbs_ds_cfna.status,          desc_value = Mbs_ds_cfna.workflow_stage_committed )[1].description;
		export ainspectionWrkFlowStgComtd             := FraudShared.MBS_CVD(column_name = 'WORKFLOW_COMMITTED', status = Mbs_ds_ainspection.status,   desc_value = Mbs_ds_ainspection.workflow_stage_committed )[1].description;
		export SuspectIPWrkFlowStgComtd               := FraudShared.MBS_CVD(column_name = 'WORKFLOW_COMMITTED', status = Mbs_ds_SuspectIP.status,     desc_value = Mbs_ds_SuspectIP.workflow_stage_committed )[1].description;
		export TextMinedCrimWrkFlowStgComtd           := FraudShared.MBS_CVD(column_name = 'WORKFLOW_COMMITTED', status = Mbs_ds_TextMinedCrim.status, desc_value = Mbs_ds_TextMinedCrim.workflow_stage_committed )[1].description;
		export OIGIndividualWrkFlowStgComtd           := FraudShared.MBS_CVD(column_name = 'WORKFLOW_COMMITTED', status = Mbs_ds_OIGIndividual.status, desc_value = Mbs_ds_OIGIndividual.workflow_stage_committed )[1].description;
		export OIGBusinessWrkFlowStgComtd             := FraudShared.MBS_CVD(column_name = 'WORKFLOW_COMMITTED', status = Mbs_ds_OIGBusiness.status,   desc_value = Mbs_ds_OIGBusiness.workflow_stage_committed )[1].description;

		//workflow_stage_detected
		export Glb5WrkFlowStgDetected                 := FraudShared.MBS_CVD(column_name = 'WORKFLOW_DETECTED', status = Mbs_ds_glb5.status,          desc_value = Mbs_ds_glb5.workflow_stage_detected )[1].description;
		export TigerWrkFlowStgDetected                := FraudShared.MBS_CVD(column_name = 'WORKFLOW_DETECTED', status = Mbs_ds_tiger.status,         desc_value = Mbs_ds_tiger.workflow_stage_detected )[1].description;
		export CFNAWrkFlowStgDetected                 := FraudShared.MBS_CVD(column_name = 'WORKFLOW_DETECTED', status = Mbs_ds_cfna.status,          desc_value = Mbs_ds_cfna.workflow_stage_detected )[1].description;
		export ainspectionWrkFlowStgDetected          := FraudShared.MBS_CVD(column_name = 'WORKFLOW_DETECTED', status = Mbs_ds_ainspection.status,   desc_value = Mbs_ds_ainspection.workflow_stage_detected )[1].description;
		export SuspectIPWrkFlowStgDetected            := FraudShared.MBS_CVD(column_name = 'WORKFLOW_DETECTED', status = Mbs_ds_SuspectIP.status,     desc_value = Mbs_ds_SuspectIP.workflow_stage_detected )[1].description;
		export TextMinedCrimWrkFlowStgDetected        := FraudShared.MBS_CVD(column_name = 'WORKFLOW_DETECTED', status = Mbs_ds_TextMinedCrim.status, desc_value = Mbs_ds_TextMinedCrim.workflow_stage_detected )[1].description;
		export OIGIndividualWrkFlowStgDetected        := FraudShared.MBS_CVD(column_name = 'WORKFLOW_DETECTED', status = Mbs_ds_OIGIndividual.status, desc_value = Mbs_ds_OIGIndividual.workflow_stage_detected )[1].description;
		export OIGBusinessWrkFlowStgDetected          := FraudShared.MBS_CVD(column_name = 'WORKFLOW_DETECTED', status = Mbs_ds_OIGBusiness.status,   desc_value = Mbs_ds_OIGBusiness.workflow_stage_detected )[1].description;		
	
	//channels
		export Glb5Channels                           := FraudShared.MBS_CVD(column_name = 'CHANNEL', status = Mbs_ds_glb5.status,          desc_value = Mbs_ds_glb5.channels )[1].description;
		export TigerChannels                          := FraudShared.MBS_CVD(column_name = 'CHANNEL', status = Mbs_ds_tiger.status,         desc_value = Mbs_ds_tiger.channels )[1].description;
		export CFNAChannels                           := FraudShared.MBS_CVD(column_name = 'CHANNEL', status = Mbs_ds_cfna.status,          desc_value = Mbs_ds_cfna.channels )[1].description;
		export ainspectionChannels                    := FraudShared.MBS_CVD(column_name = 'CHANNEL', status = Mbs_ds_ainspection.status,   desc_value = Mbs_ds_ainspection.channels )[1].description;
		export SuspectIPChannels                      := FraudShared.MBS_CVD(column_name = 'CHANNEL', status = Mbs_ds_SuspectIP.status,     desc_value = Mbs_ds_SuspectIP.channels )[1].description;
		export TextMinedCrimChannels                  := FraudShared.MBS_CVD(column_name = 'CHANNEL', status = Mbs_ds_TextMinedCrim.status, desc_value = Mbs_ds_TextMinedCrim.channels )[1].description;
		export OIGIndividualChannels                  := FraudShared.MBS_CVD(column_name = 'CHANNEL', status = Mbs_ds_OIGIndividual.status, desc_value = Mbs_ds_OIGIndividual.channels )[1].description;
		export OIGBusinessChannels                    := FraudShared.MBS_CVD(column_name = 'CHANNEL', status = Mbs_ds_OIGBusiness.status,   desc_value = Mbs_ds_OIGBusiness.channels )[1].description;

		//Threat
		export Glb5Threat                             := FraudShared.MBS_CVD(column_name = 'THREAT', status = Mbs_ds_glb5.status,          desc_value = Mbs_ds_glb5.threat )[1].description;
		export TigerThreat                            := FraudShared.MBS_CVD(column_name = 'THREAT', status = Mbs_ds_tiger.status,         desc_value = Mbs_ds_tiger.threat )[1].description;
		export CFNAThreat                             := FraudShared.MBS_CVD(column_name = 'THREAT', status = Mbs_ds_cfna.status,          desc_value = Mbs_ds_cfna.threat )[1].description;
		export ainspectionThreat                      := FraudShared.MBS_CVD(column_name = 'THREAT', status = Mbs_ds_ainspection.status,   desc_value = Mbs_ds_ainspection.threat )[1].description;
		export SuspectIPThreat                        := FraudShared.MBS_CVD(column_name = 'THREAT', status = Mbs_ds_SuspectIP.status,     desc_value = Mbs_ds_SuspectIP.threat )[1].description;
		export TextMinedCrimThreat                    := FraudShared.MBS_CVD(column_name = 'THREAT', status = Mbs_ds_TextMinedCrim.status, desc_value = Mbs_ds_TextMinedCrim.threat )[1].description;
		export OIGIndividualThreat                    := FraudShared.MBS_CVD(column_name = 'THREAT', status = Mbs_ds_OIGIndividual.status, desc_value = Mbs_ds_OIGIndividual.threat )[1].description;
		export OIGBusinessThreat                      := FraudShared.MBS_CVD(column_name = 'THREAT', status = Mbs_ds_OIGBusiness.status,   desc_value = Mbs_ds_OIGBusiness.threat )[1].description;
		
		//Alert_level
		export Glb5AlertLevel                         := FraudShared.MBS_CVD(column_name = 'ALERT_LEVEL', status = Mbs_ds_glb5.status,          desc_value = Mbs_ds_glb5.alert_level )[1].description;
		export TigerAlertLevel                        := FraudShared.MBS_CVD(column_name = 'ALERT_LEVEL', status = Mbs_ds_tiger.status,         desc_value = Mbs_ds_tiger.alert_level )[1].description;
		export CFNAAlertLevel                         := FraudShared.MBS_CVD(column_name = 'ALERT_LEVEL', status = Mbs_ds_cfna.status,          desc_value = Mbs_ds_cfna.alert_level )[1].description;
		export ainspectionAlertLevel                  := FraudShared.MBS_CVD(column_name = 'ALERT_LEVEL', status = Mbs_ds_ainspection.status,   desc_value = Mbs_ds_ainspection.alert_level )[1].description;
		export SuspectIPAlertLevel                    := FraudShared.MBS_CVD(column_name = 'ALERT_LEVEL', status = Mbs_ds_SuspectIP.status,     desc_value = Mbs_ds_SuspectIP.alert_level )[1].description;
		export TextMinedCrimAlertLevel                := FraudShared.MBS_CVD(column_name = 'ALERT_LEVEL', status = Mbs_ds_TextMinedCrim.status, desc_value = Mbs_ds_TextMinedCrim.alert_level )[1].description;
		export OIGIndividualAlertLevel                := FraudShared.MBS_CVD(column_name = 'ALERT_LEVEL', status = Mbs_ds_OIGIndividual.status, desc_value = Mbs_ds_OIGIndividual.alert_level )[1].description;
		export OIGBusinessAlertLevel                  := FraudShared.MBS_CVD(column_name = 'ALERT_LEVEL', status = Mbs_ds_OIGBusiness.status,   desc_value = Mbs_ds_OIGBusiness.alert_level )[1].description;
 
 //entity_type
		export Glb5EntityType                         := FraudShared.MBS_CVD(column_name = 'ENTITY_TYPE', status = Mbs_ds_glb5.status,          desc_value = Mbs_ds_glb5.entity_type )[1].description;
		export TigerEntityType                        := FraudShared.MBS_CVD(column_name = 'ENTITY_TYPE', status = Mbs_ds_tiger.status,         desc_value = Mbs_ds_tiger.entity_type )[1].description;
		export CFNAEntityType                         := FraudShared.MBS_CVD(column_name = 'ENTITY_TYPE', status = Mbs_ds_cfna.status,          desc_value = Mbs_ds_cfna.entity_type )[1].description;
		export ainspectionEntityType                  := FraudShared.MBS_CVD(column_name = 'ENTITY_TYPE', status = Mbs_ds_ainspection.status,   desc_value = Mbs_ds_ainspection.entity_type )[1].description;
		export SuspectIPEntityType                    := FraudShared.MBS_CVD(column_name = 'ENTITY_TYPE', status = Mbs_ds_SuspectIP.status,     desc_value = Mbs_ds_SuspectIP.entity_type )[1].description;
		export TextMinedCrimEntityType                := FraudShared.MBS_CVD(column_name = 'ENTITY_TYPE', status = Mbs_ds_TextMinedCrim.status, desc_value = Mbs_ds_TextMinedCrim.entity_type )[1].description;
		export OIGIndividualEntityType                := FraudShared.MBS_CVD(column_name = 'ENTITY_TYPE', status = Mbs_ds_OIGIndividual.status, desc_value = Mbs_ds_OIGIndividual.entity_type )[1].description;
		export OIGBusinessEntityType                  := FraudShared.MBS_CVD(column_name = 'ENTITY_TYPE', status = Mbs_ds_OIGBusiness.status,   desc_value = Mbs_ds_OIGBusiness.entity_type )[1].description;
		
  	//entity_sub_type
		export Glb5EntitySubType                      := FraudShared.MBS_CVD(column_name = 'ENTITY_SUB_TYPE', status = Mbs_ds_glb5.status,          desc_value = Mbs_ds_glb5.entity_sub_type )[1].description;
		export TigerEntitySubType                     := FraudShared.MBS_CVD(column_name = 'ENTITY_SUB_TYPE', status = Mbs_ds_tiger.status,         desc_value = Mbs_ds_tiger.entity_sub_type )[1].description;
		export CFNAEntitySubType                      := FraudShared.MBS_CVD(column_name = 'ENTITY_SUB_TYPE', status = Mbs_ds_cfna.status,          desc_value = Mbs_ds_cfna.entity_sub_type )[1].description;
		export ainspectionEntitySubType               := FraudShared.MBS_CVD(column_name = 'ENTITY_SUB_TYPE', status = Mbs_ds_ainspection.status,   desc_value = Mbs_ds_ainspection.entity_sub_type )[1].description;
		export SuspectIPEntitySubType                 := FraudShared.MBS_CVD(column_name = 'ENTITY_SUB_TYPE', status = Mbs_ds_SuspectIP.status,     desc_value = Mbs_ds_SuspectIP.entity_sub_type )[1].description;
		export TextMinedCrimEntitySubType             := FraudShared.MBS_CVD(column_name = 'ENTITY_SUB_TYPE', status = Mbs_ds_TextMinedCrim.status, desc_value = Mbs_ds_TextMinedCrim.entity_sub_type )[1].description;
		export OIGIndividualEntitySubType             := FraudShared.MBS_CVD(column_name = 'ENTITY_SUB_TYPE', status = Mbs_ds_OIGIndividual.status, desc_value = Mbs_ds_OIGIndividual.entity_sub_type )[1].description;
		export OIGBusinessEntitySubType               := FraudShared.MBS_CVD(column_name = 'ENTITY_SUB_TYPE', status = Mbs_ds_OIGBusiness.status,   desc_value = Mbs_ds_OIGBusiness.entity_sub_type )[1].description;

		//role
		export Glb5Role                               := FraudShared.MBS_CVD(column_name = 'ROLE', status = Mbs_ds_glb5.status,          desc_value = Mbs_ds_glb5.role )[1].description;
		export TigerRole                              := FraudShared.MBS_CVD(column_name = 'ROLE', status = Mbs_ds_tiger.status,         desc_value = Mbs_ds_tiger.role )[1].description;
		export CFNARole                               := FraudShared.MBS_CVD(column_name = 'ROLE', status = Mbs_ds_cfna.status,          desc_value = Mbs_ds_cfna.role )[1].description;
		export ainspectionRole                        := FraudShared.MBS_CVD(column_name = 'ROLE', status = Mbs_ds_ainspection.status,   desc_value = Mbs_ds_ainspection.role )[1].description;
		export SuspectIPRole                          := FraudShared.MBS_CVD(column_name = 'ROLE', status = Mbs_ds_SuspectIP.status,     desc_value = Mbs_ds_SuspectIP.role )[1].description;
		export TextMinedCrimRole                      := FraudShared.MBS_CVD(column_name = 'ROLE', status = Mbs_ds_TextMinedCrim.status, desc_value = Mbs_ds_TextMinedCrim.role )[1].description;
		export OIGIndividualRole                      := FraudShared.MBS_CVD(column_name = 'ROLE', status = Mbs_ds_OIGIndividual.status, desc_value = Mbs_ds_OIGIndividual.role )[1].description;
		export OIGBusinessRole                        := FraudShared.MBS_CVD(column_name = 'ROLE', status = Mbs_ds_OIGBusiness.status,   desc_value = Mbs_ds_OIGBusiness.role )[1].description;
		
		//evidence
		export Glb5Evidence                           := FraudShared.MBS_CVD(column_name = 'EVIDENCE', status = Mbs_ds_glb5.status,          desc_value = Mbs_ds_glb5.evidence )[1].description;
		export TigerEvidence                          := FraudShared.MBS_CVD(column_name = 'EVIDENCE', status = Mbs_ds_tiger.status,         desc_value = Mbs_ds_tiger.evidence )[1].description;
		export CFNAEvidence                           := FraudShared.MBS_CVD(column_name = 'EVIDENCE', status = Mbs_ds_cfna.status,          desc_value = Mbs_ds_cfna.evidence )[1].description;
		export ainspectionEvidence                    := FraudShared.MBS_CVD(column_name = 'EVIDENCE', status = Mbs_ds_ainspection.status,   desc_value = Mbs_ds_ainspection.evidence )[1].description;
		export SuspectIPEvidence                      := FraudShared.MBS_CVD(column_name = 'EVIDENCE', status = Mbs_ds_SuspectIP.status,     desc_value = Mbs_ds_SuspectIP.evidence )[1].description;
		export TextMinedCrimEvidence                  := FraudShared.MBS_CVD(column_name = 'EVIDENCE', status = Mbs_ds_TextMinedCrim.status, desc_value = Mbs_ds_TextMinedCrim.evidence )[1].description;
		export OIGIndividualEvidence                  := FraudShared.MBS_CVD(column_name = 'EVIDENCE', status = Mbs_ds_OIGIndividual.status, desc_value = Mbs_ds_OIGIndividual.evidence )[1].description;
		export OIGBusinessEvidence                    := FraudShared.MBS_CVD(column_name = 'EVIDENCE', status = Mbs_ds_OIGBusiness.status,   desc_value = Mbs_ds_OIGBusiness.evidence )[1].description;
		
END;		
