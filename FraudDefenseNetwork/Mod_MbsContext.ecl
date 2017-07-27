EXPORT Mod_MbsContext := MODULE

	  shared Mbs_ds                                 := Files().Input.MBS.sprayed(status = 1);
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
		export Glb5FileType                           := MBS_CVD(column_name = 'FILE_TYPE', status = Mbs_ds_glb5.status,          desc_value = Mbs_ds_glb5.file_type )[1].description;
		export TigerFileType                          := MBS_CVD(column_name = 'FILE_TYPE', status = Mbs_ds_tiger.status,         desc_value = Mbs_ds_tiger.file_type )[1].description;
		export CFNAFileType                           := MBS_CVD(column_name = 'FILE_TYPE', status = Mbs_ds_cfna.status,          desc_value = Mbs_ds_cfna.file_type )[1].description;
		export ainspectionFileType                    := MBS_CVD(column_name = 'FILE_TYPE', status = Mbs_ds_ainspection.status,   desc_value = Mbs_ds_ainspection.file_type )[1].description;
		export SuspectIPFileType                      := MBS_CVD(column_name = 'FILE_TYPE', status = Mbs_ds_SuspectIP.status,     desc_value = Mbs_ds_SuspectIP.file_type )[1].description;
		export TextMinedCrimFileType                  := MBS_CVD(column_name = 'FILE_TYPE', status = Mbs_ds_TextMinedCrim.status, desc_value = Mbs_ds_TextMinedCrim.file_type )[1].description;
		export OIGIndividualFileType                  := MBS_CVD(column_name = 'FILE_TYPE', status = Mbs_ds_OIGIndividual.status, desc_value = Mbs_ds_OIGIndividual.file_type )[1].description;
		export OIGBusinessFileType                    := MBS_CVD(column_name = 'FILE_TYPE', status = Mbs_ds_OIGBusiness.status,   desc_value = Mbs_ds_OIGBusiness.file_type )[1].description;

	//primary_source_entity
		export Glb5PrimarySrcEntity                   := MBS_CVD(column_name = 'PRIMARY_SOURCE_ENTITY', status = Mbs_ds_glb5.status,          desc_value = Mbs_ds_glb5.primary_source_entity )[1].description;
		export TigerPrimarySrcEntity                  := MBS_CVD(column_name = 'PRIMARY_SOURCE_ENTITY', status = Mbs_ds_tiger.status,         desc_value = Mbs_ds_tiger.primary_source_entity )[1].description;
		export CFNAPrimarySrcEntity                   := MBS_CVD(column_name = 'PRIMARY_SOURCE_ENTITY', status = Mbs_ds_cfna.status,          desc_value = Mbs_ds_cfna.primary_source_entity )[1].description;
		export ainspectionPrimarySrcEntity            := MBS_CVD(column_name = 'PRIMARY_SOURCE_ENTITY', status = Mbs_ds_ainspection.status,   desc_value = Mbs_ds_ainspection.primary_source_entity )[1].description;
		export SuspectIPPrimarySrcEntity              := MBS_CVD(column_name = 'PRIMARY_SOURCE_ENTITY', status = Mbs_ds_SuspectIP.status,     desc_value = Mbs_ds_SuspectIP.primary_source_entity )[1].description;
		export TextMinedCrimPrimarySrcEntity          := MBS_CVD(column_name = 'PRIMARY_SOURCE_ENTITY', status = Mbs_ds_TextMinedCrim.status, desc_value = Mbs_ds_TextMinedCrim.primary_source_entity )[1].description;
		export OIGIndividualPrimarySrcEntity          := MBS_CVD(column_name = 'PRIMARY_SOURCE_ENTITY', status = Mbs_ds_OIGIndividual.status, desc_value = Mbs_ds_OIGIndividual.primary_source_entity )[1].description;
		export OIGBusinessPrimarySrcEntity            := MBS_CVD(column_name = 'PRIMARY_SOURCE_ENTITY', status = Mbs_ds_OIGBusiness.status,   desc_value = Mbs_ds_OIGBusiness.primary_source_entity )[1].description;

		//Expectation_of_Victim_Entities
		export Glb5ExpOfVicEntities                   := MBS_CVD(column_name = 'VICTIM_ENTITIES', status = Mbs_ds_glb5.status,          desc_value = Mbs_ds_glb5.Expectation_of_Victim_Entities )[1].description;
		export TigerExpOfVicEntities                  := MBS_CVD(column_name = 'VICTIM_ENTITIES', status = Mbs_ds_tiger.status,         desc_value = Mbs_ds_tiger.Expectation_of_Victim_Entities )[1].description;
		export CFNAExpOfVicEntities                   := MBS_CVD(column_name = 'VICTIM_ENTITIES', status = Mbs_ds_cfna.status,          desc_value = Mbs_ds_cfna.Expectation_of_Victim_Entities )[1].description;
		export ainspectionExpOfVicEntities            := MBS_CVD(column_name = 'VICTIM_ENTITIES', status = Mbs_ds_ainspection.status,   desc_value = Mbs_ds_ainspection.Expectation_of_Victim_Entities )[1].description;
		export SuspectIPExpOfVicEntities              := MBS_CVD(column_name = 'VICTIM_ENTITIES', status = Mbs_ds_SuspectIP.status,     desc_value = Mbs_ds_SuspectIP.Expectation_of_Victim_Entities )[1].description;
		export TextMinedCrimExpOfVicEntities          := MBS_CVD(column_name = 'VICTIM_ENTITIES', status = Mbs_ds_TextMinedCrim.status, desc_value = Mbs_ds_TextMinedCrim.Expectation_of_Victim_Entities )[1].description;
		export OIGIndividualExpOfVicEntities          := MBS_CVD(column_name = 'VICTIM_ENTITIES', status = Mbs_ds_OIGIndividual.status, desc_value = Mbs_ds_OIGIndividual.Expectation_of_Victim_Entities )[1].description;
		export OIGBusinessExpOfVicEntities            := MBS_CVD(column_name = 'VICTIM_ENTITIES', status = Mbs_ds_OIGBusiness.status,   desc_value = Mbs_ds_OIGBusiness.Expectation_of_Victim_Entities )[1].description;

		//suspected_discrepancy
		export Glb5SuspDiscrepancy                    := MBS_CVD(column_name = 'SUSPECTED_DISCREPANCY', status = Mbs_ds_glb5.status,          desc_value = Mbs_ds_glb5.suspected_discrepancy )[1].description;
		export TigerSuspDiscrepancy                   := MBS_CVD(column_name = 'SUSPECTED_DISCREPANCY', status = Mbs_ds_tiger.status,         desc_value = Mbs_ds_tiger.suspected_discrepancy )[1].description;
		export CFNASuspDiscrepancy                    := MBS_CVD(column_name = 'SUSPECTED_DISCREPANCY', status = Mbs_ds_cfna.status,          desc_value = Mbs_ds_cfna.suspected_discrepancy )[1].description;
		export ainspectionSuspDiscrepancy             := MBS_CVD(column_name = 'SUSPECTED_DISCREPANCY', status = Mbs_ds_ainspection.status,   desc_value = Mbs_ds_ainspection.suspected_discrepancy )[1].description;
		export SuspectIPSuspDiscrepancy               := MBS_CVD(column_name = 'SUSPECTED_DISCREPANCY', status = Mbs_ds_SuspectIP.status,     desc_value = Mbs_ds_SuspectIP.suspected_discrepancy )[1].description;
		export TextMinedCrimSuspDiscrepancy           := MBS_CVD(column_name = 'SUSPECTED_DISCREPANCY', status = Mbs_ds_TextMinedCrim.status, desc_value = Mbs_ds_TextMinedCrim.suspected_discrepancy )[1].description;
		export OIGIndividualSuspDiscrepancy           := MBS_CVD(column_name = 'SUSPECTED_DISCREPANCY', status = Mbs_ds_OIGIndividual.status, desc_value = Mbs_ds_OIGIndividual.suspected_discrepancy )[1].description;
		export OIGBusinessSuspDiscrepancy             := MBS_CVD(column_name = 'SUSPECTED_DISCREPANCY', status = Mbs_ds_OIGBusiness.status,   desc_value = Mbs_ds_OIGBusiness.suspected_discrepancy )[1].description;

	//confidence_that_activity_was_deceitful
		export Glb5ConfActivityDeceitful              := MBS_CVD(column_name = 'DECEITFUL_ACTIVITY', status = Mbs_ds_glb5.status,          desc_value = Mbs_ds_glb5.confidence_that_activity_was_deceitful )[1].description;
		export TigerConfActivityDeceitful             := MBS_CVD(column_name = 'DECEITFUL_ACTIVITY', status = Mbs_ds_tiger.status,         desc_value = Mbs_ds_tiger.confidence_that_activity_was_deceitful )[1].description;
		export CFNAConfActivityDeceitful              := MBS_CVD(column_name = 'DECEITFUL_ACTIVITY', status = Mbs_ds_cfna.status,          desc_value = Mbs_ds_cfna.confidence_that_activity_was_deceitful )[1].description;
		export ainspectionConfActivityDeceitful       := MBS_CVD(column_name = 'DECEITFUL_ACTIVITY', status = Mbs_ds_ainspection.status,   desc_value = Mbs_ds_ainspection.confidence_that_activity_was_deceitful )[1].description;
		export SuspectIPConfActivityDeceitful         := MBS_CVD(column_name = 'DECEITFUL_ACTIVITY', status = Mbs_ds_SuspectIP.status,     desc_value = Mbs_ds_SuspectIP.confidence_that_activity_was_deceitful )[1].description;
		export TextMinedCrimConfActivityDeceitful     := MBS_CVD(column_name = 'DECEITFUL_ACTIVITY', status = Mbs_ds_TextMinedCrim.status, desc_value = Mbs_ds_TextMinedCrim.confidence_that_activity_was_deceitful )[1].description;
		export OIGIndividualConfActivityDeceitful     := MBS_CVD(column_name = 'DECEITFUL_ACTIVITY', status = Mbs_ds_OIGIndividual.status, desc_value = Mbs_ds_OIGIndividual.confidence_that_activity_was_deceitful )[1].description;
		export OIGBusinessConfActivityDeceitful       := MBS_CVD(column_name = 'DECEITFUL_ACTIVITY', status = Mbs_ds_OIGBusiness.status,   desc_value = Mbs_ds_OIGBusiness.confidence_that_activity_was_deceitful )[1].description;
		
		//workflow_stage_committed
		export Glb5WrkFlowStgComtd                    := MBS_CVD(column_name = 'WORKFLOW_COMMITTED', status = Mbs_ds_glb5.status,          desc_value = Mbs_ds_glb5.workflow_stage_committed )[1].description;
		export TigerWrkFlowStgComtd                   := MBS_CVD(column_name = 'WORKFLOW_COMMITTED', status = Mbs_ds_tiger.status,         desc_value = Mbs_ds_tiger.workflow_stage_committed )[1].description;
		export CFNAWrkFlowStgComtd                    := MBS_CVD(column_name = 'WORKFLOW_COMMITTED', status = Mbs_ds_cfna.status,          desc_value = Mbs_ds_cfna.workflow_stage_committed )[1].description;
		export ainspectionWrkFlowStgComtd             := MBS_CVD(column_name = 'WORKFLOW_COMMITTED', status = Mbs_ds_ainspection.status,   desc_value = Mbs_ds_ainspection.workflow_stage_committed )[1].description;
		export SuspectIPWrkFlowStgComtd               := MBS_CVD(column_name = 'WORKFLOW_COMMITTED', status = Mbs_ds_SuspectIP.status,     desc_value = Mbs_ds_SuspectIP.workflow_stage_committed )[1].description;
		export TextMinedCrimWrkFlowStgComtd           := MBS_CVD(column_name = 'WORKFLOW_COMMITTED', status = Mbs_ds_TextMinedCrim.status, desc_value = Mbs_ds_TextMinedCrim.workflow_stage_committed )[1].description;
		export OIGIndividualWrkFlowStgComtd           := MBS_CVD(column_name = 'WORKFLOW_COMMITTED', status = Mbs_ds_OIGIndividual.status, desc_value = Mbs_ds_OIGIndividual.workflow_stage_committed )[1].description;
		export OIGBusinessWrkFlowStgComtd             := MBS_CVD(column_name = 'WORKFLOW_COMMITTED', status = Mbs_ds_OIGBusiness.status,   desc_value = Mbs_ds_OIGBusiness.workflow_stage_committed )[1].description;

		//workflow_stage_detected
		export Glb5WrkFlowStgDetected                 := MBS_CVD(column_name = 'WORKFLOW_DETECTED', status = Mbs_ds_glb5.status,          desc_value = Mbs_ds_glb5.workflow_stage_detected )[1].description;
		export TigerWrkFlowStgDetected                := MBS_CVD(column_name = 'WORKFLOW_DETECTED', status = Mbs_ds_tiger.status,         desc_value = Mbs_ds_tiger.workflow_stage_detected )[1].description;
		export CFNAWrkFlowStgDetected                 := MBS_CVD(column_name = 'WORKFLOW_DETECTED', status = Mbs_ds_cfna.status,          desc_value = Mbs_ds_cfna.workflow_stage_detected )[1].description;
		export ainspectionWrkFlowStgDetected          := MBS_CVD(column_name = 'WORKFLOW_DETECTED', status = Mbs_ds_ainspection.status,   desc_value = Mbs_ds_ainspection.workflow_stage_detected )[1].description;
		export SuspectIPWrkFlowStgDetected            := MBS_CVD(column_name = 'WORKFLOW_DETECTED', status = Mbs_ds_SuspectIP.status,     desc_value = Mbs_ds_SuspectIP.workflow_stage_detected )[1].description;
		export TextMinedCrimWrkFlowStgDetected        := MBS_CVD(column_name = 'WORKFLOW_DETECTED', status = Mbs_ds_TextMinedCrim.status, desc_value = Mbs_ds_TextMinedCrim.workflow_stage_detected )[1].description;
		export OIGIndividualWrkFlowStgDetected        := MBS_CVD(column_name = 'WORKFLOW_DETECTED', status = Mbs_ds_OIGIndividual.status, desc_value = Mbs_ds_OIGIndividual.workflow_stage_detected )[1].description;
		export OIGBusinessWrkFlowStgDetected          := MBS_CVD(column_name = 'WORKFLOW_DETECTED', status = Mbs_ds_OIGBusiness.status,   desc_value = Mbs_ds_OIGBusiness.workflow_stage_detected )[1].description;		
	
	//channels
		export Glb5Channels                           := MBS_CVD(column_name = 'CHANNEL', status = Mbs_ds_glb5.status,          desc_value = Mbs_ds_glb5.channels )[1].description;
		export TigerChannels                          := MBS_CVD(column_name = 'CHANNEL', status = Mbs_ds_tiger.status,         desc_value = Mbs_ds_tiger.channels )[1].description;
		export CFNAChannels                           := MBS_CVD(column_name = 'CHANNEL', status = Mbs_ds_cfna.status,          desc_value = Mbs_ds_cfna.channels )[1].description;
		export ainspectionChannels                    := MBS_CVD(column_name = 'CHANNEL', status = Mbs_ds_ainspection.status,   desc_value = Mbs_ds_ainspection.channels )[1].description;
		export SuspectIPChannels                      := MBS_CVD(column_name = 'CHANNEL', status = Mbs_ds_SuspectIP.status,     desc_value = Mbs_ds_SuspectIP.channels )[1].description;
		export TextMinedCrimChannels                  := MBS_CVD(column_name = 'CHANNEL', status = Mbs_ds_TextMinedCrim.status, desc_value = Mbs_ds_TextMinedCrim.channels )[1].description;
		export OIGIndividualChannels                  := MBS_CVD(column_name = 'CHANNEL', status = Mbs_ds_OIGIndividual.status, desc_value = Mbs_ds_OIGIndividual.channels )[1].description;
		export OIGBusinessChannels                    := MBS_CVD(column_name = 'CHANNEL', status = Mbs_ds_OIGBusiness.status,   desc_value = Mbs_ds_OIGBusiness.channels )[1].description;

		//Threat
		export Glb5Threat                             := MBS_CVD(column_name = 'THREAT', status = Mbs_ds_glb5.status,          desc_value = Mbs_ds_glb5.threat )[1].description;
		export TigerThreat                            := MBS_CVD(column_name = 'THREAT', status = Mbs_ds_tiger.status,         desc_value = Mbs_ds_tiger.threat )[1].description;
		export CFNAThreat                             := MBS_CVD(column_name = 'THREAT', status = Mbs_ds_cfna.status,          desc_value = Mbs_ds_cfna.threat )[1].description;
		export ainspectionThreat                      := MBS_CVD(column_name = 'THREAT', status = Mbs_ds_ainspection.status,   desc_value = Mbs_ds_ainspection.threat )[1].description;
		export SuspectIPThreat                        := MBS_CVD(column_name = 'THREAT', status = Mbs_ds_SuspectIP.status,     desc_value = Mbs_ds_SuspectIP.threat )[1].description;
		export TextMinedCrimThreat                    := MBS_CVD(column_name = 'THREAT', status = Mbs_ds_TextMinedCrim.status, desc_value = Mbs_ds_TextMinedCrim.threat )[1].description;
		export OIGIndividualThreat                    := MBS_CVD(column_name = 'THREAT', status = Mbs_ds_OIGIndividual.status, desc_value = Mbs_ds_OIGIndividual.threat )[1].description;
		export OIGBusinessThreat                      := MBS_CVD(column_name = 'THREAT', status = Mbs_ds_OIGBusiness.status,   desc_value = Mbs_ds_OIGBusiness.threat )[1].description;
		
		//Alert_level
		export Glb5AlertLevel                         := MBS_CVD(column_name = 'ALERT_LEVEL', status = Mbs_ds_glb5.status,          desc_value = Mbs_ds_glb5.alert_level )[1].description;
		export TigerAlertLevel                        := MBS_CVD(column_name = 'ALERT_LEVEL', status = Mbs_ds_tiger.status,         desc_value = Mbs_ds_tiger.alert_level )[1].description;
		export CFNAAlertLevel                         := MBS_CVD(column_name = 'ALERT_LEVEL', status = Mbs_ds_cfna.status,          desc_value = Mbs_ds_cfna.alert_level )[1].description;
		export ainspectionAlertLevel                  := MBS_CVD(column_name = 'ALERT_LEVEL', status = Mbs_ds_ainspection.status,   desc_value = Mbs_ds_ainspection.alert_level )[1].description;
		export SuspectIPAlertLevel                    := MBS_CVD(column_name = 'ALERT_LEVEL', status = Mbs_ds_SuspectIP.status,     desc_value = Mbs_ds_SuspectIP.alert_level )[1].description;
		export TextMinedCrimAlertLevel                := MBS_CVD(column_name = 'ALERT_LEVEL', status = Mbs_ds_TextMinedCrim.status, desc_value = Mbs_ds_TextMinedCrim.alert_level )[1].description;
		export OIGIndividualAlertLevel                := MBS_CVD(column_name = 'ALERT_LEVEL', status = Mbs_ds_OIGIndividual.status, desc_value = Mbs_ds_OIGIndividual.alert_level )[1].description;
		export OIGBusinessAlertLevel                  := MBS_CVD(column_name = 'ALERT_LEVEL', status = Mbs_ds_OIGBusiness.status,   desc_value = Mbs_ds_OIGBusiness.alert_level )[1].description;
 
 //entity_type
		export Glb5EntityType                         := MBS_CVD(column_name = 'ENTITY_TYPE', status = Mbs_ds_glb5.status,          desc_value = Mbs_ds_glb5.entity_type )[1].description;
		export TigerEntityType                        := MBS_CVD(column_name = 'ENTITY_TYPE', status = Mbs_ds_tiger.status,         desc_value = Mbs_ds_tiger.entity_type )[1].description;
		export CFNAEntityType                         := MBS_CVD(column_name = 'ENTITY_TYPE', status = Mbs_ds_cfna.status,          desc_value = Mbs_ds_cfna.entity_type )[1].description;
		export ainspectionEntityType                  := MBS_CVD(column_name = 'ENTITY_TYPE', status = Mbs_ds_ainspection.status,   desc_value = Mbs_ds_ainspection.entity_type )[1].description;
		export SuspectIPEntityType                    := MBS_CVD(column_name = 'ENTITY_TYPE', status = Mbs_ds_SuspectIP.status,     desc_value = Mbs_ds_SuspectIP.entity_type )[1].description;
		export TextMinedCrimEntityType                := MBS_CVD(column_name = 'ENTITY_TYPE', status = Mbs_ds_TextMinedCrim.status, desc_value = Mbs_ds_TextMinedCrim.entity_type )[1].description;
		export OIGIndividualEntityType                := MBS_CVD(column_name = 'ENTITY_TYPE', status = Mbs_ds_OIGIndividual.status, desc_value = Mbs_ds_OIGIndividual.entity_type )[1].description;
		export OIGBusinessEntityType                  := MBS_CVD(column_name = 'ENTITY_TYPE', status = Mbs_ds_OIGBusiness.status,   desc_value = Mbs_ds_OIGBusiness.entity_type )[1].description;
		
  	//entity_sub_type
		export Glb5EntitySubType                      := MBS_CVD(column_name = 'ENTITY_SUB_TYPE', status = Mbs_ds_glb5.status,          desc_value = Mbs_ds_glb5.entity_sub_type )[1].description;
		export TigerEntitySubType                     := MBS_CVD(column_name = 'ENTITY_SUB_TYPE', status = Mbs_ds_tiger.status,         desc_value = Mbs_ds_tiger.entity_sub_type )[1].description;
		export CFNAEntitySubType                      := MBS_CVD(column_name = 'ENTITY_SUB_TYPE', status = Mbs_ds_cfna.status,          desc_value = Mbs_ds_cfna.entity_sub_type )[1].description;
		export ainspectionEntitySubType               := MBS_CVD(column_name = 'ENTITY_SUB_TYPE', status = Mbs_ds_ainspection.status,   desc_value = Mbs_ds_ainspection.entity_sub_type )[1].description;
		export SuspectIPEntitySubType                 := MBS_CVD(column_name = 'ENTITY_SUB_TYPE', status = Mbs_ds_SuspectIP.status,     desc_value = Mbs_ds_SuspectIP.entity_sub_type )[1].description;
		export TextMinedCrimEntitySubType             := MBS_CVD(column_name = 'ENTITY_SUB_TYPE', status = Mbs_ds_TextMinedCrim.status, desc_value = Mbs_ds_TextMinedCrim.entity_sub_type )[1].description;
		export OIGIndividualEntitySubType             := MBS_CVD(column_name = 'ENTITY_SUB_TYPE', status = Mbs_ds_OIGIndividual.status, desc_value = Mbs_ds_OIGIndividual.entity_sub_type )[1].description;
		export OIGBusinessEntitySubType               := MBS_CVD(column_name = 'ENTITY_SUB_TYPE', status = Mbs_ds_OIGBusiness.status,   desc_value = Mbs_ds_OIGBusiness.entity_sub_type )[1].description;

		//role
		export Glb5Role                               := MBS_CVD(column_name = 'ROLE', status = Mbs_ds_glb5.status,          desc_value = Mbs_ds_glb5.role )[1].description;
		export TigerRole                              := MBS_CVD(column_name = 'ROLE', status = Mbs_ds_tiger.status,         desc_value = Mbs_ds_tiger.role )[1].description;
		export CFNARole                               := MBS_CVD(column_name = 'ROLE', status = Mbs_ds_cfna.status,          desc_value = Mbs_ds_cfna.role )[1].description;
		export ainspectionRole                        := MBS_CVD(column_name = 'ROLE', status = Mbs_ds_ainspection.status,   desc_value = Mbs_ds_ainspection.role )[1].description;
		export SuspectIPRole                          := MBS_CVD(column_name = 'ROLE', status = Mbs_ds_SuspectIP.status,     desc_value = Mbs_ds_SuspectIP.role )[1].description;
		export TextMinedCrimRole                      := MBS_CVD(column_name = 'ROLE', status = Mbs_ds_TextMinedCrim.status, desc_value = Mbs_ds_TextMinedCrim.role )[1].description;
		export OIGIndividualRole                      := MBS_CVD(column_name = 'ROLE', status = Mbs_ds_OIGIndividual.status, desc_value = Mbs_ds_OIGIndividual.role )[1].description;
		export OIGBusinessRole                        := MBS_CVD(column_name = 'ROLE', status = Mbs_ds_OIGBusiness.status,   desc_value = Mbs_ds_OIGBusiness.role )[1].description;
		
		//evidence
		export Glb5Evidence                           := MBS_CVD(column_name = 'EVIDENCE', status = Mbs_ds_glb5.status,          desc_value = Mbs_ds_glb5.evidence )[1].description;
		export TigerEvidence                          := MBS_CVD(column_name = 'EVIDENCE', status = Mbs_ds_tiger.status,         desc_value = Mbs_ds_tiger.evidence )[1].description;
		export CFNAEvidence                           := MBS_CVD(column_name = 'EVIDENCE', status = Mbs_ds_cfna.status,          desc_value = Mbs_ds_cfna.evidence )[1].description;
		export ainspectionEvidence                    := MBS_CVD(column_name = 'EVIDENCE', status = Mbs_ds_ainspection.status,   desc_value = Mbs_ds_ainspection.evidence )[1].description;
		export SuspectIPEvidence                      := MBS_CVD(column_name = 'EVIDENCE', status = Mbs_ds_SuspectIP.status,     desc_value = Mbs_ds_SuspectIP.evidence )[1].description;
		export TextMinedCrimEvidence                  := MBS_CVD(column_name = 'EVIDENCE', status = Mbs_ds_TextMinedCrim.status, desc_value = Mbs_ds_TextMinedCrim.evidence )[1].description;
		export OIGIndividualEvidence                  := MBS_CVD(column_name = 'EVIDENCE', status = Mbs_ds_OIGIndividual.status, desc_value = Mbs_ds_OIGIndividual.evidence )[1].description;
		export OIGBusinessEvidence                    := MBS_CVD(column_name = 'EVIDENCE', status = Mbs_ds_OIGBusiness.status,   desc_value = Mbs_ds_OIGBusiness.evidence )[1].description;
		
END;		
