/*--SOAP--
<message name = 'Runway Service'>
	<part name = 'shell' type = 'tns:XmlDataSet' cols="70" rows="10"/>
	<part name = 'excludeReasons' type = 'xsd:boolean'/>
	<part name = 'model_environment' type = 'xsd:integer'/>
</message>
*/
/*--INFO-- model_environment 1=BOTH , 2=FCRA, 3=NON FCRA */
IMPORT risk_indicators, easi, Business_Risk, riskwise, models;

EXPORT Runway_Service := MACRO
	
	clam := group(dataset([],risk_indicators.Layout_Boca_Shell), seq) : stored('shell',few);
	boolean excludeReasons := false : stored('excludeReasons');
	integer model_environment := 1 : stored('model_environment');
	
	runway_results := models.Runway_function(clam, excludeReasons, model_environment);
	output(runway_results);
	
ENDMACRO;