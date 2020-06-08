IMPORT FraudShared_Services;

EXPORT fn_postautokey_joins(DATASET(FraudShared_Services.Layouts.BatchIn_rec) ds_batch_in,
                            string fraud_platform = RiskIntelligenceNetwork_Services.Constants.FRAUD_PLATFORM) := FUNCTION

 ds_autoKeys := FraudShared_Services.AutoKey_IDs(ds_batch_in, fraud_platform);

 ds_auto := PROJECT(ds_autoKeys, TRANSFORM(FraudShared_Services.Layouts.Recid_rec,
                                    SELF.entity_type_id := LEFT.classification_Entity.Entity_type_id,
                                    SELF.entity_sub_type_id := LEFT.classification_Entity.entity_sub_type_id,
                                    SELF := LEFT,
                                    SELF := []));
 RETURN ds_auto;
END;
