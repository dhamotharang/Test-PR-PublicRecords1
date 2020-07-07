/*--SOAP--
<message name="Did_Batch_Service">
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

export DID_Batch_Service := macro

inf_v1 := dataset([], DidVille.Layout_Did_InBatch_v1) : stored('did_batch_in',few);
inf := project(inf_v1, transform(DidVille.Layout_Did_InBatch, SELF := LEFT;));

recs := DidVille.DID_Batch_Service_Records(inf);
recs_v1 := project(recs, transform(DidVille.Layout_Did_OutBatch_v1, SELF := LEFT;));

output(recs_v1,named('Result'));

endmacro;
