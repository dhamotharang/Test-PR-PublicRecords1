/*--SOAP--
	<message name = 'Boca Shell Collections Inquiry Service'>
		<part name = 'batch_in'			type = 'tns:XmlDataSet' cols="70" rows="10"/>
		<part name = 'BSversion'		type = 'xsd:integer'/>
	</message>
*/
/*--INFO-- Calculate the collections counts for a given DID in Retro testing */ 
/*--HELP-- 
<pre>
&lt;Batch_In&gt;
  &lt;Row&gt;
    	&lt;Seq&gt;&lt;/Seq&gt;
			&lt;did&gt;&lt;/did&gt;
			&lt;historydate&gt;201003&lt;/historydate&gt;
  &lt;/Row&gt;
&lt;/Batch_In&gt;
</pre>
*/


IMPORT risk_indicators,gateway;

EXPORT Boca_Shell_Collections_Inquiry_Service() := MACRO
	
	indata := dataset([],risk_indicators.Layout_Input) : stored('batch_in',few);
	integer bsversion := 50 : stored('bsversion');
	
		// indata := project(ut.ds_oneRecord, transform(risk_indicators.Layout_Input, 
		// self.seq := 1;
		// self.did := 10 ;
		// self.historydate := 200904;
		// self := []));	
	// output(indata, NAMED('indata'));
	
	inquiries_input := group(project(indata, 
		transform(risk_indicators.layout_bocashell_neutral, 
			self.shell_input := left;
			self.age := 0;
			self := left;
			self := [];)), seq);
	// output(inquiries_input, named('inquiries_input'));
	
	isFCRA := false;
	BSOptions := Risk_Indicators.iid_constants.BSOptions.Collections_Neutral_Service;
	gateways := Gateway.Constants.void_gateway;
	
	neutral_inquiries := risk_indicators.Boca_Shell_Inquiries(inquiries_input, BSOptions, bsversion, gateways, Risk_Indicators.iid_constants.default_DataPermission );
	output(neutral_inquiries, named('neutral_inquiries'));
	
ENDMACRO;