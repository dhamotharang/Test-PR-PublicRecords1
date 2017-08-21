/*--SOAP--
<message name="ClassificationService">
  <part name="BAIRClassificationRequest" type="tns:XmlDataSet" cols="70" rows="25"/>  
</message>
*/
import iesp, BairRx_Common;

EXPORT ClassificationService := MACRO
	
	dIn := DATASET([], iesp.bair_classification.t_BAIRClassificationSearchRequest) : STORED('BAIRClassificationSearchRequest', FEW);
	first_row := dIn[1] : independent;
	search_by := GLOBAL(first_row.SearchBy);					
	
	BAIRContext := GLOBAL(first_row.BAIRContext);
	BairRx_Common.IParam.SetInputContext(BAIRContext);

	user := GLOBAL(first_row.user);
	BairRx_Common.IParam.SetInputSearchUser(user);
	
	agencyORI := '' : STORED('AgencyORI');
	
	recs := BairRx_Common.GetClassification(TRIM(agencyORI,LEFT,RIGHT),search_by.mode);
	BairRx_Common.ECL2ESP.Marshall.MAC_Marshall_Results(recs, result, iesp.bair_classification.t_BAIRClassificationSearchResponse, count(recs),noPaging:=TRUE);	

	OUTPUT(result, named('Results'));
	
ENDMACRO;