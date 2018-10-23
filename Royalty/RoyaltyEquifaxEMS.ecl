//Returns a dataset of royalties for the Equifax EMS gateway.

IMPORT FCRAGateway_Services;
EXPORT RoyaltyEquifaxEMS := MODULE
	EXPORT GetRoyalties(DATASET(FCRAGateway_Services.Layouts.equifax_ems.gateway_out) ds_gw_response) := FUNCTION
		//Any response that is not an HTTP error status will be charged, even if there is no match found.
		dRoyalOut := DATASET([{
			Royalty.Constants.RoyaltyCode.EFX_EMS,
			Royalty.Constants.RoyaltyType.EFX_EMS,
			COUNT(ds_gw_response(ds_gw_response.response._Header.Status = FCRAGateway_Services.Constants.GatewayStatus.SUCCESS)),
			0
		}],Royalty.Layouts.Royalty);

		RETURN dRoyalOut;
	END;
END;