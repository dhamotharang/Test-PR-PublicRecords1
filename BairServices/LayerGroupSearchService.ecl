/*--SOAP--
<message name="LayerGroupSearchService">
  <part name="BAIRAgencyLayerGroupSearchRequest" type="tns:XmlDataSet" cols="70" rows="25"/>  
</message>
*/

import iesp, BairRx_Common, BairRX_MapIncident;

EXPORT LayerGroupSearchService := MACRO
	
	dIn := DATASET([], iesp.bair_agencylayer.t_BAIRAgencyLayerGroupSearchRequest) : STORED('BAIRAgencyLayerGroupSearchRequest', FEW);
	first_row := dIn[1] : independent;

	user := GLOBAL(first_row.user);
	BairRx_Common.IParam.SetInputSearchUser(user);
	
	BAIRContext := GLOBAL(first_row.BAIRContext);
	BairRx_Common.IParam.SetInputContext(BAIRContext);
	
	search_by := global(first_row.SearchBy);							
	input_params := BairRx_Common.IParam.getSearchParams(search_by, BairRx_Common.Constants.SearchType.MapIncident); 
	
	recs := BairRx_Common.GetLayerGroup(input_params);
	BairRx_Common.ECL2ESP.Marshall.MAC_Marshall_Results(recs, result, iesp.bair_agencylayer.t_BAIRAgencyLayerGroupSearchResponse, count(recs));	
	
	output(result, named('Results'));
	
ENDMACRO;