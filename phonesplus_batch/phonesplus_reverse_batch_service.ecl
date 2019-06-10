/*--SOAP--
<message name="Phone_NoReconn_Service">
  <part name="batch_in" type="tns:XmlDataSet" cols="70" rows="25"/>  
  <part name="ExcludeCurrentGong" type="xsd:boolean"/>
  <part name="DPPAPurpose" type="xsd:byte"/>
  <part name="GLBPurpose" type="xsd:byte"/> 
  <part name="IndustryClass" type="xsd:string"/>
  <part name="IncludeQsent" type="xsd:boolean"/>
	<part name="IncludeTargus" type="xsd:boolean"/>
	<part name="IncludeTargusWireless" type="xsd:boolean"/>
  <part name="Gateways" type="tns:XmlDataSet" cols="70" rows="25"/>
  <part name="DataRestrictionMask" type="xsd:string"/>
	<part name="ReturnDetailedRoyalties" type="xsd:boolean"/>	
</message>
*/
/*--INFO-- 
This is a batch version of the reverse lookup of the phonesplus query
*/

export phonesplus_reverse_batch_service := macro
	
	batchIn := dataset([],phonesplus_batch.layout_phonesplus_reverse_batch_in) : stored('batch_in',few);
	optionsModule:= phonesplus_batch.options.getOptions();
	recsOut:= phonesplus_batch.phonesplus_reverse_batch_records(batchIn, optionsModule);


  IF (exists(recsOut.Results), doxie.compliance.logSoldToTransaction(optionsModule)); 
  OUTPUT(recsOut.Results, NAMED('Results'));    
	OUTPUT(recsOut.RoyaltySet, NAMED('RoyaltySet'));
	
endmacro;
