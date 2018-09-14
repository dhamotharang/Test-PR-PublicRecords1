IMPORT FFD, FCRA, Gateway;

EXPORT ConsumerInitiatedActivities := MODULE

  EXPORT Get(UNSIGNED LexId,
             UNSIGNED FFDOptionsMask,
             UNSIGNED FCRAPurpose,
             DATASET (Gateway.Layouts.Config) gateways = Gateway.Constants.void_gateway,
             SET OF STRING data_group_set = [],
             BOOLEAN isReseller = FALSE, 
             BOOLEAN ReturnPC = FALSE) := FUNCTION

  //Get PersonContext records which contain all consumer statements, alerts and other activities.
  ds_dids := DATASET([{FFD.Constants.SingleSearchAcctno, LexId}], FFD.Layouts.DidBatch);
  ds_person_context := IF(LexId > 0, FFD.FetchPersonContext(ds_dids, gateways, data_group_set, FFDOptionsMask));

  BOOLEAN showConsumerStatements := FFD.FFDMask.isShowConsumerStatements(FFDOptionsMask);
  ds_consumer_statements := IF(ShowConsumerStatements, FFD.prepareConsumerStatements(ds_person_context),FFD.Constants.BlankConsumerStatements);

  //Check if we need to suppress the report due to consumer alerts.
  alert_indicators := FFD.ConsumerFlag.getAlertIndicators(ds_person_context, FCRAPurpose, FFDOptionsMask, isReseller)[1];
  ds_consumer_alerts := FFD.ConsumerFlag.prepareAlertMessages(ds_person_context, alert_indicators, FFDOptionsMask);

  //Bundle the results so we can return them in a dataset.
  FFD.Layouts.CIA_data xform_bundle() := TRANSFORM
    SELF.suppress_records := alert_indicators.suppress_records;
    SELF.ConsumerAlerts := ds_consumer_alerts;
    SELF.ConsumerStatements := ds_consumer_statements;
    SELF.PersonContext := IF(ReturnPC, ds_person_context);
  END;
  
  ds_cia_out := DATASET([xform_bundle()]);
    

/*
    OUTPUT(ds_person_context,NAMED('ds_person_context'));
    OUTPUT(ds_consumer_statements,NAMED('ds_consumer_statements'));
    OUTPUT(ds_consumer_alerts,NAMED('ds_consumer_alerts'));
    OUTPUT(ds_cia_out,NAMED('ds_cia_out'));
*/

  RETURN ds_cia_out;
  END;
  
END;