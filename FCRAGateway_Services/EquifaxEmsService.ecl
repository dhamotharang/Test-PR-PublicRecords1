IMPORT AutoStandardI, FFD, FCRA, iesp;

EXPORT EquifaxEmsService := MACRO

	rec_in := iesp.mergedcreditreport_fcra.t_FcraMergedCreditReportRequest;
	ds_in := DATASET ([], rec_in) : STORED ('FcraMergedCreditReportRequest', FEW);
	first_row := ds_in[1] : INDEPENDENT;
	iesp.ECL2ESP.SetInputUser(first_row.user);

	isFCRA := TRUE;

	in_mod := MODULE(project(AutoStandardI.GlobalModule(isFCRA), FCRAGateway_Services.IParam.common_params, opt))
		EXPORT FFDOptionsMask := FFD.FFDMask.Get(first_row.options.FFDOptionsMask);
		EXPORT FCRAPurpose := FCRA.FCRAPurpose.Get(first_row.options.FCRAPurpose);
		EXPORT dataset(Gateway.Layouts.Config) gateways := Gateway.Configuration.Get();
	END;

	ds_ems_recs := FCRAGateway_Services.EquifaxEms_Records(ds_in, in_mod);

	//separate the transform, keep header information from resposne
	final_layout := iesp.mergedcreditreport_fcra.t_FcraMergedCreditReportResponse;
	final_layout to_final(FCRAGateway_Services.Layouts.equifax_ems.records_out L) := TRANSFORM
			SELF.errorInfo := L.response.emsResponse.errorInfo;
			//Keep the response status, message, and exceptions but use the query transactionID and queryID
			SELF._header := PROJECT(iesp.ECL2ESP.GetHeaderRow(), TRANSFORM(iesp.share.t_ResponseHeader,
				SELF.status := L.response._header.status,
				SELF.message := L.response._header.message,
				SELF.exceptions := L.response._header.exceptions,
				SELF := LEFT
			));
			SELF.validation := L.unique_validation;
			SELF.borrower := L.response.emsResponse.borrower;
			SELF.pdfReport := L.response.emsResponse.pdfReport;
			SELF.mergedCreditReport := L.response.emsResponse.creditReports;
			SELF.consumerStatements := L.consumerStatements;
			SELF.consumerAlerts := L.consumerAlerts;
			SELF.consumer := L.consumer;
			SELF := L.response.emsResponse;
			SELF := [];
	END;

	ds_final := PROJECT(ds_ems_recs, to_final(LEFT));
	ds_royalties := ds_ems_recs[1].Royalties;
	OUTPUT(ds_final, NAMED('Results'));
	OUTPUT(ds_royalties, NAMED('RoyaltySet'));

ENDMACRO;