/*--SOAP--
<message name="DayBatchPCNSR">
	<part name="batch_in" type="tns:XmlDataSet" cols="70" rows="25"/>
	<part name="search" type="xsd:string"/>
	<part name="DataRestrictionMask" type="xsd:string"/>
</message>



*/
/*--INFO-- This service runs the following searches on PCNSR/InfoUSA file:<BR>
	AC2A:						Hits on 'FL13Z','FL137Z','L137Z','L13Z'<BR>
	AC2B: 					Hits on '137Z','F137Z','13Z','F13Z'<BR>
	AC4A: 					Hits on 'FLP','LP','FP'<BR>
	AC03: 					Hits on 'Z','FLZ','FZ'<BR>
	AC04: 					Hits on 'LZ','FLZ'<BR>
	PHA1: 					Hits on 'FL137Z','FL13Z','L137Z','L13Z','F137Z','F13Z','137Z','13Z'<BR>
	USPAGE_FL137Z: 	Hits on 'FL137Z','FL13Z','L137Z','L13Z','137Z','13Z','FL3Z','L3Z'<BR>
	USPAGE_FL13Z: 	Hits on 'FL137Z','FL13Z','L137Z','L13Z','137Z','13Z','FL3Z','L3Z','F137Z','F13Z'<BR>
	PH50:						This option retired.  bug 105419.
	<BR>
	<B>NOTE:</B>		This service expects clean inputs<BR>
*/

export BatchPCNSRPhoneSearchService := MACRO
	STRING20 searchType := '' : STORED('search');

	in_format := DayBatchPCNSR.Layout_clean_in;

	cleanInput := dataset([],in_format) : stored('batch_in',few);
	
	//See Comment in DayBatchUtils.MAC_RemoveUncleanCityZip
	DayBatchUtils.MAC_RemoveUncleanCityZip(cleanInput,reallyCleanInput);
	
	FinalOutput := DayBatchPCNSR.Fetch_Batch_PCNSR_Full(reallyCleanInput,searchType);
	
	
	OUTPUT(FinalOutput, NAMED('Dataset'));
	
ENDMACRO;