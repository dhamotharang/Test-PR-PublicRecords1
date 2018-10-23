IMPORT iesp, Gateway, FCRA, FCRAGateway_Services;

EXPORT GetTufaPicklistVerification(DATASET(iesp.tu_fraud_alert.t_TuFraudAlertResponseEx) ds_tufa_soap_response,
	iesp.share.t_User user) := FUNCTION

		soap_response := ds_tufa_soap_response[1].response;
		is_soap_call_ok := ~EXISTS(soap_response._header.Exceptions);

		//If we have a valid gateway response call picklist to retrieve a DID.
		tufa_plist_req := IF(is_soap_call_ok, PROJECT(DATASET(soap_response),
			FCRAGateway_Services.TuFraudAlert_Transforms.output_to_picklist(LEFT, user)));

		FCRA.MAC_GetPickListRecords(tufa_plist_req, tufa_plist_resp, TRUE);

		//Picklist with noFail will return a header message if there are errors.
		is_plist_ok := tufa_plist_resp[1]._header.message = '';

		//If we have a soapcall or picklist error make the lexID zero.
		plist_lexID := IF(is_soap_call_ok AND is_plist_ok, (unsigned6)tufa_plist_resp[1].Records[1].UniqueId, 0);

		ds_tufa_with_picklist_response := PROJECT(ds_tufa_soap_response, TRANSFORM(FCRAGateway_Services.Layouts.tu_fraud_alert.gateway_out,
			SELF.lexID := plist_lexID;
			SELF.response := LEFT.response;
			));

		#IF(FCRAGateway_Services.Constants.Debug.TuPicklistVerification)
			output(tufa_plist_req, NAMED('tufa_plist_req'));
			output(tufa_plist_resp, NAMED('tufa_plist_resp'));
			output(ds_tufa_with_picklist_response, NAMED('ds_tufa_with_picklist_response'));
		#END

		RETURN ds_tufa_with_picklist_response;
END;