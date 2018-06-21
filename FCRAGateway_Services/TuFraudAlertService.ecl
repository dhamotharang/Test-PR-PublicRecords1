//This service was implemented in ticket RR-12334. The interface was kept as the G-ESP format for legacy compatibility.
//There was logic on the ESP layer which converted their T-ESP to G-ESP without going through roxie. Keeping the T-ESP
//interface required translating the ESP logic to ECL, and it was implemented a long enough time ago that questions
//could not be answered. It was decided to maintain the logic on the ESP layer as is.

IMPORT AutoStandardI, FFD, FCRA, FCRAGateway_Services, iesp;

EXPORT TuFraudAlertService := MACRO

	rec_in := iesp.tu_fraud_alert.t_TuFraudAlertRequest;
	_ds_in := DATASET ([], rec_in) : STORED ('TuFraudAlertRequest', FEW);
	first_row := _ds_in[1] : INDEPENDENT;
	iesp.ECL2ESP.SetInputUser(first_row.user);

	//Adds defaults values for easier roxie testing if options is set to true. False by default.
	ds_in := IF(first_row.options.UseRoxieDefaults,
		PROJECT(_ds_in, FCRAGateway_Services.TuFraudAlert_Transforms.set_request_defaults(LEFT)), _ds_in);

	isFCRA := TRUE;

	in_mod := MODULE(project(AutoStandardI.GlobalModule(isFCRA), FCRAGateway_Services.IParam.common_params, opt))
		EXPORT FFDOptionsMask := FFD.FFDMask.Get(first_row.options.FFDOptionsMask);
		EXPORT FCRAPurpose := FCRA.FCRAPurpose.Get(first_row.options.FCRAPurpose);
		EXPORT dataset(Gateway.Layouts.Config) gateways := Gateway.Configuration.Get();
		EXPORT ReturnMatchedUniqueIDsOnly := first_row.options.ReturnMatchedUniqueIDsOnly;
	END;

	//Use request with defaults if option is selected.
	ds_tufa_recs := FCRAGateway_Services.TuFraudAlert_Records(ds_in, in_mod);

	//Add the service layer header info.
	ds_final := PROJECT(ds_tufa_recs[1].response, FCRAGateway_Services.TuFraudAlert_Transforms.add_service_header(LEFT));

	ds_royalties := ds_tufa_recs[1].Royalties;
	OUTPUT(ds_final, NAMED('Results'));
	OUTPUT(ds_royalties, NAMED('RoyaltySet'));

ENDMACRO;