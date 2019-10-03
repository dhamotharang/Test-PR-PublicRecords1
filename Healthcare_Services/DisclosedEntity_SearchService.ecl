/*--SOAP--
<message name="DisclosedEntity_SearchService">
	<!-- COMPLIANCE SETTINGS -->
	<part name="DisclosedEntitySearchRequest" type="tns:XmlDataSet" cols="80" rows="30" />

</message>
*/

import iesp, AutoStandardI,doxie;

export DisclosedEntity_SearchService := MACRO
	ds_in := DATASET ([], iesp.disclosed_entity_search.t_DisclosedEntitySearchRequest) : STORED('DisclosedEntitySearchRequest', FEW);
	
	first_row := ds_in[1] : INDEPENDENT;	
	iesp.ECL2ESP.Marshall.Mac_Set(first_row.options);
	iesp.ECL2ESP.SetInputUser(first_row.user);
	doxie.MAC_Header_Field_Declare();


	convertedInput := project(first_row.searchBy,Healthcare_Services.DisclosedEntity_Transforms.convertIESPtoFlatInput(left,GLB_Purpose,DPPA_Purpose,AutoStandardI.GlobalModule().DataRestrictionMask));
	recs := Healthcare_Services.DisclosedEntity_Records.getRecords(dataset([convertedInput],Healthcare_Services.DisclosedEntity_Layouts.flatInput),GLB_Purpose,DPPA_Purpose,AutoStandardI.GlobalModule().DataRestrictionMask);	
	fmtRecs:=project(recs,Healthcare_Services.DisclosedEntity_Transforms.fmtResults(left,first_row.searchBy));
	// Format output to iesp
	iesp.disclosed_entity_search.t_DisclosedEntitySearchResponse format() := transform
				string q_id := '' 	 : stored ('_QueryId');
				string t_id := '' 	 : stored ('_TransactionId');
				self._Header         := ROW ({0, '', q_id, t_id, [], []}, iesp.share.t_ResponseHeader);
				self.SearchBy				 := first_row.searchBy;
				self.RecordCount 		 := count(recs);
				self.Records := fmtRecs;
	end;

	searchRes := dataset([format()]);

	output(searchRes, named('Results'));
	
ENDMACRO;
