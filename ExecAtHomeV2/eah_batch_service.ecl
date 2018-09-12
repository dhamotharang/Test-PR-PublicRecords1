/*--SOAP--
<message name="EAHBatchService">
  <part name="batch_in" type="tns:XmlDataSet" cols="70" rows="25"/>  
	<part name="DataRestrictionMask" type="xsd:string" default="00000000000"/>
	<part name="DataPermissionMask" type="xsd:string"/>
  <part name="DPPAPurpose" type="xsd:byte" default="1"/>
	<part name="GLBPurpose" type="xsd:byte" default="1"/>
  <part name="LNBranded" type="xsd:boolean"/>	 
	<part name="BIPFetchLevel" type="xsd:string"/>
	<part name="ReturnExecutivesOnly" type="xsd:boolean"/>
</message>
*/
/*--INFO-- This service returns comprehensive information of executives for input business.*/
IMPORT execathomev2;

EXPORT eah_batch_service := MACRO

ds_in_raw := DATASET([],execathomev2.Layouts.layoutBatchIn) : STORED('batch_in',FEW);
BatchShare.MAC_CapitalizeInput(ds_in_raw,ds_in);

inMod := ExecAtHomeV2.IParams.getBatchParams();

dsResults := ExecAtHomeV2.eah_batch_service_records(inMod, ds_in);

OUTPUT(dsResults, NAMED('Results'));

ENDMACRO;