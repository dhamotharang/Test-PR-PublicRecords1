IMPORT iesp, Gateway, FCRA, FCRAGateway_Services;

EXPORT GetEquifaxPicklistVerification(DATASET(iesp.equifax_ems.t_EquifaxEmsResponseEx) ds_ems_soap_response) := FUNCTION

	soap_response := ds_ems_soap_response[1].response;
	is_soap_call_ok := ~EXISTS(soap_response._header.Exceptions);

	//Transform to convert gateway response PII into a picklist request.
	iesp.person_picklist.t_PersonPickListRequest toPickList(iesp.equifax_ems.t_EquifaxEmsResponse resp) := TRANSFORM
		SELF.SearchBy := resp.EmsResponse.borrower;
		SELF := [];
	END;

	//If we have a valid gateway response call picklist to retrieve a DID.
	ems_plist_req := IF(is_soap_call_ok, DATASET([toPickList(soap_response)]));
	FCRA.MAC_GetPickListRecords(ems_plist_req, ems_plist_resp, TRUE);

	//Picklist with noFail will return a header message if there are errors.
	is_plist_ok := ems_plist_resp[1]._header.message = '';

	//If we have a picklist or soapcall error make the lexID zero.
	plist_lexID := IF(is_plist_ok AND is_soap_call_ok, (unsigned6)ems_plist_resp[1].Records[1].UniqueId, 0);

	ds_ems_with_picklist_response := PROJECT(ds_ems_soap_response, TRANSFORM(FCRAGateway_Services.Layouts.equifax_ems.gateway_out,
		SELF.lexID := plist_lexID;
		SELF.response := LEFT.response;
		));

	#IF(FCRAGateway_Services.Constants.Debug.EquifaxEmsGateway)
		output(ems_plist_req, NAMED('ems_plist_req'));
		output(ems_plist_resp, NAMED('ems_plist_resp'));
		output(ds_ems_with_picklist_response, NAMED('ds_ems_with_picklist_response'));
	#END

	RETURN ds_ems_with_picklist_response;
END;