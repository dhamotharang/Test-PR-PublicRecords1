IMPORT iesp , Royalty;

EXPORT Layouts := MODULE

   //export common_request := iesp.employment_verification_fcra.t_FcraVerificationOfEmploymentReportRequest;
   
  EXPORT gateway_employee := iesp.equifax_evs.t_TsVEmployee_V100;
   
  EXPORT gateway_response := iesp.equifax_evs.t_EquifaxEvsResponse;
   
  EXPORT gateway_record := iesp.equifax_evs.t_TsVResponse_V100;
  
  EXPORT record_out := RECORD
    UNSIGNED LexID;
    iesp.share.t_ResponseHeader eq_Header;
    DATASET(iesp.equifax_evs.t_EquifaxEvsResponseEx) GWResponse;
    DATASET(iesp.share_fcra.t_ConsumerStatement) ConsumerStatements;
    DATASET(iesp.share_fcra.t_ConsumerAlert) ConsumerAlerts;
    iesp.share_fcra.t_FCRAConsumer Consumer;
    DATASET(Royalty.Layouts.Royalty) Royalty;
    iesp.share.t_CodeMap Validation;
  END;
 
END;
