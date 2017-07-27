IMPORT Suppress;

EXPORT Common_Suppress(DATASET(FraudShared_Services.Layouts.Raw_Payload_rec) filtered) := FUNCTION

  // Don't return records for certain DIDs
  Suppress.MAC_Suppress(filtered,recs_pulled0,Suppress.Constants.ApplicationTypes.DEFAULT,Suppress.Constants.LinkTypes.DID,did);
		
  // Don't return records for certain SSNs
  Suppress.MAC_Suppress(recs_pulled0,recs_pulled1,Suppress.Constants.ApplicationTypes.DEFAULT,Suppress.Constants.LinkTypes.SSN,ssn);		
		
  // Don't return records for certain FDN Record ID
  Suppress.MAC_Suppress(recs_pulled1,recs_pulled2,Suppress.Constants.ApplicationTypes.DEFAULT,,,Suppress.Constants.DocTypes.FDN_ID,Record_ID); 		

  // Supress criminal records
  Suppress.MAC_Suppress(recs_pulled2,recs_pulled,Suppress.Constants.ApplicationTypes.DEFAULT,,,Suppress.Constants.DocTypes.OffenderKey, offender_key);

  RETURN recs_pulled;

END;