/*--SOAP--
<message name="ConsumerSearchService">
	<part name="Gateways"                  type="tns:XmlDataSet" cols="70" rows="4"/>
	<part name="fcraConsumerSearchRequest" type="tns:XmlDataSet" cols="70" rows="25"/>
</message>
*/

IMPORT FFD_Services, iesp, WSInput;

WSInput.MAC_FDD_ConsumerSearchService();

EXPORT ConsumerSearchService() := FUNCTION

	reqRec := iesp.fcraConsumer.t_SearchRequest;
	ds_xml := DATASET([],reqRec) : STORED('fcraConsumerSearchRequest',FEW);
	firstRow := ds_xml[1];
	iesp.ECL2ESP.SetInputUser(firstRow.User);

	results := FFD_Services.ConsumerRecords(firstRow);

	RETURN OUTPUT(results,NAMED('Results'));

END;
