/*--SOAP--
<message name="TxbusReport" wuTimeout="300000">
	<part name = 'BDID'			type = 'xsd:string'/>
	<part name = 'DID'			type = 'xsd:string'/>
	<part name="TaxPayerNumber" type='xsd:string' />
</message>
*/
/*--INFO-- This service searches Txbus datafiles.*/

export TxbusReportService := macro

	params := module(TxbusV2_services.Interfaces.search_params)
		export boolean is_Search := FALSE;
	END;

	// output(TxbusV2_services.TxBusSearch(params), named('Results'));

	recs := TxbusV2_services.TxBusSearch(params);
	
	doxie.MAC_Header_Field_Declare()	
	doxie.MAC_Marshall_Results(recs, recs_marshalled);
	
	OUTPUT(recs_marshalled, NAMED('Results'));

endmacro;