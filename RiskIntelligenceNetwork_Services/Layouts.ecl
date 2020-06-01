IMPORT Advo_Services, BatchShare, CriminalRecords_BatchService, DidVille, DriversV2_Services, 
 dx_PhonesInfo, FraudShared_Services, risk_indicators;

EXPORT Layouts := MODULE

 EXPORT fragment_w_value_recs := RECORD
  BatchShare.Layouts.ShareAcct;
  STRING60 fragment;
  STRING100 fragment_value;
 END;

 EXPORT entity_uid_recs := RECORD
  fragment_w_value_recs;
  STRING70 entity_context_uid := '';
 END;

 EXPORT entity_uid_recs_w_risk := RECORD
  entity_uid_recs;
  boolean hasKnownRisk;
  string10 RiskLevel;
 END; 

 EXPORT dids_recs := RECORD 
  DidVille.Layout_Did_OutBatch;
  string30 RecordSource;
 END;

 EXPORT dl_layout := RECORD
  BatchShare.Layouts.ShareAcct;
  DriversV2_Services.layouts.result_narrow;
 END;

 EXPORT realtime_appends_rec := RECORD
  FraudShared_Services.Layouts.BatchIn_rec batchin_rec;
  DATASET(CriminalRecords_BatchService.Layouts.batch_out) crim_appends;
  DATASET(Advo_Services.Advo_Batch_Service_Layouts.Batch_Out) advo_appends;
  DATASET(DidVille.Layout_Did_OutBatch) pr_best_appends;
  DATASET(dx_PhonesInfo.Layouts.Phones_Type_Main) prepaid_phone_appends;
  DATASET(dl_layout) dl_appends;
  DATASET(risk_indicators.Layout_Boca_Shell) boca_shell_appends;
 END;

END;