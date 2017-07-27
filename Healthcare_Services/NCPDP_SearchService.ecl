/*--SOAP--
<message name="NCPDP_SearchService">
	<!-- COMPLIANCE SETTINGS -->
	<part name="PharmacySearchRequest" type="tns:XmlDataSet" cols="80" rows="30" />
</message>
*/

import iesp, AutoStandardI;

export NCPDP_SearchService := MACRO
	ds_in := DATASET ([], iesp.ncpdp.t_PharmacySearchRequest) : STORED('PharmacySearchRequest', FEW);
	
	first_row := ds_in[1] : INDEPENDENT;	
	iesp.ECL2ESP.Marshall.Mac_Set(first_row.options);
	iesp.ECL2ESP.SetInputUser(first_row.user);
	hasFullNCPDP := first_row.Options.IncludeFullNCPDPInfo;
	convertedInput := project(first_row.searchBy,Healthcare_Services.NCPDP_Transforms.convertIESPtoSearchInput(left));
	recs := Healthcare_Services.NCPDP_Records().getRecords(dataset([convertedInput],Healthcare_Services.NCPDP_Layouts.autokeyInput));	
	fmtRecs:=project(recs,Healthcare_Services.NCPDP_Transforms.fmtSearchResults(left,hasFullNCPDP));
	// Format output to iesp
	// iesp.ncpdp.t_PharmacySearchResponse format() := transform
				// string q_id := '' 	 : stored ('_QueryId');
				// string t_id := '' 	 : stored ('_TransactionId');
				// self._Header         := ROW ({0, '', q_id, t_id, []}, iesp.share.t_ResponseHeader);
				// self.InputEchoSearchBy := first_row.searchBy;
				// self.RecordCount 		 := count(recs);
				// self.PharmacyRecords := fmtRecs;
	// end;

	// searchRes := dataset([format()]);
	iesp.ECL2ESP.Marshall.MAC_Marshall_Results(fmtRecs, results, iesp.ncpdp.t_PharmacySearchResponse,PharmacyRecords,false,RecordCount,InputEchoSearchBy,first_row.searchBy);

	output(results, named('Results'));
	
ENDMACRO;
