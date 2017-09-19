/*--SOAP--
<message name="LayerTextService">
  <part name="BAIRAgencyLayerSearchRequest" type="tns:XmlDataSet" cols="70" rows="25"/>  
</message>
*/
import iesp, BairRx_Common;

EXPORT LayerTextService := MACRO
	
	dIn := DATASET([], iesp.bair_agencylayer.t_BAIRAgencyLayerSearchRequest) : STORED('BAIRAgencyLayerSearchRequest', FEW);
	first_row := dIn[1] : independent;
	search_by := global(first_row.SearchBy);					
	
	user := GLOBAL(first_row.user);
	BairRx_Common.IParam.SetInputSearchUser(user);
	
	BAIRContext := GLOBAL(first_row.BAIRContext);
	BairRx_Common.IParam.SetInputContext(BAIRContext);
	
	recs := BairRx_Common.GetLayerText(search_by.LayerEntityIDs);
	BairRx_Common.ECL2ESP.Marshall.MAC_Marshall_Results(recs, result, iesp.bair_agencylayer.t_BAIRAgencyLayerSearchResponse, count(recs));	
	
	output(result, named('Results'));
	
ENDMACRO;