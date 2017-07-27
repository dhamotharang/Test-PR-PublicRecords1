/*--SOAP--
<message name="SearchService">
	<!-- COMPLIANCE SETTINGS -->
	<part name="ABMSSearchRequest" type="tns:XmlDataSet" cols="80" rows="30" />

</message>
*/

import iesp, AutoStandardI;

export SearchService := MACRO
	ds_in := DATASET ([], iesp.abms.t_ABMSSearchRequest) : STORED('ABMSSearchRequest', FEW);
	
	first_row := ds_in[1] : INDEPENDENT;	
	iesp.ECL2ESP.Marshall.Mac_Set(first_row.options);
	iesp.ECL2ESP.SetInputUser(first_row.user);	  
	iesp.ECL2ESP.SetInputReportBy (ROW (first_row.searchBy, transform (iesp.bpsreport.t_BpsReportBy, Self := Left, Self := [])));
	unsigned2 PenaltThreshold := 10 :stored('PenaltyThreshold');
	#stored ('PenaltThreshold', PenaltThreshold);	
	doxie.MAC_Header_Field_Declare();

	convertedInput := project(first_row.searchBy,Healthcare_ABMS.Transforms.convertIESPtoAKInput(left,false,false,false,GLB_Purpose,DPPA_Purpose));
	recs := Healthcare_ABMS.Raw.getRecords(dataset([convertedInput],Healthcare_ABMS.Layouts.autokeyInput),GLB_Purpose,DPPA_Purpose,PenaltThreshold);	

	// iesp.abms.t_ABMSSearchResponse format() := transform
				// string q_id := '' 	 : stored ('_QueryId');
				// string t_id := '' 	 : stored ('_TransactionId');
				// self._Header         := ROW ({0, '', q_id, t_id, []}, iesp.share.t_ResponseHeader);
				// self.SearchBy				 := first_row.searchBy;
				// self.RecordCount 		 := count(recs);
				// self.Records := choosen(project(Recs,iesp.abms.t_ABMSResults),iesp.Constants.HPR.Max_Cnt_Search);
	// end;

	// Results := dataset([format()]);
	iesp.ECL2ESP.Marshall.MAC_Marshall_Results(project(Recs,iesp.abms.t_ABMSResults), results, iesp.abms.t_ABMSSearchResponse,Records,false,RecordCount,SearchBy,first_row.searchBy);

	output(Results, named('Results'));
	
ENDMACRO;
