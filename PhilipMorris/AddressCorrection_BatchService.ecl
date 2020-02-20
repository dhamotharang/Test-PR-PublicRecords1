/*--SOAP--
<message name="AddressCorrection_BatchService">	
	<part name="DPPAPurpose"          type="xsd:byte"/>
	<part name="GLBPurpose"           type="xsd:byte"/>
	<part name="ApplicationType"     	type="xsd:string"/>
	<part name="batch_in" type="tns:XmlDataSet" cols="70" rows="25"/>					
</message>
*/
import doxie, AutoStandardI;
export AddressCorrection_BatchService() := MACRO
  // used by AddrBest.BestAddr_common()
  #stored('MaxRecordsToReturn',1000)
	inputData := DATASET([], PhilipMorris.Layouts_Batch.InAddrRecord) : stored('batch_in', few);
	mod_access := doxie.compliance.GetGlobalDataAccessModuleTranslated(AutoStandardI.GlobalModule());
  
	OUTPUT(PhilipMorris.AddressCorrection_BatchService_Records(inputData,mod_access), NAMED('Results') );		
	
ENDMACRO;
// AddressCorrection_BatchService()
