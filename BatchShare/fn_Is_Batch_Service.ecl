//This function can be called to determine if the service running is a batch service or not.
//Currently used to ensure that batch services hit a different address cleaner port than the online esp services.
//I couldn't place this function in BatchShare.Functions because of recursive dependencies
IMPORT BatchShare, ut, STD;
EXPORT fn_Is_Batch_Service() := FUNCTION
	 running_service_name := ut.GetQueryName(); // service name in lowercase
	 is_running_service_Batch := STD.Str.Contains(running_service_name, 'batch', TRUE) OR
															 running_service_name IN BatchShare.Constants.SET_BatchServices_named_without_batch;
	 // OUTPUT(is_running_service_Batch,named('fn_Is_Batch_Service'));
	 RETURN is_running_service_Batch;
END;