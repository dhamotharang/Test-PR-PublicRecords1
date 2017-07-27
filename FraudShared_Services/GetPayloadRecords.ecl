IMPORT FraudShared;

EXPORT GetPayloadRecords(
  DATASET(FraudShared_Services.Layouts.Recid_rec) ds_ids,
  string fraud_platform
) := FUNCTION

  // JOIN RECORD_ID with Payload
  results := JOIN(
    ds_ids, FraudShared.Key_Id(fraud_platform),
    KEYED(LEFT.RECORD_ID = RIGHT.RECORD_ID),
		TRANSFORM(FraudShared_Services.Layouts.Raw_Payload_rec, 
		  SELF.acctno := LEFT.acctno,
			SELF := RIGHT,
			SELF := LEFT),
		LIMIT(FraudShared_Services.Constants.MAX_RECS_ON_JOIN, SKIP));

    // OUTPUT(results, NAMED('GetPayloadRecords'));
    RETURN results;
END;
