IMPORT FCRAGateway_Services;
EXPORT Functions := MODULE
	EXPORT GetValidationCode(unsigned6 inDid, unsigned6 outDid) := FUNCTION
		RETURN MAP(
				inDid = 0 => FCRAGateway_Services.Constants.ValidationCode.INPUT_DID_NOTFOUND,
				outDid = 0 => FCRAGateway_Services.Constants.ValidationCode.OUTPUT_DID_NOTFOUND,
				inDid <> outDid => FCRAGateway_Services.Constants.ValidationCode.DID_MISMATCH,
				inDid = outDid => FCRAGateway_Services.Constants.ValidationCode.DID_MATCH, 0);
	END;

	EXPORT IsValidationOk(integer code) := FUNCTION
		RETURN code = FCRAGateway_Services.Constants.ValidationCode.DID_MATCH;
	END;
END;