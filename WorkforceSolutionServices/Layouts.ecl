import iesp , Royalty;

EXPORT Layouts := module

 	//export common_request :=  iesp.employment_verification_fcra.t_FcraVerificationOfEmploymentReportRequest;
 	
	export gateway_employee := iesp.equifax_evs.t_TsVEmployee_V100;
 	
	export gateway_response := iesp.equifax_evs.t_EquifaxEvsResponse;
 	
	export gateway_record := iesp.equifax_evs.t_TsVResponse_V100;
  
  export	record_out := record
			unsigned LexID;	
      iesp.share.t_ResponseHeader eq_Header; 
			dataset(iesp.equifax_evs.t_EquifaxEvsResponseEx) GWResponse;
			dataset(iesp.share_fcra.t_ConsumerStatement) ConsumerStatements; 
			dataset(iesp.share_fcra.t_ConsumerAlert) ConsumerAlerts; 
			iesp.share_fcra.t_FCRAConsumer Consumer; 
			dataset(Royalty.Layouts.Royalty) Royalty;
			iesp.share.t_CodeMap Validation;
		end;

 
end;