/*--SOAP--
<message name="ImageService">
  <part name="BAIRImageRequest" type="tns:XmlDataSet" cols="70" rows="25"/>  
</message>
*/
import iesp, BairRx_Common;

EXPORT ImageService := MACRO
	
	dIn := DATASET([], iesp.bair_image.t_BAIRImageRequest) : STORED('BAIRImageRequest', FEW);
	first_row := dIn[1] : independent;
	search_by := global(first_row.SearchBy);					
	
	user := GLOBAL(first_row.user);
	BairRx_Common.IParam.SetInputSearchUser(user);
	
	BAIRContext := GLOBAL(first_row.BAIRContext);
	BairRx_Common.IParam.SetInputContext(BAIRContext);
	
	recs := BairRx_Common.GetImages(search_by.EntityIDs);
	BairRx_Common.ECL2ESP.Marshall.MAC_Marshall_Results(recs, result, iesp.bair_image.t_BAIRImageResponse, count(recs));	
	
	output(result, named('Results'));
	
ENDMACRO;