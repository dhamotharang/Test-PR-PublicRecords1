import iesp , Royalty;

EXPORT Layouts := module

 	//export common_request :=  iesp.employment_verification_fcra.t_FcraVerificationOfEmploymentReportRequest;
 	
	export gateway_employee := iesp.equifax_evs.t_TsVEmployee_V100;
 	
	export gateway_response := iesp.equifax_evs.t_EquifaxEvsResponse;
 	
	export gateway_record := iesp.equifax_evs.t_TsVResponse_V100;
 
end;