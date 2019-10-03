/*--SOAP--
<message name="NCPDP_ReportService">
	<!-- COMPLIANCE SETTINGS -->
	<part name="PharmacyReportRequest" type="tns:XmlDataSet" cols="80" rows="30" />
</message>
*/

import iesp, AutoStandardI;

export NCPDP_ReportService := MACRO
	ds_in := DATASET ([], iesp.ncpdp.t_PharmacyReportRequest) : STORED('PharmacyReportRequest', FEW);
	
	first_row := ds_in[1] : INDEPENDENT;	
	iesp.ECL2ESP.Marshall.Mac_Set(first_row.options);
	iesp.ECL2ESP.SetInputUser(first_row.user);
	hasFullNCPDP := first_row.Options.IncludeFullNCPDPInfo;
	convertedInput := project(first_row.ReportBy,Healthcare_Services.NCPDP_Transforms.convertIESPtoReportInput(left));
	recs := Healthcare_Services.NCPDP_Records().getRecords(dataset([convertedInput],Healthcare_Services.NCPDP_Layouts.autokeyInput));	
	fmtRecs:=project(recs,Healthcare_Services.NCPDP_Transforms.fmtReportResults(left,hasFullNCPDP));
	// Format output to iesp
	iesp.ncpdp.t_PharmacyReportResponse format() := transform
				string q_id := '' 	 : stored ('_QueryId');
				string t_id := '' 	 : stored ('_TransactionId');
				self._Header         := ROW ({0, '', q_id, t_id, [], []}, iesp.share.t_ResponseHeader);
				self.InputEchoReportBy := first_row.ReportBy;
				self.RecordCount 		 := count(recs);
				self.PharmacyRecords := fmtRecs;
	end;

	reportRes := dataset([format()]);

	output(reportRes, named('Results'));
	
ENDMACRO;
