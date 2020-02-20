/*--SOAP--
<message name="Did_Batch_Service_v2">
  <part name="did_batch_in" type="tns:XmlDataSet" cols="70" rows="25"/>
  <part name="Appends" type="xsd:string"/>
  <part name="Verify" type="xsd:string"/>
  <part name="Fuzzies" type="xsd:string"/>
  <part name="Lookups" type="xsd:boolean"/>
  <part name="LivingSits" type="xsd:boolean"/>
  <part name="Deduped" type="xsd:boolean"/>
  <part name="AppendThreshold" type="xsd:string"/>
  <part name="GLBData" type="xsd:boolean"/>
  <part name="PatriotProcess" type="xsd:boolean"/>
  <part name="DataRestrictionMask" type="xsd:string"/>
	<part name="GLBPurpose" type="xsd:byte"/>
	<part name="IncludeMinors" type="xsd:boolean"/>
	<part name="ApplicationType" type="xsd:string"/>
	<part name="xADLVersion" type="xsd:integer"/>
  <part name="usePreLab" type="xsd:boolean"/>
</message>
*/
/*--INFO-- This service returns dids based upon a set of personal data.*/

import DidVille;

// moving this code from DidVille.DID_Batch_Service due to layout change limitation (service is called through roxie pipe)
export DID_Batch_Service_v2 := macro

inf := dataset([], DidVille.Layout_Did_InBatch) : stored('did_batch_in',few);
recs := DidVille.DID_Batch_Service_Records(inf);
output(recs,named('Result'));

endmacro;
