/*--SOAP--
	<message name = "CLICKDATA_RELATIVES_SERVICE">
		<part name = 'batch_in' type = 'tns:XmlDataSet' cols = '70' rows = '25' />
		<part name = 'AppendBests' type = 'xsd:boolean'/>
        <part name="DataRestrictionMask" type="xsd:string"/>
				<part name="ApplicationType"     	type="xsd:string"/>
	</message>
*/
/*--INFO-- This is the Clickdata Relatives Service. */

import AutoStandardI;
export ClickData_Relatives_Service := macro

	df := dataset([],clickdata.Layout_Clickdata_In_RR) : stored('batch_in',few);
	ab := false : stored('AppendBests');
	appType := AutoStandardI.InterfaceTranslator.application_type_val.val(project(AutoStandardI.GlobalModule(),AutoStandardI.InterfaceTranslator.application_type_val.params));
	
	outf := clickdata.ClickData_Relatives_Function(df, 0, ab,appType);

	output(choosen(outf,all),named('Results'));

endmacro;
// ClickData_Relatives_Service()