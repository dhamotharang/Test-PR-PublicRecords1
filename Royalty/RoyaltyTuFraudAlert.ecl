//Returns a dataset of royalties for the TuFraudAlert gateway.

IMPORT FCRAGateway_Services;
EXPORT RoyaltyTuFraudAlert := MODULE
	EXPORT GetRoyalties(DATASET(FCRAGateway_Services.Layouts.tu_fraud_alert.gateway_out) ds_gw_response) := FUNCTION
		//In the SOAPCALL, any response which incurs a charge is given a status of SUCCESS
		dRoyalOut := DATASET([{
			Royalty.Constants.RoyaltyCode.TU_FRAUD_ALERT,
			Royalty.Constants.RoyaltyType.TU_FRAUD_ALERT,
			COUNT(ds_gw_response(ds_gw_response.response._Header.Status = FCRAGateway_Services.Constants.GatewayStatus.SUCCESS)),
			0
		}],Royalty.Layouts.Royalty);

		RETURN dRoyalOut;
	END;
END;